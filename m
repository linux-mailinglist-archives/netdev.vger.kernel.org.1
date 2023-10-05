Return-Path: <netdev+bounces-38340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B637BA73D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CFDCE2821F8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A93AC08;
	Thu,  5 Oct 2023 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReB92zBB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4C38BA0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 17:02:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B22058
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696525335; x=1728061335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2LFEwsaP1sln/5m6KzWYTyPxxpTRPaDvdDcaD7hlsr4=;
  b=ReB92zBBYpl8WMfvhM/C4hypeO0oIEObEmg0992YAQD1twkDEVCt/Z5S
   dzhE6vklZZAH7ZWHY1NynJzBSbNzHWdR2XcjFeqgT1OyFjRQ+FHwIjfNv
   QxkRjI7zZW6rDZZoqsCAqulS06WCBLx99cIa9yRQLrYJMX6aiNBApzNH8
   8QPJD0OSudwgvYAzPiyR+5xAwrKQAstAOY/Tc7P5MP07mwY/WS8eNZXrh
   /y5cytKono5wXDfMZerSIDeKpoR2Lue2SOOLvpyipjtiikERIWqUfEC4G
   tyjNPVXlZT60tDFvxBKfIwsKmDpfYz1UnB1F8bSC9Hznw528zccdHPwDj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447747108"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447747108"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 10:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755537364"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755537364"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2023 10:02:13 -0700
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
Subject: [PATCH net-next v4 2/5] ice: configure FW logging
Date: Thu,  5 Oct 2023 10:01:07 -0700
Message-Id: <20231005170110.3221306-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Users want the ability to debug FW issues by retrieving the
FW logs from the E8xx devices. Use debugfs to allow the user to
read/write the FW log configuration by adding a 'fwlog/modules' file.
Reading the file will show either the currently running configuration or
the next configuration (if the user has changed the configuration).
Writing to the file will update the configuration, but NOT enable the
configuration (that is a separate command).

To see the status of FW logging then read the 'fwlog/modules' file like
this:

cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules

To change the configuration of FW logging then write to the 'fwlog/modules'
file like this:

echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules

The format to change the configuration is

echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device>/fwlog/modules

where

* fwlog_level is a name as described below. Each level includes the
  messages from the previous/lower level

      *	NONE
      *	ERROR
      *	WARNING
      *	NORMAL
      *	VERBOSE

* fwlog_event is a name that represents the module to receive events for.
  The module names are

      *	GENERAL
      *	CTRL
      *	LINK
      *	LINK_TOPO
      *	DNL
      *	I2C
      *	SDP
      *	MDIO
      *	ADMINQ
      *	HDMA
      *	LLDP
      *	DCBX
      *	DCB
      *	XLR
      *	NVM
      *	AUTH
      *	VPD
      *	IOSF
      *	PARSER
      *	SW
      *	SCHEDULER
      *	TXQ
      *	RSVD
      *	POST
      *	WATCHDOG
      *	TASK_DISPATCH
      *	MNG
      *	SYNCE
      *	HEALTH
      *	TSDRV
      *	PFREG
      *	MDLVER
      *	ALL

The name ALL is special and specifies setting all of the modules to the
specified fwlog_level.

If the NVM supports FW logging then the file 'fwlog' will be created
under the PCI device ID for the ice driver. If the file does not exist
then either the NVM doesn't support FW logging or debugfs is not enabled
on the system.

In addition to configuring the modules, the user can also configure the
number of log messages (resolution) to include in a single Admin Receive
Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
means push only when the max AQ command buffer is full). The suggested
value is 10.

To see/change the resolution the user can read/write the
'fwlog/resolution' file. An example changing the value to 50 is

echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 drivers/net/ethernet/intel/ice/ice.h          |   7 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 9 files changed, 856 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 0679907980f7..8757bec23fb3 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -34,7 +34,9 @@ ice-y := ice_main.o	\
 	 ice_lag.o	\
 	 ice_ethtool.o  \
 	 ice_repr.o	\
