Return-Path: <netdev+bounces-49470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7357F21DE
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59491F26530
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498873C06A;
	Tue, 21 Nov 2023 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVnYHY6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DE3BB5B
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832CCC433C8;
	Tue, 21 Nov 2023 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524861;
	bh=+icS+PKnqBDFIe7xGCGWTpQsX9r2BZ0S3KQJ3WBWeWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVnYHY6QZZZf3KXhQZzqM6Aujq56hgBd56leOZUIMgmjBN52KY+G9K/p+GSuK9yfy
	 ByjB3avclITna/T4LiQYLFlmilSeBT+0zlw6Zjxi7iHSQELB8kjLLIbeicDNN5XES1
	 fZDRDFvXrBXg9ZqCxH0mqloUmYxwEhMnGkkKjHJ2FyNk3iVh+FDS3eXl+RAkvlo6Ib
	 9V+ssyfTQC8ALgMCBHFWwu7C4cr28sCKEymOxc2cvjo+NmktC5wxMtc1YbnwTadiWQ
	 DpkX4eX3KGllO7znMax5cm9KRW8qIMPZBWppdxt3h9ePqWeYjvJjMH4io7dz6y9wDW
	 sbqX2RGcjEhVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/15] eth: link netdev to page_pools in drivers
Date: Mon, 20 Nov 2023 16:00:40 -0800
Message-ID: <20231121000048.789613-8-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link page pool instances to netdev for the drivers which
already link to NAPI. Unless the driver is doing something
very weird per-NAPI should imply per-netdev.

Add netsec as well, Ilias indicates that it fits the mold.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: add netsec
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
 drivers/net/ethernet/socionext/netsec.c           | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e6ac1bd21bb3..68cf0036f867 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3322,6 +3322,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 		pp.pool_size += bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
+	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3aecdf099a2f..af5e0d3c8ee1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -902,6 +902,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.nid       = node;
 		pp_params.dev       = rq->pdev;
 		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fc3d2903a80f..d1adec01299c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2137,6 +2137,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
+	pprm.netdev = rxq->ndev;
 
 	rxq->page_pool = page_pool_create(&pprm);
 
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 0891e9e49ecb..384c506bb930 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1302,6 +1302,8 @@ static int netsec_setup_rx_dring(struct netsec_priv *priv)
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = NETSEC_RXBUF_HEADROOM,
 		.max_len = NETSEC_RX_BUF_SIZE,
+		.napi = priv->napi,
+		.netdev = priv->ndev,
 	};
 	int i, err;
 
-- 
2.42.0


