Return-Path: <netdev+bounces-137750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F49A9979
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B61B214D6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA31465A1;
	Tue, 22 Oct 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knWuyIge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF08145B22;
	Tue, 22 Oct 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577482; cv=none; b=AaTzr+QB3KAklEN3A1aW4SoqMs2HYRK055b1QN3JbJrlwT9YKCB5xnhMxvnYulno8CzPKZ4d9nEb38PmTdCR6pBdfqgmP57vP9U9G2v+iSksrCfaGGFeIInfG+MMQg/uWyM/1phhRvRH2UXHLT3QdW+3L2VlB3Dw6l/9ZGhkw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577482; c=relaxed/simple;
	bh=Hq39wXmQHj0QFMyzEC2o6VYawvHcgxFMF0A/YuiCvy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwdR5zkPTT7ODbPtqwOo6g+/paSLppdMDeNDQjtX7z19GKhSpyj6zKnT1fgjgQ1mnU/J/RIx36KhdrFM01vVpZPVg/z1JO4ALRFcPX0zdLkHJz3gGm9NJR/mjxGR5IGizRXKXgUR1VTSR3k08p9ljlQIAq0i17Anmdor8+ZH75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knWuyIge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779AC4CEC7;
	Tue, 22 Oct 2024 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577482;
	bh=Hq39wXmQHj0QFMyzEC2o6VYawvHcgxFMF0A/YuiCvy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knWuyIgeHM9njcagtlKNNdtgEVWVX38Eu1pnTu1zeN5hlCzoPGn0T+rEdKY1uoCKv
	 SUs6KAQwPW+4g463Rkc88UfY4HvWbVOV8GIJ5Veyi9n/y0VFufPn8jz1ojo41WRy12
	 JU6CBTfntfISgmBL3stbiCcnEGExAM27dFeSusULQ0ITUDlYBcrugKRes930KvyR4R
	 5PoB+rMCN1xR7MRqwn5DllP5yEhl3TVcc40ogjK5xVujc1VnXW6h0LYLA8kpWm6AcN
	 3PPEwh+/0M+re+Gt0Hvob25lsKagw5RUPzsxjRlsLeqh9gi0UC4P6WonfNRcPr934v
	 QH6nBqmEwMShw==
Date: Tue, 22 Oct 2024 08:11:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, horatiu.vultur@microchip.com, 
	jensemil.schulzostergaard@microchip.com, Parthiban.Veerasooran@microchip.com, 
	Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com, 
	ast@fiberby.net, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 13/15] dt-bindings: net: add compatible strings
 for lan969x SKU's
Message-ID: <omfbhkikj6vthkssxcspdatoksifjp6khuxalvyhprijygm2ro@wa2zmixejjgw>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-13-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-13-c8c49ef21e0f@microchip.com>

On Mon, Oct 21, 2024 at 03:58:50PM +0200, Daniel Machon wrote:
> Add compatible strings for the twelve different lan969x SKU's (Stock
> Keeping Unit) that we need to support. We need to support all of them,
> as we are going to use them in the driver, for deriving the devicetree
> target in a subsequent patch.
> 
> Also, add myself as a maintainer.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  .../bindings/net/microchip,sparx5-switch.yaml           | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> index fcafef8d5a33..c38f0bd9a481 100644
> --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> @@ -9,6 +9,7 @@ title: Microchip Sparx5 Ethernet switch controller
>  maintainers:
>    - Steen Hegelund <steen.hegelund@microchip.com>
>    - Lars Povlsen <lars.povlsen@microchip.com>
> +  - Daniel Machon <daniel.machon@microchip.com>
>  
>  description: |
>    The SparX-5 Enterprise Ethernet switch family provides a rich set of
> @@ -34,7 +35,21 @@ properties:
>      pattern: "^switch@[0-9a-f]+$"
>  
>    compatible:
> -    const: microchip,sparx5-switch
> +    items:
> +      - enum:
> +          - microchip,sparx5-switch

Keep alphabetical order.

> +          - microchip,lan9691-switch
> +          - microchip,lan9692-switch
> +          - microchip,lan9693-switch
> +          - microchip,lan9694-switch
> +          - microchip,lan9695-switch
> +          - microchip,lan9696-switch
> +          - microchip,lan9697-switch
> +          - microchip,lan9698-switch
> +          - microchip,lan9699-switch
> +          - microchip,lan969a-switch
> +          - microchip,lan969b-switch
> +          - microchip,lan969c-switch

All of them use the same match data, so they are compatible? I have
doubts this is necessary in the first place. Your commit description about
driver does not help me. You need them because you are going to use
them? Yeah, it would be surprising otherwise. :)

Best regards,
Krzysztof


