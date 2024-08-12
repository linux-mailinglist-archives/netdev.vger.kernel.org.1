Return-Path: <netdev+bounces-117866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BE94F999
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F26DB21AE7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E7197A9F;
	Mon, 12 Aug 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCWayVPY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889A15C12D;
	Mon, 12 Aug 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502173; cv=none; b=Vqw84QGyajrc9DoPraH2izJBby5tcIbDyil55c8t7Z75H0OnYdI0rDmy5r5TyhsG3Vz826IX/SWVGS7k0ifCXxg2iMAFLLuPeOac0pybZPTJk3zqJ/ky0vsBpeq1e4raBz3GwUtz9wwrH8CaegFSfJvVUJ8R3M2g8EigQ907/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502173; c=relaxed/simple;
	bh=rzEu9vnbnIjIArl/dZGbz/iYFuW8wv8IQbmNNkByJOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/0gOgZWLSQpo/DVJ4ZQqvTNYr5EPHjOXcY3FIHzMaH9fFOaC6IMxG7NB+VeeKKllj3zj6uCA1YQ+TXJitNVvDiY8csSMvND3iB2cKVC7dBXHgQbJD/XxESmUalGUyIDxRsAiYjwYEDa+QMAJu4N0AN96HH+ENWb9LPKDPemoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCWayVPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB1C4AF0E;
	Mon, 12 Aug 2024 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502173;
	bh=rzEu9vnbnIjIArl/dZGbz/iYFuW8wv8IQbmNNkByJOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCWayVPYAFFOxPgIuL7KbbBc+c4s7P0DSvgpHYUGqn9E8BT8xIJ8KSlZaAkn9yxc8
	 1YqPJjwyRZQd4Q47X845FPxSTvqmVCQHnwZ/pj+rFA7ppxy6owYrrroRe/odAa55zD
	 szNI3HQzNDeLWYwni/gNyltxIPxmCbdFqity1vXEFLroh1zibOks6h2v33b3rUW7FL
	 GveB90cB59fVRJbsIuvmE2BTiIIpXfx4vmDKepzNkXWLl7sTQMfVFKg02aDRBeb1/A
	 2zmX9TlWTjcVHxc4ea45+/UtgfFLdaG0bICcV76C5TqkG5503BzZYVR0Pc765X9bDu
	 SJ4+rtqTebIJQ==
Date: Mon, 12 Aug 2024 16:36:11 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match
 for child node
Message-ID: <20240812223611.GA2346223-robh@kernel.org>
References: <20240812031114.3798487-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812031114.3798487-1-Frank.Li@nxp.com>

On Sun, Aug 11, 2024 at 11:11:14PM -0400, Frank Li wrote:
> mdio.yaml wrong parser mdio controller's address instead phy's address when
> mdio-mux exist.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
>         mdio@20 {
> 		reg = <0x20>;
> 		       ^^^ This is mdio controller register
> 
> 		ethernet-phy@2 {
> 			reg = <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };
> 
> Only phy's address is limited to 31 because MDIO bus defination.
> 
> But CHECK_DTBS report below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> 
> The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
> mdio.yaml.
> 
> Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
> controller's address.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
> index a266ade918ca7..a7def3eb4674d 100644
> --- a/Documentation/devicetree/bindings/net/mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> @@ -59,7 +59,7 @@ properties:
>      type: boolean
>  
>  patternProperties:
> -  '@[0-9a-f]+$':
> +  '^(?!mdio@).*@[0-9a-f]+$':

This is at the wrong spot. The problem is up a level where the $nodename 
matched mdio-mux-emi1@54.

I think what we want for the $nodename pattern is:

'^mdio(-(bus|external))?(@.+|-([0-9]+))$'

There's lots of pinctrl nodes named 'mdio...' we need to avoid and we 
aren't currently.

I'd prefer not to support 'mdio-external', but there's already 1 
documented case. I think the only node name fix we'd need with this is 
'mdio-gpio' which should be just 'mdio' or 'mdio-N' like all other 
bitbanged implementations.

Rob

