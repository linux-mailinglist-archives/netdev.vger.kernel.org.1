Return-Path: <netdev+bounces-142639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A479BFD0F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886E11C20892
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5117B402;
	Thu,  7 Nov 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H3H+Fd4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF1FBF0
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950976; cv=none; b=W50quAnLtmBgXsA9F4Fr3fc6n1Q70yzqK0v620aF9itx4QO3VLKI/Ecr8FV9Hh0uugAeOmCeTBc+0SiqcMRsYvjOD7htWA3bm8b8QYyP+Q7KQ8VXCnMaAr70G2vr1VIqFfCC5GtLj/cWK+912T3vlITRKApAu7vKoR20T5+/AA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950976; c=relaxed/simple;
	bh=YyqphSGLb8moAm4rSUeyP5hQxN7iaYVpPhr5f0ejr8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIp348+ZqKToYFYACPzaK/OokTm77ieuk7/+u0vH/gb3ZSvPurEnDxoI5jFHOhJ2FqP4zJ9trRofPQI9P/aSfc+HbazvEuoAPT4fjUZ1M4RKFHrLbMtminKHQIqQVymYYjgLDSVBq9n+qkZ1yGCmsm7M5qzkLdIc9avWlLotMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H3H+Fd4g; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-855eeff6448so216978241.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 19:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730950973; x=1731555773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jKwVnzbPNoX63afKY3nxCVjUfSvCXI6DT7tmFaBMzU=;
        b=H3H+Fd4g3mWl7pTwkGllVOelOV1CbB9iDHBSL32jfr79sXgGJENgVkKGtbEGOPkFpz
         qrs+Hfr09EGVr1p5LijIQxeZ7OkCfXUQrrg/E7EQErFlWgvg+ZWCwoutIo7CI64lzHwh
         8BLigg7VOMOBJH1sdJB1ZVC3xd/SGuBMcZU80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730950973; x=1731555773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jKwVnzbPNoX63afKY3nxCVjUfSvCXI6DT7tmFaBMzU=;
        b=V3ThIQLWdGP36NHvL3Xu5AJrh+jqlhOJKSXEPqd9WckGUEjYmAMcrImaCoUvKQq4ma
         HWXqG9mmW+2EsQdM+B6XlhUbuMLtLPneNoOf/H/BVnAwPGvT/ynuTdGUlGZMkt5l1wrp
         Ql8QAHKWgIen4gFMvext5ordtwm+DXtWYjb40et8EenBRWkSJZtKOShq1S42OVzqmGvz
         6vtdet71uGsXXZTEn2ihkKWypRO46W2N0j29WD339Hr7K8zxxKONpwifiwaICqgEcf46
         uVG6+LnXlm55akTMVQtlM0g7jEVzNywvJD/+7ExEVTGeW9wXiKcRQLYN4wQDhtCmpUOl
         OJQw==
X-Forwarded-Encrypted: i=1; AJvYcCUFtYreqLjYznZhdSPcbHcpHuJMzWMu8JWcDi/0JjzsXhMq72tLrIoHr9+BwHrl7L8w0k9BxvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzorbr9yJMpI/ix1h8PGetBTtfJWdFd0MKiAaqsge6v5y/jsNdZ
	dV9bV00TIX+3y1ggBQ0wiE8z1wbSeq1WxaF6zhc7+sBbnV7jQpitons80hc3XGfj3jk0XBqaxTH
	tTJtSlEMbg910ErshaZWPLbODHAkXyggsLIBG
X-Google-Smtp-Source: AGHT+IFx7FbGtXrrejuNEyv9WpPabEWgggbvC6vA+XFdNUZVvG6hpju2KnC9XGznkE738x9yETay+EIRooOSyqgpadw=
X-Received: by 2002:a05:6102:e06:b0:4a9:5d96:949b with SMTP id
 ada2fe7eead31-4a962def293mr20729448137.12.1730950973588; Wed, 06 Nov 2024
 19:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106180811.385175-1-mheib@redhat.com> <Zyv6ncZSVR5mohsF@JRM7P7Q02P>
