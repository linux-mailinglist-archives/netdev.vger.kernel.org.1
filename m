Return-Path: <netdev+bounces-260147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u/wHIyKcnGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363417B799
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF983079FB4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D95340A4C;
	Mon, 23 Feb 2026 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewkh19rC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="glmM8NSE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF435340286
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871241; cv=none; b=XMx0GVgrRTeh+qmxhSRU2vQb2TwPINzaUfWzrtTzMUz+qlC8AXVdqOiREY532lFxEt/9nch30gwVxnG0ia2Q+k33HUw6YnsvcO+q/R+oaO/zj5hUYRRlmMmjgWlD7q0kmGyzSs06H3S/jht0mFg8RIWImLnfTBn2LzYfaPSKsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871241; c=relaxed/simple;
	bh=PpdOE4d7gGRj9CyarpOoAyrIaLRA85pxUttDlNDCLtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWqkLXLtn5Hdoo/lR25kUxItiXZP0m8Ad77XSPoOHef8Aer7z5GviqpZF2y/+GnZ35agceTGZv1i8gBnycw+Rr2j39JgiJYgsojz1flHN9fOSjkPSdXxZ0AH7d/6WsggQywBpLFcSDapbtAyVIpFD7gT3cIKeYT9bRB0AmkJ2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewkh19rC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=glmM8NSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URZZSLhL0m5Vtwa8KuFxEVTxNgv94do4NCWuBbjaeW4=;
	b=ewkh19rCdgy3BmuaglUSN16+SfipsEPh1v85agaPHBaj4BLNkEjNhHo+r+OgO/IyMAh8TC
	kn0DhitHr/UZN5ZTWg3xjEvBQdbN3Lxrw+iwtmeHmt6ZDtZQkulwJCf4+DAuvzewKx7Wy/
	7s3RweWwORKSMWo/ETOH6gPEIYMBV0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-wzWyXElhPBGyyHXkAsUlFg-1; Mon, 23 Feb 2026 13:27:17 -0500
X-MC-Unique: wzWyXElhPBGyyHXkAsUlFg-1
X-Mimecast-MFC-AGG-ID: wzWyXElhPBGyyHXkAsUlFg_1771871236
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435ab907109so3730029f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871235; x=1772476035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URZZSLhL0m5Vtwa8KuFxEVTxNgv94do4NCWuBbjaeW4=;
        b=glmM8NSE5l/wMiO54J4jid7+6zXbP2LItgwCLJL0/kzvKSQFoFzHqavznMEjC8cZMO
         0tDpkY0oefXRitGngx752vmA1yM0mhwAyI5HoyXmRVt97VqM63JezNBNV9+wA8ZDnvDe
         rkgFdb5uOrCGrhnWPMYxOgoAsvv11K2cswL4xCZfo/5LtPcor5PrLFgw4GmT1aQUFBF2
         ur40E4xl5OfNjNrlwaqbKZaiguVXkFXxNZxGc3EphpNcletjjreC4sXeU+ygwtcXGVcy
         uycEW6QY/pIQqK5YneH3I8oJMx2TiagDCaseynVW4p7ZG5MRzpsVqM5feBoggap3nZH2
         4xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871235; x=1772476035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URZZSLhL0m5Vtwa8KuFxEVTxNgv94do4NCWuBbjaeW4=;
        b=v8/zgDNtZJaC6EQhRdzQkKekxS0b/2/7imhz8sMBxN5jZ7lbZ7npjERPSN7qke+PVv
         GOnbRvTBJfGIZ2pgUIjlZXy2DbV+e7fg4w2pfDSja4iz1yUoqvbTV9XFcHCtzmMwb/Cn
         ooX3RMVRzoJavrLkxvISowpL2dBMOHIU6f0Od+kP4bGCzt2pKfO0bmS+ertRywhWF/sv
         lS4aJiPG7Jds7cWwYQIAJMiQDeYXJGprcIJubxtvX20nHsFTYaXsSBH2lptLkB1uSg4X
         g1RYx9KBOffKAyEwXur/P+zDMJK4300Ef8miynMV3L96Xav5G2bc3pGKiK3U9/OD1oao
         Rx5A==
X-Gm-Message-State: AOJu0YxGO3n+ZiPLo0AVC6gA9CUz4uwyOnRgjvP9f8a0zj70IsnGCEr7
	Ehdf0FdFEuy2RN3BgupFse24rUU3bfOUw2eaPy8IJ0CkUO85Iil8jCTkwUuysiuZLdcvFDS2c88
	NpnA2/yn7sYPhgrvyjBsb8lg0+N/uijQl+rAovaUISdl456KX+lmLh7D6Yx0ucjwlADGYzLHwhn
	PqSt+34Y0fIgT/ng4UdGfefRsSkPxAUUzysM6IXaJubw==
X-Gm-Gg: ATEYQzwL6a/0a9KyHL0T8lCNmLbQRn+mIBCBsAN40OsbCMcGdmO6jDfKqufa2QDN0hi
	voZ81m+dEWWRl2AdQ0Vu6SDzxtaj6MWk6BlP21Yxr7V+bqzkVdbRHA+lzPq5WgMv0Vh+EPq51fA
	8mFg/W3Fw3JyaWT1+Rs+9ZWuc14QTf3Cc+iOiW/ddkIFJSWso4LyxfFzO5ma4Vnx/O12zFhKDKR
	8uxlgOvTzbLHciWPAYKDMKbfZwwh0+Me3wHPvF3sFlaoCqsbsLhFI72Im+LPRK6y5gCTsuGSGcB
	A2nliDheKaXK8h+fOuqt5FEF3ck+2odJEcjIOg8nohYeuMPOYr2/qWWjROntylufaI3UC+kXBZv
	8xj0jpNkw6k+C+wV/D3xPczRPVtUM2ZfHI4mHYKHSkP0GgRqcpP7pVEIbP8s=
X-Received: by 2002:a05:6000:2601:b0:435:a0f5:c271 with SMTP id ffacd0b85a97d-4396f183a30mr17451219f8f.31.1771871235153;
        Mon, 23 Feb 2026 10:27:15 -0800 (PST)
X-Received: by 2002:a05:6000:2601:b0:435:a0f5:c271 with SMTP id ffacd0b85a97d-4396f183a30mr17451143f8f.31.1771871234579;
        Mon, 23 Feb 2026 10:27:14 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm22701766f8f.5.2026.02.23.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:14 -0800 (PST)
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
Subject: [PATCH net-next v2 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Mon, 23 Feb 2026 19:26:26 +0100
Message-ID: <20260223182632.1681809-3-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260147-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1363417B799
X-Rspamd-Action: no action

This is a preparation commit as the field in later patches will no
longer accomomdate skbuffs, but more generic frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2cb65ec37d44..3b184e9ac771 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1262,7 +1262,7 @@ struct macb_queue {
 	unsigned int		rx_tail;
 	unsigned int		rx_prepared_head;
 	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
+	void			**rx_buff;
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8cc16f2b4024..fef9f3b895dd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1265,7 +1265,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1284,7 +1284,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1387,7 +1387,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1396,7 +1396,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2395,11 +2395,11 @@ static void gem_free_rx_buffers(struct macb *bp)
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
@@ -2413,8 +2413,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2477,13 +2477,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
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
2.52.0


