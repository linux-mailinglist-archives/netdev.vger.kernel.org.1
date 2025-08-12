Return-Path: <netdev+bounces-212762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F59B21C46
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AF82A811B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D002DFA3B;
	Tue, 12 Aug 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJXywSjs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBB2DEA8D
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974035; cv=none; b=j3ccf6I+/XRRo/ORw2fEn4qOscNeEcPOMpyXAHO23YGqY0ncc40xiu4Zr8poP1ij2XPD+USbIGHoXZHqS0aIlEjRef0P0xLqMyo3rGe6d+0UXt01/riWnn4Im5CN6arHtLjJhSh+KOoXERivqIGDvZ3gGzU4LBjoGX4PXt2NWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974035; c=relaxed/simple;
	bh=MWCklRtC/IS8HJvMPSmLN5GKTN09xxn5L/MZnBNNwOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+T7o4TRfNPGi561CfZprbKAaz+x1Z3FncFBkBIVe1ZKTHip9VJsRH/j7zmB+80cl4Zmy6lG//S4I7eCnpf4R+ogHZlJzacmy0xJiUwmi1y8ppCJDP97ZqsOJ+aXwirmslLKrRQULNn+HdPoEz64RSabO7Fww6idAz1bRQhRSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJXywSjs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974034; x=1786510034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWCklRtC/IS8HJvMPSmLN5GKTN09xxn5L/MZnBNNwOU=;
  b=FJXywSjs5OIugtGeAyI1USAmy7E+RTRcAszlr7H1JCQ1c60n/Iow+rPt
   nW42YgVVrFft601PU4pSq7ImhrYW11/yF53y7VLgOFMvb0aOwShj5ktHw
   Qv8X4hCfgfpEZkDpuAuDxUQCK30vj04UYm7Le4fiiA6FDW3MDYaRajeXz
   NAcj0CZyMe1J8OW0u5hH8tpo2FO6A9LkVfktVFCGxPReJFCXOkDbL9PX/
   dMHEg95ijnZ6rDb5SkAa1P4J63TJdBs5lYmri4VLiwoTYy2DXIN/+KzMt
   +LLI3Yv7A+J0oe6rwXN5EjeJUl4Q6tL1luhAlvTW6JOzfNY2RKxa5GckQ
   A==;
X-CSE-ConnectionGUID: ZBUfv8j8STuQlb62w/5ayw==
X-CSE-MsgGUID: XkECLQXLRDa6FaVZzol9IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612765"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612765"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:13 -0700
X-CSE-ConnectionGUID: IVSpuh2ySi6LynPxDkW27A==
X-CSE-MsgGUID: nlsEw8X4QYuqd++CI7VdpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327912"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 10/15] libie, ice: move fwlog admin queue to libie
Date: Tue, 12 Aug 2025 06:23:31 +0200
Message-ID: <20250812042337.1356907-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy the code and:
- change ICE_AQC to LIBIE_AQC
- change ice_aqc to libie_aqc
- move definitions outside the structures

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 78 ----------------
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 21 ++---
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 46 +++++-----
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  2 +-
 include/linux/net/intel/libie/adminq.h        | 89 +++++++++++++++++++
 5 files changed, 124 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index caae1780fd37..93aedb35fd17 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2399,42 +2399,6 @@ struct ice_aqc_event_lan_overflow {
 	u8 reserved[8];
 };
 
