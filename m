Return-Path: <netdev+bounces-277539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IILvMTtW2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 430FD3DC363
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A675A30970C7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378239280A;
	Fri, 10 Apr 2026 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOjdMGCd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF48382F2F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850754; cv=none; b=EVGRKV5L+j6f8vaYfUcds8pMm05e73Mkwof2r6vCLyHN7uPMc3vgqWN8mRY/W20WD+hQHVZsStzuId6Wl3EBLRS3dsJY/WqXKrZYLw5+HTfPNq1rHQLTMCZ4soVhJ77cnMLYzhR4hnWjn/OLuCOUR43nqr6QtNhXHvEI/jrlaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850754; c=relaxed/simple;
	bh=sKwMFjv06OPGTmuJOTj9Z8ZML+IXnDau4bRjdCO/Q4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaG6o7XQ6aNGA8nJZ2KB78UwCU8rkQ8I2mgnDUbKxDSw9jdtqow7UoC1P9+p0wGbyU2H1ioc/Ps6PcgqwO5EiSVM8svBcUzyud+F0oF4ZawTRjgwnvZx7aPAEA40pBKqXe56GDoqwvWjyVaMZEyYbWBLYAGiE53EnHBmuzP4fGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOjdMGCd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 057A11A3267;
	Fri, 10 Apr 2026 19:52:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF389603F0;
	Fri, 10 Apr 2026 19:52:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0959A1045008F;
	Fri, 10 Apr 2026 21:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EL3li+sWSIcf4OdggxFC9UaDJe+IiFNj/Dc4Y8XRilE=;
	b=gOjdMGCdkO19+ubEeaFClz+j3x/gnXd8o9pzEFHmLnizThsHAJ0pFu0tMKHv6tG5KTkrTq
	Q/sz6ngWVEQ8SbxMbA8bAzdL1o4Gr7wvxsLlR43yUggm/fORmBCQXRPJk0kRcuRSYp3ZeE
	+b/F9BxYR1rBjjzhpyqyigCUFkKbwASj7IJbrTdgct04tbud7Ur1hJYMp9FTi0JxYXRCh4
	a4DchF04/42j5/5KdTSIvRxN7RbmnJTf2fUl0whMyCN5UFpCRfbWxriMaT1ITOv3EnQ5VR
	ml8JNQBEfZF38aueLC1qOOTWxCw60rRdbFoJ7xyYwkABQr9lwJr+FDVbl9ciig==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:57 +0200
Subject: [PATCH net-next v2 09/14] net: macb: change caps helpers
 signatures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-9-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277539-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 430FD3DC363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For parallel MACB context to start become a reality, many functions will
soon not have access to `struct macb *bp`. Those will still have access
to caps through ctx->info->caps.

Change all caps helpers signatures, from taking `struct macb *bp` to
taking `u32 caps`.

Function list:

   macb_is_gem()
   gem_has_ptp()
   macb_dma64()
   macb_dma_ptp()
   macb_dma_desc_get_size()
   macb_set_addr()
   macb_get_addr()

