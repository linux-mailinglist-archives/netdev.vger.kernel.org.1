Return-Path: <netdev+bounces-193723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC68AC53C2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177A31BA40C3
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0727D766;
	Tue, 27 May 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HyH0/u1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCE194A45
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364674; cv=none; b=Vg317drxS1cKQINUNRUTyURJtw+rHJ8TfTGAfLbzYnFJGqVBz09ekZH5oTGxzWTSZwNu24Da6tWyny+IIaniiubD3auskk1s6St5lddKFfvohd5Br2+N3ZMf4gpA5504csYIDnx8Pay6gMjzkqfwDLSVOy8VizcEx4Aol2CfkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364674; c=relaxed/simple;
	bh=pSZrj4BGAAe3y+UpvKYxryamqpwpASX2Ytb7YvBa92g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qThmJupojLPY2GZjvSzURbIoanbs8YGR8Ioy6wka11x9rqNQyfvQ3X1XFTqLNqLGiJvXJGxl6WHOu0agHl80M/FrLXDW8rVJP1AhM2wmfv83QnSVDrkpp61ZaD77o5p1wAvNGGIb9/oQ1LUOyMLwJATBTAi78oxKNejyZ8Qt0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HyH0/u1y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso6919897a12.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748364669; x=1748969469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYzEDg4YbO2T8FooF40zPs6ScqjRzK+7u5BkQTM3l5M=;
        b=HyH0/u1y2M0bgz/lpU8U82zOqSqhhT3aLORl/RXQm5mafQDYS8QnVcxpxN/MqpXn9o
         6mLuehtl6cPP00UEz1O+nOF3SgH1s0Y+1gBePJ/BwYmiMb6tX9o4JM1wA7SzZaPTFbjD
         9foIPXQsweS2iDPyMOGuEWOcWT4YykidK/AEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748364669; x=1748969469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYzEDg4YbO2T8FooF40zPs6ScqjRzK+7u5BkQTM3l5M=;
        b=ro5upm5AO6xPZLuMYbswpN8GG9pEWCxeVK//9I2whgx4K7KOG23ul5jRFbguglANsh
         NJzwi9luqUsM1GTEmx75n4Dy2gJtwlswDgruu6jYGns9vdCkv409aZ/badZCrUhIrBaC
         qlnODjY3TJS79gOTAdwD6jVfV0tenOGX8vV8oa8rttuPnaW8AIFaLzb9RCRIpUdhysCx
         Gblm+mCaUVb4aEbZGQyV+f1o5jqYrtSkTIIxBX4Pm5GwEMfJL92kfdmYr55hejOLNvvO
         dWx28Ynt3VV+oscUzVg8hraFLXXFN83WKSt/ni74vNGnHtfeU4xfNEmwh9LYcoWJSu60
         KBGg==
X-Forwarded-Encrypted: i=1; AJvYcCXeT9hemPVaGiPgumn9nh8QkGDw6uO2oCoKYoVrCjiA8gqQaTgzgRutRcLlwJuvMZ4GTUZOSp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPZWAyuvtkeDXHjiMN6HWgdgzkeoKJF+ifSIFZFxFp/aZ03gb
	7ofOhsiwbc7Pz/LO/qBhsvRQ5srf68n8KfRUr9SXnj1bG611THiLe7Am9hw9iavNUntBK6MEddZ
	dy6MGBSS5iNEsFpxY7sznfFn1cFO24Kefv5OO8itV
X-Gm-Gg: ASbGncuOZh07E2lJUq+4tN88KTybUoQXV503wgKoFHSEse64e8rSoXusnJg90jXZt4p
	f32LEtfDkk6du29ivtuI6YmpmKTg/3Gd+Se6EqJaB9DN4u6JUF0ycjTii1y3eeWuRdvrIslCvvn
	0BB/Bw1ihTn1RlqMzvceltDvFPWm2gY3tlmg==
X-Google-Smtp-Source: AGHT+IEcn08og7jo2PmwiRLPdsNWwff3BZ2ygW9b9J35DgLuBzXpu4wdRWC3S2RAxxgfdUKnV/8ABHJajkOW0fSmnug=
X-Received: by 2002:a05:6402:350f:b0:600:1167:7333 with SMTP id
 4fb4d7f45d1cf-602d906c71dmr11349160a12.10.1748364669584; Tue, 27 May 2025
 09:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com> <20250520182838.3f083f34@kernel.org>
 <CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
 <20250520185144.25f5cb47@kernel.org> <CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
 <20250520191753.4e66bb08@kernel.org> <CACKFLikW2=ynZUJYbRfXvt70TsCZf0K=K=6V_Rp37F8gOroSZg@mail.gmail.com>
 <423fd162-d08e-467e-834d-2eb320db9ba1@davidwei.uk> <20250522082650.3c4a5bb2@kernel.org>
 <ff26ec09-6c00-4aff-9a18-25bcc4a3a5a7@davidwei.uk>
In-Reply-To: <ff26ec09-6c00-4aff-9a18-25bcc4a3a5a7@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 27 May 2025 09:50:57 -0700
X-Gm-Features: AX0GCFt0MrtDjlci7zjeD0aPWCp_RAdlpp6eyb1STStc9R9Uv37iVhbL6vvXj1o
Message-ID: <CACKFLi=P9xYHVF4h2Ovjd-8DaoyzFAHnY6Y6H+1b7eGq+BQZzA@mail.gmail.com>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000017616e063620df72"

--00000000000017616e063620df72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:37=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2025-05-22 16:26, Jakub Kicinski wrote:
> > For ZC we expect the queues to be taken out of the main context.
> > IIUC it'd be a significant improvement over the status quo if
> > we could check which contexts the queue is in (incl. context 0)
> > and only clamp MRU on those.
>
> Got it, thanks. Michael, is that something the FW is able to handle
> without affecting the queue reset behaviour?

We are looking into ways to limit the reset to the VNIC containing the
ring being reset.  If it works, it should address Jakub's concern.

--00000000000017616e063620df72
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEB5xkciPTr/psFcK9Ahh9fxC5/tXVkL
x7Fh7HonMvdGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUy
NzE2NTEwOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAJU/0eNa0uk0+A9s0W/qFrbLXDFStOGB0jyFuj4fqQoKOd6fmKyzvhsq0wGc6Lgsm2Zg
I635+byBUl7gmRF/IMEHWXyHgiVarBGafOzgDFD8Ppbhw2tn0IHcKEvEXbBOFWQHfbemiwNDfT7Y
WsvrFL88HULAoyfVjAXtvARv9ImPpDV1QJLLx/UZL29Sr2lkC50s9DVjUaj7lVSN4bUM5Rv1P1g8
Jo46Z6NfEx70OrRB3T9da7FgnRumNcnaACf8KVYJcoIbhlnI5+7Po4u9q+liRNKrMbLm061RW46d
a/6ISPkf0vIhMiZbmPXs959J+0Y0qukILkXTSetJYOwxt5o=
--00000000000017616e063620df72--

