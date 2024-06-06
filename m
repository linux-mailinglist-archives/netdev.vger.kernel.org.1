Return-Path: <netdev+bounces-101325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB98FE1FA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30461F27AAA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96913FD93;
	Thu,  6 Jun 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="deUfUWsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F013E039
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664312; cv=none; b=aMDlYK8PxWKmmDI9XCaTxcJRvRkAXzr3g2TbDIRHILaQ35zoEkja7OjIVgRxpc5QP1Lb7gMhl4+SfHp4UR36LzQvFdMZZO2fdaTji2n2XafkphDIVJd22oSJbZwna2fsRDiSrknqFDYL8Z9PuanYAiPCSxrmjdAiK/ccM3FFAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664312; c=relaxed/simple;
	bh=EPeDsK6KuMBbuB6S5u77PfXNSUnY2hbcjjEC7Vyr3j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1ksIFt2Bh1sFkjQGo3vI8ZijfmzZGHki1cFzDrPD2AM8Z071ZFv7Mn2cMiZ9g0hC/0Y62GlaCOJgU0T3uW9iOgyQn3Hn1Rbr3xNGddBut0jUr1IMShZrxuBkUMQmB0EwES3ISADWXFYmNiK8lBeXoZgqzYHlQ40wIoNxGMcJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=deUfUWsN; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-808ea48ca46so233938241.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717664309; x=1718269109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LyD4zYWN0+Ixbmb4DFX7iy7Za9FM3vzSd5GpKeUrpXw=;
        b=deUfUWsNED4MOUQabxUHX10A3o2xOw/7h+ij/x7S7he+3Bfbw1EP4V/rt1kIpdPLrf
         HTOTIsgcN/7WkvM/Y6/SkOspbCh4vA4yQ6zsXYKpKgN8MWoXKzCf9ZQxpkY6DcH+eUZr
         NDTH3N+YtTTPQ9U2oE/q08ixls+Vqwl6i/s94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664309; x=1718269109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyD4zYWN0+Ixbmb4DFX7iy7Za9FM3vzSd5GpKeUrpXw=;
        b=pLCJ9+CKLtch7lg78jR2MdklvT/GuwzSZdu7qRIfP+cERDkY9dd8fuWYSm3M7s2SKn
         zmtgspZdwRvBpwLjgXG7nfmaCptXz54O2KxNG11dcielubDgjAypY8nwixqN4A09MEJn
         n1UXXsz9r+dInu1zCP04PDNj1c9LaIvnqU6yZzSwj0XsgP84V+YKfIQFhovG73knDeky
         VxNeaAW8Uhf1JuJd5iYrt5zd3kKq5wFkpziOABuLxDPNDwNOZKVyKZaEJOtNzBIwkAcD
         DqkCtQ6Z0RTAIcFwGfxPbY23euG3hNHfORh6D+mNnftlIFbnoF1g+ySPWXV9xVD38sld
         QHZA==
X-Forwarded-Encrypted: i=1; AJvYcCXy9qekvfFyUHchr/5CGOTs6AABXQ5VbjMsinIbSDEIz9MA/NIjvMRrAUlq/9183SZ73RNmAlmnmecamMI1+eQKqfl47VdE
X-Gm-Message-State: AOJu0YyFX9At+nJ1F3oQ0MXpS6NCizTH7sIUGW78DOfZzp86jHvU8ZlS
	3AZvtIWIp0QUy62uQoH4hQbjweva508vM29qEH+KD1zZCPHGUWOn6PiS9AWjHyfvG8QaYr1lKsk
	5Tkn2GLV7ocMK/oGEmgjj4sqaq2hCG7b8rsMf
X-Google-Smtp-Source: AGHT+IE8OlC5dMl2aGL/NyF+YLWRIIM/LqaW7TZFDKkJfpGQ8ZRwQyq60n8rwwMq+yDJVkOL+4PgMlWuRs/54ThpUqw=
X-Received: by 2002:a05:6102:32cd:b0:47e:f811:747a with SMTP id
 ada2fe7eead31-48c0485d8c3mr6786310137.10.1717664307883; Thu, 06 Jun 2024
 01:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605161924.3162588-1-dw@davidwei.uk> <CAHS8izMWBDm5VDYOeJDy5J-pbLtsiBnP801PC17XAbzCb2oe-g@mail.gmail.com>
In-Reply-To: <CAHS8izMWBDm5VDYOeJDy5J-pbLtsiBnP801PC17XAbzCb2oe-g@mail.gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 6 Jun 2024 14:28:15 +0530
Message-ID: <CAOBf=mu=4TE3qd-p5J+fMPNud1cgqxrkAjYEw7JOpRycru6BHA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: remove WARN_ON() with OR
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000645f3061a34e3fc"

--0000000000000645f3061a34e3fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:01=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Jun 5, 2024 at 9:20=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
> >
> > Having an OR in WARN_ON() makes me sad because it's impossible to tell
> > which condition is true when triggered.
> >
> > Split a WARN_ON() with an OR in page_pool_disable_direct_recycling().
> >
> > Signed-off-by: David Wei <dw@davidwei.uk>
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > ---
> >  net/core/page_pool.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index f4444b4e39e6..3927a0a7fa9a 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1027,8 +1027,8 @@ static void page_pool_disable_direct_recycling(st=
ruct page_pool *pool)
> >         /* To avoid races with recycling and additional barriers make s=
ure
> >          * pool and NAPI are unlinked when NAPI is disabled.
> >          */
> > -       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state) ||
> > -               READ_ONCE(pool->p.napi->list_owner) !=3D -1);
> > +       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
> > +       WARN_ON(READ_ONCE(pool->p.napi->list_owner) !=3D -1);
> >
> >         WRITE_ONCE(pool->p.napi, NULL);
> >  }
> > --
> > 2.43.0
> >
> >
>
>
> --
> Thanks,
> Mina
>

--0000000000000645f3061a34e3fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICm4keW9XHGYYGTH2rMlIkOVteEL
qHhA7uRd5U03OXwcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDYwNjA4NTgyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCZPETVP+2dHrMy75fypiZ6Q982rvGuwRPySMW+ai13m74K
BE1EIdU/Gj3bMTt8sFgZJBEF9KBPmrLtdHFcUBlGdSLL+8LlIlGPvqY0fCNxXwxgxlId58ilDjbD
zchZgd6OQb1EoliTaDFQzPk/v4VkZZc8y0IwEv8zuKQOj5GW5IzxeAloYy/lI1bzf52a7zR2pmKc
4ahm27H+pSktBphQ30SHiZ5+SpC1i3QjvBIwme8e8ANcBf0t/IOmggdXqz7AkEabizUC4cywFiGJ
0JjsIcKbeVh2ml+xR7Cv5jx4VgMx+0wuOyWz/nIGnXjDA+atLJy1o+6lYNg9W6xVdqzo
--0000000000000645f3061a34e3fc--

