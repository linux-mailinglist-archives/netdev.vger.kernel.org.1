Return-Path: <netdev+bounces-53119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A043C80169B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2277C1F21082
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7FC619CB;
	Fri,  1 Dec 2023 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RwiGke7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF8AD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-42542163a1fso93571cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470392; x=1702075192; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q90gn4bNPRL1M4sFYZ3SudsPk9XpXBothX4HDEsfZs=;
        b=RwiGke7kPNOxgKYV/scDoK+AEktFGijTy3kC6MxIR5LQ+m0w3M9LW/tXhINBPrrTGK
         gWPFST1MzF7QJxBAt1LqVp9BvEyXC/zWwpfqj9TTIPLOPEHWTXUcQrZQfTMEEpTFkQ3s
         qs9uIWNxRCBlDikLCSfgMqmgidV9yHenYCWFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470392; x=1702075192;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q90gn4bNPRL1M4sFYZ3SudsPk9XpXBothX4HDEsfZs=;
        b=dDL0sZrcLUQi17a8mMbs3Cnzt/j4dy58q13u8yOPKaSD9PowxLC+6dJ3PaFCido07b
         D1jERrVoLg20gKC1NqT+Si9Jq4oGuI8RBdfeWC0Be2kA0mYJ966ciIN44Erax/2Tcwby
         qBS3bQ80elbmkjpA0VRooYTPdYMP70ZjlNFAeg92LZkasSKp2b83TgnBVv3iGpY3E0Tw
         hvXdSlAduUUBferd+RprBImuqYHW76418bc8cy2wPDvJUU4TgaR60fULX7m9qml+QSwR
         hDrC9CxEqtIWNoyN8UjhBFfwrfS2x+Asc612hT7SRXYxb29YzDNegYMzc2XI4p+Vnf8h
         RyRg==
X-Gm-Message-State: AOJu0YwiwfhUOvV2VrXRNsiTKz99z1yqVueBH06E6A0/xTeTpw+kGRmD
	d9Ts2DKsBY74qFQkL7F7TQJd7Q==
X-Google-Smtp-Source: AGHT+IFy63Jz3UQp+xGfN3m1aIvRc6GDlTr1MtYaDgRym4hqvYKqg9gjPmA7MeavathKbq2YhIlX+A==
X-Received: by 2002:a05:622a:40b:b0:41e:2314:8dde with SMTP id n11-20020a05622a040b00b0041e23148ddemr273460qtx.38.1701470391638;
        Fri, 01 Dec 2023 14:39:51 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:51 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 03/15] bnxt_en: Define basic P7 macros
Date: Fri,  1 Dec 2023 14:39:12 -0800
Message-Id: <20231201223924.26955-4-michael.chan@broadcom.com>
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
	boundary="00000000000050aa88060b7a7221"

--00000000000050aa88060b7a7221
Content-Transfer-Encoding: 8bit

Repurpose the BNXT_FLAG_CHIP_SR2 flag by renaming it to
BNXT_FLAG_CHIP_P7 since the SR2 chip never went to production.  The SR2
statictics structure is also renamed for the P7 chip.  Define the basic
P7 doorbell bits (Epoch. Toggle, etc) and implement the Epoch bit
logic.  The next higher bit beyond the legal doorbell mask is the
Epoch bit used for doorbells on P7 chips.  This bit is used by the
chip to detect dropped doorbells.

The 57608 chip ID belonging to the P7 family is also defined.  Note
that the PCI ID is not added until the last patch in the series.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 ++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 40 ++++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 3 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6f37b6ac8996..829b2a6a05a0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -260,6 +260,10 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ | DB_RING_IDX(db, idx),\
 		    (db)->doorbell)
 
+#define BNXT_DB_NQ_P7(db, idx)						\
+	bnxt_writeq(bp, (db)->db_key64 | DBR_TYPE_NQ_MASK |		\
+		    DB_RING_IDX(db, idx), (db)->doorbell)
+
 #define BNXT_DB_CQ_ARM(db, idx)						\
 	writel(DB_CP_REARM_FLAGS | DB_RING_IDX(db, idx), (db)->doorbell)
 
@@ -269,7 +273,9 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 
 static void bnxt_db_nq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+	if (bp->flags & BNXT_FLAG_CHIP_P7)
+		BNXT_DB_NQ_P7(db, idx);
+	else if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		BNXT_DB_NQ_P5(db, idx);
 	else
 		BNXT_DB_CQ(db, idx);
@@ -5784,7 +5790,7 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 			if (BNXT_CHIP_P5(bp))
 				bp->hw_ring_stats_size = BNXT_RING_STATS_SIZE_P5;
 			else
-				bp->hw_ring_stats_size = BNXT_RING_STATS_SIZE_P5_SR2;
+				bp->hw_ring_stats_size = BNXT_RING_STATS_SIZE_P7;
 		}
 	}
 	hwrm_req_drop(bp, req);
