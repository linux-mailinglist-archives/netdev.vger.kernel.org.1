Return-Path: <netdev+bounces-196886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2581AD6C8A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20F9189FF11
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6322A7F9;
	Thu, 12 Jun 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV5cmDb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE651F92E;
	Thu, 12 Jun 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721658; cv=none; b=fHpWgLVpc+GRatHLEruMPZLhRZrcjGT3ASC7ggNI4oWTR10suWxpBvQcsdHOoVl53Bv+j1JTVWBmBMEzDVgcelJE0owl9OAGOStvNlYc2e6kS6/A4tvC4vlTpepGqpiITZgIx84QAbvb77oWiLlTnNngApodeofyOujXqKORAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721658; c=relaxed/simple;
	bh=4RfTLzjwFzvRBVIbLwlDB8bIxZi8DpBfKPn88UHuL6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D02CYJC8cs1nmiyz1sbM1Lq0nL3kLNtJMEdZRcWxStXYJNZcp54a/GYP/Ri6IwardD8Y/cRlfvVXVo8UgyLzbf0tIQf3lsOnxiAvH0lW0f2yJ3OHOygYR7Fyf4l7LSelLDxw5Bc5WJCK7lEkJl7Az6DwucbnUfFKl2wUbqhNiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV5cmDb5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236470b2dceso7454975ad.0;
        Thu, 12 Jun 2025 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749721656; x=1750326456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4anYW4XgKhWdrFwLZ/0tNA4p/6Y7eRGkWV12xDwi+ws=;
        b=iV5cmDb55mzaixKMQ7JKf/HptcG3fqeC0c4GxUXmu+sGg4twWbv5px5ynPgFQiK1QE
         SYKs+EbRuvtTgx8dsmBi1D3/QEHaR4TbHkqpqhfgyXyyK7OvgvF3UC5MW4HTkDYSYpHP
         EdKtMpO8YP1L4u6UERgEe6SnNs4YfS/uZI0qexWL8W+XsMlCIbB5L3i0oo4Vo34T4irj
         K3O6Q+GT4Rt6BGRwaqPbGZdMhQx6Zv/FnfChaPZqUH3fQ8hUHjNublt98GncIgzvT9ek
         /JJiUSoroD0PswvPytNSI7tlCz9ESTWexmVWTAhb3D1GdqqMyY//1JfUO92ykqGQhsse
         AUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721656; x=1750326456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4anYW4XgKhWdrFwLZ/0tNA4p/6Y7eRGkWV12xDwi+ws=;
        b=sJzl7fojVk3L+iQyFKG+ti9vf6iv5IHVNSlxQ+niWqe7es1cS96okuOD+Y0VMYYZCT
         /h8HkswQMhZg3XW5WNC5kM6P2O+6J+IkmraIWnQDE6ar0xiV9GZotI6e7b8wd+N1dvjZ
         nKvery7s32mj9gpWLsyhPjn5Wm1uNgFJng4TebveUanBA+a8OmqMeol0gv6atNV5jzUf
         D0Na0Btrn2jTVW1jUBpc10dGnwoLv0UU0Bbia0yVcTnCfcGou0W4Qn/RQXaOjq+cdI/g
         fa8axfctNm7hWOHfhKxSXaZHs3Akxflh/bQAWLZOluHl6diSl5GXUHuxeAahmhswNeTn
         qylg==
X-Forwarded-Encrypted: i=1; AJvYcCVLsvjtaXQcM6DCU0DwsRk0fNsKWlqyms4Pk5tid4YKDscJJMkF0ebiw9OLXnupvmVCCttwfTAzq1HtpJk=@vger.kernel.org, AJvYcCVM7FP/49+uEeFYer2KnyV/FfZAvfDzeum2jI7jkz+6i5r8FWJAraGJKoe/HHU68iL+TEm4RKJW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FTnUEg6CWDTNHOW4KNIDmqLE7EBgDqZuHdg58rvLldMfAAs9
	q7IYQg5K6jzoQIhcPyAFC+Oc3SIH/VSq2HphDEsjy6fD/c4sEv9ZqoDS8xe/BFnkSZ7hHS6/1Zg
	SNhogJRMm1xgp5Eg69xKdeiEWPbaeU0Y=
X-Gm-Gg: ASbGncsgxGRG/Zz0arxSqKsuWyPElQtxLZ0hjN9JehRe2IQLC5bjfxEcnZ0oh55TBw+
	PFdQM4zvB04ThUu9my+obLwOkSUjVj94hIRE749UXTGgFqMjZQl0hZjPko8X14sqC12VhuzBp5y
	8dUDpf4mMzthfa6ac8DrYB9ZylRhDmUJ7KqWVR14OJPOuzzkA+zitmYRri610S75Na/P/Rv++QP
	kgHlQ==
X-Google-Smtp-Source: AGHT+IEn/yEuL+ZT1F+q5GVdc8O0V6/puSbAUJHNnsnmlV8IC38r0eOnzkKfa3MMKLGaKZ+m3C9HsssmyMgcw1fuDvk=
X-Received: by 2002:a17:902:ce81:b0:235:eb8d:800b with SMTP id
 d9443c01a7336-2364d8b7ec8mr33520145ad.26.1749721656497; Thu, 12 Jun 2025
 02:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083747.26531-1-noltari@gmail.com> <20250612083747.26531-5-noltari@gmail.com>
 <CAOiHx=kxcMNDrmzz5Bqd337YrZ23sYNWP0-nZrUynPJXdt4LLg@mail.gmail.com>
