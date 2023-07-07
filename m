Return-Path: <netdev+bounces-16106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF174B681
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B2E281885
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03AD174CB;
	Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36317725
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B94C433C9;
	Fri,  7 Jul 2023 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755187;
	bh=zomoltKLs2hXAeo5AVjwvvsCZTfjnGybcGYZvbxdstI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lt35gDFybV34l+xxIeEf8J60qq+xjoIzTarfszoUZOMy8K3XZSL0c0HVlwb4y/d9B
	 jPL/AH4ETttQfyzERBMzCgTuvK0So3lPbkl7H2yvPtfGt5CcD/xP1Zej3iwJzh6xy7
	 Y1a/LfY0PWvQgC1u91ExuR7tEWO4oNp8cQ5HPdSTNMmzohrf0fN2qSL5hHos4YOEqN
	 S0wC4dkCDL3RCzaKRT6jHfv/VwGuCgbRC42ZJHPS34/FHviZ2Pxoi6IYRQgcjGx7di
	 nNSScUkQbB9aHBG2PObwrpIZDOQ/jUuKItZffRb7GyO2gHe5R76HkadPJFD+UEARwi
	 tBglvT8x/b/6A==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 08/12] eth: bnxt: let the page pool manage the DMA mapping
Date: Fri,  7 Jul 2023 11:39:31 -0700
Message-ID: <20230707183935.997267-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the page pool's ability to maintain DMA mappings for us.
This avoid re-mapping recycled pages.

Note that pages in the pool are always mapped DMA_BIDIRECTIONAL,
so we should use that instead of looking at bp->rx_dir.

The syncing is probably wrong, TBH, I haven't studied the page
pool rules, they always confused me. But for a hack, who cares,
x86 :D

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 ++++++++---------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..6512514cd498 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -706,12 +706,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
-				      DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(dev, *mapping)) {
-		page_pool_recycle_direct(rxr->page_pool, page);
-		return NULL;
-	}
+	*mapping = page_pool_get_dma_addr(page);
+	dma_sync_single_for_device(dev, *mapping, PAGE_SIZE, DMA_BIDIRECTIONAL);
+
 	return page;
 }
 
@@ -951,6 +948,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 					      unsigned int offset_and_len)
 {
 	unsigned int len = offset_and_len & 0xffff;
+	struct device *dev = &bp->pdev->dev;
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
 	struct sk_buff *skb;
@@ -962,8 +960,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
+	dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
 	skb = build_skb(page_address(page), PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
@@ -984,6 +981,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 {
 	unsigned int payload = offset_and_len >> 16;
 	unsigned int len = offset_and_len & 0xffff;
+	struct device *dev = &bp->pdev->dev;
 	skb_frag_t *frag;
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
@@ -996,8 +994,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
+	dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -2943,9 +2940,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		rx_buf->data = NULL;
 		if (BNXT_RX_PAGE_MODE(bp)) {
 			mapping -= bp->rx_dma_offset;
-			dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
-					     bp->rx_dir,
-					     DMA_ATTR_WEAK_ORDERING);
 			page_pool_recycle_direct(rxr->page_pool, data);
 		} else {
 			dma_unmap_single_attrs(&pdev->dev, mapping,
@@ -2967,9 +2961,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 			continue;
 
 		if (BNXT_RX_PAGE_MODE(bp)) {
-			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
-					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-					     DMA_ATTR_WEAK_ORDERING);
 			rx_agg_buf->page = NULL;
 			__clear_bit(i, rxr->rx_agg_bmap);
 
@@ -3208,6 +3199,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 {
 	struct page_pool_params pp = { 0 };
 
+	pp.flags = PP_FLAG_DMA_MAP;
 	pp.pool_size = bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
-- 
2.41.0


