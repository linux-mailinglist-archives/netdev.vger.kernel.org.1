Return-Path: <netdev+bounces-107802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7B91C69C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE00BB23179
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D6770F6;
	Fri, 28 Jun 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ggW9nzjp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886D7603A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603036; cv=none; b=HEa62JRek/QOMhAY8GU5LxDoBbstD3j30ISwS+0iVpfJrDGF5KBnBFy7hF+zBOOBgnmK7GBBSuS+565O4oYpmlGz+j1qjgN7eUrZqmphaeVwdnnFvIsY0NJZpeXGyJpLVFvbQotFhDPozxYNrKzt3j3G15Hpw8oShpJ6NoNJV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603036; c=relaxed/simple;
	bh=11CCrpCGN5jzubUe2G7mKmFND5Fdv22jTHokN2WC/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGKjOlKohLmkuzupOIHZjvoEYCmmc3Bgh9lZGRCfEdjBuvzjmkKXT/maglj5JKruoQStpIBrCWtjMkdPwpzjBAMUO3G/EqYkghPvLU07PVZUtx7uIwuzH8mDmaNnbDUDqSXoUUr1E6GBp8TSKGwBTtJ6ENr8Frfxg6wAYTV8Pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ggW9nzjp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-72b070c377aso755065a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719603035; x=1720207835; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+07bSrfpwf+HlEMskTT5vZR2+r6Qrfoz4F9dAaBG9c=;
        b=ggW9nzjp70Z3KR0njrUXWEAzFOhnZSi4D3kq8rbhN9ZW/k+xv+s0J2+rc34FDoUD4g
         JR0WGJcGN/pq5D6o+SF1Cn4rDOfTOuLjTnU0jOq9lHhRWWT0YePP9bwLtZ6kqTyWTBg2
         3R4jheD6cbOZ3XVuO+zQA9NY1HkICENgQ8CKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603035; x=1720207835;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+07bSrfpwf+HlEMskTT5vZR2+r6Qrfoz4F9dAaBG9c=;
        b=Oe8HjT+sAFH09sglinYUaTRtS/qGtnIxNB7/2Js5kAxu+wHPLNgA00otMdk4XguyF8
         DMS0eSkOrrbCDG41WvlnzHuiUlzntsj5m9eYVhHtsozJJrpkK8MHvPdmcl+1R20F6Vpr
         CtTIAn5NN9QROBV7BmZeYcG+vHLztYd8EI4G4oWZRMH36pakKSDEQ7av1ASskI2wDMWS
         e/8K9iemr9ozW6GCsKhFwf4uWk4NGlUiNTbcu/75XYNAAiBWqGHGm/yznn6eTDtZva4e
         A234MOyTNvvoiHqEuu4gOLzUZGY7riwEmOI1pw3vJhGY02JY0v7/zOSbMocNROVJdsbd
         ytIg==
X-Gm-Message-State: AOJu0Yy65RiRK8vTHNDVPjsGATqZsuYAV02lcj9kklNJUzB/Bfh/OJql
	i71vGLda2ZnU4L2ft4Z5ZMqOyDCFFXUoJvyrfDrue5Drc0xgM1DiQ290c4jPxg==
X-Google-Smtp-Source: AGHT+IGC7GOZViiRVokTspVtwnbW/l41BygwNSAF+2Udls0bkrGmDXo5NXd4xhCJlcTSmYMChkA6Gw==
X-Received: by 2002:a17:90b:c11:b0:2c2:c3f5:33c3 with SMTP id 98e67ed59e1d1-2c9276553cbmr4091597a91.6.1719603034174;
        Fri, 28 Jun 2024 12:30:34 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939cc9b04sm46707a91.0.2024.06.28.12.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:30:33 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 05/10] bnxt_en: Add BCM5760X specific PHC registers mapping
Date: Fri, 28 Jun 2024 12:30:00 -0700
Message-ID: <20240628193006.225906-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240628193006.225906-1-michael.chan@broadcom.com>
References: <20240628193006.225906-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000107ca0061bf848ab"

--000000000000107ca0061bf848ab
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

BCM5760X firmware will advertise direct 64-bit PHC registers access
for the driver from BAR0.

Make the necessary changes in handling HWRM_PORT_MAC_PTP_QCFG's
response and PHC register mapping for 5760X chips.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  8 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 10 +++++++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e6b0a937d9b1..f900bbbb7498 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9011,7 +9011,7 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 	u8 flags;
 	int rc;
 
