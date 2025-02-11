Return-Path: <netdev+bounces-165265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEFA314EE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B141B3A8770
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB3267B63;
	Tue, 11 Feb 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcFgMXga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAB26462F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301717; cv=none; b=YiAFmmyZZi0gf4InIs5v32tr+r32bTbyT+i0ici3PzS4IgRqde0I9jxy6EbQLbpFz8YaIaVSYIXSJzR6Lkch6n6Zk6Eyda2ShheAz/vSz7lfoQtUth1isCo+OkkXpUYqqrhnIuxBEsMccQyESFv29zzPTaqfwz7ikxNHhvmwSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301717; c=relaxed/simple;
	bh=CArz82Anvc/7F9u1LnrrHmskQGbrAGkvw6Iw0x+5aGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI3jOUJdWdNoIEs+o61QTnsQBHzdtWlSe8ZXGaScJfoKnKpK/R46wOZxCn0JMo1M2PGO1R2yZiP2C4+BILLes1/eAs2cBk7yefbb7bC4UwCiCcpoePkqxi5caUIZSIGJZ1w0NiTLdYFvxMcnDzMrgUFHch3K5HvUTmSjXIOMAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcFgMXga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B8C4CEE7;
	Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301717;
	bh=CArz82Anvc/7F9u1LnrrHmskQGbrAGkvw6Iw0x+5aGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcFgMXgaSYtOmxkIxN9OZD4uoTUt6Oeq6lZnvFYgVuFoafVmssPQ+WxFvjRyvE8V4
	 Pw0/odxUD048dPV0/2iGAmDvsxeCVyrJlL7La7ouSBpPnKRMlttXhJNtd7aczpbKEs
	 RswHuh/pprkzHqAzU8m1JlXHnFBqtTyv9MYxIDaT31VRNZB++XQzsAb3mQ8eTwcNGf
	 MH3wtdMu0WHn7hWc9F9aFzxsSGPP2JVANTCNhfkst4p57QuryrMKvWjrbooPrg2nPW
	 D1S7PaMERRtpsQUbn9xD9e7gVbw1j/yuRbsrzotdAsi1/7fZxzCpFYvBkyPR8zEMXZ
	 650PZXpwlJqQw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: tariqt@nvidia.com,
	idosch@idosch.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/4] eth: mlx4: use the page pool for Rx buffers
Date: Tue, 11 Feb 2025 11:21:41 -0800
Message-ID: <20250211192141.619024-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211192141.619024-1-kuba@kernel.org>
References: <20250211192141.619024-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple conversion to page pool. Preserve the current fragmentation
logic / page splitting. Each page starts with a single frag reference,
and then we bump that when attaching to skbs. This can likely be
optimized further.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove unnecessary .max_len setting
v1: https://lore.kernel.org/20250205031213.358973-5-kuba@kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 55 +++++++-------------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 +--
 3 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 97311c98569f..ad0d91a75184 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -247,7 +247,6 @@ struct mlx4_en_tx_desc {
 
 struct mlx4_en_rx_alloc {
 	struct page	*page;
-	dma_addr_t	dma;
 	u32		page_offset;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 38d2d3aaf1e6..8dddf2e897e2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -52,57 +52,39 @@
 
 #include "mlx4_en.h"
 
-static int mlx4_alloc_page(struct mlx4_en_priv *priv,
-			   struct mlx4_en_rx_alloc *frag,
-			   gfp_t gfp)
-{
-	struct page *page;
-	dma_addr_t dma;
-
-	page = alloc_page(gfp);
-	if (unlikely(!page))
-		return -ENOMEM;
-	dma = dma_map_page(priv->ddev, page, 0, PAGE_SIZE, priv->dma_dir);
-	if (unlikely(dma_mapping_error(priv->ddev, dma))) {
-		__free_page(page);
-		return -ENOMEM;
-	}
-	frag->page = page;
-	frag->dma = dma;
-	frag->page_offset = priv->rx_headroom;
-	return 0;
-}
-
 static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 			       struct mlx4_en_rx_ring *ring,
 			       struct mlx4_en_rx_desc *rx_desc,
 			       struct mlx4_en_rx_alloc *frags,
 			       gfp_t gfp)
 {
+	dma_addr_t dma;
 	int i;
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp)) {
+			frags->page = page_pool_alloc_pages(ring->pp, gfp);
+			if (!frags->page) {
 				ring->alloc_fail++;
 				return -ENOMEM;
 			}
+			page_pool_fragment_page(frags->page, 1);
+			frags->page_offset = priv->rx_headroom;
+
 			ring->rx_alloc_pages++;
 		}
