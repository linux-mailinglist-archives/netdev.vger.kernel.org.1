Return-Path: <netdev+bounces-227991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73222BBEAE5
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E6189A85C
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B222DCC1A;
	Mon,  6 Oct 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L1nFHzeG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5951E98F3
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768850; cv=none; b=N0b5nDXAeLGX42VyPyPphYkw4KgQaFFiW8Xsnb/ASybzIynV0npMOep58XwLjlLiZmLjipkfJTsilHReEzDGkbtNrwxnxNOOL/VVPuK2q8T3RNxs9894P1mjfdg+6lzBXD75RS8TbZlF8dVTtK8V8BeoAkvn10OtZ2aMcZzwC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768850; c=relaxed/simple;
	bh=2U3K5OkoSxoMQX2efr7dPoNWnpsyR4dlt16saVxzuCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpW27zkUOteiLIkySX4qnfa1LqVBxUgbeNjpbBt9Y8bD6fEFXylRvePn5LDBAJxTQzLD/c04d6STkowl9NldWjg+gxXjy8MKbopOIgnppQ7eoVN/BAppYRd/aHJiWORiiDTUL3FLULb2WWO6r3J6SR6orYWTnSzun6jJEGhfL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L1nFHzeG; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2856450b3a.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 09:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768848; x=1760373648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xd8wzLEH05brRTVBUoiuGWwB6yjyV1xc74v72IGUdp8=;
        b=pT32Y27hwuqk7wrJtdC8CYoMSeU+QuZr+MDTpUnJSPaCpVpj5V8W3PtwKlLqR56HOj
         4lRmzocqNAe1s0uEKZjnnJjz/mW/uC8jNSskBQ9/dzfghTo2JN1pW3j+n//dBjHUVsq4
         J2DxWM+FXfsgcolK0BxvcRnuVPnESWrPd/ficU4hvbj8KscFdAhbBf71FgatrYjus31h
         RlIp338d7K/cqJ5N+GV7GY2bEBnwQefMLM7p9zLWa2rqgBMhmfZdZgpcmPosaKEuA/gC
         xBxAAr4NtGlTNKohTaJm7gboFM7rce7ywOK++rws7L6MWphuYB4DTXIKYc0I/9uYBDmY
         xM5w==
X-Forwarded-Encrypted: i=1; AJvYcCWE5waJdi7KSbUETdNPnKOHWiRh+N1JMG8AMXxTqL2FsZ4XTzwKLev2logdgmUYdL6v/O8jlag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Hsl8JWun83+X5pHi8vudW2pAQ6GMLGIUq2uDJAO1csMs4vIu
	SISTJg5b3GyP3DEnjJnjKHouVgoFye/9gE1lsrHWzRvUK8XbOmrXNxIUkykCSTZLpXJ3902oKyJ
	1TzR8gzBaLu3FAX9cTlQsrIDfR4Y+I0e8XylF6rBG7pDugzuv2QXkRQDhdE/RdEYub430StEK+q
	xWcp3V/QjO3W6nOARKdjwmk3HJFnfQkQH2xILc3xDn2yu+2Of6yr7FuRroizU0eTatJIlAGUQmj
	148yIE61bo=
X-Gm-Gg: ASbGnctbJ2kggc4zfMC67qOHy/m5nS40td5f0PFhhAWwpnePvRsgb4rLIbmABs/Tc6P
	p+lEg/kwBjS/L+7rrY9ADhoSpxdNstqtDTWg9VWfnV7G/EqdrO/zk4h00uPJhzinhq2CERB0x8y
	HfozVtgQ5yir40ZqXFeeW84isIyPrh06MWVI/NaKgWr4D5X/4vYvcrE7fHX3Js2hq9mCByE0LIF
	aPAJCpzw56np6WOpfYapX5Y/EOaSL61RLJrhDVsy+o3rNZPmB0yzrayAWqlh+wXpfWnBK5x+Asb
	8AwYJ1iZSolzfTMFkQsge0BwMf5m9sglYb7Z7A5y+eI7g+o+uX7vuvomb3YI9p801i/SxE+tQMZ
	Y+B1t8AOJMK68kDb1Fn+ZlqFD+ZWjhZToZBIcaCTi5WH1iKOn6Oo2qnM6ee+LaZeLps3SfgEkJE
	LDePvTNes=
