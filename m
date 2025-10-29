Return-Path: <netdev+bounces-233867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD9C19997
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AA2B351CCA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0707329C56;
	Wed, 29 Oct 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YAFxLUto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF9325484
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732610; cv=none; b=IDt1PvmV7jGCb3Wk0+/cRz26tgE6k2CDRQ5m+bXG0u/o6cxp3SbQn21/i6q/8GK8lHaPf5DBpSPOa/wOAFrr36FOMkCtpenw1Ltp1tuJpY1av93Q0aC4DIjxIrgPgXh90fekVR+8IT62rX5hf0zkqNw/rAelyCH1U2DZkHuJs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732610; c=relaxed/simple;
	bh=A4lAVPev8tjqb7uSqqWqFNCRO+U4EgUiYz00TlSAY0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q47ne5QSyA/Fi2uYHPu8Q6Ovc3TGC56FKAH4+V5Bu6YGkMEVWCqITnVC8URAO6QTTc6cvqbmVfREPzSLT+q6cFrTT/M3UzSoHoT2fESf3GZbyB0zHxhKlUdpwTAB4izCxIdrHP8jH94aTJLpmSMIfbEpDPzlgkcWqdTE8zurR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YAFxLUto; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-9435969137aso457194939f.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732605; x=1762337405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tk9R2/28FpCi6hU8ZyZQdOi6G2biJ9fxYaiHizvg6Q4=;
        b=v2ZWE/84sMngMkZ6T3NGIz9Z8DLS2arTpvxtOGiTrzyP5mEdmFr7VYsnwULr0WDZ98
         OU8us8lryunfVfnZesyYnj0EF6J9wlMcEl7k1ALlGOp0gf6MGd0jPDBj1uXZTgyddSae
         xd2o7+A5yA0FVKq0IuUvhkTtxa61YG3WP11BcDFKHWjFrAHtZXJOMnQk2lLIXcHmQLND
         06OBYQczq7DgEMvlfPRRsBASN1XVpqz244eXTRNHmVFfbkh9yGshBh5lMWSNnfdSQxch
         zSkCZziEBDPylfJfUiZMUREXgvADdHlC/g5Z3+Zi3qA4yAPUgPnVqTjeklk+R5C1bGMO
         O0cg==
X-Forwarded-Encrypted: i=1; AJvYcCXqmzGRtkzCYBRA+D9Q1y/DLD6Uj3kQ9aGphZhn8p9Nyw+ZJvLLRmn6NHdTevMYZHs7DKgi4t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFFhAbtXhu7ROBpa9OvmQbLHqcSxXE16dv64B2VC5GGIvY89S
	t4o9VPUyROTk9uCACBuwj5ZEGdTSlP7BZxlJ0g5CN43JWrLL6AnC9eefgEo8O7/Tys431WMkokr
	9ey/U1BhyUMNmeMWaVxtZoJM7Y4j5sxSmMtVrD8eZD3zxfybs1XKtucUjz46t1Ge9YKw8pfMyXj
	UEWSRTpeCXX/gFePsZcwmZYNaKeTCYULfOCrVlfC5wK8FxJLbjzwvvesC3cLdEgeV87DTodu7n8
	43uR1n02Rc=
X-Gm-Gg: ASbGnctWezsR/dEJtEF8Na0I0WS9L7WtgU8/3c+ihQz3vrXk6S+1S0M/g1ROTC6wIR1
	uiqU6l9b/iufInth7JYlrRIneN6Yv/83EqmvoftiYf2r2IXU385v2Aji/26KGKu+4jC8VTkKxd2
	3zXmqikeniTGO8ivDb6k8QRTcZLIOdxjkI2kLqPT1w2PQDNfrxefKKyI+Ipk7E7TsOtYvPivQpY
	1h8VNcFr0kq6K09pnzfmKnWhuP5Kn1RUvomFwRBZP03M2xn2u+d8HNacO1WoEBpFc2YOuQ+CrEZ
	zPPchkBTbR2dCyg8XoVuORR4GIpfHgQ9qjWgWReO8y0fYmah8Dqh7yoHohQYLd/9CzyZqe0lopo
	jIOt2xF3ASRI3UCxNLNlbAM0AdDoRi1p4EfOwCuGNxyeRnf0wvh1VrvLg9yqDdMsuVfPVcd0Gyl
	1naF6UF5C3EFDTHFW2HM5n8o2HlL8xTNcC3g==
