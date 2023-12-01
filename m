Return-Path: <netdev+bounces-53122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD580169F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C664AB20FB8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F03F8DB;
	Fri,  1 Dec 2023 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZWEDuooO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB27D67
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:55 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-423c28db22eso31312141cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470395; x=1702075195; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBK43eNMRoJ0VYm+mq0tfngczeToPBDiWPoCLfYrtL0=;
        b=ZWEDuooO8x5CS/vhnUkJeA7HyEYFc7oUYd81c6hbzJCMDkW91LsqifkHiY0N84MAzL
         BMomIJ3X1bP0d9S2Wfw7KmL4LK3auCwxJJAxc8qHNfvBETcohcRR3YXxo9jU676Bxxa5
         RIf2rDKNYl2KTjEUswhUNWgnnKyCC4APiuqas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470395; x=1702075195;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBK43eNMRoJ0VYm+mq0tfngczeToPBDiWPoCLfYrtL0=;
        b=ERb9FjgwDSkl78IzShkvN3tZQvP5QHVwsyHBR+XEsI/behu351FgxA8swTY5fpdl/i
         X9WsuKMMEOmRC/2zgxROrX4vQy8rA3wQAzZThBFRnt6nGKTh/8DA7AhJdKyzn7du8X6J
         ycyJZUrM5haIsP0Erc3q//Cn2Fd/byaefTDfA20atIvyYvnfzDiFNare/C+3WCCUJwBJ
         Ueu7rze7iNwhICiDSflRo+sXGRPN3yXvimo27UGIfrl0DUE8PYQ5Jmlf2h1DCwoSKa/b
         ANZtGB74itWgk3iG6KoDFt6CbL0nXjg3GWH93KfB8Tt7jp8VYHDSrelri/9lpIKf6E3N
         q5Mg==
X-Gm-Message-State: AOJu0Yxkqgr7gjZIjw+3C5SO36lSKTR+cQi7PnhfLf1xUvzeh1CvNYyl
	GN/IkawaMlA891PozIp6JY2v0ia5VK5YF3qE5M0=
X-Google-Smtp-Source: AGHT+IGVYp9CWfAzaWvk/LobAQYXV0x9H9glxDH9+I+xshtoHaJbogrHRQ/VQOICMhbie5siLlrMVA==
X-Received: by 2002:a05:622a:451:b0:425:4042:f45f with SMTP id o17-20020a05622a045100b004254042f45fmr306525qtx.67.1701470394673;
        Fri, 01 Dec 2023 14:39:54 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:54 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 05/15] bnxt_en: Implement the new toggle bit doorbell mechanism on P7 chips
Date: Fri,  1 Dec 2023 14:39:14 -0800
Message-Id: <20231201223924.26955-6-michael.chan@broadcom.com>
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
	boundary="0000000000007eb72d060b7a72b6"

--0000000000007eb72d060b7a72b6
Content-Transfer-Encoding: 8bit

The new chip family passes the Toggle bits to the driver in the NQE
notification.  The driver now stores this value and sends it back to
hardware when it re-arms the RX and TX CQs.  Together with the earlier
patch that guarantees the driver will only re-arm the CQ at the end of
NAPI polling if it has seen a new NQE, this method allows the hardware
to detect any dropped doorbells.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a17de1aceff4..d4da55e01b2c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2880,13 +2880,18 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 		struct bnxt_db_info *db;
 
 		if (cpr2->had_work_done) {
+			u32 tgl = 0;
+
+			if (dbr_type == DBR_TYPE_CQ_ARMALL) {
+				cpr2->had_nqe_notify = 0;
+				tgl = cpr2->toggle;
+			}
 			db = &cpr2->cp_db;
-			bnxt_writeq(bp, db->db_key64 | dbr_type |
+			bnxt_writeq(bp,
+				    db->db_key64 | dbr_type | DB_TOGGLE(tgl) |
 				    DB_RING_IDX(db, cpr2->cp_raw_cons),
 				    db->doorbell);
 			cpr2->had_work_done = 0;
-			if (dbr_type == DBR_TYPE_CQ_ARMALL)
-				cpr2->had_nqe_notify = 0;
 		}
 	}
 	__bnxt_poll_work_done(bp, bnapi, budget);
@@ -2912,6 +2917,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		work_done = __bnxt_poll_cqs(bp, bnapi, budget);
 	}
 	while (1) {
+		u16 type;
+
 		cons = RING_CMP(raw_cons);
 		nqcmp = &cpr->nq_desc_ring[CP_RING(cons)][CP_IDX(cons)];
 
@@ -2933,7 +2940,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		 */
 		dma_rmb();
 
-		if (nqcmp->type == cpu_to_le16(NQ_CN_TYPE_CQ_NOTIFICATION)) {
+		type = le16_to_cpu(nqcmp->type);
+		if (NQE_CN_TYPE(type) == NQ_CN_TYPE_CQ_NOTIFICATION) {
 			u32 idx = le32_to_cpu(nqcmp->cq_handle_low);
 			u32 cq_type = BNXT_NQ_HDL_TYPE(idx);
 			struct bnxt_cp_ring_info *cpr2;
@@ -2946,6 +2954,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 			idx = BNXT_NQ_HDL_IDX(idx);
 			cpr2 = &cpr->cp_ring_arr[idx];
 			cpr2->had_nqe_notify = 1;
+			cpr2->toggle = NQE_CN_TOGGLE(type);
 			work_done += __bnxt_poll_work(bp, cpr2,
 						      budget - work_done);
 			cpr->has_more_work |= cpr2->has_more_work;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6d96f66dc8c0..79b4deb45cfb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1038,6 +1038,7 @@ struct bnxt_cp_ring_info {
 	u8			had_work_done:1;
 	u8			has_more_work:1;
 	u8			had_nqe_notify:1;
+	u8			toggle;
 
 	u8			cp_ring_type;
 	u8			cp_idx;
-- 
2.30.1


--0000000000007eb72d060b7a72b6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA20dT2dtz51ETBczoAIIQX9T3T1hBmw
8FvBWelGiqWpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBGKB4kenTTR6jaARrOVC3lkLII9kEcF8rvRt7PnZ++1lUYvJXY
gzm/DOLdjFIZplk3jfZ5tCX8+sZrTpolWt79uOzUpzrYwFj3YIdw6agchKGT6X1dgHh1LH4kkMuX
ubGTXVf2VOs36xc1pjdidTw3/aHdh4xaN9V8k8oOh40WNKTdI6SF0qLKHOif5zSCLFdBbFXUftYZ
5CPZmwjOEXtHft7NaSF/VXbUo1woEjZpg4sTfCcSPpSYTdM+DMcQdCQb33stpSjVAVrpoFxOVs+S
kPm1nlyhBbDVP/03MNoqHKebgMH4SCx7xoxqaKYjrL71tkbdR1aJVsx+sWobmHVz
--0000000000007eb72d060b7a72b6--

