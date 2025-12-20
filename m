Return-Path: <netdev+bounces-245617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E539ACD38E7
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DB863001C14
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418652FE075;
	Sat, 20 Dec 2025 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egnH9i66";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGGyBjPC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7218FC80
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274713; cv=none; b=P1LaYKAhkDFdq9lwpBsk+H5nGdaHDKq4RypY8vxXrnqC6B43wwO8mc/FlVNsO+X+TWX7ZayyPNbufxo4QJTFw8/+KPOGmMpXCby8kJsN7IKV5kW1Dp4HR+fJQYg7FER1YRpajbXxxQZklZ39McDZEzTTEngf0NMilKfcf1lxO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274713; c=relaxed/simple;
	bh=lSwq4jASaoPG+r7pSBuf73W/qMPfkbF0urYOmqZu3z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2QhLz9apdVkuuCCpdkgbYWylyyaJx4K98ydviKA1WqYdWHqCby/djd58Cy9joJvsyR6MoJmR5ux6wmVq+2guS+PwLXisin6XBsQVqSPWWxc30B30g2mfPPZlQPUwc8hUyaRJaBJQID7FmT/YPJZ9FzgqYX9+OB2MZECy1FeuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egnH9i66; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGGyBjPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlP9gSBJZGD2IhvimTRoZVYc5EbfM6swYlf+gHltYgI=;
	b=egnH9i66E2j7meH7OFQhiOhG8Y8d2+GF52vUxibBQKIn2Q6hdOS1mTbACFPfztX5hT0xax
	jT6Nq+wRUBYKXxzNuMR8uc2hIGJ3fLwxOnv753OBMYe0Bw0jeO33AGg3r+c+kxM/Ywpe2W
	8OuepdoO4ScSlE3Yi3iFcbsMtq7et9g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-bBVpzqNUOPiTgRy4fEMcgQ-1; Sat, 20 Dec 2025 18:51:48 -0500
X-MC-Unique: bBVpzqNUOPiTgRy4fEMcgQ-1
X-Mimecast-MFC-AGG-ID: bBVpzqNUOPiTgRy4fEMcgQ_1766274708
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7a041a9121so398265566b.3
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274706; x=1766879506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlP9gSBJZGD2IhvimTRoZVYc5EbfM6swYlf+gHltYgI=;
        b=YGGyBjPCIJLzKcN8LQxto1aQjRuFvMC0Aeb2V+i3JceSu3b8QXmjJ8krRKY1bXSElL
         fbaeQhumokImRBzld0oV7ZWmSzZ7TZMz1l64cl7koJ+B4VkvMCgnu40WGF23+HvjiUV8
         XrLZW08lrb15VkIB/27VpiLIgH4mfWCGR3Ys5DwJFtyFx8k7WIgDqjb7Ntmr9FI/Be00
         nfxVJah2d5hMJFzJsp/EjDOJgV75Lc1cwLw+8ypTf450nqPrXffoni9IDESQrUNu1sSG
         d+o8ewKeosbvEJvmDI1L0UoBTp1i65il2bF4IPH44+aa4KO+4bPLNI1sMebLUlBlGfo7
         ELfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274706; x=1766879506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlP9gSBJZGD2IhvimTRoZVYc5EbfM6swYlf+gHltYgI=;
        b=CMuSkbeyIlFNOXAJgIkWG8HoImecVyH4+IH8ntpX9doeyPbFne1f+hB4qW6MjUMRTU
         6eiIKBukwQS1NKFHfTOqASdMt73uVRZ/H5npTROh7c/asGE18OLUrIWFIU84d06QsOdY
         Bz2zbYs8qHFXM9jjPlmgjaKxM2MbBPk/XGcyUviIKYhPiu9DXdQscqowCaBPkz0mYlMe
         iyB0ocsmUorN8oIWSEbooi+PYpup8cRnOZSXGTititpTz7wR6ELepnMowEYdw2phMtav
         VQ3OtoHYhkDKEDSunAV4MVjeGGNZ26vip/VwfH+xXfORojaYZg+26/1X8Ayanc8pd8Lz
         H3/w==
