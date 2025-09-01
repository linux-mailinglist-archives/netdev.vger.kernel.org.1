Return-Path: <netdev+bounces-218914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D67B3F057
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33544E05C6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E03274666;
	Mon,  1 Sep 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeLyfstr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A63246348
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761138; cv=none; b=JHsd8tLPY97AouphKtNOgf4Gl7tMXR8MYpf6RIxAf3YMzSMIHYv1U8P8g4nd2kFqrZnBbof41rXoGpJNiO9rIxNj8H+f+nCz0ahEiaAoLbxoVvCPF8oync50q10DmMH3sstjpNGZwTZ06pJifqQJTXT9EheEADh+bZL7bjxfwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761138; c=relaxed/simple;
	bh=4K59TJe1DfIMEYcT8ckH9g0jFKBgt3cMqRX12YDOW/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OafH9KH6lglL2rno0eISwnHOr0dpd1tDXGAy/nqsTgfT8Va0gD7REJi56Ed5h/PjInFaoudp5J/iT923mtQxSzMQn5nyp0+yjul/+KTouG28jq0u4KXnIzn7DYZ+gzcg+RJoYUqL89wNutZ8BHfIW1hbcxvj2i71YAE0ianhv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeLyfstr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EF6C4CEF5;
	Mon,  1 Sep 2025 21:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761138;
	bh=4K59TJe1DfIMEYcT8ckH9g0jFKBgt3cMqRX12YDOW/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeLyfstrp4m4w5B3pDXU/3+4fUgVgduOjYp38y0wOuH7eptLHWiEzVe0GwCDgst9q
	 Alp7KLZaEcOYNNabmocZe7Ole9khBByGd7uIqODdabpqNGaXOJMPu/gdlW997lxsPu
	 /SDItKZqrZt7q9D0Ei8UCVePOeUjuk+FC/6xfbkhzVIvK64pNDOKNjp4Kez86+z8Oe
	 n5ctg3MnHBlU31oy0oWvbe07B7AgjzrQbJgZi4DICo/6rzZh2dQJeUZRnlHdrylKIW
	 tYs+J4cO2ThNAq7+cZouAnOJhsrXlFbAFo+D6f+9t1YxkTHLQhMhz4mIt1XIwCR1yH
	 2Fr8OKKfjtaog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 01/14] eth: fbnic: move page pool pointer from NAPI to the ring struct
Date: Mon,  1 Sep 2025 14:12:01 -0700
Message-ID: <20250901211214.1027927-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for memory providers we need a closer association
between queues and page pools. We used to have a page pool at the
NAPI level to serve all associated queues but with MP the queues
under a NAPI may no longer be created equal.

The "ring" structure in fbnic is a descriptor ring. We have separate
"rings" for payload and header pages ("to device"), as well as a ring
for completions ("from device"). Technically we only need the page
pool pointers in the "to device" rings, so adding the pointer to
the ring struct is a bit wasteful. But it makes passing the structures
around much easier.

For now both "to device" rings store a pointer to the same
page pool. Using more than one queue per NAPI is extremely rare
so don't bother trying to share a single page pool between queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 16 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 83 +++++++++++---------
 2 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 873440ca6a31..a935a1acfb3e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -121,11 +121,16 @@ struct fbnic_ring {
 
 	u32 head, tail;			/* Head/Tail of ring */
 
-	/* Deferred_head is used to cache the head for TWQ1 if an attempt
-	 * is made to clean TWQ1 with zero napi_budget. We do not use it for
-	 * any other ring.
-	 */
-	s32 deferred_head;
+	union {
+		/* Rx BDQs only */
+		struct page_pool *page_pool;
+
+		/* Deferred_head is used to cache the head for TWQ1 if
+		 * an attempt is made to clean TWQ1 with zero napi_budget.
+		 * We do not use it for any other ring.
+		 */
+		s32 deferred_head;
+	};
 
 	struct fbnic_queue_stats stats;
 
@@ -142,7 +147,6 @@ struct fbnic_q_triad {
 struct fbnic_napi_vector {
 	struct napi_struct napi;
 	struct device *dev;		/* Device for DMA unmapping */
-	struct page_pool *page_pool;
 	struct fbnic_dev *fbd;
 
 	u16 v_idx;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index fea4577e38d4..7f8bdb08db9f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -640,7 +640,7 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(nv->page_pool, page, -1, pp_allow_direct);
+		page_pool_put_page(page->pp, page, -1, pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;
@@ -735,13 +735,13 @@ static struct page *fbnic_page_pool_get(struct fbnic_ring *ring,
 }
 
 static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
-				  struct fbnic_napi_vector *nv, int budget)
+				  int budget)
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 	struct page *page = rx_buf->page;
 
 	if (!page_pool_unref_page(page, rx_buf->pagecnt_bias))
-		page_pool_put_unrefed_page(nv->page_pool, page, -1, !!budget);
+		page_pool_put_unrefed_page(ring->page_pool, page, -1, !!budget);
 
 	rx_buf->page = NULL;
 }
@@ -826,8 +826,8 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0, head1);
 }
 
