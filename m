Return-Path: <netdev+bounces-65842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2983BFFB
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABF31C20D14
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD167742;
	Thu, 25 Jan 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6Sb3IfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6A66B51
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179531; cv=none; b=rM9vERf6p7QK4/Etdx+vPtqjLwlJbLT6X4dnhMm6Vvk8i4XM66h3ES263klohPIrdoLWGXdrrXfBS7SWdaPy32F1TbQXCvGHur3cW8xrDRhaX1+a7P0A7VOErmEs7Gmkt8eqDw7cXfMGZs0wPhjA6OmR/q6+L2F+PuEg5vYEubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179531; c=relaxed/simple;
	bh=Q2tHQkHRymaAxik/Vs9qeR13ue8O9s7ujpTWcE1JLts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sev8QkVKztpd32W6e8jzZegAY4oBTxBuUzweDxoDspVI9urggIc/pjxpaAqX7ZYjxJxjQvy+NxFCIItHc2E4dTEetqUx1faNW+vgW17rAoJFbx1epyYUj6iIsCXDjGfKqI4tp/qm4Q+v/zEU71q6huC0xtk99NhrJ3U9tM52DLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6Sb3IfX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a31798a73bfso34097866b.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706179527; x=1706784327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFGxMj7UCvucm1ly2smbgUkA41z8AYlc5wecDucYXdA=;
        b=j6Sb3IfXPiXJuPAeonAQovxh/hHjFsbk1AKOVkA0AOghwajiA8AHm6hfVBJQQmvPQ7
         nOci7vYTcPAKFDFYAmNfYXYbZeDB90tGPT5UJJHE3ME6iKpEptzEDsZzN8If3kwRZYCT
         8LoOeoFDXc59AZPM8RGQow3DHQq+YZMpoJgk2tY6f2plFy/+k+wvQj3rAUa9qwdSOqGW
         xzGqQ4zXG/5MA/u0ZgU8SaMpycBVqMK2gYmfOZz5Jtt+nf56XM3il6iZigWRBqFDle75
         82ykRZAkuuEx3SemQ5eagdrsh9dmiRCthpbQJ3OSbKlfMU8fw9tUxE5t/4BF+s4TiMNq
         Fnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706179527; x=1706784327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFGxMj7UCvucm1ly2smbgUkA41z8AYlc5wecDucYXdA=;
        b=rE0At6BZ6BjCoQOZTcFn+9pL+jCGR85xz02YmU14xvWYwv8sOW3QzBfcIVQn+4HkOI
         Tq13B5g1Gtrg4X2zV8MQg/epWH1+roFz/+BykGm3/knsk1eTa0ZPCAjSseqvYS+0wttn
         7hPq1JEw5HNjEWy9OAq8hPa2xgDIbxtNXhcZh4cP1nhVvKLjlv2MuVt8lGEbQoJlStfx
         FQ1Po75Q1QCJSVADYVu3YZnvkq6VwtvJEfKwD0NXsKoQv8Qbb9OVhXtVZOLg4gxdawg6
         FFteD3rErLxlS9cwkirqIBdmvfMxzc39sxebATM2kKeWkxGIRLq0nKrJJ9z9ZB9ztPwc
         iLtQ==
X-Gm-Message-State: AOJu0Yw//f83IozRpHXVL0GSoh5vssdZ/iTuAV2NyfseQJAHeqXs42xn
	fq8G1vWkKwZyZGh1SbGCEw/yLasQslO9VgLemJOOjhahzGB1O/oP
X-Google-Smtp-Source: AGHT+IEydWSVGzCOH3cZQ6VSy8YeFIq2wExCimlEIeWvHGfde8Drd3FlJvliH9pNDvzKtmkg2ZPc/w==
X-Received: by 2002:a17:907:cb19:b0:a28:5745:91b2 with SMTP id um25-20020a170907cb1900b00a28574591b2mr400375ejc.20.1706179527254;
        Thu, 25 Jan 2024 02:45:27 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id wk18-20020a170907055200b00a2adc93e308sm882518ejb.222.2024.01.25.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:45:26 -0800 (PST)
Date: Thu, 25 Jan 2024 12:45:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 05/11] net: dsa: realtek: common rtl83xx
 module
