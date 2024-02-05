Return-Path: <netdev+bounces-69286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5584A94E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0DD1C24C62
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E31EB45;
	Mon,  5 Feb 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K1Ov03QK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510701EF1E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172337; cv=none; b=rEl2+KQeM+v2WuHZ6Q2PhdrjWHxWhSQG4zgtJwBb9cqmTEh2r3wCzbzgJBG8zCcbH7jaJJHUwSf3g69Cww7LUV7gJ4xt7goetM0rnimUgVX7jKrvSh9GiwX3rRVXUhFT51fzGnEYGiK6pD+pRFGvUiLx6rt0wMBNqC+8gi5FE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172337; c=relaxed/simple;
	bh=545uZ+FhgwB62lqVeu4Z3CBVHEbbIl+2vWKVN1nawoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=midFlVBCFoc6lMJoH2Xh7Cz3cpcZWr4vTdcKsnagcf6R0JTywWkIyjWEabH72YgLuPSRs8KDWoNqRMI/4ECDdXFscTMuzKppbc2QoxeEJntsuBEBqvn+KJXVvjr4DzjmXRn8vHJ7yo+as+Kl3BnnLKGuqdDU8an8c6LMB2KGrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K1Ov03QK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e1226b30ffso2848403a34.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172334; x=1707777134; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aCNTR9du6eGYaSy9KkTjUZ3x3HkhHsVWG3Jpm9WiEV4=;
        b=K1Ov03QKEMMuU2Hk+7UusYGCYISx6t08NsqnN4UTEKhvBqjiYf0hqptKLQGy3LC2nH
         EntKW84NwZbLg/vcdZJXA+w0k3B+TTg+y7eH8ROdMNRvfdKMTiO68a6zY1394luWajRg
         lHrw4784GO8glvi9B+2p/J25jPFL3S6XXDV2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172334; x=1707777134;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCNTR9du6eGYaSy9KkTjUZ3x3HkhHsVWG3Jpm9WiEV4=;
        b=BNowF3Y1aaoJLDfRFEYBbrhdihRI2egmWkpbIOCJfOwgcKra+XQXlEpFIt/01qmsPt
         7oJDZf+lCHl5iH/HGxzTJ7dAytP42wScTBr2axdT59xxaRviFLvmVXJUrrEwhpDbSbFy
         qJG0Ppwl/lMWzOu54mIgPETbtXNM29R2y/8rdwn9ReKEhK8HHayg42BRDPWmB3GHcV3w
         VuA+DajXj6qUVPy+JLh3F7LA/nsXFOr8MCeQS+EPk+PvUGF2zY9fXZm/dACA1FgCuMiP
         3hi+oOwR5w4jG1o23QJAbpAKA4i/ioL8qOTe7aprkFNUBth5Y9ck9a9s+1e819elAVDz
         QuYA==
X-Gm-Message-State: AOJu0Yx2dvDDwbw/7x++1/Dbibf2M+Yu+HgDpfuVvXMi5zaT9GLyvK0U
	A11cXNjsDNJ66ENqtCHLmPSQcqdhOC+MXQWzZ1BI6keIMGAe40J375i4mPKRQZZlFBIBhXZufx4
	=
X-Google-Smtp-Source: AGHT+IEzDubMQ2bp9whsPq4W0kmMOs0sgu1CeEtNfesvJZhr9XgfmrWN7WqpeMg7g9Sd+E9nloxGDQ==
X-Received: by 2002:a05:6871:7503:b0:219:7e6c:fef3 with SMTP id ny3-20020a056871750300b002197e6cfef3mr670874oac.21.1707172334032;
        Mon, 05 Feb 2024 14:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiHW0SxlaR/5tWqsbuVSzXOKMji/Ko7j+VqsV+2Ah05A73a6BacVnn/lR0vRp5X/ydFDxxi5treckcCYKAesp5sItXGqx296hsUS3/LqSy5gkpsk8Uwh1GXsAj0rZCoVMSJLroaVBJOah668E29kXcm8AUvu00PXTla53J8SiI4Zz6f20DZ5ZTJ1PCKgyD3E3Qi64ZDqHb8pqSS7ptJIXgi1I=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:13 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 00/13] bnxt_en: Ntuple and RSS updates
Date: Mon,  5 Feb 2024 14:31:49 -0800
Message-Id: <20240205223202.25341-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009331150610aa0896"

--0000000000009331150610aa0896
Content-Transfer-Encoding: 8bit

This patch series adds more ntuple and RSS features following recent
patches to add support for user configured ntuple filters.  Additional
features include L2 ether filters, partial tuple masks, IP filters
besides TCP/UDP, drop action, saving and re-applying user filters
after driver reset, user configured RSS key, and RSS for IPSEC.

Ajit Khaparde (1):
  bnxt_en: Add RSS support for IPSEC headers

Edwin Peer (1):
  bnxt_en: implement fully specified 5-tuple masks

Michael Chan (3):
  bnxt_en: Use firmware provided maximum filter counts.
  bnxt_en: Add ethtool -N support for ether filters.
  bnxt_en: Support ethtool -n to display ether filters.

Pavan Chebbi (6):
  bnxt_en: Add separate function to delete the filter structure
  bnxt_en: Save user configured filters in a lookup list
  bnxt_en: Retain user configured filters when closing
  bnxt_en: Restore all the user created L2 and ntuple filters
  bnxt_en: Add support for user configured RSS key
  bnxt_en: Invalidate user filters when needed

Vikas Gupta (2):
  bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP
  bnxt_en: Add drop action support for ntuple

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 346 ++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  52 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 389 +++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |   2 +
 4 files changed, 579 insertions(+), 210 deletions(-)

-- 
2.30.1


--0000000000009331150610aa0896
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHO5j/Wd5Qs1pOaI4IqLflVX/aMNLylY
E1SVIkOix3EHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQACPoM0UUeIQJIEIORsKMp2HU6HIvCjT1mdh9FwXlMuHg2wor8k
Fjt1JWKFnXk7yRI8vJsFgGaPrELdvSjJ3lzXb/eKah26c/N5AWqFr945FHSmIli9HcIWYkSiuv1/
WRLI1sgz+adI4BLtysmBj4lI0VQZwDUBse3hxPiY9Xnnlw3tbl3eUZqpd4CvnFjPgOENvC7CJ+ep
+nRTOCb2MT30WMvVM4wvxEuFUX4HB3tMil8z2iomW8Xut3gdRMdTjDOVN06Tdulmq8gXrh2H1GHr
b9D62uRUqyEB9tL53ExgNbtX4BYElTHhcY/5SUKOTPEc4QzsJrocW7IEEwvkTyGK
--0000000000009331150610aa0896--

