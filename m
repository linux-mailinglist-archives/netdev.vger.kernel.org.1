Return-Path: <netdev+bounces-240002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADCC6F101
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 449582EBEC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFA364E93;
	Wed, 19 Nov 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVhgZA0l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k7rBHhKl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E504364048
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560457; cv=none; b=SqhwtKZFOgFCRbvywNufJcZda49A2Tr8x4DQ7EFRiAhvPgGqm+11nRuzTNlWRrqxDfsiVY5KVk4FEDVZirSodVA0dJuAPVxOl5LWn91vnU6HXEq3t4/iwM0+KXK6TDpk07aLw2XF4yg4V6xLvJytzo+Y+IHL0xTSEmYBioEkFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560457; c=relaxed/simple;
	bh=ZXiMzvpoKxQ1rBst8io3EO8PDwzIJcAbdg0DppEaOQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBRsj2XLzYx2gN7c/iwpCKDU2PuySsGaiqR0OXA38/Jh783sWBwAiVD9P8wHnkl/Z91d6u/Rz3B/N6l02Ld8+f7v2ds2nH+YdvCPLLNCWneCiFilTWm7KwQN2J/CDanVAOwrkV47OMAECcFNGYJ9KkuXwq4VZ9YdOWVUfAr1IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVhgZA0l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k7rBHhKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vHvazvYoudwMNHQL2ajUvycmPnhEHsMGrv9wkEph3U=;
	b=PVhgZA0lFxcsX2GnOi49vaqW4kZbXHbHaQ6JA8Z4ObAlGWQ4EUT5qIYTUMfaqwhbuHr+v1
	5W8MNiFf3njFBMSs/LIjbLYjGWeH+eewObipq/pjBuC+Dy6PSqql99A1nUrJcSNEhl9yxs
	Fve0jXDpMEXTC5aFwttqwYC55Z2ZfF4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kvnOsEfbO2q4y_hYUqnNGA-1; Wed, 19 Nov 2025 08:54:13 -0500
X-MC-Unique: kvnOsEfbO2q4y_hYUqnNGA-1
X-Mimecast-MFC-AGG-ID: kvnOsEfbO2q4y_hYUqnNGA_1763560452
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106720618so74052965e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560451; x=1764165251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vHvazvYoudwMNHQL2ajUvycmPnhEHsMGrv9wkEph3U=;
        b=k7rBHhKl7ZAgOWc53K/sOKZu54KgnrWG71zvBrrkhDVa+jZVuY3/X0g64Vb+qV+Eak
         3h+RRyN5Fup5lI6dI8vCPWZ8UfYyZhk3pu1CMZvdhaD+Ai5lLGLDaeRiO1JvSwQOBdYS
         Xt7McqBP40fc9tJkfTcl2rKPCIobmnUr8m0vaQoucBcz1zxG5TePQszfomp1kZ9bjvPA
         EienmiMMjZHqTHCWSU0UW03uzxHC3BfrkVPbB8qfGBG68KFsjXA9WWepWWiVD8psNWhJ
         3qr+QJn90kfaUuhS0JoeYZYRc9RLIhiIoAYuM8/+6mPESEsPawAxcSQHCdYs5+TC9/L6
         XuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560451; x=1764165251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vHvazvYoudwMNHQL2ajUvycmPnhEHsMGrv9wkEph3U=;
        b=xOuPtouHuVko732me2V6AlqXY6sNvjMY4zx6ozxC+SJCohu97eruc6tDAkNGXJmnYg
         ssCtY3NLcYEFqzKM/gUUtKT1ZiPyU7ui8AaOgoYfbrGDuS03ystJVPuFZXXfQ+Ms8igO
         eURwQ4pRBHz0JHunn4oW8AmIjvYETAJuI7k8vqmqP+vNaOCTKyCTikmIBeRunwdbEzqJ
         QvuTLv6IIJr4sR65vRYcGOJycwJvcBjzVi1JAsstOjOJAQ++xDJDv41PgsLI5c6zva7I
         nJP6jDju4ooVHQZUXcQFUe9IFiEZxbAy1oQbQRzPGLqSSjmHurtsDjFlkh38InvZcEGU
         p2EA==
X-Gm-Message-State: AOJu0YxWSgVSXxpsZUQE20+7RTDIfbZP7L6ytQ2IAvf2q1z431fX71Yf
	USnlucLDG7pf0uDL0ElPvH/55b0yqcrPe4fy3OcKDWjn1PA47w7Z4f9+4Jfrt5NwzeXWPEFQKNA
	3YQNFou/hNILxOY+7/m+EDAg7pqbyADkSacsP4kwNF7KCWkja0HPHNS3YMJ2z+rPD+zPhH1FbmQ
	Xd28CoGTSIAa57hUnnLRPRbNgf+0TZ/hYDyHFNFdkyV45h