Message-ID: <20240125104524.vfkoztu4kcabxdlc@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-6-luizluca@gmail.com>
 <20240123215606.26716-6-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-6-luizluca@gmail.com>
 <20240123215606.26716-6-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:55:57PM -0300, Luiz Angelo Daros de Luca wrote:
> Some code can be shared between both interface modules (MDIO and SMI)
> and among variants. These interface functions migrated to a common
> module:
>
> - rtl83xx_lock
> - rtl83xx_unlock
> - rtl83xx_probe
> - rtl83xx_register_switch

For API uniformity, I would also introduce rtl83xx_unregister_switch()
to make it clear that there is a teardown step associated with this.

> - rtl83xx_remove

No rtl83xx_shutdown()?

You could centralize the comments from the mdio and smi interfaces into
the rtl83xx common layer.

>
> The reset during probe was moved to the end of the common probe. This way,
> we avoid a reset if anything else fails.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 57bd5d8814c2..26b8371ecc87 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -303,3 +194,5 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
>  MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
>  MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(REALTEK_DSA);
> +

Stray blank line at the end of the file.

> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 274dd96b099c..840b1a835d07 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -575,3 +473,5 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
>  MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
>  MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(REALTEK_DSA);
> +

Likewise.

> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> new file mode 100644
> index 000000000000..57d185226b03
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/module.h>
> +
> +#include "realtek.h"
> +#include "rtl83xx.h"
> +
> +/**
> + * rtl83xx_lock() - Locks the mutex used by regmaps
> + * @ctx: realtek_priv pointer
> + *
> + * This function is passed to regmap to be used as the lock function.
> + * It is also used externally to block regmap before executing multiple
> + * operations that must happen in sequence (which will use
> + * realtek_priv.map_nolock instead).
> + *
> + * Context: Any context. Holds priv->map_lock lock.

Not "any context", but "sleepable context". You cannot acquire a mutex
in atomic context. Actually this applies across the board in this patch
set. The entry points into DSA also take mutex_lock(&dsa2_mutex), so
this also applies to its callers' context..

> + * Return: nothing
> + */
> +void rtl83xx_lock(void *ctx)
> +{
> +	struct realtek_priv *priv = ctx;
> +
> +	mutex_lock(&priv->map_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_lock, REALTEK_DSA);
> +
> +/**
> + * rtl83xx_unlock() - Unlocks the mutex used by regmaps
> + * @ctx: realtek_priv pointer
> + *
> + * This function unlocks the lock acquired by rtl83xx_lock.
> + *
> + * Context: Any context. Releases priv->map_lock lock
> + * Return: nothing
> + */
> +void rtl83xx_unlock(void *ctx)
> +{
> +	struct realtek_priv *priv = ctx;
> +
> +	mutex_unlock(&priv->map_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
> +
> +/**
> + * rtl83xx_probe() - probe a Realtek switch
> + * @dev: the device being probed
> + * @interface_info: reg read/write methods for a specific management interface.

Leave this description more open-ended, otherwise it will have to be
modified when struct realtek_interface_info gains more fields.

> + *
> + * This function initializes realtek_priv and read data from the device-tree

s/read/reads/
s/device-tree/device tree/

> + * node. The switch is hard resetted if a method is provided.
> + *
> + * Context: Any context.
> + * Return: Pointer to the realtek_priv or ERR_PTR() in case of failure.
> + *
> + * The realtek_priv pointer does not need to be freed as it is controlled by
> + * devres.
> + *
> + */
> +struct realtek_priv *
> +rtl83xx_probe(struct device *dev,
> +	      const struct realtek_interface_info *interface_info)
> +{
> +	const struct realtek_variant *var;
> +	struct realtek_priv *priv;
> +	struct regmap_config rc = {
> +			.reg_bits = 10, /* A4..A0 R4..R0 */
> +			.val_bits = 16,
> +			.reg_stride = 1,
> +			.max_register = 0xffff,
> +			.reg_format_endian = REGMAP_ENDIAN_BIG,
> +			.reg_read = interface_info->reg_read,
> +			.reg_write = interface_info->reg_write,
> +			.cache_type = REGCACHE_NONE,
> +			.lock = rtl83xx_lock,
> +			.unlock = rtl83xx_unlock,

Too many levels of indentation.

> +	};
> +	int ret;
> +
> +	var = of_device_get_match_data(dev);
> +	if (!var)
> +		return ERR_PTR(-EINVAL);
> +
> +	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&priv->map_lock);
> +
> +	rc.lock_arg = priv;
> +	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> +	if (IS_ERR(priv->map)) {
> +		ret = PTR_ERR(priv->map);
> +		dev_err(dev, "regmap init failed: %d\n", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	rc.disable_locking = true;
> +	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
> +	if (IS_ERR(priv->map_nolock)) {
> +		ret = PTR_ERR(priv->map_nolock);
> +		dev_err(dev, "regmap init failed: %d\n", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Link forward and backward */
> +	priv->dev = dev;
> +	priv->variant = var;
> +	priv->ops = var->ops;
> +	priv->chip_data = (void *)priv + sizeof(*priv);
> +
> +	dev_set_drvdata(dev, priv);
> +	spin_lock_init(&priv->lock);
> +
> +	priv->leds_disabled = of_property_read_bool(dev->of_node,
> +						    "realtek,disable-leds");
> +
> +	/* TODO: if power is software controlled, set up any regulators here */
> +
> +	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->reset)) {
> +		dev_err(dev, "failed to get RESET GPIO\n");
> +		return ERR_CAST(priv->reset);
> +	}
> +	if (priv->reset) {
> +		gpiod_set_value(priv->reset, 1);
> +		dev_dbg(dev, "asserted RESET\n");
> +		msleep(REALTEK_HW_STOP_DELAY);
> +		gpiod_set_value(priv->reset, 0);
> +		msleep(REALTEK_HW_START_DELAY);
> +		dev_dbg(dev, "deasserted RESET\n");
> +	}
> +
> +	return priv;
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_probe, REALTEK_DSA);
> +
> +/**
> + * rtl83xx_register_switch() - detects and register a switch
> + * @priv: realtek_priv pointer
> + *
> + * This function first checks the switch chip ID and register a DSA
> + * switch.
> + *
> + * Context: Any context. Takes and releases priv->map_lock.
> + * Return: 0 on success, negative value for failure.
> + */
> +int rtl83xx_register_switch(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	ret = priv->ops->detect(priv);
> +	if (ret) {
> +		dev_err_probe(priv->dev, ret, "unable to detect switch\n");
> +		return ret;
> +	}
> +
> +	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
> +	if (!priv->ds)
> +		return -ENOMEM;
> +
> +	priv->ds->priv = priv;
> +	priv->ds->dev = priv->dev;
> +	priv->ds->ops = priv->ds_ops;
> +	priv->ds->num_ports = priv->num_ports;
> +
> +	ret = dsa_register_switch(priv->ds);
> +	if (ret) {
> +		dev_err_probe(priv->dev, ret, "unable to register switch\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_register_switch, REALTEK_DSA);
> +
> +/**
> + * rtl83xx_remove() - Cleanup a realtek switch driver
> + * @ctx: realtek_priv pointer

s/ctx/priv/

> + *
> + * If a method is provided, this function asserts the hard reset of the switch
> + * in order to avoid leaking traffic when the driver is gone.
> + *
> + * Context: Any context.
> + * Return: nothing
> + */
> +void rtl83xx_remove(struct realtek_priv *priv)
> +{
> +	if (!priv)
> +		return;
> +
> +	/* leave the device reset asserted */
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, 1);
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
> +
> +MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> +MODULE_DESCRIPTION("Realtek DSA switches common module");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
> new file mode 100644
> index 000000000000..9eb8197a58fa
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl83xx.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _RTL83XX_H
> +#define _RTL83XX_H
> +
> +#include <linux/regmap.h>

I don't think anything from this header needs regmap.h?
For testing what is needed, you can create a dummy.c file which includes
only rtl83xx.h, and add just the necessary headers so that dummy.c
builds cleanly.

> +
> +struct realtek_interface_info {
> +	int (*reg_read)(void *ctx, u32 reg, u32 *val);
> +	int (*reg_write)(void *ctx, u32 reg, u32 val);
> +};
> +
> +void rtl83xx_lock(void *ctx);
> +void rtl83xx_unlock(void *ctx);
> +struct realtek_priv *
> +rtl83xx_probe(struct device *dev,
> +	      const struct realtek_interface_info *interface_info);
> +int rtl83xx_register_switch(struct realtek_priv *priv);
> +void rtl83xx_remove(struct realtek_priv *priv);
> +
> +#endif /* _RTL83XX_H */
> --
> 2.43.0
>


