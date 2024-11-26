Return-Path: <netdev+bounces-147408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E19D96B4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A09167CAB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722841CEEAE;
	Tue, 26 Nov 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICABBttA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0151CEE9B
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622083; cv=none; b=T3Fzvc8i/ACbtiqm9A/TFSTns2KEM8//FqOj9Xe22wIKjHlUv1zVGmzxwRa4ghk/wX0mzVd8hrlgLcnD/PtwO6ULvybQLrjr6RZADKwJ5pWLAtH7ihLsUnzMo0wPWC20zBgmx5yld2vEW/Ljsw2cRqXNaIfn5DIMJ9HMjJE8l1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622083; c=relaxed/simple;
	bh=1BcvzHodmZGMBmHu0MP2tXg7rtTopC0S2sUfJAkNCmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPYJK/60Q0ptGfhHSsLNc9heWVV7j8e5VJgDmUhIB1jJqHR/kCSQ0EjVLBX/XpefSrIloC/8jpLiM4yzX5gJFaVSC9NnFzucAL4wl0YTXjtssoUvYLV5oeMi2o+w6UmVHc4b6pranxRw8dkqrpDjBSwplg5rUEFHpviPHrfhdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICABBttA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622082; x=1764158082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1BcvzHodmZGMBmHu0MP2tXg7rtTopC0S2sUfJAkNCmw=;
  b=ICABBttAU8rup3ECIAYQHapyvGBk5YmoVJa+QacX3gBKX3ZxUTGVNgQ/
   jx87QkHsDOaT+8NC3d9aVQ2WCFy8K6H5CSBc+/ZOw7XLPdnLnjiETqfRQ
   WNFsk2+lD61OMENPHe0noPORwNLXnW08B+jlAx1p9hoBsNM5mWsSnVK75
   fUSTFQ8R+++KN44Sa/oM1fdyJFUxhSU9iUZ52+XFXUXt3XR2W01ZxuZNA
   JkiPy7XgFcVWBwIQJiTeEXcgGodDg+wkgfmDcNBDxtyHhjde9KLwhjtxl
   /du1n/G2a8L2oHIee+N4x/zahDk+DZCNqXJSntF0IsS9LVJcNCoMtfEg6
   A==;
X-CSE-ConnectionGUID: 30xRJNW9SzqTCJ8hV93y2g==
X-CSE-MsgGUID: C+QAhP3KT5mivUg2OYC1Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="55276392"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="55276392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:54:40 -0800
X-CSE-ConnectionGUID: aOZFv+7XTZSA8YRCCFEYhQ==
X-CSE-MsgGUID: gTfOCJlIRkagsbQCyjfSag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91766990"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2024 03:54:38 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v2 iwl-next 09/10] idpf: add support for Rx timestamping
Date: Tue, 26 Nov 2024 04:58:56 +0100
Message-Id: <20241126035849.6441-10-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241126035849.6441-1-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rx timestamp function when the Rx timestamp value is read directly
from the Rx descriptor. In order to extend the Rx timestamp value to 64
bit in hot path, the PHC time is cached in the receive groups.
Add supported Rx timestamp modes.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
v1 -> v2: extend commit message

 drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 77 ++++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 ++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +-
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 2460d27f004f..86611f2f26c5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -317,12 +317,41 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 	return 0;
 }
 
