Return-Path: <netdev+bounces-245619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05508CD38F9
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79AB301B2CF
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C7C2FC003;
	Sat, 20 Dec 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg9Ozf0N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nKKkoum1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA223C8C7
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274718; cv=none; b=G3qj6JVqFAzv83ieK4Jv9+m3QKR2zmw3zMh1MdDoHnZB2lZu91eHPDynTD/Dv2qz4CumRWN6XaqLAocSpeDGgFiWq1uCE5cMk2eMlqrKRtTIi5ys63IKzKyGAUHtx/1VTqOu4mo26WXp6J97mN53xya7GX6LXYgEUm0MSUDjdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274718; c=relaxed/simple;
	bh=+zaOkjsHE9+mqDb2s1bybFPdrhdn8rReZ9HjpXOTmSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqSx+I9LBqC81xOLpgZZexSqCZadtVJpGFJH3EsQgkqBW9l0gNgPTyPSy+XaeyTm9O66/sRwYw+smUzXLniGTW/ZXCWutK11+X8HuOjiZq1S4U8fHLBoJoVaJN8729/svOex4RmRRxNv0VTkm37XiaT1nUJrox25wdor8ZCs+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg9Ozf0N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nKKkoum1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ8XDRrpMXzIh1SbOuLPkKs6ThKyqF6vtMVVhnRSV84=;
	b=bg9Ozf0N9o0C8Uc0rGLMEH5yfD4y6PeGckYnVP+SWJVQhU9akSudMiP3wyI3XiKrWIO6d4
	XHBZT6KLr/yoz3YdjjLwvWPbKOtI5O/1T4r0KIJyZW4nTECzgu6SXkLAD5TdI1OsW6CC9Y
	UJ3SPxzlvsRmW4qGzWtMxfUqGNJusWk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-9SgbSn9TPdu0aCRWOeD5Hw-1; Sat, 20 Dec 2025 18:51:53 -0500
X-MC-Unique: 9SgbSn9TPdu0aCRWOeD5Hw-1
X-Mimecast-MFC-AGG-ID: 9SgbSn9TPdu0aCRWOeD5Hw_1766274712
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64ba73e83c9so2242931a12.2
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274711; x=1766879511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ8XDRrpMXzIh1SbOuLPkKs6ThKyqF6vtMVVhnRSV84=;
        b=nKKkoum1iA7AnLgwSTMn87VOO2qQJMayk8rdflCxut4D25emeCNJkRg8GqepWXtKf7
         KOvWEcrV4uE4kT//Zfg9GueDuplfOOY2oeGGeUcV9NRL7WhwGduMw2HZLgUp9LJjzMZs
         KuYmThMnv1e+c8t1U3TsOGSLpWNF7pnAuAOCv5lSBXBBTaok4oDCaLqyICnSlETbEdEp
         OTKo31t+lqG7og4w/AE5FdFfAGp8uq/IahNOGCcGHiIYBAVFqg09+Q9o3eU59VU8zO6v
         mu+CkXmkMNlAPUltJbBARhTeY87IaCvRNXxhN9qf+ymwaW+Bm5NbaIKXULRrSmW+EcCa
         wEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274711; x=1766879511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZ8XDRrpMXzIh1SbOuLPkKs6ThKyqF6vtMVVhnRSV84=;
        b=wiuft/B1KsUMgcAvWCxl6iRIkVUSz16pv9vBdjuAoc/FndHvghFUdfkFEa59QADKKd
         CDgvQ+XN+SARFtyAdOKGr8Ixx/0AyOBTNbESOCDqZvrC3b9AqL/M+dn/D4Hii8yG+OlV
         tJOuS0BghdbQP/+DEsTF0GTwU40WXuURjY7Ks5PJzFgUYYPiKoQBqGgZfi9YY1xjbgbq
         nD/K525VJ8at6SY4ksugb8kamKai8v6+qjS4pZvlWYWXx5dNuKgWB0iXFbLgSHy/LLam
         E0XeUBL1UG3Tbvl+kBjxublH8bqIpU8NZdDtk3Dl5AcsJ8wOQKqPy7aaBJjGclHKst97
         xXSw==
