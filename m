Return-Path: <netdev+bounces-194663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB5ACBC26
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C601717DE
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246A1ACEC7;
	Mon,  2 Jun 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcNfx0Wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420F1624E1;
	Mon,  2 Jun 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895004; cv=none; b=AJhab/J6811xO4eO+yVF2bEM0R8ijNmsQNIyUmCpUYe/iRLpZh2xY+AhiV4Ce3Egl9pG84XnpG0YCiljKoj/cvn52hIBZWHEwvgGWbKIdI6ZqeAZ722HB9aZL3MZM8dCb7S0LUuVlKGPmKm48HqzIliggjE0VFPFx79G5EHOFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895004; c=relaxed/simple;
	bh=6qZDabj8Bda67+DLPB4KnKpuGe2k/XXzH/gaF8RDOwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDZ57yiHyS6afrifM4xXwETrClWtXzhKlLkfeJmvWSi8B+B5b3Pjjuzi9qyNGMyxKCR3bDFFp8x/IFyg3PJ3YirlAG/PE8SDRUZ5JY8+OmK7gOfW7j4NeRnUrpljfvpZKsrBILJSdmwFLbJOQzdd1vZES3oarH/5H/qJhuuK7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcNfx0Wo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e6bddc30aso44292507b3.0;
        Mon, 02 Jun 2025 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748895002; x=1749499802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHp5YPOTF5ymwXfL+fLAKg/5AVYIW6ZkuudsLpnkxXk=;
        b=CcNfx0WoMXb9y+8vZQHlHxAW92J5dH9HvGBHFbfRa+adE97/gQYB0IUlSFME/5pkaM
         RW4Et94ctZkaKV1C4CgUpTVOHMNgYCQFb66jPSQ1Uj0ccNlnMFL+BCgWZnb03aW6H4Ki
         8do/lVTmWwKGco+XBIuwub+OyTJkmXGSNfCTQCjg+943bWqYqij845GNDdF1dMIKNsk9
         /se98/BI+vODbug3Z21+GpabvOYINZN7gFJaBhG/FdF7Gje5JDMtCE0FI7B9xDlL7VfJ
         +qRP+dEPAajO5bBzQ3+ijNibA1uKcyyZ7/T2Ivopi061451sOlG0nx8gTNwukxo9h7RH
         igTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895002; x=1749499802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHp5YPOTF5ymwXfL+fLAKg/5AVYIW6ZkuudsLpnkxXk=;
        b=YShq6J7ZI3HqDe0MGyEU06rpTnyvyKeogT/IhZusXaO1x19YzYQdxzEyJKLfH4pTR4
         IPNwOmahsqQiVqA7jCmGZrzKhCyMaIFC3+ard5azOnE2Z0Hl5fYXOBRJ8iul1EnMRuVd
         izVVB519yTcIvHWaCJA92mul19qKrKXJLpodkxdHAJrNnfEVfx3Pv0AboeL6kV/8OlNw
         SDh4ZEEjEzqMvUf4WxTi0IJedOSjUzWKbjk3dKOyvC98VVMq/D0ebYMx8yopMKE5bjYD
         THkE1A9XAXSo7knj7UY+RlNOaUubjcnKBg/dNI8Dt6tm7IMsaBTMtSKzaqrg/fWkMOW4
         eLww==
X-Forwarded-Encrypted: i=1; AJvYcCW4JIYSaVURsPRa7wlFytCyF2fm82EMGKqpeNzg4KJKeCGBXBNihPkt/W58KBChIHG3/+E9zBbu@vger.kernel.org, AJvYcCWUOfodw7BYyP4LVOHjWXnEEB7nUC/7N2wjHH381g9DnQZ2wVUFH3ZxYT4bfKKIRXRIuY3tGS/LpgxZKrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ks61YR+6wP7lUK90wLPmjlV29eyzM/QF94GvUOpu9n56G503
	Iw4pb70luIMXaWWy8BrMyzl3gWnCHlzox0A1OtLHI4WITKo7TXTks4DaUu3/7j6PnTubT6AWqse
	0OZ1qEI7fBYGL4w6UX8JTaQknlyYrCoU=
