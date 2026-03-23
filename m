Return-Path: <netdev+bounces-270769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE82FiS7wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:13:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C422FE219
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47D6308545A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DD3822A2;
	Mon, 23 Mar 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsYyuxlh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hga1GP4p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B93803F8
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303878; cv=none; b=I1UqhntgPx7c+LTSCBkJUPY1aadsQj2/BT4lQpUjC9udPqMMkHShpQtjBRNtbdPJsx/Rwz6oQDq1wOIdL8wjsG40k2E9qnPkkojUuGsV5ROrwM9az3E0tAl2TKDzGKcuX1KZHX50z2KiSNN3McItPv9S/Sd4/Gw9RvEsPiuuORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303878; c=relaxed/simple;
	bh=wsnx7rw9XNY1QMH09Dg8iD/+loHFlYnOEBQqlP7XOf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPttN1X8grZv7Qf6cunRfS9gWaxr7gaXVbC6I+8FE7LAu1BuAZMqZhYuK5gZMtQdjQT3esJR/cdrMDpz4gHKtiPjfhJmefK7BCzsc7rYTT5RQpgoB2u+adACfznHmnCCPlaikB2S5lfCuGFZEXpwCJOMp1mIJjgE4pPfGxSp7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsYyuxlh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hga1GP4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8NELfr7H5ZEIT3k0IT70ivWUR+4W34TKSe7yVtQgmw=;
	b=IsYyuxlhWe374IAqbWl2IJTv5pJYcHutpzG8fg2GjhaCOMiX4HbJ5GgQZ0iQIHV+yZ9wwV
	yStwOc18F54Gndd52nSSj+a4wUCgeXzL5e93CBY4V181wDR/MRHsE3OTifRH2v7St6T0eq
	fkAAyvCT0pwq96b0EQT+UdG7/hV8FM0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-EXEYUdLYO1u7b1fCAs2yKw-1; Mon, 23 Mar 2026 18:11:14 -0400
X-MC-Unique: EXEYUdLYO1u7b1fCAs2yKw-1
X-Mimecast-MFC-AGG-ID: EXEYUdLYO1u7b1fCAs2yKw_1774303873
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so60921065e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303872; x=1774908672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8NELfr7H5ZEIT3k0IT70ivWUR+4W34TKSe7yVtQgmw=;
        b=hga1GP4pZgKBUa5m3jXQ7nnkMfh5tI5YjxDoJam6Bbm8QlNwCbrVmUQ7fXap36wPwo
         4EhHTXb4MBtP/9m57x6uo/yCo/+UCCZkGS7VAsrZ24DZpAsEzi1YGc9OVe/vtDiHzqVy
         3u3qlhnauhmY1nUCECV9zAgt5v+oojiIgxhrJoEVDZcuC9OIN3FawaF7TLbfKD0WvykR
         2iYwqiv0CP1SvfS8Y8SKOT3s1Zjhh1A4dP84TV+pe9tUvklqp5OnF9IXck2Kk/Xr1Sna
         RrrofkbFJ8QQCOsnNL8RNCveN0xtBl6CW9OVz6js8zA34hgJY4ofdJ/Kj1QTupo+rlFN
         yT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303872; x=1774908672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8NELfr7H5ZEIT3k0IT70ivWUR+4W34TKSe7yVtQgmw=;
        b=eyAR9bmGwfncQTpyeHA2whrNHR3atK3w+CtXYFYN0ML2Aacjo/B83pxmsRHtxoNEWW
         2vpdDYDC5q9TJRb1Te3uussNW4HMvjjwMz163NHcWVdfqFvhi/0+NsEp9KUfmCuFvyoI
         1EGvwO5yDzbNOsOQC0YpV1og/BZc10DRJxOI0aKGE6r5NB1X4thrvF4A0/RjSGitfsEU
         tA9ihFvWMUCQ31pUo9GKzexEBPVYOY1C1ToDYWWWSWgcCwKn/KSklG0A+VtPGl4ugWFO
         XJQFuYSGNIKtoqVgEmk5+Eeu6pCVosX1fU7cr598rimPhHS5pTzgYrOjJxsYBeY0V3qf
         xpQA==
