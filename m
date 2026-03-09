Return-Path: <netdev+bounces-265578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBrOMtbdrmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334623AD9E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE04230C8B5B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224843D3D0C;
	Mon,  9 Mar 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDB+wiAo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG564gnu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F433D34A1
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067470; cv=none; b=C2r5suaolS/llv6kmO4vJbi4NDhAVghpAPZMqkLLN51thT034H7BnwKWSkCYlzfdM1LpCceGpnkaAFaZPiXDdWos2/OJ5bTGanb3Ti3kpht3nAh/i0RmJfd8lxSblJMmXB2tjDGGq9PI/EzhLabaqRcRRl4UBlFW8n49+/stid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067470; c=relaxed/simple;
	bh=PqY5pGJ3PTLtnstUYKFUaaHZR25hzYo8oGnflieeUDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkEAwbvJYeVshkBzujKzucVfMH2zoZSXpCKkidqPpBgmRp8SwbS77q2afnzBv+2JO2cH/QZ+P/QkqXstTj//SoyRm3H6ucyI7K2BPR1UUK/gZ9LWNMODVDYbUUo89GZrwgPNNFPRItIzuKcsNuwHSHzGBUlHsc/ws+SoQRN8w7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDB+wiAo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG564gnu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SQIXfa0pCUtT/FDZvgk4z84kGjdN7N6oX6yNNvP7Bs=;
	b=LDB+wiAoJhao+hElp+ukq1DTShcCUav7fENfiTpoZR0L81+hw0Tr95R9jw7tbUvGPLvhMA
	p8lTO0bn5GzHNIzO9RYmhqrsPftwuVJnc8P/7GX6ju+GDcEDr5cItZ827O8CFZVjcSkcPp
	PyWl2Eo7uwmUqbk6+uO1CYGWE0MRhvs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ogQlYfUvN5aos2lYj22AwA-1; Mon, 09 Mar 2026 10:44:25 -0400
X-MC-Unique: ogQlYfUvN5aos2lYj22AwA-1
X-Mimecast-MFC-AGG-ID: ogQlYfUvN5aos2lYj22AwA_1773067464
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c12269f3so4022330f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067463; x=1773672263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SQIXfa0pCUtT/FDZvgk4z84kGjdN7N6oX6yNNvP7Bs=;
        b=PG564gnuY1DUSkxqgj585wA9K2Ga0k2Ch5Qk94ZFB3W9BV2fz+WiJ57HyRFVRBYJ56
         Yz1ygNMoJmxwOwjLwhynruSFx4o9Sim47i0hyJ7+S1qo9phj8FX3zZVPhKOz/C2I/dKx
         uOumWN4PBlQ+06sqs2vLVOrDH+LVzqukcuQ9LhuMSuFVTNJ4Md5R3vPhMG/hIJPxSFo1
         XbVw/ek9/YT7KPGEm9iX98yMdcR2qyDSTDxgRIIIUaH2Zn4qXPnov4f5iS5oMSCNfVQ7
         +6Og1IRBQMAOs8/K4PH6pMvMVdqRO/kDoDm+Jex9Dqzhnlb62UZGM/TNCqNsqi+RJ9XC
         BJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067463; x=1773672263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SQIXfa0pCUtT/FDZvgk4z84kGjdN7N6oX6yNNvP7Bs=;
        b=ioKKO1WaNOwAptq4q2ua/TkVPS9ua2XjdrdlaodZ8tpbKPtoul5Y7Xn40+ErGo3u3t
         p+NZq2MG+cdhCARZeu8YQo8SFJKU5aE+iHSkLczYTGb9AxFn0nWdaukTyQ11QkZN1J+1
         ya80r3vQOuHdPU3gN7CtLSCEUOzLEslyhx2exnsThGHn5TrpfcV99/AHWhkZGjO/Hkkt
         4M0kYg55i5j3QUn6yWrdBoc0vi0ItXluQcyUGrD7yBXjBO0szT35TTm0kGKSWRyNFaaC
         b/pkz/itNaVZk9OqIBwpG+8b/BrBZ23JmNjaHDDrgxiLTbAXBWyNwBJSC5Wd7+ICvMaP
         /MbQ==
