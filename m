Return-Path: <netdev+bounces-265572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBnTIujdrmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960223ADB3
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7429D301EA23
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A43C199F;
	Mon,  9 Mar 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="an+vCmD8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ttq0Z6xn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4603D348B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067460; cv=none; b=R1HN4DLcN2IDfaHnNwsa5IPHQlbgYr3nPZ1SdVNQ+Xg0IYocyTj1a+QwnyrvMcjA2FosEBmHyGki34uEGYs8ymAkpgNiapfasSopmlFXAQg/q6NmJoiBTs599BcN0OiJUsQCucWAnoXDxsb3SylZ7xmlHxGEM3IhbQoPHBLR3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067460; c=relaxed/simple;
	bh=fbQ74L2IZVj9PLnIAuUkPKrCf6WdPW/aIq1x0Q71NyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnnxjPwDX8gcruCl7I4+7ZqbvBUcX9jv9MJA1nxj8AvB0+Ab2eMZHaDIdJ/8kyA65OjeyKkTsWXXbqikpS4fqr7wL+SJUaEuoq2R50OX08CToLBzbEId6jOX5Rxho7jz1MklDgbY8w/bPYX6uGChPdmGafPLJjKpfqlaG5VKs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=an+vCmD8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ttq0Z6xn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l57UhaCPiRlXVKlOAg9XUYAXuwH6SjIOkiSjTwl+34o=;
	b=an+vCmD87QncWUI8QEQ6n5GmP6UAK2UiOhJx1s42vi+w93CbPNEC5EvST5CYGem+qbty+K
	PtIIgeuhtt1UR6gVniffyJRmaDXCYwRsSm9dFCgD9hlHOdTf83CpVuXfLsR0zPmO/hGDM/
	Tt6G3WGT/7amkCyNqHginKjmYfNOYPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-LmafbX8IPcuNiK00sMDGlw-1; Mon, 09 Mar 2026 10:44:13 -0400
X-MC-Unique: LmafbX8IPcuNiK00sMDGlw-1
X-Mimecast-MFC-AGG-ID: LmafbX8IPcuNiK00sMDGlw_1773067451
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853553944fso13911895e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067450; x=1773672250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l57UhaCPiRlXVKlOAg9XUYAXuwH6SjIOkiSjTwl+34o=;
        b=Ttq0Z6xneFP6duqgo53ZUlyDtj3fgFSWmbhg4ueWQI906MInCudKJsH/v6ekj788cS
         7m795fqUvStZAta60ywLxAXzq6mQMpiPWqSoCFQT6jEizh6da7xrbe3ZnrFimoxQgnJO
         Ctlqu83zb0tUe4iv5nni0jo7PWiBq/RfYcqpePRptv0ZRPMu3Tz3gDcvdUtoraX7EPwG
         lM8YwipofT6LwtOkxY4QVoWfspHE7U0LYXpQBJ3M/2h+IIiNoWHr0c1FWMWkyQ8aA5on
         tmOL9PE8i/ok4whP2r6npFmglrzLc3muAu4hfmWZH6owZU6rBfkjNfntNb0BxG736ynH
         UFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067450; x=1773672250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l57UhaCPiRlXVKlOAg9XUYAXuwH6SjIOkiSjTwl+34o=;
        b=CZGWlbIctx5TUGmYJC5KT73mJ5XSM9spM/+h/hI4nkUVoklGEinoX6Vbetmo19C1DF
         7LCiKIp7Bp+Gr6E4EeonJ4iQMxOGBkmgkT6JbOyyx6Ye+xaiis0lswaweqgZ+GBhvqxs
         +nMB33xlVJ0Rj2SRABt+jicI5HSfeNIwVapUYqFRaAPeUqjsdlEM9sETOeKgZVC42AfY
         sgxSefJ9GRYsJH5NQNa4k0bGmUmqKqU9mi66gmEWB17dtQTiWNI0JWEHWWSQT5FQphDi
         sEC3kKAQo7T/mRbignh25b0oAR54mtxoL/tQEvQE7Z/PPSFsjL63DsyXvPQQ9g+hjl8b
         DIgg==
X-Gm-Message-State: AOJu0Yyr+AZEtFzf3WjeI8A6csEHfU1+olh9wN53FHgaW3i8sQsEWsJ9
	V7qsOUaQurhqdVzKodlvVeMJbdUYG9efPpTw/08VH236sMja/qtZ3TlfDS0KDyCNbOKJDz/LGrF
	C1AP9gX1ADmGYd4zxvPyQljHoU9CpPqAePq2vAeJ0s/gJELKpJ2l7hBk43PtsbBjRS+pxUDFV4/
	rVrjY3lQEuGm/MKdnOPoQS2NghRxbZjTWrdZJi9/0Rfw==
X-Gm-Gg: ATEYQzzr2qC5H22Io9dHmqeHFOnEYcrJCAfGziK6GR+8f4e4P+lKUp98bKjG4n7zVtR
	/HbPeytxhf33ZA2ItovBYVBypDb16IYNKlP2o+IjVlzeQprW8mvhrS+mgVLRJ6wlT88ahtlHdmE
	oO/Ezo2r8b24i2nnKFd38fhFNfmIAlCnFZhlbus7ME7w96QGJNYlED1Amp7I0s+n8XkM3zPyEHJ
	pQbE8+DnaT6nLvQkiZ32sE9wbRakZHEaQ96hEH19d5cjhqXEa3NvMvIm3f44oRjNvElN6OlP+9l
	w8zlFbtuEQuK5H+sjEUE93DYvJqkICf7rpc9diOgSyiknuwsa7N0IGgkloXhWGtH4itWzTmja/c
	yN9vbYXI3BdFnDLxb1hR9rJGFZlc8k6zu2AXNtzskHItxYI1QexUFVNA4kC8=
X-Received: by 2002:a05:600d:849c:20b0:485:4035:53a5 with SMTP id 5b1f17b1804b1-485403555e0mr18954325e9.12.1773067450312;
        Mon, 09 Mar 2026 07:44:10 -0700 (PDT)
X-Received: by 2002:a05:600d:849c:20b0:485:4035:53a5 with SMTP id 5b1f17b1804b1-485403555e0mr18953885e9.12.1773067449753;
        Mon, 09 Mar 2026 07:44:09 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3a20fsm26729446f8f.28.2026.03.09.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:07 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Mon,  9 Mar 2026 15:43:47 +0100
Message-ID: <20260309144353.1213770-3-pvalerio@redhat.com>
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
X-Rspamd-Queue-Id: 8960223ADB3
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is a preparation commit as the field in later patches will no
longer accomomdate skbuffs, but more generic frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
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
index d59588ef2f3f..dead0283512d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1400,7 +1400,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1419,7 +1419,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1522,7 +1522,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1531,7 +1531,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2531,11 +2531,11 @@ static void gem_free_rx_buffers(struct macb *bp)
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
@@ -2549,8 +2549,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2613,13 +2613,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
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


