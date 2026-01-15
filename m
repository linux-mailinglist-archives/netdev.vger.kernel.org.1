Return-Path: <netdev+bounces-250336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF321D29043
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A1830A5EA0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36432D0DE;
	Thu, 15 Jan 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpYB9SaR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdaaoAEb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE63242AD
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515982; cv=none; b=Pmd2djvD+RM6qO3L7oY/I3qePMvgX009wyYXdDQRUkW4QAD+5XJTWXhOlVKki/pZ9Zdyi69eFWfa6CH8eg7ADqIBY0LWpYPuq9MgcV3YboSLw26uAJlCYcEjWbC2Oar1jo9bfX22Wa2WEEcOI0TlFWN3P+Yc6Svh0XeDFhMQU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515982; c=relaxed/simple;
	bh=+V+Vj8h6jXw/ooi6azRjyN9cfz1MsAK/FthfsmGrTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC3AaaTqiaS/aKPe7DrBlo7sL90+be/WuH881bjjg3PtLvMxs2HnXbG9Xcpl+M4s3y7XUjoMTtrgcyil/4Jgd/inq1ZmMBobVqsQ+Q8e2GwHlg1oEttylBJH/VVbNA1pUDJOd9dw0XbVkL5wyGOPYiLBprPjqnECce8uCu7Vo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpYB9SaR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdaaoAEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jqjnu/tdB5EW0P34Mt42Y4IXvYBWKEvjHjgwpADNkqo=;
	b=FpYB9SaRrEP2Ya+VuSkmmBJH6kTSwInItlDnWyR8ChM3CWUsf7BdUgT1Sqg3wWagoCVCpb
	BenSErBE2ynU6LiaWIP4/NsBgCEYiOsjsBI253RaNEY6bnSDDZSo8BehOxTrfAiVMkI5pP
	djI4Aq6nu/EiNG3utOYhaAz+Jeuj5UA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-2BW2xEMcMUOp3ISA80rcEg-1; Thu, 15 Jan 2026 17:26:18 -0500
X-MC-Unique: 2BW2xEMcMUOp3ISA80rcEg-1
X-Mimecast-MFC-AGG-ID: 2BW2xEMcMUOp3ISA80rcEg_1768515977
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso6944745e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515976; x=1769120776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqjnu/tdB5EW0P34Mt42Y4IXvYBWKEvjHjgwpADNkqo=;
        b=YdaaoAEbjHWwhlivmZaEGYf49gD0UGdUwww4/VNPz6Dgjnjyj2EAQgxwKWYS5eRJ8d
         k+PHI7eb2dkwwKcukDqpAOm4K2gpwkJtPULKOo+GpyqZBeZ0zA+niwhSbuNY2ufgLXgK
         Qs9VL5KTwiCB16HMO9H/wEoebGkQTk61yuk3sOlyHt+3KEqqfa3QOGDqqLaCO91taEqC
         LW0lF6undoGgZka7OmXQVPVpS6/LizuX7v0j35EMRPGlymbjkFs2rYj9ubHZFwdmXwdO
         YQkf0bxARQOX1R92HpI+YA/YQGo8fnprJhrsV4QqChEIs3qyu+aBE4NSEeHOt139Kthl
         mW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515976; x=1769120776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jqjnu/tdB5EW0P34Mt42Y4IXvYBWKEvjHjgwpADNkqo=;
        b=RyutaucHxCNl0q8tvGFHMpcuIX+5C7CqQ2TwWvULYpSC1lOziDFNSkrp70d5PEzPQM
         YQv/fCcQvH5nx2BeG2bbwRdUcQh63URbXdALE+RojFBNI56lK2uOGYrlMkee9NgFo6c4
         sUmJdrr4A5/jqxclhv0CQSYA6eH0Z+mQAqHGJVsRmnq/KAwhcHlLdEMbyQF9CWrHxI+O
         x1QXSp9lAa7r729XcCZdf80k/OtY0VSPB5GtSHfipEIGVjzUL1ubzTbok8JU5yfBEYGw
         mhe136Sx3TqZYXOmgdehk/4JqsK1GUci6MbMyNEtkvVLTuJf3BYDTNIOm0xcooVJmv8Y
         byRg==
