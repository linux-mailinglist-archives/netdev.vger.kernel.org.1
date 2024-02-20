Return-Path: <netdev+bounces-73461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30A85CBAA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E22F284444
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4F15444E;
	Tue, 20 Feb 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZjI+5gVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022146BB28
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470228; cv=none; b=OBOPbtVqjazRQhfIul4Tp+YyAEeUPq94MXr8ksjV8lxC0Xfh0OCi7NDZ6jSVah7hrkgxEBIpxLg3N7vlY6kIfFpP3fSF2TRXOxNOSHXY61yjoKkNsBAJGdQmQjm6/pxdZA+n91mc0LKe0xZqiXYf9mGtVAZdjzuHcL0AsYhTLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470228; c=relaxed/simple;
	bh=6GOt6H7SVTo94hFbm5zwOTF6m/HL36b0p4tigFqlCFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhjRUelTQM6s6Rm66xo9IPpBsUkor6NUELSyZYL+xiIsm6REXrFf02d/AM5W5za8OeDGNyX5unkPdKEpfKHczJYUPUhYMZ9u9jUr4zVuWpbXp/0I4g0cmKeCHi8FjOVTbOCiUKpA6IPfkqYwfaCl97qWWmJsBDss0WD1umAOX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZjI+5gVz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787225a2addso291262685a.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470226; x=1709075026; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=boRa4w80Rwfxs/xjAoWVdjWsR4PWhA/YHrv6U+4Dt/0=;
        b=ZjI+5gVzrPLfnTPy0M2GOfUs5r5xmS2T/lgeKVcRg+5SJWlMs2wG7KbRdokZYnzQys
         dSWN4shf1q73m2NrYmGijdPRaTITNAQvXS51fZrzd44csQFuY2QN6nOASQrrKQp1Mx4N
         zL3jwluvJOa3fvIkHtt54J4M3wD6At6kSd3N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470226; x=1709075026;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boRa4w80Rwfxs/xjAoWVdjWsR4PWhA/YHrv6U+4Dt/0=;
        b=lF0WosL6buy+sc6dZoJoDI+A6pZm9fQEV0v78f8ujP7BhHd+gMZTbEfAwSQ6bhvqLD
         lmX594NB6tCb6O96rfbpKG5UYZjWjVpUeM3nN1SyXGgg++l3Hm0JQ7urW1OU2t4EYY8V
         1EBHL1jH5ChFoXJqTXCidWiIYjhtA4J9WvawzBjSREbYvtsiaWuCHX/5AKofw3qsGrbx
         n8YrWL0DXBsuB49cU5sCNeJsVTwptpujHw7qCKtwXV8aevkk1Vqm00HEDiTD/XwqAR5n
         IRJ91o2GMB/t46OWJv9oG9YsO81Idf/ap14Q3eCHyX6Kyf4cQ16DRYs4K9gNnK2lrv4I
         5zHg==
X-Gm-Message-State: AOJu0YwBb9oc2Kd/PRVmiZAY4RE7A51IM8k9wvENsMfOUHJL3qoNW5IZ
	3PiKGq4ndVD98p6TLeuSQw3XwKXKWWj+cHxneDBTBtT49+HwI6jIfma92AEuyovaL8GJiebUDOc
	=
X-Google-Smtp-Source: AGHT+IHPznZts7lvEiYvPYCCfkU6Yq+dEL7zaVA1+y+dRCU8pKyW2YIk2rcQjzFfz3N51+VGv/6eCA==
X-Received: by 2002:a05:620a:22a3:b0:787:80f1:3a91 with SMTP id p3-20020a05620a22a300b0078780f13a91mr1505710qkh.61.1708470225522;
        Tue, 20 Feb 2024 15:03:45 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:45 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 02/10] bnxt_en: Explicitly specify P5 completion rings to reserve
Date: Tue, 20 Feb 2024 15:03:09 -0800
Message-Id: <20240220230317.96341-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240220230317.96341-1-michael.chan@broadcom.com>
References: <20240220230317.96341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f03c3c0611d838db"

