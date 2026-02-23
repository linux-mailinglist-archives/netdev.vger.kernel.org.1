Return-Path: <netdev+bounces-260151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLIcD1GcnGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:28:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71717B7BD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D6830CD02F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C3340A6C;
	Mon, 23 Feb 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuMpnf3D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fks6arvD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8996330D23
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871248; cv=none; b=un0bDE+g2kxD1O4FEV43/C1ZEuf4nkp+wRBeGVnZFWpOlNFCch/64wrK6uXs/aihiWQcKzSnLtGG6RO63i+yaIVyaPXvGOfkakuqpTMwqP/uRwhD270a5weGwKUCqcoxU+yomcKwgAMKIsY370JKbvPnsizJWtGJnixQXx6Z15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871248; c=relaxed/simple;
	bh=q+4evuwuYD+PFdT2vnS9ktmRHdd6MdU95dtZKvXnfMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8+gWQxqLlFIW+Z68jr3Gm965fQXLWn3KK0xyQjC4BLKZXDsW+WpQ7Oe42ugEr9raIF2Qq4rdNx2njyN+yIeLRpfOYeRt4pEo9RJHgFvd4ZYbq9L0uYQUKEspFAKHLOAfRWUpPrQAaMp9xXaEMUTHE9QqAjTZdcPqDQgu0ye1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuMpnf3D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fks6arvD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUsyb6XUynVbSnvGrmF4BaKu58Lr18hmIlwA9Ild52E=;
	b=VuMpnf3Dk9K6Al1lb36nxfh143rZU2bk7siRHB//4YLseL4dtAlfKRs4ptPrLwXcQsnaN/
	F0xxAJ1jna1tGFrs+s+vcpZrdLGSwnlTwYRfRT/VLplrV8mMUQQC4h/Wp+EYqhaQ5ygpRi
	n2sJnUThpkdzbqqGbVogUY2z3gPsz1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-6QjrHDLgMKKqhF82mzgk7g-1; Mon, 23 Feb 2026 13:27:25 -0500
X-MC-Unique: 6QjrHDLgMKKqhF82mzgk7g-1
X-Mimecast-MFC-AGG-ID: 6QjrHDLgMKKqhF82mzgk7g_1771871244
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so31418005e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871243; x=1772476043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUsyb6XUynVbSnvGrmF4BaKu58Lr18hmIlwA9Ild52E=;
        b=fks6arvDm7oPm4oX4iZLj38b1+U1jAg4oHjVz9IjkBFOv5wXNQ/IkdgFYXOPsIl/vt
         uygsH/9Y2k+HlKFAe7pHiRt7G27NQ+rZ86SYqZru1eSJlfBurJNRVE1k4reCZZMWWYNm
         11ZeRPrOwYz4PSlQ9IzTk6UzA40muZUcyYVF4GiOrerquIXBRpZDw2tVswz/2itHqJIj
         ML1p2HD3UF9EZjwR5RrFV//sxxf0ltF+gLAXoY6c97BeZp185mnNORES/imr7YrFoYuO
         x6zQG5vAsVEA2bqotBSr8caOZSyikw6LlvuDf0DbngAV5DAjG31+Pwhy95W93n1QaHWr
         gpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871243; x=1772476043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUsyb6XUynVbSnvGrmF4BaKu58Lr18hmIlwA9Ild52E=;
        b=DCSj48hEsTX8Wn56APvD7c1SvDBllVUsOizofA0unarUm9+mXpsq/BGN6piySTE5Mg
         B4BMYyIxW+w3caRu4IULuPQZ1hFKx1RZu8Mew4PIbnOWu1MZ+lh3O4NHv/RS2LwPPGid
         L/VjaxnF7/NvlQvoMv6pnMkpoptDSe3bRv13KOSXfbvB0PG8FErPdnax4eccJuLpUxj/
         2rCp9sbTSl4ieUIhLWrk8gVzZAiEt4s3g4HT53Lg3vxPJtYRuoJIl8UlF62TRFsqPpTZ
         1mFjPfKtIK7j9B0uFZXv3Eb5gtoINIBSIEB4eCozHpcW4kgahCnn9MEAFRnEN67hSzvJ
         +k5A==
