Return-Path: <netdev+bounces-86298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6089E53F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEED1C2225E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2E4158D72;
	Tue,  9 Apr 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FsLkywsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B651158D9F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699703; cv=none; b=V1Y0Cs8I3XRHaw+EHK6UyDOKCbztPgRhdFqd2MVZL1H7Ux5daF4ZX2A3CyD+GjhCF9J4zptkua7E8AZ0dxt4xzWKv2MF27Eq4LIuwSD40MxgjNVw8dxMJiRP1IiiQgTK42PiqTwY55SfqiH2n2TAcK8hYjR4vwjMCc3bwFnO3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699703; c=relaxed/simple;
	bh=rxiBEKEkedwIdDbxrEOerM+1lZhF5rPcZUriLyF0Y5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOefMuqpKh4CMECWOP2N8+R8XvufmhzkilRYVL2e7XxEsutHLLxWXgn5pxUkprYwvNIySCzzbipvxtXa4vlN3wQ/3eyOEYoAg4/WQ2VjozYVc8gt/VLF9BIFG74/5kKpfGgoGJHwcgMnFxRzOtVHUJubccMDZxXsSkUlDSC5G6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FsLkywsb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2b1cd446fso45117695ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712699701; x=1713304501; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=95QbEKMhYkj+kQkqYtTK5zZYTEWqiLFm6PQcTVhJSn4=;
        b=FsLkywsbbhGtqyCwGsmfRjUNxNCFopUCkLG6PXSrSz2c6QZrnI0KtmEF4oZqJRacl4
         d69+2YXT0bR7sm0PcJAxOD/LVbzM9WtRNoW0bWD8oawNNd1KdqZw4lnmFKGhiVNrB/a2
         rkMNJufONSeuk9KzTlfr8MFCag/exfV9qvkZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699701; x=1713304501;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95QbEKMhYkj+kQkqYtTK5zZYTEWqiLFm6PQcTVhJSn4=;
        b=hToFU9V7d4UJZlbBFVoE5NRPZzhAt+cLohFtiAY64cQfqHc/BVItZb2xmRnYo7S20v
         rPnBsF/6srxsp/Iep2AA+ttn9mAyxw8JJER4RK4+ejjO3wyNWwERtsk20+v2S7spM59I
         rTW8ESTiXT5IF/hgMVe2CGkm+yISox0s4GGkqkUG0KVVj8RurEv/SKiPNctQ9yr1OcJo
         KzfGkP/ouyUAeGZVVQ7hP0akKvNUbacQzSSflhPmv62OSc9gp10Pq5AjizpmNAeYBVnV
         6GhixAbd/IoBycwSgEMAoTN/UPPzH2m9UaypUJwP4S35n12p5Htni+Nj1c3cgDdD0RS/
         L5WQ==
X-Gm-Message-State: AOJu0YynAsO7fRb+dDmJJUawmpnWBdt7rYHzJGdC5OxaO9QbDsHjqlCK
	Vp5SgUySMHuqWUd61PLrrS6k89RNkwEZ5t34so4dZK/nlWHsdZZX325AAxdzJw==
X-Google-Smtp-Source: AGHT+IEiMt2zv6OGJ5m4jRf3/HNlWTOlRr4AdRq4F58p87ZB7XtnJwEcR0YZNi+wP71tAoKs+sk5FQ==
X-Received: by 2002:a17:903:25d3:b0:1e2:7aba:6d0f with SMTP id jc19-20020a17090325d300b001e27aba6d0fmr1047164plb.36.1712699700500;
        Tue, 09 Apr 2024 14:55:00 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e3e081dea1sm6983687plb.0.2024.04.09.14.54.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:55:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 6/7] bnxt_en: Utilize ulp client resources if RoCE is not registered
Date: Tue,  9 Apr 2024 14:54:30 -0700
Message-Id: <20240409215431.41424-7-michael.chan@broadcom.com>
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
	boundary="00000000000052d5680615b0f96c"

--00000000000052d5680615b0f96c
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

If the RoCE driver is not registered for a RoCE capable device, add
flexibility to use the RoCE resources (MSIX/NQs) for L2 purposes,
such as additional rings configured by the user or for XDP.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 41 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 14 +++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 88cf8f47e071..a2e21fe64ab9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7470,14 +7470,27 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_rings hwr = {0};
+	int cp = bp->cp_nr_rings;
 	int rx_rings, rc;
+	int ulp_msix = 0;
 	bool sh = false;
 	int tx_cp;
 
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	hwr.cp = bnxt_nq_rings_in_use(bp);
+	if (!bnxt_ulp_registered(bp->edev)) {
+		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
+		if (!ulp_msix)
+			bnxt_set_ulp_stat_ctxs(bp, 0);
+
+		if (ulp_msix > bp->ulp_num_msix_want)
+			ulp_msix = bp->ulp_num_msix_want;
+		hwr.cp = cp + ulp_msix;
+	} else {
+		hwr.cp = bnxt_nq_rings_in_use(bp);
+	}
+
 	hwr.tx = bp->tx_nr_rings;
 	hwr.rx = bp->rx_nr_rings;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
