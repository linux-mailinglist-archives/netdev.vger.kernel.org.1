Return-Path: <netdev+bounces-206765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFEB04506
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4724A1B3D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20826158B;
	Mon, 14 Jul 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpPfNlRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213E25DB1C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509116; cv=none; b=Wx25uH15RhXyNxDyDAxANXQu9/aS/GKkaCOG2gjnBVax3cqelDCYEHZNP5PrwwljeeDtL8QPh9j1AQ47ZrnpR6FXSKgXXdZCuqfjsmvjeyjTFMggObCB/uaygdBpIu+NUGxfP8oTU7qrsvfY9j65APsKDeLtLe/+XaiSzdITP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509116; c=relaxed/simple;
	bh=nFlwd02e9/g4DZ/NmkxCUe/7HY8XUqNShWCau4Pu9TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/TD4g26xvZkKKuaBf+xKG32jy3Hvf7e4QujtJYJyTD0JOn1fxx+J5ccb1HOJahAch0FR6nhKA7G+3MWfKG8oJ5GCmRYWxN46OpI+OrjcRQgxH78IvAo1d7e0kZK6sMyI6guR71b/1kgWGXxxKTAkOisLvHLfHcvAJLZXWF8LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpPfNlRN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so3698910b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509114; x=1753113914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvGHBkttmXf4CON1tPs3Qw9PsMeF7ZNGKy7HpMcE3Q=;
        b=HpPfNlRNE7ufuyQHWhH+n5cgeUjnfYlF58Brdx2wo+nH0W7TeYLM+E2ed5xykmLRX6
         iAq7eGV5EPjBGANc1k/7Jt9WeKh7ttiJqcCjFZ5iPZEZqtKbSpDODdOB2ga7bmZvMlYc
         8zfqvOIZnKAt/3ZBrfiGPbmE9JvRNlqNFYRt6mXT/Jq1e1YRmdq9qe/jLJIp6PWs/9TX
         V0VB/Go0BK4w0NCYoNIHXqXwIagl97fJeyJ0YYHQWA1Ky7WbzzI3D6c7teOC1k9JhRru
         Jkl5mMrmEORl1s5adqQv9aull8IskI4kFlQKHiqjtAdDK12NfLLjhpXwssfgjmCCDzVn
         UmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509114; x=1753113914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvGHBkttmXf4CON1tPs3Qw9PsMeF7ZNGKy7HpMcE3Q=;
        b=RWg3M/bFpkMcgXCJjBEEh5t1WozelPPydlEvNEMBCq0SaNNaua3aUR3aub5T4N/kcZ
         GOR4Vm9P1OFEkio88QfqzdVYKrKGGH48lsaap1fbqeq/5ndbW+7BrMxagc22q67+NPJ8
         3cJ5ino9FSME0bRj0WTl2H4ykoQSQi1s7lRfUEnnQUY5zhn+bjy3hTFB69FN2NBd18o1
         Th8wjb1HLYlJaerSGxHyY+tidavi4P4Y3EhQKVYDlUN4A2ftYKIM1u5efwZZE5Be/Cwb
         0C+eXHlZ/8tL0XJhAHZTICzOUUfPQagETl1svMEkGi8iQoEq5mBnsHjXYmUuzS9aNIFf
         9HUQ==
X-Gm-Message-State: AOJu0Yzaqm6oSf+SFyowVlvog9Hsui3ZKcCg2VSYyAmq3biCLmTHlX84
	upOiZtKznYtzNpkf8/oY84qps5l7k2nM6J4aX6JltXj4TACwLZwZnEy+OmTm7pHXZ5tZPtYpYZI
	MaRGnqUptxTWIkpG85l+ZUzWh1IBVrGFAKA+bkVXWZwKZmkvYQ1S8vferDGdvD4+ckxsLKjShYU
	Bif+Du3hC+FHIGTIKA/WusI2tQvT7dvoJpn9iWMDlg6zz5daw=
X-Google-Smtp-Source: AGHT+IG+AsyJscKjpJptOX390lNj9Sps3uy7w5BnqWuBYq67PZQ9suyVO4UPdw6TWL0aQKhwkw6CSrQci+ASqQ==
X-Received: from pfat8.prod.google.com ([2002:a05:6a00:aa08:b0:746:3162:8be1])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d12:b0:748:e4f6:ff31 with SMTP id d2e1a72fcca58-74ee129846cmr23271025b3a.8.1752509113393;
 Mon, 14 Jul 2025 09:05:13 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:04:50 -0700
