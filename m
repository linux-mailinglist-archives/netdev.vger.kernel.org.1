Return-Path: <netdev+bounces-59428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5758781ACDC
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A271C21E2E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798353D90;
	Thu, 21 Dec 2023 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX15ruLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60DC2C6
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc8fd5d54bso3135491fa.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703127807; x=1703732607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSH+dWnwRQRSyrv+z08rP6q/v8buav6D6ta/+Yi4ZqM=;
        b=jX15ruLl2fAEMToxQ08en2ZQYtNfxqDnrLpw1pBhfoW5vO39lCldL15xGTzwYxQ/f9
         9h1Y8+HhbU5YlL3ySIxXIj20O2NcVpzKsY6TSSSGqM7DEJDdE4azbjdREe0Pc7/uzt3i
         EPTzmr8mfeg4CiD1y1Vey3ABoH7Z7JsLEHHOAAkpOUgtnDfQ9TpuHPpVks26N0i92kBm
         qK58BxpsILUBvzVgugRBfxoTYmTk3WNk5Ar+FwVWldqlXE7f50jC/735ewGhmAZTDpdf
         oeZwUj6TPAT5/23+k8yzPxNU9QC8jdc18ElRuAbvbnBQbP/V3NPJcY2nX++mvl/eQUJA
         tkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703127807; x=1703732607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSH+dWnwRQRSyrv+z08rP6q/v8buav6D6ta/+Yi4ZqM=;
        b=Ork2uDEvYPGI0U8aMCqU5BwwsPUa6uj4gYsePNszTlI8RCDiyM620OgyQs21Zq235i
         W63gsXZ0oHYi1lNN1PI4/1I9xPZLoPNTHvdcuf85AMi2omsoMA9xUkrgvvQnYQrK7fvA
         G/UJfj8cHsn+mE8NXnUe1LmUMyeGpu4bdFP7El/MhYL/emYLNsPRmGnPhoGdlDarExm/
         Hq+kvPEhKVCB+RjeIKiKfTP+T/Mgr8p+N738JIseU6Tju2D+9/BOMTpiRbDC2tLg4Qza
         Fn0zP7zTQ9ajZlVYNxb3rxLYvbCsfahkZ9CIFsRUTsCbiqCbGlh+EaFCJboWWB56k47o
         BmUw==
X-Gm-Message-State: AOJu0YyyUZEacHEVA6UdbYNozTihtIDGm4j/Zqnn6Gm5Ad3OI2bLaWp/
	eoYW8wOD7Fl0j7h1HXgYWFXV+GWnt0tPdKNhSv+q1/hg1OhLXmV2
X-Google-Smtp-Source: AGHT+IEyM6TSmBdQ004u6o6bZfgIPFX0iqfKOqFXCJ3MmCxzN/98Zncf5iuH93VTxzoK5oW6rL4n65yhypHVRUhjDq0=
X-Received: by 2002:a2e:a451:0:b0:2cc:9ec8:fc60 with SMTP id
 v17-20020a2ea451000000b002cc9ec8fc60mr102516ljn.9.1703127806311; Wed, 20 Dec
 2023 19:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-6-luizluca@gmail.com>
 <qlhx4kncwoeaj6wboddsxiu53sjlzwgvecvfknbopdnfd26xgq@4x3s6ta7ct2e>
