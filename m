Return-Path: <netdev+bounces-110934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB092F03A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9651C20AA2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DACB19EED0;
	Thu, 11 Jul 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8uRs0ly"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F519EEAC;
	Thu, 11 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729182; cv=none; b=NKvRtk70ew3mjlscP0VxSy8AJuTqsAK60RfMNbnh4KY9op2Y6FHcSnZfLUqC/vtXHvjgCpfBY3UrHN6s3/CUAUlR48EgHwtTCgzUaOWZ5hydYhqw8dCpKDlyBLx6TvlH3T/fJPHpFpAX6c4zGlyCU+0Xbrh0qZtfkV+/k2Apt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729182; c=relaxed/simple;
	bh=4rDgkJdhMICclrdoja6vfHDeHvjmlAaVvR2zgP1MSAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJC8prm4SXAeIbfWB0Tu2TxgAvp2sxx8p+nhOPpVrkdUl4zl3O8kS7ZgZqgQuurNd784uuPMA0I+7b88z8PFf6htaIyvMlzbgn3lbWIh3z5o+pT/7j4VWbCu9iGIuyafAfcZ1bM2Y/fMQPjoNQNxI3MhES3XKzSN5/GeRv+MtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8uRs0ly; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729180; x=1752265180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rDgkJdhMICclrdoja6vfHDeHvjmlAaVvR2zgP1MSAA=;
  b=b8uRs0lyraL6a2wEND+ostYl1jMvlP3HNF/pqXOFlNOB7yce+aab1Yul
   o4jV9lUGxM5vhsl8b/4DPAAYOEbasVSRdHHb359EKlxUMaXW0ZTv2yrUu
   AWPrxTTpxJbVbFZnbPhHuqs1japFQJvyS6jTmk5XuSQcYPmDmOgDC8fcn
   SKsZQQFqJvxCgR08SuWRfwqIr/rlmM/DIwJftVrYb0RSk6/oTaCNnISwL
   vbR1/zMCn3MygsQfvEDdPTV0Uwn22Z1cGq3G5AsvfelQix4pMH3mw11FK
   a/3WLP1NNVAfY1GnJ7Z0JMeaqk7Gza1D9z42LgsbSqK+FjXFASKC1Uevk
   Q==;
X-CSE-ConnectionGUID: AgimZlLiQ4SnENmgiGnKfA==
X-CSE-MsgGUID: 6YeDLzVUS6O+Wd0RDw3Q2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508395"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508395"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:38 -0700
X-CSE-ConnectionGUID: nkn1tFiJTTmkb4kDAJpXKQ==
X-CSE-MsgGUID: XoBn2ATZRHq1IIRJdy4Ayg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887411"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Pawel Kaminski <pawel.kaminski@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/5] ice: Add support for devlink local_forwarding param
Date: Thu, 11 Jul 2024 13:19:28 -0700
Message-ID: <20240711201932.2019925-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pawel Kaminski <pawel.kaminski@intel.com>

Add support for driver-specific devlink local_forwarding param.
Supported values are "enabled", "disabled" and "prioritized".
Default configuration is set to "enabled".

Add documentation in networking/devlink/ice.rst.

In previous generations of Intel NICs the transmit scheduler was only
limited by PCIe bandwidth when scheduling/assigning hairpin-bandwidth
between VFs. Changes to E810 HW design introduced scheduler limitation,
so that available hairpin-bandwidth is bound to external port speed.
In order to address this limitation and enable NFV services such as
"service chaining" a knob to adjust the scheduler config was created.
Driver can send a configuration message to the FW over admin queue and
internal FW logic will reconfigure HW to prioritize and add more BW to
VF to VF traffic. An end result, for example, 10G port will no longer
limit hairpin-bandwidth to 10G and much higher speeds can be achieved.

Devlink local_forwarding param set to "prioritized" enables higher
hairpin-bandwitdh on related PFs. Configuration is applicable only to
8x10G and 4x25G cards.

Changing local_forwarding configuration will trigger CORER reset in
order to take effect.

Example command to change current value:
devlink dev param set pci/0000:b2:00.3 name local_forwarding \
        value prioritized \
        cmode runtime

Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/ice.rst      |  25 ++++
 .../net/ethernet/intel/ice/devlink/devlink.c  | 126 ++++++++++++++++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   4 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 5 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 830c04354222..e3972d03cea0 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -11,6 +11,7 @@ Parameters
 ==========
 
 .. list-table:: Generic parameters implemented
