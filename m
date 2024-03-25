Return-Path: <netdev+bounces-81834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419488B41F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1999B304227
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9A84A26;
	Mon, 25 Mar 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gZQnJNmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E483CBC
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405784; cv=none; b=GFtiF48F0U2jGqSmYa4WNIIkagiMvs9yPfFam56S3H2HOV6WXczEZ7Ymikaz7tpy1KbSvyAAEsicJV036/dFUs6DQ34sjYumxqOZ2NLDF+EohBlF0dLgk/QPApNDdo6Lm7cnlCBOtumkduWgYi1CG3HuypMVuTlOxE7jsDN6HVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405784; c=relaxed/simple;
	bh=MMnBN1i9dwV7ghasfsHxDG4Y0phwAgnoqJctEeSBKY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMoCCLJA9aJ1cobc0E7bstnQj0Cxe5p4kBGIEjRk7Bl7uiIjhWMY3yB6FraEzjIlGrNAR3tqW1fMOinzfgVx71CM6nWwjUCvJuk/Td8hVnMBXMIa+OV+g6jYuRxZNosxU5HyA/0QS3tjPexqpGsDizqGZ8s7Ib24coAc6Dm+/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gZQnJNmR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d0262036afso187743439f.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405781; x=1712010581; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=70X2p8/CCC99cQg9ybF1aYmssRhx7iuSQY4KOhXgDx0=;
        b=gZQnJNmRGY9cMkcx/PePUY2XOzmMWeyhGQ8yDdl5+ouRWblobE4Rf73ISkPSp2CCVq
         EN44ZYqw9aTMTG3El0HfpiKzPss3azXqC8Y2fkv4a7+i0Sd3QKwGbuBDWUo61wJYAZGu
         j3WVr2eImpV8wlViI7YGAoIVo4dsnkFBpQi+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405781; x=1712010581;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70X2p8/CCC99cQg9ybF1aYmssRhx7iuSQY4KOhXgDx0=;
        b=eiJEW22UWN6XiZWdTz5LAIucgahWCNIZ2wNcZFdcdCsIIwF8HotOA8MTP6PmO4++IR
         qjX7yxVBIcDdwXS39m/RqxZDJvgibyJoaS108nADvatrknlj4A6lGttkg2MBJsQJlh1Q
         ECHBr4yuoAuI7QtcrE3+nATG7/Tpf00DuMoSvQV+nrReXleUIQ4MBmQnNcqbsau+L3q7
         6a71sYxsoCpYwyvJCGLpHmePvgRbVbDsewBx6kZ4+F8mt3/fa+xuwsUYMQBJ6wfZ+tJ2
         1ZGNtXTHhr1JxZnndQz1pl50/WhQ60fYpIR5RjD5ki8P2ABQT7SLfdwjOt5CGYf+QmG1
         CMPg==
X-Gm-Message-State: AOJu0YyWsvNA2DqFVPJq7kdG6KybWGWJWbEZFy71veZKBav9Nbuty43O
	OJLsNnkGn7BgMjG4poHPuu0s6szsTBI1bo58aKsEJLTQYym0cP2wevsJCA23zQ==
X-Google-Smtp-Source: AGHT+IH1/DI5yogEHYPSalGhoJBwqY+mCax2aLoSXLfBuKqpnAhl+N04xTnc3EGoPPXBzkysge5GTg==
X-Received: by 2002:a92:130b:0:b0:366:a611:f7c0 with SMTP id 11-20020a92130b000000b00366a611f7c0mr8919344ilt.0.1711405780930;
        Mon, 25 Mar 2024 15:29:40 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:39 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 07/12] bnxt_en: Simplify bnxt_rfs_capable()
Date: Mon, 25 Mar 2024 15:28:57 -0700
Message-Id: <20240325222902.220712-8-michael.chan@broadcom.com>
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
	boundary="000000000000b23d2d061483b52f"

--000000000000b23d2d061483b52f
Content-Transfer-Encoding: 8bit

bnxt_rfs_capable() determines the number of VNICs and RSS_CTXs
required to support aRFS and then reserves the resources.  We already
have functions bnxt_get_total_vnics() and bnxt_get_total_rss_ctxs()
to do that.  Simplify the code by calling these functions.  It is
also more correct to do the resource reservation after
bnxt_can_reserve_rings() returns true.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 80ccb5a54dae..e968684ccb1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12479,28 +12479,19 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	struct bnxt_hw_rings hwr = {0};
 	int max_vnics, max_rss_ctxs;
 
-	hwr.rss_ctx = 1;
-	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
-		/* 2 VNICS: default + Ntuple */
-		hwr.vnic = 2;
-		hwr.rss_ctx = bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) *
-			      hwr.vnic;
-		goto check_reserve_vnic;
-	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
+	    !BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		return bnxt_rfs_supported(bp);
+
 	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
 
-	hwr.vnic = 1 + bp->rx_nr_rings;
-check_reserve_vnic:
+	hwr.grp = bp->rx_nr_rings;
+	hwr.vnic = bnxt_get_total_vnics(bp, bp->rx_nr_rings);
+	hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	max_vnics = bnxt_get_max_func_vnics(bp);
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
-	    !(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP))
-		hwr.rss_ctx = hwr.vnic;
-
 	if (hwr.vnic > max_vnics || hwr.rss_ctx > max_rss_ctxs) {
 		if (bp->rx_nr_rings > 1)
 			netdev_warn(bp->dev,
-- 
2.30.1


--000000000000b23d2d061483b52f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOsJKZgoNmxA30gNIFXBTAhrGP8/Kawy
P5Yr5drE47DCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjk0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAvYTvY+wlCt+hlrHI6yDLzscgee69LZG6phP0DlPTC+Hd4nUHW
aCFpkrfWguRT/utI6jWchMsSvQbLTnUpX2Imwcr8hLKFD4i7ew+TMhKS4RXAH8T6k/GW5omWqEBF
Qu/dpxiN2D4sTMEfuQyFIGIlBFyXoz1euDZs4Liw7rHdmxcezPeoZ+f0uUGyYLsKfD600k0RQQrx
rJ6bsUj+LfnziafxUYOkxctKwbY64PxxM6Ib7Rn9KvmP7MEYBa/fJPBDv44/OQ5ukDxVRx+ZoFeO
iGRJapptkMKJcGKh6ZG8TudcCgeT8WlQd5QlarY/bhVqyQiqBCxQGjwSrAjinHE0
--000000000000b23d2d061483b52f--

