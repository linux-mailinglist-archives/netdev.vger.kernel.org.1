Return-Path: <netdev+bounces-92629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414748B82B7
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508BCB216F7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060C3BB2E;
	Tue, 30 Apr 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gfbl6+FV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F22C853
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517175; cv=none; b=kdNXbATSrGDrUXWa18AlLYqcUiVHeDPLi4JtVSeegEGG4OVGRhGBZWFg3u7n1u+kjxK3RWdBmfoGGk1k2gARWKG2xu7VzP0kdG/dkDqHknDN9r9Fl3sdwBYgP2w8JIT8Qqao7zpFuENVhAYZ/hpCWhUlEMe9gBzgtOdp2IXuz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517175; c=relaxed/simple;
	bh=6mVPS7TncWc8rZeUJrQnSatBetIYzPKAWstvnb9Wqmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6dBydkbNQixTJFzUr0U4aqmuOGjCSK43/yeP9k21X6B2cdfA6f/5a0jHdxBhiBdHcroCk8xvdjeeVsOcBKkeEcfBMBqHY9zB8GdClObebDd31Z2FoBC2W0IInxKoKQSuN3aVqSossEErQlTMN0AFMbfLFtShgjrEHdaqXrJfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gfbl6+FV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3960509a12.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714517173; x=1715121973; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4aiW0tCtnnxe4pUVwZynZF9OlmD9SNkaQDmahQztks=;
        b=gfbl6+FVEOmE9KPNsmY7ebb05vrtL+kB+ClYj35rpMWQZ+72Jtu27xkRPQO+LOhwtn
         cr533J3XCWBeM87NrUfE8+1cfT63Y+2IJavpAs1+s2GPDXJnqugkLcik6PxuaEAgepS2
         RdbtiCVw5VTbAVRSt00JQmgP1XiEWZYpHJxGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517173; x=1715121973;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4aiW0tCtnnxe4pUVwZynZF9OlmD9SNkaQDmahQztks=;
        b=fBQ3nmfysMtdQaYDIs41MaB/lSI2QMGXNUs7gzpslOC5wwqnMD4+F4zu6E/BcHdQrQ
         OYoh+zi9Z9Z9lHiIjv6lPd07OgYNaNqiwTpBb+pOQaY1rPTuRBs6PYoXgXvY6EmxD8Sr
         EYGktPC2CLfVn2JW2qbvYmoQFE4TB4CoKzVRD4OOlBR8W4INju2Wxkv8qkXmPQYbC6jL
         v0q3KlVBqz43zYmJ0hNLG/dXP3x9rc9lWhetg7Ve/AAMBzCioNn39JE8ikuiRKcS0/wx
         YOrHDlG+NU2G0aDlnmGBZWJNc1Z1GbULv1dS0+rh6bdLUGkL0UJ8WE7A3PpEvXjsxn+y
         eTFg==
X-Gm-Message-State: AOJu0YyYDyc858juXz7XCX7NQQhnCllLJFdxg8Bvc66g2yGutjTp5k58
	19U+ySdU32CWOaXDpqZ46qxsj19ABkNGTrQq48TBdtvust46tYQSbSlJC/dOJw==
X-Google-Smtp-Source: AGHT+IELbP68HhD34YUDfFjQwmkD0S83nH8oCLTpg70viNuifIf3Z8hp/lxMgOlCW1exJJI/dhBAcQ==
X-Received: by 2002:a17:90a:bb89:b0:2a2:97f3:83b3 with SMTP id v9-20020a17090abb8900b002a297f383b3mr789203pjr.48.1714517172165;
        Tue, 30 Apr 2024 15:46:12 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001eb2fb28eabsm7836476plq.227.2024.04.30.15.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:46:10 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 1/7] bnxt_en: Fix and simplify bnxt_get_avail_msix() calls
Date: Tue, 30 Apr 2024 15:44:32 -0700
Message-Id: <20240430224438.91494-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240430224438.91494-1-michael.chan@broadcom.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000125a4c0617582378"

--000000000000125a4c0617582378
Content-Transfer-Encoding: 8bit