X-Gm-Message-State: AOJu0YxQiEdS36T2ehbf8224VQCXeluguMaBn4IAn5/gU6F0wQ94uJN/
	n5e1RkbPKAO1nj8URURvTEZ9nyOqp94AAtUE/JRRhXLJUOESXR9nXtYWko0qxs0EyWOf5rPkUv5
	uiWATkmg6/EN/ApqagYogTIxDT5auBdWSFWa8RC3j0FBDyzgdR4OVYPLW7cDCu6509FpVBmL0B9
	mbdBw0Kb9zO3myulsCKaigP8XSeF642ZrSR6UbjDmvOw==
X-Gm-Gg: AZuq6aJltnuFfLv3AAE00uSMT7Ft/rbcVf7y8sA1xLkRUExrBLcZ9h3Fpj+8riilxMm
	gzfseEBvzYobIQBfsIdn25W5rCW1f61sciAfT1bRvRAk4uOk8pnUBzQYv5WEJwKy3oMliQBIXtq
	pjB0BejQnAx4keZpvO7H600difc+CepNvoykSlR/vSTo7Lp76IdVftAhMqESaUdyzNHDIPrKmWl
	+Cyd91EPCO5bLw1xjt1Xltyj5WYylNbMWC06doTvKGzpjNKDMVyjXQVSUrMD5vFdhUtjOqGzzVD
	BPTRjrRxWYV3NJkelyVXERuV+9+PNrMdTDa/TyOFG19T7vSawiNw2X+8ulsgnL1iUDk+2gYvQe+
	sU0D7bo1AmEJwiXp5VBAR7pdFfG9TrZUTIHhKxwx+xI1Sdbg+JaQFEa3b5dU=
X-Received: by 2002:a05:600c:608f:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-483a95bd7e8mr153653505e9.5.1771871242806;
        Mon, 23 Feb 2026 10:27:22 -0800 (PST)
X-Received: by 2002:a05:600c:608f:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-483a95bd7e8mr153652965e9.5.1771871242299;
        Mon, 23 Feb 2026 10:27:22 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3de5sm226941685e9.12.2026.02.23.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:21 -0800 (PST)
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
Subject: [PATCH net-next v2 6/8] net: macb: make macb_tx_skb generic
Date: Mon, 23 Feb 2026 19:26:30 +0100
Message-ID: <20260223182632.1681809-7-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-260151-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F71717B7BD
X-Rspamd-Action: no action

The macb_tx_skb structure is renamed to macb_tx_buff with
no functional changes.

This is a preparatory step for adding xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 10 +--
 drivers/net/ethernet/cadence/macb_main.c | 96 ++++++++++++------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 33a963b6dd4d..4e3cc0e9ea87 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -959,7 +959,7 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_skb - data about an skb which is being transmitted
+/* struct macb_tx_buff - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
  *       of the frame
  * @mapping: DMA address of the skb's fragment buffer
@@ -967,8 +967,8 @@ struct macb_dma_desc_ptp {
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
  */
