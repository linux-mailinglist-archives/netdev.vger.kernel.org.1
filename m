Return-Path: <netdev+bounces-29421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CC7831AB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962911C20933
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFFE1171D;
	Mon, 21 Aug 2023 19:58:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA9A11703
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A363C433C7;
	Mon, 21 Aug 2023 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692647922;
	bh=YHRK49m0FODZulvCBwwxZ8Z0LvJBNBRNP9bT215xj/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ttws5R1yp9Lmhoc/vxR23BZx0lRN/90vrkS2NWO2xrw7rSilXQ2XnMkpWQsKYTa/G
	 zMsWmCTa1hkkGWBpx3JlqXoacaz9k26Q/7JEq6D0a2k8oiGWzLo/zF1DgTSn9TgRwO
	 FAQRNRsh+Sx+IjZVOdNNXsJDKeFaOsLOMaI+NWLuKcIr/RziV5Uh20/sNk0SUGFvMK
	 sNO5J51RoHGHbYnBwWaf1t3s1QE1qgrqasoNb8RRYrFlU1r2+6t4mxgCVbGtxFjf5l
	 0lwT3BRUKFL/EzveVGO2l1mJ7uKhIi8wl3ixqrPQ5WSKdX8bWxDivE+qkcTHdn7O7i
	 Z+kOvbZZ5yuRw==
Received: (nullmailer pid 2196764 invoked by uid 1000);
	Mon, 21 Aug 2023 19:58:40 -0000
Date: Mon, 21 Aug 2023 14:58:40 -0500
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor@kernel.org>, Sean Anderson <sean.anderson@seco.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 8/8] dt-bindings: net: fsl,backplane-anlt:
 new binding document
Message-ID: <20230821195840.GA2181626-robh@kernel.org>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-9-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817150644.3605105-9-vladimir.oltean@nxp.com>

On Thu, Aug 17, 2023 at 06:06:44PM +0300, Vladimir Oltean wrote:
> Illustrate how the backplane AN/LT blocks can be instantiated on the
> LX2160A SoC with SerDes protocol 19.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
>  .../bindings/net/fsl,backplane-anlt.yaml      | 238 ++++++++++++++++++
>  2 files changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index c1241c8a3b77..96fa672e4786 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -49,6 +49,14 @@ properties:
>        - items:
>            - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
>            - const: ethernet-phy-ieee802.3-c45
> +      - items:
> +          - const: fsl,lx2160a-backplane-anlt
> +          - const: ethernet-phy-ieee802.3-c45

What's the benefit of having ethernet-phy-ieee802.3-c45? Will it work if 
the OS only understands that and not fsl,lx2160a-backplane-anlt?

> +        description:
> +          Some C45 PHYs have no PHY ID in the standard location, and there is
> +          also no PHY ID allocated for them to fake. They are identified by the
> +          primary compatible string, plus the secondary one to distinguish them
> +          from a raw MDIO device.
>  
>    reg:
>      minimum: 0
> diff --git a/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> new file mode 100644
> index 000000000000..7282e93b1dd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
> @@ -0,0 +1,238 @@
> +# SPDX-License-Identifier: GPL-2.0+

Not the right license.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,backplane-anlt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Backplane Ethernet PHY
> +
> +maintainers:
> +  - Vladimir Oltean <vladimir.oltean@nxp.com>
> +
> +description: |
> +  Some QorIQ and Layerscape SoCs have an additional block on each SerDes
> +  networking lane, based on an IP core from MoreThanIP, which performs IEEE
> +  802.3 clause 73 base page exchanges (for auto-negotiation) and clause 72
> +  training frame exchanges (for link training).
> +
> +  By default, this AN/LT block comes up with auto-negotiation disabled, and
> +  in that case it allows itself to be quickly bypassed from the data path and
> +  for the PCS link to come up without its involvement.
> +
> +  Software can optionally make use of it, to turn the PCS, AN/LT block and lane
> +  (PMA/PMD) into a full copper backplane internal PHY.
> +
> +  As a warning, the binding for the multi-lane link modes (40GBase-KR4) is not
> +  currently backed up by a driver implementation.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          - items:
> +              - const: fsl,lx2160a-backplane-anlt
> +              - const: ethernet-phy-ieee802.3-c45

