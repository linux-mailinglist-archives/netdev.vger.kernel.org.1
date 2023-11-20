Return-Path: <netdev+bounces-49450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62027F2192
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D906E1C211D0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56ED3B7B5;
	Mon, 20 Nov 2023 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h6xxtyB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245595
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc535cd5cso28303101cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523880; x=1701128680; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=11iRhgr2PLRNhVPu9HUHPwoEEU0Uc3Zhta4y4uUD0D8=;
        b=h6xxtyB0Fpu3fF/fEKoUKnJLlf2TaO0NY504rSHXf8RgxfArQk8HhtHaprFb3my2hl
         BJ2lLyLb+PL3mReGXsb6BX//9oMcOvuTrMTs7SKLsPdkjEKe/B0Xmsfcx5V86KWWzxxa
         FBLC3gEtjCDvP1fLMUi6UA1usEqAwAr9WYhdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523880; x=1701128680;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11iRhgr2PLRNhVPu9HUHPwoEEU0Uc3Zhta4y4uUD0D8=;
        b=G/TR2qKN622v6FWEeQD2+x50P8mTxcWxoBHqS8tS85oHOHt0BtUAshyY/te7P1dV5C
         hG1yQtrCZJnTbVj0eDauQE7SFPI6OK656w4FIYTZbC6FG5cyHK0WTJZmS/Q3nUiuXHzo
         Wj1ibry/WRyRiDF1jDVqBKh1vvvr1p0ws34iQsYGE+z7FBFvyLkW5rlSOA7BH9C/gu1P
         ErYhxCxUdYjS33OJNU3KjEThhb04a2Lx79YtKxvSz1xPIj8dxK7ELnu4snmLto96Ett1
         Y5gHfGeat9OMwAGHKzEoc8Ow5CKOfr/wfQaT355qoBtmdAuevMGG+FiUgI2y+cSdSwZU
         abJQ==
X-Gm-Message-State: AOJu0Yy3YQJ3ZtM/AlZrOxQmcVC66P6pjx7SJXepkRuNpDEUAMwR5t6H
	msxFCzQgH/N61MiAd2IVJoA2yg==
X-Google-Smtp-Source: AGHT+IF9KZRb8qQUbpU5cGFYfartjGQIWIbXxV6SVSwj98epKfu/l7Ms5Enh5VAxHRng3oI3N4MeXw==
X-Received: by 2002:a05:622a:10f:b0:41e:551f:9392 with SMTP id u15-20020a05622a010f00b0041e551f9392mr13583108qtw.51.1700523879936;
        Mon, 20 Nov 2023 15:44:39 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:39 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 03/13] bnxt_en: Restructure context memory data structures
Date: Mon, 20 Nov 2023 15:43:55 -0800
Message-Id: <20231120234405.194542-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231120234405.194542-1-michael.chan@broadcom.com>
References: <20231120234405.194542-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d30649060a9e11db"

--000000000000d30649060a9e11db
Content-Transfer-Encoding: 8bit

The current code uses a flat bnxt_ctx_mem_info structure to store 8
types of context memory for the NIC.  All the context memory types
are very similar and have similar parameters.  They can all share a
common structure to improve the organization.  Also, new firmware
interface will provide a new API to retrieve each type of context
memory by calling the API repeatedly.

This patch reorganizes the bnxt_ctx_mem_info structure to fit better
with the new firmware interface.  It will also work with the legacy
firmware interface.  The flat fields in bnxt_ctx_mem_info are replaced
by the bnxt_ctx_mem_type array.  The bnxt_mem_init array info will no
longer be needed.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 323 ++++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 101 ++++---
 2 files changed, 242 insertions(+), 182 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ff21768e592..df25b559ee45 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3121,20 +3121,20 @@ static void bnxt_free_skbs(struct bnxt *bp)
 	bnxt_free_rx_skbs(bp);
 }
 
