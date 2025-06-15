Return-Path: <netdev+bounces-197862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07EADA14F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1603AEA63
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18982627F9;
	Sun, 15 Jun 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHKy9lp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1B2045B6
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749976641; cv=none; b=ZvakBJ2+Lo3RmrSB66K0g1a93e4/BMnhNOgVuFudJ4jXnMi5qLCOjAGDYB99MZgL20Dm6Q4SUxEViqtn7IsXF688jMvxHPYsHv8cLv939ZvJ4q4H0ojOpQJNo0mKiYINK56OgpPO0IODF9GhSV839Iz5oXT4zK0Kx6vAaBSoABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749976641; c=relaxed/simple;
	bh=UfU3ocq2ii21xRQfAGGhtJtsNEug9yttyxDT5o40RTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUaWtlqCjw/0lJ44gm+ZeypuuqV6uabdDPYsOsABXWWiIEBJTpiiir2UwBdHWN9T/0ZqGuf8esg8sS7mVX759m3AujhHtI5N8uhZz8qCCg/+O670gg+qupadAWVGs77TT/XC3iuJMKgjFuQ8oaBhKEHoiTUiSuxY0l6JtW5/GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHKy9lp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0534C4CEEE;
	Sun, 15 Jun 2025 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749976641;
	bh=UfU3ocq2ii21xRQfAGGhtJtsNEug9yttyxDT5o40RTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FHKy9lp5nytf65IcLggSJHXBtvpdCaX+eUIz+E+O+Rzu+AhcVR/pKQM0rFJqzhrY/
	 nPqZ5KAyjKwfGV7OFatiZcFG1hU3oN/l1LBNPWLj8fU7y59SrL6iYOJCS/NPvVy5LF
	 HfUBXPzj/R6vHd+tVHcgWPY2iZDBJO5FUnhznAlMvTwsjLqtFlIayR92NSZ/gZss2s
	 dlzpn/p4y3N1JivIsvI7AvoXY9JtvkvookpPyLXcoecveMM15RC6bM4Wte74InZm3P
	 Opm7gRUONAsGUAKKj2+rlmF/wHU7ikKiso9Zp1lM6J3KTRWLCWy3tEYq54fX9OOdlD
	 AjPGKYRwvJJtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Jun 2025 10:36:18 +0200
Subject: [PATCH net-next 1/2] net: airoha: Compute number of descriptors
 according to reserved memory size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-airoha-hw-num-desc-v1-1-8f88daa4abd7@kernel.org>
References: <20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org>
In-Reply-To: <20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org>
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


