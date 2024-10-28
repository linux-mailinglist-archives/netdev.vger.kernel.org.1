Return-Path: <netdev+bounces-139564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE1F9B3158
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F17DB20B44
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB41DACBF;
	Mon, 28 Oct 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ja+JEpjX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DF1D95AA;
	Mon, 28 Oct 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120967; cv=none; b=VwYT61RmuRjs8UjpTjNDNRH+2E267v+uvLCtMGneF4DctBxK6fLc7fIzJfP/PMONZsRpWpXGLXYjYB17HBaI9S7NLUXMbLS8SA5kJv/ncwJab408+TaaYh9IZpCkh+tjEXdE1cDXARNwL6MTbbynQmEfZZz+E4gcUg+HxUAXJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120967; c=relaxed/simple;
	bh=6wCQMlrgt6lYnuEoKEVhz9bgUiOg1iAN6HAPvAPdnxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiAqDD3hPkHjOYWG9lMClRYnVA9TyAtwdOPAdA5Kq5figErFKqL0Np4XbCO+050dIeum1JvLyXPvPX74rmkB/7qQEjZduWlE2/4F8t32GRrNompr/R9pZh97LLUNg3QO4q7dsxIK5Ks0qlLTHy59/rLTtgRR3FpzhsC0NFp+XjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ja+JEpjX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M4yLqeOrbHH4FmbActu2ScliDa0zYtrRnOaaCWz9Ck0=; b=Ja+JEpjXk2hNrYyTd9R5/iNCD7
	17R4I5fL/ZTQmfp+sgxAIXw7l7HhaJSm34OjKTFJPs3SaPFZW+ROI1PG5AbXEJqTw4I7xdbz0D277
	/7/IrEd6PQaOd3Cl8v1033LbymjkxiMGk5hx7EefLgfbalSt1/uORcRQpA6NHgpS+G34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5PUY-00BRq4-28; Mon, 28 Oct 2024 14:09:06 +0100
Date: Mon, 28 Oct 2024 14:09:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: Add ethernet configuration for cv18xx
Message-ID: <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
References: <20241028011312.274938-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028011312.274938-1-inochiama@gmail.com>

> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
>  			status = "disabled";
>  		};
>  
> +		gmac0: ethernet@4070000 {
> +			compatible = "snps,dwmac-3.70a";
> +			reg = <0x04070000 0x10000>;
> +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> +			clock-names = "stmmaceth", "ptp_ref";
> +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			phy-handle = <&phy0>;
> +			phy-mode = "rmii";
> +			rx-fifo-depth = <8192>;
> +			tx-fifo-depth = <8192>;
> +			snps,multicast-filter-bins = <0>;
> +			snps,perfect-filter-entries = <1>;
> +			snps,aal;
> +			snps,txpbl = <8>;
> +			snps,rxpbl = <8>;
> +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> +			status = "disabled";
> +
> +			mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				phy0: phy@0 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <0>;
> +				};
> +			};

It is not clear to me what cv18xx.dtsi represents, and where the PHY
node should be, here, or in a .dts file. Is this a SOM, and the PHY is
on the SOM? 

	Andrew

