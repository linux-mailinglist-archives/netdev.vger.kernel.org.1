Return-Path: <netdev+bounces-49452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9937F2194
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3D1C218A8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669C3BB49;
	Mon, 20 Nov 2023 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hG9oYKZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8BAA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:46 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5842a7fdc61so2580412eaf.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523885; x=1701128685; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpwEa1tyAbByi1gRfGpj2gZgjDD2BUbcV1qdbEpVvQc=;
        b=hG9oYKZNZ6jFbb2kIuYeGduEU456mZFs68tUcDXLUx0nJ6camZ9exnCrFp5rXPtxNF
         cXmtPxl3sy2ZQJ+7ZZyuYYMr7VfdWQ85gfp+KCgFv0cPXNdrKX4faL4LP2BvCl46Rvcw
         pf/m8sIZBDXBL1MqEUtzFEpCH38auH1oagNYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523885; x=1701128685;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpwEa1tyAbByi1gRfGpj2gZgjDD2BUbcV1qdbEpVvQc=;
        b=tsqFVYffLkMKiVJjCDO5ZT0IzhDz/ofrG2w8pJ/CsZlkcMMJ9Ouxfls6/4RGhfXpIt
         KrGP9FZHv/zMcIaFGhZyCtNBmmuxt5UFCtNreI7+QzTaRu22cs0n5k8ZdqSP8zSxbW1B
         3KUXDoDX2hWZ7KImOoFt6cR8UV7/4RWkv0/FWO1c7KKgTo/xmTMiMJTDdLJv2T/14u8q
         ccxMhLtpSVo2GWQLmpvS3idsMWdWE1leGOOg9PJNt3CK3zlLseqz+0go9xyCM1SfVgVv
         1gxi58WO/dIbyUF8be1Z/qtEf55P4D/66mIQ0PjF8vF8rMiPfBb6rwrRxNsCUzIO73DU
         uHmA==
X-Gm-Message-State: AOJu0Yyy8etEpdTnH+wlkKdahx4BEKeQSHDnbZJmpCpliC+rluB9qG3g
	3kimaGN4rt1VDimjL7aGUSsYJQ==
X-Google-Smtp-Source: AGHT+IFhNbpqW4JDk17M/D1gDpXjp98CCBx4tJZzV6y6bzeqqSVEE215bZqJEV6zxgKkhE+T+DwA0A==
X-Received: by 2002:a05:6358:9209:b0:169:9c45:ca12 with SMTP id d9-20020a056358920900b001699c45ca12mr10695254rwb.23.1700523884955;
        Mon, 20 Nov 2023 15:44:44 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:44 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 06/13] bnxt_en: Add bnxt_setup_ctxm_pg_tbls() helper function
Date: Mon, 20 Nov 2023 15:43:58 -0800
Message-Id: <20231120234405.194542-7-michael.chan@broadcom.com>
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
	boundary="00000000000020d410060a9e1226"

--00000000000020d410060a9e1226
Content-Transfer-Encoding: 8bit

In bnxt_alloc_ctx_mem(), the logic to set up the context memory entries
and to allocate the context memory tables is done repetitively.  Add
a helper function to simplify the code.

The setup of the Fast Path TQM entries relies on some information from
the Slow Path TQM entries.  Copy the SP_TQM entries to the FP_TQM
entries to simplify the logic.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 133 ++++++++++------------
 1 file changed, 59 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 524023b8e959..e42c82ed0fd5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7307,6 +7307,7 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 			ctx->tqm_fp_rings_count = BNXT_MAX_TQM_FP_RINGS;
 
 		ctxm = &ctx->ctx_arr[BNXT_CTX_FTQM];
+		memcpy(ctxm, &ctx->ctx_arr[BNXT_CTX_STQM], sizeof(*ctxm));
 		ctxm->instance_bmap = (1 << ctx->tqm_fp_rings_count) - 1;
 
 		rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_MAX);
@@ -7574,6 +7575,30 @@ static void bnxt_free_ctx_pg_tbls(struct bnxt *bp,
 	ctx_pg->nr_pages = 0;
 }
 