X-Gm-Gg: ASbGncuI417vheI7win4C4oHksEjSYCZAMLZ//Do7tZsKRTf6gz+rUGuPXsSzZT7ahr
	brNRSjwMkJX3AXBo1wiJPMaflR7cKPCXbwRXN38PGKB5BpQDbPuWMZF5mkNiPv+Ut4Tb+8wA12j
	wTbHFLdJfukJUH+T1fEjK2rLXQMwNHeF3MEV0AcjEexfMQf8/ZpwEIWQ5svjdeqV5cBDfSNF0Ec
	WBHq6D95nkbXJWN6MlrFOqn7LusHGuTLMQ4U5XE2BswKefZ+vRRO1WcY9BfJ7nZnxsrGU8Nw6Er
	yJlWLXOHbf0JfnxFsoPi+Zgfj/4t/RYLh4MXkvw0dLbOAq3TUBy8/tzU3BrWPfapz+2FEPlRC1s
	WkkWCwR1YIndcNWQl0fCpzVlmib1+WrQK7GhoLecW5PkXJ1Vg+w==
X-Received: by 2002:a05:600c:3587:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4778fe55174mr174756555e9.6.1763560450852;
        Wed, 19 Nov 2025 05:54:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrmYbFOmNAA3s1WPDwDC+6Wd/RYp/+7vCCTWMBbBO395htYbLOADbtvOtbI6edFTKKhULIoA==
X-Received: by 2002:a05:600c:3587:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4778fe55174mr174756075e9.6.1763560450242;
        Wed, 19 Nov 2025 05:54:10 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de4765sm40209345e9.10.2025.11.19.05.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:09 -0800 (PST)
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
Subject: [PATCH RFC net-next 2/6] cadence: macb/gem: handle multi-descriptor frame reception
Date: Wed, 19 Nov 2025 14:53:26 +0100
Message-ID: <20251119135330.551835-3-pvalerio@redhat.com>
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

Add support for receiving network frames that span multiple DMA
descriptors in the Cadence MACB/GEM Ethernet driver.

