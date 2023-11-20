Return-Path: <netdev+bounces-49455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F27F2197
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81E82826D5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD63C084;
	Mon, 20 Nov 2023 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HXxhYwUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2CC8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc537ed54so30425461cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523889; x=1701128689; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4esdB+zPKllJ6zqtC3uuHmZwYDnv7UWKiy0T5PK8j4=;
        b=HXxhYwUcc/9J2AWPNiPcrSWqxiQFQY2zsQz5Z44H+d4mOxGP2UOqhJ3z9CbH8CzQbr
         GOHcz45oRvo/CjcYz6hjb5RZt0qhsAurVF6WhknyU3uP1wPS3vUEfXn0Jh47hiwt5/Qu
         hnLiQqHQVn7MhIrQWTNo8EIC4YiJzjjzjXo+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523889; x=1701128689;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4esdB+zPKllJ6zqtC3uuHmZwYDnv7UWKiy0T5PK8j4=;
        b=Kh5xBEvPBh8upkXFzoiemOP3Z8WT5Qkq/tqBSuSIugFaZ4jpSUG1xKf5Ez9IfE44d1
         AkO32BW7oA52FLys0Zl2/3Zeer5yWqcYQBrAAvKbncI7xreFaJX7xjbgHv/2KaEp2XZC
         PnZCuwL7pYd8CDz5jDLk4k/YNPCXi/jE2JPf65y/KlseXr94u2B2w+xvXr+BXfG9JhlS
         WyuD/aW/2lncHDOSQbLImiyQXamJqwELIECxSnxGj1AAwnITy3PGmyc8hWvU5mhadDNY
         dxwZnurcNL3qP5Bz03IFLByHONqryVHZbZPQNyptVL0d+3dvlm/pkJMBl34kYb9TZJGa
         7nnw==
X-Gm-Message-State: AOJu0Yw6f2Vc9E6/AyaRr5+RGHHqkQcyTWtu35JwS3jWfgEjWuivjmqL
	AjUtwDVrBREjHdOWKQjxvLn/LnWIzmsQ21Ff6xE=
X-Google-Smtp-Source: AGHT+IGl6iG2iN4Ehnvk7mlXwl/dkRfclKhkGDnNCbJysGpoT4QuQHG0ycwRtztrb3rgYBmD21zRGg==
X-Received: by 2002:ac8:5cc1:0:b0:41f:e523:ed2f with SMTP id s1-20020ac85cc1000000b0041fe523ed2fmr11607007qta.46.1700523889103;
        Mon, 20 Nov 2023 15:44:49 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:48 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 09/13] bnxt_en: Add db_ring_mask and related macro to bnxt_db_info struct.
Date: Mon, 20 Nov 2023 15:44:01 -0800
Message-Id: <20231120234405.194542-10-michael.chan@broadcom.com>
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
	boundary="0000000000005df788060a9e1214"

--0000000000005df788060a9e1214
Content-Transfer-Encoding: 8bit

This allows the doorbell related logic to mask the doorbell index
to the proper range before writing the doorbell.

The current code masks the doorbell index immediately to keep it in the
legal ranges for the most part.  Subsequent patches will change the
logic so that the index increments unbounded and it only gets masked
before use.  This is preparation work for the new chip that requires an
additional Epoch bit in the doorbell that needs to toggle when the index
has wrapped around.

This patch just adds the basic infrastructure and the logic is largely
unchanged.  We now replace RING_CMP() with the new DB_RING_IDX() at
appropriate places where we mask the completion ring index before
writing the doorbell.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 39 ++++++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 13 +++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 85d1fdb616ca..48c443d52344 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -254,18 +254,18 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 		writel(DB_CP_IRQ_DIS_FLAGS, db)
 
 #define BNXT_DB_CQ(db, idx)						\
-	writel(DB_CP_FLAGS | RING_CMP(idx), (db)->doorbell)
+	writel(DB_CP_FLAGS | DB_RING_IDX(db, idx), (db)->doorbell)
 
 #define BNXT_DB_NQ_P5(db, idx)						\
-	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ | RING_CMP(idx),	\
+	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ | DB_RING_IDX(db, idx),\
 		    (db)->doorbell)
 
 #define BNXT_DB_CQ_ARM(db, idx)						\
-	writel(DB_CP_REARM_FLAGS | RING_CMP(idx), (db)->doorbell)
+	writel(DB_CP_REARM_FLAGS | DB_RING_IDX(db, idx), (db)->doorbell)
 
 #define BNXT_DB_NQ_ARM_P5(db, idx)					\
-	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ_ARM | RING_CMP(idx),\
-		    (db)->doorbell)
+	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ_ARM |		\
+		    DB_RING_IDX(db, idx), (db)->doorbell)
 
 static void bnxt_db_nq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
