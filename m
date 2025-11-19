Return-Path: <netdev+bounces-240005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC8C6F269
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F392D504A54
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644483612E8;
	Wed, 19 Nov 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHK6u1ld";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaWkTGSN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069223659E0
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560464; cv=none; b=qb73sFXkidlUqIQ8W4PyQdRooF2VOYmmZ8xSrLEDY60nDmzRajWgJOV+g/ycGbN/RAjGJtxct6Ht5NsyDfP/vxQi7sb8UzpyQJIMvQf3hX051NKN4sZdGFceKT2svmBaze/q+CAF27bYxZ2vsrVM0AA9VE1hDghkbSRwKI7vCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560464; c=relaxed/simple;
	bh=LB6lJ6E/fJTP4V2b81T832Uj7zMHEJYK9AhAkV1nJZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ictrm1wSFcOlhm9FYnrsJoRY4o3mGm7yEGb0ib581AlYocI89yRvpAluDusC1/Gu29rsRbNc5F+pN4lAZ/t2GJVhutKlcb4CcY1mK4jkZQSc97a6+Fslu+QGvD37s4XMsPaILZ8V5/n4DBQUNBp+yKNxAPF/Qxinoy7suZ2fgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHK6u1ld; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaWkTGSN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/HEFT4kF4dFMCtSGHHCe/D2ptaImkWoadV/MKjrrmw=;
	b=fHK6u1ld/ADclsi261+WmBpGOg7UlIF5tZJsaJmuXmSnTCTvL23rGUhyCMRVpeqr3wn9Of
	sO3s9PnwCmzR63G8YswEilnHkFsAYcrklcZX8vk1h0IUtrQqG+hz88Dn00c++5vhXUdxNs
	sbNzOe5GTV/ZhX+iqAChHkosLFHJb18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-aeSM2El-NTGOIoUo1NPy5Q-1; Wed, 19 Nov 2025 08:54:19 -0500
X-MC-Unique: aeSM2El-NTGOIoUo1NPy5Q-1
X-Mimecast-MFC-AGG-ID: aeSM2El-NTGOIoUo1NPy5Q_1763560459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso78984545e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560457; x=1764165257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/HEFT4kF4dFMCtSGHHCe/D2ptaImkWoadV/MKjrrmw=;
        b=SaWkTGSNu/byd3YFUnlNXUKJ3+3UanVtYkZIDFqy/E5a8hjoVly7pbwKgos7BMl7AM
         Z+PLSUzrZ96Ty6R+JmqfdzxKYqx8qY4DqQ0DEkewDf3STtimzwScvyu4zW40nRF16lBN
         DmOC0QCiG/V7PW5TpN/MPVdhwaEtFxiqkTd8KFB4O17xlv3Dg7gUUOKYBi8E4eWHMu8L
         lGIkmd6keRr5a5afMdYX9ot0uLbPaDZZ1EEdzgGacby6W5Toa+60URMgEY92c4+cki/V
         pdvzukETO/o1TibjD3CTsmioJbGtRhmVgcpI3B5mN/KjW3LGTlH6R8kUfxN50bT2uTVi
         4xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560457; x=1764165257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/HEFT4kF4dFMCtSGHHCe/D2ptaImkWoadV/MKjrrmw=;
        b=iGEF2yb5/q86OkAZsuJidrtB/HUk9Dj+Umgh3jQKMisg8TCXgxSr1jC6R9PT2GSTTw
         RQXmIBCgguylO+3a6+mU4YWppS9zrvf0J25KGwY6pwSh/UfNv7YwWdXVygqLPCnncLUT
         Og4kj7bEh9mQbCNBxUKNw8OqFi94QNKavvwl0FMMOb2zBf7VwMWLjD7cF1qdw4s2sPDl
         LBYNCfMNBkECvH1PrOubIrIV/Sm27QXgiQovmQyXYuileSM0mjic28HEZjQ+FbN0YeOe
         zhcPmuqqs7YIPMA3qllrdDclxnrZqehX8yVN2m6kCXnmY2zEiUCDoohr5en3eOiTbU5N
         Hgbw==
