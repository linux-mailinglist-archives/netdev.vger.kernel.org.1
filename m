Return-Path: <netdev+bounces-65743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3883B8BE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 05:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBF91F23549
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2F6FD1;
	Thu, 25 Jan 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OIv92hqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512179C3
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158039; cv=none; b=Kul0aV0j1b0vQbZq7B6XUDc46OWUemenBTnO4iPefdHv3GCn4FXDbeCwDEtYhsMH3e6wHVsUEqTSjLIZFVSVDf0fcDAb2pLRoVIZPSdbUt3LdAlf7a5W+HQk+EdgI0Lrj6FAGmbrBOGstP3CrX90L83YiGqyJAKBwAp+bPQh/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158039; c=relaxed/simple;
	bh=1qUkK75kqkFifXSrA2uVGRT/MEZnRhEqn+VesqGjPDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sni4pup707k6V0W4GQpZ8SqjPrhTdyAesrhBCD29zf5ox/NkNm6yhRuaxi3UFf9Tl7SVCzK1UUhV52ivGqOEmIevAQ94/4nfpGod3OxtP4vgznzj/K2ZMpvnJjyEU3oQjSwUFf/nCDExluSWBK5S+eFjpVPyVFuJFX+Vzl2x2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OIv92hqk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a356f8440so7472436a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 20:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706158035; x=1706762835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjmO/NX9pWkNk2Ex4SbHme0YK0J7oKPDwQ65CcNbu0o=;
        b=OIv92hqk+ceVM7nhHM4hm+SxU4gp74/pMXXF6LQbJoceUq1E8vOLP0/y/IHR8T+p9M
         H71nJjept0PULL7WBimWwOM2PtbzoUcXj2+ZBAcGxcHwcBR9CXYZcheaSiATZ1XHyUg6
         zO+Fimsd6Kx6zzURDfEmDFOJIQ+7MK51qQmpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158035; x=1706762835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjmO/NX9pWkNk2Ex4SbHme0YK0J7oKPDwQ65CcNbu0o=;
        b=PsXYzbQQ8xkoRiGxXQkLWO8xGC601J46T0A1+PHwBkHnFqYAa6OwC81I4SY/xJRygS
         R11usE64EzhZGVI7a51gGCP4q22S8Pq40ZOrLAr50DG5fVklXv805EjxDAZuVhCDdF/s
         riGdRB85PSrGky42RbnKVnRs7qSugxH7Cz2TKk4fPYvvS0fAlEudoJZkxopinRCJOAiQ
         1aeL2w7HmU6jl6PLZZwOI8N4JXfqbPLKqarVzn5P01vFjCypLsbUlW6iRxDDJXLt0qad
         6t//X54R6jeRjIolCaufhnzydSH1ezlu4zdiktRRZWMLrpl0RrXwptdhRcVGIl/znoAa
         gAmg==
X-Gm-Message-State: AOJu0YxlZu9mTfVmwF3M01cFsAV33C+a1qTIvFgXU8LKg8yKJlmPrcf5
	VeeQuuLrNI0y+06pmJB/Mz3N5ULdSOBqkBoRYYakopvAB5VnMRP5TI2xeWT936u4Xevk+VPED4z
	okvu03KBSYOugR/KJqvvT8orvzwBc5IMEx1lt
X-Google-Smtp-Source: AGHT+IFceDiWRbzhE97CzKavRIMPy4r2h7RcaICCvNEp4Iw1MxfCx1HtaDbMbxpzDKhVJ38GFPEJ1EdOidz3CIMxpXo=
X-Received: by 2002:a05:6402:1747:b0:55c:304e:125a with SMTP id
 v7-20020a056402174700b0055c304e125amr173950edx.42.1706158035524; Wed, 24 Jan
 2024 20:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212005122.2401-1-michael.chan@broadcom.com>
 <20231212005122.2401-14-michael.chan@broadcom.com> <ZbDj/FI4EJezcfd1@gmail.com>
 <CALs4sv3xWaOg63a3ZVPDSq8nf2E84XNNLC1L6fJe9zphuWpgYg@mail.gmail.com>
In-Reply-To: <CALs4sv3xWaOg63a3ZVPDSq8nf2E84XNNLC1L6fJe9zphuWpgYg@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 24 Jan 2024 20:47:03 -0800
Message-ID: <CACKFLikNDhvtd9-98eD+Ah1Cr7MH3GkE+N8VucwBhTqYarcv-A@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] bnxt_en: Make PTP TX timestamp HWRM query silent
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aa7358060fbddffa"

--000000000000aa7358060fbddffa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:35=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> On Wed, Jan 24, 2024 at 3:48=E2=80=AFPM Breno Leitao <leitao@debian.org> =
wrote:
> >
> > Hello Michael, Pavan,
> >
> > On Mon, Dec 11, 2023 at 04:51:22PM -0800, Michael Chan wrote:
> > > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > >
> > > In a busy network, especially with flow control enabled, we may
> > > experience timestamp query failures fairly regularly. After a while,
> > > dmesg may be flooded with timestamp query failure error messages.
> > >
> > > Silence the error message from the low level hwrm function that
> > > sends the firmware message.  Change netdev_err() to netdev_WARN_ONCE(=
)
> > > if this FW call ever fails.
> >
> > This is starting to cause a warning now, which is not ideal, because
> > this error-now-warning happens quite frequently in Meta's fleet.
> >
> > At the same time, we want to have our kernels running warninglessly.
> > Moreover, the call stack displayed by the warning doesn't seem to be
> > quite useful and doees not help to investigate "the problem", I _think_=
.
> >
> > Is it OK to move it back to error, something as:
> >
> > -       netdev_WARN_ONCE(bp->dev,
> > +       netdev_err_once(bp->dev,
> >                          "TS query for TX timer failed rc =3D %x\n", rc=
);
>
> Hi Breno, I think it is OK to change.
> Would you be submitting a patch for this?
>

Why not netdev_warn_once()?  It will just print a message at the
warning level without the stack trace.  I think we consider this
condition to be just a warning and not an error.  Thanks.

--000000000000aa7358060fbddffa
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF3ZR3cDo9eyvVJPP+RFIF3YC6wcF/BI
dVecJ6CQPoa0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEy
NTA0NDcxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA1L8qm3ykmXUcE6dpwEluUDFX9glc10TdiATX4UOxPZKrZZjHL
mbf0T1ZA/dCW9Ak8EwfDgWxhiPwwUwaCgoRdlTeFKZGjXBfgj+9XIb/tUKKqyjxGZemv553URu6J
+798C+xcc8d61w/Aprm0A+tDmwsJJKOK3+XxQd12nxL0kzRFV3dYuzyqSQgGiUonJhaIVkZTIl8s
WcvH+LJF4lEINBOHOhLeX3C/TOF1wz0U/nQAbTRJPVJw76fRFZIHF38s8qroHmKiw+CyVrbTLnP5
8cw5fh9xypdeJ6a8g4zgzdF1y0HXRExEmcROjqA+8utZXkGkTM8I/bjZw8diSLF+
--000000000000aa7358060fbddffa--

