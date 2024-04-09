Return-Path: <netdev+bounces-86295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B589E53C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4B81C2251D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85709156F4E;
	Tue,  9 Apr 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dU8GQtA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF1158A37
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699698; cv=none; b=DtPxztwVEO+KEtQZa8Byoi+tAglEhrvh2tRVswv6pJbWJGh9YcJCCBRbgqmK2ZfxnYRSZrYr3TSFbToFP888cAGim1ne1P+W0RpjZo0U70/apIm5d4sWxzXz/v5zz+k7tyLOSwDYh3INbtGjyWSrRexxuPUPj8mtpvs3EVAs0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699698; c=relaxed/simple;
	bh=DE36xFvE7B7guPegznarAm0TQmeYd3/VyxjI0XZ640E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzXLn1CV/2faA4lLwbPi/uSnDHMdz0xP7NASrjJhSut/cXeigBxoKzBptBsR+QZyL6kwVRfRydSFy0xFABcVTBR+A9HHIT68JNt+jsCKj5FrDdvEtQM0esbRf7xvREoblUxs5EofaYwBaOFT8Dk1rQrVLMVfW8rZ5HHynnKHh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dU8GQtA6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4266673bbso23642625ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712699696; x=1713304496; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJB/79BEZAa3LWVuqfORyW2Ld4UjXZdq0FGdt1L9ezY=;
        b=dU8GQtA6JMX6lezTQ+LDXwWpom0R6YbKAFOSJcpIgjFVcI8ps2jk+pzDpg+cXsznZ+
         Us/NrvBU1V02tXcyy7RkCMCBA6/+KIQy6OPQLZffd5G0ISrVhm9B6ebT85/3hEWZTxS+
         M9IGYPsnmAil3RjG1hLsPxt6/neBH0NJOffhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699696; x=1713304496;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJB/79BEZAa3LWVuqfORyW2Ld4UjXZdq0FGdt1L9ezY=;
        b=ozkalTraim9gapcbqpbCBGT4QiGtR+iRS8H9Nt53HH7rIQ4KrkLrzUFHyJ5a6FuZpo
         +CePDcxm7U3e3bx2OvJQ7IcBMIhQeRZRhar0p9O+tlGnI6YRdbCKTmbUJEbN1+QjlgZl
         9JBBo8rPCX1lNGUoHu5DBof883/iHgFknPP3+kmD+5GQfkQErFN8zazDVb2EUY1K4qNu
         4EhKuC8R8Cfh+v9WXk65THMpQTcsOsN6bvQi0PtLEFdpHvzh8BwxQhm8NRIZa4LrPwk/
         Jsp/qa9JxNLs+MqKa9oA0kT8NJg4Kux+z3Wml7DrTJtfWtu+/PR5J3+v+9LCVsiaItOT
         uOvQ==
X-Gm-Message-State: AOJu0YzEJjNfZ8eDODpnukYdMSNeXG94p+2Q0AjCo5wL3ZEl/zHukgpk
	o6PK/9eq+vRzB1GgfH0TxBzSq9nD2Q0x3zBDLh95ytxKFWPOQcnxM2QsL/gsNA==
X-Google-Smtp-Source: AGHT+IF3gfB4lNa3j3+45isjso2dKdTQSOSSzwSYgOk/ecJEl+EH3ZaZyFY5HxOXGcEGCcx+IPzSmw==
X-Received: by 2002:a17:903:25cd:b0:1e0:9ee1:d4cf with SMTP id jc13-20020a17090325cd00b001e09ee1d4cfmr914325plb.41.1712699695571;
        Tue, 09 Apr 2024 14:54:55 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e3e081dea1sm6983687plb.0.2024.04.09.14.54.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:54:54 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 3/7] bnxt_en: Remove unneeded MSIX base structure fields and code
Date: Tue,  9 Apr 2024 14:54:27 -0700
Message-Id: <20240409215431.41424-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240409215431.41424-1-michael.chan@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000049b1f0615b0f96b"

--000000000000049b1f0615b0f96b
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

Ever since commit:

303432211324 ("bnxt_en: Remove runtime interrupt vector allocation")

