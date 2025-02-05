Return-Path: <netdev+bounces-162850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0EA2826D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D3B3A5F92
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920A213237;
	Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udq+gqUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3B212FB9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725166; cv=none; b=QH7UgK2Ru6NNw8eLOqVwnGAue5+6oxpFbEnopfgnDKECBfZ9QC8zOt1U551aTLkVpd6mAIiybZW/F7KAPuxxzwpj/2FLOfAMSz3xyrIlIQyUmBvn0bGbF7SnMjDsU3B6mDKdwEhGBsHCrnnWvJ5wGwTfbmpVGXUcAqq2Kigpx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725166; c=relaxed/simple;
	bh=21PdyqdVZaQwS6A74Dvn9/fchNwQCpV6x0EdY8s6XGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJFsTbZZLTyITBe+TN79RMP/1fIdsMdQKxQu/c+1IYlVvSg2lxwiqK7J5M/zrqlGhdl0fJhd/LlJR7RKNdDO+JG2w5eeN0hKHQxoPoDSUPWH9LrYdfcSAE6bzJYx8hQKPPuBuIRsvPKL9lHABUKNfEZYQmEV2mJfNlo1J+keD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udq+gqUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B4C4CEE8;
	Wed,  5 Feb 2025 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738725166;
	bh=21PdyqdVZaQwS6A74Dvn9/fchNwQCpV6x0EdY8s6XGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udq+gqUOkt+oJEF9TL4XjHCuWTmc1pV1Cx4Zy5Y8x+wmzZn6EgTy2ofEewsdFYjO4
	 pi5U4049EzS9dcbD+y79PBuimRPIchbSmJ5/0lIiv4ZPbkugh5+5sw2kHYQaGlaKZm
	 uyi3MiTsvo9mAsrcsclmWyYk7Sfd/BoUAGmTwtQU3mI28Ivx1svf8GS0PIpOs0RS+e
	 tfEvNE5vDvGhvjrU/lZ9kzMxgWkybAK0OOLtEh/iHrzrQ5L0/l4T5Kn4e2Kg5tcYG1
	 MyEvrP2Wa6G1I09HEQrgD/hS5V09c+cL9oYxh0003OwUlQS3TOGf9VkrZjNozcQwGc
	 5swjX6lTcfwdA==
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
Subject: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
Date: Tue,  4 Feb 2025 19:12:10 -0800
Message-ID: <20250205031213.358973-2-kuba@kernel.org>
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

Create a pool per rx queue. Subsequent patches will make use of it.

Move fcs_del to a hole to make space for the pointer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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
index 15c57e9517e9..2c23d75baf14 100644
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
+	pp.pool_size = MLX4_EN_MAX_RX_SIZE;
+	pp.nid = node;
+	pp.napi = &priv->rx_cq[queue_index]->napi;
+	pp.netdev = priv->dev;
+	pp.dev = &mdev->dev->persist->pdev->dev;
+	pp.dma_dir = DMA_BIDIRECTIONAL;
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


