Return-Path: <netdev+bounces-165511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE77A32684
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518717A2613
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952F20D51C;
	Wed, 12 Feb 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wtnCllAT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190120CCF5;
	Wed, 12 Feb 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365457; cv=none; b=cdCSntr+fU+6Z7JIbwBhE7nWSEa6WQYed02ydVtRGwU4vjMuoIWB8E38bArcIKzfFXxzaDghKnuJRBFDdyZx7FUJCbvgc+tbdMTlLk/kYYzmNWzbhHxOuOX6T5T405SUHjsLpQud1Uhm8FArJQm+h9QXpfR89SSHdClhNiVN03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365457; c=relaxed/simple;
	bh=XF3aE4u9MDVcJXLrzb1xDxpA18U3deRBPV3zVRngzZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INkivKTbYv3cpkcooFGouFSssYNBAWyp3Kr0KL2fR6YcmXO6s8l1DAmdCNUZHe8zE+A2kKfarQFHyfanlUvCIDOG9cy+aD6YIJKpqqS+Z5UsylXFdk1PCPvIT9G4lIB0W3R4VZELxYWQchlaEO8XYpN2NxD7z/EWrjVJUfQ4sS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wtnCllAT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0sj66E/QwXcmygIYcoyyi03W/kyTbRiJl+nH/qypQi4=; b=wtnCllATKXlCUCZrSQr5izWyYq
	Epn0gtEFhBE+wa6RvEeGujY1/zSRdCrl23VYsm8ydYVWqTg2sByVFqyOo+ofpuvSc/Xgp08UAgVgn
	KAweVTGJ7rGbmTYmV4IjEfLTdAyd6qX5uHVUOgSCxUpGK7xMcEApf7ZSSig1Xw1pyY50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCPK-00DOcU-H1; Wed, 12 Feb 2025 14:04:02 +0100
Date: Wed, 12 Feb 2025 14:04:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <b60f286a-75c8-4b60-9707-6d834fd4d3ad@lunn.ch>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>

On Tue, Feb 11, 2025 at 09:33:47AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add property tx-amplitude-100base-tx-percent in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2c71454ae8e362e7032e44712949e12da6826070..e0c001f1690c1eb9b0386438f2d5558fd8c94eca 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -232,6 +232,12 @@ properties:
>        PHY's that have configurable TX internal delays. If this property is
>        present then the PHY applies the TX delay.
>  
> +  tx-amplitude-100base-tx-percent:
> +    description:
> +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
> +      default will be left as is.
> +    default: 100

Doesn't having a default statement contradict the text? Maybe the
bootloader has set it to 110%, the text suggests it will be left at
that, but the default value of 100 means it will get set back to 100%?

What do your driver changes actually do?

	Andrew

