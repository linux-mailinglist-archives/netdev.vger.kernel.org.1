Return-Path: <netdev+bounces-140722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C639B7B51
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DB0B258B4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3719D897;
	Thu, 31 Oct 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FRbA/9fi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3C19D892;
	Thu, 31 Oct 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379901; cv=none; b=vFDV5osBDjz1EAk4Bx503PtgKSx/WEBWsgmieNNjkLV87vrSkQcB+O4vR6oaOIJXM41JJfc5HAe3KVq8bjcgAMIUAl9KtTCv93Zuw9fKW8q4JrpEbTQ7HMsCX+aJNWorT55kC2gsM5/8gXeaaVtfYCOuLzu84UXsjIyLl4KjLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379901; c=relaxed/simple;
	bh=XUEUdiZZ588RY/DmjfG2Rv2p7ELbqn2IBxk/dYJU760=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIz1B9gBuhQg4W52DLWHnjr19zUlY2OfGDRnJYAo9r0plSPeUCE/xgR70n6DM6BZVRg3zTIABj1pf1WZtQF7h/D3J5TjngbCxVGktj2RHlAhhYmyNKBAlOxGNSElHiPGaSUQiw2XGOW+42NXLXz8KVRpx7Wq1r3SmiUynKR3yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FRbA/9fi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3D8AOsFf2lVt9L71mkZVmKIqNbDdk74xgKnAtcWILOc=; b=FRbA/9fi/pVNHzTX7/ZaLC24xA
	alEpwQWuUyVEDaZmSc+lBB9O4PRee3nl6Ud4bE/zBqTnrzb16nHnp2K7Usvs/WjANG/ecjK/5uYbM
	AIcMrYCSguzUmhTFgg/F38+QTMOfdGQX448zKFI3YV9FYtIybDFvbafVXH5KD2Gb8xEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6Uql-00Bmpa-82; Thu, 31 Oct 2024 14:04:31 +0100
Date: Thu, 31 Oct 2024 14:04:31 +0100
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
Message-ID: <e389a60d-2fe3-46fd-946c-01dd3a0a0f6f@lunn.ch>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
 <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>

> > > > +		gmac0: ethernet@4070000 {
> > > > +			compatible = "snps,dwmac-3.70a";
> > > > +			reg = <0x04070000 0x10000>;
> > > > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > > > +			clock-names = "stmmaceth", "ptp_ref";
> > > > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			interrupt-names = "macirq";
> > > > +			phy-handle = <&phy0>;
> > > > +			phy-mode = "rmii";
> > > > +			rx-fifo-depth = <8192>;
> > > > +			tx-fifo-depth = <8192>;
> > > > +			snps,multicast-filter-bins = <0>;
> > > > +			snps,perfect-filter-entries = <1>;
> > > > +			snps,aal;
> > > > +			snps,txpbl = <8>;
> > > > +			snps,rxpbl = <8>;
> > > > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > > > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > > > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > > > +			status = "disabled";
> > > > +
> > > > +			mdio {
> > > > +				compatible = "snps,dwmac-mdio";
> > > > +				#address-cells = <1>;
> > > > +				#size-cells = <0>;
> > > > +
> > > > +				phy0: phy@0 {
> > > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > > +					reg = <0>;
> > > > +				};
> > > > +			};
> > > 
> > > It is not clear to me what cv18xx.dtsi represents, 
> > 
> > This is a include file to define common ip for the whole
> > cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> > 
> > > and where the PHY node should be, here, or in a .dts file. 
> > > Is this a SOM, and the PHY is on the SOM? 
> > 
> > The phy is on the SoC, it is embedded, and no external phy
> > is supported. So I think the phy node should stay here, not 
> > in the dts file.
> 
> There is a mistake, Some package supports external rmii/mii
> phy. So I will move this phy definition to board specific.

When there is an external PHY, does the internal PHY still exists? If
it does, it should be listed, even if it is not used.

Do the internal and external PHY share the same MDIO bus? I've seen
some SoCs with complex MDIO muxes for internal vs external PHYs.

	Andrew

