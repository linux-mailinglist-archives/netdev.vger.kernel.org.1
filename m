Return-Path: <netdev+bounces-82512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE51288E6EC
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A76D1C2E711
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77F158D8A;
	Wed, 27 Mar 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nN/hlm/S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A31158A20
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546476; cv=none; b=cWSaea2+WekEWLid4kGpdSzVVSli9sBU8OeTDzB1DU0aDUmGIvepPoOo5dTADTg2s2KiVorUOMW3YRDVZElVM5Rgind81ctyfcbzDo0GaPb0hz03ZY7463O3X0EmIMhMSjyMbyHxzcG68VPGdWP4UvmLJRzgbK+PyFe2rPa2mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546476; c=relaxed/simple;
	bh=la+A9Hvmq7yXG15ZEcilIfFPuZeiaCuNX79k1p9FIOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGC3CAVntSD7XaWd+8ZHI8psYHu/YcEjXhqcZgX0bJm2n6SR7NT+LSgddoqdTw+M7yaA1iROOLWr6Y2t559Qr4Fgso6bLjwsjxrrUpm5TZ1QmzvEhpjx5RFABrM0EuI2Uw7o+DRORnxKYM39ygP2gRYSRYJD3diCp4Bjg3Gnw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nN/hlm/S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711546475; x=1743082475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=la+A9Hvmq7yXG15ZEcilIfFPuZeiaCuNX79k1p9FIOw=;
  b=nN/hlm/SC3VxRHCguAksgqZkSSbzZVwei2ZMpogg5e9MnI/P2hIPFSzq
   pKDW6tfG6CB5c4uMKfGeA18YjUm+R758W/+IE7X0TAMkMCYirPkgx8Y7r
   7oY6D47Jjw81pw/PKIPlQeja8MGIJhEaxxqeTGJi0gjRWTy0Ge0SmDsce
   8il61V08Zpbt5AwjG2iL8x4oplJco503ok4+nqH/Bb6qTI/pZk2W/LICu
   ro/QEZs7CRiwP8FCrAZAt7StZVsirCl6RhaXp1PYD3oPMe4iHRZcYcLbP
   ibr3lv9AL2GQrIyAj6EacsLMDscBHYARiME7r9DyN2+4YqUoygJGbrMS0
   g==;
X-CSE-ConnectionGUID: HxGEWY2KQ/GCnW9RbgEZ+w==
X-CSE-MsgGUID: bTDorhxFSOiWPQhSX6KqTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9608539"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="9608539"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16355741"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 06:34:31 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5D1A0284FA;
	Wed, 27 Mar 2024 13:34:29 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 11/12] iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
Date: Wed, 27 Mar 2024 09:25:42 -0400
Message-Id: <20240327132543.15923-12-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
References: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
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


