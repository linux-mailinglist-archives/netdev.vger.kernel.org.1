Return-Path: <netdev+bounces-57636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6DD813AE6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0047A28313F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794776A010;
	Thu, 14 Dec 2023 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIuHNqxW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E4697A3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702582898; x=1734118898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWDLxLaZm2Uxwd73AmMf3zd0ReyZRiChf/ITquVyHFI=;
  b=LIuHNqxWgZN6oiIWUsIA6+DDrXJrsKUe4G0kz9y65v3xL4aHexEn03hL
   99ZXV+7JZZTvZWbbQtjf9PF6CinR5G0hQZ0F6Mlfsh58VBkaS8Ohn2lxt
   /eiWF5GuuRfIWxdioN1PQhWu1Bl7evVanxXlCpmtKckklP/eM8YGOMnv+
   qsTufEHPNJrP5Rdpk6qmUTUQH5+uQKYt7khXjHdyp7n3pm9Plv0qhbzGV
   MbxArb1pzbUDwIy8u5TCorCJrwjlgZ+Q0dGsoeEYurxzv9PHqHX6T5E97
   KuYpkmwr5Y6uFfu+Bx44EARd0xz6V9XpN3W5tEltlwQc/cit3WtWJT+Fz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399013864"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="399013864"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750666551"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="750666551"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 11:41:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vaishnavi.tipireddy@intel.com,
	horms@kernel.org,
	leon@kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v6 3/5] ice: enable FW logging
Date: Thu, 14 Dec 2023 11:40:38 -0800
Message-ID: <20231214194042.2141361-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
References: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Once users have configured the FW logging then allow them to enable it
by writing to the 'fwlog/enable' file. The file accepts a boolean value
(0 or 1) where 1 means enable FW logging and 0 means disable FW logging.

  # echo <value> > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable

Where <value> is 0 or 1.

