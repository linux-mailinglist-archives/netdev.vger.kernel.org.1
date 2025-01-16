Return-Path: <netdev+bounces-159027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C2A14238
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F1016B4B4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E9236EAD;
	Thu, 16 Jan 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gH7SCqI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0830236EA7
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055494; cv=none; b=AL3UUoL+kaPtNpL7gwRdIOOmHc1ovPmr9FOqj2czJ6OXCDA4WrdTJU4+IFlEVjFIaSWcci7gbeReGOvmWmO5ANJCvfQ7tnQg34gzGIa5FZltrY0lTrcIXc8DlQTblPkuLcEfDr6sqtAjzN/eCl6VaPNoG0F9DuoKoF5dA2VCT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055494; c=relaxed/simple;
	bh=E58GvqhozK+gaW3eihquJWJ1LOx1W6wRt9ibHixt4vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6m3JogW5IrzJI3yEhB0FP++B1oMAJQFUvJ0d7+IIEHWG4l1wg07M/Z+oDEIUkr7HFKi39fgRZlo/+JYhMoVPoLoOemYBUhOYub4j13aXTjxxdHtQPRJKFF792gb8imeQjlwJ7BG50CLXMLeY5eJ2fbUGkUxj0mOn361nxFzGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gH7SCqI/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso2332202a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055492; x=1737660292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdP3feKOUFs58rghXCz6CIm+je/v3MlelitZTR4Vf8k=;
        b=gH7SCqI/IM8PSwLKG4kWjtPsVU6FgfMdkx96ZVR6xZL44bz3Vwqs3tFHZ3l7RNdN9O
         HTsrXY8+93SZMgiUZAX3Hpdkh74zgQz61A7V+kvPIBPPXyrbHlRQUUtKJGFBntpyRH9A
         EzoyPEmCraCr198yxb5nv7yIwBjUc6INKY/AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055492; x=1737660292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdP3feKOUFs58rghXCz6CIm+je/v3MlelitZTR4Vf8k=;
        b=xGBJj85PvVHk/2h6n5qxaq5d23x5CTvYVTT/dD6baQLnNXN238i+owcK7kfbMcExKH
         U2oNHZw3jezdQsrf+1eVQ93hiDO5G2PGye6d2IuQGvn19J9n94MzL6rC/R29g+O1QHy8
         St/yxTBYjYsXwNVXucbNk93Pc8E2QTexT7MTe4KHBDIagi9VIinUXhvPegHkCuRvITnw
         6P/486ByJuFkLSTC856R4K+ksz+BSehl7oEW2LqoQJZaEoPv8kZbhgo5AXd716qxLrgi
         icXaqUNt+ycZVLA2mHC5uazOeeGcuzJoczWS117Il9S46jAbeMgUv/RR093Vdooy6zgo
         tYJQ==
X-Gm-Message-State: AOJu0Yz2dk9c3eGrO5HGjIol1rFoOpJHUrj5QhIoFrxwa//lGprqkA5u
	ZWt46QYJYpT3CHm6YKuQDtPR5MUBC9aYXygG3IhrSaBe6j7Jw2exCOPZewfOAw==
X-Gm-Gg: ASbGnctbepxl4OF8w8kg5QxX1xXzFeeKO4g5gO9lb2G6rGzNzoUjtbCKbGwT18ZgewH
	hP0Yc0nLdiFCSy6FZX5SslYQr+7/68WH3aweRwL4jEGWsLktE4cXi4CvlQbjwGGxnKGjHUq5Wp2
	3S4+GSYP4Rt+fldJKgIiwN2aEBSYH0tPQFyDWyWHYAlsUqiuDj2xBUErelfu2/ZZHRw1Phz8kAJ
	v0dQPikcJlLvoQHyiYOwnDJ3DWJfuiDs9lhStHnkzNuVJTNpjW0T/E1qLqj67CNIebZE37yOMxM
	caRUuot2YOhrnPRF1yM7/Sy0iUE+Zm54
X-Google-Smtp-Source: AGHT+IGCo+ygjJ/NAgv2pQcgNbjIRQe1c9tnCi7OOcK29Z9HBM1vF8eI5iyJX4EsTM6HfAOPNXuqsQ==
X-Received: by 2002:a17:90a:dfcb:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2f548da510amr58990992a91.0.1737055491969;
        Thu, 16 Jan 2025 11:24:51 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:51 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for TX rings
Date: Thu, 16 Jan 2025 11:23:42 -0800
Message-ID: <20250116192343.34535-10-michael.chan@broadcom.com>
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

In order to use queue_stop/queue_start to support the new Steering
Tags, we need to free the TX ring and TX completion ring if it is a
combined channel with TX/RX sharing the same NAPI.  Otherwise
TX completions will not have the updated Steering Tag.  With that
we can now add napi_disable() and napi_enable() during queue_stop()/
queue_start().  This will guarantee that NAPI will stop processing
the completion entries in case there are additional pending entries
in the completion rings after queue_stop().

There could be some NQEs sitting unprocessed while NAPI is disabled
thereby leaving the NQ unarmed.  Explicitly re-arm the NQ after
napi_enable() in queue start so that NAPI will resume properly.

Error handling in bnxt_queue_start() requires a reset.  If a TX
ring cannot be allocated or initialized properly, it will cause
TX timeout.  The reset will also free any partially allocated
rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v2:
Add reset for error handling in queue_start().
Fix compile error.

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 124 ++++++++++++++++++++--
 1 file changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 53279904cdb5..0a10a4cffcc8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7346,6 +7346,22 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
+static void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+				   bool close_path)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
+		       INVALID_HW_RING_ID;
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
+				cmpl_ring_id);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   bool close_path)
@@ -11252,6 +11268,68 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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
+	bnxt_for_each_napi_tx(i, bnapi, txr) {
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
+
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
@@ -15616,6 +15694,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
@@ -15633,25 +15712,40 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
+	bnapi = rxr->bnapi;
 	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 	if (rc)
-		return rc;
+		goto err_reset_rx;
 
 	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 	if (rc)
-		goto err_free_hwrm_rx_ring;
+		goto err_reset_rx;
 
 	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
 	if (rc)
-		goto err_free_hwrm_cp_ring;
+		goto err_reset_rx;
 
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
-	cpr = &rxr->bnapi->cp_ring;
+	cpr = &bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
+		cpr->sw_stats->tx.tx_resets++;
+		rc = bnxt_tx_queue_start(bp, idx);
+		if (rc) {
+			netdev_warn(bp->dev,
+				    "tx queue restart failed: rc=%d\n", rc);
+			bnapi->tx_fault = 1;
+			goto err_reset;
+		}
+	}
+
+	napi_enable(&bnapi->napi);
+	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
+
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 		vnic = &bp->vnic_info[i];
 
@@ -15668,10 +15762,12 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
-err_free_hwrm_cp_ring:
-	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
-err_free_hwrm_rx_ring:
-	bnxt_hwrm_rx_ring_free(bp, rxr, false);
+err_reset_rx:
+	rxr->bnapi->in_reset = true;
+err_reset:
+	napi_enable(&bnapi->napi);
+	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
+	bnxt_reset_task(bp, true);
 	return rc;
 }
 
@@ -15679,7 +15775,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i;
 
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
@@ -15691,15 +15789,23 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
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
+	napi_disable(&bnapi->napi);
+
 	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 	bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
+	bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.30.1


