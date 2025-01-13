Return-Path: <netdev+bounces-157603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C53A0AF66
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E60166284
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B880232398;
	Mon, 13 Jan 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gni6Je6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F3231C9D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750416; cv=none; b=oyqCF3ylh1oaQqhIcq/Gez488qYx+5bNXv6Hm8Bc17mWFjiHcJYWAnJ/6sts8L2WDXceczB1o/hSEPFyvvM8mV7VprBBh73/17llQbC3xbP8uLsO479/BB8B4eXuEIOgBlkVrOm+L7bYTzl6KN6O8+yWwoapbF279/BNnzjVwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750416; c=relaxed/simple;
	bh=olcQktziKlvqmLByWHEI11OxrxT9qSsm816NlJjYoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBZv6K+X3OkB1MKOjhbygb/UVH0z4yFN5T6QIO0Zjehbi4/k9SpM9/LkRvP8iUWNLsvnf4nBRuubCym6bcho8aXVvytASu7z+m1QYQLPNdHHq16Dw6tfPFtuCsEIvyPg1BUVRqFXKlWsYfuWjSgiaEh1zNNcpEVrgnk4vm4Xo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gni6Je6L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21670dce0a7so81542595ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750413; x=1737355213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1FhP/ied+x0o5xjyb/8S/ytBNTYe0wNCM2agmPfadU=;
        b=gni6Je6LOH53+rMFJgIzSPON4yhSOQNMcc44al0bqQ9HY5tKW6CjFN/IesmPKceJZG
         lgSnGp5Au9bGnSwl/B1M38iYL3yjssOtBCqgJ3ZmID8N9YG74LP1ejKSy1fHixXwmedg
         nrEf/nzjG/YiY7i0AGGqRdX8R56r/HixDM/+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750413; x=1737355213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1FhP/ied+x0o5xjyb/8S/ytBNTYe0wNCM2agmPfadU=;
        b=upfzo8iCRfqFyDcy6MYbhvVyN+mdtVltJs3KvlhzojpZ0Dclry1MkD6kcz+Zi07u2o
         0sTWAO5Kxy5bhVtYR13WTHDtijC5TsX8g8eKnU4/237/ilQZk20mAPDEjJyq/J2G7a0G
         /9bkmyznk/Ck375hoGU2M7chC0eJ8F3TbpayZJMb1dupB3WYg0H5EjI3AZFxM3qHuVOU
         Fi5EXrCZcaSNmZHGdCmhw7tcntQbTNNAT5Yftesb90rtC4mhJlhr3RI/40rOoHik97iT
         3w2UVOc/SpHjwzpk33PMVVmP8w4alnOya/Wp9GnHKs6ii9XCHm7jASHAR8Y6vZ1N0jwF
         sHqg==
X-Gm-Message-State: AOJu0YzhfrgizGq11MJhpKl3kloOTQmCyO2ZG8Bxv17S6aNRRkMGJ+it
	oZM0OmxSgmKgXjRnCFgZ0DRXeT1yJSwhdyJNNHhJ6FFqzKHOINwqSUmz8Wt18g==
X-Gm-Gg: ASbGncuzuAJ2gE4sGfnev1MKp7CHlFPdmjl9cq8PWGlfv7JIKDqyXOR7mqjTNDw8auH
	Cu4snJc0U/tNurVEpo+ixBz+OZ0OGaLAh+gWDIHxiVT1HHG/O3yg0+7lJMjbzzmd7sLJwA1H2G3
	DFJMxKhhboiGXc/lwV24CX4Ww0OFrXP5Kt6LDAyZT9Eq5a9Pe5NFnt+mPZ6d1qRe33NvZbKZ5J4
	YIaXHwF2mhNCiyjKWca5c2CT0Hh0+lXwzxI1pkr1yvMB4PmyOxubvix6SjLgICwsQD2rZ81WI2r
	G+ykKacea2j32OOMc3gdSU71INMnDviP
X-Google-Smtp-Source: AGHT+IENXV+F75c3K7kpShn33W7AxJx4zLq4geITEdYZyThtDRkADBEZqNNuqb19dR1hIXmVbDlW4A==
X-Received: by 2002:a17:902:e544:b0:216:50c6:6b47 with SMTP id d9443c01a7336-21a8400038bmr311159545ad.46.1736750413172;
        Sun, 12 Jan 2025 22:40:13 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:12 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com
Subject: [PATCH net-next 05/10] bnxt_en: Refactor bnxt_free_tx_rings() to free per Tx ring
Date: Sun, 12 Jan 2025 22:39:22 -0800
Message-ID: <20250113063927.4017173-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250113063927.4017173-1-michael.chan@broadcom.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Modify bnxt_free_tx_rings() to free the skbs per Tx ring.
This will be useful later in the series.

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 115 ++++++++++++----------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4c5cb4dd7420..4336a5b54289 100644
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


