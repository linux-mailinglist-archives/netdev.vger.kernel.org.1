Return-Path: <netdev+bounces-142071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40149BD46E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD41B21A52
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8277A1E7664;
	Tue,  5 Nov 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EatBd6Ny"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66013D51E;
	Tue,  5 Nov 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830873; cv=none; b=OU8ZYDxLhinmV0TU4/ybiECQgUAOIC0tSyospdMZB8l7qtU4GLRMUp/MzKr83F+uaxla9yCxXJFRqeDMte7f5/n6yqRACoBDOoA+O4tN5sdPOE+ACLpQG60Yjffm2JY3esVBVq9AzYF9/dr4VWENxHmBu5apJ9oEoHBQvpwG230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830873; c=relaxed/simple;
	bh=PkRypvk37TfUhZojPbI0nNHyosApfuumWE+3MNe36Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM4zIks8GAGp77mpW3Xl80Zzouz5kKEtlyvxwq+hCfQozop6j4nvzZXUesy5V4YsmJtNLrXq4eKWH2I1OzmqoZEUkOcg04rCCzdI9o8J5HTB31vDvnoRG4C7AMPkhJ9xBl4fXUbaVqrldPClfnZGfMTnKaohIBaSnvWKx4LG60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EatBd6Ny; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QxVnYUMdQ9CRpzvJqrj2mvfqMm8FPqPdD/GeqmxgDOY=; b=EatBd6NyxsUO3/2V4PVTkblfG9
	67yXp7Y2dUgg0df5VUb5K7Iad9ASBFSu2LATosEa7QEoGO/BfuFUaGX2csK7qeoT/f5Tk4ftjTErU
	SPczmtI66wnHeYWTXJkqQ09WbjjIWvEmV5LiTPPmuLE/xjiwAGxR2eqWyhR8Wj4mIxcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8OAn-00CEoH-KG; Tue, 05 Nov 2024 19:21:01 +0100
Date: Tue, 5 Nov 2024 19:21:01 +0100
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
Subject: Re: [PATCH net-next v3 5/6] net: dsa: microchip: add support for
 side MDIO interface in LAN937x
Message-ID: <682c0723-f9f6-466c-a33b-b364379403a0@lunn.ch>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
 <20241105090944.671379-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105090944.671379-6-o.rempel@pengutronix.de>

On Tue, Nov 05, 2024 at 10:09:43AM +0100, Oleksij Rempel wrote:
> Implement side MDIO channel support for LAN937x switches, providing an
> alternative to SPI for PHY management alongside existing SPI-based
> switch configuration. This is needed to reduce SPI load, as SPI can be
> relatively expensive for small packets compared to MDIO support.
> 
> Also, implemented static mappings for PHY addresses for various LAN937x
> models to support different internal PHY configurations. Since the PHY
> address mappings are not equal to the port indexes, this patch also
> provides PHY address calculation based on hardware strapping
> configuration.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

