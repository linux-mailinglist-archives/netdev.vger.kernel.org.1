Return-Path: <netdev+bounces-250332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0AD29035
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A77F30133B0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36065238D27;
	Thu, 15 Jan 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvjohhKV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvQaIJmf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB632D45B
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515977; cv=none; b=hkFtu+AHTrM3pyzqIX3LhYeskEqOTjWxgD5HogpHdqsoZXsVR9jr9eF7hAs8T1k/ev2GCq0TrapKhAmpV+5faQnZXyS1S3EBJPEkZOMpWA7fL/d6Zsw1iakQ89JDd2A17hNyrjzl71KFS51/oLYP+8K/xP+LverOfjZxYcI9LRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515977; c=relaxed/simple;
	bh=CR6emNzkWLkCDE8A/PEwKLjYTtkGEDDL2C6ZLuSGjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIk3KyIhb4NMgLdj6zyoxcY9ttq4twHXBY+XhfCPV7fZ4sxNG7mS5Nn3d+M6/60L1pe2SfquSz1Ml+zkqZ3ZL+bvK3kVhtE4n+SlwHCGHJ3snZJ3KtCZxo1vQvLXzDJvSFWRP3rGaQ+3aNJr4xrHI7u0gskenjaqdULbaxca2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvjohhKV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvQaIJmf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DW5Nxfj4WjWl8epffuQ5gCUTaC7titTkpF9YmpPfOWI=;
	b=MvjohhKVwjx4j/clsBD/iu9dL0hsqRM/NqbKBFFDJgGFJLk/xWCJt81b65tbXUqLNmVWji
	+JUzhOPjQ1wHE1P8JShzHIoUrOrlZY2z/YGtITD+X78x27yNg2ns6WOeWC9EdJ3S2zT/qh
	A6HPQiHQMAy7I+qshY/0pdpyXyz7y1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-SjiBPtZrMtOjEuSEaSS4gg-1; Thu, 15 Jan 2026 17:26:09 -0500
X-MC-Unique: SjiBPtZrMtOjEuSEaSS4gg-1
X-Mimecast-MFC-AGG-ID: SjiBPtZrMtOjEuSEaSS4gg_1768515969
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4801e9e7159so1084085e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515968; x=1769120768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW5Nxfj4WjWl8epffuQ5gCUTaC7titTkpF9YmpPfOWI=;
        b=XvQaIJmflt+Wc+1utdc/PTeyCLxtyAf4P9q4nGXO1WVCuVTgwV7yrH3rmscPvge9S/
         A0v23cIul+BSWK23Rbv0SKb0v1WCsVo/Vj5eog0o3ip9U4bp0jhphmSV0xCLoM+zgPzw
         0Qrqbpq+i3sbQos0EQepigcEf5OcabwcewRT/lOT7fhR3mVYB18tCTGzPvxZ7j2g7rrW
         z6HkMrxHTcpt6GOkcNYp7bACULCmaTGdHc6hb0yp08IAk52C0xqmZJHvPrCXqsGXyDT3
         yHJTLQl1IeUiiSTdMuYVd9Az2bBpgqaNPDcHX8l4uqz0mPVvAuDFN8sSNq+tZpgvhAQt
         4LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515968; x=1769120768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DW5Nxfj4WjWl8epffuQ5gCUTaC7titTkpF9YmpPfOWI=;
        b=QEcFDSH7h/ULJ1zYitbo7296k+v1cA22mbpBMq1O4pHxe36E/JZFe4x1SVfW3BdTTF
         Yhsu3j2Lt0sSY07T59qpklUZGaTTKYGZmR5qRBi6PTYWjP9sgczEl9+ctsFC4iZPZ7RR
         2o6jCtqajAwmFlBWiYWFMGX5vObFAvPxTXISsSGfrDRcMvZhdM4ccx0949PuonbdvBzw
         /LHOXIojoe9J+cpesDH5oSEMxEFe5+YtfRpfArFe8Fp+lxRZC481XNUnOGztV4zLAV89
         xuoXIPhQZOSo+WyYdY4uIOvJHZrazB4551OhIB1OWMEmc0ys5TNmMuIc/yGDfscsylx/
         iGoQ==
X-Gm-Message-State: AOJu0YwshW3hWHEQ9tX9aJQE8FqlszO/ENx0csBr6J5bwl2b1SvAhKEd
	6z9mn0U9YMTIsDhMDMKfTO1bSbQv0ndvLEhASvXndDQMCO59xLtxxSnBYx5AAbG3t3UAgJkjlfX
	mbCQYXHVYZqlQydF4HNwgoxQgalxe87qkkkU6JxIxMeAeVxhtSMWUqsbxb4HUtWleIY+J1IcgLb
	LMo/EesOCkxVNHVUcSFPaD4Fy8dIGPejpUwGNCZuNB8Q==
X-Gm-Gg: AY/fxX4pA+gn5gAS8YwTDdprWsl4aYehttdLqm/jhpTWTZGyDHENVil31somCr4nI/b
	IgjNVeVaoXRYFSTZ2/ByOOcRXiPts2VwOU448dqc5QbwPEGGHqCdGK9Rzpe3ZQ1g2BQeVrfvOrw
	CA3TBDcsS6WUls3VUKIGeECiSC+vgsvoT23zjqo+GdU8gxaeT7RAFz3/YqZ4r7FfwDZqgbgrnO8
	Li6GpW/2jj+jTUsw9+0X1mtDDxsjLEKaYPLJmRoauHoCZPRsev50HFR6LhRq0Co/Ahuev92GQJI
	dERd4LPv0JrarGNtaVktvBGL5oZ7mm2Z8J8rxL2Zb+HCFA74wgi6wOqC1UsiHxchQIMbkv8pxsa
	+cM4SCFbiwVlKHfZS7bF6prdmg4uP2T7ELA1jzF55GR5myw==
X-Received: by 2002:a05:600c:1c06:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-4801e2f3107mr15634085e9.8.1768515967651;
        Thu, 15 Jan 2026 14:26:07 -0800 (PST)
X-Received: by 2002:a05:600c:1c06:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-4801e2f3107mr15633705e9.8.1768515967124;
        Thu, 15 Jan 2026 14:26:07 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe65883sm2285765e9.15.2026.01.15.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:04 -0800 (PST)
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
Subject: [PATCH net-next 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Thu, 15 Jan 2026 23:25:25 +0100
Message-ID: <20260115222531.313002-3-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
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
index 5947c2b44bb3..19782f3f46f2 100644
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


