Return-Path: <netdev+bounces-212251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E62B1ED79
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E5E1887616
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA028C844;
	Fri,  8 Aug 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hae8ViOB"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE30289E0E;
	Fri,  8 Aug 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671975; cv=none; b=g8deStj8gjXiGPUqkojFjMR7WiBYcGYDTIZbrB9homm+8SsqZH65LmGnppl75uRQwB7CkyRI2lA6z/CgleQ/iZxPsQbWuX0xFOPoLpQ6iVLzAfiHmIfEaoSFxBOL/Arq+XA25KMsyi2XkqZHv52NSP+G3f9xlAfAGDwJ2AWVJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671975; c=relaxed/simple;
	bh=g4ejlWTyS6nputyKQhyp4K3miuKK3jrnVxI92kcT9+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j19TOn568gG2ar7RANaceykFUHEbre0tMLR5DaM7D8mtmUO7D0LwSb2E2V6ICgSgUFnDdhRRd9s24QTMh1ItV/HvHPKfIhjZm2JWIWcuK94nnJWrR0R2mfIljROXc/LgTkRI2fsbKteXUt7mu3XCEP3OB/eL5mZtqTPkYKeon6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hae8ViOB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EB79442D1;
	Fri,  8 Aug 2025 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxvhxIaS3nMWP5uQ4cXYsOgTl5My0qoEBeZEVyStKnA=;
	b=Hae8ViOBwkJElkuKGTTxZVel8WIgM8j6BWwE1gDLcnXSrAHpMGAGNdeVzH2znBXvA26Eof
	VYzsVe6LPSzeoxSp3+BLEOAjS7+W/ulipbAmEgx92cZ7olMp/9tv6QUQDXOlpSMBl7pyP+
	CesTnGVHkRVoRL5405qOmSrjm3KMYSvCOOJVmF+kIJ3edd91wRxb3FXRuRnr/Rdo9yVITU
	52cPxgf3VapdeXs0wubx5gmTpX5ixzg2W+QjNFHgO5bFs2m9vc1XalMGPMpHJusQo99Qla
	o6yI6EFyvAuWzhrLp/elcxjQsoIFxZm8K5IrnRV6tZqHaEoMsUntFJEHsGF3bA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:46 +0200
Subject: [PATCH net v3 14/16] net: macb: move bp->hw_dma_cap flags to
 bp->caps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-14-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

Drop bp->hw_dma_cap field and put its two flags into bp->caps.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 10 ++--------
 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++--------------
 drivers/net/ethernet/cadence/macb_ptp.c  | 16 +++++++++-------
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c5ab35f4ab493196b5fa9a8046a6c8edf7c82727..ed015c4d4a33746b7ed6e32127bc04318da946c8 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -748,6 +748,8 @@
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(18)
 #define MACB_CAPS_SG_DISABLED			BIT(19)
 #define MACB_CAPS_MACB_IS_GEM			BIT(20)
+#define MACB_CAPS_DMA_64B			BIT(21)
+#define MACB_CAPS_DMA_PTP			BIT(22)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -825,11 +827,6 @@ struct macb_dma_desc {
 };
 
 #ifdef MACB_EXT_DESC
