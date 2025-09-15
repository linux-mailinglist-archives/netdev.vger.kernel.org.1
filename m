Return-Path: <netdev+bounces-223222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C312BB58667
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758BB3AE626
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995729D29A;
	Mon, 15 Sep 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iay5aTuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B901279DB6;
	Mon, 15 Sep 2025 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970638; cv=none; b=ANnuphhZQz279eoogR1Mw5t1P2JV+RPrGj4bkROg60v6YxUpEBn6Ok35gDtIB2vkD1obB05nGdidR3EqZs8e5W94SKUqV6p41pbRs+gyNw8tjZHMCKzDikBUjOYr5Pysf/mIQC3MiiqYFvUE8RLEl+qwanSEb2dW8ZX7Nt3ozrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970638; c=relaxed/simple;
	bh=P5kwYS/3EIEKv7z3vVLgckR6fX2mI90/Pdh2L/8VJbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPMrv99p6DVLU6nv5VSP0quTl453xiKOlHjR7oyTI6VNcG5iwbOb5UcmksoeHNXiVyWrTef1xdFE7mJoyo5IHHtfWKvrYepRmMCUg5ry7ulQPKDjB31FU4OeTyGxPGJaf4T+YPcNEjo5geUF/AW1tmbszsi1acjc7oXByMTFtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iay5aTuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6329FC4CEF1;
	Mon, 15 Sep 2025 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757970637;
	bh=P5kwYS/3EIEKv7z3vVLgckR6fX2mI90/Pdh2L/8VJbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iay5aTuBxJ2a5sdhJSMucb5JBSebc2DHxCh1chOsXg+SAWDijS8l9UaU+g6xynpJ4
	 mcbmdTrakcaHCEyjF/oz3qfL45Y3ks9Weki3/JQWepoSN/yTUbUT8QCNHGgWOABrx7
	 HfrWXWPkNa7ayG2bCJ2lUqzLwKBg+q2wR2ARhsrS9pcyJEDXcz/ayr2gBEMWgCphVB
	 i9pO3Lgm9VEE4Bpne0tmHdAAaIYoQFOXUEUM8rcOv1nx5vgODMOgP9nBO1jLfTPuIs
	 FfVJJ1AzncrLOkWi4/V5WjusCxPDsksMIMlDB/WUv9Lh1fBiI7E0m1V9/9bnXwa6LF
	 H6SN4SF/hHmwA==
Date: Mon, 15 Sep 2025 16:10:36 -0500
From: Rob Herring <robh@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: dsa: microchip: Add
 strap description to set SPI mode
Message-ID: <20250915211036.GA3390851-robh@kernel.org>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
 <20250912-ksz-strap-pins-v2-2-6d97270c6926@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-ksz-strap-pins-v2-2-6d97270c6926@bootlin.com>

On Fri, Sep 12, 2025 at 11:09:13AM +0200, Bastien Curutchet (Schneider Electric) wrote:
> At reset, KSZ8463 uses a strap-based configuration to set SPI as
> interface bus. If the required pull-ups/pull-downs are missing (by
> mistake or by design to save power) the pins may float and the
> configuration can go wrong preventing any communication with the switch.
> 
> Add a 'reset' pinmux state
> Add a KSZ8463 specific strap description that can be used by the driver
> to drive the strap pins during reset. Two GPIOs are used. Users must
> describe either both of them or none of them.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index db8175b4ced6d136ba97c371b68ba993637e444a..099c6b373704427755c3d8cad4b1cd930219f2f2 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -34,6 +34,13 @@ properties:
>        - microchip,ksz8567
>        - microchip,lan9646
>  
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: reset
> +        description:
> +          Used during reset for strap configuration.
> +
>    reset-gpios:
>      description:
>        Should be a gpio specifier for a reset line.
> @@ -139,6 +146,23 @@ allOf:
>                      should be provided externally.
>                dependencies:
>                  microchip,rmii-clk-internal: [ethernet]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,ksz8463
> +    then:
> +      properties:
> +        strap-rxd0-gpios:
> +          description:
> +            RXD0 pin, used to select SPI as bus interface.
> +        strap-rxd1-gpios:
> +          description:
> +            RXD1 pin, used to select SPI as bus interface.
> +
> +dependencies:
> +  strap-rxd0-gpios: [ strap-rxd1-gpios ]
> +  strap-rxd1-gpios: [ strap-rxd0-gpios ]

It would be simpler to define "strap-rxd-gpios" with a length of 2 
entries:

straps-rxd-gpios:
  minItems: 2
  maxItems: 2

Rob

