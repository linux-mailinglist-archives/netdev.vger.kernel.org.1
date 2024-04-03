Return-Path: <netdev+bounces-84507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E524897112
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB62DB25ABA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951E14AD03;
	Wed,  3 Apr 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeDUproh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E914A4E4
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150912; cv=none; b=Creh3avkr0pQIJc033SJRbaNA2eR7NJenX9R/KQPhOyL6aBUNzli97Fm4P9KfTsVJzexkwmbRO1LW/jJ7pZYo7wDVxhNluwzpRj3IO0rf1GzryZdQNH7tuWBAWJC9XVO2dV8vaXxbFXySsqgPDmK7Ud7rAlgdhbh/hfJK/KKrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150912; c=relaxed/simple;
	bh=la+A9Hvmq7yXG15ZEcilIfFPuZeiaCuNX79k1p9FIOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dekwRVTd2Uh/D5AewyLGwwN7m0BHeepBXXuvsxINRD8flsinkwxWg6srGyru/WAAE9kOv3b0K1zB6PJWY8a1PRhHG//2Bh6vjtYxMfdxobR1bd2ChmWJcTDa8lUr2KPu/BXzlTAIsqafETPTOgCeLIrjdwlzMflEw5j7Zn0GlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeDUproh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712150910; x=1743686910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=la+A9Hvmq7yXG15ZEcilIfFPuZeiaCuNX79k1p9FIOw=;
  b=KeDUproho/hmwdXvexnyU3OX1k5rYR/IqWlRKBzOpnf4TC8R37Fv3afb
   dliSZXLRGn1dFSbzH8pJ/nQfN8ceCDOX7B+rae1zOvwzwoa7YBcRmABEL
   s5Vgcisxn7lp0MLkO4L2x5coMgyesKtn5zbuesKVyT8/uOu9duz55Gx8W
   4xd2TzM8KJysN9JCmvl9xhy2cu5V+Y8lt2fFAVt2cCaQaaYKfsFJhpjEi
   eokKQsidZtMA2Xxpx5kag4NT6Pj40V2e1oCCzmEhVmI6MfQP2vXTR8AVv
   rZTHBbPgC+VQg2iKI5eqLmkM7FVpgYRoImDp3ZXLonrJCNEPuyRg3L4d0
   w==;
X-CSE-ConnectionGUID: 8dBboowoQ8GPOLo9evjdWQ==
X-CSE-MsgGUID: EXqHdqltS2i5it0d+CVHhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7568789"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7568789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:28:28 -0700
X-CSE-ConnectionGUID: jzOWqXKoRHqGFxc1hXGxTg==
X-CSE-MsgGUID: nl+r5IPtQyKotqyPS+i0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="41592125"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 03 Apr 2024 06:28:25 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DAF7E36C1C;
	Wed,  3 Apr 2024 14:28:21 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v3 11/12] iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
Date: Wed,  3 Apr 2024 09:19:26 -0400
Message-Id: <20240403131927.87021-12-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240403131927.87021-1-mateusz.polchlopek@intel.com>
References: <20240403131927.87021-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add handlers for the SIOCSHWTSTAMP and SIOCGHWTSTAMP ioctls which allow
userspace to request timestamp enablement for the device. This
support allows standard Linux applications to request the timestamping
desired.

As with other devices that support timestamping all packets, the driver
will upgrade any request for timestamping of a specific type of packet
to HWTSTAMP_FILTER_ALL.

The current configuration is stored, so that it can be retrieved by
SIOCGHWTSTAMP.

The Tx timestamps are not implemented yet so calling SIOCSHWTSTAMP for
Tx path will end with EOPNOTSUPP error code.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  25 ++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 135 ++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |   3 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |   1 +
 4 files changed, 164 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6b27065af357..a2fe2d124907 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4925,6 +4925,30 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 	return iavf_fix_strip_features(adapter, features);
 }
 