-	if (bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5(bp)) {
+	if (bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp)) {
 		rc = -ENODEV;
 		goto no_ptp;
 	}
@@ -9027,7 +9027,8 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 		goto exit;
 
 	flags = resp->flags;
-	if (!(flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_HWRM_ACCESS)) {
+	if (BNXT_CHIP_P5_AND_MINUS(bp) &&
+	    !(flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_HWRM_ACCESS)) {
 		rc = -ENODEV;
 		goto exit;
 	}
@@ -9040,10 +9041,13 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 		ptp->bp = bp;
 		bp->ptp_cfg = ptp;
 	}
-	if (flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_PARTIAL_DIRECT_ACCESS_REF_CLOCK) {
+
+	if (flags &
+	    (PORT_MAC_PTP_QCFG_RESP_FLAGS_PARTIAL_DIRECT_ACCESS_REF_CLOCK |
+	     PORT_MAC_PTP_QCFG_RESP_FLAGS_64B_PHC_TIME)) {
 		ptp->refclk_regs[0] = le32_to_cpu(resp->ts_ref_clock_reg_lower);
 		ptp->refclk_regs[1] = le32_to_cpu(resp->ts_ref_clock_reg_upper);
-	} else if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+	} else if (BNXT_CHIP_P5(bp)) {
 		ptp->refclk_regs[0] = BNXT_TS_REG_TIMESYNC_TS0_LOWER;
 		ptp->refclk_regs[1] = BNXT_TS_REG_TIMESYNC_TS0_UPPER;
 	} else {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 12d6d17936a9..82b05641953f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2263,9 +2263,17 @@ struct bnxt {
 	 (BNXT_CHIP_NUM_58700((bp)->chip_num) &&	\
 	  !BNXT_CHIP_TYPE_NITRO_A0(bp)))
 
+/* Chip class phase 3.x */
+#define BNXT_CHIP_P3(bp)			\
+	(BNXT_CHIP_NUM_57X0X((bp)->chip_num) ||	\
+	 BNXT_CHIP_TYPE_NITRO_A0(bp))
+
 #define BNXT_CHIP_P4_PLUS(bp)			\
 	(BNXT_CHIP_P4(bp) || BNXT_CHIP_P5_PLUS(bp))
 
+#define BNXT_CHIP_P5_AND_MINUS(bp)		\
+	(BNXT_CHIP_P3(bp) || BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
+
 	struct bnxt_aux_priv	*aux_priv;
 	struct bnxt_en_dev	*edev;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 0ca7bc75616b..a3795ef8887d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -656,6 +656,14 @@ static int bnxt_map_ptp_regs(struct bnxt *bp)
 				(ptp->refclk_regs[i] & BNXT_GRC_OFFSET_MASK);
 		return 0;
 	}
+	if (bp->flags & BNXT_FLAG_CHIP_P7) {
+		for (i = 0; i < 2; i++) {
+			if (reg_arr[i] & BNXT_GRC_BASE_MASK)
+				return -EINVAL;
+			ptp->refclk_mapped_regs[i] = reg_arr[i];
+		}
+		return 0;
+	}
 	return -ENODEV;
 }
 
@@ -1018,7 +1026,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	ptp->stats.ts_lost = 0;
 	atomic64_set(&ptp->stats.ts_err, 0);
 
-	if (BNXT_CHIP_P5(bp)) {
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		spin_lock_bh(&ptp->ptp_lock);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, ptp->current_time);
-- 
2.30.1


--000000000000107ca0061bf848ab
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE9DCqHbMqw6740UEw4zY+6tIwNACguR
bnzOrTLGHH6QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE5MzAzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCdI+dfGGNoj7fFTXO+HLWmJVGVbnpK63JFEwpxBkGut4lBKFQL
RaC/XqsKmnFTiBPhEIWGhJhi65kTk+/T7Zz6T02eXSe1dkjpY//eI7rGDfJ/cOkz4O9ZmGde2SPL
J4UnYXJM+o/mg7w2Uy1+RBsXGkFICBSBufiAxLFMC1piJSaAIxmn1ipzIPsn17HxfIu9ZUSJ/Kp3
2cuzQLL54reJ7IZm4JoANOZFfDb+/QbLDcp43dlvajdNScZH5ck8GFKAkbSGMzj/tOmm86SvemlA
8s5pRQRgTwjs5XT7t8cxtdDbWLyBHBiDElnNQ/KAByklMqNp0Sr8o7RnJXm8Oj4E
--000000000000107ca0061bf848ab--

