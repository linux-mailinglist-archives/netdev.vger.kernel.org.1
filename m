Return-Path: <netdev+bounces-143490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C79C29C3
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E72842C3
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535344C9A;
	Sat,  9 Nov 2024 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqqLSxoF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6F33DF
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731124302; cv=none; b=bKsy6r7O8B85dJjNP/OfJBFwkloB6FDTAxDOfOgpcLFIwwKyTYUI/Danm+HGJwlpO8UkPfaj5ul2lV6LoMt5Q347xUv436+QqYvucbX8/YaO/qtDUHyJEWv/VqgRdYZPIfbs7iK974QvvDvF9DGuzSFJ+XqGfWtAzj8fiiAtqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731124302; c=relaxed/simple;
	bh=W8Sm3CRDukosvgca+wlElKx+QzXOc5tgOuHB/W6OBk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0e9U44h0WJMmEBd9d9Dod3SpgMbGKMr/4Ty50OsIqC4o/vLNDxfnAUIMsfuuE11im2h5N59F8YcY+Bo4cld9qjTgC+Yi5pwa6kr6rj/MIU2y1HltqqI/fqED9zVGsWDwucHGO4yJpb0IXrdHg+Hm4plMuJ51/Hjma4NoIhPuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqqLSxoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50239C4CEC6;
	Sat,  9 Nov 2024 03:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731124300;
	bh=W8Sm3CRDukosvgca+wlElKx+QzXOc5tgOuHB/W6OBk4=;
	h=From:To:Cc:Subject:Date:From;
	b=kqqLSxoFI1aij4SsfhmrJj5tdUssYo5K6wSyDwAJYMdCjpniZzI+UVCDEbMwvf/Du
	 HTVa3/cqTMSv1fyLkfpzyM04yhDKpYVJZQuqjUGaP99qpW5SUrwb04M7s1xSXhvS3X
	 XwBezyHeo9AXlKxDXeJNegpcSn/bgdj/lSsuXEN2YoU9HCItKaHEaY5wPpjWEHe0em
	 +JFj7taTG+OK7xsDBBq3GjHQ9oP5lIf3l95c/xxZdJsViI7586Hn7DEhPhxEle3FEp
	 BuwTs1KNHIjFKGOfaLO2oizGzJfq4tK5AuTTlqyLq1F1EIrItJgBRbX0i2aYHUg32N
	 VxEtQEhkOMGhA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH net-next] eth: bnxt: use page pool for head frags
Date: Fri,  8 Nov 2024 19:51:19 -0800
Message-ID: <20241109035119.3391864-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing small size RPCs (300B-400B) on a large AMD system suggests
that page pool recycling is very useful even for just the head frags.
With this patch (and copy break disabled) I see a 30% performance
improvement (82Gbps -> 106Gbps).

Convert bnxt from normal page frags to page pool frags for head buffers.

On systems with small page size we can use the same pool as for TPA
pages. On systems with large pages the frag allocation logic of the
page pool is already used to split a large page into TPA chunks.
TPA chunks are much larger than heads (8k or 64k, AFAICT vs 1kB)
and we always allocate the same sized chunks. Mixing allocation
of TPA and head pages would lead to sub-optimal memory use.
Plus Taehee's work on zero-copy / devmem will need to differentiate
between TPA and non-TPA page pool, anyway. Conditionally allocate
a new page pool for heads.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Taehee, I hope you don't mind me posting this before your v5 is ready.
Very much looking forward to the APIs you're adding, we need to be able
to increase the HDS threshold for bnxt when not used for zero-copy...

CC: michael.chan@broadcom.com
CC: ap420073@gmail.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 98 ++++++++++++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 98f589e1cbe4..bbb6abd27fed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -864,6 +864,11 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
+static bool bnxt_separate_head_pool(void)
+{
+	return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+}
+
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
 					 unsigned int *offset,
@@ -886,27 +891,19 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 }
 
 static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
+				       struct bnxt_rx_ring_info *rxr,
 				       gfp_t gfp)
 {
-	u8 *data;
-	struct pci_dev *pdev = bp->pdev;
+	unsigned int offset;
+	struct page *page;
 
-	if (gfp == GFP_ATOMIC)
-		data = napi_alloc_frag(bp->rx_buf_size);
-	else
-		data = netdev_alloc_frag(bp->rx_buf_size);
-	if (!data)
+	page = page_pool_alloc_frag(rxr->head_pool, &offset,
+				    bp->rx_buf_size, gfp);
+	if (!page)
 		return NULL;
 
-	*mapping = dma_map_single_attrs(&pdev->dev, data + bp->rx_dma_offset,
-					bp->rx_buf_use_size, bp->rx_dir,
-					DMA_ATTR_WEAK_ORDERING);
-
-	if (dma_mapping_error(&pdev->dev, *mapping)) {
-		skb_free_frag(data);
-		data = NULL;
-	}
-	return data;
+	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + offset;
+	return page_address(page) + offset;
 }
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
@@ -928,7 +925,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		rx_buf->data = page;
 		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
 	} else {
-		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, gfp);
+		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, rxr, gfp);
 
 		if (!data)
 			return -ENOMEM;
@@ -1179,13 +1176,14 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 	}
 
 	skb = napi_build_skb(data, bp->rx_buf_size);