In-Reply-To: <qlhx4kncwoeaj6wboddsxiu53sjlzwgvecvfknbopdnfd26xgq@4x3s6ta7ct2e>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Dec 2023 00:03:14 -0300
Message-ID: <CAJq09z5Ec-kpwYGAa6ing+d+e=WLAJ=RGAN=o1_Dp7gcqz25ww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Wed, Dec 20, 2023 at 01:24:28AM -0300, Luiz Angelo Daros de Luca wrote:
> > In the user MDIO driver, despite numerous references to SMI, including
> > its compatible string, there's nothing inherently specific about the SMI
> > interface in the user MDIO bus. Consequently, the code has been migrated
> > to the common module. All references to SMI have been eliminated, with
> > the exception of the compatible string, which will continue to function
> > as before.
> >
> > The realtek-mdio will now use this driver instead of the generic DSA
> > driver ("dsa user smi"), which should not be used with OF[1].
> >
> > There was a change in how the driver looks for the MDIO node in the
> > device tree. Now, it first checks for a child node named "mdio," which
> > is required by both interfaces in binding docs but used previously only
> > by realtek-mdio. If the node is not found, it will also look for a
> > compatible string, required only by SMI-connected devices in binding
> > docs and compatible with the old realtek-smi behavior.
> >
> > The line assigning dev.of_node in mdio_bus has been removed since the
> > subsequent of_mdiobus_register will always overwrite it.
> >
> > ds->user_mii_bus is only defined if all user ports do not declare a
> > phy-handle, providing a warning about the erroneous device tree[2].
> >
> > With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
> > no longer necessary. Now, the realtek_variant.ds_ops can be used
> > directly.
> >
> > The realtek_priv.setup_interface() has been removed as we can directly
> > call the new common function.
> >
> > The switch unregistration and the MDIO node decrement in refcount were
> > moved into realtek_common_remove() as both interfaces now need to put
> > the MDIO node.
> >
> > [1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/
> > [2] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/realtek-common.c | 87 +++++++++++++++++++++++-
> >  drivers/net/dsa/realtek/realtek-common.h |  1 +
> >  drivers/net/dsa/realtek/realtek-mdio.c   |  6 --
> >  drivers/net/dsa/realtek/realtek-smi.c    | 68 ------------------
> >  drivers/net/dsa/realtek/realtek.h        |  5 +-
> >  drivers/net/dsa/realtek/rtl8365mb.c      | 49 ++-----------
> >  drivers/net/dsa/realtek/rtl8366rb.c      | 52 ++------------
> >  7 files changed, 100 insertions(+), 168 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> > index bf3933a99072..b1f0095d5bce 100644
> > --- a/drivers/net/dsa/realtek/realtek-common.c
> > +++ b/drivers/net/dsa/realtek/realtek-common.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> >  #include <linux/module.h>
> > +#include <linux/of_mdio.h>
> >
> >  #include "realtek.h"
> >  #include "realtek-common.h"
> > @@ -21,6 +22,85 @@ void realtek_common_unlock(void *ctx)
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_common_unlock);
> >
> > +static int realtek_common_user_mdio_read(struct mii_bus *bus, int addr,
> > +                                      int regnum)
> > +{
> > +     struct realtek_priv *priv = bus->priv;
> > +
> > +     return priv->ops->phy_read(priv, addr, regnum);
> > +}
> > +
> > +static int realtek_common_user_mdio_write(struct mii_bus *bus, int addr,
> > +                                       int regnum, u16 val)
> > +{
> > +     struct realtek_priv *priv = bus->priv;
> > +
> > +     return priv->ops->phy_write(priv, addr, regnum, val);
> > +}
> > +
> > +int realtek_common_setup_user_mdio(struct dsa_switch *ds)
> > +{
> > +     const char *compatible = "realtek,smi-mdio";
>
> No need to put this in its own variable, it makes the code harder to read.

OK. Without a warning message that would use it again, it is better to
simply use the literal.

> > +     struct realtek_priv *priv =  ds->priv;
> > +     struct device_node *phy_node;
> > +     struct device_node *mdio_np;
> > +     struct dsa_port *dp;
> > +     int ret;
> > +
> > +     mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> > +     if (!mdio_np) {
> > +             mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
> > +             if (!mdio_np) {
> > +                     dev_err(priv->dev, "no MDIO bus node\n");
> > +                     return -ENODEV;
> > +             }
> > +     }
> > +
> > +     priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> > +     if (!priv->user_mii_bus) {
> > +             ret = -ENOMEM;
> > +             goto err_put_node;
> > +     }
> > +     priv->user_mii_bus->priv = priv;
> > +     priv->user_mii_bus->name = "Realtek user MII";
> > +     priv->user_mii_bus->read = realtek_common_user_mdio_read;
> > +     priv->user_mii_bus->write = realtek_common_user_mdio_write;
> > +     snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> > +              ds->index);
> > +     priv->user_mii_bus->parent = priv->dev;
> > +
> > +     /* When OF describes the MDIO, connecting ports with phy-handle,
> > +      * ds->user_mii_bus should not be used *
>
> Stray *, put a full stop.

OK

>
> > +      */
> > +     dsa_switch_for_each_user_port(dp, ds) {
> > +             phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> > +             of_node_put(phy_node);
> > +             if (phy_node)
> > +                     continue;
> > +
> > +             dev_warn(priv->dev,
> > +                      "DS user_mii_bus in use as '%s' is missing phy-handle",
> > +                      dp->name);
>
> "DS user_mii_bus in use" is a very cryptic warning, can you not just
> warn about a missing phy-handle, since that is what is expected?

I was struggling to fit an informative message in the 80 cols limit.
However, kernel messages are not the place for whys, just whats.
I'll change to:

                dev_warn(priv->dev, "'%s' should have a phy-handle",
                        dp->name);

> > +             ds->user_mii_bus = priv->user_mii_bus;
> > +             break;
> > +     }
> > +
> > +     ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
>
> You use devres here, but this means the mdiobus will outlive the switch
> after dsa_switch_teardown(). I don't really know if this can cause any
> unwanted runtime behaviour, but the code feels unbalanced.

