Return-Path: <netdev+bounces-49453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E87F2195
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79103B2192C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6C3C06C;
	Mon, 20 Nov 2023 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X2q1CnU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237395
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc535cd5cso28303511cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523886; x=1701128686; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=113oq2Pt7E+2XS47rfNX7OdcNWpuPF2LkUNEcoXPJlw=;
        b=X2q1CnU9UFE3jxIWvUlKkIeduH/+Vb5qMmwdFSa1yTsQwRXP4zFhDVaGvZo1dl29jN
         fakPK99GImCSYpy5aO+UrI1BFNawvdo9iLha5bQ7CjBhv6n4CNaZKvfM0ix8AREQFzwI
         uknnZaQUz8D64eQeQYRBwq94mKzGqPVgcp1/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523886; x=1701128686;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=113oq2Pt7E+2XS47rfNX7OdcNWpuPF2LkUNEcoXPJlw=;
        b=xIRT7+CXq1ps39a/JmMhVxqtR/DF+gtjLmumeN15P5XJXVgv7aoQEvXi0Y2ABf0c+a
         xnAsqIsBCtWaIuYrTO51/MJDNS57DnFI4sDz2Ei4DG05TCwoztYHm4ivmqvieH1+IgeH
         d7PsBasJJTGHZ0sxFeRNCC5HiqqZ1OaRhy4uvZThm3d4Suwggp0F7PreLB6OVjV5KmQj
         J4KfUo7Shv+ZuNmo1bzdhb1ja0Ro5Hf5fTIc0S4mT0wml74up4C4mmfImzAv+Yx3vOXr
         T2XAmswISBnzZd2b5g6B3NGtU1IwP4JJYYjnACK3ZwMJFFuASANG/VpH6FlP9n84Bedo
         CSZA==
X-Gm-Message-State: AOJu0YypTCOz4eSi2w6iWXca5q+pMUmibi1joP8Tl077gEIZ48t8ldrn
	9DdRoBlS2BCiNtRMJ7MAyJ0XUg==
X-Google-Smtp-Source: AGHT+IHwOGVdv3ES6f86gaZKNqPnXza1A6rW8yxr1MXStZJ+om0QoZGFM3MtRMN3TuQANdF4xFh1Mg==
X-Received: by 2002:ac8:5810:0:b0:418:1565:ed50 with SMTP id g16-20020ac85810000000b004181565ed50mr10968929qtg.66.1700523886389;
        Mon, 20 Nov 2023 15:44:46 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:46 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 07/13] bnxt_en: Add support for new backing store query firmware API
Date: Mon, 20 Nov 2023 15:43:59 -0800
Message-Id: <20231120234405.194542-8-michael.chan@broadcom.com>
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
	boundary="000000000000346995060a9e1276"

--000000000000346995060a9e1276
Content-Transfer-Encoding: 8bit

Use the new v2 firmware API if supported by the firmware.  We now have the
infrastructure to support the v2 API.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 85 +++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +-
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e42c82ed0fd5..19da6c8f8650 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7208,6 +7208,72 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp, int ctx_max)
 	return 0;
 }
 
