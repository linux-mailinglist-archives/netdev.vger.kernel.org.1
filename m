Return-Path: <netdev+bounces-270767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGGQIOW6wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:12:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BA2FE1FA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F193067761
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C6382299;
	Mon, 23 Mar 2026 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZP+Jt9I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRc5Om6f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D1381AFF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303873; cv=none; b=CfwzVsgGSect9QL2EdT7IbJW5J7OLLmhgDMxlhfH/au2w6PJomwDl6q0XUPMnZ0mknKxHz9vG7gnbSGPlPS0FNpl//6SygWW8eUFlvYSNnOUqc90SIcmKGA+yqcVyMVU34No3KZ+VlNtCpg0l7Bydyr9HDOu4qd5Lf/fDzM1i94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303873; c=relaxed/simple;
	bh=eR9vCftckpcz3Lwwip9dzcvWVwAk/+Bn3BeN+58wzM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtxaE1rG/4Ph9QTiDNxA3HVcoPcYf6RoS9LSiX7vSht8bMlHyev484Maq6CHCxxPJdRmh3mKTEjYB350efFDUb2vpy54ErbSiaA1LIAMTbcxLn49P1H0PjiuDU32OU4yh+R2Q/p/yLrCe81dntHvIYkoiyFuRux5tI5FXfGlQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZP+Jt9I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRc5Om6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzqQQQU0FEUWsba7gNKu6jIVRi0XQP+unQezVD8zBdw=;
	b=cZP+Jt9IDq9dJr1GBY833CUw2HlBSCnbnQE3sdFzp3HQTt1rA6WyEN4g0uWqOXchT19Z9y
	4229e5Q7f4VROoHu9yJS8iG0qb73SDAj6+0Eq3Y3ROtNmqDgxxmCRWYHXOi76IxziXiFUI
	07CDc9gJ3jxM6/7yNMC/OPDGIMjBcGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-4uTRjuU_NICH6xqL1i_jpQ-1; Mon, 23 Mar 2026 18:11:09 -0400
X-MC-Unique: 4uTRjuU_NICH6xqL1i_jpQ-1
X-Mimecast-MFC-AGG-ID: 4uTRjuU_NICH6xqL1i_jpQ_1774303868
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852ccff333so4892175e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303868; x=1774908668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzqQQQU0FEUWsba7gNKu6jIVRi0XQP+unQezVD8zBdw=;
        b=KRc5Om6f66LLOTsvx107pN3uPqhD2Xx3FZS4Aeej8Ts89FEXr+Io3ygplzcZ1kWRXd
         bBUOQUf/dkcKiv7W8v/EM42QZTPbCGc1adXDcLB4UcmeKHmDRxYqYaQ6HlV2JzLMxfwC
         2UBic0wGaT5KofokAb0wCHOK9cQ3xtbWANBAkIT+C1vxNwvDdpBEZPJe+QK5hk5oEe8v
         K8L7rHAsiDldIZw87WvESgkip9MF0RQ9hcIUBLVzUtWolPiYliKcnD+c3fVQeQREHRFd
         D0gqCfT4GQVxmCPkmo/AxFwc69lfr/bSe/IGu/u2+c4TojcX3se50/5eNZhtNNVVQpQw
         ZsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303868; x=1774908668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzqQQQU0FEUWsba7gNKu6jIVRi0XQP+unQezVD8zBdw=;
        b=g4f9SVJz+hvlF9Pr3+577dCggW+/0AmIxUDfnAYOslpSMzwnO6MDpbN3jeTV1DwuHQ
         xcDCzWyM7ZKkKl23OU3rjDlGw5X2P/SJkxwf5uBqJEyvX61u7m8uz4H55qr5nALO2lsH
         qStj7I/0Vi+3vYYW6csLZvbV1RlsptluUmVMX+xG0sdTbMKPs3TACi77nkNnvCE7sghM
         /ePM9BJoFRXTHc/8ttaM8EpzSUe2pKRX6GlyEbSxvTu0R5wNqmXZ9qSitb24/gfvm+3M
         KMBijOAO/YP7pdwUYwYhUsMxnkXEa0B3xZPdB0VYYMDyIrF8/oIuTsMju7yLgMt5pg3K
         xODQ==
X-Gm-Message-State: AOJu0Yx5aKZKlnEeTTuMHtLGOQ119I8bYBuywMv01rp7SQNELbvxwDax
	KbBKkqFjN5jfJcar3chLVotnXx+h3Jtt08gRBwGRALF7DbAxj0gwLDY6YWdnZLWckcJmyFVqViS
	DseD43gmJ51F/KAG7DWgu1zoHtCaQrfh+g1rBHsZS0I6uImVZDvqC4bB+Mhnsz9G265FIO+h/A6
	8FZQ2zLcV7CyOPLWgeSk6cY9oHPZIlN4VJxtPG/1glPg==