devm_* functions prepare objects to be destroyed/unregistered/removed
when a parent device is gone. So, if you use devm_* anywhere but in
the probe function, it might look like it is unbalanced because the
unwinding process happens automatically, outside the driver control.
So, technically, it will always be at least a little bit unbalanced.
However, the guarantee it will be cleaned and in the correct order is
worth it.

Vladimir suggested that new drivers should split the MDIO bus driver
from the DSA driver. I believe it is expected that mdiobus will
outlive the switch and it could also be registered before the switch
is registered or even allocated. We just need it to be registered
before ports are ready (dsa_tree_setup_ports?). The switch setup is
just the last opportunity we have to register an MDIO bus. Would it be
better if we move the realtek_common_setup_user_mdio call from
variants to just before the switch is registered in
realtek_common_register_switch? I didn't test it but it should work.

> > +     if (ret) {
> > +             dev_err(priv->dev, "unable to register MDIO bus %s\n",
> > +                     priv->user_mii_bus->id);
> > +             goto err_put_node;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_put_node:
> > +     of_node_put(mdio_np);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_setup_user_mdio);
> > +
> >  /* sets up driver private data struct, sets up regmaps, parse common device-tree
> >   * properties and finally issues a hardware reset.
> >   */
> > @@ -108,7 +188,7 @@ int realtek_common_register_switch(struct realtek_priv *priv)
> >
> >       priv->ds->priv = priv;
> >       priv->ds->dev = priv->dev;
> > -     priv->ds->ops = priv->ds_ops;
> > +     priv->ds->ops = priv->variant->ds_ops;
> >       priv->ds->num_ports = priv->num_ports;
> >
> >       ret = dsa_register_switch(priv->ds);
> > @@ -126,6 +206,11 @@ void realtek_common_remove(struct realtek_priv *priv)
> >       if (!priv)
> >               return;
> >
> > +     dsa_unregister_switch(priv->ds);
>
> Wait, wasn't this supposed to belong in the previous patch that added
> realtek_common_remove? Why is it being put here in this patch?

It wasn't. The of_node_put, before this patch, is only used by
realtek-smi. So, for realtek-smi, I need to add the put between the
dsa_unregister_switch() and the realtek_common_remove(), when we lose
the mdiobus reference. I thought it wasn't worth it to create a
realtek_common_unregister() that simply calls dsa_unregister_switch().
That's why I left the dsa_unregister_switch (both) and the of_node_put
(realtek-smi) on each interface code. With this commit, realtek-mdio
will also need to put the node, so it makes sense to move the common
code to the realtek_common_remove().

If we could put the node just after the registration (another patch I
sent to OF MDIO API), we wouldn't even need to think about the mdio
bus during removal. It would just go in peace.

