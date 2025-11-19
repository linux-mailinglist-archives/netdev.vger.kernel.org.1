Return-Path: <netdev+bounces-240006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F85C6F32E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BF054FB426
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273B366570;
	Wed, 19 Nov 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0gKGGZI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBAoqDeS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767230505E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560466; cv=none; b=a+jzKR/S3VvhfMZmYHEHRpQY37/lja2uLr/P4KYr90wTgs5FHfAkN+fuaCrddLknALnlN4+XxBbz4OVwNamf0oxfrhSBh5EKv+XDeidfwSGe1xX6qRNaWvQcBcXUIszqDiChVVnlkaysZLjzNkLNKZfOAo5XSCjmMoTofj48/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560466; c=relaxed/simple;
	bh=lQsRnWwJ4Uq6uExwcDQWUvFP+UVInAsDQnZa5oGWxWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpwKp1pbqsuR+cP/jCnIH4NicyAmbt4z1aDczXwGz8TEm6sqrx63UHkhh19jgcDhwsPt3zYZi8mzqF1MDmRHproJhqd70zpFuNXSjPBi+LpOzNCjHC0i0n20f+1i/upV8j5I50ztPvn0VHor/AvROm6vWdYN/24oKeToAp0S9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0gKGGZI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBAoqDeS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMCB3ZyCH+UL+sdJhXbdnULFfH6fMX/QhoJaHlVH/94=;
	b=e0gKGGZIpHFcW6Y9LOK8XpPIbS5MCg0EszuTlnFM7J0t5rbhEE1T8kmza/gyVpGdQHNs+k
	7Dvn6ltYz13p8HEq1kWrlRjFC4K8WK/7IdjUSlMHDEnCqBv0Nc/gyxWp4WW5Y0Hd5k2kTW
	blM89+hKX8/IrlwyJryBwLLsCYXSJcM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-MLZUlfvHPei-FXbyTmc8uw-1; Wed, 19 Nov 2025 08:54:22 -0500
X-MC-Unique: MLZUlfvHPei-FXbyTmc8uw-1
X-Mimecast-MFC-AGG-ID: MLZUlfvHPei-FXbyTmc8uw_1763560461
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so18605915e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560460; x=1764165260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMCB3ZyCH+UL+sdJhXbdnULFfH6fMX/QhoJaHlVH/94=;
        b=QBAoqDeSsvbSRHp32wt5HDho7z3z3d27tSpzJvfkfUpAY3Id+eUe9Wc862b3xZyMW6
         w2GPgwBvtPtbwdtoFnr/7IN16pdNJe9LtQ6hncTAjSCDYJjKkwzE2SH2spQ+rFdZjpTC
         +U9hgjO5bkOc4r4aBZvt4qVBiNI4SDqtTLXH4s7Gz/Eq3/Bpob3izWlz/CCltB+22WzL
         oA4+YiQSD/5LVDu4+A15WEz0WB9m0m48c9LyTiBxU3WzOFLSndwPT07XYhiCKrKMXTj2
         oHkvicAnQ9/8io0WgXa43MisAaQCVmjA5EbPI/Qt5Por+ffl4m+KWt5ujsgglXzn+mKR
         4r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560460; x=1764165260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMCB3ZyCH+UL+sdJhXbdnULFfH6fMX/QhoJaHlVH/94=;
        b=S49zUe4su0KNxYpKgYSSnhvzi6a2IWg3rS6Hm6sAfDm1vmFOVZNZgqa+dPZQHjLjBB
         IkN9v1xKB53tLwdqDorurE0XWUqZnCrI2Kg4aB+TwDC979j5kBEdxR80DBxhFsQaUAp1
         KvpvY9Iv39/S/s9uI+Gl9hN++bc10HP1om2a2tqAMsv30WS2bv4kni0vbkEtgxSpELce
         iFX2S1Le3M/Zx/K9zRCoEhDWScdVTACdPdO0YpfGHvgtYVxkhjBV9oVXKSK6Fq4WpcGB
         i/kMVcawJPGmLBa5S7lMGJ+N1h9UxXSzJYvOdxg456kKV29p9RQwXGa0ZBFPOudsO9eV
         AAOA==
X-Gm-Message-State: AOJu0YxByqg9NrGJfP5xjAKNz0Gj5iWYkdTomei3smWrFX0gcVXL1SO7
	RJEnuQLPk+/6Daqzd3rG8G4nWKxcWdEKZskqc+FsmBMFJswvivIYMhNUrJWfJNK3sstfEHPFXD3
	ut0i+gfYN2ljCh3+7YFlrO635z63FvC6MDVFLAfo0HexIzm5/nlTfPQkKqu/tJY0FpjVYghekaB
	G7YuLL8mXCZ281ZHiP7LASfr0FUQLUj3xriqdwz+G6PTcs
X-Gm-Gg: ASbGncvYFdlIt9G/+B4FIBZ9sjWUs55n+gkslE3dMIEeu7Io5xrzsmr1mGpuYoDyen7
	GBUnGKEuWQoKbf2jwpRJidZqhzevtJgxgyv48ncBtc59jlfz94OrVYLVhzdXaCTCmLYkXi5BKZq
	JIVLmsHvayW0TyFVNLdXk5gSt4SZtvOaW8qhfljXK9Y59uyKzzoKboNQdcL+jdzsQP/3rozM6bV
	p5mP7M7fwNLqMv2ypfias3BIJmMyveajQMSTlOU73LgRWshqIhwzly+z+drwhh7lGmJ75JO5LCk
	HPn4KGU/JY+0JNWt18CbRBHPfeTi8BCFNtgq4Oxb/FhFG8WBPhxFQs+pfcdVGmHRurFsB4p2xtn
	8TqSgmRbv5dME4+5UGkOJKtzFB8R4qFh4urbG442PAtZB5wqigA==
