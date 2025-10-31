Return-Path: <netdev+bounces-234527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB186C22CC7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D113A19D2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B51D8E01;
	Fri, 31 Oct 2025 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGc8mho2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E214A8B;
	Fri, 31 Oct 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870950; cv=none; b=DlQNLacG9NVKo8VqXX3FcKDLRlseGs9xM8gQIhcOFf92WNLY9i9u+1fi4NOyV2w4SO+reeCC53eReFd7EIls8sY6ViHv8Qrrz3KDWGNaodAMKmjNzWGX0prEB5nEM1lHj0VcpBc2ItC0bv2mnEySHoMmHzdNyFQ74vm+j2P7xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870950; c=relaxed/simple;
	bh=XUdqPcsA5R017zZpApsKIePPw1U03CxahsyjJm3NLD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJI7t0fKwmHYlywcm1ReAR8XI8ne9XpBURpXDmUiv6CwduVjv+zy/fvgOYBaTTUeNSfBIOlolrhqEhsxnH4J6I9yrQkz7ZHM7HD962j76rfuDklCniLPXoBshp4R0P92QO+faOYKXzdZl9MnjAFR0sKcnDnGvOnjNjDY2wi6av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGc8mho2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F73C4CEF1;
	Fri, 31 Oct 2025 00:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761870947;
	bh=XUdqPcsA5R017zZpApsKIePPw1U03CxahsyjJm3NLD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGc8mho2oMbm1wno5lfka1r3jdazq6oMUVFrPJnG3NQIGUQqbZ0VyderxVm2p0FID
	 UkSxoZnqg+tzsf/mdycE3aD0qOqGmQKomzT/JssLnziAVMoCVzIPaMX1PMpE9Z+rTi
	 rTUCkpIU7L3GvWv/iYijj9+bvn8tB/8weQzLFiwv8PDeMrM8X4FGHtHaHGxCa01+eU
	 Aw8jmUjqonwccQLk5T+OhfyiGPCqFLybXgh0nQdy+uUTimCVzkH02Pjt/hYYaqJzWO
	 9a7CuQma19zg/7WPafzzhefMDEORT96Fx4ZdRGKulPnR+dTkLFyFX2o6XJUTcx2lkN
	 8FOOdApZfT2xQ==
Date: Thu, 30 Oct 2025 19:35:40 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches
Message-ID: <20251031003540.GA526823-robh@kernel.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <e4e1a74f2a719bf828a4082260f6b5f3602ec4d1.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e1a74f2a719bf828a4082260f6b5f3602ec4d1.1761823194.git.daniel@makrotopia.org>

On Thu, Oct 30, 2025 at 11:29:50AM +0000, Daniel Golle wrote:
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
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 266 +++++++++++++-----
>  1 file changed, 193 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index ab3ee4ecd938..ee42c2e099e2 100644
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
> @@ -37,6 +42,100 @@ patternProperties:
>                Configure the RMII reference clock to be a clock output
>                rather than an input. Only applicable for RMII mode.
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
> +          description: Memory-mapped register regions (switch, mdio, mii)
> +        reg-names:
> +          items:
> +            - const: switch
> +            - const: mdio
> +            - const: mii
> +        mdio:
> +          $ref: /schemas/net/mdio.yaml#
> +          unevaluatedProperties: false
> +
> +          properties:
> +            compatible:
> +              const: lantiq,xrx200-mdio
> +
> +          required:
> +            - compatible
> +        gphy-fw:
> +          type: object
> +          properties:
> +            '#address-cells':
> +              const: 1
> +
> +            '#size-cells':
> +              const: 0
> +
> +            compatible:
> +              items:
> +                - enum:
> +                    - lantiq,xrx200-gphy-fw
> +                    - lantiq,xrx300-gphy-fw
> +                    - lantiq,xrx330-gphy-fw
> +                - const: lantiq,gphy-fw
> +
> +            lantiq,rcu:
> +              $ref: /schemas/types.yaml#/definitions/phandle
> +              description: phandle to the RCU syscon
> +
> +          patternProperties:
> +            "^gphy@[0-9a-f]{1,2}$":
> +              type: object
> +
> +              additionalProperties: false
> +
> +              properties:
> +                reg:
> +                  minimum: 0
> +                  maximum: 255
> +                  description:
> +                    Offset of the GPHY firmware register in the RCU register
> +                    range
> +
> +                resets:
> +                  items:
> +                    - description: GPHY reset line
> +
> +                reset-names:
> +                  items:
> +                    - const: gphy
> +
> +              required:
> +                - reg
> +
> +          required:
> +            - compatible
> +            - lantiq,rcu
> +
> +          additionalProperties: false
> +      required:
> +        - reg-names
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +          description: MDIO bus address
> +        reg-names: false
> +        gphy-fw: false
> +        mdio:
> +          $ref: /schemas/net/mdio.yaml#
> +          unevaluatedProperties: false
> +
>  maintainers:
>    - Hauke Mehrtens <hauke@hauke-m.de>
>  
> @@ -46,78 +145,11 @@ properties:
>        - lantiq,xrx200-gswip
>        - lantiq,xrx300-gswip
>        - lantiq,xrx330-gswip
> -
> -  reg:
> -    minItems: 3
> -    maxItems: 3
> -
> -  reg-names:
> -    items:
> -      - const: switch
> -      - const: mdio
> -      - const: mii
> -
> -  mdio:
> -    $ref: /schemas/net/mdio.yaml#
> -    unevaluatedProperties: false
> -
> -    properties:
> -      compatible:
> -        const: lantiq,xrx200-mdio
> -
> -    required:
> -      - compatible
> -
> -  gphy-fw:
> -    type: object
> -    properties:
> -      '#address-cells':
> -        const: 1
> -
> -      '#size-cells':
> -        const: 0
> -
> -      compatible:
> -        items:
> -          - enum:
> -              - lantiq,xrx200-gphy-fw
> -              - lantiq,xrx300-gphy-fw
> -              - lantiq,xrx330-gphy-fw
> -          - const: lantiq,gphy-fw
> -
> -      lantiq,rcu:
> -        $ref: /schemas/types.yaml#/definitions/phandle
> -        description: phandle to the RCU syscon
> -
> -    patternProperties:
> -      "^gphy@[0-9a-f]{1,2}$":
> -        type: object
> -
> -        additionalProperties: false
> -
> -        properties:
> -          reg:
> -            minimum: 0
> -            maximum: 255
> -            description:
> -              Offset of the GPHY firmware register in the RCU register range
> -
> -          resets:
> -            items:
> -              - description: GPHY reset line
> -
> -          reset-names:
> -            items:
> -              - const: gphy
> -
> -        required:
> -          - reg
> -
> -    required:
> -      - compatible
> -      - lantiq,rcu


All this should remain rather than being under an if/then schema. If you 
need something so different, then it should probably be a separate 
schema file. If there's some common parts, then a common schema shared 
between 2 or more specific bindings.

Rob

