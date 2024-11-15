Return-Path: <netdev+bounces-145310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEAB9CED26
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3287B1F2412A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45571D222B;
	Fri, 15 Nov 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PVk3/4Vp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5C1D0DDF
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683781; cv=none; b=tV7lV645JYavX9lLKu/smqR/DIYLC9orgdGS2N2WjyfGe6gIc1mtzPCM36udxTJ/ap2MYT8PnLc1MGp2xQGgcnl9jlfJEcE/hGl2+NN3xIF4r2+Tr9kizqMnlYDfN1fcKODVXxKuevJGMsLQFdc+NAGWugjFyieXNOQrbmAM1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683781; c=relaxed/simple;
	bh=XcaRzltFQRoPzRGgogJb3mXiA4VucIAi+VkU0aeyock=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlENqziH8iDevj5cnMW/GSr2ZancidtvHLXiNpcULHHEtqvbtrXBUx5Kyidi5O057sbYJx6lDvxKtQMHITiEW++Xp5Kr6o/Zs+K6UH2dbaLW6TXdF+c2UVdfXbPtqsAODH9O5pEhu3TI+GX16mEXpojeX0ls6QnOlbtdZjvsC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PVk3/4Vp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21145812538so16040875ad.0
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683779; x=1732288579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPUkCf6IOTvlAtl1ZEDoapKbZ8PNj3MfYs1PUVS6tLY=;
        b=PVk3/4VpmBOSeGAVsW2gCW7kWBE1Aqvb7mhkIkWjmE5mObtr7bRn+8KOGTRhprFEaa
         sT92EQtDNl8opnYyqDsndmWZhT/pnKGvRr2t3q49MO17/tYgcP3J3eZYpBkjqg7Kbx4P
         6RxgbVx35pE/Ew4HcRq/Ah0uP0+uY7i9dTSqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683779; x=1732288579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPUkCf6IOTvlAtl1ZEDoapKbZ8PNj3MfYs1PUVS6tLY=;
        b=qEu0wXXBVuk3gu3rYd/Te6r0Q5uW020gIP+/jPzGaSFTV6bjrH5zOhHkoNI1fK2+vZ
         o2vOLAnKvOkzYNo6EvYGwV32k+3fGuosAULSR4FTGMEtO9nVecrIYDV7IF0KhIc2+yfV
         wxqEbd/QgCaWq0zf8nwda2Pz7EOwQi/8ZcRGRD49tlgIFXyFwPR5Ei/F0dY1lFRLpUPu
         exPLssjxY5XCv1pFEHh6PxBcPDuK6ukt89DKh5sIEMLVhprcCsrg9zv61QSMIuSn0YVm
         eohtX7s6Jc1wSa2IqpavPxUj49IGxoL6QCuvO0R8VfnVmCvrbovmOrUICt6nErlQ1MOJ
         xyHQ==
X-Gm-Message-State: AOJu0Yxjw9zHovgVIcuU4s4qh6LrNJYJIoKISLkUmIJsLCVTFXZVwzJ3
	g3lUwbLMsVVziQuvb4Ait9/j/UyvkvbyIo/MfEqjH6NcFUo638qhnLbZGNPVPqrVT9i6txmd8Qs
	=
X-Google-Smtp-Source: AGHT+IEGO35jgX8yIV7QL4cLYwp0DeZm1r2+w+I1jnyX4+8Uu2GugZKh/MUvQigTA5wpH1swZ3CVGw==
X-Received: by 2002:a17:902:f541:b0:211:31ac:89f7 with SMTP id d9443c01a7336-211d0d768eamr44187345ad.26.1731683779217;
        Fri, 15 Nov 2024 07:16:19 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:18 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com
Subject: [PATCH net-next v2 04/11] bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
Date: Fri, 15 Nov 2024 07:14:30 -0800
Message-ID: <20241115151438.550106-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
References: <20241115151438.550106-1-michael.chan@broadcom.com>
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
index 8c79b88c92b0..02a8d568857b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8233,7 +8233,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 {
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
-	struct bnxt_ctx_mem_info *ctx;
+	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u16 type;
 	int rc;
 
@@ -8241,10 +8241,12 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
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
 
@@ -8293,7 +8295,8 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 	struct hwrm_func_backing_store_qcaps_input *req;
 	int rc;
 
-	if (bp->hwrm_spec_code < 0x10902 || BNXT_VF(bp) || bp->ctx)
+	if (bp->hwrm_spec_code < 0x10902 || BNXT_VF(bp) ||
+	    (bp->ctx && bp->ctx->flags & BNXT_CTX_FLAG_INITED))
 		return 0;
 
 	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
@@ -8766,11 +8769,16 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
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
@@ -8784,7 +8792,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 	}
 }
 
-void bnxt_free_ctx_mem(struct bnxt *bp)
+void bnxt_free_ctx_mem(struct bnxt *bp, bool force)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u16 type;
@@ -8793,11 +8801,13 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
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
@@ -11758,7 +11768,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-			bnxt_free_ctx_mem(bp);
+			bnxt_free_ctx_mem(bp, true);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
@@ -13471,7 +13481,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 }
 
 static bool is_bnxt_fw_ok(struct bnxt *bp)
@@ -15328,7 +15338,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
@@ -15970,7 +15980,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
@@ -16024,7 +16034,7 @@ static int bnxt_suspend(struct device *device)
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	rtnl_unlock();
 	return rc;
 }
@@ -16136,7 +16146,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
-	bnxt_free_ctx_mem(bp);
+	bnxt_free_ctx_mem(bp, true);
 	rtnl_unlock();
 
 	/* Request a slot slot reset. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d1fa58d83897..a092ed3c2248 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2824,7 +2824,7 @@ int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
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


