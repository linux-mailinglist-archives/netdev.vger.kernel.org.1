Return-Path: <netdev+bounces-33971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D920B7A0FF4
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 23:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED531C208C8
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683926E3A;
	Thu, 14 Sep 2023 21:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C09266AB
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:38:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D22706
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iu2r0d13zEDJ6u0P7ynhsVWgjjqzEUci6VFo8LlFak8=; b=T7jS97a+Tgf8kDeVhxkHYQOrrF
	jL46Z08C9ggufn1txRrPzhPMzC3wK2EbZ5O4MmhdwdoxfrdDGIxY8ODPBFCnRmRkgQ43+MmfFFeYA
	v6bY9Db/sWkm1jnZM1N/nVzoISIbeaZNRam11zqtEbQxO4otRQrjPon+JYb7amEe9uu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgu2i-006UCW-Hv; Thu, 14 Sep 2023 23:38:32 +0200
Date: Thu, 14 Sep 2023 23:38:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
 <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>

> I have the impression that the hardware reset logic is not correctly
> implemented.
> 
> If I change it like this, I don't get the "Timeout waiting for EEPROM
> done" error:
> 
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -7076,13 +7076,16 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
> 
>         chip->info = compat_info;
> 
> -       chip->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +       chip->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>         if (IS_ERR(chip->reset)) {
>                 err = PTR_ERR(chip->reset);
>                 goto out;
>         }
> -       if (chip->reset)
> +       if (chip->reset) {
>                 usleep_range(10000, 20000);
> +               gpiod_set_value(chip->reset, 0);
> +               usleep_range(10000, 20000);
> +       }
> 
> In the devicetree I pass:
> reset-gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;

Unfortunately, none of my boards appear to have the reset pin wired to
a GPIO.

The 6352 data sheet documents the reset pin is active low. So i can
understand using GPIO_ACTIVE_LOW.

In probe, we want to ensure the switch is taken out of reset, if the
bootloader etc has left it in reset. We don't actually perform a reset
here. That is done later. So we want the pin to have a high value. I
know gpiod_set_value() takes into account if the DT node has
GPIO_ACTIVE_LOW. So setting a value of 0 disables it, which means it
goes high. This is what we want. But the intention of the code is that
the actual devm_gpiod_get_optional() should set the GPIO to output a
high. But does devm_gpiod_get_optional() do the same mapping as
gpiod_set_value()? gpiod_direction_output() documents says:

 * Set the direction of the passed GPIO to output, such as gpiod_set_value() can
 * be called safely on it. The initial value of the output must be specified
 * as the logical value of the GPIO, i.e. taking its ACTIVE_LOW status into
 * account.

I don't know how to interpret this.

Is the first change on its own sufficient to make it work? As i said,
we don't aim to reset it here, just ensure it is out of reset. So
ideally all we need is devm_gpiod_get_optional() followed by a pause
just in case it was held in reset, and it will ignore MDIO requests
for a while until it sorts itself out.

Alfred: How do you have the reset GPIO configured in your DT?
GPIO_ACTIVE_LOW?

    Andrew

