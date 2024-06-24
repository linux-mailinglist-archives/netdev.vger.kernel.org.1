Return-Path: <netdev+bounces-105973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50779913F9D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 03:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768A01C20DBE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245FF1396;
	Mon, 24 Jun 2024 01:01:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FD645;
	Mon, 24 Jun 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719190879; cv=none; b=tok/R0P6/JcMv0quTI36RN+dL2OvJlz8qvejr+jDRPzlM0+4a5L9fO2cF46YIDACiAoEfIfgFvI0PeKUX/EEhX0CA9Q5MxG4TBuRIcpEccYBddXHEyBR6GLqYpWlUbHX36WssNPx+gfMqqJOL8+kdGTfpSbbhbFRjeY0uIjCPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719190879; c=relaxed/simple;
	bh=NZ4wCvC/W5FMr7YNpKy6YrXE3KgBt1IJ7qMewUbc0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd8Vc7duETDyz4ShCgSxmCKwz9Oz533Xbm51C03YmOERIPycqdaLaP+e+xB/Vz+zNe8h46d4dBxUfY+qs2mtX7MARyeLAb1I5ssAXn/7s1whZTE/s1f9pFkfJIxwGnIMvxBD2V3uLzK2GTFVfIqhUNQvEarqHEc0eRp59SglOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sLY4u-000000001bx-1r1U;
	Mon, 24 Jun 2024 01:01:04 +0000
Date: Mon, 24 Jun 2024 02:01:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH] net: phy: realtek: Add support for PHY LEDs on
 RTL8211F
Message-ID: <ZnjFTSmF3MGX7OuY@makrotopia.org>
References: <20240623234211.122475-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623234211.122475-1-marex@denx.de>

On Mon, Jun 24, 2024 at 01:40:33AM +0200, Marek Vasut wrote:
> Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
> indicate link status and activity. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

> [...]
> +static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +					unsigned long rules)
> +{
> +	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
> +				   BIT(TRIGGER_NETDEV_LINK_100) |
> +				   BIT(TRIGGER_NETDEV_LINK_1000) |
> +				   BIT(TRIGGER_NETDEV_RX) |
> +				   BIT(TRIGGER_NETDEV_TX);
> +
> +	/* The RTL8211F PHY supports these LED settings on up to three LEDs:
> +	 * - Link: Configurable subset of 10/100/1000 link rates
> +	 * - Active: Blink on activity, RX or TX is not differentiated
> +	 * The Active option has two modes, A and B:
> +	 * - A: Link and Active indication at configurable, but matching,
> +	 *      subset of 10/100/1000 link rates
> +	 * - B: Link indication at configurable subset of 10/100/1000 link
> +	 *      rates and Active indication always at all three 10+100+1000
> +	 *      link rates.
> +	 * This code currently uses mode B only.
> +	 */
> +
> +	if (index >= RTL8211F_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* Filter out any other unsupported triggers. */
> +	if (rules & ~mask)
> +		return -EOPNOTSUPP;

It looks like it is not possible to let the hardware indicate only either
RX or TX, it will always have to go together.

Please express this in this function accordingly, so fallback to
software-driven trigger works as expected.

Example:
if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
	return -EOPNOTSUPP;

> +
> +	return 0;
> +}

