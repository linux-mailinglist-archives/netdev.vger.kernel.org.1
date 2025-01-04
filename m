Return-Path: <netdev+bounces-155121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF62A01247
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 05:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EAE3A45ED
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3014A0A3;
	Sat,  4 Jan 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BL85iHgw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C4146A9B
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735965573; cv=none; b=MqH2REkkZ3j5rBQPhJcoV3Xb4Aa6onXAYQBMghCvCdZVvEZ+1wEYg/DDgtTOJfSmujHeX8UURWpvszWnimya+1d/mGM4IzlnCJyxJEBxdcFRjaSWPX2GoKpZSGySbDEnyfjA57pkX4Gp/ktICYVlQbA6F1Wdvlu3Uz5HIbC/auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735965573; c=relaxed/simple;
	bh=06NiT+i0iRwI6hVmmBvbfTBIzcZHUplEbyHCT8gQFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQXU++AjAGJ03Gvh4i0ojejTvxZ74SxD6hB+mF6Ne3nwE0pEnMDkXPCiipmeWTkGaEnEP/9sn47rOfiK9QNl6y5XSiWMTVsTLzvQKWqSUrd82cmOE0m/S6vsG55t9bXXHfJXkDXkUm/WlIFdaQpld8dzKpQceNw+0a1T0RUHcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BL85iHgw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso126734795ad.2
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 20:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735965571; x=1736570371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC9AGSnYZXaXBYMYF2+xh/OU5YnscrawMetrXLNaVW0=;
        b=BL85iHgwqawOmetkzr1Hc+hftLEIBC51iKbFJRZeDhx0AAb/RQKKm8x9Ytqcn8UObH
         MeAXfmc60kBMzBixPjsoum3b48qJ48o8HfrpaessmvIcpauZZzO6o2JEbyVOqOUtlBuO
         EuYqc+onMVzhcCw5X9C2Sz5ZvxW/ugWYowS+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735965571; x=1736570371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC9AGSnYZXaXBYMYF2+xh/OU5YnscrawMetrXLNaVW0=;
        b=N/PG+zx+OyE3Ym4q+SMDlClfH+IN1p3pi381pBJ1ZyRPv/16RU7TAnIMW9TgtrBZnv
         mmN43PV8Jtn39I/VkQx2iw3Xo9gKT/bKGPCgwI+cbN+/S2fXlrfm6fa9bT7N9IcWO2kJ
         Bd6d0lnYF6gYXgqJSsQax2A40fSQW3mXfXIttuxuUeCf7bQG/wW3OGLYaWPAOJF4QAc+
         Vq01XnAnnvsu5fOmHUws8kInN5xqMWlvS3SiH30q7FNqVd+oCoCzNHj1laDvoVsi2w3g
         Sbk2CRiFr2RvCal9hVqeBpKmOc+eXnS1ur3ga6kzFHKGLXT8MLVACHGtl8FbOZPW05XT
         PL9w==
X-Gm-Message-State: AOJu0YyaKCNDDTfDAVjP2SK8qktnVKaDUqE9CaIHMLdbHTv9r33tvhbF
	MEoB2fYSUMeRDbwpSsA20+SWtcx7WNg4TDmBt3Hf6vvmU2Voi1ZCH81YpsVfMA==
X-Gm-Gg: ASbGncvxMrJJMpw/prnwz+NXc0eVHPNzsPv3Ypp82+jmhFzr7+PhjSat8h/ElcFnTNP
	B4GBaRhZL8RqS7f+n+heum7nxg+0HS6sMrBqZMWK3VQEV36LDI7ZC1GWaBDMPoV0hK4vf4hqnI8
	fPtsmkjMXW43279nmJmDZ1tAyoLOaWg2Gv5aaoCyGtq3qjsFlUgweP4kmfyPQkDjKWntkc1kAgt
	Ji++iGkxu3HXvy6pO3E0m58exfhiT0P2Y3LxlEmR98Ghy+1Iz3oY9+SH6PjXvajKba5j+PB1DIZ
	tLGmkKuORikzaoA2ZP2/MXostgX/rXAE
X-Google-Smtp-Source: AGHT+IF8dOpDrRzbHqO7a45StSeJFY0gOyOykhqZRtptvjn0KU3O3E9hyUOE6+9MOpr2uCVoM8Rljw==
X-Received: by 2002:a05:6a00:44ce:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72abdd5efb5mr64833530b3a.1.1735965570740;
        Fri, 03 Jan 2025 20:39:30 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb5dsm27038105b3a.86.2025.01.03.20.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:39:30 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/2] bnxt_en: Fix DIM shutdown
