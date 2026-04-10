Return-Path: <netdev+bounces-277533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHBiNkxV2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8C3DC22A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D543046F0C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA033822BB;
	Fri, 10 Apr 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ulMGrhfG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361C382388;
	Fri, 10 Apr 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850736; cv=none; b=M4l2vjxWCXay+SfTXnneP/9QtPatYZ6HHLsNCSsGrFOuc4dxyZe0LT9A3NAhs/ePmiW0TDA430/mTWnKN4XaFt4kEJG8fci/GsW0hHjomhthCRtx0TBk+RVpN9qpVBc3DDQPYe2o9iOZG0FxXLmMgMJn3htLVAFy2j1CPry83LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850736; c=relaxed/simple;
	bh=drjfDrZQ4uAr+iY+EWLB/vIJDHagMvM9P5EAtxvJhw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXC0bOkQ/vYtMRl14ZrsJrb44MHHUyPUOYoP6+/4nuF01jgttWtaXOdvgt/aPB5h1friirIN1HsDGy1MJe8zGYtlk1CEMaUDlBhvYw18K4KD/SSDOqnpaUpsRaWSt6XBnqHWfk8lfranx1Czvh7zTnR9y2N9lYdu7r5RB/9y668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ulMGrhfG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0BC14E429B2;
	Fri, 10 Apr 2026 19:52:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 801CE603F0;
	Fri, 10 Apr 2026 19:52:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B535110450082;
	Fri, 10 Apr 2026 21:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/kMbbErFWvpHtbT5WRTMUwZrLWlghJCeVRaIieDYPvU=;
	b=ulMGrhfG85PeL6rWnfaOJca6DbdsIhoxDTvRfoWIpy/mXBvKtfxyli91SZxx8uVHQAKjfA
	21koY5CDgNJ73oh3QMnDTkXUXD84epnEguNqfNf5KT6mNBH7C6REfGpZqfn6U7hUXbO3KP
	QjrvcOFruQCDcpXgNnNG93ABC8WIuDlQQoExaAT0Qy8naCRDm+e0i+q300kiSLFf8YFI8e
	qLkmOnMKFr7UkdiaPW4qcDkIRWuuDAHYBdYC2ar55ToEpB3pf/Zwso7NcUomqK33dy+1ro
	30H7fsVmlRIekzOBSsyvNFymV0LjFbxMEicovEMYiOI3avAIL5kspE2jPjQuwQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:51 +0200
Subject: [PATCH net-next v2 03/14] net: macb: unify queue index variable
 naming convention and types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-3-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 40F8C3DC22A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Variables are named q or queue_index. Types are int, unsigned int, u32
and u16. Use `unsigned int q` everywhere.

Skip over taprio functions. They use `u8 queue_id` which fits with the
`struct macb_queue_enst_config` field. Using `queue_id` everywhere
would be too verbose.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a8a7df615d25..b0e70f6ce305 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -877,7 +877,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 static void gem_shuffle_tx_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
-	int q;
+	unsigned int q;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
 		gem_shuffle_tx_one_ring(queue);
@@ -1258,7 +1258,7 @@ static void macb_tx_error_task(struct work_struct *work)
 						      tx_error_task);
 	bool			halt_timeout = false;
 	struct macb		*bp = queue->bp;
-	u32			queue_index;
+	unsigned int		q;
 	u32			packets = 0;
 	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
@@ -1267,9 +1267,9 @@ static void macb_tx_error_task(struct work_struct *work)
 	unsigned int		tail;
 	unsigned long		flags;
 
-	queue_index = queue - bp->queues;
+	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    queue_index, queue->tx_tail, queue->tx_head);
+		    q, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1342,7 +1342,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	/* Set end of TX queue */
@@ -1407,7 +1407,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
-	u16 queue_index = queue - bp->queues;
+	unsigned int q = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1469,14 +1469,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	queue->tx_tail = tail;
-	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
+	if (__netif_subqueue_stopped(bp->netdev, q) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
-		netif_wake_subqueue(bp->netdev, queue_index);
+		netif_wake_subqueue(bp->netdev, q);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	if (packets)
@@ -2470,10 +2470,10 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	u16 queue_index = skb_get_queue_mapping(skb);
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue = &bp->queues[queue_index];
+	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
+	struct macb_queue *queue = &bp->queues[q];
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
@@ -2513,7 +2513,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->netdev,
 		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
-		    queue_index, skb->len, skb->head, skb->data,
+		    q, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
 	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
 		       skb->data, 16, true);
@@ -2539,7 +2539,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
 		       bp->tx_ring_size) < desc_cnt) {
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
 			   queue->tx_head, queue->tx_tail);
 		ret = NETDEV_TX_BUSY;
@@ -2555,7 +2555,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
 			     skb->len);
 
 	spin_lock(&bp->lock);
@@ -2564,7 +2564,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

-- 
2.53.0


