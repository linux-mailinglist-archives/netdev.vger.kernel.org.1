Return-Path: <netdev+bounces-245624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD2CD38F3
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2853003162
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8212F7455;
	Sat, 20 Dec 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byvYImQH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWVb6TFp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C226738B
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274730; cv=none; b=qtu4QfnK5X8DRWb61sR57zSNQr/QEu1H6HTR3Zlv8MErYUFmS/HlsP0F6KVu2TwcbSNL6k1XeIxR5GjAKxoyQ4tlOTL7KCOkphRawZms8jJrGftM5FJ//DzoiJbTXFfyEIjQE9oQp1hQsQwKaL6zf7XCcedxNNf2tPeqsjtxo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274730; c=relaxed/simple;
	bh=7+0EQJjEgWrHCYu9gibUrYPwvQpqpclrQRRRF3IEuDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcEUUYtgu3ptEQ/jwYDGeigCnZhg/n6Qj1a1dbXze+M12NU7iIdhXNdGtA7ObMi3OywSoPMlkFl82Ri28l7aCkbjJSdKlyugLPuMWAbw1/qZSUBsp55sItj9Wl94NtC3GAp70eB6SyjVoVNpu9YFAZ8OmZ7Xlb7aA2jzZdj6rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byvYImQH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWVb6TFp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sAKssJlq9imN8MkCGFrIystN7ZZurD3aD13UO9A2Gk=;
	b=byvYImQH3SZSIrA5G4LyhoqWhk1L2ajjPhVTOe42Du6cnbsLoWp7HmiApNc856bnullgZ9
	wMb0NYgOmaoRWj5Wpgi4uvHFKXZC8t5uSkocL+23BL9fP+7XP+zrXRNw6lGSyXTJYRNJ5k
	+UmyhQf4k1iE8Rm8+avWqNez8p6SBxk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-sAa9ZlYfOmq8CGgqO02t-g-1; Sat, 20 Dec 2025 18:52:03 -0500
X-MC-Unique: sAa9ZlYfOmq8CGgqO02t-g-1
X-Mimecast-MFC-AGG-ID: sAa9ZlYfOmq8CGgqO02t-g_1766274722
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64b4b64011dso4023879a12.2
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274722; x=1766879522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sAKssJlq9imN8MkCGFrIystN7ZZurD3aD13UO9A2Gk=;
        b=aWVb6TFp0JYlK+IpfX2lfA49NIhtlx7AuJHkYaVRPWZ+R2gl2FWHl599yjaPxYA/KV
         /irjipACOrZU6+hsPRc/5fOSKjrRHVGnZd9U6jJBoDafLjqmlP4jOz4rdlKykZA+24GR
         Fhf63KkFcji6OsrY6qtn2qh/yUMA2iwXNKVR9WPVjij75lFrp0eK+VDqZr6CyNTHPrIU
         7yCm8WHGXiwT3fnSxGF7BL1BVgJ0G4AtKRMLf4qef+7DfJ9hYg/hvWXSH/QgQ4MSEdjQ
         72noMBTe+NlGmt6ArKSRainwXCKk049aSMyTP8ooY6oxbaPFcdI/zNdDL5Vif0MtgryI
         S6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274722; x=1766879522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sAKssJlq9imN8MkCGFrIystN7ZZurD3aD13UO9A2Gk=;
        b=w4wtVHZidT0U3qxkKcDhAU+dLQM+HbIKX1es1yGmW3FsA/w/41y2R66IBMGIZ0EpQ5
         aivYwJTqX1OMVeS3RoDSba0ENeKVXiJPc3XXjJ+dEZMXvDA2b3RILijOr/FF/vyctSVR
         Lolm9JfNibBQWY7nJPh2WgBNb4jiJX1yzaHRsUU/NSSUCk8MmIgzjCpK26M9mmsVSwLl
         Uq2tniJE8VPGCfy6rbpvNbWWpcwAEgJCFSXp9GFa4SYwopEgoEsgFKXSHG5y6+CV3CSA
         jCemYmV8tBT/+JqpZ0pKIvBHrVHN95pQQRo0X18LLjOTNeZiHoPf2g7+owmLNh/GQDgz
         tllQ==
