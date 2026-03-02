Return-Path: <netdev+bounces-262634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAh7Lo57pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:59:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCFD1D7F91
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3851430D7339
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B013644DD;
	Mon,  2 Mar 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAVyGMva";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1PUjfv6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101E364941
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452377; cv=none; b=INIp+yY1fO7YXbqrUic3uM4omHbEPisYBWoLt01sO2MGtrFiX8MKIuO5u97nbWUJkDfzKVytY7P7bxJh1nfCt63PZ19lcmtGZ3BtgrvE60MEUvq+enLOB6m35ntNuODK9dmXyBgIQn2E35r0ZpcT5OdPZXXuuMCj4ehjZTeCg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452377; c=relaxed/simple;
	bh=7RYwVa1iXce2DZHEtCu06xxf+OIuYrobN+MEWwAkCzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1mmA5ddR5tuIoASqSgBWxCmcR7DJwkF98T+zoRNcfHBUqny+VafVitwF9HXK19HoNBA3GYYgiAlwkE6bh1JpeKXFHX8Ikqglw1MMk71VUkGRXCvCnWxGOeCcv1GM00vF9+u4/0WXlH9gkwdgLXYNak+NfcGUh5za6tSOa/lnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAVyGMva; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1PUjfv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22PKvKGRF7riDVxQVy1/SQxnivI/7TsWdmn9mXiYokk=;
	b=GAVyGMva6XMLkjpYS00EwReLOm77upgNOWze+EQX9puh3MyMLnXQBX4JtgfAkFUPQwhe5Z
	TfDZWWNG43Y5BKcd7u2fPPAX5Zxtglebwkz08Be4SZkT8eapnDEIuRSiuQ+i2uvEb3vHjd
	uxZpxYERqvYABwEP7g45CmEyWXPXViM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-uQ80SHFlPciQxF8nvkSG9A-1; Mon, 02 Mar 2026 06:52:53 -0500
X-MC-Unique: uQ80SHFlPciQxF8nvkSG9A-1
X-Mimecast-MFC-AGG-ID: uQ80SHFlPciQxF8nvkSG9A_1772452372
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so43893845e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452372; x=1773057172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22PKvKGRF7riDVxQVy1/SQxnivI/7TsWdmn9mXiYokk=;
        b=Z1PUjfv6K+Gf65X6E2UrBPIc+qKY5mXlf08m3RSMdcv9p5YAJMcJIthIeqb2o82tla
         iiM9o5qm1TN0O0mRm1LB6WaeLMLvv/t+YAJIdsyvvW8/+pVvTcaMBHMA6x3du4RlZsd8
         UcuokP9aMq63ZG4zdWtem/j9ZzsNciQHmLeajrN1vLepyIGvVPTRVZAYZUG/JXxh0cyl
         q1eXBqS7qfC2Y3Be3+2hX6MVhjORwGXetVnJ1Y+neV8+69EVvhy2NgGBiTjWZCyCK2mp
         NoC1P9XbTmDyhyMe31hMINJsZeJuV/z3bhb0BpkBJfeQ6VOHvE8n9aSQgwBs6W3t3UyU
         7FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452372; x=1773057172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22PKvKGRF7riDVxQVy1/SQxnivI/7TsWdmn9mXiYokk=;
        b=YbEaEhNSRYik8LmY621TNvTJz5c0mQNzM1i+wLbKJVNeempCYVrh56fSUiPz57pIRn
         q+Ig9CULpLFqiaJzDETPzSG5r8/ZhhiQ2mhNoSr6anGoccxW7j0WIaWdmOx+HnL3gMxh
         avF5pgDWvHNpGf5GoDKcnC/SeS7yPCrT/VWRcIsgaEcG3r4i5rUoPOWv0YRpO0V0xZn/
         bYznCBtqQ8CUcnFQmQGYe6T0kmL2MUx0KKlS01WTeN2CsabWtxw+SEBUFDgrEsjajNa8
         c6xdg1JB15rY1TEAohoHGCAXKTHJakwQN2O0Wt+L/dMXm9lwlp1ihkVxXLza5ma9P3ks
         FGAQ==
X-Gm-Message-State: AOJu0YzDjhq83OMe+it7HvBjX2bDNRg5vm1yY/3rRDatG1u4x0okYv48
	FZ4xiw0ef4G6KkRxEkGt69MowzpjT4J+dO4gI4hFrYZ0NouZ/WGqWgcMHH63ncujUyHAmT0ZtxZ
	m/fNrsKPz0mOAFK81Zcl0oiLAylqH2M5sBwKfszh0f3SHV+6s0hmHC5ax1p50ReY0essM/fXGTm
	LI3wkW0tgmz3VExfQln7RsoeyNUua8N5E8HCXJU/FiyA==
