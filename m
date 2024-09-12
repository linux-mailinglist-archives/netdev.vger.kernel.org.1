Return-Path: <netdev+bounces-127916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2739770D1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC851C24AB0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571E18BBB4;
	Thu, 12 Sep 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P3/VtViT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DA4AEF4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165771; cv=none; b=BCz/z9/mxI89u34RNt18g52qsJNau5AHHt1KkOi28H5Otsz45sepuBujgPkK5GKimFqYLN3zFWfIaItBG9cEkZCTJF7oydMsTVJHjU8zeajG1sq8O9TQogg6Pe/PQHnwbib4LdFYSpWex1Uw+Wa/q9S8Gacu7dbxkgXNmxIiIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165771; c=relaxed/simple;
	bh=HZI//WySyughwcD+Btxs2LG1gz2BCMAMQr3DEaS8ky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HskQ2trge2B6Gffadf3OIjtpysMiR4JS7IyeC/V6I91vvj+D8Qj/nynSmG8naPxyRK/oPTwdXlCaKMUU9GKc0TDMyfJdCBGKiXvMp0OoTwCsdMvigkBODgNM90kXig1nVNyMEJVhB2++cV266DyssLuCns5/A8M4RwnvCqGA+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P3/VtViT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so1660632a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726165768; x=1726770568; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOB2WcL9RquLUjHxKpnc/JbDeyP28VrxUBkxQrzVXUQ=;
        b=P3/VtViT3WM/XRzIWL965pMkL0+5ONrtYQgxvl+qKKLr6nAJPOzphLY1CcoZElsv8G
         Mx6WPkmNcMFIrJtWT9BZu8N0TO1sfNgTn1WBNYthtiFlaXIPKtKA9KeR4LNk16ELuWUb
         YyJmej+ueZHlVjdL2Qh40meRrSKy5/kgF//6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165768; x=1726770568;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOB2WcL9RquLUjHxKpnc/JbDeyP28VrxUBkxQrzVXUQ=;
        b=uOA/1bfAdsTk1p0GpwNXsWjcYRgMuMYsBcFSlGE+YWnAPNkTuAniH25mq5hyl//bH4
         4UkN3Z2bb0C7uPdGvimKiG1/gqnA6LlI9JfHhnH/ogSUWcjIDwbQUbOcOS1hHABGmObg
         RSf7nHHWG9n/EchbvYrUUoRd+YMHsH7T6SL//Yd5yHoC2DDj49kjCHazQwlcVIcC8sP7
         tc3YRTSmfhtpaGFhDL5MG8HXB4FKbVvJKK+G29hOaybP2GZhPaG2KE1DfXf04IJxRMX1
         5R99yRGWrgs3ARmnHzm7tRSXBOiMMuTyPWdAWCH/fxpz+9Ddq8hD3TdSJkijHU5rBw4X
         3IeA==
X-Forwarded-Encrypted: i=1; AJvYcCXb7ZSd23llbyXV3z25yX9/9xKuFibWxnHdgkkLqW4zD5RGwBVuNV2O47VkAFhffeD0Ai1N96g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7wvKXmXLgUCFgxXz/1hYFmk+Pnnp49J7XwTLMOcbt+Sek7ON
	8kQMJSFR1uAqHgDJLFTX28iBfLMIT4926lR2Y8u708OuAVujntWx8CPNsHy0oDsvhh5SgRfhQ1e
	71yYVsEddQjlt5He3+/7ASXZNZ08VLnCYv82m
X-Google-Smtp-Source: AGHT+IFU5FI6NTA1/YF+IHQqCd33p2NKIgM28S8xG4PTVKr9YJ9+pzSSAFjo3RDfkyjN8kVKVxHSp471X+nRPoIpidA=
X-Received: by 2002:a05:6402:3548:b0:5c2:5f1d:e1a2 with SMTP id
 4fb4d7f45d1cf-5c413e07f9bmr3175626a12.4.1726165767444; Thu, 12 Sep 2024
 11:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155830.14688-1-jdamato@fastly.com> <CACKFLimO60wNu3VggJ+cs9K2SBfMBtATCFxZ+3J1Hy3dbfLOCg@mail.gmail.com>
 <ZuMvY6_MolZYMT9m@LQ3V64L9R2.homenet.telecomitalia.it>
In-Reply-To: <ZuMvY6_MolZYMT9m@LQ3V64L9R2.homenet.telecomitalia.it>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 12 Sep 2024 11:29:15 -0700
Message-ID: <CACKFLinpY29JQoBMTw6z00GwJVXLDvJTswTS=VMxki7SdX6R4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: Link IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>, Michael Chan <michael.chan@broadcom.com>, 
	netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006dd4320621f0490b"

--0000000000006dd4320621f0490b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:13=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Thu, Sep 12, 2024 at 11:04:02AM -0700, Michael Chan wrote:
> > Looks good, but why not just add netif_napi_set_irq() to the existing
> > loop in tg3_napi_init()?  It will reduce the lines of code a bit.
> > Thanks.
>
> I made a separate function because:
>   - tg3_napi_init would need two calls (once for i=3D0, and once in
>     the loop), and
>   - tg3_napi_init and tg3_napi_enable are separated in the driver,
>     so I figured I'd separate the IRQ linking, too.
>

tg3_napi_enable() needs to be separated because it is called in
multiple places and tg3_napi_init() is only called once.

Even with 2 calls in tg3_napi_init(), I think it will still reduce the
lines of code.  Or we can do this to do everything in the loop:

for (i =3D 0; i < tp->irq_cnt; i++) {
        netif_napi_add(tp->dev, &tp->napi[i].napi, i ? tg3_poll_msix :
tg3_poll);
        netif_set_napi_irq(...);
}

--0000000000006dd4320621f0490b
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO442C4aW8iBNsUP9ZypAKTOAJy4acwB
5Dyw5cfSFKK+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkx
MjE4MjkyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCNSzaidbh1UurJg9ubfIEL16GZhdYLQWYxm0vkFsnFsbJROoug
QW2TNRQz2+Ja0mUjmHn0z6sqb2J+WqScH+E1kXCO4l6krQ8wzBf3qKQA6bf6li3tVWNMq9UIVECf
Cli5daPuKwGyriGLZYr5lAwyOvVtRrBsJt6h/6zE+8c0Oi0oOxBfONDWWYeGzwblm/zczfgv59bw
M6RZOiBA1w2lpz7StlPjGscfs3k1gD4KShMfEabWcXESiaxZN87GEAl7C4Dki5fyyIAJM+Qgtk1o
APqNUk2CDQrRkQQiDy6a7RXUthl3k20w0LLapBPzds753By6igG5b3C76T+Ud1cV
--0000000000006dd4320621f0490b--

