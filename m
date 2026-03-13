Return-Path: <netdev+bounces-267582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNcuL5RwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FF289A37
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B39317C154
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AF3D3D11;
	Fri, 13 Mar 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T642tfQK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAlE7S1L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A73D6461
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432916; cv=none; b=gbGNnJ/4kltf9/Y8i7lYtmQHU3v9w8o+ditpf7ZtXw0SJGshIx1eo742LPnQhcugUA8s2e9UvctoOaJ39AxHH6OyUMuF2GsBx+ca96UCV/8vjGAZ6uOlGa0QTfa9oOFMjRrVTTLQUoVnT8+n8Nd8bk03kdYQmNP8qp8Og9EJTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432916; c=relaxed/simple;
	bh=FNPKlt9y/mkK3Kh1YBl+atu0ulsp+N2tYkUgLHYfMLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRhs3eFAID6ITpl4jGlk7ek6TNQDgQOWRZr7al4XK0AHsgR8U+oEssSPxEnkUO6yc9MOm2jdLKVcsmdTho3JMc9dDfNGz5Kf9KrnlBH+VUE2Z4H1WTAY3ZZqeHjDhKspSfOEh1qBKkQGM7RCEUFRuc4nkPEBZEgvvVLruT2M8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T642tfQK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAlE7S1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bnb2//FqzzrUcK9gAeVLvSs2/U4LIbAhU3zRG94wT4=;
	b=T642tfQKR3G7qEiPaBwNRlCOdsNP1K9v6OE6BAdtjfAkV5xKUnmFFJOUuObiNoP/V4XTGw
	sOekgRjYhTgIBpm2RxP7hDiq4XqtjRZwPyNCavBc1QICCo2WeJYdv74ZM/Z/MjnmpC6Hww
	oe5xGZ19rNwg2ZWd7FOJch34doFY5Pw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-fjXblUxiPRy6YUdUF0RERg-1; Fri, 13 Mar 2026 16:15:08 -0400
X-MC-Unique: fjXblUxiPRy6YUdUF0RERg-1
X-Mimecast-MFC-AGG-ID: fjXblUxiPRy6YUdUF0RERg_1773432907
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so36111575e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432906; x=1774037706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bnb2//FqzzrUcK9gAeVLvSs2/U4LIbAhU3zRG94wT4=;
        b=IAlE7S1LS/nVSMR01FSadfACUxtZWeWjsrfe0Ux4ZfPF9ZbO5nCD4XNYCol0zFb6V/
         Q2mE32cAPfgDSmRvZ4hS3cwvEfUcyTySiLVz8PcNzMxJRKlEXgav51GMoXQKxU4NxhbX
         KJ+SPe+fDcVmmKvLzg0e0Ip+0YbCaFNxb4I4waKhMt6IoaZfoFb3SCZQ0yKA1SBtNDSN
         USBcTl1BEvSsGZYo33yeqsW0/K+t63oePwsJTYF8pi4rXCycMaKtU7JIg9T9JWNrBVZQ
         rjTnKLgtQ3/pg2I4tWlK2uUiVCMA4Lz43G+AfBFoh0rHzEUwa+HMxbqq9iZGSLCEQfTN
         bYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432906; x=1774037706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bnb2//FqzzrUcK9gAeVLvSs2/U4LIbAhU3zRG94wT4=;
        b=FPX6N5zUn3XvYzDTVRCoNSbSXG6gykf3i2ZegtquLITl/5A0wHTgYuJlZ493EVoPA9
         oWuMWsh19JFGWW/6kfZOxJyOS05+aj+r0KEYwNdroUiMk00TfR/tHzuFOZHvKmGRvSfg
         OtjniNvJvD89+zH1th9cQ6T4MtrHC+x6nPVrYX//Sb5zsJfLAeXTrHXWVWV/KasZp5Wl
         3KQ8idT3eVr5P7Jlt2ljTupyga5iUvDOBaP3FLSDUCPlOzhYUDfOuTbRG95S7nFKdkG+
         lmhwVQn9ZzgAwOQXK4kJfAzKtWfnv02BgvMGAfS9v9Vi15TPhL1MIoe8W56EwWviSIX0
         ZukQ==
X-Gm-Message-State: AOJu0Yz7jPVxxMMCuRBX54YgNZPnUApLLOMPQEHt6yl9CHM/MR6qNKHl
	o4tk7yLit3zoy2eMX3iYlisLvhHMz6pVTjCrHqXWjZlyJ+WfbjHiXnlV8JbUw4Nl9winu7k0BbA
	as2B9u/GnPaXAQoJWcdlqLTvKLc1C5NScUkzJ3fBCbo67IN8xVyxnIlmwVRO1FgSh1KtSAycve3
	hrxQQ/F/myE6xeVcWK/dKW1MKkYmNh5uNZnPor+bdb5A==
