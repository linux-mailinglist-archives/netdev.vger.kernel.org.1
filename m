Return-Path: <netdev+bounces-245041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE2CC61A4
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 06:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571243093F8B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2752D593E;
	Wed, 17 Dec 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DT4ORhZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A682D5C67
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949957; cv=none; b=UOAq5lD8pjnHG/JikeBzJKiJjbE2zT9qBxAtI8a9SI0B/xhgrjACslBlAxJN2fBJBjJmx4L8udpLpEwHWF9xOSqt3YbqZYjyxg3yGBbhNmwQ9C7WUv/y1hXI1LirLCxshd5BjYFu/qh6U5C8tyBrysUr01x7q90CfydCzTttMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949957; c=relaxed/simple;
	bh=zH8txaQ0XSPjp+a8hEHVgLfbYoAVeSW0Vz9enyJPQkw=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=irlJQpYlQwZzsBNx8QqsIDm98w0aD1PEOg0OI3tF9PlB9xSIqoJUssVnB21VWUNJmdNOLn6JyMPs278vJrdlCrLuy0rLZL4ovRVd+EulsDxgcJ4MWEfDwpotzlPs0sWn0a5GQD7xlM7r+gszTgGhOx5iifw7jBbRsHAxEzh3al0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DT4ORhZT; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3901013b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 21:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949956; x=1766554756;
        h=to:subject:message-id:date:thread-index:mime-version:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH8txaQ0XSPjp+a8hEHVgLfbYoAVeSW0Vz9enyJPQkw=;
        b=PAe56rXQeEwQ2GUAVAXF42cFHQOCtdgHeaj5FVQy/jySfC6Cc8RiLmtlQYRKdCzgcA
         cRLZNV2W7SeOuHbosaONgREN/iW11sTE78F2a5IAOXEer3bjI2C6oQMD3ShLSgRsW05y
         UZEzYThPktXFwTQmvn5pEzrJHCgT1sCLaDU4dxyBlBIx/RHjvMqVsw6Ig4hOyTr0EsXM
         k0B6M9AP7AstsD/31ZYk39cI1OH18zRB9NrsJiiMqZeFzGO38aJlu+5h3x/J1SbCTl+o
         li83DyKAEJejsMt2mk+dNTPuWn4wcHWCtxautzm+UTc592SRoYu/iJ3PfLqq/8wktGMy
         PC1A==
X-Gm-Message-State: AOJu0Yyd4TbJCuIbVh2UTqgwS60KEJuxVE5KJaSE0eTl6odiAmG0yjxc
	7JYUyUz6igrKKqwZPAx4xEQmtUEuMJ+emTOQmehmGxgQDIfDK22q2fy+Dsgx+cdirF6qPF7ZB7B
	2KyioeHVj/6sddnUjy8DEzGbeufLwj77UgpJHAUzvhF7VGam9s3gc5PVigrd+Y0NJKSl+2oDhOz
	VULca7GXUQthhZhAtRGfws5gQPvDOGvpc+gHpJks4ZjwUeLfxiTrJRQrsT0MzypkjOIHMH82TSC
	LAnw06kRJ7A91I=
X-Gm-Gg: AY/fxX5gnlIt2sq088woVPJGqbEoI61yjRcSJV0vs2bh6d1JuempaJ9zVnM4w7eJxWL
	kYOsSBoo6UR8uyEv+PZDim7Id9Ecc0GrppJqef1LtEAG998kUHYFR9CGZrIjMlZpxhb9MAzap5v
	dLmgy4HRLNBCBhUcEykD3KzOKCxG3asrRV+xXgTur+xEN/qgunOpN+S9zzfRBs7nf8bNR+nwz+Q
	AeBM4EtYmVvMDwsFs9CTZE0+ayQumCY1ZwvSURhQ1cFCRNvuhJ6JkQd1SOod24U6s4gZ8pv13s0
	++B34qBCFsQq0lEZ9w3/v+Cl+pvoe0C5I3bPwM0W1frsF/N2qG0xAWN4lyrZO9iZA7tsUKkmEDE
	Sy/GG//mVHSRfGRSfP5iT+brFqt/RL0JV6cf07RTim9STC/eaM2F8O6ZQx130sN1MRA3nHGu1Dg
	3tiP5MfKh/PDkytmXeyAl8hNr+z4XYBZGHtzpIXRZn00cP/mqo
X-Google-Smtp-Source: AGHT+IGUZ4xNi1rfSU7+rO52hQbB3QrjhPSeWU0+5ekVb5jUCWmnCt3Z2UhRH/YIA+6uR76XUgJpOQY1NIy3
X-Received: by 2002:a05:6a00:94f4:b0:7f1:14a8:1cd8 with SMTP id d2e1a72fcca58-7f6693a66b0mr16397678b3a.36.1765949955547;
        Tue, 16 Dec 2025 21:39:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7fcbaf28651sm212340b3a.8.2025.12.16.21.39.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Dec 2025 21:39:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6446ee26635so8793818d50.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 21:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765949954; x=1766554754; darn=vger.kernel.org;
        h=to:subject:message-id:date:thread-index:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zH8txaQ0XSPjp+a8hEHVgLfbYoAVeSW0Vz9enyJPQkw=;
        b=DT4ORhZTFp40ybkBuwDcEg5MqzD+iNob7DCV2/R5XdZN/XWnZcdmn0Gav2nRqqP9Kr
         eYsbTXVUJXPywAD5cGeiOBy5PwT5J9GTkElYPoukcTo1pcichUxl3TXpVt0IM/WQWmkQ
         /wT2wPh89/bBZG9SGru+PgvrILQqF6gcmeZuQ=
