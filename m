Return-Path: <netdev+bounces-265577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZZMNTdrmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6223AD96
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BFB230C7AAB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82DC3D413C;
	Mon,  9 Mar 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SowIGDkr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOO5wdjV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF03D4120
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067470; cv=none; b=OK5b6RXiRjk+v4YjkYmU117TuJIGssVwTec8l+Gv6vmOZokTi88Go1UTnIgiZZ7viHdSD9EJmlp7juv2KXd1y2KXhri5FfIbAxgHYuzm35jrwMryWp3hGuOurBzVwZ9Qlce9zwvS/aO93zwfvud7ux9cz1BO3AvXNQugzPiMaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067470; c=relaxed/simple;
	bh=JV1z62dEzk1K9PHk1WdyrqsnWRqcQBPhRr4B8HSgAUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPvOu08SSC1ytwKeIT+g7Df++2VQh0Yp8CpMUG/WB9LoCX1gORvN/vkyroljPilsw9djAuPkxNBHMkZtaa0KP3L6Eh7K6HHzL6s/LdlCGTqSvVZFqDkFUN+blORJUFCPlBGdWCaupqtWex0yo68JoVGTfNtW8Y4NJ01e23CSc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SowIGDkr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOO5wdjV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXCnZATLbbglXJYnBufIeJ0TlMoSzk3cLLMVE3eYlfE=;
	b=SowIGDkrx3gSc+cYOhHSwHieATpNTbQyN0L5nSVxSmpCMzbyNBJsqE4gDtMGLJOxzmsb9P
	hDtkwNVcRMQ9yToIMnFlSXzfXVez5Xk0uG6tspMh19W3PdIGTpyC1fHgwj1uDukbrKim7A
	0z+/tFRLqtUywQOW3iUaFikMJf1M3H0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-qvpDLZHbPaW9jRdU1uYZUQ-1; Mon, 09 Mar 2026 10:44:21 -0400
X-MC-Unique: qvpDLZHbPaW9jRdU1uYZUQ-1
X-Mimecast-MFC-AGG-ID: qvpDLZHbPaW9jRdU1uYZUQ_1773067460
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so128932355e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067459; x=1773672259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXCnZATLbbglXJYnBufIeJ0TlMoSzk3cLLMVE3eYlfE=;
        b=iOO5wdjVQubsNfdWfbix/aWJPavPYmD5OWGzsyb6mkJh5lhlQoQ4erazpXMOQQgRRP
         zNOo99+kgQqRuKr7Bh/9r2A/OCMc21OptX1DFHLPH/qvxxNR6ZuRJwcPK5/uJLCAmTNQ
         yRyOuou1CAFD9Fp2wihnsMwcbLjd9BCPYlrG4J3Q8PVSqkyc9XJcYZTL+mCNU3FVVrZn
         zUfaWqJSXJDLbZW4cTyOoXv9e88ZRL+ShZckH6sJVbgmqcNK4/mFPor+A8TLq5gBmPVz
         ZaLxmZBXiTwy5mwERu6WPf8QhkIqc1+tFsU7gb3qLMQc7+PhNYL7ggqXplKOs+ShKo+w
         6v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067459; x=1773672259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXCnZATLbbglXJYnBufIeJ0TlMoSzk3cLLMVE3eYlfE=;
        b=ViEGfO+cfLoxrV0yqMp7FoJlZmL130BDpOaiuoctMIXJUHaiz04jCfCU2duMU5iVms
         McRZj87B/nn3RuIn7mnrrWs+g6d+k1HuUeUeUeSKAQmgBcyf8gH+pYbcpn0ivLkg/3Iq
         TP6QogEQfcNRWYhK2xZvEgYMpLb1JLY3mY6ikKHl5OTJci1KGYMl4cWASHl0jNTW6SH/
         6yJ0K5sYDJ1Y+s8SdmmnG6vmxY6oidViiXw7FK1I9TEnUvVXQjiGChYf3DI4sxQDSN6N
         uf2odJ5TJWY/ixfuIqji2AymmDkslxLBVUPcq9X6q43C+aa/C+7wCyhuWjSkqhCdyTZW
         C9VQ==
X-Gm-Message-State: AOJu0YwjU2QaYJK9MXTq1TMuF94wPoSVo/LT9ozqR45fWrWy9NyPj+qW
	cJTteVpkrIyoX/mg5n95Ejp2vmG1pucfdZJ7V5+UK0tYnwiwgVUfT+vZdDHX49nexbXjA2nSrGW
	m1YJ/41J3NDWxAe5E3dsL7S0dJdqrfuRuLULyfUSOHMEzUQvYbt09xxy3EsTm34wL8FJUtaACBJ
	uvd/BtYLg+NzEQyEGC7qcPPe2FJi63AtdQz2DA1zDNNA==
