Return-Path: <netdev+bounces-233518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB2C14BB2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FBA04E0740
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347932A3C1;
	Tue, 28 Oct 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F/0qKEjk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826A2F5472
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656357; cv=none; b=jA5Ati8Desae/qMNypnQ5dHptinPcBAkmzOZlTVvxUECO91Lvwd2noCMiEAzBsM0x9F5FW/zvW4kdv3yujDoYsRFrO2cPYHSVv8oLCUflCOsyjDHGLlWBYfxqzCZCPepI37XC6Ffjw/u3Gelj1QW3K4cnXQDNn4MV0tQVG9Csgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656357; c=relaxed/simple;
	bh=Qp2Kj8VntGcgOkowmd6Lz9Ngw3R6THeAuB97B6fYRHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVcIw8TvOQsA1urVjClCEOj4IigfHIMmFfIxfK6I/3LlkT+TJVK1iwNozefosA+y2c/p+IZKIGxQ5SKegxZnz009F9FOWk6GSG0BF1KuGIFXhtwPf/LneEp6iLdOIA/jbvoK5t/FhVPaxIKSxhn5iKW7dIyDGimklEBQZFuPgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F/0qKEjk; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-945a5a42f1eso119464739f.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 05:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761656355; x=1762261155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5JRwI8ldIrrLoOe9UfxNr0qG+WDJW5w9sh1V2dn7MZg=;
        b=GFcmuXywB+R1ViKc/Ti8e9b2v3N+NJ6UtJshwtUlkz9GClFANV5Ridc2TlD9mFFawR
         IDRj7mEh1bS+8N7Jeni3wNfZ2W7knGR1miWqZe06K7p1kIVgnMePROEQanvzYibNGIs6
         RvOpekfgo4q/0yRRucswFsMjwYe8eHWwPW9ckGoC1NwYpi+F8tZD7JvdRwzvRjCFNNQI
         /etuUgcP/p3Yf/ZmTDyS2KMFi+LXONPqXR4y6QDHwkbcQXj5xNevpbDUM0L+z9PwXv1g
         NA7VuYLlVKewoYWu5wLh9z8KrBQnoEIdBBjCqUZx+e+GMxRPgVpnf0Ijge8UdLRuFp4n
         nL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUU1OoVPKUggJmXJ8NnU3D37auz025omll9/2Zd6MK07ljI8S1m4RtO2Sa9QoqVuyns34KFzlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3EectlYY0tXlbaC/8FN8kZjNWvvPfD7c95HNkE+w+hc+Kzgo
	uAVXEYjPQpNLRCaAQavA7OLt079hTli4od0jIvJisTdI0w6fl3A4gIMWLkP45WcN8Au4CgupmNu
	Hnb5mtnMTkYnGSTNZKDfOfZfqV30QwnuP4AXPZGwCyGI70jLqbhl/aJDmPuB/HVEHiorewCUgoz
	8INiQ4DZ6UTdX1kgami127246FGEDN7zPhU4S+ctGoZYitlUmhlxQQqLRsqB94DE9P3sjMq1FY1
	D5OjqLQ6Eg=
X-Gm-Gg: ASbGncvL3ahxkKNqf+hnz1SIUB0r8z2RAdZ1nbJgQsHTvSH9+o8cQEK7+HJCLRF/Qyr
	UsG5Dg7kkXa3pENcdwFvYNokjAXJeJbtK3ngqjU3Q+9JA08D3/SCdJ0DMBiiKkz93OOuejwlqD3
	0nOqwwJPpQCGvHurSvTmYeAvQYaxp/B6rSXoITg0SUU6eKgAWAJWmrenZbxp4ZxlX1cUW3CWF0W
	ciMzIuj5gOHx7zfhWl7aE/5B7caepo8ptMUgQm0G8FHlt3CrkNanXg0vIvCdtmGUjikNwkmUnOo
	3AUAEXBN4gSKnSj/4JorUHjju2rRbEqQPUkgkqYpK2E5i22QOQ/b2mo2D9ljMsaV/BMoXWEdGKr
	BKppG5GdQVE4DYLzsuAGBUvT4053yBTfXFMfnTr4CYryD1BwYTS2UvkNLqA==
