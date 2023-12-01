Return-Path: <netdev+bounces-53120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7580169D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B91F2109F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD17619D2;
	Fri,  1 Dec 2023 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LdC3nIs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422FD54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:54 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b5714439b3so662310b6e.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470393; x=1702075193; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlN4F1+odCy5PCjDvuF2a1q4z1fAhAL3aqBytEBXCU8=;
        b=LdC3nIs6Jb+MsUxPn+OWAUJbSqEuJ+EPzUTj3VWRbiGf/+TrTCgOh8ykcAKauL8sUP
         eMod9aGxK6IGaahWWtqymM2Qh++lGmXbsthQVQzJfqQL1BfHrQTOpnAkavipDYiGW5wr
         8VeT8wfyp2R8Rk4bY81etaDW5m7SQI3/rDOWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470393; x=1702075193;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlN4F1+odCy5PCjDvuF2a1q4z1fAhAL3aqBytEBXCU8=;
        b=mXA0mRwUOIFEa+gNiB26Nu3mRdaPLhvCDKJEAycMVdiz0MqU2dAzg2W/5QMrtXCXRB
         Os7ibdV/PEPVoyVtccDhjDbBv5PtYOQ6XN+lgITSUhMzuCI+/Lpfj+ha8KR2ssrkYCAC
         iw8vEcUVPn1YZ2JXlNAn5aRmSjFlUM2CGy0GG1M8EDWiGIhrjcGZWg5UNAs7vmOOYzet
         lqaxarvjUmtoYCaiUILaBQNLdDcYgI9TUhpCGX2t0fgAb/nzsJJV/yUnT+cfsvraOz11
         92iEIzdeT3ywBJjxpzZdGyMn7/tc28ok4sXBVk1TyZ1u2yybLrnVOA606ji+nDAxn6Ci
         hzDQ==
X-Gm-Message-State: AOJu0Ywn9YWrTH0rSWg5c4z8EJCIVhSwHMINr7W3sWShEFu+SL5bn6Wd
	QpR5Hg+dsgw64u4O4NoEXozKQg==
X-Google-Smtp-Source: AGHT+IGqgA+i3LFD9RoU92PIz0ExaAN8CL9+uLwQwwnyT8KU/RRZ7XutBT0PUBgbs2W5WMQ0V4fiQQ==
X-Received: by 2002:aca:280e:0:b0:3b8:b063:8965 with SMTP id 14-20020aca280e000000b003b8b0638965mr207705oix.115.1701470393421;
        Fri, 01 Dec 2023 14:39:53 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:52 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 04/15] bnxt_en: Consolidate DB offset calculation
Date: Fri,  1 Dec 2023 14:39:13 -0800
Message-Id: <20231201223924.26955-5-michael.chan@broadcom.com>
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
	boundary="0000000000006c9743060b7a7283"

--0000000000006c9743060b7a7283
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

