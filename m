Return-Path: <netdev+bounces-183012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB4A8AADC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F84A3B9BAD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505BC261381;
	Tue, 15 Apr 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUL+er06"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAF126C02;
	Tue, 15 Apr 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754937; cv=none; b=q4JCJiMEs+h+ZUpaCklAco9f73ScY7CxQWZaMjYiCvp66SUXdX+9mdbEZxOrYY2BJxpLNgLTXSbVG+zC5cm9JKDevgWm307VR8CY/VppdvbcaNbr+6Drltl2m+gRqdA1FKHFQdzZBBp2jfntG94Ljxa8VGb9QHAPKFpHf7t+t4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754937; c=relaxed/simple;
	bh=tyVsM8sNu2PCOz+arnoETnAj/qNuujBFl5CZuIgb6qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvFgtjSWK8VEqzNW8mAItku5OuV4j1FEnPynFHXFPJYHQqDA58yPagu9soxJYqMZGRGOkRY1NMyFntfwjCsEbMX2lQ6xzQPu7I4qEer4j56uMgQt6P68eXJKJrEhNVgUY2dueGRL99M+TCLQqD2QyFwJd9sypc7uASsRej0j/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUL+er06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E63C4CEE7;
	Tue, 15 Apr 2025 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744754935;
	bh=tyVsM8sNu2PCOz+arnoETnAj/qNuujBFl5CZuIgb6qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUL+er06cdomuT2To0Vp+vl3RezE21eS9FHO39xYrxl13ItAS72cgNN1YDbw2sDoI
	 jZUM/ht2DCGfCQaOp4g3ktg4fzLibFvaacZA5KDdh4rrxDAhJnGlOgRTyfsjnfVGOZ
	 rfLw4v57o6nzJQXAMX1FG97HnypSpNKjwJ/AvgDZKW8bmOjgWAsz8OFRckuSetUJbF
	 h0KpuhqmWYAaBuooEoYERzR+4RL9c7X/EHqyMPCfwCRh1ZVi7tFK0Tqgki7uWm4FP5
	 OmXmrl5M1eFTenfphFKy6xfN4WQrh6WhZSGrw5NtFjPXPxj7ExiMR1Btj2Agl3onuA
	 i9k7R/0At5mgg==
Date: Tue, 15 Apr 2025 17:08:53 -0500
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
Subject: Re: [net-next v5 1/6] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250415220853.GA903775-robh@kernel.org>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414140128.390400-2-lukma@denx.de>

On Mon, Apr 14, 2025 at 04:01:23PM +0200, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
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
> ---
>  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> new file mode 100644
> index 000000000000..6f2b5a277ac2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> @@ -0,0 +1,141 @@
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
> +$ref: ethernet-switch.yaml#/$defs/ethernet-ports
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
> +  pinctrl-names: true
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      ethernet-port:
> +        type: object
> +        unevaluatedProperties: false

This is going to fail if you have any property other than 'reg'. But 
then it will never be applied because you never have a node called
'ethernet-port' since you have more than 1 child node. You need this 
under 'patternProperties' and 'additionalProperties: true' instead. And 
please test some of the requirements here. Like a reg value of 3 or 
remove 'phy-mode'.

> +
> +        properties:
> +          reg:
> +            items:
> +              - enum: [1, 2]
> +            description: MTIP L2 switch port number
> +
> +        required:
> +          - reg
> +          - label
> +          - phy-mode
> +          - phy-handle