> Regarding the series as a whole, I still think all you really need is
> something like this:
>
>   - realtek_common_probe
>   - realtek_common_remove (if there is actually anything to do?)
>   - realtek_common_setup_user_mdio
>   - realtek_common_teardown_user_mdio
>
> The chip variant drivers can then do:
>
>   /* Interface-agnostic chip driver code */
>
>   rtl836xxx_setup() {
>     // ...
>     realtek_common_setup_user_mdio();
>     // ...
>   }
>
>   rtl836xxx_teardown() {
>     // ...
>     realtek_common_teardown_user_mdio();
>     // ...
>   }
>
>   rtl836xxx_probe() {
>     // assert
>     // enable regulators
>     // deassert reset
>     // do what was in detect() before
>     dsa_register_switch(priv->ds);
>   }
>
>   rtl836xxx_remove() {
>     dsa_unregister_switch();
>     // assert reset again
>   }
>
>   /* SMI boilerplate */
>
>   rtl836xxx_smi_probe() {
>     priv = realtek_smi_probe();
>     return rtl836xxx_probe(priv);
>   }
>
>   rtl836xxx_smi_remove() {
>     rtl836xxx_remove();
>     realtek_smi_remove(); // if needed
>   }
>
>   /* MDIO boilerplate */
>
>   rtl836xxx_mdio_probe() {
>     priv = realtek_mdio_probe();
>     return rtl836xxx_probe(priv);
>   }
>
>   rtl836xxx_mdio_remove() {
>     rtl836xxx_remove();
>     realtek_mdio_remove(); // if needed
>   }
>
> And your interface probe functions:
>
>   realtek_smi_probe() {
>     priv = realtek_common_probe();
>     // SMI specific setup
>     return priv;
>   }
>
>   realtek_mdio_probe() {
>     priv = realtek_common_probe();
>     // MDIO specific setup
>     return priv;
>   }
>
> Am I missing something? I'm open to other suggestions but I can't help
> but feel that the current proposal is half-baked.

Until we have some specific code for probe/remove that is both
interface and variant specific, it just creates some new functions
that have the same code. Up to this point, the detect is responsible
for the variant-specific logic. We could rename it to match a broader
role, like resetting the device before detecting it. However, it will
introduce another unbalance as the "detect" will reset the switch but,
without an "undetect-like" function, the common remove will leave it
asserted. I'm OK with that as resetting and leaving the device reset
asserted, although using the same tools, have different objectives.
But we can discuss that in the 3/7 patch.

While we use devm, there is not much need for tearing down the MDIO
(except, for now, putting the node). I don't think we should put the
node during switch teardown. At this point, all user ports are down
and the mdiobus might not be reachable but, maybe, something might
still interact with the mdio bus (sysfs? a queued syscall?).

Even during driver removal, mdiobus will still be registered and
allocated and it is still odd for me to put a node still referenced in
a registered mdio bus device. At least, it is the closest point we
have before mdiobus_unregister. The correct place to put it would be
between mdiobus_unregister and mdiobus_free, both called by devm on
device destruction and out of our control. There is no
devm_of_put_node and creating a new devm callback to put the node just
looks hacky.

All this just reinforces my belief that of_mdiobus_register should get
the node (and mdio_unregister put it), especially with devm where the
unregister happens out of the driver control. I just don't know if I
did that right.

> As a side note: I also think this will make it a bit easier to reason
> about the ownership of variables in struct realtek_priv. Ultimately its
> contents ought all to belong to the code which ends up in the
> realtek-dsa IMO. With a little effort, the rest can be moved into the
> variant-specific private data structs. And cases like
> realtek_priv::num_ports can be removed completely. But that cleanup is
> for another time.

Please, keep it for another time. I wish I don't end up reimplementing
all the driver just to add a reset control. The driver might need more
love than I'm giving but it would be easier after this series gets in.

> > +
> > +     if (priv->user_mii_bus)
> > +             of_node_put(priv->user_mii_bus->dev.of_node);
>
> I think you should undo your work in the corresponding undo
> function. You set up priv->user_mii_bus in ds_ops::setup, so you should
> undo any such stuff in ds_ops::teardown as well.

As I said, priv->user_mii_bus could (or should?) be set outside dsa
setup and priv->user_mii_bus->dev.of_node should actually be put
between mdiobus_unregister and mdiobus_free, that all called by devm
and out of our control. Here is just the closest we have before devm
does its job.

