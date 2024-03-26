Return-Path: <netdev+bounces-82020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9B88C17B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E411F63304
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744C71B3A;
	Tue, 26 Mar 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFdNhKXw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864971741
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454443; cv=none; b=K9vBW29i63Iauuv29czjoRjtXnAq5uVvXr3ZWf3mjrYmqenn0FEneXtSfZ+wyrK7QYzgUijMBNiNgXeCAfiNR2ryAjoBNGiJIiZ/nK6LGCuqiP/yi4NHyn+xYGsF9j0mUvmsAwt+gUM4eqIA9gfIWphUpQbqKmXWgZP8e+LK4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454443; c=relaxed/simple;
	bh=a4v199lS4QgEFIvJ7UyQlcvDlBJlIUR+S2C9QDqLCNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBJ7py1RyjH7JjZvVqX6mqgqEar92wms+wTTizHzxD/MeKm7r5LNg6zKwYn86KZsqytDFz/6Pfa5EdOXUZshVTmChX2tIKsx2F4uRc6B9FWSaoUCQBEM8AOye+k6UFb6KwsT8sr/4skI2Ln3r50yIqT06xESl2JUxMiG0WQqO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFdNhKXw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711454442; x=1742990442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4v199lS4QgEFIvJ7UyQlcvDlBJlIUR+S2C9QDqLCNU=;
  b=JFdNhKXwV9uGj4M81rZmA5Z8wI/uqDTfvkYAGXh8uFlSP13zHqnIw7AO
   spdWjlr9mknJr0VUV8aVw2dvNr7rsjZjcIoL8e3LysWLb6ZWwvZ5VeQHZ
   EPQVdp69pxjTm/ZcCCITe4rQ/XJHKx1QKC6Ka+JLi6mQGuJ85OaBgQlgG
   /Gxbwb3qO0wIak8SS4o+m6gCvQaDT5yqq8SBPqNTSXudOg6QFNdfvI8FS
   KZVW+7sOtsHiAjzsxUV8kiidTDYfnQGmEX1tfPZta49lLp9LhERiioq86
   Had4tPfUmtOPDxBpkHEdX8jn5CRL1brTrom0qrYxyImS7+U71gGuiywlF
   Q==;
X-CSE-ConnectionGUID: 9sNYGj+oRK+SWRYBACRSFQ==
X-CSE-MsgGUID: 6LQzYla+T/iTq4QiakmXgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6394838"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6394838"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16019578"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 05:00:36 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A33A628198;
	Tue, 26 Mar 2024 12:00:34 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 06/12] iavf: add initial framework for registering PTP clock
Date: Tue, 26 Mar 2024 07:51:11 -0400
Message-Id: <20240326115116.10040-7-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240326115116.10040-1-mateusz.polchlopek@intel.com>
References: <20240326115116.10040-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add the iavf_ptp.c file and fill it in with a skeleton framework to
allow registering the PTP clock device.
Add implementation of helper functions to check if a PTP capability
is supported and handle change in PTP capabilities.
Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/Makefile      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   6 +
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 123 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  10 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +
 5 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c

diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 2d154a4e2fd7..06a5d2752246 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
 	     iavf_adv_rss.o \
-	     iavf_txrx.o iavf_common.o iavf_adminq.o
+	     iavf_txrx.o iavf_common.o iavf_adminq.o \
+	     iavf_ptp.o
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ea2034d7914a..6feabb1c62d1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2875,6 +2875,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 		/* request initial VLAN offload settings */
 		iavf_set_vlan_offload_features(adapter, 0, netdev->features);
 
+	/* Setup initial PTP configuration */
+	iavf_ptp_init(adapter);
+
 	iavf_schedule_finish_config(adapter);
 	return;
 
@@ -5331,6 +5334,9 @@ static void iavf_remove(struct pci_dev *pdev)
 	}
 
 	iavf_misc_irq_disable(adapter);
