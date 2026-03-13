Return-Path: <netdev+bounces-267584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD1MA7hwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DE289A5B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5EA320DEFD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9A3E5577;
	Fri, 13 Mar 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH09QTKq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zid/qbuU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDD3E4C77
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432920; cv=none; b=K9AV7u5kjMq7UpH+OhZKq+O3P6NrDsf0J0be0olrQbD0sMBvaFHvQOOTb6l5z2tLWpWOzG78jJj1hjbvzMkKTO9XSMjzOqjuoNcdvjy7U9iU8ecqXYPsfCMunlDgegVZz7/DJ1ImppcE2eqp63oWTiUNt+TlnXguc4FTnYif+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432920; c=relaxed/simple;
	bh=s65G0Hzxg8sIkb6Cy8XdoLMVZJcPbomLOStoVDasfTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXyImd9S+2FqE1ezb7DKJ9bJhUcF09x6beoUdRiABOyPDjv1ilYbzn70UVtb9x7mfYr4qPTQIbaa2GYT35of/HmVYEs+LUIuDtHK943zYsoc77KF22ByNxMgvXNCebnJebPKjCuNO6BwIOgu13CdEA/fPypR3qHFWIVs89cZduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH09QTKq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zid/qbuU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7KD4DkB5npRDOD87sc5U/niVewEN3gVgyCo4UggS1w=;
	b=HH09QTKqljSMJirztBhK4P0DF3Fns+j50LxcCNpawRDsX8ciumnnoDKSkc8twp/t1K0o6D
	GcrqzGHlJEa9DjpIp7iiqVUQRhizsUv9GUeAhTqn9a1XV7pRRukaF631Fr6EnFZTb7NWyT
	aDZ4t9SSrWaUuQYM/XavupaQphkFccw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-8XTcDY_WMTeMiPqStAnkwg-1; Fri, 13 Mar 2026 16:15:11 -0400
X-MC-Unique: 8XTcDY_WMTeMiPqStAnkwg-1
X-Mimecast-MFC-AGG-ID: 8XTcDY_WMTeMiPqStAnkwg_1773432910
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so17887485e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432909; x=1774037709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7KD4DkB5npRDOD87sc5U/niVewEN3gVgyCo4UggS1w=;
        b=Zid/qbuUpAoW4cuOvbkK+yKyrl8wqC6sdqlT5uzoENml52o9hK91TgKFT+4v8e2wuB
         vuGFuOUqtjJjuyDvj/xnMeSAWgjcu0XLQRvTPa4MDeLGCll3roWT80Ahyq2Lyk2Lp5Nu
         lTP8UPSEDfDnTbYKWE26BRkygufidRcG2OZ5hNVudTHsF5Gk1OW68ACqXZB9/NlNe69R
         qP5/5do6YWrBNdCKmTNcKPwawS6BM1LeIXdN7oGM6fFivhPR51xKTOjKRK8/7UI1l0yW
         kUlFTDhyiw9GVM81Y7aUb/bDfUimqm8qF9or8PKg/LFbnCai4E2QTFUjri4n23TKZkdg
         1wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432909; x=1774037709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7KD4DkB5npRDOD87sc5U/niVewEN3gVgyCo4UggS1w=;
        b=YGluXZdhTr0mIG3dknVoqsSgWa+sB4xU6Oy+I8WpwXC5gUhG2x0F10Z3xzr4TB6SiE
         n7VDO5+X7d0PON7UayMm8+drykPr4UyERQtxZPlKlkAo2Im9CEv6RtvB/dcT38aaevZk
         ORIHz+/WnFEse/FyMSrcU7hHO5X/nXd+pmmb8rYzlJxHUPLERKBPQ2HMNcBrasBq9GnC
         G19sunL4PLOMV/lImqEFD5/buzAWAMWZfMqwChe6K8hSeBV42qV4Mf2s3tXRvEW6ymCp
         GAzw2lItAzpLlxuDhsk4WSlgXbqYzesDMffhoyd8MQEj8r4O9ZnPoB5lPxEJn7fy9R+L
         DRLQ==
X-Gm-Message-State: AOJu0YzuPjePd4Uo3X9wY+5wsAJ3l6z2jJcuuO0BMXryzhXNPsxrn1K0
	S0wMjfizwykN7Tn06ToTR+hMg9viM4K/6Qh8+Ybp8/iaAJMm6FRrKcADz4rcDWqpWenS2OKtp31
	oWVdnRPRzVVYYR7kBxMmax1DHCac9j2FNkU3s4qIh4hdzM9dKBp7jveNV/mQ7gG8FgMHVdN17sy
	3T+BiOKTu6KLuyIdATnPbk1rLOUY/6/Q9l8kayZDZ9Jg==
