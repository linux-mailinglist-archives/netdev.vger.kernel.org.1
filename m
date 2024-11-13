Return-Path: <netdev+bounces-144317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371329C68CD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC27B23E67
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128B175D45;
	Wed, 13 Nov 2024 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="huZN5r+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A717ADF8
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476396; cv=none; b=PcdVjkOBKtsQVtB3Ty6wRIreU8+fmM+jvEu6iIjL+DQQ63EZe/20g/hKn3Oegl6Z7aUQhWxtCHFeizgrTMDP5RKsWkuVHXpBIAbrYlqpr7vdzFxTPTaRpYCvQ4k71tOVXRj/7Wwvank9Z1YQAD0QWo+6KdxduHwYkVGN2suNMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476396; c=relaxed/simple;
	bh=za0bpsogRxHm4NMYxv8TajsbSFkBAJ1cX8dK5TCTZuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cet5hhEQ6vpCDnc9AFeym72V5EihIgbm+HjDUrHTycZuXS5tiLGpduzlH0A6uyrikWVIttnkVEQP+ldSS95sgl7GIoVR/vgODqo7r4RJzjSwckwFYQXoTJYC+KpoyzByNjuscgWG/V5cL0OOuuYEmuhngEuK7X4sn/tstssQlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=huZN5r+U; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609beb631aso50934541cf.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476394; x=1732081194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMyXb5/y7I5147Me22ncRWOHA10ESARq7LBgy9CZhbc=;
        b=huZN5r+UyUT8I50HnunfrbKCF6liIjUxmb1axKwOIfh8Bfila0M1maxty1+MU+6dnY
         DxwsvaRf4CQvwU5/3CU4mRSvMXohzwXL5gGnhIw83VqGrl+NMFCkJjBTW1ssf68HSMSq
         xpyYr1LlwVvmuodiVFjnVtJve4pBt8QzkwGJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476394; x=1732081194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMyXb5/y7I5147Me22ncRWOHA10ESARq7LBgy9CZhbc=;
        b=T6K5rHymNrFcLfdEhOLDbBdUIPPIX1g82yjgtOv61J2d5oTO8Y6DBEAxQmsPvqS71S
         6zG9kEqJA+NbJLUSPkSd65j4eCQuccrafIwtiNqc5/2Dv/cPtlqQqyw4BVjXmvJS2LFg
         DGBpZLvctlB9lVwYBaHzFmXvfDaQfq25wG5clnax6Yon9kwXZmvblLuYnGLmPtxp6Afw
         AblUSQdTimavs4sfs+t4KUBmUAoTyfGbU1rQKy1o/Q9Jrj4SA5LshxQaT83I3rqU+MPh
         1SDu4HkQAM3DdmjUwfZpGmurdWU/dxL/YIHoCJuKiMbcODYa2b/ShRN7PEcX2XSNjIBs
         Dffw==
X-Gm-Message-State: AOJu0Yz1Wivd+r6BHJtOu7k+W3ts8vikjzdRENBtzch6KOidE4zahE9/
	xEVzya2F+GHKPWZs95VQiitsq7SvkX4kyhTmUITMRWHLd6ujruT9Patp2Zu1Yg==
X-Google-Smtp-Source: AGHT+IGc6ueDLypKAdZ2sBl7IRZz58ZTc4kuxQbTB2hTROous5s5XtH5KBESFPf36ek/ZXsbUt1WQg==
X-Received: by 2002:a05:622a:2999:b0:461:313e:8865 with SMTP id d75a77b69052e-4630933bbe0mr263179851cf.21.1731476393883;
        Tue, 12 Nov 2024 21:39:53 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:52 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com
Subject: [PATCH net-next 04/11] bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
Date: Tue, 12 Nov 2024 21:36:42 -0800
Message-ID: <20241113053649.405407-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241113053649.405407-1-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

If 'force' is false, it will keep the memory pages and all data
structures for the context memory type if the memory is valid.

This patch always passes true for the 'force' parameter so there is
no change in behavior.  Later patches will adjust the 'force' parameter
for the FW log context memory types so that the logs will not be reset
after FW reset.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 44 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2e4fcab98cc9..7355db3e060c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8231,7 +8231,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 {
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
-	struct bnxt_ctx_mem_info *ctx;
+	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u16 type;
 	int rc;
 
@@ -8239,10 +8239,12 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	bp->ctx = ctx;
+	if (!ctx) {
+		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		bp->ctx = ctx;
+	}
 
 	resp = hwrm_req_hold(bp, req);
 
@@ -8291,7 +8293,8 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 	struct hwrm_func_backing_store_qcaps_input *req;
 	int rc;
 
-	if (bp->hwrm_spec_code < 0x10902 || BNXT_VF(bp) || bp->ctx)
+	if (bp->hwrm_spec_code < 0x10902 || BNXT_VF(bp) ||
+	    (bp->ctx && bp->ctx->flags & BNXT_CTX_FLAG_INITED))
 		return 0;
 
 	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
@@ -8764,11 +8767,16 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 }
 
 static void bnxt_free_one_ctx_mem(struct bnxt *bp,
-				  struct bnxt_ctx_mem_type *ctxm)
+				  struct bnxt_ctx_mem_type *ctxm, bool force)
 {
 	struct bnxt_ctx_pg_info *ctx_pg;
 	int i, n = 1;
 
+	ctxm->last = 0;
+
+	if (ctxm->mem_valid && !force)
+		return;
+
 	ctx_pg = ctxm->pg_info;
 	if (ctx_pg) {
 		if (ctxm->instance_bmap)
@@ -8782,7 +8790,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 	}
 }
 
-void bnxt_free_ctx_mem(struct bnxt *bp)
+void bnxt_free_ctx_mem(struct bnxt *bp, bool force)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u16 type;
@@ -8791,11 +8799,13 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 		return;
 
 	for (type = 0; type < BNXT_CTX_V2_MAX; type++)
-		bnxt_free_one_ctx_mem(bp, &ctx->ctx_arr[type]);
+		bnxt_free_one_ctx_mem(bp, &ctx->ctx_arr[type], force);
 
 	ctx->flags &= ~BNXT_CTX_FLAG_INITED;
-	kfree(ctx);
-	bp->ctx = NULL;
+	if (force) {
+		kfree(ctx);
+		bp->ctx = NULL;
+	}
 }
 
 static int bnxt_alloc_ctx_mem(struct bnxt *bp)
@@ -11756,7 +11766,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-			bnxt_free_ctx_mem(bp);
+			bnxt_free_ctx_mem(bp, true);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
@@ -13469,7 +13479,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 }
 
 static bool is_bnxt_fw_ok(struct bnxt *bp)
@@ -15326,7 +15336,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
@@ -15968,7 +15978,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
@@ -16022,7 +16032,7 @@ static int bnxt_suspend(struct device *device)
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	rtnl_unlock();
 	return rc;
 }
@@ -16134,7 +16144,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	rtnl_unlock();
 
 	/* Request a slot slot reset. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5b921c57a9f8..5fcb5a980bdf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2823,7 +2823,7 @@ int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
-void bnxt_free_ctx_mem(struct bnxt *bp);
+void bnxt_free_ctx_mem(struct bnxt *bp, bool force);
 int bnxt_num_tx_to_cp(struct bnxt *bp, int tx);
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 4cb0fabf977e..901fd36757ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -463,7 +463,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			break;
 		}
 		bnxt_cancel_reservations(bp, false);
-		bnxt_free_ctx_mem(bp);
+		bnxt_free_ctx_mem(bp, true);
 		break;
 	}
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE: {
-- 
2.30.1