X-Gm-Message-State: AOJu0YxLUX3Tcs0hd6hoXaa7p/VKqyJ0/B6xRQ2EaU07nG9r4m4UwI/h
	Tbrn5pQjRr5jlcCSBbjdl3Sd5GTgVGIfRRG/knVpvBg2B+gN1aCR6TlDEj4G0+EWZZzbhiH8Cx+
	BHAk9jLLurxWywr+32sqBC7K/uXJNMsKUTKLcDLbNlgxdpoIeU/hb1ITuoQ+sgy0TbSnNELuVtb
	mudCv6myldnxqKDDf6U0eJ+W2x8m+Vcmi4QdhZ8lgTgg==
X-Gm-Gg: ATEYQzzGc5pmyQV9vlLcAH1pJCFTja9e61aa28kUDx7L4psIkFFUlvENY56a7Ozzl0r
	gUL8SqLYsUEAM2urIwsYuB97c2N9kcgQLPGYuy9vVnT13xD+J7R0zuF/dc8apoS/eHBzBVUycYv
	iVAQjPvySP6/gMI16qOS92D+5Rgk+kl0d0paO3bIhH8vyXWEFthGD112ejS6c1ggHi/aqdQ5j33
	DhUVgwSgLo7gnTFIhEoCai6Lkvir6fcTxq9VyVshGXrYuThdMeqevAQ17dUZ/Wl9JjtQlzJjCG4
	9aW4yaGJgiQZQErzSv9zWp2qjyZ7c1B8FE+xGrGgNAYjUGiyNH4wlS2a5rrcUsH2kkvfTE+WZuY
	VkztIs0pJyE6d5M1H7Gwqn20l8ujHyRrID2yO1c6xQRClHxm7jLFe5FQEw/Q=
X-Received: by 2002:a05:6000:2891:b0:439:d935:87c0 with SMTP id ffacd0b85a97d-439da65d71emr20610720f8f.17.1773067462829;
        Mon, 09 Mar 2026 07:44:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2891:b0:439:d935:87c0 with SMTP id ffacd0b85a97d-439da65d71emr20610538f8f.17.1773067461345;
        Mon, 09 Mar 2026 07:44:21 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm26090090f8f.6.2026.03.09.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:19 -0700 (PDT)
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
Subject: [PATCH net-next v4 8/8] net: macb: introduce ndo_xdp_xmit support
Date: Mon,  9 Mar 2026 15:43:53 +0100
Message-ID: <20260309144353.1213770-9-pvalerio@redhat.com>
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
X-Rspamd-Queue-Id: 7334623AD9E
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
	TAGGED_FROM(0.00)[bounces-265578-lists,netdev=lfdr.de];
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

Introduce ndo_xdp_xmit function for redirection,
update macb_xdp_submit_frame() accordingly, and advertise
NETDEV_XDP_ACT_NDO_XMIT capability.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 73 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5351979e21ee..838447258498 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1103,11 +1103,13 @@ static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int bu
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
 
@@ -1565,20 +1567,24 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
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
 
@@ -1591,14 +1597,23 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
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
 
@@ -1609,8 +1624,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	desc = macb_tx_desc(queue, queue->tx_head);
 	tx_buff = macb_tx_buff(queue, queue->tx_head);
 	tx_buff->ptr = xdpf;
-	tx_buff->type = MACB_TYPE_XDP_TX;
-	tx_buff->mapping = 0;
+	tx_buff->type = buff_type;
+	tx_buff->mapping = dma_map ? mapping : 0;
 	tx_buff->size = xdpf->len;
 	tx_buff->mapped_as_page = false;
 
@@ -1621,7 +1636,7 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		ctrl |= MACB_BIT(TX_WRAP);
 
 	/* Set TX buffer descriptor */
-	macb_set_addr(bp, desc, addr);
+	macb_set_addr(bp, desc, mapping);
 	/* desc->addr must be visible to hardware before clearing
 	 * 'TX_USED' bit in desc->ctrl.
 	 */
@@ -1645,6 +1660,32 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
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
@@ -1682,7 +1723,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp);
 		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
-							     dev, addr)) {
+							     dev, false, addr)) {
 			act = XDP_DROP;
 			break;
 		}
@@ -4932,6 +4973,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6236,7 +6278,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_ip_align = NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.53.0


