Return-Path: <netdev+bounces-147160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC789D7AC8
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 05:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C86B213EB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040777102;
	Mon, 25 Nov 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Oz7ta+Ww"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110F4C76
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508681; cv=none; b=D8Dce+ASdzQIRIDY15nzIRE1Lo/zKVJJu+02Regta26IEjLfvieQ+30/forbPGV5FJrRoQMc6gbRGJZSFwuhTZhW1V9Z29zSB48Ch8ZLg0MKygmX19paXdw1quxsnepsZo8IvYNLJjWalAFrhokIkSLJPgTJQDkfr6tKTnWBbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508681; c=relaxed/simple;
	bh=49maGMWiy3Nbi8tm+3sP+LhlVcyM86OY4LiijQN7eNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1SYL4dPONF2WS1/j+E+SWS8GADTU4v3NcigL4n0rNu8ILxcfBlnRgUzEHtabnWow2Fn8FzLlV8XyNWbYwZxstsGnjDveLTFx7yDSrfZGAfiuXVumK4iDudFBAAZVnsfqL8RRitwIvGj8KL4Ecm9JPT8o0EDpK/yJOtRj+iw5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Oz7ta+Ww; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724e113c821so2152163b3a.3
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732508679; x=1733113479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX+7FJNwY1ZGYJBKL/Ylmjs/CQwIsMbj1Ti1EMLN6tw=;
        b=Oz7ta+WwB0uL41bN1Bm0Ua/JKG6laz21BddULDH2Y4x8qJR5JrnlPn+NClJ5cycun1
         Rnw3mfBNCF04HmDmo1RdZLJaARkwJA3QkjF18vLvLCXHtp7lFwa+YP6DyrMPQN+i+2OT
         S+i+P9MRxfnJa1vbs1J7C6Spb9LBkHSynobo+go5H5Kd0HlQ17kOpYbFGghVEE3eLIqK
         IgOqGbrJqKPz61Z6ODy/BrqmuCq1YngFhDatDIuM0K9DgsugQhmia34VIasT7v+RFh/S
         E7DgV/aGJ028jTny9+dNmAVCP/6P9o0uCI12kq13bA8CwruU8m7gNbKV8bFI1YjLkS3e
         mugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732508679; x=1733113479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX+7FJNwY1ZGYJBKL/Ylmjs/CQwIsMbj1Ti1EMLN6tw=;
        b=b9dT1uaiUQ9f+dGFBNxQtBKQCPPpoXq2+cxXDmxdTI0QuVUtx1yHWRgaSDy+Q37rrt
         Us0qvtQzEZ0xwHvY6Isb8b34NZyuFPXLkm7XmmYvIO77ul4EijdmB250uVVqwT8+buhi
         dijdEhiffso8zZsENk6PqOdaieVanXhnAbdc42e2U9q6H/SN+2c2MFnXHSO+3qZyOX0C
         toi/nC+m1KTGqpdjIdJICFUow/uZINd4hSyD/H8RqdjHTEzpspVfYYtyUhNvkh2bJjEm
         I7u2qmXUTNkN/KtPs12NHpyOyJ/xk7QuavbDMYDTfUrOSyPyJjOGnBbPmUGqe4dNAQdT
         E2Cw==
X-Gm-Message-State: AOJu0Yy5q0c6tadUNFoCfguxxU/DjRQKPa630uo6UUZcZ538HJSQFeKD
	O1y+jC9SRX5P3PQ0vlrGk/xRDz1U6mqyOsHKTgAkGbrTe6FegEfanRz6kM03KyLdlEZ+4DhHSnl
	D
X-Gm-Gg: ASbGncuwi2Wtb8ieeLpXF0BRoX059sNkjTL91rf6sHGPu5t42Dm/dyIoZbXptRy3Vy2
	grLam+sRnypfjWPJ4KgoKulzeWWZpboFrDbJuieaepCanX4rrat6gyi1I1xiDTMCkg3+iFuMOOu
	7LNqARgzSZCi7FJhvV7dJWRw6AfPsJS/cpTlMogPjVNOTnPB2SvLcgl8c257a/WMuUM/N3xRJ4/
	UUMtEMnSFSVgnjxcpu3H0ClLHHHfCYfgg==
X-Google-Smtp-Source: AGHT+IGlml5yCVInrC04HuLf7asLGGHkLFE9bqNOkY6NzmldhHqe1mmaonvulUM9isBw5zQjGzapHA==
X-Received: by 2002:a17:90b:1dcf:b0:2ea:6f19:180b with SMTP id 98e67ed59e1d1-2eb0e885a10mr13377191a91.36.1732508678677;
        Sun, 24 Nov 2024 20:24:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d06299dsm5679189a91.53.2024.11.24.20.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 20:24:38 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v1 1/3] bnxt_en: refactor tpa_info alloc/free into helpers
Date: Sun, 24 Nov 2024 20:24:10 -0800
Message-ID: <20241125042412.2865764-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125042412.2865764-1-dw@davidwei.uk>
References: <20241125042412.2865764-1-dw@davidwei.uk>
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

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 148 ++++++++++++++--------
 1 file changed, 95 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5f7bdafcf05d..b2cc8df22241 100644
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
@@ -3461,13 +3468,17 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 
 static void bnxt_free_rx_skbs(struct bnxt *bp)
 {
+	struct bnxt_rx_ring_info *rxr;
 	int i;
 
 	if (!bp->rx_ring)
 		return;
 
-	for (i = 0; i < bp->rx_nr_rings; i++)
-		bnxt_free_one_rx_ring_skbs(bp, i);
+	for (i = 0; i < bp->rx_nr_rings; i++) {
+		rxr = &bp->rx_ring[i];
+
+		bnxt_free_one_rx_ring_skbs(bp, rxr);
+	}
 }
 
 static void bnxt_free_skbs(struct bnxt *bp)
@@ -3608,29 +3619,64 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
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
+	}
+}
+
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
 	}
+	rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+				      GFP_KERNEL);
+	if (!rxr->rx_tpa_idx_map)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static int bnxt_alloc_tpa_info(struct bnxt *bp)
 {
-	int i, j;
+	int i, rc;
 
 	bp->max_tpa = MAX_TPA;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
@@ -3641,25 +3687,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-		struct rx_agg_cmp *agg;
 
-		rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
-				      GFP_KERNEL);
-		if (!rxr->rx_tpa)
-			return -ENOMEM;
-
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
@@ -4268,10 +4299,31 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
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
 
@@ -4281,19 +4333,9 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
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
@@ -13657,7 +13699,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
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


