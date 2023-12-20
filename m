Return-Path: <netdev+bounces-59149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D928197E2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC191C249BB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABCBE4E;
	Wed, 20 Dec 2023 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNHOXwoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E6C2C5
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc6b56eadaso40873941fa.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703047873; x=1703652673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oY8NRVG5rLKrrD15x2U4hm4P0XTpgUCML4KaCFrYZ2M=;
        b=JNHOXwoNStcDvxlicXVZOEHr51SqIZs4cpF15piMZBVq0mS6MdvIMMDN38jMMrzZ+l
         8AYx1Cdc7M0CJRw7xL2nqkwFZBdHfv+4JzpvkjAvYqdnpbkbd1DiYpPfggnThlgDtzMx
         qqdOgZ2MbDYCjipZGCjT/NyppVRHZSf4zbT8mP4To7Ve4PcDQDsFe+ijDo1zGQaiPLWr
         FvK4mF5/TrEr+zRyKMHsESHLn9gtAgx+cujNKPCRbPLEnbS1R6HyfWAumvmSaQtVWZem
         KLc4mxcJztjfmyCgQLqma7NlsGLM5/P0PWFe+dyuHNgFHvp8v5wy0THiFhbAHYFGm4aE
         1rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047873; x=1703652673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY8NRVG5rLKrrD15x2U4hm4P0XTpgUCML4KaCFrYZ2M=;
        b=myvBG3jc00j3K4QyAS6TB0UR0NKMn8G1HEMscWeFBck/DZPjRxXLwZHFLnOu0c+B8h
         uTzPj28pE8UGi8jmi8bzXBHK/0jrtUzGa/iFKAjnlNbg00EAMlib8kpkZGchvYl8F1iS
         VkmMLCsMFDms8n28rl6mqAri7ORjsOLhaA9pssNzVUOAF+TBYiJiz6HMZ92l1ISQZH5u
         +Jkumx+60gmp/rydaqoHmefGgiBQt7oNH654/s/UCrL28rWKA3GsHnFzqI7lye4sdXPv
         v7Mo/NH+BHUSW1HE+3JbtDLVnQOQs34PH5O7DX+zRng9I0iu5cXn+FJ6vR5WutvoxY6K
         Ynrg==
X-Gm-Message-State: AOJu0Yy0wJ+Gm8ey/pdb939Ydb/tY5J+EERnR345GjGK9CsId0JYO1Yf
	ykQZIPQOvgEOyIbMbOVWPCFhH73MAyobszdF7L0=
X-Google-Smtp-Source: AGHT+IHlM6S+H7uJTw38I5zmW/A1BFRX6ZoQy+u3xN/j2ZvBP4o0PvlQ6ig4ULKsH/3T1aafWTt4WwW3QZTa9Y//DjU=
X-Received: by 2002:a2e:9403:0:b0:2cb:27cb:3d7d with SMTP id
 i3-20020a2e9403000000b002cb27cb3d7dmr9217155ljh.84.1703047872657; Tue, 19 Dec
 2023 20:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-6-luizluca@gmail.com>
In-Reply-To: <20231220042632.26825-6-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 20 Dec 2023 01:51:01 -0300
Message-ID: <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: olteanv@gmail.com
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

Hello Vladimir,

I'm sorry to bother you again but I would like your attention for two
points that I'm not completely sure about.

