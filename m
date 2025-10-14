Return-Path: <netdev+bounces-229303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D64CFBDA5B6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5942C3468BA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF002303C96;
	Tue, 14 Oct 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZ3wB0WT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1A302CCD
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455560; cv=none; b=UwoBF81ZUbv2FGCvIaD/7lWSPUV2pOfl4FHonANta8z2cB7iwRj8LA6rdWNTMWQGr+DSJ1lbAEh/aLowtGYTreWIEH2ovNLKecq92pz0ADThaBvD3Kuqv/8y1Ega2k1Ytho5aJ1AZOeuz+6lbUgnFMwcO9E4aqhnUd/nx32L92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455560; c=relaxed/simple;
	bh=IZWi4iOW9eQHr2cqWkBDuFfzqdPon+FfuCqzWuE1sdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSKHdfCjCe9aO1RbMIT5SsmWJGZFluCU2MHi/nD4ii9J7H1fd0JT9QJQzYJIFkKkmXITYOs3rivQc7DlG96t9UfLXzN3ba/Rm5ydW2EhjbXpUUNvSdmIUQRHZZioVS5ruypCZX7MJB3vHiQzZ6grlDnizOnPxClWyEDOJHgMJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZ3wB0WT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF5684E410B4;
	Tue, 14 Oct 2025 15:25:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A430C606EC;
	Tue, 14 Oct 2025 15:25:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EBC3102F22AD;
	Tue, 14 Oct 2025 17:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FIyVTJHLl9EUh3+XnaOXcLh9+yBLiNGl00k5vghqARw=;
	b=kZ3wB0WTIeS7ZQOuyowI9HZ9Wc5H1Y+1mL/UfVeYSQWxvFRTuLduZ3u7Xs3y5by0HZbbvt
	CrojYcOzy/Rs+vC/R5hD4MUSXoZpXTWbhxbJPxLiQEWIzibp6y8n7oYD75cMOL/RyHkzgW
	tS5IE5y5T4JPYQeSEuQnDIKG+B7lSsBRbo2zrEGB1yGCHZcOStuC49eWVI4JCSqhKWpMSW
	MGaRrtljFqaIxbQvp3DNLLRRMd8VA7Bh4FUOwHwF6X91s6hhxbRKcwr+ZU9GpsCpVZENUf
	ukQU1DkKRJvo+MiLMSIzUN6AHuZYm3CImMhYNi6APVrCveJgIYtoaV1UPpIAeQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:09 +0200
Subject: [PATCH net-next 08/15] net: macb: move bp->hw_dma_cap flags to
 bp->caps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-8-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Drop bp->hw_dma_cap field and put its two flags into bp->caps.

On my specific config (eyeq5_defconfig), bloat-o-meter indicates:
 - macb_main.o: Before=56251, After=56359, chg +0.19%
 - macb_ptp.o:  Before= 3976, After= 3952, chg -0.60%

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 10 ++--------
 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++--------------
 drivers/net/ethernet/cadence/macb_ptp.c  | 16 +++++++++-------
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9d21ec482c8c62da28f9d5ff35d5ca46f293eb64..b3a4c9534240a3195adbd7acd325cdaafab60039 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -777,6 +777,8 @@
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(18)
 #define MACB_CAPS_SG_DISABLED			BIT(19)
 #define MACB_CAPS_MACB_IS_GEM			BIT(20)
+#define MACB_CAPS_DMA_64B			BIT(21)
+#define MACB_CAPS_DMA_PTP			BIT(22)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -854,11 +856,6 @@ struct macb_dma_desc {
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
@@ -1349,9 +1346,6 @@ struct macb {
 
 	struct phy		*sgmii_phy;	/* for ZynqMP SGMII mode */
 
-#ifdef MACB_EXT_DESC
-	uint8_t hw_dma_cap;
-#endif
 	spinlock_t tsu_clk_lock; /* gem tsu clock locking */
 	unsigned int tsu_rate;
 	struct ptp_clock *ptp_clock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 44a411662786ca4f309d6f9389b0d36819fc40ad..44b96bf53ff6bcb351b27a165451cac852528501 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -124,9 +124,9 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
 #ifdef MACB_EXT_DESC
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+	if (bp->caps & MACB_CAPS_DMA_64B)
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+	if (bp->caps & MACB_CAPS_DMA_PTP)
 		desc_size += sizeof(struct macb_dma_desc_ptp);
 #endif
 
@@ -136,8 +136,8 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
 #ifdef MACB_EXT_DESC
-	bool is_ptp = bp->hw_dma_cap & HW_DMA_CAP_PTP;
-	bool is_64b = bp->hw_dma_cap & HW_DMA_CAP_64B;
+	bool is_ptp = bp->caps & MACB_CAPS_DMA_PTP;
+	bool is_64b = bp->caps & MACB_CAPS_DMA_64B;
 
 	return desc_idx * (1 + is_64b + is_ptp);
 #else
@@ -475,7 +475,7 @@ static void macb_init_buffers(struct macb *bp)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	/* Single register for all queues' high 32 bits. */
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+	if (bp->caps & MACB_CAPS_DMA_64B) {
 		macb_writel(bp, RBQPH,
 			    upper_32_bits(bp->queues[0].rx_ring_dma));
 		macb_writel(bp, TBQPH,
@@ -1009,7 +1009,7 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	struct macb_dma_desc_64 *desc_64;
 
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+	if (bp->caps & MACB_CAPS_DMA_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
@@ -1028,14 +1028,14 @@ static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
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
@@ -2301,7 +2301,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (bp->hw_dma_cap & HW_DMA_CAP_PTP))
+	    (bp->caps & MACB_CAPS_DMA_PTP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 #endif
 
@@ -2781,11 +2781,11 @@ static void macb_configure_dma(struct macb *bp)
 
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
@@ -3563,7 +3563,7 @@ static int gem_get_ts_info(struct net_device *dev,
 {
 	struct macb *bp = netdev_priv(dev);
 
-	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0) {
+	if (!(bp->caps & MACB_CAPS_DMA_PTP)) {
 		ethtool_op_get_ts_info(dev, info);
 		return 0;
 	}
@@ -4351,7 +4351,7 @@ static void macb_configure_caps(struct macb *bp,
 					"GEM doesn't support hardware ptp.\n");
 			else {
 #ifdef CONFIG_MACB_USE_HWSTAMP
-				bp->hw_dma_cap |= HW_DMA_CAP_PTP;
+				bp->caps |= MACB_CAPS_DMA_PTP;
 				bp->ptp_info = &gem_ptp_info;
 #endif
 			}
@@ -5518,7 +5518,7 @@ static int macb_probe(struct platform_device *pdev)
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
2.51.0


