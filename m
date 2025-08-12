Return-Path: <netdev+bounces-212753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFBB21C3E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94FD2A63B4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F82DF3F2;
	Tue, 12 Aug 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLeFpkuW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD82D6E4D
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974016; cv=none; b=a/0SaXvsomqcHtaFIAHcsKQSCElm29JcwDRWjYs6ar6qZUQLXqnJfO0xc1wnBYJZIdeunhh4U4Xm+n6zthRBYuDQRt9mfGELy44z8arir3uXwoRoryKvKuCWbCXy7nma7CWPDQDaiZs/VFZiJGMmnoaIa2jDlAOwmttsQxg8dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974016; c=relaxed/simple;
	bh=xpI2j6Ya3tzJb0LvCYuMOYI32ZhuLepKOSz+MvOa3Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA5eXPMONzD6HIWObQljEA2vbWo/OHFHSyZLL6dkXAW/1xoYcMrjedeSiEcIEYMJvE11QycnzD5GfAYlpXtCzBjoSjM2Eb2NzyfdQoOH79wqcQUpmFHXMU4nwBP23Qh33A+YT5VjKE5HX39PzXkDcRnuiUgvZGL0DDtcK4sEmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLeFpkuW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974015; x=1786510015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpI2j6Ya3tzJb0LvCYuMOYI32ZhuLepKOSz+MvOa3Js=;
  b=FLeFpkuWhaI+GpmUeDsOxX84mftYR8JquoG0MJl4lqOFZ7VgFj0gztc7
   wUsRzFHSQSCYBivXKjMsaXpFw0J/T4mBz1Nu2jR/DbBlNqEk6HInzswwf
   LUsjpj+cTJYe0HVU7KuSqQUUbWVWj2YS9ipFYI3tUiPYfYhiBuKHKYif6
   65UGZBnvYpA+4XhRtP1XlcvQ24/WKeBE5+vpblKL8tng+X9B73cmGFgXk
   hmiimaTyjILvSL/3lxA/xFFjSWbnMm3Ypi+iliy1EwpjJ0g0wXW7UEQ+5
   SVrOHI4Ph474ujOVeKLXkbga3vEQhX+GlmJlMMbpBE4X1VSSVlIn6pNwT
   Q==;
X-CSE-ConnectionGUID: owPqFen1SOq7EslcWT9rPA==
X-CSE-MsgGUID: i+G9ODzwT2auw+d3PITVHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612724"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612724"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:46:54 -0700
X-CSE-ConnectionGUID: 0zoUI/+HRbSXOmMG/tC94g==
X-CSE-MsgGUID: mUqLLoiNR7qL2dXyHHBAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327868"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:46:53 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 01/15] ice: make fwlog functions static
Date: Tue, 12 Aug 2025 06:23:22 +0200
Message-ID: <20250812042337.1356907-2-michal.swiatkowski@linux.intel.com>
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

ice_fwlog_supported(), ice_fwlog_get() and ice_fwlog_supported() aren't
called outside the ice_fwlog.c file. Make it static and move in the file
to allow clean build.

Drop ice_fwlog_get(). It is called only from ice_fwlog_init() function
where the fwlog support is already checked. There is no need to check it
again, call ice_aq_fwlog_get() instead.

Drop no longer valid comment from ice_fwlog_get_supported().

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 232 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_fwlog.h |   5 +-
 2 files changed, 109 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index a31bb026ad34..e48856206648 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -123,6 +123,113 @@ void ice_fwlog_realloc_rings(struct ice_hw *hw, int index)
 	hw->fwlog_ring.tail = 0;
 }
 
+/**
+ * ice_fwlog_supported - Cached for whether FW supports FW logging or not
+ * @hw: pointer to the HW structure
+ *
+ * This will always return false if called before ice_init_hw(), so it must be
+ * called after ice_init_hw().
+ */
+static bool ice_fwlog_supported(struct ice_hw *hw)
+{
+	return hw->fwlog_supported;
+}
+
+/**
+ * ice_aq_fwlog_get - Get the current firmware logging configuration (0xFF32)
+ * @hw: pointer to the HW structure
+ * @cfg: firmware logging configuration to populate
+ */
+static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+{
+	struct ice_aqc_fw_log_cfg_resp *fw_modules;
+	struct ice_aqc_fw_log *cmd;
+	struct libie_aq_desc desc;
+	u16 module_id_cnt;
+	int status;
+	void *buf;
+	int i;
+
+	memset(cfg, 0, sizeof(*cfg));
+
+	buf = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_query);
+	cmd = libie_aq_raw(&desc);
+
+	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
+
+	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
+	if (status) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to get FW log configuration\n");
+		goto status_out;
+	}
+
+	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
+	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned less than the expected number of FW log module IDs\n");
+	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
+			  ICE_AQC_FW_LOG_ID_MAX);
+		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
+	}
+
+	cfg->log_resolution = le16_to_cpu(cmd->ops.cfg.log_resolution);
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_AQ_EN)
+		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
+		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
+		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
+
+	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
+
+	for (i = 0; i < module_id_cnt; i++) {
+		struct ice_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
+
+		cfg->module_entries[i].module_id =
+			le16_to_cpu(fw_module->module_identifier);
+		cfg->module_entries[i].log_level = fw_module->log_level;
+	}
+
+status_out:
+	kfree(buf);
+	return status;
+}
+
+/**
+ * ice_fwlog_set_supported - Set if FW logging is supported by FW
+ * @hw: pointer to the HW struct
+ *
+ * If FW returns success to the ice_aq_fwlog_get call then it supports FW
+ * logging, else it doesn't. Set the fwlog_supported flag accordingly.
+ *
+ * This function is only meant to be called during driver init to determine if
+ * the FW support FW logging.
+ */
+static void ice_fwlog_set_supported(struct ice_hw *hw)
+{
+	struct ice_fwlog_cfg *cfg;
+	int status;
+
+	hw->fwlog_supported = false;
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return;
+
+	status = ice_aq_fwlog_get(hw, cfg);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
+			  status);
+	else
+		hw->fwlog_supported = true;
+
+	kfree(cfg);
+}
+
 /**
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
@@ -142,7 +249,7 @@ int ice_fwlog_init(struct ice_hw *hw)
 		int status;
 
 		/* read the current config from the FW and store it */