The MSIX base vector is effectively always 0.  Remove all unneeded
structure fields and code referencing the MSIX base.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 31 +++----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 20 +++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 --
 3 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 795f3f957eb5..8213a37cba3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3905,13 +3905,12 @@ static int bnxt_alloc_cp_sub_ring(struct bnxt *bp,
 static int bnxt_alloc_cp_rings(struct bnxt *bp)
 {
 	bool sh = !!(bp->flags & BNXT_FLAG_SHARED_RINGS);
-	int i, j, rc, ulp_base_vec, ulp_msix;
+	int i, j, rc, ulp_msix;
 	int tcs = bp->num_tc;
 
 	if (!tcs)
 		tcs = 1;
 	ulp_msix = bnxt_get_ulp_msix_num(bp);
-	ulp_base_vec = bnxt_get_ulp_msix_base(bp);
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr, *cpr2;
@@ -3930,10 +3929,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		if (rc)
 			return rc;
 
-		if (ulp_msix && i >= ulp_base_vec)
-			ring->map_idx = i + ulp_msix;
-		else
-			ring->map_idx = i;
+		ring->map_idx = ulp_msix + i;
 
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			continue;
@@ -7347,17 +7343,7 @@ static int bnxt_hwrm_reserve_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 
 int bnxt_nq_rings_in_use(struct bnxt *bp)
 {
-	int cp = bp->cp_nr_rings;
-	int ulp_msix, ulp_base;
-
-	ulp_msix = bnxt_get_ulp_msix_num(bp);
-	if (ulp_msix) {
-		ulp_base = bnxt_get_ulp_msix_base(bp);
-		cp += ulp_msix;
-		if ((ulp_base + ulp_msix) > cp)
-			cp = ulp_base + ulp_msix;
-	}
-	return cp;
+	return bp->cp_nr_rings + bnxt_get_ulp_msix_num(bp);
 }
 
 static int bnxt_cp_rings_in_use(struct bnxt *bp)
@@ -7373,16 +7359,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 
 static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
 {
-	int ulp_stat = bnxt_get_ulp_stat_ctxs(bp);
-	int cp = bp->cp_nr_rings;
-
-	if (!ulp_stat)
-		return cp;
-
-	if (bnxt_nq_rings_in_use(bp) > cp + bnxt_get_ulp_msix_num(bp))
-		return bnxt_get_ulp_msix_base(bp) + ulp_stat;
-
-	return cp + ulp_stat;
+	return bp->cp_nr_rings + bnxt_get_ulp_stat_ctxs(bp);
 }
 
 static int bnxt_get_total_rss_ctxs(struct bnxt *bp, struct bnxt_hw_rings *hwr)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index fd890819d4bc..cae88747b110 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -31,21 +31,20 @@ static DEFINE_IDA(bnxt_aux_dev_ids);
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
 	struct bnxt_en_dev *edev = bp->edev;
-	int num_msix, idx, i;
+	int num_msix, i;
 
 	if (!edev->ulp_tbl->msix_requested) {
 		netdev_warn(bp->dev, "Requested MSI-X vectors insufficient\n");
 		return;
 	}
 	num_msix = edev->ulp_tbl->msix_requested;
-	idx = edev->ulp_tbl->msix_base;
 	for (i = 0; i < num_msix; i++) {
-		ent[i].vector = bp->irq_tbl[idx + i].vector;
-		ent[i].ring_idx = idx + i;
+		ent[i].vector = bp->irq_tbl[i].vector;
+		ent[i].ring_idx = i;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 			ent[i].db_offset = bp->db_offset;
 		else
-			ent[i].db_offset = (idx + i) * 0x80;
+			ent[i].db_offset = i * 0x80;
 	}
 }
 
@@ -111,17 +110,6 @@ int bnxt_get_ulp_msix_num(struct bnxt *bp)
 		min_t(u32, roce_msix, num_online_cpus()) : 0);
 }
 
-int bnxt_get_ulp_msix_base(struct bnxt *bp)
-{
-	if (bnxt_ulp_registered(bp->edev)) {
-		struct bnxt_en_dev *edev = bp->edev;
-
-		if (edev->ulp_tbl->msix_requested)
-			return edev->ulp_tbl->msix_base;
-	}
-	return 0;
-}
-
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
 {
 	if (bnxt_ulp_registered(bp->edev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index b9e73de14b57..f8df4095399f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -46,7 +46,6 @@ struct bnxt_ulp {
 	unsigned long	*async_events_bmap;
 	u16		max_async_event_id;
 	u16		msix_requested;
-	u16		msix_base;
 	atomic_t	ref_count;
 };
 
@@ -96,7 +95,6 @@ static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
 }
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp);
-int bnxt_get_ulp_msix_base(struct bnxt *bp);
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp);
 void bnxt_ulp_stop(struct bnxt *bp);
 void bnxt_ulp_start(struct bnxt *bp, int err);
-- 
2.30.1


--000000000000049b1f0615b0f96b
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMVMc941xIXHabSAcMdWZc7uhXIbH4JX
iaRZf5dDL1DAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIxNTQ1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBMSWvY8j6jAxECQisztiL5MmXHvsWgh/o/pxj25ioLqXR9PZWp
7AotYDHX3esCwv2QBNvjXqFbHXyVg86/iMePauh2tINzo8SyPqCMsXxhBQCLcam4nzhHvUtmAz3C
qR7VW1A1S4iDghxkXTR6QOVJ9ceZ3Iy6OQj/usvkyym/no7StTUm3Be2IZjkLq8wVZ2XPw8RT4VR
fkb28CzchCAuO0jGGewizaf6VIzNuOLIc9HZqWXTYpP2P7nagfFc9Oe0SgpGKOXKuoQt1vB6CeBg
nyqK3qcFdR/nfPBWQdxgKy90xZHlnAFnL5ZfarWvrTDzLQVj7WUrOyDpbgAQ6Bq6
--000000000000049b1f0615b0f96b--

