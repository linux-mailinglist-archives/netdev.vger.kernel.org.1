Return-Path: <netdev+bounces-198179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD7ADB7E0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4495A3B75B8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517C2820AC;
	Mon, 16 Jun 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WffJeyVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00693288C0E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095644; cv=none; b=Cte7jjbQDrjTEQwmDMYrcRQwVU4SSP1B4lvqaIdziF+5Eru3IlXYgYUtzuWv3XeVmZnwgalz4LJ5QpZ8KIXcbvtEYnmD0hzPy8ga23VIbOQ9thEECvdwFeX/RMu1n13xSqMlgqCmhbTjALxH7Xbpr6LSVLI3C8hmpA0amF3c1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095644; c=relaxed/simple;
	bh=g26r62zs0vXJqqsyhVf/KlKdPk9OkE+auzk+uilCSlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTgPdk1uBlNcfa+JlOPVN0sgrKuNamNDjamQZjBTdGNwaGKOsli98vnn2a4hsM/0ND10UBtWkmV9LWsAHljb+K+fRdmEORiUrIeOjOZXODjkJyNdBs/ohDTdQJqSJQLPAVbixDloVIYE1i12bj5cXa3zqOE+D7UVXNIRmkLJgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WffJeyVx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so953305766b.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750095640; x=1750700440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCwSzjsJD43vXx+NmYUOD15lFWZQvXf0155qwLQcFVM=;
        b=WffJeyVx58ynZn2EqWUsehZmVLjNou5Qk9i3py8BZ14j1Ek+/5imkgPyDSaKZW3JDR
         FzJ9ULwSfIhwIILCQvoxO0QU3mo1+kkxLOtWX08atweBXVxJ+3lfZZo9H+zWyMgUKTbX
         d48lmEe0pw+vnzZC+n/Ibcf/KgA0Sh5XOnqZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095640; x=1750700440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCwSzjsJD43vXx+NmYUOD15lFWZQvXf0155qwLQcFVM=;
        b=cuckVdU9IsnvQHMSXqqVpwWz6vursSGKYqJMeKV5QNVuaMWsp0ebsC5dS2iPxvgHrR
         UID5KUWZZKkb6QcXBooTFcplmHIAizSLlTfBrwZ7CvjQLgMYy0YRWfTplU5lulRz0Og2
         /uMAr/E9UHThHk9vmWt2V97Fr6G+XaJF8g9MIxIyq9TypdlG5qZqGJwgqw5s2mzl7yhG
         QLWoXNR5oDJ0uUJ3WSEC0j+yEofqByxu20Zm39iOd2jwBv7LdPPpAeHcr62LBH+xH4hC
         dpDzuGouUfJROJjY1v3PbW0gQbFlxQRgz5QXUy7Mw3HoFkVHS4pel+h5GCVBeP3axOSh
         Hm4A==
X-Forwarded-Encrypted: i=1; AJvYcCX3CHFeVpNsK2UdNn1H+bqB8v3b+UhxwCBKwxANmRZRgTJ/18sbZOgezxUbBh9ISCp3Bokie/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YziG/jt+oMNWH2PeE8omfGMGIgwkHebaPSxlIyKRj0E5ELbbsBJ
	AJ9GMNtBKeVnjPBSsK/mNY1bDMmnLPnRJSkdXPDB9LK2kOMF7MGSQgtLl+r+oK/gBpu2rir2YzE
	76NtNRY/zIc5jJqaNT5lx8V80bYBOO++KtXIv70f1iVQ/+u1v4Zk=
X-Gm-Gg: ASbGncvCR4hihkFQ4oq+LIXS8mxDsUbuxNoAVOfjiB5CVm112plC35C4H506OME+IMD
	dENHm7nZ7l/xLw06WlO+A/baLrUf059dDd/UfzgagfumxkIXYtNIS5flsJHKZ3Zqow1gGYj4UF5
	XYynZbU6tUVuFroffIgRazUe5gPCz8TWO0ZlwuqHj4Q11N
X-Google-Smtp-Source: AGHT+IHvdLc8eti3k4ZHR9uZuRhoe6bv865NvFkyX0at8vvCcCSvCp5uSy8ZG+m6bpINUoq065tBP+wh3KU4ioj47u0=
X-Received: by 2002:a17:907:868f:b0:adb:2ef9:db38 with SMTP id
 a640c23a62f3a-adfad5c7b4amr979795066b.36.1750095640277; Mon, 16 Jun 2025
 10:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613231841.377988-1-michael.chan@broadcom.com>
 <20250613231841.377988-4-michael.chan@broadcom.com> <20250616133855.GA6187@horms.kernel.org>
In-Reply-To: <20250616133855.GA6187@horms.kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 16 Jun 2025 10:40:27 -0700
X-Gm-Features: AX0GCFvFt54P3XjF6TjfO4kJBTkXkFkuYS6OvTwf07SX3FY4p8TtKPi6l4yEZME
Message-ID: <CACKFLimACdMBNZ2v-zpJ5=H1JdyWfLjN_0SqXkPe9waacq=GiQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fbabaf0637b3e483"

--000000000000fbabaf0637b3e483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:39=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Jun 13, 2025 at 04:18:41PM -0700, Michael Chan wrote:
> > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >
> > The commit under the Fixes tag below which updates the VNICs' RSS
> > and MRU during .ndo_queue_start(), needs to be extended to cover any
> > non-default RSS contexts which have their own VNICs.  Without this
> > step, packets that are destined to a non-default RSS context may be
> > dropped after .ndo_queue_start().
>
> Hi,
>
> This patch seems to be doing two things:
> 1. Addressing the bug described above
> 2. Implementing the optimisation below
>
> As such I think it would be best split into two patches.
> And I'd lean towards targeting the optimisation at net-next
> since "this scheme is just an improvement".

The original fix (without the improvement) was rejected by Jakub and
that's why we are improving it here.

Jakub, what do you think?

--000000000000fbabaf0637b3e483
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKyzTYSykemL0SlErXnFXQAFsqfQko9d
3P3wcztZVdHfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYx
NjE3NDA0MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAEdmNt9lwu6Pd/6tBauxlMvvToDmGjKm6HV2K2WNEdgQUmHbEcxj+pUOp31Y9SCu5M2X
C5BkrI6t2viObnWsFkst7heIBtXzvrMe07RsMp2uuhUB8K74VHlqfwiQaf+m2wQHfdJ6MuSgSPhA
STUYo/u2pXbBB0ELSQQZyy/rzKF96YCDHTz3OAQjZPs8X92/sqX9TxlPP7KUQE3V2/yOCCKtDzes
zAnl9byDY3VP3cTyFpGHddDMTbuB3gE1g0x8f7g1SHQ4wQ08xFACpOMP3qBjPwUXyJKvUDDMTORP
kFjXCO7MLSDAiWEpYVXN+/eGEkqbKadKKdJs0nxyUrzF3rg=
--000000000000fbabaf0637b3e483--

