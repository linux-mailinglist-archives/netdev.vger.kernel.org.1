Return-Path: <netdev+bounces-230586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE5BEBB39
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DF16E8499
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEA354AFE;
	Fri, 17 Oct 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="doQH97vY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58D354AC0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733567; cv=none; b=kefF4a5m2o1oIlPSUxmEmMeIaQm1fSTUQW/EKDiZbSh69PH4WaRAgFs/THQ3Ps4ZSKjDRAaNHdUIuObAqHYCdPj+NOYA5tX716RM5u8eGAwamwELnvObyPaXhnAjxAoDTZ0Wh006bjeDf2iinecRNTtXS0TgkHTMU8YqadBHTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733567; c=relaxed/simple;
	bh=snxdAyhMD6d3LQf+3vfEIPpeIi/u+NPFGmsOzcMtWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI68I8yMN5OxDpZ8krgk0Y1gZxF+2R7JWllTYRdV75DeeABjdY0prB7kzEJcJRulsaWI2tUwype4SM72+uNWeHIwKj85SzZ7ZzvSP2HNQLH1CRcIjVuwGqGI95US1dB1Q0r93hD0NdwLesu7jYH6DXS1x4V9DzK8Mhg5M7C2kkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=doQH97vY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g7QJB+xINYIsQBlH4P8xjK72iiBxzKUb4jGbIL9WGKM=; b=doQH97vYrTFMTqXGZCyGlT3B+j
	xzprKs3OzJqCJDpWHFWnlgBKEGS68a4eS1kt+GYWAbNo3no3RsoUUhTSRLtP6x48K5fW80b7g1lY8
	NnCXh9xEQG9bvgEnW35kLn2sy7zNhAbJgIOR6P29SktDtgvO+s3IdP39t32C9EwchR7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9rE8-00BKFK-O9; Fri, 17 Oct 2025 22:39:04 +0200
Date: Fri, 17 Oct 2025 22:39:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: stmmac: mdio: use phy_find_first to
 simplify stmmac_mdio_register
Message-ID: <4a2d59c0-be25-4b83-b732-138d04f62292@lunn.ch>
References: <2a4a4138-fe61-48c7-8907-6414f0b471e7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4a4138-fe61-48c7-8907-6414f0b471e7@gmail.com>

> -	int addr, found, max_addr;
> +	struct phy_device *phydev;
> +	int addr, max_addr;
>  
>  	if (!mdio_bus_data)
>  		return 0;
> @@ -668,41 +669,31 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	if (priv->plat->phy_node || mdio_node)
>  		goto bus_register_done;
>  
> -	found = 0;
> -	for (addr = 0; addr < max_addr; addr++) {

With this loop gone...

> +	phydev = phy_find_first(new_bus);
> +	if (!phydev || phydev->mdio.addr >= max_addr) {
>  		dev_warn(dev, "No PHY found\n");
>  		err = -ENODEV;
>  		goto no_phy_found;
>  	}
>  
> +	/*
> +	 * If an IRQ was provided to be assigned after
> +	 * the bus probe, do it here.
> +	 */
> +	if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
> +		new_bus->irq[addr] = mdio_bus_data->probed_phy_irq;

... what is setting addr to a value?

	Andrew

