Return-Path: <netdev+bounces-270763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN/0E6C6wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:11:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62102FE1A2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A71304FF87
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CCF382294;
	Mon, 23 Mar 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBjvtIRY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l2mdpeW2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970B381B14
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303867; cv=none; b=rLwb6FBpAnMry2PSPeZquuBYro8EzBZ+Ju4VEmELpxzOiVMv9VP+LcXW9bwUGaI1tMalyLIw/IKFs4gBazQu7QUIWfSlTwwOiNwhhBGnHcylbB/p9JOGaavNP39Sv9UpZeP/Lh6tutYaXSY1PX38DmXVcUuCYcRbSJN6rMaw7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303867; c=relaxed/simple;
	bh=xunIMCfrpxQCbKNxtPyo6A4uJcDkwkTxLkxfAYZbF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGTka4eWADmc5ByiVGl1qml6ctoJPRW96Os7GMz+pzRsHpnuItbqaB2RUknp+NYu4xeNIdTZOYvRze/vo5J3OapYpRSF/X+jrtwdVr4JOUinTK74mCnJflcC/2EkZX2ZhYeD4X/kP22zFzMLOwylXRVvU0Ghr1eALkDl3i2vzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBjvtIRY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l2mdpeW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86ac8ds6yB4cpiYnaMw8g2Nd1t7UR8QTODnPDEEBBTg=;
	b=bBjvtIRYy+7vThLhNBZO5bEg3zZ/ttwFjvgZ7LS1HZOOBTyr9AuJ9or+ykmWQjdNTgpy2j
	u4gAuYaLqly/wl3T9tjpfoBB/lkSnZZ+zQ6vor561qjtqttU4cSSRjAD/73LnNXgGCQOkr
	fsWRA/c20rtwFNsEiBU0IhpA/FDT8uY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-UeyWKJdFM3qiNG_ifraZtA-1; Mon, 23 Mar 2026 18:11:03 -0400
X-MC-Unique: UeyWKJdFM3qiNG_ifraZtA-1
X-Mimecast-MFC-AGG-ID: UeyWKJdFM3qiNG_ifraZtA_1774303862
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48534941525so40134485e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303861; x=1774908661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86ac8ds6yB4cpiYnaMw8g2Nd1t7UR8QTODnPDEEBBTg=;
        b=l2mdpeW29lBwy5MU9uWQdmjRmEjhvWde0ikRijov9fK+US9GXsIkq9SB1hGJ92efGe
         HLqxhqpv/kTpYM/033QH8dvuUgVwSuVwo+BO5GLasTvbWpHprseQENNERzrrKVjCFsdk
         /5DBDYPm/ynhRcXGm+LS7Q42A2dsUGGV4WwtKeTzv0hNJYiefZjhxwIr7wXzArzndR+2
         N8aGXBZFprnxPJPNMlcGTbCDj7IyzzlxjsaK3BTMMYVAMzJo4jqk3Q2VO0ncWwnC+En6
         JpIJVrvedN93S078JvgwR5cdAqrVSnSStz/3zkJZfGEUyE8OfQb5VdNKfP+1eUFKwvtQ
         iw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303861; x=1774908661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86ac8ds6yB4cpiYnaMw8g2Nd1t7UR8QTODnPDEEBBTg=;
        b=oqHgUmV4/xejhPyWHZMHjGkA5Rk+u9m12coHODX9FDdyvNKM7BlrwKsTq8r+iWgw48
         mVrK5IGT5HA8O6Js4uHd+P1cfi3/0JsVufw73Bf0O67Py/KmstX7vqQjrzL2XrMtfkW+
         UgVe7CYLPoOK2MzxlES2BkOu5Itr2Xwk0yxjp6QTEB1JjuIiW6JYgUx9IGb86HJ830NG
         ptN0s8oAqXnxg8eUVLiqjmo8KtUq7qgyNx9JUJ6mDKA1t2iyyMuXuMd850QnDMSczdMI
         PRFD+EI1eOjjRdZnys3pJ+aM5Vj9AZxS44vnBnDyX04iusgQ9EIOo51+/vabF5eD13TD
         yWBg==
