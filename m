Return-Path: <netdev+bounces-138376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8DF9AD307
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A47FB23291
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DEF1D048D;
	Wed, 23 Oct 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qS0cwOVI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D41D0175;
	Wed, 23 Oct 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705153; cv=none; b=fFxgJZ2xzoG436LNPkvkxXM17zCy/1dpgz14hXqf+c66G3RZZojWqPGQyoPPikcTvTi9xIPdPnY7FylVpInkYZRcY4iKFno7bTC8BcK0A7aJFeL+CRdPFrWsbPAbcpgB8b7R9eHv6q8ZXucxV5uARu4HaRzoIEnA58bFYvLdYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705153; c=relaxed/simple;
	bh=Rlzd5R8B46KQqrG91+nBi0IN92xnlfSYQyEbx0z2v+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU8oeDzMO7FhMSwL5AvdXIOOfS/NE0tvy+BshXmSSSSaXRbIfTvzBOKlierw5ItBzgtKR1jgqU+ZYgiL6+ab7MDmmM+Bd72Uty7wn0qFRSpCqO8Cbdj0Bj8rTN010WDmZdEjo0xb2D1OjKqc7gKEaUKzM2hlV0CYxDP4SktNeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qS0cwOVI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hCXcgtGPtEn2014ULSmg0P/AaZa90Zl7RHG/bEE0dtk=; b=qS0cwOVIg/cClPHaWZxurc/tnW
	LGtkJjOm0+MOJ1UNf1vbNAFHq9PLuCpUAs420xpmvdEPR5yI0Teo3X+WkQVtRR+ickluYg7wmotKa
	abCoX137Z4CcNo3mVF4Htvp1PwccARknsaQ2CVChwyp6IQaLcb450I7rFx0BBHqhlUvE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3fK1-00Azxv-Lc; Wed, 23 Oct 2024 19:39:01 +0200
Date: Wed, 23 Oct 2024 19:39:01 +0200
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
Message-ID: <77e99052-a14e-4495-9197-06d98257c590@lunn.ch>
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-2-ansuelsmth@gmail.com>
 <5761bdc3-7224-4de6-b0f5-bedc066c09f6@lunn.ch>
 <67192f00.7b0a0220.343b2b.9836@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67192f00.7b0a0220.343b2b.9836@mx.google.com>

> Well the first case that comes to mind is multiple switch and conflict.
> I have no idea if there are hw strap to configure this so I assume if a
> SoC have 2 switch (maybe of the same type), this permits to configure
> them (with reset pin and deasserting them once the base address is
> correctly configured)

Is this switch internal on an internal MDIO bus, or external?

Most PHYs and switches i've seen have strapping pins to set the base
address. It would be unusual if there was not strapping.

For the Marvell switches, the strapping moves all the MDIO
registers. This is why we have a reg at the top level in mv88e6xxx:

        ethernet-switch@0 {
            compatible = "marvell,mv88e6085";
            reg = <0>;

There is one family which use the values of 0 or 16, and each switch
uses 16 addresses. So you can put two on the bus.

> > > +  mdio:
> > > +    $ref: /schemas/net/mdio.yaml#
> > > +    unevaluatedProperties: false
> > > +    description:
> > > +      Define the relative address of the internal PHY for each port.
> > > +
> > > +      Each reg for the PHY is relative to the switch base PHY address.
> > 
> > Which is not the usual meaning of reg.
> > 
> > > +            mdio {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +
> > > +                internal_phy0: phy@0 {
> > > +                    reg = <0>;
> > 
> > So given that airoha,base_smi_address defaults to 1, this is actually
> > address 1 on the MDIO bus?
> >
> 
> Yes correct. One problem I had was that moving this outside the swich
> cause panic as it does conflict with the switch PHY address...

I would make these addresses absolute, not relative. The example above
from the marvell switch, the device using addresses 16-31 has its PHYs
within that range, and we uses the absolute reg values.

	Andrew

