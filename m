Return-Path: <netdev+bounces-232198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 771AEC026DD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAADC4E6B42
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A042FD676;
	Thu, 23 Oct 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EswT/0EU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDB2D24B7;
	Thu, 23 Oct 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236601; cv=none; b=DB0CK95OBOt8M0PRd+vmJ6X8HE+utPQCnQ9PG2z2wcz9UWFYVg+T0ax2Bf/ih8pbxH6dV/t++iF3vJ4E6Y+uiw7luAWWqGQWtvtDhi7RbYLW3/eb1d/B0mB/yT3ks7fS9i65ooHVHuoPShTxQKqyBHBVCU+NMRKRQF3gFoUq2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236601; c=relaxed/simple;
	bh=kw4pwejY//2AZ7tsFsh9thrSr6b9sczm9MMniR6xMcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BF8/nLTG70f1f5dQJnqZCTmRvXwQrARHTcscRiAnFnL+uWBcCU30R8mt7BFOAIVl/wsRpl7BosqgHLc76t0kg00TWyeqEHknak26dUCbxy5z1Fz7Te4pWxNer2fozEdIe7xfHh6WD71RIyEqNWNiif2/TnFUlTm0nqQybEYouDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EswT/0EU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 670ADC0C431;
	Thu, 23 Oct 2025 16:22:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46847606DE;
	Thu, 23 Oct 2025 16:23:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10E7D102F2473;
	Thu, 23 Oct 2025 18:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761236596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d3Jk9Ob4iaLKf7sQIf4J4/RHLTUj7WHizfDugE7sKSM=;
	b=EswT/0EU03J0XUerpewEEBJJlJjdjRBTLOX2r5kV6FdRmyn/tDVIdvpxxvPrWM5DI4UdTl
	t6spd/elDzUTskbSU+yeqKmO9tfl76jaXCsQNp+7eVTMADPLUlbncjdmRFTooh60wHVsiA
	01GGd7LkFnbAtNGtRDmY5DEY1ggU4PxLeBT9WTTaDCLPR+fsl9rrHaQQcDSnY2WdsTFiHx
	0nLgjqyKD87NAhVGH8W3GXb/kfZ91cl0DCIFKO4aAXuvuBiiDa+C0Bb6xM95SSo3MnQjSj
	NtB+M02ifaB33Q6h7X5FtSipEkX8xpG4atRHGgPhwdRagpaZpwHh3RQ39uVtTg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 23 Oct 2025 18:22:52 +0200
Subject: [PATCH net-next v3 2/5] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-macb-eyeq5-v3-2-af509422c204@bootlin.com>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
In-Reply-To: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

If HW is RSC capable, it cannot add dummy bytes at the start of IP
packets. Alignment (ie number of dummy bytes) is configured using the
RBOF field inside the NCFGR register.

On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
be done if those dummy bytes are added by the hardware; notice the
skb_reserve() is done AFTER writing the address to the device.

We cannot do the skb_reserve() call BEFORE writing the address because
the address field ignores the low 2/3 bits. Conclusion: in some cases,
we risk not being able to respect the NET_IP_ALIGN value (which is
picked based on unaligned CPU access performance).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 23 ++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5b7d4cdb204d..93e8dd092313 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -537,6 +537,8 @@
 /* Bitfields in DCFG6. */
 #define GEM_PBUF_LSO_OFFSET			27
 #define GEM_PBUF_LSO_SIZE			1
+#define GEM_PBUF_RSC_OFFSET			26
+#define GEM_PBUF_RSC_SIZE			1
 #define GEM_PBUF_CUTTHRU_OFFSET			25
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
@@ -775,6 +777,7 @@
 #define MACB_CAPS_MACB_IS_GEM			BIT(20)
 #define MACB_CAPS_DMA_64B			BIT(21)
 #define MACB_CAPS_DMA_PTP			BIT(22)
+#define MACB_CAPS_RSC				BIT(23)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 39673f5c3337..be3d0c2313a1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1300,8 +1300,19 @@ static void gem_rx_refill(struct macb_queue *queue)
 			dma_wmb();
 			macb_set_addr(bp, desc, paddr);
 
-			/* properly align Ethernet header */
-			skb_reserve(skb, NET_IP_ALIGN);
+			/* Properly align Ethernet header.
+			 *
+			 * Hardware can add dummy bytes if asked using the RBOF
+			 * field inside the NCFGR register. That feature isn't
+			 * available if hardware is RSC capable.
+			 *
+			 * We cannot fallback to doing the 2-byte shift before
+			 * DMA mapping because the address field does not allow
+			 * setting the low 2/3 bits.
+			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
+			 */
+			if (!(bp->caps & MACB_CAPS_RSC))
+				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
 			dma_wmb();
@@ -2773,7 +2784,11 @@ static void macb_init_hw(struct macb *bp)
 	macb_set_hwaddr(bp);
 
 	config = macb_mdc_clk_div(bp);
-	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
+	/* Make eth data aligned.
+	 * If RSC capable, that offset is ignored by HW.
+	 */
+	if (!(bp->caps & MACB_CAPS_RSC))
+		config |= MACB_BF(RBOF, NET_IP_ALIGN);
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
 	if (bp->caps & MACB_CAPS_JUMBO)
 		config |= MACB_BIT(JFRAME);	/* Enable jumbo frames */
@@ -4321,6 +4336,8 @@ static void macb_configure_caps(struct macb *bp,
 		dcfg = gem_readl(bp, DCFG2);
 		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
 			bp->caps |= MACB_CAPS_FIFO_MODE;
+		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
+			bp->caps |= MACB_CAPS_RSC;
 		if (gem_has_ptp(bp)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,

-- 
2.51.1