> In the user MDIO driver, despite numerous references to SMI, including
> its compatible string, there's nothing inherently specific about the SMI
> interface in the user MDIO bus. Consequently, the code has been migrated
> to the common module. All references to SMI have been eliminated, with
> the exception of the compatible string, which will continue to function
> as before.
>
> The realtek-mdio will now use this driver instead of the generic DSA
> driver ("dsa user smi"), which should not be used with OF[1].
>
> There was a change in how the driver looks for the MDIO node in the
> device tree. Now, it first checks for a child node named "mdio," which
> is required by both interfaces in binding docs but used previously only
> by realtek-mdio. If the node is not found, it will also look for a
> compatible string, required only by SMI-connected devices in binding
> docs and compatible with the old realtek-smi behavior.
>
> The line assigning dev.of_node in mdio_bus has been removed since the
> subsequent of_mdiobus_register will always overwrite it.
>
> ds->user_mii_bus is only defined if all user ports do not declare a
> phy-handle, providing a warning about the erroneous device tree[2].
>
> With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
> no longer necessary. Now, the realtek_variant.ds_ops can be used
> directly.
>
> The realtek_priv.setup_interface() has been removed as we can directly
> call the new common function.
>
> The switch unregistration and the MDIO node decrement in refcount were
> moved into realtek_common_remove() as both interfaces now need to put
> the MDIO node.
>
> [1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/
> [2] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/realtek-common.c | 87 +++++++++++++++++++++++-
>  drivers/net/dsa/realtek/realtek-common.h |  1 +
>  drivers/net/dsa/realtek/realtek-mdio.c   |  6 --
>  drivers/net/dsa/realtek/realtek-smi.c    | 68 ------------------
>  drivers/net/dsa/realtek/realtek.h        |  5 +-
>  drivers/net/dsa/realtek/rtl8365mb.c      | 49 ++-----------
>  drivers/net/dsa/realtek/rtl8366rb.c      | 52 ++------------
>  7 files changed, 100 insertions(+), 168 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> index bf3933a99072..b1f0095d5bce 100644
> --- a/drivers/net/dsa/realtek/realtek-common.c
> +++ b/drivers/net/dsa/realtek/realtek-common.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
>  #include <linux/module.h>
> +#include <linux/of_mdio.h>
>
>  #include "realtek.h"
>  #include "realtek-common.h"
> @@ -21,6 +22,85 @@ void realtek_common_unlock(void *ctx)
>  }
>  EXPORT_SYMBOL_GPL(realtek_common_unlock);
>
> +static int realtek_common_user_mdio_read(struct mii_bus *bus, int addr,
> +                                        int regnum)
> +{
> +       struct realtek_priv *priv = bus->priv;
> +
> +       return priv->ops->phy_read(priv, addr, regnum);
> +}
> +
> +static int realtek_common_user_mdio_write(struct mii_bus *bus, int addr,
> +                                         int regnum, u16 val)
> +{
> +       struct realtek_priv *priv = bus->priv;
> +
> +       return priv->ops->phy_write(priv, addr, regnum, val);
> +}
> +
> +int realtek_common_setup_user_mdio(struct dsa_switch *ds)
> +{
> +       const char *compatible = "realtek,smi-mdio";
> +       struct realtek_priv *priv =  ds->priv;
> +       struct device_node *phy_node;
> +       struct device_node *mdio_np;
> +       struct dsa_port *dp;
> +       int ret;
> +
> +       mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> +       if (!mdio_np) {
> +               mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
> +               if (!mdio_np) {
> +                       dev_err(priv->dev, "no MDIO bus node\n");
> +                       return -ENODEV;
> +               }
> +       }

I just kept the code compatible with both realtek-smi and realtek-mdio
(that was using the generic "DSA user mii"), even when it might
violate the binding docs (for SMI with a node not named "mdio").

You suggested using two new compatible strings for this driver
("realtek,rtl8365mb-mdio" and "realtek,rtl8366rb-mdio"). However, it
might still not be a good name as it is similar to the MDIO-connected
subdriver of each variant. Anyway, if possible, I would like to keep
it out of this series as it would first require a change in the
bindings before any real code change and it might add some more path
cycles.

> +       priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> +       if (!priv->user_mii_bus) {
> +               ret = -ENOMEM;
> +               goto err_put_node;
> +       }
> +       priv->user_mii_bus->priv = priv;
> +       priv->user_mii_bus->name = "Realtek user MII";
> +       priv->user_mii_bus->read = realtek_common_user_mdio_read;
> +       priv->user_mii_bus->write = realtek_common_user_mdio_write;
> +       snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> +                ds->index);
> +       priv->user_mii_bus->parent = priv->dev;
> +
> +       /* When OF describes the MDIO, connecting ports with phy-handle,
> +        * ds->user_mii_bus should not be used *
> +        */
> +       dsa_switch_for_each_user_port(dp, ds) {
> +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> +               of_node_put(phy_node);
> +               if (phy_node)
> +                       continue;
> +
> +               dev_warn(priv->dev,
> +                        "DS user_mii_bus in use as '%s' is missing phy-handle",
> +                        dp->name);
> +               ds->user_mii_bus = priv->user_mii_bus;
> +               break;
> +       }

Does this check align with how should ds->user_mii_bus be used (in a
first step for phasing it out, at least for this driver)?

