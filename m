Return-Path: <netdev+bounces-179284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FEA7BB08
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869D43A3897
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6EF1B4232;
	Fri,  4 Apr 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9fqTk7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FD198E63;
	Fri,  4 Apr 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763026; cv=none; b=D9DU1rl1D0d/eEE5BzXsIUDMu4TnI4C/KTOxqZVc7gWjgF7CBEqYbbZv+eF8rsHV//bEmAI8n5igXyHEtu0Vz0add6nGjRmAnvz37Nu4G+zbpK2FFrjcyiZuVde9SwdafMAZj1oznXToi08u+waSJKTDHpJxridn5c6Imc5ErCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763026; c=relaxed/simple;
	bh=/SfhRE90vLHth6++eAZ8pTt7WyBf5taumSc3JK1kiPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4nua8gia/j+3h4FlbAHLUapOmFfyX78llS02mqz76esMx5PDAOFMYSYJaJsN1kZA7JasGJ7giG9h2HWrKQlCHljm2fEwl7q0eBGawcZAGC1oj57aIsiC6BUtxC9gTmyLI01/7OD6YZgwebjYzqwxKYgF3IB8czUKeoPS6J+zpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9fqTk7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5D8C4CEDD;
	Fri,  4 Apr 2025 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743763026;
	bh=/SfhRE90vLHth6++eAZ8pTt7WyBf5taumSc3JK1kiPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9fqTk7fcMd4zSZTUQbVXpVrFAErSiKqVLrSJzbwdWMWHXnOKIv+s92T2mqEWKkwD
	 LpCHgTLMgHNZRcOAhu8ZSkmd5v4vJZZJ6uUI9VR6xpDud5bVDAYrUciNcO1tqO9qIF
	 fjPEnHWhe51NnsTWP7EMX1BsCMn8gvjPryVMM4WxNGDLMUBmxxv/Bg4uZUGGereDrU
	 BrAzWAjog7FOOgebkGlFO8FfWZoSmxNF78wRxwh2rO2WsAzmaMoKRhcErKFGeib/hi
	 75aSIY/xuQSVPBlej1QzwtiUgdfmeMkQw0INRR+Gg4GhUnqqsmPIWL/2rvkDB4Coci
	 pOFEjqurSMGQw==
Date: Fri, 4 Apr 2025 12:37:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, 
	Christian Marangi <ansuelsmth@gmail.com>, upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Rob Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>, 
	devicetree@vger.kernel.org
Subject: Re: [RFC net-next PATCH 01/13] dt-bindings: net: Add binding for
 Xilinx PCS
Message-ID: <20250404-tench-of-heavenly-beauty-fb4ed1@shite>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403181907.1947517-2-sean.anderson@linux.dev>

On Thu, Apr 03, 2025 at 02:18:55PM GMT, Sean Anderson wrote:
> This adds a binding for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII

Incomplete review, since this is an RFC.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> LogiCORE IP. This device is a soft device typically used to adapt
> between GMII and SGMII or 1000BASE-X (possbilty in combination with a
> serdes). pcs-modes reflects the modes available with the as configured
> when the device is synthesized. Multiple modes may be specified if
> dynamic reconfiguration is supported.
> 
> One PCS may contain "shared logic in core" which can be connected to
> other PCSs with "shared logic in example design." This primarily refers
> to clocking resources, allowing a reference clock to be shared by a bank
> of PCSs. To support this, if #clock-cells is defined then the PCS will
> register itself as a clock provider for other PCSs.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  .../devicetree/bindings/net/xilinx,pcs.yaml   | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/xilinx,pcs.yaml b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> new file mode 100644
> index 000000000000..56a3ce0c4ef0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/xilinx,pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE IP
> +
> +maintainers:
> +  - Sean Anderson <sean.anderson@seco.com>
> +
> +description:
> +  This is a soft device which implements the PCS and (depending on
> +  configuration) PMA layers of an IEEE Ethernet PHY. On the MAC side, it
> +  implements GMII. It may have an attached SERDES (internal or external), or
> +  may directly use LVDS IO resources. Depending on the configuration, it may
> +  implement 1000BASE-X, SGMII, 2500BASE-X, or 2.5G SGMII.
> +
> +  This device has a notion of "shared logic" such as reset and clocking
> +  resources which must be shared between multiple PCSs using the same I/O
> +  banks. Each PCS can be configured to have the shared logic in the "core"
> +  (instantiated internally and made available to other PCSs) or in the "example
> +  design" (provided by another PCS). PCSs with shared logic in the core are
> +  reset controllers, and generally provide several resets for other PCSs in the
> +  same bank.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    contains:

From where did you get such syntax? What do you want to express?

> +      const: xilinx,pcs-16.2

What does the number mean?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +    description:
> +      Register a clock representing the clocking resources shared with other
> +      PCSs.

Drop description, redundant.

> +
> +  clocks:
> +    items:
> +      - description:
> +          The reference clock for the PCS. Depending on your setup, this may be
> +          the gtrefclk, refclk, clk125m signal, or clocks from another PCS.
> +
> +  clock-names:
> +    const: refclk
> +
> +  done-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the reset-done output, if present.
> +
> +  interrupts:
> +    items:
> +      - description:
> +          The an_interrupt autonegotiation-complete interrupt.
> +
> +  interrupt-names:
> +    const: an
> +
> +  pcs-modes:
> +    description:
> +      The interfaces that the PCS supports.
> +    oneOf:
> +      - const: sgmii
> +      - const: 1000base-x
> +      - const: 2500base-x
> +      - items:
> +          - const: sgmii
> +          - const: 1000base-x

This is confusing. Why fallbacks? Shouldn't this be just enum? And
where is the type or constraints about number of items?

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the reset input.
> +
> +required:
> +  - compatible
> +  - reg
> +  - pcs-modes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pcs0: ethernet-pcs@0 {
> +            #clock-cells = <0>;

Follow DTS coding style. clock-cells are never the first property.

> +            compatible = "xlnx,pcs-16.2";
> +            reg = <0>;
> +            clocks = <&si570>;
> +            clock-names = "refclk";
> +            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "an";
> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +            done-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> +            pcs-modes = "sgmii", "1000base-x";
> +        };
> +
> +        pcs1: ethernet-pcs@1 {
> +            compatible = "xlnx,pcs-16.2";
> +            reg = <1>;
> +            clocks = <&pcs0>;
> +            clock-names = "refclk";
> +            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "an";
> +            reset-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> +            done-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
> +            pcs-modes = "sgmii", "1000base-x";

Drop example, basically the same as previous.

Best regards,
Krzysztof


