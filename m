Return-Path: <netdev+bounces-162852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C0A2826F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CE37A22F6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B2135C4;
	Wed,  5 Feb 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjuw1ZpQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E102135AF
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725167; cv=none; b=s08YcMwxGgq7SjefCoGA3NGm25XC5GU4qVm2MlihIx551d6u2ZaBLM4ETiu/whbHEO8S/0tU40ylcw3bQyk4WjhsDAKx57nDcMZiX3hQygiUz5FthSOIJf+EALYKUPL1f4YLPFq9tRMImIjxVuiZ3zgWQzkgPlOXO/Dm/MMPrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725167; c=relaxed/simple;
	bh=5QiXuyyyXDix7sFVat21/KxZlz14J27l6B75OFPh0Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwf6bgHQbgUVZt+rfUlJlaX2cYJcI+xsMursayhDQQETWB12Rzw8FppkZO4cQncD10yTLlspBApe4WolJ/n8ndgDNd8guUzHku4CFTMidaGauL/J/wISlGdm0AiY0guf9OuxqaIKZH1r/PfBJkEh16xQyQ0YD3uhQVIuyCG9Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjuw1ZpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E34C4CEE7;
	Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738725167;
	bh=5QiXuyyyXDix7sFVat21/KxZlz14J27l6B75OFPh0Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zjuw1ZpQVyQChWjVAQnRsO6fblvCRp6D8E8Knqd0XxYwysQgdcybtVWBvdYWq+q7D
	 2gq/0DZyHeyRBn0zI/Ox2Dojju/enZo1JuEy/QaNni8DFewaEJVBpGKZwRG7C7VsY+
	 sjilEyKErClfMw/8rSPJ+ylZCWir9vbPt76pHxtIBfX9hChNlzsQ9pVef/5cWaBos9
	 CY0+CKYYdYy9xbJ3B/JXJMnsM7X4YXJ3daKyBkQtT502PByLVuCM9ug9bMVFD2GwwH
	 9tdoSaUw9hXQ3svXa4zLD0p4ePt/SzD7XK9Z2TSXFtZ+kZF//qKRRXDyDzP65f1IU6
	 fAH0xXsGEFQkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	tariqt@nvidia.com,
	hawk@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] eth: mlx4: remove the local XDP fast-recycling ring
Date: Tue,  4 Feb 2025 19:12:12 -0800
Message-ID: <20250205031213.358973-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205031213.358973-1-kuba@kernel.org>
References: <20250205031213.358973-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be replaced with page pool's built-in recycling.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 11 ------
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 40 --------------------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   | 11 +-----
 3 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 29f48e63081b..97311c98569f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -253,14 +253,6 @@ struct mlx4_en_rx_alloc {
 
 #define MLX4_EN_CACHE_SIZE (2 * NAPI_POLL_WEIGHT)
 
-struct mlx4_en_page_cache {
-	u32 index;
-	struct {
-		struct page	*page;
-		dma_addr_t	dma;
-	} buf[MLX4_EN_CACHE_SIZE];
-};
-
 enum {
 	MLX4_EN_TX_RING_STATE_RECOVERING,
 };
@@ -343,7 +335,6 @@ struct mlx4_en_rx_ring {
 	void *buf;
 	void *rx_info;
 	struct bpf_prog __rcu *xdp_prog;
-	struct mlx4_en_page_cache page_cache;
 	unsigned long bytes;
 	unsigned long packets;
 	unsigned long csum_ok;
@@ -708,8 +699,6 @@ netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
 			       struct mlx4_en_priv *priv, unsigned int length,
 			       int tx_ind, bool *doorbell_pending);
 void mlx4_en_xmit_doorbell(struct mlx4_en_tx_ring *ring);
-bool mlx4_en_rx_recycle(struct mlx4_en_rx_ring *ring,
-			struct mlx4_en_rx_alloc *frame);
 
 int mlx4_en_create_tx_ring(struct mlx4_en_priv *priv,
 			   struct mlx4_en_tx_ring **pring,
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 2c23d75baf14..9de5449667bb 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -142,18 +142,6 @@ static int mlx4_en_prepare_rx_desc(struct mlx4_en_priv *priv,
 		(index << ring->log_stride);
 	struct mlx4_en_rx_alloc *frags = ring->rx_info +
 					(index << priv->log_rx_info);
-	if (likely(ring->page_cache.index > 0)) {
-		/* XDP uses a single page per frame */
-		if (!frags->page) {
-			ring->page_cache.index--;
-			frags->page = ring->page_cache.buf[ring->page_cache.index].page;
-			frags->dma  = ring->page_cache.buf[ring->page_cache.index].dma;
-		}
-		frags->page_offset = XDP_PACKET_HEADROOM;
-		rx_desc->data[0].addr = cpu_to_be64(frags->dma +
-						    XDP_PACKET_HEADROOM);
-		return 0;
-	}
 
 	return mlx4_en_alloc_frags(priv, ring, rx_desc, frags, gfp);
 }
@@ -430,26 +418,6 @@ void mlx4_en_recover_from_oom(struct mlx4_en_priv *priv)
 	}
 }
 
-/* When the rx ring is running in page-per-packet mode, a released frame can go
- * directly into a small cache, to avoid unmapping or touching the page
- * allocator. In bpf prog performance scenarios, buffers are either forwarded
- * or dropped, never converted to skbs, so every page can come directly from
- * this cache when it is sized to be a multiple of the napi budget.
- */
-bool mlx4_en_rx_recycle(struct mlx4_en_rx_ring *ring,
-			struct mlx4_en_rx_alloc *frame)
-{
-	struct mlx4_en_page_cache *cache = &ring->page_cache;
-
-	if (cache->index >= MLX4_EN_CACHE_SIZE)
-		return false;
-
-	cache->buf[cache->index].page = frame->page;
-	cache->buf[cache->index].dma = frame->dma;
-	cache->index++;
-	return true;
-}
-
 void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
 			     struct mlx4_en_rx_ring **pring,
 			     u32 size, u16 stride)
@@ -475,14 +443,6 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
 void mlx4_en_deactivate_rx_ring(struct mlx4_en_priv *priv,
 				struct mlx4_en_rx_ring *ring)
 {
-	int i;
-
-	for (i = 0; i < ring->page_cache.index; i++) {
-		dma_unmap_page(priv->ddev, ring->page_cache.buf[i].dma,
-			       PAGE_SIZE, priv->dma_dir);
-		put_page(ring->page_cache.buf[i].page);
-	}
-	ring->page_cache.index = 0;
 	mlx4_en_free_rx_buf(priv, ring);
 	if (ring->stride <= TXBB_SIZE)
 		ring->buf -= TXBB_SIZE;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 6e077d202827..fe1378a689a1 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -350,16 +350,9 @@ u32 mlx4_en_recycle_tx_desc(struct mlx4_en_priv *priv,
 			    int napi_mode)
 {
 	struct mlx4_en_tx_info *tx_info = &ring->tx_info[index];
-	struct mlx4_en_rx_alloc frame = {
-		.page = tx_info->page,
-		.dma = tx_info->map0_dma,
-	};
 
-	if (!napi_mode || !mlx4_en_rx_recycle(ring->recycle_ring, &frame)) {
-		dma_unmap_page(priv->ddev, tx_info->map0_dma,
-			       PAGE_SIZE, priv->dma_dir);
-		put_page(tx_info->page);
-	}
+	dma_unmap_page(priv->ddev, tx_info->map0_dma, PAGE_SIZE, priv->dma_dir);
+	put_page(tx_info->page);
 
 	return tx_info->nr_txbb;
 }
-- 
2.48.1


