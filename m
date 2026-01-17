Return-Path: <netdev+bounces-250750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510BD391AA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367D0300A844
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764432F1FDC;
	Sat, 17 Jan 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofM13A6q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA042E8B87
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768692575; cv=none; b=tJJGChI45xcMb67ZZjov11watx8pO8FGBAtz3QLxzv6SmwfJLKqkUx7QeFNvp4QYi/CQ7P5gJ8NO5BSAUdovnHIH/UCmdo1fBOrYoSEtC5jsovgbD6n++mfsdOd9rcCQvMcf05BlZ744Kywbi8X4tZlN3Hl9y63wlJq9jYJvYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768692575; c=relaxed/simple;
	bh=oJ8ubN45hryyvktcyVN+ZJXq9q0JbLOMpdq907VqWgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6cEvhlKtn3RBZE9pw0aSwwmP4zxfaUaoMf1WUhsarmW8M9Li5H4JTgVqoeWfQwzZ132S5m3mwdBXBujMjcoDdG9ZK4UjNaX9e25N19jTgmjrS5jQ544AHbRbXJJE4Rb1pstasoSJyd8HSYd8x4bJnzKPKaUJ3vg11qcA/5lrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofM13A6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D4C4CEF7;
	Sat, 17 Jan 2026 23:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768692574;
	bh=oJ8ubN45hryyvktcyVN+ZJXq9q0JbLOMpdq907VqWgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofM13A6qfNA1IPIEvOHuW4oTKqvAqiybQIgPs6ymPOSWSXUXeCZDxqf0sC0ljhKwV
	 WqH2mlFIz6OgqFbHXgQi3+McFmmYg30iu9kjTFg32ozWSv4IBJpik07iB/wjMMhaZs
	 2YJ59KPgcq2KIUCQaQaQH91LzU1ilR9cBmE1wTRkQW4bMNjMxdA5MNSgDqQMKhlr31
	 8+B4vBhc33p0agfHxVtkaIw/oODNZtIoKW/k+FYlbBYmCsOxqN8CzV5Yf8lnijstxK
	 JJvZwf1XibMcaFKTMvIM/9Jyvyvt5+mujEfNZ2UKu7FIRKbozLTL5vcjiMTkGFkGbP
	 KCDjvV3xGdgGw==
From: Jakub Kicinski <kuba@kernel.org>
To: u.kleine-koenig@baylibre.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	pabeni@redhat.com
Subject: Re: [RESEND,net-next] mdio: Make use of bus callbacks
Date: Sat, 17 Jan 2026 15:29:32 -0800
Message-ID: <20260117232932.1005051-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>
References: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
mdio: Make use of bus callbacks

This patch moves MDIO device probe/remove/shutdown callbacks from the
device_driver level to the bus_type level, with the goal of eventually
removing device_driver callbacks.

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index afdf1ad6c0e6..dea67470a7bf 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c

[ ... ]

> @@ -1004,11 +1004,67 @@ static const struct attribute_group *mdio_bus_dev_groups[] = {
>  	NULL,
>  };
>
> +/**
> + * mdio_bus_probe - probe an MDIO device
> + * @dev: device to probe
> + *
> + * Description: Take care of setting up the mdio_device structure
> + * and calling the driver to probe the device.
> + *
> + * Return: Zero if successful, negative error code on failure
> + */
> +static int mdio_bus_probe(struct device *dev)
> +{
> +	struct mdio_device *mdiodev = to_mdio_device(dev);
> +	struct device_driver *drv = dev->driver;
> +	struct mdio_driver *mdiodrv = to_mdio_driver(drv);

[ ... ]

>  const struct bus_type mdio_bus_type = {
>  	.name		= "mdio_bus",
>  	.dev_groups	= mdio_bus_dev_groups,
>  	.match		= mdio_bus_match,
>  	.uevent		= mdio_uevent,
> +	.probe		= mdio_bus_probe,
> +	.remove		= mdio_bus_remove,
> +	.shutdown	= mdio_bus_shutdown,
>  };

Does adding these bus-level callbacks break PHY device probing?

PHY drivers register via phy_driver_register() which sets:

    new_driver->mdiodrv.driver.probe = phy_probe;
    new_driver->mdiodrv.driver.remove = phy_remove;

The driver core in call_driver_probe() prioritizes bus callbacks over driver
callbacks:

    if (dev->bus->probe)
        ret = dev->bus->probe(dev);
    else if (drv->probe)
        ret = drv->probe(dev);

With mdio_bus_type.probe now set, phy_probe() will never be called for PHY
devices. The same applies to phy_remove() being bypassed by mdio_bus_remove().

phy_probe() performs essential initialization including setting phydev->drv,
reading PHY abilities, configuring EEE, and setting up the state machine.
Without this, PHY devices would fail to initialize properly.

Was there a plan to update phy_driver_register() as part of this change, or
is a separate patch needed to handle PHY drivers?
-- 
pw-bot: cr

