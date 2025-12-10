Return-Path: <netdev+bounces-244238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D48CB2BAE
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A9DC300450C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33190315D29;
	Wed, 10 Dec 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="awZclBVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EE315D46
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363460; cv=none; b=htx20SmgBw8FgQ8twMfT3/n89KNimf1SizALSBh7Vspliclpfs8r1ya1LuaM+57w36lZuGc3at8ewUPRNykxEnMgTP8YOyu5jHpX603RYkoUOgdceeF3rvLMS2PYugjy+646M4qvnWZ6njfMgt9wpaj/z9WZEHYde1ZAw3adUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363460; c=relaxed/simple;
	bh=tEO34jqmtGwj+mE4f9k5CdnkbWIS5ZV3jwmhquFIyr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdzLZv+qH0zJefIlMFuvbm700I3+9fB1swICjkIJOhTT2uOBglhLv1yFUMUuvSaKvrsDnReMQv/QcMcpLhBqq2TIkKZgffmRyxIu5r4CEXcpazWQnoGonfPxzIC1oazmXsovvK5gofUPLEckk3C1DyCIIlB0ywCi8sohlrwGMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=awZclBVT; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-3e8f418e051so4463261fac.3
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 02:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765363449; x=1765968249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RBUHEY2P271tJCw1eZEnonfRQKkaVFQRa1LoA6CeCU=;
        b=LuS1oWCRusAo8ib7WwnSO2AkPmg0yEjg0hSxG0V0Mo14BWMlC4p7oLfkrUnL2e58NW
         faUbLV7xZ6elCr/FPb68PxnCwdRi7t5tQzhK7wKWL4Vma6J0VKgZFabnP8EmsgHaoLSE
         piOlYiMyhlZ8O8c8AmZQUbaHZWcu1LJHzVdlQGyW5h/OJL/5RanwqNPUv9EqnJW8F+HF
         KGCa0o6rqDyOCWvh3KAPrUnwuI/e5QHCvIVcfAQfh1WM8ScFAk0+YyJjXqbB/ur1qaPv
         U1582cKjTzJucIVot5gvGPc8EMlSoAy3Wcn5nAARD3y+7tK7INqgVUmncw8LoO1HC6BX
         v6xA==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZeNxjBuQxuB4h4K70iLGI3k+0mPOWjFVCIkcK6AbpaUmhQJAgoXNl2Rijs5SOoJtK+vz4BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2m6LC0Rm997Vdr0PlEV29aeAU3fxYBCg1Xa9X0oshNi/IuMa
	k9LjniUp+/TM/5goPLlD3l4ICu+iZGHCiLteok1/HyJ88raG9MrYJHPJI3a13Q+9bD+QwD0tCIF
	pGeP84q08jwoJllFaC491xnObqKxKQPnms85ZlhADIIugJtGkFDL2CLhOeHsKMBIefNdqWnHTE9
	y3pK2CeEbUxv2OEu5anwuf33lsYn1XMaNh/yU5mCw2vH1Vo+BJ9m6r43M1nr+y2q24EAEohoNn5
	E9XcS9N1LIO8Cb2uw==
X-Gm-Gg: AY/fxX6lkbEOyNWTUOQAlCWN/n3C6pJe4AVTiHQzp2GKI2iRoF2pzJFIqJsHe+yeCWN
	HCHo2oDCmg1/EZWvGRdGaR0t295ys3JUPWpum9WhnMTyXFsOmGZmI90xtKvTV6JNd500TYu/ZbB
	byW1wsgUtGo6UgY5VoYCl29qBweBMSDW4Ki3cviLIGqtOPEm+wNMoxrBECeT5jTlZyhtctB2rAb
	AZ+Frb9V51DcfD8YCQbpyEwfFkp2DVQRyZNYBieoF/AT/TQtLneT2tcy3MhdAHplR2h75+Y2FAq
	khRXLTmyGng4OrphgTOloJ2AtTllOf/naLvEUENn8w7aphRNLhfbMIgmNrdc9y/bmOk38b+MuR5
	ivrvObdEWy+tcZxBblGnN7Sdmps6mV5XZJ8m1vBKL9BRgXDFpW4tWHwafN067NjtXU7hkD0xPEp
	VGI1NhfE0F8HtsdvAZWkeR/z1zbR1sPXZucBw7YYFaOTS+riQ83qY9Yw==
