require 'asciidoctor/doctest/base_suite_parser'
require 'asciidoctor/doctest/core_ext'

module Asciidoctor
  module DocTest
    ##
    # Parser of input AsciiDoc examples suite.
    #
    # @example Format of the example's header
    #   // .example-name
    #   // Any text that is not the example's name is considered
    #   // as a description.
    #   The example's content in *AsciiDoc*.
    #
    #   NOTE: The trailing new line (below this) will be removed.
    #
    class AsciidocSuiteParser < BaseSuiteParser

      FILE_SUFFIX = '.adoc'

      def parse_suite(input)
        suite = {}
        current = {}

        input.each_line do |line|
          line.chomp!
          if line =~ %r{^//\s*\.([^ \n]+)}
            suite[$1.to_sym] = current = { content: '' }
          elsif line =~ %r{^//\s*(.*)\s*$}
            (current[:desc] ||= '').concat($1, "\n")
          else
            current[:content].concat(line, "\n")
          end
        end

        suite
      end
    end
  end
end
