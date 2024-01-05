Return-Path: <netdev+bounces-61732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A2824C22
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAB286A0C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1DDA32;
	Fri,  5 Jan 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAn/TsDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7C626
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso1051071fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704414368; x=1705019168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+MdLc+k+XWvHGAXcBSxBQ+6xejfLMr5uzuLuPE9qz0=;
        b=gAn/TsDjQadazDKwJEX2mymt6/zRcIt+tYaQ8tMB6CW5PYjetUgrgzWSgaQfrbuZo4
         h6x7Y6CPDTG0GPNQwc57h+jd0uhs5LJMFikvfTrBLIfvnV+TvPmNr3E/VoMycAZGn1IW
         d+ZCE6nPRlAbxRdUu0grCkf3xRUsI74gIKKnyycrbRs5paJ91ziWyC9NQQDDKAO8a9W3
         ePau4+SJaRObkFZBdAz6bDhxrkANDAHBUTfWAY57G77bdPuZy1CM6Ey9YluAPzFNR/W2
         v+EO+iJadp34zKlhWpIKKpcuQJcOrapP2MbjU3a+JGJsU4KiUH7ZZgBp+Sg4AbrQ+MYg
         BrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704414368; x=1705019168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+MdLc+k+XWvHGAXcBSxBQ+6xejfLMr5uzuLuPE9qz0=;
        b=mDwAWBo8QLpHuVz+ddwuJ8L1ZUv+Ua7uxJ3t6LuQgyrbRp9AJ9uHXh4GzeuYHT12xW
         sL8e++11ZuVOYFTc+qiV97GQv0fWRLVvENH+EWsREv0B/y6oy/QWjPQlUEVkGGw+a7jY
         cTjT2OojiqBfdjQ1mOFL1ccrjQu/pYtZhg6sQFcYcOn26ndxk23+m8KQ0yxjoRf688Yw
         i9T9B6KQMtw5jIryLkk88UOp8cuauf3M5h5/kQWFUgGhet9kU8YavBDu5nwrbn1wo+it
         +fFxugm+QKCuS5s3gJjEjB63j7A0N+hQHSx44U8K/tbxVtxHGs5mNqjVU5oVo2VX8nxS
         iXKQ==
X-Gm-Message-State: AOJu0Yw9QXgOSaRYzsYzj02LMVunitEr78W06qJTBDxAtqJJRA6X7kz2
	nE190un/7J1wsMwCA3mdyzSNDehFPH/jtidnJjE=
X-Google-Smtp-Source: AGHT+IGn624JlKlQnySjxEjO5oa+vL90mBXEkZ0RVLsLpCmA75ftlqffn6z0DM5H1XFuxDidt3bbwQuLdHUtdkYXeMI=
X-Received: by 2002:a2e:9056:0:b0:2cd:191a:c1bf with SMTP id
 n22-20020a2e9056000000b002cd191ac1bfmr679469ljg.14.1704414368318; Thu, 04 Jan
 2024 16:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-5-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-5-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 21:25:57 -0300
Message-ID: <CAJq09z4NbssvqSMcb1aCz0yAjkFhBtCdJfraQo1ijGA9sWb8Tg@mail.gmail.com>
Subject: Re: [PATCH net-next 04/10] net: dsa: qca8k: put MDIO bus OF node on
 qca8k_mdio_register() failure
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> of_get_child_by_name() gives us an OF node with an elevated refcount,
> which should be dropped when we're done with it. This is so that,
> if (of_node_check_flag(node, OF_DYNAMIC)) is true, the node's memory can
> eventually be freed.
>
> There are 2 distinct paths to be considered in qca8k_mdio_register():
>
> - devm_of_mdiobus_register() succeeds: since commit 3b73a7b8ec38 ("net:
>   mdio_bus: add refcounting for fwnodes to mdiobus"), the MDIO core
>   treats this well.
>
> - devm_of_mdiobus_register() or anything up to that point fails: it is
>   the duty of the qca8k driver to release the OF node.

In both cases, it is qca8k driver duty to put the OF node.
3b73a7b8ec38 just allows you to put it just after mdiobus_registration
and not only after mdiobus_unregistration. This patch does put it
correctly though.

> This change addresses the second case by making sure that the OF node
> reference is not leaked.
>
> The "mdio" node may be NULL, but of_node_put(NULL) is safe.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index ec57d9d52072..5f47a290bd6e 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -949,10 +949,15 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>         struct dsa_switch *ds = priv->ds;
>         struct device_node *mdio;
>         struct mii_bus *bus;
> +       int err;
> +
> +       mdio = of_get_child_by_name(priv->dev->of_node, "mdio");

I couldn't get why you moved this here. It will only be used in
of_device_is_available()

>
>         bus = devm_mdiobus_alloc(ds->dev);
> -       if (!bus)
> -               return -ENOMEM;
> +       if (!bus) {
> +               err = -ENOMEM;
> +               goto out_put_node;
> +       }
>
>         bus->priv = (void *)priv;
>         snprintf(bus->id, MII_BUS_ID_SIZE, "qca8k-%d.%d",
> @@ -962,12 +967,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>         ds->user_mii_bus = bus;
>
>         /* Check if the devicetree declare the port:phy mapping */
> -       mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
>         if (of_device_is_available(mdio)) {

This is off-topic for this patch but it sounds strange to have an mdio
node marked as disabled. The legacy code seems to cover old
device-trees that do not have the mdio node. Supporting an existing
but disabled mdio might point in the wrong direction. Anyway, it would
be good to have common behavior across drivers. I can update the
realtek driver to match whatever is the recommended usage.

As a bonus, if a disabled node should return an error and not fallback
to the legacy user mii, devm_mdiobus_register could be replaced by
devm_of_mdiobus_register() as it handles mdio==NULL.

>                 bus->name = "qca8k user mii";
>                 bus->read = qca8k_internal_mdio_read;
>                 bus->write = qca8k_internal_mdio_write;
> -               return devm_of_mdiobus_register(priv->dev, bus, mdio);
> +               err = devm_of_mdiobus_register(priv->dev, bus, mdio);
> +               goto out_put_node;
>         }
>
>         /* If a mapping can't be found the legacy mapping is used,
> @@ -976,7 +981,13 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>         bus->name = "qca8k-legacy user mii";
>         bus->read = qca8k_legacy_mdio_read;
>         bus->write = qca8k_legacy_mdio_write;
> -       return devm_mdiobus_register(priv->dev, bus);
> +
> +       err = devm_mdiobus_register(priv->dev, bus);
> +
> +out_put_node:
> +       of_node_put(mdio);
> +
> +       return err;
>  }
>
>  static int
> --
> 2.34.1
>
Regards,

Luiz