X-Google-Smtp-Source: AGHT+IGr+MIsdjxQdJzTcqFJz6eQqwOHSj8kmX6C6zjJvoQlTpXvwPM7EE8UBGyjQtppSj3tb/lazdD63kD0
X-Received: by 2002:a05:6e02:1a49:b0:430:cf19:e682 with SMTP id e9e14a558f8ab-432f8fe1398mr34357905ab.13.1761732594622;
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5aea995ce32sm1057020173.20.2025.10.29.03.09.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34029cbe2f5so4233723a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761732593; x=1762337393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tk9R2/28FpCi6hU8ZyZQdOi6G2biJ9fxYaiHizvg6Q4=;
        b=YAFxLUtoHT6S7PFXGx6yj/0/HlPsqpOLaLaNSXMevgzXSwnvLdftedplFPii9WByGb
         02hsGVmisq/tKMGxEtOhf5m6/dUzhW4a+22SPsI1ibElCpf8FDCJWFdAX7GKZsrHJqEo
         9h+nQElDOL7Y8w5Boeo1riVNDFI+mfSlM3uR8=
X-Forwarded-Encrypted: i=1; AJvYcCW+IIkdzAkBvOdyU2J3gD9VyAMIqSD8rsRTxhjCySlo2lk7+6x7FW0lsz12aVvqt08Llzs0k4o=@vger.kernel.org
X-Received: by 2002:a17:90b:3c48:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-3403a2911femr2846086a91.32.1761732592432;
        Wed, 29 Oct 2025 03:09:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3403a2911femr2846038a91.32.1761732591550; Wed, 29 Oct 2025
 03:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029083813.2276997-1-cjubran@nvidia.com>
In-Reply-To: <20251029083813.2276997-1-cjubran@nvidia.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 29 Oct 2025 15:39:39 +0530
X-Gm-Features: AWmQ_bl3D6Qpq6QadtY_elNEjPlkBvPoYNi8liWb36M5G0NHsKBBhPL4Li_6je8
Message-ID: <CALs4sv0qPsfLqsrr4Wux=Zb22dQFKDngWMQbEq+qN8Yc+wNsyg@mail.gmail.com>
Subject: Re: [PATCH net] ptp: Allow exposing cycles only for clocks with
 free-running counter
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006cee1c06424955de"

--0000000000006cee1c06424955de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:39=E2=80=AFPM Carolina Jubran <cjubran@nvidia.com=
> wrote:
>
> The PTP core falls back to gettimex64 and getcrosststamp when
> getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
> ioctls to retrieve PHC real time instead of free-running cycles.
>
> Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
> free-running counter support since the result would represent PHC real
> time and system time rather than cycles and system time.
>
> Fixes: faf23f54d366 ("ptp: Add ioctl commands to expose raw cycle counter=
 values")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/ptp/ptp_chardev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 8106eb617c8c..c61cf9edac48 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -561,10 +561,14 @@ long ptp_ioctl(struct posix_clock_context *pccontex=
t, unsigned int cmd,
>                 return ptp_mask_en_single(pccontext->private_clkdata, arg=
ptr);
>
>         case PTP_SYS_OFFSET_PRECISE_CYCLES:
> +               if (!ptp->has_cycles)
> +                       return -EOPNOTSUPP;
>                 return ptp_sys_offset_precise(ptp, argptr,
>                                               ptp->info->getcrosscycles);
>
>         case PTP_SYS_OFFSET_EXTENDED_CYCLES:
> +               if (!ptp->has_cycles)
> +                       return -EOPNOTSUPP;
>                 return ptp_sys_offset_extended(ptp, argptr,
>                                                ptp->info->getcyclesx64);
>         default:

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> --
> 2.38.1
>
>

--0000000000006cee1c06424955de
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCzmHqh
jiaIA/O86YxzZxPQGNXqlVVr5zyWtPQwSWfUBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjkxMDA5NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCA06qwgrrecEC7yhnYAcXLx0Ldf1zN9FkqrNaX6GBD
tuhRQ+PR+B+P4GqVfULCxZJ+SGBCoZR4ePGMY8SWsHZm911Q3LMAgaHDcIrkfAeI+SrvB+KsyDqc
sghsDWjQ8psCfw4uHiXGttMkjtLDsb4bzs+fdcy+EB51mqynPLGgjE4rfkW5B84EKJ/tqG59Wvbc
rRV18/+AzzHeD66sOaOdapjWzOB7pWUVY6vCHMjrS7QkSil8OPELOQsjfI4Oy6GklMymllKU7yIi
hOxiwg8RzLzFCTq1+F1OLWaw3KULd3qUfQItZ0IJBCOqVuABEfMDFNXRWaiFtIk9dKwZoxjD
--0000000000006cee1c06424955de--

