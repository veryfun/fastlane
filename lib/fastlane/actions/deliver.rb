module Fastlane
  module Actions
    module SharedValues
      DELIVER_IPA_PATH = :DELIVER_IPA_PATH
    end

    class DeliverAction
      def self.run(params)
        require 'deliver'
        
        ENV["DELIVER_SCREENSHOTS_PATH"] = Actions.lane_context[SharedValues::SNAPSHOT_SCREENSHOTS_PATH]
        
        force = params.include?(:force)
        beta = params.include?(:beta)
        skip_deploy = params.include?(:skip_deploy)

        Dir.chdir(FastlaneFolder.path || Dir.pwd) do
          # This should be executed in the fastlane folder
          Deliver::Deliverer.new(nil, force: force, 
                                is_beta_ipa: beta, 
                                skip_deploy: skip_deploy)

          ENV[Actions::SharedValues::DELIVER_IPA_PATH.to_s] = ENV["DELIVER_IPA_PATH"] # deliver will store it in the environment
        end
      end
    end
  end
end