X-Gm-Message-State: AOJu0YxRpAdUkQEvhekRQZczvoG397aT8QjNFQKIyrR+pquBKNkM07kf
	zhX0AbFlUjPdDlliLcTzTKRGsRkiUdZIPXSLg1dPj3DkP/B4JiUdljgsJVTPwrGZlK/gduy0HJ5
	js1jJbQqGAsL6yugh3cWcO5sAdZCT/VpuW7kr+dU0ldvGnq7mTJkHcP3tgmw5WbvD44Q2VMTEfp
	ie6owDhK8U5XKIuaUBygbWr+ImHBCFKtTdCdq1I79bzw==
X-Gm-Gg: AY/fxX45j4BcrbOaF+bkA7N4euTo2WxVRmivNZ7h/MH93fHp2RP5n4deQiKMhFhhyMJ
	Gf0QBhLGfrZED13qig+r9SyXUfwxbl6WNJsbL6uLHfM1AQpKYety4wioeYXR4QzjtA0/zIIpqhc
	/3IYWRUIlcy0KCqL0w5Nfjah8/X1XjACWvzgCSs7VXkawbXeNAZoW0ofhBPonz1BCEovLWk/7PT
	WA8pdjsgy1PZzrDL+0oo0ifjcIwt3mTkXKfiiwwgFhALI5kDxVC6cu9UeGOs6wB23kKbbdp+/Ya
	zDuWzvmS1e1ECY73qTrYnZHVcbHCmS4FBjoip7azQSLbwImSPKctc0bz38tgzrTSAo3Omam/ErJ
	mIB8klRvVHeCSNAqJrHIz6C7bG1UymV4OVj0U7A8=
X-Received: by 2002:a05:6402:3491:b0:640:cdad:d2c0 with SMTP id 4fb4d7f45d1cf-64b8eca9dfemr6612114a12.25.1766274710845;
        Sat, 20 Dec 2025 15:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYUydKlx3OfiZqP6RIuOsRd59IOPxvrqZ2BsZ0q17LmekxTZ75LfQVB9EOBSYc1/uBFcpS1w==
X-Received: by 2002:a05:6402:3491:b0:640:cdad:d2c0 with SMTP id 4fb4d7f45d1cf-64b8eca9dfemr6612097a12.25.1766274710368;
        Sat, 20 Dec 2025 15:51:50 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916b82e7sm6279061a12.35.2025.12.20.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:49 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool support handle multi-descriptor frame rx
Date: Sun, 21 Dec 2025 00:51:30 +0100
Message-ID: <20251220235135.1078587-4-pvalerio@redhat.com>
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

Use the page pool allocator for the data buffers and enable skb recycling
support, instead of relying on netdev_alloc_skb allocating the entire skb
during the refill.

The patch also add support for receiving network frames that span multiple
DMA descriptors in the Cadence MACB/GEM Ethernet driver.