-	 ice_tc_lib.o
+	 ice_tc_lib.o	\
+	 ice_fwlog.o	\
+	 ice_debugfs.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
 	ice_virtchnl.o		\
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fcaa5c3b8ec0..2d5fb9bec045 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -561,6 +561,8 @@ struct ice_pf {
 	struct ice_vsi_stats **vsi_stats;
 	struct ice_sw *first_sw;	/* first switch created by firmware */
 	u16 eswitch_mode;		/* current mode of eswitch */
+	struct dentry *ice_debugfs_pf;
+	struct dentry *ice_debugfs_pf_fwlog;
 	struct ice_vfs vfs;
 	DECLARE_BITMAP(features, ICE_F_MAX);
 	DECLARE_BITMAP(state, ICE_STATE_NBITS);
@@ -879,6 +881,11 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 	return false;
 }
 
+void ice_debugfs_fwlog_init(struct ice_pf *pf);
+void ice_debugfs_init(void);
+void ice_debugfs_exit(void);
+void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
+
 bool netif_is_ice(const struct net_device *dev);
 int ice_vsi_setup_tx_rings(struct ice_vsi *vsi);
 int ice_vsi_setup_rx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 5d31c119f8f6..5282fc290d4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2293,6 +2293,81 @@ struct ice_aqc_event_lan_overflow {
 	u8 reserved[8];
 };
 
