Return-Path: <netdev+bounces-186124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2236A9D411
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42B37B3592
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA511224AFC;
	Fri, 25 Apr 2025 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD9ko8Xi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA22248B5;
	Fri, 25 Apr 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615960; cv=none; b=DfXewt6XfUTk93YRgJztREMCeiyEbVmgdytX7c8dFlm6eSXe2gjW2mRn2GhSSP6D6rEPW4UqfY9hZb1BzTQsYj1CklZAIkDV8ms8WJMXtcvYiEhOthUewpDjSdIUvPh84L4rndbSD+rT9JMTb9jFkEOPQPQwHu2BETPMOhbpb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615960; c=relaxed/simple;
	bh=b9bm/p8zSpCIfixDbHrqSOd8EYP29vfm3KZGTV072So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFWgtZP9SJK4rfFjMMldG32Kw5iQQHMZRLYDf+iLqcT+mBUHdsDmDrTAPVCpAK4PNd+cRf9R7CU/Skl2JZ1pOSVyay+OeE5YP5/7uqsMLSO9YW/lWITysboQZNfaywZC4rm7/LE6slXqBEXOBbWseodz62xGigd6Iue9obnKOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD9ko8Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428BC4CEE4;
	Fri, 25 Apr 2025 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745615959;
	bh=b9bm/p8zSpCIfixDbHrqSOd8EYP29vfm3KZGTV072So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RD9ko8Xif61xELtnsNDb/QNzYZzYZ49tUz/ommuRJVDqjIQb4hd0l1OEANf+99VnX
	 CvRlZ4XFslnHOoKOZqfoh3Skplj2QGOjyucPY2u8iKj6yNvCoUDZfqf36d6swDpx1A
	 xEAd4wMOm9xtaVOYP5YC0RfFp9V+n6LbzE4i3URXxQJEtLYCDXTz/czEExCg0zIeMa
	 2Dmdbt7H2NP/U3n+ivhCektD/CFSnEHJ0/shaAlDYPw6CJhnqrRogb8EwHLPaJIWHM
	 aDzhVEC7rubrd1FbCZ8rvsdyHJBzliLZSr9U55CLP9ihuiBMa+8nwPOEsFjWO9+T52
	 AmsCAvTaEeziA==
Date: Fri, 25 Apr 2025 16:19:17 -0500
From: Rob Herring <robh@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	nm@ti.com, ssantosh@kernel.org, tony@atomide.com,
	richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	horms@kernel.org, jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v6 01/11] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Message-ID: <20250425211917.GA3108205-robh@kernel.org>
References: <20250423060707.145166-1-parvathi@couthit.com>
 <20250423060707.145166-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423060707.145166-2-parvathi@couthit.com>

On Wed, Apr 23, 2025 at 11:36:57AM +0530, Parvathi Pudi wrote:
> Documentation update for the newly added "pruss2_eth" device tree
> node and its dependencies along with compatibility for PRU-ICSS
> Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
> (eCAP) peripheral and using YAML binding document for AM57xx SoCs.
> 
> Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  10 +-
>  .../bindings/net/ti,icssm-prueth.yaml         | 233 ++++++++++++++++++
>  .../bindings/net/ti,pruss-ecap.yaml           |  32 +++
>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 +
>  4 files changed, 281 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> index e36e3a622904..ea2659d90a52 100644
> --- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> @@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
>  
>  maintainers:
>    - Md Danish Anwar <danishanwar@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
>  
>  properties:
>    compatible:
> @@ -17,9 +19,11 @@ properties:
>                - ti,am642-icss-iep
>                - ti,j721e-icss-iep
>            - const: ti,am654-icss-iep
> -
> -      - const: ti,am654-icss-iep
> -
> +      - enum:
> +          - ti,am654-icss-iep
> +          - ti,am5728-icss-iep
> +          - ti,am4376-icss-iep
> +          - ti,am3356-icss-iep
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> new file mode 100644
> index 000000000000..d42aea70eb76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> @@ -0,0 +1,233 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,icssm-prueth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ICSSM PRUSS Ethernet
> +
> +maintainers:
> +  - Roger Quadros <rogerq@ti.com>
> +  - Andrew F. Davis <afd@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
> +
> +description:
> +  Ethernet based on the Programmable Real-Time Unit and Industrial
> +  Communication Subsystem.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am57-prueth     # for AM57x SoC family
> +      - ti,am4376-prueth   # for AM43x SoC family
> +      - ti,am3359-prueth   # for AM33x SoC family
> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to OCMC SRAM node
> +
> +  ti,mii-rt:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to MII_RT module's syscon regmap

regmap is a Linuxism. Say what functionality you need from this block.

