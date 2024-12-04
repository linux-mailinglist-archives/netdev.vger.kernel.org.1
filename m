Return-Path: <netdev+bounces-148798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3D9E3293
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CF0165DDF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE473166307;
	Wed,  4 Dec 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ehDmT7c6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AB10F9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285491; cv=none; b=tbfVlHXDj0d84XvCuIWTqHrOI55sCABMKZm1AuvqqLvtfp5/iNQVZnm+jqiUA7mqnaSG73W4D+Ihu8V58z7ZzcF1PMQusNhRl9ZGhl84Xyl6tLszdz1Jjd6QPd+CLMZh0pNaAwym41RJoa68EJgnIVshMrBUKBVySkbtX0zpo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285491; c=relaxed/simple;
	bh=EhSDUfl2UybzUg4Xo+ichKql6HUpxf3sGDukmmwSab0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv6PjkLp7RJf9x0rV5VB7ZAux01a5fEzR3Z5v0Hl788mIdyGVmGKYbc3YGdX5ujOiBQRvIg5CL5SCUJneRn3ziYaJriNnYMhH58LAVHNU00/Q6xPGXOIsHGLT+GSDbF8x8xlc7XA/yCZizdbnapyCOmdYKSFz9agGC5wm6wq6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ehDmT7c6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2155157c31fso3859135ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 20:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733285489; x=1733890289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF5YUu1HHUN/4SRYSLRA5gwEjtvy7MqC6Zr1gwy7BaM=;
        b=ehDmT7c6cb3XCqfTA34VfOFnskweiXF4eLFn/dap10AqitPnPa1jCQIEXRfFru8iUB
         4yrvs1pSHYzOjPjpbPiZEtXAas26i6fKNk6uPmUJ0sqpG6IbcHzLiGYxH2R2gwyhx71F
         VOOgkq7Qehy86p1N2/VfdZs5OB9qHQt8c/n4OLqbFcmq0UqnnP489SFMr2xR/mWcZqA0
         gmE4nF9g7nILayYtPjHYBh6ZZACp9oZ0Lw46aKBdhSMTvRRKMpemDpUUk//Jx0b7tAZr
         ei4xDbv9uMuY3lG3DxmKTTf2uWIjC4Z3ihyeN5ZAaYnX1+KVyJsnIMdx2KRdNhtHPMTo
         wmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285489; x=1733890289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF5YUu1HHUN/4SRYSLRA5gwEjtvy7MqC6Zr1gwy7BaM=;
        b=UqyBVhqyMZwia/vK5jGzMmWV66oZJoUjow4l7GteS/5Cew9f0MUlI9QhW9Pmd7qUSr
         6pByR9gz58+dgTZ9dFmMq2XzmSHPNCktFolIB+1k62oqEj+mwBoBA2TIhXlPFAYDfdsn
         Q0BkfP8cgtjkzK1udL36cWnG7LJ+iCNEOPomXXOGswo9yxNbh+u3JV+uaY00vSry8SuD
         A4LdfC87w6FNzUIeFsfMATwBE9zU48wXwF1hFgXojj2hMyVyTwoB5MmFgShLjEjar3LR
         vKRgTbvkk99BQC5EkId9CV4XQ6w09hOigjzuxPycxAqG0zCVpYpRKjLpNEV9rnI4jyAn
         3Kyw==
X-Gm-Message-State: AOJu0YxaLELP3TLr21rwKwjqA6TUMWrzycENc/TcnyQ+ClKR8nLiMGU2
	v9FQVWdhG1+pFKekyNg1jekR+3HX8UOIOG8uwinx7EuIpqxVZmwDlU1GpvBks53ddpN0zwRCQMX
	a
X-Gm-Gg: ASbGncs7msqucip7ZXAgE07Lb20pI4RBKuuoR+WMX+xz9xwanYc3t+PCdgMBWEw0YiE
	V8YP9r3NoH1VZqoQUNhaWNrPUT9AEK1qM4kGNzBPzuiDVOBmzj9o/dRY0KaVOtYLCNMCtFJWLrq
	d5SV2B6xPQGWH0rGhpBlt7L1u1uowZ+VFyOZaO2FxxMHFJmNjIzfPLrkPmigVVtXm4p1pWyoqku
	w0WDSR/GJ2I/J6I8oRAaKarl54p35QuwQ==
X-Google-Smtp-Source: AGHT+IGYRWshOpdWgIEEJvHJPusu6oVvsLIDl5rn3s3bTdbJgm9HQN1Xvpfj8z48IZdLyJ+sv1/mKg==
X-Received: by 2002:a17:902:e88e:b0:215:a303:24e9 with SMTP id d9443c01a7336-215bd45df7amr86929935ad.3.1733285489269;
        Tue, 03 Dec 2024 20:11:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm95293375ad.52.2024.12.03.20.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:11:28 -0800 (PST)
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
Subject: [PATCH net v3 1/3] bnxt_en: refactor tpa_info alloc/free into helpers
Date: Tue,  3 Dec 2024 20:10:20 -0800
Message-ID: <20241204041022.56512-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204041022.56512-1-dw@davidwei.uk>
References: <20241204041022.56512-1-dw@davidwei.uk>
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
index 4ec4934a4edd..b85f22a4d1c3 100644
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
@@ -13663,7 +13701,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
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