@@ -287,7 +287,7 @@ static void bnxt_db_cq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5)
 		bnxt_writeq(bp, db->db_key64 | DBR_TYPE_CQ_ARMALL |
-			    RING_CMP(idx), db->doorbell);
+			    DB_RING_IDX(db, idx), db->doorbell);
 	else
 		BNXT_DB_CQ(db, idx);
 }
@@ -526,7 +526,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		memcpy(txbd, tx_push1, sizeof(*txbd));
 		prod = NEXT_TX(prod);
 		tx_push->doorbell =
-			cpu_to_le32(DB_KEY_TX_PUSH | DB_LONG_TX_PUSH | prod);
+			cpu_to_le32(DB_KEY_TX_PUSH | DB_LONG_TX_PUSH |
+				    DB_RING_IDX(&txr->tx_db, prod));
 		WRITE_ONCE(txr->tx_prod, prod);
 
 		tx_buf->is_push = 1;
@@ -2871,7 +2872,8 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 		if (cpr2->had_work_done) {
 			db = &cpr2->cp_db;
 			bnxt_writeq(bp, db->db_key64 | dbr_type |
-				    RING_CMP(cpr2->cp_raw_cons), db->doorbell);
+				    DB_RING_IDX(db, cpr2->cp_raw_cons),
+				    db->doorbell);
 			cpr2->had_work_done = 0;
 		}
 	}
@@ -5987,6 +5989,26 @@ static int bnxt_hwrm_set_async_event_cr(struct bnxt *bp, int idx)
 	}
 }
 
+static void bnxt_set_db_mask(struct bnxt *bp, struct bnxt_db_info *db,
+			     u32 ring_type)
+{
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX:
+		db->db_ring_mask = bp->tx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_RX:
+		db->db_ring_mask = bp->rx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_AGG:
+		db->db_ring_mask = bp->rx_agg_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+	case HWRM_RING_ALLOC_NQ:
+		db->db_ring_mask = bp->cp_ring_mask;
+		break;
+	}
+}
+
 static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 			u32 map_idx, u32 xid)
 {
@@ -6026,6 +6048,7 @@ static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 			break;
 		}
 	}
+	bnxt_set_db_mask(bp, db, ring_type);
 }
 
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a591f950ce14..7d79a2c8d3c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -813,8 +813,11 @@ struct bnxt_db_info {
 		u64		db_key64;
 		u32		db_key32;
 	};
+	u32			db_ring_mask;
 };
 
+#define DB_RING_IDX(db, idx)	((idx) & (db)->db_ring_mask)
+
 struct bnxt_tx_ring_info {
 	struct bnxt_napi	*bnapi;
 	struct bnxt_cp_ring_info	*tx_cpr;
@@ -2353,9 +2356,10 @@ static inline void bnxt_db_write_relaxed(struct bnxt *bp,
 					 struct bnxt_db_info *db, u32 idx)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5) {
-		bnxt_writeq_relaxed(bp, db->db_key64 | idx, db->doorbell);
+		bnxt_writeq_relaxed(bp, db->db_key64 | DB_RING_IDX(db, idx),
+				    db->doorbell);
 	} else {
-		u32 db_val = db->db_key32 | idx;
+		u32 db_val = db->db_key32 | DB_RING_IDX(db, idx);
 
 		writel_relaxed(db_val, db->doorbell);
 		if (bp->flags & BNXT_FLAG_DOUBLE_DB)
@@ -2368,9 +2372,10 @@ static inline void bnxt_db_write(struct bnxt *bp, struct bnxt_db_info *db,
 				 u32 idx)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5) {
-		bnxt_writeq(bp, db->db_key64 | idx, db->doorbell);
+		bnxt_writeq(bp, db->db_key64 | DB_RING_IDX(db, idx),
+			    db->doorbell);
 	} else {
-		u32 db_val = db->db_key32 | idx;
+		u32 db_val = db->db_key32 | DB_RING_IDX(db, idx);
 
 		writel(db_val, db->doorbell);
 		if (bp->flags & BNXT_FLAG_DOUBLE_DB)
-- 
2.30.1


--0000000000005df788060a9e1214
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDyd2qL6q4TR7IN5NSLhoTbFZFBXHAeL
WaWmDhKmxrGFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBbXj7N81haucD/CX7XzyfBkMRdBUyTEcuEB/WDXfPmtcSRQohS
ed0jMa4E4LvWGSQU7Jbyjv46vUE+nEeNXQaGUF5fcE8NP8WxIR9OI67Wsbmjtv/2H5a6vha7xRw8
6VyI1YLxN7Ui6SqepAVUJN8ndqSHQ44tiXA7+EgoQhqStgjVTrtj3QV95pR1U29dLssO5oTRpMBv
MK4KaACop3RaomQLVsNRk8gZ+JG0pY5jNmLYkhjnRrmNMhDfgteLNyLQZg4E+cdvb4qaDMMjreSB
Usl9I6F9u542SuBHh3agUi7TbtA0JuOb45PHa32oyyVMA0r/MP5cIEWB8T6Dt3Tk
--0000000000005df788060a9e1214--