X-Gm-Gg: ATEYQzywhv6QzHUqvUSrYcM+qIVxquiEm35uAuG1/QQTxMjZ6d25AdCtxXQlg9LsV8x
	MxfXjIYVRGXKkvgPfTEUJy6/bajV+/hqGLdflsp0f5cHC3aFt8c6eSO9RFwAcdLUwyCDE84Q+eE
	sDrlinRq7T0GijTkQgUynBkh0Ry04gKldzA8fdYQhzHP1VeT+zblA2NZr9sAHTapeHoAWuLzDGi
	GCCIkDhtXBrXaNOivFFuRoZ0hQ6+Icc/+rcVpBDeRZavWh7oN0Cu0YLjl+pKz2kJgK2d387/3LX
	NoTGf/Z2+55wcdv5JNwO0I6kJCuH+L0MMv5PjKGcler7Nw99pJMDVVRKXgTaY0lsQriXpi40yRu
	C7HuCL2bLLfUsmPHtH11mdk7/inWlpTSL6kJCk+2lsxIiH7WsTzMP4W9kbiw=
X-Received: by 2002:a05:600c:1f13:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48540dbd6ecmr13790195e9.3.1773067459112;
        Mon, 09 Mar 2026 07:44:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1f13:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48540dbd6ecmr13789525e9.3.1773067458516;
        Mon, 09 Mar 2026 07:44:18 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f9f82a7sm36334135e9.10.2026.03.09.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:17 -0700 (PDT)
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
Subject: [PATCH net-next v4 7/8] net: macb: add XDP support for gem
Date: Mon,  9 Mar 2026 15:43:52 +0100
Message-ID: <20260309144353.1213770-8-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144353.1213770-1-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DB6223AD96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265577-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Introduce basic XDP support for macb/gem with the XDP_TX, XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 362 ++++++++++++++++++++---
 2 files changed, 331 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d8c581394b98..a1cec805ee92 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -15,6 +15,7 @@
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1293,6 +1294,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_rxq;
 };
 
 struct ethtool_rx_fs_item {
@@ -1398,6 +1400,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 13e4a3438439..5351979e21ee 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/bpf_trace.h>
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -1098,6 +1099,18 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
+static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
+{
+	if (type == MACB_TYPE_SKB) {
+		napi_consume_skb(buff, budget);
+	} else {
+		if (!budget)
+			xdp_return_frame(buff);
+		else
+			xdp_return_frame_rx_napi(buff);
+	}
+}
+
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 			  int budget)
 {
@@ -1112,7 +1125,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		napi_consume_skb(tx_buff->ptr, budget);
+		macb_tx_release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1176,7 +1189,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * network engine about the macb/gem being halted.
 	 */
 	napi_disable(&queue->napi_tx);
-	spin_lock_irqsave(&bp->lock, flags);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	spin_lock(&bp->lock);
 
 	/* Make sure nobody is trying to queue up new packets */
 	netif_tx_stop_all_queues(bp->dev);
@@ -1200,6 +1214,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			goto unmap;
+
 		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1237,6 +1255,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1268,7 +1287,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	netif_tx_start_all_queues(bp->dev);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
-	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock(&bp->lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	napi_enable(&queue->napi_tx);
 }
 
@@ -1306,6 +1326,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	unsigned long flags;
+	int skb_packets = 0;
 	unsigned int tail;
 	unsigned int head;
 	u16 queue_index;
@@ -1320,6 +1341,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_tx_buff *tx_buff;
 		struct macb_dma_desc *desc;
 		struct sk_buff *skb;
+		void *data = NULL;
 		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1338,10 +1360,18 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->ptr;
+
+			if (tx_buff->type != MACB_TYPE_SKB) {
+				data = tx_buff->ptr;
+				packets++;
+				goto unmap;
+			}
 
 			/* First, update TX stats if needed */
-			if (skb) {
+			if (tx_buff->ptr) {
+				data = tx_buff->ptr;
+				skb = tx_buff->ptr;
+
 				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
@@ -1353,24 +1383,26 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				queue->stats.tx_packets++;
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
+				skb_packets++;
 				packets++;
 				bytes += skb->len;
 			}
 
+unmap:
 			/* Now we can safely release resources */
 			macb_tx_unmap(bp, tx_buff, budget);
 
-			/* skb is set only for the last buffer of the frame.
-			 * WARNING: at this point skb has been freed by
+			/* data is set only for the last buffer of the frame.
+			 * WARNING: at this point the buffer has been freed by
 			 * macb_tx_unmap().
 			 */
-			if (skb)
+			if (data)
 				break;
 		}
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
-				  packets, bytes);
+				  skb_packets, bytes);
 
 	queue->tx_tail = tail;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
