Return-Path: <netdev+bounces-81833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F988B41E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26943011AA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3B82860;
	Mon, 25 Mar 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BsmdYpre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7A83A09
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405782; cv=none; b=ZNg/o8u6MvLSVuf7ZUB6Y4GgjqeV8REz/ZZmgXoiStlTmhJoMsHnjuseNbH+Of5P5OW/XSeMqJCy5CRiofeExcCOhGQ2tQsBXWMLMh5Zf067c+xuuSQlXbHu63y8ogyPz2jHPiD7Qei0FjhQiKfDjLg3gY9S1oQF+YLir6KZmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405782; c=relaxed/simple;
	bh=Kj3TTwWhKn8PZne3JcLHmh68UWZYpuM9034ZghvE54w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTTzVSJLgkRkQOt+ecfSb84It4iZ0DI+/Dq4YLgMszltXZwKGi9XIWiSGE9Zm+dIm7/3jGgid6iTWa87rEJi1/ZVtlJbjXrlXs/4+agIALV5YXsFHl0ShNfkRO2w7Jawdfm12Zco+rgbrSp3c20Rw8/WtOFvwKtEtF11Ww0H+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BsmdYpre; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c3ae8fa863so3054118b6e.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405779; x=1712010579; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnNdavuJnk9/eptSfqqgadVHQidSPOoSOWrbe4X4NVU=;
        b=BsmdYpree6RQUCNFHv9oppj5l4T7GDoX3H4NrBwlRHjeALWZrPgPADpLQVTlHUBShD
         44KiaRT5Ym984ydt9yz29AesYmLN0BlVsXsw4BYtlyqcx2ZUW2Hf57a1kJSpSAM88N0X
         +Oqn4euPjmn9ZA9b0J4Se2j6f8mJvsmlfVZbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405779; x=1712010579;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnNdavuJnk9/eptSfqqgadVHQidSPOoSOWrbe4X4NVU=;
        b=stHiNvVFB+y9aVM5/yi4oVGFInZbadyJIh/ywA7Mo8ybJDM1k+pCjmLKG97w9sHA4x
         ZSJknCGfMteK6i2tOsEMdVIcHh2PzsgKbWTNCrHvC0WdirdZp2P5ANyb413igulIjlzg
         ROv19pStBfCCn+eETKOziVNvoxe4TlofjmSRNig4bqXDXV/fQH2O4EpAn5e38DIqFiuT
         vjqVCuE0Dypzj4S1ygJOzd/FbMSEtpVTfHgRFbSZTRWDD6hMTWogbTEyQtYIUbnbK2rX
         csLtvNH8I4EvM8Tba9QsEy52q96O8o1V7xJo3qPaawq9VY9H8gGpHGCvk1l2qe260HA/
         3BwA==
X-Gm-Message-State: AOJu0YxrP+G38gObNb0DJX7adP9FTpErWjU0tScZLFQ+vch4oAya38uG
	ylVR9h+d+aHdT3euuUfbSJm0pMP8YRGHOho9HC/VVg6Ym+9fXunsv/X53LsRPA==
X-Google-Smtp-Source: AGHT+IFz1SnsqqRorRmvcSVQY1hgv8WFn4YaIDbocw0DF1lUD2E22OuH75+rFWIsnDZBjVwrwCgCrw==
X-Received: by 2002:a05:6358:3996:b0:17b:f637:7bb with SMTP id b22-20020a056358399600b0017bf63707bbmr8862071rwe.30.1711405779108;
        Mon, 25 Mar 2024 15:29:39 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 06/12] bnxt_en: Refactor RSS indir alloc/set functions
Date: Mon, 25 Mar 2024 15:28:56 -0700
Message-Id: <20240325222902.220712-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000091fa2e061483b513"

--00000000000091fa2e061483b513
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

We will need to dynamically allocate and change indirection tables
for additional RSS contexts.  Add the rss_ctx pointer parameter to
bnxt_alloc_rss_indir_tbl() and bnxt_set_dflt_rss_indir_tbl().
Existing usage will always pass rss_ctx as NULL which means the
default RSS context.

When supporting additional RSS contexts in subsequent patches, we'll
pass the valid rss_ctx to these 2 functions.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0ede267904ad..80ccb5a54dae 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6026,9 +6026,10 @@ static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 		return bnxt_cp_ring_from_grp(bp, &txr->tx_ring_struct);
 }
 
