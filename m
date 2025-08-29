Return-Path: <netdev+bounces-218305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF63B3BDF6
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899B3B6036E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B02135C5;
	Fri, 29 Aug 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WT9WDCr6"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA86367
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478144; cv=none; b=tuOujWd35Ebx2GFNOg/3SfqOgKhCkITystD++XDk4KzSAcUTR1J0HGphCTBE1S+BF/zChxgOKDw+W/uM4071w2hNb2+Mv6FJXu9OssN4CbPdmQyoop+qET695dnAQofimr7NbAji/O548U+v4IhWuZ6K1izONJXBVoM5rpAVMkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478144; c=relaxed/simple;
	bh=6C1zj2Bz/SMfKwe3VGQqLVRnnp7gjcPGg3T2++Phznk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUyzmoPJiUogYAM06R0DnqOBXXljsYEd0BlovJoTxqYh0RgRLNjqwJ4Fg1nW4e4cdKG/C3Zj0pxuQbkaTwsnpIzMdiplIN/XwQORXN8xUyiRYQ+snGFi/92mFtxJmOKC5axdOzg37IrCcVfaTncvbQwvVECdFozJL8KMNTeyTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WT9WDCr6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756478139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOZIz3lvu5cNDuQESZBMSPvek4N2QVT9u+4vmBaWsdc=;
	b=WT9WDCr6cuF3dRaMSAztN2A/RlrynTWdl1Ypm9Wf3VL2040LxUeW+FDf6Fd6FPYLlwiWBu
	IPNsH5Z597sgT9L0qGx574anTiR7DDkiMar6opsI2N7d7aT3mcQeT1r6QHdwDp3GDu8AyK
	PbAB2sQifnOiE5NscrsCXwvom/OfnOM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mike Galbraith <efault@gmx.de>,
	Robert Hancock <robert.hancock@calian.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: macb: Fix tx_ptr_lock locking
Date: Fri, 29 Aug 2025 10:35:21 -0400
Message-Id: <20250829143521.1686062-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

macb_start_xmit and macb_tx_poll can be called with bottom-halves
disabled (e.g. from softirq) as well as with interrupts disabled (with
netpoll). Because of this, all other functions taking tx_ptr_lock must
use spin_lock_irqsave.

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Use irqsave/restore for all accesses, since they can also also be
  called from netpoll.

 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 16d28a8b3b56..c769b7dbd3ba 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1223,12 +1223,13 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	u16 queue_index = queue - bp->queues;
+	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
 	u32 bytes = 0;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
@@ -1291,7 +1292,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return packets;
 }
@@ -1707,8 +1708,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	if (queue->tx_head == queue->tx_tail)
 		goto out_tx_ptr_unlock;
@@ -1720,19 +1722,20 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
 	bool retval = false;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	if (queue->tx_head != queue->tx_tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1740,7 +1743,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	return retval;
 }
 
@@ -2308,6 +2311,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
+	unsigned long flags;
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
@@ -2368,7 +2372,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
 	}
 
-	spin_lock_bh(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
@@ -2392,15 +2396,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
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