Note: drop macb_64b_desc(bp, ...) parameter; it is unused and it must
be dropped as macb_{set,get}_addr() call macb_64b_desc().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  21 ++---
 drivers/net/ethernet/cadence/macb_main.c | 133 ++++++++++++++++---------------
 drivers/net/ethernet/cadence/macb_ptp.c  |   8 +-
 3 files changed, 82 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5ce1b1045e6a..0c11d2805848 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -840,7 +840,7 @@
  */
 #define macb_or_gem_writel(__bp, __reg, __value) \
 	({ \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem((__bp)->caps)) \
 			gem_writel((__bp), __reg, __value); \
 		else \
 			macb_writel((__bp), __reg, __value); \
@@ -849,7 +849,7 @@
 #define macb_or_gem_readl(__bp, __reg) \
 	({ \
 		u32 __v; \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem((__bp)->caps)) \
 			__v = gem_readl((__bp), __reg); \
 		else \
 			__v = macb_readl((__bp), __reg); \
@@ -1470,14 +1470,15 @@ static inline void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb, stru
 static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc) { }
 #endif
 
-static inline bool macb_is_gem(struct macb *bp)
+static inline bool macb_is_gem(u32 caps)
 {
-	return !!(bp->caps & MACB_CAPS_MACB_IS_GEM);
+	return !!(caps & MACB_CAPS_MACB_IS_GEM);
 }
 
-static inline bool gem_has_ptp(struct macb *bp)
+static inline bool gem_has_ptp(u32 caps)
 {
-	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && (bp->caps & MACB_CAPS_GEM_HAS_PTP);
+	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
+	       (caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
 /* ENST Helper functions */
@@ -1493,16 +1494,16 @@ static inline u64 enst_max_hw_interval(u32 speed_mbps)
 			    ENST_TIME_GRANULARITY_NS * 1000, (speed_mbps));
 }
 
-static inline bool macb_dma64(struct macb *bp)
+static inline bool macb_dma64(u32 caps)
 {
 	return IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
-	       bp->caps & MACB_CAPS_DMA_64B;
+	       caps & MACB_CAPS_DMA_64B;
 }
 
-static inline bool macb_dma_ptp(struct macb *bp)
+static inline bool macb_dma_ptp(u32 caps)
 {
 	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
-	       bp->caps & MACB_CAPS_DMA_PTP;
+	       caps & MACB_CAPS_DMA_PTP;
 }
 
 static inline void macb_queue_isr_clear(struct macb *bp,
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9e35c25b7a56..f66f1a174bb4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -126,13 +126,13 @@ struct sifive_fu540_macb_mgmt {
  *    word 5: timestamp word 1
  *    word 6: timestamp word 2
  */
-static unsigned int macb_dma_desc_get_size(struct macb *bp)
+static unsigned int macb_dma_desc_get_size(u32 caps)
 {
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-	if (macb_dma64(bp))
+	if (macb_dma64(caps))
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(caps))
 		desc_size += sizeof(struct macb_dma_desc_ptp);
 
 	return desc_size;
@@ -140,10 +140,10 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
-	return desc_idx * (1 + macb_dma64(bp) + macb_dma_ptp(bp));
+	return desc_idx * (1 + macb_dma64(bp->caps) + macb_dma_ptp(bp->caps));
 }
 
-static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_desc *desc)
+static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
 {
 	return (struct macb_dma_desc_64 *)((void *)desc
 		+ sizeof(struct macb_dma_desc));
@@ -195,7 +195,7 @@ static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 	dma_addr_t offset;
 
 	offset = macb_tx_ring_wrap(queue->bp, index) *
-			macb_dma_desc_get_size(queue->bp);
+			macb_dma_desc_get_size(queue->bp->caps);
 
 	return txq->ring_dma + offset;
 }
@@ -282,7 +282,7 @@ static void macb_set_hwaddr(struct macb *bp)
 	top = get_unaligned_le16(bp->netdev->dev_addr + 4);
 	macb_or_gem_writel(bp, SA1T, top);
 
-	if (gem_has_ptp(bp)) {
+	if (gem_has_ptp(bp->caps)) {
 		gem_writel(bp, RXPTPUNI, bottom);
 		gem_writel(bp, TXPTPUNI, bottom);
 	}
@@ -493,7 +493,7 @@ static void macb_init_buffers(struct macb *bp)
 	unsigned int q;
 
 	/* Single register for all queues' high 32 bits. */
-	if (macb_dma64(bp)) {
+	if (macb_dma64(bp->caps)) {
 		rxq = &bp->ctx->rxq[0];
 		txq = &bp->ctx->txq[0];
 		macb_writel(bp, RBQPH, upper_32_bits(rxq->ring_dma));
@@ -776,7 +776,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
-	} else if (macb_is_gem(bp)) {
+	} else if (macb_is_gem(bp->caps)) {
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
@@ -834,7 +834,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	unsigned char desc[24];
 	unsigned long flags;
 
-	desc_size = macb_dma_desc_get_size(bp);
+	desc_size = macb_dma_desc_get_size(bp->caps);
 
 	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
 		return;
@@ -941,7 +941,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		ctrl &= ~MACB_BIT(PAE);
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			ctrl &= ~GEM_BIT(GBE);
 
 			if (speed == SPEED_1000)
@@ -972,7 +972,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);
-	if (gem_has_ptp(bp))
+	if (gem_has_ptp(bp->caps))
 		ctrl |= MACB_BIT(PTPUNI);
 
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
@@ -1082,7 +1082,8 @@ static int macb_mii_probe(struct net_device *netdev)
 		  bp->phylink_config.supported_interfaces);
 
 	/* Determine what modes are supported */
-	if (macb_is_gem(bp) && (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
+	if (macb_is_gem(bp->caps) &&
+	    (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
 		bp->phylink_config.mac_capabilities |= MAC_1000FD;
 		if (!(bp->caps & MACB_CAPS_NO_GIGABIT_HALF))
 			bp->phylink_config.mac_capabilities |= MAC_1000HD;
@@ -1250,12 +1251,12 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 	}
 }
 
-static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_t addr)
+static void macb_set_addr(u32 caps, struct macb_dma_desc *desc, dma_addr_t addr)
 {
-	if (macb_dma64(bp)) {
+	if (macb_dma64(caps)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
 		 * of which allows packet RX. Make sure the high bits are also
@@ -1267,18 +1268,18 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 	desc->addr = lower_32_bits(addr);
 }
 
-static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
+static dma_addr_t macb_get_addr(u32 caps, struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
 
-	if (macb_dma64(bp)) {
+	if (macb_dma64(caps)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(caps))
 		addr &= ~GEM_BIT(DMA_RXVALID);
 	return addr;
 }
@@ -1378,7 +1379,7 @@ static void macb_tx_error_task(struct work_struct *work)
 
 	/* Set end of TX queue */
 	desc = macb_tx_desc(queue, 0);
-	macb_set_addr(bp, desc, 0);
+	macb_set_addr(bp->caps, desc, 0);
 	desc->ctrl = MACB_BIT(TX_USED);
 
 	/* Make descriptor updates visible to hardware */
@@ -1563,7 +1564,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			 * make sure ctrl is cleared first to avoid a race.
 			 */
 			dma_wmb();
-			macb_set_addr(bp, desc, paddr);
+			macb_set_addr(bp->caps, desc, paddr);
 
 			/* Properly align Ethernet header.
 			 *
@@ -1637,7 +1638,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		rmb();
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
-		addr = macb_get_addr(bp, desc);
+		addr = macb_get_addr(bp->caps, desc);
 
 		if (!rxused)
 			break;
@@ -1799,7 +1800,7 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 	addr = rxq->buffers_dma;
 	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
 		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+		macb_set_addr(bp->caps, desc, addr);
 		desc->ctrl = 0;
 		addr += bp->ctx->rx_buffer_size;
 	}
@@ -1952,7 +1953,7 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
-	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
+	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp->caps);
 	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
 	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
 
@@ -2129,7 +2130,7 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 	if (status & MACB_BIT(ISR_ROVR)) {
 		/* We missed at least one packet */
 		spin_lock(&bp->stats_lock);
-		if (macb_is_gem(bp))
+		if (macb_is_gem(bp->caps))
 			bp->hw_stats.gem.rx_overruns++;
 		else
 			bp->hw_stats.macb.rx_overruns++;
@@ -2143,7 +2144,7 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		if (status & GEM_BIT(WOL))
 			gem_wol_interrupt(queue, status);
 	} else {
@@ -2381,7 +2382,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp->caps, desc, tx_skb->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2532,7 +2533,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		return ret;
 	}
 
-	if (macb_dma_ptp(bp) &&
+	if (macb_dma_ptp(bp->caps) &&
 	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
@@ -2619,7 +2620,7 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int size;
 
-	if (!macb_is_gem(bp)) {
+	if (!macb_is_gem(bp->caps)) {
 		size = MACB_RX_BUFFER_SIZE;
 	} else {
 		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
@@ -2660,7 +2661,7 @@ static void gem_free_rx_buffers(struct macb *bp)
 				continue;
 
 			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(bp, desc);
+			addr = macb_get_addr(bp->caps, desc);
 
 			dma_unmap_single(&bp->pdev->dev, addr,
 					 bp->ctx->rx_buffer_size,
@@ -2689,13 +2690,13 @@ static void macb_free_rx_buffers(struct macb *bp)
 
 static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
+	return macb_dma_desc_get_size(bp->caps) * bp->ctx->tx_ring_size +
 		bp->tx_bd_rd_prefetch;
 }
 
 static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->rx_ring_size +
+	return macb_dma_desc_get_size(bp->caps) * bp->ctx->rx_ring_size +
 		bp->rx_bd_rd_prefetch;
 }
 
@@ -2843,7 +2844,7 @@ static void gem_init_rings(struct macb *bp)
 		txq = &bp->ctx->txq[q];
 		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 			desc = macb_tx_desc(queue, i);
-			macb_set_addr(bp, desc, 0);
+			macb_set_addr(bp->caps, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
@@ -2864,7 +2865,7 @@ static void macb_init_rings(struct macb *bp)
 
 	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 		desc = macb_tx_desc(&bp->queues[0], i);
-		macb_set_addr(bp, desc, 0);
+		macb_set_addr(bp->caps, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
 	txq->head = 0;
@@ -2933,7 +2934,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
 	u32 config;
 	unsigned long pclk_hz;
 
-	if (macb_is_gem(bp))
+	if (macb_is_gem(bp->caps))
 		return gem_mdc_clk_div(bp);
 
 	pclk_hz = clk_get_rate(bp->pclk);
@@ -2955,7 +2956,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
  */
 static u32 macb_dbw(struct macb *bp)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return 0;
 
 	switch (GEM_BFEXT(DBWDEF, gem_readl(bp, DCFG1))) {
@@ -2984,7 +2985,7 @@ static void macb_configure_dma(struct macb *bp)
 	u32 dmacfg;
 
 	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			if (q)
@@ -3008,9 +3009,9 @@ static void macb_configure_dma(struct macb *bp)
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
 		dmacfg &= ~GEM_BIT(ADDR64);
-		if (macb_dma64(bp))
+		if (macb_dma64(bp->caps))
 			dmacfg |= GEM_BIT(ADDR64);
-		if (macb_dma_ptp(bp))
+		if (macb_dma_ptp(bp->caps))
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
 		netdev_dbg(bp->netdev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
@@ -3038,7 +3039,7 @@ static void macb_init_hw(struct macb *bp)
 		config |= MACB_BIT(BIG);	/* Receive oversized frames */
 	if (bp->netdev->flags & IFF_PROMISC)
 		config |= MACB_BIT(CAF);	/* Copy All Frames */
-	else if (macb_is_gem(bp) && bp->netdev->features & NETIF_F_RXCSUM)
+	else if (macb_is_gem(bp->caps) && bp->netdev->features & NETIF_F_RXCSUM)
 		config |= GEM_BIT(RXCOEN);
 	if (!(bp->netdev->flags & IFF_BROADCAST))
 		config |= MACB_BIT(NBC);	/* No BroadCast */
@@ -3146,14 +3147,14 @@ static void macb_set_rx_mode(struct net_device *netdev)
 		cfg |= MACB_BIT(CAF);
 
 		/* Disable RX checksum offload */
-		if (macb_is_gem(bp))
+		if (macb_is_gem(bp->caps))
 			cfg &= ~GEM_BIT(RXCOEN);
 	} else {
 		/* Disable promiscuous mode */
 		cfg &= ~MACB_BIT(CAF);
 
 		/* Enable RX checksum offload only if requested */
-		if (macb_is_gem(bp) && netdev->features & NETIF_F_RXCSUM)
+		if (macb_is_gem(bp->caps) && netdev->features & NETIF_F_RXCSUM)
 			cfg |= GEM_BIT(RXCOEN);
 	}
 
@@ -3436,7 +3437,7 @@ static void macb_get_stats(struct net_device *netdev,
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	netdev_stats_to_stats64(nstat, &bp->netdev->stats);
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		gem_get_stats(bp, nstat);
 		return;
 	}
@@ -3684,7 +3685,7 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED))
 		regs_buff[12] = macb_or_gem_readl(bp, USRIO);
-	if (macb_is_gem(bp))
+	if (macb_is_gem(bp->caps))
 		regs_buff[13] = gem_readl(bp, DMACFG);
 }
 
@@ -3816,7 +3817,7 @@ static int gem_get_ts_info(struct net_device *netdev,
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (!macb_dma_ptp(bp)) {
+	if (!macb_dma_ptp(bp->caps)) {
 		ethtool_op_get_ts_info(netdev, info);
 		return 0;
 	}
@@ -3917,7 +3918,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	bool cmp_b = false;
 	bool cmp_c = false;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	tp4sp_v = &(fs->h_u.tcp_ip4_spec);
@@ -4278,7 +4279,7 @@ static inline void macb_set_txcsum_feature(struct macb *bp,
 {
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	val = gem_readl(bp, DMACFG);
@@ -4296,7 +4297,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 	struct net_device *netdev = bp->netdev;
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	val = gem_readl(bp, NCFGR);
@@ -4311,7 +4312,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 static inline void macb_set_rxflow_feature(struct macb *bp,
 					   netdev_features_t features)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	gem_enable_flow_filters(bp, !!(features & NETIF_F_NTUPLE));
@@ -4630,7 +4631,7 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_FIFO_MODE;
 		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
 			bp->caps |= MACB_CAPS_RSC;
-		if (gem_has_ptp(bp)) {
+		if (gem_has_ptp(bp->caps)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,
 					"GEM doesn't support hardware ptp.\n");
@@ -4842,7 +4843,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 	netdev->netdev_ops = &macb_netdev_ops;
 
 	/* setup appropriated routines according to adapter type */
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		bp->macbgem_ops.mog_alloc_rx_buffers = gem_alloc_rx_buffers;
 		bp->macbgem_ops.mog_free_rx_buffers = gem_free_rx_buffers;
 		bp->macbgem_ops.mog_init_rings = gem_init_rings;
@@ -4871,7 +4872,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		netdev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */
-	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
+	if (macb_is_gem(bp->caps) && !(bp->caps & MACB_CAPS_FIFO_MODE))
 		netdev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		netdev->hw_features &= ~NETIF_F_SG;
@@ -4997,7 +4998,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
 				       (AT91ETHER_MAX_RX_DESCR *
-					macb_dma_desc_get_size(bp)),
+					macb_dma_desc_get_size(bp->caps)),
 				       &rxq->ring_dma, GFP_KERNEL);
 	if (!rxq->ring)
 		return -ENOMEM;
@@ -5010,7 +5011,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 	if (!rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(bp->caps),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 		return -ENOMEM;
@@ -5026,7 +5027,7 @@ static void at91ether_free_coherent(struct macb *bp)
 	if (rxq->ring) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(bp->caps),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 	}
@@ -5057,7 +5058,7 @@ static int at91ether_start(struct macb *bp)
 	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
 		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+		macb_set_addr(bp->caps, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
 	}
@@ -5572,13 +5573,13 @@ static int macb_alloc_tieoff(struct macb *bp)
 		return 0;
 
 	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-						macb_dma_desc_get_size(bp),
+						macb_dma_desc_get_size(bp->caps),
 						&bp->rx_ring_tieoff_dma,
 						GFP_KERNEL);
 	if (!bp->rx_ring_tieoff)
 		return -ENOMEM;
 
-	macb_set_addr(bp, bp->rx_ring_tieoff,
+	macb_set_addr(bp->caps, bp->rx_ring_tieoff,
 		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
 
 	bp->rx_ring_tieoff->ctrl = 0;
@@ -5591,7 +5592,7 @@ static void macb_free_tieoff(struct macb *bp)
 	if (!bp->rx_ring_tieoff)
 		return;
 
-	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp->caps),
 			  bp->rx_ring_tieoff,
 			  bp->rx_ring_tieoff_dma);
 	bp->rx_ring_tieoff = NULL;
@@ -5972,12 +5973,12 @@ static int macb_probe(struct platform_device *pdev)
 		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->rx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(bp->caps);
 
 		val = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->tx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(bp->caps);
 	}
 
 	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
@@ -6022,7 +6023,7 @@ static int macb_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
 
 	netdev_info(netdev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
-		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
+		    macb_is_gem(bp->caps) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    netdev->base_addr, netdev->irq, netdev->dev_addr);
 
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
@@ -6150,7 +6151,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			tmp |= MACB_BFEXT(IP, ifa_local);
 		}
 
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, tmp);
 		} else {
@@ -6212,7 +6213,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
 		/* Disable WoL */
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			queue_writel(bp->queues, IDR, GEM_BIT(WOL));
 			gem_writel(bp, WOL, 0);
 		} else {
@@ -6240,7 +6241,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
-			if (macb_is_gem(bp))
+			if (macb_is_gem(bp->caps))
 				gem_init_rx_ring(queue);
 			else
 				macb_init_rx_ring(queue);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7dac1d..2070508fd2e0 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -28,10 +28,10 @@
 static struct macb_dma_desc_ptp *macb_ptp_desc(struct macb *bp,
 					       struct macb_dma_desc *desc)
 {
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return NULL;
 
-	if (macb_dma64(bp))
+	if (macb_dma64(bp->caps))
 		return (struct macb_dma_desc_ptp *)
 				((u8 *)desc + sizeof(struct macb_dma_desc)
 				+ sizeof(struct macb_dma_desc_64));
@@ -384,7 +384,7 @@ int gem_get_hwtst(struct net_device *netdev,
 	struct macb *bp = netdev_priv(netdev);
 
 	*tstamp_config = bp->tstamp_config;
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -411,7 +411,7 @@ int gem_set_hwtst(struct net_device *netdev,
 	struct macb *bp = netdev_priv(netdev);
 	u32 regval;
 
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return -EOPNOTSUPP;
 
 	switch (tstamp_config->tx_type) {

-- 
2.53.0