The user can read the 'fwlog/enable' file to see whether logging is
enabled or not. Reading the actual data is a separate patch. To see the
current value then:

  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 98 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 67 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  2 +
 4 files changed, 170 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 612c8d270838..9ddd50ba07b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2393,6 +2393,7 @@ enum ice_aqc_fw_logging_mod {
 };
 
 /* Set FW Logging configuration (indirect 0xFF30)
+ * Register for FW Logging (indirect 0xFF31)
  * Query FW Logging (indirect 0xFF32)
  */
 struct ice_aqc_fw_log {
@@ -2401,6 +2402,7 @@ struct ice_aqc_fw_log {
 #define ICE_AQC_FW_LOG_CONF_AQ_EN	BIT(1)
 #define ICE_AQC_FW_LOG_QUERY_REGISTERED	BIT(2)
 #define ICE_AQC_FW_LOG_CONF_SET_VALID	BIT(3)
+#define ICE_AQC_FW_LOG_AQ_REGISTER	BIT(0)
 #define ICE_AQC_FW_LOG_AQ_QUERY		BIT(2)
 
 	u8 rsp_flag;
@@ -2722,6 +2724,7 @@ enum ice_adminq_opc {
 
 	/* FW Logging Commands */
 	ice_aqc_opc_fw_logs_config			= 0xFF30,
+	ice_aqc_opc_fw_logs_register			= 0xFF31,
 	ice_aqc_opc_fw_logs_query			= 0xFF32,
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 3b0d9b214fd1..3dde99969132 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -281,6 +281,101 @@ static const struct file_operations ice_debugfs_nr_messages_fops = {
 	.write = ice_debugfs_nr_messages_write,
 };
 
+/**
+ * ice_debugfs_enable_read - read from 'enable' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_enable_read(struct file *filp,
+				       char __user *buffer, size_t count,
+				       loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct ice_hw *hw = &pf->hw;
+	char buff[32] = {};
+
+	snprintf(buff, sizeof(buff), "%u\n",
+		 (u16)(hw->fwlog_cfg.options &
+		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
+
+	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+}
+
+/**
+ * ice_debugfs_enable_write - write into 'enable' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_enable_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct ice_hw *hw = &pf->hw;
+	char user_val[8], *cmd_buf;
+	bool enable;
+	ssize_t ret;
+
+	/* don't allow partial writes or invalid input */
+	if (*ppos != 0 || count > 2)
+		return -EINVAL;
+
+	cmd_buf = memdup_user(buf, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+
+	ret = sscanf(cmd_buf, "%s", user_val);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = kstrtobool(user_val, &enable);
+	if (ret)
+		goto enable_write_error;
+
+	if (enable)
+		hw->fwlog_cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
+	else
+		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+
+	ret = ice_fwlog_set(hw, &hw->fwlog_cfg);
+	if (ret)
+		goto enable_write_error;
+
+	if (enable)
+		ret = ice_fwlog_register(hw);
+	else
+		ret = ice_fwlog_unregister(hw);
+
+	if (ret)
+		goto enable_write_error;
+
+	/* if we get here, nothing went wrong; return count since we didn't
+	 * really write anything
+	 */
+	ret = (ssize_t)count;
+
+enable_write_error:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_enable_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_enable_read,
+	.write = ice_debugfs_enable_write,
+};
+
 /**
  * ice_debugfs_fwlog_init - setup the debugfs directory
  * @pf: the ice that is starting up
@@ -332,6 +427,9 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 
 	pf->ice_debugfs_pf_fwlog_modules = fw_modules;
 
+	debugfs_create_file("enable", 0600, pf->ice_debugfs_pf_fwlog,
+			    pf, &ice_debugfs_enable_fops);
+
 	return;
 
 err_create_module_files:
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 307e0d04f3fe..25a17cbc1d34 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -63,6 +63,11 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	kfree(pf->ice_debugfs_pf_fwlog_modules);
 
 	pf->ice_debugfs_pf_fwlog_modules = NULL;
+
+	status = ice_fwlog_unregister(hw);
+	if (status)
+		dev_warn(ice_hw_to_dev(hw), "Unable to unregister FW logging, status: %d\n",
+			 status);
 }
 
 /**
@@ -197,6 +202,8 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
 	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
 		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
+		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
 
 	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
 
@@ -226,6 +233,66 @@ int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 	return ice_aq_fwlog_get(hw, cfg);
 }
 
+/**
+ * ice_aq_fwlog_register - Register PF for firmware logging events (0xFF31)
+ * @hw: pointer to the HW structure
+ * @reg: true to register and false to unregister
+ */
+static int ice_aq_fwlog_register(struct ice_hw *hw, bool reg)
+{
+	struct ice_aq_desc desc;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_register);
+
+	if (reg)
+		desc.params.fw_log.cmd_flags = ICE_AQC_FW_LOG_AQ_REGISTER;
+
+	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+}
+
+/**
+ * ice_fwlog_register - Register the PF for firmware logging
+ * @hw: pointer to the HW structure
+ *
+ * After this call the PF will start to receive firmware logging based on the
+ * configuration set in ice_fwlog_set.
+ */
+int ice_fwlog_register(struct ice_hw *hw)
+{
+	int status;
+
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	status = ice_aq_fwlog_register(hw, true);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to register for firmware logging events over ARQ\n");
+	else
+		hw->fwlog_cfg.options |= ICE_FWLOG_OPTION_IS_REGISTERED;
+
+	return status;
+}
+
+/**
+ * ice_fwlog_unregister - Unregister the PF from firmware logging
+ * @hw: pointer to the HW structure
+ */
+int ice_fwlog_unregister(struct ice_hw *hw)
+{
+	int status;
+
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	status = ice_aq_fwlog_register(hw, false);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to unregister from firmware logging events over ARQ\n");
+	else
+		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_IS_REGISTERED;
+
+	return status;
+}
+
 /**
  * ice_fwlog_set_supported - Set if FW logging is supported by FW
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 8e68ee02713b..45865558425d 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -53,4 +53,6 @@ int ice_fwlog_init(struct ice_hw *hw);
 void ice_fwlog_deinit(struct ice_hw *hw);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
+int ice_fwlog_register(struct ice_hw *hw);
+int ice_fwlog_unregister(struct ice_hw *hw);
 #endif /* _ICE_FWLOG_H_ */
-- 
2.41.0