+enum ice_aqc_fw_logging_mod {
+	ICE_AQC_FW_LOG_ID_GENERAL = 0,
+	ICE_AQC_FW_LOG_ID_CTRL,
+	ICE_AQC_FW_LOG_ID_LINK,
+	ICE_AQC_FW_LOG_ID_LINK_TOPO,
+	ICE_AQC_FW_LOG_ID_DNL,
+	ICE_AQC_FW_LOG_ID_I2C,
+	ICE_AQC_FW_LOG_ID_SDP,
+	ICE_AQC_FW_LOG_ID_MDIO,
+	ICE_AQC_FW_LOG_ID_ADMINQ,
+	ICE_AQC_FW_LOG_ID_HDMA,
+	ICE_AQC_FW_LOG_ID_LLDP,
+	ICE_AQC_FW_LOG_ID_DCBX,
+	ICE_AQC_FW_LOG_ID_DCB,
+	ICE_AQC_FW_LOG_ID_XLR,
+	ICE_AQC_FW_LOG_ID_NVM,
+	ICE_AQC_FW_LOG_ID_AUTH,
+	ICE_AQC_FW_LOG_ID_VPD,
+	ICE_AQC_FW_LOG_ID_IOSF,
+	ICE_AQC_FW_LOG_ID_PARSER,
+	ICE_AQC_FW_LOG_ID_SW,
+	ICE_AQC_FW_LOG_ID_SCHEDULER,
+	ICE_AQC_FW_LOG_ID_TXQ,
+	ICE_AQC_FW_LOG_ID_RSVD,
+	ICE_AQC_FW_LOG_ID_POST,
+	ICE_AQC_FW_LOG_ID_WATCHDOG,
+	ICE_AQC_FW_LOG_ID_TASK_DISPATCH,
+	ICE_AQC_FW_LOG_ID_MNG,
+	ICE_AQC_FW_LOG_ID_SYNCE,
+	ICE_AQC_FW_LOG_ID_HEALTH,
+	ICE_AQC_FW_LOG_ID_TSDRV,
+	ICE_AQC_FW_LOG_ID_PFREG,
+	ICE_AQC_FW_LOG_ID_MDLVER,
+	ICE_AQC_FW_LOG_ID_MAX,
+};
+
+/* Set FW Logging configuration (indirect 0xFF30)
+ * Query FW Logging (indirect 0xFF32)
+ */
+struct ice_aqc_fw_log {
+	u8 cmd_flags;
+#define ICE_AQC_FW_LOG_CONF_UART_EN	BIT(0)
+#define ICE_AQC_FW_LOG_CONF_AQ_EN	BIT(1)
+#define ICE_AQC_FW_LOG_QUERY_REGISTERED	BIT(2)
+#define ICE_AQC_FW_LOG_CONF_SET_VALID	BIT(3)
+#define ICE_AQC_FW_LOG_AQ_QUERY		BIT(2)
+
+	u8 rsp_flag;
+	__le16 fw_rt_msb;
+	union {
+		struct {
+			__le32 fw_rt_lsb;
+		} sync;
+		struct {
+			__le16 log_resolution;
+#define ICE_AQC_FW_LOG_MIN_RESOLUTION		(1)
+#define ICE_AQC_FW_LOG_MAX_RESOLUTION		(128)
+
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
+struct ice_aqc_fw_log_cfg_resp {
+	__le16 module_identifier;
+	u8 log_level;
+	u8 rsvd0;
+};
+
 /**
  * struct ice_aq_desc - Admin Queue (AQ) descriptor
  * @flags: ICE_AQ_FLAG_* flags
@@ -2381,6 +2456,7 @@ struct ice_aq_desc {
 		struct ice_aqc_get_cgu_ref_prio get_cgu_ref_prio;
 		struct ice_aqc_get_cgu_info get_cgu_info;
 		struct ice_aqc_driver_shared_params drv_shared_params;
+		struct ice_aqc_fw_log fw_log;
 		struct ice_aqc_set_mac_lb set_mac_lb;
 		struct ice_aqc_alloc_free_res_cmd sw_res_ctrl;
 		struct ice_aqc_set_mac_cfg set_mac_cfg;
@@ -2577,6 +2653,10 @@ enum ice_adminq_opc {
 
 	/* Standalone Commands/Events */
 	ice_aqc_opc_event_lan_overflow			= 0x1001,
+
+	/* FW Logging Commands */
+	ice_aqc_opc_fw_logs_config			= 0xFF30,
+	ice_aqc_opc_fw_logs_query			= 0xFF32,
 };
 
 #endif /* _ICE_ADMINQ_CMD_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index af1f7405bb76..d60c7a007cfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -954,6 +954,11 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
+	status = ice_fwlog_init(hw);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "Error initializing FW logging: %d\n",
+			  status);
+
 	status = ice_clear_pf_cfg(hw);
 	if (status)
 		goto err_unroll_cqinit;
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
new file mode 100644
index 000000000000..e354c7287ff6
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Intel Corporation. */
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/random.h>
+#include <linux/vmalloc.h>
+#include "ice.h"
+
+static struct dentry *ice_debugfs_root;
+
+/* the ordering in this array is important. it matches the ordering of the
+ * values in the FW so the index is the same value as in ice_aqc_fw_logging_mod
+ */
+static const char * const ice_fwlog_module_string[] = {
+	"GENERAL",
+	"CTRL",
+	"LINK",
+	"LINK_TOPO",
+	"DNL",
+	"I2C",
+	"SDP",
+	"MDIO",
+	"ADMINQ",
+	"HDMA",
+	"LLDP",
+	"DCBX",
+	"DCB",
+	"XLR",
+	"NVM",
+	"AUTH",
+	"VPD",
+	"IOSF",
+	"PARSER",
+	"SW",
+	"SCHEDULER",
+	"TXQ",
+	"RSVD",
+	"POST",
+	"WATCHDOG",
+	"TASK_DISPATCH",
+	"MNG",
+	"SYNCE",
+	"HEALTH",
+	"TSDRV",
+	"PFREG",
+	"MDLVER",
+	"ALL",
+};
+
+/* the ordering in this array is important. it matches the ordering of the
+ * values in the FW so the index is the same value as in ice_fwlog_level
+ */
+static const char * const ice_fwlog_level_string[] = {
+	"NONE",
+	"ERROR",
+	"WARNING",
+	"NORMAL",
+	"VERBOSE",
+};
+
+static void ice_print_fwlog_config(struct ice_hw *hw, struct ice_fwlog_cfg *cfg,
+				   char **buff, int *size)
+{
+	char *tmp = *buff;
+	int used = *size;
+	u16 i, len;
+
+	len = snprintf(tmp, used, "Log_resolution: %d\n", cfg->log_resolution);
+	tmp = tmp + len;
+	used -= len;
+	len = snprintf(tmp, used, "Options: 0x%04x\n", cfg->options);
+	tmp = tmp + len;
+	used -= len;
+	len = snprintf(tmp, used, "\tarq_ena: %s\n",
+		       (cfg->options &
+		       ICE_FWLOG_OPTION_ARQ_ENA) ? "true" : "false");
+	tmp = tmp + len;
+	used -= len;
+	len = snprintf(tmp, used, "\tuart_ena: %s\n",
+		       (cfg->options &
+		       ICE_FWLOG_OPTION_UART_ENA) ? "true" : "false");
+	tmp = tmp + len;
+	used -= len;
+	len = snprintf(tmp, used, "\trunning: %s\n",
+		       (cfg->options &
+		       ICE_FWLOG_OPTION_IS_REGISTERED) ? "true" : "false");
+	tmp = tmp + len;
+	used -= len;
+	len = snprintf(tmp, used, "Module Entries:\n");
+	tmp = tmp + len;
+	used -= len;
+
+	for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++) {
+		struct ice_fwlog_module_entry *entry =
+			&cfg->module_entries[i];
+
+		len = snprintf(tmp, used, "\tModule: %s, Log Level: %s\n",
+			       ice_fwlog_module_string[entry->module_id],
+			       ice_fwlog_level_string[entry->log_level]);
+		tmp = tmp + len;
+		used -= len;
+	}
+
+	len = snprintf(tmp, used, "Valid log levels:\n");
+	tmp = tmp + len;
+	used -= len;
+
+	for (i = 0; i < ICE_FWLOG_LEVEL_INVALID; i++) {
+		len = snprintf(tmp, used, "\t%s\n", ice_fwlog_level_string[i]);
+		tmp = tmp + len;
+		used -= len;
+	}
+
+	*buff = tmp;
+	*size = used;
+}
+
+/**
+ * ice_fwlog_dump_cfg - Dump current FW logging configuration
+ * @hw: pointer to the HW structure
+ * @buff: pointer to a buffer to hold the config strings
+ * @buff_size: size of the buffer in bytes
+ */
+static void ice_fwlog_dump_cfg(struct ice_hw *hw, char *buff, int buff_size)
+{
+	int len;
+
+	len = snprintf(buff, buff_size, "FWLOG Configuration:\n");
+	buff = buff + len;
+	buff_size -= len;
+
+	ice_print_fwlog_config(hw, &hw->fwlog_cfg, &buff, &buff_size);
+}
+
+/**
+ * ice_debugfs_parse_cmd_line - Parse the command line that was passed in
+ * @src: pointer to a buffer holding the command line
+ * @len: size of the buffer in bytes
+ * @argv: pointer to store the command line items
+ * @argc: pointer to store the number of command line items
+ */
+static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
+					  char ***argv, int *argc)
+{
+	char *cmd_buf, *cmd_buf_tmp;
+
+	cmd_buf = memdup_user(src, len + 1);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+	cmd_buf[len] = '\0';
+
+	/* the cmd_buf has a newline at the end of the command so
+	 * remove it
+	 */
+	cmd_buf_tmp = strchr(cmd_buf, '\n');
+	if (cmd_buf_tmp) {
+		*cmd_buf_tmp = '\0';
+		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf + 1;
+	}
+
+	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
+	if (!*argv)
+		return -ENOMEM;
+
+	kfree(cmd_buf);
+	return 0;
+}
+
+/**
+ * ice_debugfs_module_read - read from 'module' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_module_read(struct file *filp, char __user *buffer,
+				       size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	char *data = NULL;
+	int status;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(&pf->hw))
+		return -EOPNOTSUPP;
+
+	data = vzalloc(ICE_AQ_MAX_BUF_LEN);
+	if (!data) {
+		dev_warn(ice_pf_to_dev(pf), "Unable to allocate memory for FW configuration!\n");
+		return -ENOMEM;
+	}
+
+	ice_fwlog_dump_cfg(&pf->hw, data, ICE_AQ_MAX_BUF_LEN);
+
+	if (count < strlen(data))
+		return -ENOSPC;
+
+	status = simple_read_from_buffer(buffer, count, ppos, data,
+					 strlen(data));
+	vfree(data);
+
+	return status;
+}
+
+/**
+ * ice_debugfs_module_write - write into 'module' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_module_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct device *dev = ice_pf_to_dev(pf);
+	ssize_t ret;
+	char **argv;
+	int argc;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(&pf->hw))
+		return -EOPNOTSUPP;
+
+	/* don't allow partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
+	if (ret)
+		goto err_copy_from_user;
+
+	if (argc == 2) {
+		int module, log_level;
+
+		module = sysfs_match_string(ice_fwlog_module_string, argv[0]);
+		if (module < 0) {
+			dev_info(dev, "unknown module '%s'\n", argv[0]);
+			ret = -EINVAL;
+			goto module_write_error;
+		}
+
+		log_level = sysfs_match_string(ice_fwlog_level_string, argv[1]);
+		if (log_level < 0) {
+			dev_info(dev, "unknown log level '%s'\n", argv[1]);
+			ret = -EINVAL;
+			goto module_write_error;
+		}
+
+		/* module is valid because it was range checked using
+		 * sysfs_match_string()
+		 */
+		if (module != ICE_AQC_FW_LOG_ID_MAX) {
+			ice_pf_fwlog_update_module(pf, log_level, module);
+		} else {
+			/* the module 'ALL' is a shortcut so that we can set
+			 * all of the modules to the same level quickly
+			 */
+			int i;
+
+			for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
+				ice_pf_fwlog_update_module(pf, log_level, i);
+		}
+	} else {
+		dev_info(dev, "unknown or invalid command '%s'\n", argv[0]);
+		ret = -EINVAL;
+		goto module_write_error;
+	}
+
+	/* if we get here, nothing went wrong; return bytes copied */
+	ret = (ssize_t)count;
+
+module_write_error:
+	argv_free(argv);
+err_copy_from_user:
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
+static const struct file_operations ice_debugfs_module_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_module_read,
+	.write = ice_debugfs_module_write,
+};
+
+/**
+ * ice_debugfs_resolution_read - read from 'resolution' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_resolution_read(struct file *filp,
+					   char __user *buffer, size_t count,
+					   loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct ice_hw *hw = &pf->hw;
+	char buff[32] = {};
+	int status;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(&pf->hw))
+		return -EOPNOTSUPP;
+
+	snprintf(buff, sizeof(buff), "%d\n",
+		 hw->fwlog_cfg.log_resolution);
+
+	status = simple_read_from_buffer(buffer, count, ppos, buff,
+					 strlen(buff));
+
+	return status;
+}
+
+/**
+ * ice_debugfs_resolution_write - write into 'resolution' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_resolution_write(struct file *filp, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	ssize_t ret;
+	char **argv;
+	int argc;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	/* don't allow partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
+	if (ret)
+		goto err_copy_from_user;
+
+	if (argc == 1) {
+		s16 resolution;
+
+		ret = kstrtos16(argv[0], 0, &resolution);
+		if (ret)
+			goto resolution_write_error;
+
+		if (resolution < ICE_AQC_FW_LOG_MIN_RESOLUTION ||
+		    resolution > ICE_AQC_FW_LOG_MAX_RESOLUTION) {
+			dev_err(dev, "Invalid FW log resolution %d, value must be between %d - %d\n",
+				resolution, ICE_AQC_FW_LOG_MIN_RESOLUTION,
+				ICE_AQC_FW_LOG_MAX_RESOLUTION);
+			ret = -EINVAL;
+			goto resolution_write_error;
+		}
+
+		hw->fwlog_cfg.log_resolution = resolution;
+	} else {
+		dev_info(dev, "unknown or invalid command '%s'\n", argv[0]);
+		ret = -EINVAL;
+		goto resolution_write_error;
+	}
+
+	/* if we get here, nothing went wrong; return bytes copied */
+	ret = (ssize_t)count;
+
+resolution_write_error:
+	argv_free(argv);
+err_copy_from_user:
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
+static const struct file_operations ice_debugfs_resolution_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_resolution_read,
+	.write = ice_debugfs_resolution_write,
+};
+
+/**
+ * ice_debugfs_fwlog_init - setup the debugfs directory
+ * @pf: the ice that is starting up
+ */
+void ice_debugfs_fwlog_init(struct ice_pf *pf)
+{
+	const char *name = pci_name(pf->pdev);
+
+	/* only support fw log commands on PF 0 */
+	if (pf->hw.bus.func)
+		return;
+
+	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
+	if (IS_ERR(pf->ice_debugfs_pf)) {
+		pr_info("init of debugfs PCI dir failed\n");
+		return;
+	}
+
+	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
+						      pf->ice_debugfs_pf);
+	if (IS_ERR(pf->ice_debugfs_pf)) {
+		pr_info("init of debugfs fwlog dir failed\n");
+		return;
+	}
+
+	debugfs_create_file("modules", 0600, pf->ice_debugfs_pf_fwlog,
+			    pf, &ice_debugfs_module_fops);
+
+	debugfs_create_file("resolution", 0600,
+			    pf->ice_debugfs_pf_fwlog, pf,
+			    &ice_debugfs_resolution_fops);
+}
+
+/**
+ * ice_debugfs_init - create root directory for debugfs entries
+ */
+void ice_debugfs_init(void)
+{
+	ice_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (IS_ERR(ice_debugfs_root))
+		pr_info("init of debugfs failed\n");
+}
+
+/**
+ * ice_debugfs_exit - remove debugfs entries
+ */
+void ice_debugfs_exit(void)
+{
+	debugfs_remove_recursive(ice_debugfs_root);
+	ice_debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
new file mode 100644
index 000000000000..1f4b474dcc97
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Intel Corporation. */
+
+#include "ice.h"
+#include "ice_common.h"
+#include "ice_fwlog.h"
+
+/**
+ * ice_fwlog_init - Initialize FW logging configuration
+ * @hw: pointer to the HW structure
+ *
+ * This function should be called on driver initialization during
+ * ice_init_hw().
+ */
+int ice_fwlog_init(struct ice_hw *hw)
+{
+	int status;
+
+	ice_fwlog_set_supported(hw);
+
+	if (ice_fwlog_supported(hw)) {
+		/* read the current config from the FW and store it */
+		status = ice_fwlog_get(hw, &hw->fwlog_cfg);
+		if (status)
+			return status;
+
+		ice_debugfs_fwlog_init(hw->back);
+	} else {
+		dev_warn(ice_hw_to_dev(hw), "FW logging is not supported in this NVM image. Please update the NVM to get FW log support\n");
+	}
+
+	return 0;
+}
+
+/**
+ * ice_fwlog_supported - Cached for whether FW supports FW logging or not
+ * @hw: pointer to the HW structure
+ *
+ * This will always return false if called before ice_init_hw(), so it must be
+ * called after ice_init_hw().
+ */
+bool ice_fwlog_supported(struct ice_hw *hw)
+{
+	return hw->fwlog_supported;
+}
+
+/**
+ * ice_aq_fwlog_set - Set FW logging configuration AQ command (0xFF30)
+ * @hw: pointer to the HW structure
+ * @entries: entries to configure
+ * @num_entries: number of @entries
+ * @options: options from ice_fwlog_cfg->options structure
+ * @log_resolution: logging resolution
+ */
+static int
+ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
+		 u16 num_entries, u16 options, u16 log_resolution)
+{
+	struct ice_aqc_fw_log_cfg_resp *fw_modules;
+	struct ice_aqc_fw_log *cmd;
+	struct ice_aq_desc desc;
+	int status;
+	int i;
+
+	fw_modules = kcalloc(num_entries, sizeof(*fw_modules), GFP_KERNEL);
+	if (!fw_modules)
+		return -ENOMEM;
+
+	for (i = 0; i < num_entries; i++) {
+		fw_modules[i].module_identifier =
+			cpu_to_le16(entries[i].module_id);
+		fw_modules[i].log_level = entries[i].log_level;
+	}
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_config);
+	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+
+	cmd = &desc.params.fw_log;
+
+	cmd->cmd_flags = ICE_AQC_FW_LOG_CONF_SET_VALID;
+	cmd->ops.cfg.log_resolution = cpu_to_le16(log_resolution);
+	cmd->ops.cfg.mdl_cnt = cpu_to_le16(num_entries);
+
+	if (options & ICE_FWLOG_OPTION_ARQ_ENA)
+		cmd->cmd_flags |= ICE_AQC_FW_LOG_CONF_AQ_EN;
+	if (options & ICE_FWLOG_OPTION_UART_ENA)
+		cmd->cmd_flags |= ICE_AQC_FW_LOG_CONF_UART_EN;
+
+	status = ice_aq_send_cmd(hw, &desc, fw_modules,
+				 sizeof(*fw_modules) * num_entries,
+				 NULL);
+
+	kfree(fw_modules);
+
+	return status;
+}
+
+/**
+ * ice_fwlog_set - Set the firmware logging settings
+ * @hw: pointer to the HW structure
+ * @cfg: config used to set firmware logging
+ *
+ * This function should be called whenever the driver needs to set the firmware
+ * logging configuration. It can be called on initialization, reset, or during
+ * runtime.
+ *
+ * If the PF wishes to receive FW logging then it must register via
+ * ice_fwlog_register. Note, that ice_fwlog_register does not need to be called
+ * for init.
+ */
+int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+{
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	return ice_aq_fwlog_set(hw, cfg->module_entries,
+				ICE_AQC_FW_LOG_ID_MAX, cfg->options,
+				cfg->log_resolution);
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
+	struct ice_aq_desc desc;
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
+	cmd = &desc.params.fw_log;
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
+ * ice_fwlog_get - Get the firmware logging settings
+ * @hw: pointer to the HW structure
+ * @cfg: config to populate based on current firmware logging settings
+ */
+int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+{
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	if (!cfg)
+		return -EINVAL;
+
+	return ice_aq_fwlog_get(hw, cfg);
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
+void ice_fwlog_set_supported(struct ice_hw *hw)
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
+	/* don't call ice_fwlog_get() because that would check to see if FW
+	 * logging is supported which is what the driver is determining now
+	 */
+	status = ice_aq_fwlog_get(hw, cfg);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
+			  status);
+	else
+		hw->fwlog_supported = true;
+
+	kfree(cfg);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
new file mode 100644
index 000000000000..5a4194527cf9
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022, Intel Corporation. */
+
+#ifndef _ICE_FWLOG_H_
+#define _ICE_FWLOG_H_
+#include "ice_adminq_cmd.h"
+
+struct ice_hw;
+
+/* Only a single log level should be set and all log levels under the set value
+ * are enabled, e.g. if log level is set to ICE_FW_LOG_LEVEL_VERBOSE, then all
+ * other log levels are included (except ICE_FW_LOG_LEVEL_NONE)
+ */
+enum ice_fwlog_level {
+	ICE_FWLOG_LEVEL_NONE = 0,
+	ICE_FWLOG_LEVEL_ERROR = 1,
+	ICE_FWLOG_LEVEL_WARNING = 2,
+	ICE_FWLOG_LEVEL_NORMAL = 3,
+	ICE_FWLOG_LEVEL_VERBOSE = 4,
+	ICE_FWLOG_LEVEL_INVALID, /* all values >= this entry are invalid */
+};
+
+struct ice_fwlog_module_entry {
+	/* module ID for the corresponding firmware logging event */
+	u16 module_id;
+	/* verbosity level for the module_id */
+	u8 log_level;
+};
+
+struct ice_fwlog_cfg {
+	/* list of modules for configuring log level */
+	struct ice_fwlog_module_entry module_entries[ICE_AQC_FW_LOG_ID_MAX];
+	/* options used to configure firmware logging */
+	u16 options;
+#define ICE_FWLOG_OPTION_ARQ_ENA		BIT(0)
+#define ICE_FWLOG_OPTION_UART_ENA		BIT(1)
+	/* set before calling ice_fwlog_init() so the PF registers for firmware
+	 * logging on initialization
+	 */
+#define ICE_FWLOG_OPTION_REGISTER_ON_INIT	BIT(2)
+	/* set in the ice_fwlog_get() response if the PF is registered for FW
+	 * logging events over ARQ
+	 */
+#define ICE_FWLOG_OPTION_IS_REGISTERED		BIT(3)
+
+	/* minimum number of log events sent per Admin Receive Queue event */
+	u16 log_resolution;
+};
+
+void ice_fwlog_set_supported(struct ice_hw *hw);
+bool ice_fwlog_supported(struct ice_hw *hw);
+int ice_fwlog_init(struct ice_hw *hw);
+int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
+int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
+#endif /* _ICE_FWLOG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d665c566c3bd..fcb777d1a237 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4355,6 +4355,22 @@ static void ice_print_wake_reason(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "Wake reason: %s", wake_str);
 }
 