-static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
-			    struct fbnic_ring *ring, unsigned int hw_head)
+static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
+			    int napi_budget)
 {
 	unsigned int head = ring->head;
 
@@ -835,7 +835,7 @@ static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
 		return;
 
 	do {
-		fbnic_page_pool_drain(ring, head, nv, napi_budget);
+		fbnic_page_pool_drain(ring, head, napi_budget);
 
 		head++;
 		head &= ring->size_mask;
@@ -865,7 +865,7 @@ static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, struct page *page)
 	} while (--i);
 }
 
-static void fbnic_fill_bdq(struct fbnic_napi_vector *nv, struct fbnic_ring *bdq)
+static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 {
 	unsigned int count = fbnic_desc_unused(bdq);
 	unsigned int i = bdq->tail;
@@ -876,7 +876,7 @@ static void fbnic_fill_bdq(struct fbnic_napi_vector *nv, struct fbnic_ring *bdq)
 	do {
 		struct page *page;
 
-		page = page_pool_dev_alloc_pages(nv->page_pool);
+		page = page_pool_dev_alloc_pages(bdq->page_pool);
 		if (!page) {
 			u64_stats_update_begin(&bdq->stats.syncp);
 			bdq->stats.rx.alloc_failed++;
@@ -997,7 +997,7 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	}
 }
 
-static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
+static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
 	struct page *page;
@@ -1014,12 +1014,13 @@ static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 
 		while (nr_frags--) {
 			page = skb_frag_page(&shinfo->frags[nr_frags]);
-			page_pool_put_full_page(nv->page_pool, page, !!budget);
+			page_pool_put_full_page(qt->sub1.page_pool, page,
+						!!budget);
 		}
 	}
 
 	page = virt_to_page(pkt->buff.data_hard_start);
-	page_pool_put_full_page(nv->page_pool, page, !!budget);
+	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
 }
 
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
@@ -1274,7 +1275,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 					dropped++;
 				}
 
-				fbnic_put_pkt_buff(nv, pkt, 1);
+				fbnic_put_pkt_buff(qt, pkt, 1);
 			}
 
 			pkt->buff.data_hard_start = NULL;
@@ -1307,12 +1308,12 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
-		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
-	fbnic_fill_bdq(nv, &qt->sub0);
+		fbnic_clean_bdq(&qt->sub0, head0, budget);
+	fbnic_fill_bdq(&qt->sub0);
 
 	if (head1 >= 0)
-		fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
-	fbnic_fill_bdq(nv, &qt->sub1);
+		fbnic_clean_bdq(&qt->sub1, head1, budget);
+	fbnic_fill_bdq(&qt->sub1);
 
 	/* Record the current head/tail of the queue */
 	if (rcq->head != head) {
@@ -1462,6 +1463,12 @@ static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
 	fbn->rx[rxr->q_idx] = NULL;
 }
 
+static void fbnic_free_qt_page_pools(struct fbnic_q_triad *qt)
+{
+	page_pool_destroy(qt->sub0.page_pool);
+	page_pool_destroy(qt->sub1.page_pool);
+}
+
 static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 				   struct fbnic_napi_vector *nv)
 {
@@ -1479,10 +1486,10 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
+		fbnic_free_qt_page_pools(&nv->qt[i]);
 	}
 
 	fbnic_napi_free_irq(fbd, nv);