--000000000000f03c3c0611d838db
Content-Transfer-Encoding: 8bit

The current code assumes that every RX ring group and every TX ring
requires a completion ring on P5_PLUS chips.  Now that we have the
bnxt_hw_rings structure, add the cp_p5 field so that it can
be explicitly specified.  This makes the logic more clear.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4a30eff0791b..4f3d2b1c9989 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7114,7 +7114,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		enables |= hwr->stat ? FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			enables |= hwr->cp ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
-			enables |= hwr->tx + hwr->grp ?
+			enables |= hwr->cp_p5 ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
 			enables |= hwr->rx ?
 				   FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
@@ -7131,7 +7131,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
 
-			req->num_cmpl_rings = cpu_to_le16(hwr->tx + hwr->grp);
+			req->num_cmpl_rings = cpu_to_le16(hwr->cp_p5);
 			req->num_msix = cpu_to_le16(hwr->cp);
 			req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 		} else {
@@ -7164,7 +7164,7 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 			     FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 	enables |= hwr->stat ? FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		enables |= hwr->tx + hwr->grp ?
+		enables |= hwr->cp_p5 ?
 			   FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
 	} else {
 		enables |= hwr->cp ? FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
@@ -7180,7 +7180,7 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
 
-		req->num_cmpl_rings = cpu_to_le16(hwr->tx + hwr->grp);
+		req->num_cmpl_rings = cpu_to_le16(hwr->cp_p5);
 		req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 	} else {
 		req->num_cmpl_rings = cpu_to_le16(hwr->cp);
@@ -7350,6 +7350,8 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	if (BNXT_NEW_RM(bp)) {
 		hwr->rx = hw_resc->resv_rx_rings;
 		hwr->cp = hw_resc->resv_irqs;
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+			hwr->cp_p5 = hw_resc->resv_cp_rings;
 		hwr->grp = hw_resc->resv_hw_ring_grps;
 		hwr->vnic = hw_resc->resv_vnics;
 		hwr->stat = hw_resc->resv_stat_ctxs;
@@ -7359,7 +7361,7 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
-	       hwr->stat;
+	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
 static int __bnxt_reserve_rings(struct bnxt *bp)
@@ -7378,8 +7380,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.vnic = 1;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
-	if ((bp->flags & BNXT_FLAG_RFS) &&
-	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		hwr.cp_p5 = hwr.rx + hwr.tx;
+	else if (bp->flags & BNXT_FLAG_RFS)
 		hwr.vnic = hwr.rx + 1;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx <<= 1;
@@ -13326,6 +13329,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.cp += bnxt_get_ulp_msix_num(bp);
 		hwr.stat += bnxt_get_ulp_stat_ctxs(bp);
 	}
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		hwr.cp_p5 = hwr.tx + rx;
 	return bnxt_hwrm_check_rings(bp, &hwr);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bb3b31f8d02f..681a579afcc2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1259,6 +1259,7 @@ struct bnxt_hw_rings {
 	int rx;
 	int grp;
 	int cp;
+	int cp_p5;
 	int stat;
 	int vnic;
 };
-- 
2.30.1


--000000000000f03c3c0611d838db
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF4B1apS8s2EuIDZkj1tmilPKkGot7G5
56x4Lo/RPlu4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCoGJdvTbtrciJWtzaqn0d4GAhPIPaW2W+7lFbvKSrubcW6HtyN
+GdpmdVy61r0muXAYBeYHvgmbm4eD4LIi6qX3uM61+EESISkKRjgWAIWcg57QKgoMqIcXMHCj2z3
fCVUWbZdz8XgriUswSh5/NZ51EVps9jGKAgyj2kEsP4x8xG4LhFTmi6jQ+jljZPUMI8894mYrVT4
NQOA3q6ku+n4SXU6yui/AtknF9Y3ikhAYK7zPC2Jue3bRhKwIZy+QJER8+qdVpc14WT5mXqnlyGw
0cM8N1fx5UK+UDQwuo/HsFx/6zBY6logxPV3NNV+yE6Ug6NYQZfow6x1E0eGEGuA
--000000000000f03c3c0611d838db--

