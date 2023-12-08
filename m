Return-Path: <netdev+bounces-55116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BA809763
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C35282260
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37255366;
	Fri,  8 Dec 2023 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTs8sWPu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FE1716
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701996153; x=1733532153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=orVjUD5ddP8xPXk2wsMYSkl3zxdQMjEZln+bLNxXy9o=;
  b=fTs8sWPuGn+imMvCfqPsx9l7aNPKZrsWB+jwfNH7fXkwavnxiGSyx5Jv
   X/PwJ0Bol5WGCLveYqYT0VwoyInVSluGp8JGQFjHHyBbPL1fF6RyYGSyZ
   mF03SJ1EgCifXhpUnv8LHRFJyX/uqkeDCMJOnXxA7IMBiPcZfe0g753JK
   BRkGK0+a2YegYkZ1AApW7ffbbro5U3dJgdZqUNbe/phZgzuke0wMFilfe
   HAMF9ftX30YFyAEnn7pwsnpwd81e3ExyNGc9Yod1XU8kzQXNk2ZJA2RHB
   1LuOkURBXsTlyBTykfELqwfQjrk1hinu6x5kmUL55nIjpRmTCrWAthio8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7691200"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7691200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862683735"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="862683735"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:42:32 -0800
From: Pawel Kaminski <pawel.kaminski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: Add support for devlink loopback param.
Date: Thu,  7 Dec 2023 16:42:27 -0800
Message-ID: <20231208004227.195801-1-pawel.kaminski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for driver-specific devlink loopback param. Supported values
are "enabled", "disabled" and "prioritized". Default configuration is
set to "enabled".

Add documentation in networking/devlink/ice.rst.

In previous generations of Intel NICs the trasmit scheduler was only
limited by PCIe bandwidth when scheduling/assigning hairpin-badwidth
between VFs. Changes to E810 HW design introduced scheduler limitation,
so that available hairpin-bandwidth is bound to external port speed.
In order to address this limitation and enable NFV services such as
"service chaining" a knob to adjust the scheduler config was created.
Driver can send a configuration message to the FW over admin queue and
internal FW logic will reconfigure HW to prioritize and add more BW to
VF to VF traffic. As end result for example 10G port will no longer limit
hairpin-badwith to 10G and much higher speeds can be achieved.

Devlink loopback param set to "prioritized" enables higher
hairpin-badwitdh on related PFs. Configuration is applicable only to
8x10G and 4x25G cards.

Changing loopback configuration will trigger CORER reset in order to take
effect.

Example command to change current value:
devlink dev param set pci/0000:b2:00.3 name loopback value prioritized \
        cmode runtime

Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
---
Changes in v2:
 - improved commit message,
 - added documentation change
 - changed parameter devlink mode to "runtime"
 - Link to v1: https://lore.kernel.org/all/20231201235949.62728-1-pawel.kaminski@intel.com/
---
 Documentation/networking/devlink/ice.rst      |  15 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 128 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 5 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 7f30ebd5debb..efc6be109dc3 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -11,6 +11,7 @@ Parameters
 ==========
 
 .. list-table:: Generic parameters implemented
+   :widths: 5 5 90
 
    * - Name
      - Mode
@@ -22,6 +23,20 @@ Parameters
      - runtime
      - mutually exclusive with ``enable_roce``
 
+.. list-table:: Driver specific parameters implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Mode
+     - Description
+   * - ``loopback``
+     - runtime
+     - Controls loopback behavior by tuning scheduler bandwidth.
+       Supported values are ``enabled``, ``disabled``, ``prioritized``.
+       The latter allows for bandwidth higher than external port speed
+       when looping back traffic between VFs. Works with 8x10G and 4x25G
+       cards.
+
 Info versions
 =============
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 6a5e974a1776..13d0e3cbc24c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -230,6 +230,13 @@ struct ice_aqc_get_sw_cfg_resp_elem {
 #define ICE_AQC_GET_SW_CONF_RESP_IS_VF		BIT(15)
 };
 
