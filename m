Return-Path: <netdev+bounces-190494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2466AB70A4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB86166FA7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421F1DF27C;
	Wed, 14 May 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnRrwyoV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BA33997;
	Wed, 14 May 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238480; cv=none; b=XhrbmJm6y5QJLDwuikCzT1CGtojbvb/+lMIH58Iq+VAbuKDhgGdoowldrLLBxbtjew0hotk6owT4etxOFo5jnilJuqeJGWBxDrurfEashhOBqPj7mPfxYUSUG7xjd3zjZ+cBrnRStgyfhv6DHRxjT2xLpeGDkxnnKhd1xE5DHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238480; c=relaxed/simple;
	bh=B2tOkM/DzG98PLHSFcOfINzeUonmNYRo9e+Y87xDuDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSqTAegE6U9Ieqqz5hL/pGG43YQUYj3Su05K6VjbAf182tYzIXc8QNN2fMgFh1+taZd5HGVmgd/NcwI+qYBmy2QtmjjZrgFgTImtERKD1dZSG3E/mJdT4Po6tNmkg5IIWDYBqbDZC8qc1j4O11ZyeG4t40B4YKfJNSBgR3S6eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnRrwyoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AE1C4CEE3;
	Wed, 14 May 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747238477;
	bh=B2tOkM/DzG98PLHSFcOfINzeUonmNYRo9e+Y87xDuDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnRrwyoVk4xJCFtsxhj+dIJJQuynWD+NXT5oD0O0HhLpGyu8A7uaS76STzKYcQOpH
	 scweY4N0CzWYf8oY8G7mjKLS9qwvAV6DmSS02cSLC3DgNL1xU/aXvmYwmjPHjRXNvY
	 79o/awouzMIVHtjPJONGDOpzbNhpiULYSHJk1Rp6Qk8zZOcLysTUolbmIsx5WH8ZdY
	 3fXcaYXifxaTVfsaHlzC37K8XtlohACuMj7GXe8OduiIbKg+KT2AbLjQQzH/fBhFYs
	 hobh5RCftYz/r6KTdA8p07dpvtkzhyMuLaxALyAnucokq7H0mVjPzVmSzlfNT5pwxZ
	 lJ2x9Vf6a382w==
Date: Wed, 14 May 2025 11:01:15 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v11 1/7] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250514160115.GA2382587-robh@kernel.org>
References: <20250504145538.3881294-1-lukma@denx.de>
 <20250504145538.3881294-2-lukma@denx.de>
 <20250512164025.GA3454904-robh@kernel.org>
 <20250513080920.7c8a2a06@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513080920.7c8a2a06@wsk>

