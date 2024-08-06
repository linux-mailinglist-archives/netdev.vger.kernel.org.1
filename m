Return-Path: <netdev+bounces-116138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00B49493F9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF251C21504
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F31D54F9;
	Tue,  6 Aug 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV4GqNrJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C71BC08F;
	Tue,  6 Aug 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956270; cv=none; b=ZGNcfpwbPzRRqQRRNSikM7NT27x2TsvM+23w77Wtcg/zjw4CuBZJWDDjd9j/Bq6chh7JJ7RJC0OGyK3Msw6akbQLrwotUeIdsX9njcFVun6i+6nvQNiWtmEM0fuUhk5e+8j4uUj80YwVIXBMg5tb8nWRHj/kEJCs0cNuj79veFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956270; c=relaxed/simple;
	bh=WvUKeYGEnDCMv+ueazaSl3PBo1+JLiRTjhrQ6VKYw0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnNfSHwymi0GpJFC1Ub3ZzGQwQPnW+fBpE5IcaYZPqSKCw8RzigMqSOx4CeCjOfivaOMDOFWM99pMeeZ3XmDUi2MC39Za8DF70yvBU/VSxI375EcbQfycX+ToGWBWD59OoYkNxalzdKJR43MSLord1yedjwOTA0SBTvNHLsb2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV4GqNrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AADC4AF12;
	Tue,  6 Aug 2024 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722956270;
	bh=WvUKeYGEnDCMv+ueazaSl3PBo1+JLiRTjhrQ6VKYw0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rV4GqNrJfetI/fwIhKY+0Wo5JSVDXU4OgOt9bnDmMHKmri6JYdaWmUF5bZxtGCEQB
	 e4yzlsC5qpzB6Xn6lDkrKsrqxpHikymw0WYNJUcspOQNFGWJ0FRtP02OM9AMAZQrl0
	 L7rop4/B1k0t6PoOat3/X9rRz4Q0UK7KQkMnxP4KAIIlTUXRyKKS+FhWqKt90Na8OW
	 qOzEnC6xD8dmQGece5TAEWe6zkiIGooO62y0PCNkQRI3Dvx7aLQbylH67f5LYO1r5R
	 Ab6Z/OcZTY5VHXQOCEggiW+zfKaHT4NIfsQmMZm9XWmuZvfFoJ9j+yQ3J0r0yUWn5G
	 QzinxQ5lWN3BA==
Date: Tue, 6 Aug 2024 08:57:48 -0600
From: Rob Herring <robh@kernel.org>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org,
	richardcochran@gmail.com, mcoquelin.stm32@gmail.com, andrew@lunn.ch,
	alim.akhtar@samsung.com, linux-fsd@tesla.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <20240806145748.GA1502402-robh@kernel.org>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092855epcas5p49902519f31bddcfe7da8f4b96a7d0527@epcas5p4.samsung.com>
 <20240730091648.72322-2-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730091648.72322-2-swathi.ks@samsung.com>

On Tue, Jul 30, 2024 at 02:46:45PM +0530, Swathi K S wrote:
> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> Ethernet YAML schema to enable the DT validation.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +-
>  .../devicetree/bindings/net/tesla,ethqos.yaml | 91 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3eb65e63fdae..0da11fe98cec 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -98,6 +98,7 @@ properties:
>          - snps,dwxgmac-2.10
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> +        - tesla,fsd-ethqos
>  
>    reg:
>      minItems: 1
> @@ -121,7 +122,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      items:
>        - description: GMAC main clock
> @@ -133,7 +134,7 @@ properties:
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      contains:
>        enum:
> diff --git a/Documentation/devicetree/bindings/net/tesla,ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> new file mode 100644
> index 000000000000..9246b0395126
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/tesla,ethqos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FSD Ethernet Quality of Service
> +
> +maintainers:
> +  - Swathi K S <swathi.ks@samsung.com>
> +
> +description:
> +  dwmmac based tesla ethernet devices which support Gigabit
> +  ethernet.

Please write complete sentences.

> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    const: tesla,fsd-ethqos.yaml

???

Filename matching compatible means for compatible string 
"tesla,fsd-ethqos" the filename should be tesla,fsd-ethqos.yaml.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 5
> +    maxItems: 10
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 10
> +
> +  iommus:
> +    maxItems: 1
> +
> +  phy-mode:
> +    $ref: ethernet-controller.yaml#/properties/phy-connection-type

No need for this. phy-mode should already be included by snps,dwmac.yaml 
including ethernet-controller.yaml.

Though you may want to define what subset of modes are valid.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - phy-mode
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ethernet_1: ethernet@14300000 {

Drop unused label.

> +              compatible = "tesla,fsd-ethqos";
> +              reg = <0x0 0x14300000 0x0 0x10000>;
> +              interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +              clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
> +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
> +                       <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
> +                       <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
> +                       <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
> +                       <&clock_peric PERIC_EQOS_PHYRXCLK>,
> +                       <&clock_peric PERIC_DOUT_RGMII_CLK>;
> +              clock-names = "ptp_ref",
> +                            "master_bus",
> +                            "slave_bus",
> +                            "tx",
> +                            "rx",
> +                            "master2_bus",
> +                            "slave2_bus",
> +                            "eqos_rxclk_mux",
> +                            "eqos_phyrxclk",
> +                            "dout_peric_rgmii_clk";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
> +                          <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
> +                          <&eth1_rx_ctrl>, <&eth1_mdio>;
> +              iommus = <&smmu_peric 0x0 0x1>;
> +              phy-mode = "rgmii-id";
> +    };
> +
> +...
> -- 
> 2.17.1
> 

