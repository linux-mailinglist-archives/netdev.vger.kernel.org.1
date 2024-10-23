Return-Path: <netdev+bounces-138372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2189AD239
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09EA2853FF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B11CB506;
	Wed, 23 Oct 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hp4wPkSZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F879C4;
	Wed, 23 Oct 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703349; cv=none; b=bJnUDHGWD4xVpHRAHKkClZ3mocUCdtHXVQbG/V5CKGbgUlPNUMRV33Gk73Sy6htn44bF3PaSUM7OhZnjXwLogTlDcBBE6BYYKZkOhbf9jrfTMnHj+1hJysHMRLx7Y34UvjJ3j42S/sZd/MV86529Sz9888ToPytVRLtdUhAlbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703349; c=relaxed/simple;
	bh=t6OPo3nYliT7PVPzDeiTDoe3aVWcIHhbXsytGx1exAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT4eI0tHp1B9GUVy/UMaJxlE5NNHKJMQm9/HbGuOBxhUU0vDd6GmU1tE87ktQPr7dhWrvvlqNvp53m6/VBIpeDqcqylDfkw59kL0F0V4ajou40LY5/knpA/x6NbLB4nxlfxpChqSGREWSIPGoyJkFyK2DzRrnTv9+VtT0QPynvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hp4wPkSZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gmEVhBJVJsQXnrJhRZPfZUzFLJqycfl8GOOHTWz4FTY=; b=hp4wPkSZbMXNN95Uk34gpoCcvo
	kMgc4Kx2KFDq4hrzZ7/1mBSPikuzlXlMY0EvidbGFVm45qDRNfh+yFDeF+wB3b+fCxQTs7voApWvu
	WlrFrE9EKhYYh1EHuxgQJ/7nLzKXsh0rFQziXfbsiq9w9vhW7h4xgyxrSA9uDbZ9r+yo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3eqv-00AzoS-OD; Wed, 23 Oct 2024 19:08:57 +0200
Date: Wed, 23 Oct 2024 19:08:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 1/3] dt-bindings: net: dsa: Add Airoha
 AN8855 Gigabit Switch documentation
Message-ID: <5761bdc3-7224-4de6-b0f5-bedc066c09f6@lunn.ch>
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161958.12056-2-ansuelsmth@gmail.com>

> +  airoha,base_smi_address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Configure and change the base switch PHY address to a new address on
> +      the bus.
> +      On reset, the switch PHY address is ALWAYS 1.
> +    default: 1
> +    maximum: 31

Given that this is a 5 port switch, what happens if i pick a value
greater than 31 - 5 ?

Do you have a real use case for this? A board which requires the PHYs
get shifted from the default of 1? Vendors have all sorts of bells and
whistles which we never use. If its not needed, i would not add it,
until it is actually needed, if ever.

> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Define the relative address of the internal PHY for each port.
> +
> +      Each reg for the PHY is relative to the switch base PHY address.

Which is not the usual meaning of reg. 

> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy0: phy@0 {
> +                    reg = <0>;

So given that airoha,base_smi_address defaults to 1, this is actually
address 1 on the MDIO bus?

	Andrew