In-Reply-To: <20250714160451.124671-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714160451.124671-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714160451.124671-5-jeroendb@google.com>
Subject: [PATCH net-next 4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

In the descriptor clean path, a number of changes need to be made to
accommodate out of order completions and double completions.

The XSK stack can only handle completions being processed in order, as a
single counter is incremented in xsk_tx_completed to sigify how many XSK
descriptors have been completed. Because completions can come back out
of order in DQ, a separate queue of XSK descriptors must be maintained.
This queue keeps the pending packets in the order that they were written
so that the descriptors can be counted in xsk_tx_completed in the same
order.

For double completions, a new pending packet state and type are
introduced. The new type, GVE_TX_PENDING_PACKET_DQO_XSK, plays an
anlogous role to pre-existing _SKB and _XDP_FRAME pending packet types
for XSK descriptors. The new state, GVE_PACKET_STATE_XSK_COMPLETE,
represents packets for which no more completions are expected. This
includes packets which have received a packet completion or reinjection
completion, as well as packets whose reinjection completion timer have
timed out. At this point, such packets can be counted as part of
xsk_tx_completed() and freed.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  19 ++-
 drivers/net/ethernet/google/gve/gve_dqo.h    |   1 +
 drivers/net/ethernet/google/gve/gve_main.c   |   6 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 148 +++++++++++++++++++
 4 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 9925c08e595e..ff7dc06e7fa4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -399,11 +399,17 @@ enum gve_packet_state {
 	GVE_PACKET_STATE_PENDING_REINJECT_COMPL,
 	/* No valid completion received within the specified timeout. */
 	GVE_PACKET_STATE_TIMED_OUT_COMPL,
+	/* XSK pending packet has received a packet/reinjection completion, or
+	 * has timed out. At this point, the pending packet can be counted by
+	 * xsk_tx_complete and freed.
+	 */
+	GVE_PACKET_STATE_XSK_COMPLETE,
 };
 
 enum gve_tx_pending_packet_dqo_type {
 	GVE_TX_PENDING_PACKET_DQO_SKB,
-	GVE_TX_PENDING_PACKET_DQO_XDP_FRAME
+	GVE_TX_PENDING_PACKET_DQO_XDP_FRAME,
+	GVE_TX_PENDING_PACKET_DQO_XSK,
 };
 
 struct gve_tx_pending_packet_dqo {
@@ -440,10 +446,10 @@ struct gve_tx_pending_packet_dqo {
 	/* Identifies the current state of the packet as defined in
 	 * `enum gve_packet_state`.
 	 */
-	u8 state : 2;
+	u8 state : 3;
 
 	/* gve_tx_pending_packet_dqo_type */
-	u8 type : 1;
+	u8 type : 2;
 
 	/* If packet is an outstanding miss completion, then the packet is
 	 * freed if the corresponding re-injection completion is not received
@@ -512,6 +518,8 @@ struct gve_tx_ring {
 				/* Cached value of `dqo_compl.free_tx_qpl_buf_cnt` */
 				u32 free_tx_qpl_buf_cnt;
 			};
+
+			atomic_t xsk_reorder_queue_tail;
 		} dqo_tx;
 	};
 
