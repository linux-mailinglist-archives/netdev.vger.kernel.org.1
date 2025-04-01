Return-Path: <netdev+bounces-178696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC6A78510
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4AD3AF4E6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5420E338;
	Tue,  1 Apr 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLJf2v8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63851BBBF7;
	Tue,  1 Apr 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548628; cv=none; b=gDky4i1XN7K+unFlnD1OxIyl8uFsJaE1NYzMNX690QpCSwSbgLnsrUNqZ3c0xzPaBm+jKhcVTYnuQZ/CAy3besbheF80SF77lqwz/Md9ofjrV+Qmx/0JWmG7JGUUdCe2dGKmN3bcLtriaNx5zKPVOM/t9MeS1UrEX3C7oG+XVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548628; c=relaxed/simple;
	bh=BYOXmSOsaPKAshZKAzxa/WceoPbno44r7z7Qhx1eioY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmwI4zpjgJx7sab9Btn0xWHi0VbFaIa96+oYBhbQV+guDwpYhz+HT1liLONJlwsvGb1dP6TGE7bUS5YQIs1zRKxf+1moBh1uxHsbKnMd4WHqp3/Or4swvmJ4talYlv+ngorcF0+dVjiX6dzNg12te+UEg28HdA7Bm8QUGAavbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLJf2v8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DCFC4CEE4;
	Tue,  1 Apr 2025 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743548627;
	bh=BYOXmSOsaPKAshZKAzxa/WceoPbno44r7z7Qhx1eioY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLJf2v8hEejssbPR01Tj2/A/wIryXbN0voAiZ6/Lm087eksrq31aOcBsL/0S71klr
	 b1Gb5Zw/RmCftZB36g8EGidgctqXwMTypk96G0moqwOGcWOIb+W//XTJwxBdwGBPDf
	 StRRNSnx1yuCQV3K+1NeppyDOrjdkIur0MEI23GQ78JsQXAXLji9Dr9am2NdHjv2D4
	 7paYtgQxa3jlQICY82f5hCO6JKjvWmSAUMY59vLN6g0Y6Zx1SQCTmofOUtf2UkrAbT
	 lAfqHGGO/u6Ki9dk5wUX1mvfx82cXWk/FXWgZC5XoClRbTJ3m2RYtUtjjb3OjwTCQV
	 3ONLn9gsrLxnQ==
Date: Tue, 1 Apr 2025 18:03:46 -0500
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
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250401230346.GA28557-robh@kernel.org>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-2-lukma@denx.de>
 <20250331235518.GA2823373-robh@kernel.org>
 <20250401123507.2e3bf0a6@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401123507.2e3bf0a6@wsk>

On Tue, Apr 01, 2025 at 12:35:07PM +0200, Lukasz Majewski wrote:
> Hi Rob,
> 
> > On Mon, Mar 31, 2025 at 12:31:13PM +0200, Lukasz Majewski wrote:
> > > This patch provides description of the MTIP L2 switch available in
> > > some NXP's SOCs - e.g. imx287.
> > > 
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
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
> > > ---
> > >  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 154
> > > ++++++++++++++++++ 1 file changed, 154 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > new file mode 100644 index 000000000000..98eba3665f32 --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > @@ -0,0 +1,154 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
> > > BSD-2-Clause) +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/nxp,imx287-mtip-switch.yaml#
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
> > > +$ref: ethernet-switch.yaml#  
> > 
> > This needs to be: ethernet-switch.yaml#/$defs/ethernet-ports
> > 
> > With that, you can drop much of the below part. More below...
> > 
> > > +
> > > +properties:
> 
> So it shall be after the "properties:"
> 
> $ref: ethernet-switch.yaml#/$defs/ethernet-ports   [*]

It can stay where it is, just add "/$defs/ethernet-ports"


> > > +  compatible:
> > > +    const: nxp,imx287-mtip-switch
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
> > > +  pinctrl-names: true
> > > +  
> > 
> > > +  ethernet-ports:
> 
> And then this "node" can be removed as it has been referenced above [*]?

Well, you have to keep it to have 'required' in the child nodes.

> 
> (I shall only keep the properties, which are not standard to [*] if
> any).
> 
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^port@[12]+$':  
> > 
> > Note that 'ethernet-port' is the preferred node name though 'port' is 
> > allowed.
> 
> Ok. That would be the correct define:
> 
> ethernet-ports {
>      mtip_port1: ethernet-port@1 {
>                reg = <1>;
>                label = "lan0";
>                local-mac-address = [ 00 00 00 00 00 00 ];
>                phy-mode = "rmii";
>                phy-handle = <&ethphy0>;
> 	       };
> 
>                mtip_port2: port@2 {

And here...

> 		....
> 	       };
> 
> > 
> > > +        type: object
> > > +        description: MTIP L2 switch external ports
> > > +
> > > +        $ref: ethernet-controller.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          reg:
> > > +            items:
> > > +              - enum: [1, 2]
> > > +            description: MTIP L2 switch port number
> > > +
> > > +          label:
> > > +            description: Label associated with this port
> > > +
> > > +        required:
> > > +          - reg
> > > +          - label
> > > +          - phy-mode
> > > +          - phy-handle  
> > 
> > All the above under 'ethernet-ports' can be dropped though you might 
> > want to keep 'required' part.
> 
> Ok, I will keep it.

So I think you just want this:

ethernet-ports:
  type: object
  additionalProperties: true  # Check if you need this

  patternProperties:
    '^ethernet-port@[12]$':
      required:
        - label
        - phy-mode
        - phy-handle

Rob

