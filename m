Return-Path: <netdev+bounces-201203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2439AE86E0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA391C25226
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD726981C;
	Wed, 25 Jun 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmLfXz8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075E268688
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862607; cv=none; b=p8BuMdnnzL0ksuGQXsQgY1sOqMkDNxY4W/NwcoES8wzJLddeB0CQDzs9PO44fKIop/qdDZn6bq9XtD45lUxqsdGkfaKHcvv9DxMRlWnXhATKEWTREwlRfZDXz5VldVtpb5YfYA5yxeBYW8IvkGZrqG+qkErZx2pPFdxeYx5TVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862607; c=relaxed/simple;
	bh=o/zklcCXTcNnCg6d1opHPaCZO1qBg4YhDTZnbLaFt4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E0PShx7Ghbdx6i9/e3ajM5Ip+ix84czMz/AFAL14l2BokVA97bCkpz2GIOswI5N8axSQUu51WioGda4RylmblpfuZ3+ghU2R1+mvaANy6MnyfjDqYhUKx5TpihhNNOyx4vmhpET6waWh8xn1fYVj3zdgERUMawsED5YSaM1mG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmLfXz8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA19C4CEEA;
	Wed, 25 Jun 2025 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750862606;
	bh=o/zklcCXTcNnCg6d1opHPaCZO1qBg4YhDTZnbLaFt4U=;
	h=From:Date:Subject:To:Cc:From;
	b=ZmLfXz8q1xkk/VQKZ2uu/uUAwdvnzZTbDksBJiJQ8EIZcPAcvylYGdK9vZs6eCmKE
	 fThokQ2cdl9FpFXiV/r0BXgUugqgWeM3KsRVL5AYziKypZ04CREAzTns8Z9Q8HJGNY
	 /Gqf+xuElPCsZ82UIiFXy8LmUTaAW2U1L70nYBMR2bjUDpEFNzf7XifVilTWruogAm
	 SDqGs1LeZAuelxPS8gsvuxKCcdF3vQUaf6sqHuORadPeTsOfJhgG3wu0gXTFei2EDd
	 xCnHvC8ZtgXwPO0nPrKaP6UNIRlUypwgdiYqpSFjKiPjFTQsjXKt7ZzYNbqytG1X9r
	 FoGKmBtl3sSQw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 25 Jun 2025 16:43:15 +0200
Subject: [PATCH net] net: airoha: Get rid of dma_sync_single_for_device()
 in airoha_qdma_fill_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-airoha-sync-for-device-v1-1-923741deaabf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAILXGgC/x3MMQqAMAxA0atIZgMmYhWvIg6lRs3SSgqiiHe3O
 P7h/QeymEqGsXrA5NSsKZaguoKw+7gJ6lIauOGucdyhV0u7x3zHgGsyXAoKgjQQk6O2d9xCwYf
 Jqtc/nub3/QDBA5yRaAAAAA==
X-Change-ID: 20250625-airoha-sync-for-device-181216137623
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Since the page_pool for airoha_eth driver is created with
PP_FLAG_DMA_SYNC_DEV flag, we do not need to sync_for_device each page
received from the pool since it is already done by the page_pool codebase.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 06dea3a13e77ce11f35dbd36966a34c5ef229c11..10a167224bf5ff60e60655306b8748253d2f52e5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -551,9 +551,7 @@ static int airoha_fe_init(struct airoha_eth *eth)
 
 static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 {
-	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
 	struct airoha_qdma *qdma = q->qdma;
-	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
 	int nframes = 0;
 
@@ -577,9 +575,6 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
 		e->dma_len = SKB_WITH_OVERHEAD(q->buf_size);
 
-		dma_sync_single_for_device(eth->dev, e->dma_addr, e->dma_len,
-					   dir);
-
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));

---
base-commit: 9caca6ac0e26cd20efd490d8b3b2ffb1c7c00f6f
change-id: 20250625-airoha-sync-for-device-181216137623

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


