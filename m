Return-Path: <netdev+bounces-139773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78739B40A4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69921C2249F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71201E0E1D;
	Tue, 29 Oct 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dvKgnwL+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824294400;
	Tue, 29 Oct 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170257; cv=none; b=qOp7o1XTnUeX4j09bZ+ocCTLs9YhMCL3bmqxVX+ISekuUS+JojlrD9PDpkzQ3ELilayVMEsgaCUY377KJnxUuMAeJwgMQfa7+VqcGz7pBLUjPyuL3qJ5bmh6iAZSr+hfHYc6Xwqu8ZxMDOAwK10Tx0qnoY0dOHpiOhmATRQ6n1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170257; c=relaxed/simple;
	bh=rbs6zdmlmEO16BukbbW/kX6BRAgAHqPcAzpnhOyj4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pozc/dF0p6jWSRMTvj78GQhtV3BlssBl79YnVQlClRcb0dBLjD84sUdbWflqfv2HZhjYd+k28Fv39+PFQH5nMCIzaAk9dSZXwCkttaEGCrNqcmsSXvvU8IKPfE+AuXcHrvhr4wN5BSP/ZBef3aqGJ9w3LrTLpBGy83h2AzNiJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dvKgnwL+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4x7+NMYuwtDNvuiXxIkan9s38gNFO7jrlobgIQdg9wI=; b=dvKgnwL+xlxDZYgcteGPA7b1b7
	mLcb/Toa8r1YLBarjgVedww/AUh/e93nYKxJn0MCiIuXh1j8B+aBur60A4HEBBxqIfiLMvlt4rF0O
	7jPcAv+gcq+yNAuTKebC5HnZ9CB2ptTJoX+sj2mDMLGrqaP5KDvKrRk1CSAhwJWRWCDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5cJd-00BWHU-42; Tue, 29 Oct 2024 03:50:41 +0100
Date: Tue, 29 Oct 2024 03:50:41 +0100
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
Message-ID: <ab0ed945-07ff-4aff-9763-e31f156df25f@lunn.ch>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>

On Tue, Oct 29, 2024 at 06:43:03AM +0800, Inochi Amaoto wrote:
> On Mon, Oct 28, 2024 at 02:09:06PM +0100, Andrew Lunn wrote:
> > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > @@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
> > >  			status = "disabled";
> > >  		};
> > >  
> > > +		gmac0: ethernet@4070000 {
> > > +			compatible = "snps,dwmac-3.70a";
> > > +			reg = <0x04070000 0x10000>;
> > > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > > +			clock-names = "stmmaceth", "ptp_ref";
> > > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "macirq";
> > > +			phy-handle = <&phy0>;
> > > +			phy-mode = "rmii";
> > > +			rx-fifo-depth = <8192>;
> > > +			tx-fifo-depth = <8192>;
> > > +			snps,multicast-filter-bins = <0>;
> > > +			snps,perfect-filter-entries = <1>;
> > > +			snps,aal;
> > > +			snps,txpbl = <8>;
> > > +			snps,rxpbl = <8>;
> > > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > > +			status = "disabled";
> > > +
> > > +			mdio {
> > > +				compatible = "snps,dwmac-mdio";
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				phy0: phy@0 {
> > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > +					reg = <0>;
> > > +				};
> > > +			};
> > 
> > It is not clear to me what cv18xx.dtsi represents, 
> 
> This is a include file to define common ip for the whole
> cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> 
> > and where the PHY node should be, here, or in a .dts file. 
> > Is this a SOM, and the PHY is on the SOM? 
> 
> The phy is on the SoC, it is embedded, and no external phy
> is supported. So I think the phy node should stay here, not 
> in the dts file.

So this is correct when the PHY is internal. However, this is normally
expressed by setting phy-mode to "internal". The stmmac driver might
however not allow that? If not, please put a comment indicating the
PHY is part of the SoC.

	Andrew