-	page_pool_destroy(nv->page_pool);
 	netif_napi_del(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
 	kfree(nv);
@@ -1500,13 +1507,14 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 #define FBNIC_PAGE_POOL_FLAGS \
 	(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
 
-static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
-				    struct fbnic_napi_vector *nv)
+static int
+fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
+			  struct fbnic_q_triad *qt)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = FBNIC_PAGE_POOL_FLAGS,
-		.pool_size = (fbn->hpq_size + fbn->ppq_size) * nv->rxt_count,
+		.pool_size = fbn->hpq_size + fbn->ppq_size,
 		.nid = NUMA_NO_NODE,
 		.dev = nv->dev,
 		.dma_dir = DMA_BIDIRECTIONAL,
@@ -1533,7 +1541,9 @@ static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
 	if (IS_ERR(pp))
 		return PTR_ERR(pp);
 
-	nv->page_pool = pp;
+	qt->sub0.page_pool = pp;
+	page_pool_get(pp);
+	qt->sub1.page_pool = pp;
 
 	return 0;
 }
@@ -1599,17 +1609,10 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	/* Tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
 
-	/* Allocate page pool */
-	if (rxq_count) {
-		err = fbnic_alloc_nv_page_pool(fbn, nv);
-		if (err)
-			goto napi_del;
-	}
-
 	/* Request the IRQ for napi vector */
 	err = fbnic_napi_request_irq(fbd, nv);
 	if (err)
-		goto pp_destroy;
+		goto napi_del;
 
 	/* Initialize queue triads */
 	qt = nv->qt;
@@ -1679,10 +1682,14 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
 		fbn->rx[rxq_idx] = &qt->cmpl;
 
+		err = fbnic_alloc_qt_page_pools(fbn, nv, qt);
+		if (err)
+			goto free_ring_cur_qt;
+
 		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
 				       nv->napi.napi_id);
 		if (err)
-			goto free_ring_cur_qt;
+			goto free_qt_pp;
 
 		/* Update Rx queue index */
 		rxt_count--;
@@ -1698,6 +1705,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		qt--;
 
 		xdp_rxq_info_unreg(&qt->xdp_rxq);
+free_qt_pp:
+		fbnic_free_qt_page_pools(qt);
 free_ring_cur_qt:
 		fbnic_remove_rx_ring(fbn, &qt->sub0);
 		fbnic_remove_rx_ring(fbn, &qt->sub1);
@@ -1714,8 +1723,6 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		txt_count++;
 	}
 	fbnic_napi_free_irq(fbd, nv);
-pp_destroy:
-	page_pool_destroy(nv->page_pool);
 napi_del:
 	netif_napi_del(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
@@ -2019,7 +2026,7 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 		/* Register XDP memory model for completion queue */
 		err = xdp_reg_mem_model(&nv->qt[i].xdp_rxq.mem,
 					MEM_TYPE_PAGE_POOL,
-					nv->page_pool);
+					nv->qt[i].sub0.page_pool);
 		if (err)
 			goto xdp_unreg_mem_model;
 
@@ -2333,13 +2340,13 @@ void fbnic_flush(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			/* Clean the work queues of unprocessed work */
-			fbnic_clean_bdq(nv, 0, &qt->sub0, qt->sub0.tail);
-			fbnic_clean_bdq(nv, 0, &qt->sub1, qt->sub1.tail);
+			fbnic_clean_bdq(&qt->sub0, qt->sub0.tail, 0);
+			fbnic_clean_bdq(&qt->sub1, qt->sub1.tail, 0);
 
 			/* Reset completion queue descriptor ring */
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
 
-			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
+			fbnic_put_pkt_buff(qt, qt->cmpl.pkt, 0);
 			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
 		}
 	}
@@ -2360,8 +2367,8 @@ void fbnic_fill(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			/* Populate the header and payload BDQs */
-			fbnic_fill_bdq(nv, &qt->sub0);
-			fbnic_fill_bdq(nv, &qt->sub1);
+			fbnic_fill_bdq(&qt->sub0);
+			fbnic_fill_bdq(&qt->sub1);
 		}
 	}
 }
-- 
2.51.0