X-Google-Smtp-Source: AGHT+IENIZPJ7+wspd84NPSQYYAumYfvgQDsv97MG47S2NqemmNxIfxrXE5p+tJ26suo4mWwlRVsLja6CVRo
X-Received: by 2002:a05:6a00:39a6:b0:77f:efd:829b with SMTP id d2e1a72fcca58-78c98cbfd12mr16082046b3a.22.1759768848086;
        Mon, 06 Oct 2025 09:40:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-78b0202dea7sm876738b3a.9.2025.10.06.09.40.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:40:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-783c3400b5dso3201874b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759768846; x=1760373646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd8wzLEH05brRTVBUoiuGWwB6yjyV1xc74v72IGUdp8=;
        b=L1nFHzeGCVTReVzAkOthnVqHuO+PDhiji/H/WLch4021GXWoazH13AJTKDII0/v2FX
         DkL0eeayPxXxu5ogHE7dtCAkJBQO6t6RZmqgZrUP3ah60Bohqae6Pst9BekaS32nnmrb
         I4nBIRQSro2DzRq1rwAMVx7s+qzYwzmy8x/Hw=
X-Forwarded-Encrypted: i=1; AJvYcCXqS3Z7OClcsQR+yvzzpAQGS3k+LM52ppKYZkYp+jSAY0cNDogZSsmfxm6VTw8SdCBHGjHqLVc=@vger.kernel.org
X-Received: by 2002:a05:6a20:430c:b0:2ca:1b5:9d45 with SMTP id adf61e73a8af0-32b62094913mr15508479637.32.1759768846288;
        Mon, 06 Oct 2025 09:40:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:430c:b0:2ca:1b5:9d45 with SMTP id
 adf61e73a8af0-32b62094913mr15508442637.32.1759768845883; Mon, 06 Oct 2025
 09:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com>
 <20250929114611.4dc6f2c2@kernel.org> <CALs4sv2tRYnDV5vOWum9+JQSr61i-ng1Gaok17bi+JSP-uLSNg@mail.gmail.com>
 <ab203d1c-7a56-4d44-813d-e4a884bf4e43@lunn.ch>
In-Reply-To: <ab203d1c-7a56-4d44-813d-e4a884bf4e43@lunn.ch>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 6 Oct 2025 22:10:33 +0530
X-Gm-Features: AS18NWDV7R6uaueoJJfUIWUY2LRTvy8LL3SM7N6NJ7rcscVKoHX9cHQe3yA6srY
Message-ID: <CALs4sv31DN2UXXSJaZrdjuQhyV9qH2xOsqSAYgbzOJUVwVoVnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, jgg@ziepe.ca, Michael Chan <michael.chan@broadcom.com>, 
	Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, "David S . Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Eric Dumazet <edumazet@google.com>, 
	Andrew Gospodarek <gospo@broadcom.com>, Linux Netdev List <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fdb08d0640801c10"

--000000000000fdb08d0640801c10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:52=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 30, 2025 at 05:55:38AM +0530, Pavan Chebbi wrote:
> >
> >
> > On Tue, 30 Sept, 2025, 12:16=E2=80=AFam Jakub Kicinski, <kuba@kernel.or=
g> wrote:
> >
> >     On Sun, 28 Sep 2025 12:05:36 +0530 Pavan Chebbi wrote:
> >     > Dear maintainers, my not-yet-reviewed v4 series is moved to 'Chan=
ges
> >     Requested'.
> >     > I am not sure if I missed anything. Can you pls help me know!
> >
> >     There is
> >
> >     drivers/fwctl/bnxt/main.c:303:14-21: WARNING opportunity for memdup=
_user
> >
> >
> > Shouldn't it be treated more as a suggestion than a real warning? Are y=
ou
> > insisting that I should change to use it?
>
> There is some danger of "Cannot see the forest for the trees". If you
> ignore this warning, are you going to miss other warnings which should
> be addressed because you have got used to just ignoring warnings? It
> is much better if your code is totally free of warnings.
>
>         Andrew

Sure, true for real warnings. My submission was that this particular
'WARNING' sounds more like a suggestion that's all.
And I chose not to address it, and did not ignore it. Anyway, I will
try to incorporate it in the next revision.

--000000000000fdb08d0640801c10
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCN2Wpw
e6zjxU9lEs3T+pCpYnap2VyISjgDcbqMsZdMBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMDYxNjQwNDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDBGT2OFGHbknD3tW6l9rfaTP5Afmpdaqz2aHMPKVXc
z1QYYwPuFJd1alElqGN0Z6yJSEzo8BIm0eY+Vb7wKQhn2cofxUaDG2sgwlXjWAa6ZwojMhIcwFa1
3S2/gtsluFQNs92q3T/+N7DoKuqFxYYCBsc9t3V3gMJPemlfAhcdB4Uv5VO/G/EFs0TUiidnbCDP
QUbLo7xXxrFNFlgOAcAKh7pCZvZCyz7397wWzWJiECsbk2oG8Z/NobLaGW/ena6J+jxyJ1+NJqHk
eocX6wSQVZsdQnQ7FWgOKjM8pvL3R/eM9bCBuubWn2nK17wtZQ+saDup0H8CAu1//xVCwC6c
--000000000000fdb08d0640801c10--

