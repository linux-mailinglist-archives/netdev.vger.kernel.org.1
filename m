Return-Path: <netdev+bounces-233740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2FC17DE3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7354E5020D8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99532D4807;
	Wed, 29 Oct 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0c1ezp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D72773CB;
	Wed, 29 Oct 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700961; cv=none; b=FEgg9aOUe6sLwCubBizO3n+/iwZUykOVPNyoqeIoJh9veN5qu5K7jiK7QnytBQcsUTbW7A09dBsRr2pxcUmv/kcNDQeeKA4JiYUzoQAQQcea5a5dlBpL3ZWJueV5468UxGYE1O+HfQFrCClrmvEE/40w9al97AR/SfNzEczWGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700961; c=relaxed/simple;
	bh=E6wadRJDZxuXmwKy5dpUgXEbJCuW/KtG5CMnRrBEzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKsRLKMIzd39lhi3OyPWKLcFG4+beiIkerzIaR8p20bDx8PGTxQjCY2pcDXYZUMafs2oYcXUe4M3PONgf1i804HQFGSl0xutZuvTfIXQw1L7ovWe8ML2X5Nk95Be2MxSnzo8J7nuyug4YEs0N8dmGs6xehuv6KIWLpcolGGbcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0c1ezp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD8BC4CEE7;
	Wed, 29 Oct 2025 01:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700961;
	bh=E6wadRJDZxuXmwKy5dpUgXEbJCuW/KtG5CMnRrBEzUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C0c1ezp56HH24DLoxCgh3igo1oTdkxA7sDy10eheZm5wYvftOvkSZUTy0DvVpr3ft
	 s06/Ok/lRrZBtWYeNOsvqoYuW9F9YlJiaYdz1Qq194+tpmx4VOawddyopTVn6h8jdl
	 hm39M9hZHWlgx0gqtwdVa6YmXX3/3JMS7Eukz+62+DvBoMFhe+0ale1uSQqmcLqCz3
	 s1D51VXDofQSZRFFQb8d9Urx4Dx79iD9ld9KbijgGSTALurCgJJaM//Ra6Hd79t6I5
	 At78lzGNCJ1Mh33LJcUtfPfPu22v/O19BpcinWh4buRT4jOwOkTPnMTkklvy/KrMR/
	 uRFgmssjncU2g==
Date: Tue, 28 Oct 2025 18:22:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/4] net: mdio: common handling of phy reset
 properties
Message-ID: <20251028182240.17da8177@kernel.org>
In-Reply-To: <58dd6c6e6684e2dc8e7a97e9ebc086a1cb273735.1761124022.git.buday.csaba@prolan.hu>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
	<58dd6c6e6684e2dc8e7a97e9ebc086a1cb273735.1761124022.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Let me give you some nit picky comments, maybe v5 will have more luck
attracting area experts :(

On Wed, 22 Oct 2025 11:08:50 +0200 Buday Csaba wrote:
> Reset properties of an `mdio_device` are initialized in multiple
> source files and multiple functions:
>   - `reset_assert_delay` and `reset_deassert_delay` are in
>     fwnode_mdio.c
>   - `reset_gpio` and `reset_ctrl` are in mdio_bus.c, but handled by
>     different functions
> 
> This patch unifies the handling of all these properties into two
> functions.

Use imperative mood. "This patch unifies" -> "Unify"
Please check all commits msgs for this (eg glancing at patch 2
"Changed" -> "Change")

> mdiobus_register_gpiod() and mdiobus_register_reset() are removed,
> while mdio_device_register_reset() and mdio_device_unregister_reset()
> are introduced instead.
> These functions handle both reset-controllers and reset-gpios, and
> also read the corresponding properties from the device tree.
> These changes should make tracking the reset properties easier.

> +	/* reset-gpio, bring up deasserted */
> +	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev, "reset",
> +						 GPIOD_OUT_LOW);
> +

no empty lines between call and its error check pls

> +	if (IS_ERR(mdiodev->reset_gpio))
> +		return PTR_ERR(mdiodev->reset_gpio);
> +
> +	if (mdiodev->reset_gpio)
> +		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
> +
> +	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	mdiodev->reset_ctrl = reset;
> +
> +	/* Assert the reset signal */
> +	mdio_device_reset(mdiodev, 1);
> +
> +	return 0;
> +}

