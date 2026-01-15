Return-Path: <netdev+bounces-250337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50801D2902C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212503019E33
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18732D0DE;
	Thu, 15 Jan 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQYWOCsy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r5i99AfD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336D327BEC
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515983; cv=none; b=WJ6yUmt2aBKTRaPCREECHp+ACkm0EzTIAu5ZNxb13jmLA1P6c/xoFCskZYX5/nsNcmFMgfNF4WpCcRjRVXAG7xDqbSYq//2IrS87+CWO/lmfRucB7gnqSttkzJAB10drH2NjDdHpe7oYR1LycdJYeCGlgqL3VJ3DxB1xozjI0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515983; c=relaxed/simple;
	bh=TENhOtvSgQjp0CBhUnlztDyrVnI8Fv4t4yZbvbcJcaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSGnrYmpe9l1+36qTgNfawT5Nw+xJBZMjrgrnj40hmtA4jG64XputQwZZFRV2s7eL7g40Ajo5fIO1eut47sJ0ZeHLHvgXtezD/fqfBzJEngbX3QzrSzWWbdypfMS2aYVVyM5uHd14K07r3IsNiBYh44YDMdpnQ4CPhL9iD+2qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQYWOCsy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r5i99AfD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zxluwm1XGdHAeU6/KlnUEPr4dJc5v8Dzg668p6S4Vc=;
	b=fQYWOCsyROM93WlGC03n/BZ9+bukXj4W0K9kisU/o6mYk1YghGo8ivNd8ofQlto0cs1f8Q
	WRsct2QswWdSxlFxfuJvhSlX6S3EkvRo/Ai9LOYjOuo5Sm0+wCsxefSGoPH/rnpiJ2s3/3
	784Nox0FUrLgE4b9XsUyCO7oyfBcn4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-sdfJ3DOPOHi1Ek2E0tGhMA-1; Thu, 15 Jan 2026 17:26:19 -0500
X-MC-Unique: sdfJ3DOPOHi1Ek2E0tGhMA-1
X-Mimecast-MFC-AGG-ID: sdfJ3DOPOHi1Ek2E0tGhMA_1768515978
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso8779335e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515977; x=1769120777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zxluwm1XGdHAeU6/KlnUEPr4dJc5v8Dzg668p6S4Vc=;
        b=r5i99AfDD8m40she6I5htw4YgcPuoSTmROu4ENXwgyna8hBLI2y0ofLGKOWmlL9Ejn
         TNE6Orp/PHUBl2yKulTfXho7N7oX61nH2TRwfjs6Oej5PUYyNvMmiKcQI4DS5zjtM8op
         DZF28RqIVeFUGSYkQqAwCK8sjsOO7uVyAUozsEMQYJ77+ACY+7kKaZUqtAxo1LmDi444
         cdRflQHHawBgT5z56unhfXMOIbR8T4qFiR7dPnCqEvbSJF9IUzu6FuNwrIAgrg1DrGed
         XSbIggNZlCJHpuX+LtF51dbIvNmOLXfOS75WnuuWkmop8NfZi7Yt+Ny7/dWzm21+LTAQ
         Rq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515977; x=1769120777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zxluwm1XGdHAeU6/KlnUEPr4dJc5v8Dzg668p6S4Vc=;
        b=bjUptcU7vtaBOFZBUoiJAwNXdgJHFRNzHy5upg4DUmn9637bBT3UqfwZF+Vg6MOwzF
         uYLuyoLM05oBJ/PoJmbs6xF8OLfxpiir0L5J2h40zxITtq/pNlzP5MeWTgJnvDGjFay3
         bKday45Yndt3bRcfd/arMbgUYV8gQt+hzCkhwuYXs459GA084xL77drxfCOLrz6pazzJ
         d+u55y/VdYCYADytcLr3NahhSjR803MkkQOrCiYhBjm8PN0QOyD7L+ds31ec9UFix5Nm
         gVrgmHpsHpPOh1XgXLhbPiQM4IztoNSlpCzmtZ97cVLZvpn4e38m8ycY+/tC8MqZmExQ
         xBqw==
X-Gm-Message-State: AOJu0Yyj5rJ1Ab6LSnpUv/mVQOk1ELc3gzwAXqyu7aQhGcpwd7uLO8sC
	KaEnyKNoaBkuZU0zp57iEMPzS3xJqiFYt4OZ56TeiDRXLEvpf4xi1+bhzPeae1GH+ItFG4csuzA
	HivcC3YRSdkGovu8nhV86BP49q33WbGImAQWIfmOrhBCdZnSzMpgylAdCjiWBZdsZ0gLgYODrYL
	8pg0x1HsKNIaTs2slp0Hckl/Fkk6eBtQ8znNPYdw3C+Q==
X-Gm-Gg: AY/fxX7WNQ97mqSfbIj6um6C7ijt/2IGqgxH1dmHNL5TBdVUv8ihvddPKlbSEcO2bII
	EOxCIRuTpfT32Ep+7HL43Db9RhMId+RE8hWkO7F6weuaCpJ2V3FbDTeiFob4Jnvl//xVbMkqB4m
	k1PNHyJz31UmP3HP7dEroVKP2w1pVbY5PpquEgortAFS7MSrrkxjHUh1EhMhVzL6YFIgRIdBvA+
	kXW85tOfgjJBc2a+bK/x9Flpo3fLw0M0qkLPpeckT1c9Bcp4alM7XPTuxpcWc0J0gTUY4iZKuzv
	+o3QWbJxsqRtsZRqu4pKDREzIalpfafr/b77RLXltvMvRkOo4Rl1yFygq4wZKVRE4Nlypx/YDOX
	LxBYX7DUGew6PgVbhCTc8yGQLDoA2qcE+gxzS2MCAbMl6Pw==
X-Received: by 2002:a05:600c:3b1f:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4801e34cf66mr13022155e9.25.1768515976980;
        Thu, 15 Jan 2026 14:26:16 -0800 (PST)
X-Received: by 2002:a05:600c:3b1f:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4801e34cf66mr13021815e9.25.1768515976471;
        Thu, 15 Jan 2026 14:26:16 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271easm1374903f8f.14.2026.01.15.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:16 -0800 (PST)
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
Subject: [PATCH net-next 7/8] cadence: macb: make tx path skb agnostic
Date: Thu, 15 Jan 2026 23:25:30 +0100
Message-ID: <20260115222531.313002-8-pvalerio@redhat.com>
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

Rename macb_tx_buff member skb to ptr and introduce macb_tx_buff_type
to identify the buffer type macb_tx_buff represents.

This is the last preparatory step for xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 23 +++++++++++-----
 drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++----------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 970ad3f945fb..c17e894dfcdb 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -959,19 +959,28 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_buff - data about an skb which is being transmitted
- * @skb: skb currently being transmitted, only set for the last buffer
- *       of the frame
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
  * @mapping: DMA address of the skb's fragment buffer
  * @size: size of the DMA mapped buffer
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
+ * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP_NDO)
  */
 struct macb_tx_buff {
-	void			*skb;
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
index 26af371b3b1e..afd8c0f2d895 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -969,7 +969,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -981,9 +982,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
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
 
@@ -1070,7 +1071,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1078,7 +1079,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1206,7 +1207,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+
+			if (tx_buff->type == MACB_TYPE_SKB)
+				skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2163,7 +2166,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2191,7 +2195,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2209,7 +2214,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5096,8 +5102,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5189,9 +5196,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
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


