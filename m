Return-Path: <netdev+bounces-188875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C949AAF1FC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 06:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5564E0917
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2A320012B;
	Thu,  8 May 2025 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PyQSEj+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEF19DF6A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677422; cv=none; b=bQNxloZwXDp/ekrQy1MPuclnFODb6DdJYbWhr7BLO3LcmF2C3bAw1X9hhaS8nd2ztiRx+ChvNog+dhNC8yzcv7pkj/E9nNaEoAs0eYiLAI+4JkYyG6spShyO+ofCuyXPtMjJv0rTzbCaHBe4Q33RCbr3LGI8kSl3zOd99p4ZOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677422; c=relaxed/simple;
	bh=HqviJ1WtvOooafQmrkybCz5iCbVBddU8G9WSbtv29NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpF8BIVuUFAJeI9DBV14MhJ3bBApde2pVN4qTyFeQ5CY3mOCcvHyfPG2wzKww7CNmdroEkOWbi1H33xdPQ33JVM95ha45DHwKzWT3+rRIM8QwtEdGAlWDzxzBQimE9HMR0t+XmGUqnyzvyL9zd3+jrjhHpdi5gx07GGE5u7tsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PyQSEj+h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7403f3ece96so928572b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746677420; x=1747282220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7xi+O4PSPhAWXqIHLh8LpL32Ge9LdG/jkOUakO1Yzw=;
        b=PyQSEj+hFrYdDVzGb3dZiPW7D2bvKdM6rdmG1/6JgCJ64P6XtFWPN3RsCYkT9fPNB6
         ZmjDsPrQhWDf62ujPDQpeICDaqovoIYHv2rAtKctCSEeF0PLWUCmD4GbwgVpAH0pHDL/
         BKRgQWwOpdQKbpiUVj6pivAfzNKyatfJk4b10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746677420; x=1747282220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7xi+O4PSPhAWXqIHLh8LpL32Ge9LdG/jkOUakO1Yzw=;
        b=voymG4dvgEsyknSWmvUvh2TLtkK+Inmg2UHF0gReOGyL5a0ZoPWlW+BmwUMShzN43Z
         JCw8xfjjdgRblIECWeb/634ZKf5/isbLQei3oqbwxNiVvO2r3Qst6yOivkTPiIQnatEX
         2h+FA19KlTDXh5RNYQf58qj+Se62OxF/ztV0JdaQfDwetYj3EHl43ItMNPW2osbFc1Dn
         JqiN0TVwgczLZ31nj0d0VQXGJGOMsBuScYrva6cWCGYhTp/2Z3e33rhv1r9DobpYOk5a
         gaoneeQCMfvkiPEFboaSnlGb5NLCnWcXQpAgU6r+2XD5bgEad7ZB7ohn+LUlqs7Hf4yX
         0Kiw==
X-Forwarded-Encrypted: i=1; AJvYcCWvTpTYk6MxhbVE5tt4HJRNhzgVQCiXlRZE9oZlykg/iIOSWEoHWMZQ2+kT+sDXlFtNQu1nJuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJsqUCr03dDzNr5B2bZiYEdU0RCTWG3aKbhabUNrhUYjtpLKK
	3OpdZNA8ghwBnjZfAFDJuuBF0ghugN3rgL6uWe+sm1xBUUINDvC9Ziz504kaL3Uq4Lm5BTHnqcZ
	a6GYwzI5PVObprPzf9HRDR4oyt7Whze7Jv1zD
X-Gm-Gg: ASbGncumHbGUbcmmkRdfN9Tmgl07pLfovmJOJev2XeLy6Nc6z2m2yAE7ev/MsyRBXT2
	riN+RcAiNYq72iFOCv1QoNtWL2ZofF+Gs+aABGYnQgK69rFToYiV1/hMcbB7tiUQN5uaKEQMboG
	mpsbD1cGjFOyhs7bpVedCuCXs=