+/**
+ * ice_pf_fwlog_update_module - update 1 module
+ * @pf: pointer to the PF struct
+ * @log_level: log_level to use for the @module
+ * @module: module to update
+ */
+void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
+{
+	struct ice_fwlog_module_entry *entries;
+	struct ice_hw *hw = &pf->hw;
+
+	entries = (struct ice_fwlog_module_entry *)hw->fwlog_cfg.module_entries;
+
+	entries[module].log_level = log_level;
+}
+
 /**
  * ice_register_netdev - register netdev
  * @vsi: pointer to the VSI struct
@@ -5181,6 +5197,8 @@ static void ice_remove(struct pci_dev *pdev)
 		msleep(100);
 	}
 
+	ice_debugfs_exit();
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
@@ -5642,6 +5660,8 @@ static int __init ice_module_init(void)
 		goto err_dest_wq;
 	}
 
+	ice_debugfs_init();
+
 	status = pci_register_driver(&ice_driver);
 	if (status) {
 		pr_err("failed to register PCI driver, err %d\n", status);
@@ -5652,6 +5672,7 @@ static int __init ice_module_init(void)
 
 err_dest_lag_wq:
 	destroy_workqueue(ice_lag_wq);
+	ice_debugfs_exit();
 err_dest_wq:
 	destroy_workqueue(ice_wq);
 	return status;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 2dc6df5ba505..20a9efc931c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -17,6 +17,7 @@
 #include "ice_protocol_type.h"
 #include "ice_sbq_cmd.h"
 #include "ice_vlan_mode.h"
+#include "ice_fwlog.h"
 
 static inline bool ice_is_tc_ena(unsigned long bitmap, u8 tc)
 {
@@ -870,6 +871,9 @@ struct ice_hw {
 	u8 fw_patch;		/* firmware patch version */
 	u32 fw_build;		/* firmware build number */
 
+	struct ice_fwlog_cfg fwlog_cfg;
+	bool fwlog_supported; /* does hardware support FW logging? */
+
 /* Device max aggregate bandwidths corresponding to the GL_PWR_MODE_CTL
  * register. Used for determining the ITR/INTRL granularity during
  * initialization.
-- 
2.38.1