Use "contains" and drop ethernet-phy-ieee802.3-c45.

> +    then:
> +      $ref: ethernet-phy.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,lx2160a-backplane-anlt
> +          - const: ethernet-phy-ieee802.3-c45
> +      - const: fsl,lx2160a-secondary-anlt
> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description: |
> +      The address of the AN/LT block within the internal MDIO bus of the MAC it
> +      is attached to.
> +
> +      In the 1000Base-KX and 10GBase-KR link modes, the AN/LT block responds at
> +      the same MDIO address as the PCS (determined by the SGMIInCR1[MDEV_PORT]
> +      or SXGMIInCR1[MDEV_PORT] registers of the SerDes block, by default 0).
> +      The PCS and AN/LT block respond to different MMDs, though.
> +
> +      In the 25GBase-KR and higher link modes, the AN/LT block responds at a
> +      different MDIO address than the PCS, determined by the
> +      ANLTnCR1[MDEV_PORT] register of the SerDes block. By default this is 4
> +      for lanes A and E, 5 for lanes B and F, 6 for lanes C and G, 7 for lanes
> +      D and H.
> +
> +      The PCS responds in all cases at the address determined by the MDEV_PORT
> +      field of the SGMIInCR1, SXGMIIaCR1, E25GaCR1, E40GaCR1, E50GaCR1 or
> +      E100GaCR1 registers of the SerDes block.
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      phandle for the generic PHY (SerDes lane) that acts as PMA/PMD layer
> +
> +  pcs-handle:
> +    maxItems: 1
> +    description:
> +      phandle for the technology-dependent PCS block corresponding to the
> +      initial (RCW-based) configuration of the port. Must be omitted for the
> +      link modes where the PCS and AN/LT block respond at the same MDIO
> +      address. Must be specified otherwise.
> +
> +  secondary-anlt-handle:

Needs a vendor prefix and type.

