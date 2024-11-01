Return-Path: <netdev+bounces-141010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE09B9135
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0677C28251B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176819E7F7;
	Fri,  1 Nov 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h0FAhilm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0822097;
	Fri,  1 Nov 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464817; cv=none; b=I7sXU+wTSJ+vBCt8igx5Y71Opz/6150HPJ9/dZc/MGyMCKYPdZs+e2UhQei8mYu04oIuvID6olSlp0o1vvun33k6Z+meRQ6sNfgWL/R3Z+6c+Ik/nws1i4fF/rLWSD9d/FFkvlXAyxCqNorom3qgJikFamrzGIgwbtER6Lm0SHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464817; c=relaxed/simple;
	bh=QNXdyGnqE6MurJIcF0ns6jB3cXGZVUEvz/Y3ylybaQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOPCZ4C8a5eZIRJKDxkArkNGbtFhU6Sq9TBHUvf855dNalGzceHKZG/AbSpORqkh/NeQVMEtgmrtounGEs7girt/wIUlPDXRsLqjwrDN4IyEzPPNciZVIgzBiBTv9fEhJ0auyw4cXkKFKnUhAhH79NB+XC/sVy7wzbXS1SR9gKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h0FAhilm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JLfKetvUuxPUYkpPeA7mnXrzdgQkP5ynoIU4H8aYS3U=; b=h0FAhilmGmVBQ5NQWg3uCkBa5Z
	wBWcuyUI17qGVzn7hgmPZYc8+Y/8faJQW7qsFUCd4+QAan8AfGgxrSLUThwbNqFCSqRFnV8RWNRFl
	DvvjfhGliWxog9tagmqENZzMNVIlzb7BrBGuszd5VPi+LN8iAw7MpZz4Ue4QhsS0WqoI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6qwa-00BsXZ-SD; Fri, 01 Nov 2024 13:40:00 +0100
Date: Fri, 1 Nov 2024 13:40:00 +0100
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
Message-ID: <5b08e092-c302-43a9-a04d-3566bec96e94@lunn.ch>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
 <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>
 <e389a60d-2fe3-46fd-946c-01dd3a0a0f6f@lunn.ch>
 <nkydxanwucqmbzzz2fb24xyelrouj6gvhuuou2ssbf4tvvhfea@6uiuueim7m3a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nkydxanwucqmbzzz2fb24xyelrouj6gvhuuou2ssbf4tvvhfea@6uiuueim7m3a>

> > > > > > +			mdio {
> > > > > > +				compatible = "snps,dwmac-mdio";
> > > > > > +				#address-cells = <1>;
> > > > > > +				#size-cells = <0>;
> > > > > > +
> > > > > > +				phy0: phy@0 {
> > > > > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > > > > +					reg = <0>;
> > > > > > +				};
> > > > > > +			};
> > > > > 
> > > > > It is not clear to me what cv18xx.dtsi represents, 
> > > > 
> > > > This is a include file to define common ip for the whole
> > > > cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> > > > 
> > > > > and where the PHY node should be, here, or in a .dts file. 
> > > > > Is this a SOM, and the PHY is on the SOM? 
> > > > 
> > > > The phy is on the SoC, it is embedded, and no external phy
> > > > is supported. So I think the phy node should stay here, not 
> > > > in the dts file.
> > > 
> > > There is a mistake, Some package supports external rmii/mii
> > > phy. So I will move this phy definition to board specific.
> > 
> > When there is an external PHY, does the internal PHY still exists? If
> > it does, it should be listed, even if it is not used.
> > 
> > Do the internal and external PHY share the same MDIO bus? 
> 
> They share the same MDIO bus and phy id setting.

What do you mean by phy ID?

> When an external phy
> is select, the internal one is not initialized and can not be accessed
> by the SoC.
> 
> > I've seen some SoCs with complex MDIO muxes for internal vs external
> > PHYs.
> > 
> > 	Andrew
> 
> There is a switch register on the SoC to decide which phy/mode is used. 
> By defaut is internal one with rmii mode. I think a driver is needed to
> handle this properly.

This sounds like a complex MDIO mux. You should think about this now,
because others have left this same problem too late and ended up with
a complex design in order to keep backwards compatibility with old DT
blobs which don't actually describe the real hardware.

	Andrew