-static void bnxt_init_ctx_mem(struct bnxt_mem_init *mem_init, void *p, int len)
+static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, int len)
 {
-	u8 init_val = mem_init->init_val;
-	u16 offset = mem_init->offset;
+	u8 init_val = ctxm->init_value;
+	u16 offset = ctxm->init_offset;
 	u8 *p2 = p;
 	int i;
 
 	if (!init_val)
 		return;
-	if (offset == BNXT_MEM_INVALID_OFFSET) {
+	if (offset == BNXT_CTX_INIT_INVALID_OFFSET) {
 		memset(p, init_val, len);
 		return;
 	}
-	for (i = 0; i < len; i += mem_init->size)
+	for (i = 0; i < len; i += ctxm->entry_size)
 		*(p2 + i + offset) = init_val;
 }
 
@@ -3201,8 +3201,8 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 		if (!rmem->pg_arr[i])
 			return -ENOMEM;
 
-		if (rmem->mem_init)
-			bnxt_init_ctx_mem(rmem->mem_init, rmem->pg_arr[i],
+		if (rmem->ctx_mem)
+			bnxt_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
 					  rmem->page_size);
 		if (rmem->nr_pages > 1 || rmem->depth > 0) {
 			if (i == rmem->nr_pages - 2 &&
@@ -7175,37 +7175,16 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 	return rc;
 }
 
-static void bnxt_init_ctx_initializer(struct bnxt_ctx_mem_info *ctx,
-			struct hwrm_func_backing_store_qcaps_output *resp)
+static void bnxt_init_ctx_initializer(struct bnxt_ctx_mem_type *ctxm,
+				      u8 init_val, u8 init_offset,
+				      bool init_mask_set)
 {
-	struct bnxt_mem_init *mem_init;
-	u16 init_mask;
-	u8 init_val;
-	u8 *offset;
-	int i;
-
-	init_val = resp->ctx_kind_initializer;
-	init_mask = le16_to_cpu(resp->ctx_init_mask);
-	offset = &resp->qp_init_offset;
-	mem_init = &ctx->mem_init[BNXT_CTX_MEM_INIT_QP];
-	for (i = 0; i < BNXT_CTX_MEM_INIT_MAX; i++, mem_init++, offset++) {
-		mem_init->init_val = init_val;
-		mem_init->offset = BNXT_MEM_INVALID_OFFSET;
-		if (!init_mask)
-			continue;
-		if (i == BNXT_CTX_MEM_INIT_STAT)
-			offset = &resp->stat_init_offset;
-		if (init_mask & (1 << i))
-			mem_init->offset = *offset * 4;
-		else
-			mem_init->init_val = 0;
-	}
-	ctx->mem_init[BNXT_CTX_MEM_INIT_QP].size = ctx->qp_entry_size;
-	ctx->mem_init[BNXT_CTX_MEM_INIT_SRQ].size = ctx->srq_entry_size;
-	ctx->mem_init[BNXT_CTX_MEM_INIT_CQ].size = ctx->cq_entry_size;
-	ctx->mem_init[BNXT_CTX_MEM_INIT_VNIC].size = ctx->vnic_entry_size;
-	ctx->mem_init[BNXT_CTX_MEM_INIT_STAT].size = ctx->stat_entry_size;
-	ctx->mem_init[BNXT_CTX_MEM_INIT_MRAV].size = ctx->mrav_entry_size;
+	ctxm->init_value = init_val;
+	ctxm->init_offset = BNXT_CTX_INIT_INVALID_OFFSET;
+	if (init_mask_set)
+		ctxm->init_offset = init_offset * 4;
+	else
+		ctxm->init_value = 0;
 }
 
 static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
@@ -7225,8 +7204,11 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 	rc = hwrm_req_send_silent(bp, req);
 	if (!rc) {
 		struct bnxt_ctx_pg_info *ctx_pg;
+		struct bnxt_ctx_mem_type *ctxm;
 		struct bnxt_ctx_mem_info *ctx;
+		u8 init_val, init_idx = 0;
 		int i, tqm_rings;
+		u16 init_mask;
 
 		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx) {
@@ -7235,39 +7217,69 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 		}
 		bp->ctx = ctx;
 
-		ctx->qp_max_entries = le32_to_cpu(resp->qp_max_entries);
-		ctx->qp_min_qp1_entries = le16_to_cpu(resp->qp_min_qp1_entries);
-		ctx->qp_max_l2_entries = le16_to_cpu(resp->qp_max_l2_entries);
-		ctx->qp_entry_size = le16_to_cpu(resp->qp_entry_size);
-		ctx->srq_max_l2_entries = le16_to_cpu(resp->srq_max_l2_entries);
-		ctx->srq_max_entries = le32_to_cpu(resp->srq_max_entries);
-		ctx->srq_entry_size = le16_to_cpu(resp->srq_entry_size);
-		ctx->cq_max_l2_entries = le16_to_cpu(resp->cq_max_l2_entries);
-		ctx->cq_max_entries = le32_to_cpu(resp->cq_max_entries);
-		ctx->cq_entry_size = le16_to_cpu(resp->cq_entry_size);
-		ctx->vnic_max_vnic_entries =
-			le16_to_cpu(resp->vnic_max_vnic_entries);
-		ctx->vnic_max_ring_table_entries =
+		init_val = resp->ctx_kind_initializer;
+		init_mask = le16_to_cpu(resp->ctx_init_mask);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
+		ctxm->max_entries = le32_to_cpu(resp->qp_max_entries);
+		ctxm->qp_qp1_entries = le16_to_cpu(resp->qp_min_qp1_entries);
+		ctxm->qp_l2_entries = le16_to_cpu(resp->qp_max_l2_entries);
+		ctxm->entry_size = le16_to_cpu(resp->qp_entry_size);
+		bnxt_init_ctx_initializer(ctxm, init_val, resp->qp_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
+		ctxm->srq_l2_entries = le16_to_cpu(resp->srq_max_l2_entries);
+		ctxm->max_entries = le32_to_cpu(resp->srq_max_entries);
+		ctxm->entry_size = le16_to_cpu(resp->srq_entry_size);
+		bnxt_init_ctx_initializer(ctxm, init_val, resp->srq_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
+		ctxm->cq_l2_entries = le16_to_cpu(resp->cq_max_l2_entries);
+		ctxm->max_entries = le32_to_cpu(resp->cq_max_entries);
+		ctxm->entry_size = le16_to_cpu(resp->cq_entry_size);
+		bnxt_init_ctx_initializer(ctxm, init_val, resp->cq_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
+		ctxm->vnic_entries = le16_to_cpu(resp->vnic_max_vnic_entries);
+		ctxm->max_entries = ctxm->vnic_entries +
 			le16_to_cpu(resp->vnic_max_ring_table_entries);
-		ctx->vnic_entry_size = le16_to_cpu(resp->vnic_entry_size);
-		ctx->stat_max_entries = le32_to_cpu(resp->stat_max_entries);
-		ctx->stat_entry_size = le16_to_cpu(resp->stat_entry_size);
-		ctx->tqm_entry_size = le16_to_cpu(resp->tqm_entry_size);
-		ctx->tqm_min_entries_per_ring =
-			le32_to_cpu(resp->tqm_min_entries_per_ring);
-		ctx->tqm_max_entries_per_ring =
-			le32_to_cpu(resp->tqm_max_entries_per_ring);
-		ctx->tqm_entries_multiple = resp->tqm_entries_multiple;
-		if (!ctx->tqm_entries_multiple)
-			ctx->tqm_entries_multiple = 1;
-		ctx->mrav_max_entries = le32_to_cpu(resp->mrav_max_entries);
-		ctx->mrav_entry_size = le16_to_cpu(resp->mrav_entry_size);
-		ctx->mrav_num_entries_units =
+		ctxm->entry_size = le16_to_cpu(resp->vnic_entry_size);
+		bnxt_init_ctx_initializer(ctxm, init_val,
+					  resp->vnic_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
+		ctxm->max_entries = le32_to_cpu(resp->stat_max_entries);
+		ctxm->entry_size = le16_to_cpu(resp->stat_entry_size);
+		bnxt_init_ctx_initializer(ctxm, init_val,
+					  resp->stat_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_STQM];
+		ctxm->entry_size = le16_to_cpu(resp->tqm_entry_size);
+		ctxm->min_entries = le32_to_cpu(resp->tqm_min_entries_per_ring);
+		ctxm->max_entries = le32_to_cpu(resp->tqm_max_entries_per_ring);
+		ctxm->entry_multiple = resp->tqm_entries_multiple;
+		if (!ctxm->entry_multiple)
+			ctxm->entry_multiple = 1;
+
+		memcpy(&ctx->ctx_arr[BNXT_CTX_FTQM], ctxm, sizeof(*ctxm));
+
+		ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
+		ctxm->max_entries = le32_to_cpu(resp->mrav_max_entries);
+		ctxm->entry_size = le16_to_cpu(resp->mrav_entry_size);
+		ctxm->mrav_num_entries_units =
 			le16_to_cpu(resp->mrav_num_entries_units);
-		ctx->tim_entry_size = le16_to_cpu(resp->tim_entry_size);
-		ctx->tim_max_entries = le32_to_cpu(resp->tim_max_entries);
+		bnxt_init_ctx_initializer(ctxm, init_val,
+					  resp->mrav_init_offset,
+					  (init_mask & (1 << init_idx++)) != 0);
 
-		bnxt_init_ctx_initializer(ctx, resp);
+		ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
+		ctxm->entry_size = le16_to_cpu(resp->tim_entry_size);
+		ctxm->max_entries = le32_to_cpu(resp->tim_max_entries);
 
 		ctx->tqm_fp_rings_count = resp->tqm_fp_rings_count;
 		if (!ctx->tqm_fp_rings_count)
@@ -7275,6 +7287,9 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 		else if (ctx->tqm_fp_rings_count > BNXT_MAX_TQM_FP_RINGS)
 			ctx->tqm_fp_rings_count = BNXT_MAX_TQM_FP_RINGS;
 
+		ctxm = &ctx->ctx_arr[BNXT_CTX_FTQM];
+		ctxm->instance_bmap = (1 << ctx->tqm_fp_rings_count) - 1;
+
 		tqm_rings = ctx->tqm_fp_rings_count + BNXT_MAX_TQM_SP_RINGS;
 		ctx_pg = kcalloc(tqm_rings, sizeof(*ctx_pg), GFP_KERNEL);
 		if (!ctx_pg) {
@@ -7321,6 +7336,7 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 	struct hwrm_func_backing_store_cfg_input *req;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_pg_info *ctx_pg;
+	struct bnxt_ctx_mem_type *ctxm;
 	void **__req = (void **)&req;
 	u32 req_len = sizeof(*req);
 	__le32 *num_entries;
@@ -7343,70 +7359,86 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 	req->enables = cpu_to_le32(enables);
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP) {
 		ctx_pg = &ctx->qp_mem;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
 		req->qp_num_entries = cpu_to_le32(ctx_pg->entries);
-		req->qp_num_qp1_entries = cpu_to_le16(ctx->qp_min_qp1_entries);
-		req->qp_num_l2_entries = cpu_to_le16(ctx->qp_max_l2_entries);
-		req->qp_entry_size = cpu_to_le16(ctx->qp_entry_size);
+		req->qp_num_qp1_entries = cpu_to_le16(ctxm->qp_qp1_entries);
+		req->qp_num_l2_entries = cpu_to_le16(ctxm->qp_l2_entries);
+		req->qp_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->qpc_pg_size_qpc_lvl,
 				      &req->qpc_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ) {
 		ctx_pg = &ctx->srq_mem;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
 		req->srq_num_entries = cpu_to_le32(ctx_pg->entries);
-		req->srq_num_l2_entries = cpu_to_le16(ctx->srq_max_l2_entries);
-		req->srq_entry_size = cpu_to_le16(ctx->srq_entry_size);
+		req->srq_num_l2_entries = cpu_to_le16(ctxm->srq_l2_entries);
+		req->srq_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->srq_pg_size_srq_lvl,
 				      &req->srq_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ) {
 		ctx_pg = &ctx->cq_mem;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
 		req->cq_num_entries = cpu_to_le32(ctx_pg->entries);
-		req->cq_num_l2_entries = cpu_to_le16(ctx->cq_max_l2_entries);
-		req->cq_entry_size = cpu_to_le16(ctx->cq_entry_size);
+		req->cq_num_l2_entries = cpu_to_le16(ctxm->cq_l2_entries);
+		req->cq_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->cq_pg_size_cq_lvl,
 				      &req->cq_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC) {
 		ctx_pg = &ctx->vnic_mem;
-		req->vnic_num_vnic_entries =
-			cpu_to_le16(ctx->vnic_max_vnic_entries);
+		ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
+		req->vnic_num_vnic_entries = cpu_to_le16(ctxm->vnic_entries);
 		req->vnic_num_ring_table_entries =
-			cpu_to_le16(ctx->vnic_max_ring_table_entries);
-		req->vnic_entry_size = cpu_to_le16(ctx->vnic_entry_size);
+			cpu_to_le16(ctxm->max_entries - ctxm->vnic_entries);
+		req->vnic_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->vnic_pg_size_vnic_lvl,
 				      &req->vnic_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT) {
 		ctx_pg = &ctx->stat_mem;
-		req->stat_num_entries = cpu_to_le32(ctx->stat_max_entries);
-		req->stat_entry_size = cpu_to_le16(ctx->stat_entry_size);
+		ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
+		req->stat_num_entries = cpu_to_le32(ctxm->max_entries);
+		req->stat_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->stat_pg_size_stat_lvl,
 				      &req->stat_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV) {
+		u32 units;
+
 		ctx_pg = &ctx->mrav_mem;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
 		req->mrav_num_entries = cpu_to_le32(ctx_pg->entries);
-		if (ctx->mrav_num_entries_units)
-			flags |=
-			FUNC_BACKING_STORE_CFG_REQ_FLAGS_MRAV_RESERVATION_SPLIT;
-		req->mrav_entry_size = cpu_to_le16(ctx->mrav_entry_size);
+		units = ctxm->mrav_num_entries_units;
+		if (units) {
+			u32 num_mr, num_ah = ctxm->mrav_av_entries;
+			u32 entries;
+
+			num_mr = ctx_pg->entries - num_ah;
+			entries = ((num_mr / units) << 16) | (num_ah / units);
+			req->mrav_num_entries = cpu_to_le32(entries);
+			flags |= FUNC_BACKING_STORE_CFG_REQ_FLAGS_MRAV_RESERVATION_SPLIT;
+		}
+		req->mrav_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->mrav_pg_size_mrav_lvl,
 				      &req->mrav_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM) {
 		ctx_pg = &ctx->tim_mem;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
 		req->tim_num_entries = cpu_to_le32(ctx_pg->entries);
-		req->tim_entry_size = cpu_to_le16(ctx->tim_entry_size);
+		req->tim_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->tim_pg_size_tim_lvl,
 				      &req->tim_page_dir);
 	}
+	ctxm = &ctx->ctx_arr[BNXT_CTX_STQM];
 	for (i = 0, num_entries = &req->tqm_sp_num_entries,
 	     pg_attr = &req->tqm_sp_pg_size_tqm_sp_lvl,
 	     pg_dir = &req->tqm_sp_page_dir,
@@ -7416,7 +7448,7 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 		if (!(enables & ena))
 			continue;
 
-		req->tqm_entry_size = cpu_to_le16(ctx->tqm_entry_size);
+		req->tqm_entry_size = cpu_to_le16(ctxm->entry_size);
 		ctx_pg = ctx->tqm_mem[i];
 		*num_entries = cpu_to_le32(ctx_pg->entries);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem, pg_attr, pg_dir);
@@ -7441,7 +7473,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
 
 static int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp,
 				  struct bnxt_ctx_pg_info *ctx_pg, u32 mem_size,
-				  u8 depth, struct bnxt_mem_init *mem_init)
+				  u8 depth, struct bnxt_ctx_mem_type *ctxm)
 {
 	struct bnxt_ring_mem_info *rmem = &ctx_pg->ring_mem;
 	int rc;
@@ -7479,7 +7511,7 @@ static int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp,
 			rmem->pg_tbl_map = ctx_pg->ctx_dma_arr[i];
 			rmem->depth = 1;
 			rmem->nr_pages = MAX_CTX_PAGES;
-			rmem->mem_init = mem_init;
+			rmem->ctx_mem = ctxm;
 			if (i == (nr_tbls - 1)) {
 				int rem = ctx_pg->nr_pages % MAX_CTX_PAGES;
 
@@ -7494,7 +7526,7 @@ static int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp,
 		rmem->nr_pages = DIV_ROUND_UP(mem_size, BNXT_PAGE_SIZE);
 		if (rmem->nr_pages > 1 || depth)
 			rmem->depth = 1;
-		rmem->mem_init = mem_init;
+		rmem->ctx_mem = ctxm;
 		rc = bnxt_alloc_ctx_mem_blk(bp, ctx_pg);
 	}
 	return rc;
@@ -7559,10 +7591,12 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 {
 	struct bnxt_ctx_pg_info *ctx_pg;
+	struct bnxt_ctx_mem_type *ctxm;
 	struct bnxt_ctx_mem_info *ctx;
-	struct bnxt_mem_init *init;
+	u32 l2_qps, qp1_qps, max_qps;
 	u32 mem_size, ena, entries;
 	u32 entries_sp, min;
+	u32 srqs, max_srqs;
 	u32 num_mr, num_ah;
 	u32 extra_srqs = 0;
 	u32 extra_qps = 0;
@@ -7579,60 +7613,65 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	if (!ctx || (ctx->flags & BNXT_CTX_FLAG_INITED))
 		return 0;
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
+	l2_qps = ctxm->qp_l2_entries;
+	qp1_qps = ctxm->qp_qp1_entries;
+	max_qps = ctxm->max_entries;
+	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
+	srqs = ctxm->srq_l2_entries;
+	max_srqs = ctxm->max_entries;
 	if ((bp->flags & BNXT_FLAG_ROCE_CAP) && !is_kdump_kernel()) {
 		pg_lvl = 2;
-		extra_qps = 65536;
-		extra_srqs = 8192;
+		extra_qps = min_t(u32, 65536, max_qps - l2_qps - qp1_qps);
+		extra_srqs = min_t(u32, 8192, max_srqs - srqs);
 	}
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
 	ctx_pg = &ctx->qp_mem;
-	ctx_pg->entries = ctx->qp_min_qp1_entries + ctx->qp_max_l2_entries +
-			  extra_qps;
-	if (ctx->qp_entry_size) {
-		mem_size = ctx->qp_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_QP];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, init);
+	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
 		if (rc)
 			return rc;
 	}
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
 	ctx_pg = &ctx->srq_mem;
-	ctx_pg->entries = ctx->srq_max_l2_entries + extra_srqs;
-	if (ctx->srq_entry_size) {
-		mem_size = ctx->srq_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_SRQ];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, init);
+	ctx_pg->entries = srqs + extra_srqs;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
 		if (rc)
 			return rc;
 	}
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
 	ctx_pg = &ctx->cq_mem;
-	ctx_pg->entries = ctx->cq_max_l2_entries + extra_qps * 2;
-	if (ctx->cq_entry_size) {
-		mem_size = ctx->cq_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_CQ];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, init);
+	ctx_pg->entries = ctxm->cq_l2_entries + extra_qps * 2;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
 		if (rc)
 			return rc;
 	}
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
 	ctx_pg = &ctx->vnic_mem;
