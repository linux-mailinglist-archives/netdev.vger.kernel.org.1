Return-Path: <netdev+bounces-144320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C673D9C68D0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5677A1F21B45
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA8178CC8;
	Wed, 13 Nov 2024 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gzBazPPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063A17D36A
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476403; cv=none; b=fFAK3p0EyYPC4azpLLYbhuYd8j4ySy1zQr0VW43qbGxQHBRCNY6TzxyAUyBX78gAh09hZof+Pg3s0NOayUmu1FD5v5DYHkC7llLGRqSM7o6uveMNzcO6FGDHnNz3dD/RvfDViVN8aNu3o3ESv5X2uOlGCdVCbg26FrsvZn/T4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476403; c=relaxed/simple;
	bh=4QVqaJBm02QmRkdW7bvF/BSFFOO4VaYgcHyeBwpEI8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo/YRTd6bhLhq+88toMoDNG8eF1k+4+Lk/VDkLx/CSFuYBx4XygWHFUkq6wk7K8N03w35spIhJmkurMJqIRPqftS9Gb1IZSV3hJEJPRwBpDKhDoYTj0IWbbdFMYxBCkk3vHdVWQpHt3Rv9cWkvyU4SC2kOiXyPmDDiHn1LpJ2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gzBazPPJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609967ab7eso45819711cf.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476401; x=1732081201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSCfFYFggKAXKz/lnbFHsj/7DGeN6KF4cVRYcNvRsk4=;
        b=gzBazPPJ9bTRVsZ+vVzoM474D0cqbdvmmI7nCryaygiJpREpmLntop9f3mrSQ7uBeS
         EEPbFJlbtFwN5uPtKRYlGTedaml8PlsUpNsqcFjMWwWo5zgiG+lhbkCrt7eUdhsJIxlu
         AdbRjAKof9rLuj5uMYCE15BL63x0WXsEGLZaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476401; x=1732081201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSCfFYFggKAXKz/lnbFHsj/7DGeN6KF4cVRYcNvRsk4=;
        b=X9whia9WZtg7lociunLJyDa1PSXZmtrXAXfLa2LiIw2fGAgbxXKLnCDJXnKhctRiWM
         ZQWG+nBo0mntTWjkIharCJ9DqFB66BHrhnGJnryZn5PBH5EtF3a/9wNAcOkad1lvkaF2
         ZPI5ZSMuS+XAE1o8O3MPlBst4nZVz5fOhfDVNY4d0tP4nZMCaM1OHJhHSOMa0HVQSozA
         r8Q6ym3gY0GjZ4uRHLFRol4etklOWAIFmplbmLe7kIUB/eI7cXHVmwerEtcYoPgOHjAQ
         d8KBtGEr1548+xEFCrB02IQYZlHvpNYLctjG6Uh9D5nBHUxjA1UA9O5U4rsiCO0GiR5S
         5/2g==
X-Gm-Message-State: AOJu0Yx4dWaAG2OOI7ra8rJ++s7hy6VwkrIhAl3jObIFJIsbesw+seCJ
	eleSUmth+7zTw+5aQDRrgiAlvmKbB4TEYz9FwG56Iqe6S3AFS3RRPwkvbiitIw==
X-Google-Smtp-Source: AGHT+IHPsJA2LSwcyLFppRovnWsTVOgFIg5seQav7wgZk2QtnhFFE1ApBOLm4t7LVSP4UryNNnrTyw==
X-Received: by 2002:ac8:59c4:0:b0:458:2b7b:c45c with SMTP id d75a77b69052e-46309410f6amr318355451cf.39.1731476400755;
        Tue, 12 Nov 2024 21:40:00 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:59 -0800 (PST)
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
Subject: [PATCH net-next 07/11] bnxt_en: Do not free FW log context memory
Date: Tue, 12 Nov 2024 21:36:45 -0800
Message-ID: <20241113053649.405407-8-michael.chan@broadcom.com>
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

If FW supports appending new FW logs to an offset in the context
memory after FW reset, then do not free this type of context memory
during reset.  The driver will provide the initial offset to the FW
when configuring this type of context memory.  This way, we don't lose
the older FW logs after reset.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 39 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b14d48ba5a32..c5c40981b879 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8297,6 +8297,9 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp, int ctx_max)
 	return 0;
 }
 
