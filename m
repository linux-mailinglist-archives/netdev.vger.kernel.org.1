Return-Path: <netdev+bounces-149988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A849E8622
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400F21647CF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28616155A30;
	Sun,  8 Dec 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="btlmEvN7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99913B2B6;
	Sun,  8 Dec 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673798; cv=none; b=jZpe1sd6jvuVb7kd52iLPnAvmIsmec+EsFSKGdoxbZSIWcCylgjvzq+5NJks4cHbJyWLv3/wgofoc09dHgtVcnvyYnKCVq2NMl4ioLkESlQY3ShgOAITUn07wn4SRUCfgVDAJbyU6SfXczBMnWj3lsLKTSkfB6xZ1KPx6+lKwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673798; c=relaxed/simple;
	bh=GaFyTA7f+D92e8/6ECS9c1uYp74xBQ0xKi3Wf9y3Ieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNStrWNnsKfbTDA2lGfMSjNVDaL6SkdpuPnh3ttnIp0OGCWIZo6bwU+v52gOPrpFuFEEYMSdT8efT/MT25dg/LlqxrqwkPSPxrMz9Wz5w5HACLncCqQtN6HjeDLhZYDAhLgvctaIG5hWDAJNdh/CKg0Agw15kFDe+pCMCVgzUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=btlmEvN7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VZ8VRmiKJwkt/GYZB70TA69WOCgOy6/6A6FCtWbmeu4=; b=btlmEvN7EvWs2yI3x1wGfGlvQk
	qNjp3GT9mYlIiZxcbrRufWO4s0XRmZRSM2zw+V+/0NGcA4ZJYh0ppcKvrXpEaXQ1Xl2Z/XX/2wocq
	OOQJU9f56/RQCF3DfYx8ckJIZ7qOEJpn/GTtd3ImEInmC0s2HwuNLkqf64T/pcbXR+hI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKJk8-00FZvL-Nc; Sun, 08 Dec 2024 17:02:48 +0100
Date: Sun, 8 Dec 2024 17:02:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v10 2/9] dt-bindings: net: Document support for
 Airoha AN8855 Switch Virtual MDIO
Message-ID: <656c4f9d-ff6b-4c98-84f4-d20b6e562c13@lunn.ch>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208002105.18074-3-ansuelsmth@gmail.com>

On Sun, Dec 08, 2024 at 01:20:37AM +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed
> as AN8855 require special handling as the same address on the MDIO bus is
> shared for both Switch and PHY and special handling for the page
> configuration is needed to switch accessing to Switch address space
> or PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an8855-mdio.yaml      | 86 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> new file mode 100644
> index 000000000000..2211df3cc3b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 MDIO Passtrough
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN8855 Virtual MDIO Passtrough. This is needed as AN8855
> +  require special handling as the same address on the MDIO bus is
> +  shared for both Switch and PHY and special handling for the page
> +  configuration is needed to switch accessing to Switch address space
> +  or PHY.
> +
> +$ref: /schemas/net/mdio.yaml#
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855-mdio
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        compatible = "airoha,an8855-mdio";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        internal_phy1: phy@1 {
> +            reg = <1>;
> +
> +            nvmem-cells = <&shift_sel_port0_tx_a>,
> +                <&shift_sel_port0_tx_b>,
> +                <&shift_sel_port0_tx_c>,
> +                <&shift_sel_port0_tx_d>;
> +            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";


For this example nvmem is not relevant. Those are PHY properties, not
MDIO properties. So you could simplify this.

	Andrew