+
+	iavf_ptp_release(adapter);
+
 	/* Shut down all the garbage mashers on the detention level */
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->watchdog_task);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
new file mode 100644
index 000000000000..0f09d918d269
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. */
+
+#include "iavf.h"
+
+/**
+ * iavf_ptp_cap_supported - Check if a PTP capability is supported
+ * @adapter: private adapter structure
+ * @cap: the capability bitmask to check
+ *
+ * Return true if every capability set in cap is also set in the enabled
+ * capabilities reported by the PF.
+ */
+bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap)
+{
+	if (!PTP_ALLOWED(adapter))
+		return false;
+
+	/* Only return true if every bit in cap is set in hw_caps.caps */
+	return (adapter->ptp.hw_caps.caps & cap) == cap;
+}
+
+/**
+ * iavf_ptp_register_clock - Register a new PTP for userspace
+ * @adapter: private adapter structure
+ *
+ * Allocate and register a new PTP clock device if necessary.
+ */
+static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
+{
+	struct ptp_clock_info *ptp_info = &adapter->ptp.info;
+	struct device *dev = &adapter->pdev->dev;
+
+	memset(ptp_info, 0, sizeof(*ptp_info));
+
+	snprintf(ptp_info->name, sizeof(ptp_info->name) - 1, "%s-%s-clk",
+		 dev_driver_string(dev),
+		 dev_name(dev));
+	ptp_info->owner = THIS_MODULE;
+
+	adapter->ptp.clock = ptp_clock_register(ptp_info, dev);
+	if (IS_ERR(adapter->ptp.clock))
+		return PTR_ERR(adapter->ptp.clock);
+
+	dev_info(&adapter->pdev->dev, "PTP clock %s registered\n",
+		 adapter->ptp.info.name);
+	return 0;
+}
+
+/**
+ * iavf_ptp_init - Initialize PTP support if capability was negotiated
+ * @adapter: private adapter structure
+ *
+ * Initialize PTP functionality, based on the capabilities that the PF has
+ * enabled for this VF.
+ */
+void iavf_ptp_init(struct iavf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	int err;
+
+	if (WARN_ON(adapter->ptp.initialized)) {
+		dev_err(dev, "PTP functionality was already initialized!\n");
+		return;
+	}
+
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC)) {
+		dev_dbg(dev, "Device does not have PTP clock support\n");
+		return;
+	}
+
+	err = iavf_ptp_register_clock(adapter);
+	if (err) {
+		dev_warn(dev, "Failed to register PTP clock device (%d)\n",
+			 err);
+		return;
+	}
+
+	adapter->ptp.initialized = true;
+}
+
+/**
+ * iavf_ptp_release - Disable PTP support
+ * @adapter: private adapter structure
+ *
+ * Release all PTP resources that were previously initialized.
+ */
+void iavf_ptp_release(struct iavf_adapter *adapter)
+{
+	if (!IS_ERR_OR_NULL(adapter->ptp.clock)) {
+		dev_info(&adapter->pdev->dev, "removing PTP clock %s\n",
+			 adapter->ptp.info.name);
+		ptp_clock_unregister(adapter->ptp.clock);
+		adapter->ptp.clock = NULL;
+	}
+
+	adapter->ptp.initialized = false;
+}
+
+/**
+ * iavf_ptp_process_caps - Handle change in PTP capabilities
+ * @adapter: private adapter structure
+ *
+ * Handle any state changes necessary due to change in PTP capabilities, such
+ * as after a device reset or change in configuration from the PF.
+ */
+void iavf_ptp_process_caps(struct iavf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+
+	dev_dbg(dev, "PTP capabilities changed at runtime\n");
+
+	/* Check if the device gained or lost necessary access to support the
+	 * PTP hardware clock. If so, driver must respond appropriately by
+	 * creating or destroying the PTP clock device.
+	 */
+	if (adapter->ptp.initialized &&
+	    !iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		iavf_ptp_release(adapter);
+	else if (!adapter->ptp.initialized &&
+		 iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		iavf_ptp_init(adapter);
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index aee4e2da0b9a..4939c219bd18 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -4,9 +4,19 @@
 #ifndef _IAVF_PTP_H_
 #define _IAVF_PTP_H_
 
+#include <linux/ptp_clock_kernel.h>
+
 /* fields used for PTP support */
 struct iavf_ptp {
 	struct virtchnl_ptp_caps hw_caps;
+	bool initialized;
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
 };
 
+void iavf_ptp_init(struct iavf_adapter *adapter);
+void iavf_ptp_release(struct iavf_adapter *adapter);
+void iavf_ptp_process_caps(struct iavf_adapter *adapter);
+bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap);
+
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index f922e177146d..12ce169699cf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2511,6 +2511,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_1588_PTP_GET_CAPS:
 		memcpy(&adapter->ptp.hw_caps, msg,
 		       min_t(u16, msglen, sizeof(adapter->ptp.hw_caps)));
+		/* process any state change needed due to new capabilities */
+		iavf_ptp_process_caps(adapter);
 	break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-- 
2.38.1


