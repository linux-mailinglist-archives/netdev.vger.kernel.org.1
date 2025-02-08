Return-Path: <netdev+bounces-164374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98933A2D8A2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35C418889D3
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAB241C91;
	Sat,  8 Feb 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F95xWLqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792B1F3BB2
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046619; cv=none; b=k7P0kzBbPj5/4XAAYorPFwC+bJP2zgszC+bCH2Bzj6WJwDbEx5IRY1X7ctDzv/ZU1cB+F23Z8WOTz5EuuSwuUn/6jHfyl5aVKYj58mPwbrgTIFGIJOC1KrCAOyeSCrhMUHbCjhWzSSdCuKrH2krZU+xbqfLc48JXJcfKJXZX6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046619; c=relaxed/simple;
	bh=yr5NVaXF4WifkmHfycJ5OUi5ZYuO/tTL86mjoK412Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj4zOt0Vzc09CwOkuZMk6Lgz8Ila2ZpFdX54lpkiCO/8WFxYi98R1Ki2YiJWRtO1ypkx+AhZxqb5Th/dEEfzfX3ohMKjcOWh1sUdas0PUHqiUmpY95hLKEo5UQG38dfDKu0wNAHFJF8RJqiT14QZWqduhI2JTQ95u72TSmbtU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F95xWLqX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e15717a2dso1707805a34.3
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046617; x=1739651417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RTIyK0KIR1ajEu0JkWqsIzhmuIaJw1KfFrmwDSSJ1w=;
        b=F95xWLqXLOz+J6EA+HbwzugZGteCZHRHp9Pkyut8mCyAfj8tgaM9BiIjv5/Nh9a4/8
         tHdVfYB2qkk1trmXQ4sDdA3IDYeSI4pJffb/b/UhQorrMdPjcANJ+aWMlnH+O36Scid0
         gBVdKOyWfEktP4c062M19F0J7xEV7gKh46sVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046617; x=1739651417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RTIyK0KIR1ajEu0JkWqsIzhmuIaJw1KfFrmwDSSJ1w=;
        b=S5wW4ErTfGtnB5uWpMO3Sgj/1dPY6GxYqwie+wcXEeBTQp/Fm5aQlgPm7o0Tq6OvS6
         7Zd22t8cEOAvk6IfTkCOJec0bPkepcvsjAqrnhHbaBKouSiIcXiB1CYx2T5zOr/BpL5S
         r+uWh3XFUrw1pzeKXz2tvycubLWXH9zCE+D+z1OEKdfIXJRVgMYjXQXDuw3RgA+ljYfo
         GL4BjP2UVWhgsMYXKKw6oNjeMcOjJ6gaR1lHv11taCqHlETATvhotFmE1m/gUOg/incd
         Sz3qcBQF9b9rv/TyA/ueS0advBKfyznDul7LfPNPoAuEv5tHlU34/B039DOA2xSAuCw5
         rb5A==
X-Gm-Message-State: AOJu0YyhOZWew9Mc3Ux5X+MaYqNj+CSL+xedOnb5OpiwQZbyv/jbBcv0
	6lgT4lLDRanPDx8DaACChZd4fO1z8A30I1TUTH5swI2N50Yy9tOEDbcg1DqOdg==
X-Gm-Gg: ASbGnctwWhMdphH9VCu9Zni3tbAAybrw7B5/viQJ+5ccyDJ0u7NVocXR04n3rxjn9q6
	XKvI33+8mNVHSSnbWBz1J+j4VHzhZRwuT8184X3Uce8bxib/pA6Ui6VkrAcurIz9JEploHAEiUD
	0bCViAm2c6S9/6QxSWm+K5ZQMkEchQnwvjy23eUITwbqENNUekTwaxYU4rbfcVOrpZlbodoPmSA
	vRrj8I65ze6yBJem/pd5Tnr4K9MAs6Y4S9cxIwy1BXhuA0WXvsHeZbXgr1pYzOI7U43FnTtC9DG
	wnUEx57sNlBpqcASp6o+HdCg90JsBtnAfU0bIn7PRYG4B+uaybzRRBK27LeNjVH/m40=
X-Google-Smtp-Source: AGHT+IF0uwnmJr6/J0k3Bed/Il0b7oXI5iKGt3T5fBE/iugbkvVhU0J2jHB1gZQLz7Tt3SHHxcLnFg==
X-Received: by 2002:a05:6830:61ca:b0:71e:373:6257 with SMTP id 46e09a7af769-726b8887274mr6956041a34.21.1739046616866;
        Sat, 08 Feb 2025 12:30:16 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:16 -0800 (PST)
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
Subject: [PATCH net-next v4 09/10] bnxt_en: Extend queue stop/start for TX rings
Date: Sat,  8 Feb 2025 12:29:15 -0800
Message-ID: <20250208202916.1391614-10-michael.chan@broadcom.com>
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


