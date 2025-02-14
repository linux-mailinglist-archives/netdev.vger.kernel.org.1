Return-Path: <netdev+bounces-166564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A6A36761
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3035C188B5F6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B71D95A3;
	Fri, 14 Feb 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J60HE3dO"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2A1990BA
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567812; cv=none; b=omi7NIMBDZMRxz9of3mRwphDHc/K5catGT13AdanwNg4Eny8BcvCbfiXFtFvytgEOTsALbnM+61af5PKmKR6/Ie9VfAGEM0Tk2wbRpqtBcfKF9rdL9qKKkmQNS1d1FJK/3cFmisZUZyM0bAqqcseKMqEEvcyuZ+VN/mOxLUqDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567812; c=relaxed/simple;
	bh=DJMdxiEhPE8s7D3ZE51WcufdZuKradtOoylVhVyCWIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eG9DqSBBF+vcUxqNV84iJ2zYlOSDNsSdI008D079KX0VKZ9NJ1cWdvABKbaD6r0Iacs/BtUKm6DkACnck5C8jzkCbsPwepmYehob7KU/qvzTfZR771yp86C0hf5LxW/JDAt8U8GKJxo6cW48YUt1FKG7HE7iORENsV7PUlaUpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J60HE3dO; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739567808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QUYEF3XJZWIIabE64Wpo23Cj1Kc5EozP7DpwQj01ZWM=;
	b=J60HE3dO9aKtCRChQlcmQm56rgJARyu3WrwP7zASMC6Se46m2WCVESu9YF1qTF6Qlhfk81
	q/tqd9LEgasp4OmZFqoML1gtIWX25RucN7SojVzdH1/LJtIVdoJ41jjnhKK1K4nfIBIq8o
	9IfAodBU6BAsfo5klT5qxpROeFgp/Ng=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: cadence: macb: Implement BQL
Date: Fri, 14 Feb 2025 16:16:43 -0500
Message-Id: <20250214211643.2617340-1-sean.anderson@linux.dev>
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

 drivers/net/ethernet/cadence/macb_main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 48496209fb16..63c65b4bb348 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1081,6 +1081,9 @@ static void macb_tx_error_task(struct work_struct *work)
 						      tx_error_task);
 	bool			halt_timeout = false;
 	struct macb		*bp = queue->bp;
+	u32			queue_index = queue - bp->queues;
+	u32			packets = 0;
+	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
 	struct macb_dma_desc	*desc;
 	struct sk_buff		*skb;
@@ -1088,8 +1091,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	unsigned long		flags;
 
 	netdev_vdbg(bp->dev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    (unsigned int)(queue - bp->queues),
-		    queue->tx_tail, queue->tx_head);
+		    queue_index, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1142,8 +1144,10 @@ static void macb_tx_error_task(struct work_struct *work)
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
@@ -1160,6 +1164,9 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+				  packets, bytes);
+
 	/* Set end of TX queue */
 	desc = macb_tx_desc(queue, 0);
 	macb_set_addr(bp, desc, 0);
@@ -1230,6 +1237,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
+	u32 bytes = 0;
 
 	spin_lock(&queue->tx_ptr_lock);
 	head = queue->tx_head;
@@ -1271,6 +1279,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
 				packets++;
+				bytes += skb->len;
 			}
 
 			/* Now we can safely release resources */
@@ -1285,6 +1294,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+				  packets, bytes);
+
 	queue->tx_tail = tail;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
@@ -2386,6 +2398,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
+			     skb->len);
 
 	spin_lock_irq(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
@@ -3019,6 +3033,7 @@ static int macb_close(struct net_device *dev)
 	netif_tx_stop_all_queues(dev);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
-- 
2.35.1.1320.gc452695387.dirty


