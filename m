Return-Path: <netdev+bounces-262632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPDbE3p6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:54:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E21D7E88
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9BD3048772
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEE36402D;
	Mon,  2 Mar 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6oStvwX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/2t1QIw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A87364025
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452373; cv=none; b=EyENmn10fUGzZveQxy+lF020fmufaiQoZ38w6jJPnnA6x8IXRuay1iyMY7+ipgeGx52YaWFesrIgWSFQRTpCnUsYN4NF0yPOTWbErzxHPLBM3TkMR2hMq1W297m7Blb6Lgp+fE/CmKqsdEmGiOf+jYEK1w9qIHYvjDXywdESbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452373; c=relaxed/simple;
	bh=kGVhllUDoYfkJQR1F8xFYVAQArwWXHjh2UE0Nd3JZsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWjNk57wtP+rcx99sY0d3asdNhh+TXaMgIA4UFuhBEy+c3uQ41JXaRvH68ty6uS1l3Qiex6MQH8v655RCGG/mFpNcumbbXWn9L6uLrBbqfiSpjKNHgDRihQ8lY1Pt+R9t5at6P2FtHnnfzZ3IHJlvGeYx4hI4g5f9l2NB+STNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6oStvwX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/2t1QIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcRsaRiPQU7nDsusyUovgkjsWZy2tScqTuACfJr6ZGw=;
	b=d6oStvwXUlrFAgqoKyRpPdj5GWiwRsJQ2Rz+hmyjmtjlx3zm9+W8SFwAfxSkc39Vp/LImE
	Rrq0q6xc81rNxwpoAoU2XFrlPQqniiJs1utNw+cqNHURlOa3Q/fA7/kIslU/9dKEng+7Ul
	PY/DVGIkZUM8WLW2BTimLcL+JU9ImP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-nzpAs2b6PS27lZ4hdFmBiw-1; Mon, 02 Mar 2026 06:52:50 -0500
X-MC-Unique: nzpAs2b6PS27lZ4hdFmBiw-1
X-Mimecast-MFC-AGG-ID: nzpAs2b6PS27lZ4hdFmBiw_1772452369
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso34418685e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452368; x=1773057168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcRsaRiPQU7nDsusyUovgkjsWZy2tScqTuACfJr6ZGw=;
        b=R/2t1QIwQyd9jUzX4ITYS6QHb9X131bqtn8IUVQYwPHq3mbVEj4y88yXuLfOFIaTN1
         2m/DMxt0x37gnedv1s/y+4FIIbtd5ZD7ftqHiZOkn3QbcDa0cV+6A0/i+EpxtuOOy/iA
         tE+hgg2ZGymJOx/eTeE4UhaaesqDNPHtLsQGFlPqb69ZeMEw6d/8uohD8XE8vhWaSmkB
         Ub+YkEY9OqXRX2XYbnDr15OlA6ECEN6qK9DyZ5tcFybunrTpSp7iKQLSSCwXPaxDS+Wu
         rqBjqkSyGXZdxpgdAksQ7pMtt+6sbJ3N5yfoNZcDdVhY6hiWdLfwXdAO9FgLzfD23B/I
         XviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452368; x=1773057168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcRsaRiPQU7nDsusyUovgkjsWZy2tScqTuACfJr6ZGw=;
        b=Xp1Ygzr1glYoDxvPK5K4Dk/eSKKXjBGqrWFiRyC9H308r0P7n7HRcxEiKVV8xT2XQ/
         2V3jSbRLVjPCtyFYDLbMXTzEdrWkbcDGnjP+ECphOYAGFsWCpJrREvn5zdqbLPxxzp5r
         2NXr+Fd0k9C86k28oHIY0RmOtK5E+49dWD8kaYyqM2h6VPAT4XwQrcbys2tjQNa6RMQr
         lC+Iv7G4btGosTNtLsQFLlrpbhW690Kw+yBWzXja8r/JlZT6E99988wG3wZB7KxNTPVh
         Tm1Zjzy71tUyhzVdMTlmf/mDCi9VKCeOhjCymYCGZJfeqCqs5KGzIvlYDCkltgkuZG/w
         FNVQ==
X-Gm-Message-State: AOJu0YyBzr7jdOb04GqFosIIr0yIHkEPmQIUpmVpUrYptHp4zQnN6Kg7
	l1m6ib62MbBDL3cCu4QV3UGLY0KO2INHedTKaoBeOJ8/UQOT/YqJysa/z4eXgR3zcHka2BvW1W0
	Hcxh3h7s2NDSKiMeCmgQgyguhFA69ZuGMNaYMcDY+bahyIOR5lfdTPLh390L8Ew5wziWoLW9B+1
	D+JRn7ZLgVvXm3XR1kAW/vdXTCnstap8qlyOg68Vl2cg==
X-Gm-Gg: ATEYQzwmDr5qzC92l4QUlw+si3eBe4auEsqSjVZZgmJOIZ27nBy9L523cDX21eXzHGY
	oJ4SZB7nqJDgaWtczmkXPOi6MoHGrcoSj5E+5PlL8SH2Tg8qZ1BgtQGAeknVq+xWcDdOOocxUL9
	cvTpx/Zfz7Gu567wW4ZW1r4StSn2k3IbStWS9DevcqhP1kBIVu+r3eG4/BXZOhXVD/WBGtY0xo1
	3V8jvcca6QyCPw9xhTHms5uO+QgOTpt1SdTFGDa6vyr6hvZcvgOsjX3jsCNOKhtiVK6xc4JXyx2
	eMEphVpiIBAUnyS0vKHComP39hGU7kbP2CGLidSQmMtsA95wqCgO23VwkdES0pd9CacHf+hBvRS
	vDitqZOuGdCJiCv451r3w4nSUqvjaQ6hE6OUB8JZqz0uNwh0Qh0TwzhOmAbM=
X-Received: by 2002:a05:600c:548f:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-483c9bb1d7fmr206044435e9.14.1772452367885;
        Mon, 02 Mar 2026 03:52:47 -0800 (PST)
X-Received: by 2002:a05:600c:548f:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-483c9bb1d7fmr206043755e9.14.1772452367284;
        Mon, 02 Mar 2026 03:52:47 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb2c5a8sm193739985e9.0.2026.03.02.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:45 -0800 (PST)
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
Subject: [PATCH net-next v3 6/8] net: macb: generalize tx buffer handling
Date: Mon,  2 Mar 2026 12:52:30 +0100
Message-ID: <20260302115232.1430640-7-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E11E21D7E88
X-Rspamd-Action: no action

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
index 7228902ae20c..1ae80938331b 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -958,19 +958,28 @@ struct macb_dma_desc_ptp {
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
index 2fedbea841ff..fc6ea1391846 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -982,7 +982,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -994,9 +995,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
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
 
@@ -1083,7 +1084,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1091,7 +1092,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1188,20 +1189,22 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
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
 
@@ -1219,7 +1222,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+			skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2140,7 +2143,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2168,7 +2172,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2186,7 +2191,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5013,8 +5019,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5106,9 +5113,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
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
2.52.0


