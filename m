Return-Path: <netdev+bounces-162323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F7A268DB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC68165310
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19683137C2A;
	Tue,  4 Feb 2025 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CxGaUAP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14A35967
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630027; cv=none; b=kMOXR+n61h9BNS3Qbc8h1sevzRnefVOZ7FlvS+CDSQcY5CbTLOTn4hvVpWkHJbgZtPxQDhpuKEVrDxUWpTt+LjUR6Kg2IRhWgHDPwuP/kn2q23CuI7Vg3JoBO3eDdYG2EAt6Q6CBnfvD9rqfbuAoKVhjBb/v4jAoYUTlC7cDzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630027; c=relaxed/simple;
	bh=WMm7lF8i3aT0wkgzKRQ9Rv0++wE/D/rYcS6YOf4Fbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksW1yYkMtdxWT3BePJvZfK+n0X3nRsYDTuxDILzbevxRCpM0ToRgz47mByYrYLDBjlxFh1U50a+J9Op38enCWabPKrzfr9adFu52ivmMtyS3Rk6l7jzO2SvWlFmZmWzCTNuBSSosqAEfsZkcuhw9cTuAYQFevsrDCnqDW35jeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CxGaUAP9; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a3a40c69e3so2782808fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630024; x=1739234824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=CxGaUAP9Z0ogTWVgA1txokxQptWeAiHk2nU3uYjQHp1UQe3+cbAxd3uS3SDIumohI0
         SEC4h2UOEUIyS5zgiww80f4b6Mtp5n470oLDRcfyphKZxceo7V5l8lDRBPqN7PzEG0ce
         2IeLgOV6OqmyKUOnBuAPWSHaEfWl5KjO7Mf7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630024; x=1739234824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=no7sCHOg6snenjEsYqAfVuVXuyMT0VxctaE+KuoxU9f8t/kx0ZLLNedLd6/NWOMfMG
         ut1prk7XEmFbeXLBWhJXbl5fhAN8qm+yHVZnKGXv73yrv3LDjug8yR1oGCMgKk8Wf8BO
         Nem/F8naz9AqlGEg8bbEXk0UC/uuwNM5rm8zJQIZLr0WazmCPxVZEgAGwYW0HhhG1Waf
         EKRo0slHZIejnekwBQcCbQ2TdMjTBjKHTj3tvD4mjxG8exN8mx9gYHGgHNvA0Ab/yrOY
         m/55MEOEnPHYzx1Lte1cCdWnEMUKphUljTyvEWAR4ih6uX2RMu48ETZBldPhpfGn1q5U
         DbWQ==
X-Gm-Message-State: AOJu0YwgUvyHfPO7gzhE3UpBbf9n7ae/VvkUtVSoUY1lp+g5rIcHJC90
	8/b4MEKe1/NtWt9bQuXS1q0NFW01lTfIM592/rARvvYhkgKJ1cs563+k67jxaQ==
X-Gm-Gg: ASbGncvnpmiVdUC6/7w37wKaUc+FTnzvQdQsG3enQ/7EqnpDmQKma7RybScN3qWLATf
	ws6Og+zPgHwA08Tt/7c4IxW5LHUExaucqQ7kPkJ8MtgCPfKd/1RBufSaUP7W8Sp7YVtfXREpye9
	ilNu2gX6lagi5DZ/truqrYc0BIndJH/J7mzOw+h+fVHmmi1HX95CznUlJfoiTBde/hJLrSFMnT4
	abPDPUdTOQI6gi4Na00XSbGBRb++T2cTZA/R73x/rw+22kUmmWeXZKSsBY1Y2jaD9fwoE47bqJ/
	fP+tHhS3oHUrxU3SqXqZuYH3wdCYR4C/Xsmf6DcfWA30epdhDGAUVTGT0FofAjusz/w=
X-Google-Smtp-Source: AGHT+IGKVa2DwIjU65GRYFuBnennYsOuxShGUNDhcfyBlmZQZM5FU48fo2DljNdQHo7ZzRhb6f2cuA==
X-Received: by 2002:a05:6870:2f01:b0:29e:7a09:d92a with SMTP id 586e51a60fabf-2b32efd067fmr14907279fac.5.1738630024302;
        Mon, 03 Feb 2025 16:47:04 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:03 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v3 05/10] bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
