Return-Path: <netdev+bounces-119912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4301695777A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF209283D4D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3071DF680;
	Mon, 19 Aug 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXLYsS+n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5D1DD3B1
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106895; cv=none; b=ub53jzDy3LPH6t0Jiy+T5GZZtCtSvjbamOteNUNbdnPKdbQawk2OE7vVsXV+t6M1stmDh9vLgIOmRCmGe9vZi/PfgiaZn0LETqsl5vhV3wqbDEYdq06kzzxFPc2s+e5kMQWW4Jjo3L9uh+Pp8pvBR8uRhgLMZOk56zzFo2V6k1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106895; c=relaxed/simple;
	bh=7LC/IGYzAC7MY5gtUr81Ppq3WllGwFWuk9VtiJ9hDcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOCZ73xIMogwFXTIKLEFjAENW/Kr4Yps5zKFRn9sZ0CwIZkMFfNUrS0557gbCIWuqXH9nCi2xnX3fUvv51cMGfnFK6NcNhjHA0650zyEanX4b2pe8of46PZxGgh0eoBNq9S9nfHQpwOnFRlDbhLzYEX4ch6+Fel5YoBNVyqS5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXLYsS+n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106893; x=1755642893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7LC/IGYzAC7MY5gtUr81Ppq3WllGwFWuk9VtiJ9hDcI=;
  b=dXLYsS+n8SpQWGj/4VcBqASnwdEZGBo9dzwoc0YPId+pc3lB/kFUzjYW
   gpf5B78JEhHGFAuPhIe1Q4tVUigUA19QFRIg4e9LIEcGpENYdaABxVoyH
   gnJ0XlatO3nVKSNA6kPjohSsxyrTID6DyY2Pud9KmWGmVlKZ8KKqNJa4D
   q2vYE7okIGvB/qAajppi8M/jaNOE6qOXjsEsJ2K2r8MFeI4XXbqFtUG4D
   R/4XRju77bitRRU9yy9sGYn9H72/FjqIdIgtGwGj8zMwPFdJQZ28/3uj+
   j1t/elaWY3IHvskkK4dPvrq1J5ZRfv0w5gpVXupkT96Elhzqc/PhS3ara
   Q==;
X-CSE-ConnectionGUID: HxZrY3CBTpGhs1PlLuR4lw==
X-CSE-MsgGUID: sqOOuIjQRFyMCb0yF+9RXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33535166"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33535166"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:34:51 -0700
X-CSE-ConnectionGUID: S0mdyHZKTuGc6mghJOSTsA==
X-CSE-MsgGUID: r/fwirjaQLiTlVU16VFRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64700525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 15:34:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: [PATCH net-next v2 4/9] idpf: convert to libie Tx buffer completion
Date: Mon, 19 Aug 2024 15:34:36 -0700
Message-ID: <20240819223442.48013-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

&idpf_tx_buffer is almost identical to the previous generations, as well
as the way it's handled. Moreover, relying on dma_unmap_addr() and
!!buf->skb instead of explicit defining of buffer's type was never good.
Use the newly added libeth helpers to do it properly and reduce the
copy-paste around the Tx code.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  82 +++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 195 ++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  50 +----
 3 files changed, 101 insertions(+), 226 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index fe64febf7436..98f26a4b835f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include <net/libeth/rx.h>
+#include <net/libeth/tx.h>
 
 #include "idpf.h"
 
@@ -224,6 +225,7 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buf, len, size);
 		dma_unmap_addr_set(tx_buf, dma, dma);
+		tx_buf->type = LIBETH_SQE_FRAG;
 
 		/* align size to end of page */
 		max_data += -dma & (IDPF_TX_MAX_READ_REQ_SIZE - 1);
@@ -245,6 +247,8 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 				i = 0;
 			}
 
+			tx_q->tx_buf[i].type = LIBETH_SQE_EMPTY;
+
 			dma += max_data;
 			size -= max_data;
 
@@ -282,13 +286,13 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 	tx_desc->qw1 = idpf_tx_singleq_build_ctob(td_cmd, offsets,
 						  size, td_tag);
 