X-Gm-Message-State: AOJu0YygrTG9/Bm2R2ojzn8OtQEg0u5LwJlUgMjXNtxU9BoBgDgOJjE0
	b13xrsrti+nuJqc5ZmH6FjbMrbzlcmMgZcQzCq8VNFnDBYLFR7x+JLQRl0DciTCFkgf78gE4KmS
	5hRJidGS3wx0/RYb5xB+fvY+H5P5Y+yGJBVeyXAyvUQVGNdeM5whdVC34xJ7eG6nIuwlaRJerhR
	2IHKcA749p5QyqpizrO2IiW7oqywmt3Qw5HYX6lwOXcQ==
X-Gm-Gg: AY/fxX5/VgNU6108uTJvIudmCMMApE7ePguBIf6mZQl760NfVCp//+cppnywrEka4GE
	JtkA8rHB+gXFVBvoJ93s7X9O1y+FDgvhNY+FB8N8GpcBXHvkf3J6Hx8raYA/tQIXTXiNgnENJA7
	5q14TR3OFhk6EWOzqiC0DTmOTlQuDGOzKUad5EQDhWfMLBkAmnNzDEcT34qV8MB/31CEiJcDUNV
	ZCjGRacTqUULiRRTsy6GwzXO2qqh4Hx2BXeukRchQuGLJTjCdEn3y9ZxAgSDXuR6bb1r+SbvNIv
	s2C9jehZ1Bp4/4m6fY8Bz4X47/VRSdcWPCiCZQWSRayV/QEgUny/IyN8lSDw+Uj17xb479lz1Ej
	WkD9rKDbuL+gKv3qObyln/OHur6Zpse8+0+lIbKcVOxhIsg==
X-Received: by 2002:a05:600c:4e92:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4801eb0426fmr7683425e9.24.1768515975942;
        Thu, 15 Jan 2026 14:26:15 -0800 (PST)
X-Received: by 2002:a05:600c:4e92:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4801eb0426fmr7683065e9.24.1768515975461;
        Thu, 15 Jan 2026 14:26:15 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ce5aasm4596525e9.2.2026.01.15.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:12 -0800 (PST)
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
Subject: [PATCH net-next 6/8] cadence: macb: make macb_tx_skb generic
Date: Thu, 15 Jan 2026 23:25:29 +0100
Message-ID: <20260115222531.313002-7-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macb_tx_skb structure is renamed to macb_tx_buff with
no functional changes.

This is a preparatory step for adding xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 10 +--
 drivers/net/ethernet/cadence/macb_main.c | 96 ++++++++++++------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d46d8523198d..970ad3f945fb 100644
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
@@ -1331,7 +1331,7 @@ struct macb {
 	phy_interface_t		phy_interface;
 
 	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
-	struct macb_tx_skb	rm9200_txq[2];
+	struct macb_tx_buff	rm9200_txq[2];
 	unsigned int		max_tx_length;
 
 	u64			ethtool_stats[GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1f62100a4c4d..26af371b3b1e 100644
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
@@ -969,21 +969,21 @@ static int macb_halt_tx(struct macb *bp)
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
 
@@ -1029,7 +1029,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32			queue_index;
 	u32			packets = 0;
 	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
@@ -1069,16 +1069,16 @@ static void macb_tx_error_task(struct work_struct *work)
 
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
@@ -1107,7 +1107,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1185,7 +1185,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_skb	*tx_skb;
+		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
@@ -1205,8 +1205,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
-			tx_skb = macb_tx_skb(queue, tail);
-			skb = tx_skb->skb;
+			tx_buff = macb_tx_buff(queue, tail);
+			skb = tx_buff->skb;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -1226,7 +1226,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_buff, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2130,8 +2130,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	struct macb_tx_buff *tx_buff = NULL;
 	unsigned int eof = 1, mss_mfs = 0;
-	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
 	dma_addr_t mapping;
@@ -2154,7 +2154,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		tx_skb = macb_tx_skb(queue, tx_head);
+		tx_buff = macb_tx_buff(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2163,10 +2163,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2183,7 +2183,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			tx_skb = macb_tx_skb(queue, tx_head);
+			tx_buff = macb_tx_buff(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2191,10 +2191,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2203,13 +2203,13 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2240,10 +2240,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 
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
@@ -2266,7 +2266,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp, desc, tx_buff->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2282,9 +2282,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 	netdev_err(bp->dev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	return -ENOMEM;
@@ -2601,8 +2601,8 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		kfree(queue->tx_buff);
+		queue->tx_buff = NULL;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
@@ -2680,9 +2680,9 @@ static int macb_alloc_consistent(struct macb *bp)
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


