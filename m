Return-Path: <netdev+bounces-49004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBD7F0617
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384D01C20456
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E681B655;
	Sun, 19 Nov 2023 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Zv6duC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8D115
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:13:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso2672414f8f.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396021; x=1701000821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/X2Hjy9928PmrZRwLa11s4OXD1TRt3Se0ytUrNf/5I=;
        b=E/Zv6duCd2YTqpUiSSVBE48nWYbMtIYYTGwF1ugEUHVOvGY4X0uQ781S6qIPBOSYwx
         ED1EUE96jfmORyyL2z8cVwq6TOC/ssrVSc6uDhxhUt0T8uFmefHqrexV0cvq34NA1rrR
         rDt3Ro9VOCJCK7hqSMWxpPFYxE8O1DBzwx7prlU0VdcXvoMvWpulgXankSxRQGkhHt7J
         NQHYtfVeiPkH+R98txV4g3e1CPIb29G3wJ6kIUvV4tfBkALIEb6K0DA+KPl3V7J7jkSi
         +SOz8kKlGcwCaP/8EVrnIfEHuTQ0Z2Ye2KsPfUjYupv8fu+UFfJeA+6b4aLQN4fZ9Nm7
         yjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396021; x=1701000821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/X2Hjy9928PmrZRwLa11s4OXD1TRt3Se0ytUrNf/5I=;
        b=LqOHVsp7ILI3Q7hSswyCw0fY2E/KlkjgO7vWG3lSQk//cpQ+/cZpnwfRE3S9H/ja57
         8KczBj+YPhjGSNWVm8SOf+OcOUFHZOYfF6akoaFc5S7qUow6rKsarVxOGMEGiRsCxlS4
         caYHZwWJK5Yevemek6o3LRbiDA3qRXqQkehRe9FChC9IYov1jkqqZxYDJOQvW1JpaDw+
         +AWi2moZ+WakLTrry7tq48ZrWsVfPeCqcTd1cycmblBaLnHHmsjULH+b94XS74sWipTF
         bsTi5EG7VnjQpIrSEkRrOuc/17EYtSVGgTplA3kXyTmb3UGxT0uxDlv4tcWJcG19YXXq
         Gw/w==
X-Gm-Message-State: AOJu0YzpXd3URo6RPXQCFgj7HPNtafAs4sVlEUe0RUBo/AC9u0tciTEO
	NvKA3mcLDT0Nrp/kpEJmLkE=
X-Google-Smtp-Source: AGHT+IEC+qCUJSb2dlMTlIp+O5VqxOuaiB4XW9EKLcS1Q3WKML95NfX2MQgquZriA0Ipoy3Lmp3s7A==
X-Received: by 2002:a5d:464a:0:b0:32d:9a1b:5d79 with SMTP id j10-20020a5d464a000000b0032d9a1b5d79mr2516386wrs.33.1700396021152;
        Sun, 19 Nov 2023 04:13:41 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d49c8000000b0031984b370f2sm7931057wrs.47.2023.11.19.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:13:40 -0800 (PST)
Date: Sun, 19 Nov 2023 14:13:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [net-next 1/2] net: dsa: realtek: create realtek-common
Message-ID: <20231119121338.dskcbfwlo5txe245@skbuf>
References: <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117235140.1178-2-luizluca@gmail.com>
 <20231117235140.1178-2-luizluca@gmail.com>

On Fri, Nov 17, 2023 at 08:50:00PM -0300, Luiz Angelo Daros de Luca wrote:
> +struct realtek_priv *realtek_common_probe(struct device *dev,
> +		struct regmap_config rc, struct regmap_config rc_nolock)

nitpick: A more conventional way of aligning the arguments would be:

struct realtek_priv *
realtek_common_probe(struct device *dev, struct regmap_config rc,
		     struct regmap_config rc_nolock)

> +{
> +	const struct realtek_variant *var;
> +	struct realtek_priv *priv;
> +	struct device_node *np;
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
> +	np = dev->of_node;
> +
> +	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
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
> +	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> +	if (!priv->ds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	priv->ds->dev = dev;
> +	priv->ds->priv = priv;
> +
> +	return priv;
> +}
> +EXPORT_SYMBOL(realtek_common_probe);
> +
> +void realtek_common_remove(struct realtek_priv *priv)
> +{
> +	if (!priv)
> +		return;
> +
> +	dsa_unregister_switch(priv->ds);
> +	if (priv->user_mii_bus)
> +		of_node_put(priv->user_mii_bus->dev.of_node);
> +
> +	/* leave the device reset asserted */
> +	if (priv->reset)
> +		gpiod_set_value(priv->reset, 1);
> +}
> +EXPORT_SYMBOL(realtek_common_remove);

realtek_common_remove() should not undo things that realtek_common_probe()
never did.

