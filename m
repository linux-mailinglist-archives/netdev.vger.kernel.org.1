Return-Path: <netdev+bounces-250066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB8D23A4E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B3C30B0124
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCC3803C9;
	Thu, 15 Jan 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I+KG6bQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90D35E53E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469352; cv=pass; b=UE3P1EOOv3X7qDLCWQGD0y8Heuau+5ZENrDaON1oSkbd3SdiriwFPukNvu4yG9uOZid4rTT8UYcK8meFx3SzPy88KIq+9Nu+G38rPeMKJD7JBkbdt9pj1ADPlD1nPiZizoT8Gzry+NWgtiAxy/qGSAtGJhVmgz+8xOjtOPr3/UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469352; c=relaxed/simple;
	bh=mUmIxGpYsmG5qN1Dtp9DYaoQz0klm6WyXt8L9cL9ri0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbALrTXUwMuu1TDH/RSOAtN7Mu3QdPg2ivv3FrJKVWLafiFpLYkAy3fcBomwnO2BuNtq32H+i+XRr+DhMMDvneQ4Kew3AzF+m2Thi6mRkBDC3lFYCf8BJ7Qu9t4fbSD1ePfDb7aajlgjbvuJM09+qzKyVKrDeA98DmzIRe4T3pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I+KG6bQA; arc=pass smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3f9e592af58so471579fac.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469349; x=1769074149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz8GN5/Ba2sIxz0bEZSs8Pv6D/I3LNK609Fl+XvRKs0=;
        b=Ha0ziZx03OoQ8R9CXWWAxXlCdn383OcPDMDiicl4SEtmjglrvo2WRixN4//yjbCdNi
         u6sOWurBksXJ4AvCfn8G8e1bTvr7Lr3IROmUJJ4EDXMg2JLQbAreddRgXp6uXnKJbG9K
         GXr9/Rv9N2ZN6wmT9TkuxVqOAnQ8LHQfiygNDPTz3SVhV3NdZ44nLYxd0JYDzqM5bPCQ
         Lvi8xavIrTpMQLUUujcY9LL7MZinfqfLtiBGij6aEXa7rBKQ4nXhSjwzZjc4irZgJ461
         xSwyuwsX3XpVoJPRJ8N3kA8hTc/Af7dXWofOz/1yT+7r7egKPBMgWRilmSgsEuzzY4OO
         eCXQ==
X-Forwarded-Encrypted: i=2; AJvYcCUENH0OLdWx0ECH2IlkNwQicLS9oeWTUFVofjI4KU4OJnsSua+iH25vWiQEPSzGjoJYKi0mhkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVgy6e3awJFFLkxe52XnzaOk49ynXgWzCcPuzRUgh6vslhb7L
	cLu3yw0aYMcc+WLwvN/DC6HkFw89HuDeMx0Mdz7f3n0BRrg42I1MdmwOa5Jx3hqmEkrJqiI26uN
	8KNEGc3ZkiPkTQMiucNJ9IZ7nKn/+KWMUs+gjYklD6v+q3vQCKZZwCakk1eYgYhnZ/CFI1Q0OEJ
	sB89GFo2fMSTqemN+cEkpntithC/V61dpZc2JnBLdcmy0vjQ/pipjhH8oZatVHVHYy/7032vT0e
	FW0grWvPsQ=
X-Gm-Gg: AY/fxX6F9lM533nQa5PNCoMhXaxDxEfYsg0f92ruEaARgjKTDGE/r+HbCaBDhH6T2kC
	fCEDy0XRnF1VVK6dAUlPY9BRinQj9DTr7cWaIC3azG4S75FXv2HR+63LzNkANQEHPnDR8Bx0OYF
	6gstguXp3N5yYaIei3zjT7KDUmsxPlgSupIdFyish13UPWX8R5oMwSqvm2CiUT1hy+lZLv8LuaY
	5W5EG5ObNd2+thXi5RQxH0wFeq+L9T+L4h6E8hS4a0YmUkxcO7JMml7kd5B3hF+4wE5Yjea4OJj
	jL1jbLLhhPfXGmx40Tsy6XAHXfU9M8b7nvGvOvqV5gBLPLs0NAezqikMUg6aGUin3ST5+fub7ju
	8V2CJjZpViVQgPFkl4GShGaX0zkz/kHX4TsCYmtIio3Gc5q1AqJvNYBcTTawD8nw5J/SbRNL/y4
	TsLxfYMDv3n3XXO7+jb/qv2w5sra3mvPGxwm+oWA9U24NYquY=
