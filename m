Return-Path: <netdev+bounces-65926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26983C771
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A9F1C23D42
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A173172;
	Thu, 25 Jan 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT8KCcSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AC6EB62
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198718; cv=none; b=IdXt0L7NPHu6+UTMDISD2FqI7V0C12Bp+gy9WJKK9C6Mk3kd+vj/zHAHFOA5wrczgWbkmu/lLMVrXc+CacSNWNEccEtBFVN2QksyOpSz/OV/mJ0izM54o69aLITrbTwbEmJbzKvbtRbE3rvpnAfMxseOdAzE3wmaFPFmvCe9GoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198718; c=relaxed/simple;
	bh=WcgIVxFAEZm5k+sUvy6ja0ZDx8MUw2tq4VHi8PgvCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR57V0TVHWb5ATWQxaMCor5tmqLesoriQ43H9bELgWTCPRRugiT0wSxkoaLGN2jtrQQKnhU9JHLoLsQf+5l1Tii/qLEufVj4te8SC64pWviYQ50Dj11CPb8DwigliSO+Er3qBUBow4AALFBNZwbGv0ogDG0is6RkLgJL8p2f9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT8KCcSj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26fa294e56so706399266b.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706198714; x=1706803514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5YZuTNLjYN9CQlSLRnpRr3XmeJ9yYwxzSycwQgafHA=;
        b=KT8KCcSjgIJnavXoh8dRrhsraBPlk42btIL+mZPam8H+7ZnKBi62EtXMs05rvQJjby
         CR40/HxyerW/QagSu8w6qQBliINu3E7Q6Yff9XabQHGbdoXZzSxPsZt5EmSSSKTrmtsU
         vkRvyMyyLF6YygvHKpMMnrwLdNiIlhB5ufwLJs3VYhzb9ZVQ0WYsVpP8T8hlavxsYAvr
         AjZQmObZ3jJkChbNhSvaYkpahg+4vF+NhbHdJ+yNd5+URMWFMlRE7BXPSBLjw9Xt+5iS
         cx79YyWYpORDA5682sz1g6N/y4jUWxHiz8wCGf6AalSvm7MIDAX75HEEB7JzuLoxYKod
         WRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198714; x=1706803514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5YZuTNLjYN9CQlSLRnpRr3XmeJ9yYwxzSycwQgafHA=;
        b=Cugc/TAuXMV+P2Z0/wbldDC3kXXNwJYf99VSuocB+658BAJe0Zxq2xsO+mVk9aCUkD
         QNLFfFQUeo27ouGA7rMYgfLMRcy8LDOLW8HcM30Ts9SHFUndbWgxFumVoC1NOEkZWgEA
         8fD1ovt+eeLnkf0byOAM2owG5/YZRKyBDPSRujyp0RP6X1FA5OytydsnSn24QvGrovYm
         nhBlGBBdPfm1SUNcIBqeJEb3zoiuIUCv2AMybrvl4Bb4uV6PBPLC7lZObCUqPBWW70dM
         pJNPVt8LIhKvDkS9mph5pC2Y7Ag5cc4WQ8rN8ExvtXOAsdAtu1PmESob0sJup8y7htua
         SOOQ==
X-Gm-Message-State: AOJu0YwLtH6BX5tNSPAA39nbqf8xbrpAJ6poMXuncoeF2R1i7EApvezZ
	BB7GViyhwzEcPx2eHMT/wbhh7psKLek7MEhWuIN7xMoYemWM/YLU
X-Google-Smtp-Source: AGHT+IEKRs+4oLt7Uq409EefzkIAJIqpGscsJRpg8QfLodDOI5ecmRXSDRiNSKqD1fV1cBZqcR8wXQ==
X-Received: by 2002:a17:907:cca5:b0:a31:484a:2db2 with SMTP id up37-20020a170907cca500b00a31484a2db2mr452467ejc.117.1706198714200;
        Thu, 25 Jan 2024 08:05:14 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id cu1-20020a170906ba8100b00a319088708csm536624ejd.211.2024.01.25.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:05:13 -0800 (PST)
