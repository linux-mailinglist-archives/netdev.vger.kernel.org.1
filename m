Return-Path: <netdev+bounces-250338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F83D29032
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17CF93014D3C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7732D7F8;
	Thu, 15 Jan 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaKMPIlE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYM/XOTn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F80238D27
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515986; cv=none; b=eyRpTEon6/wO73sOwtbOds4TLMJr7DAU4KqTB7hB7w08tVCrsg21EvC+JmlgE6aE85hipm5f8fdL1fOxYwYzlGYtRA/XlZsCEJCL8637jPCgfEtdUcb4GpdBEws7sSkVlJdATkuV/RtyK1bufJqIqf+pO1Pgi2qWB6vulDQ/wGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515986; c=relaxed/simple;
	bh=RkWdRpZgKWsKZ8N0XRG3o87801o8Pn7z8ot6xoeRqgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYCTjzsUiIHIllgelyWN6WYlQlSLg24hkZK2bQhXGuLkZdE8DiEeWt7m2sJfU9NW0JXhcBD0KejhPdVNpRxEXsNKPMzqzPYO7spm1sPGYeengyU7OO7RWOS1HVDfuBicPAD91wvacWEVETuUlkJK+G+xfTsAexC7N3N0DwzVsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaKMPIlE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYM/XOTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhasQuPLAaXUShdUP5hBmDEHuyViJfUXdpYu81w9UrE=;
	b=VaKMPIlEaQKXFokKvaBcbokbVe/Te84qosvW2KTZKTf4OdzP4sEcImGoJIFCuQ7at+SOwb
	zkWHxd7/7UooV+4Yy4RziqVWvLpoyiL3u7rDf+3orQ0R4NZbH9tu2yJVkHVRlFdsaCXWJr
	SqtVmj4wjeagK9lUZR4TgYHpE3oaNno=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-X5pc3YZiMOehOudbzNSP9w-1; Thu, 15 Jan 2026 17:26:22 -0500
X-MC-Unique: X5pc3YZiMOehOudbzNSP9w-1
X-Mimecast-MFC-AGG-ID: X5pc3YZiMOehOudbzNSP9w_1768515981
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso7860435e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515980; x=1769120780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhasQuPLAaXUShdUP5hBmDEHuyViJfUXdpYu81w9UrE=;
        b=QYM/XOTnJbQjqpCuc2LpxQppOqpSceHUPi8xug2bGv8Ep+d7b36IkshSddJ9a6INLQ
         mEdf7UsQV0EJhuYEqrqBBj4sb/FVVeJRt8AjGlBpVoXS5Lb4tirQxHjbSLGIUuSkyHfI
         UiUB++HVtIkxpS+QOncrdZg2VVPz3FRdvZ5eEk2wTBjBn/ypIa5zWG0hT7yIcuckDKLV
         BWvghp2IWzz9F8rStRseDmaYdI3ktrEveZ4/XYwt5LiBS5iWzI3WeNnc4R7hoo1AP/uD
         Lh2VOgbl7cgZy4E+YhGmq73ykNYWc61vJ2U9no8ct8YHeoevu59h96tpkhfV9sNKpXBH
         lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515980; x=1769120780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhasQuPLAaXUShdUP5hBmDEHuyViJfUXdpYu81w9UrE=;
        b=UnF5QT2HbJTfz/gSwpg0l+AKOTP5kxhTptHR8TpKEMoWyOdbFUetJqYodQGhxjVJom
         Rjh896C+SR0nHQZww+INWt2cm1EmXD08zL9ZEZ8xZRmApEHpCp8HStS3hKIXBnu9PJ1N
         hNwrloyzYRGp8oJbc+94inumDVuaA9wFKUziljw5snAr3CfWTDEfxXVk5uECOImvCsMo
         RRMFYjGuwZvxqc6io0hE9qhdQc/biozjT1xNdQBLbqFNmvuqj1FG1gke0MSUEFTKFNuC
         /DQAfNp9v4HGTyqndf2zzyCHS7kokDi49vKakU6+eBln/Af3/pbmQPOaGpkR5oVXaJw7
         2SgQ==
X-Gm-Message-State: AOJu0YzbYCJvg7h7uBmDTLjErdMIC/D4dMP0N4M+P41DA9jaVKQglY7D
	6ttrZvtGgdnZh9622BQaPMtpnssLumqyNopHY5q173zi6O6+nvsTw+wKOKrEKVGCi1em/nGm/eJ
	sE58ZZETo1rlX+2WpcL3PogTopDrgCP/Q7gLNOz3V1jCEm3mFTDduIZaAv8fJai+gMKIC7cqY7H
	3PhJZnAjqTzwStgucIXwALcfLhxGs/68ADiI5nCkGABA==
X-Gm-Gg: AY/fxX7+RuPbrIIfOYPUu6yxXwNq3bZId2rS2uWGdYN6NQm+glIvmVAum4ZmBr+FlMr
	iZMDi5GAsoTRzWZ9ZgD0kvWyRNxsLflgRRr+LWKcaqi2uVTZNPzD9huq8ru/fgdPBDB4TinDuvm
	JixKO7v2GymqtxMSnsVtadu+PSacqC1te54k5VXoSCU9XObd5fJhK/XlqxsL6wtG6mhVw2+7wNC
	VdbAFE2sszcBjYDkOYwxsy70yXoX4WfcpHnwLbi5N8pKEfGYUWrzBCS31OefK/DxUmPi+77HN+v
	cL4rktTj8BBofVhJ4LTdIgC+abvxFh3Qm2BsP193T6u7sCcbOjscUByVuGS23zM/pl4QYnsr26g
	XQJPgR/F9PZB8CIgG2WS6jfjKoLcHfNliPRYomUZpe6ovfA==
X-Received: by 2002:a5d:5d81:0:b0:42f:bb08:d1ef with SMTP id ffacd0b85a97d-43569992d99mr979679f8f.17.1768515980105;
        Thu, 15 Jan 2026 14:26:20 -0800 (PST)
X-Received: by 2002:a5d:5d81:0:b0:42f:bb08:d1ef with SMTP id ffacd0b85a97d-43569992d99mr979652f8f.17.1768515979623;
        Thu, 15 Jan 2026 14:26:19 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm1423170f8f.11.2026.01.15.14.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:17 -0800 (PST)
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
Subject: [PATCH net-next 8/8] cadence: macb: introduce xmit support
Date: Thu, 15 Jan 2026 23:25:31 +0100
Message-ID: <20260115222531.313002-9-pvalerio@redhat.com>
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

Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
redirection, and update macb_tx_unmap() to handle both skbs and xdp
frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
to process XDP_TX verdicts.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 165 +++++++++++++++++++++--
 1 file changed, 157 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index afd8c0f2d895..32f8629bcb25 100644
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
@@ -1350,10 +1373,127 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
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
+static int gem_xdp_xmit(struct net_device *dev, int num_frame,
+			struct xdp_frame **frames, u32 flags)
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
 
@@ -1380,6 +1520,13 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
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
@@ -1467,7 +1614,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (!(first_frame && last_frame))
 			goto skip_xdp;
 
-		ret = gem_xdp_run(queue, buff_head, data_len);
+		ret = gem_xdp_run(queue, buff_head, data_len, addr);
 		if (ret == XDP_REDIRECT)
 			xdp_flush = true;
 
@@ -4580,6 +4727,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5888,7 +6036,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_headroom += NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.52.0


