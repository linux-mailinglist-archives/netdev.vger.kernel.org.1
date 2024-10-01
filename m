Return-Path: <netdev+bounces-130721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADDC98B506
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5DB21553
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86451BBBCA;
	Tue,  1 Oct 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgv94+nB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A363D;
	Tue,  1 Oct 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765918; cv=none; b=iFw4sxU669JsMM1Lcv7USo7IkEe5PBUfnHlgbqN/E8Qni2VlCwdgZPFkuOboADtN0tcD55mL3vvDwa1BnyRdHp9CuEPZ0bZkt7XJby2oXkUMgkVratwqOLK8xYtn3zsbcOu6RJy+iClOlsqC27ktytpdaFNN6VTLMYYT9Mnbl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765918; c=relaxed/simple;
	bh=O5YTakodNDe1cIRujrnosQhMNdo3PJWvcNMncXtHV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS6XFNbwt2IZuo48B6s00hIgS5YpO5t6+gJcsqD3tSR1GmmiA/rUb8jWEoUmTJlB1kN5GF6dNuieeW8sASAKYZypyriaf3ZNzz0PaSz3tGNWfzdd+M6mvQfI5DGUBm6pRk6NiOkiD3eIoD9LrR2bjLEX9Jvm1tsiw9u6AtYS0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgv94+nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD7CC4CEC6;
	Tue,  1 Oct 2024 06:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765918;
	bh=O5YTakodNDe1cIRujrnosQhMNdo3PJWvcNMncXtHV5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgv94+nBOTvDk85hEJE4nQhK9YttToSyPnz2hvThSEUArrnY/qEP72+oB6nmnIMQS
	 3vwqWcEvIVhDByq/Z/X45y33LSHPMiRya4nGpzvnS2vqw25iQjs9Q4ONLndw2U0mX0
	 1LLwlpcQvqrNTh07IR57+ksIj/4s52MesSzeYMNTgDtKEKeialcVja4ODnHKZelX/J
	 kzcxVN25K9KGngOBGsPnHBGaf/jXL5qVq1ORfku0CxXMouDPH08ROkKCadcKFDHzMz
	 YOGjVp98JyELCLJX4Tjy4kdv54kwUePbqNsYTAwgEJIYZ3co89lip2f7j2s7dKSXjx
	 De3TSuulx58/g==
Date: Tue, 1 Oct 2024 08:58:34 +0200
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
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: net: Add T-HEAD dwmac support
Message-ID: <wtknsih2yrbylqzanp6k753kklk4myf6iezjz6swnp4nsqr2hl@7mmm6lxhqemu>
References: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>
 <20240930-th1520-dwmac-v3-1-ae3e03c225ab@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930-th1520-dwmac-v3-1-ae3e03c225ab@tenstorrent.com>

On Mon, Sep 30, 2024 at 11:23:24PM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add documentation to describe the DesginWare-based GMAC controllers in
> the T-HEAD TH1520 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: rename compatible, add apb registers as second reg of gmac node]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml        |  1 +
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml | 97 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 99 insertions(+)
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
> index 000000000000..fef1810b10c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> @@ -0,0 +1,97 @@
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

I don't get why none of snps,dwmac properties are restricted. How many
interrupts do you have here? How many clocks? resets?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts

Drop

> +  - interrupt-names

Drop

> +  - phy-mode
> +
> +unevaluatedProperties: false

Best regards,
Krzysztof