X-Gm-Message-State: AOJu0YxR1bhRJ+2IsIoL8kq3qPygxGSF3sLUPK330y4YtaqNDp31WATl
	dMMcW/WeCdABKdTMT5zZeOvHuHHoYdHbpfd+CxZtdqk/tUVmHTyEaGRX0lwgxA/LMYgil93IVzi
	CRaWr89lbIbmVh+diadwsutmoe7fRhUU/cWZFAyszqtc6Jqivq/QghRdBDMdY+eiYjJ+v8MDJ4W
	BvVzAjkt2aQXzK16mLGw8rmUb6RYnwlRpTBLSVKINZ+Czk
X-Gm-Gg: ASbGncvB4tQRQNePaFYbI8cI9FrK5dcbSv5j3U6xOKH3rIklbc2vLagKmYlPOvzVfN3
	KkqWWCWGSfTbMLWeGwQDgM5wsnPR5G/A6aOLQSayeKjgjlMu2gcz/n/IACRyiTPKKa2kKS6g3vR
	JSct0rXJpgxnIXC/p+ADQiyUnJhL704LAGTmt4JgP2q37Oz1x/B3TUlcAWeiAjxB4xsMg05HlJp
	byWefWgrfoDqRG2LibBEatF5xbvHILsj7NVUiaHR59G+pxLQVz47cuYUq3q51tCWPc4EOr6c/Ai
	keeDEh7ozhifHdsWceZIMlIu8sGgrW4MVy/dIk9sWvejPIpnJaabwOGMK53nZAl7eLXmVaJ4pIK
	r0lwfZzKW8VbE9Ye2/g+09hpo2Vs2NJYLpRPi7MYpAmysOGtI7g==
X-Received: by 2002:a05:600c:1986:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-4778fea7037mr182941145e9.27.1763560457294;
        Wed, 19 Nov 2025 05:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFcVaWdthOTQ4rgsqodkc287ljZLvRZRp6Nvf9BQUXXAZljOGJ6xhfJ1r7nkVBbjRtwb5xeQ==
X-Received: by 2002:a05:600c:1986:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-4778fea7037mr182940695e9.27.1763560456713;
        Wed, 19 Nov 2025 05:54:16 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1037d32sm47192415e9.12.2025.11.19.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:16 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC net-next 5/6] cadence: macb/gem: make tx path skb agnostic
Date: Wed, 19 Nov 2025 14:53:29 +0100
Message-ID: <20251119135330.551835-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119135330.551835-1-pvalerio@redhat.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macb_tx_skb structure is renamed to macb_tx_buff. Also, the skb
member is now called data as it can be an sk_buff or an xdp_frame
depending on the tx path, along with an enum to identify the buffer
type.