@@ -545,6 +553,9 @@ struct gve_tx_ring {
 			/* Last TX ring index fetched by HW */
 			atomic_t hw_tx_head;
 
+			u16 xsk_reorder_queue_head;
+			u16 xsk_reorder_queue_tail;
+
 			/* List to track pending packets which received a miss
 			 * completion but not a corresponding reinjection.
 			 */
@@ -598,6 +609,8 @@ struct gve_tx_ring {
 			struct gve_tx_pending_packet_dqo *pending_packets;
 			s16 num_pending_packets;
 
+			u16 *xsk_reorder_queue;
+
 			u32 complq_mask; /* complq size is complq_mask + 1 */
 
 			/* QPL fields */
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index bb278727f4d9..6eb442096e02 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -38,6 +38,7 @@ netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
 					 netdev_features_t features);
 bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
 bool gve_xdp_poll_dqo(struct gve_notify_block *block);
+bool gve_xsk_tx_poll_dqo(struct gve_notify_block *block, int budget);
 int gve_rx_poll_dqo(struct gve_notify_block *block, int budget);
 int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 02020d5d2f92..b1aba3242435 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -427,6 +427,12 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 
 	if (block->rx) {
 		work_done = gve_rx_poll_dqo(block, budget);
+
+		/* Poll XSK TX as part of RX NAPI. Setup re-poll based on if
+		 * either datapath has more work to do.
+		 */
+		if (priv->xdp_prog)
+			reschedule |= gve_xsk_tx_poll_dqo(block, budget);
 		reschedule |= work_done == budget;
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index ce5370b741ec..6f1d515673d2 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -13,6 +13,7 @@
 #include <linux/tcp.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
+#include <net/xdp_sock_drv.h>
 
 /* Returns true if tx_bufs are available. */
 static bool gve_has_free_tx_qpl_bufs(struct gve_tx_ring *tx, int count)
@@ -241,6 +242,9 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 		tx->dqo.tx_ring = NULL;
 	}
 
+	kvfree(tx->dqo.xsk_reorder_queue);
+	tx->dqo.xsk_reorder_queue = NULL;
+
 	kvfree(tx->dqo.pending_packets);
 	tx->dqo.pending_packets = NULL;
 
@@ -345,6 +349,17 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 
 	tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next = -1;
 	atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);
+
+	/* Only alloc xsk pool for XDP queues */
+	if (idx >= cfg->qcfg->num_queues && cfg->num_xdp_rings) {
+		tx->dqo.xsk_reorder_queue =
+			kvcalloc(tx->dqo.complq_mask + 1,
+				 sizeof(tx->dqo.xsk_reorder_queue[0]),
+				 GFP_KERNEL);
+		if (!tx->dqo.xsk_reorder_queue)
+			goto err;
+	}
+
 	tx->dqo_compl.miss_completions.head = -1;
 	tx->dqo_compl.miss_completions.tail = -1;
 	tx->dqo_compl.timed_out_completions.head = -1;
@@ -992,6 +1007,38 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	return 0;
 }
 