X-Gm-Message-State: AOJu0YzvNaph2E27FQct+B61zQ9D8QaLj/NDHluxdJ/ubM61/X2Ypb77
	lz4DLYHkwWUq8vmhHpa8ExbWpvmT+4n4LBhPDGErxzAjYjKX/wLX7eXaVknTjPdN/K+h+7r0gdN
	+PIQuomq/H0l3rGB5G+y56WQ7InLpDee/hEvc2GUdzCoOUg4pEf24Z0ZeUO2U60JBskbE5R0IFp
	9ua0j7bUBknmUMFA7POwWtoPntu7qreyxUNUwonegZkg==
X-Gm-Gg: AY/fxX6UyIwiD6T8W6U8qp7gyaSb0jOpyzBFoHBtCwdWobYigeDCSGRNU6vUGdyQNKF
	th3eDxIIscX9emQZJGd+erMt3l/KfShOQtBC4VqjCNisqk3E9Mv+n5DwwwZ7fpKAmuW6CDQ6SgI
	JKVJMleOfseVQqVLeNyrsWztbY2FmiKhpKUf42Einys8bv+7gn3hyMtZ/9jolVaYf0WlUfYiq/t
	y1kA6PvGXaIpDefHGCXfAA/8uAWCQ1pJ/h7ZSTr3v5gRDiI94WGlA7eTjErEH31jlGWMgd04ppT
	dV/wcjNt/OJ5jmXY8a0qujCWtMguRxcT+itDqq3TDLVzmZjEcregDtzO00Ggvjb/U8d4z56LyCK
	U3DMGij4rswXpUhHEfnKRrIZLkeSg5BQeRrXYpLk=
X-Received: by 2002:a05:6402:3596:b0:64d:2889:cf42 with SMTP id 4fb4d7f45d1cf-64d2889d183mr1367704a12.2.1766274721729;
        Sat, 20 Dec 2025 15:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEihQrukAVdebD+7Q9OztoEfus2h8CTfE9eUUvOVqD0Y6Op8C2S+H4E35z+G1hNt7DNy82O2A==
X-Received: by 2002:a05:6402:3596:b0:64d:2889:cf42 with SMTP id 4fb4d7f45d1cf-64d2889d183mr1367677a12.2.1766274721257;
        Sat, 20 Dec 2025 15:52:01 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494cd7sm5916350a12.16.2025.12.20.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:59 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 8/8] cadence: macb: introduce xmit support
Date: Sun, 21 Dec 2025 00:51:35 +0100
Message-ID: <20251220235135.1078587-9-pvalerio@redhat.com>
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

Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
redirection, and update macb_tx_unmap() to handle both skbs and xdp
frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
to process XDP_TX verdicts.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
 1 file changed, 158 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cd29a80d1dbb..d8abfa45e22d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -969,6 +969,17 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
+static void release_buff(void *buff, enum macb_tx_buff_type type, int budget)
+{
+	if (type == MACB_TYPE_SKB) {
+		napi_consume_skb(buff, budget);
+	} else if (type == MACB_TYPE_XDP_TX) {
+		xdp_return_frame_rx_napi(buff);
+	} else {
+		xdp_return_frame(buff);
+	}
+}
+
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 			  int budget)
 {
@@ -983,7 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		napi_consume_skb(tx_buff->ptr, budget);
+		release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1071,6 +1082,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			goto unmap;
+
 		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1108,6 +1123,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1186,6 +1202,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
+		void			*data = NULL;
 		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
@@ -1208,11 +1225,16 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
 
-			if (tx_buff->type == MACB_TYPE_SKB)
-				skb = tx_buff->ptr;
+			if (tx_buff->type != MACB_TYPE_SKB) {
+				data = tx_buff->ptr;
+				goto unmap;
+			}
 
 			/* First, update TX stats if needed */
-			if (skb) {
+			if (tx_buff->type == MACB_TYPE_SKB && tx_buff->ptr) {
+				data = tx_buff->ptr;
+				skb = tx_buff->ptr;
+
 				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
@@ -1228,6 +1250,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				bytes += skb->len;
 			}
 
+unmap:
 			/* Now we can safely release resources */
 			macb_tx_unmap(bp, tx_buff, budget);
 
@@ -1235,7 +1258,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			 * WARNING: at this point skb has been freed by
 			 * macb_tx_unmap().
 			 */
-			if (skb)
+			if (data)
 				break;
 		}
 	}
