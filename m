Return-Path: <netdev+bounces-199353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B08ADFE5E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E961894E54
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AE2475F7;
	Thu, 19 Jun 2025 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P48eqC4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0224A051
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750316859; cv=none; b=cQk03Cz91/1ssUQw1TDz2EXIxIunttQ9r+mS4bsJmSb/AD4D3wIKEBk3VpC3Q0TfuWv2y1u1qXhElOPxkjVTobXiokUwHrejSl4MuSEu7S4tjSCG10W1mkrT6M4zvIdF32+Dj+XzpAoNo2PkMK8LrMAiijFKqc8YeAConTlqNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750316859; c=relaxed/simple;
	bh=XzlQTlIP0+twJXa+kEklTGPKwMc8r1JBvRVvfulVsNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9QxZcWRLm9L7N9gAKP0kMCVKxdgyucsi/IBfyuoXaW1v0xA7IDYDpYrbLNQn94gd6gXMYj6qyxfPIhS+BDyWIfnPwZUbyF52JR2ceRToMoPPe7+kXJzCQ3yDj61mu6j6HkMt9pmHKYpi+JVW+fZcUz/96djVgPueZJsMt+iBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P48eqC4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D3C4CEEA;
	Thu, 19 Jun 2025 07:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750316859;
	bh=XzlQTlIP0+twJXa+kEklTGPKwMc8r1JBvRVvfulVsNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P48eqC4Tb9pm9kxnwJokSgR9j6hWYXokhc/5y2JDldv0JuHKmvhxxMQ9wE8dTy7lU
	 jEZ2MlLqUJ7Ggwk1V0moBD4mZhTPyMLJW+4pFcynrDsJJzrGRYShxGgBu2Cj0w473w
	 lqj1PQMmhBK7biyfcxlyEnbH2Y9nfMkhzLx43+vOVdORHBHxr+SDjxBWUDY6yRVG2q
	 Q02xQdBnV89BKIww0iADai7KgDacXsy5V8+PgZSV793A6TMF9eY8lpGAgQsXEufo58
	 E+D/neUGGeAH7GfCYfHOkxgdPPENg32E8fCO/q/mhLsSHNLazzDgQdoqgFC/6o/yIn
	 7xRxTtuod5MEg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 19 Jun 2025 09:07:25 +0200
Subject: [PATCH net v4 2/2] net: airoha: Differentiate hwfd buffer size for
 QDMA0 and QDMA1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-airoha-hw-num-desc-v4-2-49600a9b319a@kernel.org>
References: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
In-Reply-To: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

EN7581 SoC allows configuring the size and the number of buffers in
hwfd payload queue for both QDMA0 and QDMA1.
In order to reduce the required DRAM used for hwfd buffers queues and
decrease the memory footprint, differentiate hwfd buffer size for QDMA0
and QDMA1 and reduce hwfd buffer size to 1KB for QDMA1 (WAN) while
maintaining 2KB for QDMA0 (LAN).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 1b7fd7ee0cbf3e1f7717110c70e9c5183fdd93d4..06dea3a13e77ce11f35dbd36966a34c5ef229c11 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1068,14 +1068,15 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	int size, index, num_desc = HW_DSCP_NUM;
 	struct airoha_eth *eth = qdma->eth;
 	int id = qdma - &eth->qdma[0];
+	u32 status, buf_size;
 	dma_addr_t dma_addr;
 	const char *name;
-	u32 status;
 
 	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
 	if (!name)
 		return -ENOMEM;
 
+	buf_size = id ? AIROHA_MAX_PACKET_SIZE / 2 : AIROHA_MAX_PACKET_SIZE;
 	index = of_property_match_string(eth->dev->of_node,
 					 "memory-region-names", name);
 	if (index >= 0) {
@@ -1096,9 +1097,9 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		/* Compute the number of hw descriptors according to the
 		 * reserved memory size and the payload buffer size
 		 */
-		num_desc = rmem->size / AIROHA_MAX_PACKET_SIZE;
+		num_desc = div_u64(rmem->size, buf_size);
 	} else {
-		size = AIROHA_MAX_PACKET_SIZE * num_desc;
+		size = buf_size * num_desc;
 		if (!dmam_alloc_coherent(eth->dev, size, &dma_addr,
 					 GFP_KERNEL))
 			return -ENOMEM;
@@ -1111,9 +1112,10 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
+	/* QDMA0: 2KB. QDMA1: 1KB */
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
-			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
+			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, !!id));
 	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
 	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,

-- 
2.49.0