> +    maxItems: 1
> +    description:
> +      In case this is the primary (first) lane of a multi-lane link mode, this
> +      property holds an array of phandles for the other AN/LT blocks, that are
> +      involved in link training but not in auto-negotiation. These have the
> +      "fsl,lx2160a-secondary-anlt" compatible string.
> +
> +required:
> +  - compatible
> +  - reg
> +  - phys
> +
> +unevaluatedProperties: false
> +
> +examples:
> +
> +  # LX2160A lanes A, B, C, D with SerDes 1 protocol 19: dpmac2 uses 40GBase-KR4
> +  - |
> +    dpmac2 {
> +        phy-handle = <&mac2_backplane_anlt>;
> +        phy-connection-type = "internal";
> +    };
> +
> +    pcs_mdio2 {

mdio {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";

Don't need status in examples.

> +
> +        pcs2: ethernet-phy@0 {
> +            reg = <0>;
> +        };
> +
> +        mac2_backplane_anlt: ethernet-phy@7 {
> +            compatible = "fsl,lx2160a-backplane-anlt",
> +                          "ethernet-phy-ieee802.3-c45";
> +            reg = <7>; /* according to ANLTDCR1[MDEV_PORT] */
> +            phys = <&serdes_1 3>; /* lane D */
> +            max-speed = <40000>;
> +            pcs-handle = <&pcs2>;
> +            secondary-anlt-handle = <&mac2_lane2_anlt>, <&mac2_lane3_anlt>,
> +                                    <&mac2_lane4_anlt>;
> +        };
> +
> +        mac2_lane2_anlt: ethernet-backplane-anlt@6 {
> +            compatible = "fsl,lx2160a-secondary-anlt";
> +            reg = <6>; /* according to ANLTCCR1[MDEV_PORT] */
> +            phys = <&serdes_1 2>; /* lane C */
> +        };
> +
> +        mac2_lane3_anlt: ethernet-backplane-anlt@5 {
> +            compatible = "fsl,lx2160a-secondary-anlt";
> +            reg = <5>; /* according to ANLTBCR1[MDEV_PORT] */
> +            phys = <&serdes_1 1>; /* lane B */
> +        };
> +
> +        mac2_lane4_anlt: ethernet-backplane-anlt@4 {
> +            compatible = "fsl,lx2160a-secondary-anlt";
> +            reg = <4>; /* according to ANLTACR1[MDEV_PORT] */
> +            phys = <&serdes_1 0>; /* lane A */
> +        };
> +    };
> +
> +  # LX2160A lane E with SerDes 1 protocol 19: dpmac6 uses 25GBase-KR
> +  - |
> +    dpmac6 {
> +        phy-handle = <&mac6_backplane_anlt>;
> +        phy-connection-type = "internal";
> +    };
> +
> +    pcs_mdio6 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";
> +
> +        pcs6: ethernet-phy@0 {
> +            reg = <0>;
> +        };
> +
> +        mac6_backplane_anlt: ethernet-phy@4 {
> +            compatible = "fsl,lx2160a-backplane-anlt",
> +                          "ethernet-phy-ieee802.3-c45";
> +            reg = <4>; /* according to ANLTFCR1[MDEV_PORT] */
> +            phys = <&serdes_1 4>; /* lane E */
> +            max-speed = <25000>;
> +            pcs-handle = <&pcs6>;
> +        };
> +    };
> +
> +  # LX2160A lane F with SerDes 1 protocol 19: dpmac5 uses 25GBase-KR
> +  - |
> +    dpmac5 {
> +        phy-handle = <&mac5_backplane_anlt>;
> +        phy-connection-type = "internal";
> +    };
> +
> +    pcs_mdio5 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";
> +
> +        pcs5: ethernet-phy@0 {
> +            reg = <0>;
> +        };
> +
> +        mac5_backplane_anlt: ethernet-phy@5 {
> +            compatible = "fsl,lx2160a-backplane-anlt",
> +                         "ethernet-phy-ieee802.3-c45";
> +            reg = <5>; /* according to ANLTFCR1[MDEV_PORT] */
> +            phys = <&serdes_1 5>; /* lane F */
> +            max-speed = <25000>;
> +            pcs-handle = <&pcs5>;
> +        };
> +    };
> +
> +  # LX2160A lane G with SerDes 1 protocol 19: dpmac4 uses 10GBase-KR
> +  - |
> +    dpmac4 {
> +        phy-handle = <&mac4_backplane_anlt>;
> +        phy-connection-type = "internal";
> +    };
> +
> +    pcs_mdio4 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";
> +
> +        mac4_backplane_anlt: ethernet-phy@0 {
> +            compatible = "fsl,lx2160a-backplane-anlt",
> +                         "ethernet-phy-ieee802.3-c45";
> +            reg = <0>; /* merged with PCS SXGMIIGCR1[MDEV_PORT] */
> +            phys = <&serdes_1 7>; /* lane G */
> +            max-speed = <10000>;
> +            /* no pcs-handle to &pcs4 */
> +        };
> +    };
> +
> +  # LX2160A lane H with SerDes 1 protocol 19: dpmac3 uses 10GBase-KR
> +  - |
> +    dpmac3 {
> +        phy-handle = <&mac3_backplane_anlt>;
> +        phy-connection-type = "internal";
> +    };
> +
> +    pcs_mdio3 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";
> +
> +        mac3_backplane_anlt: ethernet-phy@0 {
> +            compatible = "fsl,lx2160a-backplane-anlt",
> +                         "ethernet-phy-ieee802.3-c45";
> +            reg = <0>; /* merged with PCS SXGMIIHCR1[MDEV_PORT] */
> +            phys = <&serdes_1 7>; /* lane H */
> +            max-speed = <10000>;
> +            /* no pcs-handle to &pcs3 */
> +        };
> +    };

5 examples yet not one for "fsl,lx2160a-secondary-anlt"

