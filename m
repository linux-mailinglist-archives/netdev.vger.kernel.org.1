Return-Path: <netdev+bounces-240001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698DC6F1AC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CAC0030007
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E733559C8;
	Wed, 19 Nov 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Loxz/9Ok";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUCA9AY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A447364032
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560457; cv=none; b=OF0M2MahOSDj0h4M97VPqn7+jZkwvda7CdaW5karSVvlt7ysT3kegzy1mIkCxRO891qpPRyifdgGiRU8XJnFkueuqZNVhE+Ug4ZYTKA15lpwnPzHd0+gs9YvlHSMySsD9HW9/FAd+zR4909samezpeSd2dihkS5Exi91Hpe8EaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560457; c=relaxed/simple;
	bh=uLNYAwI2Lx+O6Au2w5OdQYvomjn5Xuvc49AOaD+yslQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL5MJDR6vEXPso057yPRw7kTMe6c3yhzV8biffKggPZHIht8PWcLi9ofmtsIsfForBgVs545Lwn09ybQzG7xntbanlcWHmy4w801hhGyYXcKDQFDwk/dI3fO4YxLU8v3ceTFiYl2xwe917I6uTwLXMzwstOoYzxs51bmEEra0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Loxz/9Ok; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUCA9AY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MQPzRU9WYS0pc1OITuYUE6TWGYA9kQW6IJ2uRfKw6I=;
	b=Loxz/9OkiW3VA+A8e/4wfiTzjxr5LFBQitRgHCFJeNgJVCkMNxKvd9kMt07IbgQm8u0w7J
	e9l//FPmhJ7NKLmEzN/BcnyXhseplsrunv5r9fit98OrHUxo8R4boVaVui0X4PG2Ett2Ks
	cWKRm8WPCCpFBr8RqyAlbfboo1lemfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-x4xVevJ3NHWpLili3yATyQ-1; Wed, 19 Nov 2025 08:54:12 -0500
X-MC-Unique: x4xVevJ3NHWpLili3yATyQ-1
X-Mimecast-MFC-AGG-ID: x4xVevJ3NHWpLili3yATyQ_1763560451
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so6706444f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560450; x=1764165250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MQPzRU9WYS0pc1OITuYUE6TWGYA9kQW6IJ2uRfKw6I=;
        b=KUCA9AY0Xo4xIB4HdZLbMFA67tohSH2wDXULemM0kIFU3sHlVLD7QAGctU4BcOU8xF
         VKc+DWkbp7qssOLOOth6BkwXpr/p1OHG8dg+3CPM85ONAsWrTN80bnGp3xeUZo9eEBoS
         fYzWqMaXBaAxyb9Ezx5OK8qYDzF/ylJyEygRfQWGjmip9UkKagDv/6oxHNC68AUFoi3L
         rSeta1Cdv1wkPyuwqHSK2carovRitHfsD/xjwssr5jwErPD+kWuVovfkPDsUmM3KrL1r
         haanMhqd76JkPsodo2+48Obc35ehk+PXrHYmYImokuq9TfZjkFWs3dC3lk+nnCE0OJj+
         cZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560450; x=1764165250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MQPzRU9WYS0pc1OITuYUE6TWGYA9kQW6IJ2uRfKw6I=;
        b=ZXCG63ZhO0MKOe7zhkljgCqpaANp1e3lZPWR2OPjiSD21lM1be7x6ALXtmlrhRLFVB
         O0AQzPJQIyZ5MSId7ETWWLBTu6JN9pC0q+YQboJrZKlYQAn1QbDb3eqm0muLgZJDCV8O
         vVG/HhxXmux2cw6iFrcNPeWX4SDkgVa7PuMQsdZ4HoFmSs19WeKXjjNUgHtU+87iFtqa
         cW+A9n9PQ3K9Ndilx2/3fDAmqQWTEqOw/bv5tT5wlx/cGGiSOWOVCKTqPA3q5TMUcf0s
         8yg7WhuiQQBwF123uGc8Iw++x9a8GJIKDaUN8lWg1Ipp09uvCyTXIytOb0jMY+UM0Zw6
         uY6Q==
X-Gm-Message-State: AOJu0YyRp4UGNKLTrC+Ix7R5G12m1IA8SCAv7s0DBwekeM04FHHjjPtU
	9cnwQ1mqF+JqPJxbBbLcriyFJlzMPYdkJOAlY3kH1TCmmPt96zLOvkMU3cMkKz7samdef87h3nA
	qZAXJY902kctcXCdZz9VOs7Cy6+TsNQ6huNLl7O5MgJ8zb6NbIKE6nytj9+0chrvtHwxkLXyGGj
	mVzd98Q64uqbGmUEu0drsfNFjW8n2vQDqm7H30OUlvvdXP
