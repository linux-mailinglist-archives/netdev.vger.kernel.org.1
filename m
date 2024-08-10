Return-Path: <netdev+bounces-117425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548494DDC9
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDFC281A93
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644C168C3F;
	Sat, 10 Aug 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2zDCk826"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5681B810;
	Sat, 10 Aug 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723311854; cv=none; b=tyF232J8VxmQPhZkX5U0OZlDysSqetMtkV81ik9jLFVEX9scnrsut5Qdj4XXY4/C94rSUeseL0aeKxct4M5RTL9ZioN/BGV1EKjX4Eh6ESjcEcPb7mTo+h7McGmXaptj5PnutAZ6+pzmmR++KnuraUaGPDWdPE0mYQ87WUe8mgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723311854; c=relaxed/simple;
	bh=yxAsryxOArQAIt6pcgRoQ5BqqAfNMKr9c2igsDRFd0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+qcjK6GAUYyUTdyF0echCsUdJMZXXTSbrabh1swkkOw/9gubmcYh0EV9rhT6JjvVaEZ7Hu0pv90i4IvUYHcE7uDvuXfkJ2G4Hf2WI0Dt+tHL+3PYE5xppWV8ldEf4NbR1edDtFt9l6BLjmtH/K1cNpoD5cp25xGzV4rqgB2d/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2zDCk826; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6TJv0MO1TD/A8rw0DqiXOfv6PFXDaLY6RcDsOL6qfl8=; b=2zDCk826cy6Vj8QE6tjpucfRpt
	uqHLbrjmVMYgvTRD+piUxOvO6FNs4sWKrNv+WNCSyNPtagwQNbZ6I+/P0I/zcWL46BH/dmEgjOgOP
	tEquTIVjy8Xp/k0RpGBHnN7xQjol/g/87UwPClSo+TvWA+mzY8ADef6WnbvoIrmYnnLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scq8I-004SNu-2y; Sat, 10 Aug 2024 19:44:02 +0200
Date: Sat, 10 Aug 2024 19:44:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Message-ID: <301c5f90-0307-4c23-b867-6677d41dce47@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-4-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809233840.59953-4-Tristram.Ha@microchip.com>

> +static irqreturn_t ksz9477_handle_port_irq(struct ksz_device *dev, u8 port,
> +					   u8 *data)
> +{
> +	struct dsa_switch *ds = dev->ds;
> +	struct phy_device *phydev;
> +	int cnt = 0;
> +
> +	phydev = mdiobus_get_phy(ds->user_mii_bus, port);
> +	if (*data & PORT_PHY_INT) {
> +		/* Handle the interrupt if there is no PHY device or its
> +		 * interrupt is not registered yet.
> +		 */
> +		if (!phydev || phydev->interrupts != PHY_INTERRUPT_ENABLED) {
> +			u8 phy_status;
> +
> +			ksz_pread8(dev, port, REG_PORT_PHY_INT_STATUS,
> +				   &phy_status);
> +			if (phydev)
> +				phy_trigger_machine(phydev);
> +			++cnt;
> +			*data &= ~PORT_PHY_INT;
> +		}
> +	}

This looks like a layering violation. Why is this needed? An interrupt
controller generally has no idea what the individual interrupt is
about. It just calls into the interrupt core to get the handler
called, and then clears the interrupt. Why does that not work here?

What other DSA drivers do if they need to handle some of the
interrupts is just request the interrupt like any other driver:

https://elixir.bootlin.com/linux/v6.10.3/source/drivers/net/dsa/mv88e6xxx/pcs-639x.c#L95

> +irqreturn_t ksz9477_handle_irq(struct ksz_device *dev, u8 port, u8 *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	u32 data32;
> +
> +	if (port > 0)
> +		return ksz9477_handle_port_irq(dev, port - 1, data);
> +
> +	ksz_read32(dev, REG_SW_INT_STATUS__4, &data32);
> +	if (data32 & LUE_INT) {
> +		u8 lue;
> +
> +		ksz_read8(dev, REG_SW_LUE_INT_STATUS, &lue);
> +		ksz_write8(dev, REG_SW_LUE_INT_STATUS, lue);
> +		if (lue & LEARN_FAIL_INT)
> +			dev_info_ratelimited(dev->dev, "lue learn fail\n");
> +		if (lue & WRITE_FAIL_INT)
> +			dev_info_ratelimited(dev->dev, "lue write fail\n");
> +		ret = IRQ_HANDLED;
> +	}

https://elixir.bootlin.com/linux/v6.10.3/source/drivers/net/dsa/mv88e6xxx/global1_atu.c#L474

	Andrew

