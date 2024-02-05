Return-Path: <netdev+bounces-69297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C9E84A959
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9E29304F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230428E31;
	Mon,  5 Feb 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QqJ0GTQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D11DA58
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172355; cv=none; b=eXHZySTTvhS+7d0ivBXQDIAFF+h0Mt0W/RVdkmlNh/CvrIb0HxmeZPooBXFEy7wZrAnHdSNeH73YoFgei+C15IJ3+2JS2d/pQALdbgzYKc53BKeynfd/h/83uWfgFVTRM7Q7O6E+SCv2Le95xnY9+fnPoBIut6efKVj4sYgDmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172355; c=relaxed/simple;
	bh=MAXuPCl2sFn1NUP0oXPJ8AAyQ7T0v1qHVHSFmGeCBPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZiY1WAKd6+T67yn8FAAo4fRZ0dNdXsLQ0g65laCKCcjAlSR1g1Mp3JEkjtgLuLri5q23VgCxeUaydo7PVIr99HRSbwg+E0G9QvnrmiOYmds5zJfY80hNUeZYUS9KEK5JR0CSyO+CQjKiZgB7eqhuC9dQqPDoVUbyaLeLUXraXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QqJ0GTQb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a9c21f9ecso29327811cf.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172353; x=1707777153; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d72hnexSFBoKXOTEfV0exTKLLP0xzu0ruuF+i1GK1W0=;
        b=QqJ0GTQbVzocoQX031hPVOMvhMjcpMPbkI5qcBhderuWmRw/5HPSlMSBvTBDlMjtfn
         hvjnhohm2cLYFqmG/9P/M+72sYb5MEFF97XNMv6m4hrlFRjyB0wspdcHFlh6O4anR/Js
         NS1XfYaCtSxd/umlpd85s+06c9Ye4GSDDja2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172353; x=1707777153;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d72hnexSFBoKXOTEfV0exTKLLP0xzu0ruuF+i1GK1W0=;
        b=Due+x0PR9HHQdmUbRJJ31eqGys1LovYKcWFRbeFOYLxTCnoCo/H3TNkSLcfbvg8jdU
         xxQ8lpOMGUtri6zHPG1+CcLECcVyeqtNsJPzLDh3AsUrO4BntEcAn0LsHdK6Dx8UCOcA
         jnhiY21bsP+5YzYWeJvwT9Rg0IwQdRzSsQozVN+mn65zI0KNdYMHMdAIuK/42U0OQbYM
         k+amO9V5wpwBlZ0E91wSxypzaUTYfETK1Rt/Qh8dzsOzno0FMs78GE2w/dX7DI+b/QuH
         TtP8ToewOKBq1aO9ShzbTyL3mw6P/E9827ruBkRiF77i6Z1WGDdaZoMtKmmYrIG8fRQx
         Jjnw==
X-Gm-Message-State: AOJu0YyOqanBLatvErltRODTx9caVj5D3GIVSnBijr0zT4iWnPJBUjjl
	ImrGirSKj1JJ2i3a4zZVt5Jl/RsM33PZX9aTIvCzUwx26CGzNvmFHTZLGJSv0w==
X-Google-Smtp-Source: AGHT+IFO8Lu0MA9f6cAnJHMx+TNgd/6YuXfQY45FHsJg73LK+9RNVNKOo1wbPcy61Hfzq3lkhFIFdQ==
X-Received: by 2002:ac8:59cf:0:b0:42b:fd4a:e13d with SMTP id f15-20020ac859cf000000b0042bfd4ae13dmr649576qtf.55.1707172352837;
        Mon, 05 Feb 2024 14:32:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQURLqNjfVDGaK6LO40iXhl6ki1L2N+5dbjxhnCBs2ZbUm+k+XCISduegLOvXQGY2Sm/XvET9vGoe+iSvqwkug9Gh1hSzAS4WxLkPo5rvl8uTyk0QduYliQrAoVosrDDrES1z0p/fy1E7FUIjlXKNFFAgWxBqJrfTOffXdkxO3fKV8gxDlryqANEBZ6K1qCNY05z+AW1KxPhRMmzo+BDh7bcI=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:32 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 11/13] bnxt_en: Add support for user configured RSS key
