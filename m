Return-Path: <netdev+bounces-195349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77033ACFB25
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 04:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311C217132F
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BF1D7E35;
	Fri,  6 Jun 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZuavQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7929A2;
	Fri,  6 Jun 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175919; cv=none; b=dh5fsAKLmDjvWOnEbcwbri7MJzv9yWT/eYubdrBqLSW16ndDg/Ocy+E6Yedwic9YT1YlkrG7UdKh3BHrEgZ1XHnNm8E8RElCRcoC6NN0Hk+qtQv/s0tIDjsmniuLPBeEMiyHNesUIvOZ1DH4aphBHO6MTZHpmveLto4iYcZE+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175919; c=relaxed/simple;
	bh=G0NA9QukdyKS4fk2n1Yl/YyeZJx+qnKUTJAd9JdBjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWyOCCGs1dQUPOX/KAFIHZb3jKP+6pZPWVBJVc73H31Z9ckaBiWzh4PNf5mEYoXtG+2P4ygAs7nbfMZ+TM8mpuIrRLYUJanE/LkN9okkt/hcpfdbYkOV3oeJwRBaULiuCiEkgxmBmSWpTsKX3k4kAPPeZhcwUD0Uhhags9BPVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZuavQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98B8C4CEE7;
	Fri,  6 Jun 2025 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749175918;
	bh=G0NA9QukdyKS4fk2n1Yl/YyeZJx+qnKUTJAd9JdBjK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKZuavQnWCXtl7BTKihWvG8j/Lfe6N4iWrK7+Jze+SRinKdAv/HpDxvMLrsxz8GX5
	 YdA1sYlRtP0txd1nX5Gobn7XM9xlMxMkSNGSFebRm6oQxeVpj4emNA1dfZRDtPrnCa
	 mfoEUxeBoiMKd0p4W8BKWf9RmZxZEXhFXVRvBpwaN7wUM/7myPvTa9wAQK3n5I/P6g
	 fSY7NCGOfJNaur8NcvS4RL6J8x2Bm6s8Vd30o6CmEzNGgrfJ8rM1VBRqjz/FCJWf4a
	 8OAbRoa01AwKrwAK4rT2CNh6LJxRV44azNZ0Bps/uFlqf8Cqqk1+7EhXN9nOgkBVbI
	 nBcI1+HX66UCQ==
Date: Thu, 5 Jun 2025 21:11:56 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev, wahrenst@gmx.net
Subject: Re: [PATCH v2 1/1] dt-bindings: ieee802154: Convert at86rf230.txt
 yaml format
Message-ID: <20250606021156.GA3780713-robh@kernel.org>
References: <20250602151601.948874-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602151601.948874-1-Frank.Li@nxp.com>

On Mon, Jun 02, 2025 at 11:15:58AM -0400, Frank Li wrote:
> Convert at86rf230.txt yaml format.
> 
> Additional changes:
> - Add ref to spi-peripheral-props.yaml.
> - Add parent spi node in examples.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - xtal-trim to uint8
> ---
>  .../bindings/net/ieee802154/at86rf230.txt     | 27 --------
>  .../net/ieee802154/atmel,at86rf233.yaml       | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> deleted file mode 100644
> index 168f1be509126..0000000000000
> --- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* AT86RF230 IEEE 802.15.4 *
> -
> -Required properties:
> -  - compatible:		should be "atmel,at86rf230", "atmel,at86rf231",
> -			"atmel,at86rf233" or "atmel,at86rf212"
> -  - spi-max-frequency:	maximal bus speed, should be set to 7500000 depends
> -			sync or async operation mode
> -  - reg:		the chipselect index
> -  - interrupts:		the interrupt generated by the device. Non high-level
> -			can occur deadlocks while handling isr.
> -
> -Optional properties:
> -  - reset-gpio:		GPIO spec for the rstn pin
> -  - sleep-gpio:		GPIO spec for the slp_tr pin
> -  - xtal-trim:		u8 value for fine tuning the internal capacitance
> -			arrays of xtal pins: 0 = +0 pF, 0xf = +4.5 pF
> -
> -Example:
> -
> -	at86rf231@0 {
> -		compatible = "atmel,at86rf231";
> -		spi-max-frequency = <7500000>;
> -		reg = <0>;
> -		interrupts = <19 4>;
> -		interrupt-parent = <&gpio3>;
> -		xtal-trim = /bits/ 8 <0x06>;
> -	};
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
> new file mode 100644
> index 0000000000000..d84e05c133710
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ieee802154/atmel,at86rf233.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AT86RF230 IEEE 802.15.4
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at86rf212
> +      - atmel,at86rf230
> +      - atmel,at86rf231
> +      - atmel,at86rf233
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpio:
> +    maxItems: 1
> +
> +  sleep-gpio:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 7500000
> +
> +  xtal-trim:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      u8 value for fine tuning the internal capacitance
> +      arrays of xtal pins: 0 = +0 pF, 0xf = +4.5 pF

Drop 'u8 value for '

maximum: 0xf

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        zigbee@0 {
> +            compatible = "atmel,at86rf231";
> +            reg = <0>;
> +            spi-max-frequency = <7500000>;
> +            interrupts = <19 4>;
> +            interrupt-parent = <&gpio3>;
> +            xtal-trim = /bits/ 8 <0x06>;
> +        };
> +    };
> -- 
> 2.34.1
> 