X-Gm-Gg: ASbGnctlcR0rKVtrfvcGPmwKpHp2vwcYQU2H03dKHifxUOokJHBn1Q/vQAjSUn3RXtO
	0JkbehYGwMSl3sMtyU3s3NUJNAYKekDk5TojaDrW06pjv3c/Ix8TgzYcJ5S/5N9uMket70cnUH2
	sDF983NqW2OmfSeNS5/qB7hpjb34Gnots=
X-Google-Smtp-Source: AGHT+IEG8+rYkZ8J0ad63XxaLdh3Bt8Ko5va2+0Nzp1oBW0obEFzDklDSh9QFKsvuqHam2yzUY9uDai2X7YQbBcQIbg=
X-Received: by 2002:a05:690c:4988:b0:70e:143:b82f with SMTP id
 00721157ae682-71097e2a415mr141984667b3.32.1748895001924; Mon, 02 Jun 2025
 13:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-2-noltari@gmail.com>
In-Reply-To: <20250531101308.155757-2-noltari@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 2 Jun 2025 22:09:50 +0200
X-Gm-Features: AX0GCFvLRivx8hP9shOr9DRFXc3O_mmvS_BF19GgVVfIIjI1Yj5LaA3IDyr4XxU
Message-ID: <CAOiHx=nEZrszxSdBrGmZXKCi_VVAQQUX4bb9AxWFJ1K-O3pNmg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: dsa: b53: add support for FDB operations
 on 5325/5365
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com, 
	Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:13=E2=80=AFPM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> From: Florian Fainelli <f.fainelli@gmail.com>
