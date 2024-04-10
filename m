Return-Path: <netdev+bounces-86539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FB89F214
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBF7B22340
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3415D5B8;
	Wed, 10 Apr 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOzmTBhM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116A15B99B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751997; cv=none; b=b97igZly6Nsyd26XdesyJeMq4S49rtJQGp95d4Sh9Gg0uJPk/Met9a3KHIzBmhsAKFkdiXSl+xgMmN65xrgpUvoMadAWXLItCxAhtnUsejQZIpqDw67ZsDET+f2siENMM+PMR7/bp9AD6Lx4WcGtFY3aJWZ/KqblQgenIwPp28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751997; c=relaxed/simple;
	bh=riDmmh6kZH39OLvl3Ej2xrZ1Uiy5IuatlOKwM1Htw2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDELvgYaRVLdhuRByiueaLUtbv/cGjJAcwMEvkfbKlZg0Ajq1KZnMfvoAtb1GRs0l3IpZYS5F0ZSzkbzGs33baNprIRKxmPmpcHlTM3a3oz1x4xpYVRfnmDx/737tz1xb2Zx2LLcKzqWG3cKcCCoHAwR95gR+v5DBv4U0lFD2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOzmTBhM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712751995; x=1744287995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riDmmh6kZH39OLvl3Ej2xrZ1Uiy5IuatlOKwM1Htw2U=;
  b=lOzmTBhMapQ2dKjwmMNRc2ktoD2nei65BDqFzeH5ddKY/41bTDE3dn9V
   wL8J6vBEjj3A4Y2E/iW2LLepQycO2bQGu8DpZnLSDKLGQsCDhj3utt3Z8
   XjvDzmZKq8mOAR8blYmxWL5z043VCJHyFJ+5GIqcHAp7SUO1MqtmlhNeR
   lOGxEEWDQCStvxzfifubid/NcowjKtm9oAy0u2NbIywItmUF3NdQJyGQG
   YvH6OtWelJCyIy1XRGP3DwgHw91UrBYFmolb/4UWY8MW5DtO6Bd++gP9/
   TelmWFocUpNMOO6bh9lh9LN1xtOLmDMRg9u7S9nxUTM9dnxpXnkKM3m1n
   Q==;
X-CSE-ConnectionGUID: mAeo34hPQnultau9uq2/Vg==
X-CSE-MsgGUID: 6RACV2OrSNaaqdkFm7RnPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7982215"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7982215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:26:35 -0700
X-CSE-ConnectionGUID: eMXqniWwT0WxI2RmUP+PiA==
X-CSE-MsgGUID: vfmF6FlXQpyKIeTT6SOh7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51760068"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 05:26:32 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 68DEF2FC48;
	Wed, 10 Apr 2024 13:26:30 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v4 06/12] iavf: add initial framework for registering PTP clock
Date: Wed, 10 Apr 2024 08:17:00 -0400
Message-Id: <20240410121706.6223-7-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240410121706.6223-1-mateusz.polchlopek@intel.com>
References: <20240410121706.6223-1-mateusz.polchlopek@intel.com>
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

Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
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
index 21df6a0f136f..a4203dcb158b 100644
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
 
@@ -5358,6 +5361,9 @@ static void iavf_remove(struct pci_dev *pdev)
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


