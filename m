Return-Path: <netdev+bounces-138724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999DD9AEA54
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD371F221FC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA521EABCC;
	Thu, 24 Oct 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmOqeuJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CA1E7660;
	Thu, 24 Oct 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783386; cv=none; b=pp6X5lVktS6ChbGScY3LjMOhlVo0dUduR8TxBKWP9SEm7uWHP7llcjpEk8vmP0qZLF0RGdCEm88L/EBsNg5TnEYEguZnQGlu79OJBDQeymQ8/ApPNeYqDqJJ+YrH+kE/WjAc7Ffhc9HO6WGGiTx0k29kVvHJVcBh5RKo01D53+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783386; c=relaxed/simple;
	bh=xEjMAQfA1uXRN9RJu6qq9b5+SQpN/LVbFyfZ/9OTh98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNfXm8PKCQS1AT6xlLUBXd6JHl+JpIq7Pa9naQyGdx9kBWfLvPkcFwD9Vu2CaRTsNbzCzgLwxVBJC77KpQvorGq5UhjixxYUQCNMdZ3iAbdwPp9LK4yiZ+cvnmoiOs6CzeY59tWDumAiPD9G3tefDqlH9PO1loA78b9IbV0ygnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmOqeuJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0930FC4CEC7;
	Thu, 24 Oct 2024 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783386;
	bh=xEjMAQfA1uXRN9RJu6qq9b5+SQpN/LVbFyfZ/9OTh98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmOqeuJFEcIDXrWqUn2exb+M6Et8L2ku5O276TBDc7BgtWVRzk1YXHnehvu5y21jb
	 66s9AE6hCn4fzrn+98UZAocCil89+KMtPjMckI2QZ21Vw0faU4kCd8ncZ2f8XA+jt4
	 mfX4UIj3S4frOSw0s6bj/qab7dQvQE2X/CFGZuvG6wNvCgiqk3Md+zwfxnUVZKysEh
	 WhB5AKERRRbJdU/ttIGElyNmaiHQBYxzUpjOqn81BR/xUUM/qic7mRiMepk9jstQc5
	 ytcXhjRjp90+mVtBVH/MlqMiVNoTgCQt5T3hiVWnB52tB/KzLofDB8dK066C5W6x4T
	 VCyNiWmzyrXgg==
Date: Thu, 24 Oct 2024 10:23:05 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20241024152305.GA550738-robh@kernel.org>
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

On Wed, Oct 23, 2024 at 06:19:50PM +0200, Christian Marangi wrote:
> Add Airoha AN8855 5 port Gigabit Switch documentation.
> 
> The switch node requires an additional mdio node to describe each internal
> PHY relative offset as the PHY address for the switch match the one for
> the PHY ports. On top of internal PHY address, the switch base PHY address
> is added.
> 
> Also the switch base PHY address can be configured and changed after the
> first initialization. On reset, the switch PHY address is ALWAYS 1.
> This can be configured with the use of "airoha,base_smi_address".
> 
> Calibration values might be stored in switch EFUSE and internal PHY
> might need to be calibrated, in such case, airoha,ext_surge needs to be
> enabled and relative NVMEM cells needs to be defined in nvmem-layout
> node.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/dsa/airoha,an8855.yaml       | 253 ++++++++++++++++++
>  1 file changed, 253 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
> new file mode 100644
> index 000000000000..5982b4c39536
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
> @@ -0,0 +1,253 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/airoha,an8855.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Gigabit switch
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:

You need '>' to preserve paragraphs.

> +  Airoha AN8855 is a 5-port Gigabit Switch.
> +
> +  The switch node requires an additional mdio node to describe each internal
> +  PHY relative offset as the PHY address for the switch match the one for
> +  the PHY ports. On top of internal PHY address, the switch base PHY address
> +  is added.
> +
> +  Also the switch base PHY address can be configured and changed after the
> +  first initialization. On reset, the switch PHY address is ALWAYS 1.
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1
> +
> +  airoha,base_smi_address:

s/_/-/

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Configure and change the base switch PHY address to a new address on
> +      the bus.
> +      On reset, the switch PHY address is ALWAYS 1.

The paragraphs here won't be maintained without '>' and a blank line in 
between.

Or just move the 2nd sentence up to follow the first one.

> +    default: 1
> +    maximum: 31
> +
> +  airoha,ext_surge:

ditto.

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Calibrate the internal PHY with the calibration values stored in EFUSE
> +      for the r50Ohm values.
> +
> +  '#nvmem-cell-cells':
> +    const: 0
> +
> +  nvmem-layout:
> +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
> +    description:
> +      NVMEM Layout for exposed EFUSE. (for example to propagate calibration
> +      value for r50Ohm for internal PHYs)
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Define the relative address of the internal PHY for each port.
> +
> +      Each reg for the PHY is relative to the switch base PHY address.
> +
> +$ref: dsa.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch@1 {
> +            compatible = "airoha,an8855";
> +            reg = <1>;
> +            reset-gpios = <&pio 39 0>;
> +
> +            airoha,ext_surge;
> +
> +            #nvmem-cell-cells = <0>;
> +
> +            nvmem-layout {
> +                compatible = "fixed-layout";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
> +                    reg = <0xc 0x4>;
> +                };
> +
> +                shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
> +                    reg = <0x10 0x4>;
> +                };
> +
> +                shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
> +                    reg = <0x14 0x4>;
> +                };
> +
> +                shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
> +                    reg = <0x18 0x4>;
> +                };
> +
> +                shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
> +                    reg = <0x1c 0x4>;
> +                };
> +
> +                shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
> +                    reg = <0x20 0x4>;
> +                };
> +
> +                shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
> +                    reg = <0x24 0x4>;
> +                };
> +
> +                shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
> +                    reg = <0x28 0x4>;
> +                };
> +
> +                shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
> +                    reg = <0x2c 0x4>;
> +                };
> +
> +                shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
> +                    reg = <0x30 0x4>;
> +                };
> +
> +                shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
> +                    reg = <0x34 0x4>;
> +                };
> +
> +                shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
> +                    reg = <0x38 0x4>;
> +                };
> +
> +                shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
> +                    reg = <0x4c 0x4>;
> +                };
> +
> +                shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
> +                    reg = <0x50 0x4>;
> +                };
> +
> +                shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
> +                    reg = <0x54 0x4>;
> +                };
> +
> +                shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
> +                    reg = <0x58 0x4>;
> +                };
> +            };
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    label = "lan1";
> +                    phy-mode = "internal";
> +                    phy-handle = <&internal_phy0>;
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan2";
> +                    phy-mode = "internal";
> +                    phy-handle = <&internal_phy1>;
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    label = "lan3";
> +                    phy-mode = "internal";
> +                    phy-handle = <&internal_phy2>;
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    label = "lan4";
> +                    phy-mode = "internal";
> +                    phy-handle = <&internal_phy3>;
> +                };
> +
> +                port@5 {
> +                    reg = <5>;
> +                    label = "cpu";
> +                    ethernet = <&gmac0>;
> +                    phy-mode = "2500base-x";
> +
> +                    fixed-link {
> +                        speed = <2500>;
> +                        full-duplex;
> +                        pause;
> +                    };
> +                };
> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy0: phy@0 {
> +                    reg = <0>;
> +
> +                    nvmem-cells = <&shift_sel_port0_tx_a>,
> +                                  <&shift_sel_port0_tx_b>,
> +                                  <&shift_sel_port0_tx_c>,
> +                                  <&shift_sel_port0_tx_d>;
> +                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +
> +                internal_phy1: phy@1 {
> +                    reg = <1>;
> +
> +                    nvmem-cells = <&shift_sel_port1_tx_a>,
> +                                  <&shift_sel_port1_tx_b>,
> +                                  <&shift_sel_port1_tx_c>,
> +                                  <&shift_sel_port1_tx_d>;
> +                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +
> +                internal_phy2: phy@2 {
> +                    reg = <2>;
> +
> +                    nvmem-cells = <&shift_sel_port2_tx_a>,
> +                                  <&shift_sel_port2_tx_b>,
> +                                  <&shift_sel_port2_tx_c>,
> +                                  <&shift_sel_port2_tx_d>;
> +                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +
> +                internal_phy3: phy@3 {
> +                    reg = <3>;
> +
> +                    nvmem-cells = <&shift_sel_port3_tx_a>,
> +                                  <&shift_sel_port3_tx_b>,
> +                                  <&shift_sel_port3_tx_c>,
> +                                  <&shift_sel_port3_tx_d>;
> +                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.45.2
> 