-		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
-						    frags->page_offset);
+		dma = page_pool_get_dma_addr(frags->page);
+		rx_desc->data[i].addr = cpu_to_be64(dma + frags->page_offset);
 	}
 	return 0;
 }
 
 static void mlx4_en_free_frag(const struct mlx4_en_priv *priv,
+			      struct mlx4_en_rx_ring *ring,
 			      struct mlx4_en_rx_alloc *frag)
 {
-	if (frag->page) {
-		dma_unmap_page(priv->ddev, frag->dma,
-			       PAGE_SIZE, priv->dma_dir);
-		__free_page(frag->page);
-	}
+	if (frag->page)
+		page_pool_put_full_page(ring->pp, frag->page, false);
 	/* We need to clear all fields, otherwise a change of priv->log_rx_info
 	 * could lead to see garbage later in frag->page.
 	 */
@@ -167,7 +149,7 @@ static void mlx4_en_free_rx_desc(const struct mlx4_en_priv *priv,
 	frags = ring->rx_info + (index << priv->log_rx_info);
 	for (nr = 0; nr < priv->num_frags; nr++) {
 		en_dbg(DRV, priv, "Freeing fragment:%d\n", nr);
-		mlx4_en_free_frag(priv, frags + nr);
+		mlx4_en_free_frag(priv, ring, frags + nr);
 	}
 }
 
@@ -470,7 +452,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 		if (unlikely(!page))
 			goto fail;
 
-		dma = frags->dma;
+		dma = page_pool_get_dma_addr(page);
 		dma_sync_single_range_for_cpu(priv->ddev, dma, frags->page_offset,
 					      frag_size, priv->dma_dir);
 
@@ -481,6 +463,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 		if (frag_info->frag_stride == PAGE_SIZE / 2) {
 			frags->page_offset ^= PAGE_SIZE / 2;
 			release = page_count(page) != 1 ||
+				  atomic_long_read(&page->pp_ref_count) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
 		} else if (!priv->rx_headroom) {
@@ -494,10 +477,9 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 			release = frags->page_offset + frag_info->frag_size > PAGE_SIZE;
 		}
 		if (release) {
-			dma_unmap_page(priv->ddev, dma, PAGE_SIZE, priv->dma_dir);
 			frags->page = NULL;
 		} else {
-			page_ref_inc(page);
+			page_pool_ref_page(page);
 		}
 
 		nr++;
@@ -767,7 +749,8 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			/* Get pointer to first fragment since we haven't
 			 * skb yet and cast it to ethhdr struct
 			 */
-			dma = frags[0].dma + frags[0].page_offset;
+			dma = page_pool_get_dma_addr(frags[0].page);
+			dma += frags[0].page_offset;
 			dma_sync_single_for_cpu(priv->ddev, dma, sizeof(*ethh),
 						DMA_FROM_DEVICE);
 
@@ -806,7 +789,8 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			void *orig_data;
 			u32 act;
 
-			dma = frags[0].dma + frags[0].page_offset;
+			dma = page_pool_get_dma_addr(frags[0].page);
+			dma += frags[0].page_offset;
 			dma_sync_single_for_cpu(priv->ddev, dma,
 						priv->frag_info[0].frag_size,
 						DMA_FROM_DEVICE);
@@ -869,6 +853,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 		skb = napi_get_frags(&cq->napi);
 		if (unlikely(!skb))
 			goto next;
+		skb_mark_for_recycle(skb);
 
 		if (unlikely(ring->hwtstamp_rx_filter == HWTSTAMP_FILTER_ALL)) {
 			u64 timestamp = mlx4_en_get_cqe_ts(cqe);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index fe1378a689a1..87f35bcbeff8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -44,6 +44,7 @@
 #include <linux/ipv6.h>
 #include <linux/indirect_call_wrapper.h>
 #include <net/ipv6.h>
+#include <net/page_pool/helpers.h>
 
 #include "mlx4_en.h"
 
@@ -350,9 +351,10 @@ u32 mlx4_en_recycle_tx_desc(struct mlx4_en_priv *priv,
 			    int napi_mode)
 {
 	struct mlx4_en_tx_info *tx_info = &ring->tx_info[index];
+	struct page_pool *pool = ring->recycle_ring->pp;
 
-	dma_unmap_page(priv->ddev, tx_info->map0_dma, PAGE_SIZE, priv->dma_dir);
-	put_page(tx_info->page);
+	/* Note that napi_mode = 0 means ndo_close() path, not budget = 0 */
+	page_pool_put_full_page(pool, tx_info->page, !!napi_mode);
 
 	return tx_info->nr_txbb;
 }
@@ -1189,7 +1191,7 @@ netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
 	tx_desc = ring->buf + (index << LOG_TXBB_SIZE);
 	data = &tx_desc->data;
 
-	dma = frame->dma;
+	dma = page_pool_get_dma_addr(frame->page);
 
 	tx_info->page = frame->page;
 	frame->page = NULL;
-- 
2.48.1