The patch removes the requirement that limited frame reception to
a single descriptor (RX_SOF && RX_EOF), also avoiding potential
contiguous multi-page allocation for large frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |   5 +
 drivers/net/ethernet/cadence/macb_main.c | 345 +++++++++++++++--------
 3 files changed, 235 insertions(+), 116 deletions(-)

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
index 3b184e9ac771..45c04157f153 100644
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
@@ -1266,6 +1268,8 @@ struct macb_queue {
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
+	struct page_pool	*page_pool;
+	struct sk_buff		*skb;
 };
 
 struct ethtool_rx_fs_item {
@@ -1289,6 +1293,7 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 	size_t			rx_buffer_size;
+	size_t			rx_headroom;
 
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4e2444b2e95..9e1efc1f56d8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1249,14 +1249,22 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static int gem_rx_refill(struct macb_queue *queue)
+static int gem_total_rx_buffer_size(struct macb *bp)
+{
+	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
+}
+
+static int gem_rx_refill(struct macb_queue *queue, bool napi)
 {
 	unsigned int		entry;
-	struct sk_buff		*skb;
 	dma_addr_t		paddr;
+	void			*data;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	struct page *page;
+	gfp_t gfp_alloc;
 	int err = 0;
+	int offset;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1268,25 +1276,20 @@ static int gem_rx_refill(struct macb_queue *queue)
 		desc = macb_rx_desc(queue, entry);
 
 		if (!queue->rx_buff[entry]) {
-			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
-			if (unlikely(!skb)) {
+			gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
+			page = page_pool_alloc_frag(queue->page_pool, &offset,
+						    gem_total_rx_buffer_size(bp),
+						    gfp_alloc | __GFP_NOWARN);
+			if (!page) {
 				netdev_err(bp->dev,
-					   "Unable to allocate sk_buff\n");
+					   "Unable to allocate page\n");
 				err = -ENOMEM;
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
-			queue->rx_buff[entry] = skb;
+			paddr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM + offset;
+			data = page_address(page) + offset;
+			queue->rx_buff[entry] = data;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1296,20 +1299,6 @@ static int gem_rx_refill(struct macb_queue *queue)
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
@@ -1353,14 +1342,19 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	struct macb *bp = queue->bp;
 	unsigned int		len;
 	unsigned int		entry;
-	struct sk_buff		*skb;
 	struct macb_dma_desc	*desc;
+	int			data_len;
 	int			count = 0;
+	void			*buff_head;
+	struct skb_shared_info	*shinfo;
+	struct page		*page;
+	int			nr_frags;
+
 
 	while (count < budget) {
 		u32 ctrl;
 		dma_addr_t addr;
-		bool rxused;
+		bool rxused, first_frame;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1374,6 +1368,12 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (!rxused)
 			break;
 
+		if (!(bp->caps & MACB_CAPS_RSC))
+			addr += NET_IP_ALIGN;
+
+		dma_sync_single_for_cpu(&bp->pdev->dev,
+					addr, bp->rx_buffer_size,
+					page_pool_get_dma_dir(queue->page_pool));
 		/* Ensure ctrl is at least as up-to-date as rxused */
 		dma_rmb();
 
@@ -1382,58 +1382,118 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_tail++;
 		count++;
 
-		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->dev,
-				   "not whole frame pointed by descriptor\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
-			break;
-		}
-		skb = queue->rx_buff[entry];
-		if (unlikely(!skb)) {
+		buff_head = queue->rx_buff[entry];
+		if (unlikely(!buff_head)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
-		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
+
+		first_frame = ctrl & MACB_BIT(RX_SOF);
 		len = ctrl & bp->rx_frm_len_mask;
 
-		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
+		if (len) {
+			data_len = len;
+			if (!first_frame)
+				data_len -= queue->skb->len;
+		} else {
+			data_len = bp->rx_buffer_size;
+		}
+
+		if (first_frame) {
+			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
+			if (unlikely(!queue->skb)) {
+				netdev_err(bp->dev,
+					   "Unable to allocate sk_buff\n");
+				goto free_frags;
+			}
+
+			/* Properly align Ethernet header.
+			 *
+			 * Hardware can add dummy bytes if asked using the RBOF
+			 * field inside the NCFGR register. That feature isn't
+			 * available if hardware is RSC capable.
+			 *
+			 * We cannot fallback to doing the 2-byte shift before
+			 * DMA mapping because the address field does not allow
+			 * setting the low 2/3 bits.
+			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
+			 */
+			skb_reserve(queue->skb, bp->rx_headroom);
+			skb_mark_for_recycle(queue->skb);
+			skb_put(queue->skb, data_len);
+			queue->skb->protocol = eth_type_trans(queue->skb, bp->dev);
+
+			skb_checksum_none_assert(queue->skb);
+			if (bp->dev->features & NETIF_F_RXCSUM &&
+			    !(bp->dev->flags & IFF_PROMISC) &&
+			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
+				queue->skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			if (!queue->skb) {
+				netdev_err(bp->dev,
+					   "Received non-starting frame while expecting it\n");
+				goto free_frags;
+			}
+
+			shinfo = skb_shinfo(queue->skb);
+			page = virt_to_head_page(buff_head);
+			nr_frags = shinfo->nr_frags;
+
+			if (nr_frags >= ARRAY_SIZE(shinfo->frags))
+				goto free_frags;
 
-		skb_put(skb, len);
-		dma_unmap_single(&bp->pdev->dev, addr,
-				 bp->rx_buffer_size, DMA_FROM_DEVICE);
+			skb_add_rx_frag(queue->skb, nr_frags, page,
+					buff_head - page_address(page) + bp->rx_headroom,
+					data_len, gem_total_rx_buffer_size(bp));
+		}
+
+		/* now everything is ready for receiving packet */
+		queue->rx_buff[entry] = NULL;
 
-		skb->protocol = eth_type_trans(skb, bp->dev);
-		skb_checksum_none_assert(skb);
-		if (bp->dev->features & NETIF_F_RXCSUM &&
-		    !(bp->dev->flags & IFF_PROMISC) &&
-		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
 
-		bp->dev->stats.rx_packets++;
-		queue->stats.rx_packets++;
-		bp->dev->stats.rx_bytes += skb->len;
-		queue->stats.rx_bytes += skb->len;
+		if (ctrl & MACB_BIT(RX_EOF)) {
+			bp->dev->stats.rx_packets++;
+			queue->stats.rx_packets++;
+			bp->dev->stats.rx_bytes += queue->skb->len;
+			queue->stats.rx_bytes += queue->skb->len;
 
-		gem_ptp_do_rxstamp(bp, skb, desc);
+			gem_ptp_do_rxstamp(bp, queue->skb, desc);
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
-		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
-			    skb->len, skb->csum);
-		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb_mac_header(skb), 16, true);
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb->data, 32, true);
+			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
+				    queue->skb->len, queue->skb->csum);
+			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
+				       skb_mac_header(queue->skb), 16, true);
+			print_hex_dump(KERN_DEBUG, "buff_head: ", DUMP_PREFIX_ADDRESS, 16, 1,
+				       queue->skb->buff_head, 32, true);
 #endif
 
-		napi_gro_receive(napi, skb);
+			napi_gro_receive(napi, queue->skb);
+			queue->skb = NULL;
+		}
+
+		continue;
+
+free_frags:
+		if (queue->skb) {
+			dev_kfree_skb(queue->skb);
+			queue->skb = NULL;
+		} else {
+			page_pool_put_full_page(queue->page_pool,
+						virt_to_head_page(buff_head),
+						false);
+		}
+
+		bp->dev->stats.rx_dropped++;
+		queue->stats.rx_dropped++;
+		queue->rx_buff[entry] = NULL;
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(queue, true);
 
 	return count;
 }
@@ -2367,12 +2427,25 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 
-static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
+static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
+	int overhead;
+	size_t size;
+
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = size;
+		size = mtu + ETH_HLEN + ETH_FCS_LEN;
+		if (!(bp->caps & MACB_CAPS_RSC))
+			size += NET_IP_ALIGN;
+
+		bp->rx_buffer_size = SKB_DATA_ALIGN(size);
+		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
+			overhead = bp->rx_headroom +
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+			bp->rx_buffer_size = rounddown(PAGE_SIZE - overhead,
+						       RX_BUFFER_MULTIPLE);
+		}
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->dev,
@@ -2389,11 +2462,9 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 
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
@@ -2401,22 +2472,20 @@ static void gem_free_rx_buffers(struct macb *bp)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_buff[i];
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
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		page_pool_destroy(queue->page_pool);
+		queue->page_pool = NULL;
 	}
 }
 