X-Gm-Gg: ATEYQzyNg3X/djWWhDzPvVfwoqo1cHyP+UuPGWa9Bz29CIeJPjObchdBXGYnZD83JBO
	Wa+i/bi5Smx7g1ae7w2mzcWsjOsqtRUdihLkL7JNwgf8lCfV5qzQTq6P739cecOpoxFgaQEnfdf
	O7rjUbkDsTMUoStrRdZwa6loX4NvhCkd4t+ZJqCuldZDP9Qh8oVS9aoEmUcDk4j9R7FDvRYUmOz
	UWIM9cpsaaBA+Y8GWYF7rcVd5nEM5g/YQx4FHrwO8V2nEBdQ4H2zaUba2CjkLKQlqdETpRummpG
	P7lFy++vLRhXDGrk3wPwQJyY4qGYhXBXvkH+s9HO3GhaXjlqOkzRkkWKfnZnBYyEgBU+TusnHXn
	L4jGUAzjddpj2d2ryz1M2ce7SN7cTAiJ0nsDtJSbMxh1MeDCwX45miWR5BXQ=
X-Received: by 2002:a05:600c:4e16:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-4855670cd92mr72730445e9.30.1773432908894;
        Fri, 13 Mar 2026 13:15:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-4855670cd92mr72729745e9.30.1773432908311;
        Fri, 13 Mar 2026 13:15:08 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm18129513f8f.29.2026.03.13.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:15:05 -0700 (PDT)
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
Subject: [PATCH net-next v5 7/8] net: macb: add XDP support for gem
Date: Fri, 13 Mar 2026 21:14:32 +0100
Message-ID: <20260313201433.2346119-8-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.data:url]
X-Rspamd-Queue-Id: 627DE289A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce basic XDP support for macb/gem with the XDP_TX, XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 366 ++++++++++++++++++++---
 2 files changed, 335 insertions(+), 34 deletions(-)

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
index 0cc63c2f498f..df2b3f5a2fed 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/bpf_trace.h>
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -1190,6 +1191,18 @@ static int macb_halt_tx(struct macb *bp)
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
@@ -1204,7 +1217,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		napi_consume_skb(tx_buff->ptr, budget);
+		macb_tx_release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1268,7 +1281,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * network engine about the macb/gem being halted.
 	 */
 	napi_disable(&queue->napi_tx);
-	spin_lock_irqsave(&bp->lock, flags);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	spin_lock(&bp->lock);
 
 	/* Make sure nobody is trying to queue up new packets */
 	netif_tx_stop_all_queues(bp->dev);
@@ -1292,6 +1306,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			goto unmap;
+
 		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1329,6 +1347,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1360,7 +1379,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	netif_tx_start_all_queues(bp->dev);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
-	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock(&bp->lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	napi_enable(&queue->napi_tx);
 }
 
@@ -1398,6 +1418,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	unsigned long flags;
+	int skb_packets = 0;
 	unsigned int tail;
 	unsigned int head;
 	u16 queue_index;
@@ -1412,6 +1433,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_tx_buff *tx_buff;
 		struct macb_dma_desc *desc;
 		struct sk_buff *skb;
+		void *data = NULL;
 		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1430,10 +1452,18 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
@@ -1445,24 +1475,26 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
@@ -1512,9 +1544,27 @@ static int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
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
@@ -1551,7 +1601,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 				break;
 			}
 
-			paddr = page_pool_get_dma_addr(page) + NET_SKB_PAD + offset;
+			paddr = page_pool_get_dma_addr(page) +
+				gem_rx_pad(bp) + offset;
 
 			dma_sync_single_for_device(&bp->pdev->dev,
 						   paddr, bp->rx_buffer_size,
@@ -1605,12 +1656,156 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
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
+	macb_tx_lpi_wake(bp);
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
@@ -1618,11 +1813,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
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
@@ -1662,9 +1857,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
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
@@ -1676,6 +1871,18 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
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
@@ -1695,7 +1902,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			skb_reserve(queue->skb, bp->rx_headroom);
+			skb_reserve(queue->skb, headroom);
 			skb_mark_for_recycle(queue->skb);
 			skb_put(queue->skb, data_len);
 		} else {
@@ -1707,15 +1914,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
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
@@ -1743,6 +1946,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1761,6 +1966,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2702,13 +2910,13 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -2759,6 +2967,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2915,37 +3125,62 @@ static int macb_alloc_consistent(struct macb *bp)
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
 
@@ -2987,7 +3222,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure. In case of HRESP error
 		 * recovery we always reuse the existing page pool.
 		 */
-		last_err = gem_create_page_pool(queue);
+		last_err = gem_create_page_pool(queue, q);
 		if (last_err)
 			break;
 
@@ -3437,11 +3672,24 @@ static int macb_close(struct net_device *dev)
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
@@ -3459,6 +3707,55 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	bool need_update, running;
+	int err;
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
+
+	if (running && need_update) {
+		err = macb_open(dev);
+		if (err) {
+			rcu_assign_pointer(bp->prog, old_prog);
+			return err;
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
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
@@ -4730,6 +5027,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6006,11 +6304,11 @@ static int macb_probe(struct platform_device *pdev)
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


