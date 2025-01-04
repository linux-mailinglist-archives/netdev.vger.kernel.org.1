Return-Path: <netdev+bounces-155146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D484CA013C4
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8DF3A3DC7
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746B15CD52;
	Sat,  4 Jan 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtV2lszV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545591494DC;
	Sat,  4 Jan 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735984379; cv=none; b=d5sUwluCsKdS5GMuhGj0ruzkF/V2nUtlteOu+jowVBirGiE+v/ocBR82Of+KBfs0ZvdPrGhfI1qbw99YFNlVZ/M8S2QxassFXAwtXLyhHBSv/jhUTK3xn17At8A1EqsS6mTjuhRVxke0U2UPvIOVz6iunMZ7EcbHSU0CB2KaL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735984379; c=relaxed/simple;
	bh=QfJzHXidRnc8n8tGLP7uLoN3qg3Mje7Wh8IqxUGfnkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrkK1O0oyLf5F1r/Dc6SNW90J3wCddqN+noeN1rIr2O4ntxpA13W+jiJfzwUJrpU1yZVFWkpM81P1zzFuWwEU/FoQHiTHTELbbOUtRg/aAS6cQeJK4Vcv7FWPZz86jLIHJ/2vdPpSJX2ZOJ00aAvYIp3sKdV/e3gfulv5XhtuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtV2lszV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB3C4CED1;
	Sat,  4 Jan 2025 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735984378;
	bh=QfJzHXidRnc8n8tGLP7uLoN3qg3Mje7Wh8IqxUGfnkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtV2lszVE8q9tWAsv1su8HrlHzuuTxBFVBGDEuRyqSM2h+psvziC9LZkXPOjBbbqj
	 ZdQvnmwbebgkpRmZbVfap5XymcTGTUkB5EAYDORXoFYn0UlCb4bbExQ4OqLsHQRp2s
	 rzca9mKQtuIC8Xw/9d/yQy/TOIfR4lyNHtxApJO6kO7rUEcL8FmDzFqYodEDEE5FRq
	 0Nkqd/ofM4TYeD1r8LfWrPBiGDHZuTu3mnpKrW8fVeXM2c7UgLbajAQZKqVqOGdil2
	 tABRCpTu++6gbOJuPDycS3ImfI34hAVzBfXiLFTDZo3L3GO4M/2KZeV6nE71YcHfL7
	 8Z+cmh731C80w==
Date: Sat, 4 Jan 2025 10:52:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	Kyle Swenson <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>, 
	kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 25/27] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Message-ID: <rva5vyuksnw64j7hbgdjp2n4qw22a7niw4oc66dyaz5ndaa7ja@u6z4mavekjsw>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-25-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-feature_poe_port_prio-v4-25-dc91a3c0c187@bootlin.com>

On Fri, Jan 03, 2025 at 10:13:14PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch adds the regulator supply parameter of the managers.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> It updates also the example as the regulator supply of the PSE PIs
> should be the managers itself and not an external regulator.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> ---
>  .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml    | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> index fd4244fceced..0dc0da32576b 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> @@ -68,6 +68,9 @@ properties:
>            "#size-cells":
>              const: 0
>  
> +          vmain-supply:
> +            description: Regulator power supply for the PD69208X manager.

s/Regulator//
Keep it simple, no need to state obvious. What is not obvious here is
why there are no main device supplies (VDD, VDDA).

And what about VAUX5 and VAUX3P3? So basically the description is not
only redundant but actually incorrect because it suggests it is entire
supply, while there are others.

> +
>          patternProperties:
>            '^port@[0-7]$':
>              type: object
> @@ -106,10 +109,11 @@ examples:
>            #address-cells = <1>;
>            #size-cells = <0>;
>  
> -          manager@0 {
> +          manager0: manager@0 {
>              reg = <0>;
>              #address-cells = <1>;
>              #size-cells = <0>;
> +            vmain-supply = <&pse1_supply>;
>  
>              phys0: port@0 {
>                reg = <0>;
> @@ -128,7 +132,7 @@ examples:
>              };
>            };
>  
> -          manager@1 {
> +          manager1: manager@1 {

Not used.

Best regards,
Krzysztof