-		status = ice_fwlog_get(hw, &hw->fwlog_cfg);
+		status = ice_aq_fwlog_get(hw, &hw->fwlog_cfg);
 		if (status)
 			return status;
 
@@ -214,18 +321,6 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	}
 }
 
-/**
- * ice_fwlog_supported - Cached for whether FW supports FW logging or not
- * @hw: pointer to the HW structure
- *
- * This will always return false if called before ice_init_hw(), so it must be
- * called after ice_init_hw().
- */
-bool ice_fwlog_supported(struct ice_hw *hw)
-{
-	return hw->fwlog_supported;
-}
-
 /**
  * ice_aq_fwlog_set - Set FW logging configuration AQ command (0xFF30)
  * @hw: pointer to the HW structure
@@ -300,83 +395,6 @@ int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 				cfg->log_resolution);
 }
 
-/**
- * ice_aq_fwlog_get - Get the current firmware logging configuration (0xFF32)
- * @hw: pointer to the HW structure
- * @cfg: firmware logging configuration to populate
- */
-static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
-{
-	struct ice_aqc_fw_log_cfg_resp *fw_modules;
-	struct ice_aqc_fw_log *cmd;
-	struct libie_aq_desc desc;
-	u16 module_id_cnt;
-	int status;
-	void *buf;
-	int i;
-
-	memset(cfg, 0, sizeof(*cfg));
-
-	buf = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_query);
-	cmd = libie_aq_raw(&desc);
-
-	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
-
-	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
-	if (status) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to get FW log configuration\n");
-		goto status_out;
-	}
-
-	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
-	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned less than the expected number of FW log module IDs\n");
-	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
-			  ICE_AQC_FW_LOG_ID_MAX);
-		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
-	}
-
-	cfg->log_resolution = le16_to_cpu(cmd->ops.cfg.log_resolution);
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_AQ_EN)
-		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
-		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
-		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
-
-	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
-
-	for (i = 0; i < module_id_cnt; i++) {
-		struct ice_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
-
-		cfg->module_entries[i].module_id =
-			le16_to_cpu(fw_module->module_identifier);
-		cfg->module_entries[i].log_level = fw_module->log_level;
-	}
-
-status_out:
-	kfree(buf);
-	return status;
-}
-
-/**
- * ice_fwlog_get - Get the firmware logging settings
- * @hw: pointer to the HW structure
- * @cfg: config to populate based on current firmware logging settings
- */
-int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
-{
-	if (!ice_fwlog_supported(hw))
-		return -EOPNOTSUPP;
-
-	return ice_aq_fwlog_get(hw, cfg);
-}
-
 /**
  * ice_aq_fwlog_register - Register PF for firmware logging events (0xFF31)
  * @hw: pointer to the HW structure
@@ -438,37 +456,3 @@ int ice_fwlog_unregister(struct ice_hw *hw)
 
 	return status;
 }
-
-/**
- * ice_fwlog_set_supported - Set if FW logging is supported by FW
- * @hw: pointer to the HW struct
- *
- * If FW returns success to the ice_aq_fwlog_get call then it supports FW
- * logging, else it doesn't. Set the fwlog_supported flag accordingly.
- *
- * This function is only meant to be called during driver init to determine if
- * the FW support FW logging.
- */
-void ice_fwlog_set_supported(struct ice_hw *hw)
-{
-	struct ice_fwlog_cfg *cfg;
-	int status;
-
-	hw->fwlog_supported = false;
-
-	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return;
-
-	/* don't call ice_fwlog_get() because that would check to see if FW
-	 * logging is supported which is what the driver is determining now
-	 */
-	status = ice_aq_fwlog_get(hw, cfg);
-	if (status)
-		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
-			  status);
-	else
-		hw->fwlog_supported = true;
-
-	kfree(cfg);
-}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 287e71fa4b86..7d95d11b6ef9 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -38,7 +38,7 @@ struct ice_fwlog_cfg {
 	 * logging on initialization
 	 */
 #define ICE_FWLOG_OPTION_REGISTER_ON_INIT	BIT(2)
-	/* set in the ice_fwlog_get() response if the PF is registered for FW
+	/* set in the ice_aq_fwlog_get() response if the PF is registered for FW
 	 * logging events over ARQ
 	 */
 #define ICE_FWLOG_OPTION_IS_REGISTERED		BIT(3)
@@ -67,12 +67,9 @@ struct ice_fwlog_ring {
 bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings);
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
-void ice_fwlog_set_supported(struct ice_hw *hw);
-bool ice_fwlog_supported(struct ice_hw *hw);
 int ice_fwlog_init(struct ice_hw *hw);
 void ice_fwlog_deinit(struct ice_hw *hw);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
-int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw);
 int ice_fwlog_unregister(struct ice_hw *hw);
 void ice_fwlog_realloc_rings(struct ice_hw *hw, int index);
-- 
2.49.0