-	ctx_pg->entries = ctx->vnic_max_vnic_entries +
-			  ctx->vnic_max_ring_table_entries;
-	if (ctx->vnic_entry_size) {
-		mem_size = ctx->vnic_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_VNIC];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, init);
+	ctx_pg->entries = ctxm->max_entries;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, ctxm);
 		if (rc)
 			return rc;
 	}
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
 	ctx_pg = &ctx->stat_mem;
-	ctx_pg->entries = ctx->stat_max_entries;
-	if (ctx->stat_entry_size) {
-		mem_size = ctx->stat_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_STAT];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, init);
+	ctx_pg->entries = ctxm->max_entries;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, ctxm);
 		if (rc)
 			return rc;
 	}
@@ -7641,30 +7680,31 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
 		goto skip_rdma;
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
 	ctx_pg = &ctx->mrav_mem;
 	/* 128K extra is needed to accommodate static AH context
 	 * allocation by f/w.
 	 */
-	num_mr = 1024 * 256;
-	num_ah = 1024 * 128;
+	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
+	num_ah = min_t(u32, num_mr, 1024 * 128);
+	ctxm->split_entry_cnt = BNXT_CTX_MRAV_AV_SPLIT_ENTRY + 1;
+	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
+		ctxm->mrav_av_entries = num_ah;
+
 	ctx_pg->entries = num_mr + num_ah;