+   :widths: 5 5 90
 
    * - Name
      - Mode
@@ -68,6 +69,30 @@ Parameters
 
        To verify that value has been set:
        $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``local_forwarding``
+      - runtime
+      - Controls loopback behavior by tuning scheduler bandwidth.
+        It impacts all kinds of functions: physical, virtual and
+        subfunctions.
+        Supported values are:
+
+        ``enabled`` - loopback traffic is allowed on port
+
+        ``disabled`` - loopback traffic is not allowed on this port
+
+        ``prioritized`` - loopback traffic is prioritized on this port
+
+        Default value of ``local_forwarding`` parameter is ``enabled``.
+        ``prioritized`` provides ability to adjust loopback traffic rate to increase
+        one port capacity at cost of the another. User needs to disable
+        local forwarding on one of the ports in order have increased capacity
+        on the ``prioritized`` port.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index f774781ab514..810a901d7afd 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1381,9 +1381,129 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+#define DEVLINK_LOCAL_FWD_DISABLED_STR "disabled"
+#define DEVLINK_LOCAL_FWD_ENABLED_STR "enabled"
+#define DEVLINK_LOCAL_FWD_PRIORITIZED_STR "prioritized"
+
+/**
+ * ice_devlink_local_fwd_mode_to_str - Get string for local_fwd mode.
+ * @mode: local forwarding for mode used in port_info struct.
+ *
+ * Return: Mode respective string or "Invalid".
+ */
+static const char *
+ice_devlink_local_fwd_mode_to_str(enum ice_local_fwd_mode mode)
+{
+	switch (mode) {
+	case ICE_LOCAL_FWD_MODE_ENABLED:
+		return DEVLINK_LOCAL_FWD_ENABLED_STR;
+	case ICE_LOCAL_FWD_MODE_PRIORITIZED:
+		return DEVLINK_LOCAL_FWD_PRIORITIZED_STR;
+	case ICE_LOCAL_FWD_MODE_DISABLED:
+		return DEVLINK_LOCAL_FWD_DISABLED_STR;
+	}
+
+	return "Invalid";
+}
+
+/**
+ * ice_devlink_local_fwd_str_to_mode - Get local_fwd mode from string name.
+ * @mode_str: local forwarding mode string.
+ *
+ * Return: Mode value or negative number if invalid.
+ */
+static int ice_devlink_local_fwd_str_to_mode(const char *mode_str)
+{
+	if (!strcmp(mode_str, DEVLINK_LOCAL_FWD_ENABLED_STR))
+		return ICE_LOCAL_FWD_MODE_ENABLED;
+	else if (!strcmp(mode_str, DEVLINK_LOCAL_FWD_PRIORITIZED_STR))
+		return ICE_LOCAL_FWD_MODE_PRIORITIZED;
+	else if (!strcmp(mode_str, DEVLINK_LOCAL_FWD_DISABLED_STR))
+		return ICE_LOCAL_FWD_MODE_DISABLED;
+
+	return -EINVAL;
+}
+
+/**
+ * ice_devlink_local_fwd_get - Get local_fwd parameter.
+ * @devlink: Pointer to the devlink instance.
+ * @id: The parameter ID to set.
+ * @ctx: Context to store the parameter value.
+ *
+ * Return: Zero.
+ */
+static int ice_devlink_local_fwd_get(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct ice_port_info *pi;
+	const char *mode_str;
+
+	pi = pf->hw.port_info;
+	mode_str = ice_devlink_local_fwd_mode_to_str(pi->local_fwd_mode);
+	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s", mode_str);
+
+	return 0;
+}
+
+/**
+ * ice_devlink_local_fwd_set - Set local_fwd parameter.
+ * @devlink: Pointer to the devlink instance.
+ * @id: The parameter ID to set.
+ * @ctx: Context to get the parameter value.
+ * @extack: Netlink extended ACK structure.
+ *
+ * Return: Zero.
+ */
+static int ice_devlink_local_fwd_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	int new_local_fwd_mode = ice_devlink_local_fwd_str_to_mode(ctx->val.vstr);
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_port_info *pi;
+
+	pi = pf->hw.port_info;
+	if (pi->local_fwd_mode != new_local_fwd_mode) {
+		pi->local_fwd_mode = new_local_fwd_mode;
+		dev_info(dev, "Setting local_fwd to %s\n", ctx->val.vstr);
+		ice_schedule_reset(pf, ICE_RESET_CORER);
+	}
+
+	return 0;
+}
+
+/**
+ * ice_devlink_local_fwd_validate - Validate passed local_fwd parameter value.
+ * @devlink: Unused pointer to devlink instance.
+ * @id: The parameter ID to validate.
+ * @val: Value to validate.
+ * @extack: Netlink extended ACK structure.
+ *
+ * Supported values are:
+ * "enabled" - local_fwd is enabled, "disabled" - local_fwd is disabled
+ * "prioritized" - local_fwd traffic is prioritized in scheduling.
+ *
+ * Return: Zero when passed parameter value is supported. Negative value on
+ * error.
+ */
+static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
+					  union devlink_param_value val,
+					  struct netlink_ext_ack *extack)
+{
+	if (ice_devlink_local_fwd_str_to_mode(val.vstr) < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Error: Requested value is not supported.");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
+	ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
 };
 
 static const struct devlink_param ice_dvl_rdma_params[] = {
@@ -1405,6 +1525,12 @@ static const struct devlink_param ice_dvl_sched_params[] = {
 			     ice_devlink_tx_sched_layers_get,
 			     ice_devlink_tx_sched_layers_set,
 			     ice_devlink_tx_sched_layers_validate),
+	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
+			     "local_forwarding", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     ice_devlink_local_fwd_get,
+			     ice_devlink_local_fwd_set,
+			     ice_devlink_local_fwd_validate),
 };
 
 static void ice_devlink_free(void *devlink_ptr)
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index b70d4ca43443..66f02988d549 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -232,6 +232,13 @@ struct ice_aqc_get_sw_cfg_resp_elem {
 #define ICE_AQC_GET_SW_CONF_RESP_IS_VF		BIT(15)
 };
 
