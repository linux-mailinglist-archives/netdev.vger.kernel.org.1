Return-Path: <netdev+bounces-188762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6DAAE82D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA09C7F34
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF528DB79;
	Wed,  7 May 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsfJCw0b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8E28D8FE;
	Wed,  7 May 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640150; cv=none; b=Ka1kCwYGUV/RnfNoYlTF7ls0JFXX6B7/wjNHeey4Gj0PKjGqP/8u9+tDmHkIDcA3uPOOThcdAXFV4cWf/+GhDoh3HwXQpHjJq1JGZQv8NRjuYX42Vp3TfclB2B8QKZAz6MjW0tRJZVfepo8KuCY80r8qwVBusiD03kbXM6wuiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640150; c=relaxed/simple;
	bh=W/kyXuWaZKDmPfwuyKSOYasAKozBMnO2KN/T9exj3sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twIJIm2mOjo5nUPkCIFTkFbWqUJSBy5zt0TKgZWHxc+18guPuvfNaZe/Rt2LgTnES9FURHCovTWpkt+vkK9WaA6StzpEyxCn2Zpg92WXcxZK8vNujwWg5DZoso58XZ0ZFpJwfBUKwidzf+M16cv0fZk2xcKUJn90eX22A0yaz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsfJCw0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A01CC4CEE9;
	Wed,  7 May 2025 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746640150;
	bh=W/kyXuWaZKDmPfwuyKSOYasAKozBMnO2KN/T9exj3sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OsfJCw0bX1SwuWBBEJPTzWSCCbWcoX4BENTXRUhzEAvjf5c6GjWZ9koqN6Afkbif0
	 T7zTVQFfaGq0px92bH8f/T6/nb7YyIkaicrSlVj+NfwySmS0kT9ag2IP287lOkVql8
	 RwKB9tBDCOMaR2DMdsfefg/Kv++yOmLA1ot6cDhUbyUfSBl0zUcp5yBk7BZI9JePF+
	 d5IZBsPnTq0FWYkktKW/RUuHYSdqbYt3HA/QPN2Ab2lejj9S4UA6HCzSVnmJk9rNJK
	 2o3RdK6e1kL6LiBTTUNok6aLb1qAj7c/KdiHuD9LT3XA1dx7eY+/7dOB0xtLF/OLjD
	 AIFdG3bC1J6aw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 07 May 2025 19:48:46 +0200
Subject: [PATCH net-next 2/2] net: airoha: Add the capability to allocate
 hw buffers in SRAM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-airopha-desc-sram-v1-2-d42037431bfa@kernel.org>
References: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
In-Reply-To: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to improve packet processing and packet forwarding
performances, EN7581 SoC supports allocating buffers for hw forwarding
queues in SRAM instead of DRAM if available on the system.
Rely on SRAM for buffers allocation if available on the system and use
DRAM as fallback.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 48 ++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931fd9532aa3b8cc78f41afc676aa117..b1ca8322d4eb34f48a6ed6a3b4596c128324cd50 100644
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
-	u32 status;
-	int size;
+	const char *name;
+	int size, index;
+	u32 status, val;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
 	qdma->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
@@ -1088,12 +1091,36 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
-	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					   GFP_KERNEL);
-	if (!qdma->hfwd.q)
+	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
+	if (!name)
 		return -ENOMEM;
 
+	index = of_property_match_string(eth->dev->of_node,
+					 "memory-region-names", name);
+	if (index >= 0) { /* buffers in sram */
+		struct reserved_mem *rmem;
+		struct device_node *np;
+
+		np = of_parse_phandle(eth->dev->of_node, "memory-region",
+				      index);
+		if (!np)
+			return -ENODEV;
+
+		rmem = of_reserved_mem_lookup(np);
+		of_node_put(np);
+
+		dma_addr = rmem->base;
+		qdma->hfwd.q = devm_ioremap(eth->dev, rmem->base, rmem->size);
+		if (!qdma->hfwd.q)
+			return -ENOMEM;
+	} else {
+		size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
+		qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
+						   GFP_KERNEL);
+		if (!qdma->hfwd.q)
+			return -ENOMEM;
+	}
+
 	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
 
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
@@ -1101,11 +1128,14 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
+
+	val = FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
+	      LMGR_INIT_START;
+	if (index >= 0)
+		val |= LMGR_SRAM_MODE_MASK;
 	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
-			HW_FWD_DESC_NUM_MASK,
-			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
-			LMGR_INIT_START);
+			HW_FWD_DESC_NUM_MASK, val);
 
 	return read_poll_timeout(airoha_qdma_rr, status,
 				 !(status & LMGR_INIT_START), USEC_PER_MSEC,

-- 
2.49.0