In-Reply-To: <CAOiHx=kxcMNDrmzz5Bqd337YrZ23sYNWP0-nZrUynPJXdt4LLg@mail.gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Thu, 12 Jun 2025 11:47:03 +0200
X-Gm-Features: AX0GCFve23f_zwO-L2nFeZiFWzohYflBoyr99dafg6h7XIq29CrUZEHbnOB-Q1E
Message-ID: <CAKR-sGeJ3FWM_0FyuSF=esuvrSDX5w9zwfs7Peof1XDx=sHSpA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/14] net: dsa: b53: detect BCM5325 variants
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

El jue, 12 jun 2025 a las 11:17, Jonas Gorski
(<jonas.gorski@gmail.com>) escribi=C3=B3:
>
> On Thu, Jun 12, 2025 at 10:37=E2=80=AFAM =C3=81lvaro Fern=C3=A1ndez Rojas
> <noltari@gmail.com> wrote:
> >
> > Older BCM5325M switches lack some registers that newer BCM5325E have, s=
o
> > we need to be able to differentiate them in order to check whether the
> > registers are available or not.
>
> Did you test this with a BCM5325M?

Nope, I don't have any device with a BCM5325M.

>
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
> >  drivers/net/dsa/b53/b53_common.c | 34 ++++++++++++++++++++++++++------
> >  drivers/net/dsa/b53/b53_priv.h   | 16 +++++++++++++--
> >  2 files changed, 42 insertions(+), 8 deletions(-)
> >
> >  v3: detect BCM5325 variants as requested by Florian.
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index 222107223d109..2975dab6ee0bb 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -2490,8 +2490,18 @@ struct b53_chip_data {
> >
> >  static const struct b53_chip_data b53_switch_chips[] =3D {
> >         {
> > -               .chip_id =3D BCM5325_DEVICE_ID,
> > -               .dev_name =3D "BCM5325",
> > +               .chip_id =3D BCM5325M_DEVICE_ID,
> > +               .dev_name =3D "BCM5325M",
> > +               .vlans =3D 16,
>
> Are you sure about BCM5325M supporting VLANs at all? All the
> documentation I can find implies it does not. And if it does not, not
> sure if it makes sense to support it.

Since Florian suggested that we should be able to differentiate them I
assumed we were supporting it, but if it doesn't make sense to support
it at all we can drop this patch entirely and not check for 5325m in
B53_VLAN_ID_IDX access of the next patch (5/14).

>
> > +               .enabled_ports =3D 0x3f,
> > +               .arl_bins =3D 2,
> > +               .arl_buckets =3D 1024,
> > +               .imp_port =3D 5,
> > +               .duplex_reg =3D B53_DUPLEX_STAT_FE,
> > +       },
> > +       {
> > +               .chip_id =3D BCM5325E_DEVICE_ID,
> > +               .dev_name =3D "BCM5325E",
> >                 .vlans =3D 16,
> >                 .enabled_ports =3D 0x3f,
> >                 .arl_bins =3D 2,
> > @@ -2938,10 +2948,22 @@ int b53_switch_detect(struct b53_device *dev)
> >                 b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_2=
5, 0xf);
> >                 b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25=
, &tmp);
> >
> > -               if (tmp =3D=3D 0xf)
> > -                       dev->chip_id =3D BCM5325_DEVICE_ID;
> > -               else
> > +               if (tmp =3D=3D 0xf) {
> > +                       u32 phy_id;
> > +                       int val;
> > +
> > +                       val =3D b53_phy_read16(dev->ds, 0, MII_PHYSID1)=
;
> > +                       phy_id =3D (val & 0xffff) << 16;
> > +                       val =3D b53_phy_read16(dev->ds, 0, MII_PHYSID2)=
;
> > +                       phy_id |=3D (val & 0xffff);
>
> You should ignore the least significant nibble, as it encodes the chip re=
vision.

So the correct would be:
val =3D b53_phy_read16(dev->ds, 0, MII_PHYSID2);
phy_id |=3D (val & 0xfff0);
Right?

>
> > +
> > +                       if (phy_id =3D=3D 0x0143bc30)
> > +                               dev->chip_id =3D BCM5325E_DEVICE_ID;
> > +                       else
> > +                               dev->chip_id =3D BCM5325M_DEVICE_ID;
> > +               } else {
> >                         dev->chip_id =3D BCM5365_DEVICE_ID;
> > +               }
> >                 break;
> >         case BCM5389_DEVICE_ID:
> >         case BCM5395_DEVICE_ID:
> > @@ -2975,7 +2997,7 @@ int b53_switch_detect(struct b53_device *dev)
> >                 }
> >         }
> >
> > -       if (dev->chip_id =3D=3D BCM5325_DEVICE_ID)
> > +       if (is5325(dev))
> >                 return b53_read8(dev, B53_STAT_PAGE, B53_REV_ID_25,
> >                                  &dev->core_rev);
> >         else
> > diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_p=
riv.h
> > index a5ef7071ba07b..deea4d83f0e93 100644
> > --- a/drivers/net/dsa/b53/b53_priv.h
> > +++ b/drivers/net/dsa/b53/b53_priv.h
> > @@ -60,7 +60,8 @@ struct b53_io_ops {
> >
> >  enum {
> >         BCM4908_DEVICE_ID =3D 0x4908,
> > -       BCM5325_DEVICE_ID =3D 0x25,
> > +       BCM5325M_DEVICE_ID =3D 0x25,
> > +       BCM5325E_DEVICE_ID =3D 0x25e,
>
> Maybe we should have a b53_priv::variant_id field or so. Other chips
> also can have variants, so we might want to avoid polluting the chip
> id space. We currently don't care about them, but might in the future
> as they have different feature support (e.g. there are bcm531x5
> variants with and without CFP support).

That makes sense.
I can rework this patch with a new variant field if differentiating
the BCM5325M is finally needed.

>
> Regards,
> Jonas

Best regards,
=C3=81lvaro.

