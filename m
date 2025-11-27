Return-Path: <netdev+bounces-242177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29337C8D250
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2D4D4E17CE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA0318120;
	Thu, 27 Nov 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR2pw/zp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCB271443
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229366; cv=none; b=gteC76c8jka575mlI8aqMVh2GjO3S5WntTFd0J9nzK7CSjARzbmaRm1vEB/n/9Liw8bxP3awJvE206Px0PcptA1z8bzLGOakQI3TliGUGdMtCScYsqh+HpWAUMg+9wP/2ZpX7gajqTJzlIf34cGtecca2phQyxMBFt6gpGUH4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229366; c=relaxed/simple;
	bh=fHAFSqYrWymrIMhWT1z391H9KRyY231aWvYby8ijFgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViFxfRs+7X7UHUYGbV4mNWQafg6W03FnHULKi7ehb/P8xOKO7dvaCHc81PSLBXAiC9QxAG5KPsOVVfIu5mV3qsJ2Z8jX8W0jPo+7r0qq2l9sYgHZLN8b7tAiRwt2bUhh3VfHDQS3z7c/yA/MPtWSvGU/oEpPuO/GUIqpqx8BpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR2pw/zp; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a7af9fe4fso5553677b3.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229364; x=1764834164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s+lGtq/FjwF9TG7daW93flP5eOXaX9Z6GsP51FKsX8=;
        b=XR2pw/zp6cM4pEUg+jLjYC/NxVQh3Ijq1MBH1kTUBBYBZSYCDLXhzhk25Lbpc2Xa2m
         F1uvpLaQp0w6ZmqzKu8wosdZAEa6KmlR67Ihwiy4B+AzMNc/Nd3BuqRaNbaZ5BuTHhf0
         AoaoIZwVltpIgrZjoajw52AuF41VWtduvHBNc+D4Faq5kAZRcz8S1xPRda0L1DpB7gxG
         /lz3NQxX+7wFaZW7g3ehL/PwrqpNA7DDrRd61tocJ5Jk8+qoTNEtvAg84ec8EfCyHfnp
         lIWvQBw71S8VIEgG+/h2RUho7PjK5DQocOsLFwVdspJyZekTr8BAftK8/yVKMVRHKpjf
         rbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229364; x=1764834164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0s+lGtq/FjwF9TG7daW93flP5eOXaX9Z6GsP51FKsX8=;
        b=P560LWGNkn3lnBjpDAU2qHy3/+7THMgOn3mOONHMywI3zknXpB8bNvo91u7x1aBllm
         RXAEYOSbz+Xv+2oTmYgj0TBaPe3TdK3bfIq4rr96MTXoilmCFiIkVuA3zgM0gdXVBLs2
         QOzMz8hYi8W9Qxf7A6X3dnvSmSbAK10b3jyl9KgQ8EftxYtLN3ZcAePT88a6jUvntL+B
         seWEDlt84XOwqcyc4grZwM1LmlFmXrf3HJYh207tI/1c1BNIb26Sl3cF76A+nTLNLjtz
         Z4lIGJkmD4avZNJU/soBk5cu1ZphrhWRVObYnFkltEa+OX/dS6i71Ishp5fzWTLrdkxc
         SxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWWizOXyNgpLik9g1+H2LaaX5FpYisBXe0SFqU9V5crsHs1VVkFtqcjjxonLR92FXGqKVX+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEc3Hz54n8xANJTuKVyVAJLkGvL3gRdDTDUbSEijt9uapmvfy
	cvzzWVIZELmBqrzSqHYCjqKLuxoc3Z0PfSZRkllrssKU2iQ/Pta+DW7JC3mjqldoWYHTRp14Y8e
	pVqfH9KaOaVout915q/zheKAaI2OjQSQ=
X-Gm-Gg: ASbGncsTWI9zM8BbWujMFmfFXNlbI805pPtkzb8HbjhURFfsGWHHAgqBZXZCsGorHqV
	ArPvbkYdc+jt53pcrK9tqsnq95v+HETmhuat0N29blnugEREAbRrx+nYq7DOrBDmA6u9qP1TeNj
	je5jwBbfNdkhD1FXbDAcygUqJ4EpfZImrCsP6MIJC0iJya1pWBfmANKDZyOmnAq+BHwRnqGBIK/
	+IrIS/V75NFtUl7495ioruS9eIBlt2rbl8uvX1HPlSeKruELXd7tkI8lLgrjoRSdewi2A==
X-Google-Smtp-Source: AGHT+IGT6CGsB7Usnzyfxo67b+IkZOsMuFPTHSRIn2T6WhwEk4p8Wl8HKysJF49vHWu54pqPWxQMGpKildwftGtDYJ8=
X-Received: by 2002:a05:690c:6201:b0:788:20ec:c17f with SMTP id
 00721157ae682-78a8b539269mr197005357b3.39.1764229363950; Wed, 26 Nov 2025
 23:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-8-jonas.gorski@gmail.com> <20251125203119.fw746rr3ootunqts@skbuf>