-static int bnxt_alloc_rss_indir_tbl(struct bnxt *bp)
+int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 {
 	int entries;
+	u16 *tbl;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		entries = BNXT_MAX_RSS_TABLE_ENTRIES_P5;
@@ -6036,16 +6037,22 @@ static int bnxt_alloc_rss_indir_tbl(struct bnxt *bp)
 		entries = HW_HASH_INDEX_SIZE;
 
 	bp->rss_indir_tbl_entries = entries;
-	bp->rss_indir_tbl = kmalloc_array(entries, sizeof(*bp->rss_indir_tbl),
-					  GFP_KERNEL);
-	if (!bp->rss_indir_tbl)
+	tbl = kmalloc_array(entries, sizeof(*bp->rss_indir_tbl), GFP_KERNEL);
+	if (!tbl)
 		return -ENOMEM;
+
+	if (rss_ctx)
+		rss_ctx->rss_indir_tbl = tbl;
+	else
+		bp->rss_indir_tbl = tbl;
+
 	return 0;
 }
 
-static void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp)
+void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
 {
 	u16 max_rings, max_entries, pad, i;
+	u16 *rss_indir_tbl;
 
 	if (!bp->rx_nr_rings)
 		return;
@@ -6056,13 +6063,17 @@ static void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp)
 		max_rings = bp->rx_nr_rings;
 
 	max_entries = bnxt_get_rxfh_indir_size(bp->dev);
+	if (rss_ctx)
+		rss_indir_tbl = &rss_ctx->rss_indir_tbl[0];
+	else
+		rss_indir_tbl = &bp->rss_indir_tbl[0];
 
 	for (i = 0; i < max_entries; i++)
-		bp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, max_rings);
+		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, max_rings);
 
 	pad = bp->rss_indir_tbl_entries - max_entries;
 	if (pad)
-		memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u16));
+		memset(&rss_indir_tbl[i], 0, pad * sizeof(u16));
 }
 
 static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
@@ -7341,7 +7352,7 @@ static void bnxt_check_rss_tbl_no_rmgr(struct bnxt *bp)
 	if (hw_resc->resv_rx_rings != bp->rx_nr_rings) {
 		hw_resc->resv_rx_rings = bp->rx_nr_rings;
 		if (!netif_is_rxfh_configured(bp->dev))
-			bnxt_set_dflt_rss_indir_tbl(bp);
+			bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 	}
 }
 
@@ -7497,7 +7508,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		return -ENOMEM;
 
 	if (!netif_is_rxfh_configured(bp->dev))
-		bnxt_set_dflt_rss_indir_tbl(bp);
+		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
 	return rc;
 }
@@ -15119,7 +15130,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			bp->flags |= BNXT_FLAG_CHIP_P7;
 	}
 
-	rc = bnxt_alloc_rss_indir_tbl(bp);
+	rc = bnxt_alloc_rss_indir_tbl(bp, NULL);
 	if (rc)
 		goto init_err_pci_clean;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4d3104c26cfa..181758f6892a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2715,6 +2715,8 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 				      struct bnxt_ntuple_filter *fltr);
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
+int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
+void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
-- 
2.30.1


--00000000000091fa2e061483b513
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKp5FMqs5B5SXc7Z2M2tO/fhNiWZSceB
g7OEUHPsPDJ1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjkzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBvYjyqgj2Vsqun/OsxfixqVg/GZNexPH4qaN94SWd6LOk2AXdl
wcWs9NGJO+a+FLZP52TeGugupgTMCpqEkHtY5L045z2JW5ZnpmxvKNN7ToVx6lKmCkRpZNROXGZu
mhUIPi3rEMKAEgMAEIlcGXbGX01V43EX3TfyX6h/rBr9Fju8qR+rQq9cDQkZdq6qyET+BmOxVbir
D4lWl/irPoCfASAZguMrAHx8/Dl1MD+0ddlSeVTxggl1Pkx95uckfJJCnYKXs9sJWmtw4YuNBa5E
N8rgctHjeEtAH+poOhBkUKWTuRYB6zUpjxc8v+yg/OFFnF8oO7ehKlT8SXxPekxq
--00000000000091fa2e061483b513--

