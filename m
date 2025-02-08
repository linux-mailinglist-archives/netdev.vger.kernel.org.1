Return-Path: <netdev+bounces-164370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E1A2D89E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186E8165912
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7621A7046;
	Sat,  8 Feb 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cbvb20af"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBD24113C
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046609; cv=none; b=EwJVDFZOHTsagOWe95tDTo6TKWv05R8eo5SSkIZXDRIju2oMbLRtxw4H6Y8++jNyuJUXlnozox1WvsqC6v8K+BXk240bvWQGHiXDYb0mI/LKT8fUnS4S7DnGZ42FmmQzA5urSwDYOfcSEHTpvuChlwhXuOFaQ4jSRW47gpZTLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046609; c=relaxed/simple;
	bh=WMm7lF8i3aT0wkgzKRQ9Rv0++wE/D/rYcS6YOf4Fbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYE18thC1+U9FXtNbQO5lRSQM6GnWuLq32JZmbmH7vMu+4uBl5uidoY2BqpXJ2PUPr0uWn7o0hZ6dVnpaCM6wLBFonEmqv80b6/0+wwnJ92VFtHUpw1IgA4nJ1lmpBicFf1nO7nhd2UFQZQP1BIunJYqOBUlfs4U9s2NyIFuWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cbvb20af; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f321876499so1760091eaf.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046606; x=1739651406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=Cbvb20afVpSSrsI6dL9NZ1epbvGckRbqJY5wH/0gf2cInAb8CUX6Jcf53eCnXQ31lJ
         7LcTSbxALXGIK7r2WGJzIDvp3ZxSS9O48UtfAFwx41kkFcUSi0+fsu/ofjD0uN6Q/w6U
         iBx0QNUucPhhJX2/p5rOHDMQiTniTr0Dly6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046606; x=1739651406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=voSIPQOqDe9wjXmNUPulAfFpB+5+rkdXgPfGGBtI4M+VTmuzpPO1eNEsZQCI8ZR9W1
         wvROSK+d1RZtZ5pJ4ycu/Jtcag3nJyRUgJ+DeNTaVBrzXHxilcF4vcXfSfvJacdSXYSV
         fnpPMrM+qT+XjVfy7eIgLvmrHJ/Ipsvg6durKM8KJAj63xa5yCtei/p/jtltho9ZIVwa
         0VS8Uwt6TYb63WARaWBRoavS4OQhPqxoSyHe7OKzTTqeeqCK1g5g52IrafvAsgNsqSJL
         xdola12yLzZ8a8meIYLUZLo5QvLJwGpDkInL8QylLp2YqHWQHbyEmxqM3aY4TZpW46J6
         zQbw==
X-Gm-Message-State: AOJu0Yys6MoVHuvXrxGOuivxSbuUWU8SuCI0IhQhC+y59Nm+EzWCZ0Ax
	rkJ4MelkLdwKAH8A4UORjf9LZC89cJs3wlzFJwZ3NTrNnL+R9iSbpGEV9s+WTzo7u3n3LhbKhec
	=
X-Gm-Gg: ASbGncs6KcN7MS9HBa2dfEtKK10eZ0Ee2AAkCh+MvyQdMle4NFamvUnNnv8xLipfowx
	Kp+HEkk+TCY8wBloOWhCPDdVXSSaL4EnSP3OaMzQKIrezXsVjlMSxpiGX9QF1uLVJc2CKD2s7TE
	uhYaB/w85y5AASPeS0UF+zD9OUPIcWx9dldi/zG5q5hJQDy9vM1Glwe9qGiDBv7oMtivok1vh38
	+HWtcppB3Vv9VpaaUku65en/BOP8bHQYCbXz4E4A2H5GYV+qCSJh9atUQEfDM7Cpnk5VTjYIS/z
	rwPE06H7L17lhDiGg9CwySfOOIFxFYQL/FihKmWV3YI+tMVxOxgSeg4hBZntV9cLrfc=
X-Google-Smtp-Source: AGHT+IGXh7Trsq0+oV8mwHISOlPg1adundTv08EDQSkHLBxL5o/XZRQgrdqE1CeIzDR9HoqNk7WLvw==
X-Received: by 2002:a4a:eb14:0:b0:5fa:69fa:a098 with SMTP id 006d021491bc7-5fc51f3b6d7mr8419447eaf.2.1739046606581;
        Sat, 08 Feb 2025 12:30:06 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:05 -0800 (PST)
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
Subject: [PATCH net-next v4 05/10] bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
Date: Sat,  8 Feb 2025 12:29:11 -0800
Message-ID: <20250208202916.1391614-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
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