-	IDPF_SINGLEQ_BUMP_RING_IDX(tx_q, i);
+	first->type = LIBETH_SQE_SKB;
+	first->rs_idx = i;
 
-	/* set next_to_watch value indicating a packet is present */
-	first->next_to_watch = tx_desc;
+	IDPF_SINGLEQ_BUMP_RING_IDX(tx_q, i);
 
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
-	netdev_tx_sent_queue(nq, first->bytecount);
+	netdev_tx_sent_queue(nq, first->bytes);
 
 	idpf_tx_buf_hw_update(tx_q, i, netdev_xmit_more());
 }
@@ -306,8 +310,7 @@ idpf_tx_singleq_get_ctx_desc(struct idpf_tx_queue *txq)
 	struct idpf_base_tx_ctx_desc *ctx_desc;
 	int ntu = txq->next_to_use;
 
-	memset(&txq->tx_buf[ntu], 0, sizeof(struct idpf_tx_buf));
-	txq->tx_buf[ntu].ctx_entry = true;
+	txq->tx_buf[ntu].type = LIBETH_SQE_CTX;
 
 	ctx_desc = &txq->base_ctx[ntu];
 
@@ -396,11 +399,11 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 	first->skb = skb;
 
 	if (tso) {
-		first->gso_segs = offload.tso_segs;
-		first->bytecount = skb->len + ((first->gso_segs - 1) * offload.tso_hdr_len);
+		first->packets = offload.tso_segs;
+		first->bytes = skb->len + ((first->packets - 1) * offload.tso_hdr_len);
 	} else {
-		first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
-		first->gso_segs = 1;
+		first->bytes = max_t(unsigned int, skb->len, ETH_ZLEN);
+		first->packets = 1;
 	}
 	idpf_tx_singleq_map(tx_q, first, &offload);
 