+static void gve_xsk_reorder_queue_push_dqo(struct gve_tx_ring *tx,
+					   u16 completion_tag)
+{
+	u32 tail = atomic_read(&tx->dqo_tx.xsk_reorder_queue_tail);
+
+	tx->dqo.xsk_reorder_queue[tail] = completion_tag;
+	tail = (tail + 1) & tx->dqo.complq_mask;
+	atomic_set_release(&tx->dqo_tx.xsk_reorder_queue_tail, tail);
+}
+
+static struct gve_tx_pending_packet_dqo *
+gve_xsk_reorder_queue_head(struct gve_tx_ring *tx)
+{
+	u32 head = tx->dqo_compl.xsk_reorder_queue_head;
+
+	if (head == tx->dqo_compl.xsk_reorder_queue_tail) {
+		tx->dqo_compl.xsk_reorder_queue_tail =
+			atomic_read_acquire(&tx->dqo_tx.xsk_reorder_queue_tail);
+
+		if (head == tx->dqo_compl.xsk_reorder_queue_tail)
+			return NULL;
+	}
+
+	return &tx->dqo.pending_packets[tx->dqo.xsk_reorder_queue[head]];
+}
+
+static void gve_xsk_reorder_queue_pop_dqo(struct gve_tx_ring *tx)
+{
+	tx->dqo_compl.xsk_reorder_queue_head++;
+	tx->dqo_compl.xsk_reorder_queue_head &= tx->dqo.complq_mask;
+}
+
 /* Transmit a given skb and ring the doorbell. */
 netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev)
 {
@@ -1015,6 +1062,62 @@ netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static bool gve_xsk_tx_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
+			   int budget)
+{
+	struct xsk_buff_pool *pool = tx->xsk_pool;
+	struct xdp_desc desc;
+	bool repoll = false;
+	int sent = 0;
+
+	spin_lock(&tx->dqo_tx.xdp_lock);
+	for (; sent < budget; sent++) {
+		struct gve_tx_pending_packet_dqo *pkt;
+		s16 completion_tag;
+		dma_addr_t addr;
+		u32 desc_idx;
+
+		if (unlikely(!gve_has_avail_slots_tx_dqo(tx, 1, 1))) {
+			repoll = true;
+			break;
+		}
+
+		if (!xsk_tx_peek_desc(pool, &desc))
+			break;
+
+		pkt = gve_alloc_pending_packet(tx);
+		pkt->type = GVE_TX_PENDING_PACKET_DQO_XSK;
+		pkt->num_bufs = 0;
+		completion_tag = pkt - tx->dqo.pending_packets;
+
+		addr = xsk_buff_raw_get_dma(pool, desc.addr);
+		xsk_buff_raw_dma_sync_for_device(pool, addr, desc.len);
+
+		desc_idx = tx->dqo_tx.tail;
+		gve_tx_fill_pkt_desc_dqo(tx, &desc_idx,
+					 true, desc.len,
+					 addr, completion_tag, true,
+					 false);
+		++pkt->num_bufs;
+		gve_tx_update_tail(tx, desc_idx);
+		tx->dqo_tx.posted_packet_desc_cnt += pkt->num_bufs;
+		gve_xsk_reorder_queue_push_dqo(tx, completion_tag);
+	}
+
+	if (sent) {
+		gve_tx_put_doorbell_dqo(priv, tx->q_resources, tx->dqo_tx.tail);
+		xsk_tx_release(pool);
+	}
+
+	spin_unlock(&tx->dqo_tx.xdp_lock);
+
+	u64_stats_update_begin(&tx->statss);
+	tx->xdp_xsk_sent += sent;
+	u64_stats_update_end(&tx->statss);
+
+	return (sent == budget) || repoll;
+}
+
 static void add_to_list(struct gve_tx_ring *tx, struct gve_index_list *list,
 			struct gve_tx_pending_packet_dqo *pending_packet)
 {
@@ -1152,6 +1255,9 @@ static void gve_handle_packet_completion(struct gve_priv *priv,
 		pending_packet->xdpf = NULL;
 		gve_free_pending_packet(tx, pending_packet);
 		break;
+	case GVE_TX_PENDING_PACKET_DQO_XSK:
+		pending_packet->state = GVE_PACKET_STATE_XSK_COMPLETE;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -1251,8 +1357,34 @@ static void remove_timed_out_completions(struct gve_priv *priv,
 
 		remove_from_list(tx, &tx->dqo_compl.timed_out_completions,
 				 pending_packet);
+
+		/* Need to count XSK packets in xsk_tx_completed. */
+		if (pending_packet->type == GVE_TX_PENDING_PACKET_DQO_XSK)
+			pending_packet->state = GVE_PACKET_STATE_XSK_COMPLETE;
+		else
+			gve_free_pending_packet(tx, pending_packet);
+	}
+}
+
+static void gve_tx_process_xsk_completions(struct gve_tx_ring *tx)
+{
+	u32 num_xsks = 0;
+
+	while (true) {
+		struct gve_tx_pending_packet_dqo *pending_packet =
+			gve_xsk_reorder_queue_head(tx);
+
+		if (!pending_packet ||
+		    pending_packet->state != GVE_PACKET_STATE_XSK_COMPLETE)
+			break;
+
+		num_xsks++;
+		gve_xsk_reorder_queue_pop_dqo(tx);
 		gve_free_pending_packet(tx, pending_packet);
 	}
+
+	if (num_xsks)
+		xsk_tx_completed(tx->xsk_pool, num_xsks);
 }
 
 int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
@@ -1333,6 +1465,9 @@ int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	remove_miss_completions(priv, tx);
 	remove_timed_out_completions(priv, tx);
 
+	if (tx->xsk_pool)
+		gve_tx_process_xsk_completions(tx);
+
 	u64_stats_update_begin(&tx->statss);
 	tx->bytes_done += pkt_compl_bytes + reinject_compl_bytes;
 	tx->pkt_done += pkt_compl_pkts + reinject_compl_pkts;
@@ -1365,6 +1500,19 @@ bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean)
 	return compl_desc->generation != tx->dqo_compl.cur_gen_bit;
 }
 
+bool gve_xsk_tx_poll_dqo(struct gve_notify_block *rx_block, int budget)
+{
+	struct gve_rx_ring *rx = rx_block->rx;
+	struct gve_priv *priv = rx->gve;
+	struct gve_tx_ring *tx;
+
+	tx = &priv->tx[gve_xdp_tx_queue_id(priv, rx->q_num)];
+	if (tx->xsk_pool)
+		return gve_xsk_tx_dqo(priv, tx, budget);
+
+	return 0;
+}
+
 bool gve_xdp_poll_dqo(struct gve_notify_block *block)
 {
 	struct gve_tx_compl_desc *compl_desc;
-- 
2.50.0.727.gbf7dc18ff4-goog