X-Received: by 2002:a05:6871:230d:b0:3d2:6a9e:29ff with SMTP id 586e51a60fabf-40406fa6c97mr3838199fac.16.1768469349387;
        Thu, 15 Jan 2026 01:29:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa6aeebf7sm3095369fac.16.2026.01.15.01.29.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 01:29:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0c495fc7aso8286915ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768469348; cv=none;
        d=google.com; s=arc-20240605;
        b=RM182NnD6o/0fIw5S94WpMnztAUuhFdDzg0bsy8fof7QSjokvh8f5iLiWH3386zHgx
         Ay7B/nVrVB97jCxmwuJb5g+SbkGHtH+zuZppJ3AXOjfhqt154Yp0+Zo323hz0qISpHwG
         otepvFz1ORsa37q0A5w6bR9beMVlGdFUzGrvr5abIyVx7c8SrmNEl9bkOnMw1NwULu+4
         XyV5lk3vvHqhQA2Qhsav+bjFQdUSh5cAEmN+fUcqUOBFG3pS8NhT808UhLh5BIKOMgbu
         saxs1iHiT3zNI3jDqxvyVyoeA311IY2Nb1hHHlRHbczw41xuaGkOxE8eiVnDyjpjudhu
         d8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sz8GN5/Ba2sIxz0bEZSs8Pv6D/I3LNK609Fl+XvRKs0=;
        fh=UC953QgTw6bc9RgNgpZBVMzPBaRyA0hIMl4oBSrWWh0=;
        b=AnDitroaGFJh+PAuz1nJcy/Oim+mnOx9yaler2AQOYlyNBZKTUnfmNa1F3WmzdOLl0
         XP/cx50knhrMdKwUcxVa7KVAPs0ZpBMldprGabDAtVQgdviSAFy7DFdPoNAqsJuGOa2V
         Ny/vJmFFCdHCQ3dAF59fQvnvvyyVGMQUi1O6ojAqGGYMzpLg2ET/I6BjLG/WzI5ONJyX
         K0FNdOvd1BJPAYza+Yp4PCNkb2qGavy+7oNq7o8PYYQ+//JeuDrtnh8jk9OFgKFlvZOa
         nKgsHgM0J5X8gNleYU//1KJQtvYFXtDigOcoSp7J+lLCzNDjjHDI2/N1cRDLpERdWHmO
         OIjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768469348; x=1769074148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz8GN5/Ba2sIxz0bEZSs8Pv6D/I3LNK609Fl+XvRKs0=;
        b=I+KG6bQA3T/k1DzgMybHnaDcMIXmtN3ZSWMZOYud0nU7HxAyiMRza2XAejF+w66Edc
         mCGDonk0CwG6d24iAjcc0JlJify1CWH4JEhJoWgcjQXcSs+6P3rLyE6Ee2DnzMMa/go9
         rCCzvu8DhWVnVWbaChMeDLQklvbMEBY8ELbdU=
X-Forwarded-Encrypted: i=1; AJvYcCVF5h3qWyV2Q73Fc7C1zF9fqsZPDFADZg71rbzbtquTpmXJ+fo21X2ZnRcK3yd2sBuLsGxF2yU=@vger.kernel.org
X-Received: by 2002:a17:903:1208:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a599ea726fmr50530725ad.54.1768469347925;
        Thu, 15 Jan 2026 01:29:07 -0800 (PST)
X-Received: by 2002:a17:903:1208:b0:2a0:d5b0:dd80 with SMTP id
 d9443c01a7336-2a599ea726fmr50530505ad.54.1768469347374; Thu, 15 Jan 2026
 01:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-3-pavan.chebbi@broadcom.com> <20251019125231.GH6199@unreal>
