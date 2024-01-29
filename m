Return-Path: <netdev+bounces-66559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE283FC5F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB212815F5
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA9DF58;
	Mon, 29 Jan 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU6dl3h/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBEF9DB
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496598; cv=none; b=fp/LlCVasjx5im5CoQgvc3rBwqbCjxXE91Kh7FCni7ntArwkmlTuRFk6Kk+SX+yfAiUOzs3SVQ6ypbKmGWTY6oSjH90mW3jJ2IZ1F4D3LzUL/Esas/PpeSxkXb4Y437GuAPc3G9Oap7cZKYgGjVRUW1RCu9QqZiyT7WVfbr79ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496598; c=relaxed/simple;
	bh=aCF7KnsqldFBfG460POHGuaGiEXNxuU3v2AXGIxEo0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCaY85Vs0tHjbKx6GSvmU4ynhhW/2ykMcgh/l+IRXSJMSSL5ss99TT8mLcimKtyrgZZKiziVvYdMEhY116lAEq6XQtY8hIchU6qOqg6COf/6jqIIcCTVdWlhLeil00iU2JJk04ElIyQZ68v/LyEbdi+abTu2KElW67sa3Y8Usm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU6dl3h/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf33035d1dso23902511fa.2
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 18:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706496594; x=1707101394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A5JnPMh8vL8/CHG3+l69kHziVs+C39ypmERxaZD79jk=;
        b=TU6dl3h/KZYBd6AYevOVeIzcClLGjyj+DJIO3SyH6ksWVe+DNtG8xac8ZQMIrCQHHM
         /7MfdgBXLExU5ULHHwe6IAUteyed42P5rooo63PS6vyH2vVEZX9V/xqobYDZBtPiLQVR
         /CWw95teoJ2QQlAtFzbut2erbfEvixMAK8H9FMRWCKKR+WtbZqeCmdMGyTrqhSUUysEq
         nM4yARzd7jKHDbNPd0xg5kISx1Ngu0UPcPuBP26B1jBSB34l6SqNbCaqBm4nH2fdoc+R
         r8EFxuS+MUJmT9xBS1g+kVeI5AkKxBGl5RgaSaPdnidmYXVsnRvL2G5Bs57wmGoGk7g1
         gLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706496594; x=1707101394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5JnPMh8vL8/CHG3+l69kHziVs+C39ypmERxaZD79jk=;
        b=NN7Iw+86RXiycHNFQSHWDQH4CNVE6SgT+PXpdm3Rgb49g7VvWYjIz839zkqpIJzYTx
         98oifTOc4U9PinbPZi1/iD348AyZdKjoV8eEVXRVQ+MkSb2nvtU2Gl2RP2C0q9V0n3Ue
         klhfzABHUChx9u0mFjGSfjmS9xKadDwFvdsUiIojURGuHL63x1RqAYV4nipt6ObjcSdr
         ylqsKa1BhLxEKVtmdDWDVyjjinuXAULnUgwbO9ilq9sffcvERbSWjvf9X4ch142zaQPQ
         iEfYF/c71eGCkyDQFwhmYafTNsyCU684b0lw0phL7XchyYezZovmwdVgXwlaZRvbgqCm
         QwpQ==
X-Gm-Message-State: AOJu0YwJgumVdTloJ4SyWUfj2Cd02RicVy33aEAIHS+wYbtaDbhHe3P/
	w7SDVmhyJcIuJnKEwO8yLeSk+iLO5N0FXXiBKOlmKgA6PxJHuKLFn1l3f5kr/J+5p5t6pjVOXBu
	6dgMjmtUsHXi1KK5eX0BHkoTc8A0=
X-Google-Smtp-Source: AGHT+IG9cjciPA65SFKWUsnuUyuB9ZevnyuIu0zp8c08RGeM8eVbl2exbTqI7XukDfzebyym7QVvh2balBCUhpZiZ48=
X-Received: by 2002:a05:6512:3b0e:b0:50e:b23c:e37 with SMTP id
 f14-20020a0565123b0e00b0050eb23c0e37mr3512675lfv.48.1706496593954; Sun, 28
 Jan 2024 18:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-10-luizluca@gmail.com>
 <20240125160511.pskpwroyrdmooxrg@skbuf>
In-Reply-To: <20240125160511.pskpwroyrdmooxrg@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 28 Jan 2024 23:49:42 -0300
Message-ID: <CAJq09z5KJE1D=gCd5WX_B26FxYN_eGn7LwENwNQZ0BSe7aDwOA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 09/11] net: dsa: realtek: migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jan 23, 2024 at 06:56:01PM -0300, Luiz Angelo Daros de Luca wrote:
> > In the user MDIO driver, despite numerous references to SMI, including
> > its compatible string, there's nothing inherently specific about the SMI
> > interface in the user MDIO bus. Consequently, the code has been migrated
> > to the rtl83xx module. All references to SMI have been eliminated.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> > diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> > index 53bacbacc82e..525d8c014136 100644
> > --- a/drivers/net/dsa/realtek/rtl83xx.c
> > +++ b/drivers/net/dsa/realtek/rtl83xx.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> >  #include <linux/module.h>
> > +#include <linux/of_mdio.h>
> >
> >  #include "realtek.h"
> >  #include "rtl83xx.h"
> > @@ -42,6 +43,72 @@ void rtl83xx_unlock(void *ctx)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
> >
> > +static int rtl83xx_user_mdio_read(struct mii_bus *bus, int addr, int regnum)
> > +{
> > +     struct realtek_priv *priv = bus->priv;
> > +
> > +     return priv->ops->phy_read(priv, addr, regnum);
> > +}
> > +
> > +static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
> > +                                u16 val)
> > +{
> > +     struct realtek_priv *priv = bus->priv;
> > +
> > +     return priv->ops->phy_write(priv, addr, regnum, val);
> > +}
>
> Do we actually need to go through this extra indirection, or can the
> priv->ops->phy_read/write() prototypes be made to take just struct
> mii_bus * as their first argument?