X-Gm-Message-State: AOJu0Yw145RN+WGeNaE2g0fUfpZeDEKVlVkMpYW9PCxAcJzRNRpPAbU+
	V6hJFhxEkMhyEWC2cKp9Fis95i75I/wiO0+DYyyL3So0Xe5lpnNwBcW9M2GFacg3tCY9k43UiPO
	eF9ep3Mv8oVPLiq9LEF0grUr9bggboasBzT55WJIE15ufuSKdZBqs+IYv1sS+hAAy6v8y567Tmu
	ur/dV4wRhV4EExTIq/Hg/GQ3AH2fK3agMIL89HazVcoA==
X-Gm-Gg: ATEYQzwHg3zdlmsEfw8muQAfowNRuvuQ9QBLofvH+LccE74FF9T5JhN53iPQ3IfqAfT
	h2vMjPxjjPGqfDewXJWe/ZLvFmbRk9kLY+crkmMPTt+oWU5ZBa5WWkdV30gvTcSWOgNtU+TZWu3
	ebxPCT24HhMpD/4T/G7YmcvpG/LoTnNUWZ0eYyRM0ZnmnkzfrrRizH86PHW2/edMmoUE/l58L6k
	AWdd295epF8La2ajidT0nwxZcKJB2QiLlczJgDvsTHAirvWKjWerPh7vYEbyk3TmmM8bOeoSer8
	nJlvB4fyjM6WNFrDbKgzUDACePgyr4tS9EU/vTyn1muIbKNUFzQBhD0Jo9OHT+DRAa6hkDPdi5o
	u4C1Fn+MzDM1uqbvRAup4x36gVMVRZzca5Wae1GXMZs5EkEBNE4A=
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4870f212c1emr16495595e9.13.1774303872277;
        Mon, 23 Mar 2026 15:11:12 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4870f212c1emr16495375e9.13.1774303871804;
        Mon, 23 Mar 2026 15:11:11 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116abecesm2867035e9.5.2026.03.23.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:11:11 -0700 (PDT)
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
Subject: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit support
Date: Mon, 23 Mar 2026 23:10:47 +0100
Message-ID: <20260323221047.2749577-8-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270769-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: B6C422FE219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce ndo_xdp_xmit function for redirection,
update macb_xdp_submit_frame() accordingly, and advertise
NETDEV_XDP_ACT_NDO_XMIT capability.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 73 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 537d02264851..38b15d1e7127 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1202,11 +1202,13 @@ static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int bu
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
 
@@ -1664,20 +1666,24 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
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
 
@@ -1690,14 +1696,23 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
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
 
@@ -1708,8 +1723,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	desc = macb_tx_desc(queue, queue->tx_head);
 	tx_buff = macb_tx_buff(queue, queue->tx_head);
 	tx_buff->ptr = xdpf;
-	tx_buff->type = MACB_TYPE_XDP_TX;
-	tx_buff->mapping = 0;
+	tx_buff->type = buff_type;
+	tx_buff->mapping = dma_map ? mapping : 0;
 	tx_buff->size = xdpf->len;
 	tx_buff->mapped_as_page = false;
 
@@ -1720,7 +1735,7 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		ctrl |= MACB_BIT(TX_WRAP);
 
 	/* Set TX buffer descriptor */
-	macb_set_addr(bp, desc, addr);
+	macb_set_addr(bp, desc, mapping);
 	/* desc->addr must be visible to hardware before clearing
 	 * 'TX_USED' bit in desc->ctrl.
 	 */
@@ -1745,6 +1760,32 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
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
@@ -1782,7 +1823,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp);
 		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
-							     dev, addr)) {
+							     dev, false, addr)) {
 			act = XDP_DROP;
 			break;
 		}
@@ -5043,6 +5084,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -6333,7 +6375,8 @@ static int macb_probe(struct platform_device *pdev)
 			bp->rx_ip_align = NET_IP_ALIGN;
 
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.53.0


