Return-Path: <netdev+bounces-137732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E029A98C5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125AC283108
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74D1487E5;
	Tue, 22 Oct 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kld+mbf/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECF146A71
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575684; cv=none; b=jt3AK2mFYlihSoGzqWGCrbQgO0TuTmvzPPUeop3wVSFcViL2VZ6AhzDROW1YKi5donYh32uDTi276D+iFI4BN365gXUSrZpXepp8FFFvCTvKg9FIBM9HMxbHXXpBTIDOyra7/AHJt9W5hJLD5Atyqf/EVYWECIykRLZjNybSkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575684; c=relaxed/simple;
	bh=xTcAzn3h5yqJZ//gDEkILyNj27zcOsnDqbtvrZuqYck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLw6DVJXN6OaO/2xDWVApgfmE/ewI1t0tGE7/ylPtLGGo/c7w2ylJe6LTEagU9B79NCrGKNr3aUmZ6quUN8gNNobCpumAh9aaIcEnyuEYPN/0ZgldQ9hbuq45sQdytwPeP1VUpKSk517XrzkNQiSSJEGFZwffwX328STZKku4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kld+mbf/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575682; x=1761111682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTcAzn3h5yqJZ//gDEkILyNj27zcOsnDqbtvrZuqYck=;
  b=Kld+mbf/mSv3+7pabo03XA2lNpKiV0EfNSEw34woMgCjoS5Kp0VQA8Xg
   apUuIvbKWcHOg3pgWWFXfaCqrbSuQJ9f1QG7uD9LBpKemotFAgBtPFYEn
   rtZDDQ68cXm4v0C3cGzmj3tJmNKszU5Bh6vYEQocPcPe/h44g/X0/nRjB
   E/2PgJZVY6rfuuND7GSpQQBePDyTrw262Zp5tQCgEditVnqtl3nlWx8b9
   YEODpZqRITHUXmwy4pbwsq/Ca6OiFP2E0mhpkc555TUGNkPT6ffNHM2m+
   94JV7NjAovcVggK/mKGdCujsY6slrODi+nFXkywNnuHzBmp0Da9ceZbwI
   Q==;
X-CSE-ConnectionGUID: 2If3geFXTz6n9b9eRSkOxA==
X-CSE-MsgGUID: NKEeLX13ToC5yf8Sa01OCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015636"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015636"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:41:21 -0700
X-CSE-ConnectionGUID: tpAEXIl+SoCP++g5SNr/Hw==
X-CSE-MsgGUID: q0zUvbYoQt2cPAVzDmQ+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84558128"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 22:41:17 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A185727BCA;
	Tue, 22 Oct 2024 06:41:16 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v12 13/14] iavf: handle set and get timestamps ops
Date: Tue, 22 Oct 2024 07:41:20 -0400
Message-Id: <20241022114121.61284-14-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which
allow userspace to request timestamp enablement for the device. This
support allows standard Linux applications to request the timestamping
desired.

As with other devices that support timestamping all packets, the driver
will upgrade any request for timestamping of a specific type of packet
to HWTSTAMP_FILTER_ALL.

The current configuration is stored, so that it can be retrieved by
calling .ndo_hwtstamp_get

The Tx timestamps are not implemented yet so calling set ops for
Tx path will end with EOPNOTSUPP error code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  21 ++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 100 ++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |   9 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |   1 +
 4 files changed, 131 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b897dd94a32e..1103c210b4e3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5137,6 +5137,25 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 	return iavf_fix_strip_features(adapter, features);
 }
 
