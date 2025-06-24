Return-Path: <netdev+bounces-200533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A639AE5EE2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BE17B0C26
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5666255F53;
	Tue, 24 Jun 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D27XIDOD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469B22D9ED;
	Tue, 24 Jun 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753011; cv=none; b=A/MK0uCQzQwOOYgL0FlDJIjyg2V2txypw3fDZrXndExx25sI276zwNWXmeH6V6yUjfu5GJKgpJ9E6XPhGv1P04eGRTZE5I4Xgwxf2JXhDOWlfgfoYZOUJC4ybqIWX9EVCJ4G70jt8sxmKp5Ejs1skgpMhM+7aKAGQv6TN2L8R7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753011; c=relaxed/simple;
	bh=NBm7n8cvZBw6HTko9M9D97Lqr/lsqlB20GFEmgKmdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVKkj5ebH2mHvOizeuLHTM5nyLtOoLU8WPycvy7/SHicD9r/9iyI/bACINajtxyKx0s5ux9Sj5tPrJGZzp8toEi/IEo1YcSLxB+d5jzA/jmBdnNWKF0kg7jy85h6TMCYlCJg4q2Y2dpDPPUmAOlbQCfdt70K61/uv6KyXLUyETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D27XIDOD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mMnMLYCAgxCT8gkPeig8C/G/rXJSBpt5RF65PZMjsdg=; b=D27XIDOD17q4O65To2PG5W+KJq
	kGJ7PN3qvRLghHdjyJUT3rwQpo1dkyYYlW2OdsEdJKU0qofBChOwP0PQqfT1mBQNHhYJMCxmSYub9
	OcABdfMKRtXFZTSKxJutatMYGyHscoyuHH00nl/aAXBmglZgYilt5xhYGSDJRJYU2J1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTypJ-00Glmv-AQ; Tue, 24 Jun 2025 10:16:21 +0200
Date: Tue, 24 Jun 2025 10:16:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Frederic Lambert <frdrc66@gmail.com>,
	Gabor Juhos <juhosg@openwrt.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] ARM: dts: Fix up wrv54g device tree
Message-ID: <08531445-a27d-413f-96de-81087d6f61e1@lunn.ch>
References: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
 <20250624-ks8995-dsa-bindings-v1-2-71a8b4f63315@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-ks8995-dsa-bindings-v1-2-71a8b4f63315@linaro.org>

On Tue, Jun 24, 2025 at 09:41:12AM +0200, Linus Walleij wrote:
> Fix up the KS8995 switch and PHYs the way that is most likely:
> 
> - Phy 1-4 is certainly the PHYs of the KS8995 (mask 0x1e in
>   the outoftree code masks PHYs 1,2,3,4).
> - Phy 5 is likely the separate WAN phy directly connected
>   to ethc.
> - The ethb is probably connected as CPU interface to
>   the KS8995.
> 
> There are some confused comments in the old board file
> replicated into the device tree like ethc being "connected
> to port 5 of the ks8995" but this makes no sense as it
> is certainly connected to a phy.
> 
> Properly integrate the KS8995 switch using the new bindings.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts  | 75 +++++++++++++++++-----
>  1 file changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
> index 98275a363c57cde22ef57c3885bc4469677ef790..14b766083e3a870a1154a93be74af6e6738fe137 100644
> --- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
> +++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
> @@ -72,10 +72,50 @@ spi {
>  		cs-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>  		num-chipselects = <1>;
>  
> -		switch@0 {
> +		ethernet-switch@0 {
>  			compatible = "micrel,ks8995";
>  			reg = <0>;
>  			spi-max-frequency = <50000000>;
> +
> +			ethernet-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ethernet-port@0 {
> +					reg = <0>;
> +					label = "1";
> +					phy-mode = "rgmii";

If this is an internal PHY, it would be better to use 'internal'. I
would like to avoid all the issues around 'rgmii' vs 'rgmii-id'.

> +				ethernet-port@4 {
> +					reg = <4>;
> +					ethernet = <&ethb>;
> +					phy-mode = "rgmii-id";
> +					fixed-link {
> +						speed = <100>;
> +						full-duplex;
> +					};

That is a bit odd, rgmii-id, yet speed limited to 100. It would be
good to add a comment about this.

> @@ -134,41 +174,44 @@ pci@c0000000 {
>  			<0x0800 0 0 2 &gpio0 10 IRQ_TYPE_LEVEL_LOW>; /* INT B on slot 1 is irq 10 */
>  		};
>  
> -		/*
> -		 * EthB - connected to the KS8995 switch ports 1-4
> -		 * FIXME: the boardfile defines .phy_mask = 0x1e for this port to enable output to
> -		 * all four switch ports, also using an out of tree multiphy patch.
> -		 * Do we need a new binding and property for this?
> -		 */
> -		ethernet@c8009000 {
> +		ethb: ethernet@c8009000 {
>  			status = "okay";
>  			queue-rx = <&qmgr 3>;
>  			queue-txready = <&qmgr 20>;
> -			phy-mode = "rgmii";
> -			phy-handle = <&phy4>;
> +			phy-mode = "rgmii-id";
> +			fixed-link {
> +				speed = <100>;
> +				full-duplex;
> +			};

This is all confusing. Do you have the board, or a schematic for it? 

Looking at the old DT, this ethernet interface has its own MDIO bus,
with PHYs at address 4 and 5. The phy-handle above means this MAC is
connected to the PHY at address 4. The PHY at address 5 is connected
to the second MAC instance of this SoC. This implies it is:

SOC:MAC-PHY-PHY-MAC:SWITCH 

Rather than the more usual back to back MAC. There are boards with
back to back PHY, so it is not out of the question.

However, it could also be this old DT description is completely
broken, and the PHYs on this bus are the external PHYs for the
switches? There should not be a phy-handle in the MAC nodes.

>  
>  			mdio {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
> -				/* Should be ports 1-4 on the KS8995 switch */
> +				/* Should be LAN ports 1-4 on the KS8995 switch */
> +				phy1: ethernet-phy@1 {
> +					reg = <1>;
> +				};
> +				phy2: ethernet-phy@2 {
> +					reg = <2>;
> +				};
> +				phy3: ethernet-phy@3 {
> +					reg = <3>;
> +				};
>  				phy4: ethernet-phy@4 {
>  					reg = <4>;
>  				};

This node is the SoC interface MDIO bus. Why would the internal PHYs
of switch bus on the SoC MDIO bus? I would expect the switch to have
its own MDIO bus and place its PHYs there.

	Andrew

