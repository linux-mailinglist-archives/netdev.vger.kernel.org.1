Return-Path: <netdev+bounces-198914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E0ADE4CF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716881890D0C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE7274FC1;
	Wed, 18 Jun 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzQSl/oe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E27944F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232923; cv=none; b=buRw/VA1VDO7XIsUMOuJADvnKCak62INadb6rryTDqGD5wPtYnOKhBm871yQQm+OsqYq6Qk2yTcQZwTjdzwl+Uw7ECaSqLuamnCGNy4NJcspHwuVgsj8a+2PQWouazGnN9hrL2nxeH+yL88URY6oCdPtP83FoswEdKp2mCcBNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232923; c=relaxed/simple;
	bh=UfU3ocq2ii21xRQfAGGhtJtsNEug9yttyxDT5o40RTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNZIobFkuq2Fz5INLrOjJEhie54ZdTj6KIMiGkN7YWmX8OEZal7FstYNov/rTf0M+c9G5S9toveiZ4H33UVbiQEEeELnpoNz04UXfUGEOBZXkK5DuYglet5XeKAFJkjxnDYvaIlGu7ASsvAUzqtOxgFwb9sqqMqp8Oh5QB1zyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzQSl/oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3DC4CEEF;
	Wed, 18 Jun 2025 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232923;
	bh=UfU3ocq2ii21xRQfAGGhtJtsNEug9yttyxDT5o40RTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PzQSl/oe5peqD5rWG+gb+cVmuynJH7yZRS9+8WkyCusoQeGFL0zB/fPA7J7nZKreV
	 uv3RZBrrBqlFYGLXU6E92hIMUSA+EFBYj6pYalL230Gsi9P2+BvmwklJ9lPLU5NUTk
	 W2MWAd3U2njeZFAcXSgZb4kzSQInCtqQKPWCqHSU/PfMvHNtTZW5xCeGKYgNXFEFhu
	 +wV7un5SGaUNXbKUjZpOVW4JKIdigJHtqUa2HzFs7FZECiVFdrBHIkXmowbBJLpBMg
	 E817yXTNM3eW35UrD5lxuYRAeSvYIqPT81Nex7tbHdhfyjbR50XL7Ki5RjJ8gJ+xA0
	 w0JLd/7RJ5tIw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 18 Jun 2025 09:48:04 +0200
Subject: [PATCH net v3 1/2] net: airoha: Compute number of descriptors
 according to reserved memory size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-airoha-hw-num-desc-v3-1-18a6487cd75e@kernel.org>
References: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
In-Reply-To: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to not exceed the reserved memory size for hwfd buffers,
compute the number of hwfd buffers/descriptors according to the
reserved memory size and the size of each hwfd buffer (2KB).

Fixes: 3a1ce9e3d01b ("net: airoha: Add the capability to allocate hwfd buffers via reserved-memory")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a7ec609d64dee9c8e901c7eb650bb3fe144ee00a..1b7fd7ee0cbf3e1f7717110c70e9c5183fdd93d4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1065,19 +1065,13 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 
 static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 {
+	int size, index, num_desc = HW_DSCP_NUM;
 	struct airoha_eth *eth = qdma->eth;
 	int id = qdma - &eth->qdma[0];
 	dma_addr_t dma_addr;
 	const char *name;
-	int size, index;
 	u32 status;
 
-	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
-	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
-		return -ENOMEM;
-
-	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
-
 	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
 	if (!name)
 		return -ENOMEM;
@@ -1099,8 +1093,12 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		rmem = of_reserved_mem_lookup(np);
 		of_node_put(np);
 		dma_addr = rmem->base;
+		/* Compute the number of hw descriptors according to the
+		 * reserved memory size and the payload buffer size
+		 */
+		num_desc = rmem->size / AIROHA_MAX_PACKET_SIZE;
 	} else {
-		size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
+		size = AIROHA_MAX_PACKET_SIZE * num_desc;
 		if (!dmam_alloc_coherent(eth->dev, size, &dma_addr,
 					 GFP_KERNEL))
 			return -ENOMEM;
@@ -1108,6 +1106,11 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 
 	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
 
+	size = num_desc * sizeof(struct airoha_qdma_fwd_desc);
+	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
+		return -ENOMEM;
+
+	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
 			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
@@ -1116,7 +1119,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
 			HW_FWD_DESC_NUM_MASK,
-			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
+			FIELD_PREP(HW_FWD_DESC_NUM_MASK, num_desc) |
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK);
 
 	return read_poll_timeout(airoha_qdma_rr, status,

-- 
2.49.0


