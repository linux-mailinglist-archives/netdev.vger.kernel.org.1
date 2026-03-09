Return-Path: <netdev+bounces-265575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMKLHwzermm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869523AE0E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71D8C3027C95
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FC3D5220;
	Mon,  9 Mar 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ez18DU5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKYLLHyX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383F3D34BA
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067464; cv=none; b=I1M3xsucZ0tM6VvZN4URd3RI+4uEWRF8JqZNQeSGLirhHOrYrRooZw72wlst/QBVh8YxEbjIT9vVrzPuWKu9FcUVAD+Og6ToQzFPQlDzTj1yTKqBQcXJF56I2XtjVEzBLfbYNGbUivHWp+F8wRBLQOdlqW6YKgMdS/3wSeDoYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067464; c=relaxed/simple;
	bh=jd6rVW63OQ8pSJgiCEr0oMytj4vQU6CpsRMW6qF2aOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lldr209wohLLuIPglaUEULuWt0e9X00S1gPElUxUwyp+HEGjsyN1jKVoEFJiXOzNRNk6Y9z+BwHkJGnHS+TbWvKpYmn3/VMEpsp8eCQFxhzjOi80JPUr+56xW/sDhZkaTwp0cfdx4ZUDR0+2AhbFjIJ9YQwSatpoQ7Jeb+ZknLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ez18DU5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKYLLHyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysZRQTRetlej5oepRv1ihh288NWXlq1+vjLjWCgbREs=;
	b=Ez18DU5XqUQ6tyv+2B2sFx1kb4ppf5LpgT9zZm9slFVADqHt4LjDh192ki52arBa4bA9wF
	rMMbvgqaeWL+Z6RiJrCmQ7k6G3JN2HHAXVKVuQ0Mr5pDcPLjyPZB1BHebira0Fk3e5D9Bi
	yOplobCBVYLpyOFImhUyZ0VljZI83Vg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-3yop7etyN8iJJFymeyr8qg-1; Mon, 09 Mar 2026 10:44:17 -0400
X-MC-Unique: 3yop7etyN8iJJFymeyr8qg-1
X-Mimecast-MFC-AGG-ID: 3yop7etyN8iJJFymeyr8qg_1773067456
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483786a09b1so4460945e9.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067455; x=1773672255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysZRQTRetlej5oepRv1ihh288NWXlq1+vjLjWCgbREs=;
        b=VKYLLHyXmVZoXBVXSf06tfb2A9YiFwpSOUiorjVXHnQVZG85JEnoJBh0HIqhjj9Gs5
         v5BRZZ6XdpCVotxhNzUrpAfYT6Q5XhmkCjXLqF0WT93n8xx42g2sZjA3ZJMFt4eMhRmk
         3f09bVVnfU+WFovAw08UG2OUiaC2cBwJSYYZH770yiCpYFKYMYXoq+FEEjyQWvLmtczi
         pM9BL74RRaHxe3yaOrj23Aanpf3doURszmbTivVoji2+wpISbcTHsrjVfIgBWH+UWp4X
         N8SNswvQB7GBqsR9BOAasOuO9+8RcwizM4ZZrK9ZAJgFjv0qjVi459Y4bVb6GM2QhW3R
         SMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067455; x=1773672255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ysZRQTRetlej5oepRv1ihh288NWXlq1+vjLjWCgbREs=;
        b=UprU/qRoqjg92efsFsLdbrpRIrncR8VL2tPkyJvns40nM8pE3QDT8b2WhfMZaP5sgZ
         6flv8Fq9w0NHAq/BwQECsV9ROdCJZFt4VWFrW7KNCatKt0r47BIHNiWjav9vFQZlMc4X
         24EgjV7kfrj24/2ztv3+hGEmBXDPGswdoVUIJXJlBjWijMWsXkpOtJQnTGsJ3Nw5Y5wv
         ZQ1FEKZRaDpo3JfU6Kp+EeXykYnC1mhAvNxIdTWzZmZCC+o5AhMkaVTRhPs5Vm8xDzbg
         uJXYfzs6cCVPhq/qXkY442Zz1HKIZZAVKhcclZo51ci0Hku2bTpYee69/v8QJEAOmMQe
         LZMw==
X-Gm-Message-State: AOJu0YyG0hIjxHogm12fUgtEbl0GyGgvvpW+51p6duT7ndT0A6NQOeey
	gQhtrxXWoNDM+YB+f1i6TYzI2YCaPfY6pcN4sFUuHeeUejqNh517feJsYf3bXVgJePuj43JUpcD
	+jsZ158yynhDZWBN9fYeJuqKOD5j85P7UO3HTI/CSVUPliJF6X0ia/PLxTA4RTFdwcH9tQ509FU
	Q4OVc8hUnoLKmYxaSXcYj6RLtty3zfYNeE5/sOhqBzBg==
