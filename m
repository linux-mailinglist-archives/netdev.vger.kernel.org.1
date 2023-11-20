Return-Path: <netdev+bounces-49454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99D7F2196
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218722826DE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719693BB39;
	Mon, 20 Nov 2023 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FAcUsZam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C0C7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41e58a33ec9so30476681cf.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523888; x=1701128688; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnJ4Fd6jgSYIbyztkUkCdk6VHmDxyI6t1l4oxLWExNw=;
        b=FAcUsZaml+TzkAISzO8nmaMAp91O9o8oAb3P+MP0VEoLAO3pmz/qE/RULVf+7ZjvXX
         gCeHfXmi6PaJyCjVZlb71Nvx/Yh2j5hvwDeo24/MJVJ7FumCouwRVEuujeyc/shaRkSv
         /wdZUm/yC2aZ/6X+N1Fz1+oR5S+Igrl4n9a00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523888; x=1701128688;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnJ4Fd6jgSYIbyztkUkCdk6VHmDxyI6t1l4oxLWExNw=;
        b=sr12FcTzH5coLlxF6fXAQlxDVzfuYid5ZJkntrgioUEOHpPIdfLmm4WKwMfWaB2qAR
         YJZBPaTyjI9MsLE9F9XMs3MwSAnBtJbx18xkunbr96A6E90OsUqd+vhZwi9Cx+B9oKo/
         +AyewOF0YFQaL6LqeiYopEBObiuJP1phDq7yOc/isXJj7infUrHNZDCm/pZsbNJyNE13
         EpAC1tjkY1FIPe+gRbB6WvU0hGzMmbAgAUAxoDWZvb/XQRP+pAF8N3ao/LR6YtvaScD1
         iuIKPtR1MaXvsZut59FEBEfE8f+8uJr/ZoGv1Kyns1UIoSd0vtPRKfqygObBJwtyGW2k
         CMZg==
X-Gm-Message-State: AOJu0YxxPdqloijFn3KoRX9awwAmMCM8NaDDvbrwlRW/s7kU3G5Js2ci
	MtpNiLMq55LCKesL07Rl3ox5sA==
X-Google-Smtp-Source: AGHT+IFhirdZ6AJYxLoUIiw2HOgtkXsxFhc6PS1bbUuncoaIQ+h3RuI5nKEtAt0BKgax8ur3fcYm7A==
X-Received: by 2002:ac8:5c05:0:b0:41e:236a:b314 with SMTP id i5-20020ac85c05000000b0041e236ab314mr12064205qti.68.1700523887840;
        Mon, 20 Nov 2023 15:44:47 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:47 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next 08/13] bnxt_en: Add support for HWRM_FUNC_BACKING_STORE_CFG_V2 firmware calls
Date: Mon, 20 Nov 2023 15:44:00 -0800
Message-Id: <20231120234405.194542-9-michael.chan@broadcom.com>
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
	boundary="0000000000004b93d6060a9e12cf"

--0000000000004b93d6060a9e12cf
Content-Transfer-Encoding: 8bit

Newer chips starting with 57600 will use this new firmware HWRM call to
configure backing store memory.  Add this new call if it is supported
by the firmware.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 71 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 19da6c8f8650..85d1fdb616ca 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7670,6 +7670,71 @@ static int bnxt_setup_ctxm_pg_tbls(struct bnxt *bp,
 	return rc;
 }
 
+static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
+					       struct bnxt_ctx_mem_type *ctxm,
+					       bool last)
+{
+	struct hwrm_func_backing_store_cfg_v2_input *req;
+	u32 instance_bmap = ctxm->instance_bmap;
+	int i, j, rc = 0, n = 1;
+	__le32 *p;
+
+	if (!(ctxm->flags & BNXT_CTX_MEM_TYPE_VALID) || !ctxm->pg_info)
+		return 0;
+
+	if (instance_bmap)
+		n = hweight32(ctxm->instance_bmap);
+	else
+		instance_bmap = 1;
+
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_BACKING_STORE_CFG_V2);
+	if (rc)
+		return rc;
+	hwrm_req_hold(bp, req);
+	req->type = cpu_to_le16(ctxm->type);
+	req->entry_size = cpu_to_le16(ctxm->entry_size);
+	req->subtype_valid_cnt = ctxm->split_entry_cnt;
+	for (i = 0, p = &req->split_entry_0; i < ctxm->split_entry_cnt; i++)
+		p[i] = cpu_to_le32(ctxm->split[i]);
+	for (i = 0, j = 0; j < n && !rc; i++) {
+		struct bnxt_ctx_pg_info *ctx_pg;
+
+		if (!(instance_bmap & (1 << i)))
+			continue;
+		req->instance = cpu_to_le16(i);
+		ctx_pg = &ctxm->pg_info[j++];
+		if (!ctx_pg->entries)
+			continue;
+		req->num_entries = cpu_to_le32(ctx_pg->entries);
+		bnxt_hwrm_set_pg_attr(&ctx_pg->ring_mem,
+				      &req->page_size_pbl_level,
+				      &req->page_dir);
+		if (last && j == n)
+			req->flags =
+				cpu_to_le32(FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_BS_CFG_ALL_DONE);
+		rc = hwrm_req_send(bp, req);
+	}
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
+static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
+{
+	struct bnxt_ctx_mem_info *ctx = bp->ctx;
+	struct bnxt_ctx_mem_type *ctxm;
+	int rc = 0;
+	u16 type;
+
+	for (type = 0 ; type < BNXT_CTX_V2_MAX; type++) {
+		ctxm = &ctx->ctx_arr[type];
+
+		rc = bnxt_hwrm_func_backing_store_cfg_v2(bp, ctxm, ctxm->last);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
 void bnxt_free_ctx_mem(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
@@ -7804,7 +7869,11 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++)
 		ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP << i;
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
-	rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
+
+	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
+		rc = bnxt_backing_store_cfg_v2(bp);
+	else
+		rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
 	if (rc) {
 		netdev_err(bp->dev, "Failed configuring context mem, rc = %d.\n",
 			   rc);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0dbf854530f1..a591f950ce14 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1548,6 +1548,7 @@ struct bnxt_ctx_mem_type {
 	u16	type;
 	u16	entry_size;
 	u32	flags;
+#define BNXT_CTX_MEM_TYPE_VALID FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID
 	u32	instance_bmap;
 	u8	init_value;
 	u8	entry_multiple;
-- 
2.30.1


--0000000000004b93d6060a9e12cf
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFFxZAAheiINEmtPzMxxruv0KvM3P9f/
DGOp2qissHwQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBrI42fAmkFlAGjWtCXM1Q19vXyHc1NvGUeO998INC0mJNxevdQ
r2lSGdxq/eTfjHpoD07/oV+OW5R5XVU6Nw35IoJGMS8pqBkEvLvX7j/FadMciO46zwedNYrwP/ao
4TcxJUMYMrHklJJROr8JtXhj+TlTQRYNhfMJgpJZKZLofMZjLLwldYCYFfvtD1ZYw+XwMCXfu/JA
+ohIVGv1slIjrhyCnOJVQzi8bOrGVHvH6JOED/GMSITLU8qiOjzyP1LWu3d9I+Yk44kkta8CJWm8
cyTZaddHYyzp1jm08LkuMRzskcrlxTHBML6Dxbo+Zp3MgZmM05jlUxhL3VZKq54l
--0000000000004b93d6060a9e12cf--

