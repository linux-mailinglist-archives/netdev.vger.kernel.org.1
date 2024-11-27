Return-Path: <netdev+bounces-147660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B39DAF45
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F995B21B4B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660B2036FC;
	Wed, 27 Nov 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="u004OQap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0E18C03E
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747143; cv=none; b=oBcFDxoV0R2l6KJQH2P+xg+8oW6EtQIMgnYvNpfNR+mNWhglT1PnL/4EUDP4JC1D6F19StphBZB6WCpJTYKFLru/P0+UkbVG6ZOe9BeI4HBF0J7tmOCFW7XixG0e/L3NWB1KYJmw+2m+UJRXLYUt7t3ywfSaBh9qRJfuks1z5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747143; c=relaxed/simple;
	bh=MoLFVrwG2pzOw4qM/p8sJC/2q7dJ+PcpgoOiBZI65Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QynIo69rGVKrMwt36qiTwOpwjXntk/nFsuiYMhyU3ZJAHzy/WPBzA+gGKj6rCuELJyT1cEK2tjY6TrdHeSpR3unYtl5dadK6kd3ZxjkU+F2kqkmQHaB+iflZOAm6QZPQdBVqZ++UXj+YCJTw3Ah7p6fq8OITYjhcSRwEa0Zb0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=u004OQap; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21207f0d949so1631675ad.2
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732747141; x=1733351941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckgX9xzAjYg/Gmcb3ip5McB1Pq7fmdIgvnbsrSdDfZ8=;
        b=u004OQapDy5BfP6yK/BSQDwEQEir9EdQ4B2aw6JXfwWI71zGr/WmabuY7kRRQrcJIU
         sXrSPb8lf3QThLcy2XKsnYFyUj+9Kj2gOLQV2lmQdJAGoaTKAWFR/Eu+V5q5HE81OkZe
         HrdG0qnEblx/KCz72KfqGR7bimEQKRplBfHlbd74W9QrmrkbWxgIRc+RfvpX/jLbyxbk
         eJtZPJJ3O+2CNJxOM5rTmI2eXNbrln4t1TYBQwEbRMSvh76kOqYRSTLvxyOadcSGrM9A
         /GdfWE/E3R14MHtth2uuwa1qDO5enCspLDyMH9uR/TEsjRu4SL8aYEN88iFKFoI/nyfU
         UbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747141; x=1733351941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckgX9xzAjYg/Gmcb3ip5McB1Pq7fmdIgvnbsrSdDfZ8=;
        b=nEw0qIgdyEkaY0frNG6YMxEvNUa+8eehO/E9yDFYo1ixQdoV5sh0+47jaABPNhrxVM
         QZfkFizY4O4tuf03BewAuhqlGXZ0WrQy/iUxVdg2v9fh2opWLsCrdO/8odmoiG4YuvL6
         vC/V+YCgSGSB27IDNXAUuBTVm+E4GxU2N+4EsBDdjwSjXAuBAbglTqSwSBZQ8KJoatk+
         SvQ6TNCY3aqg3xFil0xdDKxnX2QyHhBaR2vqMuHnlQeK93v5N3zRPczN/5AFO/8zR6tn
         VdSexUno8KKFAa5fkYGv6AbV5mtWycCMc97BOww6KGnIMfHQr8JLAjWVJt6K6/zkZdqp
         ehcw==
X-Gm-Message-State: AOJu0YyxXBVVW5Vaa2/f1b982tstBlliWNhLzRNUhAI4dYLL9FwNqjcC
	YcXDE8Hd029s5efbATcQQDq8jbZJ03yr8OKWoysKanhs8R+Aes8Ko6gSV1XdlGk9FGni7vYlAZH
	y