+static int iavf_hwstamp_get(struct net_device *netdev,
+			    struct kernel_hwtstamp_config *config)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	*config = adapter->ptp.hwtstamp_config;
+
+	return 0;
+}
+
+static int iavf_hwstamp_set(struct net_device *netdev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	return iavf_ptp_set_ts_config(adapter, config, extack);
+}
+
 static int
 iavf_verify_shaper(struct net_shaper_binding *binding,
 		   const struct net_shaper *shaper,
@@ -5245,6 +5264,8 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_set_features	= iavf_set_features,
 	.ndo_setup_tc		= iavf_setup_tc,
 	.net_shaper_ops		= &iavf_shaper_ops,
+	.ndo_hwtstamp_get	= iavf_hwstamp_get,
+	.ndo_hwtstamp_set	= iavf_hwstamp_set,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index c2e0d27552b0..4246ddfa6f0d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -7,6 +7,100 @@
 #define iavf_clock_to_adapter(info)				\
 	container_of_const(info, struct iavf_adapter, ptp.info)
 
+/**
+ * iavf_ptp_disable_rx_tstamp - Disable timestamping in Rx rings
+ * @adapter: private adapter structure
+ *
+ * Disable timestamp reporting for all Rx rings.
+ */
+static void iavf_ptp_disable_rx_tstamp(struct iavf_adapter *adapter)
+{
+	for (u32 i = 0; i < adapter->num_active_queues; i++)
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
+	for (u32 i = 0; i < adapter->num_active_queues; i++)
+		adapter->rx_rings[i].flags |= IAVF_TXRX_FLAGS_HW_TSTAMP;
+}
+
+/**
+ * iavf_ptp_set_timestamp_mode - Set device timestamping mode
+ * @adapter: private adapter structure
+ * @config: pointer to kernel_hwtstamp_config
+ *
+ * Set the timestamping mode requested from the userspace.
+ *
+ * Note: this function always translates Rx timestamp requests for any packet
+ * category into HWTSTAMP_FILTER_ALL.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int iavf_ptp_set_timestamp_mode(struct iavf_adapter *adapter,
+				       struct kernel_hwtstamp_config *config)
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
+	if (config->rx_filter == HWTSTAMP_FILTER_NONE) {
+		iavf_ptp_disable_rx_tstamp(adapter);
+		return 0;
+	} else if (config->rx_filter > HWTSTAMP_FILTER_NTP_ALL) {
+		return -ERANGE;
+	} else if (!(iavf_ptp_cap_supported(adapter,
+					    VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))) {
+		return -EOPNOTSUPP;
+	}
+
+	config->rx_filter = HWTSTAMP_FILTER_ALL;
+	iavf_ptp_enable_rx_tstamp(adapter);
+
+	return 0;
+}
+
+/**
+ * iavf_ptp_set_ts_config - Set timestamping configuration
+ * @adapter: private adapter structure
+ * @config: pointer to kernel_hwtstamp_config structure
+ * @extack: pointer to netlink_ext_ack structure
+ *
+ * Program the requested timestamping configuration to the device.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = iavf_ptp_set_timestamp_mode(adapter, config);
+	if (err)
+		return err;
+
+	/* Save successful settings for future reference */
+	adapter->ptp.hwtstamp_config = *config;
+
+	return 0;
+}
+
 /**
  * iavf_ptp_cap_supported - Check if a PTP capability is supported
  * @adapter: private adapter structure
@@ -321,4 +415,10 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
 		iavf_ptp_release(adapter);
 	else if (!adapter->ptp.clock && phc)
 		iavf_ptp_init(adapter);
+
+	/* Check if the device lost access to Rx timestamp incoming packets */
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		iavf_ptp_disable_rx_tstamp(adapter);
+	}
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 8e2f1ed18b86..0801e3ff5a59 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -12,6 +12,9 @@ void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap);
 void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline void iavf_ptp_init(struct iavf_adapter *adapter) { }
 static inline void iavf_ptp_release(struct iavf_adapter *adapter) { }
@@ -23,5 +26,11 @@ static inline bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter,
 }
 
 static inline void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter) { }
+static inline int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+					 struct kernel_hwtstamp_config *config,
+					 struct netlink_ext_ack *extack)
+{
+	return -1;
+}
 #endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index dff5c8cd27ab..79ad554f2d53 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -252,6 +252,7 @@ struct iavf_ring {
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
 #define IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2	BIT(5)
+#define IAVF_TXRX_FLAGS_HW_TSTAMP		BIT(6)
 
 	/* stats structs */
 	struct iavf_queue_stats	stats;
-- 
2.38.1


