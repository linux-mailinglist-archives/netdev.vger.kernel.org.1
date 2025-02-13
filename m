Return-Path: <netdev+bounces-165743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23828A33460
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14153A3867
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DC78F49;
	Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9IDLehn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A307081A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408802; cv=none; b=gLHq3SN+yqtZkTO8wGJ1Oik/bCIZNG07KfavuT2t/9ih7IzKOLUAGFfCtydW1M9Cnemzd5vmhZoa36J/wOuPI+uNrtrHwHPyNZXdUC0ELd6IpnoCvWDHZxZ+Qm9Z5I4FYnsmHwemv80wimSk8Yw2apql6zWb7ATNBw2sXmX5KJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408802; c=relaxed/simple;
	bh=rImjUt0qc0DeiY9g5lZl4Ra6VLDP0VtNaaWhl2uBUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV7HXAVyq1U+eQGJ0cYsVGwHauiUaaB6kTspUNpnG12ypHVcKAVkMcU370BCt0lGnmy6TnpZ8BZToPkww2Pi0dVZ5gUpX5M5jv+RI+ZfaFeKGlKLw+P7K26KftYHpBc+rg76G+t+2SyzQPIFACsooZydMrdkkMHYh6bhu+4WJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9IDLehn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07E2C4CEE5;
	Thu, 13 Feb 2025 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739408801;
	bh=rImjUt0qc0DeiY9g5lZl4Ra6VLDP0VtNaaWhl2uBUg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9IDLehnyz6iuxXe8aRwiihkVgLjMY6g+y0cUGpjWhTJak7IRI88oXM039p8ZeFqN
	 aFG8BQjSgZqXIL2E+toBcPJq86resrc7kNzH7XqG6tj9nIAoj9usqAerEfEGCSDEdk
	 40ZATOXbrxJ66BmgU+buQAc3hmgWfWcioVgUfHe2a+duJfB7S9xy8PHGx975ICl6ch
	 1EvTBzzNKtyvaC0ZRTz9VlVKu2rqtk9LY51Hnct84XyUGzVn5U2un1cBSdYj8huhSl
	 jfL9tlsSiLM2u1UAjE/qTuXlIvcSbsyc1qhYfa/giHYv0J5C43fj88yytJzcTYMLeb
	 qUaiwhTXAYQjg==
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
Subject: [PATCH net-next v3 1/4] eth: mlx4: create a page pool for Rx
Date: Wed, 12 Feb 2025 17:06:32 -0800
Message-ID: <20250213010635.1354034-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213010635.1354034-1-kuba@kernel.org>
References: <20250213010635.1354034-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a pool per rx queue. Subsequent patches will make use of it.

Move fcs_del to a hole to make space for the pointer.

Per common "wisdom" base the page pool size on the ring size.
Note that the page pool cache size is in full pages, so just
round up the effective buffer size to pages.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - use priv->rx_skb_size for effective buffer size
 - use priv->dma_dir for DMA mapping direction, instead of always BIDIR
v2: https://lore.kernel.org/20250211192141.619024-2-kuba@kernel.org
 - update pp.pool_size
v1: https://lore.kernel.org/20250205031213.358973-2-kuba@kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  3 ++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 24 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 28b70dcc652e..29f48e63081b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -335,10 +335,11 @@ struct mlx4_en_rx_ring {
 	u16 stride;
 	u16 log_stride;
 	u16 cqn;	/* index of port CQ associated with this ring */
+	u8  fcs_del;
 	u32 prod;
 	u32 cons;
 	u32 buf_size;
-	u8  fcs_del;
+	struct page_pool *pp;
 	void *buf;
 	void *rx_info;
 	struct bpf_prog __rcu *xdp_prog;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 15c57e9517e9..a8c0cf5d0d08 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -48,6 +48,7 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_checksum.h>
 #endif
+#include <net/page_pool/helpers.h>
 
 #include "mlx4_en.h"
 
@@ -268,6 +269,7 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 			   u32 size, u16 stride, int node, int queue_index)
 {
 	struct mlx4_en_dev *mdev = priv->mdev;
+	struct page_pool_params pp = {};
 	struct mlx4_en_rx_ring *ring;
 	int err = -ENOMEM;
 	int tmp;
@@ -286,9 +288,26 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	ring->log_stride = ffs(ring->stride) - 1;
 	ring->buf_size = ring->size * ring->stride + TXBB_SIZE;
 
-	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
+	pp.flags = PP_FLAG_DMA_MAP;
+	pp.pool_size = size * DIV_ROUND_UP(priv->rx_skb_size, PAGE_SIZE);
+	pp.nid = node;
+	pp.napi = &priv->rx_cq[queue_index]->napi;
+	pp.netdev = priv->dev;
+	pp.dev = &mdev->dev->persist->pdev->dev;
+	pp.dma_dir = priv->dma_dir;
+
+	ring->pp = page_pool_create(&pp);
+	if (!ring->pp)
 		goto err_ring;
 
+	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
+		goto err_pp;
+
+	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 ring->pp);
+	if (err)
+		goto err_xdp_info;
+
 	tmp = size * roundup_pow_of_two(MLX4_EN_MAX_RX_FRAGS *
 					sizeof(struct mlx4_en_rx_alloc));
 	ring->rx_info = kvzalloc_node(tmp, GFP_KERNEL, node);
@@ -319,6 +338,8 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	ring->rx_info = NULL;
 err_xdp_info:
 	xdp_rxq_info_unreg(&ring->xdp_rxq);
+err_pp:
+	page_pool_destroy(ring->pp);
 err_ring:
 	kfree(ring);
 	*pring = NULL;
@@ -445,6 +466,7 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
 	xdp_rxq_info_unreg(&ring->xdp_rxq);
 	mlx4_free_hwq_res(mdev->dev, &ring->wqres, size * stride + TXBB_SIZE);
 	kvfree(ring->rx_info);
+	page_pool_destroy(ring->pp);
 	ring->rx_info = NULL;
 	kfree(ring);
 	*pring = NULL;
-- 
2.48.1


