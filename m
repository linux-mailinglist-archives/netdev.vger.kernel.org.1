Return-Path: <netdev+bounces-73467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E785CBB5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2228439F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66991552F5;
	Tue, 20 Feb 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O6R7Xm+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676F6BB28
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470238; cv=none; b=sYFmGzzKzVoabxt1J9tXrHQ4R5BwudToXIhGPPJ2KpENFYcOE2VURSOOrliJTKsJlETOUY85i8e02poHWL+AVe460wAX3FcfgYnfNcMPeSGPRrXomBHsgPzTg1N8S9Fwa2T7GpoBibNircwicjQm8uNPsmvzJqVR389p8G4y2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470238; c=relaxed/simple;
	bh=uKjXJ8tagpzlWX6TtQyZMesghBJXMI4EsEtJDHc88jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4l6Uo/sQ6JOwCpB/CqB1al/wcj5DiJhol8ggF0EKcUTXRx7/BSFMWOTGJp6El4JBBSYV0FPTQjf0uJ7F+ACPiAX6ePwyvKPeAXITpCw53mUs0qaE8IRbbV3bDUMiYhReOq+UckWUJxFI3MZnAPk4+ilFS5dz9p7GAvZdQVvdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O6R7Xm+M; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7875dc24ecaso204454385a.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470236; x=1709075036; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF1BreLJO6/bZtgwW9u4DWy93rMTd3sKofzO0AJPhXE=;
        b=O6R7Xm+M5fw7zeVimoJAeBn++4GtCwkUiv2EjCnenYDvamXFQzASjZ2fam9D/IUziG
         Yfl5i7prziOdaoM+7TQUGNZNX2rWDR7VVD+72o1qdXzBQG1IW9jYbwRCL1FayJEGOMhG
         9GTfpD+VLwBESHkxax3DxNszpnA8AJ0KMwxGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470236; x=1709075036;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF1BreLJO6/bZtgwW9u4DWy93rMTd3sKofzO0AJPhXE=;
        b=eJMWDopERWIP1TrfzJEomDbu7ii9H6EwPZokSNXdvIK3Z73OAnbeYDcY2s/2hx2ME1
         EbEJkPEk3bq5ZHjZcG5WSAMYYNrko+hk7wecqHjTiGA7x7nd60kQj4AIJwSLnzdstn5Q
         57WG2TUpzegA5C5Mb3huL7b0iePHUZXaJdLBxD9g1ubYYx7ON3AnUJccC28dk71gIR5Z
         L/C9FPs4z645571HSdn+RYF4PaQSGguFH3klU5qEHZvG94kMBMdPyFdgB6oBqd/nzKuX
         CxBv75TE9FTJb9nfw+xSVejXIxqosHH9YCUdJCcsvaB66icanTdYLka4fLIQ7Gu+M1Qp
         nKkw==
X-Gm-Message-State: AOJu0Yx20HGWQnD0O8/sfAB2FMm9gPkju2k80vje1U+l0099KH2PYeBq
	oIt/EYJeuNBD92TzchtNIPyxnWCbNk+eIR2wchcRQVxp7wBTkb5+aCG53knT2w==
X-Google-Smtp-Source: AGHT+IHK9qQG2QxamAzt/ayMqe0gkWyQUekUpbwaZYMvLvJv3dmiT0jfxACoTolV4gELvjOIpRXzRw==
X-Received: by 2002:a37:c447:0:b0:787:1dbf:f703 with SMTP id h7-20020a37c447000000b007871dbff703mr17017994qkm.26.1708470235556;
        Tue, 20 Feb 2024 15:03:55 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:55 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 08/10] bnxt_en: Provision for an additional VNIC for ntuple filters
Date: Tue, 20 Feb 2024 15:03:15 -0800
Message-Id: <20240220230317.96341-9-michael.chan@broadcom.com>
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
	boundary="00000000000089ec5a0611d83906"

--00000000000089ec5a0611d83906
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

On newer chips that support the ring table index method for
ntuple filters, the current scheme of using the same VNIC for
both RSS and ntuple filters will not work in all cases.  An
ntuple filter can only be directed to a destination ring if
that destination ring is also in the RSS indirection table.

To support ntuple filters with any arbitratry RSS indirection
table that may only include a subset of the rings, we need to
use a separate VNIC for ntuple filters.

