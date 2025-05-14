Return-Path: <netdev+bounces-190553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF86AAB77FF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47108176FE9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6D221F12;
	Wed, 14 May 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eklo3P8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7C221271;
	Wed, 14 May 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258370; cv=none; b=IE/1S9QxneJCHwFqdzJxKIRhODOihxsWZOZirblNiF7LfEVLOf46qLnPG1yHN3GNQ1HWdQ8euTOhjX0YOvmATUznSxDpt2mjP3Bzj43ID/hBOhPsE3/tRE9tBvYgkGEzU+5sAT+5KyX6Z68789lQR8r5Rw/mN5WsXEFJHCGhZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258370; c=relaxed/simple;
	bh=mXXP6jPmHjrLDq0YvJKfrILeEi0rih83V0iyKJkz37w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skm0mUqAAJ+lpZP3BzSpeE9BJ9zYf2zvQgQ+CCMLAR1c8hotjsfF3GWG1lEr6JZx4KbJ5dlnZ6c4tvRdmCE0yeWk5IV063sTk56EfiBc2iZTsU7oeZM/zbWvHZhoilqoktqzLCn26pXEkrOjyHvrZZqbfeLm1ulV0xA7qMa3VEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eklo3P8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3D3C4CEE3;
	Wed, 14 May 2025 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747258369;
	bh=mXXP6jPmHjrLDq0YvJKfrILeEi0rih83V0iyKJkz37w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eklo3P8gO3ZA/poAviqKg20Jo5FLMmxCWg/QyoBrT+JcE0uc8kxa0Ps8m0ovUG5aA
	 mcUIBXxORo606F5yOGujkrHa4+2JIZgrWNg/+hhiwxwP2p+quNVO3OnVswmgVoHAp5
	 1oOA1qsA3OfZWdpYGsi7PvNzFr6zJS2StHzUOvo/kybJAyO/8FhHEsoxbAJS7qOqik
	 gZ1gVA7xuk/FEADQvzcwXntGdrNwBQvIBr1oXKDJn+xFcwboM8C7GPrT9GQY7+ZztA
	 BcDCJ/l//GCCv6TV+MfNAhAejNGGt5Z+pY1VyYX9UxRBXpOwz+b1zHMJitu8Ppdiew
	 l8FMVbVx/p6Wg==
Date: Wed, 14 May 2025 16:32:47 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [net-next PATCH v4 07/11] dt-bindings: net: ethernet-controller:
 permit to define multiple PCS
Message-ID: <20250514213247.GA3053278-robh@kernel.org>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511201250.3789083-8-ansuelsmth@gmail.com>

On Sun, May 11, 2025 at 10:12:33PM +0200, Christian Marangi wrote:
> Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
> can be defined for an ethrnet-controller node to support various PHY

typo

> interface mode type.
> 
> It's very common for SoCs to have a 2 or more dedicated PCS for Base-X
> (for example SGMII, 1000base-x, 2500base-x, ...) and Base-R (for example
> USXGMII,10base-r, ...) with the MAC selecting one of the other based on
> the attached PHY.

I'm confused what you need. The restriction was no arg cells allowed. 
Any number of phandles was allowed. The former would need a 
"#pcs-handle-cells" type property.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 7cbf11bbe99c..60605b34d242 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -84,8 +84,6 @@ properties:
>  
>    pcs-handle:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      maxItems: 1
>      description:
>        Specifies a reference to a node representing a PCS PHY device on a MDIO
>        bus to link with an external PHY (phy-handle) if exists.
> -- 
> 2.48.1
> 

