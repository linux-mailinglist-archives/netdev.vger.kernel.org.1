Return-Path: <netdev+bounces-165264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8FA314ED
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C07A25B3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08843264604;
	Tue, 11 Feb 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5hzdK3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BA2638B9
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301716; cv=none; b=aA9q8MO8yct2/rX45tuTnf6ulejKCZDaJxNmnhcv82gM5HDVl+57CApwNXmENIvFNqswb0a49QB5YELh7TsQe0M8xCH+uxzmpYBMDjFr2G8z6x9zKlSp8570I7TR+rS99v9te5xDFUL3zaLZOXIGl5JfWPKLVJb+x0Fy8p7Buhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301716; c=relaxed/simple;
	bh=fSPkE7Mv3vTWh6CGvDBIhihiYlnu+RRShY7EuN6XNWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYwOhgB1yqTcb/c3kHSqRBAb40z0qKxC1w2K9LT8bPGtWhILuug84yYSyarAuPfcDVCsN3c4GYjHwvWMD+VtjlTo74ot+VMsl6shkEBKW55FYGq0vTIc826aEVjHpYHJ9SaY1zEcRsCh2FA0xlEGwlFZefMRpdAh0aCo8mk9gxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5hzdK3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50049C4CEED;
	Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301716;
	bh=fSPkE7Mv3vTWh6CGvDBIhihiYlnu+RRShY7EuN6XNWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5hzdK3DQbJr/NRg1iUfupXxI3XQQfTEabY9xuPhsrDTIARhim4LpeuvJ2Le5hyyu
	 TaWC1ao7ZPeEyu6iuYSd/GjoqiJJz75xBxOvilgJmXylcX8hpgk2SYks2M/1u9sG0A
	 SJ7tnt7+Abu0TsfOuhX464a9Ps5wriEeEG5UXgFdLWL2qvaCyXDMulnRqyP8Wn1AlF
	 KOxtitY5zK7Q0ZT5JLqzSt/6xjIFOgIxqtEjOiTpSCt5RmY1hP1CaBv1fR1AL/5NA8
	 AXwbXxeu+pPhR+jLXyVprB+z10O5VMkYjTVmkK7xEvIRU4tL8OyujB/m45/qcEZk9O
	 hrzESJTGvPf1A==
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
Subject: [PATCH net-next v2 3/4] eth: mlx4: remove the local XDP fast-recycling ring
Date: Tue, 11 Feb 2025 11:21:40 -0800
Message-ID: <20250211192141.619024-4-kuba@kernel.org>
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

It will be replaced with page pool's built-in recycling.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
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
index da57ab39d4bd..38d2d3aaf1e6 100644
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
@@ -431,26 +419,6 @@ void mlx4_en_recover_from_oom(struct mlx4_en_priv *priv)
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
@@ -476,14 +444,6 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
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


