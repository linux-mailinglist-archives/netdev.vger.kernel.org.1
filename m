Return-Path: <netdev+bounces-215743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A736B301A2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A754FAC0442
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E64343D9E;
	Thu, 21 Aug 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbJGXU2S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38213343D6C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799289; cv=none; b=Hm4pXVD2JKqgnnLRYMK8XdS/tpbdlw775vm5afoliRB93Z9CzrnxBopi3Y0FpGeIff4y/AVcmaJWzRWaiuTRDJsh+JlAskuZwOtR9Y2mY6ZRf9i369ZbIugYkPpaYwKUkSFriAN1y31ujQ92hR3P57V0HEJiLlF7t970VmMf+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799289; c=relaxed/simple;
	bh=ep9B9twbaDXwcJdZLQNqTpyF0uJiauqSPlN2pFABiqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6DBQWaS90yvdBnOcPb0wcEL+Q741szl65Uru2CJtw7Z32nfCWzzc+4PIykeMp+YgYduPD2zbC849cNtpYcqDiSc8r8pguvoZsz8YLSjghc7EYcweQCMTMMqKPeevdAId/o/uWIHilg++ur9bMwso/96vPmDq1jIuBxeYco2vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbJGXU2S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755799287; x=1787335287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ep9B9twbaDXwcJdZLQNqTpyF0uJiauqSPlN2pFABiqo=;
  b=bbJGXU2Sp754+xCFjvAlh6RGn+x0BOI1AwKToVDiXsLV8kJVSSE31yVL
   5Zk71gLNieho1XTeCQLswHKHCFBbJgl+FzRAENkzHgs9unRrMWhlbEsR+
   rqNY7LgnxoNlxSI53XN+ZCrDi6PYgQPCE9Aiprwa708w/JPpj78TPMuEa
   bx2zlw8j64zHBfZfu08lW4GbJ72qtFsrvHUpE/QmBY9uezYHDNawKEm16
   KWVdtBAZe+EssbTfNNWd5OKmhFVJ5R3KBpeRYqxv81iuRwibFeSmiJZST
   Ja+QV+ZaoBOLFzrN7YvuF98VaKqC4X5yjoq6Qssyg+m4TI2fuAoVcckCv
   w==;
X-CSE-ConnectionGUID: zyw/iG6GTRKG0i9tRimEPw==
X-CSE-MsgGUID: I3gu+3awQA26hkaZN+uZIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60727075"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60727075"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:01:11 -0700
X-CSE-ConnectionGUID: ii3KBozgQ360+NLvbJ7vcg==
X-CSE-MsgGUID: oiKxOFoXTrq+yY5blMiPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172738224"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2025 11:01:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	lrizzo@google.com,
	brianvv@google.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/6] idpf: add support for Tx refillqs in flow scheduling mode
Date: Thu, 21 Aug 2025 11:00:54 -0700
Message-ID: <20250821180100.401955-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
References: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

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
out-of-order completions. The fast flow will continue sending traffic
and generating tags. Because tags are generated on the fly, the fast
flow eventually uses the same tag for a packet that is still in flight
from the slower flow. The driver has no idea which packet it should
clean when it processes the completion with that tag, but it will look
for the packet on the buffer ring before the hash table.  If the slower
flow packet completion is processed first, it will end up cleaning the
fast flow packet on the ring prematurely. This leaves the descriptor
ring in a bad state resulting in a crash or Tx timeout.

In summary, generating a tag when a packet is sent can lead to the same
tag being associated with multiple packets. This can lead to resource
leaks, crashes, and/or Tx timeouts.

Before we can replace the tag generation, we need a new mechanism for
the send path to know what tag to use next. The driver will allocate and
initialize a refillq for each TxQ with all of the possible free tag
values. During send, the driver grabs the next free tag from the refillq
from next_to_clean. While cleaning the packet, the clean routine posts
the tag back to the refillq's next_to_use to indicate that it is now
free to use.

This mechanism works exactly the same way as the existing Rx refill
queues, which post the cleaned buffer IDs back to the buffer queue to be
reposted to HW. Since we're using the refillqs for both Rx and Tx now,
genericize some of the existing refillq support.

