Return-Path: <netdev+bounces-49901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A67F3C8B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8D5282BEF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195DC8C2;
	Wed, 22 Nov 2023 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh/kq3Wz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9819C2CF
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFAC433D9;
	Wed, 22 Nov 2023 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624668;
	bh=1rmI8uIg1fczjGS3j0dpoVFXLV9JFBoCjHeaCq+vIpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh/kq3Wz13M8B3bsNvWUFJDw4sSA3R+GyW+UClkcQDaxNZIiC7szF7PdBfDGe1mpi
	 2VpEgWsWAn29ak1qjc6puzp9gEJI1prnEW7eJt+Lk1QRTZ/IcokrcHB0rGlfF/72fs
	 TB9W0bYprbWkdoGBjidfWpOXgqPs53s1BHYoE/ScKKUtM7MIV2/U6S1JDVF11KGmOx
	 KWXfHv5DSpekrh0Cmllp/XF7aqqy9uGjazuxHgYrWlpNsQWIr6Dv1Kdj6wrk7kvX+r
	 axbk9o4wJg6uCxmMeMGMCzH3rRKtgZVDZkTI1n1bsOkJ1CvPDVPw7qAAHHrxjNN9Mn
	 9b1LC1TINTKDw==
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
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 05/13] eth: link netdev to page_pools in drivers
Date: Tue, 21 Nov 2023 19:44:12 -0800
Message-ID: <20231122034420.1158898-6-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
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
v3: fix netsec build
v2: add netsec
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
 drivers/net/ethernet/socionext/netsec.c           | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8cf7b30bd03..e35e7e02538c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3331,6 +3331,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
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
index 0891e9e49ecb..5ab8b81b84e6 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1302,6 +1302,8 @@ static int netsec_setup_rx_dring(struct netsec_priv *priv)
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = NETSEC_RXBUF_HEADROOM,
 		.max_len = NETSEC_RX_BUF_SIZE,
+		.napi = &priv->napi,
+		.netdev = priv->ndev,
 	};
 	int i, err;
 
-- 
2.42.0