David reported this issue of the driver not initializing on an older
chip not running in the new resource manager mode (!BNXT_NEW_RM()).

Sample dmesg:

bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12

This is a regression caused by a recent commit that adds a call to
bnxt_get_avail_msix() before MSIX is initialized:

bnxt_set_dflt_rings()
  __bnxt_reserve_rings()
    bnxt_get_avail_msix()

bnxt_get_avail_msix() returns a negative number if !BNXT_NEW_RM() and
when MSIX is not initialized.  This causes __bnxt_reserve_rings() to
fail in this call sequence and the driver aborts initialization.

Before this commit in 2022:

303432211324 ("bnxt_en: Remove runtime interrupt vector allocation")

MSIX allocation for RoCE was dynamic and bnxt_get_avail_msix() was
used to determine the available run-time MSIX available for RoCE.

Today, bnxt_get_avail_msix() is only used to reserve some available
MSIX ahead of time to be ready when the RoCE driver loads.  It
only needs to be called when BNXT_NEW_RM() is true because older
chips do not require reservations for MSIX.  Simplify
bnxt_get_avail_msix() to only consider the BNXT_NEW_RM() case and
only make this call if BNXT_NEW_RM() is true.

Also change bnxt_get_avail_msix() to static since it is only used
in bnxt.c.

Reported-by: David Wei <dw@davidwei.uk>
Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 20 ++++++++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 -
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index be96bb494ae6..0eb880766012 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7459,6 +7459,8 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
+static int bnxt_get_avail_msix(struct bnxt *bp, int num);
+
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_rings hwr = {0};
@@ -7471,7 +7473,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (!bnxt_ulp_registered(bp->edev)) {
+	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
@@ -10474,19 +10476,13 @@ unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp)
 	return bnxt_get_max_func_stat_ctxs(bp) - bnxt_get_func_stat_ctxs(bp);
 }
 
-int bnxt_get_avail_msix(struct bnxt *bp, int num)
+/* Only called if BNXT_NEW_RM() is true to get the available MSIX to
+ * reserve ahead of time before RoCE is registered.
+ */
+static int bnxt_get_avail_msix(struct bnxt *bp, int num)
 {
-	int max_cp = bnxt_get_max_func_cp_rings(bp);
 	int max_irq = bnxt_get_max_func_irqs(bp);
 	int total_req = bp->cp_nr_rings + num;
-	int max_idx, avail_msix;
-
-	max_idx = bp->total_irqs;
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
-		max_idx = min_t(int, bp->total_irqs, max_cp);
-	avail_msix = max_idx - bp->cp_nr_rings;
-	if (!BNXT_NEW_RM(bp) || avail_msix >= num)
-		return avail_msix;
 
 	if (max_irq < total_req) {
 		num = max_irq - bp->cp_nr_rings;
@@ -10619,7 +10615,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (!bnxt_ulp_registered(bp->edev)) {
+	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
 		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ad57ef051798..0c680032ab66 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2736,7 +2736,6 @@ unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
 unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
-int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
-- 
2.30.1


--000000000000125a4c0617582378
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGZPokqcnsFhDEtx+mhE1+YXqL2o3UJz
55o2srGastq3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQz
MDIyNDYxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBmw4nl5ws433pQrU4QiLElY346xuaFVmxAdDtkoHo2lxLWQyOm
tczm8Oj10MjdHyTHHmOThQ/N2mzyn8cogalnUnHnGMu/L2U1Z4NDieLQxQ57pcbRA6K7Ll94K4IQ
hoqqi703gkt2PfJFB2H6XI8jb7NRGTT9OuzT3aDNkp7I3jHFGD4a6bN1PTSEZ2/C8+5dGhu7cMZl
97cE/1PRkq5qbuBP66ZRED7x2lrvOHQGX4OqIZWm93swBWh7+87IOBDePcGeBTfvQQ9bSiWBYth0
O8MCDiYlcf+YoEXfmOevOwPm38WEn48eEShyrpYTIRZ04UqP2xK4cX8mBVQnInie
--000000000000125a4c0617582378--