Note: the refillqs will not be used yet. This is only demonstrating how
they will be used to pass free tags back to the send path.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 93 +++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  8 +-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 66a1b040639d..9b63944235fb 100644
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
@@ -244,6 +247,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 			      struct idpf_tx_queue *tx_q)
 {
 	struct device *dev = tx_q->dev;
+	struct idpf_sw_queue *refillq;
 	int err;
 
 	err = idpf_tx_buf_alloc_all(tx_q);
@@ -267,6 +271,29 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	tx_q->next_to_clean = 0;
 	idpf_queue_set(GEN_CHK, tx_q);
 
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+		return 0;
+
+	refillq = tx_q->refillq;
+	refillq->desc_count = tx_q->desc_count;
+	refillq->ring = kcalloc(refillq->desc_count, sizeof(u32),
+				GFP_KERNEL);
+	if (!refillq->ring) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
+
+	for (unsigned int i = 0; i < refillq->desc_count; i++)
+		refillq->ring[i] =
+			FIELD_PREP(IDPF_RFL_BI_BUFID_M, i) |
+			FIELD_PREP(IDPF_RFL_BI_GEN_M,
+				   idpf_queue_has(GEN_CHK, refillq));
+
+	/* Go ahead and flip the GEN bit since this counts as filling
+	 * up the ring, i.e. we already ring wrapped.
+	 */
+	idpf_queue_change(GEN_CHK, refillq);
+
 	return 0;
 
 err_alloc:
@@ -603,18 +630,18 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
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
@@ -995,6 +1022,11 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
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
@@ -1414,6 +1446,13 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
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
@@ -2005,6 +2044,8 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 
 	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
 
+	idpf_post_buf_refill(txq->refillq, compl_tag);
+
 	/* If we didn't clean anything on the ring, this packet must be
 	 * in the hash table. Go clean it there.
 	 */
@@ -2364,6 +2405,37 @@ static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
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
+	u32 ntc = refillq->next_to_clean;
+	u32 refill_desc;
+
+	refill_desc = refillq->ring[ntc];
+
+	if (unlikely(idpf_queue_has(RFL_GEN_CHK, refillq) !=
+		     !!(refill_desc & IDPF_RFL_BI_GEN_M)))
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
@@ -2912,6 +2984,13 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	}
 
 	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+		if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
+						      &tx_params.compl_tag))) {
+			u64_stats_update_begin(&tx_q->stats_sync);
+			u64_stats_inc(&tx_q->q_stats.q_busy);
+			u64_stats_update_end(&tx_q->stats_sync);
+		}
+
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
 		/* Set the RE bit to catch any packets that may have not been
@@ -3472,7 +3551,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 skip_data:
 		rx_buf->netmem = 0;
 
-		idpf_rx_post_buf_refill(refillq, buf_id);
+		idpf_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
 
 		/* skip if it is non EOP desc */
@@ -3580,10 +3659,10 @@ static void idpf_rx_clean_refillq(struct idpf_buf_queue *bufq,
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
index 281de655a813..58232a1bd0a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -108,8 +108,8 @@ do {								\
  */
 #define IDPF_TX_SPLITQ_RE_MIN_GAP	64
 
-#define IDPF_RX_BI_GEN_M		BIT(16)
-#define IDPF_RX_BI_BUFID_M		GENMASK(15, 0)
+#define IDPF_RFL_BI_GEN_M		BIT(16)
+#define IDPF_RFL_BI_BUFID_M		GENMASK(15, 0)
 
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
@@ -622,6 +622,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @cleaned_pkts: Number of packets cleaned for the above said case
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
@@ -671,6 +672,7 @@ struct idpf_tx_queue {
 
 	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
+	struct idpf_sw_queue *refillq;
 
 	u16 compl_tag_bufid_m;
 	u16 compl_tag_cur_gen;
@@ -692,7 +694,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    112 + sizeof(struct u64_stats_sync),
+			    120 + sizeof(struct u64_stats_sync),
 			    24);
 
 /**
-- 
2.47.1


