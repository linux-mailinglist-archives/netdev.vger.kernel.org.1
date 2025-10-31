Return-Path: <netdev+bounces-234526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75523C22C76
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A29D400316
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C801D5146;
	Fri, 31 Oct 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERwvNhrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B291C8631;
	Fri, 31 Oct 2025 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870566; cv=none; b=gZf+GtI5TAq1/BcLRMNH28BDVzNfJ7hQjqZVk/cCEvPAgc9A3ENywCFrHbkuIhPeQqSSVoHVAvA3p/TlYa0OuOa5h1GVRO4wvTYzvkOjqj/WxP7yCCBAenK+5Qg0qyzuExuLwgck7Csqb1aX8D7imbc2RwbBnjA7FPjkSG88oD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870566; c=relaxed/simple;
	bh=UM6Yec175jS9Q0JhM4JNCSEyAxYvmozftEKcUDIq/6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocUc2DdC4YqdV8oXDJ6yQ1H67bccig8EWXjB+60nE++dkztXN9YuXdHFFq80NE7zFldfLXIHbzvpHUoHsdSnyeJmLlp3e84feKsrpxcBTLgdtSE4OU0eTBRvf+DJedxCIaLVD4wfgnXgmqlsOtQzqS5apRsNI9ANz5x6qtcUvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERwvNhrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E4C4CEFD;
	Fri, 31 Oct 2025 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761870565;
	bh=UM6Yec175jS9Q0JhM4JNCSEyAxYvmozftEKcUDIq/6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERwvNhrf/gsDEr0bowe5JNBZOzVxJ4JdGt7r9dEooUme9uL5lqn11eL80IxQZGPEM
	 sIkp6GxNDrxgVVSy9qkOreT1mXS3vpcRHt+1TPkm9aFkug9OOwq+QMd1bhO9BhF4y3
	 M0kqO8Vg9a+sb7bH7LSCM1KIxHNMFN4em0Pn6njkWAzBhFBV/0TVaauo5i2+xOVmQb
	 bOs0+DnyvT3lutfzWX5EQsBKIt2pDS+CZSh55mIN6veCD00XD9s6lto2/pieC0JAsp
	 dG68k9MmPAHoyzChAnN1PUegm/F/c/5eklc7K45Te2Gtv+Cwkp6NSBNlkShDEZr5Ce
	 y6BqEwoUQzhvA==
Date: Thu, 30 Oct 2025 19:29:24 -0500
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
Subject: Re: [PATCH net-next v5 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <20251031002924.GA516142-robh@kernel.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>

On Thu, Oct 30, 2025 at 11:28:35AM +0000, Daniel Golle wrote:
> Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> properties on port nodes to allow fine-tuning of RGMII clock delays.
> 
> The GSWIP switch hardware supports delay values in 500 picosecond
> increments from 0 to 3500 picoseconds, with a post-reset default of 2000
> picoseconds for both TX and RX delays. The driver currently sets the
> delay to 0 in case the PHY is setup to carry out the delay by the
> corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").
> 
> This corresponds to the driver changes that allow adjusting MII delays
> using Device Tree properties instead of relying solely on the PHY
> interface mode.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4:
>  * remove misleading defaults
> 
> v3:
>  * redefine ports node so properties are defined actually apply
>  * RGMII port with 2ps delay is 'rgmii-id' mode
> 
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index f3154b19af78..8ccbc8942eb3 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -6,8 +6,31 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Lantiq GSWIP Ethernet switches
>  
> -allOf:
> -  - $ref: dsa.yaml#/$defs/ethernet-ports

I think you can keep this as you aren't adding custom properties.

> +$ref: dsa.yaml#
> +
> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    type: object
> +    patternProperties:
> +      "^(ethernet-)?port@[0-6]$":

> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false

And drop these lines. You may need 'additionalProperties: true' if the 
tools warn.

> +
> +        properties:
> +          tx-internal-delay-ps:
> +            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> +            description:
> +              RGMII TX Clock Delay defined in pico seconds.
> +              The delay lines adjust the MII clock vs. data timing.
> +              If this property is not present the delay is determined by
> +              the interface mode.
> +          rx-internal-delay-ps:
> +            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> +            description:
> +              RGMII RX Clock Delay defined in pico seconds.
> +              The delay lines adjust the MII clock vs. data timing.
> +              If this property is not present the delay is determined by
> +              the interface mode.
>  
>  maintainers:
>    - Hauke Mehrtens <hauke@hauke-m.de>
> @@ -113,8 +136,10 @@ examples:
>                      port@0 {
>                              reg = <0>;
>                              label = "lan3";
> -                            phy-mode = "rgmii";
> +                            phy-mode = "rgmii-id";
>                              phy-handle = <&phy0>;
> +                            tx-internal-delay-ps = <2000>;
> +                            rx-internal-delay-ps = <2000>;
>                      };
>  
>                      port@1 {
> -- 
> 2.51.2