X-Gm-Gg: ATEYQzxQ+kjL8YPbtZrMWpuAa9B/5gXN4juQivNsQpBcLtMrS4jgiu5YQbMqhGO+hLS
	p4N4I1fuZgAh8gyv9lYYRNTx+SsO0K+rFS+7f5vaN41ZRj5RnayKiM/8PRM09t2yEXMRU9s2VX0
	rdPrHD1YDjE0nAriYsBZFc9jo+aQxhdsBP2Wu4jeuGaNva4lYqUAOusZiFEiWZWegA1VIvmTY3c
	5zKbzZmJp5fpBLIH1Q/kpiIYBUIeIBbN2GhYI0VUXnqzli+lalWfl0xLSQKa1b4IJ5thapNi+hI
	nrdVHlb0A+kCbyd7oVyAPzg3W/mVMaTDQCi5InJKvG5C0z6KjOBHb861fQxFUe5bVaHypCFa6D2
	8r5oq+VRTMDfQ9cgN3/JVuB/zjHE4kjawb37/jzR/FXH/YyQIHTI=
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr183488955e9.32.1774303867475;
        Mon, 23 Mar 2026 15:11:07 -0700 (PDT)
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr183488635e9.32.1774303866851;
        Mon, 23 Mar 2026 15:11:06 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711709e95sm2502125e9.8.2026.03.23.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:11:04 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/7] net: macb: make macb_tx_skb generic
Date: Mon, 23 Mar 2026 23:10:44 +0100
Message-ID: <20260323221047.2749577-5-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270767-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: E50BA2FE1FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The macb_tx_skb structure is renamed to macb_tx_buff with
no functional changes.

This is a preparatory step for adding xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |   8 +-
 drivers/net/ethernet/cadence/macb_main.c | 112 +++++++++++------------
 2 files changed, 60 insertions(+), 60 deletions(-)

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
index 84989ff0c3a9..a71d36b18170 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -159,10 +159,10 @@ static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
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
@@ -792,7 +792,7 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 {
 	unsigned int head, tail, count, ring_size, desc_size;
-	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
+	struct macb_tx_buff tx_buff, *buff_curr, *buff_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
 	unsigned int i, cycles, shift, curr, next;
 	struct macb *bp = queue->bp;
@@ -824,8 +824,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 
 	for (i = 0; i < cycles; i++) {
 		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
-		memcpy(&tx_skb, macb_tx_skb(queue, i),
-		       sizeof(struct macb_tx_skb));
+		memcpy(&tx_buff, macb_tx_buff(queue, i),
+		       sizeof(struct macb_tx_buff));
 
 		curr = i;
 		next = (curr + shift) % ring_size;
@@ -841,9 +841,9 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 			if (curr == ring_size - 1)
 				desc_curr->ctrl |= MACB_BIT(TX_WRAP);
 
-			skb_curr = macb_tx_skb(queue, curr);
-			skb_next = macb_tx_skb(queue, next);
-			memcpy(skb_curr, skb_next, sizeof(struct macb_tx_skb));
+			buff_curr = macb_tx_buff(queue, curr);
+			buff_next = macb_tx_buff(queue, next);
+			memcpy(buff_curr, buff_next, sizeof(struct macb_tx_buff));
 
 			curr = next;
 			next = (curr + shift) % ring_size;
@@ -855,8 +855,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
 		if (curr == ring_size - 1)
 			desc_curr->ctrl |= MACB_BIT(TX_WRAP);
-		memcpy(macb_tx_skb(queue, curr), &tx_skb,
-		       sizeof(struct macb_tx_skb));
+		memcpy(macb_tx_buff(queue, curr), &tx_buff,
+		       sizeof(struct macb_tx_buff));
 	}
 
 	queue->tx_head = count;
@@ -1197,21 +1197,21 @@ static int macb_halt_tx(struct macb *bp)
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
 
@@ -1257,7 +1257,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32			queue_index;
 	u32			packets = 0;
 	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
+	struct macb_tx_buff	*tx_buff;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
@@ -1297,16 +1297,16 @@ static void macb_tx_error_task(struct work_struct *work)
 
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
@@ -1335,7 +1335,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1413,7 +1413,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_skb	*tx_skb;
+		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
@@ -1433,8 +1433,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
-			tx_skb = macb_tx_skb(queue, tail);
-			skb = tx_skb->skb;
+			tx_buff = macb_tx_buff(queue, tail);
+			skb = tx_buff->skb;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -1454,7 +1454,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_buff, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2332,8 +2332,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	struct macb_tx_buff *tx_buff = NULL;
 	unsigned int eof = 1, mss_mfs = 0;
-	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
 	dma_addr_t mapping;
@@ -2356,7 +2356,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		tx_skb = macb_tx_skb(queue, tx_head);
+		tx_buff = macb_tx_buff(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2365,10 +2365,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2385,7 +2385,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			tx_skb = macb_tx_skb(queue, tx_head);
+			tx_buff = macb_tx_buff(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2393,10 +2393,10 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2405,13 +2405,13 @@ static unsigned int macb_tx_map(struct macb *bp,
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
@@ -2442,10 +2442,10 @@ static unsigned int macb_tx_map(struct macb *bp,
 
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
@@ -2468,7 +2468,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(bp, desc, tx_buff->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2484,9 +2484,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 	netdev_err(bp->dev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
-		tx_skb = macb_tx_skb(queue, i);
+		tx_buff = macb_tx_buff(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
 	return -ENOMEM;
@@ -2809,8 +2809,8 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		kfree(queue->tx_buff);
+		queue->tx_buff = NULL;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
@@ -2888,9 +2888,9 @@ static int macb_alloc_consistent(struct macb *bp)
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


