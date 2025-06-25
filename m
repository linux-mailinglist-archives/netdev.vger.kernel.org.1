Return-Path: <netdev+bounces-201232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973CAE8920
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76DB188A931
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FAE1DF256;
	Wed, 25 Jun 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA1lr0Dd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140A1CEAD6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867480; cv=none; b=IOyK+3KdkxncmV2n5Jo7+dVPgZ47L50c9XwmXBq//RNt/URtdvIKSkRG2Km9C9eNmUJQJ6/jwm8ctQVzEVG00KLvXm3Y562plz24aYdqKZl5JjFUTA+ft6Jgy7zPAa8pdlRQZklvbmhNm8jw1jr1P3AlfxIRHhd/B1LU02peWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867480; c=relaxed/simple;
	bh=zsSswhhfsh6GuN6XOJMRsBnNxL+UyXymwP5bR+o0QEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYu3Zq/fphN/Ffb9/Onixq6c6UZSr0ANDQCdLfBU4IUDKv0ciI4KuxjpvC9uxl4mfL1y/UyJKYQTa30tGS+W4DMgjGI1qhmzqqzjWxYbJ8ZREKqjgQvbf/Kzdvr5FI89Ppd9H5FsVRwT9B3bF6nZPLvDahyaOr5pO2uHDmbvjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA1lr0Dd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750867478; x=1782403478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zsSswhhfsh6GuN6XOJMRsBnNxL+UyXymwP5bR+o0QEc=;
  b=WA1lr0DdAS5eR4JRjnugFZV+fwwI/0MLSZ/t9lrt+Ef7hDrnkvXiEPDW
   OIrXHFMwNACQIpwtqlDqvCzljJiZCk49LCYKJwxXG3fnM0eqKg351rV4Y
   R7kZ6UBJmfYY7El5eS1hz5B1zWk7ZkYTrbNn8BYxHt+ThBUhsewI/KWxB
   1ssF+hP7NF//J2SNbJ8TJ/fYB1Qy51LYdntCeby3Dm6wynhWV5kzbOiUF
   F9WdCaH+/jzHElGVmOXE2cjl9WGt3KbjC75dBwO/9YszyHQjXlBMZ6v7K
   YBVuaieGiSWEsiDancRvXJWZAGTMVidYZIhwTEABk9OohckZGusXR/Qzm
   g==;
X-CSE-ConnectionGUID: nSflFRq9QEeVC9dq/z5fQA==
X-CSE-MsgGUID: GMDrSgLDRFeMY7yFq+93Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70714936"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70714936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:04:36 -0700
X-CSE-ConnectionGUID: i90wXtb+T8yTBTGdX+Hreg==
X-CSE-MsgGUID: H7qQnTwBQ72a/EffZoY+cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157752600"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 09:04:37 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [Intel-wired-lan] [PATCH net 1/5] idpf: add support for Tx refillqs in flow scheduling mode
Date: Wed, 25 Jun 2025 09:11:52 -0700
Message-Id: <20250625161156.338777-2-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250625161156.338777-1-joshua.a.hay@intel.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the start of a 5 patch series intended to fix a stability issue
in the flow scheduling Tx send/clean path that results in a Tx timeout.

In certain production environments, it is possible for completion tags
to collide, meaning N packets with the same completion tag are in flight
at the same time. In this environment, any given Tx queue is effectively
used to send both slower traffic and higher throughput traffic
simultaneously. This is the result of a customer's specific
configuration in the device pipeline, the details of which Intel cannot
provide. This configuration results in a small number of out-of-order
completions, i.e., a small number of packets in flight. The existing
guardrails in the driver only protect against a large number of packets
in flight. The slower flow completions are delayed which causes the
out-of-order completions. Meanwhile, the fast flow exhausts the pool of
unique tags and starts reusing tags. The next packet in the fast flow
uses the same tag for a packet that is still in flight from the slower
flow. The driver has no idea which packet it should clean when it
processes the completion with that tag, but it will for the packet on
the buffer ring before the hash table.  If the slower flow packet
completion is processed first, it will end up cleaning the fast flow
packet on the ring prematurely. This leaves the descriptor ring in a bad
state resulting in a Tx timeout.

