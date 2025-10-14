Return-Path: <netdev+bounces-229304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C16BDA5DA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F73188EB85
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1934304BC1;
	Tue, 14 Oct 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vFzR7pjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E853002D3;
	Tue, 14 Oct 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455563; cv=none; b=OvovVRSUu9I20SqAVKSf3rHJdL1kAmwSc4naf7MLzt+IiVuHU+SrwCw74mPBVc7XqY5DazETwZ6Grisvw2311LrQjt+Lt2SGs6yihjgG8sOkr3uWFID/5dvsTyzMMa3mJeH6xIuBIjcMuP9w5lFI3d3gbIfpxzrEogHPk0wyRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455563; c=relaxed/simple;
	bh=HTY2ijRO1tf1eTSEVXlg5CpDj5modXR4DH8kaYDg27E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q64ixrPXRHT+Y68GFY3nv7+lPIQjSd0hM1L5hvMBpJvZdaJSUN/YsIcp8vHROPtEtjb/PJC1OmTpBZ0UdLimuEhhCARHzW0wNbeNtwjvMX7Kta+XfvjDgKaYnozGm9GJJJUxYvHD8myGhrirFR5zqOCUJ3tnYqws7xZPugmUngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vFzR7pjG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B4D484E4108F;
	Tue, 14 Oct 2025 15:25:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8AD82606EC;
	Tue, 14 Oct 2025 15:25:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF7DC102F22B4;
	Tue, 14 Oct 2025 17:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455557; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZY8fyxY5lDryOsTY56WS6WnXIkM/Swh6Q0iFUBtZEVA=;
	b=vFzR7pjGZjPkz9QxC12zGuKLdY0CpCDe6hMFKn9llWwpZFbTeU9DxccZDUezdgm4Y/vTJV
	W0PuuY8KGP/+AsAFw2uoKnIdAZxbb7+cWgxUZM0Gp+KmjtcrKSa7YOJ7m0uaho3y/Z+gqN
	cC3boS/jB8fDl+BQddMpjsy3ffExWa6zL/PrB6ZBlov1yd9jz7u6sGocJNoT3jhAADkT30
	SIqHCMjCRJuNqn1gjKO7VVNwz4qDFFBzRKNtH55wzvRcGrXfJSQoGLi9p8/UNzAM+WjVgz
	tlXQUM6nnT6/aclsGdfg7L+O7JCBamchI0IQwWOJ2G61GJ9opCKH9gAO0ul9uw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:10 +0200
Subject: [PATCH net-next 09/15] net: macb: introduce DMA descriptor helpers
 (is 64bit? is PTP?)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-9-31cd266e22cd@bootlin.com>
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

Introduce macb_dma64() and macb_dma_ptp() helper functions.
Many codepaths are made simpler by dropping conditional compilation.

This implies two additional changes:
 - Always compile related structure definitions inside <macb.h>.
 - MACB_EXT_DESC can be dropped as it is useless now.

The common case:

	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
		struct macb_dma_desc_64 *desc_64;
		if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
			desc_64 = macb_64b_desc(bp, desc);
			// ...
		}
	#endif

Is replaced by:

	if (macb_dma64(bp)) {
		struct macb_dma_desc_64 *desc_64 = macb_64b_desc(bp, desc);
		// ...
	}

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 18 +++++++----
 drivers/net/ethernet/cadence/macb_main.c | 55 ++++++++++----------------------
 drivers/net/ethernet/cadence/macb_ptp.c  |  8 ++---
 3 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index b3a4c9534240a3195adbd7acd325cdaafab60039..f696b2ddc412bffdbdee5dd32c59b338130907f3 100644
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
@@ -855,7 +851,6 @@ struct macb_dma_desc {
 	u32	ctrl;
 };
 
-#ifdef MACB_EXT_DESC
 struct macb_dma_desc_64 {
 	u32 addrh;
 	u32 resvd;
@@ -865,7 +860,6 @@ struct macb_dma_desc_ptp {
 	u32	ts_1;
 	u32	ts_2;
 };
-#endif
 
 /* DMA descriptor bitfields */
 #define MACB_RX_USED_OFFSET			0
@@ -1437,6 +1431,18 @@ static inline u64 enst_max_hw_interval(u32 speed_mbps)
 			    ENST_TIME_GRANULARITY_NS * 1000, (speed_mbps));
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
index 44b96bf53ff6bcb351b27a165451cac852528501..9db419b94d0b47c19cdafb707b1e500124b682c8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -123,35 +123,24 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
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
@@ -473,15 +462,13 @@ static void macb_init_buffers(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	/* Single register for all queues' high 32 bits. */
-	if (bp->caps & MACB_CAPS_DMA_64B) {
+	if (macb_dma64(bp)) {
 		macb_writel(bp, RBQPH,
 			    upper_32_bits(bp->queues[0].rx_ring_dma));
 		macb_writel(bp, TBQPH,
 			    upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
-#endif
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
@@ -1006,10 +993,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 
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
@@ -1018,26 +1004,23 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
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
 
-	if (bp->caps & MACB_CAPS_DMA_64B) {
+	if (macb_dma64(bp)) {
+		struct macb_dma_desc_64 *desc_64;
+
 		desc_64 = macb_64b_desc(bp, desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
-#endif
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-#ifdef CONFIG_MACB_USE_HWSTAMP
-	if (bp->caps & MACB_CAPS_DMA_PTP)
+	if (macb_dma_ptp(bp))
 		addr &= ~GEM_BIT(DMA_RXVALID);
-#endif
 	return addr;
 }
 
@@ -2299,11 +2282,9 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return ret;
 	}
 
-#ifdef CONFIG_MACB_USE_HWSTAMP
-	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (bp->caps & MACB_CAPS_DMA_PTP))
+	if (macb_dma_ptp(bp) &&
+	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-#endif
 
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
 
@@ -2780,14 +2761,10 @@ static void macb_configure_dma(struct macb *bp)
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
@@ -3563,7 +3540,7 @@ static int gem_get_ts_info(struct net_device *dev,
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
2.51.0