+static int bnxt_setup_ctxm_pg_tbls(struct bnxt *bp,
+				   struct bnxt_ctx_mem_type *ctxm, u32 entries,
+				   u8 pg_lvl)
+{
+	struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
+	int i, rc = 0, n = 1;
+	u32 mem_size;
+
+	if (!ctxm->entry_size || !ctx_pg)
+		return -EINVAL;
+	if (ctxm->instance_bmap)
+		n = hweight32(ctxm->instance_bmap);
+	if (ctxm->entry_multiple)
+		entries = roundup(entries, ctxm->entry_multiple);
+	entries = clamp_t(u32, entries, ctxm->min_entries, ctxm->max_entries);
+	mem_size = entries * ctxm->entry_size;
+	for (i = 0; i < n && !rc; i++) {
+		ctx_pg[i].entries = entries;
+		rc = bnxt_alloc_ctx_pg_tbls(bp, &ctx_pg[i], mem_size, pg_lvl,
+					    ctxm->init_value ? ctxm : NULL);
+	}
+	return rc;
+}
+
 void bnxt_free_ctx_mem(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
@@ -7605,13 +7630,11 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 
 static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 {
-	struct bnxt_ctx_pg_info *ctx_pg;
 	struct bnxt_ctx_mem_type *ctxm;
 	struct bnxt_ctx_mem_info *ctx;
 	u32 l2_qps, qp1_qps, max_qps;
-	u32 mem_size, ena, entries;
-	u32 entries_sp, min;
-	u32 srqs, max_srqs;
+	u32 ena, entries_sp, entries;
+	u32 srqs, max_srqs, min;
 	u32 num_mr, num_ah;
 	u32 extra_srqs = 0;
 	u32 extra_qps = 0;
@@ -7642,61 +7665,37 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, l2_qps + qp1_qps + extra_qps,
+				     pg_lvl);
+	if (rc)
+		return rc;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = srqs + extra_srqs;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, srqs + extra_srqs, pg_lvl);
+	if (rc)
+		return rc;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_CQ];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = ctxm->cq_l2_entries + extra_qps * 2;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, pg_lvl, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->cq_l2_entries +
+				     extra_qps * 2, pg_lvl);
+	if (rc)
+		return rc;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_VNIC];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = ctxm->max_entries;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
+	if (rc)
+		return rc;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_STAT];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = ctxm->max_entries;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
+	if (rc)
+		return rc;
 
 	ena = 0;
 	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
 		goto skip_rdma;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
-	ctx_pg = ctxm->pg_info;
 	/* 128K extra is needed to accommodate static AH context
 	 * allocation by f/w.
 	 */
@@ -7706,24 +7705,15 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
 		ctxm->mrav_av_entries = num_ah;
 
-	ctx_pg->entries = num_mr + num_ah;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 2, ctxm);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, num_mr + num_ah, 2);
+	if (rc)
+		return rc;
 	ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
-	ctx_pg = ctxm->pg_info;
-	ctx_pg->entries = l2_qps + qp1_qps + extra_qps;
-	if (ctxm->entry_size) {
-		mem_size = ctxm->entry_size * ctx_pg->entries;
-		rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1, NULL);
-		if (rc)
-			return rc;
-	}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, l2_qps + qp1_qps + extra_qps, 1);
+	if (rc)
+		return rc;
 	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM;
 
 skip_rdma:
@@ -7731,22 +7721,17 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	min = ctxm->min_entries;
 	entries_sp = ctx->ctx_arr[BNXT_CTX_VNIC].vnic_entries + l2_qps +
 		     2 * (extra_qps + qp1_qps) + min;
-	entries_sp = roundup(entries_sp, ctxm->entry_multiple);
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, entries_sp, 2);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNXT_CTX_FTQM];
 	entries = l2_qps + 2 * (extra_qps + qp1_qps);
-	entries = roundup(entries, ctxm->entry_multiple);
-	entries = clamp_t(u32, entries, min, ctxm->max_entries);
-	for (i = 0, ctx_pg = ctxm->pg_info; i < ctx->tqm_fp_rings_count + 1;
-	     ctx_pg = &ctx->ctx_arr[BNXT_CTX_FTQM].pg_info[i], i++) {
-		ctx_pg->entries = i ? entries : entries_sp;
-		if (ctxm->entry_size) {
-			mem_size = ctxm->entry_size * ctx_pg->entries;
-			rc = bnxt_alloc_ctx_pg_tbls(bp, ctx_pg, mem_size, 1,
-						    NULL);
-			if (rc)
-				return rc;
-		}
+	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, entries, 2);
+	if (rc)
+		return rc;
+	for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++)
 		ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP << i;
-	}
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
 	rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
 	if (rc) {
-- 
2.30.1


--00000000000020d410060a9e1226
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINipSY6ilLwiYfGIbsyJHBsOQQnnL3sC
YGZabeKb6sr1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBqyMpBYDkdl4hokRI+OX6WBKDPFawB01BsR1VpwmXo32nEaypa
e9WtxbcZ5/8DzEDV70cKc0EVMsqUGvzH6vmUfgK7TjVFkhpWeH8ctpYS7e2qNhiEzsmyGuxX2Znu
mR0BXpMqgH0+DR0F1hiOQDfS8++/7zvKsajN01pNERIlY/97bvO9XviPy7aW+AJ22E+gvX22/a2I
9juA5b9voEOu+v5hVyncTdI1g+Lck6+5CxvYaUOh2k3hSN+TNUbUEAowORM7ax9tA0BAz1gYKHhE
nU4/noTMdypTLBu69xllcTsJAYRiNoL1pyrCJVN7J9Gbxc3gGpMH3Ln0+ARXa0e3
--00000000000020d410060a9e1226--

