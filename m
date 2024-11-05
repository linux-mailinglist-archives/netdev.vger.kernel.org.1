Return-Path: <netdev+bounces-142070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376409BD461
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A565AB22B84
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B01E7C15;
	Tue,  5 Nov 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LkvctTHk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883591E767B;
	Tue,  5 Nov 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830547; cv=none; b=kp+gakBlva2PXPBDj1dJBaDWjV3vyTJUyuGW5uwJLkMt3ANCKqW9K62juoG4R9roRoqrPv640DpSvSNfMA1lYOFPXhWA15asJeubEPGBA8go4Em+qYecQTDB6iBf6muWMB+zVWKJ9CJNDml0Zeg8wUX2Mis2E0Pso9y0OKnt3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830547; c=relaxed/simple;
	bh=BBjsb+hg8t8mwlkHWp3i3xePfqIavB+Df6w6mwWrwY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUdoNUl+BnGioAsqbpKhS+knmf1J8TgX2Q9chvW6DnN8vbJi3QrLW9UeZzdsCddeMYnf3R8d6J6BocQScIilC1MSLXLC7D0foAypAfwSfk9bIp/Lg85Z3UW95hzu29xIiX3tvZZSFlRMM3Q2/jONcBuW2ymu1A7ax+x6WhKlGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LkvctTHk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uqmym68O0/QCfZxx9k0c637XLqVZRZcVImmW75Z3t+Q=; b=LkvctTHk2IviG4ktAPZXRLQWAr
	xZu/R3iqT3E/YzV7CSGbPc5X8ub1kAI9NQR33xXa2gAo+HBSxQNMG6XnmWVFmUZu58rV+hp9hYZof
	fkN2KAm2cpK2oz8BozxWN8b7nSgrGXHITv/zXX00PL0BTAA1lRFD3KMD+sMUmiisB+lc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8O5Q-00CElW-0I; Tue, 05 Nov 2024 19:15:28 +0100
Date: Tue, 5 Nov 2024 19:15:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH net-next v3 3/6] net: dsa: microchip: Refactor MDIO
 handling for side MDIO access
Message-ID: <790cbc97-6a08-495c-9afd-b8a49e546241@lunn.ch>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
 <20241105090944.671379-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105090944.671379-4-o.rempel@pengutronix.de>

On Tue, Nov 05, 2024 at 10:09:41AM +0100, Oleksij Rempel wrote:
> Add support for accessing PHYs via a side MDIO interface in LAN937x
> switches. The existing code already supports accessing PHYs via main
> management interfaces, which can be SPI, I2C, or MDIO, depending on the
> chip variant. This patch enables using a side MDIO bus, where SPI is
> used for the main switch configuration and MDIO for managing the
> integrated PHYs. On LAN937x, this is optional, allowing them to operate
> in both configurations: SPI only, or SPI + MDIO. Typically, the SPI
> interface is used for switch configuration, while MDIO handles PHY
> management.
> 
> Additionally, update interrupt controller code to support non-linear
> port to PHY address mapping, enabling correct interrupt handling for
> configurations where PHY addresses do not directly correspond to port
> indexes. This change ensures that the interrupt mechanism properly
> aligns with the new, flexible PHY address mappings introduced by side
> MDIO support.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