+static void bnxt_free_one_ctx_mem(struct bnxt *bp,
+				  struct bnxt_ctx_mem_type *ctxm, bool force);
+
 #define BNXT_CTX_INIT_VALID(flags)	\
 	(!!((flags) &			\
 	    FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT))
@@ -8325,6 +8328,8 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 	for (type = 0; type < BNXT_CTX_V2_MAX; ) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		u8 init_val, init_off, i;
+		u32 max_entries;
+		u16 entry_size;
 		__le32 *p;
 		u32 flags;
 
@@ -8334,9 +8339,20 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 			goto ctx_done;
 		flags = le32_to_cpu(resp->flags);
 		type = le16_to_cpu(resp->next_valid_type);
-		if (!(flags & FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID))
+		if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
+			bnxt_free_one_ctx_mem(bp, ctxm, true);
 			continue;
-
+		}
+		entry_size = le16_to_cpu(resp->entry_size);
+		max_entries = le32_to_cpu(resp->max_num_entries);
+		if (ctxm->mem_valid) {
+			if (!(flags & BNXT_CTX_MEM_PERSIST) ||
+			    ctxm->entry_size != entry_size ||
+			    ctxm->max_entries != max_entries)
+				bnxt_free_one_ctx_mem(bp, ctxm, true);
+			else
+				continue;
+		}
 		ctxm->type = le16_to_cpu(resp->type);
 		ctxm->entry_size = le16_to_cpu(resp->entry_size);
 		ctxm->flags = flags;
@@ -8787,6 +8803,16 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 	hwrm_req_hold(bp, req);
 	req->type = cpu_to_le16(ctxm->type);
 	req->entry_size = cpu_to_le16(ctxm->entry_size);
+	if ((ctxm->flags & BNXT_CTX_MEM_PERSIST) &&
+	    bnxt_bs_trace_avail(bp, ctxm->type)) {
+		struct bnxt_bs_trace_info *bs_trace;
+		u32 enables;
+
+		enables = FUNC_BACKING_STORE_CFG_V2_REQ_ENABLES_NEXT_BS_OFFSET;
+		req->enables = cpu_to_le32(enables);
+		bs_trace = &bp->bs_trace[bnxt_bstore_to_trace[ctxm->type]];
+		req->next_bs_offset = cpu_to_le32(bs_trace->last_offset);
+	}
 	req->subtype_valid_cnt = ctxm->split_entry_cnt;
 	for (i = 0, p = &req->split_entry_0; i < ctxm->split_entry_cnt; i++)
 		p[i] = cpu_to_le32(ctxm->split[i]);
@@ -8881,6 +8907,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 		ctxm->pg_info = NULL;
 		ctxm->mem_valid = 0;
 	}
+	memset(ctxm, 0, sizeof(*ctxm));
 }
 
 void bnxt_free_ctx_mem(struct bnxt *bp, bool force)
@@ -11859,7 +11886,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-			bnxt_free_ctx_mem(bp, true);
+			bnxt_free_ctx_mem(bp, false);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
@@ -13572,7 +13599,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp, true);
+	bnxt_free_ctx_mem(bp, false);
 }
 
 static bool is_bnxt_fw_ok(struct bnxt *bp)
@@ -16125,7 +16152,7 @@ static int bnxt_suspend(struct device *device)
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp, true);
+	bnxt_free_ctx_mem(bp, false);
 	rtnl_unlock();
 	return rc;
 }
@@ -16237,7 +16264,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
-	bnxt_free_ctx_mem(bp, true);
+	bnxt_free_ctx_mem(bp, false);
 	rtnl_unlock();
 
 	/* Request a slot slot reset. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 901fd36757ed..ef8288fd68f4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -463,7 +463,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			break;
 		}
 		bnxt_cancel_reservations(bp, false);
-		bnxt_free_ctx_mem(bp, true);
+		bnxt_free_ctx_mem(bp, false);
 		break;
 	}
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE: {
-- 
2.30.1


