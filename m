Return-Path: <netdev+bounces-53118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D87801699
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EB81F210B4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB15619C8;
	Fri,  1 Dec 2023 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dXjzExKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AACD54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423b8a41061so15112471cf.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470389; x=1702075189; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=os2GBrDP1iHtpBMOKGX1Z5wvg6btj0qCc7QbkvRVZ3E=;
        b=dXjzExKw9u3u1ABe2nHJf4FJ2ySepSkvbee/q2QuQSkShWO2w0MQ37ybEZ5fQyvMg8
         DI3ncKKARO1ZMrtrutzNfsSZbqd0MJhInuy5C9HJbzp6GLlQ4VE7ZbRglM0Jjhh8VmBA
         TLZP4FnnFKzePv/CN26bQgnJxU2d6wVgLjBsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470389; x=1702075189;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os2GBrDP1iHtpBMOKGX1Z5wvg6btj0qCc7QbkvRVZ3E=;
        b=pwcxRhc2V5Tx7528SPOPbP9LKuNZ+rUVvvFlrJd9mNf45v/YXfvzbRPDjTQ/EuaOUR
         NPfIbq4Lh7jA7HbGBLz2RgA94FwmlzzIxMeDqFdxF5ECZQSy8g2yOsab56C/PN8K2/Wj
         omCkITauDEJqMDMHgW1RVeZLRDf4ZZh7M9oeCRiY1yT8e7JCLMqlp7W2N3lzbDz1YKZq
         q2k61tm1jNbgOFgytwvso7+HqACG5QzY+9WHTAeUdW/jclSZsAFswfUTwiIvX6xl3oXC
         +Sb6HjRR4OLrfHO/D3eW8v19in7qjCXtKqwPUbk+dapLHiY6uC1oTDozKriOhNrxdrEU
         8vHg==
X-Gm-Message-State: AOJu0YwzKoCDmSdEDBfRztkFwDF9op7LKBDilboYMig7NqQEiP8tBiBj
	0dd02V9d0fZQGHy6R0RkHHtCzg==
X-Google-Smtp-Source: AGHT+IGswQWH6EaSO+KOP6iqbiNXq+7KcCF9kDtHbUAEJ6Hs4NmwwUi2H/3ObQBPcvPubnlz0cHaYQ==
X-Received: by 2002:ac8:5bc8:0:b0:425:4043:96e0 with SMTP id b8-20020ac85bc8000000b00425404396e0mr271330qtb.109.1701470388698;
        Fri, 01 Dec 2023 14:39:48 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:48 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 01/15] bnxt_en: Fix backing store V2 logic
Date: Fri,  1 Dec 2023 14:39:10 -0800
Message-Id: <20231201223924.26955-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000023d0ab060b7a728d"

--00000000000023d0ab060b7a728d
Content-Transfer-Encoding: 8bit

The current code determines the last backing store valid type during
bnxt_hwrm_func_backing_store_qcaps_v2().  In effect, the last type
is determined based on what firmware advertises.  The more correct
way is to determine it based on what the driver is configuring.  The
driver may not configure all the backing store types advertised by
firmware.

Move the logic to determine the last type to bnxt_backing_store_cfg_v2().
We need to pass the legacy enable flags to the function in case only
the legacy types are being configured.

Fixes: 236e237f8ffe ("bnxt_en: Add support for HWRM_FUNC_BACKING_STORE_CFG_V2 firmware calls")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e35e7e02538c..6f37b6ac8996 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7249,7 +7249,6 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 {
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
-	u16 last_valid_type = BNXT_CTX_INV;
 	struct bnxt_ctx_mem_info *ctx;
 	u16 type;
 	int rc;
@@ -7281,7 +7280,6 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 			continue;
 
 		ctxm->type = le16_to_cpu(resp->type);
-		last_valid_type = ctxm->type;
 		ctxm->entry_size = le16_to_cpu(resp->entry_size);
 		ctxm->flags = flags;
 		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
@@ -7298,8 +7296,6 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		     i++, p++)
 			ctxm->split[i] = le32_to_cpu(*p);
 	}
-	if (last_valid_type < BNXT_CTX_V2_MAX)
-		ctx->ctx_arr[last_valid_type].last = true;
 	rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_V2_MAX);
 
 ctx_done:
@@ -7751,13 +7747,22 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 	return rc;
 }
 
-static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
+static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
+	u16 last_type;
 	int rc = 0;
 	u16 type;
 
+	if (!ena)
+		return 0;
+	else if (ena & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM)
+		last_type = BNXT_CTX_MAX - 1;
+	else
+		last_type = BNXT_CTX_L2_MAX - 1;
+	ctx->ctx_arr[last_type].last = 1;
+
 	for (type = 0 ; type < BNXT_CTX_V2_MAX; type++) {
 		ctxm = &ctx->ctx_arr[type];
 
@@ -7904,7 +7909,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
 
 	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
-		rc = bnxt_backing_store_cfg_v2(bp);
+		rc = bnxt_backing_store_cfg_v2(bp, ena);
 	else
 		rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 94b3627406c4..f22800c1bb77 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1611,6 +1611,7 @@ struct bnxt_ctx_mem_type {
 #define BNXT_CTX_XPAR	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION
 
 #define BNXT_CTX_MAX	(BNXT_CTX_TIM + 1)
+#define BNXT_CTX_L2_MAX	(BNXT_CTX_FTQM + 1)
 #define BNXT_CTX_V2_MAX	(BNXT_CTX_XPAR + 1)
 #define BNXT_CTX_INV	((u16)-1)
 
-- 
2.30.1


--00000000000023d0ab060b7a728d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIst0lVwfCLs1KK55BxUXjfC0SsrrAoL
0uOWY4Ts6XRSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCYcyiyCcNQP8F+BMo7FG8qOX0uBQrFMC8eSEGAckUN+sWRM8Ui
12qrmB40wuGTM+AHodnxqY+SfjmZylJwXG1wL531WgZusF8WbeTKPHn7lD/Fgdt52VWRPSsIxeLn
x1b33m63v4ywVniFuxl73jyKSyyB4suJl4GWihpacNzZFcIbMwPRMJgZ7juEeZT03SiRj8dBwVJY
CH9aEwsl17YVzCCF1ykQpPbXDPiiNk7x6UnRN7/yEpHzuvx8uLD2T5xIf5p8XXiy+AWpoA1mUO+J
rdaw+nmNPns2N1lKBpv8O49TEQvot0rZ/CYIG5Tf7KU2PetHj6xCzj9tts8dLSQS
--00000000000023d0ab060b7a728d--

