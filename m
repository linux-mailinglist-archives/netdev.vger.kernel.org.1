Return-Path: <netdev+bounces-82024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D088C17F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9171F633B6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013076F08E;
	Tue, 26 Mar 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbFrEOIk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254771753
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454451; cv=none; b=VAjETy1+VhD2CsJWsxbKgFBArE3mALLojAciFOho5u7vqEVBMK5HZoRDNUtigHO4+Jfw3m7Rd6ifVIjGhQXGXcNmgfbogxU9JVeEEpAfCOkLBuL8By0cJrT///CDG7DrHsppI4SBKg7WJuQD+uqCan7Uc6wLO0NeeN1Kig+8GOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454451; c=relaxed/simple;
	bh=XxoqYKVsb5QCY/9gm+DejYOZ5y8qDmIJQpBISmQK8/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlCynTzbJVLtLUWWgtim/kB6spOW0Kwdq/aNeNn6PP82LtLxMTJ3NOiZ6J7bVWV8lhXZQJziQgAphw5B1tp72uEzLslmhnTfcJZYhziQ2DBWbC1FXlWBmcRIHgl6uULS70LIC2QaNwNmwVKKWS42NSQAwRrGYX6vVzVi26vEN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbFrEOIk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711454450; x=1742990450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxoqYKVsb5QCY/9gm+DejYOZ5y8qDmIJQpBISmQK8/8=;
  b=WbFrEOIkKUYRJurNT6RI5f2nO8CJTojfW6azoXjHctASyaJh8N4FS2h5
   lWqh4JSgi6qEi356CAnf1xizNm5gmFxI8QuhaMG7WylHCxG8UBXzpO1iF
   6G6bZU0KPjMxQ3bSRAmNaub6mwWJ5wtnyG05Rdffl7CF8XN/KswyvwMmG
   bup2orTUdXhKCCGW0xw2nsO3tgabB/GZo8ssHI0uKsfduB3lazKDPCPCr
   6z5KHAIuoku+z1CXpsRjHdT0Q+R1k95iMvxYQCm/5S+Tu5lmiGPdeTK18
   qPHElZB56tjTUU5omu8mBBQFeBu0kIpqZTULvy0eo/YM0Sd2vFD70+zCR
   A==;
X-CSE-ConnectionGUID: gqlhSD7URrewlWK5ZGpUxQ==
X-CSE-MsgGUID: oHE9Btz9Ttmimkxaya6MDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6366383"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6366383"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20657421"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 05:00:47 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AC7C628197;
	Tue, 26 Mar 2024 12:00:46 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 12/12] iavf: add support for Rx timestamps to hotpath
Date: Tue, 26 Mar 2024 07:51:17 -0400
Message-Id: <20240326115116.10040-13-mateusz.polchlopek@intel.com>
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

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  9 +++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 67 +++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |  4 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 44 ++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a2fe2d124907..26c170ae1f14 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -726,6 +726,15 @@ static u8 iavf_select_rx_desc_format(struct iavf_adapter *adapter)
 	if (!RXDID_ALLOWED(adapter))
 		return VIRTCHNL_RXDID_1_32B_BASE;
 
+	/* Rx timestamping requires the use of flexible NIC descriptors */
+	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		if (supported_rxdids & BIT(VIRTCHNL_RXDID_2_FLEX_SQ_NIC))
+			return VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
+
+		dev_dbg(&adapter->pdev->dev,
+			"Unable to negotiate flexible descriptor format.\n");
+	}
+
 	/* Warn if the PF does not list support for the default legacy
 	 * descriptor format. This shouldn't happen, as this is the format
 	 * used if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is not supported. It is
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 0e5cae23f9be..f422ce4cc3fc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -428,6 +428,9 @@ void iavf_ptp_release(struct iavf_adapter *adapter)
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
 	spin_unlock(&adapter->ptp.aq_cmd_lock);
 
+	adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	iavf_ptp_disable_rx_tstamp(adapter);
+
 	adapter->ptp.initialized = false;
 }
 
@@ -461,3 +464,67 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
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
+ */
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp)
+{
+	const u64 mask = GENMASK_ULL(31, 0);
+	u32 delta;
+	u64 ns;
+
+	/* Calculate the delta between the lower 32bits of the cached PHC
+	 * time and the in_tstamp value
+	 */
+	delta = (in_tstamp - (u32)(cached_phc_time & mask));
+
+	/* Do not assume that the in_tstamp is always more recent than the
+	 * cached PHC time. If the delta is large, it indicates that the
+	 * in_tstamp was taken in the past, and should be converted
+	 * forward.
+	 */
+	if (delta > (mask / 2)) {
+		/* reverse the delta calculation here */
+		delta = ((u32)(cached_phc_time & mask) - in_tstamp);
+		ns = cached_phc_time - delta;
+	} else {
+		ns = cached_phc_time + delta;
+	}
+
+	return ns;
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 337bf184a7ea..66e113ae27f5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -6,6 +6,9 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+/* bit indicating whether a 40bit timestamp is valid */
+#define IAVF_PTP_40B_TSTAMP_VALID	BIT(0)
+
 /* structure used to queue PTP commands for processing */
 struct iavf_ptp_aq_cmd {
 	struct list_head list;
@@ -38,5 +41,6 @@ void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
 long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp);
 int iavf_ptp_get_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr);
 int iavf_ptp_set_ts_config(struct iavf_adapter *adapter, struct ifreq *ifr);
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp);
 
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 4762126c77db..52d35b27c947 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1237,6 +1237,48 @@ static inline void iavf_flex_rx_hash(struct iavf_ring *ring,
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
+static void iavf_flex_rx_tstamp(struct iavf_ring *rx_ring,
+				union iavf_rx_desc *rx_desc,
+				struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps *skb_tstamps;
+	struct iavf_adapter *adapter;
+	u32 tstamp;
+	u64 ns;
+
+	/* Skip processing if timestamps aren't enabled */
+	if (!(rx_ring->flags & IAVF_TXRX_FLAGS_HW_TSTAMP))
+		return;
+
+	/* Check if this Rx descriptor has a valid timestamp */
+	if (!(rx_desc->flex_wb.ts_low & IAVF_PTP_40B_TSTAMP_VALID))
+		return;
+
+	adapter = netdev_priv(rx_ring->netdev);
+
+	/* the ts_low field only contains the valid bit and sub-nanosecond
+	 * precision, so we don't need to extract it.
+	 */
+	tstamp = le32_to_cpu(rx_desc->flex_wb.flex_ts.ts_high);
+	ns = iavf_ptp_extend_32b_timestamp(adapter->ptp.cached_phc_time,
+					   tstamp);
+
+	skb_tstamps = skb_hwtstamps(skb);
+	memset(skb_tstamps, 0, sizeof(*skb_tstamps));
+	skb_tstamps->hwtstamp = ns_to_ktime(ns);
+}
+
 /**
  * iavf_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
@@ -1260,6 +1302,8 @@ static void iavf_process_skb_fields(struct iavf_ring *rx_ring,
 		iavf_flex_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
 
 		iavf_flex_rx_csum(rx_ring->vsi, skb, rx_desc);
+
+		iavf_flex_rx_tstamp(rx_ring, rx_desc, skb);
 	}
 
 	skb_record_rx_queue(skb, rx_ring->queue_index);
-- 
2.38.1