X-Google-Smtp-Source: AGHT+IFB1VJx386VrJ9j1dzrpZLfhrIPZE1faM+alxbDFLpm4RPN+ABfNWkaxfUdFRfNDRdRlZwO8w63hXXN
X-Received: by 2002:a05:6871:690:b0:3e8:8ec1:eba1 with SMTP id 586e51a60fabf-3f5bda73cd9mr1217537fac.36.1765363449501;
        Wed, 10 Dec 2025 02:44:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f50aa9edbfsm2124328fac.5.2025.12.10.02.44.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 02:44:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso11329608a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765363448; x=1765968248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RBUHEY2P271tJCw1eZEnonfRQKkaVFQRa1LoA6CeCU=;
        b=awZclBVTIvvEFm/m9OXyRMm1pyTFyxro7c5J7yK9P1LV34efZsigCVIQabAdd4fIxw
         Jl+cfmFB6Fnw9ssnhU/YGDk0aUYD78db5vUJuHNEp/D/+gt+Q0hQJ9ZZnd9X+LXA5Eoz
         NoSKkC1b6MiH/L4aeslycnNACxP7DA9dTG+vI=
X-Forwarded-Encrypted: i=1; AJvYcCUnq74Ki7mctL0IYLRPCkivB8Vcjsx1Uzq2pwT9iSqsxVm+l+xVtuoHqMv/R/4Y88OxgnHM4h0=@vger.kernel.org
X-Received: by 2002:a05:7301:e85:b0:2a4:7f22:cc0d with SMTP id 5a478bee46e88-2ac0562e34dmr2047011eec.32.1765363447775;
        Wed, 10 Dec 2025 02:44:07 -0800 (PST)
X-Received: by 2002:a05:7301:e85:b0:2a4:7f22:cc0d with SMTP id
 5a478bee46e88-2ac0562e34dmr2046974eec.32.1765363447249; Wed, 10 Dec 2025
 02:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
 <20251127191439.2f665ca0@kernel.org> <CANXQDtYySxN6kcDh3hPAUcFBiu0vDuVX_7mdLSbkKcf562MoWg@mail.gmail.com>
 <20251128104431.70ba577b@kernel.org>
In-Reply-To: <20251128104431.70ba577b@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 10 Dec 2025 16:13:53 +0530
X-Gm-Features: AQt7F2riDIQTHAwxFtKyJLnAkub4dh9Lx8EFdSI8VSYZOh3_mL9gwsI8JfrdMsU
Message-ID: <CANXQDtYMSGzhOa+Ja=r2ytAh63DYWvebXR12272YXUkZX355qg@mail.gmail.com>
Subject: Re: [v3, net-next 00/12] bng_en: enhancements for link, Rx/Tx,
 LRO/TPA & stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003a9e1b064596b56d"

--0000000000003a9e1b064596b56d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 28 Nov 2025 20:29:47 +0530 Bhargava Chenna Marreddy wrote:
> > > On Thu, 27 Nov 2025 01:19:19 +0530 Bhargava Marreddy wrote:
> > > > This series enhances the bng_en driver by adding:
> > > > 1. Link query support
> > > > 2. Tx support (standard + TSO)
> > > > 3. Rx support (standard + LRO/TPA)
> > > > 4. ethtool link set/get functionality
> > > > 5. Hardware statistics reporting via ethtool S
> > >
> > > >  13 files changed, 5729 insertions(+), 50 deletions(-)
> > >
> > > This should be 2 or 3 series, really.
> >
> > We would appreciate it if you could allow this current patch series to
> > be accepted for review. We commit to ensuring all future patch series
> > submissions will be smaller and more manageable.
> > If this is not acceptable, please let us know, and we will rework the
> > current series.
>
> current as in v3? Or you'll make v4 similarly humongous?
> Look, we're not trying to be difficult. If you keep posting 6kLoC
> at a time it will sit in a queue for 3 days each time and probably
> reach v20. It is just quicker to get code upstream with smaller
> submissions.
>
> There are some very seasoned upstream contributors within Broadcom,
> please talk to them?

We agree that a larger series can require a lot of effort from reviewers.

We will keep v4 limited to TX and RX only =E2=80=94 roughly ~2.5=E2=80=AFK =
LOC.
Hopefully this size will be good to proceed further.

Thanks,
Bhargava Marreddy

--0000000000003a9e1b064596b56d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD8WvMCiGYVO4Bg49PHGX8XLdB+XyHJoxKJlt5g0nz04DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEyMTAxMDQ0MDhaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCV6Sxh
jG370l/2OPqU/bk6/nLIEPGGYMxoklGwoL4K+8nsO/3y8OqlOLN/aIHWBiszZ/9tYIIS8oUKUOJL
R34vhrrDi4hKa9IoV3JFjQ4WwLfcJ8knQ7OgvycAYGjfG8aOkVWae1bAxiC45LmZPvh9g2XgIVK3
mBYHHByEzI2WNHahlDH4o8E8GW2qqLv75NlCSeXUW3UaIEU1AyNVa2bQ0w2ccW9UWd3l3FPDiYeF
4CNXQssTc8ba8JivMAvAzyANaYHwfiYqKPPXbLoSO/We1Sqz7JEXcXEefitpQN3YQTIyDdYsxFwL
hKWfARm15UTpjOlzdsoXiKvfAM7W6/FB
--0000000000003a9e1b064596b56d--

