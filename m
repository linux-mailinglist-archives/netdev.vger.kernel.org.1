Return-Path: <netdev+bounces-168201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD2A3E148
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4282F862742
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5952204F94;
	Thu, 20 Feb 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JgTLL5R6"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B320DD47
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069797; cv=none; b=Op5zyq+oNQd/Px5zaHY22WzwrnjEf6MWtbPtEbLdDSQ3zE0G4PH+TGkzV1w6euDvJzzBhRW/6Z5KCxD98kqb/tmHsZuRju/hA5/1mMN2qoVSi7FnJ2yt8uZNy2PJrbAej11Ev0qFDkgKWP7b5AqjniajrRjVawAtKDNa4LVAw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069797; c=relaxed/simple;
	bh=CETFckSGLagswl0Pqfs57UFAtqcIvAdVoYsbh8b7tPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=maSAaNM2ieH1zPEBrhmY0o0VkVxhoJ1XK2ZrS7o3WvwsKW8peqm96uYL9h64vVdLcNEkGFPg+peZ4xEe8xMQL5vRqBELI9N+UN4NJhc5/JRUx4bm075hbZnaha8d5UNiv5w+msk7lo2F+dq5lqDXI+TeqN5nRN50NX7d1B0z2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JgTLL5R6; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740069783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2EPvTSWtCKlN86g9+N+uYkxsZa3IluO/QJHLmqnQGwE=;
	b=JgTLL5R6XUz4U+PfdujS2vMn1wjtV0gVZO6rqKXmZ/7W72pDRE8AIcvp5uozE7B6jnGZnv
	f0XJCGACVuz+pDyK8Dx0I+R7dmaM0GkyZtnxlW9W05ilnEn2uL+0HiLiPMfuMfzWvk7EIF
	kSj4Wy19C56PM9ZK0bB1MF5sTfc3sp4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2] net: cadence: macb: Implement BQL
Date: Thu, 20 Feb 2025 11:42:57 -0500
Message-Id: <20250220164257.96859-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement byte queue limits to allow queuing disciplines to account for
packets enqueued in the ring buffer but not yet transmitted. There are a
separate set of transmit functions for AT91 that I haven't touched since
I don't have hardware to test on.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Reset BQL after disabling NAPI
- Adjust variable ordering for improved aesthetics

 drivers/net/ethernet/cadence/macb_main.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 48496209fb16..d0eac42d9ae0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1081,15 +1081,18 @@ static void macb_tx_error_task(struct work_struct *work)
 						      tx_error_task);
 	bool			halt_timeout = false;
 	struct macb		*bp = queue->bp;
+	u32			queue_index;
+	u32			packets = 0;
+	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
 	unsigned int		tail;
 	unsigned long		flags;
 
+	queue_index = queue - bp->queues;
 	netdev_vdbg(bp->dev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    (unsigned int)(queue - bp->queues),
-		    queue->tx_tail, queue->tx_head);
+		    queue_index, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1142,8 +1145,10 @@ static void macb_tx_error_task(struct work_struct *work)
 					    skb->data);
 				bp->dev->stats.tx_packets++;
 				queue->stats.tx_packets++;
+				packets++;
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
+				bytes += skb->len;
 			}
 		} else {
 			/* "Buffers exhausted mid-frame" errors may only happen
@@ -1160,6 +1165,9 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+				  packets, bytes);
+
 	/* Set end of TX queue */
 	desc = macb_tx_desc(queue, 0);
 	macb_set_addr(bp, desc, 0);
@@ -1230,6 +1238,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
+	u32 bytes = 0;
 
 	spin_lock(&queue->tx_ptr_lock);
 	head = queue->tx_head;
@@ -1271,6 +1280,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
 				packets++;
+				bytes += skb->len;
 			}
 
 			/* Now we can safely release resources */
@@ -1285,6 +1295,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+				  packets, bytes);
+
 	queue->tx_tail = tail;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
@@ -2386,6 +2399,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
+			     skb->len);
 
 	spin_lock_irq(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
@@ -3021,6 +3036,7 @@ static int macb_close(struct net_device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
 	phylink_stop(bp->phylink);
-- 
2.35.1.1320.gc452695387.dirty