Date: Mon,  3 Feb 2025 16:46:04 -0800
Message-ID: <20250204004609.1107078-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Modify bnxt_free_tx_rings() to free the skbs per TX ring.
This will be useful later in the series.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 115 ++++++++++++----------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 52d4dc222759..453f52648145 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3314,74 +3314,81 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void bnxt_free_tx_skbs(struct bnxt *bp)
+static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr, int idx)
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
 
-	if (!bp->tx_ring)
-		return;
-
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
-	for (i = 0; i < bp->tx_nr_rings; i++) {
-		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
-		int j;
 
-		if (!txr->tx_buf_ring)
+	for (i = 0; i < max_idx;) {
+		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct sk_buff *skb;
+		int j, last;
+
+		if (idx  < bp->tx_nr_rings_xdp &&
+		    tx_buf->action == XDP_REDIRECT) {
+			dma_unmap_single(&pdev->dev,
+					 dma_unmap_addr(tx_buf, mapping),
+					 dma_unmap_len(tx_buf, len),
+					 DMA_TO_DEVICE);
+			xdp_return_frame(tx_buf->xdpf);
+			tx_buf->action = 0;
+			tx_buf->xdpf = NULL;
+			i++;
 			continue;
+		}
 
-		for (j = 0; j < max_idx;) {
-			struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[j];
-			struct sk_buff *skb;
-			int k, last;
-
-			if (i < bp->tx_nr_rings_xdp &&
-			    tx_buf->action == XDP_REDIRECT) {
-				dma_unmap_single(&pdev->dev,
-					dma_unmap_addr(tx_buf, mapping),
-					dma_unmap_len(tx_buf, len),
-					DMA_TO_DEVICE);
-				xdp_return_frame(tx_buf->xdpf);
-				tx_buf->action = 0;
-				tx_buf->xdpf = NULL;
-				j++;
-				continue;
-			}
+		skb = tx_buf->skb;
+		if (!skb) {
+			i++;
+			continue;
+		}
 
-			skb = tx_buf->skb;
-			if (!skb) {
-				j++;
-				continue;
-			}
+		tx_buf->skb = NULL;
 
-			tx_buf->skb = NULL;
+		if (tx_buf->is_push) {
+			dev_kfree_skb(skb);
+			i += 2;
+			continue;
+		}
 
-			if (tx_buf->is_push) {
-				dev_kfree_skb(skb);
-				j += 2;
-				continue;
-			}
+		dma_unmap_single(&pdev->dev,
+				 dma_unmap_addr(tx_buf, mapping),
+				 skb_headlen(skb),
+				 DMA_TO_DEVICE);
 
-			dma_unmap_single(&pdev->dev,
-					 dma_unmap_addr(tx_buf, mapping),
-					 skb_headlen(skb),
-					 DMA_TO_DEVICE);
+		last = tx_buf->nr_frags;
+		i += 2;
+		for (j = 0; j < last; j++, i++) {
+			int ring_idx = i & bp->tx_ring_mask;
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
-			last = tx_buf->nr_frags;
-			j += 2;
-			for (k = 0; k < last; k++, j++) {
-				int ring_idx = j & bp->tx_ring_mask;
-				skb_frag_t *frag = &skb_shinfo(skb)->frags[k];
-
-				tx_buf = &txr->tx_buf_ring[ring_idx];
-				dma_unmap_page(
-					&pdev->dev,
-					dma_unmap_addr(tx_buf, mapping),
-					skb_frag_size(frag), DMA_TO_DEVICE);
-			}
-			dev_kfree_skb(skb);
+			tx_buf = &txr->tx_buf_ring[ring_idx];
+			dma_unmap_page(&pdev->dev,
+				       dma_unmap_addr(tx_buf, mapping),
+				       skb_frag_size(frag), DMA_TO_DEVICE);
 		}
-		netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, i));
+		dev_kfree_skb(skb);
+	}
+	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
+}
+
+static void bnxt_free_tx_skbs(struct bnxt *bp)
+{
+	int i;
+
+	if (!bp->tx_ring)
+		return;
+
+	for (i = 0; i < bp->tx_nr_rings; i++) {
+		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
+
+		if (!txr->tx_buf_ring)
+			continue;
+
+		bnxt_free_one_tx_ring_skbs(bp, txr, i);
 	}
 }
 
-- 
2.30.1