> +
> +       ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> +       if (ret) {
> +               dev_err(priv->dev, "unable to register MDIO bus %s\n",
> +                       priv->user_mii_bus->id);
> +               goto err_put_node;
> +       }
> +
> +       return 0;
> +
> +err_put_node:
> +       of_node_put(mdio_np);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(realtek_common_setup_user_mdio);
> +
>  /* sets up driver private data struct, sets up regmaps, parse common device-tree
>   * properties and finally issues a hardware reset.
>   */
> @@ -108,7 +188,7 @@ int realtek_common_register_switch(struct realtek_priv *priv)
>
>         priv->ds->priv = priv;
>         priv->ds->dev = priv->dev;
> -       priv->ds->ops = priv->ds_ops;
> +       priv->ds->ops = priv->variant->ds_ops;
>         priv->ds->num_ports = priv->num_ports;
>
>         ret = dsa_register_switch(priv->ds);
> @@ -126,6 +206,11 @@ void realtek_common_remove(struct realtek_priv *priv)
>         if (!priv)
>                 return;
>
> +       dsa_unregister_switch(priv->ds);
> +
> +       if (priv->user_mii_bus)
> +               of_node_put(priv->user_mii_bus->dev.of_node);
> +
>         /* leave the device reset asserted */
>         if (priv->reset)
>                 gpiod_set_value(priv->reset, 1);
> diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
> index 518d091ff496..b1c2a50d85cd 100644
> --- a/drivers/net/dsa/realtek/realtek-common.h
> +++ b/drivers/net/dsa/realtek/realtek-common.h
> @@ -7,6 +7,7 @@
>
>  void realtek_common_lock(void *ctx);
>  void realtek_common_unlock(void *ctx);
> +int realtek_common_setup_user_mdio(struct dsa_switch *ds);
>  struct realtek_priv *
>  realtek_common_probe(struct device *dev, struct regmap_config rc,
>                      struct regmap_config rc_nolock);
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 967f6c1e8df0..e2b5432eeb26 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -142,7 +142,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
>         priv->bus = mdiodev->bus;
>         priv->mdio_addr = mdiodev->addr;
>         priv->write_reg_noack = realtek_mdio_write;
> -       priv->ds_ops = priv->variant->ds_ops_mdio;
>
>         ret = realtek_common_register_switch(priv);
>         if (ret)
> @@ -156,11 +155,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
>  {
>         struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
>
> -       if (!priv)
> -               return;
> -
> -       dsa_unregister_switch(priv->ds);
> -
>         realtek_common_remove(priv);
>  }
>  EXPORT_SYMBOL_GPL(realtek_mdio_remove);
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 2b2c6e34bae5..383689163057 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -31,7 +31,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/skbuff.h>
>  #include <linux/of.h>
> -#include <linux/of_mdio.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
> @@ -339,63 +338,6 @@ static const struct regmap_config realtek_smi_nolock_regmap_config = {
>         .disable_locking = true,
>  };
>
> -static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
> -{
> -       struct realtek_priv *priv = bus->priv;
> -
> -       return priv->ops->phy_read(priv, addr, regnum);
> -}
> -
> -static int realtek_smi_mdio_write(struct mii_bus *bus, int addr, int regnum,
> -                                 u16 val)
> -{
> -       struct realtek_priv *priv = bus->priv;
> -
> -       return priv->ops->phy_write(priv, addr, regnum, val);
> -}
> -
> -static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> -{
> -       struct realtek_priv *priv =  ds->priv;
> -       struct device_node *mdio_np;
> -       int ret;
> -
> -       mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
> -       if (!mdio_np) {
> -               dev_err(priv->dev, "no MDIO bus node\n");
> -               return -ENODEV;
> -       }
> -
> -       priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> -       if (!priv->user_mii_bus) {
> -               ret = -ENOMEM;
> -               goto err_put_node;
> -       }
> -       priv->user_mii_bus->priv = priv;
> -       priv->user_mii_bus->name = "SMI user MII";
> -       priv->user_mii_bus->read = realtek_smi_mdio_read;
> -       priv->user_mii_bus->write = realtek_smi_mdio_write;
> -       snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
> -                ds->index);
> -       priv->user_mii_bus->dev.of_node = mdio_np;
> -       priv->user_mii_bus->parent = priv->dev;
> -       ds->user_mii_bus = priv->user_mii_bus;
> -
> -       ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> -       if (ret) {
> -               dev_err(priv->dev, "unable to register MDIO bus %s\n",
> -                       priv->user_mii_bus->id);
> -               goto err_put_node;
> -       }
> -
> -       return 0;
> -
> -err_put_node:
> -       of_node_put(mdio_np);
> -
> -       return ret;
> -}
> -
>  int realtek_smi_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -417,8 +359,6 @@ int realtek_smi_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->mdio);
>
>         priv->write_reg_noack = realtek_smi_write_reg_noack;
> -       priv->setup_interface = realtek_smi_setup_mdio;
> -       priv->ds_ops = priv->variant->ds_ops_smi;
>
>         ret = realtek_common_register_switch(priv);
>         if (ret)
> @@ -432,14 +372,6 @@ void realtek_smi_remove(struct platform_device *pdev)
>  {
>         struct realtek_priv *priv = platform_get_drvdata(pdev);
>
> -       if (!priv)
> -               return;
> -
> -       dsa_unregister_switch(priv->ds);
> -
> -       if (priv->user_mii_bus)
> -               of_node_put(priv->user_mii_bus->dev.of_node);
> -
>         realtek_common_remove(priv);
>  }
>  EXPORT_SYMBOL_GPL(realtek_smi_remove);
> diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> index fbd0616c1df3..7af6dcc1bb24 100644
> --- a/drivers/net/dsa/realtek/realtek.h
> +++ b/drivers/net/dsa/realtek/realtek.h
> @@ -60,7 +60,6 @@ struct realtek_priv {
>
>         spinlock_t              lock; /* Locks around command writes */
>         struct dsa_switch       *ds;
> -       const struct dsa_switch_ops *ds_ops;
>         struct irq_domain       *irqdomain;
>         bool                    leds_disabled;
>
> @@ -71,7 +70,6 @@ struct realtek_priv {
>         struct rtl8366_mib_counter *mib_counters;
>
>         const struct realtek_ops *ops;
> -       int                     (*setup_interface)(struct dsa_switch *ds);
>         int                     (*write_reg_noack)(void *ctx, u32 addr, u32 data);
>
>         int                     vlan_enabled;
> @@ -115,8 +113,7 @@ struct realtek_ops {
>  };
>
>  struct realtek_variant {
> -       const struct dsa_switch_ops *ds_ops_smi;
> -       const struct dsa_switch_ops *ds_ops_mdio;
> +       const struct dsa_switch_ops *ds_ops;
>         const struct realtek_ops *ops;
>         unsigned int clk_delay;
>         u8 cmd_read;
> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index 58ec057b6c32..e890ad113ba3 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
>         return 0;
>  }
>
> -static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
> -{
> -       return rtl8365mb_phy_read(ds->priv, phy, regnum);
> -}
> -
> -static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
> -                                  u16 val)
> -{
> -       return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
> -}
> -
>  static const struct rtl8365mb_extint *
>  rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
>  {
> @@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>         if (ret)
>                 goto out_teardown_irq;
>
> -       if (priv->setup_interface) {
> -               ret = priv->setup_interface(ds);
> -               if (ret) {
> -                       dev_err(priv->dev, "could not set up MDIO bus\n");
> -                       goto out_teardown_irq;
> -               }
> +       ret = realtek_common_setup_user_mdio(ds);
> +       if (ret) {
> +               dev_err(priv->dev, "could not set up MDIO bus\n");
> +               goto out_teardown_irq;
>         }
>
>         /* Start statistics counter polling */
> @@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
>         return 0;
>  }
>
> -static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
> -       .get_tag_protocol = rtl8365mb_get_tag_protocol,
> -       .change_tag_protocol = rtl8365mb_change_tag_protocol,
> -       .setup = rtl8365mb_setup,
> -       .teardown = rtl8365mb_teardown,
> -       .phylink_get_caps = rtl8365mb_phylink_get_caps,
> -       .phylink_mac_config = rtl8365mb_phylink_mac_config,
> -       .phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
> -       .phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
> -       .port_stp_state_set = rtl8365mb_port_stp_state_set,
> -       .get_strings = rtl8365mb_get_strings,
> -       .get_ethtool_stats = rtl8365mb_get_ethtool_stats,
> -       .get_sset_count = rtl8365mb_get_sset_count,
> -       .get_eth_phy_stats = rtl8365mb_get_phy_stats,
> -       .get_eth_mac_stats = rtl8365mb_get_mac_stats,
> -       .get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
> -       .get_stats64 = rtl8365mb_get_stats64,
> -       .port_change_mtu = rtl8365mb_port_change_mtu,
> -       .port_max_mtu = rtl8365mb_port_max_mtu,
> -};
> -
> -static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
> +static const struct dsa_switch_ops rtl8365mb_switch_ops = {
>         .get_tag_protocol = rtl8365mb_get_tag_protocol,
>         .change_tag_protocol = rtl8365mb_change_tag_protocol,
>         .setup = rtl8365mb_setup,
> @@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
>         .phylink_mac_config = rtl8365mb_phylink_mac_config,
>         .phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
>         .phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
> -       .phy_read = rtl8365mb_dsa_phy_read,
> -       .phy_write = rtl8365mb_dsa_phy_write,
>         .port_stp_state_set = rtl8365mb_port_stp_state_set,
>         .get_strings = rtl8365mb_get_strings,
>         .get_ethtool_stats = rtl8365mb_get_ethtool_stats,
> @@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
>  };
>
>  const struct realtek_variant rtl8365mb_variant = {
> -       .ds_ops_smi = &rtl8365mb_switch_ops_smi,
> -       .ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
> +       .ds_ops = &rtl8365mb_switch_ops,
>         .ops = &rtl8365mb_ops,
>         .clk_delay = 10,
>         .cmd_read = 0xb9,
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index e60a0a81d426..56619aa592ec 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -1027,12 +1027,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>         if (ret)
>                 dev_info(priv->dev, "no interrupt support\n");
>
> -       if (priv->setup_interface) {
> -               ret = priv->setup_interface(ds);
> -               if (ret) {
> -                       dev_err(priv->dev, "could not set up MDIO bus\n");
> -                       return -ENODEV;
> -               }
> +       ret = realtek_common_setup_user_mdio(ds);
> +       if (ret) {
> +               dev_err(priv->dev, "could not set up MDIO bus\n");
> +               return -ENODEV;
>         }
>
>         return 0;
> @@ -1772,17 +1770,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
>         return ret;
>  }
>
> -static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
> -{
> -       return rtl8366rb_phy_read(ds->priv, phy, regnum);
> -}
> -
> -static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
> -                                  u16 val)
> -{
> -       return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
> -}
> -
>  static int rtl8366rb_reset_chip(struct realtek_priv *priv)
>  {
>         int timeout = 10;
> @@ -1848,35 +1835,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
>         return 0;
>  }
>
> -static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
> -       .get_tag_protocol = rtl8366_get_tag_protocol,
> -       .setup = rtl8366rb_setup,
> -       .phylink_get_caps = rtl8366rb_phylink_get_caps,
> -       .phylink_mac_link_up = rtl8366rb_mac_link_up,
> -       .phylink_mac_link_down = rtl8366rb_mac_link_down,
> -       .get_strings = rtl8366_get_strings,
> -       .get_ethtool_stats = rtl8366_get_ethtool_stats,
> -       .get_sset_count = rtl8366_get_sset_count,
> -       .port_bridge_join = rtl8366rb_port_bridge_join,
> -       .port_bridge_leave = rtl8366rb_port_bridge_leave,
> -       .port_vlan_filtering = rtl8366rb_vlan_filtering,
> -       .port_vlan_add = rtl8366_vlan_add,
> -       .port_vlan_del = rtl8366_vlan_del,
> -       .port_enable = rtl8366rb_port_enable,
> -       .port_disable = rtl8366rb_port_disable,
> -       .port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
> -       .port_bridge_flags = rtl8366rb_port_bridge_flags,
> -       .port_stp_state_set = rtl8366rb_port_stp_state_set,
> -       .port_fast_age = rtl8366rb_port_fast_age,
> -       .port_change_mtu = rtl8366rb_change_mtu,
> -       .port_max_mtu = rtl8366rb_max_mtu,
> -};
> -
> -static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
> +static const struct dsa_switch_ops rtl8366rb_switch_ops = {
>         .get_tag_protocol = rtl8366_get_tag_protocol,
>         .setup = rtl8366rb_setup,
> -       .phy_read = rtl8366rb_dsa_phy_read,
> -       .phy_write = rtl8366rb_dsa_phy_write,
>         .phylink_get_caps = rtl8366rb_phylink_get_caps,
>         .phylink_mac_link_up = rtl8366rb_mac_link_up,
>         .phylink_mac_link_down = rtl8366rb_mac_link_down,
> @@ -1915,8 +1876,7 @@ static const struct realtek_ops rtl8366rb_ops = {
>  };
>
>  const struct realtek_variant rtl8366rb_variant = {
> -       .ds_ops_smi = &rtl8366rb_switch_ops_smi,
> -       .ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
> +       .ds_ops = &rtl8366rb_switch_ops,
>         .ops = &rtl8366rb_ops,
>         .clk_delay = 10,
>         .cmd_read = 0xa9,
> --
> 2.43.0
>

