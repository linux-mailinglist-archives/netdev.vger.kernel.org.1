Return-Path: <netdev+bounces-159023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C069A14233
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E80516B4D7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CE234D12;
	Thu, 16 Jan 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eRCw1AHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AE22CBF8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055489; cv=none; b=BlkGBtIql3tl9V1rO226adVEJpMNBCPvTsLI84IvoQzPrYlWXn+51rtGuotMyD3q+J0a9RAuYJ8eAJd+AJ8oACtJCz9U9YdBf1D2dbswwW8OqxH2jU5oYwazdXjpFCrThVgRTzLIHeOKFIQihleUIQ9T7kqe16TQsk+e+/C3Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055489; c=relaxed/simple;
	bh=+8qq6vP56h+BIdmBw7mUU6l7e26/kZtqjGExLcI/tgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJqwU/KCyfuopbAMgnaGcYgkgM8Ch9dC4j2fd0y33wG6eQWZYCaYyL8OG+YQwh5sTC34aU+AAa/h70jE94fxMm8im7hqHuZr4th5kN/jRldj8IA0eQayEXNcUejW9e4q/esDdCgVBkt1cHKe69CHked6TAR8EKbBqPLdaKgsENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eRCw1AHs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so1949926a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055487; x=1737660287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6aotgWxyezjPB/kF1pZfa9Nrz53wDK4KJ5RUijW8gs=;
        b=eRCw1AHsIEY3xGqognRm9M4k0nAyvFua0JpnxMQ5CcpqUSZUrtC7JswKHDik3+BAQA
         bIUitTNeRNK/aCQT1wj1WMT5OLb1FX30sKiy1ht0h8jbeMIQiyzKSEBkGG7Dc+QG4GCe
         piByeLW1V19koAtVkfDQTzJLLmy+Wq5RW2KXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055487; x=1737660287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6aotgWxyezjPB/kF1pZfa9Nrz53wDK4KJ5RUijW8gs=;
        b=q3VibPRV/mv0N1NI7gbkoHDIdsineYrxGAufY5OIq7LAYXRxSzJOBBJPn3MuLRwAcF
         HL2+SKTFsKsL0PFHi+LtXwQKUSPHG7L2Ho/apBQ3MVzaI1UKHP8rvE/XeMd7bFbeYqDp
         l0NAQgWYRlMluFsQUHcZgiSzcZyNFCgq9QnUV6gR/5OAH/GkIq0t1W7jtbcwnzabXO+z
         IGjTt8JJYxOrX9w8/WOXl2QvZfe4o+yjH3Lpf4omDAF/7d7c9SV+jOjGnl7Tf4rBf+5c
         Fq/WiQ9QdNpaNfthuy25Y4lMDtIn6O8ix3FvDnr1VeDylwtKT9Y+2mUp4tu17TUOJS7E
         iM5A==
X-Gm-Message-State: AOJu0YyLKSVqaglU+iVkLf5kouz6QBbxWq017LidXCkv/435jIUPzUWf
	+g8JQ5ZkcyY60VLyW4PLSWZC1J1ou9ISXi42dCdk5pMTABk/jw66MsosafQhZQ==
X-Gm-Gg: ASbGncv5cvff+5hOolC3UPhJc/ECXX/m8fGNiZmeHLKYL6JBtbQjCze27T0KlBbEcRy
	o2hr9Fq1iWVPyHvESBMjhWJo5xcdLpOzJf5gvt/0AYAg15h9l6b7uqGOaVWjsREDBYoSJlQeiw2
	GEsdstxwrk4gBvKUGVidO+oWe5jHhHEzt+5R8uxibvCXB7pdZG2w2zCtEeGJA4ELuJgb40wo3q/
	6oo4nYYbgYKkpWO24+n5qpOHONXQkdOwnNeaPvufEV1QHsg+orugVH1ZFy++pordE/Kyw+ul32x
	4M5hztnECgxxC8VU94IGhSeN7FDeSA9j
X-Google-Smtp-Source: AGHT+IFoJ/0ZA27MLS+3r7Ovi20kqQzIanLf0FL+/DyC7BUDa9yEqox1p2/ov8QT4TwCos0ZK5QNRg==
X-Received: by 2002:a17:90b:524d:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2f5490bd071mr48092907a91.28.1737055486785;
        Thu, 16 Jan 2025 11:24:46 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:46 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 05/10] bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
Date: Thu, 16 Jan 2025 11:23:38 -0800
Message-ID: <20250116192343.34535-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
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
index c651fe42cd57..50459ffc48c8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3313,74 +3313,81 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
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


