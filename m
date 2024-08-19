Return-Path: <netdev+bounces-119902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E639576EF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1908283B20
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92D166F25;
	Mon, 19 Aug 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PHEQisVR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785B3F9CC;
	Mon, 19 Aug 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104665; cv=none; b=n9qtA8/l633CcSVxsV38vkPT8nyeo0HGD/Y3t7TuvfzrZxBWHqVBX4SQtK9wSuUZ5n7nwjY+OUPrq75GjgD+r8lelNkbKvFUdg+8DP1xYoHZ9hFsA/kR4p1C9qOA4UNzRoTXu3VvFhCirEeK6dmQgoyOy9Zq+TQWO48Xt0ppKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104665; c=relaxed/simple;
	bh=KYn8p+NSJrYcziwVjY5bQIV7LvNtaGg8Jd5Cp/ncoys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgjJXWGPCFRZDI3C6tJpRL1HPqNWOg4UZPG7RROddUkhwD86NgA3A9dikwwi0gZ7mtnnY6n/K6BJ378OP48rf/0baG+QjdEAWJY+fe5oCjqc5xX+KmeMAcegRDo9/P6wt47lmY49WryMsJiknINx0iperExSM4qUwoq67gncGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PHEQisVR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KWELWY8kP/e75VfClS8JEpAm5DcwZJmSJ36xnxJNPlM=; b=PHEQisVR6CN9sYcF7ahqoZMg+4
	GTK2kCo5TLmd772RH2HB9AHh2Gb1ad0CYo22wTG9w9cvOojgM+zL7RlGM/iZk51gfPxtL/h3UZfNu
	zQ6kkPv8jYSyty5BJguoTXWOBLXSnsva9bNkU5VSYI6CSrPnUnVosVyPqcIkNo7Ey7gA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgANS-0059lF-KD; Mon, 19 Aug 2024 23:57:26 +0200
Date: Mon, 19 Aug 2024 23:57:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] phy: dp83tg720: Add statistics support
Message-ID: <654c3a17-fea7-4e28-be36-5229eb106737@lunn.ch>
References: <20240819113625.2072283-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819113625.2072283-1-o.rempel@pengutronix.de>

> +static const struct dp83tg720_hw_stat dp83tg720_hw_stats[] = {
> +	{
> +		.string = "esd_event_count",
> +		.cache_index1 = DP83TG720_CACHE_A2D_REG_66,
> +		.cache_index2 = DP83TG720_CACHE_EMPTY,
> +		.mask1 = DP83TG720S_ESD_EVENT_COUNT_MASK,
> +		.shift1 = 9,
> +		.flags = DP83TG720_FLAG_COUNTER,
> +	},
> +	{
> +		.string = "link_training_time",
> +		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_1,
> +		.cache_index2 = DP83TG720_CACHE_EMPTY,
> +		.mask1 = DP83TG720S_LINK_TRAINING_TIME_MASK,
> +	},
> +	{
> +		.string = "remote_receiver_time",
> +		.cache_index1 = DP83TG720_CACHE_LINK_QUAL_2,
> +		.cache_index2 = DP83TG720_CACHE_EMPTY,
> +		.mask1 = DP83TG720S_REMOTE_RECEIVER_TIME_MASK,
> +		.shift1 = 8,
> +	},

If i remember correctly, some of these are part of an Open Alliance
standard. Ideally, we want all PHYs which follow the standard to use
the same names of these statistics.

Maybe add to the open alliance header something like

#define TC42_ESD_EVENT_COUNT "esd_event_count"

Given that the Open Alliance failed to define the registers, i don't
think we can do much more than that?

> +static void dp83tg720_get_strings(struct phy_device *phydev, u8 *data)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(dp83tg720_hw_stats); i++) {
> +		strscpy(&data[j * ETH_GSTRING_LEN],
> +			dp83tg720_hw_stats[i].string, ETH_GSTRING_LEN);

ethtool_puts()

	Andrew

---
pw-bot: cr

