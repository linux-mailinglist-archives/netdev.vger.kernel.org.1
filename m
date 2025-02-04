Return-Path: <netdev+bounces-162327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB2A268E1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE371882827
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDF70810;
	Tue,  4 Feb 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FwtC1WSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC9145A11
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630037; cv=none; b=opDM1s/TPkJD9ka1UssMgXNYpLGy1KeSpdIYutZ1UiF794TQywqToDKALICvlH240rCg7di3zwc/faiQqNH7bUBd1Ii77lgkgad4DnuxkkZT9uMtK9cv97Q514uToVzaZ3iUNMDuOTmS++JyXiFEg5ANw/j6S3UK+HVa/C6f2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630037; c=relaxed/simple;
	bh=yr5NVaXF4WifkmHfycJ5OUi5ZYuO/tTL86mjoK412Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLmaXxqs/D3ToAFvD1ugK+Htt8PjWj4QW9s6E/65WSW9T2V7KncO7jNarVqOoQJDZPAhxRFZDiaKujAbndt5m+w3T+aNwwYJKoOpvGpmY70r6Qki2Qg95oxCsZG13nHjnN3xNiEKRPsvOXqrkQsw7irk5hD0k3wZrGJewLdYqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FwtC1WSX; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29f7b5fbc9aso1305592fac.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630034; x=1739234834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RTIyK0KIR1ajEu0JkWqsIzhmuIaJw1KfFrmwDSSJ1w=;
        b=FwtC1WSX8N4ydE4FUqe+tXsaISMZCNUQSq4Di8SkCvJsSPxhCOSNSvK1yEZF//ZAZA
         CJvgM3sUMUv7CEL/0wQtcfzMMxe1MBd9WlfxIgl5xkhcwFdYhg4xXkyQIu7erEJLwWN9
         Dpron5NJea/0ZFDz1qMmBq8DlFIXUv4+w/aEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630034; x=1739234834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RTIyK0KIR1ajEu0JkWqsIzhmuIaJw1KfFrmwDSSJ1w=;
        b=Tep6GwblccRjlLBzpTaCpUb9PTm/PpqUQsoL54nybbGDWDG+j14hH6JjSllyrES6xk
         ChH5vseGgWBG1bCfNgncmyl7DLKIqIL40IZXfvrjc4Bsqw7/wN7WzltLSW4JM0b3EfuY
         MT8B8XnmdPSq+46FNXv7xPxiB+gAhg4xl/hu5CPnG4RPgwkiAfBdYJeF/HQZ1pUkBk5k
         ss/tWPo9Xw4cMmH+mzJ2nbXWmnX3TFXmFHCjR8aX4v1R4pyxJtETn6x/SNZ/zlZLLVwi
         q52MEUebHDnGOZV89LT40yK66IVlIqNS5wMJuUCMzKt1u32o48BquFJ20ui/j89T+9Ra
         3P3A==
X-Gm-Message-State: AOJu0YwBNSbq57GEsZfAq8IR/g1/DpGzkauiY04ZpqkZ6Iv/YR9X7dTi
	C5Alu99nrk9iWlFhbHuNlO20O0tXzVkwVfR/ldNfAHPyNvkT1WUhax4VQCsFjA==
X-Gm-Gg: ASbGncvgG8umkgA5P8LuQvR7HNAazmsv0BC0DUhminNcX0Kueu2LCpfNQsSwRS9YppU
	EM5SHo7APvc0SdUgD+n8sIYNI+cZHlP9LgjCVZ4F3KPcZxfj39SlK9ihKaDCOUCxdWxJDjqyPWc
	YO1Ei2rBVd4y/afCxfvz/nJPQXYqZ6Ifh8FTZ3n5K4UJjmEfmCFt+Vu2SD63L1/veJ7YrcuhrGv
	2nSdEhJ6sWnwb064moQd85shs5bF9ClSxNMhah4xJR0oiGVgl2ZiiQCUvSwxH78Qc0bBqfEe1lA
	UPFGPNKUh8jESMuXu6WATuK9J96+Z5B5UjFS7J0rnxIicOSbCedoiv5VELD0f6A9ptE=
X-Google-Smtp-Source: AGHT+IEytnvdW1sngSIuGVrD4NFQZHENd2iweRtvuO4Ha2YZgRK4/fcBRkHGI/ulPtYyFHO9Cdl5Rg==
X-Received: by 2002:a05:6871:2106:b0:29e:6096:c271 with SMTP id 586e51a60fabf-2b32eff0913mr14324616fac.9.1738630034316;
        Mon, 03 Feb 2025 16:47:14 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:13 -0800 (PST)
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
Subject: [PATCH net-next v3 09/10] bnxt_en: Extend queue stop/start for TX rings
Date: Mon,  3 Feb 2025 16:46:08 -0800
Message-ID: <20250204004609.1107078-10-michael.chan@broadcom.com>
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
rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v3:
Fix build bot warning.
Only free TX/TX cmpl rings when TPH is enabled.

v2:
Add reset for error handling in queue_start().
Fix compile error.

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 132 ++++++++++++++++++++--
 1 file changed, 122 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 019a8433b0d6..fee9baff9e5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7368,6 +7368,22 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
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
@@ -11274,6 +11290,75 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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
@@ -15638,6 +15723,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
@@ -15655,27 +15741,42 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
+	bnapi = rxr->bnapi;
+	cpr = &bnapi->cp_ring;
 	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 	if (rc)
-		return rc;
+		goto err_reset_rx;
 
 	if (bp->tph_mode) {
 		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 		if (rc)
-			goto err_free_hwrm_rx_ring;
+			goto err_reset_rx;
 	}
 
 	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
 	if (rc)
-		goto err_free_hwrm_cp_ring;
+		goto err_reset_rx;
 
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
-	cpr = &rxr->bnapi->cp_ring;
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
 
@@ -15692,11 +15793,12 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
-err_free_hwrm_cp_ring:
-	if (bp->tph_mode)
-		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
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
 
@@ -15704,7 +15806,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i;
 
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
@@ -15716,17 +15820,25 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
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
 	if (bp->tph_mode) {
 		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 		bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
 	}
+	bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.30.1