@@ -420,10 +423,15 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 				  int *cleaned)
 {
-	unsigned int total_bytes = 0, total_pkts = 0;
+	struct libeth_sq_napi_stats ss = { };
 	struct idpf_base_tx_desc *tx_desc;
 	u32 budget = tx_q->clean_budget;
 	s16 ntc = tx_q->next_to_clean;
+	struct libeth_cq_pp cp = {
+		.dev	= tx_q->dev,
+		.ss	= &ss,
+		.napi	= napi_budget,
+	};
 	struct idpf_netdev_priv *np;
 	struct idpf_tx_buf *tx_buf;
 	struct netdev_queue *nq;
@@ -441,47 +449,23 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 		 * such. We can skip this descriptor since there is no buffer
 		 * to clean.
 		 */
-		if (tx_buf->ctx_entry) {
-			/* Clear this flag here to avoid stale flag values when
-			 * this buffer is used for actual data in the future.
-			 * There are cases where the tx_buf struct / the flags
-			 * field will not be cleared before being reused.
-			 */
-			tx_buf->ctx_entry = false;
+		if (unlikely(tx_buf->type <= LIBETH_SQE_CTX)) {
+			tx_buf->type = LIBETH_SQE_EMPTY;
 			goto fetch_next_txq_desc;
 		}
 
-		/* if next_to_watch is not set then no work pending */
-		eop_desc = (struct idpf_base_tx_desc *)tx_buf->next_to_watch;
-		if (!eop_desc)
-			break;
-
-		/* prevent any other reads prior to eop_desc */
+		/* prevent any other reads prior to type */
 		smp_rmb();
 
+		eop_desc = &tx_q->base_tx[tx_buf->rs_idx];
+
 		/* if the descriptor isn't done, no work yet to do */
 		if (!(eop_desc->qw1 &
 		      cpu_to_le64(IDPF_TX_DESC_DTYPE_DESC_DONE)))
 			break;
 
-		/* clear next_to_watch to prevent false hangs */
-		tx_buf->next_to_watch = NULL;
-
 		/* update the statistics for this packet */
-		total_bytes += tx_buf->bytecount;
-		total_pkts += tx_buf->gso_segs;
-
-		napi_consume_skb(tx_buf->skb, napi_budget);
-
-		/* unmap skb header data */
-		dma_unmap_single(tx_q->dev,
-				 dma_unmap_addr(tx_buf, dma),
-				 dma_unmap_len(tx_buf, len),
-				 DMA_TO_DEVICE);
-
-		/* clear tx_buf data */
-		tx_buf->skb = NULL;
-		dma_unmap_len_set(tx_buf, len, 0);
+		libeth_tx_complete(tx_buf, &cp);
 
 		/* unmap remaining buffers */
 		while (tx_desc != eop_desc) {
@@ -495,13 +479,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
-				dma_unmap_page(tx_q->dev,
-					       dma_unmap_addr(tx_buf, dma),
-					       dma_unmap_len(tx_buf, len),
-					       DMA_TO_DEVICE);
-				dma_unmap_len_set(tx_buf, len, 0);
-			}
+			libeth_tx_complete(tx_buf, &cp);
 		}
 
 		/* update budget only if we did something */
@@ -521,11 +499,11 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	ntc += tx_q->desc_count;
 	tx_q->next_to_clean = ntc;
 
-	*cleaned += total_pkts;
+	*cleaned += ss.packets;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_add(&tx_q->q_stats.packets, total_pkts);
-	u64_stats_add(&tx_q->q_stats.bytes, total_bytes);
+	u64_stats_add(&tx_q->q_stats.packets, ss.packets);
+	u64_stats_add(&tx_q->q_stats.bytes, ss.bytes);
 	u64_stats_update_end(&tx_q->stats_sync);
 
 	np = netdev_priv(tx_q->netdev);
@@ -533,7 +511,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 
 	dont_wake = np->state != __IDPF_VPORT_UP ||
 		    !netif_carrier_ok(tx_q->netdev);
-	__netif_txq_completed_wake(nq, total_pkts, total_bytes,
+	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
 				   dont_wake);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 585c3dadd9bf..de35736143de 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2,10 +2,19 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include <net/libeth/rx.h>
+#include <net/libeth/tx.h>
 
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
+struct idpf_tx_stash {
+	struct hlist_node hlist;
+	struct libeth_sqe buf;
+};
+
+#define idpf_tx_buf_compl_tag(buf)	(*(int *)&(buf)->priv)
+LIBETH_SQE_CHECK_PRIV(int);
+
 static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
 			       unsigned int count);
 
@@ -60,41 +69,18 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	}
 }
 
-/**
- * idpf_tx_buf_rel - Release a Tx buffer
- * @tx_q: the queue that owns the buffer
- * @tx_buf: the buffer to free
- */
-static void idpf_tx_buf_rel(struct idpf_tx_queue *tx_q,
-			    struct idpf_tx_buf *tx_buf)
-{
-	if (tx_buf->skb) {
-		if (dma_unmap_len(tx_buf, len))
-			dma_unmap_single(tx_q->dev,
-					 dma_unmap_addr(tx_buf, dma),
-					 dma_unmap_len(tx_buf, len),
-					 DMA_TO_DEVICE);
-		dev_kfree_skb_any(tx_buf->skb);
-	} else if (dma_unmap_len(tx_buf, len)) {
-		dma_unmap_page(tx_q->dev,
-			       dma_unmap_addr(tx_buf, dma),
-			       dma_unmap_len(tx_buf, len),
-			       DMA_TO_DEVICE);
-	}
-
-	tx_buf->next_to_watch = NULL;
-	tx_buf->skb = NULL;
-	tx_buf->compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
-	dma_unmap_len_set(tx_buf, len, 0);
-}
-
 /**
  * idpf_tx_buf_rel_all - Free any empty Tx buffers
  * @txq: queue to be cleaned
  */
 static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 {
+	struct libeth_sq_napi_stats ss = { };
 	struct idpf_buf_lifo *buf_stack;
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= &ss,
+	};
 	u16 i;
 
 	/* Buffers already cleared, nothing to do */
