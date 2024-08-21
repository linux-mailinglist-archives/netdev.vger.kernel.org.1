Return-Path: <netdev+bounces-120546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF07959BA4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF073B23325
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B9188010;
	Wed, 21 Aug 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrHNGwFd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365119259F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242723; cv=none; b=lpsY+ijxvO2xvrXFfVUIj8kFrdW1SAqxfcSP4Cj/02XMgLymnvO8flNADfzlsPtWs4af/qpJpEpZXWFXKNBVpQrPeljOpPIm2jAELzwSYEGr4/7Sn/2T/r9bg0WWO3+SZG/4hoqWwY/K8dIVPYu/qImg32MU0sOiqhFKYkDOWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242723; c=relaxed/simple;
	bh=36sNNwmzpCLTuZWLDoeyo8v3mkYOXualO3dM1iSAZMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cI4ajp2u2CDFyOGBgxk8rRnYkGYlC9PjTw/ziegIygizfNKMRxYN36ia8Ts2M1VIVWcx8o/jXmz4PZ8mOdEw5i5iYMjfAJzU8fuejs+K0kgVGEi9FMuL877CyaznNo8BlOZYcP8HWbQ13IxGWs5PeD2gdI76GSRdFKaNGnkSCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrHNGwFd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242722; x=1755778722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36sNNwmzpCLTuZWLDoeyo8v3mkYOXualO3dM1iSAZMs=;
  b=MrHNGwFdp1UGqLT+x8R6PYI4d8tE4xK/UYicIRsoJ8nfoiELtsgG8QRh
   L5sxX5vuoCr6G6grMPRw734thC3lnlhc8XV9W5rAsOqSGXLGIGQ6yUA+H
   M2nvTA9Nsx7IzbeoDDV/+qrFMB6i0rVtkv4DUOiF80PGETUSwo23ZUGVD
   VAeC66VUXmLoV861opgMQr1NiLPZoPzstf+4lrLoOwz6yOpggWuHb9LGU
   sY+fnXvJEdP7XTiHq78psgz3C2lO4FUod+pGx80zcVfK17I+i/jcun6Xj
   Xtt8v2fWPRruD0iFEnqDxgHbtcjjrbZA7qtit3V1bhxeJ9X98pIBFIi+Z
   A==;
X-CSE-ConnectionGUID: Nelp7g/WQ3+75GPvYbd/jQ==
X-CSE-MsgGUID: lCSj3yaBSvGQf00W6IsgJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34017143"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34017143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:18:24 -0700
X-CSE-ConnectionGUID: Mr+OszokTke6L0fp1Y0rDA==
X-CSE-MsgGUID: 67xb74uJSTOcbmxHhsJyUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60732517"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2024 05:18:22 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1BDD228789;
	Wed, 21 Aug 2024 13:18:21 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	alexandr.lobakin@intel.com
Subject: [PATCH iwl-next v10 14/14] iavf: add support for Rx timestamps to hotpath
Date: Wed, 21 Aug 2024 14:15:39 +0200
Message-Id: <20240821121539.374343-15-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240821121539.374343-1-wojciech.drewek@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add support for receive timestamps to the Rx hotpath. This support only
works when using the flexible descriptor format, so make sure that we
request this format by default if we have receive timestamp support
available in the PTP capabilities.

In order to report the timestamps to userspace, we need to perform
timestamp extension. The Rx descriptor does actually contain the "40
bit" timestamp. However, upper 32 bits which contain nanoseconds are
conveniently stored separately in the descriptor. We could extract the
32bits and lower 8 bits, then perform a bitwise OR to calculate the
40bit value. This makes no sense, because the timestamp extension
algorithm would simply discard the lower 8 bits anyways.

Thus, implement timestamp extension as iavf_ptp_extend_32b_timestamp(),
and extract and forward only the 32bits of nominal nanoseconds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 11 +++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 61 +++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |  4 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 45 +++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_type.h |  1 +
 5 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 1458410ca560..ebc01a8d1ac6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -730,6 +730,15 @@ static u8 iavf_select_rx_desc_format(const struct iavf_adapter *adapter)
 	if (!IAVF_RXDID_ALLOWED(adapter))
 		return VIRTCHNL_RXDID_1_32B_BASE;
 
