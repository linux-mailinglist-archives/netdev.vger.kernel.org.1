Return-Path: <netdev+bounces-65852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77383C0A0
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA581F21CEC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C8224E8;
	Thu, 25 Jan 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtv0MwUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FD1BC3A
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181445; cv=none; b=pZ1lDCJLgr5+Wj6njPVRs5FDGO1ejEJpgSrH9FIEM1zycfRhEf7BHj23mpoCcTCJ3rCf3gDJdgU5Q/xoA2QGy3+63d8NU5VMV696MbE7K2vepQx0Ddu+1DnS9i1zjwqWRecpmO84sYMbvL7qiWttHU6qaNDSs/wanHPvI8ykeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181445; c=relaxed/simple;
	bh=MdslMVgzHi1m8oYvgxheQS05Ee+kiif+JVF7D5uCinQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvULC7VARho4tw7vsnNyddbpVxzYAzV3692Hbe1xfwxGT0bHyxt7IjyGWJVEtYl01eB9BhTjeCrlEkCCSylCcZ6aQEBMhywdf/P6qmJwZ9OmT4XPRxScyThJFRNRjvKPLbQoh478QPDO4qddJOY/bC8QKU/ax2tgCczZWf0r0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtv0MwUz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2e0be86878so119562366b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706181441; x=1706786241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxshifZza5zmbGioMcGXHlFCYwjpkJ56TpATNMZYq1Q=;
        b=Xtv0MwUzhsazwTVOVCCj21sbSocgFZOJyOORkOZ+Ca8NVBABS9Di9Jpo+0wwqtoOez
         7YPy3LQqTx12BkKBOFbYnL2E3iD7AnmQ8ZRQl9wTn0io15H8YrYLbRRABKsBM5F7qcml
         uvgJMVwopsyeQ8w4y+reOM9S7m9Bn3hDOsnmw7LfTKX/PxuK8zQQrIMWJIoOPKnoFQuq
         MElZ/vlZhYADDqn5cLrgf1dqeBfolZ/G2+r3Z51KKUuVfOiUILvcQSa2mSEbMHm+Ov/y
         Fgdd//hVH8UKIn92XOe3flKPJSJg+YBaij6hyha+9mp8eOqNfUgyq6WyHJQaArVfe2Ea
         PhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706181441; x=1706786241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxshifZza5zmbGioMcGXHlFCYwjpkJ56TpATNMZYq1Q=;
        b=SUbCTmOLhjrKU8MZvMwv/0dDkhi8gDQUuRV70NKAzVPWk9odw5bZpawk2MdTq4sd/q
         tbhK4EpFHBrcoJnn46Y7kZoH2C6h/M+DhGE76i4bui2yoa9zQEEdgJuhKmhhEZ+5C0d8
         AmTiLWF9LN/jdyyPgoFEawUo71aLaVNCI38ajxDKMZVYzDX1SOToNrfdP8un5ABoIIPt
         u9S8JNf+trxlA+/b6KsVoBLWsp8XkoIOSf8AjArtosMFx8aSjuqothQT+4eScvbVH74k
         eM0XuQnkKpREPVVtPIWffQwWMvou0G3+rhdzQpiISE+Qvfr1HfljwORCxRUW/29OhcOO
         tWkw==
X-Gm-Message-State: AOJu0YzKSmWTyUdA2W93hy/h4ORnQzCpXe4WertfTtF46b3t/UBNVfr4
	7aVBT603AbX8D2x/Pywe9Q6+a+jPgEq36gOEj2AvR5iVlRIy6dxB
X-Google-Smtp-Source: AGHT+IFdiKVcHZ3e9rryvTmUA4qBemYPPY73y/KjS/xyBFs4ptx9bNjqqQLcRi49X//m1Kkoh9oLkw==
X-Received: by 2002:a17:907:788f:b0:a33:b38:f296 with SMTP id ku15-20020a170907788f00b00a330b38f296mr76958ejc.21.1706181441114;
        Thu, 25 Jan 2024 03:17:21 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b00a2a2426728bsm919919eja.178.2024.01.25.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:17:20 -0800 (PST)