@@ -103,7 +89,7 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 
 	/* Free all the Tx buffer sk_buffs */
 	for (i = 0; i < txq->desc_count; i++)
-		idpf_tx_buf_rel(txq, &txq->tx_buf[i]);
+		libeth_tx_complete(&txq->tx_buf[i], &cp);
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -203,10 +189,6 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 	if (!tx_q->tx_buf)
 		return -ENOMEM;
 
-	/* Initialize tx_bufs with invalid completion tags */
-	for (i = 0; i < tx_q->desc_count; i++)
-		tx_q->tx_buf[i].compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
-
 	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
 		return 0;
 
@@ -1655,37 +1637,6 @@ static void idpf_tx_handle_sw_marker(struct idpf_tx_queue *tx_q)
 	wake_up(&vport->sw_marker_wq);
 }
 
-/**
- * idpf_tx_splitq_clean_hdr - Clean TX buffer resources for header portion of
- * packet
- * @tx_q: tx queue to clean buffer from
- * @tx_buf: buffer to be cleaned
- * @cleaned: pointer to stats struct to track cleaned packets/bytes
- * @napi_budget: Used to determine if we are in netpoll
- */
-static void idpf_tx_splitq_clean_hdr(struct idpf_tx_queue *tx_q,
-				     struct idpf_tx_buf *tx_buf,
-				     struct idpf_cleaned_stats *cleaned,
-				     int napi_budget)
-{
-	napi_consume_skb(tx_buf->skb, napi_budget);
-
-	if (dma_unmap_len(tx_buf, len)) {
-		dma_unmap_single(tx_q->dev,
-				 dma_unmap_addr(tx_buf, dma),
-				 dma_unmap_len(tx_buf, len),
-				 DMA_TO_DEVICE);
-
-		dma_unmap_len_set(tx_buf, len, 0);
-	}
-
-	/* clear tx_buf data */
-	tx_buf->skb = NULL;
-
-	cleaned->bytes += tx_buf->bytecount;
-	cleaned->packets += tx_buf->gso_segs;
-}
-
 /**
  * idpf_tx_clean_stashed_bufs - clean bufs that were stored for
  * out of order completions
@@ -1701,23 +1652,20 @@ static void idpf_tx_clean_stashed_bufs(struct idpf_tx_queue *txq,
 {
 	struct idpf_tx_stash *stash;
 	struct hlist_node *tmp_buf;
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= cleaned,
+		.napi	= budget,
+	};
 
 	/* Buffer completion */
 	hash_for_each_possible_safe(txq->stash->sched_buf_hash, stash, tmp_buf,
 				    hlist, compl_tag) {
-		if (unlikely(stash->buf.compl_tag != (int)compl_tag))
+		if (unlikely(idpf_tx_buf_compl_tag(&stash->buf) !=
+			     (int)compl_tag))
 			continue;
 
-		if (stash->buf.skb) {
-			idpf_tx_splitq_clean_hdr(txq, &stash->buf, cleaned,
-						 budget);
-		} else if (dma_unmap_len(&stash->buf, len)) {
-			dma_unmap_page(txq->dev,
-				       dma_unmap_addr(&stash->buf, dma),
-				       dma_unmap_len(&stash->buf, len),
-				       DMA_TO_DEVICE);
-			dma_unmap_len_set(&stash->buf, len, 0);
-		}
+		libeth_tx_complete(&stash->buf, &cp);
 
 		/* Push shadow buf back onto stack */
 		idpf_buf_lifo_push(&txq->stash->buf_stack, stash);
@@ -1737,8 +1685,7 @@ static int idpf_stash_flow_sch_buffers(struct idpf_tx_queue *txq,
 {
 	struct idpf_tx_stash *stash;
 
-	if (unlikely(!dma_unmap_addr(tx_buf, dma) &&
-		     !dma_unmap_len(tx_buf, len)))
+	if (unlikely(tx_buf->type <= LIBETH_SQE_CTX))
 		return 0;
 
 	stash = idpf_buf_lifo_pop(&txq->stash->buf_stack);
@@ -1751,20 +1698,18 @@ static int idpf_stash_flow_sch_buffers(struct idpf_tx_queue *txq,
 
 	/* Store buffer params in shadow buffer */
 	stash->buf.skb = tx_buf->skb;
-	stash->buf.bytecount = tx_buf->bytecount;
-	stash->buf.gso_segs = tx_buf->gso_segs;
+	stash->buf.bytes = tx_buf->bytes;
+	stash->buf.packets = tx_buf->packets;
+	stash->buf.type = tx_buf->type;
 	dma_unmap_addr_set(&stash->buf, dma, dma_unmap_addr(tx_buf, dma));
 	dma_unmap_len_set(&stash->buf, len, dma_unmap_len(tx_buf, len));
-	stash->buf.compl_tag = tx_buf->compl_tag;
+	idpf_tx_buf_compl_tag(&stash->buf) = idpf_tx_buf_compl_tag(tx_buf);
 
 	/* Add buffer to buf_hash table to be freed later */
 	hash_add(txq->stash->sched_buf_hash, &stash->hlist,
-		 stash->buf.compl_tag);
-
-	memset(tx_buf, 0, sizeof(struct idpf_tx_buf));
+		 idpf_tx_buf_compl_tag(&stash->buf));
 
-	/* Reinitialize buf_id portion of tag */
-	tx_buf->compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
+	tx_buf->type = LIBETH_SQE_EMPTY;
 
 	return 0;
 }
@@ -1806,6 +1751,11 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 	union idpf_tx_flex_desc *next_pending_desc = NULL;
 	union idpf_tx_flex_desc *tx_desc;
 	s16 ntc = tx_q->next_to_clean;
+	struct libeth_cq_pp cp = {
+		.dev	= tx_q->dev,
+		.ss	= cleaned,
+		.napi	= napi_budget,
+	};
 	struct idpf_tx_buf *tx_buf;
 
 	tx_desc = &tx_q->flex_tx[ntc];
@@ -1821,13 +1771,10 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 		 * invalid completion tag since no buffer was used.  We can
 		 * skip this descriptor since there is no buffer to clean.
 		 */
-		if (unlikely(tx_buf->compl_tag == IDPF_SPLITQ_TX_INVAL_COMPL_TAG))
+		if (tx_buf->type <= LIBETH_SQE_CTX)
 			goto fetch_next_txq_desc;
 
-		eop_desc = (union idpf_tx_flex_desc *)tx_buf->next_to_watch;
-
-		/* clear next_to_watch to prevent false hangs */
-		tx_buf->next_to_watch = NULL;
+		eop_desc = &tx_q->flex_tx[tx_buf->rs_idx];
 
 		if (descs_only) {
 			if (idpf_stash_flow_sch_buffers(tx_q, tx_buf))
@@ -1844,8 +1791,7 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 				}
 			}
 		} else {
-			idpf_tx_splitq_clean_hdr(tx_q, tx_buf, cleaned,
-						 napi_budget);
+			libeth_tx_complete(tx_buf, &cp);
 
 			/* unmap remaining buffers */
 			while (tx_desc != eop_desc) {
@@ -1853,13 +1799,7 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 							      tx_desc, tx_buf);
 
 				/* unmap any remaining paged data */
-				if (dma_unmap_len(tx_buf, len)) {
-					dma_unmap_page(tx_q->dev,
-						       dma_unmap_addr(tx_buf, dma),
-						       dma_unmap_len(tx_buf, len),
-						       DMA_TO_DEVICE);
-					dma_unmap_len_set(tx_buf, len, 0);
-				}
+				libeth_tx_complete(tx_buf, &cp);
 			}
 		}
 