X-Received: by 2002:a05:690e:16a0:b0:640:fc53:3b6d with SMTP id 956f58d0204a3-6455566348cmr12386279d50.64.1765949954275;
        Tue, 16 Dec 2025 21:39:14 -0800 (PST)
X-Received: by 2002:a05:690e:16a0:b0:640:fc53:3b6d with SMTP id
 956f58d0204a3-6455566348cmr12386273d50.64.1765949953936; Tue, 16 Dec 2025
 21:39:13 -0800 (PST)
From: Dharmender Garg Garg <dharmender.garg@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdxvF3iOtZ3Rr73tT86ZiFmm2XXosQ==
Date: Wed, 17 Dec 2025 11:09:12 +0530
X-Gm-Features: AQt7F2q_TgQyLzp-JdKU1DAZrde_1AZbRswBUZvw-HnBKWv1bAQbkWRk2_P9FLY
Message-ID: <460258fdca70a8b68ecb151480ef99d9@mail.gmail.com>
Subject: subscribe netdev
To: netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bb263e06461f4394"

--000000000000bb263e06461f4394
Content-Type: text/plain; charset="UTF-8"

subscribe netdev

--000000000000bb263e06461f4394
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
CQCHbf4K/sa8yiOw2qEx2eHv0fXb9txmt8tq4oBDb/8/e7QzqwyP4AF9QNRqoo7YhEposVJ01Mm8
LrKelbYWEVPj74y4AQ2x3T8Tt3eeM7pO+65eXzC0iwRM+PnfwMTd/WVzXEnFRlqElQ2L92Rcg+nL
Br5nZRQJzGJKrm/dghG0HIA8STne+2+0Vl0Jm1/xWwd3PVUlCF+kkWZqC63N/AreShgU5X46XKAw
Y3pllKzJ4tzC22oMMTxSRjG7M3ZjDoTj5xHmoDC3LvONHfO84AfTZ5Z2UQIDAQABo4IB4DCCAdww
DgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUF
BzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIw
MjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21p
bWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMDMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMC
MDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMEEG
A1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNybDAnBgNVHREEIDAegRxkaGFybWVuZGVyLmdhcmdAYnJvYWRjb20uY29tMBMGA1UdJQQM
MAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQ1
gmbMVhlI4fI5gzyrvJdjYNX4dDANBgkqhkiG9w0BAQsFAAOCAgEAIilBYcPY1c/pd64W9/sOUnkd
tkJ991eiIjAB6UXvFJC7Jg8m6XmodhIB+5N+OAz+qdE5wy1PUXwFmMEos0c9Cwq7YRTfEZ7WI7Hu
X8niHzBg4rfU46fm5Virt7VzS740EQhzzH8TCq+v8VluSBtCYcQH30OfPZIh5imVt6qU+O6uYr/m
b7MndySA/eQUzDF9PAPisD+tnqfZpYhUeAK944Aeyz5arAFEwfqZDSX5BxiUfJHaca3r+zRK7pOv
LOgij3lAmWlai3D0I+nAR4FPLncyvX72G8NDOUMC15xYW9MWaq2bsZukywxLjrHCAGtGDGj88zMm
qG3n2nfcK7+2StXDi65b1ZGFurDHLAf4k9PLxcc7vbu/ayQfZu/WMefE2EiCQlcAcVyDI6v4a1/d
dDrYSoX+qqRLhv0SVf1yOTzeEsHc6sGW2qBJN+6+t1Kl4D8hcox98Y7Q3LmpMqUJXWcpI1OpTubV
qYxJnAbHmXZaqlaG2T2u0k3YMgWBv62g/1bh3zuYefH81WSdcjqWlswhMeMT9xo6e4Q4/lSh+8Yk
afEHAKS2zP92yLyShwjb6MGxOP4KtvUhEXyBN8g8yy9CL2LXP/IeNl7j4cUjjdQDu5hjEF4pdKF1
jlyFu5TadFv8+ve14VtBGOveOAIKYbd7sWCAo1vG/Kuvwns/XzAxggJXMIICUwIBATBiMFIxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWdu
IEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwCLpwddxj5oLQ8kx4wDQYJYIZIAWUDBAIBBQCggccwLwYJ
KoZIhvcNAQkEMSIEIBM/EkSkcLR/kNRSQu/SFcsJamb6QM9Q9Kxl05QwslvJMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTIxNzA1MzkxNFowXAYJKoZIhvcNAQkP
MU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI45jLaIfcAVYa8IB/wI
8LCGCALcBoh+pMiP2zburTIOFOOBy/EHlPe5xQdV5Sm/Dx9hIxM9weAmZosDV+Ud44NiZ+H4LG2Y
bgbhcf8kiulgH5DgqMczrdRMFnheBrEZVu011enq50YmNk6SRuu7N2/F0cukWK1uAL1IllmyVXut
RaITO56eerUGhA53rL5EUedOeAkS0OT6NKp61qN8i+8drcAdawBku+TZ1NFjf+XkRqkE/LY1BocG
RRY+MBMvmfck6jHzWvWUb6oY8j3OGikAjTiYg6/5spJ7PxPtWlAxad0TCmoIZMUYMoaqQ7mXi+vv
3hpbF0jjN5AVB0dCZ/k=
--000000000000bb263e06461f4394--