Date: Thu, 25 Jan 2024 18:05:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 09/11] net: dsa: realtek: migrate
 user_mii_bus setup to realtek-dsa
Message-ID: <20240125160511.pskpwroyrdmooxrg@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-10-luizluca@gmail.com>
 <20240123215606.26716-10-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-10-luizluca@gmail.com>
 <20240123215606.26716-10-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:56:01PM -0300, Luiz Angelo Daros de Luca wrote:
> In the user MDIO driver, despite numerous references to SMI, including
> its compatible string, there's nothing inherently specific about the SMI
> interface in the user MDIO bus. Consequently, the code has been migrated
> to the rtl83xx module. All references to SMI have been eliminated.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 53bacbacc82e..525d8c014136 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/module.h>
> +#include <linux/of_mdio.h>
>  
>  #include "realtek.h"
>  #include "rtl83xx.h"
> @@ -42,6 +43,72 @@ void rtl83xx_unlock(void *ctx)
>  }
>  EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
>  
> +static int rtl83xx_user_mdio_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	struct realtek_priv *priv = bus->priv;
> +
> +	return priv->ops->phy_read(priv, addr, regnum);
> +}
> +
> +static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
> +				   u16 val)
> +{
> +	struct realtek_priv *priv = bus->priv;
> +
> +	return priv->ops->phy_write(priv, addr, regnum, val);
> +}

Do we actually need to go through this extra indirection, or can the
priv->ops->phy_read/write() prototypes be made to take just struct
mii_bus * as their first argument?

> +
> +/**
> + * rtl83xx_setup_user_mdio() - register the user mii bus driver
> + * @ds: DSA switch associated with this user_mii_bus
> + *
> + * This function first gets and mdio node under the dev OF node, aborting
> + * if missing. That mdio node describing an mdio bus is used to register a
> + * new mdio bus.
> + *
> + * Context: Any context.
> + * Return: 0 on success, negative value for failure.
> + */
> +int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
> +{
> +	struct realtek_priv *priv =  ds->priv;

Please remove the extra space here in " =  ds->priv".

> +	struct device_node *mdio_np;
> +	int ret = 0;
> +
> +	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> +	if (!mdio_np) {
> +		dev_err(priv->dev, "no MDIO bus node\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> +	if (!priv->user_mii_bus) {
> +		ret = -ENOMEM;
> +		goto err_put_node;
> +	}
> +
> +	priv->user_mii_bus->priv = priv;
> +	priv->user_mii_bus->name = "Realtek user MII";
> +	priv->user_mii_bus->read = rtl83xx_user_mdio_read;
> +	priv->user_mii_bus->write = rtl83xx_user_mdio_write;
> +	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> +		 ds->index);

There isn't much consistency here, but maybe something derived from
dev_name(dev) or %pOF would make it clearer that it describes a switch's
internal MDIO bus, rather than just any Realtek thing?

> +	priv->user_mii_bus->parent = priv->dev;
> +
> +	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> +	if (ret) {
> +		dev_err(priv->dev, "unable to register MDIO bus %s\n",
> +			priv->user_mii_bus->id);
> +		goto err_put_node;
> +	}

Maybe this function would look a bit less cluttered with a temporary
struct mii_bus *bus variable, and priv->user_mii_bus gets assigned to
"bus" at the end (on success), and another struct device *dev = priv->dev.

> +
> +err_put_node:
> +	of_node_put(mdio_np);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_user_mdio, REALTEK_DSA);
> +
>  /**
>   * rtl83xx_probe() - probe a Realtek switch
>   * @dev: the device being probed
> diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
> index 9eb8197a58fa..b5d464bb850d 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.h
> +++ b/drivers/net/dsa/realtek/rtl83xx.h
> @@ -12,6 +12,7 @@ struct realtek_interface_info {
>  
>  void rtl83xx_lock(void *ctx);
>  void rtl83xx_unlock(void *ctx);
> +int rtl83xx_setup_user_mdio(struct dsa_switch *ds);
>  struct realtek_priv *
>  rtl83xx_probe(struct device *dev,
>  	      const struct realtek_interface_info *interface_info);
> -- 
> 2.43.0
> 

Otherwise, this is in principle ok and what I wanted to see.

