Return-Path: <netdev+bounces-157607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C190A0AF6A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B144B166241
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1A23313B;
	Mon, 13 Jan 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NaBjXi0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D3231A2B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750420; cv=none; b=I7Zls6EbMO0kVQWxAVHXAP+aG3tOi81hTBUVlB/cVQWiZqGS9O4lj6Qu0XWK0OykXYmBTIFa9gHFLDd8WaA/o24ag9Dv32JlqK2NgTUp2nYDfhgPtmDqgfaBIiQJnbgMBCZQMOI0L47g0rGYlVsKlE1SQV+8HUK759tzi0oyeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750420; c=relaxed/simple;
	bh=qtM4+neR5uKJIfJVuviqqJmsdus8dBgLjhKWXjtgA3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj7UxPr++Rdr2fYkVoyDbLUm9PKHKaqYsPuoqI31L4nXrCg9dY8lli7/nLskrW+g/dyUD3kAgiOUt9quS5E+v2DFh3obC7qThYcPt+f0MI8wkpPhNOcscVxHMTuyVbmQAx+A33vEvg33TptuJ/KmVFtRtKcYm9OCCGRyqKrELAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NaBjXi0O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163b0c09afso68258695ad.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750418; x=1737355218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBdYDp1JAUZJh0QPIMS3gD47vLzzKNVdhhPpNOWc8To=;
        b=NaBjXi0OyH67JwCUMdD9knL/yPKq2aCTHf0RqgdwXr62Ctl9Zz4Du9bPk+MEoSnJaT
         U7Qu2Kl2GVxlXyKMhLEmtK0hNyF+Nm4DMB5CHU4rPObPC+xl4Lf6B3NPPVJwblX+IklP
         XJiRc67XHlOfEhP3n05Ft4KO1vaUFWpIrYA8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750418; x=1737355218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBdYDp1JAUZJh0QPIMS3gD47vLzzKNVdhhPpNOWc8To=;
        b=FiLOGOcYiP050fxRYWtH0P7p3E8POilTOnLf+yXAWHD0hOau3hxwkaJztng2evNTLF
         XaxwaB7MKq2yVtTAdGo19MdBcz/mjhGkf48aa8zSsnzpDNjSNggPfh3sj4MERVn6AFJY
         /xwGWCgD2wmz5yC/BaGRyk8BRwpBUrenLpgmQEVJafCjcU41l7M2n3hrSBNEVKWtXMEA
         kzOtT0Hcv/weZsP9A7LZuG6qfZkWZJveDqq3pKVMSAk3ihwo4I5/tbC1QKsDalz27fsO
         28/fqXJh7aC87T6IzLGKhraqfwysB+gr+3OIxCIiDyZBzxMuvNfJxOjriqQg5xdxcEWx
         Eugw==
X-Gm-Message-State: AOJu0Yykrz8LTOWPSYiL2WBp/q25pjkVh3FOrtJ0TOo/Lzf3fbTlT14H
	t0ftvQJOSxPwOnscQiPx078vhEsma6wHbemi2v2CzkMQGuP9NDGO0IPm4OkNXnExhMSUJWEwRvw
	=
X-Gm-Gg: ASbGncs7xvT55Tv5HIjJeQ1LdjBth6yZGEXaHVGxPhyd8FTI7I7S9XqUqqQZ0FVZe4f
	4BZWKEJbOjzsRZQpNtbvxASJKx0/bP+tN/Y/BpC8UwRjavEDrSgfR6oPg9uvfbK7dMNM1OBD8gE
	mMhyz3pAOmiXqLLe6J01SfW9nkn6IuNwvQcF1XffOWO2p15/j0uB4eRMisMXEvKt8eZZzxdARPJ
	cHhQYTiJC/ZUJab6LTlPEeVy94YJI6wbbMTmP+WXmANB8knX87eq2/ylPBMt14PyIi1E7e4G4M1
	1RZqZR+etL76Vl8knTJPe84Wf00w3Gbb
X-Google-Smtp-Source: AGHT+IELI5ZjyUM0oy+fb6Ac44tkvh2dvLKAawewN8YVf8mq9w+RjQ1xf9MBNUI8FSlAxhsiC7hPYw==
X-Received: by 2002:a17:902:cecd:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21a83f3469cmr267171935ad.3.1736750418327;
        Sun, 12 Jan 2025 22:40:18 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:17 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx rings
Date: Sun, 12 Jan 2025 22:39:26 -0800
Message-ID: <20250113063927.4017173-10-michael.chan@broadcom.com>
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

In order to use queue_stop/queue_start to support the new Steering
Tags, we need to free the TX ring and TX completion ring if it is a
combined channel with TX/RX sharing the same NAPI.  Otherwise
TX completions will not have the updated Steering Tag.  With that
we can now add napi_disable() and napi_enable() during queue_stop()/
queue_start().  This will guarantee that NAPI will stop processing
the completion entries in case there are additional pending entries
in the completion rings after queue_stop().

There could be some NQEs sitting unprocessed while NAPI is disabled
thereby leaving the NQ unarmed.  Explictily Re-arm the NQ after
napi_enable() in queue start so that NAPI will resume properly.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 99 ++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fe350d0ba99c..eddb4de959c6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7341,6 +7341,22 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
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
@@ -11247,6 +11263,69 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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
+		if (rc) {
+			bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
+			return rc;
+		}
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
@@ -15647,6 +15726,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
+		rc = bnxt_tx_queue_start(bp, idx);
+		if (rc)
+			netdev_warn(bp->dev,
+				    "tx queue restart failed: rc=%d\n", rc);
+	}
+
+	napi_enable(&rxr->bnapi->napi);
+	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
+
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 		vnic = &bp->vnic_info[i];
 
@@ -15675,6 +15764,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
 	struct bnxt_vnic_info *vnic;
+	struct bnxt_napi *bnapi;
 	int i;
 
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
@@ -15686,15 +15776,22 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
 	rxr = &bp->rx_ring[idx];
-	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
+	bnapi = rxr->bnapi;
+	cancel_work_sync(&bnapi->cp_ring.dim.work);
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


