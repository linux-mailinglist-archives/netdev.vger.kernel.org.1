Return-Path: <netdev+bounces-212252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB8B1ED7D
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D34B1C2834E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9828DF33;
	Fri,  8 Aug 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CYy/pZaO"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339C28A416;
	Fri,  8 Aug 2025 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671976; cv=none; b=pF4LmZwzXF55wy9KIhhw8L/akOoyQqjet0FKlQ4znKdICgbJRrHBJk35Tn5dW8p2iLbNzZLrwR8SeuJO83AwVfXCw48A0Djwy0us8xgwizkY0hqR25lHtdjPJO4A1YjA3r9KGOywEzRjDbceErzqHj0YRXy9dxRNWl4U9ZAElOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671976; c=relaxed/simple;
	bh=sLJIxwUozhvmDEiqq7ZBgFDewqBo9FkaXz4ced4czNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txSm6MJ3k4XI2X+qA9NBxWJdUCG+b8Y1WTfWD+Uc/YiwHsjzUbDdLSfD3irxGmMaG4VSLwI68O4m3PnmcQAo8UZttaL5208xdHYRlNtcrNiz8kqdCbeSUfKLod5cUyxRYppeMGozvHoHrgNAbj2kBFRa7SIC1rItHLzpL1vKt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CYy/pZaO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CEF9442DE;
	Fri,  8 Aug 2025 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTiPHYaY9zrTaWTjbu3T51TdBgN3W8x4plWLPdU6694=;
	b=CYy/pZaOsHBeo08MIgERoFdjfSrO7WCG9fbCz+lQkAKVbegk+VvqklBPWR98MCMrg0X1hK
	HljM5qdxO39cAZzpBJq/Fl/r+7BVLgfzkH2+bVuSsG97bVgGgyiA+579k1uxqP+vWkKgj2
	KqbChhQWRWS7qUBMqALPj2wFD7x/5CVJAcoIKcPCYoeoBR7vmJBAQtCBvbTypsUbj5gZtp
	gVa99NOum4o4ZQNqx9UB+U8j+XB9BpDXWxu6oW70Qa2wjVeZUsL/WB1DrgtVLiCCp1CGLn
	tLSZ4FsJTRnFdAbGXeJ2jZCeiB/kSZHd5zetVVjpRLI4oLkAwPxlykWPyZvkGw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:47 +0200
Subject: [PATCH net v3 15/16] net: macb: introduce DMA descriptor helpers
 (is 64bit? is PTP?)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-15-08f1fcb5179f@bootlin.com>
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

Introduce macb_dma64() and macb_dma_ptp() helper functions.
Many codepaths are made simpler by dropping conditional compilation.

This implies two additional changes:
 - Always compile related structure definitions inside <macb.h>.
 - MACB_EXT_DESC can be dropped as it is useless now.

The common case is:

        #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
                if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
                        // ...
                }
        #endif

And replaced by:

        if (macb_dma64(bp)) {
                // ...
        }

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 18 +++++++----
 drivers/net/ethernet/cadence/macb_main.c | 53 +++++++++-----------------------
 drivers/net/ethernet/cadence/macb_ptp.c  |  8 ++---
 3 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ed015c4d4a33746b7ed6e32127bc04318da946c8..aa29eaac109acb2771e5732b59362dd28fcafa47 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -15,10 +15,6 @@
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 
-#if defined(CONFIG_ARCH_DMA_ADDR_T_64BIT) || defined(CONFIG_MACB_USE_HWSTAMP)
-#define MACB_EXT_DESC
-#endif
-
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
 #define MACB_MAX_QUEUES 8
@@ -826,7 +822,6 @@ struct macb_dma_desc {
 	u32	ctrl;
 };
 