This series refactors the Tx buffer management by replacing the stashing
mechanisms and the tag generation with a large pool/array of unique
tags. The completion tags are now simply used to index into the pool of
Tx buffers. This implicitly prevents any tag from being reused while
it's in flight.

First, we need a new mechanism for the send path to know what tag to use
next. The driver will allocate and initialize a refillq for each TxQ
with all of the possible free tag values. During send, the driver grabs
the next free tag from the refillq from next_to_clean. While cleaning
the packet, the clean routine posts the tag back to the refillq's
next_to_use to indicate that it is now free to use.

This mechanism works exactly the same way as the existing Rx refill
queues, which post the cleaned buffer IDs back to the buffer queue to be
reposted to HW. Since we're using the refillqs for both Rx and Tx now,
genercize some of the existing refillq support.

Note: the refillqs will not be used yet. This is only demonstrating how
they will be used to pass free tags back to the send path.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 91 +++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  8 +-
 2 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5cf440e09d0a..6a16b80a8ac2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -139,6 +139,9 @@ static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 	if (!txq->desc_ring)
 		return;
 
+	if (txq->refillq)
+		kfree(txq->refillq->ring);
+
 	dmam_free_coherent(txq->dev, txq->size, txq->desc_ring, txq->dma);
 	txq->desc_ring = NULL;
 	txq->next_to_use = 0;
@@ -267,6 +270,31 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	tx_q->next_to_clean = 0;
 	idpf_queue_set(GEN_CHK, tx_q);
 
+	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+		struct idpf_sw_queue *refillq = tx_q->refillq;
+
+		refillq->desc_count = tx_q->desc_count;
+
+		refillq->ring = kcalloc(refillq->desc_count, sizeof(u32),
+					GFP_KERNEL);
+		if (!refillq->ring) {
+			err = -ENOMEM;
+			goto err_alloc;
+		}
+
+		for (u32 i = 0; i < refillq->desc_count; i++)
+			refillq->ring[i] =
+				FIELD_PREP(IDPF_RFL_BI_BUFID_M, i) |
+				FIELD_PREP(IDPF_RFL_BI_GEN_M,
+					   idpf_queue_has(GEN_CHK, refillq));
+
+		/*
+		 * Go ahead and flip the GEN bit since this counts as filling
+		 * up the ring, i.e. we already ring wrapped.
+		 */
+		idpf_queue_change(GEN_CHK, refillq);
+	}
+
 	return 0;
 
 err_alloc:
@@ -603,18 +631,18 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 }
 
 /**
- * idpf_rx_post_buf_refill - Post buffer id to refill queue
+ * idpf_post_buf_refill - Post buffer id to refill queue
  * @refillq: refill queue to post to
  * @buf_id: buffer id to post
  */
-static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
+static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 {
 	u32 nta = refillq->next_to_use;
 
 	/* store the buffer ID and the SW maintained GEN bit to the refillq */
 	refillq->ring[nta] =
-		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
-		FIELD_PREP(IDPF_RX_BI_GEN_M,
+		FIELD_PREP(IDPF_RFL_BI_BUFID_M, buf_id) |
+		FIELD_PREP(IDPF_RFL_BI_GEN_M,
 			   idpf_queue_has(GEN_CHK, refillq));
 
 	if (unlikely(++nta == refillq->desc_count)) {
@@ -995,6 +1023,11 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
 
 		for (j = 0; j < txq_grp->num_txq; j++) {
+			if (flow_sch_en) {
+				kfree(txq_grp->txqs[j]->refillq);
+				txq_grp->txqs[j]->refillq = NULL;
+			}
+
 			kfree(txq_grp->txqs[j]);
 			txq_grp->txqs[j] = NULL;
 		}
@@ -1414,6 +1447,13 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 			}
 
 			idpf_queue_set(FLOW_SCH_EN, q);
+
+			q->refillq = kzalloc(sizeof(*q->refillq), GFP_KERNEL);
+			if (!q->refillq)
+				goto err_alloc;
+
+			idpf_queue_set(GEN_CHK, q->refillq);
+			idpf_queue_set(RFL_GEN_CHK, q->refillq);
 		}
 
 		if (!split)
@@ -2005,6 +2045,8 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 
 	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
 
+	idpf_post_buf_refill(txq->refillq, compl_tag);
+
 	/* If we didn't clean anything on the ring, this packet must be
 	 * in the hash table. Go clean it there.
 	 */
@@ -2364,6 +2406,37 @@ static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
 	return ntu;
 }
 
