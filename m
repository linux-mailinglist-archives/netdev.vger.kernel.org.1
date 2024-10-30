Return-Path: <netdev+bounces-140367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10499B631D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E75E2828BC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFEE1E9066;
	Wed, 30 Oct 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FYIqQah5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175F1E570B;
	Wed, 30 Oct 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291503; cv=none; b=ImCNkfxmR0WjxsOjrx9xc+FAM0JWEkmL9NQRyaWnVXmYTL571FmhBK1Ludz+Px8EEr2xKf5wRdr04yLil0c+uMC1WrNLXo8k4n+2XXIb5AGGS5xYYQ9PpDUgxsSyvNIPGOOIdejvMb+Ty8L2NN61TEvKnp1cWw5AR658z35TagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291503; c=relaxed/simple;
	bh=5WjxaCpOtmNmXe4YJQkUqUuW+bFgPW+KHY3iNDjzG4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g++EoNbRtbes1LhZybboHSxymILWiq/vIeb/dxaPx6u0Hta0Qdr1/K3cC7tM6l8/SPvJHTrlCx9Xsmn0VGMXGFq8ns7odnDejiQOiqbeqFtLL5x7TzCYGIDqx4MCX1N3SIxiBQrpxX8tMTdHxrWeGAg0yb4Leb+Zv7lwjzsQp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FYIqQah5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A1gdFxL9zVx4lkEXli7DnX5FSvvlBekb4hoQcoFayx4=; b=FYIqQah5jFjkkhCL49WEyg4yz6
	I+kPSfgfV0jbmFYzzdfPSDNPWoLsi9hkwYIfzhQaOPEGp6ZNjHVFc78r/2dBD5mrO2dYkTC9DJrlI
	N+21apyXdybsTZF8hkXp4ys8wGy9Ye8a0chut7yE3NDjCTmCQPtQPNkGOaxrxFhGh8nY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t67r2-00Bgcd-B3; Wed, 30 Oct 2024 13:31:16 +0100
Date: Wed, 30 Oct 2024 13:31:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH net-next v2 2/5] dt-bindings: net: dsa: ksz: add
 mdio-parent-bus property for internal MDIO
Message-ID: <4754b485-05e9-47e5-872e-da5ee31bf9eb@lunn.ch>
References: <20241029110732.1977064-1-o.rempel@pengutronix.de>
 <20241029110732.1977064-3-o.rempel@pengutronix.de>
 <20241029123107.ssvggsn2b5w3ehoy@skbuf>
 <ZyDe_ObZ-laVk8c2@pengutronix.de>
 <2b03f429-9ae2-4c7a-9cec-0bc2f3c6e816@lunn.ch>
 <ZyHGEDfhcRGX_Fzg@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyHGEDfhcRGX_Fzg@pengutronix.de>

> Yes, this is correct. This can be implemented purely by parsing the
> devicetree. Based on previous experience, I expected you to suggest me
> to implement the validation so i jumped directly to a part of this step.
> 
> Should I implement it based on the devicetree information and validate
> based on HW strapping?

I assume you need to list the PHYs in DT because there is not a 1:1
mapping of port number to MDIO address? If there is a 1:1 mapping,
port 1 has a PHY at MDIO address 1, the DSA core will connect the PHYs
for you, there is no need to list them in DT.

But if strapping can put them anywhere on the bus, this is not true,
and then you need the phy-handle.

I would then suggest DT described the hardware, the PHYs are listed on
the correct MDIO address, and you validate the hardware matches DT
just as a sanity check.

	Andrew