X-Gm-Gg: ASbGncsaXmqkVHFzUYGrEg0Tx7LMXKxrR55znX8YMR7kkKOlAGmwSTrBmvdKqo1cVIf
	ZNRux1MCVKOKooN9cBn4bEIjhodcMuaZcwjc2mLp3YXAxl2CDLf+OFGWnvrWYytlth9bNZgmLMW
	/NM4WtxQbobh4rLvV2Hg9qHfNPlV6WMfMOzJZ3797rbQ0Q9V3rS3qLp50Q0CTsYVRipJN5ma0th
	R+3ocp+QJTwuOUbIbAWQaH+VedwhmK9D7Q9wy0aL9y7FVx/23mj3HKGWLin1Hn7qB+YM4ifeTu4
	JcyhQAtFCZML3VS/2hn3SP/zWW1udn4RP7fEe1Ej8bso5c4mCE8rR3FEYIrWsqfGXF06GWM2SE/
	nE5lrjrjgyb/WUUMyHDcuydi5edHi6be0nrBXieZki+IJdm7j/A==
X-Received: by 2002:a05:6000:26ce:b0:42b:4279:eddd with SMTP id ffacd0b85a97d-42b5934aca1mr19563201f8f.24.1763560449698;
        Wed, 19 Nov 2025 05:54:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTuqxhd9RTzUGKZujfHXlSagAOnjKZmVWsZtX0sK7aNyIQM+ws1u5MhSuqnTi8tqP8HXl4og==
X-Received: by 2002:a05:6000:26ce:b0:42b:4279:eddd with SMTP id ffacd0b85a97d-42b5934aca1mr19563154f8f.24.1763560449012;
        Wed, 19 Nov 2025 05:54:09 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b622sm37434564f8f.29.2025.11.19.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:07 -0800 (PST)
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
Subject: [PATCH RFC net-next 1/6] cadence: macb/gem: Add page pool support
Date: Wed, 19 Nov 2025 14:53:25 +0100
Message-ID: <20251119135330.551835-2-pvalerio@redhat.com>
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

Use the page pool allocator for the data buffers and enable skb recycling
support, instead of relying on netdev_alloc_skb allocating the entire skb
during the refill.

The change replaces the rx_skbuff array with rx_buff array to store page
pool allocated buffers instead of pre-allocated skbs. DMA mapping, rx and
refill path were updated accordingly.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  10 +-
 drivers/net/ethernet/cadence/macb_main.c | 169 +++++++++++++++--------
 3 files changed, 121 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 5b2a461dfd28..ae500f717433 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -25,6 +25,7 @@ config MACB
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PHYLINK
 	select CRC32
+	select PAGE_POOL
 	help
 	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
 	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..dcf768bd1bc1 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
+#include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -957,6 +959,10 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
+/* The buf includes headroom compatible with both skb and xdpf */
+#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
+#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADROOM)
+
 /* struct macb_tx_skb - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
  *       of the frame
@@ -1262,10 +1268,11 @@ struct macb_queue {
 	unsigned int		rx_tail;
 	unsigned int		rx_prepared_head;
 	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
+	void			**rx_buff;
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
+	struct page_pool	*page_pool;
 };
 
 struct ethtool_rx_fs_item {
@@ -1289,6 +1296,7 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 	size_t			rx_buffer_size;
+	u16			rx_offset;
 
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e461f5072884..985c81913ba6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1250,11 +1250,28 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static void *gem_page_pool_get_buff(struct page_pool *pool,
+				    dma_addr_t *dma_addr, gfp_t gfp_mask)
+{
+	struct page *page;
+
+	if (!pool)
+		return NULL;
+
+	page = page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
+	if (!page)
+		return NULL;
+
+	*dma_addr = page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
+
+	return page_address(page);
+}
+
+static void gem_rx_refill(struct macb_queue *queue, bool napi)
 {
 	unsigned int		entry;
-	struct sk_buff		*skb;
 	dma_addr_t		paddr;
+	void			*data;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 
@@ -1267,25 +1284,17 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
-			if (unlikely(!skb)) {
+			data = gem_page_pool_get_buff(queue->page_pool, &paddr,
+						      napi ? GFP_ATOMIC : GFP_KERNEL);
+			if (unlikely(!data)) {
 				netdev_err(bp->dev,
-					   "Unable to allocate sk_buff\n");
+					   "Unable to allocate page\n");
 				break;
 			}
 
-			/* now fill corresponding descriptor entry */
-			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->rx_buffer_size,
-					       DMA_FROM_DEVICE);
-			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
-				dev_kfree_skb(skb);
-				break;
-			}
-
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = data;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1295,20 +1304,6 @@ static void gem_rx_refill(struct macb_queue *queue)
 			 */
 			dma_wmb();
 			macb_set_addr(bp, desc, paddr);
