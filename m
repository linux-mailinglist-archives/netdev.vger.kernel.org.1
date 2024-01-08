Return-Path: <netdev+bounces-62416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231582707A
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9831F22CD2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAF45976;
	Mon,  8 Jan 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeQMnnU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BB4597B
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso1076799a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722406; x=1705327206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcfaM45gF/et/a6H29npxBOU+4ntT51BwbJxoJ7ElAk=;
        b=CeQMnnU24NO2H+Xvk9rMn/giNHsY07IA6Jh+JdhlEPCzeQduXs1EUjql3BK45ZQlKn
         VzWCkteUrhNVKDOFaszyUopYxvyLgWdNVu8XAHKrlBjRT8SzMbTK5NwoXF6+pXM78sYe
         2gEkmKMrbeTkmWs6vZTs78SIi/kLXWBPBdgsAGhYf94qXHFYUGG7kV7CxSfWMh815GL4
         GV+pY6+uOmjWPEuwJszlr9Bg5n+IATfqZBw0NI4uWSsbWRW/x9mcR3BwTlPd79Va4LtW
         df3kjtqqxGLFnC2ZF+epcEkpiD5L9l4q6XW5subgrjbnK9k06Fn2lHnTQ70uiWGWt4nd
         VKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722406; x=1705327206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcfaM45gF/et/a6H29npxBOU+4ntT51BwbJxoJ7ElAk=;
        b=PO1FrfZozAK0cmwQwWBCtgBVZ5PFcAtvy3OIEt6hjIUl6PtlR51W5lG5Y0Cq/MT48q
         t+3ngs7mlt7XoZeL8IRu/YjOifzJulAstZ7OUfDISbe/DMpBHQSk0DCIlhRUglLTWH83
         N31BJZ1b/d6rEFnLR1wUVwCZP4IqnilaQW1qf5M7husw9FhmibdSd8uPoXzWDTelHGuF
         UFqORRMWJpUuvC3s/Pfo+f6QuPAen9UvfHePSDW8Xt5EAkmY0GEonCOcOf/PZk+0w/R+
         H2+CrpugJEGVEqy34E1+GbzsvMclwGVeHTaklKh++Lg5KoU/PqvqgGYboUTvgwJv59Ld
         yArA==
X-Gm-Message-State: AOJu0YxVNocfP1O6Ce6HfzTvnpi0UtnR2icbWkVy+Dz/8m5gPlqoZXce
	cBV4SahLjgmV0pZoUW7NnOY=
X-Google-Smtp-Source: AGHT+IHj5fKhcCJklzI/HrgSUpREWpdf64LNjf6mNwPKpBaKDKqYobFddWPaolAzQSX4EvXyR3cwHw==
X-Received: by 2002:a17:906:48d3:b0:a2b:1a80:7b8f with SMTP id d19-20020a17090648d300b00a2b1a807b8fmr27262ejt.99.1704722406216;
        Mon, 08 Jan 2024 06:00:06 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709070b1500b00a26af4d96c6sm3956399ejl.4.2024.01.08.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:00:05 -0800 (PST)
Date: Mon, 8 Jan 2024 16:00:02 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240108140002.wpf6zj7qv2ftx476@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-4-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:31PM -0300, Luiz Angelo Daros de Luca wrote:
> Some code can be shared between both interface modules (MDIO and SMI)
> and among variants. These interface functions migrated to a common
> module:
> 
> - realtek_common_lock
> - realtek_common_unlock
> - realtek_common_probe
> - realtek_common_register_switch
> - realtek_common_remove
> 
> The reset during probe was moved to the end of the common probe. This way,
> we avoid a reset if anything else fails.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
> new file mode 100644
> index 000000000000..80b37e5fe780
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/realtek-common.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/module.h>
> +
> +#include "realtek.h"
> +#include "realtek-common.h"
> +
> +void realtek_common_lock(void *ctx)
> +{
> +	struct realtek_priv *priv = ctx;
> +
> +	mutex_lock(&priv->map_lock);
> +}
> +EXPORT_SYMBOL_GPL(realtek_common_lock);

Would you mind adding some kernel-doc comments above each of these
exported functions? https://docs.kernel.org/doc-guide/kernel-doc.html
says "Every function that is exported to loadable modules using
EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc comment.
Functions and data structures in header files which are intended to be
used by modules should also have kernel-doc comments."

It is something I only recently started paying attention to, so we don't
have consistency in this regard. But we should try to adhere to this
practice for code we change.

> +
> +void realtek_common_unlock(void *ctx)
> +{
> +	struct realtek_priv *priv = ctx;
> +
> +	mutex_unlock(&priv->map_lock);
> +}
> +EXPORT_SYMBOL_GPL(realtek_common_unlock);
> +
> +struct realtek_priv *
> +realtek_common_probe(struct device *dev, struct regmap_config rc,
> +		     struct regmap_config rc_nolock)

Could you use "const struct regmap_config *" as the data types here, to
avoid two on-stack variable copies? Regmap will copy the config structures
anyway.

> +{
> +	const struct realtek_variant *var;
> +	struct realtek_priv *priv;
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
> +	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
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
> +EXPORT_SYMBOL(realtek_common_probe);
> diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> index e9ee778665b2..fbd0616c1df3 100644
> --- a/drivers/net/dsa/realtek/realtek.h
> +++ b/drivers/net/dsa/realtek/realtek.h
> @@ -58,11 +58,9 @@ struct realtek_priv {
>  	struct mii_bus		*bus;
>  	int			mdio_addr;
>  
> -	unsigned int		clk_delay;
> -	u8			cmd_read;
> -	u8			cmd_write;
>  	spinlock_t		lock; /* Locks around command writes */
>  	struct dsa_switch	*ds;
> +	const struct dsa_switch_ops *ds_ops;
>  	struct irq_domain	*irqdomain;
>  	bool			leds_disabled;
>  
> @@ -79,6 +77,8 @@ struct realtek_priv {
>  	int			vlan_enabled;
>  	int			vlan4k_enabled;
>  
> +	const struct realtek_variant *variant;
> +
>  	char			buf[4096];
>  	void			*chip_data; /* Per-chip extra variant data */
>  };

Can the changes to struct realtek_priv be a separate patch, to
clarify what is being changed, and to leave the noisy code movement
more isolated?