X-Gm-Message-State: AOJu0YzQnIfKeoG/fZ2nQ5GAQC2kngsg/PzBpxe0N7hD5BojFeW/Sh4b
	UjPUcCuD0xYs8UigcRs+YtoPIsNODEYnD20kYtboyvkd2uHYWuqrKH2NMvRpNsYIpBHVbRqWGaO
	hn8+FhZbHZodeeqNEaerKBqETyr7qK/iKlFfVa+VrI3WPuR8BunUAmv1wammz3hILkPSN9dfV37
	mIhpgA/igGbks+vbG8NRGmmjo3+ECDT9syvoV3QylUWw==
X-Gm-Gg: AY/fxX4ssKRcBNzG5+vTQV0aVZScrmICIhbM38c+QNB86Bij/ha/V7NqQWqXN12Rmim
	P0TJ/vegDMbrQGZfcu3QsC0egpmMBHPGWh58nPMrpnUd3pj2l/zvKvHfLZ2TjHI5tW0gOm76ogS
	Yc5vIv1a8Fii/EURng216SzMECSb6W4y8DQtxcnyLq4WL5v6Wk5E6kChmQhAHt1O7pBenj+w++i
	rNnkI0TfIsJCxsPyoMSk6KE4RcDuqxvEZTAyUorv0yt8rXlsF/oI2yeEVWfPtCzSCnEt8LWCHly
	WHAm/ahPijApjIPneLOOVqud6D8Iftk7Dgjq6KkWoxezAPEZUYtB7LlQWgoB/bG7pTbvVznbX5J
	AwnmGuraZC+5gefMhgRRQZt/DzPDGEyYe17jy0H4=
X-Received: by 2002:a17:907:961c:b0:b7f:fd02:9b4e with SMTP id a640c23a62f3a-b8036f90153mr771204066b.28.1766274706111;
        Sat, 20 Dec 2025 15:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNuiXbQghVP1yLBWHzmVnlBaQq6U5Bcf43Khf4WBoCl/4x3TvEG5ur2lB+zJ5Bk2PN5XrvDQ==
X-Received: by 2002:a17:907:961c:b0:b7f:fd02:9b4e with SMTP id a640c23a62f3a-b8036f90153mr771202066b.28.1766274705711;
        Sat, 20 Dec 2025 15:51:45 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm619062366b.10.2025.12.20.15.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:45 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH RFC net-next v2 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Sun, 21 Dec 2025 00:51:28 +0100
Message-ID: <20251220235135.1078587-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220235135.1078587-1-pvalerio@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
up all slots with valid buffers.

gem_rx_refill() is called at link up by
gem_init_rings() == bp->macbgem_ops.mog_init_rings().

Move operation to macb_open(), mostly to allow it to fail early and
loudly rather than init the device with Rx mostly broken.

About `bool fail_early`:
 - When called from macb_open(), ring init fails as soon as a queue
   cannot be refilled.
 - When called from macb_hresp_error_task(), we do our best to reinit
   the device: we still iterate over all queues and try refilling all
   even if a previous queue failed.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
Picked up as agreed from the discussion about v1.
This is slightly different from the original patch.
mog_init_rings() was simply moved after rx_ring_tieoff
allocation to avoid a NULL pointer dereference of rx_ring_tieoff.
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 39 ++++++++++++++++++------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..2cb65ec37d44 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1180,7 +1180,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e461f5072884..cd869db27920 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,10 +705,9 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
+		/* Initialize buffer registers as clearing MACB_BIT(TE) in link
+		 * down cleared the pipeline and control registers.
 		 */
-		bp->macbgem_ops.mog_init_rings(bp);
 		macb_init_buffers(bp);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -1250,13 +1249,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	unsigned int		entry;
 	struct sk_buff		*skb;
 	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1273,6 +1273,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1322,6 +1323,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1774,7 +1776,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2547,8 +2549,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2560,6 +2560,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2580,11 +2585,13 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp, bool fail_early)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2600,13 +2607,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_rx_refill(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+		}
 	}
 
 	macb_init_tieoff(bp);
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp, bool fail_early)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2623,6 +2641,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
-- 
2.52.0