@@ -1901,24 +1841,20 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
 	u16 idx = compl_tag & txq->compl_tag_bufid_m;
 	struct idpf_tx_buf *tx_buf = NULL;
 	u16 ntc = txq->next_to_clean;
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= cleaned,
+		.napi	= budget,
+	};
 	u16 num_descs_cleaned = 0;
 	u16 orig_idx = idx;
 
 	tx_buf = &txq->tx_buf[idx];
+	if (unlikely(tx_buf->type <= LIBETH_SQE_CTX))
+		return false;
 
-	while (tx_buf->compl_tag == (int)compl_tag) {
-		if (tx_buf->skb) {
-			idpf_tx_splitq_clean_hdr(txq, tx_buf, cleaned, budget);
-		} else if (dma_unmap_len(tx_buf, len)) {
-			dma_unmap_page(txq->dev,
-				       dma_unmap_addr(tx_buf, dma),
-				       dma_unmap_len(tx_buf, len),
-				       DMA_TO_DEVICE);
-			dma_unmap_len_set(tx_buf, len, 0);
-		}
-
-		memset(tx_buf, 0, sizeof(struct idpf_tx_buf));
-		tx_buf->compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
+	while (idpf_tx_buf_compl_tag(tx_buf) == (int)compl_tag) {
+		libeth_tx_complete(tx_buf, &cp);
 
 		num_descs_cleaned++;
 		idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
@@ -2307,6 +2243,12 @@ unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 idx)
 {
+	struct libeth_sq_napi_stats ss = { };
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= &ss,
+	};
+
 	u64_stats_update_begin(&txq->stats_sync);
 	u64_stats_inc(&txq->q_stats.dma_map_errs);
 	u64_stats_update_end(&txq->stats_sync);
@@ -2316,7 +2258,7 @@ void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 		struct idpf_tx_buf *tx_buf;
 
 		tx_buf = &txq->tx_buf[idx];
-		idpf_tx_buf_rel(txq, tx_buf);
+		libeth_tx_complete(tx_buf, &cp);
 		if (tx_buf == first)
 			break;
 		if (idx == 0)
@@ -2405,7 +2347,8 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 		if (dma_mapping_error(tx_q->dev, dma))
 			return idpf_tx_dma_map_error(tx_q, skb, first, i);
 
-		tx_buf->compl_tag = params->compl_tag;
+		idpf_tx_buf_compl_tag(tx_buf) = params->compl_tag;
+		tx_buf->type = LIBETH_SQE_FRAG;
 
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buf, len, size);
@@ -2479,8 +2422,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 			 * simply pass over these holes and finish cleaning the
 			 * rest of the packet.
 			 */