We would just postpone the same code in phy_write/read. We only need priv there.

Using mii_bus will also prevent an easy way for the driver to query
those registers (although not used anymore after ds_switch_ops
.phy_read/write are gone)

>
> > +
> > +/**
> > + * rtl83xx_setup_user_mdio() - register the user mii bus driver
> > + * @ds: DSA switch associated with this user_mii_bus
> > + *
> > + * This function first gets and mdio node under the dev OF node, aborting
> > + * if missing. That mdio node describing an mdio bus is used to register a
> > + * new mdio bus.
> > + *
> > + * Context: Any context.
> > + * Return: 0 on success, negative value for failure.
> > + */
> > +int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
> > +{
> > +     struct realtek_priv *priv =  ds->priv;
>
> Please remove the extra space here in " =  ds->priv".

OK

>
> > +     struct device_node *mdio_np;
> > +     int ret = 0;
> > +
> > +     mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> > +     if (!mdio_np) {
> > +             dev_err(priv->dev, "no MDIO bus node\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> > +     if (!priv->user_mii_bus) {
> > +             ret = -ENOMEM;
> > +             goto err_put_node;
> > +     }
> > +
> > +     priv->user_mii_bus->priv = priv;
> > +     priv->user_mii_bus->name = "Realtek user MII";
> > +     priv->user_mii_bus->read = rtl83xx_user_mdio_read;
> > +     priv->user_mii_bus->write = rtl83xx_user_mdio_write;
> > +     snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> > +              ds->index);
>
> There isn't much consistency here, but maybe something derived from
> dev_name(dev) or %pOF would make it clearer that it describes a switch's
> internal MDIO bus, rather than just any Realtek thing?

Yes, Realtek-0:<port> is not very informative.

Using only dev_name will give me these device names:

mdio-bus:1d <- switch1 in the conduit mdio bus at address 29 (0x1d)
(not the user mdio bus)
mdio-bus:1d:00 <- port 0 in switch1
mdio-bus:1d:01 <- port 1 in switch1
...

It is quite compact and easy to identify which device is under which.
But, in this case, mdio-bus:1d would be both the switch device name in
the conduit bus and the name of the switch internal mdio bus.

devices/platform/10100000.ethernet/mdio_bus/mdio-bus/mdio-bus:1d/mdio_bus/mdio-bus:1d/mdio-bus:1d:00
devices/platform/10100000.ethernet/mdio_bus/mdio-bus/mdio-bus:1d/mdio_bus/mdio-bus:1d/mdio-bus:1d:01

For SMI-connected switches, it changes a little bit but the essence is the same:

devices/platform/switch/mdio_bus/switch/switch:00
devices/platform/switch/mdio_bus/switch/switch:01

I guess the best approach is to append something that identifies the
other mdio bus, for example ":user_mii". The result is something like
this:

mdio-bus:1d
mdio-bus:1d:user_mii:00
mdio-bus:1d:user_mii:01
...

Or, for SMI:

switch:user_mii:00
switch:user_mii:01
...

It is good enough for me as these switches have only one MDIO bus.

We could also bring up some kind of a general suggestion for naming
user_mii buses. In that case, we should be prepared for multiple mdio
buses and the mdio node name+@unit (%pOFP) might be appropriate. We
would get something like this:

mdio-bus:1d:mdio:00
mdio-bus:1d:mdio:01

Or, for SMI:

switch:mdio:00
switch:mdio:01

If there are multiple MDIO buses, it will be mdio@N (not tested).

mdio-bus:1d:mdio@0:00
mdio-bus:1d:mdio@0:01
...
mdio-bus:1d:mdio@1:00
mdio-bus:1d:mdio@1:01
...

The device_name can also be replaced with %pOFP, which will differ
only for MDIO-connected switches:

mdio-bus:1d
switch1@29:mdio:01
switch1@29:mdio:02
...

But it will not have a clear relation with the parent MDIO bus.

I also considered %pOFf but it gives a more verbose device name
without adding too much useful information:

!ethernet@10100000!mdio-bus!switch1@29:00
!ethernet@10100000!mdio-bus!switch1@29:01
!ethernet@10100000!mdio-bus!switch1@29:02

And I'm reluctant to add those "!" as they may not play nice with some
non-ideal scripts reading sysfs. I would, at least, replace them with
":" .

> > +     priv->user_mii_bus->parent = priv->dev;
> > +
> > +     ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> > +     if (ret) {
> > +             dev_err(priv->dev, "unable to register MDIO bus %s\n",
> > +                     priv->user_mii_bus->id);
> > +             goto err_put_node;
> > +     }
>
> Maybe this function would look a bit less cluttered with a temporary
> struct mii_bus *bus variable, and priv->user_mii_bus gets assigned to
> "bus" at the end (on success), and another struct device *dev = priv->dev.

Yes, it looks much cleaner.

> Otherwise, this is in principle ok and what I wanted to see.

I'm glad to hear that. Thanks!

Regards,

Luiz

