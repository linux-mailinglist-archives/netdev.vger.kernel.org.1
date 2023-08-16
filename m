Return-Path: <netdev+bounces-28272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD277EDEB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F0F1C211B3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA391E52D;
	Wed, 16 Aug 2023 23:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A51C9EF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D364FC433AD;
	Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229393;
	bh=kM7KDN6C6og0WfP4foy6Sw7lSPuayqqnmsqD1elAlSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCZ5vEQhlx37Hg300yyuvPe9QDFDDYvPDpykxoDYnd/DQ3+GBuwpcO7EqS84tiIpR
	 L90i0i1esC/9HOqxtMH7z04PN509WvPUB2kdOZ4xDOkDuYgkRYKtl4rouTi8/vcq14
	 dV1rcY2Vjhp6DMDcTJf7HeiSY7DOP9IzKyJ540b6aH3n1UdK69OULBYFcgtN4V+qB/
	 CUaahcNusVcvk9zfU7pM4GNZSPxlaIQm0+xOPFLid8czEHs+6fTGGcu1zEeL+EL6Ti
	 78T8vLSYJuKW8kdj9kms+fUptfB+N9i98KgNey9RrLbm8P2P1lVwgMvC7AXSfMDSZN
	 +153BcYiWS9tA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 07/13] eth: link netdev to pp
Date: Wed, 16 Aug 2023 16:42:56 -0700
Message-ID: <20230816234303.3786178-8-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7be917a8da48..06776196c05e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3247,6 +3247,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
+	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bc9d5a5bea01..f9ca600f47e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -839,6 +839,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.nid       = node;
 		pp_params.dev       = rq->pdev;
 		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4a16ebff3d1d..25286490e237 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2056,6 +2056,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
+	pprm.netdev = rxq->ndev;
 
 	rxq->page_pool = page_pool_create(&pprm);
 
-- 
2.41.0