On Tue, May 13, 2025 at 08:09:20AM +0200, Lukasz Majewski wrote:
> Hi Rob,
> 
> > On Sun, May 04, 2025 at 04:55:32PM +0200, Lukasz Majewski wrote:
> > > This patch provides description of the MTIP L2 switch available in
> > > some NXP's SOCs - e.g. imx287.
> > > 
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > > 
> > > ---
> > > Changes for v2:
> > > - Rename the file to match exactly the compatible
> > >   (nxp,imx287-mtip-switch)
> > > 
> > > Changes for v3:
> > > - Remove '-' from const:'nxp,imx287-mtip-switch'
> > > - Use '^port@[12]+$' for port patternProperties
> > > - Drop status = "okay";
> > > - Provide proper indentation for 'example' binding (replace 8
> > >   spaces with 4 spaces)
> > > - Remove smsc,disable-energy-detect; property
> > > - Remove interrupt-parent and interrupts properties as not required
> > > - Remove #address-cells and #size-cells from required properties
> > > check
> > > - remove description from reg:
> > > - Add $ref: ethernet-switch.yaml#
> > > 
> > > Changes for v4:
> > > - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove
> > > already referenced properties
> > > - Rename file to nxp,imx28-mtip-switch.yaml
> > > 
> > > Changes for v5:
> > > - Provide proper description for 'ethernet-port' node
> > > 
> > > Changes for v6:
> > > - Proper usage of
> > >   $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
> > >   when specifying the 'ethernet-ports' property
> > > - Add description and check for interrupt-names property
> > > 
> > > Changes for v7:
> > > - Change switch interrupt name from 'mtipl2sw' to 'enet_switch'
> > > 
> > > Changes for v8:
> > > - None
> > > 
> > > Changes for v9:
> > > - Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle
> > > 
> > > Changes for v10:
> > > - None
> > > 
> > > Changes for v11:
> > > - None
> > > ---
> > >  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 149
> > > ++++++++++++++++++ 1 file changed, 149 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > > new file mode 100644 index 000000000000..35f1fe268de7 --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > > @@ -0,0 +1,149 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
> > > BSD-2-Clause) +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
> > > +
> > > +maintainers:
> > > +  - Lukasz Majewski <lukma@denx.de>
> > > +
> > > +description:
> > > +  The 2-port switch ethernet subsystem provides ethernet packet
> > > (L2)
> > > +  communication and can be configured as an ethernet switch. It
> > > provides the
> > > +  reduced media independent interface (RMII), the management data
> > > input
> > > +  output (MDIO) for physical layer device (PHY) management.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nxp,imx28-mtip-switch
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  phy-supply:
> > > +    description:
> > > +      Regulator that powers Ethernet PHYs.
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Register accessing clock
> > > +      - description: Bus access clock
> > > +      - description: Output clock for external device - e.g. PHY
> > > source clock
> > > +      - description: IEEE1588 timer clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: ipg
> > > +      - const: ahb
> > > +      - const: enet_out
> > > +      - const: ptp
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: Switch interrupt
> > > +      - description: ENET0 interrupt
> > > +      - description: ENET1 interrupt
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: enet_switch
> > > +      - const: enet0
> > > +      - const: enet1
> > > +
> > > +  pinctrl-names: true
> > > +
> > > +  ethernet-ports:
> > > +    type: object
> > > +    $ref:
> > > ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties  
> > 
> > 'patternProperties' is wrong. Drop.
> > 
> 
> When I do drop it, then
> make dt_binding_check DT_SCHEMA_FILES=nxp,imx28-mtip-switch.yaml
> 
> shows:
> 
> nxp,imx28-mtip-switch.example.dtb: switch@800f0000: ethernet-ports:
> 'oneOf' conditional failed, one must be fixed:
> 
> 'ports' is a required property 
> 'ethernet-ports' is a required property
>         from schema $id:
>         http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#

Actually, it needs to be at the top-level as well:

allOf:
  - $ref: ethernet-switch.yaml#/$defs/ethernet-ports


> 
> We do have ethernet-ports:
> and we do "include" ($ref)
> https://elixir.bootlin.com/linux/v6.14.6/source/Documentation/devicetree/bindings/net/ethernet-switch.yaml#L77
> 
> which is what we exactly need.

The $ref is effectively pasting in what you reference, so the result 
would be:

ethernet-ports:
  type: object
  "^(ethernet-)?ports$":
    patternProperties:
      "^(ethernet-)?port@[0-9a-f]+$":
        description: Ethernet switch ports
        $ref: ethernet-switch-port.yaml#
        unevaluatedProperties: false

A DT node/property name and json-schema keyword at the same level is 
never correct. json-schema behavior is to ignore (silently) any unknown 
keyword. So the validator sees the keyword "^(ethernet-)?ports$" and 
ignores everything below it.


> 
> > > +    additionalProperties: true  
> > 
> > Drop.
> > 
> 
> When removed we do have:
> nxp,imx28-mtip-switch.example.dtb: switch@800f0000: Unevaluated
> properties are not allowed ('ethernet-ports' was unexpected)
> 
> or 
> 
> nxp,imx28-mtip-switch.yaml: ethernet-ports: Missing
> additionalProperties/unevaluatedProperties constraint

'additionalProperties: true' should suppress that.

> 
> Depending if I do remove 'patternProperties' above.
> 
> To sum up - with the current code, the DT schema checks pass. It also
> looks like the $ref for ethernet-switch is used in an optimal way.
> 
> I would opt for keeping the code as is for v12.