-			memset(&tx_q->tx_buf[i], 0, sizeof(struct idpf_tx_buf));
-			tx_q->tx_buf[i].compl_tag = params->compl_tag;
+			tx_q->tx_buf[i].type = LIBETH_SQE_EMPTY;
 
 			/* Adjust the DMA offset and the remaining size of the
 			 * fragment.  On the first iteration of this loop,
@@ -2525,19 +2467,19 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 	/* record SW timestamp if HW timestamp is not available */
 	skb_tx_timestamp(skb);
 
+	first->type = LIBETH_SQE_SKB;
+
 	/* write last descriptor with RS and EOP bits */
+	first->rs_idx = i;
 	td_cmd |= params->eop_cmd;
 	idpf_tx_splitq_build_desc(tx_desc, params, td_cmd, size);
 	i = idpf_tx_splitq_bump_ntu(tx_q, i);
 
-	/* set next_to_watch value indicating a packet is present */
-	first->next_to_watch = tx_desc;
-
 	tx_q->txq_grp->num_completions_pending++;
 
 	/* record bytecount for BQL */
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
-	netdev_tx_sent_queue(nq, first->bytecount);
+	netdev_tx_sent_queue(nq, first->bytes);
 
 	idpf_tx_buf_hw_update(tx_q, i, netdev_xmit_more());
 }
@@ -2737,8 +2679,7 @@ idpf_tx_splitq_get_ctx_desc(struct idpf_tx_queue *txq)
 	struct idpf_flex_tx_ctx_desc *desc;
 	int i = txq->next_to_use;
 
-	memset(&txq->tx_buf[i], 0, sizeof(struct idpf_tx_buf));
-	txq->tx_buf[i].compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
+	txq->tx_buf[i].type = LIBETH_SQE_CTX;
 
 	/* grab the next descriptor */
 	desc = &txq->flex_ctx[i];