> +
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSS
> +
> +  ti,ecap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to Enhanced Capture (eCAP) event for ICSS
> +
> +  interrupts:
> +    items:
> +      - description: High priority Rx Interrupt specifier.
> +      - description: Low priority Rx Interrupt specifier.
> +
> +  interrupt-names:
> +    items:
> +      - const: rx_hp
> +      - const: rx_lp
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      ^ethernet-port@[0-1]$:
> +        type: object
> +        description: ICSSM PRUETH external ports
> +        $ref: ethernet-controller.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            items:
> +              - enum: [0, 1]
> +            description: ICSSM PRUETH port number
> +
> +          interrupts:
> +            maxItems: 3
> +
> +          interrupt-names:
> +            items:
> +              - const: rx
> +              - const: emac_ptp_tx
> +              - const: hsr_ptp_tx
> +
> +        required:
> +          - reg
> +
> +    anyOf:
> +      - required:
> +          - ethernet-port@0
> +      - required:
> +          - ethernet-port@1
> +
> +required:
> +  - compatible
> +  - sram
> +  - ti,mii-rt
> +  - ti,iep
> +  - ti,ecap
> +  - ethernet-ports
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    /* Dual-MAC Ethernet application node on PRU-ICSS2 */
> +    pruss2_eth: pruss2-eth {

Drop unused labels.

> +      compatible = "ti,am57-prueth";
> +      ti,prus = <&pru2_0>, <&pru2_1>;
> +      sram = <&ocmcram1>;
> +      ti,mii-rt = <&pruss2_mii_rt>;
> +      ti,iep = <&pruss2_iep>;
> +      ti,ecap = <&pruss2_ecap>;
> +      interrupts = <20 2 2>, <21 3 3>;
> +      interrupt-names = "rx_hp", "rx_lp";
> +      interrupt-parent = <&pruss2_intc>;
> +
> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pruss2_emac0: ethernet-port@0 {
> +          reg = <0>;
> +          phy-handle = <&pruss2_eth0_phy>;
> +          phy-mode = "mii";
> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +
> +        pruss2_emac1: ethernet-port@1 {
> +          reg = <1>;
> +          phy-handle = <&pruss2_eth1_phy>;
> +          phy-mode = "mii";
> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +      };
> +    };
> +  - |
> +    /* Dual-MAC Ethernet application node on PRU-ICSS1 */
> +    pruss1_eth: pruss1-eth {
> +      compatible = "ti,am4376-prueth";
> +      ti,prus = <&pru1_0>, <&pru1_1>;
> +      sram = <&ocmcram>;
> +      ti,mii-rt = <&pruss1_mii_rt>;
> +      ti,iep = <&pruss1_iep>;
> +      ti,ecap = <&pruss1_ecap>;
> +      interrupts = <20 2 2>, <21 3 3>;
> +      interrupt-names = "rx_hp", "rx_lp";
> +      interrupt-parent = <&pruss1_intc>;
> +
> +      pinctrl-0 = <&pruss1_eth_default>;
> +      pinctrl-names = "default";
> +
> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pruss1_emac0: ethernet-port@0 {
> +          reg = <0>;
> +          phy-handle = <&pruss1_eth0_phy>;
> +          phy-mode = "mii";
> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
> +          interrupt-names = "rx", "emac_ptp_tx",
> +                                          "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +
> +        pruss1_emac1: ethernet-port@1 {
> +          reg = <1>;
> +          phy-handle = <&pruss1_eth1_phy>;
> +          phy-mode = "mii";
> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
> +          interrupt-names = "rx", "emac_ptp_tx",
> +                                          "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +      };
> +    };
> +  - |
> +    /* Dual-MAC Ethernet application node on PRU-ICSS */
> +    pruss_eth: pruss-eth {

Really need 3 examples?

> +      compatible = "ti,am3359-prueth";
> +      ti,prus = <&pru0>, <&pru1>;
> +      sram = <&ocmcram>;
> +      ti,mii-rt = <&pruss_mii_rt>;
> +      ti,iep = <&pruss_iep>;
> +      ti,ecap = <&pruss_ecap>;
> +      interrupts = <20 2 2>, <21 3 3>;
> +      interrupt-names = "rx_hp", "rx_lp";
> +      interrupt-parent = <&pruss_intc>;
> +
> +      pinctrl-0 = <&pruss_eth_default>;
> +      pinctrl-names = "default";
> +
> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pruss_emac0: ethernet-port@0 {
> +          reg = <0>;
> +          phy-handle = <&pruss_eth0_phy>;
> +          phy-mode = "mii";
> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
> +          interrupt-names = "rx", "emac_ptp_tx",
> +                                          "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +
> +        pruss_emac1: ethernet-port@1 {
> +          reg = <1>;
> +          phy-handle = <&pruss_eth1_phy>;
> +          phy-mode = "mii";
> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
> +          interrupt-names = "rx", "emac_ptp_tx",
> +                                          "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> new file mode 100644
> index 000000000000..42f217099b2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,pruss-ecap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments PRU-ICSS Enhanced Capture (eCAP) event module
> +
> +maintainers:
> +  - Murali Karicheri <m-karicheri2@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
> +
> +properties:
> +  compatible:
> +    const: ti,pruss-ecap
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pruss2_ecap: ecap@30000 {
> +        compatible = "ti,pruss-ecap";
> +        reg = <0x30000 0x60>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index 927b3200e29e..594f54264a8c 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -251,6 +251,15 @@ patternProperties:
>  
>      type: object
>  
> +  ecap@[a-f0-9]+$:
> +    description:
> +      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
> +      and capture periodic timer based events which will be used for features
> +      like RX Pacing to rise interrupt when the timer event has occurred.
> +      Each PRU-ICSS instance has one eCAP modeule irrespective of SOCs.
> +
> +    type: object

This should either have a ref to ti,pruss-ecap.yaml or should just move 
reg and compatible here since it is only 2 properties.

> +
>    mii-rt@[a-f0-9]+$:
>      description: |
>        Real-Time Ethernet to support multiple industrial communication protocols.
> -- 
> 2.34.1
> 