X-Gm-Gg: ASbGncu70lrpsNf/G3RWxjE6aOF0KVXZxppDlK4GuQsB/9rr9yuim5IwtgQ+ov+hn6r
	0s7tjobDnxoRg5HJfFSQ44JeBCWg8B5GTqPZp6lYsVx+Bvgv/Zm/yUD7u4mUDC4Q52Vdh/X6wrs
	smWQhOMJOXKE3kZ0a8WbGhQXQfjlCYpxI0yF+gJAo7DHKxpfkSiHkqnxNfP85yjDv4LGW5HND04
	1ezvYq3pGLdkCHeeQ5HQsjqr77kdw3/s5Q=
X-Google-Smtp-Source: AGHT+IEkcs4P3nC8XdTcozpol+3ohyv5pDvrr6V3RgfTQl0ALwxnxeLKyPZ7ZbTjydv/bCdO9ya4xQ==
X-Received: by 2002:a17:902:f648:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215013854dcmr60378205ad.30.1732747140994;
        Wed, 27 Nov 2024 14:39:00 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521987facsm646165ad.195.2024.11.27.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:39:00 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v2 1/3] bnxt_en: refactor tpa_info alloc/free into helpers
Date: Wed, 27 Nov 2024 14:38:53 -0800
Message-ID: <20241127223855.3496785-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127223855.3496785-1-dw@davidwei.uk>
References: <20241127223855.3496785-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor bnxt_rx_ring_info->tpa_info operations into helpers that work
on a single tpa_info in prep for queue API using them.

There are 2 pairs of operations:

* bnxt_alloc_one_tpa_info()
* bnxt_free_one_tpa_info()

These alloc/free the tpa_info array itself.

* bnxt_alloc_one_tpa_info_data()
* bnxt_free_one_tpa_info_data()

These alloc/free the frags stored in tpa_info array.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 142 ++++++++++++++--------
 1 file changed, 90 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 57e69c0552ab..38783d125d55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3421,15 +3421,11 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 	}
 }
 
-static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
+static void bnxt_free_one_tpa_info_data(struct bnxt *bp,
+					struct bnxt_rx_ring_info *rxr)
 {
-	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
-	struct bnxt_tpa_idx_map *map;
 	int i;
 
-	if (!rxr->rx_tpa)
-		goto skip_rx_tpa_free;
-
 	for (i = 0; i < bp->max_tpa; i++) {
 		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
 		u8 *data = tpa_info->data;
@@ -3440,6 +3436,17 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		tpa_info->data = NULL;
 		page_pool_free_va(rxr->head_pool, data, false);
 	}
+}
+
+static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_tpa_idx_map *map;
+
+	if (!rxr->rx_tpa)
+		goto skip_rx_tpa_free;
+
+	bnxt_free_one_tpa_info_data(bp, rxr);
 
 skip_rx_tpa_free:
 	if (!rxr->rx_buf_ring)
@@ -3467,7 +3474,7 @@ static void bnxt_free_rx_skbs(struct bnxt *bp)
 		return;
 
 	for (i = 0; i < bp->rx_nr_rings; i++)
-		bnxt_free_one_rx_ring_skbs(bp, i);
+		bnxt_free_one_rx_ring_skbs(bp, &bp->rx_ring[i]);
 }
 
 static void bnxt_free_skbs(struct bnxt *bp)
@@ -3608,29 +3615,64 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 	return 0;
 }
 
+static void bnxt_free_one_tpa_info(struct bnxt *bp,
+				   struct bnxt_rx_ring_info *rxr)
+{
+	int i;
+
+	kfree(rxr->rx_tpa_idx_map);
+	rxr->rx_tpa_idx_map = NULL;
+	if (rxr->rx_tpa) {
+		for (i = 0; i < bp->max_tpa; i++) {
+			kfree(rxr->rx_tpa[i].agg_arr);
+			rxr->rx_tpa[i].agg_arr = NULL;
+		}
+	}
+	kfree(rxr->rx_tpa);
+	rxr->rx_tpa = NULL;
+}
+
 static void bnxt_free_tpa_info(struct bnxt *bp)
 {
-	int i, j;
+	int i;
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
 
-		kfree(rxr->rx_tpa_idx_map);
-		rxr->rx_tpa_idx_map = NULL;
-		if (rxr->rx_tpa) {
-			for (j = 0; j < bp->max_tpa; j++) {
-				kfree(rxr->rx_tpa[j].agg_arr);
-				rxr->rx_tpa[j].agg_arr = NULL;
-			}
-		}
-		kfree(rxr->rx_tpa);
-		rxr->rx_tpa = NULL;
+		bnxt_free_one_tpa_info(bp, rxr);
 	}
 }
 
