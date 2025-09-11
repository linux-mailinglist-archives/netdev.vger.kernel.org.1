Return-Path: <netdev+bounces-222321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185DB53D7B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D7AC10AD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12932DF3CF;
	Thu, 11 Sep 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkSFU5NB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B42DECAF
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624747; cv=none; b=dFFSm4UdI6Ljld6YKk/w7+me+dr8SLUhQ8dg9JSzDdP2zOTg0XMVNtVdICKXLctm9wo1RNv598G35ZTubNNZ/bSyU7iU3/TrhgsfLgEeTq8NZ/nx9tAi3mNzXa11hPWVRhgPBxrZivsVF5so/bUYFpsVYYDY1gt4hPi57c88C9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624747; c=relaxed/simple;
	bh=FNKx3JMr6NaLXnkX+ZMtTO9MRXomBrAqkbVon/yYerg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWHFSOL7ld2FjJee4dkbY9nY1r4ueAtmyN8CRRXAJ3OUgY9f2dtbkKhZK7O+Rj6tXbXDFsuF1dZWWm64utsWVJvPRiK+/a2TrOxM18fa9FPQYbKSajx+igBNSnfmphEPowDXlSL58Ly4e7RxvSP1aSo2Kfc7zePOpVdhWJEie/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkSFU5NB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624745; x=1789160745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNKx3JMr6NaLXnkX+ZMtTO9MRXomBrAqkbVon/yYerg=;
  b=SkSFU5NBd/Zqc4D8gxYjgNHeTWwmPoZjtJSfEIjqdk/zZ4O4o/fl2Nka
   p+va6rOHSIxisrhIx150R6y62WTLABktsf0ZCEKlMVMB7NO5LFoHNJ62k
   JokEzAqGup9KtG0jBJBAyc1YyS6m4t3ua07GRnpHybAxkCiD2BIC7DhFm
   1+eeJ+vKQDVnKN0sb7AXggxB9yVDiGlPYdBvXo3gyZBKs4Vti4q/4VmQB
   tXk34AntEAi9zce1Kp4JKU4lkC4oOzZuV7QkjQsgCMvbgmewiyAfEA2SG
   SiX5+mH3WClQqkBf3TPH3amxWfYESE+eH82fowwzJYH4AmiEmEUoTLY1Z
   g==;
X-CSE-ConnectionGUID: Poi6IKl4ROmbOn2wpRDrkQ==
X-CSE-MsgGUID: vsYaeZnTTfy5m+QZ6y1cLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558931"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558931"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:44 -0700
X-CSE-ConnectionGUID: dJ0KgIrlSpechI8VUOm+0A==
X-CSE-MsgGUID: nexyF1n2R5e5wLCd+Pz57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583399"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 10/15] libie, ice: move fwlog admin queue to libie
Date: Thu, 11 Sep 2025 14:05:09 -0700
Message-ID: <20250911210525.345110-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Copy the code and:
- change ICE_AQC to LIBIE_AQC
- change ice_aqc to libie_aqc
- move definitions outside the structures

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 161e0571bae7..6f7f6788447e 100644
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
index 9e640e942feb..30175be484a5 100644
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
@@ -325,8 +325,8 @@ ice_aq_fwlog_set(struct ice_fwlog *fwlog,
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
@@ -341,19 +341,19 @@ ice_aq_fwlog_set(struct ice_fwlog *fwlog,
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
@@ -382,7 +382,7 @@ int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 		return -EOPNOTSUPP;
 
 	return ice_aq_fwlog_set(fwlog, cfg->module_entries,
-				ICE_AQC_FW_LOG_ID_MAX, cfg->options,
+				LIBIE_AQC_FW_LOG_ID_MAX, cfg->options,
 				cfg->log_resolution);
 }
 
@@ -393,14 +393,14 @@ int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
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
index ba62f703df43..ca2ac88b5709 100644
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
2.47.1