-
-			/* Properly align Ethernet header.
-			 *
-			 * Hardware can add dummy bytes if asked using the RBOF
-			 * field inside the NCFGR register. That feature isn't
-			 * available if hardware is RSC capable.
-			 *
-			 * We cannot fallback to doing the 2-byte shift before
-			 * DMA mapping because the address field does not allow
-			 * setting the low 2/3 bits.
-			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
-			 */
-			if (!(bp->caps & MACB_CAPS_RSC))
-				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
 			dma_wmb();
@@ -1349,12 +1344,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
+	int			buffer_size;
 	unsigned int		len;
 	unsigned int		entry;
+	void			*data;
 	struct sk_buff		*skb;
 	struct macb_dma_desc	*desc;
 	int			count = 0;
 
+	buffer_size = DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZE;
+
 	while (count < budget) {
 		u32 ctrl;
 		dma_addr_t addr;
@@ -1387,24 +1386,49 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
-		if (unlikely(!skb)) {
+		data = queue->rx_buff[entry];
+		if (unlikely(!data)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
+
+		skb = napi_build_skb(data, buffer_size);
+		if (unlikely(!skb)) {
+			netdev_err(bp->dev,
+				   "Unable to allocate sk_buff\n");
+			page_pool_put_full_page(queue->page_pool,
+						virt_to_head_page(data),
+						false);
+			break;
+		}
+
+		/* Properly align Ethernet header.
+		 *
+		 * Hardware can add dummy bytes if asked using the RBOF
+		 * field inside the NCFGR register. That feature isn't
+		 * available if hardware is RSC capable.
+		 *
+		 * We cannot fallback to doing the 2-byte shift before
+		 * DMA mapping because the address field does not allow
+		 * setting the low 2/3 bits.
+		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
+		 */
+		skb_reserve(skb, bp->rx_offset);
+		skb_mark_for_recycle(skb);
+
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
 
+		dma_sync_single_for_cpu(&bp->pdev->dev,
+					addr, len,
+					page_pool_get_dma_dir(queue->page_pool));
 		skb_put(skb, len);
-		dma_unmap_single(&bp->pdev->dev, addr,
-				 bp->rx_buffer_size, DMA_FROM_DEVICE);
-
 		skb->protocol = eth_type_trans(skb, bp->dev);
 		skb_checksum_none_assert(skb);
 		if (bp->dev->features & NETIF_F_RXCSUM &&
@@ -1431,7 +1455,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		napi_gro_receive(napi, skb);
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(queue, true);
 
 	return count;
 }
@@ -2387,34 +2411,30 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 
 static void gem_free_rx_buffers(struct macb *bp)
 {
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
 	struct macb_queue *queue;
-	dma_addr_t		addr;
 	unsigned int q;
+	void *data;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		if (!queue->rx_buff)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
-
-			if (!skb)
+			data = queue->rx_buff[i];
+			if (!data)
 				continue;
 
-			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(bp, desc);
-
-			dma_unmap_single(&bp->pdev->dev, addr, bp->rx_buffer_size,
-					DMA_FROM_DEVICE);
-			dev_kfree_skb_any(skb);
-			skb = NULL;
+			page_pool_put_full_page(queue->page_pool,
+						virt_to_head_page(data),
+						false);
+			queue->rx_buff[i] = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
+		page_pool_destroy(queue->page_pool);
+		queue->page_pool = NULL;
 	}
 }
 
@@ -2477,13 +2497,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+		queue->rx_buff = kzalloc(size, GFP_KERNEL);
+		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->dev,
-				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   "Allocated %d RX buff entries at %p\n",
+				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
 }
@@ -2567,6 +2587,32 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static void gem_create_page_pool(struct macb_queue *queue)
+{
+	unsigned int num_pages = DIV_ROUND_UP(queue->bp->rx_buffer_size, PAGE_SIZE);
+	struct macb *bp = queue->bp;
+	struct page_pool_params pp_params = {
+		.order = order_base_2(num_pages),
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = queue->bp->rx_ring_size,
+		.nid = NUMA_NO_NODE,
+		.dma_dir = DMA_FROM_DEVICE,
+		.dev = &queue->bp->pdev->dev,
+		.napi = &queue->napi_rx,
+		.offset = bp->rx_offset,
+		.max_len = MACB_PP_MAX_BUF_SIZE(num_pages),
+	};
+	struct page_pool *pool;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool)) {
+		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
+		pool = NULL;
+	}
+
+	queue->page_pool = pool;
+}
+
 static void macb_init_tieoff(struct macb *bp)
 {
 	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
@@ -2600,7 +2646,8 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		gem_create_page_pool(queue);
+		gem_rx_refill(queue, false);
 	}
 
 	macb_init_tieoff(bp);
@@ -5604,6 +5651,12 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
+	if (macb_is_gem(bp)) {
+		bp->rx_offset = MACB_PP_HEADROOM;
+		if (!(bp->caps & MACB_CAPS_RSC))
+			bp->rx_offset += NET_IP_ALIGN;
+	}
+
 	netif_carrier_off(dev);
 
 	err = register_netdev(dev);
-- 
2.51.1


