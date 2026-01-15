Return-Path: <netdev+bounces-250163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B5D246DE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77103030DBE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE78361DB3;
	Thu, 15 Jan 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LBFphnfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC671327C05
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479725; cv=none; b=p9elo8bquPNKySBvfKNSZej9e7Xm1VShnBZZH4EGXIXTk1vLUx7ZRh5rgr8zwJbOUpt7FdWCnprXl7HGUWrwkJ28dpNDvl2FlTLhOHKjBcSl0n5mOe7kGLDNvH8xyel0Gu9v+1SzDzQTr1GXpVeZoJsxtWa3y8G/XHOjnzUYMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479725; c=relaxed/simple;
	bh=mztL6FJJVhIsLriyAdm66WGjP2KgFJIvGhze7XPucCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFWe9uHegWV/0LBFKX5K3/2iY+FvHDAdFmoIln63zQPV+OkkxC08IkAZ4h4m/k/rXG3t2+jeeQUHBDxYqSV1npPAhXCMQ1bTA1eciQSEm8RIKchJy5FQrpaPj24z+itNdB7wO3r2X0MA93PlB7QoqUOUB0f06Quoh2dwmsFm8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LBFphnfc; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-81ef4b87291so445338b3a.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 04:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479723; x=1769084523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVG7zkiiUojtHl+FYSOUhzGRnxn0VKPvJs7XoFu2Ono=;
        b=MlQV39fpFgVzgZOQOVCW5/c9ntecEh6YizkhlmTVNegrTWsAMCdFDnPkQgPPXoJtCP
         6GeCJoiCKjoWjUp6Wn1n2PkaFrz9cRsEZvorV2bF457DU3feZXNC5qIB5jDhKpvEzzQD
         M49U3lqXWt7/FNVQ2vY8l6gIZr0y7Y1CBxszBXAiXQlibhI/5y286NKhNfYadJWVpM10
         ESfX/eX/th6KFO/2O+OVygxU6k2WCPBPB6qU2cgegkV9b3GJxO2j7kmh0vF9wxU7ieTM
         CMRWc9WKksD6Dl7347/hiDuLGTGPamRFdyS3DRbH0P20b4/Mna+GXxcLkMbE+mYiaXax
         laKA==
X-Forwarded-Encrypted: i=1; AJvYcCWWW9sNEc8R06n9XvBUjIAF4sJw+aWeozlQJFCxKs1Z93p2zgrDmfCLhgCHVQxKhIqxMOvD8S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xyQWKJrRdy6IOfhNcjJiiuwvaAyl3L/0c8b0hbAgoFLvmLdd
	JiXL6GVoLYGK87attkvA+bj0kGPs2DH6WSkg3meVVqdKcG/0loHPI1STvdgbJrAbtTxYmLk+iKt
	RJWru9+EQYOnspsKa3vCgG7QD8smIzNKzty8u8UhMBpnULlMmtdK60dckcZzH76EWYRIKREBZNZ
	GB+4oLvGnKvrMEJceFt089cQhCVJejH86xyoDrjdnuzPJIyygnecYO2fBPdEERxLxLra0rIA3Vc
	8zylGs0+24=
X-Gm-Gg: AY/fxX6qrFIskKjRMLWfiGekyD+vaxv/yhQgV5Xwd7i8HvqBkj/ek3oNC9etuNO8tls
	dOjNgEWsBW4JRunmO1a1JIiCULiK8c3B9jF7LTi/XHTZ2oQbYYP7RNG87NIvVtjCn30IxR8y1Za
	TFRIyFR5ifq2s2bHQtO/vq97h6Esmc29VmbtqCNJGUgTLwSVHsYnr9GkZSYRajBAXcPMv2+8mFR
	n+GK39UY3XzwYf7gLpYsRe7P8QiwRP5bFqfQ9FnwSn11Sc5Y1bAvQChdFKtX4wRv/0duERtmw47
	CdAFy8HR4va2BxCCXfbzfrb9eKWFp6vvEU4CCo8HAqYcog/tCM7BuD19MCfG6WiEI9sukeBKEA/
	PWahIK8n77VgORPsdXV40QOCrqvToEO8Wbvm9nR6SmnxeQsu5HuzG4OX3VZytodOFZ9vZNjPcxk
	BpMAarkvUQLeBmf3cNA205O2ZYCMGKI1JvTEUOnpmOxg==
X-Received: by 2002:a05:6a00:3020:b0:81f:5fe9:4d2d with SMTP id d2e1a72fcca58-81f83c5805amr4609147b3a.9.1768479723148;
        Thu, 15 Jan 2026 04:22:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-81f8e6098dfsm370306b3a.7.2026.01.15.04.22.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 04:22:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so955807a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768479721; x=1769084521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVG7zkiiUojtHl+FYSOUhzGRnxn0VKPvJs7XoFu2Ono=;
        b=LBFphnfciii4jdeeOJVuPjYeu7+YiXmD6Wte7JpB2cGrrM2KEIQU3MdnvzXducZH92
         b0oFcL3RiuaPxjHqkU259IYw8dGbpvNpfCen3MQkdZ0y2Qk6JTJqXhwxW5UBm+IclUyI
         ZiXxnVFTor4qe+1gOcmK8NqaoW1YIZQQEnCHM=
X-Forwarded-Encrypted: i=1; AJvYcCWG20dpH6Atu7l8cbtWdIMdpeuZykZAZWF/zIymsZF8jRy1dVpWzLiduGNYcB2Qhi9gTASYroc=@vger.kernel.org
X-Received: by 2002:a17:90a:d44f:b0:34c:2db6:57ec with SMTP id 98e67ed59e1d1-3510b1267b5mr5553494a91.17.1768479721305;
        Thu, 15 Jan 2026 04:22:01 -0800 (PST)
