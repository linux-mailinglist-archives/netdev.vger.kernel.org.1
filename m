Return-Path: <netdev+bounces-234976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58BC2A8BB
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 603C334826D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A22DCBF2;
	Mon,  3 Nov 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAn5X3v6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D32DC77B;
	Mon,  3 Nov 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158160; cv=none; b=XFMTD4+GeVAgH1QsxTcAcfm4H8HdNxh/PXXuZZIpMcYkEQX59OO7yTpGPeipF13ixsg4KgbfffLx7mTbYS9Avy+r9QCvQzHtK8UPjxRXnjN4eBqJz9hdOPT8Z1v4bSRKT6jxuDyEEeOT3dTjyx2HtOqSLJMfXoVTwi5dCW6uJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158160; c=relaxed/simple;
	bh=YDv22vyr4bQtUMxYJVP0QlxdmM2loUP8z8C33OqCi/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJx+jaegNhdxX53RiZDfiM9GHwzascloa5ErPZvltHMCj+2hknABN+Yckp7eTdGcfnze09YAAMYYmnwW8h9+DoH8ox6CRWqB5ajcXJArz6dbRd60dZ+FrmJtKOAYGR5FR5LpkT2bXI4XaSccoeZbBr3jjG1RWf7ocPwkhRN5wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAn5X3v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD91C116C6;
	Mon,  3 Nov 2025 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762158160;
	bh=YDv22vyr4bQtUMxYJVP0QlxdmM2loUP8z8C33OqCi/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAn5X3v6uk7dZDnUWBpTMXs8robVOpfEv8DEm7sRhXYQeJ4kgxtySH0fUHDZN6DQe
	 Hkg+ZlSgOpX8jbyS2yZ8Prlt1tQ/PSlMtRsD9BqjH3751/vwK7yTB6jOSkvTXod8Bt
	 sDOZzPfAyeebHOza1V8k75yLSz5wKc7MLvapu8g76Bb3P0mIsWQIHABkBAphQJdM/b
	 +kGDHZinx0rtESxFb/R1m8uysRgr0caPKRQ7X5b9sLwWDFiUb4y4IjVYa71xhQmqCb
	 xInVB1BlhwiiEp3FLlVbuuvUbpz4plLBNR5E27khbRp0CGRVGu+7rnPX6GOS15Nq7U
	 DneVXqrGkZkHA==
Date: Mon, 3 Nov 2025 09:22:38 +0100
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
Subject: Re: [PATCH net-next v6 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add MaxLinear RMII refclk output property
Message-ID: <20251103-festive-aloof-nuthatch-fadd08@kuoka>
References: <cover.1761938079.git.daniel@makrotopia.org>
 <c25fdd18373a60eb566f4de85a17279f7ab5518b.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c25fdd18373a60eb566f4de85a17279f7ab5518b.1761938079.git.daniel@makrotopia.org>

On Fri, Oct 31, 2025 at 07:21:30PM +0000, Daniel Golle wrote:
> Add support for the maxlinear,rmii-refclk-out boolean property on port
> nodes to configure the RMII reference clock to be an output rather than
> an input.
> 
> This property is only applicable for ports in RMII mode and allows the
> switch to provide the reference clock for RMII-connected PHYs instead
> of requiring an external clock source.
> 
> This corresponds to the driver changes that read this Device Tree
> property to configure the RMII clock direction.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> v6:
>  * switch order of patches, move deviation from
>    dsa.yaml#/$defs/ethernet-ports to this patch which actually
>    needs it

and v5, v4, v3, v2 ? No lore links in the cover letter, incomplete
changelog.

> 
>  .../bindings/net/dsa/lantiq,gswip.yaml         | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index f3154b19af78..b494f414a3e1 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -6,8 +6,22 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Lantiq GSWIP Ethernet switches
>  
> -allOf:
> -  - $ref: dsa.yaml#/$defs/ethernet-ports
> +$ref: dsa.yaml#
> +
> +patternProperties:

patterns follow properties. Please do not introduce your own style, see
example schema.

> +  "^(ethernet-)?ports$":
> +    type: object
> +    patternProperties:
> +      "^(ethernet-)?port@[0-6]$":
> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          maxlinear,rmii-refclk-out:
> +            type: boolean
> +            description:
> +              Configure the RMII reference clock to be a clock output
> +              rather than an input. Only applicable for RMII mode.
>  
>  maintainers:
>    - Hauke Mehrtens <hauke@hauke-m.de>
> -- 
> 2.51.2

