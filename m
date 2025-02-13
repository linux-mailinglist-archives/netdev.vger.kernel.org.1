Return-Path: <netdev+bounces-165758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC2A33477
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E636B1681E1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649BC13AD11;
	Thu, 13 Feb 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bw3kk9G2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840ED13A3EC
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409225; cv=none; b=hKwWP84b3DsAnuFlEmzfNxqJX4dMRwDDAAOblRmKjwrVLQ2X0qsej2iAm34YyuhiqgzPZYWFpLsr55x511vWs/yZgtRw148tm8tSrp1LFH6o4amlc17gBj0F0OuUhLBuE//pnyw3RuT3l4puoB4botwdda4hwCH3Hr8SHca2f00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409225; c=relaxed/simple;
	bh=7yFFQYYH4+IZ/hODe5AzffCuzF/F+agehrnk2mzt25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0YuoeFmyt90Gkchcq1bi9XFigms92NNzYlf9lMf+U053De8cMNTy1DEHWKhZ82EIzRuUuKkIu0hOjgW39T+u/SoGX8Bl4FQrNJAe9f6q1RBsUYsb7oHWLhY9NrK082BHBzBKJfdxI3RFcS+UtbBO9P5aNKGle0M+p7wf9P085U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bw3kk9G2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fc8f74d397so210013eaf.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409222; x=1740014022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6ahPr3qNlrtPz7WNKqwlq2nEMj89hzFEsFf8OUr3YU=;
        b=Bw3kk9G2sWz2w80FGhmNO8/VK1JS8oCPure49XY7sD1YhgXxc517Tsj8uOrI6mSnUS
         eTQLxeS4TOzmIVQqUFxMXwpgUYUEXw96mvjBS12i8sWVHOhVMJlWGTMGS2V1UTr8jMO5
         wTqd2W/irGL9Qx0/2DRHuyp0ZKNOMFLrOhxQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409222; x=1740014022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6ahPr3qNlrtPz7WNKqwlq2nEMj89hzFEsFf8OUr3YU=;
        b=swLGmSpwrLEVyMo6H0K+WYjKECJ2yiLS/JJTgrns6PaYxHTZioL5UGsHTgSZp6MD4D
         q4uSqR56KKSYO3WSB979KgpY+oWoDeuBFvMRbgDeg2EdLtXrhjfQfhLfrsDMTJoOtFE8
         mUyQ8kKSdLvZwXswKxL5OFMMk7xFkK/0GNwBKfN2GR9214ggDgNR6kUazPMavG4qvSzN
         QtuoogODZ2OG/Vsp9VyJYuPC85ymWIzvdf7WcK8BX5gVKOvE0b12TfB6bFNueEjXKmzU
         2UchGdlTxo7MflxPGecjdzlzj+5HqXLPu6xgbTt3zicl/WrpL0MkC+uqXMAn/wXf9KHV
         PCuA==
X-Gm-Message-State: AOJu0Yxwme9mgF0EjGnthBY38HQtFz7grVsBQ5oT2rc3hjpzNY7X/R2Q
	wy7Ot8UVcHQgLB/SCykbGkmSGqdfdq14BcpgFm/eU57ty8YrUdCdV68pg1H0Bw==
X-Gm-Gg: ASbGncvl3I/GYPJvEBJKTgEhmG+nDmS1ReSnm3JLvvll0ZYuJP79rlZ6N1NRhm68LPJ
	Kn1KcmNDsilMFgK6L9I4s4CEtYfXfdduFdIxjlA3n3wfipPYyuqrjYJprkEIPKGC7g+M/VwzaH7
	R/nFdn44tLDDszL416KA8CCa1WZMPFH7CDZm7uAF8ME99rDXh5oc8KrkPYlZhRT9NEEaHar+rM3
	oL00LTZ+XIkGbXRvdLClXNK9jEkKQyq5+Qai6lwAiDgaRtdz/HlW0UGjAg1wPBEaYhdN5I1mcM3
	mlro34f/pQuLfbsqxBQubMqxrjWV7Inm1IabJSFBvg2NUlt6be7MKPMWGE7+sofDoJY=
X-Google-Smtp-Source: AGHT+IGaF25b+KFHyJdESkI1lKfFaiWVAkjVXb86JdAaIYwH+sNp0zFhuYVUvq1XHhGmfmzLqhqGpg==
X-Received: by 2002:a05:6820:2221:b0:5fc:b059:7597 with SMTP id 006d021491bc7-5fcb0597a2cmr608862eaf.1.1739409222571;
        Wed, 12 Feb 2025 17:13:42 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:41 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v5 10/11] bnxt_en: Extend queue stop/start for TX rings
Date: Wed, 12 Feb 2025 17:12:38 -0800
Message-ID: <20250213011240.1640031-11-michael.chan@broadcom.com>
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

In order to use queue_stop/queue_start to support the new Steering
Tags, we need to free the TX ring and TX completion ring if it is a
combined channel with TX/RX sharing the same NAPI.  Otherwise
TX completions will not have the updated Steering Tag.  If TPH is
not enabled, we just stop the TX ring without freeing the TX/TX cmpl
rings.  With that we can now add napi_disable() and napi_enable()
during queue_stop()/ queue_start().  This will guarantee that NAPI
will stop processing the completion entries in case there are
additional pending entries in the completion rings after queue_stop().

