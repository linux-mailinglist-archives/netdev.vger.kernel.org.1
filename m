Return-Path: <netdev+bounces-155143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFCA013B4
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9971634E6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B018871F;
	Sat,  4 Jan 2025 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFFQuOsY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206914E2E2;
	Sat,  4 Jan 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983755; cv=none; b=IRd+2LSvB/pU6YgUUj+WtKUkFRKfXDCGId9/aepyTv68IWHPxx8lHTbkSEPSGhi3HWT10qstHbsKhM26UiksFAZMbbVyPDmubNo++8QaH0JK00iXVmnP4gePSjwLrcAPk4f7PsX/WLWTL77H/z/4PR2g0aYI5Y1SJ/jxnNoumWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983755; c=relaxed/simple;
	bh=BdtKntSR84+kS/9hvgiNVSzjx77Oo0UwAneNtgTu3Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmONGBsJ1OlKJuimIcZo0SUdztLtLuiuBwdd7amygf2T7VCY9xzLpds/bsn4ABSAGiq3Qps8okAQE40ecqI9QRMMeIPWlV1lUomMm55NbWTkKg8XNOXDHc5eZtOv43pUGlAE2Knsel6umcdDa2cqvZKT5Z4YWpL7ji1W93EjXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFFQuOsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95170C4CED1;
	Sat,  4 Jan 2025 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735983755;
	bh=BdtKntSR84+kS/9hvgiNVSzjx77Oo0UwAneNtgTu3Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFFQuOsYn4hjqrLNsi5KmHamJ4DWxGsXi/TSluk83usnbiPIVixUE2hnmNhTb6KGN
	 JIKQEWgovpmdhj84eSAfLadSv8Y3IXWl/6h/MMvTx9mUblKaWlwLeJr/8QgrMSFYMp
	 jKxdHGiRPyqhfygaCTgb1v2bPEvOS7AFrCkNEQ8UHgn+eV5j3oM/GkTtIp5I0t+Ujt
	 DfPjheRljp+vFTht59Yn6GZo8lAzsw5xavzFId8xJAN/tXJExJ8o6fDE4iAI9chQ3B
	 ZM8ANSCBXdLK2CB+VRKYiHdbor07U28n7CFlOfXb6mbVi1Tl8d9ydOVgbA/tWiVlsT
	 QEHjmDhsL+PUg==
Date: Sat, 4 Jan 2025 10:42:32 +0100
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
Subject: Re: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <mjtwntmupclvy2dvc66zxxob3py47lew47vq37hfi6v6pmbpne@nr62lnuilzya>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>

On Fri, Jan 03, 2025 at 10:13:07PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Introduce a new property to describe the power budget of the regulator.
> This property will allow power management support for regulator consumers
> like PSE controllers, enabling them to make decisions based on the
> available power capacity.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - Add type.
> - Add unit in the name.
> 
> Changes in v2:
> - new patch.
> ---
>  Documentation/devicetree/bindings/regulator/regulator.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
> index 1ef380d1515e..c5a6b24ebe7b 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
> @@ -34,6 +34,11 @@ properties:
>    regulator-input-current-limit-microamp:
>      description: maximum input current regulator allows
>  
> +  regulator-power-budget-miniwatt:

What sort of quantity prefix is a "mini"? How much is a mini?

> +    description: power budget of the regulator
> +    $ref: /schemas/types.yaml#/definitions/uint32

This should not be needed. Use proper unit from dtschema.

> +
> +

Just one blank line.

Best regards,
Krzysztof


