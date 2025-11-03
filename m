Return-Path: <netdev+bounces-234978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50715C2A901
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A133C4E2FB9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D642DC348;
	Mon,  3 Nov 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwsDDPhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E02C15B7;
	Mon,  3 Nov 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158383; cv=none; b=gC1Eu4xYCuWR5QojIYAmgy7nOcwKzW/tlrJqMGaopunMZI8pG0qF1Fbi94wQK9yn+9TpMsm1Frw/m4aBzC7yqmtFchg0aARV2yNxgj7xsIh3fT7R6QYG8LxjBiLr8DwXG03tbQv7hI4yoSCHeQ31vwIq9lW+HBobxOOazePynqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158383; c=relaxed/simple;
	bh=0OchX97w3a0X/5UQeN5/1r679Y592gYdY3Idulg7QYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcNlGG9SWNg1gPad2Y06B7ZVzq8c5SNIp1yl6am1/FfdKDtRtTPxduwiHH5wOtt70DFKDYkWvQ4wT+D4z0QerICFglaTCW9V8TGelfyTusQdf2tOTR/Q3IgKGfzST5pXpOiahgdEOqD4Gn6s8a1it2Q4fOdltgFek+mS+W1mlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwsDDPhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFAFC116D0;
	Mon,  3 Nov 2025 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762158383;
	bh=0OchX97w3a0X/5UQeN5/1r679Y592gYdY3Idulg7QYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwsDDPhK8ivmDj3dCIehIPp2Q5xZfNrrZeCMlk/2JNYzmjxXB8eAVr0U5dtAz3qbg
	 gWMugib39EbE/ozdODVU02IZkgPRbNki47P6fQy0gb+uezAsoqm0+8ebNwiK1DEh1X
	 CNIEw3r1qDSjUYauR8Sc8F/7t53Y1oMW9wXIQQFscAxLAq4/u72BFZSPjehZyP9033
	 yKdsvvl9zBhXrUaeJPA/Q3ika5Gb0N5C/bpJYrYHqi5Tyq7v5QuYzw/qbfJ1S8FlZd
	 PFnQEfW1+ekp4Jv9OaZVS+f9aV0aesUv6Hl1zN3vhE9Xv8Qcy6e+s3Yp8UR1yhVvIF
	 pmyVZZ0vO3pBg==
Date: Mon, 3 Nov 2025 09:26:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Schirm <andreas.schirm@siemens.com>, Lukas Stockmann <lukas.stockmann@siemens.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Peter Christen <peter.christen@siemens.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, 
	Juraj Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, "Livia M. Rosu" <lrosu@maxlinear.com>, 
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches
Message-ID: <20251103-wonderful-resilient-snake-7d2e9e@kuoka>
References: <cover.1761938079.git.daniel@makrotopia.org>
 <b32a49c03c75be0a1b4666e99c25a3fc0f95d63b.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b32a49c03c75be0a1b4666e99c25a3fc0f95d63b.1761938079.git.daniel@makrotopia.org>

On Fri, Oct 31, 2025 at 07:22:39PM +0000, Daniel Golle wrote:
> Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
> GSW1xx switches which are based on the same hardware IP but connected
> via MDIO instead of being memory-mapped.
> 
> Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
> and GSW145 switches and adjust the schema to handle the different
> connection methods with conditional properties.
> 
> Add MaxLinear GSW125 example showing MDIO-connected configuration.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v6:
>  * keep properties on top level and use allOf for conditional constraints
> 
> v5:
>  * drop maxlinear,rx-inverted from example
> 
> v4:
>  * drop maxlinear,rx-inverted and maxlinear,tx-inverted properties for
>    now in favor of upcoming generic properties
> 
> v3:
>  * add maxlinear,rx-inverted and maxlinear,tx-inverted properties
> 
> v2:
>  * remove git conflict left-overs which somehow creeped in
>  * indent example with 4 spaces instead of tabs
> 
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 131 +++++++++++++++++-
>  1 file changed, 126 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index cf01b07f7f44..8904d0b6cec5 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -4,7 +4,12 @@
>  $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Lantiq GSWIP Ethernet switches
> +title: Lantiq GSWIP and MaxLinear GSW1xx Ethernet switches
> +
> +description:
> +  Lantiq GSWIP and MaxLinear GSW1xx switches share the same hardware IP.
> +  Lantiq switches are embedded in SoCs and accessed via memory-mapped I/O,
> +  while MaxLinear switches are standalone ICs connected via MDIO.
>  
>  $ref: dsa.yaml#
>  
> @@ -46,9 +51,14 @@ properties:
>        - lantiq,xrx200-gswip
>        - lantiq,xrx300-gswip
>        - lantiq,xrx330-gswip
> +      - maxlinear,gsw120
> +      - maxlinear,gsw125
> +      - maxlinear,gsw140
> +      - maxlinear,gsw141
> +      - maxlinear,gsw145
>  
>    reg:
> -    minItems: 3
> +    minItems: 1
>      maxItems: 3
>  
>    reg-names:
> @@ -65,9 +75,6 @@ properties:
>        compatible:
>          const: lantiq,xrx200-mdio
>  
> -    required:
> -      - compatible
> -
>    gphy-fw:
>      type: object
>      properties:
> @@ -123,6 +130,32 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - lantiq,xrx200-gswip
> +              - lantiq,xrx300-gswip
> +              - lantiq,xrx330-gswip
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +        mdio:
> +          required:
> +            - compatible
> +      required:
> +        - reg-names

This wasn't before and is a change in existing binding. You need a
separate patch with its own explanation.

> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        reg-names: false
> +        gphy-fw: false
> +
>  unevaluatedProperties: false

Best regards,
Krzysztof


