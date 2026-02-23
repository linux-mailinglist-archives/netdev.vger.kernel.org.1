Return-Path: <netdev+bounces-260153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIrDBTqcnGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35117B7B6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54E5D301DA41
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF99F340285;
	Mon, 23 Feb 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K06vK2S+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdkOn6lX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85433987F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871252; cv=none; b=I/iP5Y4+435BeG3rEG2QmKuIZMH/EP3miXlpwQijOXsZT+PIFpfcMPWopB3aIAZg/ABOcSAM21RpIIm0rc1nBNd5zGt9RRp8bJpJNWU+Ig8cx/cCZpBTBMdzSVPHv5R02TLYCJofvTpC1HHixqkOuEqrPXD2E0pe7rmgfxIRUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871252; c=relaxed/simple;
	bh=Gt/ybORBXuFYqnra/JVdC2WvTktBDNp4NAuqe5HpQTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdlbgIXKktCcosZR5gFP3zNns158ufueOFXuKg19aqlkHhRBHS3fS4z3wAN3RzYbF8PlmHsuJj15lO/0GyQVzpUgQs6o7duz8xm9lL+A7beDECH71foadbXVOAqcDJ4TgF3Lq+0I8Jxy/V92obj50hsfIe8S0/IKZo0o9WEAqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K06vK2S+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdkOn6lX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLbpRX1SSJd3x5MRSo5gnO5pcAxAYlU6G0gCQ7m11Ro=;
	b=K06vK2S+Smde8os7jhGPiDoH0Nk6tuQM1RhMDn1B0xgru9AeAtxxwVaLT5TcZivURNM7l5
	0+dbGbCcI9HcEtUgxVPdFigeBKTNSvnfCUMhjDHPBfzjGb1d07SZBK3O/ZdeizbI+ItTeH
	R8gyWlwQ/JQ3T9iCni4K1sPXDepOzxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-QMhFXW2cPuOeZyHRrLeP2w-1; Mon, 23 Feb 2026 13:27:28 -0500
X-MC-Unique: QMhFXW2cPuOeZyHRrLeP2w-1
X-Mimecast-MFC-AGG-ID: QMhFXW2cPuOeZyHRrLeP2w_1771871248
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48079ae1001so15873355e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871247; x=1772476047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLbpRX1SSJd3x5MRSo5gnO5pcAxAYlU6G0gCQ7m11Ro=;
        b=HdkOn6lXcmi+L7IPq5B9OXUsxki1WplO3H7gqzt2es6y+0pF9op2tK9QHv1cettCMN
         6XwP2Rf6X5lTEL8i4iV80sNQ5LboY+cFH7BaX4giOka5EETSNNpvBe3jxB5bRPgYMLjj
         6+RRxr9/uRyxUe5cvIj/G4pUdo6yGC8NMU+JGrn3xcZFHzxXTQfdlC9vZ+Tz7rUjpMp5
         DczWdg9x64nFjuaDYg4XRDA/HtWeGB8ReogE+1ziSDAdsqZsjo7Z57W6VGZuTsMMI95g
         Y9VKnBIn6ePRgO/T/unflCf/KScee+oAzwpgLr+jolVMqg0nz8PfxfoO4lXeJ+DthIY1
         8O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871247; x=1772476047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLbpRX1SSJd3x5MRSo5gnO5pcAxAYlU6G0gCQ7m11Ro=;
        b=tDbIeUUqE3ICyvjwYSMHei1dVWjuNEEoUQAB8TTJp7ITiI7TiarRC43yfUfzQoBm3+
         FQpwByEnKqXxohrpVlL9mnMWJJLKRZ882GKr/lOrjmVLkli8lhY1MpqQksEnh9Skckot
         Vp3ZHhHGkdVf7UDnhf2GQoVH6P7vn/GpT6UCq+0sZYJIGDFpPnUxQuoa7+9fw7cu7GBY
         GNwc1wPqQGsC8ZdMdH+/hhzjABcabC+DGS1mIfqs3x6Keb5JRRjJSPWnbq9YTMdZ4N6A
         Pgwv4xXKPnYvyoEqwlDsUnAMLMU5pqz/cymX5S/3gcIOiZUBQpRcNErMVHfAeP9PMSnG
         3IyQ==
X-Gm-Message-State: AOJu0Yy1EOptgLiNDI6XSZKf4tbqJXMNqBHDolptOMSt7xL1vXybwqOw
	cKYAqCRLEPjHzx5zMJsu/004bcvk+64NeqMC9ISHQrUcGEPDbQMOTTPVDanaaQUwj0JzRTg8mDF
	5vB6d9sRDW6VVBoah3GlC6eHK1EGyEbDD4ozqICCMNIJbAlSwnII8R6FqUQzmHki6kD/UXqEkIc
	gc6sodSYODolLkZ+c21C4YsjQdahovZD6meW4PMsi8pg==
X-Gm-Gg: AZuq6aJyWe1iOvYuDtFP4kC6UKv8HZl5i1oOUOAzC3sTYvy5YFO7pZbAk/2ZWJuoM8u
	9rJUcgkVULUb0+tcIls+UhDd7Yr11neqHy94K+CZsYVd++qeORimXFKgJOEMjO1ignr94kfP0VA
	NMvlZ7ndxJoxa8t3MQLb2OBkZeaE1+6YA4kmrc1evOhfJPTi4c7b8HhcJ9Tg0aEYSqPIkw/n1q3
	bpujYEBjsqlEE8SNZq1cYivoWc6TcDFtgVHqFZtiBeUEp2QpI8VBpwWd5ibT52O8prkWa2GTr+F
	hxp252V3vUxP5i+qBbrGipXi4C3Osk5wmhguFyC7IVXdJxaTv2+GC7MRSKtoT7GMmEnWa26rBbn
	wTgFihdHdK8uS59sf6HYA6PT/IjWClOgwoUilQkbhvoqCXnkF659A1dH/gmw=