@@ -2478,13 +2547,12 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = bp->rx_ring_size * sizeof(struct sk_buff *);
+		size = bp->rx_ring_size * sizeof(*queue->rx_buff);
 		queue->rx_buff = kzalloc(size, GFP_KERNEL);
 		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
-			netdev_dbg(bp->dev,
-				   "Allocated %d RX buff entries at %p\n",
+			netdev_dbg(bp->dev, "Allocated %d RX buff entries at %p\n",
 				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
@@ -2572,6 +2640,33 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static int gem_create_page_pool(struct macb_queue *queue)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = queue->bp->rx_ring_size,
+		.nid = NUMA_NO_NODE,
+		.dma_dir = DMA_FROM_DEVICE,
+		.dev = &queue->bp->pdev->dev,
+		.napi = &queue->napi_rx,
+		.max_len = PAGE_SIZE,
+	};
+	struct page_pool *pool;
+	int err = 0;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool)) {
+		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
+		err = PTR_ERR(pool);
+		pool = NULL;
+	}
+
+	queue->page_pool = pool;
+
+	return err;
+}
+
 static void macb_init_tieoff(struct macb *bp)
 {
 	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
@@ -2607,12 +2702,24 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
+		/* This is a hard failure, so the best we can do is try the
+		 * next queue in case of HRESP error.
+		 */
+		err = gem_create_page_pool(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+
+			continue;
+		}
+
 		/* We get called in two cases:
 		 *  - open: we can propagate alloc errors (so fail early),
 		 *  - HRESP error: cannot propagate, we attempt to reinit
 		 *    all queues in case of failure.
 		 */
-		err = gem_rx_refill(queue);
+		err = gem_rx_refill(queue, false);
 		if (err) {
 			last_err = err;
 			if (fail_early)
@@ -2756,39 +2863,40 @@ static void macb_configure_dma(struct macb *bp)
 	unsigned int q;
 	u32 dmacfg;
 
-	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
-	if (macb_is_gem(bp)) {
-		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			if (q)
-				queue_writel(queue, RBQS, buffer_size);
-			else
-				dmacfg |= GEM_BF(RXBS, buffer_size);
-		}
-		if (bp->dma_burst_length)
-			dmacfg = GEM_BFINS(FBLDO, bp->dma_burst_length, dmacfg);
-		dmacfg |= GEM_BIT(TXPBMS) | GEM_BF(RXBMS, -1L);
-		dmacfg &= ~GEM_BIT(ENDIA_PKT);
+	if (!macb_is_gem((bp)))
+		return;
 
-		if (bp->native_io)
-			dmacfg &= ~GEM_BIT(ENDIA_DESC);
+	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
+	dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		if (q)
+			queue_writel(queue, RBQS, buffer_size);
 		else
-			dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
+			dmacfg |= GEM_BF(RXBS, buffer_size);
+	}
+	if (bp->dma_burst_length)
+		dmacfg = GEM_BFINS(FBLDO, bp->dma_burst_length, dmacfg);
+	dmacfg |= GEM_BIT(TXPBMS) | GEM_BF(RXBMS, -1L);
+	dmacfg &= ~GEM_BIT(ENDIA_PKT);
 
-		if (bp->dev->features & NETIF_F_HW_CSUM)
-			dmacfg |= GEM_BIT(TXCOEN);
-		else
-			dmacfg &= ~GEM_BIT(TXCOEN);
+	if (bp->native_io)
+		dmacfg &= ~GEM_BIT(ENDIA_DESC);
+	else
+		dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
 
-		dmacfg &= ~GEM_BIT(ADDR64);
-		if (macb_dma64(bp))
-			dmacfg |= GEM_BIT(ADDR64);
-		if (macb_dma_ptp(bp))
-			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
-		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
-			   dmacfg);
-		gem_writel(bp, DMACFG, dmacfg);
-	}
+	if (bp->dev->features & NETIF_F_HW_CSUM)
+		dmacfg |= GEM_BIT(TXCOEN);
+	else
+		dmacfg &= ~GEM_BIT(TXCOEN);
+
+	dmacfg &= ~GEM_BIT(ADDR64);
+	if (macb_dma64(bp))
+		dmacfg |= GEM_BIT(ADDR64);
+	if (macb_dma_ptp(bp))
+		dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
+	netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
+		   dmacfg);
+	gem_writel(bp, DMACFG, dmacfg);
 }
 
 static void macb_init_hw(struct macb *bp)
@@ -2951,7 +3059,6 @@ static void macb_set_rx_mode(struct net_device *dev)
 
 static int macb_open(struct net_device *dev)
 {
-	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int q;
@@ -2964,7 +3071,7 @@ static int macb_open(struct net_device *dev)
 		return err;
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	macb_init_rx_buffer_size(bp, dev->mtu);
 
 	err = macb_alloc_consistent(bp);
 	if (err) {
@@ -5623,6 +5730,12 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
+	if (macb_is_gem(bp)) {
+		bp->rx_headroom = XDP_PACKET_HEADROOM;
+		if (!(bp->caps & MACB_CAPS_RSC))
+			bp->rx_headroom += NET_IP_ALIGN;
+	}
+
 	netif_carrier_off(dev);
 
 	err = register_netdev(dev);
-- 
2.52.0


