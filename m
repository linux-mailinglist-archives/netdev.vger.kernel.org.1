Return-Path: <netdev+bounces-126257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66E9703FB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AEA282FFA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C4165EFA;
	Sat,  7 Sep 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P23sX4Od"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AD1DDC9;
	Sat,  7 Sep 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725739102; cv=none; b=lWJm7Zwomkjo4GidsiIM4J19cINUS153goildAvPfJnBuSmAzA4yBnXaWtaDVWz0ac4MDwwk2bSyxb/xHvbicGzBSzyrRzutQsd025caT+t9gvATe7wamJSnkJiHkj+uVqkXK+TkFFo4oWfuPEHVGX7Qi2D2KiDIFNJqENLXFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725739102; c=relaxed/simple;
	bh=mXTWEosx6hmLysJk2H37TYGR4TQ/vmh6rRqJJ0ekdvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTXeerP7go6y1zYVyX6f52Qn+m+79QcMXu52POW62ZSchJbPyo4C3i4TEfI/QPzR1pbXuP33gsgMHsF2cmmRIqYGS+F9slsooDByBAo8gDASo2+ZiU4pkjzkcZKuTvWvtD5iD/1kveep9V/TBrFroa77HGSsbjU2zkLHQW+8UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P23sX4Od; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d9f65f9e3eso29372887b3.3;
        Sat, 07 Sep 2024 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725739100; x=1726343900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOTCbq/sW0efKS+98vJ1rm+6hr2f1VMIv6gcYD7fw7E=;
        b=P23sX4OdpaNJgsQq03gW6DJ+tHgwNvuH4Hpxzr/TmbqyBfoqFr/zDBo5oRrsHCvH8O
         tmsM1T4DMwO29TDqrLKba3OFJ8XgCInc4eNDFohQU8BoPLPDZa+afVLEfW6w8aFYw/Y9
         kLvvltIqjSLIgj3nu4bopJeLneI6GtyFNLT7PmZg0+jMJsUVbN3ZMQtxm7sUqUVxF3K3
         cLER2xYSxnp46czA0UhhyofKDlvAjz9VEkdd5eyBEbGUeNmzpI7rCWKY6HtB5wpmzn7c
         hKcRTNVj0ncOqvS69ROc3h39r/hW6ORly9ERtRdmaZkoWOJfjdCCBCFqFHqsVQpftjqH
         dtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725739100; x=1726343900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOTCbq/sW0efKS+98vJ1rm+6hr2f1VMIv6gcYD7fw7E=;
        b=FAFZTQEHsoy91+fFMdMeKlOUQ9GJxSwrwKSNuIDlAopXOrvTXhXvzm7NJq3+y5BySp
         L3r9n21F3YEImY9ONSZpASyBUnGgH6J8wzICb17KmwtcLCZoVsOPBKIWYcLsVicNRQKP
         bmUbQsx1LJCU1gHDfQzkqygMMevYz6/AlG9NrfYSdmwP9gMmGUzFxjV345CMcY9Yoivy
         rth7p6yz10r4xjgg6VX6QP0e7hSKeZVATLBXSQV7H1yifA+/sjMCOuNeGV8oCHMtovCw
         +jBBDQDpS6xWBnYEvgfFVlM39df7YGmAHihfj3bxrdVU+ZgjouXJepF5bdpUeDGZ7Fr1
         UPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzy1fMkcedeElhgchhSyCeWK/K3LLrcf77/PrVHBwoiIH2Lz2hP9mnczCNmXaMkg0nrMJcLeLAH5nbyKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PNOWnMGauS/nB60y665MfFDTCTJhH1HWOM0oEDjmxNZwIJxa
	M99t1x26nKStq4ZtdN5dAry0Cjf9u8zy7np0+xmLh5AbataSUNSEt6bN/fC7eby7xcyUQCQGhvj
	LX+hgxb9dlHu2cXPp7ar3WAW2qkI=
X-Google-Smtp-Source: AGHT+IFBXczbNHb0Xp8PlFntEPArh9FxxfwJG8qNc4SPgCs2M8wr4I8xLPpUzL1i/QKBtwY8TWiLsOkLnWGeLFiceg0=
X-Received: by 2002:a05:690c:2b0e:b0:64b:4a9f:540d with SMTP id
 00721157ae682-6db4516c22amr59648357b3.31.1725739099876; Sat, 07 Sep 2024
 12:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905201506.12679-1-rosenp@gmail.com> <20240905201506.12679-7-rosenp@gmail.com>
 <8f0413fc-42d6-4b26-81e7-affbea66868f@wanadoo.fr>
