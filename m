Return-Path: <netdev+bounces-183516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E6A90E70
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0B217E799
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D814C24887A;
	Wed, 16 Apr 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NCG+7ieU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07702946F
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841280; cv=none; b=Nvk4tt3qxTuSkWxwt6nRAYRjf26axIqzSAkkwgo66MOs6NZ0vG46OWJ8Gpbke8CFTGo4vnkJe8C5OOiH0c3C9V1TdIWlVTzSDE1JeoTwyK5eTxNx2DiQGrz7MorM3JiqQoI77w7FNNp6VhmffRH+XiVDAFaSVWAb94lFbaxMgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841280; c=relaxed/simple;
	bh=BVUe+IzR7ZXlW8RKOqTElj3zn75d8Ieotp5q5KDMRmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVV/cKgf6K/mktBVdWvD4FOGR7oZQrOv2wQeKoML+C3NOLKWjuDoxdzQOsur/0kG/I1VTsrIXR+knO8dcOw3QEnG+KFoY3MX3HZPzHF5LQPGqQ7LB3VrQA9IwTxFkguYYaiTAw+Yum2VWFCZ/5NUKRj4IqE399PCerSYqbs8xKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NCG+7ieU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so241333a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744841277; x=1745446077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMDmi7vc2WdhqTVTf120SxoGBnP5lcBR/x9EGcZpj5U=;
        b=NCG+7ieUHbqFpcji2rmXXSwuVQtUsLb8ptMUSHpYf2T8hRhgDGyvGe4D1/Pgif+tM1
         bkgTCUhJzvB1UwQn+hSP1Sf2kEpjYpbN9mYNhoVGiWs1CAvyJG7iCQ7zhlwWw3f0rM9z
         gMM0Utys8J6ZVhcCazTtPNjnYB7AxlHZDsaMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841277; x=1745446077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMDmi7vc2WdhqTVTf120SxoGBnP5lcBR/x9EGcZpj5U=;
        b=aFpp5lTO5r5jR4I7b+hudMw+0te6WSeiGD26RbI7b00L6hGVEz/9e6bGwJ9k6BlQ9S
         mu0Qln+KCni+R0uVQjxUMFFBfX4Wvk48h+aDtg+I4541W6IvQQNqZB7gPA1V9T7BcedA
         MMIFQwGnVIwpH31BY5ymtTKYN3QhNDeG+YH7Sz73jOZfJl1OhkWKinz1IVKn748jPvZR
         N4f+bavQGQwBvsRlYwBZtI3MX/6DUjw24DGrK4oR99VTj17e8TKYLhYF4GVB8Q/iwJHr
         NTGWWgdeXnbiIMjxciVjxi79cL3A0N6Oj/kFytowavYPnAUWKD2hQB9LiwiblKwpl4Kk
         nMkA==
X-Forwarded-Encrypted: i=1; AJvYcCXV2Unltg9996fEWQnAwJBgQUq9tp07dI2Zme2Vqw6h/0RugggJtkbddbnMkWXVWlIvf1WpTQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCVI1vWTaKTBmQgS0b0JJJiVnwFwRRAffhIPpZrAIhZwdNXw3
	Bb18hgERLyhrG1IiIhsR28KAD8aQ8qPTfz1o17w0e0cN+ScVwQXUj135D3Me450W5EpwXyF/fL2
	HHcsd9/eTq8dk072F3wajt9BZ9IuT3SSlgmnY
X-Gm-Gg: ASbGncvkWLqtW/URI89hyZlTAVb0ePJeKABedbH4t7S5ssRlN1NfQECWZUVlDcyHCPi
	X3cwQh2feaADygcvjt7Z8MQcp7KzJD3wFc/8ciDJU9ZHWmnEHjS6uhQzHcGsoInwaMug6L+A4zf
	2DPWj3xatlqQkLji7r0gYmGTU=
X-Google-Smtp-Source: AGHT+IHLyAXKItzQdlcTuJgTvAOY9KmS1OamUiRHrr30chdI1GRjwUKnWblBnH7NOl5mUN8GanlXCb7KrYayszofAKY=
X-Received: by 2002:a05:6402:2803:b0:5ec:9513:1eaa with SMTP id
 4fb4d7f45d1cf-5f4b75e2682mr2971751a12.23.1744841277040; Wed, 16 Apr 2025
 15:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
 <20250415174818.1088646-2-michael.chan@broadcom.com> <20250415201444.61303ce7@kernel.org>
 <CACKFLi=tvPJXk4zFXxFzWftc-AVU+2m_cg+EFTzs5MSoDoWFaQ@mail.gmail.com> <20250416144447.1fde7ada@kernel.org>
In-Reply-To: <20250416144447.1fde7ada@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 16 Apr 2025 15:07:44 -0700
X-Gm-Features: ATxdqUFNQWYxZB0zdX8hPjQUl37VDl93NzuwKxHipej-YScHr1luZoxsvXLSdiQ
Message-ID: <CACKFLin0j2+JWMWoHBAhzQDLmequ-fK4TOO+9hdfm92CoOyZ6A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] bnxt_en: Change FW message timeout warning
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008843a40632ec84f5"

--0000000000008843a40632ec84f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Apr 2025 14:41:10 -0700 Michael Chan wrote:
> > On Tue, Apr 15, 2025 at 8:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > > sysctl_hung_task_timeout_secs is an exported symbol, and it defaults =
to 120.
> > > Should you not use it in the warning (assuming I understand the inten=
t
> > > there)?
> > Yes, we have considered that.  This is only printed once at driver
> > load time, but the sysctl value can be changed at any time after the
> > driver is loaded.  So we just want to use a reasonable value well
> > below the default sysctl_hung_task_timeout_secs value as the
> > threshold.
> >
> > But we can reference and compare with the
> > sysctl_hung_task_timeout_secs value if that makes more sense.
>
> I see your point.  We could also check against
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT ?
>
> I noticed that some arches set this value really low (10 or 20 sec),
> it may be worth warning the users in such cases.

OK, that sounds good.  I will check CONFIG_DEFAULT_HUNG_TASK_TIMEOUT
in v2.  Thanks.

--0000000000008843a40632ec84f5
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHQjuo7ZCmKev3mhlHwPBtaosIT42s67
8YNzuT0hpdUoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQx
NjIyMDc1N1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAAID8NPF+H8krQiLXwpTul9oijkIAjAqp0dEUxbKxltwPdch32ELixxaxWVS7BM3EPK4
mQdQ1XV/LqVqQzyjqjrTNlZreL20Vex+ibO0pc605A0SJdgXgH10hWCufFyyMUF0RE3kEuf6A7So
wsl7M9cleHfbgDVApzoMh+A2AA7hyDjMrf7wjv1GMCZCk2FOhUfS2/y9OmI0c5lvQJPyC4KsJ7Ds
SwDbQ09gaKEH4XMeOYmAAFcXQlr34hFcHD84bL6CazUyinJS+wXISCsBxM2+hJNLdTRz4LVLcxQa
NUtuH5AwAF25feMqBAQYmcuZeMIxc6CUurTEFYUZDzJ3NFA=
--0000000000008843a40632ec84f5--

