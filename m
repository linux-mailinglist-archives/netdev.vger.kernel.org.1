Return-Path: <netdev+bounces-243603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5329CA46DD
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCCF1304DA34
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C529ACF7;
	Thu,  4 Dec 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhnm4d2A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B704241CA2;
	Thu,  4 Dec 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864786; cv=none; b=tQX1hoaPBiYLHsFu0x9jrw1qKh73yiYZkG+YI6/V5c2jECj2EY+G2MBj6ka/koiSEJEM6BjYbsX9hhvtsLLbHDmvItqwe2QQS1v7ge1XVneD/KQ3ne8YMD9JJFdSN06AJh9YWnKXSUvedSebkhTanR66shlU9YFOzpOljhTYMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864786; c=relaxed/simple;
	bh=rlds9OxuuiX2BZpLBwXK3GF65T0dQAcIL0B/e32mGHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFg4OFfIklg+IFKqMYXNYIvCdU88SjfUm/JiYR7lUIE6mcdf95aX4gkJa63IF/22HhaNUiFqZdjLI9s/i/QvGgbVD3I0YPk5Y/6KcIqJAf42GpmaR9rxbKhJNJsrm0pVGFTOm9R1r3SvmY1SIVlKdxBbkmLIlFx+ZPdk90i2vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhnm4d2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26646C4CEFB;
	Thu,  4 Dec 2025 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864784;
	bh=rlds9OxuuiX2BZpLBwXK3GF65T0dQAcIL0B/e32mGHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vhnm4d2AoIz4CSFvSog+EJ5WuUZqGUAt43oQ4tTZ3yrdltV6tUeVeBH/O4GzhAmw9
	 X3gmeuCy32BF7mLD0+13u3pPxCtPMwvlNkheLbkrxaOtz4wDC7jx84+ETMoEYUH8aK
	 yKQ7IK2U+diiUAiSjEA7yfEqvLZQ8BJdBWp+UDugqyYXt1upgTJoN8188QOq1TJv6M
	 8+kvoLcFz5e0VA/aScMhl3P4EHSAiCPsI58Le8Hcsb7Qnp/F9qmL6U5Fp64LjJz5Vd
	 vCwJ+5tM/HYidRxgw+XpkCgTrcUkEzG1oL3yFDw3uw4qMIIudycU+7lFtV1wPynE4O
	 A8KlSPWvYuMdw==
Date: Thu, 4 Dec 2025 10:13:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-phy@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 3/9] dt-bindings: phy-common-props: RX and TX
 lane polarity inversion
Message-ID: <176486478133.1579282.8723601049864810210.robh@kernel.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-4-vladimir.oltean@nxp.com>


On Sat, 22 Nov 2025 21:33:35 +0200, Vladimir Oltean wrote:
> Differential signaling is a technique for high-speed protocols to be
> more resilient to noise. At the transmit side we have a positive and a
> negative signal which are mirror images of each other. At the receiver,
> if we subtract the negative signal (say of amplitude -A) from the
> positive signal (say +A), we recover the original single-ended signal at
> twice its original amplitude. But any noise, like one coming from EMI
> from outside sources, is supposed to have an almost equal impact upon
> the positive (A + E, E being for "error") and negative signal (-A + E).
> So (A + E) - (-A + E) eliminates this noise, and this is what makes
> differential signaling useful.
> 
> Except that in order to work, there must be strict requirements observed
> during PCB design and layout, like the signal traces needing to have the
> same length and be physically close to each other, and many others.
> 
> Sometimes it is not easy to fulfill all these requirements, a simple
> case to understand is when on chip A's pins, the positive pin is on the
> left and the negative is on the right, but on the chip B's pins (with
> which A tries to communicate), positive is on the right and negative on
> the left. The signals would need to cross, using vias and other ugly
> stuff that affects signal integrity (introduces impedance
> discontinuities which cause reflections, etc).
> 
> So sometimes, board designers intentionally connect differential lanes
> the wrong way, and expect somebody else to invert that signal to recover
> useful data. This is where RX and TX polarity inversion comes in as a
> generic concept that applies to any high-speed serial protocol as long
> as it uses differential signaling.
> 
> I've stopped two attempts to introduce more vendor-specific descriptions
> of this only in the past month:
> https://lore.kernel.org/linux-phy/20251110110536.2596490-1-horatiu.vultur@microchip.com/
> https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/
> 
> and in the kernel we already have merged:
> - "st,px_rx_pol_inv"
> - "st,pcie-tx-pol-inv"
> - "st,sata-tx-pol-inv"
> - "mediatek,pnswap"
> - "airoha,pnswap-rx"
> - "airoha,pnswap-tx"
> 
> and maybe more. So it is pretty general.
> 
> One additional element of complexity is introduced by the fact that for
> some protocols, receivers can automatically detect and correct for an
> inverted lane polarity (example: the PCIe LTSSM does this in the
> Polling.Configuration state; the USB 3.1 Link Layer Test Specification
> says that the detection and correction of the lane polarity inversion in
> SuperSpeed operation shall be enabled in Polling.RxEQ.). Whereas for
> other protocols (SGMII, SATA, 10GBase-R, etc etc), the polarity is all
> manual and there is no detection mechanism mandated by their respective
> standards.
> 
> So why would one even describe rx-polarity and tx-polarity for protocols
> like PCIe, if it had to always be PHY_POL_AUTO?
> 
> Related question: why would we define the polarity as an array per
> protocol? Isn't the physical PCB layout protocol-agnostic, and aren't we
> describing the same physical reality from the lens of different protocols?
> 
> The answer to both questions is because multi-protocol PHYs exist
> (supporting e.g. USB2 and USB3, or SATA and PCIe, or PCIe and Ethernet
> over the same lane), one would need to manually set the polarity for
> SATA/Ethernet, while leaving it at auto for PCIe/USB 3.0+.
> 
> I also investigated from another angle: what if polarity inversion in
> the PHY is one layer, and then the PCIe/USB3 LTSSM polarity detection is
> another layer on top? Then rx-polarity = <PHY_POL_AUTO> doesn't make
> sense, it can still be rx-polarity = <PHY_POL_NORMAL> or <PHY_POL_INVERT>,
> and the link training state machine figures things out on top of that.
> This would radically simplify the design, as the elimination of
> PHY_POL_AUTO inherently means that the need for a property array per
> protocol also goes away.
> 
> I don't know how things are in the general case, but at least in the 10G
> and 28G Lynx SerDes blocks from NXP Layerscape devices, this isn't the
> case, and there's only a single level of RX polarity inversion: in the
> SerDes lane. In the case of PCIe, the controller is in charge of driving
> the RDAT_INV bit autonomously, and it is read-only to software.
> 
> So the existence of this kind of SerDes lane proves the need for
> PHY_POL_AUTO to be a third state.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../bindings/phy/phy-common-props.yaml        | 45 +++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |  4 ++
>  2 files changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