X-Gm-Gg: ATEYQzwCWNz1riNsMPRxESsiDGEFmKfrtROVVAsg8eZeqPojrZqhQg69HkULpl4yP7s
	qy+YT3HvNz2YfQCECwXk9FufXs4CUmVSCYjO6HnejkaGRI4f5HThmmAAWXjz5KmJ5EmM7ryS8zn
	0pIBpci6vFX3Ye4Z8+Maz17zfCLTfTMt5p8Idq32XepSkFkfK8hAWuewX9f0JtZUG5/Tp6yOgPt
	MF4HskJz7g5ZoMfjC63bgwMCZwQmRpTIE/7O48ns3kOjPHsl73ElR0J3V0HWGAp0xWO1GUi7I7Q
	/AKJnVehN3lK1Obxg6ykvnSFCjwT+JJIQLqS4QxQpxGnFNhqQNaYF0GVuETmdSBkR7Z3pPZKY10
	qqUwdtC/DOvRRHGyahgR0dgvBN+oj/pltDmSTx0h6aLH8TY6nmCVfxR794Gk=
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-485566cfacbmr80135485e9.7.1773432905670;
        Fri, 13 Mar 2026 13:15:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-485566cfacbmr80135055e9.7.1773432905195;
        Fri, 13 Mar 2026 13:15:05 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm482562625e9.11.2026.03.13.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:15:04 -0700 (PDT)
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
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 6/8] net: macb: generalize tx buffer handling
Date: Fri, 13 Mar 2026 21:14:31 +0100
Message-ID: <20260313201433.2346119-7-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267582-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 249FF289A37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename struct macb_tx_buff member skb to ptr and introduce
macb_tx_buff_type to identify the buffer type macb_tx_buff
represents.

Currently the buffer can only be MACB_TYPE_SKB, so the sk_buff
case is handled unconditionally in the tx path.
The remaining type handling will be handled by subsequent patches.

This is the last preparatory step for XDP xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 25 ++++++++-----
 drivers/net/ethernet/cadence/macb_main.c | 45 ++++++++++++++----------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1cc626088174..d8c581394b98 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -965,19 +965,28 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_buff - data about an skb which is being transmitted
- * @skb: skb currently being transmitted, only set for the last buffer
- *       of the frame
- * @mapping: DMA address of the skb's fragment buffer
+enum macb_tx_buff_type {
+	MACB_TYPE_SKB,
+	MACB_TYPE_XDP_TX,
+	MACB_TYPE_XDP_NDO,
+};
+
+/* struct macb_tx_buff - data about an skb or xdp frame which is being
+ * transmitted.
+ * @ptr: pointer to skb or xdp frame being transmitted, only set
+ *        for the last buffer for sk_buff
+ * @mapping: DMA address of the skb's fragment or xdp buffer
  * @size: size of the DMA mapped buffer
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
+ * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP_NDO)
  */
 struct macb_tx_buff {
-	struct sk_buff		*skb;
-	dma_addr_t		mapping;
-	size_t			size;
-	bool			mapped_as_page;
+	void				*ptr;
+	dma_addr_t			mapping;
+	size_t				size;
+	bool				mapped_as_page;
+	enum macb_tx_buff_type		type;
 };
 
 /* Hardware-collected statistics. Used when updating the network
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1dff136cc63a..0cc63c2f498f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1190,7 +1190,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -1202,9 +1203,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
 		tx_buff->mapping = 0;
 	}
 
-	if (tx_buff->skb) {
-		napi_consume_skb(tx_buff->skb, budget);
-		tx_buff->skb = NULL;
+	if (tx_buff->ptr) {
+		napi_consume_skb(tx_buff->ptr, budget);
+		tx_buff->ptr = NULL;
 	}
 }
 
@@ -1291,7 +1292,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1299,7 +1300,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1396,20 +1397,22 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
-	u16 queue_index = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
+	u16 queue_index;
 	int packets = 0;
 	u32 bytes = 0;
 
+	queue_index  = queue - bp->queues;
+
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_buff	*tx_buff;
-		struct sk_buff		*skb;
-		struct macb_dma_desc	*desc;
-		u32			ctrl;
+		struct macb_tx_buff *tx_buff;
+		struct macb_dma_desc *desc;
+		struct sk_buff *skb;
+		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
 
@@ -1427,7 +1430,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+			skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2358,7 +2361,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2386,7 +2390,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2404,7 +2409,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5268,8 +5274,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5361,9 +5368,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			dev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
+		if (lp->rm9200_txq[desc].ptr) {
+			dev_consume_skb_irq(lp->rm9200_txq[desc].ptr);
+			lp->rm9200_txq[desc].ptr = NULL;
 			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
 					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
-- 
2.53.0