+static int bnxt_alloc_one_tpa_info(struct bnxt *bp,
+				   struct bnxt_rx_ring_info *rxr)
+{
+	struct rx_agg_cmp *agg;
+	int i;
+
+	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
+			      GFP_KERNEL);
+	if (!rxr->rx_tpa)
+		return -ENOMEM;
+
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		return 0;
+	for (i = 0; i < bp->max_tpa; i++) {
+		agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+		if (!agg)
+			return -ENOMEM;
+		rxr->rx_tpa[i].agg_arr = agg;
+	}
+	rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+				      GFP_KERNEL);
+	if (!rxr->rx_tpa_idx_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int bnxt_alloc_tpa_info(struct bnxt *bp)
 {
-	int i, j;
+	int i, rc;
 
 	bp->max_tpa = MAX_TPA;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
@@ -3641,25 +3683,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-		struct rx_agg_cmp *agg;
-
-		rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
-				      GFP_KERNEL);
-		if (!rxr->rx_tpa)
-			return -ENOMEM;
 
-		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
-			continue;
-		for (j = 0; j < bp->max_tpa; j++) {
-			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
-			if (!agg)
-				return -ENOMEM;
-			rxr->rx_tpa[j].agg_arr = agg;
-		}
-		rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
-					      GFP_KERNEL);
-		if (!rxr->rx_tpa_idx_map)
-			return -ENOMEM;
+		rc = bnxt_alloc_one_tpa_info(bp, rxr);
+		if (rc)
+			return rc;
 	}
 	return 0;
 }
@@ -4268,10 +4295,31 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 	rxr->rx_agg_prod = prod;
 }
 
+static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
+					struct bnxt_rx_ring_info *rxr)
+{
+	dma_addr_t mapping;
+	u8 *data;
+	int i;
+
+	for (i = 0; i < bp->max_tpa; i++) {
+		data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
+					    GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		rxr->rx_tpa[i].data = data;
+		rxr->rx_tpa[i].data_ptr = data + bp->rx_offset;
+		rxr->rx_tpa[i].mapping = mapping;
+	}
+
+	return 0;
+}
+
 static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 {
 	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
-	int i;
+	int rc;
 
 	bnxt_alloc_one_rx_ring_skb(bp, rxr, ring_nr);
 
@@ -4281,19 +4329,9 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	bnxt_alloc_one_rx_ring_page(bp, rxr, ring_nr);
 
 	if (rxr->rx_tpa) {
-		dma_addr_t mapping;
-		u8 *data;
-
-		for (i = 0; i < bp->max_tpa; i++) {
-			data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
-						    GFP_KERNEL);
-			if (!data)
-				return -ENOMEM;
-
-			rxr->rx_tpa[i].data = data;
-			rxr->rx_tpa[i].data_ptr = data + bp->rx_offset;
-			rxr->rx_tpa[i].mapping = mapping;
-		}
+		rc = bnxt_alloc_one_tpa_info_data(bp, rxr);
+		if (rc)
+			return rc;
 	}
 	return 0;
 }
@@ -13657,7 +13695,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 			bnxt_reset_task(bp, true);
 			break;
 		}
-		bnxt_free_one_rx_ring_skbs(bp, i);
+		bnxt_free_one_rx_ring_skbs(bp, rxr);
 		rxr->rx_prod = 0;
 		rxr->rx_agg_prod = 0;
 		rxr->rx_sw_agg_prod = 0;
-- 
2.43.5


