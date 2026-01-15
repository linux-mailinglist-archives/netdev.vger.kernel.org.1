Return-Path: <netdev+bounces-250331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6AD29024
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 289373039989
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE632C33A;
	Thu, 15 Jan 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzok4xfQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5w1hpZA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEA238D27
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515970; cv=none; b=pqUltuVcH9MEVmMQlc3ZxZgBhwdBHfemx2s/xrMJ+jOhJrrWGJTZjp9L8BbNwhjaBYrU+Aj+7EnzChi3MSPwwYiKtk8n4QNxNhwMwUZZvA4sDQYmNGzf7ZpQgYMtfO3bQ7J89J0mPMwm6nDZkbf0y+kOqfKgJ+IoFwFFrxvLbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515970; c=relaxed/simple;
	bh=wO7VbTTA74i6b8rXWNUZqLt1krbj/c5iltyk1DS6oFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3Mdxc/WtuLdd1RjJOVKJYWbe4TN64vcDfd337AYbCnrkkZ/cUq+7OEOwYI0VUNCp7QiFQl9gUYLudGBGOLOYYpe6YcR96le4T0jcn0GDT8PhsV9zsq40y/YARfvUA5fVmbS65gvB7VnAMvw2zoFvIGdV6ahC7QqdSKngM3RlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wzok4xfQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5w1hpZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOw140+gS4p6D8j9ofaxXXMdBY274y7EasdRz0cci48=;
	b=Wzok4xfQPS6oRTaUCNTN4BNBFTsq+e6gtdMix8jjFCOZQUMz0AD5//cfZzZRzZSqQo0V1s
	vApycqBW79g3v6+bjYNWf/GWxXlr9TCSsYm3wFChrtujztDWuZ6LGA6u2ZohR+rfLUv3Eg
	zbdGqHwZSlLzxomPlzPmM31WPz+Lfe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-p4DS3qIMP1KUKofSY5F1lA-1; Thu, 15 Jan 2026 17:26:07 -0500
X-MC-Unique: p4DS3qIMP1KUKofSY5F1lA-1
X-Mimecast-MFC-AGG-ID: p4DS3qIMP1KUKofSY5F1lA_1768515966
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432db1a9589so1228410f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515964; x=1769120764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOw140+gS4p6D8j9ofaxXXMdBY274y7EasdRz0cci48=;
        b=G5w1hpZAoD/Y3sz9tj328Hav6wI+Y91yRB72T6QWtEZTJ4yImr+9dDQ4oB0Rqs30IH
         5mA1kILKclKgtHyJjmLZv79eNmwMRwQzy9/nwvVBO206bEJIZNZ2q1+hMZSK1CIoTh1t
         sMj0EKUgaKPVXkR6kegBomcHuW2nQ5mlGjHlbaMgeBK8agF4qZ3EK4emT56y13vWQ5mU
         BlqpC6aV7va+NAQdtbkgupZsgM6Mh1edpF0fbL3Vl4MXeYR+tZPHtqBDYOfaJ45wB+Kp
         mbi1VEtZ9miVh91RpSTYyWd+A75DAdxLQaxEp9E4f6sYSIv8DyhGBHOIaOgmYYh21n7+
         Yw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515964; x=1769120764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOw140+gS4p6D8j9ofaxXXMdBY274y7EasdRz0cci48=;
        b=XWEzPBKqi3TFoyNRLaqgoZtQFK1iAQbo6Qnyoy2Medc5t5SgZcMYKJ4Ma1Qz1tzseu
         /f2y0iJfyJlsJI9THT6hYvc8UTQmEj4d57cPNQIpdKdJ+x/Arh1H6Z6neOxcVj/zr4Bc
         G3l3X12QpSNTQ8ZKzNV8MrRQKMEhh/3xjVprM4RIJYktrXMvQPZ4RMKefluE9Y/LTzD4
         OZgBFbf6g4lPp0dceJ5EYqFFw93steMD+2tvvmSG4MxOqqNrEEe91oV57e2cQ/LC/0tY
         dlLZrkuMjSeTVc8UQZ/iHUjXobtsw1KNxzP2jH0PhdJZpARVGfLaWAgx9ja/4JdLdBT+
         mXoA==