-	dma_unmap_single_attrs(&bp->pdev->dev, dma_addr, bp->rx_buf_use_size,
-			       bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_buf_use_size,
+				bp->rx_dir);
 	if (!skb) {
-		skb_free_frag(data);
+		page_pool_free_va(rxr->head_pool, data, true);
 		return NULL;
 	}
 
+	skb_mark_for_recycle(skb);
 	skb_reserve(skb, bp->rx_offset);
 	skb_put(skb, offset_and_len & 0xffff);
 	return skb;
@@ -1840,7 +1838,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		u8 *new_data;
 		dma_addr_t new_mapping;
 
-		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, GFP_ATOMIC);
+		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
+						GFP_ATOMIC);
 		if (!new_data) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
@@ -1852,16 +1851,16 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		tpa_info->mapping = new_mapping;
 
 		skb = napi_build_skb(data, bp->rx_buf_size);
-		dma_unmap_single_attrs(&bp->pdev->dev, mapping,
-				       bp->rx_buf_use_size, bp->rx_dir,
-				       DMA_ATTR_WEAK_ORDERING);
+		dma_sync_single_for_cpu(&bp->pdev->dev, mapping,
+					bp->rx_buf_use_size, bp->rx_dir);
 
 		if (!skb) {
-			skb_free_frag(data);
+			page_pool_free_va(rxr->head_pool, data, true);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
+		skb_mark_for_recycle(skb);
 		skb_reserve(skb, bp->rx_offset);
 		skb_put(skb, len);
 	}
@@ -3308,28 +3307,22 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 
 static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	struct pci_dev *pdev = bp->pdev;
 	int i, max_idx;
 
 	max_idx = bp->rx_nr_pages * RX_DESC_CNT;
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
-		dma_addr_t mapping = rx_buf->mapping;
 		void *data = rx_buf->data;
 
 		if (!data)
 			continue;
 
 		rx_buf->data = NULL;
-		if (BNXT_RX_PAGE_MODE(bp)) {
+		if (BNXT_RX_PAGE_MODE(bp))
 			page_pool_recycle_direct(rxr->page_pool, data);
-		} else {
-			dma_unmap_single_attrs(&pdev->dev, mapping,
-					       bp->rx_buf_use_size, bp->rx_dir,
-					       DMA_ATTR_WEAK_ORDERING);
-			skb_free_frag(data);
-		}
+		else
+			page_pool_free_va(rxr->head_pool, data, true);
 	}
 }
 
@@ -3356,7 +3349,6 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 {
 	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
-	struct pci_dev *pdev = bp->pdev;
 	struct bnxt_tpa_idx_map *map;
 	int i;
 
@@ -3370,13 +3362,8 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		if (!data)
 			continue;
 
-		dma_unmap_single_attrs(&pdev->dev, tpa_info->mapping,
-				       bp->rx_buf_use_size, bp->rx_dir,
-				       DMA_ATTR_WEAK_ORDERING);
-
 		tpa_info->data = NULL;
-
-		skb_free_frag(data);
+		page_pool_free_va(rxr->head_pool, data, false);
 	}
 
 skip_rx_tpa_free:
@@ -3592,7 +3579,9 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		rxr->page_pool = NULL;
+		if (rxr->page_pool != rxr->head_pool)
+			page_pool_destroy(rxr->head_pool);
+		rxr->page_pool = rxr->head_pool = NULL;
 
 		kfree(rxr->rx_agg_bmap);
 		rxr->rx_agg_bmap = NULL;
@@ -3610,6 +3599,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   int numa_node)
 {
 	struct page_pool_params pp = { 0 };
+	struct page_pool *pool;
 
 	pp.pool_size = bp->rx_agg_ring_size;
 	if (BNXT_RX_PAGE_MODE(bp))
@@ -3622,14 +3612,25 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.max_len = PAGE_SIZE;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 
-	rxr->page_pool = page_pool_create(&pp);
-	if (IS_ERR(rxr->page_pool)) {
-		int err = PTR_ERR(rxr->page_pool);
+	pool = page_pool_create(&pp);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+	rxr->page_pool = pool;
 
-		rxr->page_pool = NULL;
-		return err;
+	if (bnxt_separate_head_pool()) {
+		pp.pool_size = max(bp->rx_ring_size, 1024);
+		pool = page_pool_create(&pp);
+		if (IS_ERR(pool))
+			goto err_destroy_pp;
 	}
+	rxr->head_pool = pool;
+
 	return 0;
+
+err_destroy_pp:
+	page_pool_destroy(rxr->page_pool);
+	rxr->page_pool = NULL;
+	return PTR_ERR(pool);
 }
 
 static int bnxt_alloc_rx_rings(struct bnxt *bp)
@@ -4180,7 +4181,8 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 		u8 *data;
 
 		for (i = 0; i < bp->max_tpa; i++) {
-			data = __bnxt_alloc_rx_frag(bp, &mapping, GFP_KERNEL);
+			data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
+						    GFP_KERNEL);
 			if (!data)
 				return -ENOMEM;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 69231e85140b..649955fa3e37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1105,6 +1105,7 @@ struct bnxt_rx_ring_info {
 	struct bnxt_ring_struct	rx_agg_ring_struct;
 	struct xdp_rxq_info	xdp_rxq;
 	struct page_pool	*page_pool;
+	struct page_pool	*head_pool;
 };
 
 struct bnxt_rx_sw_stats {
-- 
2.47.0