This patch provisions the additional VNIC.  The next patch will
allocate additional VNIC from firmware and set it up.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 33 +++++++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 +++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8877043febd2..0ca9dd397622 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4211,8 +4211,12 @@ static int bnxt_alloc_vnics(struct bnxt *bp)
 	int num_vnics = 1;
 
 #ifdef CONFIG_RFS_ACCEL
-	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5_PLUS)) == BNXT_FLAG_RFS)
-		num_vnics += bp->rx_nr_rings;
+	if (bp->flags & BNXT_FLAG_RFS) {
+		if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+			num_vnics++;
+		else if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+			num_vnics += bp->rx_nr_rings;
+	}
 #endif
 
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
@@ -7284,9 +7288,13 @@ static int bnxt_get_total_rss_ctxs(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	if (!hwr->grp)
 		return 0;
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		return bnxt_get_nr_rss_ctxs(bp, hwr->grp);
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		int rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
 
+		if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+			rss_ctx *= hwr->vnic;
+		return rss_ctx;
+	}
 	if (BNXT_VF(bp))
 		return BNXT_VF_MAX_RSS_CTX;
 	if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) && bnxt_rfs_supported(bp))
@@ -7312,6 +7320,8 @@ static void bnxt_check_rss_tbl_no_rmgr(struct bnxt *bp)
 static int bnxt_get_total_vnics(struct bnxt *bp, int rx_rings)
 {
 	if (bp->flags & BNXT_FLAG_RFS) {
+		if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+			return 2;
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			return rx_rings + 1;
 	}
@@ -8962,6 +8972,10 @@ static int bnxt_hwrm_cfa_adv_flow_mgnt_qcaps(struct bnxt *bp)
 	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V2_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2;
 
+	if (flags &
+	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V3_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3;
+
 	if (flags &
 	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_EXT_IP_PROTO_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO;
@@ -12358,16 +12372,25 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	int max_vnics, max_rss_ctxs;
 
 	hwr.rss_ctx = 1;
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
+		/* 2 VNICS: default + Ntuple */
+		hwr.vnic = 2;
+		hwr.rss_ctx = bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) *
+			      hwr.vnic;
+		goto check_reserve_vnic;
+	}
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return bnxt_rfs_supported(bp);
 	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
 
 	hwr.vnic = 1 + bp->rx_nr_rings;
+check_reserve_vnic:
 	max_vnics = bnxt_get_max_func_vnics(bp);
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
 
-	if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP))
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
+	    !(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP))
 		hwr.rss_ctx = hwr.vnic;
 
 	if (hwr.vnic > max_vnics || hwr.rss_ctx > max_rss_ctxs) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 328bbf72acaf..e9158407b181 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2328,12 +2328,16 @@ struct bnxt {
 	#define BNXT_FW_CAP_BACKING_STORE_V2		BIT_ULL(36)
 	#define BNXT_FW_CAP_VNIC_TUNNEL_TPA		BIT_ULL(37)
 	#define BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO	BIT_ULL(38)
+	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 
 	u32			fw_dbg_cap;
 
 #define BNXT_NEW_RM(bp)		((bp)->fw_cap & BNXT_FW_CAP_NEW_RM)
 #define BNXT_PTP_USE_RTC(bp)	(!BNXT_MH(bp) && \
 				 ((bp)->fw_cap & BNXT_FW_CAP_PTP_RTC))
+#define BNXT_SUPPORTS_NTUPLE_VNIC(bp)	\
+	(BNXT_PF(bp) && ((bp)->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3))
+
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
 	u16                     hwrm_cmd_kong_seq;
-- 
2.30.1


--00000000000089ec5a0611d83906
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINWylrG0XWyiHPp/7j9ZFjlOB7yn/EiE
dMRfopG8qfTJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB34Spp6/x5HfBPv5hf5m+eW9xqpwP8yfUBGBQBADBAho1GP6eW
yaRF77gaiPuw7mIo1+odIG+YDltJ5cK7asZ0wg0xPkUdwadh3vla8oEnu1PpGS4HwGfYGOq/V/Fu
7Kq6JRDqw+g4PHZtxEz4GlAiaG+6CRgJP0lsGMcBenZ0tE5eZ6HSF/B+hMRfyspBpD4eGWDCIGDj
PvEVCE/M+Le44/mhRSk8c+YveGM7kK1OKHF7Oyx57gB/5uCjE7WNC8C7m+kL3B3uEX5PJMrJb3zI
ep7SjUTxIGnXXZiy7OW6WsALs90WXTGflQsm7ZPJnaP5hEQ9F4BF35FS91n/npWr
--00000000000089ec5a0611d83906--

