pwd = File.dirname(__FILE__)
$: << pwd

begin
  as_lib = File.join(pwd, "../../activesupport/lib")
  ap_lib = File.join(pwd, "../../actionpack/lib")

  $: << as_lib if File.directory?(as_lib)
  $: << ap_lib if File.directory?(ap_lib)
  
  require "action_controller"
  require "action_view"
rescue LoadError
  require 'rubygems'
  gem "actionpack", '>= 2.3'

  require "action_controller"
  require "action_view"
end

begin
  require 'rubygems'
  gem 'RedCloth', '>= 4.1.1'
rescue Gem::LoadError
  $stderr.puts %(Generating Guides requires RedCloth 4.1.1+)
  exit 1
end

require 'redcloth'

module RailsGuides
  autoload :Generator, "rails_guides/generator_pt_br"
  autoload :Indexer, "rails_guides/indexer"
  autoload :Helpers, "rails_guides/helpers"
  autoload :HelpersPtBr, "rails_guides/helpers_pt_br"  
  autoload :TextileExtensions, "rails_guides/textile_extensions"
  autoload :Levenshtein, "rails_guides/levenshtein"
end

RedCloth.send(:include, RailsGuides::TextileExtensions)

if $0 == __FILE__
  RailsGuides::Generator.new.generate
end