This is a preparatory step for adding xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  28 ++++--
 drivers/net/ethernet/cadence/macb_main.c | 120 +++++++++++++----------
 2 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2f665260a84d..67bb98d3cb00 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -964,19 +964,27 @@ struct macb_dma_desc_ptp {
 #define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
 #define MACB_MAX_PAD		(MACB_PP_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
-/* struct macb_tx_skb - data about an skb which is being transmitted
- * @skb: skb currently being transmitted, only set for the last buffer
- *       of the frame
+enum macb_tx_buff_type {
+	MACB_TYPE_SKB,
+	MACB_TYPE_XDP_TX,
+	MACB_TYPE_XDP_NDO,
+};
+
+/* struct macb_tx_buff - data about an skb or xdp frame which is being transmitted
+ * @data: pointer to skb or xdp frame being transmitted, only set
+ *        for the last buffer for sk_buff
  * @mapping: DMA address of the skb's fragment buffer
  * @size: size of the DMA mapped buffer
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
+ * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP_NDO)
  */
-struct macb_tx_skb {
-	struct sk_buff		*skb;
-	dma_addr_t		mapping;
-	size_t			size;
-	bool			mapped_as_page;
+struct macb_tx_buff {
+	void				*data;
+	dma_addr_t			mapping;
+	size_t				size;
+	bool				mapped_as_page;
+	enum macb_tx_buff_type		type;
 };
 
 /* Hardware-collected statistics. Used when updating the network
@@ -1258,7 +1266,7 @@ struct macb_queue {
 	spinlock_t		tx_ptr_lock;
 	unsigned int		tx_head, tx_tail;
 	struct macb_dma_desc	*tx_ring;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
@@ -1336,7 +1344,7 @@ struct macb {
 	phy_interface_t		phy_interface;
 
 	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
-	struct macb_tx_skb	rm9200_txq[2];
+	struct macb_tx_buff	rm9200_txq[2];
 	unsigned int		max_tx_length;
 
 	u64			ethtool_stats[GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 53ea1958b8e4..eeda1a3871a6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -156,10 +156,10 @@ static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
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
@@ -969,21 +969,25 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
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
+	if (tx_buff->data) {
+		if (tx_buff->type != MACB_TYPE_SKB)
+			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping (%d)",
+				   tx_buff->type);
+		napi_consume_skb(tx_buff->data, budget);
+		tx_buff->data = NULL;
 	}
 }
 
@@ -1029,7 +1033,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32			queue_index;
 	u32			packets = 0;
 	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
@@ -1069,16 +1073,23 @@ static void macb_tx_error_task(struct work_struct *work)
 
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
-		tx_skb = macb_tx_skb(queue, tail);
-		skb = tx_skb->skb;
+		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
+				   tx_buff->type);
+		skb = tx_buff->data;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb, 0);
+				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
-				tx_skb = macb_tx_skb(queue, tail);
-				skb = tx_skb->skb;
+				tx_buff = macb_tx_buff(queue, tail);
+				if (tx_buff->type != MACB_TYPE_SKB)
+					netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
+						   tx_buff->type);
+				skb = tx_buff->data;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1107,7 +1118,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1185,7 +1196,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_skb	*tx_skb;
+		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
@@ -1205,8 +1216,10 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
-			tx_skb = macb_tx_skb(queue, tail);
-			skb = tx_skb->skb;
+			tx_buff = macb_tx_buff(queue, tail);
+
+			if (tx_buff->type == MACB_TYPE_SKB)
+				skb = tx_buff->data;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -1226,7 +1239,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_buff, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2117,8 +2130,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	struct macb_tx_buff *tx_buff = NULL;
 	unsigned int eof = 1, mss_mfs = 0;
-	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
 	dma_addr_t mapping;
@@ -2141,7 +2154,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		tx_skb = macb_tx_skb(queue, tx_head);
+		tx_buff = macb_tx_buff(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2150,10 +2163,11 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_skb->skb = NULL;
-		tx_skb->mapping = mapping;
-		tx_skb->size = size;
-		tx_skb->mapped_as_page = false;
+		tx_buff->data = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
+		tx_buff->mapping = mapping;
+		tx_buff->size = size;
+		tx_buff->mapped_as_page = false;
 
 		len -= size;
 		offset += size;
@@ -2170,7 +2184,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			tx_skb = macb_tx_skb(queue, tx_head);
+			tx_buff = macb_tx_buff(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2178,10 +2192,11 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_skb->skb = NULL;
-			tx_skb->mapping = mapping;
-			tx_skb->size = size;
-			tx_skb->mapped_as_page = true;
+			tx_buff->data = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
+			tx_buff->mapping = mapping;
+			tx_buff->size = size;
+			tx_buff->mapped_as_page = true;
 
 			len -= size;
 			offset += size;
@@ -2190,13 +2205,14 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* Should never happen */
-	if (unlikely(!tx_skb)) {
+	if (unlikely(!tx_buff)) {
 		netdev_err(bp->dev, "BUG! empty skb!\n");
 		return 0;
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_skb->skb = skb;
+	tx_buff->data = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -2227,10 +2243,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 
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
@@ -2253,7 +2269,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp, desc, tx_buff->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2269,9 +2285,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 	netdev_err(bp->dev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	return -ENOMEM;
@@ -2582,8 +2598,8 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		kfree(queue->tx_buff);
+		queue->tx_buff = NULL;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
@@ -2662,9 +2678,9 @@ static int macb_alloc_consistent(struct macb *bp)
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
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
@@ -5050,7 +5066,7 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].data = skb;
 		lp->rm9200_txq[desc].size = skb->len;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
@@ -5143,9 +5159,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			dev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
+		if (lp->rm9200_txq[desc].data) {
+			dev_consume_skb_irq(lp->rm9200_txq[desc].data);
+			lp->rm9200_txq[desc].data = NULL;
 			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
 					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
-- 
2.51.1