+/**
+ * iavf_do_ioctl - Handle network device specific ioctls
+ * @netdev: network interface device structure
+ * @ifr: interface request data
+ * @cmd: ioctl command
+ *
+ * Callback to handle the networking device specific ioctls. Used to handle
+ * the SIOCGHWTSTAMP and SIOCSHWTSTAMP ioctl requests that configure Tx and Rx
+ * timstamping support.
+ */
+static int iavf_do_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	switch (cmd) {
+	case SIOCGHWTSTAMP:
+		return iavf_ptp_get_ts_config(adapter, ifr);
+	case SIOCSHWTSTAMP:
+		return iavf_ptp_set_ts_config(adapter, ifr);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
@@ -4940,6 +4964,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_fix_features	= iavf_fix_features,
 	.ndo_set_features	= iavf_set_features,
 	.ndo_setup_tc		= iavf_setup_tc,
+	.ndo_eth_ioctl		= iavf_do_ioctl,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index f1f4c260e08f..0e5cae23f9be 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -3,6 +3,135 @@
 
 #include "iavf.h"
 
+/**
+ * iavf_ptp_disable_rx_tstamp - Disable timestamping in Rx rings
+ * @adapter: private adapter structure
+ *
+ * Disable timestamp reporting for all Rx rings.
+ */
+static void iavf_ptp_disable_rx_tstamp(struct iavf_adapter *adapter)
+{
+	unsigned int i;
+
+	for (i = 0; i < adapter->num_active_queues; i++)
+		adapter->rx_rings[i].flags &= ~IAVF_TXRX_FLAGS_HW_TSTAMP;
+}
+
+/**
+ * iavf_ptp_enable_rx_tstamp - Enable timestamping in Rx rings
+ * @adapter: private adapter structure
+ *
+ * Enable timestamp reporting for all Rx rings.
+ */
+static void iavf_ptp_enable_rx_tstamp(struct iavf_adapter *adapter)
+{
+	unsigned int i;
+
+	for (i = 0; i < adapter->num_active_queues; i++)
+		adapter->rx_rings[i].flags |= IAVF_TXRX_FLAGS_HW_TSTAMP;
+}
+
+/**
+ * iavf_ptp_set_timestamp_mode - Set device timestamping mode
+ * @adapter: private adapter structure
+ * @config: timestamping configuration request
+ *
+ * Set the timestamping mode requested from the SIOCSHWTSTAMP ioctl.
+ *
+ * Note: this function always translates Rx timestamp requests for any packet
+ * category into HWTSTAMP_FILTER_ALL.
+ */
+static int iavf_ptp_set_timestamp_mode(struct iavf_adapter *adapter,
+				       struct hwtstamp_config *config)
+{
+	/* Reserved for future extensions. */
+	if (config->flags)
+		return -EINVAL;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+	case HWTSTAMP_TX_ON:
+		return -EOPNOTSUPP;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		iavf_ptp_disable_rx_tstamp(adapter);
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_ALL:
+		if (!(iavf_ptp_cap_supported(adapter,
+					     VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)))
+			return -EOPNOTSUPP;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		iavf_ptp_enable_rx_tstamp(adapter);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/**
+ * iavf_ptp_get_ts_config - Get timestamping configuration for SIOCGHWTSTAMP
+ * @adapter: private adapter structure
+ * @ifr: the ioctl request structure
+ *
+ * Copy the current hardware timestamping configuration back to userspace.
+ * Called in response to the SIOCGHWTSTAMP ioctl that queries a device's
+ * current timestamp settings.
+ */
+int iavf_ptp_get_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr)
+{
+	struct hwtstamp_config *config = &adapter->ptp.hwtstamp_config;
+
+	return copy_to_user(ifr->ifr_data, config,
+			    sizeof(*config)) ? -EFAULT : 0;
+}
+
+/**
+ * iavf_ptp_set_ts_config - Set timestamping configuration from SIOCSHWTSTAMP
+ * @adapter: private adapter structure
+ * @ifr: the ioctl request structure
+ *
+ * Program the requested timestamping configuration from SIOCSHWTSTAMP ioctl
+ * to the device.
+ */
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr)
+{
+	struct hwtstamp_config config;
+	int err;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	err = iavf_ptp_set_timestamp_mode(adapter, &config);
+	if (err)
+		return err;
+
+	/* Save successful settings for future reference */
+	adapter->ptp.hwtstamp_config = config;
+
+	return copy_to_user(ifr->ifr_data, &config,
+			    sizeof(config)) ? -EFAULT : 0;
+}
+
 /**
  * clock_to_adapter - Convert clock info pointer to adapter pointer
  * @ptp_info: PTP info structure
@@ -325,4 +454,10 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
 	else if (!adapter->ptp.initialized &&
 		 iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC))
 		iavf_ptp_init(adapter);
+
+	/* Check if the device lost access to Rx timestamp incoming packets */
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		iavf_ptp_disable_rx_tstamp(adapter);
+	}
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 7a25647980f3..337bf184a7ea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -21,6 +21,7 @@ struct iavf_ptp {
 	struct list_head aq_cmds;
 	/* Lock protecting access to the AQ command list */
 	spinlock_t aq_cmd_lock;
+	struct hwtstamp_config hwtstamp_config;
 	u64 cached_phc_time;
 	unsigned long cached_phc_updated;
 	bool initialized;
@@ -35,5 +36,7 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap);
 void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
 long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp);
+int iavf_ptp_get_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr);
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr);
 
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 54d858303839..f77407030566 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -358,6 +358,7 @@ struct iavf_ring {
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
 #define IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2	BIT(5)
+#define IAVF_TXRX_FLAGS_HW_TSTAMP		BIT(6)
 
 	/* stats structs */
 	struct iavf_queue_stats	stats;
-- 
2.38.1


