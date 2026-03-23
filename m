Return-Path: <netdev+bounces-270766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDY2BRu7wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2C2FE212
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5AE03080C3C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC14381AE9;
	Mon, 23 Mar 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVPgPHmX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCLN5s2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2B3803F8
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303873; cv=none; b=XI4F5Pk91Q6mZJIuyG+ar8QilF33upe44hK+Q3rWtUdSbL00H+5KWlyWK3YeCkx/BDb9R7secZrw+xEd6YzV0lUUexGLxgCt8O6ZuERk4krFaWCtKf0pqrXx6P1VPqPBISzu05oGtqT6gID+UyU4J/Z2HW9Q9PZ80aD8d3E5sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303873; c=relaxed/simple;
	bh=r575h5vMufitgbbpjCWoAI7vvWi/s0rOsTtZQFO6id0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzV97LaCH3PLvkMAKZlyUj1pk2dprqhSgPBvqyR32IhjWDO+jmnmvtYwfLUymBMRCuiSLpWZ0f2JGlqtdQHyVHk4euk4t6vcIyCAD3zPGgyOb3ZBnkYdf7+zp4osXJYNdjR2xLu78vXq/Gb+qE2+bETDMprW36qnxRvSR4I1/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVPgPHmX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCLN5s2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYYzb+C+GVD//g1CL4FpzxkmwW37DUcS3N+4vrdOsmM=;
	b=UVPgPHmX5jh31p6BsDiKEzJ5LLKVFzcz/1RH6JCtGgBAQtNKFDbEAfpA0/W3Xv3ihmGQ0k
	mduKmcm00RP5JYYJsycx3QrhvANtMSghfoVrQZmvfnPf9Hg3cCq/udj18VW5iNSFBo0chi
	E2AoD0P7c7FXFAjMOujrdfBAgd7358I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-BJIDUVFwOXGHEynfOiuORQ-1; Mon, 23 Mar 2026 18:11:10 -0400
X-MC-Unique: BJIDUVFwOXGHEynfOiuORQ-1
X-Mimecast-MFC-AGG-ID: BJIDUVFwOXGHEynfOiuORQ_1774303869
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso34989525e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303868; x=1774908668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYYzb+C+GVD//g1CL4FpzxkmwW37DUcS3N+4vrdOsmM=;
        b=YCLN5s2LdcKat7Rx9CZED/Xd0d1ckNZNBaX42ONvtrw7Vmm0olY8g7OwTO/MtZkibs
         ioD0gzkUUM4IIFIkld3gTZZ6gUiiovK1XGiy+CDSvv4Jgse1Qy4uNl9AM6cjZs50KvJk
         Bw3RTj5O8ta55rV1TSpDaz+X6ybN3DMIHytlgSec2I7u+ThBbxKfGuEAvv4WDp22F1fi
         dm648AcAuFvEnbLo89S30ypovoO7hD0nGP9Eg24y1/c/sXp7WETukitjGEX79AOnWOer
         BLtsrVLHjP5Urk+onbfxm3sRovgFCn62JOzYeHD05U+4l8CenSAvDePbz4PVtqJh5h+u
         Ggsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303868; x=1774908668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYYzb+C+GVD//g1CL4FpzxkmwW37DUcS3N+4vrdOsmM=;
        b=TSsQo+g+OCiOaRKBOe8WukIN8hRQgnh1saPahQN2Wu4kwCFFo0agpuyN2HybBs4Lnk
         pU9DoCXP+0nXxsb4ig0wfMkTK1jNJs3kv+hJTz+hf6HHu1hXDOu2FGgFoFBnYw5VRkqA
         QRuax+HzJMLeLRwHNscM3FPVECvYUr0cnfwUrlm4pF3Jb6pTM514CvsPHTBbNr5KdfiE
         c122f2EePuK4vTeO94i4kxR3huRgIymfCprDxHJotwAt2/R1zSt7+IT2DR3asZ07cStv
         RUd/TJWNHOvQ0Ypp39iRhgZPoMZCcGYeJeB2nUgv3sW/AMr9dzg/1g19cDr92LXbNdJm
         bq+g==
X-Gm-Message-State: AOJu0Yx6yjXyomnbXdjiY/1Yka4pbC3pwja+8BNQXeNsds44kWX96cwg
	EaHfedMi97Uiww0+27yApQJOyg537Cyh4eJThIVE5nnuKvaQ6EvaKrv0FMUHiC86vCdm3NcmUKq
	Zmnj1rWEw7DpfQqsxusY1kReV98UAZsOyS11MDSIuKKV/FHY2OHPmkdrQboGLBUzFVbtbfyNd1+
	QG6qUQAg6YTUuJGHgAJuxCWT3kZzcPRipsfJco/c4s7Q==
X-Gm-Gg: ATEYQzyk7KGv+xEf/u7kMH59MseJX98nDxdG+Ouuyni50FoBFG6Wd3qGTMwaWrZKf0i
	l77CIJCwySFY935jLGob3jHH+iXSLokBChLXGsXOaWrwg5yTLCFRZiFjYcmyR1Gwu2Assb8mb+s
	aSBIwv+8g1Vq+dW+uV/Pk+ZXoEP/bKXhPh64tDKiS8ktdI7mTc0VTP2S+RJkrj8qpno3qUu5PC3
	KsBIMgSm3Dy1IAdOJCSk/ZeKl7N50w0K1CtQDcUK7fBl0DXBqFq0cr5Ytp3v6uNhJq4QwIsqsKk
	8dovV2Xc5YxMSn/WKZBxH0jiGetLmw0+RipCHwdH7oCR4c50tJkri7Wgt/y7O1kRi31TxP2DsVx
	Z5Jmd0oefV36U3Iru0+018xlF1bbEpPT9hvH/V+uNAHBHeMO/Fnk=
X-Received: by 2002:a05:600c:1f95:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-486ff039d32mr202931655e9.25.1774303868411;
        Mon, 23 Mar 2026 15:11:08 -0700 (PDT)
X-Received: by 2002:a05:600c:1f95:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-486ff039d32mr202931365e9.25.1774303867889;
        Mon, 23 Mar 2026 15:11:07 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm2403135e9.10.2026.03.23.15.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:11:07 -0700 (PDT)
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
Subject: [PATCH net-next v6 5/7] net: macb: generalize tx buffer handling
Date: Mon, 23 Mar 2026 23:10:45 +0100
Message-ID: <20260323221047.2749577-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-1-pvalerio@redhat.com>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270766-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 7DA2C2FE212
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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
index a71d36b18170..4c5dd70f003b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1197,7 +1197,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -1209,9 +1210,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
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
 
@@ -1298,7 +1299,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1306,7 +1307,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1403,20 +1404,22 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
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
 
+	queue_index = queue - bp->queues;
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
 
@@ -1434,7 +1437,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+			skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2365,7 +2368,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2393,7 +2397,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2411,7 +2416,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5283,8 +5289,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5376,9 +5383,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
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


