Return-Path: <netdev+bounces-47560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487357EA75C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9CD28102B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FDA7F7;
	Tue, 14 Nov 2023 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EvYXUkXj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8E1FD3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:17:01 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E7D49
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:00 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so3399827a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699921020; x=1700525820; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXVAA+iMnBYAbPlexIiJ/dr859n+goc7YW/gorJkqZU=;
        b=EvYXUkXjjLFERBus10JrVmQbZnjyeyxYp4CY/b+vnob2NCdXUcXTAXgY4+xye4aNv7
         S56iljsWAdThLmea/l3lWsFyEaNObVB1okW/cdS/cAd/W8+YzL9HyCr8S/38Vb+nzNDG
         T5xl08kJ/wWoJXS+2EL0X4+Ma1eCg8ogEK1OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699921020; x=1700525820;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXVAA+iMnBYAbPlexIiJ/dr859n+goc7YW/gorJkqZU=;
        b=JiZZVDsB9qrRp7+QYoKkz7cJ9QewFoFHTtYGCrvCGtJT6ygs6CS3m8rbB14E06x1nQ
         M2nHhi1YM6zQKb0sVPGTI/eSSFH2s1Z8A2+BxO54Bg6ZxmHORVGvUYa3jvq1wZm+CcD5
         3JW99FUcnMWTRA2Z6v8sqz+xLj6jv66N0pb4X9mO4JkDjsvyzCDQXbgFUEjicDQu1sQs
         x0tqJ3tu/ZTEWw763nHugy+wpH32h8QBkLnVvExHfwZTwZyjn6D4IpnaukiiAwQwwVw9
         w6bG1uo0PJXoauNpSYAbxe4sxaBoF6fuSq7ws5uWw3jqYfW8l1jRix8e1WcDFHvB4Psz
         2TPQ==
X-Gm-Message-State: AOJu0YxlxywSb9bLjkyMtUVyu1x0AskQqGl/MLZvsOHL9RagVM5t8gPO
	ZmWNoHwuSiPBKm0ozOPvp+WJZg==
X-Google-Smtp-Source: AGHT+IGFbCFXrjOCc5IrsSmDJu/1C4Psl1lfELf3AJJSDL+aH4tvMzPSWGF4HLMgw4twg/wnekHygw==
X-Received: by 2002:a17:90b:1802:b0:280:1c25:b633 with SMTP id lw2-20020a17090b180200b002801c25b633mr6118125pjb.2.1699921019283;
        Mon, 13 Nov 2023 16:16:59 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a680600b0027ffff956bcsm4063478pjj.47.2023.11.13.16.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 16:16:58 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v2 05/13] bnxt_en: Remove BNXT_RX_HDL and BNXT_TX_HDL
Date: Mon, 13 Nov 2023 16:16:13 -0800
Message-Id: <20231114001621.101284-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231114001621.101284-1-michael.chan@broadcom.com>
References: <20231114001621.101284-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008d1fac060a11b4b6"

--0000000000008d1fac060a11b4b6
Content-Transfer-Encoding: 8bit

These 2 constants were used for the one RX and one TX completion
ring pointer in the cpr->cp_ring_arr fixed array.  Now that we've
changed to allocating the array for the exact number of entries to
support more TX rings, we no longer use these constants.

The array index as well as the type of completion ring (RX/TX) are
now encoded in the handle for the completion ring.  This will allow
us to locate the completion ring during NAPI for any number of
completion rings sharing the same MSIX.  In the following patches,
we'll be adding support for more TX rings associated with the same
MSIX vector.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++-
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 11a85cb28517..a4f7fa17daf8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2906,12 +2906,15 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 
 		if (nqcmp->type == cpu_to_le16(NQ_CN_TYPE_CQ_NOTIFICATION)) {
 			u32 idx = le32_to_cpu(nqcmp->cq_handle_low);
+			u32 cq_type = BNXT_NQ_HDL_TYPE(idx);
 			struct bnxt_cp_ring_info *cpr2;
 
 			/* No more budget for RX work */
-			if (budget && work_done >= budget && idx == BNXT_RX_HDL)
+			if (budget && work_done >= budget &&
+			    cq_type == BNXT_NQ_HDL_TYPE_RX)
 				break;
 
+			idx = BNXT_NQ_HDL_IDX(idx);
 			cpr2 = &cpr->cp_ring_arr[idx];
 			work_done += __bnxt_poll_work(bp, cpr2,
 						      budget - work_done);
@@ -2927,8 +2930,9 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
 	}
 poll_done:
-	cpr_rx = &cpr->cp_ring_arr[BNXT_RX_HDL];
-	if (cpr_rx->bnapi && (bp->flags & BNXT_FLAG_DIM)) {
+	cpr_rx = &cpr->cp_ring_arr[0];
+	if (cpr_rx->cp_ring_type == BNXT_NQ_HDL_TYPE_RX &&
+	    (bp->flags & BNXT_FLAG_DIM)) {
 		struct dim_sample dim_sample = {};
 
 		dim_update_sample(cpr->event_ctr,
@@ -3592,6 +3596,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr, *cpr2;
 		struct bnxt_ring_struct *ring;
+		int cp_count = 0, k;
 
 		if (!bnapi)
 			continue;
@@ -3612,30 +3617,32 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
 			continue;
 
-		cpr->cp_ring_count = 2;
-		cpr->cp_ring_arr = kcalloc(cpr->cp_ring_count, sizeof(*cpr),
+		if (i < bp->rx_nr_rings)
+			cp_count++;
+		if ((sh && i < bp->tx_nr_rings) ||
+		    (!sh && i >= bp->rx_nr_rings))
+			cp_count++;
+
+		cpr->cp_ring_arr = kcalloc(cp_count, sizeof(*cpr),
 					   GFP_KERNEL);
-		if (!cpr->cp_ring_arr) {
-			cpr->cp_ring_count = 0;
+		if (!cpr->cp_ring_arr)
 			return -ENOMEM;
-		}
+		cpr->cp_ring_count = cp_count;
 
-		if (i < bp->rx_nr_rings) {
-			cpr2 = &cpr->cp_ring_arr[BNXT_RX_HDL];
-			rc = bnxt_alloc_cp_sub_ring(bp, cpr2);
-			if (rc)
-				return rc;
-			cpr2->bnapi = bnapi;
-			bp->rx_ring[i].rx_cpr = cpr2;
-		}
-		if ((sh && i < bp->tx_nr_rings) ||
-		    (!sh && i >= bp->rx_nr_rings)) {
-			cpr2 = &cpr->cp_ring_arr[BNXT_TX_HDL];
+		for (k = 0; k < cp_count; k++) {
+			cpr2 = &cpr->cp_ring_arr[k];
 			rc = bnxt_alloc_cp_sub_ring(bp, cpr2);
 			if (rc)
 				return rc;
 			cpr2->bnapi = bnapi;
-			bp->tx_ring[j++].tx_cpr = cpr2;
+			cpr2->cp_idx = k;
+			if (!k && i < bp->rx_nr_rings) {
+				bp->rx_ring[i].rx_cpr = cpr2;
+				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_RX;
+			} else {
+				bp->tx_ring[j++].tx_cpr = cpr2;
+				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_TX;
+			}
 		}
 	}
 	return 0;
@@ -6023,7 +6030,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 
 			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_TX_HDL;
+			ring->handle = BNXT_SET_NQ_HDL(cpr2);
 			map_idx = bnapi->index;
 			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
 			if (rc)
@@ -6060,7 +6067,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 
 			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_RX_HDL;
+			ring->handle = BNXT_SET_NQ_HDL(cpr2);
 			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
 			if (rc)
 				goto err_out;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c04089e7ac39..efb0db54575b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -543,6 +543,19 @@ struct nqe_cn {
 	__le32	cq_handle_high;
 };
 
+#define BNXT_NQ_HDL_IDX_MASK	0x00ffffff
+#define BNXT_NQ_HDL_TYPE_MASK	0xff000000
+#define BNXT_NQ_HDL_TYPE_SHIFT	24
+#define BNXT_NQ_HDL_TYPE_RX	0x00
+#define BNXT_NQ_HDL_TYPE_TX	0x01
+
+#define BNXT_NQ_HDL_IDX(hdl)	((hdl) & BNXT_NQ_HDL_IDX_MASK)
+#define BNXT_NQ_HDL_TYPE(hdl)	(((hdl) & BNXT_NQ_HDL_TYPE_MASK) >>	\
+				 BNXT_NQ_HDL_TYPE_SHIFT)
+
+#define BNXT_SET_NQ_HDL(cpr)						\
+	(((cpr)->cp_ring_type << BNXT_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
+
 #define DB_IDX_MASK						0xffffff
 #define DB_IDX_VALID						(0x1 << 26)
 #define DB_IRQ_DIS						(0x1 << 27)
@@ -997,6 +1010,8 @@ struct bnxt_cp_ring_info {
 
 	u8			had_work_done:1;
 	u8			has_more_work:1;
+	u8			cp_ring_type;
+	u8			cp_idx;
 
 	u32			last_cp_raw_cons;
 
@@ -1023,8 +1038,6 @@ struct bnxt_cp_ring_info {
 
 	int			cp_ring_count;
 	struct bnxt_cp_ring_info *cp_ring_arr;
-#define BNXT_RX_HDL	0
-#define BNXT_TX_HDL	1
 };
 
 struct bnxt_napi {
-- 
2.30.1


--0000000000008d1fac060a11b4b6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEFtGcURv79kxnus89tfMfv2A4BpdBRR
2BADqkTZKEGWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEx
NDAwMTcwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBjIFGbYZTqEhiSVs5Vr+3TD6aHDiXciKwd44IcYmmYq9pk0VPp
3zOXg8cmRrPgVHpIPdtPz6ivLv4UJAPi+Vq6TyQcgPjkWfoiX0kywe/OGSaPre50Z1azZvq891DL
0ai+7bkTD8OH5ACNeP4Ujs1PGn1V3N7k+vwLhYL48ku9E+wYKTa6wADEzgyesXlF3rQFPUn61B8D
oXjKm3yJi7yiaVKzDGOrLzYk0bBv5ud7+S91cehuCyBXDHQudDp/ptBlaCGAwGyFn5yYVrgGhWsu
KBH+CQMvTlVjpIjw8O+z6EjQKgk8l9BICYnQ8VeUbjENRE6NEuH8vlcZVoUmkR3G
--0000000000008d1fac060a11b4b6--

