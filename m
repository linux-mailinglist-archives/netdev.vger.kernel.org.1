Return-Path: <netdev+bounces-145313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2600F9CEF8C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86959B32398
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798C1D54E1;
	Fri, 15 Nov 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V2r5+FiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCF1D517F
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683785; cv=none; b=WA1WHe9PAy96lpoULIOgkzQuxlrfMHLGWXRDCpmGfORN5OayXrI1VIsIj3TjNM4kZL8ZGflPhKL97gFb/SobkHmUBjxLxab4K1LOgKdp/AWwQCfZzGd+4sjkPPK68uZhyqDWnEz1iA5CcNYqZWWaRvhxD09lLEEfJgLp3Jx/sRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683785; c=relaxed/simple;
	bh=zPTOPc46x1D/9huyUG6smYxjX6jG3SZMxm6gpAKpTh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmYtHn7UzLeXNuXokmQ1yx1+aS9cwc1owiPjlFNXA6xSnhBY7GGa90690FWdnOWOKoTlp6jSPEwwQkYVqNyBV4O3HqW8uW2yOYwmWgC2dETubGaaNYm5BC7534RxeI2nH9cltawK00ZY7L8yIaOphOZfO85ogpSXwBNSjsdAJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V2r5+FiZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20e6981ca77so9429335ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683783; x=1732288583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOSqlL/+vxlsew4PpFTOmWZxwmKpfrscNTlL18lV+X8=;
        b=V2r5+FiZkCy2HIb0AYD7xU+Mz4q1HZ2VkSB+dk+RyzVpVdqgUKAykSya2Cg1tDgOC+
         Boo3F5ukaCxJg90OY0ocgmWs4JHQ5wDm5GBi7mly9pQ0jvyHHBn0WzNhRmP/P91aUE+O
         CxC3J7wf87H/7EouPWPtF7PT21FvTMzQTWDWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683783; x=1732288583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOSqlL/+vxlsew4PpFTOmWZxwmKpfrscNTlL18lV+X8=;
        b=PdLkPpzIg3aFQhgFG5PtPr2QToMWpIQm0Nn9MiFBqnlMei+QeDoB8izGECSkpu23W5
         NSLCSaTPoE3+llDSXbTB44aBFlI5dfEU5fqetsZZNVz4+stUw9oX5sJZd5cJwPPuv0ij
         yFwkg76dgjjOOZmiCTK3QG4M9npPx/7l4BwAwFvGUVaTke36ZXbylE7x+rw0CrsAtTU3
         8jV+yDqNbFRUJ7ZcsRrLCfNiR5IxdnpBRX+PwuFMER7ZCjwxAQYf3etftCfb+llYSrT2
         oqbFx9X8Lp5/6tY7P1bOcpvTRd9ntEZiid7MtmcdQTzFrsl20a7OpNAd75gELcKX8rgW
         C/lA==
X-Gm-Message-State: AOJu0YzIrHzGZ7SWCMXf3KKHcsgYKEJgjPIDJB7ZUTad2rSGi04UyfTF
	YWrRnzqZypVAmL4Az2kPTI8UKmb04TsS49FwxvvGojCzBOqpG3q6LlyXMonUrg==
X-Google-Smtp-Source: AGHT+IFGsUD9O4K4AfaiZiIbfsIHwEtiMchGPTsBwQOd//BA1evBrOSj2HOoMIcv/owJ3imXPq4l2g==
X-Received: by 2002:a17:903:11c9:b0:20c:d428:adf4 with SMTP id d9443c01a7336-211d0ecb083mr41812835ad.38.1731683783296;
        Fri, 15 Nov 2024 07:16:23 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:22 -0800 (PST)
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
Subject: [PATCH net-next v2 07/11] bnxt_en: Do not free FW log context memory
Date: Fri, 15 Nov 2024 07:14:33 -0800
Message-ID: <20241115151438.550106-8-michael.chan@broadcom.com>
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

If FW supports appending new FW logs to an offset in the context
memory after FW reset, then do not free this type of context memory
during reset.  The driver will provide the initial offset to the FW
when configuring this type of context memory.  This way, we don't lose
the older FW logs after reset.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 43 +++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 07510df4497b..b0f3b431708c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8300,6 +8300,9 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp, int ctx_max)
 	return 0;
 }
 
+static void bnxt_free_one_ctx_mem(struct bnxt *bp,
+				  struct bnxt_ctx_mem_type *ctxm, bool force);
+
 #define BNXT_CTX_INIT_VALID(flags)	\
 	(!!((flags) &			\
 	    FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT))
@@ -8328,6 +8331,8 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 	for (type = 0; type < BNXT_CTX_V2_MAX; ) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		u8 init_val, init_off, i;
+		u32 max_entries;
+		u16 entry_size;
 		__le32 *p;
 		u32 flags;
 
@@ -8337,15 +8342,26 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
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
-		ctxm->entry_size = le16_to_cpu(resp->entry_size);
+		ctxm->entry_size = entry_size;
 		ctxm->flags = flags;
 		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
 		ctxm->entry_multiple = resp->entry_multiple;
-		ctxm->max_entries = le32_to_cpu(resp->max_num_entries);
+		ctxm->max_entries = max_entries;
 		ctxm->min_entries = le32_to_cpu(resp->min_num_entries);
 		init_val = resp->ctx_init_value;
 		init_off = resp->ctx_init_offset;
@@ -8790,6 +8806,16 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
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
@@ -8884,6 +8910,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 		ctxm->pg_info = NULL;
 		ctxm->mem_valid = 0;
 	}
+	memset(ctxm, 0, sizeof(*ctxm));
 }
 
 void bnxt_free_ctx_mem(struct bnxt *bp, bool force)
@@ -11862,7 +11889,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-			bnxt_free_ctx_mem(bp, true);
+			bnxt_free_ctx_mem(bp, false);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
@@ -13575,7 +13602,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp, true);
+	bnxt_free_ctx_mem(bp, false);
 }
 
 static bool is_bnxt_fw_ok(struct bnxt *bp)
@@ -16128,7 +16155,7 @@ static int bnxt_suspend(struct device *device)
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
-	bnxt_free_ctx_mem(bp, true);
+	bnxt_free_ctx_mem(bp, false);
 	rtnl_unlock();
 	return rc;
 }
@@ -16240,7 +16267,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
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