The doorbell offset on P5 chips is hard coded.  On the new P7 chips,
it is returned by the firmware.  Simplify the logic that determines
this offset and store it in a new db_offset field in struct bnxt.
Also, provide this offset to the RoCE driver in struct bnxt_en_dev.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 16 +++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 10 ++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  4 ++++
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 829b2a6a05a0..a17de1aceff4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6031,10 +6031,6 @@ static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 			u32 map_idx, u32 xid)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		if (BNXT_PF(bp))
-			db->doorbell = bp->bar1 + DB_PF_OFFSET_P5;
-		else
-			db->doorbell = bp->bar1 + DB_VF_OFFSET_P5;
 		switch (ring_type) {
 		case HWRM_RING_ALLOC_TX:
 			db->db_key64 = DBR_PATH_L2 | DBR_TYPE_SQ;
@@ -6054,6 +6050,8 @@ static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 
 		if (bp->flags & BNXT_FLAG_CHIP_P7)
 			db->db_key64 |= DBR_VALID;
+
+		db->doorbell = bp->bar1 + bp->db_offset;
 	} else {
 		db->doorbell = bp->bar1 + map_idx * 0x80;
 		switch (ring_type) {
@@ -7146,7 +7144,6 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 {
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
-	u32 min_db_offset = 0;
 	u16 flags;
 	int rc;
 
@@ -7204,16 +7201,17 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 	if (bp->db_size)
 		goto func_qcfg_exit;
 
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+	bp->db_offset = le16_to_cpu(resp->legacy_l2_db_size_kb) * 1024;
+	if (BNXT_CHIP_P5(bp)) {
 		if (BNXT_PF(bp))
-			min_db_offset = DB_PF_OFFSET_P5;
+			bp->db_offset = DB_PF_OFFSET_P5;
 		else
-			min_db_offset = DB_VF_OFFSET_P5;
+			bp->db_offset = DB_VF_OFFSET_P5;
 	}
 	bp->db_size = PAGE_ALIGN(le16_to_cpu(resp->l2_doorbell_bar_size_kb) *
 				 1024);
 	if (!bp->db_size || bp->db_size > pci_resource_len(bp->pdev, 2) ||
-	    bp->db_size <= min_db_offset)
+	    bp->db_size <= bp->db_offset)
 		bp->db_size = pci_resource_len(bp->pdev, 2);
 
 func_qcfg_exit:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 40b26f7a0f5e..6d96f66dc8c0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2216,6 +2216,7 @@ struct bnxt {
 	/* ensure atomic 64-bit doorbell writes on 32-bit systems. */
 	spinlock_t		db_lock;
 #endif
+	int			db_offset;	/* db_offset within db_size */
 	int			db_size;
 
 #define BNXT_NTP_FLTR_MAX_FLTR	4096
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index e89731492f5e..93f9bd55020f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -42,13 +42,10 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 	for (i = 0; i < num_msix; i++) {
 		ent[i].vector = bp->irq_tbl[idx + i].vector;
 		ent[i].ring_idx = idx + i;
-		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			ent[i].db_offset = DB_PF_OFFSET_P5;
-			if (BNXT_VF(bp))
-				ent[i].db_offset = DB_VF_OFFSET_P5;
-		} else {
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+			ent[i].db_offset = bp->db_offset;
+		else
 			ent[i].db_offset = (idx + i) * 0x80;
-		}
 	}
 }
 
@@ -333,6 +330,7 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->pdev = bp->pdev;
 	edev->l2_db_size = bp->db_size;
 	edev->l2_db_size_nc = bp->db_size;
+	edev->l2_db_offset = bp->db_offset;
 
 	if (bp->flags & BNXT_FLAG_ROCEV1_CAP)
 		edev->flags |= BNXT_EN_FLAG_ROCEV1_CAP;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 6ff77f082e6c..b9e73de14b57 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -73,6 +73,10 @@ struct bnxt_en_dev {
 							 * bytes mapped as non-
 							 * cacheable.
 							 */
+	int				l2_db_offset;	/* Doorbell offset in
+							 * bytes within
+							 * l2_db_size_nc.
+							 */
 	u16				chip_num;
 	u16				hw_ring_stats_size;
 	u16				pf_port_id;
-- 
2.30.1


--0000000000006c9743060b7a7283
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAN0TnWRzXse7XH8TaDjvZP5FbKwOYX+
iGbU3ZzQCR+dMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQALJb88L7UBb1ArZkN+ZlY0TSRb5U78aWSvgT6YViCmQEzX8ZNl
4/Jpe9uV+agH5z+FPjaIvo4vZsRoDg1EB/st9SsCYucKx8y5WIXZV31GFP8lLnyWqw2ySwKQHXSy
d6E+QXczCLICTE3ytTg3OtYdrX3cW7niwigRTyta4/TcM1TtcgfgRExuCvbVNXyzMeKcyQSair7E
KBvBUMy/trxRQU+MaC2g+1PqgBlQNoGX0RlxI8mRgekFJajkH/3FzEocpR3eztVLnK62vtPisFAw
rv9P/f2bGfH4DFGUJLOiw6vWkZw5touhPXa9YyQDg5J5BOxBliCq9snYob6IeV+Q
--0000000000006c9743060b7a7283--

