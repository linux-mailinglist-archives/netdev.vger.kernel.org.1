Return-Path: <netdev+bounces-57985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8361F814AE1
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60491C22C9A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985371E535;
	Fri, 15 Dec 2023 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xjYXEIDP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02386364CA;
	Fri, 15 Dec 2023 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c9dYSwI/tHowWVWZHgoLgxKGUYu53C7j7Gbs0bydLbU=; b=xjYXEIDP4kxhMTyjPx3OaJH5yg
	3Kju1IUXXUZGwnM89zY6s4iAf9t3Lgdox1lvAfG0LnjVxRH7mkbjdla/us0CVyGykUiVmjg6Q1Ghh
	KHJul0eOkQ2b1AlMbHrYDJnOkiT6QjgqSHYQRp7oqDgkln+iioeUhYi3oeh9OV7i1nTQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE9Q7-00327e-Fe; Fri, 15 Dec 2023 15:44:07 +0100
Date: Fri, 15 Dec 2023 15:44:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: marvell10g: Add LED support for
 88X3310
Message-ID: <9e2305e5-6b04-4032-8a71-dd24db04ddab@lunn.ch>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-4-tobias@waldekranz.com>

> +static int mv3310_led_funcs_from_flags(struct mv3310_led *led,
> +				       unsigned long flags,
> +				       enum mv3310_led_func *solid,
> +				       enum mv3310_led_func *blink)
> +{
> +	unsigned long activity, duplex, link;
> +
> +	if (flags & ~(BIT(TRIGGER_NETDEV_LINK) |
> +		      BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +		      BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +		      BIT(TRIGGER_NETDEV_TX) |
> +		      BIT(TRIGGER_NETDEV_RX)))
> +		return -EINVAL;

This probably should be -EOPNOTSUPP. The trigger will then do the
blinking in software.

> +
> +	link = flags & BIT(TRIGGER_NETDEV_LINK);
> +
> +	duplex = flags & (BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +			  BIT(TRIGGER_NETDEV_FULL_DUPLEX));
> +
> +	activity = flags & (BIT(TRIGGER_NETDEV_TX) |
> +			    BIT(TRIGGER_NETDEV_RX));
> +
> +	if (link && duplex)
> +		return -EINVAL;

It is an odd combination, but again, if the hardware cannot do it,
return -EOPNOTSUPP and leave it to the software.

       Andrew

