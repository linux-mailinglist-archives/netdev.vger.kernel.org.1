Return-Path: <netdev+bounces-34645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A07A5096
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855E41C21846
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33F266C7;
	Mon, 18 Sep 2023 17:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD26266C6;
	Mon, 18 Sep 2023 17:07:43 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698FE3;
	Mon, 18 Sep 2023 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4dwqbabpRXtAFfSri7LBE3DGA0CnqUUPOENxivi1UzE=; b=lzrXogp/kL8mBy8K9gKe6RuiQk
	2joE3ilZNPoITCwSoJQJn6JMlDtBYr8oVbiH9gFaWl7rIExh6fiqpmpD17Y1b/vrycqL3J20/Cebh
	AfHqNIDExteB9DzPDiZ7+czGCHJ6WWBa9Hte8Uepc1WOVbDdJGXAy7nIgGfF6OFaLE1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiGwi-006oFv-Mn; Mon, 18 Sep 2023 18:18:00 +0200
Date: Mon, 18 Sep 2023 18:18:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jay Monkman <jtm@lopingdog.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH 3/4] net: phy: Add GPIO and DT support to NCN26000
Message-ID: <4242c63c-eec2-4168-ae59-b4fac8cdea3e@lunn.ch>
References: <ZQf1Nx+2amtUZulX@lopingdog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQf1Nx+2amtUZulX@lopingdog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 01:59:03AM -0500, Jay Monkman wrote:
> 
> This adds GPIO support and devicetree configuration for
> the NCN26000 PHY.

Please Cc: the GPIO maintainers. They have specialist knowledge that
netdev reviews like me don't have. You probably want to separate this
out into a patch of its own, since you don't want to be spamming GPIO
people with a MAC driver etc.

> +// clause 45 vendor specific registers
> +#define NCN26000_REG_PHYCFG1_MMD	MDIO_MMD_VEND2

Please use MDIO_MMD_VEND2 directly, so it is clear you are in vendor
space.

> +static int ncn26000_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct ncn26000_priv *priv = gpiochip_get_data(gc);
> +
> +	if (offset > 2)
> +		return -ENODEV;

Can that happen? I would expect the GPIO core to perform this
validation?

> +
> +	if (priv->gpiomask & (1 << offset))
> +		return 0;
> +
> +	return -EBUSY;

Is this function even needed? All it seems to do is validation. No
resources are actually reserved.

> +static void ncn26000_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct ncn26000_priv *priv = gpiochip_get_data(gc);
> +	u32 dio_reg;
> +
> +	dio_reg = phy_read(priv->phydev, NCN26000_REG_DIO_CONFIG);
> +
> +	switch (offset) {
> +	case 0:
> +		if (!val == !(priv->diocfg & NCN26000_DIO_CFG_VAL0))
> +			dio_reg |= NCN26000_DIO_CFG_VAL0;
> +		else
> +			dio_reg &= ~NCN26000_DIO_CFG_VAL0;
> +		break;
> +
> +	case 1:
> +		if (!val == !(priv->diocfg & NCN26000_DIO_CFG_VAL1))
> +			dio_reg |= NCN26000_DIO_CFG_VAL1;
> +		else
> +			dio_reg &= ~NCN26000_DIO_CFG_VAL1;
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "invalid GPIO offset: %d\n", offset);
> +		return;
> +	}
> +
> +	phy_write(priv->phydev, NCN26000_REG_DIO_CONFIG, dio_reg);

You are doing a read/modify/write here. How does locking work?

> +static int ncn26000_gpio_get_dir(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}

So they are all GPO? No GPI or GPIO?

> +static int ncn26000_gpio_setup(struct ncn26000_priv *priv)
> +{
> +	struct gpio_chip *gc = &priv->gpio_chip;
> +
> +	gc->request            = ncn26000_gpio_request;
> +	gc->get_direction      = ncn26000_gpio_get_dir;
> +	gc->direction_output   = ncn26000_gpio_dir_out;
> +	gc->set                = ncn26000_gpio_set;
> +	gc->label              = "ncn26000-gpio";
> +	gc->base               = -1;
> +	gc->ngpio              = 2;
> +	gc->parent             = priv->dev;
> +	gc->owner              = THIS_MODULE;
> +
> +	return devm_gpiochip_add_data(priv->dev, gc, priv);
> +}

Am i right in saying that the rest of this patch has nothing to do
with GPIOs? Please split it up into multiple patches.

     Andrew