+/* Loopback port parameter mode values. */
+enum ice_local_fwd_mode {
+	ICE_LOCAL_FWD_MODE_ENABLED = 0,
+	ICE_LOCAL_FWD_MODE_DISABLED = 1,
+	ICE_LOCAL_FWD_MODE_PRIORITIZED = 2,
+};
+
 /* Set Port parameters, (direct, 0x0203) */
 struct ice_aqc_set_port_params {
 	__le16 cmd_flags;
@@ -240,7 +247,9 @@ struct ice_aqc_set_port_params {
 	__le16 swid;
 #define ICE_AQC_PORT_SWID_VALID			BIT(15)
 #define ICE_AQC_PORT_SWID_M			0xFF
-	u8 reserved[10];
+	u8 local_fwd_mode;
+#define ICE_AQC_SET_P_PARAMS_LOCAL_FWD_MODE_VALID BIT(2)
+	u8 reserved[9];
 };
 
 /* These resource type defines are used for all switch resource
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e311a41a74fa..9cd649053ef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1086,6 +1086,7 @@ int ice_init_hw(struct ice_hw *hw)
 		goto err_unroll_cqinit;
 	}
 
+	hw->port_info->local_fwd_mode = ICE_LOCAL_FWD_MODE_ENABLED;
 	/* set the back pointer to HW */
 	hw->port_info->hw = hw;
 
@@ -3071,6 +3072,9 @@ ice_aq_set_port_params(struct ice_port_info *pi, bool double_vlan,
 		cmd_flags |= ICE_AQC_SET_P_PARAMS_DOUBLE_VLAN_ENA;
 	cmd->cmd_flags = cpu_to_le16(cmd_flags);
 
+	cmd->local_fwd_mode = pi->local_fwd_mode |
+				ICE_AQC_SET_P_PARAMS_LOCAL_FWD_MODE_VALID;
+
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index e26ae79578ba..f3e376cbdd92 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -738,6 +738,7 @@ struct ice_port_info {
 	u16 sw_id;			/* Initial switch ID belongs to port */
 	u16 pf_vf_num;
 	u8 port_state;
+	u8 local_fwd_mode;
 #define ICE_SCHED_PORT_STATE_INIT	0x0
 #define ICE_SCHED_PORT_STATE_READY	0x1
 	u8 lport;
-- 
2.41.0