Date: Mon,  5 Feb 2024 14:32:00 -0800
Message-Id: <20240205223202.25341-12-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000af8b370610aa0950"

--000000000000af8b370610aa0950
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Store the user configured or generated Toeplitz key in
bp->rss_hash_key.  The key stays constant across ifdown/ifup
unless updated by the user.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 18 ++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h      |  4 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  6 ++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a6e2b65c45ce..27941ade894a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4246,9 +4246,23 @@ static void bnxt_init_vnics(struct bnxt *bp)
 				u8 *key = (void *)vnic->rss_hash_key;
 				int k;
 
+				if (!bp->rss_hash_key_valid &&
+				    !bp->rss_hash_key_updated) {
+					get_random_bytes(bp->rss_hash_key,
+							 HW_HASH_KEY_SIZE);
+					bp->rss_hash_key_updated = true;
+				}
+
+				memcpy(vnic->rss_hash_key, bp->rss_hash_key,
+				       HW_HASH_KEY_SIZE);
+
+				if (!bp->rss_hash_key_updated)
+					continue;
+
+				bp->rss_hash_key_updated = false;
+				bp->rss_hash_key_valid = true;
+
 				bp->toeplitz_prefix = 0;
-				get_random_bytes(vnic->rss_hash_key,
-					      HW_HASH_KEY_SIZE);
 				for (k = 0; k < 8; k++) {
 					bp->toeplitz_prefix <<= 8;
 					bp->toeplitz_prefix |= key[k];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a6b6db1546cc..28091889615b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2222,6 +2222,10 @@ struct bnxt {
 #define BNXT_RSS_CAP_NEW_RSS_CAP		BIT(2)
 #define BNXT_RSS_CAP_RSS_TCAM			BIT(3)
 
+	u8			rss_hash_key[HW_HASH_KEY_SIZE];
+	u8			rss_hash_key_valid:1;
+	u8			rss_hash_key_updated:1;
+
 	u16			max_mtu;
 	u8			max_tc;
 	u8			max_lltc;	/* lossless TCs */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6721c4a88453..9b5382412db3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1755,8 +1755,10 @@ static int bnxt_set_rxfh(struct net_device *dev,
 	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->key)
-		return -EOPNOTSUPP;
+	if (rxfh->key) {
+		memcpy(bp->rss_hash_key, rxfh->key, HW_HASH_KEY_SIZE);
+		bp->rss_hash_key_updated = true;
+	}
 
 	if (rxfh->indir) {
 		u32 i, pad, tbl_size = bnxt_get_rxfh_indir_size(dev);
-- 
2.30.1


--000000000000af8b370610aa0950
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO5PlNN28PjidX/E1lcyy3ibkfdXSofk
9FOhEbwlrRdtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCEl5tw0CQo2YDn9fjZmPB7O7WjWA0j8meql9SLMy1NEXWdxdra
6AbZtTxdpYwHEuZDtaKJWaiH36t7jGmXEu12l6ya8tQ4YkfQR2vjVJobIyyG75lqhig8Kkh/Qr9C
RTEwHFPdqAahgimNPFvdeswm4sVOMfE3yC672Tz8xc+CTTcx0JRiNXACPnUF+NUBkWWmAY+MgZVC
kb9hdKEEt72uGN/v2Ru0OjUmvcvmft9nq6h3bYilH2W/EeMAuVcZ6zSYCFLXHd0zpr9ibnYpXYgp
6ssbA175jHDZwdz410lXYLPVye8keUx91u2e70kKNjr65eI2r4HmbYInrMvLMDXk
--000000000000af8b370610aa0950--

