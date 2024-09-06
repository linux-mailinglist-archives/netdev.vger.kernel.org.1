Return-Path: <netdev+bounces-125994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B157296F7EE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1C284E83
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836911D278C;
	Fri,  6 Sep 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wdbzAy6E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3521C9EA4;
	Fri,  6 Sep 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635538; cv=none; b=NWXPF66TyMIqYtKfhWiJWkHNHjua4VjozN6VpjC1dI8/zLYOjrQ3pEXZT84ryGH6i1c9hKl0IvWFHz7j/vr5/H1AHa2C/hiilju09eu84cXu4at533HIFg9lrXWpm9l+xSSTGNEe37R/mCDypSk8n5bvaEhBR5u2JiHYzSHmq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635538; c=relaxed/simple;
	bh=nHfH1To98MiQXw9Cq91V2tGugWtiARfETsNaWf94Vjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD83CamoyWKkhRhDVQ0Xkk5+f50q0CLL6P+lNZ8/IAewDpC1InXqQinNyKu5HeFmDvYDJ1nWSCXq7L583Ktfp3wScidIehrVAO7o8g5rub992+L6/xjIUdvDVSOkBabUQE9nCC7HniUDz3F9eLPn+SK3nCQpWL1PT2wItc64ncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wdbzAy6E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xowjl4gL3MXeOIeUtVOUSScxtHchudp16w9u5iKTOEs=; b=wdbzAy6EeZvgycIkxYYLjSZA1B
	Xy0tkwAQITTeHNPdj2CXU0RfM+zMPkXK9OHTZ1hvlaOynIsxPCUaHCItAJq3koypsWRrld+/73Yqd
	hxx1k9PHAVmr4gHunyOisTpGH/XlH1WYClj4jne10loGmnfjfdjqaIxNCYCirllO3xpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smacs-006pnp-Si; Fri, 06 Sep 2024 17:11:54 +0200
Date: Fri, 6 Sep 2024 17:11:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
Message-ID: <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906144905.591508-1-o.rempel@pengutronix.de>

On Fri, Sep 06, 2024 at 04:49:05PM +0200, Oleksij Rempel wrote:
> Add two new properties, `forced-master` and `forced-slave`, to the
> ethernet-phy binding. These properties are intended for Single Pair
> Ethernet (1000/100/10Base-T1) PHYs, where each PHY and product may have
> a predefined link role (master or slave). Typically, these roles are set
> by hardware strap pins, but in some cases, device tree configuration is
> necessary.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index d9b62741a2259..af7a1eb6ceff6 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -158,6 +158,28 @@ properties:
>        Mark the corresponding energy efficient ethernet mode as
>        broken and request the ethernet to stop advertising it.
> 
> +  forced-master:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If set, forces the PHY to operate as a master. This is used in Single Pair
> +      Ethernet (1000/100/10Base-T1) where each PHY and product has a predefined
> +      link role (master or slave). This property is board-specific, as the role
> +      is usually configured by strap pins but can be set through the device tree
> +      if needed.
> +      This property is mutually exclusive with 'forced-slave'; only one of them
> +      should be used.

DT reviewers tend to complain about such mutually exclusive
properties.

What you are effectively adding is support for the ethtool:

ethtool -s [master-slave preferred-master|preferred-slave|forced-master|forced-slave]

10Base-T1 often does not have autoneg, so preferred-master &
preferred-slave make non sense in this context, but i wounder if
somebody will want these later. An Ethernet switch is generally
preferred-master for example, but the client is preferred-slave.

Maybe make the property a string with supported values 'forced-master'
and 'forced-slave', leaving it open for the other two to be added
later.

I've not seen the implementation yet, but i don't think there is much
driver specific here. We already have phydev->master_slave_set, it
just needs to be set from this property. Can it be done in phylib core
somewhere?

	Andrew