In-Reply-To: <20251125203119.fw746rr3ootunqts@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 27 Nov 2025 08:42:33 +0100
X-Gm-Features: AWmQ_bm7NXXuqwG60hqOZozOV1vet_6FzLZaSS2Ikfny8B3_mVNRnhztOw7cjwg
Message-ID: <CAOiHx==e3ZiFmA4XJe+6V02r0Wszrcy+v_DFRtMBPYrkNkqkjA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] net: dsa: b53: allow VID 0 for BCM5325/65
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:31=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hi Jonas,
>
> On Tue, Nov 25, 2025 at 08:51:50AM +0100, Jonas Gorski wrote:
> > Now that writing ARL entries works properly, we can actually use VID 0
> > as the default untagged VLAN for BCM5325 and BCM5365 as well, so use 0
> > as default PVID always.
> >
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  drivers/net/dsa/b53/b53_common.c | 49 +++++++++++---------------------
> >  1 file changed, 17 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index ac995f36ed95..4eff64204897 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -870,14 +870,6 @@ static void b53_enable_stp(struct b53_device *dev)
> >       b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
> >  }
> >
> > -static u16 b53_default_pvid(struct b53_device *dev)
> > -{
> > -     if (is5325(dev) || is5365(dev))
> > -             return 1;
> > -     else
> > -             return 0;
> > -}
> > -
>
> I am in favour of a more minimal change, where b53_default_pvid()
> returns 0, and its call sites are kept unmodified, if only and for
> code documentation purposes. Other drivers use a macro to avoid
> hardcoding the 0 everywhere the default VLAN is meant. This driver
> doesn't have a macro but it already has b53_default_pvid().

Sure, I can do that.

> >  static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, i=
nt port)
> >  {
> >       struct b53_device *dev =3D ds->priv;
> > @@ -906,14 +898,12 @@ int b53_configure_vlan(struct dsa_switch *ds)
> >       struct b53_device *dev =3D ds->priv;
> >       struct b53_vlan vl =3D { 0 };
> >       struct b53_vlan *v;
> > -     int i, def_vid;
> >       u16 vid;
> > -
> > -     def_vid =3D b53_default_pvid(dev);
> > +     int i;
> >
> >       /* clear all vlan entries */
> >       if (is5325(dev) || is5365(dev)) {
> > -             for (i =3D def_vid; i < dev->num_vlans; i++)
> > +             for (i =3D 0; i < dev->num_vlans; i++)
> >                       b53_set_vlan_entry(dev, i, &vl);
> >       } else {
> >               b53_do_vlan_op(dev, VTA_CMD_CLEAR);
> > @@ -927,7 +917,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
> >        * entry. Do this only when the tagging protocol is not
> >        * DSA_TAG_PROTO_NONE
> >        */
> > -     v =3D &dev->vlans[def_vid];
> > +     v =3D &dev->vlans[0];
> >       b53_for_each_port(dev, i) {
> >               if (!b53_vlan_port_may_join_untagged(ds, i))
> >                       continue;
> > @@ -935,16 +925,15 @@ int b53_configure_vlan(struct dsa_switch *ds)
> >               vl.members |=3D BIT(i);
> >               if (!b53_vlan_port_needs_forced_tagged(ds, i))
> >                       vl.untag =3D vl.members;
> > -             b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
> > -                         def_vid);
> > +             b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),=
 0);
