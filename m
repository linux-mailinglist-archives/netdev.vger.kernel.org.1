Return-Path: <netdev+bounces-174001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BCA5CF4A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDF17BF5E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C502641C5;
	Tue, 11 Mar 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBM4xUAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C7263F57;
	Tue, 11 Mar 2025 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721119; cv=none; b=abROye+OCffiLMotP32hyHLKajECzkn4SnKT3ebgyVNTrIvkmjgVFmTtOUB90VfsG67fpjkD1dRTK2YR+xhsrwARgauYCCKa9pbY1rEK3gqinK5m0HrV+Ki6CHUa6hRSyhFquMEuUQcMsL3QvwiFgyO/ygk2ivU55Ny1xphDbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721119; c=relaxed/simple;
	bh=vD3EacD3StgEcdCEuMUQ5gzplQWLkIqq1FTPEZvPzfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3TYis5yYbOD8T3ZFlWKhyVGjDvRn6mw7hPVZB85sByCp/tueOBSUUzYCu/g4MijmlVRAJE7ed8IPv9wF5otVj47noC05R/aCJeNfzsY/biEpsmaCB7EW89ekOxHttgJ32spD6SrPkPX9KObyg+pmbI6Mc9TJU8wXwP/BhmlKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBM4xUAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D2C4CEEA;
	Tue, 11 Mar 2025 19:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721117;
	bh=vD3EacD3StgEcdCEuMUQ5gzplQWLkIqq1FTPEZvPzfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBM4xUAkTUSoMvHUEAgRz6yN/W5RI7I4V2p83akIVmnAM7QsIcAQaLXlHr1vNn+QI
	 5ETwOeuCX4I/89nK2A3vphN/bUIz+tf2148c+5xZ3vXPv6lgLe5v+vHHHDmsBwj3si
	 WoVutHIgmQxZJY4o1F7Csp/tbW73xacT4HqG/1aCzmKtHyOp+KUJ/ZVwun/V1yNyIw
	 QtJygu4ryRR69VbveplcuNR3T4RwYAuI8Eu/J5EIRDoBt1I03+2WF5O2z88ny9J4iB
	 7vKswfiVOdbxC0slpftaFCpGE7eYEI9pqM7AUQtJ86jQsD0xpcSZQ8cvUZiTvbTNGf
	 mGuBLNFZmp07g==
Date: Tue, 11 Mar 2025 14:25:16 -0500
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 04/13] dt-bindings: net: Document support
 for AN8855 Switch Internal PHY
Message-ID: <20250311192516.GA4115176-robh@kernel.org>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-5-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 06:26:49PM +0100, Christian Marangi wrote:
> Document support for AN8855 Switch Internal PHY.
> 
> Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
> PHYs on the MDIO bus.
> 
> Each PHY might need to be calibrated to correctly work with the
> use of the eFUSE provided by the Switch SoC. This can be enabled by
> defining in the PHY node the "airoha,ext-surge" property.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an8855-phy.yaml       | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> new file mode 100644
> index 000000000000..301c46f84904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Switch Internal PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
> +  PHYs on the MDIO bus.
> +
> +  Each PHY might need to be calibrated to correctly work with the
> +  use of the eFUSE provided by the Switch SoC.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-idc0ff.0410
> +  required:
> +    - compatible
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  airoha,ext-surge:
> +    description: enable PHY calibration with the use of SoC eFUSE.

Wouldn't nvmem-cells presence enable this?

> +
> +  nvmem-cells:
> +    items:
> +      - description: phandle to SoC eFUSE tx_a
> +      - description: phandle to SoC eFUSE tx_b
> +      - description: phandle to SoC eFUSE tx_c
> +      - description: phandle to SoC eFUSE tx_d
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: tx_a
> +      - const: tx_b
> +      - const: tx_c
> +      - const: tx_d
> +
> +required:
> +  - compatible
> +  - reg
> +
> +if:
> +  required:
> +    - airoha,ext-surge
> +then:
> +  required:
> +    - nvmem-cells
> +    - nvmem-cell-names

dependentRequired:
  airoha,ext-surge: [ nvmem-cells, nvmem-cell-names ]

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@1 {
> +            compatible = "ethernet-phy-idc0ff.0410",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg = <1>;
> +        };
> +
> +        ethernet-phy@2 {
> +            compatible = "ethernet-phy-idc0ff.0410",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg = <2>;
> +
> +            airoha,ext-surge;
> +
> +            nvmem-cells = <&shift_sel_port0_tx_a>,
> +                <&shift_sel_port0_tx_b>,
> +                <&shift_sel_port0_tx_c>,
> +                <&shift_sel_port0_tx_d>;
> +            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 696ad8465ea8..45f4bb8deb0d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -726,6 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> +F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
>  F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
>  F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
>  
> -- 
> 2.48.1
> 

