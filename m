Return-Path: <netdev+bounces-246782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7406CF1274
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B5B43000B03
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B62798F3;
	Sun,  4 Jan 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hc4KMaGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93831DED4C
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767545573; cv=none; b=UFYLqlJozyqrkVTSarftsBMsHvb8oopjOcy+Tvecl9uTPGNqCA+mUOtBmuFzy7eMhwv1hV8oG6sa32ayq3Tv1k/2OiuLsiG897uvLR4T6JYklexrbDyvCN49VvNek2oOOru2r2jsm+RpFV4MXufw52UIDSibrY7J5YTHnQ2GQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767545573; c=relaxed/simple;
	bh=+tBHGOmVtypBBwvFvio+xBhIdYb98Ho71rB8dNekFu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpvenkzGxn9ydLmHW0CZbuDSHGkZl7Zwab/n3b7w75s7nx+cgO4Q+xYWTzc/B+bgBp1YzyFVfvSIXMi/p1nsndzeZOISn2eHkxzvzbPQvsIDvK3P+0EIY3m/9ZuXSN+7S1kSX6FU6h820CqJYEV+47y0PKx3qCa4Uu6VYmUS4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hc4KMaGh; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a0eaf55d58so6562355ad.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 08:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767545570; x=1768150370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zABrQzlFpeUDx3D39FeSfVfy2foExGP4kkwYvOCeBA8=;
        b=e1tFPEyua+GrQ9yRihlMGq7qj6aiIxG4+7Rkr5+bXV361zMD8Of9sxi3f2hTXkpa3z
         L/ip2KteIwZIW5YQpDnAtknfCHPkKD9k/oknLLg8tXM7pdis3sYlV7yeHTHuqwBW59B+
         YyZeX8IcFFvO6/ScPWH0aF2flar8Fm5tg4YLMm5pH6glAXhAE/gspin2LLOVbXUqoo2M
         qudOZM1/3HUM7WQXGCXo5SmPrJ9dLkVIXU+aSQo58a+GQsYHiyhj9Z189jmLaM723Bav
         IyYXg4JpqazZY5dAKYkkWLIGSCfYc2aoZBMiXbeDAfNE+eRdtF2IGCJ2Bu33qNkQsgtH
         9Aqw==
X-Forwarded-Encrypted: i=1; AJvYcCVzN+0WZQ4Yh/Pwz0iCeKsGqzpENEq3hDjJ8lioBBNDKL22AhNhr1blRTYryuWNtzYFGrcpK9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIMybVzXI34meNDUyZE/nzoaona5qbNu7mUDuwBiTP8Gc57Ow
	oYh20x6pvFEtXLiYu7n5j+N3iKUez4KtEi1E3qUeBUBwbWmuYPzPrNJRnwFwYpH6iMzx5CziMpu
	9Mf/Eb+SspvNKxs5cLMgaTUw6VjnozrmlnVE6u8NjrzuwDj/OuVv82+fTzwSbDRssfx+a5Rj8kK
	tlRTxP4yX8/yX5I7F0S1LLRAhDLPOOElBVOzcqSVN8Lu82DA5w7PUdx9S+YplQgllcGQQ4wfEvX
	cKeVJQ9rQ==
X-Gm-Gg: AY/fxX5LvFEd5TVt1WK6lj6JRVX5jBg9QYfAL6mU8MqETonhIUmiaXfVjyV4IsSDmjT
	rQR9ozaBF84z8U54FExVsa/Nb7aBQeU5PvPzCmcAV8YjEot3j9jKwwfhvYHarfFVer+haupGdGO
	S10CaHXh92rQvEJun/eHTtEnX+LOeUCQRqj1NREt9es51KrmV9U4Kyvz2SDl9L0N2okORdOsNa7
	73ghtNe0hTbb9MKFfDuxfuVxM1bm6x76BwPRoBn46ipfzX71VVPxF2ikawBoNMDTT0gXlHxkBtX
	JxglQ1Pfx2WjmQPSdNwD9ohKyldvaXQoswabPQ2GcxA0FwQSEQ1VnTNgdlv35uo/wLuEYHwwVv5
	TYvzOm+G4WftiqMJ+jbOF5yxGcB9FpFaWy8yFilrc4nzQ6mUGD/y0okTudGnS3J8cd3sjtPrI1T
	5U/vur8sJ/qB08LPiLo2DQOGAluxTj073p7mKEuG7d
X-Google-Smtp-Source: AGHT+IFAGzqkOKNWVkOjw+we+YaYmpXAkyGizA05hfCNBryP9wV0qflTAKO6iRkdP1QAt1t011BLITIqaOYc
X-Received: by 2002:a17:903:1aab:b0:2a0:9047:a738 with SMTP id d9443c01a7336-2a3c09a70efmr39750865ad.19.1767545569979;
        Sun, 04 Jan 2026 08:52:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3c81837sm50970735ad.18.2026.01.04.08.52.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 08:52:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f5265a39dso7482088241.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767545568; x=1768150368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zABrQzlFpeUDx3D39FeSfVfy2foExGP4kkwYvOCeBA8=;
        b=hc4KMaGhA0ZNBlyQmw3K5SrOIXRibhjb25Y0uR05/FMBDJiJps0C6kzjud85WCBQP0
         LGftm1wdFUfJUFCmav9fSJW7qoTb92VV8U58uqBFWYw7kDcu3EyBMt2fWPPY+2Z4/52j
         uNQIbnWbjJZHNlVcA6hy1vypbtOHUcjK1xAig=