X-Gm-Gg: ATEYQzya2+u2hDb6dY4wbChWYQSuoF3N2LgxMDytqDSlmbXq425P+rxL54dimHVngRW
	YV09U8r//dBS2/Y42roUeV5gOTz+thebywJCzOQybaUN5txKL4kEYNX4rbvIkeAlfPTwrrEyxvY
	Gnh0bHPT+gDeQ/KG+LMau1i1mvCqtIUR2B53rCK+LXd2+e3pBKDIElGCqdM4ePfpwbLkarGb9AH
	0ulLhOzY5a8zgNGhiuKgXqsHsunUUJ0mGgWelCyg+KT2k9CJSG7iz2IGV+PlnaxaNOW3ZrsKUmD
	Vn5SMymYkVqAP10sGtZHnHrTj2zhhzWcDmBhT9fcseCueIcTiADNyR8KfY3YUKyJmGtjz/pTNk7
	gus0rKLdAVm9sevsWeZ4sf1+eJSUKjyHtMz5jzrOrva9mbiio6gdFvBsyHLo=
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-483c9c2059bmr177605675e9.32.1772452371607;
        Mon, 02 Mar 2026 03:52:51 -0800 (PST)
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-483c9c2059bmr177605215e9.32.1772452371137;
        Mon, 02 Mar 2026 03:52:51 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd765604sm352455425e9.15.2026.03.02.03.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:48 -0800 (PST)
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
Subject: [PATCH net-next v3 8/8] net: macb: introduce ndo_xdp_xmit support
Date: Mon,  2 Mar 2026 12:52:32 +0100
Message-ID: <20260302115232.1430640-9-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-262634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BCFD1D7F91
X-Rspamd-Action: no action

Introduce ndo_xdp_xmit function for redirection,
update macb_xdp_submit_frame() accordingly, and advertise
NETDEV_XDP_ACT_NDO_XMIT capability.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 73 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 152cbf5eb33a..57bea3555d8b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -987,11 +987,13 @@ static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int bu
 {
 	if (type == MACB_TYPE_SKB) {
 		napi_consume_skb(buff, budget);
-	} else {
+	} else if (type == MACB_TYPE_XDP_TX) {
 		if (!budget)
 			xdp_return_frame(buff);
 		else
 			xdp_return_frame_rx_napi(buff);
+	} else {
+		xdp_return_frame(buff);
 	}
 }
 
@@ -1442,20 +1444,24 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 }
 
 static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
-				 struct net_device *dev, dma_addr_t addr)
+				 struct net_device *dev, bool dma_map,
+				 dma_addr_t addr)
 {
+	enum macb_tx_buff_type buff_type;
 	struct macb_tx_buff *tx_buff;
 	int cpu = smp_processor_id();
 	struct macb_dma_desc *desc;
 	struct macb_queue *queue;
 	unsigned int next_head;
 	unsigned long flags;
+	dma_addr_t mapping;
 	u16 queue_index;
 	int err = 0;
 	u32 ctrl;
 
 	queue_index = cpu % bp->num_queues;
 	queue = &bp->queues[queue_index];
+	buff_type = dma_map ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
@@ -1468,14 +1474,23 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		goto unlock;
 	}
 
-	/* progs can adjust the head. Sync and set the adjusted one.
-	 * This also implicitly takes into account ip alignment,
-	 * if present.
-	 */
-	addr += xdpf->headroom + sizeof(*xdpf);
-
-	dma_sync_single_for_device(&bp->pdev->dev, addr,
-				   xdpf->len, DMA_BIDIRECTIONAL);
+	if (dma_map) {
+		mapping = dma_map_single(&bp->pdev->dev,
+					 xdpf->data,
+					 xdpf->len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+	} else {
+		/* progs can adjust the head. Sync and set the adjusted one.
+		 * This also implicitly takes into account ip alignment,
+		 * if present.
+		 */
+		mapping = addr + xdpf->headroom + sizeof(*xdpf);
+		dma_sync_single_for_device(&bp->pdev->dev, mapping,
+					   xdpf->len, DMA_BIDIRECTIONAL);
+	}
 
 	next_head = queue->tx_head + 1;
 
@@ -1486,8 +1501,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	desc = macb_tx_desc(queue, queue->tx_head);
 	tx_buff = macb_tx_buff(queue, queue->tx_head);
 	tx_buff->ptr = xdpf;
-	tx_buff->type = MACB_TYPE_XDP_TX;
-	tx_buff->mapping = 0;
+	tx_buff->type = buff_type;
+	tx_buff->mapping = dma_map ? mapping : 0;
 	tx_buff->size = xdpf->len;
 	tx_buff->mapped_as_page = false;
 
@@ -1498,7 +1513,7 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		ctrl |= MACB_BIT(TX_WRAP);
 
 	/* Set TX buffer descriptor */
-	macb_set_addr(bp, desc, addr);
+	macb_set_addr(bp, desc, mapping);
 	/* desc->addr must be visible to hardware before clearing
 	 * 'TX_USED' bit in desc->ctrl.
 	 */
@@ -1522,6 +1537,32 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	return err;
 }
 
+static int gem_xdp_xmit(struct net_device *dev, int num_frame,
+			struct xdp_frame **frames, u32 flags)
+{
+	struct macb *bp = netdev_priv(dev);
+	u32 xmitted = 0;
+	int i;
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	if (unlikely(!netif_carrier_ok(dev)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < num_frame; i++) {
+		if (macb_xdp_submit_frame(bp, frames[i], dev, true, 0))
+			break;
+
+		xmitted++;
+	}
+
+	return xmitted;
+}
+
 static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 		       unsigned int *len, unsigned int *headroom,
 		       dma_addr_t addr)
@@ -1559,7 +1600,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp);
 		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
-							     dev, addr)) {
+							     dev, false, addr)) {
 			act = XDP_DROP;
 			break;
 		}
@@ -4791,6 +4832,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6094,7 +6136,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_ip_align = NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.52.0