@@ -7550,12 +7563,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
 	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
-		int resv_msix, resv_ctx, ulp_msix, ulp_ctxs;
+		int resv_msix, resv_ctx, ulp_ctxs;
 		struct bnxt_hw_resc *hw_resc;
 
 		hw_resc = &bp->hw_resc;
 		resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
-		ulp_msix = bnxt_get_ulp_msix_num(bp);
 		ulp_msix = min_t(int, resv_msix, ulp_msix);
 		bnxt_set_ulp_msix_num(bp, ulp_msix);
 		resv_ctx = hw_resc->resv_stat_ctxs  - bp->cp_nr_rings;
@@ -10609,13 +10621,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
 	int tcs = bp->num_tc;
+	int irqs_required;
 	int rc;
 
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (irq_re_init && BNXT_NEW_RM(bp) &&
-	    bnxt_get_num_msix(bp) != bp->total_irqs) {
+	if (!bnxt_ulp_registered(bp->edev)) {
+		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
+
+		if (ulp_msix > bp->ulp_num_msix_want)
+			ulp_msix = bp->ulp_num_msix_want;
+		irqs_required = ulp_msix + bp->cp_nr_rings;
+	} else {
+		irqs_required = bnxt_get_num_msix(bp);
+	}
+
+	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
 		bnxt_ulp_irq_stop(bp);
 		bnxt_clear_int_mode(bp);
 		irq_cleared = true;
@@ -13625,8 +13647,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		return -ENOMEM;
 	hwr.stat = hwr.cp;
 	if (BNXT_NEW_RM(bp)) {
-		hwr.cp += bnxt_get_ulp_msix_num(bp);
-		hwr.stat += bnxt_get_ulp_stat_ctxs(bp);
+		hwr.cp += bnxt_get_ulp_msix_num_in_use(bp);
+		hwr.stat += bnxt_get_ulp_stat_ctxs_in_use(bp);
 		hwr.grp = rx;
 		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	}
@@ -14899,8 +14921,9 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	*max_rx = hw_resc->max_rx_rings;
 	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
-			bnxt_get_ulp_msix_num(bp),
-			hw_resc->max_stat_ctxs - bnxt_get_ulp_stat_ctxs(bp));
+			bnxt_get_ulp_msix_num_in_use(bp),
+			hw_resc->max_stat_ctxs -
+			bnxt_get_ulp_stat_ctxs_in_use(bp));
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		*max_cp = min_t(int, *max_cp, max_irq);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index de2cb1d4cd98..edb10aebd095 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -61,6 +61,13 @@ void bnxt_set_ulp_msix_num(struct bnxt *bp, int num)
 		bp->edev->ulp_num_msix_vec = num;
 }
 
+int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp)
+{
+	if (bnxt_ulp_registered(bp->edev))
+		return bp->edev->ulp_num_msix_vec;
+	return 0;
+}
+
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
 {
 	if (bp->edev)
@@ -74,6 +81,13 @@ void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ulp_ctx)
 		bp->edev->ulp_num_ctxs = num_ulp_ctx;
 }
 
+int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp)
+{
+	if (bnxt_ulp_registered(bp->edev))
+		return bp->edev->ulp_num_ctxs;
+	return 0;
+}
+
 void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 {
 	if (bp->edev) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 04ce3328e66f..b86baf901a5d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -98,9 +98,11 @@ static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
 }
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp);
+int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp);
 void bnxt_set_ulp_msix_num(struct bnxt *bp, int num);
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp);
 void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ctxs);
+int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp);
 void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp);
 void bnxt_ulp_stop(struct bnxt *bp);
 void bnxt_ulp_start(struct bnxt *bp, int err);
-- 
2.30.1


--00000000000052d5680615b0f96c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICrR2a/ggdXpga/dB8dIt8veGJ199Vo8
iNnL/JcFMB2FMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIxNTUwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBKo/+JUiC4iI6oWxujB1F+T4tCsJAFSltlkimwYRTv6xgDmt+D
bYZcsdRtJOIsZcAw7AUMNYssCsgefoX7Ae2PbXtoL4ndSPBkgb14YERDvCMUcXrGrTymk7vruTGQ
mZLkPasjKVLLlLFZgvFqdu02cwIpKhrAZR0C0S1K4KPQlKo7gFwDqmb6q1PcaMjWzaV2lAujKdM0
6Fy5o+QZdP4ZyJey2waRqc4oUxvkHw85wHtXcInrQ88ihnT2FIl1E28kCW8HqbJligey6nrK7+Xx
Tp3LTmeAbq9tmTvDcinc49YAIgSeErSm74ha02zDyPSFR/TuRA7jMTxtXVStXv62
--00000000000052d5680615b0f96c--

