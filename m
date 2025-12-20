Return-Path: <netdev+bounces-245623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF8CD38F0
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED5EA3007E43
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAA2F7455;
	Sat, 20 Dec 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4woL++2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdKHMQ8P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88142E62C8
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274728; cv=none; b=mVn/7JFjq84sB/TJrGK3Uri57Gzt6c1Wf+fF0x9XawVdVcw5d834zK809wkZ0r4rSEK+4IbLN8/7NlshpluP7ri4Nfou30bn4pD0NOTV2Prw6sTqG7DolOmduwXFvwuUMsAExoD2dEjFZyF05bCd2sxNtJIVkWqZUjiysB1S+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274728; c=relaxed/simple;
	bh=dCnMY/Gf6soXaa0LmgSP40Mo4gr2p0s54PV2qvVA2aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh3Do27Ljz4d5WQfS3DR4+7wbORPDbVhBIZKTKWZ2lg8HaWupFHnLgzm/di4FzpY+z3JGcwiNG/DsmCumQe38sLFBUoVEzLpsgTrG7FHIwVjd+PpR8x6HOVCbFdEeoG6BQkicC2Bsyi7NRB94MgeFWwXF7T3cC39Fjm9MRmzOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4woL++2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdKHMQ8P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuag4WFwEElTM9nuRln6RLBcUfe2z//PxP5ZLQLqZnA=;
	b=A4woL++2Bq8HrEeG+IB0O+rUK0sS3ZolM6qgqTIxXA9EOBGPOkWRo8seWeINqsY/GrhOAn
	AjK8zJbVctyuv/ft9eA7PnsgUSFjlo46LlN3oBqqIC/jbfzHLvYlivYh8w7t0Gxkn+KL+k
	7kStgSgeDpRyy40cpkHMgRdBUWCfXjQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-yd5ysTlgMgqbmcTZZlxgsQ-1; Sat, 20 Dec 2025 18:52:01 -0500
X-MC-Unique: yd5ysTlgMgqbmcTZZlxgsQ-1
X-Mimecast-MFC-AGG-ID: yd5ysTlgMgqbmcTZZlxgsQ_1766274720
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64b735f514dso3552172a12.3
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274719; x=1766879519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuag4WFwEElTM9nuRln6RLBcUfe2z//PxP5ZLQLqZnA=;
        b=BdKHMQ8PjX+FegPOToa/LGHtWqcM1I2BE0A3RFV6epJzq7kJzdrYva6FYyDk9UIvDw
         1MtLsTs/0Sf+h6BIFJqHYCb4Fwx1MNqUU2pd6sSmD3Jwf9sDFvU18JJtg8+zcjCmPGtw
         v/TBPpX51NMG38dBHPql9v8fQ1LFwUralik3UCtsm36rGgYmBTV3tMVSb4u92iNVJSY0
         3388Sbkmo6JOLWF2lF5aTw9THo98RYFKub6GzEkEHEG+RWWvf1XeKDaK2yjUQcrnh1dZ
         rb7K5cVafnyS56G6Mm8nATqQ/6zxrPzIXlm0ALgErsyHv+UWBmVlC7Vy1QcpiguPreat
         EMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274719; x=1766879519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuag4WFwEElTM9nuRln6RLBcUfe2z//PxP5ZLQLqZnA=;
        b=VeXEae6tu4//Ejp94yMuOHvBFD8pmf26I48a4/98zSn7GuxFMGhU9UmzxyubqbjdsX
         fTfc0aBgO8dczBgAvmEDGSfb3qzoVZUE8Jdn/kn9mXbYDW+mWviko5FXd+SigfJuaSW6
         eg1iMdaQdTkN7tVbUfmxNrE+PuDgBymHQ/T9KqLE2l7jQp+1Bd6leXHwabfMKS8l/3tK
         yv7YzpjzZt8eRhvZgaSET8J4xwgfd6x/WC4pgYfd0Llb2O46SRSBqgdcBH0VRcpK1jw1
         kWb7SwQWMTzv4qpSu0DHI0dTrC9vUqSap/oTt40KjwRacsns27qDaOR9C3u31vLOve8y
         xs4Q==
X-Gm-Message-State: AOJu0YxGbn4DiQRjACeOB+vpvJe5KEguCvxEGsL0MH/XgD+15DbfTuwm
	XWfriH9KMEyGbT0NfFXLwIntLjH+gCYiy1TMv55cwJWGURfGYGlsrwJTn8PZjb/ClGpSFYbX0Vk
	LTsPfYbAmL4jviMfX7kRCXeJsN11iW3+t1cIjoA88BI4lBL/IKszGVCwWFY44nSV+D5mxGRNyG/
	Pzb+QBJPJQVc1oZTbWI+hFuabP2CZCTJB2VbKITtf8lw==
X-Gm-Gg: AY/fxX4aa67ArbcVbV+QkZ1N1bPPpqfPeiLaAKEQwrQA7Mjkr6ZCIjK/yqlQNw9FzQy
	AQrcKIr5zfAuPBWDxjCYMbdR5Iesp1PBskym3tYT0Ji4ryq6SoNARX0oW9kp65vhF5Y4D+rkYfb
	ooNpOLT2SWKIS2kdCEUvbCahqYDhsN440dr1pClIS73WR8vSP7CS8NTXkahnbHOXO5tb/YYymkM
	tKf6ECrEJ2f3QrfvZwTA/scWjFELHNgd5AGBXpdsfv9a1exAQL+CcDF5sZTmpyBYvuw9yU4aLvw
	JPzCWT/mncbhkC4NSlipDo9boHuSSo+uUd0QlUDPjReTx5tAcDwegXFuaBS+hhaYHkfU92SNWvY
	XDsArELsBab7pZcTqKaIsOpNRM+cWblJLSdauWyg=
X-Received: by 2002:a05:6402:5108:b0:649:b4d8:7946 with SMTP id 4fb4d7f45d1cf-64b8edb3335mr5543626a12.23.1766274719158;
        Sat, 20 Dec 2025 15:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlbhjauxqjGyvJUKmzpav2KqV08pxpOFyzMp3rGVAEtgUtpXIyjv+kddIq7JNXdMcalOnzng==
X-Received: by 2002:a05:6402:5108:b0:649:b4d8:7946 with SMTP id 4fb4d7f45d1cf-64b8edb3335mr5543597a12.23.1766274718662;
        Sat, 20 Dec 2025 15:51:58 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm5878124a12.6.2025.12.20.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:58 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 7/8] cadence: macb: make tx path skb agnostic
Date: Sun, 21 Dec 2025 00:51:34 +0100
Message-ID: <20251220235135.1078587-8-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220235135.1078587-1-pvalerio@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
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
index 47c25993ad40..09aec2c4f7d4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -960,19 +960,28 @@ struct macb_dma_desc_ptp {
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
index 3ffad2ddc349..cd29a80d1dbb 100644
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
@@ -2166,7 +2169,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2194,7 +2198,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2212,7 +2217,8 @@ static unsigned int macb_tx_map(struct macb *bp,
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