-	if (ctx->mrav_entry_size) {
-		mem_size = ctx->mrav_entry_size * ctx_pg->entries;
-		init = &ctx->mem_init[BNXT_CTX_MEM_INIT_MRAV];
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 2, init);
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 2, ctxm);
 		if (rc)
 			return rc;
 	}
 	ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
-	if (ctx->mrav_num_entries_units)
-		ctx_pg->entries =
-			((num_mr / ctx->mrav_num_entries_units) << 16) |
-			 (num_ah / ctx->mrav_num_entries_units);
 
+	ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
 	ctx_pg = &ctx->tim_mem;
-	ctx_pg->entries = ctx->qp_mem.entries;
-	if (ctx->tim_entry_size) {
-		mem_size = ctx->tim_entry_size * ctx_pg->entries;
+	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
+	if (ctxm->entry_size) {
+		mem_size = ctxm->entry_size * ctx_pg->entries;
 		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, NULL);
 		if (rc)
 			return rc;
@@ -7672,18 +7712,19 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM;
 
 skip_rdma:
-	min = ctx->tqm_min_entries_per_ring;
-	entries_sp = ctx->vnic_max_vnic_entries + ctx->qp_max_l2_entries +
-		     2 * (extra_qps + ctx->qp_min_qp1_entries) + min;
-	entries_sp = roundup(entries_sp, ctx->tqm_entries_multiple);
-	entries = ctx->qp_max_l2_entries + 2 * (extra_qps + ctx->qp_min_qp1_entries);
-	entries = roundup(entries, ctx->tqm_entries_multiple);
-	entries = clamp_t(u32, entries, min, ctx->tqm_max_entries_per_ring);
+	ctxm = &ctx->ctx_arr[BNXT_CTX_STQM];
+	min = ctxm->min_entries;
+	entries_sp = ctx->ctx_arr[BNXT_CTX_VNIC].vnic_entries + l2_qps +
+		     2 * (extra_qps + qp1_qps) + min;
+	entries_sp = roundup(entries_sp, ctxm->entry_multiple);
+	entries = l2_qps + 2 * (extra_qps + qp1_qps);
+	entries = roundup(entries, ctxm->entry_multiple);
+	entries = clamp_t(u32, entries, min, ctxm->max_entries);
 	for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++) {
 		ctx_pg = ctx->tqm_mem[i];
 		ctx_pg->entries = i ? entries : entries_sp;
-		if (ctx->tqm_entry_size) {
-			mem_size = ctx->tqm_entry_size * ctx_pg->entries;
+		if (ctxm->entry_size) {
+			mem_size = ctxm->entry_size * ctx_pg->entries;
 			rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1,
 						    NULL);
 			if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4ce993943924..757d2edb8c05 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -762,13 +762,6 @@ struct bnxt_sw_rx_agg_bd {
 	dma_addr_t		mapping;
 };
 
-struct bnxt_mem_init {
-	u8	init_val;
-	u16	offset;
-#define	BNXT_MEM_INVALID_OFFSET	0xffff
-	u16	size;
-};
-
 struct bnxt_ring_mem_info {
 	int			nr_pages;
 	int			page_size;
@@ -778,7 +771,7 @@ struct bnxt_ring_mem_info {
 #define BNXT_RMEM_USE_FULL_PAGE_FLAG	4
 
 	u16			depth;
-	struct bnxt_mem_init	*mem_init;
+	struct bnxt_ctx_mem_type	*ctx_mem;
 
 	void			**pg_arr;
 	dma_addr_t		*dma_arr;
@@ -1551,35 +1544,70 @@ do {									\
 		attr = FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_4K;	\
 } while (0)
 
+struct bnxt_ctx_mem_type {
+	u16	type;
+	u16	entry_size;
+	u32	flags;
+	u32	instance_bmap;
+	u8	init_value;
+	u8	entry_multiple;
+	u16	init_offset;
+#define	BNXT_CTX_INIT_INVALID_OFFSET	0xffff
+	u32	max_entries;
+	u32	min_entries;
+	u8	last:1;
+	u8	split_entry_cnt;
+#define BNXT_MAX_SPLIT_ENTRY	4
+	union {
+		struct {
+			u32	qp_l2_entries;
+			u32	qp_qp1_entries;
+			u32	qp_fast_qpmd_entries;
+		};
+		u32	srq_l2_entries;
+		u32	cq_l2_entries;
+		u32	vnic_entries;
+		struct {
+			u32	mrav_av_entries;
+			u32	mrav_num_entries_units;
+		};
+		u32	split[BNXT_MAX_SPLIT_ENTRY];
+	};
+};
+
+#define BNXT_CTX_MRAV_AV_SPLIT_ENTRY	0
+
+#define BNXT_CTX_QP	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QP
+#define BNXT_CTX_SRQ	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ
+#define BNXT_CTX_CQ	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ
+#define BNXT_CTX_VNIC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_VNIC
+#define BNXT_CTX_STAT	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_STAT
+#define BNXT_CTX_STQM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SP_TQM_RING
+#define BNXT_CTX_FTQM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING
+#define BNXT_CTX_MRAV	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV
+#define BNXT_CTX_TIM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM
+#define BNXT_CTX_TKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TKC
+#define BNXT_CTX_RKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RKC
+#define BNXT_CTX_MTQM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING
+#define BNXT_CTX_SQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW
+#define BNXT_CTX_RQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW
+#define BNXT_CTX_SRQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW
+#define BNXT_CTX_CQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW
+#define BNXT_CTX_QTKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_TKC
+#define BNXT_CTX_QRKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_RKC
+#define BNXT_CTX_TBLSC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE
+#define BNXT_CTX_XPAR	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION
+
+#define BNXT_CTX_MAX	(BNXT_CTX_TIM + 1)
+#define BNXT_CTX_V2_MAX	(BNXT_CTX_XPAR + 1)
+#define BNXT_CTX_INV	((u16)-1)
+
 struct bnxt_ctx_mem_info {
-	u32	qp_max_entries;
-	u16	qp_min_qp1_entries;
-	u16	qp_max_l2_entries;
-	u16	qp_entry_size;
-	u16	srq_max_l2_entries;
-	u32	srq_max_entries;
-	u16	srq_entry_size;
-	u16	cq_max_l2_entries;
-	u32	cq_max_entries;
-	u16	cq_entry_size;
-	u16	vnic_max_vnic_entries;
-	u16	vnic_max_ring_table_entries;
-	u16	vnic_entry_size;
-	u32	stat_max_entries;
-	u16	stat_entry_size;
-	u16	tqm_entry_size;
-	u32	tqm_min_entries_per_ring;
-	u32	tqm_max_entries_per_ring;
-	u32	mrav_max_entries;
-	u16	mrav_entry_size;
-	u16	tim_entry_size;
-	u32	tim_max_entries;
-	u16	mrav_num_entries_units;
-	u8	tqm_entries_multiple;
 	u8	tqm_fp_rings_count;
 
 	u32	flags;
 	#define BNXT_CTX_FLAG_INITED	0x01
+	struct bnxt_ctx_mem_type	ctx_arr[BNXT_CTX_MAX];
 
 	struct bnxt_ctx_pg_info qp_mem;
 	struct bnxt_ctx_pg_info srq_mem;
@@ -1589,15 +1617,6 @@ struct bnxt_ctx_mem_info {
 	struct bnxt_ctx_pg_info mrav_mem;
 	struct bnxt_ctx_pg_info tim_mem;
 	struct bnxt_ctx_pg_info *tqm_mem[BNXT_MAX_TQM_RINGS];
-
-#define BNXT_CTX_MEM_INIT_QP	0
-#define BNXT_CTX_MEM_INIT_SRQ	1
-#define BNXT_CTX_MEM_INIT_CQ	2
-#define BNXT_CTX_MEM_INIT_VNIC	3
-#define BNXT_CTX_MEM_INIT_STAT	4
-#define BNXT_CTX_MEM_INIT_MRAV	5
-#define BNXT_CTX_MEM_INIT_MAX	6
-	struct bnxt_mem_init	mem_init[BNXT_CTX_MEM_INIT_MAX];
 };
 
 enum bnxt_health_severity {
-- 
2.30.1


--000000000000d30649060a9e11db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ8Uyxm3iYc7oy1wdkd0w1iq7HmlDWvu
/Xys2EKhb3JOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBjB1fufLgQNNiqeOIyq5n52X+3C/ZSQgIz41JF2i8FAtURIOkw
ngGY7ZWhR6sII3vwHuAuhEfwyDZmxsaM/rUIQIdUAdQ6RTM2Iivx3t/i4c1SPsL/YqVpQFtInChY
peA1RzCJBu9yewoNZfywXwC+YyVTwUW2120rfll7tq0V1+cnLT6C1ii7TtsEmdBMw9lQcZQB8Cxi
3bC/DZ+D85q/1AcsZ+ysOBt32ySs9xnUSqnC31/aQNnyOkr6N83bfe16Svgp7g5HiG5N/DmPetuz
XLuvxOs5fuFdepAG1cb70jIdQUVOFtfM19gMyyum4m5htcQpqe2MiXm9/fK6amt6
--000000000000d30649060a9e11db--