@@ -1420,9 +1452,27 @@ static int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 	return len;
 }
 
+static unsigned int gem_rx_pad(struct macb *bp)
+{
+	if (rcu_access_pointer(bp->prog))
+		return XDP_PACKET_HEADROOM;
+
+	return NET_SKB_PAD;
+}
+
+static unsigned int gem_max_rx_data_size(int base_sz)
+{
+	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
+}
+
+static unsigned int __gem_total_rx_buffer_size(int data_sz, unsigned int headroom)
+{
+	return SKB_HEAD_ALIGN(data_sz + headroom);
+}
+
 static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 {
-	return SKB_HEAD_ALIGN(bp->rx_buffer_size + NET_SKB_PAD);
+	return __gem_total_rx_buffer_size(bp->rx_buffer_size, gem_rx_pad(bp));
 }
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1459,7 +1509,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 				break;
 			}
 
-			paddr = page_pool_get_dma_addr(page) + NET_SKB_PAD + offset;
+			paddr = page_pool_get_dma_addr(page) +
+				gem_rx_pad(bp) + offset;
 
 			dma_sync_single_for_device(&bp->pdev->dev,
 						   paddr, bp->rx_buffer_size,
@@ -1513,12 +1564,155 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
+				 struct net_device *dev, dma_addr_t addr)
+{
+	struct macb_tx_buff *tx_buff;
+	int cpu = smp_processor_id();
+	struct macb_dma_desc *desc;
+	struct macb_queue *queue;
+	unsigned int next_head;
+	unsigned long flags;
+	u16 queue_index;
+	int err = 0;
+	u32 ctrl;
+
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
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
+	/* progs can adjust the head. Sync and set the adjusted one.
+	 * This also implicitly takes into account ip alignment,
+	 * if present.
+	 */
+	addr += xdpf->headroom + sizeof(*xdpf);
+
+	dma_sync_single_for_device(&bp->pdev->dev, addr,
+				   xdpf->len, DMA_BIDIRECTIONAL);
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
+	tx_buff->type = MACB_TYPE_XDP_TX;
+	tx_buff->mapping = 0;
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
+	macb_set_addr(bp, desc, addr);
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
+	return err;
+}
+
+static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
+		       unsigned int *len, unsigned int *headroom,
+		       dma_addr_t addr)
+{
+	struct net_device *dev;
+	struct xdp_frame *xdpf;
+	struct bpf_prog *prog;
+	struct xdp_buff xdp;
+
+	u32 act = XDP_PASS;
+
+	rcu_read_lock();
+
+	prog = rcu_dereference(queue->bp->prog);
+	if (!prog)
+		goto out;
+
+	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
+	xdp_prepare_buff(&xdp, buff_head, *headroom, *len, false);
+	xdp_buff_clear_frags_flag(&xdp);
+	dev = queue->bp->dev;
+
+	act = bpf_prog_run_xdp(prog, &xdp);
+	switch (act) {
+	case XDP_PASS:
+		*len = xdp.data_end - xdp.data;
+		*headroom = xdp.data - xdp.data_hard_start;
+		goto out;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
+							     dev, addr)) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	page_pool_put_full_page(queue->page_pool,
+				virt_to_head_page(xdp.data), true);
+out:
+	rcu_read_unlock();
+
+	return act;
+}
+
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	bool xdp_flush = false;
+	unsigned int headroom;
 	unsigned int entry;
 	struct page *page;
 	void *buff_head;
@@ -1526,11 +1720,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int data_len;
 	int nr_frags;
 