In-Reply-To: <8f0413fc-42d6-4b26-81e7-affbea66868f@wanadoo.fr>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 7 Sep 2024 12:58:08 -0700
Message-ID: <CAKxU2N-f=B2Kc4iLi_f4e1kyGgKEi5K2B8GfnzLi1=qLovJu+Q@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 6/9] net: ibm: emac: use netdev's phydev directly
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 12:32=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 05/09/2024 =C3=A0 22:15, Rosen Penev a =C3=A9crit :
> > Avoids having to use own struct member.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/ethernet/ibm/emac/core.c | 47 +++++++++++++--------------=
-
> >   drivers/net/ethernet/ibm/emac/core.h |  3 --
> >   2 files changed, 21 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index e2abda947a51..cda368701ae4 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -2459,7 +2459,7 @@ static int emac_read_uint_prop(struct device_node=
 *np, const char *name,
> >   static void emac_adjust_link(struct net_device *ndev)
> >   {
> >       struct emac_instance *dev =3D netdev_priv(ndev);
> > -     struct phy_device *phy =3D dev->phy_dev;
> > +     struct phy_device *phy =3D ndev->phydev;
> >
> >       dev->phy.autoneg =3D phy->autoneg;
> >       dev->phy.speed =3D phy->speed;
> > @@ -2510,22 +2510,20 @@ static int emac_mdio_phy_start_aneg(struct mii_=
phy *phy,
> >   static int emac_mdio_setup_aneg(struct mii_phy *phy, u32 advertise)
> >   {
> >       struct net_device *ndev =3D phy->dev;
> > -     struct emac_instance *dev =3D netdev_priv(ndev);
> >
> >       phy->autoneg =3D AUTONEG_ENABLE;
> >       phy->advertising =3D advertise;
> > -     return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
> > +     return emac_mdio_phy_start_aneg(phy, ndev->phydev);
> >   }
> >
> >   static int emac_mdio_setup_forced(struct mii_phy *phy, int speed, int=
 fd)
> >   {
> >       struct net_device *ndev =3D phy->dev;
> > -     struct emac_instance *dev =3D netdev_priv(ndev);
> >
> >       phy->autoneg =3D AUTONEG_DISABLE;
> >       phy->speed =3D speed;
> >       phy->duplex =3D fd;
> > -     return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
> > +     return emac_mdio_phy_start_aneg(phy, ndev->phydev);
> >   }
> >
> >   static int emac_mdio_poll_link(struct mii_phy *phy)
> > @@ -2534,20 +2532,19 @@ static int emac_mdio_poll_link(struct mii_phy *=
phy)
> >       struct emac_instance *dev =3D netdev_priv(ndev);
> >       int res;
> >
> > -     res =3D phy_read_status(dev->phy_dev);
> > +     res =3D phy_read_status(ndev->phydev);
> >       if (res) {
> >               dev_err(&dev->ofdev->dev, "link update failed (%d).", res=
);
> >               return ethtool_op_get_link(ndev);
> >       }
> >
> > -     return dev->phy_dev->link;
> > +     return ndev->phydev->link;
> >   }
> >
> >   static int emac_mdio_read_link(struct mii_phy *phy)
> >   {
> >       struct net_device *ndev =3D phy->dev;
> > -     struct emac_instance *dev =3D netdev_priv(ndev);
> > -     struct phy_device *phy_dev =3D dev->phy_dev;
> > +     struct phy_device *phy_dev =3D ndev->phydev;
> >       int res;
> >
> >       res =3D phy_read_status(phy_dev);
> > @@ -2564,10 +2561,9 @@ static int emac_mdio_read_link(struct mii_phy *p=
hy)
> >   static int emac_mdio_init_phy(struct mii_phy *phy)
> >   {
> >       struct net_device *ndev =3D phy->dev;
> > -     struct emac_instance *dev =3D netdev_priv(ndev);
> >
> > -     phy_start(dev->phy_dev);
> > -     return phy_init_hw(dev->phy_dev);
> > +     phy_start(ndev->phydev);
> > +     return phy_init_hw(ndev->phydev);
> >   }
> >
> >   static const struct mii_phy_ops emac_dt_mdio_phy_ops =3D {
> > @@ -2622,26 +2618,28 @@ static int emac_dt_mdio_probe(struct emac_insta=
nce *dev)
> >   static int emac_dt_phy_connect(struct emac_instance *dev,
> >                              struct device_node *phy_handle)
> >   {
> > +     struct phy_device *phy_dev;
> > +
> >       dev->phy.def =3D devm_kzalloc(&dev->ofdev->dev, sizeof(*dev->phy.=
def),
> >                                   GFP_KERNEL);
> >       if (!dev->phy.def)
> >               return -ENOMEM;
> >
> > -     dev->phy_dev =3D of_phy_connect(dev->ndev, phy_handle, &emac_adju=
st_link,
> > +     phy_dev =3D of_phy_connect(dev->ndev, phy_handle, &emac_adjust_li=
nk,
> >                                     0, dev->phy_mode);
> > -     if (!dev->phy_dev) {
> > +     if (!phy_dev) {
> >               dev_err(&dev->ofdev->dev, "failed to connect to PHY.\n");
> >               return -ENODEV;
> >       }
> >
> > -     dev->phy.def->phy_id =3D dev->phy_dev->drv->phy_id;
> > -     dev->phy.def->phy_id_mask =3D dev->phy_dev->drv->phy_id_mask;
> > -     dev->phy.def->name =3D dev->phy_dev->drv->name;
> > +     dev->phy.def->phy_id =3D phy_dev->drv->phy_id;
> > +     dev->phy.def->phy_id_mask =3D phy_dev->drv->phy_id_mask;
> > +     dev->phy.def->name =3D phy_dev->drv->name;
> >       dev->phy.def->ops =3D &emac_dt_mdio_phy_ops;
> >       ethtool_convert_link_mode_to_legacy_u32(&dev->phy.features,
> > -                                             dev->phy_dev->supported);
> > -     dev->phy.address =3D dev->phy_dev->mdio.addr;
> > -     dev->phy.mode =3D dev->phy_dev->interface;
> > +                                             phy_dev->supported);
> > +     dev->phy.address =3D phy_dev->mdio.addr;
> > +     dev->phy.mode =3D phy_dev->interface;
> >       return 0;
> >   }
> >
> > @@ -2695,11 +2693,11 @@ static int emac_init_phy(struct emac_instance *=
dev)
> >                               return res;
> >
> >                       res =3D of_phy_register_fixed_link(np);
> > -                     dev->phy_dev =3D of_phy_find_device(np);
> > -                     if (res || !dev->phy_dev)
> > +                     ndev->phydev =3D of_phy_find_device(np);
> > +                     if (res || !ndev->phydev)
> >                               return res ? res : -EINVAL;
> >                       emac_adjust_link(dev->ndev);
> > -                     put_device(&dev->phy_dev->mdio.dev);
> > +                     put_device(&ndev->phydev->mdio.dev);
> >               }
> >               return 0;
> >       }
> > @@ -3254,9 +3252,6 @@ static void emac_remove(struct platform_device *o=
fdev)
> >       if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
> >               zmii_detach(dev->zmii_dev, dev->zmii_port);
> >
> > -     if (dev->phy_dev)
> > -             phy_disconnect(dev->phy_dev);
> > -
>
> Hi,
>
> I guess that this call was to balance the of_phy_connect() from
> emac_dt_phy_connect().
>
> Is it ok to just remove this phy_disconnect()?
I would think free or unregister_netdev handles it given that phydev
is a member of netdev.

On a separate note, A lot of drivers seem to do this in open/close as
opposed to probe/remove.
>
> CJ
>
> >       busy_phy_map &=3D ~(1 << dev->phy.address);
> >       DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/etherne=
t/ibm/emac/core.h
> > index f4bd4cd8ac4a..b820a4f6e8c7 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.h
> > +++ b/drivers/net/ethernet/ibm/emac/core.h
> > @@ -188,9 +188,6 @@ struct emac_instance {
> >       struct emac_instance            *mdio_instance;
> >       struct mutex                    mdio_lock;
> >
> > -     /* Device-tree based phy configuration */
> > -     struct phy_device               *phy_dev;
> > -
> >       /* ZMII infos if any */
> >       u32                             zmii_ph;
> >       u32                             zmii_port;
>