-#define HW_DMA_CAP_32B		0
-#define HW_DMA_CAP_64B		(1 << 0)
-#define HW_DMA_CAP_PTP		(1 << 1)
-#define HW_DMA_CAP_64B_PTP	(HW_DMA_CAP_64B | HW_DMA_CAP_PTP)
-
 struct macb_dma_desc_64 {
 	u32 addrh;
 	u32 resvd;
@@ -1315,9 +1312,6 @@ struct macb {
 
 	struct phy		*sgmii_phy;	/* for ZynqMP SGMII mode */
 
-#ifdef MACB_EXT_DESC
-	uint8_t hw_dma_cap;
-#endif
 	spinlock_t tsu_clk_lock; /* gem tsu clock locking */
 	unsigned int tsu_rate;
 	struct ptp_clock *ptp_clock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e3cf62253bb96ff245e49730dd4c4b232ce89712..52c3a352519c3f68403d859932d26b536a01affb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -123,9 +123,9 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
 #ifdef MACB_EXT_DESC
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+	if (bp->caps & MACB_CAPS_DMA_64B)
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+	if (bp->caps & MACB_CAPS_DMA_PTP)
 		desc_size += sizeof(struct macb_dma_desc_ptp);
 #endif
 
@@ -135,8 +135,8 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
 #ifdef MACB_EXT_DESC
-	bool is_ptp = bp->hw_dma_cap & HW_DMA_CAP_PTP;
-	bool is_64b = bp->hw_dma_cap & HW_DMA_CAP_64B;
+	bool is_ptp = bp->caps & MACB_CAPS_DMA_PTP;
+	bool is_64b = bp->caps & MACB_CAPS_DMA_64B;
 
 	return desc_idx * (1 + is_64b + is_ptp);
 #else
@@ -474,7 +474,7 @@ static void macb_init_buffers(struct macb *bp)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	/* Single register for all queues' high 32 bits. */
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+	if (bp->caps & MACB_CAPS_DMA_64B) {
 		macb_writel(bp, RBQPH, upper_32_bits(bp->queues[0].rx_ring_dma));
 		macb_writel(bp, TBQPH, upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
@@ -1006,7 +1006,7 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	struct macb_dma_desc_64 *desc_64;
 
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+	if (bp->caps & MACB_CAPS_DMA_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
@@ -1025,14 +1025,14 @@ static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	struct macb_dma_desc_64 *desc_64;
 
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+	if (bp->caps & MACB_CAPS_DMA_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 #endif
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
 #ifdef CONFIG_MACB_USE_HWSTAMP
-	if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+	if (bp->caps & MACB_CAPS_DMA_PTP)
 		addr &= ~GEM_BIT(DMA_RXVALID);
 #endif
 	return addr;
@@ -2304,7 +2304,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (bp->hw_dma_cap & HW_DMA_CAP_PTP))
+	    (bp->caps & MACB_CAPS_DMA_PTP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 #endif
 
@@ -2784,11 +2784,11 @@ static void macb_configure_dma(struct macb *bp)
 
 		dmacfg &= ~GEM_BIT(ADDR64);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+		if (bp->caps & MACB_CAPS_DMA_64B)
 			dmacfg |= GEM_BIT(ADDR64);
 #endif
 #ifdef CONFIG_MACB_USE_HWSTAMP
-		if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+		if (bp->caps & MACB_CAPS_DMA_PTP)
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
 #endif
 		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
@@ -3568,7 +3568,7 @@ static int gem_get_ts_info(struct net_device *dev,
 {
 	struct macb *bp = netdev_priv(dev);
 
-	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0) {
+	if (!(bp->caps & MACB_CAPS_DMA_PTP)) {
 		ethtool_op_get_ts_info(dev, info);
 		return 0;
 	}
@@ -4140,7 +4140,7 @@ static void macb_configure_caps(struct macb *bp,
 					"GEM doesn't support hardware ptp.\n");
 			else {
 #ifdef CONFIG_MACB_USE_HWSTAMP
-				bp->hw_dma_cap |= HW_DMA_CAP_PTP;
+				bp->caps |= MACB_CAPS_DMA_PTP;
 				bp->ptp_info = &gem_ptp_info;
 #endif
 			}
@@ -5276,7 +5276,7 @@ static int macb_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to set DMA mask\n");
 			goto err_out_free_netdev;
 		}
-		bp->hw_dma_cap |= HW_DMA_CAP_64B;
+		bp->caps |= MACB_CAPS_DMA_64B;
 	}
 #endif
 	platform_set_drvdata(pdev, dev);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index a63bf29c4fa81b95f10aec8b8fe9918022e196d6..f4ab379f28493cffe30275fd335844ae2fefc89a 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -28,14 +28,16 @@
 static struct macb_dma_desc_ptp *macb_ptp_desc(struct macb *bp,
 					       struct macb_dma_desc *desc)
 {
-	if (bp->hw_dma_cap == HW_DMA_CAP_PTP)
-		return (struct macb_dma_desc_ptp *)
-				((u8 *)desc + sizeof(struct macb_dma_desc));
-	if (bp->hw_dma_cap == HW_DMA_CAP_64B_PTP)
+	if (!(bp->caps & MACB_CAPS_DMA_PTP))
+		return NULL;
+
+	if (bp->caps & MACB_CAPS_DMA_64B)
 		return (struct macb_dma_desc_ptp *)
 				((u8 *)desc + sizeof(struct macb_dma_desc)
 				+ sizeof(struct macb_dma_desc_64));
-	return NULL;
+	else
+		return (struct macb_dma_desc_ptp *)
+				((u8 *)desc + sizeof(struct macb_dma_desc));
 }
 
 static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
@@ -380,7 +382,7 @@ int gem_get_hwtst(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 
 	*tstamp_config = bp->tstamp_config;
-	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
+	if (!(bp->caps & MACB_CAPS_DMA_PTP))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -407,7 +409,7 @@ int gem_set_hwtst(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	u32 regval;
 
-	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
+	if (!(bp->caps & MACB_CAPS_DMA_PTP))
 		return -EOPNOTSUPP;
 
 	switch (tstamp_config->tx_type) {

-- 
2.50.1