X-Forwarded-Encrypted: i=1; AJvYcCWw5T60OsFJTVRUnAD0OvjM6z8E34A0iqOOZ4T4eQQImL1257HJGPIFR0nF5pChxzblwQ+m1nw=@vger.kernel.org
X-Received: by 2002:a05:6102:c94:b0:5db:f276:37a6 with SMTP id ada2fe7eead31-5ec30a8bcc7mr1840153137.8.1767545568687;
        Sun, 04 Jan 2026 08:52:48 -0800 (PST)
X-Received: by 2002:a05:6102:c94:b0:5db:f276:37a6 with SMTP id
 ada2fe7eead31-5ec30a8bcc7mr1840151137.8.1767545568388; Sun, 04 Jan 2026
 08:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-bnge_aux_bus-v1-1-82e273ebfdac@blochl.de>
In-Reply-To: <20251228-bnge_aux_bus-v1-1-82e273ebfdac@blochl.de>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Sun, 4 Jan 2026 22:22:36 +0530
X-Gm-Features: AQt7F2rYMu13TPddarPgBaT9-3v7rq7pbFgvQF_Y_NjAklJd1M_ys_-m6jH4qz4
Message-ID: <CAHLZf_tQbddDms1tnVvRj7EP7vUm5qwoDN0puu-pusWS7+PWPQ@mail.gmail.com>
Subject: Re: [PATCH net] net: bnge: add AUXILIARY_BUS to Kconfig dependencies
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Leon Romanovsky <leon@kernel.org>, Siva Reddy Kallam <siva.kallam@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3189c064792c5fb"

--000000000000c3189c064792c5fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 9:23=E2=80=AFPM Markus Bl=C3=B6chl <markus@blochl.d=
e> wrote:
>
> The build can currently fail with
>
>     ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge=
_rdma_aux_device_add':
>     bnge_auxr.c:(.text+0x366): undefined reference to `__auxiliary_device=
_add'
>     ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge=
_rdma_aux_device_init':
>     bnge_auxr.c:(.text+0x43c): undefined reference to `auxiliary_device_i=
nit'
>
> if BNGE is enabled but no other driver pulls in AUXILIARY_BUS.
>
> Select AUXILIARY_BUS in BNGE like in all other drivers which create
> an auxiliary_device.
>
> Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
> Signed-off-by: Markus Bl=C3=B6chl <markus@blochl.de>

Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

> ---
> Basic steps to reproduce:
> - make allnoconfig
> - manually enable just PCI, NETDEVICES, ETHERNET, NET_VENDOR_BROADCOM and=
 BNGE
> - make
> ---
>  drivers/net/ethernet/broadcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet=
/broadcom/Kconfig
> index ca565ace6e6a..cd7dddeb91dd 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -259,6 +259,7 @@ config BNGE
>         depends on PCI
>         select NET_DEVLINK
>         select PAGE_POOL
> +       select AUXILIARY_BUS
>         help
>           This driver supports Broadcom ThorUltra 50/100/200/400/800 giga=
bit
>           Ethernet cards. The module will be called bng_en. To compile th=
is
>
> ---
> base-commit: 4d1442979e4a53b9457ce1e373e187e1511ff688
> change-id: 20251228-bnge_aux_bus-4acb743203b5
>
> Best regards,
> --
> Markus Bl=C3=B6chl <markus@blochl.de>
>
>
> --

--000000000000c3189c064792c5fb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKrK4s4bn/cj
dIq31Bq39qsl32RKWW+1yotn2lQNP1n0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDEwNDE2NTI0OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFVMGvFwPkbcKKYbqszntuPlsOA6Lqr0StLlFuHdosPzOD4m
zd+xNlEBPkcu+MoXea+p7UU3VccVQV/SAOXVKOWrXUY3RF2al24ligtK+IwiassXAEAcHgybAOkZ
Pi2Q9zN8e7K5xIcR6CF9zXfWnRHlyNEDdaEp9D8ydxcq6OA7xUNbHhPnkc9ZACv+hbZnsXWZSRMj
yeONZFOOia1v6fJB2saYPh0hn1Pu3BAHzsIluyyiZk6v3Q50GnCjSAW6uaVyf7CwJp4XMJtrnYn/
0Sg/+kzqCye8ofxMTsoqiF5mv2riQoB3X/9USRY2fEQQeznheuizmH0A0oRvkgGK44g=
--000000000000c3189c064792c5fb--

