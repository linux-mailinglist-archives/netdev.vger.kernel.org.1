Return-Path: <netdev+bounces-49457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376187F2199
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BC3282734
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376793B791;
	Mon, 20 Nov 2023 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P83IvLt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5276AA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:52 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce2ea3a944so3256826a34.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523892; x=1701128692; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vEyflXwbxS2Y0ACXeNhIZOrUhvrfnDAJQpcjqHZf88=;
        b=P83IvLt5IObT0nBSPplIB2wuxZ5lrG+BWXE8VJBjewEKbUtkOCZtUno4sPoil6klNC
         KEXq/o3CWRIu01/vPxb2iOQw84JX3RlEabT6ETKgW1OTVzu0pANVlZ3acYACf6DT7/sI
         7Jk0re/KNBmRUv//7k6mWyjEW2i3496u+ISNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523892; x=1701128692;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vEyflXwbxS2Y0ACXeNhIZOrUhvrfnDAJQpcjqHZf88=;
        b=cvsK3UKw6dlG+oxGHrYAUwsKw5/j/spIER2YBD5Fzv/AYF7kGFecesnjoLmoqyY2lx
         Z/qw5xZwdJhH8emuSMQyrHOne180mx/xAj16LR+s6LNSw8pbSEfuT2d6advvYw3jktDR
         bOY1f679pOeMQ6/DoRh5FH7EVxwS9DDa/ZvPVx5rul52Qy2PwfBqDaIkxXMl9i5wioXQ
         0Y+vC1zfN8BziaH193PTO1VRvG6PLX1fBuxF5W0gAhKupa7ZCIyKUsox71ZoVq+XA6Bw
         H8RN+g5kR/hOcuK5xatudCMgbgkFoZ3Cw0LqlHoRVQWnD1CmoG2O0KyeiQ3UOZqEITCm
         ZSfQ==
X-Gm-Message-State: AOJu0YxgW8ciL5DPdA09vack9R5nAnV3aZ4uxHU8Ir/duwFaRuXI/HSa
	XejTFbQdnSg48pm+JscytTnK+fJLMUWX2t4xEg4=
X-Google-Smtp-Source: AGHT+IHWfKJS8T87bm1Z7DAFO/Zh7JEFwfUkEaOiY8joN63Gyl7cGutQ5tKKGy4CwNZdxr9lXKRNvQ==
X-Received: by 2002:a05:6358:5294:b0:169:9586:9195 with SMTP id g20-20020a056358529400b0016995869195mr8719738rwa.31.1700523891849;
        Mon, 20 Nov 2023 15:44:51 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:51 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 11/13] bnxt_en: Modify RX ring indexing logic.
Date: Mon, 20 Nov 2023 15:44:03 -0800
Message-Id: <20231120234405.194542-12-michael.chan@broadcom.com>
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
	boundary="00000000000088de72060a9e1285"

--00000000000088de72060a9e1285
Content-Transfer-Encoding: 8bit

Modify the RX indexing logic for both RX ring and RX aggregation ring just
like the TX logic.  Change it so that the index increments unbounded and
mask it only when needed.

Modify the existing RX macros so that the index is not masked.  Add new
macros RING_RX()/RING_RX_AGG() to mask it only when needed to get the
index of rxr->rx_buf_ring[] and rxr->rx_agg_ring[].

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 29 ++++++++++++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 10 +++++---
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c83450564765..b2cf42953130 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -821,8 +821,8 @@ static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp)
 {
-	struct rx_bd *rxbd = &rxr->rx_desc_ring[RX_RING(prod)][RX_IDX(prod)];
-	struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[prod];
+	struct rx_bd *rxbd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
+	struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	dma_addr_t mapping;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
@@ -855,9 +855,10 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
 {
 	u16 prod = rxr->rx_prod;
 	struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
+	struct bnxt *bp = rxr->bnapi->bp;
 	struct rx_bd *cons_bd, *prod_bd;
 
-	prod_rx_buf = &rxr->rx_buf_ring[prod];
+	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
 	prod_rx_buf->data = data;
@@ -865,8 +866,8 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
 
 	prod_rx_buf->mapping = cons_rx_buf->mapping;
 
-	prod_bd = &rxr->rx_desc_ring[RX_RING(prod)][RX_IDX(prod)];
-	cons_bd = &rxr->rx_desc_ring[RX_RING(cons)][RX_IDX(cons)];
+	prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
+	cons_bd = &rxr->rx_desc_ring[RX_RING(bp, cons)][RX_IDX(cons)];
 
 	prod_bd->rx_bd_haddr = cons_bd->rx_bd_haddr;
 }
@@ -886,7 +887,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 				     u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
-		&rxr->rx_agg_desc_ring[RX_RING(prod)][RX_IDX(prod)];
+		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
 	struct page *page;
 	dma_addr_t mapping;
@@ -903,7 +904,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 
 	__set_bit(sw_prod, rxr->rx_agg_bmap);
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
-	rxr->rx_sw_agg_prod = NEXT_RX_AGG(sw_prod);
+	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
 	rx_agg_buf->page = page;
 	rx_agg_buf->offset = offset;
@@ -979,13 +980,13 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 
 		prod_rx_buf->mapping = cons_rx_buf->mapping;
 
-		prod_bd = &rxr->rx_agg_desc_ring[RX_RING(prod)][RX_IDX(prod)];
+		prod_bd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
 
 		prod_bd->rx_bd_haddr = cpu_to_le64(cons_rx_buf->mapping);
 		prod_bd->rx_bd_opaque = sw_prod;
 
 		prod = NEXT_RX_AGG(prod);
-		sw_prod = NEXT_RX_AGG(sw_prod);
+		sw_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 	}
 	rxr->rx_agg_prod = prod;
 	rxr->rx_sw_agg_prod = sw_prod;