There could be some NQEs sitting unprocessed while NAPI is disabled
thereby leaving the NQ unarmed.  Explicitly re-arm the NQ after
napi_enable() in queue start so that NAPI will resume properly.

Error handling in bnxt_queue_start() requires a reset.  If a TX
ring cannot be allocated or initialized properly, it will cause
TX timeout.  The reset will also free any partially allocated
rings.  We don't expect to hit this error path because re-allocating
previously reserved and allocated rings with the same parameters
should never fail.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v5:
Remove reset counter increment.
Add comments about napi_disable().
Add comments that ring alloc should always succed in this code path.

v3:
Fix build bot warning.
Only free TX/TX cmpl rings when TPH is enabled.

v2:
Add reset for error handling in queue_start().
Fix compile error.

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 119 ++++++++++++++++++++--
 1 file changed, 110 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2d0d9ac8e2c4..1997cdbd5801 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11279,6 +11279,78 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	return 0;
 }
 
+static void bnxt_tx_queue_stop(struct bnxt *bp, int idx)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct netdev_queue *txq;
+	struct bnxt_napi *bnapi;
+	int i;
+
+	bnapi = bp->bnapi[idx];
+	bnxt_for_each_napi_tx(i, bnapi, txr) {
+		WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
+		synchronize_net();
+
+		if (!(bnapi->flags & BNXT_NAPI_FLAG_XDP)) {
+			txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
+			if (txq) {
+				__netif_tx_lock_bh(txq);
+				netif_tx_stop_queue(txq);
+				__netif_tx_unlock_bh(txq);
+			}
+		}
+
+		if (!bp->tph_mode)
+			continue;
+
+		bnxt_hwrm_tx_ring_free(bp, txr, true);
+		bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
+		bnxt_free_one_tx_ring_skbs(bp, txr, txr->txq_index);
+		bnxt_clear_one_cp_ring(bp, txr->tx_cpr);
+	}
+}
+
+static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct netdev_queue *txq;
+	struct bnxt_napi *bnapi;
+	int rc, i;
+
+	bnapi = bp->bnapi[idx];
+	/* All rings have been reserved and previously allocated.
+	 * Reallocating with the same parameters should never fail.
+	 */
+	bnxt_for_each_napi_tx(i, bnapi, txr) {
+		if (!bp->tph_mode)
+			goto start_tx;
+
+		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
+		if (rc)
+			return rc;
+
+		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, false);
+		if (rc)
+			return rc;
+
+		txr->tx_prod = 0;
+		txr->tx_cons = 0;
+		txr->tx_hw_cons = 0;
+start_tx:
+		WRITE_ONCE(txr->dev_state, 0);
+		synchronize_net();
+
+		if (bnapi->flags & BNXT_NAPI_FLAG_XDP)
+			continue;
+
+		txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
+		if (txq)
+			netif_tx_start_queue(txq);
+	}
+
+	return 0;
+}
+
 static void bnxt_free_irq(struct bnxt *bp)
 {
 	struct bnxt_irq *irq;
@@ -15641,7 +15713,9 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
+	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
@@ -15659,27 +15733,39 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
+	bnapi = rxr->bnapi;
+	cpr = &bnapi->cp_ring;
+
 	/* All rings have been reserved and previously allocated.
 	 * Reallocating with the same parameters should never fail.
 	 */
 	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 	if (rc)
-		return rc;
+		goto err_reset;
 
 	if (bp->tph_mode) {
 		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 		if (rc)
-			goto err_free_hwrm_rx_ring;
+			goto err_reset;
 	}
 
 	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
 	if (rc)
-		goto err_free_hwrm_cp_ring;
+		goto err_reset;
 
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
+		rc = bnxt_tx_queue_start(bp, idx);
+		if (rc)
+			goto err_reset;
+	}
+
+	napi_enable(&bnapi->napi);
+	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
+
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 		vnic = &bp->vnic_info[i];
 
@@ -15696,11 +15782,12 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
-err_free_hwrm_cp_ring:
-	if (bp->tph_mode)
-		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
-err_free_hwrm_rx_ring:
-	bnxt_hwrm_rx_ring_free(bp, rxr, false);
+err_reset:
+	netdev_err(bp->dev, "Unexpected HWRM error during queue start rc: %d\n",
+		   rc);
+	napi_enable(&bnapi->napi);
+	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
+	bnxt_reset_task(bp, true);
 	return rc;
 }
 
@@ -15708,7 +15795,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i;
 
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
@@ -15720,17 +15809,29 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
 	rxr = &bp->rx_ring[idx];
-	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
+	bnapi = rxr->bnapi;
+	cpr = &bnapi->cp_ring;
+	cancel_work_sync(&cpr->dim.work);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	page_pool_disable_direct_recycling(rxr->page_pool);
 	if (bnxt_separate_head_pool())
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
+		bnxt_tx_queue_stop(bp, idx);
+
+	/* Disable NAPI now after freeing the rings because HWRM_RING_FREE
+	 * completion is handled in NAPI to guarantee no more DMA on that ring
+	 * after seeing the completion.
+	 */
+	napi_disable(&bnapi->napi);
+
 	if (bp->tph_mode) {
 		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 		bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
 	}
+	bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.30.1


