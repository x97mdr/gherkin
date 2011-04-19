# -*- encoding: utf-8 -*-
gherkin_dir = Dir.pwd =~ /gherkin\/tmp/ ? File.expand_path("../../../..", Dir.pwd) : File.expand_path("..", __FILE__)
$LOAD_PATH.unshift File.join(gherkin_dir, 'lib')
require "gherkin/version"

Gem::Specification.new do |s|
  s.name        = "gherkin"
  s.version     = Gherkin::VERSION
  s.authors     = ["Mike Sassak", "Gregory Hnatiuk", "Aslak Hellesøy"]
  s.description = "A fast Gherkin lexer/parser for based on the Ragel State Machine Compiler."
  s.summary     = "gherkin-#{Gherkin::VERSION}"
  s.email       = "cukes@googlegroups.com"
  s.homepage    = "http://github.com/aslakhellesoy/gherkin"

  s.rubygems_version   = "1.3.7"
  s.default_executable = "gherkin"

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = ["LICENSE", "README.rdoc", "History.txt"]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"

  s.files -= Dir['ikvm/**/*']
  s.files -= Dir['java/**/*']
  s.files -= Dir['js/**/*']
  s.files -= Dir['ext/**/*']
  s.files -= Dir['lib/gherkin.jar']
  s.files -= Dir['lib/**/*.dll']
  s.files -= Dir['lib/**/*.bundle']
  s.files -= Dir['lib/**/*.so']
  
  if ENV['GEM_PLATFORM']
    puts "GEM_PLATFORM:#{ENV['GEM_PLATFORM']}"
  end
  s.platform = ENV['GEM_PLATFORM'] if ENV['GEM_PLATFORM'] 
  case s.platform.to_s
  when /java/
    s.files += ['lib/gherkin.jar']
  when /mswin|mingw32/
    s.files += Dir['lib/*/*.so']
  when /dotnet/
    s.files += Dir['lib/*.dll']
  else # MRI or Rubinius
    s.files += Dir['lib/gherkin/rb_lexer/*.rb']
    s.files += Dir['ext/**/*.c']
    s.extensions = Dir['ext/**/extconf.rb']
    s.add_development_dependency('rake-compiler', '~> 0.7.5')
  end

  s.add_dependency('json', '>= 1.4.6')

  s.add_development_dependency('cucumber', '>= 0.10.0')
  s.add_development_dependency('rake', '>= 0.8.7')
  s.add_development_dependency('bundler', '>= 1.0.10')
  s.add_development_dependency('rspec', '>= 2.5.0')
  s.add_development_dependency('awesome_print', '>= 0.3')
  s.add_development_dependency('therubyracer', '>= 0.8.2.pre2') if ENV['GHERKIN_JS'] && !defined?(JRUBY_VERSION)

  # Only needed by Cucumber. Remove when Cucumber no longer needs those.
  s.add_development_dependency('term-ansicolor', '>= 1.0.5')
  s.add_development_dependency('builder', '>= 3.0.0')
end
