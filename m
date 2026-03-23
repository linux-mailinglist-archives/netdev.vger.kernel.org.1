Return-Path: <netdev+bounces-270764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHo2KLm6wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:12:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94392FE1C6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06893037E67
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BD3803F8;
	Mon, 23 Mar 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ucz/ELJL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qabOOCwP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19A3822A7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303868; cv=none; b=FroMkdEpu4+n+WD5TBo9RdAxCZ4zysuDAjpP0dHVVXFAvB1bBAS1WlX3pnqHrJkpBg3A3HKVN6ZWPcOlz8KiLtOMiZI9AieAHchFF3wYRULzWR852/aWMLvsUuHPdcDCm5LC3/b27DW7tPkDMbd/IcM39Un1Cr6kA8Xr4us8HTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303868; c=relaxed/simple;
	bh=HwukPN5c13ISrNT+ZsEoQ0z0RrZ+8fnqxyqeMcaYJNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN7ZdZrFpv6+wyOQAZT9lDaJPtOXYd2d9T9S4WWR0H1YVGuROH7OVb/ITBB23q7offkQcNeP2kwLlPD3kTlH4fSbm7BMlMZghqOemxykMkiVcwX/BuLGMMuQhWdri70FUXGNI5mJaX/+LBqdz0LDCJMVYdoT+q7JSKru6SGrgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ucz/ELJL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qabOOCwP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyTf7NDhWxGHSitXenvoLQqJ8q8Rzb0N9JSTS+DRJP8=;
	b=Ucz/ELJL18u5xZOALXRJn4o9lkFwgAPte5wvusRRo0BwO5aOpClSQpmAIOkEarhYN92Vhv
	6b4Gf3n1yPgon7JsyDLXm4fkCIDtkHXTPXMN92ScTqtypPRkg6nnTrkQNgCEILcYUFwFgU
	QEmMohDSCxkgICGhTK6UgHNpbpPItTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-EWc7eqZJOnWwKjXslewXlA-1; Mon, 23 Mar 2026 18:11:05 -0400
X-MC-Unique: EWc7eqZJOnWwKjXslewXlA-1
X-Mimecast-MFC-AGG-ID: EWc7eqZJOnWwKjXslewXlA_1774303864
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853466655dso7603785e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303863; x=1774908663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyTf7NDhWxGHSitXenvoLQqJ8q8Rzb0N9JSTS+DRJP8=;
        b=qabOOCwPcvX87jsEwcVoW227r5q0hwWyU8vSv1/MFj0M0P5Y5vXddCtWBnZRntFSc7
         kuWIl5kwSqqB7/KO4uNshGYWom8dpNAFZYzoprRi25y03WbS6sRTtpavbnCOnUUNie2w
         /tHQHphTe0pdiM9Eo7u2gKmXYcxGbvtTWXHxYE8iAhpUrGbgVIjp2ep9GHyT4p05jYkQ
         AivrhlTcqtQMatDPsL3KAaf2Hqkcj5lFmWwalMYiKAxsK9rRiDNZWYDQBP2ioSZ2Ue7h
         ey4zGmusMvmRmR8gfeTDIke6cLG8onQKbHKuWEij84enKCM9jzxmrv9k1s43dH+jzjQB
         91fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303863; x=1774908663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyTf7NDhWxGHSitXenvoLQqJ8q8Rzb0N9JSTS+DRJP8=;
        b=G507y0D3qiTkZFWFh8EPlVmL+d2/7mVNjwS5p2XTjXYnox9KqgwJRsI2NHWW/jpJtF
         sBqKAj1xc5XSl3D8ffW9+ddbvwoJeEip9BiC5UXiIM4jdlpxEnIFLcpmTLAExwmxrsEu
         DE5PKBy1LTCMWTynAhzQMpM7CWwCNKG+p/cv+jr+GNnsGCsWcJIroavOIVbwQ0k5RLZh
         0WFW27DzzbU8HiwmBt6ucbhCKTehbZxrOi/K53Vnr6pGrjPmL6Okf96BulfY97sZosfx
         maDbxF1GiDQtgzOP9FJmAVCihCD9bOQnmrbXmhj3h3CE8mZgqooa9KSnwtQfEAz6ATn8
         AnbA==
X-Gm-Message-State: AOJu0YwQ7XK93Lpu+spLy6gIT6Me6U7Hv0aOsdpSmjRZVm4Z+dffagQR
	vP8vh+WLe0b83zJClxyrI4Vj+jeoUV7c9XDen9wQYYutNv4tGitG8TDWGsgXxQrJVbCZbUFnxG2
	VmQtQF0Tb/nKLQVqxEG6pZxSjFxBter3dVgkEZ4wyhsMqiXif9jbkp7wkKjn/XDWqYQeOD5oUYu
	y3ZYic+fcllr3++3fx/B8EfQrV2cFbKoeKo0kPXcomMg==
X-Gm-Gg: ATEYQzyYSOuLthek5GTHPEx6LxkUQgCSv2o2yMZKN+w9pbjh19u+pRoGcyrnA+yN87i
	Dp//SuGbXzMS+OBbFM3D2Npt4gUmh3gCuywmKVdKuevoe3ZqSDYfgPOT14RGir9xCBIw7/MNdwQ
	sAKLTZ9vdaQSPH4SAGcukmYHW56MojejZyO9fgyn2BOjMcbkr5u8yGA9GaanAnYtUOHNEXLri+p
	U+IExZO18v2UyrTYM52MNX4vfZT2kmpYPrNoNco08AE6Ql6ECsSfh/CVJjVUvnnOTorSC6G1COP
	RqQjCSjNkte+Uku+NaTHRmZpMLSlaUjjw9EEisAn0Nh0PKah0Lz9hrkK+Tj9ZvXVe5jRqmskCSl
	bFXk8KaEZTTAQc5g/JT2lXkGC1Zil9y8rg1KPvf04CJsF9o20Lng=
X-Received: by 2002:a05:600c:a416:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-486ff0303admr168003445e9.24.1774303863442;
        Mon, 23 Mar 2026 15:11:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-486ff0303admr168003205e9.24.1774303862930;
        Mon, 23 Mar 2026 15:11:02 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee57esm2874925e9.14.2026.03.23.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:11:00 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/7] net: macb: rename rx_skbuff into rx_buff
Date: Mon, 23 Mar 2026 23:10:42 +0100
Message-ID: <20260323221047.2749577-3-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-1-pvalerio@redhat.com>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D94392FE1C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a preparation commit as the field in later patches will no
longer accommodate skbuffs, but more generic frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 0acc188fe547..d84ec528c12f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1277,7 +1277,7 @@ struct macb_queue {
 	unsigned int		rx_tail;
 	unsigned int		rx_prepared_head;
 	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
+	void			**rx_buff;
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 38302cba05ad..fca7b9c6b670 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1499,7 +1499,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1518,7 +1518,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1621,7 +1621,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1630,7 +1630,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2630,11 +2630,11 @@ static void gem_free_rx_buffers(struct macb *bp)
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		if (!queue->rx_buff)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
+			skb = queue->rx_buff[i];
 
 			if (!skb)
 				continue;
@@ -2648,8 +2648,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2712,13 +2712,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+		queue->rx_buff = kzalloc(size, GFP_KERNEL);
+		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->dev,
-				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   "Allocated %d RX buff entries at %p\n",
+				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
 }
-- 
2.53.0