>
> BCM5325 and BCM5365 are part of a much older generation of switches which=
,
> due to their limited number of ports and VLAN entries (up to 256) allowed
> a single 64-bit register to hold a full ARL entry.
> This requires a little bit of massaging when reading, writing and
> converting ARL entries in both directions.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 60 +++++++++++++++++++++-----------
>  drivers/net/dsa/b53/b53_priv.h   | 57 +++++++++++++++++++++---------
>  drivers/net/dsa/b53/b53_regs.h   |  7 ++--
>  3 files changed, 84 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 132683ed3abe..03c1e2e75061 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1760,9 +1760,11 @@ static int b53_arl_read(struct b53_device *dev, u6=
4 mac,
>
>                 b53_read64(dev, B53_ARLIO_PAGE,
>                            B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
> -               b53_read32(dev, B53_ARLIO_PAGE,
> -                          B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
> -               b53_arl_to_entry(ent, mac_vid, fwd_entry);
> +
> +               if (!is5325(dev) && !is5365(dev))
> +                       b53_read32(dev, B53_ARLIO_PAGE,
> +                                  B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
> +               b53_arl_to_entry(dev, ent, mac_vid, fwd_entry);
>
>                 if (!(fwd_entry & ARLTBL_VALID)) {
>                         set_bit(i, free_bins);
> @@ -1795,7 +1797,8 @@ static int b53_arl_op(struct b53_device *dev, int o=
p, int port,
>
>         /* Perform a read for the given MAC and VID */
>         b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
> -       b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
> +       if (!is5325(dev))
> +               b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
>
>         /* Issue a read operation for this MAC */
>         ret =3D b53_arl_rw_op(dev, 1);
> @@ -1846,12 +1849,14 @@ static int b53_arl_op(struct b53_device *dev, int=
 op, int port,
>         ent.is_static =3D true;
>         ent.is_age =3D false;
>         memcpy(ent.mac, addr, ETH_ALEN);
> -       b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
> +       b53_arl_from_entry(dev, &mac_vid, &fwd_entry, &ent);
>
>         b53_write64(dev, B53_ARLIO_PAGE,
>                     B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
> -       b53_write32(dev, B53_ARLIO_PAGE,
> -                   B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
> +
> +       if (!is5325(dev) && !is5365(dev))
> +               b53_write32(dev, B53_ARLIO_PAGE,
> +                           B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
>
>         return b53_arl_rw_op(dev, 0);
>  }
> @@ -1863,12 +1868,6 @@ int b53_fdb_add(struct dsa_switch *ds, int port,
>         struct b53_device *priv =3D ds->priv;
>         int ret;
>
> -       /* 5325 and 5365 require some more massaging, but could
> -        * be supported eventually
> -        */
> -       if (is5325(priv) || is5365(priv))
> -               return -EOPNOTSUPP;
> -
>         mutex_lock(&priv->arl_mutex);
>         ret =3D b53_arl_op(priv, 0, port, addr, vid, true);
>         mutex_unlock(&priv->arl_mutex);
> @@ -1895,10 +1894,15 @@ EXPORT_SYMBOL(b53_fdb_del);
>  static int b53_arl_search_wait(struct b53_device *dev)
>  {
>         unsigned int timeout =3D 1000;
> -       u8 reg;
> +       u8 reg, offset;
> +
> +       if (is5325(dev) || is5365(dev))
> +               offset =3D B53_ARL_SRCH_CTL_25;
> +       else
> +               offset =3D B53_ARL_SRCH_CTL;
>
>         do {
> -               b53_read8(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_CTL, &reg);
> +               b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
>                 if (!(reg & ARL_SRCH_STDN))
>                         return 0;
>
> @@ -1917,11 +1921,19 @@ static void b53_arl_search_rd(struct b53_device *=
dev, u8 idx,
>         u64 mac_vid;
>         u32 fwd_entry;
>
> -       b53_read64(dev, B53_ARLIO_PAGE,
> -                  B53_ARL_SRCH_RSTL_MACVID(idx), &mac_vid);
> -       b53_read32(dev, B53_ARLIO_PAGE,
> -                  B53_ARL_SRCH_RSTL(idx), &fwd_entry);
> -       b53_arl_to_entry(ent, mac_vid, fwd_entry);
> +       if (is5325(dev)) {
> +               b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVI=
D_25,
> +                          &mac_vid);
> +       } else if (is5365(dev)) {
> +               b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVI=
D_65,
> +                          &mac_vid);
> +       } else {
> +               b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(=
idx),
> +                          &mac_vid);
> +               b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
> +                          &fwd_entry);
> +       }
> +       b53_arl_to_entry(dev, ent, mac_vid, fwd_entry);
>  }
>
>  static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
> @@ -1942,14 +1954,20 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
>         struct b53_device *priv =3D ds->priv;
>         struct b53_arl_entry results[2];
>         unsigned int count =3D 0;
> +       u8 offset;
>         int ret;
>         u8 reg;
>
>         mutex_lock(&priv->arl_mutex);
>
> +       if (is5325(priv) || is5365(priv))
> +               offset =3D B53_ARL_SRCH_CTL_25;
> +       else
> +               offset =3D B53_ARL_SRCH_CTL;
> +
>         /* Start search operation */
>         reg =3D ARL_SRCH_STDN;
> -       b53_write8(priv, B53_ARLIO_PAGE, B53_ARL_SRCH_CTL, reg);
> +       b53_write8(priv, offset, B53_ARL_SRCH_CTL, reg);
>
>         do {
>                 ret =3D b53_arl_search_wait(priv);
> diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_pri=
v.h
> index a5ef7071ba07..05c5b9239bda 100644
> --- a/drivers/net/dsa/b53/b53_priv.h
> +++ b/drivers/net/dsa/b53/b53_priv.h
> @@ -286,30 +286,55 @@ struct b53_arl_entry {
>         u8 is_static:1;
>  };
>
> -static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
> +static inline void b53_arl_to_entry(struct b53_device *dev,
> +                                   struct b53_arl_entry *ent,
>                                     u64 mac_vid, u32 fwd_entry)
>  {
>         memset(ent, 0, sizeof(*ent));
> -       ent->port =3D fwd_entry & ARLTBL_DATA_PORT_ID_MASK;
> -       ent->is_valid =3D !!(fwd_entry & ARLTBL_VALID);
> -       ent->is_age =3D !!(fwd_entry & ARLTBL_AGE);
> -       ent->is_static =3D !!(fwd_entry & ARLTBL_STATIC);
> -       u64_to_ether_addr(mac_vid, ent->mac);
> -       ent->vid =3D mac_vid >> ARLTBL_VID_S;
> +       if (is5325(dev) || is5365(dev)) {
> +               ent->port =3D (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
> +                           ARLTBL_DATA_PORT_ID_MASK_25;
> +               ent->is_valid =3D !!(mac_vid & ARLTBL_VALID_25);
> +               ent->is_age =3D !!(mac_vid & ARLTBL_AGE_25);
> +               ent->is_static =3D !!(mac_vid & ARLTBL_STATIC_25);
> +               u64_to_ether_addr(mac_vid, ent->mac);
> +               ent->vid =3D mac_vid >> ARLTBL_VID_S_65;
> +       } else {
> +               ent->port =3D fwd_entry & ARLTBL_DATA_PORT_ID_MASK;
> +               ent->is_valid =3D !!(fwd_entry & ARLTBL_VALID);
> +               ent->is_age =3D !!(fwd_entry & ARLTBL_AGE);
> +               ent->is_static =3D !!(fwd_entry & ARLTBL_STATIC);
> +               u64_to_ether_addr(mac_vid, ent->mac);
> +               ent->vid =3D mac_vid >> ARLTBL_VID_S;
> +       }
>  }
>
> -static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
> +static inline void b53_arl_from_entry(struct b53_device *dev,
> +                                     u64 *mac_vid, u32 *fwd_entry,
>                                       const struct b53_arl_entry *ent)
>  {
>         *mac_vid =3D ether_addr_to_u64(ent->mac);
> -       *mac_vid |=3D (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL_VID_S;
> -       *fwd_entry =3D ent->port & ARLTBL_DATA_PORT_ID_MASK;
> -       if (ent->is_valid)
> -               *fwd_entry |=3D ARLTBL_VALID;
> -       if (ent->is_static)
> -               *fwd_entry |=3D ARLTBL_STATIC;
> -       if (ent->is_age)
> -               *fwd_entry |=3D ARLTBL_AGE;
> +       if (is5325(dev) || is5365(dev)) {
> +               *mac_vid |=3D (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_=
25) <<
> +                                 ARLTBL_DATA_PORT_ID_S_25;
> +               *mac_vid |=3D (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
> +                                 ARLTBL_VID_S_65;
> +               if (ent->is_valid)
> +                       *mac_vid |=3D ARLTBL_VALID_25;
> +               if (ent->is_static)
> +                       *mac_vid |=3D ARLTBL_STATIC_25;
> +               if (ent->is_age)
> +                       *mac_vid |=3D ARLTBL_AGE_25;
> +       } else {
> +               *mac_vid |=3D (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL=
_VID_S;
> +               *fwd_entry =3D ent->port & ARLTBL_DATA_PORT_ID_MASK;
> +               if (ent->is_valid)
> +                       *fwd_entry |=3D ARLTBL_VALID;
> +               if (ent->is_static)
> +                       *fwd_entry |=3D ARLTBL_STATIC;
> +               if (ent->is_age)
> +                       *fwd_entry |=3D ARLTBL_AGE;
> +       }
>  }

Looking at the low amount of shared code in all of these changes,
maybe it would make more sense to have separate functions for 5325
instead, e.g. have a  b53_arl_from_entry_25() that doesn't take a
fwd_entry etc.

Regards,
Jonas