+/**
+ * idpf_tx_get_free_buf_id - get a free buffer ID from the refill queue
+ * @refillq: refill queue to get buffer ID from
+ * @buf_id: return buffer ID
+ *
+ * Return: true if a buffer ID was found, false if not
+ */
+static bool idpf_tx_get_free_buf_id(struct idpf_sw_queue *refillq,
+				    u16 *buf_id)
+{
+	u16 ntc = refillq->next_to_clean;
+	u32 refill_desc;
+
+	refill_desc = refillq->ring[ntc];
+
+	if (idpf_queue_has(RFL_GEN_CHK, refillq) !=
+	    !!(refill_desc & IDPF_RFL_BI_GEN_M))
+		return false;
+
+	*buf_id = FIELD_GET(IDPF_RFL_BI_BUFID_M, refill_desc);
+
+	if (unlikely(++ntc == refillq->desc_count)) {
+		idpf_queue_change(RFL_GEN_CHK, refillq);
+		ntc = 0;
+	}
+
+	refillq->next_to_clean = ntc;
+
+	return true;
+}
+
 /**
  * idpf_tx_splitq_map - Build the Tx flex descriptor
  * @tx_q: queue to send buffer on
@@ -2912,6 +2985,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	}
 
 	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+		if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
+						      &tx_params.compl_tag)))
+			return idpf_tx_drop_skb(tx_q, skb);
+
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
 		/* Set the RE bit to catch any packets that may have not been
@@ -3464,7 +3541,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 skip_data:
 		rx_buf->page = NULL;
 
-		idpf_rx_post_buf_refill(refillq, buf_id);
+		idpf_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
 
 		/* skip if it is non EOP desc */
@@ -3572,10 +3649,10 @@ static void idpf_rx_clean_refillq(struct idpf_buf_queue *bufq,
 		bool failure;
 
 		if (idpf_queue_has(RFL_GEN_CHK, refillq) !=
-		    !!(refill_desc & IDPF_RX_BI_GEN_M))
+		    !!(refill_desc & IDPF_RFL_BI_GEN_M))
 			break;
 
-		buf_id = FIELD_GET(IDPF_RX_BI_BUFID_M, refill_desc);
+		buf_id = FIELD_GET(IDPF_RFL_BI_BUFID_M, refill_desc);
 		failure = idpf_rx_update_bufq_desc(bufq, buf_id, buf_desc);
 		if (failure)
 			break;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 36a0f828a6f8..6924bee6ff5b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -107,8 +107,8 @@ do {								\
  */
 #define IDPF_TX_SPLITQ_RE_MIN_GAP	64
 
-#define IDPF_RX_BI_GEN_M		BIT(16)
-#define IDPF_RX_BI_BUFID_M		GENMASK(15, 0)
+#define IDPF_RFL_BI_GEN_M		BIT(16)
+#define IDPF_RFL_BI_BUFID_M		GENMASK(15, 0)
 
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
@@ -621,6 +621,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @cleaned_pkts: Number of packets cleaned for the above said case
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
@@ -670,6 +671,7 @@ struct idpf_tx_queue {
 
 	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
+	struct idpf_sw_queue *refillq;
 
 	u16 compl_tag_bufid_m;
 	u16 compl_tag_cur_gen;
@@ -691,7 +693,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    112 + sizeof(struct u64_stats_sync),
+			    120 + sizeof(struct u64_stats_sync),
 			    24);
 
 /**
-- 
2.39.2


