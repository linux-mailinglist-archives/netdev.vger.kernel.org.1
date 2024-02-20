Return-Path: <netdev+bounces-73464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0A85CBAD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A82284449
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A916154BFC;
	Tue, 20 Feb 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FxIj7TI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4468154BEB
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470233; cv=none; b=lRVYXk8v8+omjPXfBgBbyw9FEIn9JZcLtuAkVBCLvIXTQ0Xj9Z7FWgxOFEalGZiZiwvj9TbCjX97aS+XhC+yTkcc4syTR5leU5cP9mOU8hvzbBFUx5oP0DoPXoNkiMLpf6CQ3AuHgyRhO1yQ7mGi7rxJnEwuSz+xVKhVGHmp43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470233; c=relaxed/simple;
	bh=K2ZxQGOKFoVwBigXBNNB0oarH2oloNtEBTIfumQRd6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQWWcKZXCCx4+PCizPUPYQwe85iltSejtDgtVvtbPzRjekBhALnR9IHryHXCt6xWPI/oylolLLywmqsUecnHWaiqPEmPO2Fm0KD3IGNS8KaUHTOunrK5T2CMCY13FzQGN+GUWxRNIj0R6A7irc6y5HM/KqWOrpXtynCoLqjJ8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FxIj7TI5; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso6345040276.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470231; x=1709075031; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fc9vmsbXajGioCEefOFYBTI6iVy3rXK2F9RPnhsUc=;
        b=FxIj7TI5XncFGW2tOKHCvEjcdD7cZHb1wsMdKHKp4VT+LwdKuQ/wiCIhYkSlJhK88e
         XegI9ZPj3Aokzggpf2BHpiyNCKM6qmbUDkgJmLlUys3ishY34GSHA40/kNsxHgjKWdOK
         Mw5H8tKg8gTYkM1SigdMlSXMDgxXDK+/eKKxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470231; x=1709075031;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fc9vmsbXajGioCEefOFYBTI6iVy3rXK2F9RPnhsUc=;
        b=tjsJb+Y0ztTPXceAkkNIOHozL4l60q0KuEJZNPUPvpiaJCyvRh6Cb25foQ3/a2JOFl
         NHNqbNcxTvHu8tqHCjRdv6CofrqJVlx8bclF2oeZYiddayMmGAgyjCG8hQvzUiLqGXap
         XaNuHWtnR9njYVR1JJPjFDq/D8YbEyTIHSbQN0oJnXEBaFhINLWhNu2rVlHBZEL5OK/c
         orxDL41MnRKThyxUbRT5ft7/tNavndNHAiBsaBbuk+0SB51ZnlWGHadAsWuEBX8CHrZJ
         yDO5KIPo6UMizw3OCOLPXDY/pzTmsIiQ06V9d7TU2vOPMkwNLl7lpz/6ChsmK91QwNWS
         AskQ==
X-Gm-Message-State: AOJu0Yx5zk9ExtWzTSKM+bClK3oCvWZ8bkgbq3Q7Ys/0BI283CIFz8xZ
	GiF4i7NTWwI6FDAXk7GUH64HUmCraZwRaXQxEZK2jvB26aIFO+OwaHVsjUxGzw==
X-Google-Smtp-Source: AGHT+IG62W1YD046gVtxD3mo77GAi29pMW0jLBKtMXZtOQtkVT+Aidn4r1ByHLaeRlDBUHpXsYwgJQ==
X-Received: by 2002:a25:8247:0:b0:dcd:38f9:f78 with SMTP id d7-20020a258247000000b00dcd38f90f78mr15547722ybn.29.1708470230689;
        Tue, 20 Feb 2024 15:03:50 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
Subject: [PATCH net-next 05/10] bnxt_en: Add bnxt_get_total_vnics() to calculate number of VNICs
Date: Tue, 20 Feb 2024 15:03:12 -0800
Message-Id: <20240220230317.96341-6-michael.chan@broadcom.com>
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
	boundary="0000000000003ca3ce0611d83959"

--0000000000003ca3ce0611d83959
Content-Transfer-Encoding: 8bit

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>

Refactor the code by adding a new function to calculate the number of
required VNICs.  This is used in multiple places when reserving or
checking resources.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 71ac165dfb52..95af3cd7dba0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7308,13 +7308,22 @@ static void bnxt_check_rss_tbl_no_rmgr(struct bnxt *bp)
 	}
 }
 
+static int bnxt_get_total_vnics(struct bnxt *bp, int rx_rings)
+{
+	if (bp->flags & BNXT_FLAG_RFS) {
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+			return rx_rings + 1;
+	}
+	return 1;
+}
+
 static bool bnxt_need_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	int cp = bnxt_cp_rings_in_use(bp);
 	int nq = bnxt_nq_rings_in_use(bp);
 	int rx = bp->rx_nr_rings, stat;
-	int vnic = 1, grp = rx;
+	int vnic, grp = rx;
 
 	if (hw_resc->resv_tx_rings != bp->tx_nr_rings &&
 	    bp->hwrm_spec_code >= 0x10601)
@@ -7329,9 +7338,9 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 		bnxt_check_rss_tbl_no_rmgr(bp);
 		return false;
 	}
-	if ((bp->flags & BNXT_FLAG_RFS) &&
-	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
-		vnic = rx + 1;
+
+	vnic = bnxt_get_total_vnics(bp, rx);
+
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		rx <<= 1;
 	stat = bnxt_get_func_stat_ctxs(bp);
@@ -7382,13 +7391,13 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.cp = bnxt_nq_rings_in_use(bp);
 	hwr.tx = bp->tx_nr_rings;
 	hwr.rx = bp->rx_nr_rings;
-	hwr.vnic = 1;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr.cp_p5 = hwr.rx + hwr.tx;
-	else if (bp->flags & BNXT_FLAG_RFS)
-		hwr.vnic = hwr.rx + 1;
+
+	hwr.vnic = bnxt_get_total_vnics(bp, hwr.rx);
+
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx <<= 1;
 	hwr.grp = bp->rx_nr_rings;
@@ -13326,10 +13335,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	if (max_tx < hwr.tx)
 		return -ENOMEM;
 
-	hwr.vnic = 1;
-	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5_PLUS)) ==
-	    BNXT_FLAG_RFS)
-		hwr.vnic += rx;
+	hwr.vnic = bnxt_get_total_vnics(bp, rx);
 
 	tx_cp = __bnxt_num_tx_to_cp(bp, hwr.tx, tx_sets, tx_xdp);
 	hwr.cp = sh ? max_t(int, tx_cp, rx) : tx_cp + rx;
-- 
2.30.1


--0000000000003ca3ce0611d83959
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILFob1dq1f+V93ZqPesmsT5UclLazag3
jnRDPBUJ5PIRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAx5DGbOtHZICuj1g+8w4wlDMjq2hrpOO27DSxsNdmJFXe25/AK
8DfM2wWYr8AST+C5tcjTjzqJar0cvKy7oHKaCjbONgdlIAP7LMntPDUf+oNe2YbIAx5ZYLgeZZ4s
ub/2fUQmZ5B7tUy0yU2+oSrMdmOUNqBzqbiNeoK3HcPayv8jWXBSQZlaWrmxKHgh2dYzYyRwFfxF
TpJQqkZF+QwGuFgJxkQctLdPhhXRc7OsQ+PcIcgnbZNqJVsX3r7RWNsDWoyrn81DLi+JAoBNoGqR
bVv9Fh4whRMc/3PLCczmdMULA+e9YgimWCtoKk8z/RB6JADFX1VamD8T8RASjouK
--0000000000003ca3ce0611d83959--