Date: Thu, 25 Jan 2024 13:17:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Message-ID: <20240125111718.armzsazgcjnicc2h@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-9-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:56:00PM -0300, Luiz Angelo Daros de Luca wrote:
> The line assigning dev.of_node in mdio_bus has been removed since the
> subsequent of_mdiobus_register will always overwrite it.

Please use present tense and imperative mood. "Remove the line assigning
dev.of_node, because ...".

> 
> ds->user_mii_bus is not assigned anymore[1].

"As discussed in [1], allow the DSA core to be simplified, by not
assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
is unnecessary."

> It should work as before as long as the switch ports have a valid
> phy-handle property.
> 
> Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> to mdiobus"), we can put the "mdio" node just after the MDIO bus
> registration.

> The switch unregistration was moved into realtek_common_remove() as
> both interfaces now use the same code path.

Hopefully you can sort this part out in a separate patch that's
unrelated to the user_mii_bus cleanup, ideally in "net: dsa: realtek:
common rtl83xx module".

> 
> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
>  drivers/net/dsa/realtek/realtek-smi.c  | 15 ++-------------
>  drivers/net/dsa/realtek/rtl83xx.c      |  2 ++
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 0171185ec665..c75b4550802c 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -158,11 +158,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
>  {
>  	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
>  
> -	if (!priv)
> -		return;
> -

The way I would structure these guards is I would keep them here, and
not in rtl83xx_remove() and rtl83xx_shutdown(). Then I would make sure
that rtl83xx_remove() is the exact opposite of just rtl83xx_probe(), and
rtl83xx_unregister_switch() is the exact opposite of just rtl83xx_register_switch().

And I would fix the error handling path of realtek_smi_probe() and
realtek_mdio_probe() to call rtl83xx_remove() when rtl83xx_register_switch()
fails.

> -	dsa_unregister_switch(priv->ds);
> -
>  	rtl83xx_remove(priv);
>  }
>  EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 0ccb2a6059a6..a89813e527d2 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -331,7 +331,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  {
>  	struct realtek_priv *priv =  ds->priv;
>  	struct device_node *mdio_np;
> -	int ret;
> +	int ret = 0;
>  
>  	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
>  	if (!mdio_np) {
> @@ -344,15 +344,14 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  		ret = -ENOMEM;
>  		goto err_put_node;
>  	}
> +
>  	priv->user_mii_bus->priv = priv;
>  	priv->user_mii_bus->name = "SMI user MII";
>  	priv->user_mii_bus->read = realtek_smi_mdio_read;
>  	priv->user_mii_bus->write = realtek_smi_mdio_write;
>  	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
>  		 ds->index);
> -	priv->user_mii_bus->dev.of_node = mdio_np;
>  	priv->user_mii_bus->parent = priv->dev;
> -	ds->user_mii_bus = priv->user_mii_bus;
>  
>  	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
>  	if (ret) {
> @@ -361,8 +360,6 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  		goto err_put_node;
>  	}
>  
> -	return 0;
> -
>  err_put_node:
>  	of_node_put(mdio_np);
>  
> @@ -434,14 +431,6 @@ void realtek_smi_remove(struct platform_device *pdev)
>  {
>  	struct realtek_priv *priv = platform_get_drvdata(pdev);
>  
> -	if (!priv)
> -		return;
> -
> -	dsa_unregister_switch(priv->ds);
> -
> -	if (priv->user_mii_bus)
> -		of_node_put(priv->user_mii_bus->dev.of_node);
> -
>  	rtl83xx_remove(priv);
>  }
>  EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 3d07c5662fa4..53bacbacc82e 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -190,6 +190,8 @@ void rtl83xx_remove(struct realtek_priv *priv)
>  	if (!priv)
>  		return;
>  
> +	dsa_unregister_switch(priv->ds);
> +
>  	/* leave the device reset asserted */
>  	if (priv->reset)
>  		gpiod_set_value(priv->reset, 1);
> -- 
> 2.43.0
> 


