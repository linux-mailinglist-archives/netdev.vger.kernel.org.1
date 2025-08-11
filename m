Return-Path: <netdev+bounces-212608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A22B2170F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768EF680E81
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF12E2EEE;
	Mon, 11 Aug 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZqyuVnWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F582E2EE4
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946488; cv=none; b=bkp6lypeH/FT3HPe+Amz5gS+jhWoBlbH5BzVLtmoHxspZL0Xc8dgR+8mEd6Cr31Ax9VphUp9fHmWsdPJZiFjMDOOWm4vRx2anvqQLgmzxZC/H4E01gkyxlrvOVjsh0HWsXcfnZ4chewRfrzOP45ikG8b6ONwNZOjfjuehfIesE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946488; c=relaxed/simple;
	bh=HA5GVypJ4ScykSXNFFxS5BkGihwWrZk/jfU+oeSmaIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDJPXXt2w5zecNF5z6EyUNoFOygzX0t2d8IdPRLvJseF7D52Ij5gzrRdKXTOz5rLdJTK6QC0O4mANqHBo2epkW+Z/iiGf6dVNJPovpZO7HtSUvz2fPhNXVw9DIqMIbtRC3tYGb92XCU9y2my8ws7xl3pgu7VjMNiTWFTsTIKm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZqyuVnWE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso7568142a12.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754946485; x=1755551285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIWcwn97b7lWHcLZyXbCllvFOaOg7s4x3kZrm6zU4Ic=;
        b=ZqyuVnWEeflknBwnZMzfUYaHb/YOwJPFJ0TYc4ssEsIaF4dH/2oG99QXAVGmn1Z4qF
         iaTRgRMT7GP+ayjV0hxNe9c4my8i1tQ2rgHApbzQ4Yc3Hkaq/yXEBNZH6ft3TPg9piD6
         Brf5g8Fx0WT7mXceYzjLaFg3ChgqKwYShqwzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946485; x=1755551285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIWcwn97b7lWHcLZyXbCllvFOaOg7s4x3kZrm6zU4Ic=;
        b=UWaZmfgVwKx9cjg4iE79bMi3hB5SiwxAbGQg2a379u1D3gkPKIC/ajhFdoetEtWW1f
         kUV/nGhT9/zhrIn0ZAdng8uve5Z8h68a2t//NEoUJouPRX4y38OwhnsN5wbvKI/wPoU0
         8fqi9hm0QJQmkB10/vm5GSwf/QH+XFEFt0P8Z/dZe5emVsRUpqTxuAfBD95QstBJDcxt
         IJyjG18Luktzk76CjheaOKeJKNR6xba4pLoU1+kImt4AF4w7SLliSJIXBDxn5Jfk2sdO
         nWVae5anllGtdJr0/T8HxASSnCfqylIG2e8ibmiz1Av3jF87u+aN2ej9HbN908ha5/Uj
         27Rw==
X-Gm-Message-State: AOJu0YxAOWuRIlpsMtqOxA35x6zLcE0f0tblHhrx/NrWYcrahg99Cbsw
	nyTnAb64FccMb2YT6rJTnK/Hhbb1Hh+4PtJ/Ig6+ebDHdHaPmaD9TlkATcdUC1S7G1J8kPvA42b
	oJrFUFjstrPO4zBMB3ehevT4bsza8sskBT+CbI6Hx
X-Gm-Gg: ASbGncuh4FyGGCpvWdOJfDT5AeM5wA25sNTeh185hcIcy3aRmKylHCWig0xl7KeswDa
	LrSO3KiBTl0DVY5dvag2m7NrcehAweZ8HyY7UovL+be5IxY40etLpRZJqquICplf0Zk9b8BstcS
	5OT1Un1oeqExfXcsdAextgcFlWFYioxK3ow6JsdTmw9r3jp0tMSqLxy3cGoC+sP06BFeBhZTy9h
	a4C5/T+
X-Google-Smtp-Source: AGHT+IGSizuJi11OTIFONuEgTUoI2/ERWdyjOb+VX6Gu2IEPYn3wuetVFveR+45ThkyXTpkQe31EcV1eLfr0Dd6O3Qg=
X-Received: by 2002:a17:907:944d:b0:af9:4282:d38a with SMTP id
 a640c23a62f3a-afa1dfecbc5mr84865666b.21.1754946485426; Mon, 11 Aug 2025
 14:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811174346.1989199-1-dw@davidwei.uk> <CACKFLimKpAtt8GDGT7k5zagQfzmPc_ggt9c0pu427=+T_FST1g@mail.gmail.com>
 <521bf1f1-4a22-4afc-b101-ac960781b911@davidwei.uk>
In-Reply-To: <521bf1f1-4a22-4afc-b101-ac960781b911@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 11 Aug 2025 14:07:52 -0700
X-Gm-Features: Ac12FXzmIFGfTULPIPZfXPgHji2JylJrF3CxJvktWr9Xt5_svgWYYcgNSMpiqQg
Message-ID: <CACKFLimab-kzux20TU4GD72GCa7PSe=JTxaeErDRe+zHke7TGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt: fill data page pool with frags if
 PAGE_SIZE > BNXT_RX_PAGE_SIZE
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e25844063c1d5138"

--000000000000e25844063c1d5138
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:19=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2025-08-11 11:08, Michael Chan wrote:
> > On Mon, Aug 11, 2025 at 10:43=E2=80=AFAM David Wei <dw@davidwei.uk> wro=
te:
> >>
> >> The data page pool always fills the HW rx ring with pages. On arm64 wi=
th
> >> 64K pages, this will waste _at least_ 32K of memory per entry in the r=
x
> >> ring.
> >>
> >> Fix by fragmenting the pages if PAGE_SIZE > BNXT_RX_PAGE_SIZE. This
> >> makes the data page pool the same as the header pool.
> >>
> >> Tested with iperf3 with a small (64 entries) rx ring to encourage buff=
er
> >> circulation.
> >
> > This was a regression when adding devmem support.  Prior to that,
> > __bnxt_alloc_rx_page() would handle this properly.  Should we add a
> > Fixes tag?
>
> Sounds good, how about this?
>
> Fixes: cd1fafe7da1f ("eth: bnxt: add support rx side device memory TCP")

The tag is correct.  Thanks.

--000000000000e25844063c1d5138
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICQF2UAb03RM+rmjKH0VJao5SutFTEwN
8NgYjUn4yKUCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgx
MTIxMDgwNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBABGz87lO7L/AbPDfjyYW+MYjip6Bica65VC/7X6VJamecU3q0spRHliKiUh8bk4A84R8
PfMnPhSHjrS36gAU9v7yGka0ukXz0gUMzhrnhU9Bg8vMRS+YjrmK25XKF1R49MJt4TaYUrzt2BMB
YMK4ixUSWU703QZSSqvXqE6XLwLsvZwhDW9fuCxDRgGUSRQeTj3wTU6nrCoWs1XEutJjgaNAMaTx
J3tMkQkbSlwo0a79wZpp5RQBF4mATiliyVkQZ/nnBzfY/ZzYbYiW8kwEY98hPmhzL8QYRcSoL3m7
9NdKjkajl8hoB5GeawppKHVjMJRoN1jCQeCSf+o1mxlW6oA=
--000000000000e25844063c1d5138--

