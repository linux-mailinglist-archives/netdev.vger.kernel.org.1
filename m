Return-Path: <netdev+bounces-166536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5183A3661D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8391F172197
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838831C8634;
	Fri, 14 Feb 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoLAXjxT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3061C84DB
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561279; cv=none; b=mHYcuWDnbEiXRkUJ9rfTQ+SnE4fxjSySdTZAnY0Yl2kyWaR8GO3l8yXqGvR0PaBAVQB47MtOkLuTLIV+BCh1RF/aU06drITiJrKhhcSzRBKqMS2mburiUy5qSGnsNIK8rh8AlekX3owd+eNZ3hxmvA1RoLd/3P9fh0CoW55VwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561279; c=relaxed/simple;
	bh=PqMqzWK/+DWgfqA4lIDByeB8ihVFXuhONOyGIcafbe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG0yzFwc+xqXl5RyorIRTV9QaNvkJx9AmhGE+wbPtU3KYgXLZ9dCuPxHw9h2IBTCvgoFZ0KUdq1vPA+c+KJeA/pNL0JvCG1tSvZp0KwkstSOJ3iAYClMhu/dWzXU5AkNEIACyylTBSjnysCW6yHA3C2u2pife9Rn31+/CM1i2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoLAXjxT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561277; x=1771097277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqMqzWK/+DWgfqA4lIDByeB8ihVFXuhONOyGIcafbe4=;
  b=IoLAXjxTZH0Xn5nnLTk7Vvuf5B5USTMcX5Ucz5E1He7bfxFBUYtRWD28
   Y7lcjyQHCNhaF49MosiU0IYtC2vZ7vESDML75cW8p8CpOGOpvdf3NcFgH
   4hBl8iQOWVByYhbn/O1d1uzvL3tJvQ8rambSodnRMc5o7deQtk2qp6aE6
   crvVkqtnL2D+FEij7d8LbWrLn4YM1dPj8DtO6duWdbkfQ+qOgah4G4d5/
   GPDRx1lDc51NHlUaFwdpEvdxg+JSy37eS4IkmtESSMF0/iOPRc2/R7sgf
   em9UoQQvBZUcPoHjIVIY7mz0wb2hPa0NS/uSBB7y7PLvkmmYBwxRwy6zC
   w==;
X-CSE-ConnectionGUID: EOf4PDCqQaSTb+SAH8ak5Q==
X-CSE-MsgGUID: jnLu7v/mRGS54bcirSuxlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244123"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:54 -0800
X-CSE-ConnectionGUID: 0V0WCP/bTk6Mu+hZN4ljlA==
X-CSE-MsgGUID: J08+0s8GRv2VKfEvj3ZOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144393993"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Sai Krishna <saikrishnag@marvell.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 06/14] iavf: add initial framework for registering PTP clock
Date: Fri, 14 Feb 2025 11:27:27 -0800
Message-ID: <20250214192739.1175740-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
References: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
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

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/iavf/Makefile      |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   6 +
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 122 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  14 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   8 ++
 7 files changed, 155 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 26b9938bc38d..1640d2f27833 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -264,6 +264,7 @@ config I40EVF
 	tristate "Intel(R) Ethernet Adaptive Virtual Function support"
 	select IAVF
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  This driver supports virtual functions for Intel XL710,
 	  X710, X722, XXV710, and all devices advertising support for
diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 356ac9faa5bf..e13720a728ff 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-y := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
 	  iavf_adv_rss.o iavf_txrx.o iavf_common.o iavf_adminq.o
+
+iavf-$(CONFIG_PTP_1588_CLOCK) += iavf_ptp.o
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index edb9679cbad4..8d652ab72e19 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4,6 +4,7 @@
 #include <linux/net/intel/libie/rx.h>
 
 #include "iavf.h"
+#include "iavf_ptp.h"
 #include "iavf_prototype.h"
 /* All iavf tracepoints are defined by the include below, which must
  * be included exactly once across the whole kernel with
@@ -2878,6 +2879,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	if (QOS_ALLOWED(adapter))
 		adapter->aq_required |= IAVF_FLAG_AQ_GET_QOS_CAPS;
 
+	/* Setup initial PTP configuration */
+	iavf_ptp_init(adapter);
+
 	iavf_schedule_finish_config(adapter);
 	return;
 
@@ -5681,6 +5685,8 @@ static void iavf_remove(struct pci_dev *pdev)
 		msleep(50);
 	}
 
+	iavf_ptp_release(adapter);
+
 	iavf_misc_irq_disable(adapter);
 	/* Shut down all the garbage mashers on the detention level */
 	cancel_work_sync(&adapter->reset_task);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
