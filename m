Return-Path: <netdev+bounces-221797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3DB51E1D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05D31885DC4
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD95265620;
	Wed, 10 Sep 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2osiUM5H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E74219A86;
	Wed, 10 Sep 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522787; cv=none; b=VzkbX0GMIL7jRUaQQRYWi+uuM2XwOU+1wagMlnUQ1ZJhfLFko6kbxzLiqzVDWqhm6ouhC1SJGglqkrMvC1pU6k5C3ZjVbn72xG3rj8yedqQnXxwPqK6qCNc1ydq1KP/4Z53/G4kjqAKgAcv9gAMHox4aHg44Il8+IAKc2i4grJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522787; c=relaxed/simple;
	bh=LHVi22hmdKEYriv8S93DuMS2bCKCirlgpOUbUHzNiAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx3O1qy+qIuHMvu42i8SuiDBvh0POlJ+jDErXBFgRKhVCdXfup2/x4z9wGeFqdnU/KyjHC/zITCT5zsEZhcQ22oyE82QF/mPf6pJx5n6O6oL0YvWIW5k9SQ5eQgKGpWhk+fGOHcqO+qh+mQzCXadVLj87hmxgPJ7FoXQvc4oy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2osiUM5H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HoO6vkDGS7CPDCnJ0Lsh5f0VN7QxwwVtfLxnW3o78pw=; b=2osiUM5H9hRhyjYCh/8vwaG8NV
	KlgzREfAFiIJMtCrrcw5ipDeTRxm4u2j5LdwxuzheT5iKj9bOIqdMKIqO962Jd0v7vB06lpCaf9gw
	IB1sh1wn6ZBkxTFqX6LNvmoJFgc2XV70cz0jZ23NnVWIypvX0mx4L393XFQq8sjnEE3A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwNxX-007yW5-1Q; Wed, 10 Sep 2025 18:46:15 +0200
Date: Wed, 10 Sep 2025 18:46:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
Message-ID: <14114502-f087-4d3b-a91e-cff0dfe59045@lunn.ch>
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
 <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>

> Support the KSZ8463's strap configuration that enforces SPI as
> communication bus, since it is the only bus supported by the driver.

So this is the key sentence for this patchset, which should of been in
patch 0/X. You have a chicken/egg problem. You cannot talk to the
switch to put it into SPI mode because you cannot talk to the switch
using SPI.

The current patch descriptions, and the patches themselves don't make
this clear. They just vaguely mention configuration via strapping.

> +static int ksz_configure_strap(struct ksz_device *dev)

Please make it clear this function straps the switch for SPI. If
somebody does add support for I2C, they need to understand that...

> +{
> +	struct pinctrl_state *state = NULL;
> +	struct pinctrl *pinctrl;
> +	int ret;
> +
> +	if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {

I would not hide this here. Please move this if into
ksz_switch_register(). I also think this function should have the
ksz8463 prefix, since how you strap other devices might differ. So
ksz8463_configure_straps_spi() ?

> +		struct gpio_desc *rxd0;
> +		struct gpio_desc *rxd1;
> +
> +		rxd0 = devm_gpiod_get_index_optional(dev->dev, "strap", 0, GPIOD_OUT_LOW);
> +		if (IS_ERR(rxd0))
> +			return PTR_ERR(rxd0);
> +
> +		rxd1 = devm_gpiod_get_index_optional(dev->dev, "strap", 1, GPIOD_OUT_HIGH);
> +		if (IS_ERR(rxd1))
> +			return PTR_ERR(rxd1);
> +
> +		/* If at least one strap definition is missing we don't do anything */
> +		if (!rxd0 || !rxd1)
> +			return 0;

I would say, if you have one, not two, the DT blob is broken, and you
should return -EINVAL.

> +
> +		pinctrl = devm_pinctrl_get(dev->dev);
> +		if (IS_ERR(pinctrl))
> +			return PTR_ERR(pinctrl);
> +
> +		state = pinctrl_lookup_state(pinctrl, "reset");
> +		if (IS_ERR(state))
> +			return PTR_ERR(state);
> +
> +		ret = pinctrl_select_state(pinctrl, state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int ksz_switch_register(struct ksz_device *dev)
>  {
>  	const struct ksz_chip_data *info;
> @@ -5353,10 +5392,18 @@ int ksz_switch_register(struct ksz_device *dev)
>  		return PTR_ERR(dev->reset_gpio);
>  
>  	if (dev->reset_gpio) {
> +		ret = ksz_configure_strap(dev);
> +		if (ret)
> +			return ret;
> +
>  		gpiod_set_value_cansleep(dev->reset_gpio, 1);
>  		usleep_range(10000, 12000);
>  		gpiod_set_value_cansleep(dev->reset_gpio, 0);
>  		msleep(100);
> +
> +		ret = pinctrl_select_default_state(dev->dev);
> +		if (ret)
> +			return ret;

This does not look symmetrical. Maybe put the
pinctrl_select_default_state() inside a function called
ksz8463_release_straps_spi()?

	Andrew