X-Gm-Gg: ATEYQzxVldGgrXf9kgmt68reGbrcBm9AdSLJkloXXV4f/lmQsdFXPy7rToUi4U1ZNjn
	ZF5nOlX/ITD9CzXfGMYz0qMokZDaC0DWaMj0AvgODg8zc5Lx6It2EyBQcTlTxnK4JSvNJ+zFLI5
	AXcBim2EyJOLbBVuchz/0fcJJ7OaQasnC0WQQo6BPBh6y/yZ2oglqBDPDNpAF+geMDoW6aLGXDR
	Xz5QCr2sKiYlQ4VFEiPBpHbaA/T+G3xwywFe9OrdLG3XDdQ//9WmUMAXYCNxjX2BuFQwMk7JCUP
	PrO5goA8KkPUWzj8cupSFoGZG6eENftrXk9Nqp8E1YF5HuyrafGr6zZmP13IkNt/N7oirRt9FNP
	JYF+W9VghJeWsCtDIV/KG0E6yiEVgAVluZLOlu1vx0zu748sgz4L/kfVfRvk=
X-Received: by 2002:a05:600c:64c7:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-48526923bbcmr176595345e9.11.1773067454754;
        Mon, 09 Mar 2026 07:44:14 -0700 (PDT)
X-Received: by 2002:a05:600c:64c7:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-48526923bbcmr176594765e9.11.1773067454179;
        Mon, 09 Mar 2026 07:44:14 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853833094dsm130604975e9.13.2026.03.09.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/8] net: macb: make macb_tx_skb generic
Date: Mon,  9 Mar 2026 15:43:50 +0100
Message-ID: <20260309144353.1213770-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144353.1213770-1-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7869523AE0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The macb_tx_skb structure is renamed to macb_tx_buff with
no functional changes.

This is a preparatory step for adding xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  8 +-
 drivers/net/ethernet/cadence/macb_main.c | 96 ++++++++++++------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2c6ba1b63aab..1cc626088174 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -965,7 +965,7 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_skb - data about an skb which is being transmitted
+/* struct macb_tx_buff - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
  *       of the frame
  * @mapping: DMA address of the skb's fragment buffer
@@ -973,7 +973,7 @@ struct macb_dma_desc_ptp {
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
  */
-struct macb_tx_skb {
+struct macb_tx_buff {
 	struct sk_buff		*skb;
 	dma_addr_t		mapping;
 	size_t			size;
@@ -1267,7 +1267,7 @@ struct macb_queue {
 	spinlock_t		tx_ptr_lock;
 	unsigned int		tx_head, tx_tail;
 	struct macb_dma_desc	*tx_ring;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
@@ -1345,7 +1345,7 @@ struct macb {
 	phy_interface_t		phy_interface;
 
 	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
-	struct macb_tx_skb	rm9200_txq[2];
+	struct macb_tx_buff	rm9200_txq[2];
 	unsigned int		max_tx_length;
 
 	u64			ethtool_stats[GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bf653e5879e..b0f2ba338b22 100644
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
@@ -1098,21 +1098,21 @@ static int macb_halt_tx(struct macb *bp)
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
 
@@ -1158,7 +1158,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32			queue_index;
 	u32			packets = 0;
 	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
@@ -1198,16 +1198,16 @@ static void macb_tx_error_task(struct work_struct *work)
 
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
@@ -1236,7 +1236,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1314,7 +1314,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_skb	*tx_skb;
+		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
@@ -1334,8 +1334,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
-			tx_skb = macb_tx_skb(queue, tail);
-			skb = tx_skb->skb;
+			tx_buff = macb_tx_buff(queue, tail);
+			skb = tx_buff->skb;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -1355,7 +1355,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_buff, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2233,8 +2233,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	struct macb_tx_buff *tx_buff = NULL;
 	unsigned int eof = 1, mss_mfs = 0;
-	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
 	dma_addr_t mapping;
@@ -2257,7 +2257,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		tx_skb = macb_tx_skb(queue, tx_head);
+		tx_buff = macb_tx_buff(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2266,10 +2266,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2286,7 +2286,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			tx_skb = macb_tx_skb(queue, tx_head);
+			tx_buff = macb_tx_buff(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2294,10 +2294,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2306,13 +2306,13 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2343,10 +2343,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 
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
@@ -2369,7 +2369,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp, desc, tx_buff->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2385,9 +2385,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 	netdev_err(bp->dev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	return -ENOMEM;
@@ -2710,8 +2710,8 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		kfree(queue->tx_buff);
+		queue->tx_buff = NULL;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
@@ -2789,9 +2789,9 @@ static int macb_alloc_consistent(struct macb *bp)
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
2.53.0


