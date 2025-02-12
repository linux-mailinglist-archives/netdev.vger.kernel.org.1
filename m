Return-Path: <netdev+bounces-165709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2EA33303
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46673A243C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694022036E2;
	Wed, 12 Feb 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VQh5ZPva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825541FBC9C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401198; cv=none; b=tkHorty5qialp5HbPR1l4KM7WXLfiQyxOLXwWm2T5FEMqUJfLs99eKYcHS3SUX8cWMJmjyGDjs1rhQajerZXWnr0nz4Izwh2uFmotJotsKfWxDwGZ5UaXgZTEwZ43Ph2GwVmm+fkE4QFsm6WqzyBXaxIj3SmZFunUMKG87ORRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401198; c=relaxed/simple;
	bh=BNo86KZuD7rhjuC2n6sDiXT9q8BQN7zmKka2xR0jf4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBCn2TV0Gq74mnzimN9i7wgRvpSV6sTQR455NIKY9+f9dQxVIh4JWafwAJ4RiLdm3zGVG3NZ22QqI7LHog6GjtnKCSmA9OEK9eYUb+X2aSkyauLDJarbUNdSrtv+43KbnjBhjoog+FPFtykAkCBg0QG1Aitu98nIBK2+mwEQ9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VQh5ZPva; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so464276a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739401195; x=1740005995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UORAExcOb6F1C8aB2DrPpzefAFwPpCu6YmtRKkXFN3A=;
        b=VQh5ZPva5fIX5jwfULML8i91zC18ilXhiA7+cIGhZ+EP+aFeBatKUFCLKWvx5yJbeT
         5Qx1VxOPeyvaFaoXRtLmyk0qlo0WTRsparE6kqhmc0IU/f/WgEpgNSlfeb+MHkJInpCD
         lTvqiqdWezP6BJeWzy5XyIPPgmPj5NHGueBIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739401195; x=1740005995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UORAExcOb6F1C8aB2DrPpzefAFwPpCu6YmtRKkXFN3A=;
        b=qcLDe+estlWKP5hwzQjzIZnM2JcPWXLMKJQOX0UhI1UaFG9qXUIkzWm8C37rpfCKOS
         xiRkFRia3vCTUgi8Jgt1fsiyIXUEacsHWh9ZleLOaZIS0n8nSLRSZ1BMuvy0vzzL8YsJ
         fsn1y2xrS3KQKSCeLmPkTjTxnw1EMNagHFwjdCjBc+yf1mXwofdobOMVS1c856QDoDRW
         oM9u1xa8LnQ/DsP1L9hhTuQAFaz2FPHhd7NT9OKsS81+64ly3APN59L2nU6vaKmlyOLr
         FeNhUUjXhCIz9YaQaPYp1HjX2o0orM6Z0CvQOkjhvf5MGmSjrzBEhhshbVR4mIi4sDwC
         juXw==
X-Forwarded-Encrypted: i=1; AJvYcCXMH5u387O9KbEW0FZ0BsaatQ606fyUZKGi4JOdLNPzlSXT/L4Wmse9yXHNFTerk3h4yPBTYl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx337+RmXXSwM+bLFLWV+MwoqgGPqLVDb0WutmEKJ/HhbgnzzVi
	JhnLcVEs9WlPYxuNj2/z3HigUWGKcdm/jdSJVsTq89o2Q0WODbJ5uFFTCvzCxCgp57kalQHhQDo
	yKoHidhsJ6IlQ6xR0keXIiZDFSSuQA4KW87tg
X-Gm-Gg: ASbGnctUBS6/2+Ist4FnfJgFjA0IpzCoDh/6oj/8OexukTIcbceTX5Vvzz3ZvTsV7lO
	TANPHOYVeQqGLj74GeA3iRAVNaUUSpHW2iQOPyk8Oiyi2mXTrrSY76jlORJ0rKTkUzU1lqtz6KQ
	==
X-Google-Smtp-Source: AGHT+IFbS/AhpfHNHesmEtNjmXm8Vi4x9pOaPQgLDyY1nNWSQltONPWk5O0y+1kn8uARNHcBpgksAGvjJv6yN4RJqzI=
X-Received: by 2002:a05:6402:210b:b0:5de:5899:e735 with SMTP id
 4fb4d7f45d1cf-5decb909bb2mr624362a12.14.1739401194824; Wed, 12 Feb 2025
 14:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
 <20250208202916.1391614-10-michael.chan@broadcom.com> <20250211174438.3b8493fe@kernel.org>
 <CACKFLi=jHfL2iAP-hVm=MmLDBD+wOOHrHsNNM21dCRAjRu7o7A@mail.gmail.com> <20250211184305.2605e4fb@kernel.org>
In-Reply-To: <20250211184305.2605e4fb@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 12 Feb 2025 14:59:42 -0800
X-Gm-Features: AWEUYZldQClwe33uZdoZHUv41VXzxFsGfWEhlgDL625fhpk_LLmFPbV6Cbuh3O8
Message-ID: <CACKFLimn1pKDJH3QSi+X5adhnHy_yLV=LJ9fz6_9YB_G64xf-A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 09/10] bnxt_en: Extend queue stop/start for TX rings
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com, 
	helgaas@kernel.org, horms@kernel.org, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b7d8d062df9e6dd"

--0000000000005b7d8d062df9e6dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Feb 2025 18:31:21 -0800 Michael Chan wrote:
> > The ring has been previously reserved with FW, so it normally should
> > not fail.  I'll need to ask the FW team for some possible failure
> > scenarios.
>
> Thanks, expectation is that start never fails.
> If the FW team comes back with "should never happen if rings
> are reserved" please add a comment to that effect here. Since
> this is one of very few implementations people may read it
> and incorrectly assume that allocating is okay.
> If the FW team comes back with a list of possible but unlikely
> scenarios I'm afraid a rework will be needed.
>

The FW team has confirmed that it should never fail in this case.  The
ring has been previously reserved and allocated.  Re-allocating it
with essentially the same parameters should never fail.  I will be
sending V5 soon.  Thanks.

--0000000000005b7d8d062df9e6dd
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINzafYoR2YZl31KRL16gJG2C14gFN1gf
WY8mCPgqxu+PMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIx
MjIyNTk1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAHTqVmkcXtuCkBWT75cd2N3OtHquHKmw7moT3TYIhhPewj3MhE
RhyKjIPnetHAaW2IUzngYatkrMB+q37RG6O5BCSdhw6Tv2sr8zoF4WxegM//ynPXOeTicIuouz8c
xLBZcxTWh0YX997AZVvnqHIxxNcTFfc0LniULXsBh1RxZqfGj69VS3Gl/q8QJOk7gfUAcYgqRyzd
nq61X3X0tAKpzdUxX+Gpu3t82tCGQA1RHgXGSE4cuR5RPU26mmI4yRrvyohkzNUr3wkkjdUA8+wl
LIqLonmfk31n9x1H/YvqWVKRQypZ4W5FhTHm03aRE0ruc+N+u+qQendJM62UQDcF
--0000000000005b7d8d062df9e6dd--