+/**
+ * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
+ *				     queue group.
+ * @grp: receive queue group in which Rx timestamp is enabled
+ * @split: Indicates whether the queue model is split or single queue
+ * @systime: Cached system time
+ */
+static void
+idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
+				u64 systime)
+{
+	struct idpf_rx_queue *rxq;
+	u16 i;
+
+	if (!split) {
+		for (i = 0; i < grp->singleq.num_rxq; i++) {
+			rxq = grp->singleq.rxqs[i];
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	} else {
+		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
+			rxq = &grp->splitq.rxq_sets[i]->rxq;
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	}
+}
+
 /**
  * idpf_ptp_update_cached_phctime - Update the cached PHC time values
  * @adapter: Driver specific private structure
  *
  * This function updates the system time values which are cached in the adapter
- * structure.
+ * structure and the Rx queues.
  *
  * This function must be called periodically to ensure that the cached value
  * is never more than 2 seconds old.
@@ -332,7 +361,7 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 {
 	u64 systime;
-	int err;
+	int err, i;
 
 	err = idpf_ptp_read_src_clk_reg(adapter, &systime, NULL);
 	if (err)
@@ -345,6 +374,22 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 	WRITE_ONCE(adapter->ptp->cached_phc_time, systime);
 	WRITE_ONCE(adapter->ptp->cached_phc_jiffies, jiffies);
 
+	idpf_for_each_vport(adapter, i) {
+		struct idpf_vport *vport = adapter->vports[i];
+		bool split;
+
+		if (!vport || !vport->rxq_grps)
+			continue;
+
+		split = idpf_is_queue_model_split(vport->rxq_model);
+
+		for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+			struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+
+			idpf_ptp_update_phctime_rxq_grp(grp, split, systime);
+		}
+	}
+
 	return 0;
 }
 
@@ -608,6 +653,33 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
+ * @vport: Virtual port structure
+ * @rx_filter: bool value for whether timestamps are enabled or disabled
+ */
+static void idpf_ptp_set_rx_tstamp(struct idpf_vport *vport, int rx_filter)
+{
+	vport->tstamp_config.rx_filter = rx_filter;
+
+	if (rx_filter == HWTSTAMP_FILTER_NONE)
+		return;
+
+	for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+		struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+		u16 j;
+
+		if (idpf_is_queue_model_split(vport->rxq_model)) {
+			for (j = 0; j < grp->singleq.num_rxq; j++)
+				idpf_queue_set(PTP, grp->singleq.rxqs[j]);
+		} else {
+			for (j = 0; j < grp->splitq.num_rxq_sets; j++)
+				idpf_queue_set(PTP,
+					       &grp->splitq.rxq_sets[j]->rxq);
+		}
+	}
+}
+
 /**
  * idpf_ptp_set_timestamp_mode - Setup driver for requested timestamp mode
  * @vport: Virtual port structure
@@ -627,6 +699,7 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 	}
 
 	vport->tstamp_config.tx_type = config->tx_type;
+	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index ab0a4228fac4..6a7074073aa8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3170,6 +3170,33 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_rx_hwtstamp - check for an RX timestamp and pass up the stack
+ * @rxq: pointer to the rx queue that receives the timestamp
+ * @rx_desc: pointer to rx descriptor containing timestamp
+ * @skb: skb to put timestamp in
+ */
+static void
+idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+		 struct sk_buff *skb)
+{
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	ts_high = le32_to_cpu(rx_desc->ts_high);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ts_ns),
+	};
+}
+
 /**
  * idpf_rx_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rxq: Rx descriptor ring packet is being transacted on
@@ -3195,6 +3222,9 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
+	if (idpf_queue_has(PTP, rxq))
+		idpf_rx_hwtstamp(rxq, rx_desc, skb);
+
 	skb->protocol = eth_type_trans(skb, rxq->netdev);
 
 	if (le16_get_bits(rx_desc->hdrlen_flags,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 2f8f2eab3d09..2c651fb9f96d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -290,6 +290,8 @@ struct idpf_ptype_state {
  * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
+ * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
+ *		  queue
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -300,6 +302,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
+	__IDPF_Q_PTP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -491,6 +494,7 @@ struct idpf_txq_stash {
  * @next_to_alloc: RX buffer to allocate at
  * @skb: Pointer to the skb
  * @truesize: data buffer truesize in singleq
+ * @cached_phctime: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
  * @q_id: Queue id
@@ -538,6 +542,7 @@ struct idpf_rx_queue {
 
 	struct sk_buff *skb;
 	u32 truesize;
+	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_rx_queue_stats q_stats;
@@ -557,7 +562,7 @@ struct idpf_rx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
-			    80 + sizeof(struct u64_stats_sync),
+			    88 + sizeof(struct u64_stats_sync),
 			    32);
 
 /**
-- 
2.31.1