X-Gm-Message-State: AOJu0YxoixHa/KA4eymxY+9XKo1EWQxM433O46Gzr5dxOCrFxpyp3Uqt
	hYUz3zbjdUfSD9Dvn3LGTgljLUrxTABElD/pIn7USwt8OJrf/MYHgpoU2XCQe/3//A181uskBFN
	VAc14+Cu2ilWatzJH544TSHQrAv1ivh8+p7/l4f3Gb3WR27/OITzSNu+BlTfLlqTF0HVDNuXPUv
	ejw1hKWUVV/Y5S67RDUTuOB8G79DpC5JKuOXOUYPQh5Q==
X-Gm-Gg: AY/fxX4kd27Z/6QNkSJVJzG+cKMiGy3qJXJnMT6FAyTE2fKG/+oWhw8yv5K/WS7zeVW
	K432N2oUDwI1WHZr+0DJcXn/nmJchrZiY7tg1cTc6BckHHRyGTYuCFlH8w1FazP8iF9mgL7A96U
	GRXC+5dDaCFYIzZVRrMHuMxveEXRQ8famgXwbNFANGrFjen+4Y4dwKuW68Po+PFAKDhmL8zhXZ4
	aJJXo9/aNC5cAdkAKRLPWXUL+Glh2sdV+zZoAai3WJ3Y9Ri6M4QyrNwaVkaTFAXJLJ2gPKrAr2e
	h+rs1+fFgoMCMLh37I/K1xCSTP/7jLvRB2JK+HqmbkdMJBcyZK7ZjXf/5kUqrYTPmTbwVNuas0V
	h6mIidGBAcCWu7Yfl4Y5NiDLq4QxrnBu8pvBytPDUhCLQLQ==
X-Received: by 2002:a05:6000:26c6:b0:431:6ba:38bd with SMTP id ffacd0b85a97d-43569972db5mr1148674f8f.10.1768515964015;
        Thu, 15 Jan 2026 14:26:04 -0800 (PST)
X-Received: by 2002:a05:6000:26c6:b0:431:6ba:38bd with SMTP id ffacd0b85a97d-43569972db5mr1148642f8f.10.1768515963575;
        Thu, 15 Jan 2026 14:26:03 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf42sm1390240f8f.20.2026.01.15.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:03 -0800 (PST)
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
Subject: [PATCH net-next 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Thu, 15 Jan 2026 23:25:24 +0100
Message-ID: <20260115222531.313002-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
up all slots with valid buffers.

gem_rx_refill() is called at link up by
gem_init_rings() == bp->macbgem_ops.mog_init_rings().

Move operation to macb_open(), mostly to allow it to fail early and
loudly rather than init the device with Rx mostly broken.

About `bool fail_early`:
 - When called from macb_open(), ring init fails as soon as a queue
   cannot be refilled.
 - When called from macb_hresp_error_task(), we do our best to reinit
   the device: we still iterate over all queues and try refilling all
   even if a previous queue failed.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 40 +++++++++++++++++-------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..2cb65ec37d44 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1180,7 +1180,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2d5f3eb09530..5947c2b44bb3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,8 +705,8 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
+		/* Initialize buffer registers as clearing MACB_BIT(TE) in link
+		 * down cleared the pipeline and control registers.
 		 */
 		macb_init_buffers(bp);
 
@@ -1249,13 +1249,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	unsigned int		entry;
 	struct sk_buff		*skb;
 	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1272,6 +1273,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1321,6 +1323,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1773,7 +1776,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2546,8 +2549,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2559,6 +2560,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2579,11 +2585,13 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp, bool fail_early)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2599,13 +2607,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_rx_refill(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+		}
 	}
 
 	macb_init_tieoff(bp);
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp, bool fail_early)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2622,6 +2641,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -2953,8 +2973,6 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
-
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
-- 
2.52.0


