Return-Path: <netdev+bounces-192189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D6ABECF0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D471BA557C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA42356CD;
	Wed, 21 May 2025 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Ui8NHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9323506E;
	Wed, 21 May 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811825; cv=none; b=VTcJkVil0Mj5rdQeMpILqiZBc4U6aHhvnAMlxcd87W7Srcfr1jrDKdAbpcJS1lrDnh54Ff1CGtKn2A6O4fPKPePqWGcs95+0JR3Cv1C53JRP5ObMF+vnDAIYwZVhj+Wvn3LrZ+f/nR/x664fNHPUqCzM0aeQcuVqygYNbUrV20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811825; c=relaxed/simple;
	bh=HtIvyLnzoLGjuDqzE4ebbNLd1tqZk4KAODJR9iSVbWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLAoJbaPH333/kRC0JchHfl5m9w/KJjT0MHzeY1/Yozsb0jm9kNqo3lqCtoMLp3zvAD6s8+hjT1X7ozwQapsM2mc3xoK3rhLm55cFC+wzDQV0BHKdsnfWJrse8JY0fIfT3no3LNBF7oH4Wdfzq7LsNetcghX+Nhs5U+/LmtzYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Ui8NHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9C5C4CEE4;
	Wed, 21 May 2025 07:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811824;
	bh=HtIvyLnzoLGjuDqzE4ebbNLd1tqZk4KAODJR9iSVbWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C2Ui8NHhPFH6M03XcKi2a+9CZJPEWCFLkQV7SEWIlOLD99SP4cIR4gfZDyV7i1X2W
	 vafLSzqRSCrRYQDRvJhseBIe+kFRYtPLXrFXoXCG4cgtItqbo63c5VQg1hQ+WQMQbo
	 41R+Ym1v7VfnKx8xRozWrrEB3h65YJYycIt1x8rqMU45pl6tq8GnHHfuQ6NZxyBBDf
	 bcAvRbZaK2Eju2JfvoBuqqoGltcJc/mk5fXCSlE5I0NpaQDFfcNDKpNUdFGA2h1b3s
	 VkCm0IIWMvj0C4ygK60N81EKuH7n7VlO5JJcL83WhHxUyLl3xEv7Pw2gyC1SfRiR71
	 xhmvinhcVzYng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 21 May 2025 09:16:38 +0200
Subject: [PATCH net-next v3 3/4] net: airoha: Add the capability to
 allocate hwfd buffers via reserved-memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-airopha-desc-sram-v3-3-a6e9b085b4f0@kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
In-Reply-To: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

In some configurations QDMA blocks require a contiguous block of
system memory for hwfd buffers queue. Introduce the capability to allocate
hw buffers forwarding queue via the reserved-memory DTS property instead of
running dmam_alloc_coherent().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 33 +++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5f7cbbcbb1d469836dfcea95137c960bfd076744..20e590d76735e72a1a538a42d2a1f49b882deccc 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -5,6 +5,7 @@
  */
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -1076,9 +1077,11 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 {
 	struct airoha_eth *eth = qdma->eth;
+	int id = qdma - &eth->qdma[0];
 	dma_addr_t dma_addr;
+	const char *name;
+	int size, index;
 	u32 status;
-	int size;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
 	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
@@ -1086,10 +1089,34 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
-	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
+	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
+	if (!name)
 		return -ENOMEM;
 
+	index = of_property_match_string(eth->dev->of_node,
+					 "memory-region-names", name);
+	if (index >= 0) {
+		struct reserved_mem *rmem;
+		struct device_node *np;
+
+		/* Consume reserved memory for hw forwarding buffers queue if
+		 * available in the DTS
+		 */
+		np = of_parse_phandle(eth->dev->of_node, "memory-region",
+				      index);
+		if (!np)
+			return -ENODEV;
+
+		rmem = of_reserved_mem_lookup(np);
+		of_node_put(np);
+		dma_addr = rmem->base;
+	} else {
+		size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
+		if (!dmam_alloc_coherent(eth->dev, size, &dma_addr,
+					 GFP_KERNEL))
+			return -ENOMEM;
+	}
+
 	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
 
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,

-- 
2.49.0