The patch removes the requirement that limited frame reception to
a single descriptor (RX_SOF && RX_EOF), also avoiding potential
contiguous multi-page allocation for large frames. It also uses
page pool fragments allocation instead of full page for saving
memory.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   4 +-
 drivers/net/ethernet/cadence/macb_main.c | 180 ++++++++++++++---------
 2 files changed, 111 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index dcf768bd1bc1..e2f397b7a27f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -960,8 +960,7 @@ struct macb_dma_desc_ptp {
 #define PPM_FRACTION	16
 
 /* The buf includes headroom compatible with both skb and xdpf */
-#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
-#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADROOM)
+#define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
 
 /* struct macb_tx_skb - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
@@ -1273,6 +1272,7 @@ struct macb_queue {
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
+	struct sk_buff		*skb;
 };
 
 struct ethtool_rx_fs_item {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 985c81913ba6..be0c8e101639 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1250,21 +1250,25 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void *gem_page_pool_get_buff(struct page_pool *pool,
+static void *gem_page_pool_get_buff(struct  macb_queue *queue,
 				    dma_addr_t *dma_addr, gfp_t gfp_mask)
 {
+	struct macb *bp = queue->bp;
 	struct page *page;
+	int offset;
 
-	if (!pool)
+	if (!queue->page_pool)
 		return NULL;
 
-	page = page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
+	page = page_pool_alloc_frag(queue->page_pool, &offset,
+				    bp->rx_buffer_size,
+				    gfp_mask | __GFP_NOWARN);
 	if (!page)
 		return NULL;
 
-	*dma_addr = page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
+	*dma_addr = page_pool_get_dma_addr(page) + MACB_PP_HEADROOM + offset;
 
-	return page_address(page);
+	return page_address(page) + offset;
 }
 
 static void gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1286,7 +1290,7 @@ static void gem_rx_refill(struct macb_queue *queue, bool napi)
 
 		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			data = gem_page_pool_get_buff(queue->page_pool, &paddr,
+			data = gem_page_pool_get_buff(queue, &paddr,
 						      napi ? GFP_ATOMIC : GFP_KERNEL);
 			if (unlikely(!data)) {
 				netdev_err(bp->dev,
@@ -1344,20 +1348,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
-	int			buffer_size;
 	unsigned int		len;
 	unsigned int		entry;
 	void			*data;
-	struct sk_buff		*skb;
 	struct macb_dma_desc	*desc;
+	int			data_len;
 	int			count = 0;
 
-	buffer_size = DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZE;
-
 	while (count < budget) {
 		u32 ctrl;
 		dma_addr_t addr;
-		bool rxused;
+		bool rxused, first_frame;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1368,6 +1369,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
 		addr = macb_get_addr(bp, desc);
 
+		dma_sync_single_for_cpu(&bp->pdev->dev,
+					addr, bp->rx_buffer_size - bp->rx_offset,
+					page_pool_get_dma_dir(queue->page_pool));
 		if (!rxused)
 			break;
 
@@ -1379,13 +1383,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_tail++;
 		count++;
 
-		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->dev,
-				   "not whole frame pointed by descriptor\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
-			break;
-		}
 		data = queue->rx_buff[entry];
 		if (unlikely(!data)) {
 			netdev_err(bp->dev,
@@ -1395,64 +1392,102 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 
-		skb = napi_build_skb(data, buffer_size);
-		if (unlikely(!skb)) {
-			netdev_err(bp->dev,
-				   "Unable to allocate sk_buff\n");
-			page_pool_put_full_page(queue->page_pool,
-						virt_to_head_page(data),
-						false);
-			break;
+		first_frame = ctrl & MACB_BIT(RX_SOF);
+		len = ctrl & bp->rx_frm_len_mask;
+
+		if (len) {
+			data_len = len;
+			if (!first_frame)
+				data_len -= queue->skb->len;
+		} else {
+			data_len = SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
 		}
 
-		/* Properly align Ethernet header.
-		 *
-		 * Hardware can add dummy bytes if asked using the RBOF
-		 * field inside the NCFGR register. That feature isn't
-		 * available if hardware is RSC capable.
-		 *
-		 * We cannot fallback to doing the 2-byte shift before
-		 * DMA mapping because the address field does not allow
-		 * setting the low 2/3 bits.
-		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
-		 */
-		skb_reserve(skb, bp->rx_offset);
-		skb_mark_for_recycle(skb);
+		if (first_frame) {
+			queue->skb = napi_build_skb(data, bp->rx_buffer_size);
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
+			skb_reserve(queue->skb, bp->rx_offset);
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
+			struct skb_shared_info *shinfo = skb_shinfo(queue->skb);
+			struct page *page = virt_to_head_page(data);
+			int nr_frags = shinfo->nr_frags;
+
+			if (nr_frags >= ARRAY_SIZE(shinfo->frags))
+				goto free_frags;
+
+			skb_add_rx_frag(queue->skb, nr_frags, page,
+					data - page_address(page) + bp->rx_offset,
+					data_len, bp->rx_buffer_size);
+		}
 
 		/* now everything is ready for receiving packet */
 		queue->rx_buff[entry] = NULL;
-		len = ctrl & bp->rx_frm_len_mask;
-
-		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
 
-		dma_sync_single_for_cpu(&bp->pdev->dev,
-					addr, len,
-					page_pool_get_dma_dir(queue->page_pool));
-		skb_put(skb, len);
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
+			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
+				       queue->skb->data, 32, true);
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
+						virt_to_head_page(data),
+						false);
+		}
 	}
 
 	gem_rx_refill(queue, true);
@@ -2394,7 +2429,10 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = size;
+		bp->rx_buffer_size = size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+			+ MACB_PP_HEADROOM;
+		if (bp->rx_buffer_size > PAGE_SIZE)
+			bp->rx_buffer_size = PAGE_SIZE;
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->dev,
@@ -2589,18 +2627,15 @@ static int macb_alloc_consistent(struct macb *bp)
 
 static void gem_create_page_pool(struct macb_queue *queue)
 {
-	unsigned int num_pages = DIV_ROUND_UP(queue->bp->rx_buffer_size, PAGE_SIZE);
-	struct macb *bp = queue->bp;
 	struct page_pool_params pp_params = {
-		.order = order_base_2(num_pages),
+		.order = 0,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
 		.dma_dir = DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.napi = &queue->napi_rx,
-		.offset = bp->rx_offset,
-		.max_len = MACB_PP_MAX_BUF_SIZE(num_pages),
+		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
 
@@ -2784,8 +2819,9 @@ static void macb_configure_dma(struct macb *bp)
 	unsigned int q;
 	u32 dmacfg;
 
-	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
 	if (macb_is_gem(bp)) {
+		buffer_size = SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
+		buffer_size /= RX_BUFFER_MULTIPLE;
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			if (q)
@@ -2816,6 +2852,8 @@ static void macb_configure_dma(struct macb *bp)
 		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
 		gem_writel(bp, DMACFG, dmacfg);
+	} else {
+		buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
 	}
 }
 
-- 
2.51.1


