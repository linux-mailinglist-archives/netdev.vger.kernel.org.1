Return-Path: <netdev+bounces-101186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4318FDA81
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F333286133
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259221667EE;
	Wed,  5 Jun 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiC7jkMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CE2AE7F;
	Wed,  5 Jun 2024 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630160; cv=none; b=h/iW7f/ui2VP2vA6EBCaj7hwITW8EMNtEjuyOcNwhwWHomlU0Khat/ldD90eZmTllodxVqKz6hugGlvKkniFSG4PKjA/7e8+ipQ1CT1SGNlU4d08vGAxjdhrNsBzw5VArSqKyvwiZzXwp1L17gNpmkqMbEj8Xh1k2os239CwMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630160; c=relaxed/simple;
	bh=XJoNnLa6bSjUpsAGuvnYZUrq8gMdzN/n/FdfKk2N5n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKvV0+48dCW4d3iRWGYWZHvaghFnNnnMGeZ/cczD2yzKSEy4jd0Mxs1B8gIKCNipEQGh8QiyQA8gVTpBAK/yp7gCogk4mpnucpABRHxLHebi8o23BaF/TBH9N6RSlI9JGsF/kmU2J+WG5pnjuozorl3u0VcKCOjF1smrOC3QNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiC7jkMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F23FC2BD11;
	Wed,  5 Jun 2024 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717630159;
	bh=XJoNnLa6bSjUpsAGuvnYZUrq8gMdzN/n/FdfKk2N5n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiC7jkMYzVmu4VMMt3O1dP83DWyLAQ33RZbx5KsVs7YE7Wdp0SumwfzRYsmKdD5R1
	 Zhki8J8/jp6F6SpSxSKohmE0JEEVOAKdNtNp4zxXMHPAUDmTrqHQ+d4ZtzdkSHRcx5
	 vg7bJdzoz4xt/AP0tDYa0TXvyoY0vazD7FTMdWv4+27W1udL5JZvthrgakw/PhYcKX
	 GIfZRVKMuqYXTuxSshw2Owl7J6MHHMTNmK/2AFtyloBMcseHJBtY2rafbCl0EnPKOJ
	 Fg6Xo5uXh/qxESg+lxH3JZfmw0wjgRndwOWXpV1d4wL+qqnbvRa+ieYusVa9rUn/2F
	 NCjzAKOAkOVZg==
Date: Wed, 5 Jun 2024 17:29:16 -0600
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20240605232916.GA3400992-robh@kernel.org>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-7-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602143636.5839-7-fancer.lancer@gmail.com>

On Sun, Jun 02, 2024 at 05:36:20PM +0300, Serge Semin wrote:
> Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> providing an interface between the Media Access Control (MAC) and Physical
> Medium Attachment Sublayer (PMA) through a Media independent interface.
> >From software point of view it exposes IEEE std. Clause 45 CSR space and
> can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
> case the PCS device is supposed to be defined under the respective MDIO
> bus DT-node. In the later case the DW xPCS will be just a normal IO
> memory-mapped device.
> 
> Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
> source properties specified. The former one indicates the Clause 73/37
> auto-negotiation events like: negotiation page received, AN is completed
> or incompatible link partner. The clock DT-properties can describe up to
> three clock sources: peripheral bus clock source, internal reference clock
> and the externally connected reference clock.
> 
> Finally the DW XPCS IP-core can be optionally synthesized with a
> vendor-specific interface connected to the Synopsys PMA (also called
> DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
> portable way. So if the DW XPCS device has the respective PMA attached
> then it should be reflected in the DT-node compatible string so the driver
> would be aware of the PMA-specific device capabilities (mainly connected
> with CSRs available for the fine-tunings).
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Changelog v2:
> - Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
>   interface is just a normal memory-mapped device.
> ---
>  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> new file mode 100644
> index 000000000000..7927bceefbf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare Ethernet PCS
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> +  between Media Access Control and Physical Medium Attachment Sublayer through
> +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> +  optionally synthesized with a vendor-specific interface connected to
> +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> +  general it can be used to communicate with any compatible PHY.
> +
> +  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
> +  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
> +  right to the system IO memory space.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> +        const: snps,dw-xpcs
> +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> +        const: snps,dw-xpcs-gen1-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> +        const: snps,dw-xpcs-gen2-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> +        const: snps,dw-xpcs-gen2-6g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> +        const: snps,dw-xpcs-gen4-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> +        const: snps,dw-xpcs-gen4-6g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> +        const: snps,dw-xpcs-gen5-10g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> +        const: snps,dw-xpcs-gen5-12g
> +
> +  reg:
> +    items:
> +      - description:
> +          In case of the MDIO management interface this just a 5-bits ID
> +          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
> +          MCI or APB3 management interfaces, then the space mapping can be
> +          either 'direct' or 'indirect'. In the former case all Clause 45
> +          registers are contiguously mapped within the address space
> +          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
> +          to the multiple 256 register sets. There is a special viewport CSR
> +          which is responsible for the set selection. The upper part of
> +          the CSR address MMD+REG[20:8] is supposed to be written in there
> +          so the corresponding subset would be mapped to the lowest 255 CSRs.
> +
> +  reg-names:
> +    items:
> +      - enum: [ direct, indirect ]
> +
> +  reg-io-width:
> +    description:
> +      The way the CSRs are mapped to the memory is platform depended. Since
> +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> +      two bytes aligned at least.
> +    default: 2
> +    enum: [ 2, 4 ]
> +
> +  interrupts:
> +    description:
> +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> +      auto-negotiation events':' Page received, AN is completed or incompatible
> +      link partner.
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> +      source connected via the clk_csr_i line.
> +
> +      PCS/PMA layer can be clocked by an internal reference clock source
> +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> +      generator. Both clocks can be supplied at a time.
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +    anyOf:
> +      - items:
> +          enum: [ core, pad ]

This has no effect. If it is true, then the 2nd entry is too.

You are saying all the clocks are optional and any combination/order is 
valid. Do we really need it so flexible? Doubtful the h/w is that 
flexible.

> +      - items:
> +          enum: [ pclk, core, pad ]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ethernet-pcs@1f05d000 {
> +      compatible = "snps,dw-xpcs";
> +      reg = <0x1f05d000 0x1000>;
> +      reg-names = "indirect";
> +
> +      reg-io-width = <4>;
> +
> +      interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      clocks = <&ccu_pclk>, <&ccu_core>, <&ccu_pad>;
> +      clock-names = "pclk", "core", "pad";
> +    };
> +  - |
> +    mdio-bus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet-pcs@0 {
> +        compatible = "snps,dw-xpcs";
> +        reg = <0>;
> +
> +        clocks = <&ccu_core>, <&ccu_pad>;
> +        clock-names = "core", "pad";
> +      };
> +    };
> +...
> -- 
> 2.43.0
> 

