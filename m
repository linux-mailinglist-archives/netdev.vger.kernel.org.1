Return-Path: <netdev+bounces-130079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD1988168
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78FA281442
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E5189F57;
	Fri, 27 Sep 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw1IV33s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002E15ADAB;
	Fri, 27 Sep 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429691; cv=none; b=XlSFctsl/Aop9GZ7/QBVTJhG7kW46zGMb8LXk3oiKLPHejJYE9dZSGPVi3PV71ydhgwpgUcqlNoyxdz3DfRA/cnrSPq2s7ZoZsJ21+TDeY4oXkyV+vMTko4m4N0bSRp1+vZmFq+QtlmhyVuGgk22hrpwXbB9jZMKifyctA/2itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429691; c=relaxed/simple;
	bh=GxG+tu+21lu0yCzU+ifnIiJI9JUvz1/XTvqf4gwANmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmPQgc8swJ7pKaCXUHTaQ3LBtI52uxJ22r//9zCNLG9mWXiEpu5Q4y8FNYW/sbZ+H/c/uD1m/WvLbl0KhIfeL90PmGQvXJ3+miyK5/uf0P4vIzuZUA3ZSjC7/EqOqVlhWB/FkE1Ka95lsCr/4K9Gei06YGamggfL/3YlVYuySaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw1IV33s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48821C4CECD;
	Fri, 27 Sep 2024 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727429691;
	bh=GxG+tu+21lu0yCzU+ifnIiJI9JUvz1/XTvqf4gwANmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw1IV33snqufyRIefxyv34fx/122R7wwnm+AFm4YXxXC8ZzrLikLv3M5h5GOl4Nru
	 22dmIY+6IjYvQk1aWxzWRqSvlr68B0W10pufCpST8OJzbksS1m9bsH/BtxTsFg3Xpo
	 lJpExPQlaTE5gnCqW9Mi+ugyS9DPY+efipl/qCnBzpeS4dNYxdfFBLTjAVWBmkb3aA
	 8G6I9gsPQP1/yqLRrdEwqaHFrrQ+d4uCeT0Qve8GCqsXgT11TyV3D4iezPLTTnN1oV
	 qRUIkuxf7H3fghviSq7Aih0hdU+QXNadtj5nDEaKEqCTBhNwRcmHRy3CbkDuIU0si4
	 lawvIy42bdk0Q==
Date: Fri, 27 Sep 2024 11:34:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: Add T-HEAD dwmac support
Message-ID: <4pxpku3btckw7chyxlqw56entdb2s3gqeas4w3owbu5egmq3nf@5v76h4cczv4z>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-1-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926-th1520-dwmac-v2-1-f34f28ad1dc9@tenstorrent.com>

On Thu, Sep 26, 2024 at 11:15:50AM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add documentation to describe T-HEAD dwmac.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: change apb registers from syscon to second reg of gmac node]
> [drew: rename compatible, add thead rx/tx internal delay properties]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml | 109 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 4e2ba1bf788c..474ade185033 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -99,6 +99,7 @@ properties:
>          - snps,dwxgmac-2.10
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> +        - thead,th1520-gmac
>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> new file mode 100644
> index 000000000000..1070e891c025
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/thead,th1520-gmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD TH1520 GMAC Ethernet controller
> +
> +maintainers:
> +  - Drew Fustini <dfustini@tenstorrent.com>
> +
> +description: |
> +  The TH1520 GMAC is described in the TH1520 Peripheral Interface User Manual
> +  https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
> +
> +  Features include
> +    - Compliant with IEEE802.3 Specification
> +    - IEEE 1588-2008 standard for precision networked clock synchronization
> +    - Supports 10/100/1000Mbps data transfer rate
> +    - Supports RGMII/MII interface
> +    - Preamble and start of frame data (SFD) insertion in Transmit path
> +    - Preamble and SFD deletion in the Receive path
> +    - Automatic CRC and pad generation options for receive frames
> +    - MDIO master interface for PHY device configuration and management
> +
> +  The GMAC Registers consists of two parts
> +    - APB registers are used to configure clock frequency/clock enable/clock
> +      direction/PHY interface type.
> +    - AHB registers are use to configure GMAC core (DesignWare Core part).
> +      GMAC core register consists of DMA registers and GMAC registers.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - thead,th1520-gmac
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - thead,th1520-gmac
> +      - const: snps,dwmac-3.70a
> +
> +  reg:
> +    items:
> +      - description: DesignWare GMAC IP core registers
> +      - description: GMAC APB registers
> +
> +  reg-names:
> +    items:
> +      - const: dwmac
> +      - const: apb
> +
> +  thead,rx-internal-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      RGMII receive clock delay. The value is used for the delay_ctrl
> +      field in GMAC_RXCLK_DELAY_CTRL. Units are not specified.

What do you mean by "unspecified units"? They are always specified,
hardware does not work randomly, e.g. once uses clock cycles, but next
time you run it will use picoseconds.

You also miss default (property is not required) and some sort of constraints.

> +
> +  thead,tx-internal-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      RGMII transmit clock delay. The value is used for the delay_ctrl
> +      field in GMAC_TXCLK_DELAY_CTRL. Units are not specified.

Best regards,
Krzysztof