X-Google-Smtp-Source: AGHT+IHNWb+6NO3eJKZWEUlYLDkt6qZddjVno9+85xzygCVaInzuy+6QznOMvfJSzRfR3ZL8F5OxgsmiYgi8
X-Received: by 2002:a05:6602:1653:b0:945:ac18:f018 with SMTP id ca18e2360f4ac-945b8028ef7mr527587139f.8.1761656354999;
        Tue, 28 Oct 2025 05:59:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-94359f29e47sm64675639f.11.2025.10.28.05.59.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:59:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bcb779733so5227550a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761656353; x=1762261153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JRwI8ldIrrLoOe9UfxNr0qG+WDJW5w9sh1V2dn7MZg=;
        b=F/0qKEjksv0OOk57J7R4YMpov/K8U+uFgnkY1c8WcFPQ09CL3OoINGoyJwnkw6VRdm
         1jvJ4C03abICAuvkk9oIZQRTkVyh2OAMo36pOVT1fZ1+Z5NkO+ZzFF3B6jQCq1mC+gFd
         VQRx9CW4iJ01HEuuMFaMQvZATU4dDgXkTe2S8=
X-Forwarded-Encrypted: i=1; AJvYcCXSRXvDpmi4sj25oHOIuwKi6yeoi9dQqWXxRS36Yhkgj9cBX3EuAG6Tg8VSAKih85HWHjYoUIc=@vger.kernel.org
X-Received: by 2002:a17:90b:1f8d:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-34027c07822mr3659651a91.34.1761656353114;
        Tue, 28 Oct 2025 05:59:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8d:b0:32e:6019:5d19 with SMTP id
 98e67ed59e1d1-34027c07822mr3659583a91.34.1761656352207; Tue, 28 Oct 2025
 05:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028095143.396385-1-junjie.cao@intel.com>
In-Reply-To: <20251028095143.396385-1-junjie.cao@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 28 Oct 2025 18:28:58 +0530
X-Gm-Features: AWmQ_blv4IicVDAg6PPYGOl-mWcn34kwei6gDaU69BZlRovT_QyM3SNIr65PP6o
Message-ID: <CALs4sv0V7Tu9VKgopUZJZfQZA=B1ijnEA5jiqG47wvvsxpTrxA@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Junjie Cao <junjie.cao@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a7ebf064237954f"

--0000000000002a7ebf064237954f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:22=E2=80=AFPM Junjie Cao <junjie.cao@intel.com> w=
rote:
>
> Syzbot reports a NULL function pointer call on arm64 when
> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> posix clock gettime path.
>
> Return -EOPNOTSUPP when both callbacks are missing, avoiding the crash
> and matching the defensive style used in the posix clock layer.
>
> Reported-by: syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc8c0e7ccabd456541612
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  drivers/ptp/ptp_clock.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index ef020599b771..764bd25220c1 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -110,12 +110,14 @@ static int ptp_clock_settime(struct posix_clock *pc=
, const struct timespec64 *tp
>  static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *=
tp)
>  {
>         struct ptp_clock *ptp =3D container_of(pc, struct ptp_clock, cloc=
k);
> -       int err;
> +       int err =3D -EOPNOTSUPP;
>
>         if (ptp->info->gettimex64)
> -               err =3D ptp->info->gettimex64(ptp->info, tp, NULL);
> -       else
> -               err =3D ptp->info->gettime64(ptp->info, tp);
> +               return ptp->info->gettimex64(ptp->info, tp, NULL);
> +
> +       if (ptp->info->gettime64)
> +               return ptp->info->gettime64(ptp->info, tp);
> +
>         return err;
>  }

Patch looks valid to me. But a similar situation exists right above
this function where ptp_clock_settime() is calling
ptp->info->settime64() unconditionally.
Maybe that can be guarded also?
Also this looks like a patch meant for "net" with an improved title IMO.

>
> --
> 2.43.0
>
>

--0000000000002a7ebf064237954f
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDZhVyL
KLpmdv0Oi8CMH14UwrDzH8QuAClQmoDOf5WCJzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjgxMjU5MTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC9RLuziJKOKjvXe3qpIxM9IWCRnrcsxvzAXKxkKX6f
wPmPmpSQvgL2N5JmHRswhFhUxhdWkSRFP4dmedV761PUd+WUjI/nXuw84NzacziryefEJHiRINe8
GNsgnH/QwamvBW7oFwD5G4fwQhJXuxOJl7gHb5qRK1n96cDxO+qbBuQq/imb6N1qW+/6DIlBTF0E
5KNGs9lSk+EyV42K2j0YDXbX7S1OLXgKAvteKkMh7aMWIwAmPBNvVXVCOrU7r/ZV2CNp9gwliYl0
5X/54fPIToze2S67rc6q6APKmdFjSsKDkt1P9lehW983SXx0XZn6pC2/4uden/Gb9HLRsmuu
--0000000000002a7ebf064237954f--

