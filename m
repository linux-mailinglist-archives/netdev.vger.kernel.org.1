Return-Path: <netdev+bounces-189841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AFAB3DCD
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6663BCE98
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CC2528EF;
	Mon, 12 May 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmyYf+UT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED89250C05;
	Mon, 12 May 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068028; cv=none; b=RLceQLMfDeUVg85wvH793GJm4lZhohQpsF54nu6QXvE0mHlWvcH3ZvxWNTxz9o+0WIN7N5tysJSGmXjM924oQJ41HU5QYbAVSmqkq7LaGFFzqbDDOtOepueZdg6vovig77m8qUCkl5xTuoV91jSiUq4a5DvpJJ3onH+wQ2NZKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068028; c=relaxed/simple;
	bh=6tcoJxQNycyS+g+UuadukNx5hqQX0eM1s0P5TP7QSpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2kq2KQ2yoO503sMHtaPjIPbbIV+BPuMIa7aoPYU2gTIXxq5EF20gC/X2Dc5eFnRydwchQ7HHo4J9xp/ox1CKEoGjvPQK3aNQEjKY2PQkji9C/QAN1eFiBdwyJsD3i+dcFIWG8GF7CNsp+nF2oBAhNJyksPjAk9phup6/BXAjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmyYf+UT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A356C4CEE7;
	Mon, 12 May 2025 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068027;
	bh=6tcoJxQNycyS+g+UuadukNx5hqQX0eM1s0P5TP7QSpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmyYf+UTzTUMyJDclwm9Ra8k0Vriwlze7yPBcvq/W4d4jQNjgwbz6C6z9RkxsfCct
	 owjG9TO+GLMSpIeCLcCmV5Zv5ZCJFcmB8PE7TDHxqW4ZVr5wo8S6dE8qzqPb9sFptK
	 RLk0YrbmJYZWjicM8Kcoqc91EyxrN5VD2JNu9xsCgPapu9zpMl4Pio9E/2DYKNKNfo
	 wwdjaMZteB5o1I7hWPGDWKiH2U1KpdMr0pFZSERvdhxoKDGcfj6KLsZS371rnAIPRS
	 ayFTAgV5wRwtR9wwHybcCqKU+X92fGrR4/tFFU6ICJbZczo0ypwXUKk7QKECwJNNrT
	 vbsMPzcjNGWCw==
Date: Mon, 12 May 2025 11:40:25 -0500
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
Message-ID: <20250512164025.GA3454904-robh@kernel.org>
References: <20250504145538.3881294-1-lukma@denx.de>
 <20250504145538.3881294-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504145538.3881294-2-lukma@denx.de>

On Sun, May 04, 2025 at 04:55:32PM +0200, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> 
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>   (nxp,imx287-mtip-switch)
> 
> Changes for v3:
> - Remove '-' from const:'nxp,imx287-mtip-switch'
> - Use '^port@[12]+$' for port patternProperties
> - Drop status = "okay";
> - Provide proper indentation for 'example' binding (replace 8
>   spaces with 4 spaces)
> - Remove smsc,disable-energy-detect; property
> - Remove interrupt-parent and interrupts properties as not required
> - Remove #address-cells and #size-cells from required properties check
> - remove description from reg:
> - Add $ref: ethernet-switch.yaml#
> 
> Changes for v4:
> - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove already
>   referenced properties
> - Rename file to nxp,imx28-mtip-switch.yaml
> 
> Changes for v5:
> - Provide proper description for 'ethernet-port' node
> 
> Changes for v6:
> - Proper usage of
>   $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
>   when specifying the 'ethernet-ports' property
> - Add description and check for interrupt-names property
> 
> Changes for v7:
> - Change switch interrupt name from 'mtipl2sw' to 'enet_switch'
> 
> Changes for v8:
> - None
> 
> Changes for v9:
> - Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle
> 
> Changes for v10:
> - None
> 
> Changes for v11:
> - None
> ---
>  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> new file mode 100644
> index 000000000000..35f1fe268de7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +description:
> +  The 2-port switch ethernet subsystem provides ethernet packet (L2)
> +  communication and can be configured as an ethernet switch. It provides the
> +  reduced media independent interface (RMII), the management data input
> +  output (MDIO) for physical layer device (PHY) management.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx28-mtip-switch
> +
> +  reg:
> +    maxItems: 1
> +
> +  phy-supply:
> +    description:
> +      Regulator that powers Ethernet PHYs.
> +
> +  clocks:
> +    items:
> +      - description: Register accessing clock
> +      - description: Bus access clock
> +      - description: Output clock for external device - e.g. PHY source clock
> +      - description: IEEE1588 timer clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +      - const: enet_out
> +      - const: ptp
> +
> +  interrupts:
> +    items:
> +      - description: Switch interrupt
> +      - description: ENET0 interrupt
> +      - description: ENET1 interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: enet_switch
> +      - const: enet0
> +      - const: enet1
> +
> +  pinctrl-names: true
> +
> +  ethernet-ports:
> +    type: object
> +    $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties

'patternProperties' is wrong. Drop.

> +    additionalProperties: true

Drop.

> +
> +    patternProperties:
> +      '^ethernet-port@[12]$':
> +        type: object
> +        additionalProperties: true
> +        properties:
> +          reg:
> +            items:
> +              - enum: [1, 2]
> +            description: MTIP L2 switch port number
> +
> +        required:
> +          - reg
> +          - label

'label' shouldn't ever be required because s/w shouldn't care what the 
value is.

> +          - phy-mode
> +          - phy-handle
> +
> +  mdio:
> +    type: object
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Specifies the mdio bus in the switch, used as a container for phy nodes.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - mdio
> +  - ethernet-ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include<dt-bindings/interrupt-controller/irq.h>
> +    #include<dt-bindings/gpio/gpio.h>
> +    switch@800f0000 {
> +        compatible = "nxp,imx28-mtip-switch";
> +        reg = <0x800f0000 0x20000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
> +        phy-supply = <&reg_fec_3v3>;
> +        interrupts = <100>, <101>, <102>;
> +        interrupt-names = "enet_switch", "enet0", "enet1";
> +        clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> +        clock-names = "ipg", "ahb", "enet_out", "ptp";
> +
> +        ethernet-ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            mtip_port1: ethernet-port@1 {
> +                reg = <1>;
> +                label = "lan0";
> +                local-mac-address = [ 00 00 00 00 00 00 ];
> +                phy-mode = "rmii";
> +                phy-handle = <&ethphy0>;
> +            };
> +
> +            mtip_port2: ethernet-port@2 {
> +                reg = <2>;
> +                label = "lan1";
> +                local-mac-address = [ 00 00 00 00 00 00 ];
> +                phy-mode = "rmii";
> +                phy-handle = <&ethphy1>;
> +            };
> +        };
> +
> +        mdio_sw: mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
> +            reset-delay-us = <25000>;
> +            reset-post-delay-us = <10000>;
> +
> +            ethphy0: ethernet-phy@0 {
> +                reg = <0>;
> +            };
> +
> +            ethphy1: ethernet-phy@1 {
> +                reg = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.39.5
> 