In-Reply-To: <Zyv6ncZSVR5mohsF@JRM7P7Q02P>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 7 Nov 2024 09:12:41 +0530
Message-ID: <CAOBf=mvnzjpxm3S_x1-cnuAW1FA+7eNeL6xPHd8-iAh35SZiRg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: use irq_update_affinity_hint()
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Mohammad Heib <mheib@redhat.com>, netdev@vger.kernel.org, michael.chan@broadcom.com, 
	skotur@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ec104d06264a6dfb"

--000000000000ec104d06264a6dfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:54=E2=80=AFAM Andy Gospodarek
<andrew.gospodarek@broadcom.com> wrote:
>
> On Wed, Nov 06, 2024 at 08:08:11PM +0200, Mohammad Heib wrote:
> > irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> > instead. This removes the side-effect of actually applying the affinity=
.
> >
> > The driver does not really need to worry about spreading its IRQs acros=
s
> > CPUs. The core code already takes care of that. when the driver applies=
 the
> > affinities by itself, it breaks the users' expectations:
> >
> >  1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
> >     order to prevent IRQs from being moved to certain CPUs that run a
> >     real-time workload.
> >
> >  2. bnxt_en device reopening will resets the affinity
> >     in bnxt_open().
> >
> >  3. bnxt_en has no idea about irqbalance's config, so it may move an IR=
Q to
> >     a banned CPU. The real-time workload suffers unacceptable latency.
> >
>
> Thanks for the patch.  This seems inline with what have been done in othe=
r
> drivers.
>
> > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 99d025b69079..cd82f93b20a1 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -10885,7 +10885,7 @@ static void bnxt_free_irq(struct bnxt *bp)
> >               irq =3D &bp->irq_tbl[map_idx];
> >               if (irq->requested) {
> >                       if (irq->have_cpumask) {
> > -                             irq_set_affinity_hint(irq->vector, NULL);
> > +                             irq_update_affinity_hint(irq->vector, NUL=
L);
> >                               free_cpumask_var(irq->cpu_mask);
> >                               irq->have_cpumask =3D 0;
> >                       }
> > @@ -10940,10 +10940,10 @@ static int bnxt_request_irq(struct bnxt *bp)
> >                       irq->have_cpumask =3D 1;
> >                       cpumask_set_cpu(cpumask_local_spread(i, numa_node=
),
> >                                       irq->cpu_mask);
> > -                     rc =3D irq_set_affinity_hint(irq->vector, irq->cp=
u_mask);
> > +                     rc =3D irq_update_affinity_hint(irq->vector, irq-=
>cpu_mask);
> >                       if (rc) {
> >                               netdev_warn(bp->dev,
> > -                                         "Set affinity failed, IRQ =3D=
 %d\n",
> > +                                         "Update affinity hint failed,=
 IRQ =3D %d\n",
> >                                           irq->vector);
> >                               break;
> >                       }
> > --
> > 2.34.3
> >
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000ec104d06264a6dfb
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFUOwJjyrgy6q2yFf10Ipl3RN9Rt
6AbHgMOxhT3WqJlWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEwNzAzNDI1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC3w5ZLcTZrUTwnBdlyLwN1/SWeFtxLDRjtYcei17blifMX
OP1c0PDILhMOhWsjrD6WCQqbqHDoOVJBgUK9kI22fjyz3sMAgTAZbG3OaTmmmtyVa0YP8OzNXHIW
IsJd0IWBpnOabCnmmUJYK2q6R0vKJzhBzIIAdzDQr1CYJHJllRRtHGw5Rs2p7Ibr83xi2JTcUF2E
26kL/FGtzgrIvetnT7GOSaZoIWqbtQNBuQJeEdO1kgLYeNtL2kJ/Nl9B2snijcFlLAnS76FctkYs
juJeAySVnl+0b4lcvMMd6bnet7SbG9tzre44JMWgOmRhVeX14sDKZ6yhDrgx/7HbiG5H
--000000000000ec104d06264a6dfb--