-enum ice_aqc_fw_logging_mod {
-	ICE_AQC_FW_LOG_ID_GENERAL = 0,
-	ICE_AQC_FW_LOG_ID_CTRL,
-	ICE_AQC_FW_LOG_ID_LINK,
-	ICE_AQC_FW_LOG_ID_LINK_TOPO,
-	ICE_AQC_FW_LOG_ID_DNL,
-	ICE_AQC_FW_LOG_ID_I2C,
-	ICE_AQC_FW_LOG_ID_SDP,
-	ICE_AQC_FW_LOG_ID_MDIO,
-	ICE_AQC_FW_LOG_ID_ADMINQ,
-	ICE_AQC_FW_LOG_ID_HDMA,
-	ICE_AQC_FW_LOG_ID_LLDP,
-	ICE_AQC_FW_LOG_ID_DCBX,
-	ICE_AQC_FW_LOG_ID_DCB,
-	ICE_AQC_FW_LOG_ID_XLR,
-	ICE_AQC_FW_LOG_ID_NVM,
-	ICE_AQC_FW_LOG_ID_AUTH,
-	ICE_AQC_FW_LOG_ID_VPD,
-	ICE_AQC_FW_LOG_ID_IOSF,
-	ICE_AQC_FW_LOG_ID_PARSER,
-	ICE_AQC_FW_LOG_ID_SW,
-	ICE_AQC_FW_LOG_ID_SCHEDULER,
-	ICE_AQC_FW_LOG_ID_TXQ,
-	ICE_AQC_FW_LOG_ID_RSVD,
-	ICE_AQC_FW_LOG_ID_POST,
-	ICE_AQC_FW_LOG_ID_WATCHDOG,
-	ICE_AQC_FW_LOG_ID_TASK_DISPATCH,
-	ICE_AQC_FW_LOG_ID_MNG,
-	ICE_AQC_FW_LOG_ID_SYNCE,
-	ICE_AQC_FW_LOG_ID_HEALTH,
-	ICE_AQC_FW_LOG_ID_TSDRV,
-	ICE_AQC_FW_LOG_ID_PFREG,
-	ICE_AQC_FW_LOG_ID_MDLVER,
-	ICE_AQC_FW_LOG_ID_MAX,
-};
-
 enum ice_aqc_health_status_mask {
 	ICE_AQC_HEALTH_STATUS_SET_PF_SPECIFIC_MASK = BIT(0),
 	ICE_AQC_HEALTH_STATUS_SET_ALL_PF_MASK      = BIT(1),
@@ -2516,48 +2480,6 @@ struct ice_aqc_health_status_elem {
 	__le32 internal_data2;
 };
 
-/* Set FW Logging configuration (indirect 0xFF30)
- * Register for FW Logging (indirect 0xFF31)
- * Query FW Logging (indirect 0xFF32)
- * FW Log Event (indirect 0xFF33)
- */
-struct ice_aqc_fw_log {
-	u8 cmd_flags;
-#define ICE_AQC_FW_LOG_CONF_UART_EN	BIT(0)
-#define ICE_AQC_FW_LOG_CONF_AQ_EN	BIT(1)
-#define ICE_AQC_FW_LOG_QUERY_REGISTERED	BIT(2)
-#define ICE_AQC_FW_LOG_CONF_SET_VALID	BIT(3)
-#define ICE_AQC_FW_LOG_AQ_REGISTER	BIT(0)
-#define ICE_AQC_FW_LOG_AQ_QUERY		BIT(2)
-
-	u8 rsp_flag;
-	__le16 fw_rt_msb;
-	union {
-		struct {
-			__le32 fw_rt_lsb;
-		} sync;
-		struct {
-			__le16 log_resolution;
-#define ICE_AQC_FW_LOG_MIN_RESOLUTION		(1)
-#define ICE_AQC_FW_LOG_MAX_RESOLUTION		(128)
-
-			__le16 mdl_cnt;
-		} cfg;
-	} ops;
-	__le32 addr_high;
-	__le32 addr_low;
-};
-
-/* Response Buffer for:
- *    Set Firmware Logging Configuration (0xFF30)
- *    Query FW Logging (0xFF32)
- */
-struct ice_aqc_fw_log_cfg_resp {
-	__le16 module_identifier;
-	u8 log_level;
-	u8 rsvd0;
-};
-
 /* Admin Queue command opcodes */
 enum ice_adminq_opc {
 	/* AQ commands */
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 36a13f54bddc..0e31be26a82c 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -12,10 +12,11 @@ static struct dentry *ice_debugfs_root;
 /* create a define that has an extra module that doesn't really exist. this
  * is so we can add a module 'all' to easily enable/disable all the modules
  */
-#define ICE_NR_FW_LOG_MODULES (ICE_AQC_FW_LOG_ID_MAX + 1)
+#define ICE_NR_FW_LOG_MODULES (LIBIE_AQC_FW_LOG_ID_MAX + 1)
 
 /* the ordering in this array is important. it matches the ordering of the
- * values in the FW so the index is the same value as in ice_aqc_fw_logging_mod
+ * values in the FW so the index is the same value as in
+ * libie_aqc_fw_logging_mod
  */
 static const char * const ice_fwlog_module_string[] = {
 	"general",
@@ -84,7 +85,7 @@ ice_fwlog_print_module_cfg(struct ice_fwlog_cfg *cfg, int module,
 {
 	struct ice_fwlog_module_entry *entry;
 
-	if (module != ICE_AQC_FW_LOG_ID_MAX) {
+	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
 		entry =	&cfg->module_entries[module];
 
 		seq_printf(s, "\tModule: %s, Log Level: %s\n",
@@ -93,7 +94,7 @@ ice_fwlog_print_module_cfg(struct ice_fwlog_cfg *cfg, int module,
 	} else {
 		int i;
 
-		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++) {
+		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++) {
 			entry =	&cfg->module_entries[i];
 
 			seq_printf(s, "\tModule: %s, Log Level: %s\n",
@@ -190,7 +191,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (module != ICE_AQC_FW_LOG_ID_MAX) {
+	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
 		fwlog->cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
@@ -198,7 +199,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		 */
 		int i;
 
-		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
+		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++)
 			fwlog->cfg.module_entries[i].log_level = log_level;
 	}
 
@@ -266,11 +267,11 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 	if (ret)
 		return ret;
 
-	if (nr_messages < ICE_AQC_FW_LOG_MIN_RESOLUTION ||
-	    nr_messages > ICE_AQC_FW_LOG_MAX_RESOLUTION) {
+	if (nr_messages < LIBIE_AQC_FW_LOG_MIN_RESOLUTION ||
+	    nr_messages > LIBIE_AQC_FW_LOG_MAX_RESOLUTION) {
 		dev_err(dev, "Invalid FW log number of messages %d, value must be between %d - %d\n",
-			nr_messages, ICE_AQC_FW_LOG_MIN_RESOLUTION,
-			ICE_AQC_FW_LOG_MAX_RESOLUTION);
+			nr_messages, LIBIE_AQC_FW_LOG_MIN_RESOLUTION,
+			LIBIE_AQC_FW_LOG_MAX_RESOLUTION);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 8a1fede98865..0e4d0da86e0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -142,8 +142,8 @@ static bool ice_fwlog_supported(struct ice_fwlog *fwlog)
  */
 static int ice_aq_fwlog_get(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 {
-	struct ice_aqc_fw_log_cfg_resp *fw_modules;
-	struct ice_aqc_fw_log *cmd;
+	struct libie_aqc_fw_log_cfg_resp *fw_modules;
+	struct libie_aqc_fw_log *cmd;
 	struct libie_aq_desc desc;
 	u16 module_id_cnt;
 	int status;
@@ -156,10 +156,10 @@ static int ice_aq_fwlog_get(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 	if (!buf)
 		return -ENOMEM;
 
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_query);
+	ice_fill_dflt_direct_cmd_desc(&desc, libie_aqc_opc_fw_logs_query);
 	cmd = libie_aq_raw(&desc);
 
-	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
+	cmd->cmd_flags = LIBIE_AQC_FW_LOG_AQ_QUERY;
 
 	status = fwlog->send_cmd(fwlog->priv, &desc, buf, ICE_AQ_MAX_BUF_LEN);
 	if (status) {
@@ -168,26 +168,26 @@ static int ice_aq_fwlog_get(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 	}
 
 	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
-	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
+	if (module_id_cnt < LIBIE_AQC_FW_LOG_ID_MAX) {
 		dev_dbg(&fwlog->pdev->dev, "FW returned less than the expected number of FW log module IDs\n");
-	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
+	} else if (module_id_cnt > LIBIE_AQC_FW_LOG_ID_MAX) {
 		dev_dbg(&fwlog->pdev->dev, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
-			ICE_AQC_FW_LOG_ID_MAX);
-		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
+			LIBIE_AQC_FW_LOG_ID_MAX);
+		module_id_cnt = LIBIE_AQC_FW_LOG_ID_MAX;
 	}
 
 	cfg->log_resolution = le16_to_cpu(cmd->ops.cfg.log_resolution);
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_AQ_EN)
+	if (cmd->cmd_flags & LIBIE_AQC_FW_LOG_CONF_AQ_EN)
 		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
+	if (cmd->cmd_flags & LIBIE_AQC_FW_LOG_CONF_UART_EN)
 		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
+	if (cmd->cmd_flags & LIBIE_AQC_FW_LOG_QUERY_REGISTERED)
 		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
 
-	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
+	fw_modules = (struct libie_aqc_fw_log_cfg_resp *)buf;
 
 	for (i = 0; i < module_id_cnt; i++) {
-		struct ice_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
+		struct libie_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
 
 		cfg->module_entries[i].module_id =
 			le16_to_cpu(fw_module->module_identifier);
@@ -326,8 +326,8 @@ ice_aq_fwlog_set(struct ice_fwlog *fwlog,
 		 struct ice_fwlog_module_entry *entries, u16 num_entries,
 		 u16 options, u16 log_resolution)
 {
-	struct ice_aqc_fw_log_cfg_resp *fw_modules;
-	struct ice_aqc_fw_log *cmd;
+	struct libie_aqc_fw_log_cfg_resp *fw_modules;
+	struct libie_aqc_fw_log *cmd;
 	struct libie_aq_desc desc;
 	int status;
 	int i;
@@ -342,19 +342,19 @@ ice_aq_fwlog_set(struct ice_fwlog *fwlog,
 		fw_modules[i].log_level = entries[i].log_level;
 	}
 
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_config);
+	ice_fill_dflt_direct_cmd_desc(&desc, libie_aqc_opc_fw_logs_config);
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 
 	cmd = libie_aq_raw(&desc);
 
-	cmd->cmd_flags = ICE_AQC_FW_LOG_CONF_SET_VALID;
+	cmd->cmd_flags = LIBIE_AQC_FW_LOG_CONF_SET_VALID;
 	cmd->ops.cfg.log_resolution = cpu_to_le16(log_resolution);
 	cmd->ops.cfg.mdl_cnt = cpu_to_le16(num_entries);
 
 	if (options & ICE_FWLOG_OPTION_ARQ_ENA)
-		cmd->cmd_flags |= ICE_AQC_FW_LOG_CONF_AQ_EN;
+		cmd->cmd_flags |= LIBIE_AQC_FW_LOG_CONF_AQ_EN;
 	if (options & ICE_FWLOG_OPTION_UART_ENA)
-		cmd->cmd_flags |= ICE_AQC_FW_LOG_CONF_UART_EN;
+		cmd->cmd_flags |= LIBIE_AQC_FW_LOG_CONF_UART_EN;
 
 	status = fwlog->send_cmd(fwlog->priv, &desc, fw_modules,
 				 sizeof(*fw_modules) * num_entries);
@@ -383,7 +383,7 @@ int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 		return -EOPNOTSUPP;
 
 	return ice_aq_fwlog_set(fwlog, cfg->module_entries,
-				ICE_AQC_FW_LOG_ID_MAX, cfg->options,
+				LIBIE_AQC_FW_LOG_ID_MAX, cfg->options,
 				cfg->log_resolution);
 }
 
@@ -394,14 +394,14 @@ int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
  */
 static int ice_aq_fwlog_register(struct ice_fwlog *fwlog, bool reg)
 {
-	struct ice_aqc_fw_log *cmd;
+	struct libie_aqc_fw_log *cmd;
 	struct libie_aq_desc desc;
 
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_register);
+	ice_fill_dflt_direct_cmd_desc(&desc, libie_aqc_opc_fw_logs_register);
 	cmd = libie_aq_raw(&desc);
 
 	if (reg)
-		cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_REGISTER;
+		cmd->cmd_flags = LIBIE_AQC_FW_LOG_AQ_REGISTER;
 
 	return fwlog->send_cmd(fwlog->priv, &desc, NULL, 0);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 22585ea9ec93..9efa4a83c957 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -29,7 +29,7 @@ struct ice_fwlog_module_entry {
 
 struct ice_fwlog_cfg {
 	/* list of modules for configuring log level */
-	struct ice_fwlog_module_entry module_entries[ICE_AQC_FW_LOG_ID_MAX];
+	struct ice_fwlog_module_entry module_entries[LIBIE_AQC_FW_LOG_ID_MAX];
 	/* options used to configure firmware logging */
 	u16 options;
 #define ICE_FWLOG_OPTION_ARQ_ENA		BIT(0)
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 1dd5d5924aee..f7d90e9acfe4 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -222,6 +222,94 @@ struct libie_aqc_list_caps_elem {
 };
 LIBIE_CHECK_STRUCT_LEN(32, libie_aqc_list_caps_elem);
 
+/* Admin Queue command opcodes */
+enum libie_adminq_opc {
+	/* FW Logging Commands */
+	libie_aqc_opc_fw_logs_config			= 0xFF30,
+	libie_aqc_opc_fw_logs_register			= 0xFF31,
+	libie_aqc_opc_fw_logs_query			= 0xFF32,
+	libie_aqc_opc_fw_logs_event			= 0xFF33,
+};
+
+enum libie_aqc_fw_logging_mod {
+	LIBIE_AQC_FW_LOG_ID_GENERAL = 0,
+	LIBIE_AQC_FW_LOG_ID_CTRL,
+	LIBIE_AQC_FW_LOG_ID_LINK,
+	LIBIE_AQC_FW_LOG_ID_LINK_TOPO,
+	LIBIE_AQC_FW_LOG_ID_DNL,
+	LIBIE_AQC_FW_LOG_ID_I2C,
+	LIBIE_AQC_FW_LOG_ID_SDP,
+	LIBIE_AQC_FW_LOG_ID_MDIO,
+	LIBIE_AQC_FW_LOG_ID_ADMINQ,
+	LIBIE_AQC_FW_LOG_ID_HDMA,
+	LIBIE_AQC_FW_LOG_ID_LLDP,
+	LIBIE_AQC_FW_LOG_ID_DCBX,
+	LIBIE_AQC_FW_LOG_ID_DCB,
+	LIBIE_AQC_FW_LOG_ID_XLR,
+	LIBIE_AQC_FW_LOG_ID_NVM,
+	LIBIE_AQC_FW_LOG_ID_AUTH,
+	LIBIE_AQC_FW_LOG_ID_VPD,
+	LIBIE_AQC_FW_LOG_ID_IOSF,
+	LIBIE_AQC_FW_LOG_ID_PARSER,
+	LIBIE_AQC_FW_LOG_ID_SW,
+	LIBIE_AQC_FW_LOG_ID_SCHEDULER,
+	LIBIE_AQC_FW_LOG_ID_TXQ,
+	LIBIE_AQC_FW_LOG_ID_RSVD,
+	LIBIE_AQC_FW_LOG_ID_POST,
+	LIBIE_AQC_FW_LOG_ID_WATCHDOG,
+	LIBIE_AQC_FW_LOG_ID_TASK_DISPATCH,
+	LIBIE_AQC_FW_LOG_ID_MNG,
+	LIBIE_AQC_FW_LOG_ID_SYNCE,
+	LIBIE_AQC_FW_LOG_ID_HEALTH,
+	LIBIE_AQC_FW_LOG_ID_TSDRV,
+	LIBIE_AQC_FW_LOG_ID_PFREG,
+	LIBIE_AQC_FW_LOG_ID_MDLVER,
+	LIBIE_AQC_FW_LOG_ID_MAX,
+};
+
+/* Set FW Logging configuration (indirect 0xFF30)
+ * Register for FW Logging (indirect 0xFF31)
+ * Query FW Logging (indirect 0xFF32)
+ * FW Log Event (indirect 0xFF33)
+ */
+#define LIBIE_AQC_FW_LOG_CONF_UART_EN		BIT(0)
+#define LIBIE_AQC_FW_LOG_CONF_AQ_EN		BIT(1)
+#define LIBIE_AQC_FW_LOG_QUERY_REGISTERED	BIT(2)
+#define LIBIE_AQC_FW_LOG_CONF_SET_VALID		BIT(3)
+#define LIBIE_AQC_FW_LOG_AQ_REGISTER		BIT(0)
+#define LIBIE_AQC_FW_LOG_AQ_QUERY		BIT(2)
+
+#define LIBIE_AQC_FW_LOG_MIN_RESOLUTION		(1)
+#define LIBIE_AQC_FW_LOG_MAX_RESOLUTION		(128)
+
+struct libie_aqc_fw_log {
+	u8 cmd_flags;
+
+	u8 rsp_flag;
+	__le16 fw_rt_msb;
+	union {
+		struct {
+			__le32 fw_rt_lsb;
+		} sync;
+		struct {
+			__le16 log_resolution;
+			__le16 mdl_cnt;
+		} cfg;
+	} ops;
+	__le32 addr_high;
+	__le32 addr_low;
+};
+
+/* Response Buffer for:
+ *    Set Firmware Logging Configuration (0xFF30)
+ *    Query FW Logging (0xFF32)
+ */
+struct libie_aqc_fw_log_cfg_resp {
+	__le16 module_identifier;
+	u8 log_level;
+	u8 rsvd0;
+};
+
 /**
  * struct libie_aq_desc - Admin Queue (AQ) descriptor
  * @flags: LIBIE_AQ_FLAG_* flags
@@ -253,6 +341,7 @@ struct libie_aq_desc {
 		struct	libie_aqc_driver_ver driver_ver;
 		struct	libie_aqc_req_res res_owner;
 		struct	libie_aqc_list_caps get_cap;
+		struct	libie_aqc_fw_log fw_log;
 	} params;
 };
 LIBIE_CHECK_STRUCT_LEN(32, libie_aq_desc);
-- 
2.49.0