-
 	while (count < budget) {
 		bool rxused, first_frame, last_frame;
 		dma_addr_t addr;
 		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1570,9 +1764,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (data_len < 0)
 			goto free_frags;
 
-		addr += first_frame ? bp->rx_ip_align : 0;
-
-		dma_sync_single_for_cpu(&bp->pdev->dev,	addr, data_len,
+		dma_sync_single_for_cpu(&bp->pdev->dev,
+					addr + (first_frame ? bp->rx_ip_align : 0),
+					data_len,
 					page_pool_get_dma_dir(queue->page_pool));
 
 		if (first_frame) {
@@ -1584,6 +1778,18 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 				queue->stats.rx_dropped++;
 			}
 
+			headroom = bp->rx_headroom;
+
+			if (last_frame) {
+				ret = gem_xdp_run(queue, buff_head, &data_len,
+						  &headroom, addr - gem_rx_pad(bp));
+				if (ret == XDP_REDIRECT)
+					xdp_flush = true;
+
+				if (ret != XDP_PASS)
+					goto next_frame;
+			}
+
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
 			if (unlikely(!queue->skb)) {
 				if (net_ratelimit())
@@ -1603,7 +1809,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			skb_reserve(queue->skb, bp->rx_headroom);
+			skb_reserve(queue->skb, headroom);
 			skb_mark_for_recycle(queue->skb);
 			skb_put(queue->skb, data_len);
 		} else {
@@ -1615,15 +1821,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 				goto free_frags;
 
 			skb_add_rx_frag(queue->skb, nr_frags, page,
-					buff_head - page_address(page) + NET_SKB_PAD,
+					buff_head - page_address(page) + gem_rx_pad(bp),
 					data_len, gem_total_rx_buffer_size(bp));
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (last_frame) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1651,6 +1853,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1669,6 +1873,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2610,13 +2817,13 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int overhead;
-	size_t size;
 
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		size = mtu + ETH_HLEN + ETH_FCS_LEN;
-		bp->rx_buffer_size = SKB_DATA_ALIGN(size + bp->rx_ip_align);
+		bp->rx_headroom = gem_rx_pad(bp) + bp->rx_ip_align;
+		bp->rx_buffer_size = gem_max_rx_data_size(mtu + bp->rx_ip_align);
+
 		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
 			overhead = bp->rx_headroom +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -2667,6 +2874,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2823,37 +3032,62 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static int gem_create_page_pool(struct macb_queue *queue)
+static int gem_create_page_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = rcu_access_pointer(queue->bp->prog)
+				? DMA_BIDIRECTIONAL
+				: DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.netdev = queue->bp->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
-	int err = 0;
+	int err;
 
 	/* This can happen in the case of HRESP error.
 	 * Do nothing as page pool is already existing.
 	 */
 	if (queue->page_pool)
-		return err;
+		return 0;
 
 	pool = page_pool_create(&pp_params);
 	if (IS_ERR(pool)) {
 		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
 		err = PTR_ERR(pool);
-		pool = NULL;
+		goto clear_pool;
 	}
 
 	queue->page_pool = pool;
 
+	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
+			       queue->napi_rx.napi_id);
+	if (err < 0) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
+		goto destroy_pool;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 queue->page_pool);
+	if (err) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
+		goto unreg_info;
+	}
+
+	return 0;
+
+unreg_info:
+	xdp_rxq_info_unreg(&queue->xdp_rxq);
+destroy_pool:
+	page_pool_destroy(pool);
+clear_pool:
+	queue->page_pool = NULL;
+
 	return err;
 }
 
@@ -2895,7 +3129,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure. In case of HRESP error
 		 * recovery we always reuse the existing page pool.
 		 */
-		last_err = gem_create_page_pool(queue);
+		last_err = gem_create_page_pool(queue, q);
 		if (last_err)
 			break;
 
@@ -3345,11 +3579,24 @@ static int macb_close(struct net_device *dev)
 	return 0;
 }
 
+static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
+{
+	return __gem_total_rx_buffer_size(gem_max_rx_data_size(mtu + bp->rx_ip_align),
+					  XDP_PACKET_HEADROOM) <= PAGE_SIZE;
+}
+
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct macb *bp = netdev_priv(dev);
+
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (rcu_access_pointer(bp->prog) && !gem_xdp_valid_mtu(bp, new_mtu)) {
+		netdev_err(dev, "MTU %d too large for XDP\n", new_mtu);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -3367,6 +3614,52 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	bool need_update, running;
+	int err = 0;
+
+	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	running = netif_running(dev);
+	need_update = !!bp->prog != !!prog;
+	if (running && need_update)
+		macb_close(dev);
+
+	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (running && need_update) {
+		err = macb_open(dev);
+		if (err)
+			rcu_assign_pointer(bp->prog, NULL);
+	}
+
+	return err;
+}
+
+static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void gem_update_stats(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -4638,6 +4931,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5938,11 +6232,11 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_phy_exit;
 
 	if (macb_is_gem(bp)) {
-		bp->rx_headroom = NET_SKB_PAD;
-		if (!(bp->caps & MACB_CAPS_RSC)) {
+		if (!(bp->caps & MACB_CAPS_RSC))
 			bp->rx_ip_align = NET_IP_ALIGN;
-			bp->rx_headroom += NET_IP_ALIGN;
-		}
+
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.53.0