@@ -1327,7 +1328,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	cons = tpa_start->rx_tpa_start_cmp_opaque;
 	prod = rxr->rx_prod;
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
-	prod_rx_buf = &rxr->rx_buf_ring[prod];
+	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	tpa_info = &rxr->rx_tpa[agg_id];
 
 	if (unlikely(cons != rxr->rx_next_cons ||
@@ -1348,7 +1349,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	mapping = tpa_info->mapping;
 	prod_rx_buf->mapping = mapping;
 
-	prod_bd = &rxr->rx_desc_ring[RX_RING(prod)][RX_IDX(prod)];
+	prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
 
 	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
 
@@ -1381,8 +1382,8 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	tpa_info->agg_count = 0;
 
 	rxr->rx_prod = NEXT_RX(prod);
-	cons = NEXT_RX(cons);
-	rxr->rx_next_cons = NEXT_RX(cons);
+	cons = RING_RX(bp, NEXT_RX(cons));
+	rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
 	bnxt_reuse_rx_data(rxr, cons, cons_rx_buf->data);
@@ -2050,7 +2051,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 next_rx_no_len:
 	rxr->rx_prod = NEXT_RX(prod);
-	rxr->rx_next_cons = NEXT_RX(cons);
+	rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
 
 next_rx_no_prod_no_len:
 	*raw_cons = tmp_raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1b04510f677b..17e1881c8a27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -686,7 +686,9 @@ struct nqe_cn {
  */
 #define BNXT_MIN_TX_DESC_CNT		(MAX_SKB_FRAGS + 2)
 
-#define RX_RING(x)	(((x) & ~(RX_DESC_CNT - 1)) >> (BNXT_PAGE_SHIFT - 4))
+#define RX_RING(bp, x)	(((x) & (bp)->rx_ring_mask) >> (BNXT_PAGE_SHIFT - 4))
+#define RX_AGG_RING(bp, x)	(((x) & (bp)->rx_agg_ring_mask) >>	\
+				 (BNXT_PAGE_SHIFT - 4))
 #define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
 
 #define TX_RING(bp, x)	(((x) & (bp)->tx_ring_mask) >> (BNXT_PAGE_SHIFT - 4))
@@ -716,9 +718,11 @@ struct nqe_cn {
 #define RX_CMP_TYPE(rxcmp)					\
 	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_CMP_TYPE)
 
-#define NEXT_RX(idx)		(((idx) + 1) & bp->rx_ring_mask)
+#define RING_RX(bp, idx)	((idx) & (bp)->rx_ring_mask)
+#define NEXT_RX(idx)		((idx) + 1)
 
-#define NEXT_RX_AGG(idx)	(((idx) + 1) & bp->rx_agg_ring_mask)
+#define RING_RX_AGG(bp, idx)	((idx) & (bp)->rx_agg_ring_mask)
+#define NEXT_RX_AGG(idx)	((idx) + 1)
 
 #define RING_TX(bp, idx)	((idx) & (bp)->tx_ring_mask)
 #define NEXT_TX(idx)		((idx) + 1)
-- 
2.30.1


--00000000000088de72060a9e1285
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDiHNbLJjoi/MXEfeINUO8YDyIhvS32/
PALRP1+Up+1wMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCeC1X4+3TS0dkx4dhFloWkkpMYYkyB0jlE+HcS0FuDMWfusBBN
xbnOBzIqZpzi0orlhzmpSpjoAZKup1NuqN7ICL5BF41C1QZaIC8lvWTibUs/UkkLMY3L79gMQM1d
m8IL8zRbY9YThQvDQPjm1yBSdQHT4nS+rX3mfEeH8J2FJa63fyfGycaaKrn/E2ArGbMwe8/8YAzQ
O7oHu072FBzjXRcODA8Bk9igCKWRt483esoMPshty9o5wAYCvETa+RE9uy49/hyL3gpa5Jmj6hnC
nztT7Hu52Fr4+2ccBCeG0nr57XT9UwnMnGfuE+vcuir5ZlIcOSDzujd1hppNxVks
--00000000000088de72060a9e1285--

