Return-Path: <netdev+bounces-124585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C996A0F1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797BEB217EC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E313E025;
	Tue,  3 Sep 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbCirwCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2B1F937;
	Tue,  3 Sep 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374641; cv=none; b=K2Fc4XXJ/1HqyxgL1pV7v3uUN6+TMeaCbRShPSI/mrSYD0lwDXO0gq80ypmyvxAiywO3TpPn6R/Z71zLlZDR2hDs/vcTCN1HHOFGUtthDPSTin8PqjSYF2FKe5fgZ5P3VuuQvDqv2KXjsCh0zQXDmyLQUc0jbk0eor190YmaRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374641; c=relaxed/simple;
	bh=bhsfC7schH8RjjHul+VtOnj/fBjxgGuPNJejcIgfj6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw7XkXlFYWlWoLda5SRBSzaicyj8iXa4yOmWMzDzC1gRaIhxL3196uka25RmtVGBiE7fKYTa9Tzq6jg0dvp3OZTfpvvaHS4nwfEU0Opol3hPsfQTm0mMP674kHMJvi9IAvKa9WzCd6H7JyrrDg0nsTZd04krUCu08ksB1bRxiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbCirwCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BDEC4CEC4;
	Tue,  3 Sep 2024 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374640;
	bh=bhsfC7schH8RjjHul+VtOnj/fBjxgGuPNJejcIgfj6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbCirwCmULlJUOhjUc9zCVGyJug9BPM4mAdtEiqxIOtAzsMM0pyzIo0nU8/0oZq7U
	 XaT4S5oLB4Q5mi3UI8xatueGCnzkPuu7EmUn2olbCI1MTTAZ2VoSHTlyF7B/KIKrih
	 wPk6Bu3exp92W6hjDiLPQG9ZRIiW5KFY9ooNLeYdsgVyMkW69foXqw77/HHzMD3Jlv
	 KCY8hxMU5WQzVJpLIeZa1nBGvxw7mBERhnHncCJSH5+wT2EjyXqESUh/dtsayUCuqU
	 4zOCOkZriT6qS048tCZqn3z72S64hxnIWkV5+lal6jUHabWOYvmf5WLlVFwAiXmle4
	 Alrk1iPmHl6Rw==
Date: Tue, 3 Sep 2024 09:43:59 -0500
From: Rob Herring <robh@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	horatiu.vultur@microchip.com, ruanjinjie@huawei.com,
	steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
	masahiroy@kernel.org, alexanderduyck@fb.com, krzk+dt@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io, markku.vorne@kempower.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v7 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240903144359.GA981887-robh@kernel.org>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
 <20240903104705.378684-15-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903104705.378684-15-Parthiban.Veerasooran@microchip.com>

On Tue, Sep 03, 2024 at 04:17:05PM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
> (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> integrated into the LAN8650/1. The communication between the Host and the
> MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> Interface (TC6).
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan8650.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> new file mode 100644
> index 000000000000..b7b755b27b78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan8650.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
> +
> +maintainers:
> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +
> +description:
> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> +  integrated into the LAN8650/1. The communication between the Host and
> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> +  Interface (TC6).
> +
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,lan8650
> +      - items:
> +          - const: microchip,lan8651
> +          - const: microchip,lan8650
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt from MAC-PHY asserted in the event of Receive Chunks
> +      Available, Transmit Chunk Credits Available and Extended Status
> +      Event.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 15000000
> +    maximum: 25000000
> +

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

What are these for? They apply to child nodes, yet you have no child 
nodes defined.

Rob