Date: Fri,  3 Jan 2025 20:38:48 -0800
Message-ID: <20250104043849.3482067-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250104043849.3482067-1-michael.chan@broadcom.com>
References: <20250104043849.3482067-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIM work will call the firmware to adjust the coalescing parameters on
the RX rings.  We should cancel DIM work before we call the firmware
to free the RX rings.  Otherwise, FW will reject the call from DIM
work if the RX ring has been freed.  This will generate an error
message like this:

bnxt_en 0000:21:00.1 ens2f1np1: hwrm req_type 0x53 seq id 0x6fca error 0x2

and cause unnecessary concern for the user.  It is also possible to
modify the coalescing parameters of the wrong ring if the ring has
been re-allocated.

To prevent this, cancel DIM work right before freeing the RX rings.
We also have to add a check in NAPI poll to not schedule DIM if the
RX rings are shutting down.  Check that the VNIC is active before we
schedule DIM.  The VNIC is always disabled before we free the RX rings.

Fixes: 0bc0b97fca73 ("bnxt_en: cleanup DIM work on device shutdown")
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 38 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b86f980fa7ea..aeaa74f03046 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2897,6 +2897,13 @@ static int bnxt_hwrm_handler(struct bnxt *bp, struct tx_cmp *txcmp)
 	return 0;
 }
 
+static bool bnxt_vnic_is_active(struct bnxt *bp)
+{
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
+
+	return vnic->fw_vnic_id != INVALID_HW_RING_ID && vnic->mru > 0;
+}
+
 static irqreturn_t bnxt_msix(int irq, void *dev_instance)
 {
 	struct bnxt_napi *bnapi = dev_instance;
@@ -3164,7 +3171,7 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 			break;
 		}
 	}
-	if (bp->flags & BNXT_FLAG_DIM) {
+	if ((bp->flags & BNXT_FLAG_DIM) && bnxt_vnic_is_active(bp)) {
 		struct dim_sample dim_sample = {};
 
 		dim_update_sample(cpr->event_ctr,
@@ -3295,7 +3302,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 poll_done:
 	cpr_rx = &cpr->cp_ring_arr[0];
 	if (cpr_rx->cp_ring_type == BNXT_NQ_HDL_TYPE_RX &&
-	    (bp->flags & BNXT_FLAG_DIM)) {
+	    (bp->flags & BNXT_FLAG_DIM) && bnxt_vnic_is_active(bp)) {
 		struct dim_sample dim_sample = {};
 
 		dim_update_sample(cpr->event_ctr,
@@ -7266,6 +7273,26 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 	return rc;
 }
 
+static void bnxt_cancel_dim(struct bnxt *bp)
+{
+	int i;
+
+	/* DIM work is initialized in bnxt_enable_napi().  Proceed only
+	 * if NAPI is enabled.
+	 */
+	if (!bp->bnapi || test_bit(BNXT_STATE_NAPI_DISABLED, &bp->state))
+		return;
+
+	/* Make sure NAPI sees that the VNIC is disabled */
+	synchronize_net();
+	for (i = 0; i < bp->rx_nr_rings; i++) {
+		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
+		struct bnxt_napi *bnapi = rxr->bnapi;
+
+		cancel_work_sync(&bnapi->cp_ring.dim.work);
+	}
+}
+
 static int hwrm_ring_free_send_msg(struct bnxt *bp,
 				   struct bnxt_ring_struct *ring,
 				   u32 ring_type, int cmpl_ring_id)
@@ -7366,6 +7393,7 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		}
 	}
 
+	bnxt_cancel_dim(bp);
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path);
 		bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path);
@@ -11309,8 +11337,6 @@ static void bnxt_disable_napi(struct bnxt *bp)
 		if (bnapi->in_reset)
 			cpr->sw_stats->rx.rx_resets++;
 		napi_disable(&bnapi->napi);
-		if (bnapi->rx_ring)
-			cancel_work_sync(&cpr->dim.work);
 	}
 }
 
@@ -15572,8 +15598,10 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 		bnxt_hwrm_vnic_update(bp, vnic,
 				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
 	}
-
+	/* Make sure NAPI sees that the VNIC is disabled */
+	synchronize_net();
 	rxr = &bp->rx_ring[idx];
+	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
-- 
2.30.1


