Return-Path: <netdev+bounces-165262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6818A314EA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415787A2044
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43FA263893;
	Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGodYFuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA026388A
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301715; cv=none; b=cddpOfs6EFVOLbhgsGwAMPAmdaPuuNWWZAoDjQttOPnKKwylh3y3tdcjKbNvp+WRlLPm+eqNqJPQ28uFlrBJh1XQaa1nSnvyv86UOEm6g+nlY2Yy2pRwDMZOxPbx8aCdIz+i85bhgSEMUfE3fuiy+KmNTMbiADtFS8kCHxsdrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301715; c=relaxed/simple;
	bh=tW8Bs/nVipPnXytH2eHzZkTc5yJj6BBCn2FI1QtZyho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP7+1PI3VvOmDHK/f1xoLMIcbPl+BvkY2nCRFstTpvVm1+Qwbt9wokw2uG/Jfk4n4Mfo4Ajr2Kz4LOaM8R9Yp61yq8KkwX3ekY4darQmpjb8bQfYSNKjLBcrQ3OzJLG53XgmbFJd1ru80GD4mgsPjCFsfl/rTADirgrHeXUozt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGodYFuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC6C4CEEA;
	Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301715;
	bh=tW8Bs/nVipPnXytH2eHzZkTc5yJj6BBCn2FI1QtZyho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGodYFuwot6n+In7oDaV6aBBeJJ1IgEirphFwUX1weQ+sbZJbZY9sk7583wtUo79j
	 twf58kEa74iEtVyWk6Uobz8l01vmVjXiKxxsdbLc8RgdMT6LNnSXpTygIdh4dVCJxq
	 JltubicTr/jI28gmGEvxKvudFc8DAV9qh6Jbb7UryOtexTtafVySpu4wJE2TkFbebQ
	 6K1qWwxTyoe9+VzJPU0dJjw66RhLZ4QWQ8FAc9qGrQx6sgvSo8DFML1mWg05f2CEWf
	 zWmIQCcZy70XI/gLqFmDvcigVCN+7R01pIS7otcpXwOJ77lDQFl4XMTPGRSBL9j5N+
	 szQ6Nx+9/ou1w==
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
Subject: [PATCH net-next v2 1/4] eth: mlx4: create a page pool for Rx
Date: Tue, 11 Feb 2025 11:21:38 -0800
Message-ID: <20250211192141.619024-2-kuba@kernel.org>
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

Create a pool per rx queue. Subsequent patches will make use of it.

Move fcs_del to a hole to make space for the pointer.

Per common "wisdom" base the page pool size on the ring size.
Note that the page pool cache size is in full pages, so just
round up the effective buffer size to pages.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - update pp.pool_size
v1: https://lore.kernel.org/20250205031213.358973-2-kuba@kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  3 ++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 25 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

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
index 15c57e9517e9..da57ab39d4bd 100644
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
@@ -286,9 +288,27 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	ring->log_stride = ffs(ring->stride) - 1;
 	ring->buf_size = ring->size * ring->stride + TXBB_SIZE;
 
-	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
+	pp.flags = PP_FLAG_DMA_MAP;
+	pp.pool_size =
+		size * DIV_ROUND_UP(MLX4_EN_EFF_MTU(priv->dev->mtu), PAGE_SIZE);
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
@@ -319,6 +339,8 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	ring->rx_info = NULL;
 err_xdp_info:
 	xdp_rxq_info_unreg(&ring->xdp_rxq);
+err_pp:
+	page_pool_destroy(ring->pp);
 err_ring:
 	kfree(ring);
 	*pring = NULL;
@@ -445,6 +467,7 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
 	xdp_rxq_info_unreg(&ring->xdp_rxq);
 	mlx4_free_hwq_res(mdev->dev, &ring->wqres, size * stride + TXBB_SIZE);
 	kvfree(ring->rx_info);
+	page_pool_destroy(ring->pp);
 	ring->rx_info = NULL;
 	kfree(ring);
 	*pring = NULL;
-- 
2.48.1