> >       }
> > -     b53_set_vlan_entry(dev, def_vid, &vl);
> > +     b53_set_vlan_entry(dev, 0, &vl);
> >
> >       if (dev->vlan_filtering) {
> >               /* Upon initial call we have not set-up any VLANs, but up=
on
> >                * system resume, we need to restore all VLAN entries.
> >                */
> > -             for (vid =3D def_vid + 1; vid < dev->num_vlans; vid++) {
> > +             for (vid =3D 1; vid < dev->num_vlans; vid++) {
> >                       v =3D &dev->vlans[vid];
> >
> >                       if (!v->members)
> > @@ -1280,7 +1269,6 @@ static int b53_setup(struct dsa_switch *ds)
> >       struct b53_device *dev =3D ds->priv;
> >       struct b53_vlan *vl;
> >       unsigned int port;
> > -     u16 pvid;
> >       int ret;
> >
> >       /* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
> > @@ -1310,8 +1298,7 @@ static int b53_setup(struct dsa_switch *ds)
> >       }
> >
> >       /* setup default vlan for filtering mode */
> > -     pvid =3D b53_default_pvid(dev);
> > -     vl =3D &dev->vlans[pvid];
> > +     vl =3D &dev->vlans[0];
> >       b53_for_each_port(dev, port) {
> >               vl->members |=3D BIT(port);
> >               if (!b53_vlan_port_needs_forced_tagged(ds, port))
> > @@ -1740,7 +1727,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
> >       if (pvid)
> >               new_pvid =3D vlan->vid;
> >       else if (!pvid && vlan->vid =3D=3D old_pvid)
> > -             new_pvid =3D b53_default_pvid(dev);
> > +             new_pvid =3D 0;
> >       else
> >               new_pvid =3D old_pvid;
> >       dev->ports[port].pvid =3D new_pvid;
> > @@ -1790,7 +1777,7 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
> >       vl->members &=3D ~BIT(port);
> >
> >       if (pvid =3D=3D vlan->vid)
> > -             pvid =3D b53_default_pvid(dev);
> > +             pvid =3D 0;
> >       dev->ports[port].pvid =3D pvid;
> >
> >       if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
> > @@ -2269,7 +2256,7 @@ int b53_br_join(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge,
> >       struct b53_device *dev =3D ds->priv;
> >       struct b53_vlan *vl;
> >       s8 cpu_port =3D dsa_to_port(ds, port)->cpu_dp->index;
> > -     u16 pvlan, reg, pvid;
> > +     u16 pvlan, reg;
> >       unsigned int i;
> >
> >       /* On 7278, port 7 which connects to the ASP should only receive
> > @@ -2278,8 +2265,7 @@ int b53_br_join(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge,
> >       if (dev->chip_id =3D=3D BCM7278_DEVICE_ID && port =3D=3D 7)
> >               return -EINVAL;
> >
> > -     pvid =3D b53_default_pvid(dev);
> > -     vl =3D &dev->vlans[pvid];
> > +     vl =3D &dev->vlans[0];
> >
> >       if (dev->vlan_filtering) {
> >               /* Make this port leave the all VLANs join since we will =
have
> > @@ -2295,9 +2281,9 @@ int b53_br_join(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge,
> >                                   reg);
> >               }
> >
> > -             b53_get_vlan_entry(dev, pvid, vl);
> > +             b53_get_vlan_entry(dev, 0, vl);
> >               vl->members &=3D ~BIT(port);
> > -             b53_set_vlan_entry(dev, pvid, vl);
> > +             b53_set_vlan_entry(dev, 0, vl);
> >       }
> >
> >       b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan=
);
> > @@ -2336,7 +2322,7 @@ void b53_br_leave(struct dsa_switch *ds, int port=
, struct dsa_bridge bridge)
> >       struct b53_vlan *vl;
> >       s8 cpu_port =3D dsa_to_port(ds, port)->cpu_dp->index;
> >       unsigned int i;
> > -     u16 pvlan, reg, pvid;
> > +     u16 pvlan, reg;
> >
> >       b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan=
);
> >
> > @@ -2361,8 +2347,7 @@ void b53_br_leave(struct dsa_switch *ds, int port=
, struct dsa_bridge bridge)
> >       b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan=
);
> >       dev->ports[port].vlan_ctl_mask =3D pvlan;
> >
> > -     pvid =3D b53_default_pvid(dev);
> > -     vl =3D &dev->vlans[pvid];
> > +     vl =3D &dev->vlans[0];
> >
> >       if (dev->vlan_filtering) {
> >               /* Make this port join all VLANs without VLAN entries */
> > @@ -2374,9 +2359,9 @@ void b53_br_leave(struct dsa_switch *ds, int port=
, struct dsa_bridge bridge)
> >                       b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN=
_EN, reg);
> >               }
> >
> > -             b53_get_vlan_entry(dev, pvid, vl);
> > +             b53_get_vlan_entry(dev, 0, vl);
> >               vl->members |=3D BIT(port);
> > -             b53_set_vlan_entry(dev, pvid, vl);
> > +             b53_set_vlan_entry(dev, 0, vl);
> >       }
> >  }
> >  EXPORT_SYMBOL(b53_br_leave);
> > --
> > 2.43.0
> >
>
> Not covered in this patch, but I wonder whether it should have been.
>
> This test in b53_vlan_prepare() seems obsolete and a good candidate for
> removal:
>
>         if ((is5325(dev) || is5365(dev)) && vlan->vid =3D=3D 0)
>                 return -EOPNOTSUPP;

Ah, good catch. Yeah, that should/can be removed.

>
> especially since we already have the same check below in b53_vlan_add()
> for all chip IDs:
>
>         if (vlan->vid =3D=3D 0)
>                 return 0;

Arguably the 5325/65 check could have already been dropped at that
time I added this.

I'll send a v2 later.

Best regards,
Jonas