X-Received: by 2002:a17:90a:d44f:b0:34c:2db6:57ec with SMTP id
 98e67ed59e1d1-3510b1267b5mr5553470a91.17.1768479720886; Thu, 15 Jan 2026
 04:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-3-pavan.chebbi@broadcom.com> <20251019125231.GH6199@unreal>
 <CALs4sv3GenPwPXJxON8wkhRW1F-KB7DT3DkPbzm4BY620aTEvA@mail.gmail.com> <20260115110039.GE14359@unreal>
In-Reply-To: <20260115110039.GE14359@unreal>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 15 Jan 2026 17:51:47 +0530
X-Gm-Features: AZwV_Qje6AJ5OiHaK5RbY2zUjuLRYj4-B4wtNV7oEJvFo77VOP2wtLIAsKe8Inw
Message-ID: <CALs4sv0v8MQqjVqx07GdiuPr9qt6WQmQSe5Y8FWvni_8R9H7MQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] bnxt_en: Refactor aux bus functions to be
 more generic
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net, 
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009a03e706486c45d4"

--0000000000009a03e706486c45d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 4:30=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jan 15, 2026 at 02:58:55PM +0530, Pavan Chebbi wrote:
> > On Sun, Oct 19, 2025 at 6:22=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 01:10:30AM -0700, Pavan Chebbi wrote:
> > > > Up until now there was only one auxiliary device that bnxt
> > > > created and that was for RoCE driver. bnxt fwctl is also
> > > > going to use an aux bus device that bnxt should create.
> > > > This requires some nomenclature changes and refactoring of
> > > > the existing bnxt aux dev functions.
> > > >
> > > > Convert 'aux_priv' and 'edev' members of struct bnxt into
> > > > arrays where each element contains supported auxbus device's
> > > > data. Move struct bnxt_aux_priv from bnxt.h to ulp.h because
> > > > that is where it belongs. Make aux bus init/uninit/add/del
> > > > functions more generic which will accept aux device type as
> > > > a parameter. Make bnxt_ulp_start/stop functions (the only
> > > > other common functions applicable to any aux device) loop
> > > > through the aux devices to update their config and states.
> > > >
> > > > Also, as an improvement in code, bnxt_register_dev() can skip
> > > > unnecessary dereferencing of edev from bp, instead use the
> > > > edev pointer from the function parameter.
> > > >
> > > > Future patches will reuse these functions to add an aux bus
> > > > device for fwctl.
> > > >
> > > > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > > > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > > > ---
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  29 ++-
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
> > > >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 238 ++++++++++----=
----
> > > >  include/linux/bnxt/ulp.h                      |  23 +-
> > > >  5 files changed, 181 insertions(+), 124 deletions(-)
> > >
> > > <...>
> > >
> > > > -void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
> > > > +void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type=
 idx)
> > > >  {
> > > >       struct bnxt_aux_priv *aux_priv;
> > > >       struct auxiliary_device *adev;
> > > >
> > > >       /* Skip if no auxiliary device init was done. */
> > > > -     if (!bp->aux_priv)
> > > > +     if (!bp->aux_priv[idx])
> > > >               return;
> > >
> > > <...>
> > >
> > > > -void bnxt_rdma_aux_device_del(struct bnxt *bp)
> > > > +void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type id=
x)
> > > >  {
> > > > -     if (!bp->edev)
> > > > +     if (!bp->edev[idx])
> > > >               return;
> > >
> > > You are not supposed to call these functions if you didn't initialize
> > > auxdev for this idx first. Please don't use defensive programming sty=
le
> > > for in-kernel API.
> >
> > Sorry for late response, I started reworking the patches and wanted to
> > address this comment.
> > Without a map/list of active aux devs, we will have to check the
> > validity of the aux_priv or edev somewhere before. That won't change
> > much for the defensive programming concern.
> > To do away completely with these checks, I wish to handle this change
> > separately where we maintain bnxt's active auxdev by idx, in the newly
> > introduced struct bnxt_aux_device.
> > I hope that is fine.
>
> I don't know. My preference is that you get things right from the
> beginning. For reasons unknown to me, the Broadcom drivers are full of
> random `if (.. =3D=3D NULL)` checks, which makes the code hard to review,=
 as
> it's never clear whether the functions are re-entrant or not.

Ok, let me see if I can make that change now itself. My worry is that
it might just entail a bigger change in the entire aux bus infra of
bnxt, which, though worthwhile, IMO warrants separate time and mind
space.
Having said that, let me see what best I can do. Thanks

>
> Thanks
>
> >
> > >
> > > Thanks
>
>
>

--0000000000009a03e706486c45d4
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA8VtB6
B7xDZI7EXD+dmj3J3REbPWyVSLV26deQzwC83TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMTUxMjIyMDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAq6WHH8eWpK7yRcb0nMK2Z9XyKftHFTA3AeB+q4E+O
qgYQp8Lz+qUmorQhCgfk3Dn4PYGNH5uY8cSSteIA5YG0r5EE97VEquwjFR9jwyJSdW2rNs6rry5z
rKMnSPnkzL8jfYK11GEJ4Jqlvdvaw00QimnavDTus7+tPVBHX+LoBdU4hfLoOSwJITOtSb1tAs0H
aheeZoBbr07hGbzNNS8bwpU2AoDeU8MKlHxF7EYIIk4AWZjgBIMlP+EgV/dxWBAHd3ew4ddk6Djr
L1ZFSEb9OylgUof46sJgJlox/dHNqQb0Xblm6xK0DnE28jCAPKjPeFiJujSKzZsuqc7jmmB6
--0000000000009a03e706486c45d4--