@@ -2822,12 +2763,12 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	first->skb = skb;
 
 	if (tso) {
-		first->gso_segs = tx_params.offload.tso_segs;
-		first->bytecount = skb->len +
-			((first->gso_segs - 1) * tx_params.offload.tso_hdr_len);
+		first->packets = tx_params.offload.tso_segs;
+		first->bytes = skb->len +
+			((first->packets - 1) * tx_params.offload.tso_hdr_len);
 	} else {
-		first->gso_segs = 1;
-		first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
+		first->packets = 1;
+		first->bytes = max_t(unsigned int, skb->len, ETH_ZLEN);
 	}
 
 	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 6215dbee5546..fa87754c7340 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -131,7 +131,6 @@ do {								\
 	(txq)->num_completions_pending - (txq)->complq->num_completions)
 
 #define IDPF_TX_SPLITQ_COMPL_TAG_WIDTH	16
-#define IDPF_SPLITQ_TX_INVAL_COMPL_TAG	-1
 /* Adjust the generation for the completion tag and wrap if necessary */
 #define IDPF_TX_ADJ_COMPL_TAG_GEN(txq) \
 	((++(txq)->compl_tag_cur_gen) >= (txq)->compl_tag_gen_max ? \
@@ -149,47 +148,7 @@ union idpf_tx_flex_desc {
 	struct idpf_flex_tx_sched_desc flow; /* flow based scheduling */
 };
 
-/**
- * struct idpf_tx_buf
- * @next_to_watch: Next descriptor to clean
- * @skb: Pointer to the skb
- * @dma: DMA address
- * @len: DMA length
- * @bytecount: Number of bytes
- * @gso_segs: Number of GSO segments
- * @compl_tag: Splitq only, unique identifier for a buffer. Used to compare
- *	       with completion tag returned in buffer completion event.
- *	       Because the completion tag is expected to be the same in all
- *	       data descriptors for a given packet, and a single packet can
- *	       span multiple buffers, we need this field to track all
- *	       buffers associated with this completion tag independently of
- *	       the buf_id. The tag consists of a N bit buf_id and M upper
- *	       order "generation bits". See compl_tag_bufid_m and
- *	       compl_tag_gen_s in struct idpf_queue. We'll use a value of -1
- *	       to indicate the tag is not valid.
- * @ctx_entry: Singleq only. Used to indicate the corresponding entry
- *	       in the descriptor ring was used for a context descriptor and
- *	       this buffer entry should be skipped.
- */
-struct idpf_tx_buf {
-	void *next_to_watch;
-	struct sk_buff *skb;
-	DEFINE_DMA_UNMAP_ADDR(dma);
-	DEFINE_DMA_UNMAP_LEN(len);
-	unsigned int bytecount;
-	unsigned short gso_segs;
-
-	union {
-		int compl_tag;
-
-		bool ctx_entry;
-	};
-};
-
-struct idpf_tx_stash {
-	struct hlist_node hlist;
-	struct idpf_tx_buf buf;
-};
+#define idpf_tx_buf libeth_sqe
 
 /**
  * struct idpf_buf_lifo - LIFO for managing OOO completions
@@ -496,10 +455,7 @@ struct idpf_tx_queue_stats {
 	u64_stats_t dma_map_errs;
 };
 
-struct idpf_cleaned_stats {
-	u32 packets;
-	u32 bytes;
-};
+#define idpf_cleaned_stats libeth_sq_napi_stats
 
 #define IDPF_ITR_DYNAMIC	1
 #define IDPF_ITR_MAX		0x1FE0
@@ -688,7 +644,7 @@ struct idpf_tx_queue {
 
 		void *desc_ring;
 	};
-	struct idpf_tx_buf *tx_buf;
+	struct libeth_sqe *tx_buf;
 	struct idpf_txq_group *txq_grp;
 	struct device *dev;
 	void __iomem *tail;
-- 
2.42.0


