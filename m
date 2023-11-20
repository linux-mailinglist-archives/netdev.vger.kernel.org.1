Return-Path: <netdev+bounces-49451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410C7F2193
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F800B219A7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534D3B2BD;
	Mon, 20 Nov 2023 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e+3uxdvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53BC8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:44 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4629ef1dbc4so481696137.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523883; x=1701128683; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvmlDgPm/OTGtsNIlrjV63lUUeoMPCn1z8AQkCDM9lA=;
        b=e+3uxdvqe+ka9TEv4IY0M2cFA59jA4KlN5ONFxoN4H5lHYl+dJ/b6C+WQaOVhjWgz0
         uZaMzYGB61L4nOezaDlRQJs5shkwUV7YXx8W4bruM6JltFU65SLhSkRjPFlpzkoURc+l
         JWXQ/E/+OcdEXUKkF888+55gsoYIpecNy7Ws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523883; x=1701128683;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvmlDgPm/OTGtsNIlrjV63lUUeoMPCn1z8AQkCDM9lA=;
        b=J6GxaCsjA8OXlhPZ2LYPJrVdjKGf3ckvzmX2IcoSgrT0Yuztb5k2aX4CCp5Z2ENEWl
         /xjaMJqXe7WzL2TZUR67W/2VuadlNcJlkMMua5+n+cofiQrqDBZ8GRWA6eCldkL+m48K
         m1ep58Gzpy+yx9zXiAIfSWWJJLO+nd7Her99fkIb/E+kxHHmS5K7mcNvjXcUnmfpSXp2
         wgqpAcEPUBy2DGNJKZhPnimHLPZOBrHasPLC2HnbNq4tLuIkQpEQbTq7424ixJH0DspK
         hq9bs5n6FyeNHhppxWOTXVYqR2lBEeqxhYlAOL+BWxlHIRMTYw/JGZzKDzeyLausd4G2
         +Pfw==
X-Gm-Message-State: AOJu0YxWsIGWTkJVnfM70agy0EXasbs0piITbq8QKzOkvMOfJRUXiTPK
	BYxvFA37SdOd16ilBd3RNi2yBg==
X-Google-Smtp-Source: AGHT+IGAzHblxlRVXBLJqyvk64uAIGQrRygql3deliOQIQaTysD6VPiem1/NWnVw6W7LLW4fBpaGsg==
X-Received: by 2002:a05:6102:1162:b0:462:ad97:c412 with SMTP id k2-20020a056102116200b00462ad97c412mr2099512vsg.26.1700523883081;
        Mon, 20 Nov 2023 15:44:43 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:42 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 05/13] bnxt_en: Use the pg_info field in bnxt_ctx_mem_type struct
Date: Mon, 20 Nov 2023 15:43:57 -0800
Message-Id: <20231120234405.194542-6-michael.chan@broadcom.com>
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
	boundary="0000000000000892bf060a9e1202"

--0000000000000892bf060a9e1202
Content-Transfer-Encoding: 8bit