In-Reply-To: <20251019125231.GH6199@unreal>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 15 Jan 2026 14:58:55 +0530
X-Gm-Features: AZwV_QiwX-1IjoPqJNPxJJ7Z5_for622FsXWoK7mpp6We7JYew_y1B_YvzAX9Ww
Message-ID: <CALs4sv3GenPwPXJxON8wkhRW1F-KB7DT3DkPbzm4BY620aTEvA@mail.gmail.com>
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
	boundary="0000000000004db42a064869dbfd"

--0000000000004db42a064869dbfd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 6:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Oct 14, 2025 at 01:10:30AM -0700, Pavan Chebbi wrote:
> > Up until now there was only one auxiliary device that bnxt
> > created and that was for RoCE driver. bnxt fwctl is also
> > going to use an aux bus device that bnxt should create.
> > This requires some nomenclature changes and refactoring of
> > the existing bnxt aux dev functions.
> >
> > Convert 'aux_priv' and 'edev' members of struct bnxt into
> > arrays where each element contains supported auxbus device's
> > data. Move struct bnxt_aux_priv from bnxt.h to ulp.h because
> > that is where it belongs. Make aux bus init/uninit/add/del
> > functions more generic which will accept aux device type as
> > a parameter. Make bnxt_ulp_start/stop functions (the only
> > other common functions applicable to any aux device) loop
> > through the aux devices to update their config and states.
> >
> > Also, as an improvement in code, bnxt_register_dev() can skip
> > unnecessary dereferencing of edev from bp, instead use the
> > edev pointer from the function parameter.
> >
> > Future patches will reuse these functions to add an aux bus
> > device for fwctl.
> >
> > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  29 ++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 238 ++++++++++--------
> >  include/linux/bnxt/ulp.h                      |  23 +-
> >  5 files changed, 181 insertions(+), 124 deletions(-)
>
> <...>
>
> > -void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
> > +void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type idx=
)
> >  {
> >       struct bnxt_aux_priv *aux_priv;
> >       struct auxiliary_device *adev;
> >
> >       /* Skip if no auxiliary device init was done. */
> > -     if (!bp->aux_priv)
> > +     if (!bp->aux_priv[idx])
> >               return;
>
> <...>
>
> > -void bnxt_rdma_aux_device_del(struct bnxt *bp)
> > +void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type idx)
> >  {
> > -     if (!bp->edev)
> > +     if (!bp->edev[idx])
> >               return;
>
> You are not supposed to call these functions if you didn't initialize
> auxdev for this idx first. Please don't use defensive programming style
> for in-kernel API.

Sorry for late response, I started reworking the patches and wanted to
address this comment.
Without a map/list of active aux devs, we will have to check the
validity of the aux_priv or edev somewhere before. That won't change
much for the defensive programming concern.
To do away completely with these checks, I wish to handle this change
separately where we maintain bnxt's active auxdev by idx, in the newly
introduced struct bnxt_aux_device.
I hope that is fine.

>
> Thanks

--0000000000004db42a064869dbfd
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCbcbs/
2SnX2/qQIbo9akC+rFz1A7oKa9XfosarU5U4dzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMTUwOTI5MDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB+32bEgQM3D9m+S3WmYLrdU8QZ2Ipu6LYcyMz93YM8
Mz6bvU4+oVp6LoFi6n/fBqOfLyOtFqM2D6UOgqneg7p3jmRk7UmJeODEYw+O1WSUvEJrIHTUg89T
DcHbYQ70UJQssnb7lXBT4mQBzPfGKiTPU9fcej8Dh+Cg5N5DpBLdSBAz10rqQvSUA9x0k5QzYL26
mcfxGgbS8rXgmtzdkFyaT5BVR3su4WCzYAKem8HJR4VeGYKNS//dX1C+boDAy/i5amjxNfkxvoen
1SsxrTtwiNjgiunUs7Qx234w+J8B260cqNMvSutHh4CQOmiOO07GATl6f/iH5G/fCE+C1hVO
--0000000000004db42a064869dbfd--