-struct macb_tx_skb {
-	struct sk_buff		*skb;
+struct macb_tx_buff {
+	void			*skb;
 	dma_addr_t		mapping;
 	size_t			size;
 	bool			mapped_as_page;
@@ -1253,7 +1253,7 @@ struct macb_queue {
 	spinlock_t		tx_ptr_lock;
 	unsigned int		tx_head, tx_tail;
 	struct macb_dma_desc	*tx_ring;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
@@ -1332,7 +1332,7 @@ struct macb {
 	phy_interface_t		phy_interface;
 
 	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
-	struct macb_tx_skb	rm9200_txq[2];
+	struct macb_tx_buff	rm9200_txq[2];
 	unsigned int		max_tx_length;
 
 	u64			ethtool_stats[GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 26b517ed251c..f65f976123fd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -157,10 +157,10 @@ static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
 	return &queue->tx_ring[index];
 }
 
-static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
-				       unsigned int index)
+static struct macb_tx_buff *macb_tx_buff(struct macb_queue *queue,
+					 unsigned int index)
 {
-	return &queue->tx_skb[macb_tx_ring_wrap(queue->bp, index)];
+	return &queue->tx_buff[macb_tx_ring_wrap(queue->bp, index)];
 }
 
 static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
@@ -967,21 +967,21 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
 {
-	if (tx_skb->mapping) {
-		if (tx_skb->mapped_as_page)
-			dma_unmap_page(&bp->pdev->dev, tx_skb->mapping,
-				       tx_skb->size, DMA_TO_DEVICE);
+	if (tx_buff->mapping) {
+		if (tx_buff->mapped_as_page)
+			dma_unmap_page(&bp->pdev->dev, tx_buff->mapping,
+				       tx_buff->size, DMA_TO_DEVICE);
 		else
-			dma_unmap_single(&bp->pdev->dev, tx_skb->mapping,
-					 tx_skb->size, DMA_TO_DEVICE);
-		tx_skb->mapping = 0;
+			dma_unmap_single(&bp->pdev->dev, tx_buff->mapping,
+					 tx_buff->size, DMA_TO_DEVICE);
+		tx_buff->mapping = 0;
 	}
 
-	if (tx_skb->skb) {
-		napi_consume_skb(tx_skb->skb, budget);
-		tx_skb->skb = NULL;
+	if (tx_buff->skb) {
+		napi_consume_skb(tx_buff->skb, budget);
+		tx_buff->skb = NULL;
 	}
 }
 
@@ -1027,7 +1027,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32			queue_index;
 	u32			packets = 0;
 	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
@@ -1067,16 +1067,16 @@ static void macb_tx_error_task(struct work_struct *work)
 
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
-		tx_skb = macb_tx_skb(queue, tail);
-		skb = tx_skb->skb;
+		tx_buff = macb_tx_buff(queue, tail);
+		skb = tx_buff->skb;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb, 0);
+				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
-				tx_skb = macb_tx_skb(queue, tail);
-				skb = tx_skb->skb;
+				tx_buff = macb_tx_buff(queue, tail);
+				skb = tx_buff->skb;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1105,7 +1105,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1183,7 +1183,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_skb	*tx_skb;
+		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
@@ -1203,8 +1203,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
-			tx_skb = macb_tx_skb(queue, tail);
-			skb = tx_skb->skb;
+			tx_buff = macb_tx_buff(queue, tail);
+			skb = tx_buff->skb;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -1224,7 +1224,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_buff, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2137,8 +2137,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	struct macb_tx_buff *tx_buff = NULL;
 	unsigned int eof = 1, mss_mfs = 0;
-	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
 	dma_addr_t mapping;
@@ -2161,7 +2161,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		tx_skb = macb_tx_skb(queue, tx_head);
+		tx_buff = macb_tx_buff(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2170,10 +2170,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_skb->skb = NULL;
-		tx_skb->mapping = mapping;
-		tx_skb->size = size;
-		tx_skb->mapped_as_page = false;
+		tx_buff->skb = NULL;
+		tx_buff->mapping = mapping;
+		tx_buff->size = size;
+		tx_buff->mapped_as_page = false;
 
 		len -= size;
 		offset += size;
@@ -2190,7 +2190,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			tx_skb = macb_tx_skb(queue, tx_head);
+			tx_buff = macb_tx_buff(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2198,10 +2198,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_skb->skb = NULL;
-			tx_skb->mapping = mapping;
-			tx_skb->size = size;
-			tx_skb->mapped_as_page = true;
+			tx_buff->skb = NULL;
+			tx_buff->mapping = mapping;
+			tx_buff->size = size;
+			tx_buff->mapped_as_page = true;
 
 			len -= size;
 			offset += size;
@@ -2210,13 +2210,13 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* Should never happen */
-	if (unlikely(!tx_skb)) {
+	if (unlikely(!tx_buff)) {
 		netdev_err(bp->dev, "BUG! empty skb!\n");
 		return 0;
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_skb->skb = skb;
+	tx_buff->skb = skb;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -2247,10 +2247,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	do {
 		i--;
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 		desc = macb_tx_desc(queue, i);
 
-		ctrl = (u32)tx_skb->size;
+		ctrl = (u32)tx_buff->size;
 		if (eof) {
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
@@ -2273,7 +2273,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp, desc, tx_buff->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2289,9 +2289,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 	netdev_err(bp->dev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	return -ENOMEM;
@@ -2617,8 +2617,8 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		kfree(queue->tx_buff);
+		queue->tx_buff = NULL;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
@@ -2696,9 +2696,9 @@ static int macb_alloc_consistent(struct macb *bp)
 		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
 		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
 
-		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
-		queue->tx_skb = kmalloc(size, GFP_KERNEL);
-		if (!queue->tx_skb)
+		size = bp->tx_ring_size * sizeof(struct macb_tx_buff);
+		queue->tx_buff = kmalloc(size, GFP_KERNEL);
+		if (!queue->tx_buff)
 			goto out_err;
 	}
 
-- 
2.52.0


