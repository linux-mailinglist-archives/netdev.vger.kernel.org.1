Return-Path: <netdev+bounces-165753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEFA33473
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992853A8952
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F1142903;
	Thu, 13 Feb 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jq01dXZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4284D29
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409217; cv=none; b=mHSZ4vtBIn5sJpfSn5dzmHiEHHCirpBDuRqCkkZPP82SZH9zZp/ishABNjpjMgaPmi8X7KQaQXLyzOUUVMJQfZxlva0yKrpEnMKSAVOeagIpU1bMgj41PayvzTjB33FucgAScrZZWuTsnuts5xpnLmGhCcwRZwTwPQPqQszlhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409217; c=relaxed/simple;
	bh=WMm7lF8i3aT0wkgzKRQ9Rv0++wE/D/rYcS6YOf4Fbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGHpX0bRphZD/OGK/gz6+xb7NWgUKhtwL9EbQwCXDBwW4NmhjaAP5yrydSZ2MRoFHAI5HCrJJjVFtr7/Ee9R6n/3QVR+N5Vy7DDNdSe24R+oXun1eGvAu/U+Iwj9DOtkBnwVgJMMr5jVY2RtWwsGEKHoegCOad4KuWSNG5qT3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jq01dXZ0; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71fbb0d035dso252996a34.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409214; x=1740014014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=Jq01dXZ0Jr9gYMteAZBf0yUyZshALAy1j66VN2iIjmT1y5MZqQ+lJ+Pp9QC0QJO1cn
         SkadkYy6qr9sfpChUJ17tZpDgBG8uegU6NZnNIIO2+AhVymZ1F653Ua/X3BouHAiUKDQ
         fmoGl8/++2HY4hrN36rFKL3ZBrXwS7bXqMLUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409214; x=1740014014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycu8HxRfHwBK04zHzX+xCqlv0tMM5LUbOD+7kw9MqnQ=;
        b=YlEz76llKxF/5LFmKcePaEBZ6NzhajaA5B+Wvkr3dGWukkK3VmaAkRLfm8qbdLX8q+
         mTNMVgV07xt/gWHALqGJrgEbQTqFcwMq42SMh3WoviLAibUlM+Pd9WTMwwPDn+D++0b1
         mbWbrzjm0jjjL2MghYVLnaN719bjJwuN92QUQw8YoliPP3dYreg/RnD3yVZu8BJsG8xT
         Sq+wRVc5pxTaX5cLz5cdRmCW7ZSvF8f81bLG3CrZW2Ub3JpXZq0u94ySSNLfCRI5FiaX
         Vj6NRJteOK0pKjbwBLUXTW3S09Ut4InDFpT+BaIIh3RGSwob4OCsK0g6WN/mzCd2IrP6
         Mj1w==
X-Gm-Message-State: AOJu0YyezyntrEE392LwoBwYnlwXTxSANZDBT6Wvu0UfJZ0ZLtYHk8XQ
	3DYAnT11Mgtholm+iTP6iyPvNnFa68hukjRToqJEEX16r5hCcEqxTbUjK038SA==
X-Gm-Gg: ASbGnctVgCHsimBf2QaltYFEqB12PsxpgSgdnyQinzKLYWiLCpxmQJMHMZ1BrR2Z9+x
	kFlI20fZHsB4ubcd2+0v2J7ngO3l4gpPtwxOr7Po7ttIqPcr7CbVAhxyD7a2bqj3PvV4rbgWyzj
	tMx26uSc2g3dqrMsnrcVcgXtHzLnDQKkzbx4hPdWBiQdt5+oeQc8lXXGFx7LOnbn+TfxqoEKpkL
	zM3tBzep6jImVdyDBp77Q891QSLKJwLcsiSbc2SC0/uUcxOBtteQ7fNs+rIh1MqW9AA9ZOh3LCp
	ayBY4xuIM/UP36EkK+awLVt88u/78GSH4wk0wczMBQR07kogTgwx7bd6jy3xfTw5FdU=
X-Google-Smtp-Source: AGHT+IFSdHICmV54tOV6uEADJTXrP2+XqjZbh2QsJybypqYDTy0v1wwAKnRrApErddhA8OoV2l62Ag==
X-Received: by 2002:a05:6830:3150:b0:71e:1fc7:252 with SMTP id 46e09a7af769-726fe7dc129mr812084a34.20.1739409212974;
        Wed, 12 Feb 2025 17:13:32 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:32 -0800 (PST)
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
Subject: [PATCH net-next v5 05/11] bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
Date: Wed, 12 Feb 2025 17:12:33 -0800
Message-ID: <20250213011240.1640031-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
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


