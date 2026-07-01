Return-Path: <netdev+bounces-303738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWc5Ozs6RWqW8woAu9opvQ
	(envelope-from <netdev+bounces-303738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B041B6EF767
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:03:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HklDjcjY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02DFD30265E3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8B4968E1;
	Wed,  1 Jul 2026 15:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8D494A08
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:59:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921571; cv=none; b=bXmwe7It3U+BbcY8DA+JG27KScHLvOMQJNxCcK2T01dAwpcnVsJbg9bAyiGOsOVyVZ3YA7UDmVYEmnLmjSan6XsI+WolkFqFOyoIckQNCHDwWqQoisiQUGP5YbAxEhPZP5ltdlgMeM2ejTaIxM4b58bhkw1OfFSWqB3ISRARhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921571; c=relaxed/simple;
	bh=4N8mHNWMwqxOmMYNEYfZ4nTxUb2buaGtzQASrlT9rqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=le6e/ojDpsOL2R5H2bsVm79QKxZGovKH8nhQB9xvMJPMcrfL8GU9JqC8Dyys2GkHWqFwPZW3Ovew7V18DorXLAKVqsij09u14LgNO0QifEcsu+7o99Y1URwMmUuPUuIrjsWE5Bx9dfqcRxh+LXabTtyCGzK9AoSXtwDdZLS2j9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HklDjcjY; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 47B5DC4FECB;
	Wed,  1 Jul 2026 15:59:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47A3660288;
	Wed,  1 Jul 2026 15:59:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7AD6104C9686;
	Wed,  1 Jul 2026 17:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NQlMhQ/nVeLPLSWP2dYh32czHerWOdCqsQuS6HHwx4w=;
	b=HklDjcjYw1tm8Qwgw6WRfh4Cjf39YssDW0GbyjBn5VEqWHuNNIopHpXgnxBXDEhvv4iBSa
	QY42brS02cAGfy19++zgBQLklvHuLEJ/YYHsEjo6nFxuDZki4Kf/zrHlwtFE6//nHNMnic
	UVLuhHJNKPz3YhWqa9D82shyqbVHSmS1zVHZzFZIS4JWlWpjAf/Nxz9bSNev/Q+fiIIEU6
	0IrITqZ2rjd61ppZcqr9PGA1le+D2FpFW5xeOoTk3lRsqofwJ+ADZECUwNsNfg9FfTG+7y
	W2xmUob2eoJt8A2pw0Jmrgr/121PERmnBzUXhJhxwznffGUKvoJAXiBtH9RfFA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:09 +0200
Subject: [PATCH net-next v3 06/15] net: macb: allocate tieoff descriptor
 once across device lifetime
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-6-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B041B6EF767

The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
configured onto queues for Wake-on-LAN during system-wide suspend when
hardware does not support disabling individual queues
(MACB_CAPS_QUEUE_DISABLE).

MACB/GEM driver allocates it alongside the main RX ring
inside macb_alloc() at open. Free is done by macb_free() at close.

Change to allocate once at probe and free on probe failure or device
removal. This makes the tieoff descriptor lifetime much longer,
avoiding repeating coherent buffer allocation on each open/close cycle.

Main benefit: we dissociate its lifetime from the main ring's lifetime.
That way there is less work to be doing on resources (re)alloc. This
currently happens on close/open, but will soon also happen on context
swap operations (set_ringparam, change_mtu, set_channels, etc).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 75 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8b52122bc134..951a7f080225 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2653,12 +2653,6 @@ static void macb_free(struct macb *bp)
 	unsigned int q;
 	size_t size;
 
-	if (bp->rx_ring_tieoff) {
-		dma_free_coherent(dev, macb_dma_desc_get_size(bp),
-				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
-		bp->rx_ring_tieoff = NULL;
-	}
-
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
@@ -2756,16 +2750,6 @@ static int macb_alloc(struct macb *bp)
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
-	/* Required for tie off descriptor for PM cases */
-	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
-		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-							macb_dma_desc_get_size(bp),
-							&bp->rx_ring_tieoff_dma,
-							GFP_KERNEL);
-		if (!bp->rx_ring_tieoff)
-			goto out_err;
-	}
-
 	return 0;
 
 out_err:
@@ -2773,19 +2757,6 @@ static int macb_alloc(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void macb_init_tieoff(struct macb *bp)
-{
-	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
-
-	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
-		return;
-	/* Setup a wrapping descriptor with no free slots
-	 * (WRAP and USED) to tie off/disable unused RX queues.
-	 */
-	macb_set_addr(bp, desc, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
-	desc->ctrl = 0;
-}
-
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
 	queue->rx_tail = 0;
@@ -2813,8 +2784,6 @@ static void gem_init_rings(struct macb *bp)
 
 		gem_init_rx_ring(queue);
 	}
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
+static int macb_alloc_tieoff(struct macb *bp)
+{
+	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return 0;
+
+	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+						macb_dma_desc_get_size(bp),
+						&bp->rx_ring_tieoff_dma,
+						GFP_KERNEL);
+	if (!bp->rx_ring_tieoff)
+		return -ENOMEM;
+
+	macb_set_addr(bp, bp->rx_ring_tieoff,
+		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+
+	bp->rx_ring_tieoff->ctrl = 0;
+
+	return 0;
+}
+
+static void macb_free_tieoff(struct macb *bp)
+{
+	if (!bp->rx_ring_tieoff)
+		return;
+
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+			  bp->rx_ring_tieoff,
+			  bp->rx_ring_tieoff_dma);
+	bp->rx_ring_tieoff = NULL;
+}
+
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };
@@ -5927,10 +5926,14 @@ static int macb_probe(struct platform_device *pdev)
 
 	netif_carrier_off(netdev);
 
+	err = macb_alloc_tieoff(bp);
+	if (err)
+		goto err_out_unregister_mdio;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
-		goto err_out_unregister_mdio;
+		goto err_out_free_tieoff;
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
@@ -5944,6 +5947,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_out_free_tieoff:
+	macb_free_tieoff(bp);
+
 err_out_unregister_mdio:
 	mdiobus_unregister(bp->mii_bus);
 	mdiobus_free(bp->mii_bus);
@@ -5973,6 +5979,7 @@ static void macb_remove(struct platform_device *pdev)
 	if (netdev) {
 		bp = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		macb_free_tieoff(bp);
 		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);

-- 
2.55.0