new file mode 100644
index 000000000000..5a1b5f8b87e5
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. */
+
+#include "iavf.h"
+#include "iavf_ptp.h"
+
+/**
+ * iavf_ptp_cap_supported - Check if a PTP capability is supported
+ * @adapter: private adapter structure
+ * @cap: the capability bitmask to check
+ *
+ * Return: true if every capability set in cap is also set in the enabled
+ *         capabilities reported by the PF, false otherwise.
+ */
+bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap)
+{
+	if (!IAVF_PTP_ALLOWED(adapter))
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
+ *
+ * Return: 0 if success, error otherwise.
+ */
+static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
+{
+	struct ptp_clock_info *ptp_info = &adapter->ptp.info;
+	struct device *dev = &adapter->pdev->dev;
+	struct ptp_clock *clock;
+
+	snprintf(ptp_info->name, sizeof(ptp_info->name), "%s-%s-clk",
+		 KBUILD_MODNAME, dev_name(dev));
+	ptp_info->owner = THIS_MODULE;
+
+	clock = ptp_clock_register(ptp_info, dev);
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
+	adapter->ptp.clock = clock;
+
+	dev_dbg(&adapter->pdev->dev, "PTP clock %s registered\n",
+		adapter->ptp.info.name);
+
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
+	int err;
+
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC)) {
+		pci_notice(adapter->pdev,
+			   "Device does not have PTP clock support\n");
+		return;
+	}
+
+	err = iavf_ptp_register_clock(adapter);
+	if (err) {
+		pci_err(adapter->pdev,
+			"Failed to register PTP clock device (%p)\n",
+			ERR_PTR(err));
+		return;
+	}
+
+	for (int i = 0; i < adapter->num_active_queues; i++) {
+		struct iavf_ring *rx_ring = &adapter->rx_rings[i];
+
+		rx_ring->ptp = &adapter->ptp;
+	}
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
+	if (!adapter->ptp.clock)
+		return;
+
+	pci_dbg(adapter->pdev, "removing PTP clock %s\n",
+		adapter->ptp.info.name);
+	ptp_clock_unregister(adapter->ptp.clock);
+	adapter->ptp.clock = NULL;
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
+	bool phc = iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC);
+
+	/* Check if the device gained or lost necessary access to support the
+	 * PTP hardware clock. If so, driver must respond appropriately by
+	 * creating or destroying the PTP clock device.
+	 */
+	if (adapter->ptp.clock && !phc)
+		iavf_ptp_release(adapter);
+	else if (!adapter->ptp.clock && phc)
+		iavf_ptp_init(adapter);
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 65678e76c34f..b63aea323f86 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -6,4 +6,18 @@
 
 #include "iavf_types.h"
 
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+void iavf_ptp_init(struct iavf_adapter *adapter);
+void iavf_ptp_release(struct iavf_adapter *adapter);
+void iavf_ptp_process_caps(struct iavf_adapter *adapter);
+bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap);
+#else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
+static inline void iavf_ptp_init(struct iavf_adapter *adapter) { }
+static inline void iavf_ptp_release(struct iavf_adapter *adapter) { }
+static inline void iavf_ptp_process_caps(struct iavf_adapter *adapter) { }
+static inline bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap)
+{
+	return false;
+}
+#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 15a05e30434d..c38b4ec2eaea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -297,6 +297,8 @@ struct iavf_ring {
 					 * for this ring.
 					 */
 
+	struct iavf_ptp *ptp;
+
 	u32 rx_buf_len;
 	struct net_shaper q_shaper;
 	bool q_shaper_update;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 65b0028bb968..d009171e5f8a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -4,6 +4,7 @@
 #include <linux/net/intel/libie/rx.h>
 
 #include "iavf.h"
+#include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
 /**
@@ -359,6 +360,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
 	u32 i, max_frame;
+	u8 rx_flags = 0;
 	size_t len;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
@@ -376,6 +378,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	if (!vqci)
 		return;
 
+	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))
+		rx_flags |= VIRTCHNL_PTP_RX_TSTAMP;
+
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
 	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
@@ -398,6 +403,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		if (CRC_OFFLOAD_ALLOWED(adapter))
 			vqpi->rxq.crc_disable = !!(adapter->netdev->features &
 						   NETIF_F_RXFCS);
+		vqpi->rxq.flags = rx_flags;
 		vqpi++;
 	}
 
@@ -2608,6 +2614,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		adapter->ptp.hw_caps = *(struct virtchnl_ptp_caps *)msg;
 
+		/* process any state change needed due to new capabilities */
+		iavf_ptp_process_caps(adapter);
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-- 
2.47.1


