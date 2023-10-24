Return-Path: <netdev+bounces-43922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F07D5743
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A475F281A64
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B243A26D;
	Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glUSDVsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC43A265
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83CC433D9;
	Tue, 24 Oct 2023 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163364;
	bh=bAbrp+PwATunC6AisJFm+R5C2NoS2C5HzBAtTGgwWfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glUSDVsXYriJZvUHS/HnTNXodnVzeLZtYWJcHVu8NxWnlbnhkaHz07Bb/9ZOZSPxU
	 XwNtHuW5YvX81VNG0kwkcZaveYukDvUIPw2jF99kVKDOJPkHnTtJTLWBywrfhz2Kfs
	 hKs5Zfn1teTTjl52B9Iq4AGVkTSmFnpzF+DWvu8YYpSw76SxFfpoQ0REe8gbHmkBUz
	 dxUzbcCImLKAG52Y5vr49cu0tuosbNzavV99Fi33yRfbOpnnLe1IyaymcAKab5Qw/J
	 xD7larPUCk2f7nM79yUJ8snSIPpKopF0kqZx65kU+hKIglMv5j6T4ChsxqQkQOwi8T
	 iJdMGq6V9ndIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/15] eth: link netdev to page_pools in drivers
Date: Tue, 24 Oct 2023 09:02:12 -0700
Message-ID: <20231024160220.3973311-8-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
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
index d0359b569afe..04b1b53b1bf1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3298,6 +3298,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 		pp.pool_size += bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
+	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea58c6917433..9e4325453d15 100644
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
index 48ea4aeeea5d..91ad64538cb3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2137,6 +2137,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
+	pprm.netdev = rxq->ndev;
 
 	rxq->page_pool = page_pool_create(&pprm);
 
-- 
2.41.0