@@ -6015,6 +6021,10 @@ static void bnxt_set_db_mask(struct bnxt *bp, struct bnxt_db_info *db,
 		db->db_ring_mask = bp->cp_ring_mask;
 		break;
 	}
+	if (bp->flags & BNXT_FLAG_CHIP_P7) {
+		db->db_epoch_mask = db->db_ring_mask + 1;
+		db->db_epoch_shift = DBR_EPOCH_SFT - ilog2(db->db_epoch_mask);
+	}
 }
 
 static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
@@ -6041,6 +6051,9 @@ static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 			break;
 		}
 		db->db_key64 |= (u64)xid << DBR_XID_SFT;
+
+		if (bp->flags & BNXT_FLAG_CHIP_P7)
+			db->db_key64 |= DBR_VALID;
 	} else {
 		db->doorbell = bp->bar1 + map_idx * 0x80;
 		switch (ring_type) {
@@ -14014,8 +14027,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (BNXT_CHIP_P5_PLUS(bp)) {
 		bp->flags |= BNXT_FLAG_CHIP_P5_PLUS;
-		if (BNXT_CHIP_SR2(bp))
-			bp->flags |= BNXT_FLAG_CHIP_SR2;
+		if (BNXT_CHIP_P7(bp))
+			bp->flags |= BNXT_FLAG_CHIP_P7;
 	}
 
 	rc = bnxt_alloc_rss_indir_tbl(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 8a22b2d7ea94..40b26f7a0f5e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -541,6 +541,8 @@ struct nqe_cn {
 	#define NQ_CN_TYPE_SFT            0
 	#define NQ_CN_TYPE_CQ_NOTIFICATION  0x30UL
 	#define NQ_CN_TYPE_LAST            NQ_CN_TYPE_CQ_NOTIFICATION
+	#define NQ_CN_TOGGLE_MASK         0xc0UL
+	#define NQ_CN_TOGGLE_SFT          6
 	__le16	reserved16;
 	__le32	cq_handle_low;
 	__le32	v;
@@ -561,6 +563,10 @@ struct nqe_cn {
 #define BNXT_SET_NQ_HDL(cpr)						\
 	(((cpr)->cp_ring_type << BNXT_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
 
+#define NQE_CN_TYPE(type)	((type) & NQ_CN_TYPE_MASK)
+#define NQE_CN_TOGGLE(type)	(((type) & NQ_CN_TOGGLE_MASK) >>	\
+				 NQ_CN_TOGGLE_SFT)
+
 #define DB_IDX_MASK						0xffffff
 #define DB_IDX_VALID						(0x1 << 26)
 #define DB_IRQ_DIS						(0x1 << 27)
@@ -576,9 +582,14 @@ struct nqe_cn {
 
 /* 64-bit doorbell */
 #define DBR_INDEX_MASK					0x0000000000ffffffULL
+#define DBR_EPOCH_MASK					0x01000000UL
+#define DBR_EPOCH_SFT					24
+#define DBR_TOGGLE_MASK					0x06000000UL
+#define DBR_TOGGLE_SFT					25
 #define DBR_XID_MASK					0x000fffff00000000ULL
 #define DBR_XID_SFT					32
 #define DBR_PATH_L2					(0x1ULL << 56)
+#define DBR_VALID					(0x1ULL << 58)
 #define DBR_TYPE_SQ					(0x0ULL << 60)
 #define DBR_TYPE_RQ					(0x1ULL << 60)
 #define DBR_TYPE_SRQ					(0x2ULL << 60)
@@ -591,6 +602,7 @@ struct nqe_cn {
 #define DBR_TYPE_CQ_CUTOFF_ACK				(0x9ULL << 60)
 #define DBR_TYPE_NQ					(0xaULL << 60)
 #define DBR_TYPE_NQ_ARM					(0xbULL << 60)
+#define DBR_TYPE_NQ_MASK				(0xeULL << 60)
 #define DBR_TYPE_NULL					(0xfULL << 60)
 
 #define DB_PF_OFFSET_P5					0x10000
@@ -819,9 +831,17 @@ struct bnxt_db_info {
 		u32		db_key32;
 	};
 	u32			db_ring_mask;
+	u32			db_epoch_mask;
+	u8			db_epoch_shift;
 };
 
-#define DB_RING_IDX(db, idx)	((idx) & (db)->db_ring_mask)
+#define DB_EPOCH(db, idx)	(((idx) & (db)->db_epoch_mask) <<	\
+				 ((db)->db_epoch_shift))
+
+#define DB_TOGGLE(tgl)		((tgl) << DBR_TOGGLE_SFT)
+
+#define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
+				 DB_EPOCH(db, idx))
 
 struct bnxt_tx_ring_info {
 	struct bnxt_napi	*bnapi;
@@ -1803,14 +1823,14 @@ struct bnxt {
 #define CHIP_NUM_57504		0x1751
 #define CHIP_NUM_57502		0x1752
 
+#define CHIP_NUM_57608		0x1760
+
 #define CHIP_NUM_58802		0xd802
 #define CHIP_NUM_58804		0xd804
 #define CHIP_NUM_58808		0xd808
 
 	u8			chip_rev;
 
-#define CHIP_NUM_58818		0xd818
-
 #define BNXT_CHIP_NUM_5730X(chip_num)		\
 	((chip_num) >= CHIP_NUM_57301 &&	\
 	 (chip_num) <= CHIP_NUM_57304)
@@ -1888,7 +1908,7 @@ struct bnxt {
 					 BNXT_FLAG_ROCEV2_CAP)
 	#define BNXT_FLAG_NO_AGG_RINGS	0x20000
 	#define BNXT_FLAG_RX_PAGE_MODE	0x40000
-	#define BNXT_FLAG_CHIP_SR2	0x80000
+	#define BNXT_FLAG_CHIP_P7	0x80000
 	#define BNXT_FLAG_MULTI_HOST	0x100000
 	#define BNXT_FLAG_DSN_VALID	0x200000
 	#define BNXT_FLAG_DOUBLE_DB	0x400000
@@ -1918,8 +1938,8 @@ struct bnxt {
 				  (bp)->max_tpa_v2) && !is_kdump_kernel())
 #define BNXT_RX_JUMBO_MODE(bp)	((bp)->flags & BNXT_FLAG_JUMBO)
 
-#define BNXT_CHIP_SR2(bp)			\
-	((bp)->chip_num == CHIP_NUM_58818)
+#define BNXT_CHIP_P7(bp)			\
+	((bp)->chip_num == CHIP_NUM_57608)
 
 #define BNXT_CHIP_P5(bp)			\
 	((bp)->chip_num == CHIP_NUM_57508 ||	\
@@ -1928,7 +1948,7 @@ struct bnxt {
 
 /* Chip class phase 5 */
 #define BNXT_CHIP_P5_PLUS(bp)			\
-	(BNXT_CHIP_P5(bp) || BNXT_CHIP_SR2(bp))
+	(BNXT_CHIP_P5(bp) || BNXT_CHIP_P7(bp))
 
 /* Chip class phase 4.x */
 #define BNXT_CHIP_P4(bp)			\
@@ -2272,15 +2292,15 @@ struct bnxt {
 #define BNXT_NUM_TX_RING_STATS			8
 #define BNXT_NUM_TPA_RING_STATS			4
 #define BNXT_NUM_TPA_RING_STATS_P5		5
-#define BNXT_NUM_TPA_RING_STATS_P5_SR2		6
+#define BNXT_NUM_TPA_RING_STATS_P7		6
 
 #define BNXT_RING_STATS_SIZE_P5					\
 	((BNXT_NUM_RX_RING_STATS + BNXT_NUM_TX_RING_STATS +	\
 	  BNXT_NUM_TPA_RING_STATS_P5) * 8)
 
-#define BNXT_RING_STATS_SIZE_P5_SR2				\
+#define BNXT_RING_STATS_SIZE_P7					\
 	((BNXT_NUM_RX_RING_STATS + BNXT_NUM_TX_RING_STATS +	\
-	  BNXT_NUM_TPA_RING_STATS_P5_SR2) * 8)
+	  BNXT_NUM_TPA_RING_STATS_P7) * 8)
 
 #define BNXT_GET_RING_STATS64(sw, counter)		\
 	(*((sw) + offsetof(struct ctx_hw_stats, counter) / 8))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b0cea5b600cc..99c8b15bdfbe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -513,7 +513,7 @@ static int bnxt_get_num_tpa_ring_stats(struct bnxt *bp)
 		if (bp->max_tpa_v2) {
 			if (BNXT_CHIP_P5(bp))
 				return BNXT_NUM_TPA_RING_STATS_P5;
-			return BNXT_NUM_TPA_RING_STATS_P5_SR2;
+			return BNXT_NUM_TPA_RING_STATS_P7;
 		}
 		return BNXT_NUM_TPA_RING_STATS;
 	}
-- 
2.30.1


--00000000000050aa88060b7a7221
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDRRLZajow33D7hB7acw61BwmQ0ahAOa
zhdvBUY5KanJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBQNxgwlnprVWJxaCWhL44sU0Ch6kwEjgwXZkIAiZqD5T7czBwF
VbKiyvXzTrzsFvPE9zabScK59zZqSv3NHGuIOQ3V35W8/g7Xi4GyC2R0E20wmjrjTXsux6oY7F3X
1hjtc6DifuFfW+anjLw2XyKJh/GtWj2gNuMm8a+VPsGlb3QMxZBjJ5gpD3R5cjFUSXFFHnPfXV9o
a7wIDx57hlRYn2SihnqFHpNqI8TY588Wjsa2mRsK177lyQsJX3/nHYLUMaQD4OoWvHUaynwuuWFA
v/SFGM0P/+xDpvwxyNEdgWM9bMgbZEdMaXLZ+Sp6OXhsU8Nar4QmbQLaTBeEOkPx
--00000000000050aa88060b7a7221--