X-Gm-Message-State: AOJu0YyQjxZLg5WowituPMo4wmpQ09Ln1wcxncCZxgKgXHUGT+1bPXfA
	3pSxSqluhZbOfu+Xd4DJIuIENNXetfMQPMGkjn5gLZCnesMYzFF9fqhS14u9/tgAXQC828WDtGy
	WsOBbe6gUf1px9Ptp4fq/vDOgBYbe9JcVmjbp9HszbGr48mHqRfidBvFKlYcARlOD8WCj73eE6x
	pa/HZxjILpFWDtvg6b1/OEq6RUHvt4xLg1obuMsCW7xw==
X-Gm-Gg: ATEYQzyV+VXM4D0cfjR4KX15RkyHcVheQnIQKRr6akBf5JGmAoeNmkm25zjAUON9PFB
	XWTPr5wSkhSetjKJAh+uykjpVmD5EKhxDQjBVtNs9qECMrbjFDR8iTErxOtDmUsFbPuEoYzVIvF
	YI31n5nwbzRqsOYsoJmJccB5SqiFmoQGBSVLKFjJQeZt4RlWBcL1YezFlB0q+Et1lwhMBP9XgFu
	/ZUocc7/PuQz2K2MZ+9k/wlGpNgItkDx2ig07o7Nf3yq0rDLb5ebBfg17LirOE8fWRTrv5dgTu+
	FDY2OGuSUYWuDftRALv9IVLH1DDNGnb/i//LLk2PmfOMygy4mTGg3EmcNSyfc+Ymj9FyH+dmolc
	dVHS/rhvcmutRMdai6tRaZPY6VxHjWA7mETpMZbyGocrnOY0rvro=
X-Received: by 2002:a05:600c:5248:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-486feb5d82emr208754705e9.0.1774303860824;
        Mon, 23 Mar 2026 15:11:00 -0700 (PDT)
X-Received: by 2002:a05:600c:5248:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-486feb5d82emr208754475e9.0.1774303860356;
        Mon, 23 Mar 2026 15:11:00 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116939b8sm6047255e9.3.2026.03.23.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:10:59 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/7] net: macb: move Rx buffers alloc from link up to open
Date: Mon, 23 Mar 2026 23:10:41 +0100
Message-ID: <20260323221047.2749577-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-1-pvalerio@redhat.com>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270763-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: A62102FE1A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/cadence/macb_main.c | 53 ++++++++++++++++++------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c69828b27dae..0acc188fe547 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1195,7 +1195,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1cb49252abf5..38302cba05ad 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1481,13 +1481,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
@@ -1504,6 +1505,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1553,6 +1555,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -2005,7 +2008,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2779,8 +2782,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2792,6 +2793,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2812,19 +2818,21 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rx_ring(struct macb_queue *queue)
+static int gem_init_rx_ring(struct macb_queue *queue)
 {
 	queue->rx_tail = 0;
 	queue->rx_prepared_head = 0;
 
-	gem_rx_refill(queue);
+	return gem_rx_refill(queue);
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
@@ -2837,13 +2845,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		gem_init_rx_ring(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_init_rx_ring(queue);
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
@@ -2860,6 +2879,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -3191,7 +3211,6 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -6108,12 +6127,20 @@ static int __maybe_unused macb_resume(struct device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
-			if (macb_is_gem(bp))
-				gem_init_rx_ring(queue);
-			else
+			if (macb_is_gem(bp)) {
+				err = gem_init_rx_ring(queue);
+				if (err) {
+					dev_err(dev, "Unable to init RX ring: %d\n", err);
+					return err;
+				}
+			} else {
 				macb_init_rx_ring(queue);
+			}
 		}
+	}
 
+	for (q = 0, queue = bp->queues; q < bp->num_queues;
+	     ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}
-- 
2.53.0