>
> > +
> >       /* leave the device reset asserted */
> >       if (priv->reset)
> >               gpiod_set_value(priv->reset, 1);
> > diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
> > index 518d091ff496..b1c2a50d85cd 100644
> > --- a/drivers/net/dsa/realtek/realtek-common.h
> > +++ b/drivers/net/dsa/realtek/realtek-common.h
> > @@ -7,6 +7,7 @@
> >
> >  void realtek_common_lock(void *ctx);
> >  void realtek_common_unlock(void *ctx);
> > +int realtek_common_setup_user_mdio(struct dsa_switch *ds);
> >  struct realtek_priv *
> >  realtek_common_probe(struct device *dev, struct regmap_config rc,
> >                    struct regmap_config rc_nolock);
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 967f6c1e8df0..e2b5432eeb26 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -142,7 +142,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
> >       priv->bus = mdiodev->bus;
> >       priv->mdio_addr = mdiodev->addr;
> >       priv->write_reg_noack = realtek_mdio_write;
> > -     priv->ds_ops = priv->variant->ds_ops_mdio;
> >
> >       ret = realtek_common_register_switch(priv);
> >       if (ret)
> > @@ -156,11 +155,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
> >
> > -     if (!priv)
> > -             return;
> > -
> > -     dsa_unregister_switch(priv->ds);
> > -
> >       realtek_common_remove(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_mdio_remove);
> > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > index 2b2c6e34bae5..383689163057 100644
> > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > @@ -31,7 +31,6 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/of.h>
> > -#include <linux/of_mdio.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/platform_device.h>
> > @@ -339,63 +338,6 @@ static const struct regmap_config realtek_smi_nolock_regmap_config = {
> >       .disable_locking = true,
> >  };
> >
> > -static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
> > -{
> > -     struct realtek_priv *priv = bus->priv;
> > -
> > -     return priv->ops->phy_read(priv, addr, regnum);
> > -}
> > -
> > -static int realtek_smi_mdio_write(struct mii_bus *bus, int addr, int regnum,
> > -                               u16 val)
> > -{
> > -     struct realtek_priv *priv = bus->priv;
> > -
> > -     return priv->ops->phy_write(priv, addr, regnum, val);
> > -}
> > -
> > -static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> > -{
> > -     struct realtek_priv *priv =  ds->priv;
> > -     struct device_node *mdio_np;
> > -     int ret;
> > -
> > -     mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
> > -     if (!mdio_np) {
> > -             dev_err(priv->dev, "no MDIO bus node\n");
> > -             return -ENODEV;
> > -     }
> > -
> > -     priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> > -     if (!priv->user_mii_bus) {
> > -             ret = -ENOMEM;
> > -             goto err_put_node;
> > -     }
> > -     priv->user_mii_bus->priv = priv;
> > -     priv->user_mii_bus->name = "SMI user MII";
> > -     priv->user_mii_bus->read = realtek_smi_mdio_read;
> > -     priv->user_mii_bus->write = realtek_smi_mdio_write;
> > -     snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
> > -              ds->index);
> > -     priv->user_mii_bus->dev.of_node = mdio_np;
> > -     priv->user_mii_bus->parent = priv->dev;
> > -     ds->user_mii_bus = priv->user_mii_bus;
> > -
> > -     ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> > -     if (ret) {
> > -             dev_err(priv->dev, "unable to register MDIO bus %s\n",
> > -                     priv->user_mii_bus->id);
> > -             goto err_put_node;
> > -     }
> > -
> > -     return 0;
> > -
> > -err_put_node:
> > -     of_node_put(mdio_np);
> > -
> > -     return ret;
> > -}
> > -
> >  int realtek_smi_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev = &pdev->dev;
> > @@ -417,8 +359,6 @@ int realtek_smi_probe(struct platform_device *pdev)
> >               return PTR_ERR(priv->mdio);
> >
> >       priv->write_reg_noack = realtek_smi_write_reg_noack;
> > -     priv->setup_interface = realtek_smi_setup_mdio;
> > -     priv->ds_ops = priv->variant->ds_ops_smi;
> >
> >       ret = realtek_common_register_switch(priv);
> >       if (ret)
> > @@ -432,14 +372,6 @@ void realtek_smi_remove(struct platform_device *pdev)
> >  {
> >       struct realtek_priv *priv = platform_get_drvdata(pdev);
> >
> > -     if (!priv)
> > -             return;
> > -
> > -     dsa_unregister_switch(priv->ds);
> > -
> > -     if (priv->user_mii_bus)
> > -             of_node_put(priv->user_mii_bus->dev.of_node);
> > -
> >       realtek_common_remove(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(realtek_smi_remove);
> > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > index fbd0616c1df3..7af6dcc1bb24 100644
> > --- a/drivers/net/dsa/realtek/realtek.h
> > +++ b/drivers/net/dsa/realtek/realtek.h
> > @@ -60,7 +60,6 @@ struct realtek_priv {
> >
> >       spinlock_t              lock; /* Locks around command writes */
> >       struct dsa_switch       *ds;
> > -     const struct dsa_switch_ops *ds_ops;
> >       struct irq_domain       *irqdomain;
> >       bool                    leds_disabled;
> >
> > @@ -71,7 +70,6 @@ struct realtek_priv {
> >       struct rtl8366_mib_counter *mib_counters;
> >
> >       const struct realtek_ops *ops;
> > -     int                     (*setup_interface)(struct dsa_switch *ds);
> >       int                     (*write_reg_noack)(void *ctx, u32 addr, u32 data);
> >
> >       int                     vlan_enabled;
> > @@ -115,8 +113,7 @@ struct realtek_ops {
> >  };
> >
> >  struct realtek_variant {
> > -     const struct dsa_switch_ops *ds_ops_smi;
> > -     const struct dsa_switch_ops *ds_ops_mdio;
> > +     const struct dsa_switch_ops *ds_ops;
> >       const struct realtek_ops *ops;
> >       unsigned int clk_delay;
> >       u8 cmd_read;
> > diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> > index 58ec057b6c32..e890ad113ba3 100644
> > --- a/drivers/net/dsa/realtek/rtl8365mb.c
> > +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> > @@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
> >       return 0;
> >  }
> >
> > -static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
> > -{
> > -     return rtl8365mb_phy_read(ds->priv, phy, regnum);
> > -}
> > -
> > -static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
> > -                                u16 val)
> > -{
> > -     return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
> > -}
> > -
> >  static const struct rtl8365mb_extint *
> >  rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
> >  {
> > @@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
> >       if (ret)
> >               goto out_teardown_irq;
> >
> > -     if (priv->setup_interface) {
> > -             ret = priv->setup_interface(ds);
> > -             if (ret) {
> > -                     dev_err(priv->dev, "could not set up MDIO bus\n");
> > -                     goto out_teardown_irq;
> > -             }
> > +     ret = realtek_common_setup_user_mdio(ds);
> > +     if (ret) {
> > +             dev_err(priv->dev, "could not set up MDIO bus\n");
> > +             goto out_teardown_irq;
> >       }
> >
> >       /* Start statistics counter polling */
> > @@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
> >       return 0;
> >  }
> >
> > -static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
> > -     .get_tag_protocol = rtl8365mb_get_tag_protocol,
> > -     .change_tag_protocol = rtl8365mb_change_tag_protocol,
> > -     .setup = rtl8365mb_setup,
> > -     .teardown = rtl8365mb_teardown,
> > -     .phylink_get_caps = rtl8365mb_phylink_get_caps,
> > -     .phylink_mac_config = rtl8365mb_phylink_mac_config,
> > -     .phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
> > -     .phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
> > -     .port_stp_state_set = rtl8365mb_port_stp_state_set,
> > -     .get_strings = rtl8365mb_get_strings,
> > -     .get_ethtool_stats = rtl8365mb_get_ethtool_stats,
> > -     .get_sset_count = rtl8365mb_get_sset_count,
> > -     .get_eth_phy_stats = rtl8365mb_get_phy_stats,
> > -     .get_eth_mac_stats = rtl8365mb_get_mac_stats,
> > -     .get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
> > -     .get_stats64 = rtl8365mb_get_stats64,
> > -     .port_change_mtu = rtl8365mb_port_change_mtu,
> > -     .port_max_mtu = rtl8365mb_port_max_mtu,
> > -};
> > -
> > -static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
> > +static const struct dsa_switch_ops rtl8365mb_switch_ops = {
> >       .get_tag_protocol = rtl8365mb_get_tag_protocol,
> >       .change_tag_protocol = rtl8365mb_change_tag_protocol,
> >       .setup = rtl8365mb_setup,
> > @@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
> >       .phylink_mac_config = rtl8365mb_phylink_mac_config,
> >       .phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
> >       .phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
> > -     .phy_read = rtl8365mb_dsa_phy_read,
> > -     .phy_write = rtl8365mb_dsa_phy_write,
> >       .port_stp_state_set = rtl8365mb_port_stp_state_set,
> >       .get_strings = rtl8365mb_get_strings,
> >       .get_ethtool_stats = rtl8365mb_get_ethtool_stats,
> > @@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
> >  };
> >
> >  const struct realtek_variant rtl8365mb_variant = {
> > -     .ds_ops_smi = &rtl8365mb_switch_ops_smi,
> > -     .ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
> > +     .ds_ops = &rtl8365mb_switch_ops,
> >       .ops = &rtl8365mb_ops,
> >       .clk_delay = 10,
> >       .cmd_read = 0xb9,
> > diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> > index e60a0a81d426..56619aa592ec 100644
> > --- a/drivers/net/dsa/realtek/rtl8366rb.c
> > +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> > @@ -1027,12 +1027,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
> >       if (ret)
> >               dev_info(priv->dev, "no interrupt support\n");
> >
> > -     if (priv->setup_interface) {
> > -             ret = priv->setup_interface(ds);
> > -             if (ret) {
> > -                     dev_err(priv->dev, "could not set up MDIO bus\n");
> > -                     return -ENODEV;
> > -             }
> > +     ret = realtek_common_setup_user_mdio(ds);
> > +     if (ret) {
> > +             dev_err(priv->dev, "could not set up MDIO bus\n");
> > +             return -ENODEV;
> >       }
> >
> >       return 0;
> > @@ -1772,17 +1770,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
> >       return ret;
> >  }
> >
> > -static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
> > -{
> > -     return rtl8366rb_phy_read(ds->priv, phy, regnum);
> > -}
> > -
> > -static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
> > -                                u16 val)
> > -{
> > -     return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
> > -}
> > -
> >  static int rtl8366rb_reset_chip(struct realtek_priv *priv)
> >  {
> >       int timeout = 10;
> > @@ -1848,35 +1835,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
> >       return 0;
> >  }
> >
> > -static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
> > -     .get_tag_protocol = rtl8366_get_tag_protocol,
> > -     .setup = rtl8366rb_setup,
> > -     .phylink_get_caps = rtl8366rb_phylink_get_caps,
> > -     .phylink_mac_link_up = rtl8366rb_mac_link_up,
> > -     .phylink_mac_link_down = rtl8366rb_mac_link_down,
> > -     .get_strings = rtl8366_get_strings,
> > -     .get_ethtool_stats = rtl8366_get_ethtool_stats,
> > -     .get_sset_count = rtl8366_get_sset_count,
> > -     .port_bridge_join = rtl8366rb_port_bridge_join,
> > -     .port_bridge_leave = rtl8366rb_port_bridge_leave,
> > -     .port_vlan_filtering = rtl8366rb_vlan_filtering,
> > -     .port_vlan_add = rtl8366_vlan_add,
> > -     .port_vlan_del = rtl8366_vlan_del,
> > -     .port_enable = rtl8366rb_port_enable,
> > -     .port_disable = rtl8366rb_port_disable,
> > -     .port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
> > -     .port_bridge_flags = rtl8366rb_port_bridge_flags,
> > -     .port_stp_state_set = rtl8366rb_port_stp_state_set,
> > -     .port_fast_age = rtl8366rb_port_fast_age,
> > -     .port_change_mtu = rtl8366rb_change_mtu,
> > -     .port_max_mtu = rtl8366rb_max_mtu,
> > -};
> > -
> > -static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
> > +static const struct dsa_switch_ops rtl8366rb_switch_ops = {
> >       .get_tag_protocol = rtl8366_get_tag_protocol,
> >       .setup = rtl8366rb_setup,
> > -     .phy_read = rtl8366rb_dsa_phy_read,
> > -     .phy_write = rtl8366rb_dsa_phy_write,
> >       .phylink_get_caps = rtl8366rb_phylink_get_caps,
> >       .phylink_mac_link_up = rtl8366rb_mac_link_up,
> >       .phylink_mac_link_down = rtl8366rb_mac_link_down,
> > @@ -1915,8 +1876,7 @@ static const struct realtek_ops rtl8366rb_ops = {
> >  };
> >
> >  const struct realtek_variant rtl8366rb_variant = {
> > -     .ds_ops_smi = &rtl8366rb_switch_ops_smi,
> > -     .ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
> > +     .ds_ops = &rtl8366rb_switch_ops,
> >       .ops = &rtl8366rb_ops,
> >       .clk_delay = 10,
> >       .cmd_read = 0xa9,
> > --
> > 2.43.0
> >

