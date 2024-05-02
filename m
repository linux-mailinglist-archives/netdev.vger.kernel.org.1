Return-Path: <netdev+bounces-92895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323468B93FC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48034B21E78
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3E21105;
	Thu,  2 May 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lB4tP0Gk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134F208A9
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625663; cv=none; b=gByKhb8HGLOXi5QpzjXqCoIkXbL+Ted0KvhanwOlSfpdRRLWnnm3c7cozLQhpAl90q11jzry1bO+77zrXrJXNM4LnI6bY8rtCZ25M8vL55A9eqGsnNGdXyg0oqgw6oHL/fEj14qyFOl7IS33KpuPx0gKkf8SLr0GC+4Vjxno4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625663; c=relaxed/simple;
	bh=ZHF4Go+nOkdq39sKD/sqLIpOLW/meubx55Acw8RoEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0L+QdWFhP1tKGfbJ3Qi+eWhaXuFxGuWLBv9yuWK3XLVYcGBbs0QjBxGnnSloGLVTIxuFGEOKqfF/Wf2p6odTkzJseiI/D2B4FnsFO98PXCoj2JZ4iwXrasjunF8MDPOlJracY8GANG0JK6/+nOWpZC7g9oFAsnT6YV8NP4jJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lB4tP0Gk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4f341330fso69475805ad.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625661; x=1715230461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zYfD4DNKBLYCTzuc2jEB4CxeXC1l1DUWPGVBNCSW3Y=;
        b=lB4tP0Gkzh8X5wjVVrRpfn/9K2YCQmYP1mMcEv6b6rTfeeVPAiuLAkVWYkSjaejNgT
         T8Foec8f3O5AFX0RHIwv7nMTWlDypEaagNUBjkDxFyhskK6xP0MsCepWNL37wooGIN0T
         j54egwYXZ7XvXfLAoicDiljwcyiZvEu4pm6N/7twX7vsz083mybjXP2LEXmeaRmyBaPI
         v0OFbg5AYkD7UlwIlI2fkDiHgP8cGBgmKK2Z7pbOJXMvxgDmGBZzDAhZbeasnZ5ns/WF
         Ixp3Uze+pbpSd/W5VZb5DFi9pbQavJEQ8ySHtSzC55fJOs3L3xQtJzkPBaQnkVN2A4uz
         0XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625661; x=1715230461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zYfD4DNKBLYCTzuc2jEB4CxeXC1l1DUWPGVBNCSW3Y=;
        b=ZExGmYoaX8Y+c4TYkwAOd+SlgZ+hzk7+xoPHC2XeuAEMYy9vMuFtbYpLtjz3HEgW4J
         V5PE+3GBTiGodz+4YajZSf1fnAE+mdVKR54vrV/GW7qGPE8xoaDCeu6XWUKiNHnLln9V
         GitJb9oWZkk/2Rl0ZNeopYl2hfHl9HDGriqZwyG6OTlyv9n51FinfrmTLB4/be82ehrR
         z8sqQlV76/gL0ElqT6pXLGR5nlodHtJw75GpQqqjQ1mBhJR+o7sVy9BSBUdNctnN8jwl
         UllKsnb8cH2LRqMCdBuIHGzKgq4l50hcjzTLAaYGxdlRX/jhwIYubDup4YRn6mZQBca6
         KTNw==
X-Gm-Message-State: AOJu0Yx3e0C99qdbTaWevLMxviUiNo9FVvL0mQh4kslamAxSE3ZuixGZ
	hg6VQNN1z89PCM2k80FUbV9Qmh/EL1DhEmF8Sct3I3QXliXj/cvI21h4aOzUS3PmlTV8v0e9MS+
	m
X-Google-Smtp-Source: AGHT+IE6kZEWK8zvBs8txByjfCvMeugXv3X8x2uCxAwhSB1KLWc1he+GaOUgqw32xHYQLtGaj0O4mA==
X-Received: by 2002:a17:902:6bca:b0:1e4:df0c:a570 with SMTP id m10-20020a1709026bca00b001e4df0ca570mr4421353plt.8.1714625661186;
        Wed, 01 May 2024 21:54:21 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001eb3dae7ef1sm248395plg.16.2024.05.01.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:20 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 5/9] bnxt: refactor bnxt_{alloc,free}_one_tpa_info()
Date: Wed,  1 May 2024 21:54:06 -0700
Message-ID: <20240502045410.3524155-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the allocation of each rx ring's tpa_info in
bnxt_alloc_tpa_info() out into a standalone function
__bnxt_alloc_one_tpa_info().

In case of allocation failures during bnxt_alloc_tpa_info(), clean up
in-place.

Change bnxt_free_tpa_info() to free a single rx ring passed in as a
parameter. This makes bnxt_free_rx_rings() more symmetrical.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 95 +++++++++++++++--------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b20303f3b7d..bda49e7f6c3d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3500,29 +3500,66 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 	return 0;
 }
 
-static void bnxt_free_tpa_info(struct bnxt *bp)
+static void bnxt_free_tpa_info(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	int i, j;
+	int i;
 
-	for (i = 0; i < bp->rx_nr_rings; i++) {
-		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
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
 
-		kfree(rxr->rx_tpa_idx_map);
-		rxr->rx_tpa_idx_map = NULL;
-		if (rxr->rx_tpa) {
-			for (j = 0; j < bp->max_tpa; j++) {
-				kfree(rxr->rx_tpa[j].agg_arr);
-				rxr->rx_tpa[j].agg_arr = NULL;
-			}
+static int __bnxt_alloc_one_tpa_info(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	struct rx_agg_cmp *agg;
+	int i, rc;
+
+	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
+				GFP_KERNEL);
+	if (!rxr->rx_tpa)
+		return -ENOMEM;
+
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		return 0;
+
+	for (i = 0; i < bp->max_tpa; i++) {
+		agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+		if (!agg) {
+			rc = -ENOMEM;
+			goto err_free;
 		}
-		kfree(rxr->rx_tpa);
-		rxr->rx_tpa = NULL;
+		rxr->rx_tpa[i].agg_arr = agg;
+	}
+	rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+					GFP_KERNEL);
+	if (!rxr->rx_tpa_idx_map) {
+		rc = -ENOMEM;
+		goto err_free;
 	}
+
+	return 0;
+
+err_free:
+	while(i--) {
+		kfree(rxr->rx_tpa[i].agg_arr);
+		rxr->rx_tpa[i].agg_arr = NULL;
+	}
+	kfree(rxr->rx_tpa);
+	rxr->rx_tpa = NULL;
+
+	return rc;
 }
 
 static int bnxt_alloc_tpa_info(struct bnxt *bp)
 {
-	int i, j;
+	int i, rc;
 
 	bp->max_tpa = MAX_TPA;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
@@ -3533,27 +3570,18 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 
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
+		rc = __bnxt_alloc_one_tpa_info(bp, rxr);
+		if (rc)
+			goto err_free;
 	}
 	return 0;
+
+err_free:
+	while (i--)
+		bnxt_free_tpa_info(bp, &bp->rx_ring[i]);
+
+	return rc;
 }
 
 static void bnxt_free_rx_rings(struct bnxt *bp)
@@ -3563,11 +3591,12 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	if (!bp->rx_ring)
 		return;
 
-	bnxt_free_tpa_info(bp);
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
 		struct bnxt_ring_struct *ring;
 
+		bnxt_free_tpa_info(bp, rxr);
+
 		if (rxr->xdp_prog)
 			bpf_prog_put(rxr->xdp_prog);
 
-- 
2.43.0


