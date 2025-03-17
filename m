Return-Path: <netdev+bounces-175331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F43A6538F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D70165913
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D844241674;
	Mon, 17 Mar 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M67Ms5tR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3184241129;
	Mon, 17 Mar 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221714; cv=none; b=uPE/SSBffDu/lHjrwbTJCxClt/MLDf1k4W42t0CdQva7BBiHVJ3WgR8BMYSET21be9E3RdIW1O8Gc8Y7K210NFDH4z8bl5S6RRq+Wem0LqNN/hoUtsXYRZ8PKTS7Epw/jCNbzpY4aG5F53olafIatcKGwuodoJo7SQyaWryklq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221714; c=relaxed/simple;
	bh=icj7nB3bxRTzLn+Ln71aWFZgRw7kuWe4zA5Mo+qp1Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwRw6+BeAWRBCC/zO1rXTP/hFXKyowdj7v5zNASGCTyh2Er73PvB/iZCjEQimUwGYb7bip+aApTc9OK8sq5SRXZv9BDnUOZbZbbqj1PgcrmDcZAIRIbDoff7YgJbH28egBmUAJtYC/PzyM3Es3jcfCvRmcTflTbvRKGBxw7tAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M67Ms5tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C08C4CEE3;
	Mon, 17 Mar 2025 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742221714;
	bh=icj7nB3bxRTzLn+Ln71aWFZgRw7kuWe4zA5Mo+qp1Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M67Ms5tRtJqZNjr4HpbUvBavc5Q4oDs6jmFypIre7oRXBHxSlAr+Ij/96AkfPIy/k
	 x3XKqTWIt5StT89G2yFALXMp5n0Dc2R9d1XGVmIYjb8obSfGtSL9i5zA8rIbfwo86j
	 Hn3twjfJj7Lw4RRZyu7iC4/sPmt8VFW26lvCec+S3Qqy+DafKkfinjfO+E6iAXte1H
	 w+06FBgdTb+o42RcpsUV2/jVRV3RE0mvvBIqVls1VFsRXhpIzNwBW/qbSuE4pyUyf1
	 OEd6vE30XljVHM23pWPS1rZpl/UJpX8OyVtdeiP0tZHCPLt0oC6A1AMkT5ogO+2g/D
	 kFhsg8FMePZbA==
Date: Mon, 17 Mar 2025 09:28:32 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v13 05/14] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC
Message-ID: <20250317142832.GA4116523-robh@kernel.org>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315154407.26304-6-ansuelsmth@gmail.com>

On Sat, Mar 15, 2025 at 04:43:45PM +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 182 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> new file mode 100644
> index 000000000000..a59a23056b3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Switch SoC
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 Switch is a SoC that expose various peripherals like an
> +  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> +
> +  It does also support i2c and timers but those are not currently
> +  supported/used.
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +
> +  efuse:
> +    type: object
> +    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
> +    description:
> +      EFUSE exposed by the Airoha AN8855 Switch. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml

No need to list the schema twice. Drop the 2nd sentence.

> +
> +  ethernet-switch:
> +    type: object
> +    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
> +    description:
> +      Switch exposed by the Airoha AN8855 Switch. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

ditto

> +
> +  mdio:
> +    type: object
> +    $ref: /schemas/net/airoha,an8855-mdio.yaml
> +    description:
> +      MDIO exposed by the Airoha AN8855 Switch. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml

ditto

> +
> +required:
> +  - compatible
> +  - reg

The child nodes are optional?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        soc@1 {
> +            compatible = "airoha,an8855";
> +            reg = <1>;
> +
> +            reset-gpios = <&pio 39 0>;
> +
> +            efuse {
> +                compatible = "airoha,an8855-efuse";
> +
> +                #nvmem-cell-cells = <0>;
> +
> +                nvmem-layout {
> +                    compatible = "fixed-layout";
> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +
> +                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
> +                       reg = <0xc 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
> +                        reg = <0x10 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
> +                        reg = <0x14 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
> +                       reg = <0x18 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
> +                        reg = <0x1c 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
> +                        reg = <0x20 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
> +                       reg = <0x24 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
> +                        reg = <0x28 0x4>;
> +                    };
> +                };
> +            };
> +
> +            ethernet-switch {
> +                compatible = "airoha,an8855-switch";
> +
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                        reg = <0>;
> +                        label = "lan1";
> +                        phy-mode = "internal";
> +                        phy-handle = <&internal_phy1>;
> +                    };
> +
> +                    port@1 {
> +                        reg = <1>;
> +                        label = "lan2";
> +                        phy-mode = "internal";
> +                        phy-handle = <&internal_phy2>;
> +                    };
> +
> +                    port@5 {
> +                        reg = <5>;
> +                        label = "cpu";
> +                        ethernet = <&gmac0>;
> +                        phy-mode = "2500base-x";
> +
> +                        fixed-link {
> +                            speed = <2500>;
> +                            full-duplex;
> +                            pause;
> +                        };
> +                    };
> +                };
> +            };
> +
> +            mdio {
> +                compatible = "airoha,an8855-mdio";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy1: phy@1 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c45";
> +                  reg = <1>;
> +
> +                  nvmem-cells = <&shift_sel_port0_tx_a>,
> +                      <&shift_sel_port0_tx_b>,
> +                      <&shift_sel_port0_tx_c>,
> +                      <&shift_sel_port0_tx_d>;
> +                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +
> +                internal_phy2: phy@2 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c45";
> +                  reg = <2>;
> +
> +                  nvmem-cells = <&shift_sel_port1_tx_a>,
> +                      <&shift_sel_port1_tx_b>,
> +                      <&shift_sel_port1_tx_c>,
> +                      <&shift_sel_port1_tx_d>;
> +                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45f4bb8deb0d..65709e47adc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -725,6 +725,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
>  F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
>  F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
>  F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> -- 
> 2.48.1
> 

