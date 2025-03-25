Return-Path: <netdev+bounces-177481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86530A704D1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17CB1883840
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3025BAC7;
	Tue, 25 Mar 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SPc4yNT3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AF256C7A;
	Tue, 25 Mar 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915659; cv=none; b=kYCS61yt6+K4kiTu8rwkk8LGyDW+dE6AYQoknR3O+ye6+lx/ngKuovXLvRzkexare+fvs48AclozEgGKxPSeD9qyjzj7CVkdBf1f+2tos4nonPvecC4GRV8fDojEj1yDVcfpXLgD5BHNLEcFA8smLwOxAyfwoDM1/bhjG4vI40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915659; c=relaxed/simple;
	bh=jSkEJPEqkW5LWIo0VxKkBQc2W3VLZCRiU011fP09tMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kma107r0wDuIkZB8rqRczURZOR0nSCLU0JGrnGbNDCuDuo0MgHIfpAW6DygrLJ4hov09rtOz5OWYeF/zfB1VpaFs1DKTUJP2k+2vP0PoKBAUN83xidelpRcQ8ViL2oUFlsQrKs4xHK5sOirODxOvazUGr8gYjhqs+IkJ0XJFczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SPc4yNT3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e9BYomaOrXBuNI0X4uTrl/CKPbTYsn1WfQ0/aRiNpfU=; b=SPc4yNT3r+UVTqPntSELDQ9DY/
	nQDCXjZg9NxIiwhxY2lERc9folGnr2s3OC9xAAXT/f9HsqrFiRRlb1H2oJ1H4ssHYmNbXTqezL/g8
	22uMPcvjz2XFkGeTmHu37gbEpdLz4KfnC6IoOW6S3mh4KD7K98AT6QigejSyv/vJcpbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx5yj-0074Qk-9i; Tue, 25 Mar 2025 16:14:09 +0100
Date: Tue, 25 Mar 2025 16:14:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 4/5] arm: dts: imx287: Provide description for MTIP L2
 switch
Message-ID: <40c6c272-d4a3-4bf2-87a1-17086d96afea@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325115736.1732721-5-lukma@denx.de>

On Tue, Mar 25, 2025 at 12:57:35PM +0100, Lukasz Majewski wrote:
> This description is similar to one supprted with the cpsw_new.c
> driver.
> 
> It has separated ports and PHYs (connected to mdio bus).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> index 6c5e6856648a..e645b086574d 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> @@ -5,6 +5,7 @@
>   */
>  
>  /dts-v1/;
> +#include<dt-bindings/interrupt-controller/irq.h>
>  #include "imx28-lwe.dtsi"
>  
>  / {
> @@ -18,6 +19,61 @@ &can0 {
>  	status = "okay";
>  };
>  
> +&eth_switch {
> +	compatible = "fsl,imx287-mtip-switch";

The switch is part of the SoC. So i would expect the compatible to be
in the .dtsi file for the SoC.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
> +	phy-supply = <&reg_fec_3v3>;
> +	phy-reset-duration = <25>;
> +	phy-reset-post-delay = <10>;
> +	interrupts = <100>, <101>, <102>;
> +	clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> +	clock-names = "ipg", "ahb", "enet_out", "ptp";

Which of these properties are SoC properties? I _guess_ interrupts,
clocks and clock-names. So they should be in the SoC .dtsi file. You
should only add board properties here.

       Andrew