X-Received: by 2002:a05:600c:1f86:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4778fea17bemr171055615e9.32.1763560460402;
        Wed, 19 Nov 2025 05:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmDllfr71GVXTEK0JtVnC1sII5XtYPvO0JStUBFVZbkKCA3WWdOnYSKgjF1r5/J/jiPd0YsA==
X-Received: by 2002:a05:600c:1f86:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4778fea17bemr171055255e9.32.1763560459900;
        Wed, 19 Nov 2025 05:54:19 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e1b657sm39767195e9.17.2025.11.19.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:17 -0800 (PST)
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
Subject: [PATCH RFC net-next 6/6] cadence: macb/gem: introduce xmit support
Date: Wed, 19 Nov 2025 14:53:30 +0100
Message-ID: <20251119135330.551835-7-pvalerio@redhat.com>
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

Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
redirection, and update macb_tx_unmap() to handle both skbs and xdp
frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
to process XDP_TX verdicts.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
 1 file changed, 153 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index eeda1a3871a6..bd62d3febeb1 100644
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
@@ -983,10 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->data) {
-		if (tx_buff->type != MACB_TYPE_SKB)
-			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping (%d)",
-				   tx_buff->type);
-		napi_consume_skb(tx_buff->data, budget);
+		release_buff(tx_buff->data, tx_buff->type, budget);
 		tx_buff->data = NULL;
 	}
 }
@@ -1076,8 +1084,8 @@ static void macb_tx_error_task(struct work_struct *work)
 		tx_buff = macb_tx_buff(queue, tail);
 
 		if (tx_buff->type != MACB_TYPE_SKB)
-			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
-				   tx_buff->type);
+			goto unmap;
+
 		skb = tx_buff->data;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1118,6 +1126,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1196,6 +1205,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
+		void			*data = NULL;
 		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
@@ -1218,11 +1228,16 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
 
-			if (tx_buff->type == MACB_TYPE_SKB)
-				skb = tx_buff->data;
+			if (tx_buff->type != MACB_TYPE_SKB) {
+				data = tx_buff->data;
+				goto unmap;
+			}
 
 			/* First, update TX stats if needed */
-			if (skb) {
+			if (tx_buff->type == MACB_TYPE_SKB && tx_buff->data) {
+				data = tx_buff->data;
+				skb = tx_buff->data;
+
 				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
@@ -1238,6 +1253,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				bytes += skb->len;
 			}
 
+unmap:
 			/* Now we can safely release resources */
 			macb_tx_unmap(bp, tx_buff, budget);
 
@@ -1245,7 +1261,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			 * WARNING: at this point skb has been freed by
 			 * macb_tx_unmap().
 			 */
-			if (skb)
+			if (data)
 				break;
 		}
 	}
@@ -1357,8 +1373,124 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
+				 struct net_device *dev, dma_addr_t addr)
+{
+	enum macb_tx_buff_type buff_type;
+	struct macb_tx_buff *tx_buff;
+	int cpu = smp_processor_id();
+	struct macb_dma_desc *desc;
+	struct macb_queue *queue;
+	unsigned long flags;
+	dma_addr_t mapping;
+	u16 queue_index;
+	int err = 0;
+	u32 ctrl;
+
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
+	buff_type = !addr ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+
+	/* This is a hard error, log it. */
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
+		       bp->tx_ring_size) < 1) {
+		netif_stop_subqueue(dev, queue_index);
+		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
+			   queue->tx_head, queue->tx_tail);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	if (!addr) {
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
+	unsigned int tx_head = queue->tx_head + 1;
+
+	ctrl = MACB_BIT(TX_USED);
+	desc = macb_tx_desc(queue, tx_head);
+	desc->ctrl = ctrl;
+
+	desc = macb_tx_desc(queue, queue->tx_head);
+	tx_buff = macb_tx_buff(queue, queue->tx_head);
+	tx_buff->data = xdpf;
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
+	queue->tx_head = tx_head;
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
+macb_xdp_xmit(struct net_device *dev, int num_frame,
+	      struct xdp_frame **frames, u32 flags)
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
+		if (macb_xdp_submit_frame(bp, frames[i], dev, 0))
+			break;
+
+		xmitted++;
+	}
+
+	return xmitted;
+}
+
 static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
-		       struct net_device *dev)
+		       struct net_device *dev, dma_addr_t addr)
 {
 	struct bpf_prog *prog;
 	u32 act = XDP_PASS;
@@ -1379,6 +1511,12 @@ static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
 			break;
 		}
 		goto out;
+	case XDP_TX:
+		struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+
+		if (!xdpf || macb_xdp_submit_frame(queue->bp, xdpf, dev, addr))
+			act = XDP_DROP;
+		goto out;
 	default:
 		bpf_warn_invalid_xdp_action(dev, prog, act);
 		fallthrough;
@@ -1467,7 +1605,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 				 false);
 		xdp_buff_clear_frags_flag(&xdp);
 
-		ret = gem_xdp_run(queue, &xdp, bp->dev);
+		ret = gem_xdp_run(queue, &xdp, bp->dev, addr);
 		if (ret == XDP_REDIRECT)
 			xdp_flush = true;
 
@@ -4546,6 +4684,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= macb_xdp,
+	.ndo_xdp_xmit		= macb_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5851,7 +5990,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_offset += NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.51.1