Use the newly added pg_info field in bnxt_ctx_mem_type struct and
remove the standalone page info structures in bnxt_ctx_mem_info.
This now completes the reorganization of the context memory
structures to work better with the new and more flexible firmware
interface for newer chips.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 74 +++++++++--------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  9 ---
 2 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3b18bcee151a..524023b8e959 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7224,11 +7224,9 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send_silent(bp, req);
 	if (!rc) {
-		struct bnxt_ctx_pg_info *ctx_pg;
 		struct bnxt_ctx_mem_type *ctxm;
 		struct bnxt_ctx_mem_info *ctx;
 		u8 init_val, init_idx = 0;
-		int i, tqm_rings;
 		u16 init_mask;
 
 		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -7311,14 +7309,6 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 		ctxm = &ctx->ctx_arr[BNXT_CTX_FTQM];
 		ctxm->instance_bmap = (1 << ctx->tqm_fp_rings_count) - 1;
 
-		tqm_rings = ctx->tqm_fp_rings_count + BNXT_MAX_TQM_SP_RINGS;
-		ctx_pg = kcalloc(tqm_rings, sizeof(*ctx_pg), GFP_KERNEL);
-		if (!ctx_pg) {
-			rc = -ENOMEM;
-			goto ctx_err;
-		}
-		for (i = 0; i < tqm_rings; i++, ctx_pg++)
-			ctx->tqm_mem[i] = ctx_pg;
 		rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_MAX);
 	} else {
 		rc = 0;
@@ -7380,8 +7370,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 
 	req->enables = cpu_to_le32(enables);
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP) {
-		ctx_pg = &ctx->qp_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
+		ctx_pg = ctxm->pg_info;
 		req->qp_num_entries = cpu_to_le32(ctx_pg->entries);
 		req->qp_num_qp1_entries = cpu_to_le16(ctxm->qp_qp1_entries);
 		req->qp_num_l2_entries = cpu_to_le16(ctxm->qp_l2_entries);
@@ -7391,8 +7381,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 				      &req->qpc_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ) {
-		ctx_pg = &ctx->srq_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
+		ctx_pg = ctxm->pg_info;
 		req->srq_num_entries = cpu_to_le32(ctx_pg->entries);
 		req->srq_num_l2_entries = cpu_to_le16(ctxm->srq_l2_entries);
 		req->srq_entry_size = cpu_to_le16(ctxm->entry_size);
@@ -7401,8 +7391,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 				      &req->srq_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ) {
-		ctx_pg = &ctx->cq_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
+		ctx_pg = ctxm->pg_info;
 		req->cq_num_entries = cpu_to_le32(ctx_pg->entries);
 		req->cq_num_l2_entries = cpu_to_le16(ctxm->cq_l2_entries);
 		req->cq_entry_size = cpu_to_le16(ctxm->entry_size);
@@ -7411,8 +7401,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 				      &req->cq_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC) {
-		ctx_pg = &ctx->vnic_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
+		ctx_pg = ctxm->pg_info;
 		req->vnic_num_vnic_entries = cpu_to_le16(ctxm->vnic_entries);
 		req->vnic_num_ring_table_entries =
 			cpu_to_le16(ctxm->max_entries - ctxm->vnic_entries);
@@ -7422,8 +7412,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 				      &req->vnic_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT) {
-		ctx_pg = &ctx->stat_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
+		ctx_pg = ctxm->pg_info;
 		req->stat_num_entries = cpu_to_le32(ctxm->max_entries);
 		req->stat_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
@@ -7433,8 +7423,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV) {
 		u32 units;
 
-		ctx_pg = &ctx->mrav_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
+		ctx_pg = ctxm->pg_info;
 		req->mrav_num_entries = cpu_to_le32(ctx_pg->entries);
 		units = ctxm->mrav_num_entries_units;
 		if (units) {
@@ -7452,8 +7442,8 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 				      &req->mrav_page_dir);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM) {
-		ctx_pg = &ctx->tim_mem;
 		ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
+		ctx_pg = ctxm->pg_info;
 		req->tim_num_entries = cpu_to_le32(ctx_pg->entries);
 		req->tim_entry_size = cpu_to_le16(ctxm->entry_size);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
@@ -7464,14 +7454,15 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 	for (i = 0, num_entries = &req->tqm_sp_num_entries,
 	     pg_attr = &req->tqm_sp_pg_size_tqm_sp_lvl,
 	     pg_dir = &req->tqm_sp_page_dir,
-	     ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP;
+	     ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP,
+	     ctx_pg = ctxm->pg_info;
 	     i < BNXT_MAX_TQM_RINGS;
+	     ctx_pg = &ctx->ctx_arr[BNXT_CTX_FTQM].pg_info[i],
 	     i++, num_entries++, pg_attr++, pg_dir++, ena <<= 1) {
 		if (!(enables & ena))
 			continue;
 
 		req->tqm_entry_size = cpu_to_le16(ctxm->entry_size);
-		ctx_pg = ctx->tqm_mem[i];
 		*num_entries = cpu_to_le32(ctx_pg->entries);
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem, pg_attr, pg_dir);
 	}
@@ -7587,30 +7578,23 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u16 type;
-	int i;
 
 	if (!ctx)
 		return;
 
