Return-Path: <netdev+bounces-179355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63DA7C193
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7A87A7C5F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D971F4282;
	Fri,  4 Apr 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tEv/3P0V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC81E1DE5
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784415; cv=none; b=MqeqEBe+lI4ixA6OSVycMwpH55cRXAkqmVi6nbRb5GJNmhHDT68o0s5UGSFN/kavTUoYEV6uJDf1KtKdARMJER4NOBvHQisyJzA18BoXJpcp/BTzWp9ct/8pRxCw81tmxNA52LTXOAGpUQzc1KO2nlmnkmObjnwGKDm/xcLQRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784415; c=relaxed/simple;
	bh=DYpsEZ0F/B0jeAg5F8F+hIVilOxHCU5XT9sciDSnFb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsGkSdpDd+yFjV3P0us9ofobfXPFsxWpPd2k8pAcLWnYClkRNCZHg/ml3t1KygcpmqQHreIWFvEuJTKcuCTa83pUymHjYsjPsBeLaS7I84WwJDz0HyfRjOu9tPOP5ATDWRAS3w6hM84pZ3oF9678ImauJ+W0EcLm9R/knD3mwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tEv/3P0V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rIaP0Oe52Rsj+tzF4BQOcrLCL+WZ6dkzbOdGTYBx0gA=; b=tEv/3P0V6FX86a+LYcFPruAaW5
	VAvzAJLe0q5r5XFYPI1Tgs7qhc7H+iKpqZdGkIgUam2Z+KZJfO4g0awfLklBBTlMGzCrrxV8UZCfc
	LpUcWMrryVPwb0BYkv9oiSfdVlS6QlpWw1ndS0ha9Z1OZ0+UOA8mm8xIGoXf3rRHdsyE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u0jyw-0084Ek-1Q; Fri, 04 Apr 2025 18:33:26 +0200
Date: Fri, 4 Apr 2025 18:33:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>

> Part of the issue is that I think I may be mixing terms up and I have
> to be careful of that. If I am not mistaken you refer to the PHY as
> the full setup from the MII down to the other side of the PMA or maybe
> PMD. I also have to resist calling our PMA a PHY as it is a SerDes
> PHY, not an Ethernet PHY.

For us, a PHY is something like:

https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-transceivers/marvell-phys-transceivers-alaska-88e151x-datasheet.pdf

https://www.ti.com/lit/ds/symlink/dp83867ir.pdf

It has an MII interface one side, and a Base-T interface the other,
where you connect magnetics and an RJ-45.

It gets a bit more complex with devices like the Marvell 10G PHY,
which can be used as an MII to MII converter typically used to convert
the MII output from the MAC to something you can connect to an SFP
cage.

PHYs are not necessarily soldered to the board, they can also be
inside SFPs. Copper 1G SFPs typically use a Marvell m88e1111 PHY.

Just to add more confusion, Linux also has generic PHYs, which came
later than PHYs, drivers/phy. A SERDES interface can be pretty
generic, and can be used for multiple protocols. Some SoCs have SERDES
interfaces which you can configure for USB, SATA, or
networking. Generic PHYs hand this protocol switch. For some, you even
need to configure the subprotocol SGMII, 1000BaseX, 2500BaseX.

All this terminology has been driven mostly from SoCs, because x86
systems either hid all this in firmware, or like the intel drivers,
wrote there own MDIO and PHY drivers inside there MAC drivers.

So for a long time we talked about MII, GMII, RGMII, which are
relatively simple MII interfaces. Things got more complex with SGMII,
1000BaseX, 2500BaseX, 10GBaseX since you then have a PCS, and the PCS
is an active part, performing signalling, negotiation, except when
vendors broke it because why run SGMII at 2.5 times the clock speed
and call it 2500BaseX, which is it not...

We needed something to represent that negotiation, so drivers/net/pcs
was born, with a lot of helpers for devices which follow 802.3
registers.

So for us, we have:

MAC - PHY
MAC - PCS - PHY
MAC - PCS - SFP cage
MAC - PCS - PHY - SFP cage

This is why i keep saying you are pushing the envelope. SoC currently
top out at 10GbaseX. There might be 4 lanes to implement that 10G, or
1 lane, but we don't care, they all get connected to a PHY, and BaseT
comes out the other side.

	Andrew

