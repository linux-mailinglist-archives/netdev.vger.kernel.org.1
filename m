Return-Path: <netdev+bounces-98503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D318D19A8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611B7B21687
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C116C6AC;
	Tue, 28 May 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sj4ttKyd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD313AA3E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896056; cv=none; b=KUAyVyFjk5uaeclGFnWGygvVzMJStkpVJzIIT9xDghvgCYBI7eR2nOfZXSf0xdGzi5gc2Amr3RO0bWql098Sd6XKajL2+tKYzxMHKYgTMnJivjIV68xzFLY+YnfdlFnrFZISXak7DIM4nnzBnRpFcw4YRHaDvsrVmhr+CjJZHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896056; c=relaxed/simple;
	bh=cybhhclj7qHxFAALsdj/ZqjaHgjusVXs/VMFf9OY3wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQ9kKlYp9sjDR0XZ6ckEWLnQ6p26BttRA9VUBeZYcKliWtLf+YmoPHqJeHWO2qlu9GVG/a87Mn4SoGQH9numdTZ1aQHpEW524v/6qC4GJjY075A21h4jfSZQw3H813Y2PsxYMhW2R78v7koqLjp+6ZGROb79xodjjknDhGt8jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sj4ttKyd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716896054; x=1748432054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cybhhclj7qHxFAALsdj/ZqjaHgjusVXs/VMFf9OY3wA=;
  b=Sj4ttKydV4aVZJTKLGyWWVLTkPwssmezO1wiA8NwERqgm0aLmanNdkvx
   De6HNCOLe7MQtbPND7FW5GALnPL60+EoKVcBCx50OUN3QQFPaJN1Y+Py6
   awYb/yopnBgBjtzoxqL5BjUXDP6USNWgTTIOuZjSUyNIz3o1I7SH5bcJw
   hHy6nkMaQk69Q1Zp6ZwQ4Z4h267VMXGZEJHhIOpoFs0sWDEv4OJ6OuNLx
   5JzwAFrMn8AiYUdpfdWimfZysVdsYPHnFJtkSZgPh8sn/38nzm6PxRhtc
   Rw36h9x2qov4epIoxR8trHBYjS/d+7PkP5ViIzQ2Mps01cuMrCM1TcKN4
   Q==;
X-CSE-ConnectionGUID: AJgXpCPmR0i+UBNGt8ipfg==
X-CSE-MsgGUID: JOQeJeDtSLyUUHASSP9R0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30757442"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="30757442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:34:07 -0700
X-CSE-ConnectionGUID: uVPE8TMPQOemtPJ2YSb8Xg==
X-CSE-MsgGUID: L68X0rmoTG63w7HOLmUJgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35126741"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 04:34:04 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5B40327BBA;
	Tue, 28 May 2024 12:34:03 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 11/12] iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
Date: Tue, 28 May 2024 07:23:00 -0400
Message-Id: <20240528112301.5374-12-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
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

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  28 ++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 141 ++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |   3 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |   1 +
 4 files changed, 173 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3b1f177068c9..f403d27fb7ee 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4930,6 +4930,33 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
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
+ *
+ * Return: call to functions iavf_ptp_get_ts_config/iavf_ptp_set_ts_config or
+ *         -EOPNOTSUPP if wrong ioctl command passed
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
@@ -4945,6 +4972,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_fix_features	= iavf_fix_features,
 	.ndo_set_features	= iavf_set_features,
 	.ndo_setup_tc		= iavf_setup_tc,
+	.ndo_eth_ioctl		= iavf_do_ioctl,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 69e4948a9057..8882a7b83a2a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -3,6 +3,141 @@
 
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
+ *
+ * Return: 0 if success, error code otherwise
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
+ *
+ * Return: 0 if success, -EFAULT otherwise
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
+ *
+ * Return: 0 if success, -EFAULT otherwise
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
@@ -335,4 +470,10 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
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
index 3add31924d75..0379f94acb56 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -262,6 +262,7 @@ struct iavf_ring {
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
 #define IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2	BIT(5)
+#define IAVF_TXRX_FLAGS_HW_TSTAMP		BIT(6)
 
 	/* stats structs */
 	struct iavf_queue_stats	stats;
-- 
2.38.1