+#define BNXT_CTX_INIT_VALID(flags)	\
+	(!!((flags) &			\
+	    FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT))
+
+static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
+{
+	struct hwrm_func_backing_store_qcaps_v2_output *resp;
+	struct hwrm_func_backing_store_qcaps_v2_input *req;
+	u16 last_valid_type = BNXT_CTX_INV;
+	struct bnxt_ctx_mem_info *ctx;
+	u16 type;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_BACKING_STORE_QCAPS_V2);
+	if (rc)
+		return rc;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	bp->ctx = ctx;
+
+	resp = hwrm_req_hold(bp, req);
+
+	for (type = 0; type < BNXT_CTX_V2_MAX; ) {
+		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		u8 init_val, init_off, i;
+		__le32 *p;
+		u32 flags;
+
+		req->type = cpu_to_le16(type);
+		rc = hwrm_req_send(bp, req);
+		if (rc)
+			goto ctx_done;
+		flags = le32_to_cpu(resp->flags);
+		type = le16_to_cpu(resp->next_valid_type);
+		if (!(flags & FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID))
+			continue;
+
+		ctxm->type = le16_to_cpu(resp->type);
+		last_valid_type = ctxm->type;
+		ctxm->entry_size = le16_to_cpu(resp->entry_size);
+		ctxm->flags = flags;
+		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
+		ctxm->entry_multiple = resp->entry_multiple;
+		ctxm->max_entries = le32_to_cpu(resp->max_num_entries);
+		ctxm->min_entries = le32_to_cpu(resp->min_num_entries);
+		init_val = resp->ctx_init_value;
+		init_off = resp->ctx_init_offset;
+		bnxt_init_ctx_initializer(ctxm, init_val, init_off,
+					  BNXT_CTX_INIT_VALID(flags));
+		ctxm->split_entry_cnt = min_t(u8, resp->subtype_valid_cnt,
+					      BNXT_MAX_SPLIT_ENTRY);
+		for (i = 0, p = &resp->split_entry_0; i < ctxm->split_entry_cnt;
+		     i++, p++)
+			ctxm->split[i] = le32_to_cpu(*p);
+	}
+	if (last_valid_type < BNXT_CTX_V2_MAX)
+		ctx->ctx_arr[last_valid_type].last = true;
+	rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_V2_MAX);
+
+ctx_done:
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
 static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 {
 	struct hwrm_func_backing_store_qcaps_output *resp;
@@ -7217,6 +7283,9 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 	if (bp->hwrm_spec_code < 0x10902 || BNXT_VF(bp) || bp->ctx)
 		return 0;
 
+	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
+		return bnxt_hwrm_func_backing_store_qcaps_v2(bp);
+
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_BACKING_STORE_QCAPS);
 	if (rc)
 		return rc;
@@ -7229,13 +7298,15 @@ static int bnxt_hwrm_func_backing_store_qcaps(struct bnxt *bp)
 		u8 init_val, init_idx = 0;
 		u16 init_mask;
 
-		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+		ctx = bp->ctx;
 		if (!ctx) {
-			rc = -ENOMEM;
-			goto ctx_err;
+			ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+			if (!ctx) {
+				rc = -ENOMEM;
+				goto ctx_err;
+			}
+			bp->ctx = ctx;
 		}
-		bp->ctx = ctx;
-
 		init_val = resp->ctx_kind_initializer;
 		init_mask = le16_to_cpu(resp->ctx_init_mask);
 
@@ -7607,7 +7678,7 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 	if (!ctx)
 		return;
 
-	for (type = 0; type < BNXT_CTX_MAX; type++) {
+	for (type = 0; type < BNXT_CTX_V2_MAX; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
 		int i, n = 1;
@@ -7914,6 +7985,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 067a66eedf36..0dbf854530f1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1608,7 +1608,7 @@ struct bnxt_ctx_mem_info {
 
 	u32	flags;
 	#define BNXT_CTX_FLAG_INITED	0x01
-	struct bnxt_ctx_mem_type	ctx_arr[BNXT_CTX_MAX];
+	struct bnxt_ctx_mem_type	ctx_arr[BNXT_CTX_V2_MAX];
 };
 
 enum bnxt_health_severity {
@@ -2070,6 +2070,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED	BIT_ULL(33)
 	#define BNXT_FW_CAP_DFLT_VLAN_TPID_PCP		BIT_ULL(34)
 	#define BNXT_FW_CAP_PRE_RESV_VNICS		BIT_ULL(35)
+	#define BNXT_FW_CAP_BACKING_STORE_V2		BIT_ULL(36)
 
 	u32			fw_dbg_cap;
 
-- 
2.30.1


--000000000000346995060a9e1276
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDVvPb4OpbkF15g2NYbYfC0obKCQN4el
8DsYq3qCBe5TMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB3B1V2RM5C//vANzhGoIvVAAUmzIlHd87H2G33hrkrwJcoNmYt
BOburbP7X5YJcyWTxaJK5yvAmb+lnz2y0Cd+yDVmFT025a0Ls4o9bzRXqIj7rH6+R3HH4I1DOV+p
KzugGbcax6G+An70IC6qTFFNlrpjbu2UMLqqSbUn252Jfq0J36NFd5hajqrjxubu/36q8ZlPsxuq
9JjdwH22rqZH3eOO4Pb3cw1S1vcv/Zq/4oXbLwj79pP1dAjcWI159hDGGv2BMRG/VfPemoIKvAhU
24H/RwTsrSfF9+La0wU1ZlKlE4HMCmiIk2AKXIJr4cD7eRl+JTPhBaB/EO1oNKQr
--000000000000346995060a9e1276--

