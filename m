Return-Path: <netdev+bounces-56164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED780E07E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DBB211D5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15088659;
	Tue, 12 Dec 2023 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JSC3i7Pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF14A6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:51:53 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f8308616eso37643185a.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702342312; x=1702947112; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WguqJFGGFl7e8875DmHuLLtOdnq7eY2Vkwa0CIPYSw0=;
        b=JSC3i7Pfd3KJu9dEAmpxma/oWAzHuSpI+MXn8jb7l8ceUbu63QEJ6KzUW1qVM0SWEk
         U+vHNcXyZlcT2NUcG1D9c5jKliMx2PeGZQmoRs6ZsOygMLVFvktZcvFHCJdOLPmC4zQt
         J0PCKY6djSjSKk/gCunz2PyEO4P9iwDgqxVPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342312; x=1702947112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WguqJFGGFl7e8875DmHuLLtOdnq7eY2Vkwa0CIPYSw0=;
        b=fY7d+I07B05DtQsU3AFkE4hYAyKcLqBAMl7NWZKrfnNrJRtNYXK6KgVHhirBvPn2Dr
         aOS40KgM81yrMHYoqz38kMJ2Fv6r2tGm642Bf7oK7XOsvqqeBAmidUk8wYic1NlFeXZ4
         TX7CHeCdevFeq2WurRfhD0MrmhQhIEpwJSk9uI1Z8gyeIiNFMDa2RXCeFv8LF75Hek78
         U8nWuHxYJzYjFDbnAVcAsgdzmAh/zAUxeqhVByL7XxKKkQZptYfGq76j/yl16NZJXLVM
         75z25HhwLGX5Sr8u7w0+pZ8DVH8B3SLZSS9TaOQmvnGEp9R6CfGxs+b/CRlpB7+7fEzQ
         fqug==
X-Gm-Message-State: AOJu0Yywu0YsXIXZQ26plJ43oOWV5JmzQ3JPvlwM5GxaYmFpx+49Ae6e
	ni5d/n6ocSB37Uyhz2M6r0kC4A==
X-Google-Smtp-Source: AGHT+IGCcVHzuu8NbMCKMPE5+Zp/cwi4JFvU1qtrzIP7uPdR+nYxOsKaRqccvq1WWQ598YO0pxgPNw==
X-Received: by 2002:a05:622a:64a:b0:425:9d55:e9f5 with SMTP id a10-20020a05622a064a00b004259d55e9f5mr8564026qtb.75.1702342312259;
        Mon, 11 Dec 2023 16:51:52 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b00423ea1b31b3sm3619664qtt.66.2023.12.11.16.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2023 16:51:51 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH net-next 06/13] bnxt_en: Allocate extra QP backing store memory when RoCE FW reports it
Date: Mon, 11 Dec 2023 16:51:15 -0800
Message-Id: <20231212005122.2401-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231212005122.2401-1-michael.chan@broadcom.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d49863060c4574f3"

--000000000000d49863060c4574f3
Content-Transfer-Encoding: 8bit

From: Selvin Xavier <selvin.xavier@broadcom.com>

The Fast QP modify destroy RoCE feature requires additional QP entries
in QP context backing store. FW reports the extra count to be
allocated during backing store query. Use this value and allocate extra
memory.  Note that this works for both the V1 and V1 backing store
FW APIs.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 72e2bd4611de..42a52ee8c1bc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7535,6 +7535,7 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 		ctxm->max_entries = le32_to_cpu(resp->qp_max_entries);
 		ctxm->qp_qp1_entries = le16_to_cpu(resp->qp_min_qp1_entries);
 		ctxm->qp_l2_entries = le16_to_cpu(resp->qp_max_l2_entries);
+		ctxm->qp_fast_qpmd_entries = le16_to_cpu(resp->fast_qpmd_qp_num_entries);
 		ctxm->entry_size = le16_to_cpu(resp->qp_entry_size);
 		bnxt_init_ctx_initializer(ctxm, init_val, resp->qp_init_offset,
 					  (init_mask & (1 << init_idx++)) != 0);
@@ -7672,6 +7673,9 @@ static int bnxt_hwrm_func_backing_store_cfg(struct bnxt *bp, u32 enables)
 		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
 				      &req->qpc_pg_size_qpc_lvl,
 				      &req->qpc_page_dir);
+
+		if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD)
+			req->qp_num_fast_qpmd_entries = cpu_to_le16(ctxm->qp_fast_qpmd_entries);
 	}
 	if (enables & FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ) {
 		ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
@@ -8004,6 +8008,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	u32 num_mr, num_ah;
 	u32 extra_srqs = 0;
 	u32 extra_qps = 0;
+	u32 fast_qpmd_qps;
 	u8 pg_lvl = 1;
 	int i, rc;
 
@@ -8020,14 +8025,20 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
 	l2_qps = ctxm->qp_l2_entries;
 	qp1_qps = ctxm->qp_qp1_entries;
+	fast_qpmd_qps = ctxm->qp_fast_qpmd_entries;
 	max_qps = ctxm->max_entries;
 	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
 	srqs = ctxm->srq_l2_entries;
 	max_srqs = ctxm->max_entries;
+	ena = 0;
 	if ((bp->flags & BNXT_FLAG_ROCE_CAP) && !is_kdump_kernel()) {
 		pg_lvl = 2;
 		extra_qps = min_t(u32, 65536, max_qps - l2_qps - qp1_qps);
+		/* allocate extra qps if fw supports RoCE fast qp destroy feature */
+		extra_qps += fast_qpmd_qps;
 		extra_srqs = min_t(u32, 8192, max_srqs - srqs);
+		if (fast_qpmd_qps)
+			ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD;
 	}
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
@@ -8057,7 +8068,6 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	ena = 0;
 	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
 		goto skip_rdma;
 
@@ -8074,7 +8084,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, num_mr + num_ah, 2);
 	if (rc)
 		return rc;
-	ena = FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
+	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_TIM];
 	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, l2_qps + qp1_qps + extra_qps, 1);
-- 
2.30.1


--000000000000d49863060c4574f3
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICYohvKnrP8iylSR96YrgOJTS7vgisRX
E+E/PxhWSflPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIx
MjAwNTE1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB+KoUqW8EpfnAxTlY05qinkOHdOpV0gY30RLieo/+Z0koB/rHu
FM1n6fD0xmoOHOIPtSQ3HnEbzma+Co+1KxMI/bN3Z/hpNwY41mf1lwTJkNZXUqCYKGdUU16BrVUY
Tgnh+lCLkbD9E+sBkFtmnWBUx+aLnEah4fRqUEobPIXpME/QgB8h8biO8VH4EfmgipxqzTpQ+2yQ
ULF4AZGqTqBM5aNLgJunV36cBy2lRjKmGLsKJ1x7A8BMdHw/13adwjdFBzzqB2vOxuqXyzAHvf/6
GlMU/YPJepsX+YLufvxkUelOStgybut9sgyiNt4XR6DuaOA1PHQfTpLEkd6ByovR
--000000000000d49863060c4574f3--