-	if (ctx->tqm_mem[0]) {
-		for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++)
-			bnxt_free_ctx_pg_tbls(bp, ctx->tqm_mem[i]);
-		kfree(ctx->tqm_mem[0]);
-		ctx->tqm_mem[0] = NULL;
-	}
-
-	bnxt_free_ctx_pg_tbls(bp, &ctx->tim_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->mrav_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->stat_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->vnic_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->cq_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->srq_mem);
-	bnxt_free_ctx_pg_tbls(bp, &ctx->qp_mem);
-
 	for (type = 0; type < BNXT_CTX_MAX; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
+		int i, n = 1;
+
+		if (!ctx_pg)
+			continue;
+		if (ctxm->instance_bmap)
+			n = hweight32(ctxm->instance_bmap);
+		for (i = 0; i < n; i++)
+			bnxt_free_ctx_pg_tbls(bp, &ctx_pg[i]);
 
-		kfree(ctxm->pg_info);
+		kfree(ctx_pg);
 		ctxm->pg_info = NULL;
 	}
 
@@ -7658,7 +7642,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
-	ctx_pg = &ctx->qp_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7668,7 +7652,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
-	ctx_pg = &ctx->srq_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = srqs + extra_srqs;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7678,7 +7662,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
-	ctx_pg = &ctx->cq_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = ctxm->cq_l2_entries + extra_qps * 2;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7688,7 +7672,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
-	ctx_pg = &ctx->vnic_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = ctxm->max_entries;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7698,7 +7682,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
-	ctx_pg = &ctx->stat_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = ctxm->max_entries;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7712,7 +7696,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 		goto skip_rdma;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
-	ctx_pg = &ctx->mrav_mem;
+	ctx_pg = ctxm->pg_info;
 	/* 128K extra is needed to accommodate static AH context
 	 * allocation by f/w.
 	 */
@@ -7732,7 +7716,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
-	ctx_pg = &ctx->tim_mem;
+	ctx_pg = ctxm->pg_info;
 	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
 	if (ctxm->entry_size) {
 		mem_size = ctxm->entry_size * ctx_pg->entries;
@@ -7751,8 +7735,8 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	entries = l2_qps + 2 * (extra_qps + qp1_qps);
 	entries = roundup(entries, ctxm->entry_multiple);
 	entries = clamp_t(u32, entries, min, ctxm->max_entries);
-	for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++) {
-		ctx_pg = ctx->tqm_mem[i];
+	for (i = 0, ctx_pg = ctxm->pg_info; i < ctx->tqm_fp_rings_count + 1;
+	     ctx_pg = &ctx->ctx_arr[BNXT_CTX_FTQM].pg_info[i], i++) {
 		ctx_pg->entries = i ? entries : entries_sp;
 		if (ctxm->entry_size) {
 			mem_size = ctxm->entry_size * ctx_pg->entries;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7e67df57b8af..067a66eedf36 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1609,15 +1609,6 @@ struct bnxt_ctx_mem_info {
 	u32	flags;
 	#define BNXT_CTX_FLAG_INITED	0x01
 	struct bnxt_ctx_mem_type	ctx_arr[BNXT_CTX_MAX];
-
-	struct bnxt_ctx_pg_info qp_mem;
-	struct bnxt_ctx_pg_info srq_mem;
-	struct bnxt_ctx_pg_info cq_mem;
-	struct bnxt_ctx_pg_info vnic_mem;
-	struct bnxt_ctx_pg_info stat_mem;
-	struct bnxt_ctx_pg_info mrav_mem;
-	struct bnxt_ctx_pg_info tim_mem;
-	struct bnxt_ctx_pg_info *tqm_mem[BNXT_MAX_TQM_RINGS];
 };
 
 enum bnxt_health_severity {
-- 
2.30.1


--0000000000000892bf060a9e1202
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJriDjwaajnjIjD244S9Mod7mUTStLjD
IVvamqJTfzhIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBgCKtLqiGt8uq94MW//cxbFpJsVaAAj6mPUpJPHdBjdOsA2OZ6
zqbSccKp7aoOR55OA2zUStOXHPuHRA6C3ksJSCvR4/mmzILCRepCSzfCdLuV+PADjs1jtxErruCv
8nOWoXsNlcl6Vbic61J+sEEzI06535QWsNBfxPJAxDyNKYnRTeUltk5VvWKKIFlYuTu4mzjrvxRx
PcKj91+3/8FE5oRW5yv32kQ7DKsoXULhiztOQU10QUqKhb9TLLTfBJTDCvbVZBAk8w83JeGwXvoa
QE2HHc6XLjhsAtIm4oFSfWrjAxCSMHc0SCVGpnfIEbdnJin6u/Ix1CboxN5zf1eg
--0000000000000892bf060a9e1202--