+/* Loopback port parameter mode values. */
+enum ice_loopback_mode {
+	ICE_LOOPBACK_MODE_ENABLED = 0,
+	ICE_LOOPBACK_MODE_DISABLED = 1,
+	ICE_LOOPBACK_MODE_PRIORITIZED = 2,
+};
+
 /* Set Port parameters, (direct, 0x0203) */
 struct ice_aqc_set_port_params {
 	__le16 cmd_flags;
@@ -238,7 +245,9 @@ struct ice_aqc_set_port_params {
 	__le16 swid;
 #define ICE_AQC_PORT_SWID_VALID			BIT(15)
 #define ICE_AQC_PORT_SWID_M			0xFF
-	u8 reserved[10];
+	u8 loopback_mode;
+#define ICE_AQC_SET_P_PARAMS_LOOPBACK_MODE_VALID BIT(2)
+	u8 reserved[9];
 };
 
 /* These resource type defines are used for all switch resource
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2f67ea1feb60..2efa781efcdb 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1019,7 +1019,7 @@ int ice_init_hw(struct ice_hw *hw)
 		status = -ENOMEM;
 		goto err_unroll_cqinit;
 	}
-
+	hw->port_info->loopback_mode = ICE_LOOPBACK_MODE_ENABLED;
 	/* set the back pointer to HW */
 	hw->port_info->hw = hw;
 
@@ -2962,6 +2962,10 @@ ice_aq_set_port_params(struct ice_port_info *pi, bool double_vlan,
 	cmd = &desc.params.set_port_params;
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_port_params);
+
+	cmd->loopback_mode = pi->loopback_mode |
+				ICE_AQC_SET_P_PARAMS_LOOPBACK_MODE_VALID;
+
 	if (double_vlan)
 		cmd_flags |= ICE_AQC_SET_P_PARAMS_DOUBLE_VLAN_ENA;
 	cmd->cmd_flags = cpu_to_le16(cmd_flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 65be56f2af9e..97182bacafa3 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1429,6 +1429,127 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+#define DEVLINK_LPBK_DISABLED_STR "disabled"
+#define DEVLINK_LPBK_ENABLED_STR "enabled"
+#define DEVLINK_LPBK_PRIORITIZED_STR "prioritized"
+
+/**
+ * ice_devlink_loopback_mode_to_str - Get string for loopback mode.
+ * @mode: Loopback mode used in port_info struct.
+ *
+ * Return: Mode respective string or "Invalid".
+ */
+static const char *ice_devlink_loopback_mode_to_str(enum ice_loopback_mode mode)
+{
+	switch (mode) {
+	case ICE_LOOPBACK_MODE_ENABLED:
+		return DEVLINK_LPBK_ENABLED_STR;
+	case ICE_LOOPBACK_MODE_PRIORITIZED:
+		return DEVLINK_LPBK_PRIORITIZED_STR;
+	case ICE_LOOPBACK_MODE_DISABLED:
+		return DEVLINK_LPBK_DISABLED_STR;
+	}
+
+	return "Invalid";
+}
+
+/**
+ * ice_devlink_loopback_str_to_mode - Get loopback mode from string name.
+ * @mode_str: Loopback mode string.
+ *
+ * Return: Mode value or negative number if invalid.
+ */
+static int ice_devlink_loopback_str_to_mode(const char *mode_str)
+{
+	if (!strcmp(mode_str, DEVLINK_LPBK_ENABLED_STR))
+		return ICE_LOOPBACK_MODE_ENABLED;
+	else if (!strcmp(mode_str, DEVLINK_LPBK_PRIORITIZED_STR))
+		return ICE_LOOPBACK_MODE_PRIORITIZED;
+	else if (!strcmp(mode_str, DEVLINK_LPBK_DISABLED_STR))
+		return ICE_LOOPBACK_MODE_DISABLED;
+
+	return -EINVAL;
+}
+
+/**
+ * ice_devlink_loopback_get - Get loopback parameter.
+ * @devlink: Pointer to the devlink instance.
+ * @id: The parameter ID to set.
+ * @ctx: Context to store the parameter value.
+ *
+ * Return: Zero.
+ */
+static int ice_devlink_loopback_get(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct ice_port_info *pi;
+	const char *mode_str;
+
+	pi = pf->hw.port_info;
+	mode_str = ice_devlink_loopback_mode_to_str(pi->loopback_mode);
+	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s", mode_str);
+
+	return 0;
+}
+
+/**
+ * ice_devlink_loopback_set - Set loopback parameter.
+ * @devlink: Pointer to the devlink instance.
+ * @id: The parameter ID to set.
+ * @ctx: Context to get the parameter value.
+ *
+ * Return: Zero.
+ */
+static int ice_devlink_loopback_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx)
+{
+	int new_loopback_mode = ice_devlink_loopback_str_to_mode(ctx->val.vstr);
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_port_info *pi;
+
+	pi = pf->hw.port_info;
+	if (pi->loopback_mode != new_loopback_mode) {
+		pi->loopback_mode = new_loopback_mode;
+		dev_info(dev, "Setting loopback to %s\n", ctx->val.vstr);
+		ice_schedule_reset(pf, ICE_RESET_CORER);
+	}
+
+	return 0;
+}
+
+/**
+ * ice_devlink_loopback_validate - Validate passed loopback parameter value.
+ * @devlink: Unused pointer to devlink instance.
+ * @id: The parameter ID to validate.
+ * @val: Value to validate.
+ * @extack: Netlink extended ACK structure.
+ *
+ * Supported values are:
+ * "enabled" - loopback is enabled, "disabled" - loopback is disabled
+ * "prioritized" - loopback traffic is prioritized in scheduling.
+ *
+ * Return: Zero when passed parameter value is supported. Negative value on
+ * error.
+ */
+static int ice_devlink_loopback_validate(struct devlink *devlink, u32 id,
+					 union devlink_param_value val,
+					 struct netlink_ext_ack *extack)
+{
+	if (ice_devlink_loopback_str_to_mode(val.vstr) < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Error: Requested value is not supported.");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+enum ice_param_id {
+	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	ICE_DEVLINK_PARAM_ID_LOOPBACK,
+};
+
 static const struct devlink_param ice_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      ice_devlink_enable_roce_get,
@@ -1438,7 +1559,12 @@ static const struct devlink_param ice_devlink_params[] = {
 			      ice_devlink_enable_iw_get,
 			      ice_devlink_enable_iw_set,
 			      ice_devlink_enable_iw_validate),
-
+	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_LOOPBACK,
+			     "loopback", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     ice_devlink_loopback_get,
+			     ice_devlink_loopback_set,
+			     ice_devlink_loopback_validate),
 };
 
 static void ice_devlink_free(void *devlink_ptr)
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1fff865d0661..c8d75a1820a1 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -713,6 +713,7 @@ struct ice_port_info {
 	u16 sw_id;			/* Initial switch ID belongs to port */
 	u16 pf_vf_num;
 	u8 port_state;
+	u8 loopback_mode;
 #define ICE_SCHED_PORT_STATE_INIT	0x0
 #define ICE_SCHED_PORT_STATE_READY	0x1
 	u8 lport;
-- 
2.41.0