@@ -1350,10 +1373,128 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
+				 struct net_device *dev, bool dma_map,
+				 dma_addr_t addr)
+{
+	enum macb_tx_buff_type buff_type;
+	struct macb_tx_buff *tx_buff;
+	int cpu = smp_processor_id();
+	struct macb_dma_desc *desc;
+	struct macb_queue *queue;
+	unsigned int next_head;
+	unsigned long flags;
+	dma_addr_t mapping;
+	u16 queue_index;
+	int err = 0;
+	u32 ctrl;
+
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
+	buff_type = dma_map ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+
+	/* This is a hard error, log it. */
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1) {
+		netif_stop_subqueue(dev, queue_index);
+		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
+			   queue->tx_head, queue->tx_tail);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	if (dma_map) {
+		mapping = dma_map_single(&bp->pdev->dev,
+					 xdpf->data,
+					 xdpf->len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+	} else {
+		mapping = addr;
+		dma_sync_single_for_device(&bp->pdev->dev, mapping,
+					   xdpf->len, DMA_BIDIRECTIONAL);
+	}
+
+	next_head = queue->tx_head + 1;
+
+	ctrl = MACB_BIT(TX_USED);
+	desc = macb_tx_desc(queue, next_head);
+	desc->ctrl = ctrl;
+
+	desc = macb_tx_desc(queue, queue->tx_head);
+	tx_buff = macb_tx_buff(queue, queue->tx_head);
+	tx_buff->ptr = xdpf;
+	tx_buff->type = buff_type;
+	tx_buff->mapping = mapping;
+	tx_buff->size = xdpf->len;
+	tx_buff->mapped_as_page = false;
+
+	ctrl = (u32)tx_buff->size;
+	ctrl |= MACB_BIT(TX_LAST);
+
+	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) == (bp->tx_ring_size - 1)))
+		ctrl |= MACB_BIT(TX_WRAP);
+
+	/* Set TX buffer descriptor */
+	macb_set_addr(bp, desc, tx_buff->mapping);
+	/* desc->addr must be visible to hardware before clearing
+	 * 'TX_USED' bit in desc->ctrl.
+	 */
+	wmb();
+	desc->ctrl = ctrl;
+	queue->tx_head = next_head;
+
+	/* Make newly initialized descriptor visible to hardware */
+	wmb();
+
+	spin_lock(&bp->lock);
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	spin_unlock(&bp->lock);
+
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
+		netif_stop_subqueue(dev, queue_index);
+
+unlock:
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
+
+	if (err)
+		release_buff(xdpf, buff_type, 0);
+
+	return err;
+}
+
+static int
+gem_xdp_xmit(struct net_device *dev, int num_frame,
+	     struct xdp_frame **frames, u32 flags)
+{
+	struct macb *bp = netdev_priv(dev);
+	u32 xmitted = 0;
+	int i;
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < num_frame; i++) {
+		if (macb_xdp_submit_frame(bp, frames[i], dev, true, 0))
+			break;
+
+		xmitted++;
+	}
+
+	return xmitted;
+}
+
 static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
-		       unsigned int len)
+		       unsigned int len, dma_addr_t addr)
 {
 	struct net_device *dev;
+	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
 	struct xdp_buff xdp;
 
@@ -1380,6 +1521,13 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 			break;
 		}
 		goto out;
+	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+
+		if (!xdpf || macb_xdp_submit_frame(queue->bp, xdpf, dev, false,
+						   addr))
+			act = XDP_DROP;
+		goto out;
 	default:
 		bpf_warn_invalid_xdp_action(dev, prog, act);
 		fallthrough;
@@ -1469,7 +1617,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF)))
 			goto skip_xdp;
 
-		ret = gem_xdp_run(queue, buff_head, len);
+		ret = gem_xdp_run(queue, buff_head, len, addr);
 		if (ret == XDP_REDIRECT)
 			xdp_flush = true;
 
@@ -4582,6 +4730,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5888,7 +6037,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_headroom += NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.52.0


