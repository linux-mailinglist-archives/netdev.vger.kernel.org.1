Return-Path: <netdev+bounces-245618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E6CD38F4
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFE1300A1E6
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F002F90E0;
	Sat, 20 Dec 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdc51G1h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra02sjNr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFF3A1E66
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274716; cv=none; b=T/suoXo6m4zUj8L8N32bM7arEpqDjuXSTqul9kJARXjdqizCgpYSe2oVJty4hL9N7V4wIb+BB7Nh3qer2d68nvNymB4P7YWkXLDGuxDMcjI4nJ3+VQVgucTLKr7TJaM+dh0ZX3ov49sUgWcwXL0YNNBTf7ApvhyZ5EZpbQhG/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274716; c=relaxed/simple;
	bh=Z53GAY7kNhDEl5dekZI/wTxUpIzhvPcOE2houKNvZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjBtqqEi5KY6wZtGMibJyYkRIqUzP7MOYPmYIWfSvP4Tt1HQb6b2B73HpvuUBdVzln8U8GgHGXMDiLZO/eBVzWc85AjmI22UmCzr6M1RpUBsL9fAoN3DPSdzRVEVChp7VqC1oU06wvqShEYJKD4xBEo2XrX1V+SJN1ixLgdQyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdc51G1h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra02sjNr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Miv0bXuT2ySMYdDj31ZA6vzlK2OWc8hGfoPjag0P8tc=;
	b=Zdc51G1htMMeWnpeNFiAfG7VbRXMQ9iAUxGuKnaaRre8pmskxYzN9LvfYwIuekUMg1TvMw
	ahDVmXqGXHKm4oF5XZ8z2NCbaRrIbHqf7r/BGtKnkxoyRNGXG/VhCcBBSTQbqsQQ31tg93
	1ATb8tK4Fcu8oTmJN7ojuR8jTinjzsM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-auF-oknoP8uw1iNtdDIoDg-1; Sat, 20 Dec 2025 18:51:52 -0500
X-MC-Unique: auF-oknoP8uw1iNtdDIoDg-1
X-Mimecast-MFC-AGG-ID: auF-oknoP8uw1iNtdDIoDg_1766274711
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7ff8a27466so309403266b.3
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274710; x=1766879510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Miv0bXuT2ySMYdDj31ZA6vzlK2OWc8hGfoPjag0P8tc=;
        b=Ra02sjNr9xb03tHRfcpInwfUOeCF3Ke7jDr9IF1mg+9VT1zr3EjKsUPIURJzmYwoHD
         thXDi1jn+wsa+XR0LnqHf9kEyL0988CgERsDKvkyCrC9jG3lr/0jGuuV736Lr+gpPXmX
         T0AO8fCaSw+WYxG/tF3INSGX0GXGT08TSmfXDDlK4dtMJ+nd4Va32bY/Xz8oLkHuyaMA
         QEU5d9TELyE7G0AkCI7LPca01uK/gcP+8MJY0i6m7X6Fm9uy4N5JY/S3cpVWfwsrHJWC
         lEP8WbrRuwXRihj4DIU+alUV0Ni7nxH5Ssepb0sYEL0syLv9l+C2mbtOLPqJfoXfLqUK
         pHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274710; x=1766879510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Miv0bXuT2ySMYdDj31ZA6vzlK2OWc8hGfoPjag0P8tc=;
        b=eV25OSIFrOl8z6/4d4MLqxGPc3wXkwH6mIQVO+NNsLSQMw3CVZd8YsoKfz8eopeEoy
         tVG2bPE+nHrh1nvKzOm6i9G/nDm/RwYlMXZhWDKgezcblHIva0b9eoa/mqnMezrzL8q+
         YMkTuO1xDvOWjIr3EPArVZ5MVuV7QFgHA7jR6Forcl9+VVxPywIY4cy7HcyL/1Yvd5ef
         2/owdEjNkWjmXgsYze6s4W4VWg1/YCjicZZJGER7pUXJOA1Aajzw6iaC7UAoM2oyUjOo
         qma0oa2huKDJ/k0KLrnqm/z5CHyE7WujFpW0JEnhWvat7ov8+tjv7lAv3wHziRpuAt1E
         hiYQ==
X-Gm-Message-State: AOJu0YwPafKnZf7lpJhJGwX2NJU9t+yo3J2jGRmSHPbwxFepBXXTd22O
	vXVBTnaHwBzFMJHG1PLX7+BvPbcApmxYKJdKCKxSdf61P9qMlxee5zZnonf1ztXOP/XxIyUBxJ2
	c5h/Oyk2kB7/QaZJl5vtZ90orAOYDHQxH0eQq7o9Bf5JdNInNDDwZH5CYH+CRpXqgjooFPGYAux
	uHV/XMvjPc1e//2Y75dcpi/pBt3laNSpJbBV9L32WoYg==
X-Gm-Gg: AY/fxX4MqL9wB6o9/bdSXcAOEb/fshQKw3l0hq8bFkCLvYdb7EjU30Jik00sX9Z6PPn
	JSS4xLx+0V7+Z7Eg19cxNnEGt+kCnT/V8WILAk0nMgSLa9bBW9eNVXzy1zHFr+q7sfupJLAWx+a
	fC2l6t1It0yYdC7iy3PJMAlv4Woc2ZxJnl2mDqwwwRH2M0KhpcN2I4RtKhvSPLugqx1ztq/9c9O
	Ao1eiDZnEghsM4oJtx8hFdq02GuttKHcKCBbG56gfDm6IvaZrYvVLIzoXNDFMrLzI0RS8bHRTwj
	nb3Xxk1HuHwngz7SYPhTY3XxHRpeHGtm6/eNol5xuwozx3px1aWUV00JTJkn2ALpEar4RSWLaH3
	i8FsxdqUp+EwDGVKF/ApGRdhRSLRop9Xe1KM7hZ0=
X-Received: by 2002:a17:907:5c8:b0:b73:544d:b963 with SMTP id a640c23a62f3a-b8036ecf4c0mr678175666b.13.1766274709865;
        Sat, 20 Dec 2025 15:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJcqSDqRZeOLn13aQqjVn27jTiobqWvu16cfoByIVOd340scaI8SfpJ2/Kb+WlC0zm4pu1RA==
X-Received: by 2002:a17:907:5c8:b0:b73:544d:b963 with SMTP id a640c23a62f3a-b8036ecf4c0mr678174066b.13.1766274709333;
        Sat, 20 Dec 2025 15:51:49 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ddffc7sm626724066b.43.2025.12.20.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:46 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Sun, 21 Dec 2025 00:51:29 +0100
Message-ID: <20251220235135.1078587-3-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220235135.1078587-1-pvalerio@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation commit as the field in later patches will no longer
accomomdate skbuffs, but more generic frames.

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
index cd869db27920..b4e2444b2e95 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1267,7 +1267,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1286,7 +1286,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1389,7 +1389,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1398,7 +1398,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2397,11 +2397,11 @@ static void gem_free_rx_buffers(struct macb *bp)
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
@@ -2415,8 +2415,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2479,13 +2479,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
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