+	/* Rx timestamping requires the use of flexible NIC descriptors */
+	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		if (rxdids & BIT(VIRTCHNL_RXDID_2_FLEX_SQ_NIC))
+			return VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
+
+		pci_warn(adapter->pdev,
+			 "Unable to negotiate flexible descriptor format\n");
+	}
+
 	/* Warn if the PF does not list support for the default legacy
 	 * descriptor format. This shouldn't happen, as this is the format
 	 * used if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is not supported. It is
@@ -737,7 +746,7 @@ static u8 iavf_select_rx_desc_format(const struct iavf_adapter *adapter)
 	 * support for the format.
 	 */
 	if (!(rxdids & VIRTCHNL_RXDID_1_32B_BASE_M))
-		dev_warn(&adapter->pdev->dev, "PF does not list support for default Rx descriptor format\n");
+		pci_warn(adapter->pdev, "PF does not list support for default Rx descriptor format\n");
 
 	return VIRTCHNL_RXDID_1_32B_BASE;
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 2ebc65535679..57b5e0949227 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -387,6 +387,9 @@ void iavf_ptp_release(struct iavf_adapter *adapter)
 	}
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
 	mutex_unlock(&adapter->ptp.aq_cmd_lock);
+
+	adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	iavf_ptp_disable_rx_tstamp(adapter);
 }
 
 /**
@@ -416,3 +419,61 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
 		iavf_ptp_disable_rx_tstamp(adapter);
 	}
 }
+
+/**
+ * iavf_ptp_extend_32b_timestamp - Convert a 32b nanoseconds timestamp to 64b
+ * nanoseconds
+ * @cached_phc_time: recently cached copy of PHC time
+ * @in_tstamp: Ingress/egress 32b nanoseconds timestamp value
+ *
+ * Hardware captures timestamps which contain only 32 bits of nominal
+ * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
+ *
+ * Extend the 32bit nanosecond timestamp using the following algorithm and
+ * assumptions:
+ *
+ * 1) have a recently cached copy of the PHC time
+ * 2) assume that the in_tstamp was captured 2^31 nanoseconds (~2.1
+ *    seconds) before or after the PHC time was captured.
+ * 3) calculate the delta between the cached time and the timestamp
+ * 4) if the delta is smaller than 2^31 nanoseconds, then the timestamp was
+ *    captured after the PHC time. In this case, the full timestamp is just
+ *    the cached PHC time plus the delta.
+ * 5) otherwise, if the delta is larger than 2^31 nanoseconds, then the
+ *    timestamp was captured *before* the PHC time, i.e. because the PHC
+ *    cache was updated after the timestamp was captured by hardware. In this
+ *    case, the full timestamp is the cached time minus the inverse delta.
+ *
+ * This algorithm works even if the PHC time was updated after a Tx timestamp
+ * was requested, but before the Tx timestamp event was reported from
+ * hardware.
+ *
+ * This calculation primarily relies on keeping the cached PHC time up to
+ * date. If the timestamp was captured more than 2^31 nanoseconds after the
+ * PHC time, it is possible that the lower 32bits of PHC time have
+ * overflowed more than once, and we might generate an incorrect timestamp.
+ *
+ * This is prevented by (a) periodically updating the cached PHC time once
+ * a second, and (b) discarding any Tx timestamp packet if it has waited for
+ * a timestamp for more than one second.
+ *
+ * Return: extended timestamp (to 64b).
+ */
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp)
+{
+	u32 low = lower_32_bits(cached_phc_time);
+	u32 delta = in_tstamp - low;
+	u64 ns;
+
+	/* Do not assume that the in_tstamp is always more recent than the
+	 * cached PHC time. If the delta is large, it indicates that the
+	 * in_tstamp was taken in the past, and should be converted
+	 * forward.
+	 */
+	if (delta > S32_MAX)
+		ns = cached_phc_time - (low - in_tstamp);
+	else
+		ns = cached_phc_time + delta;
+
+	return ns;
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 3b67a4624eee..2c4f25ef5af0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -9,6 +9,9 @@
 #define iavf_clock_to_adapter(info)				\
 	container_of_const(info, struct iavf_adapter, ptp.info)
 
+/* bit indicating whether a 40bit timestamp is valid */
+#define IAVF_PTP_40B_TSTAMP_VALID	BIT(24)
+
 void iavf_ptp_init(struct iavf_adapter *adapter);
 void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
@@ -18,5 +21,6 @@ long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp);
 int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
 			   struct kernel_hwtstamp_config *config,
 			   struct netlink_ext_ack *extack);
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp);
 
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 8f529cfaf7a8..b2ed20622bbc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -8,6 +8,7 @@
 #include "iavf.h"
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
+#include "iavf_ptp.h"
 
 /**
  * iavf_is_descriptor_done - tests DD bit in Rx descriptor
@@ -1085,6 +1086,49 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring,
 	}
 }
 
+/**
+ * iavf_flex_rx_tstamp - Capture Rx timestamp from the descriptor
+ * @rx_ring: descriptor ring
+ * @rx_desc: specific descriptor
+ * @skb: skb currently being received
+ *
+ * Read the Rx timestamp value from the descriptor and pass it to the stack.
+ *
+ * This function only operates on the VIRTCHNL_RXDID_2_FLEX_SQ_NIC flexible
+ * descriptor writeback format.
+ */
+static void iavf_flex_rx_tstamp(const struct iavf_ring *rx_ring,
+				const struct iavf_rx_desc *rx_desc,
+				struct sk_buff *skb)
+{
+	struct iavf_adapter *adapter;
+	__le64 qw2 = rx_desc->qw2;
+	__le64 qw3 = rx_desc->qw3;
+	u32 tstamp;
+	u64 ns;
+
+	/* Skip processing if timestamps aren't enabled */
+	if (!(rx_ring->flags & IAVF_TXRX_FLAGS_HW_TSTAMP))
+		return;
+
+	/* Check if this Rx descriptor has a valid timestamp */
+	if (!le64_get_bits(qw2, IAVF_PTP_40B_TSTAMP_VALID))
+		return;
+
+	/* the ts_low field only contains the valid bit and sub-nanosecond
+	 * precision, so we don't need to extract it.
+	 */
+	tstamp = le64_get_bits(qw3, IAVF_RXD_FLEX_QW3_TSTAMP_HIGH_M);
+
+	adapter = netdev_priv(rx_ring->netdev);
+	ns = iavf_ptp_extend_32b_timestamp(adapter->ptp.cached_phc_time,
+					   tstamp);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ns),
+	};
+}
+
 /**
  * iavf_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
@@ -1110,6 +1154,7 @@ static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 		csum_bits = iavf_legacy_rx_csum(rx_ring->vsi, rx_desc, decoded);
 	} else {
 		iavf_flex_rx_hash(rx_ring, rx_desc, skb, decoded);
+		iavf_flex_rx_tstamp(rx_ring, rx_desc, skb);
 		csum_bits = iavf_flex_rx_csum(rx_ring->vsi, rx_desc, decoded);
 	}
 	iavf_rx_csum(rx_ring->vsi, skb, decoded, csum_bits);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 7c94e4c7f544..ab0e0e40ed5a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -323,6 +323,7 @@ struct iavf_rx_desc {
 #define IAVF_RXD_FLEX_XTRMD5_VALID_M		BIT(15)
 
 	aligned_le64 qw3;
+#define IAVF_RXD_FLEX_QW3_TSTAMP_HIGH_M		GENMASK_ULL(63, 32)
 } __aligned(4 * sizeof(__le64));
 
 #define IAVF_RXD_QW1_STATUS_TSYNINDX_SHIFT IAVF_RX_DESC_STATUS_TSYNINDX_SHIFT
-- 
2.40.1