X-Google-Smtp-Source: AGHT+IF5Dr0PzNsqozuZEY7yGvyc1ae/PouxRhE1+PaQj0TzdnPouRPWJmMrEi9HOPWPt/QSwn28/N1tj3OWL8vTYOk=
X-Received: by 2002:a05:6a00:23c2:b0:73e:23bb:e750 with SMTP id
 d2e1a72fcca58-740b43d328emr583132b3a.23.1746677420305; Wed, 07 May 2025
 21:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com>
 <CALs4sv2vN3+MOzRnK=nQ_uMXbR4Fi8xW9H8LdX79vYA7tHx+2g@mail.gmail.com> <CALjTZvbopTcm9P7Hp1ep54R3_7yODg7r4j=OR2y3WOA1X84e2Q@mail.gmail.com>
In-Reply-To: <CALjTZvbopTcm9P7Hp1ep54R3_7yODg7r4j=OR2y3WOA1X84e2Q@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 8 May 2025 09:40:08 +0530
X-Gm-Features: ATxdqUG1vmXzQBQ4O7kO0toLnsIrMrC5-ZeIRa7J3DYeS9Jn20mw6jwB4F9--H4
Message-ID: <CALs4sv2DgtkcWtMSsMiP9VLW98+5T9hz13j+O3qnqKYce6G+qw@mail.gmail.com>
Subject: Re: [REGRESSION] tg3 is broken since 6.13-rc1
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: mchan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000321f9206349807d4"

--000000000000321f9206349807d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rui,

On Wed, May 7, 2025 at 9:44=E2=80=AFPM Rui Salvaterra <rsalvaterra@gmail.co=
m> wrote:
>
> Hi, Pavan,
>
>
> On Mon, 9 Dec 2024 at 16:30, Pavan Chebbi <pavan.chebbi@broadcom.com> wro=
te:
> >
> > Thanks Rui for the report. Sorry, I did not expect this side effect.
> > I will check and post a fix/revert patch.
>
> Any news about this? The patch you sent me off-list is most definitely
> required for my machine's tg3-supported Ethernet controller to work at
> all. I reverted it and did a quick test build, the result being...
>

I am trying to find out how the current fix that is in the tree is
working out for the original bug reporter.
He is yet to get back. But I do understand, irrespective of that
finding, you have a problem that is affecting you.
I just don't know why you need the regular DMA mask also to be forced
32b on your setup.
I will check again with the original reporter and discuss with my team
and try to give a solution.
Can you please mention your model and the make again? Let me see if I
can find one in our lab or near me.

> rui@happymeal:~$ uname -a
> Linux happymeal 6.15.0-rc5+ #169 SMP PREEMPT Wed May  7 15:05:44 WEST
> 2025 x86_64 x86_64 x86_64 GNU/Linux
> rui@happymeal:~$ dmesg | grep tg3
> [    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for
> consistent allocations
> [    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error =
-5
> rui@happymeal:~$
>
>
> Kind regards,
>
> Rui Salvaterra

--000000000000321f9206349807d4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILbtOqI8LCLCHgkPbgLfNrlqc+Zsl9yF
WsGbKyU9jTEzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUw
ODA0MTAyMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAIMja9psO5yBLXxLP/auWrVhLZfSZMBEYxuNc0p0eV6/9gsoz8vxtUV9pIH1gouFIjrG
T0/3bKhUVVGMWkVqRvsN9r7qSyez5LJaLI8e+SpdR1JZ2c4hOWt/h1D9rbR7Bs/3apKIe8Ovh7X0
Q3J7dwcujJDb/cPM5XjVhkPKJtN9DuTe5Szf3tCZWIdeQUiuwyAEE6JB6xkGC28C60wzD09DOrlc
We/FZBlTvxyyDIheTQgvZUQ9/KQQOwK4DIx0koBzuPj7RZbZg3WBSKjgrF0NgGkcB4C1PjrFN7W9
uZIgTsWzvvhI/ya94HliRYIxChLr4mLCkz/uyEP6OkJkMKM=
--000000000000321f9206349807d4--