-#ifdef MACB_EXT_DESC
 struct macb_dma_desc_64 {
 	u32 addrh;
 	u32 resvd;
@@ -836,7 +831,6 @@ struct macb_dma_desc_ptp {
 	u32	ts_1;
 	u32	ts_2;
 };
-#endif
 
 /* DMA descriptor bitfields */
 #define MACB_RX_USED_OFFSET			0
@@ -1390,6 +1384,18 @@ static inline bool gem_has_ptp(struct macb *bp)
 	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && (bp->caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
+static inline bool macb_dma64(struct macb *bp)
+{
+	return IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
+	       bp->caps & MACB_CAPS_DMA_64B;
+}
+
+static inline bool macb_dma_ptp(struct macb *bp)
+{
+	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
+	       bp->caps & MACB_CAPS_DMA_PTP;
+}
+
 /**
  * struct macb_platform_data - platform data for MACB Ethernet used for PCI registration
  * @pclk:		platform clock
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 52c3a352519c3f68403d859932d26b536a01affb..15fd940c684f50c983c32e94a0856d42d9ece161 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -122,35 +122,24 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 {
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-#ifdef MACB_EXT_DESC
-	if (bp->caps & MACB_CAPS_DMA_64B)
+	if (macb_dma64(bp))
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (bp->caps & MACB_CAPS_DMA_PTP)
+	if (macb_dma_ptp(bp))
 		desc_size += sizeof(struct macb_dma_desc_ptp);
-#endif
 
 	return desc_size;
 }
 
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
-#ifdef MACB_EXT_DESC
-	bool is_ptp = bp->caps & MACB_CAPS_DMA_PTP;
-	bool is_64b = bp->caps & MACB_CAPS_DMA_64B;
-
-	return desc_idx * (1 + is_64b + is_ptp);
-#else
-	return desc_idx;
-#endif
+	return desc_idx * (1 + macb_dma64(bp) + macb_dma_ptp(bp));
 }
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_desc *desc)
 {
 	return (struct macb_dma_desc_64 *)((void *)desc
 		+ sizeof(struct macb_dma_desc));
 }
-#endif
 
 /* Ring buffer accessors */
 static unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
@@ -472,13 +461,11 @@ static void macb_init_buffers(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	/* Single register for all queues' high 32 bits. */
-	if (bp->caps & MACB_CAPS_DMA_64B) {
+	if (macb_dma64(bp)) {
 		macb_writel(bp, RBQPH, upper_32_bits(bp->queues[0].rx_ring_dma));
 		macb_writel(bp, TBQPH, upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
-#endif
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
@@ -1003,10 +990,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 
 static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_t addr)
 {
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	struct macb_dma_desc_64 *desc_64;
+	if (macb_dma64(bp)) {
+		struct macb_dma_desc_64 *desc_64;
 
-	if (bp->caps & MACB_CAPS_DMA_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
@@ -1015,26 +1001,23 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 		 */
 		dma_wmb();
 	}
-#endif
+
 	desc->addr = lower_32_bits(addr);
 }
 
 static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	struct macb_dma_desc_64 *desc_64;
+	if (macb_dma64(bp)) {
+		struct macb_dma_desc_64 *desc_64;
 
-	if (bp->caps & MACB_CAPS_DMA_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
-#endif
+
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-#ifdef CONFIG_MACB_USE_HWSTAMP
-	if (bp->caps & MACB_CAPS_DMA_PTP)
+	if (macb_dma_ptp(bp))
 		addr &= ~GEM_BIT(DMA_RXVALID);
-#endif
 	return addr;
 }
 
@@ -2302,11 +2285,9 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return ret;
 	}
 
-#ifdef CONFIG_MACB_USE_HWSTAMP
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (bp->caps & MACB_CAPS_DMA_PTP))
+	    macb_dma_ptp(bp))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-#endif
 
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
 
@@ -2783,14 +2764,10 @@ static void macb_configure_dma(struct macb *bp)
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
 		dmacfg &= ~GEM_BIT(ADDR64);
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->caps & MACB_CAPS_DMA_64B)
+		if (macb_dma64(bp))
 			dmacfg |= GEM_BIT(ADDR64);
-#endif
-#ifdef CONFIG_MACB_USE_HWSTAMP
-		if (bp->caps & MACB_CAPS_DMA_PTP)
+		if (macb_dma_ptp(bp))
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
-#endif
 		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
 		gem_writel(bp, DMACFG, dmacfg);
@@ -3568,7 +3545,7 @@ static int gem_get_ts_info(struct net_device *dev,
 {
 	struct macb *bp = netdev_priv(dev);
 
-	if (!(bp->caps & MACB_CAPS_DMA_PTP)) {
+	if (!macb_dma_ptp(bp)) {
 		ethtool_op_get_ts_info(dev, info);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index f4ab379f28493cffe30275fd335844ae2fefc89a..c9e77819196e17a5b88f6dab77dadabfe087a1bd 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -28,10 +28,10 @@
 static struct macb_dma_desc_ptp *macb_ptp_desc(struct macb *bp,
 					       struct macb_dma_desc *desc)
 {
-	if (!(bp->caps & MACB_CAPS_DMA_PTP))
+	if (!macb_dma_ptp(bp))
 		return NULL;
 
-	if (bp->caps & MACB_CAPS_DMA_64B)
+	if (macb_dma64(bp))
 		return (struct macb_dma_desc_ptp *)
 				((u8 *)desc + sizeof(struct macb_dma_desc)
 				+ sizeof(struct macb_dma_desc_64));
@@ -382,7 +382,7 @@ int gem_get_hwtst(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 
 	*tstamp_config = bp->tstamp_config;
-	if (!(bp->caps & MACB_CAPS_DMA_PTP))
+	if (!macb_dma_ptp(bp))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -409,7 +409,7 @@ int gem_set_hwtst(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	u32 regval;
 
-	if (!(bp->caps & MACB_CAPS_DMA_PTP))
+	if (!macb_dma_ptp(bp))
 		return -EOPNOTSUPP;
 
 	switch (tstamp_config->tx_type) {

-- 
2.50.1