X-Received: by 2002:a05:600c:8211:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483a963c196mr198902105e9.35.1771871246614;
        Mon, 23 Feb 2026 10:27:26 -0800 (PST)
X-Received: by 2002:a05:600c:8211:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483a963c196mr198901465e9.35.1771871246069;
        Mon, 23 Feb 2026 10:27:26 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm257839895e9.5.2026.02.23.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:25 -0800 (PST)
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
Subject: [PATCH net-next v2 8/8] net: macb: introduce xmit support
Date: Mon, 23 Feb 2026 19:26:32 +0100
Message-ID: <20260223182632.1681809-9-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260153-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F35117B7B6
X-Rspamd-Action: no action

Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
redirection, and update macb_tx_unmap() to handle both skbs and xdp
frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
to process XDP_TX verdicts.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 171 +++++++++++++++++++++--
 1 file changed, 162 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 50646ee90672..69392ec0065f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -967,6 +967,17 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
+static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
+{
+	if (type == MACB_TYPE_SKB) {
+		napi_consume_skb(buff, budget);
+	} else if (type == MACB_TYPE_XDP_TX) {
+		xdp_return_frame_rx_napi(buff);
+	} else {
+		xdp_return_frame(buff);
+	}
+}
+
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 			  int budget)
 {
@@ -981,7 +992,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		napi_consume_skb(tx_buff->ptr, budget);
+		macb_tx_release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1069,6 +1080,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			goto unmap;
+
 		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1106,6 +1121,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1184,6 +1200,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
+		void			*data = NULL;
 		struct macb_tx_buff	*tx_buff;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
@@ -1206,11 +1223,16 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
 
-			if (tx_buff->type == MACB_TYPE_SKB)
-				skb = tx_buff->ptr;
+			if (tx_buff->type != MACB_TYPE_SKB) {
+				data = tx_buff->ptr;
+				goto unmap;
+			}
 
 			/* First, update TX stats if needed */
-			if (skb) {
+			if (tx_buff->type == MACB_TYPE_SKB && tx_buff->ptr) {
+				data = tx_buff->ptr;
+				skb = tx_buff->ptr;
+
 				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
@@ -1226,6 +1248,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				bytes += skb->len;
 			}
 
+unmap:
 			/* Now we can safely release resources */
 			macb_tx_unmap(bp, tx_buff, budget);
 
@@ -1233,7 +1256,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			 * WARNING: at this point skb has been freed by
 			 * macb_tx_unmap().
 			 */
-			if (skb)
+			if (data)
 				break;
 		}
 	}
@@ -1363,10 +1386,127 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
+				 struct net_device *dev, bool dma_map,
+				 dma_addr_t addr)
+{
+	enum macb_tx_buff_type buff_type;
+	struct macb_tx_buff *tx_buff;
+	int cpu = smp_processor_id();
+	struct macb_dma_desc *desc;
+	struct macb_queue *queue;
+	unsigned int next_head;
+	unsigned long flags;
+	dma_addr_t mapping;
+	u16 queue_index;
+	int err = 0;
+	u32 ctrl;
+
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
+	buff_type = dma_map ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
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
+	if (dma_map) {
+		mapping = dma_map_single(&bp->pdev->dev,
+					 xdpf->data,
+					 xdpf->len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+	} else {
+		mapping = addr;
+		dma_sync_single_for_device(&bp->pdev->dev, mapping,
+					   xdpf->len, DMA_BIDIRECTIONAL);
+	}
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
+	tx_buff->type = buff_type;
+	tx_buff->mapping = dma_map ? mapping : 0;
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
+	macb_set_addr(bp, desc, mapping);
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
+	if (err)
+		macb_tx_release_buff(xdpf, buff_type, 0);
+
+	return err;
+}
+
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
-		       unsigned int len)
+		       unsigned int len, dma_addr_t addr)
 {
 	struct net_device *dev;
+	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
 	struct xdp_buff xdp;
 
@@ -1393,6 +1533,18 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 			break;
 		}
 		goto out;
+	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+
+		if (unlikely(!xdpf)) {
+			act = XDP_DROP;
+			break;
+		}
+
+		if (macb_xdp_submit_frame(queue->bp, xdpf, dev, false,
+					  addr))
+			act = XDP_DROP;
+		goto out;
 	default:
 		bpf_warn_invalid_xdp_action(dev, prog, act);
 		fallthrough;
@@ -1480,7 +1632,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		if (first_frame) {
 			if (last_frame) {
-				ret = gem_xdp_run(queue, buff_head, data_len);
+				ret = gem_xdp_run(queue, buff_head, data_len, addr);
 				if (ret == XDP_REDIRECT)
 					xdp_flush = true;
 
@@ -4620,6 +4772,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
 	.ndo_bpf		= gem_xdp,
+	.ndo_xdp_xmit		= gem_xdp_xmit,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5920,8 +6073,8 @@ static int macb_probe(struct platform_device *pdev)
 
 	if (macb_is_gem(bp))
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT;
-
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
 	netif_carrier_off(dev);
 
 	err = register_netdev(dev);
-- 
2.52.0


