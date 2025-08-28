Return-Path: <netdev+bounces-217894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D16B3A583
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450483A2AAB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265372D838F;
	Thu, 28 Aug 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ehl5mmQp"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53625A34F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396859; cv=none; b=DN+00Ha3UFBFlbwCX7hur1golXE7vFS2p7jGwKf0ZKx1Ff4pQoUh7a/XTSzy5Kblt6ayWbWDjD5VyOMn2L8+E+e0y6lKgKWrfHqqgU9cT1XgzySEGdSwP64B6vBUYCRft1Y5xKh3rBnx+ggGLvry/Hac/Q3Wu0JlCigfP/uP2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396859; c=relaxed/simple;
	bh=hb7VLI6PShExv14ypYu5OGnNmdCKxSLa+baAX3y+iqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPoIFUwCX3bO0DRO10QE7uEHl0HlFcHe3Ua6IvZ7WnieM7YrUd6AVvFTwW9SAj9HT0uNRLSxP01UfgI8EwniSu9P56MKAnWrM9rRSFvwSEAnuOgvoOpLsGgLGccZlihs8WVbUBnC2huEE+Gu6Y8BwQVYXAFmTT3xcuindzTPBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ehl5mmQp; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756396854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7IA/yEM1WqXtcqfvsUISFXQfmi98uZPiGjQuyyb+a6U=;
	b=ehl5mmQpH9uGJuClMpmdhKlCIapxp4QX65fLAHs1eVtiYCzdA+UbTvxBXYjCPIKFnSV9ni
	7m4vkbnUJeFuQGZJpOjDdPLCHN1Gj3PcYDw7mX8NOeOObfAcwuzW9nS0owAuqSlLJ6mpwO
	Kvtwq1BxWhsmTDaMCt2UcSgdUywNsHA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Mike Galbraith <efault@gmx.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] net: macb: Fix tx_ptr_lock locking
Date: Thu, 28 Aug 2025 12:00:23 -0400
Message-Id: <20250828160023.1505762-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

macb_start_xmit can be called with bottom-halves disabled (e.g.
transmitting from softirqs) as well as with interrupts disabled (with
netpoll). Because of this, all other functions taking tx_ptr_lock must
disable IRQs, and macb_start_xmit must only re-enable IRQs if they
were already enabled.

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 16d28a8b3b56..b0a8dfa341ea 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1228,7 +1228,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	int packets = 0;
 	u32 bytes = 0;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irq(&queue->tx_ptr_lock);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
@@ -1291,7 +1291,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irq(&queue->tx_ptr_lock);
 
 	return packets;
 }
@@ -1708,7 +1708,7 @@ static void macb_tx_restart(struct macb_queue *queue)
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irq(&queue->tx_ptr_lock);
 
 	if (queue->tx_head == queue->tx_tail)
 		goto out_tx_ptr_unlock;
@@ -1720,19 +1720,19 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irq(&queue->tx_ptr_lock);
 }
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
 	bool retval = false;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irq(&queue->tx_ptr_lock);
 	if (queue->tx_head != queue->tx_tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1740,7 +1740,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irq(&queue->tx_ptr_lock);
 	return retval;
 }
 
@@ -2308,6 +2308,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
+	unsigned long flags;
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
@@ -2368,7 +2369,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
 	}
 
-	spin_lock_bh(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
@@ -2392,15 +2393,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
 			     skb->len);
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
 		netif_stop_subqueue(dev, queue_index);
 
 unlock:
-	spin_unlock_bh(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return ret;
 }
-- 
2.35.1.1320.gc452695387.dirty


