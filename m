Return-Path: <netdev+bounces-127843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D542A976DBF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C79E1F29DB0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660991B12FD;
	Thu, 12 Sep 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="277TqTKd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9B548E0;
	Thu, 12 Sep 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154896; cv=none; b=PzPwTO4NqBOu9ddtuRWJLp7sG+Kvr3iUYHR02dBo8MqPxnaHSsgF+GaqAlTxtRHUWKXLbJjZ3ceIBy6g6p837R8ibNUYb4j1Qip6HRyMRnHwYSn64j1Ujdlkn2osuUMTXbOPDTdLox5zeIDl0uA2MyMV7z3y2G7nV49iXerW8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154896; c=relaxed/simple;
	bh=pYgVyTrj3EPheRBKGvDhoJnds5qSV20clSUzKPNw1pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAsxfuJWxQEDwaYxf4yg7VRBjYX/M6DS8wMM2oexGvcI5lppXdDMMU5UHHgI5PHOuYqPEUug8WJnIG5X2TCD9vhvWL0Q8bMtZgrdO6jqUwVJK+N7gfvIb2hlscBZwWjkL5ti5s0Yq8ergFyY4Jxj4AdofePbPWcTYr10hqqNx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=277TqTKd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tI9kvm+HnL0YeKQzBOoR82/5uRh5sxlcs29HkgCcm5k=; b=277TqTKd44LFt0BzPGWBTBMSUs
	nmstv4sSYViFUCJyQIqZ0mqKChc4mtzucuy/nVDesMQ4x+eareEfPyz58LTuQiTlql9k4lUFOwTQw
	laGG4SOW/CPOM3ieCB1pmQ7e2rzMIi3tQuMxqalvd1lmOY5hFWiMiZOWsQcPllNqbpaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soljm-007JqQ-Rv; Thu, 12 Sep 2024 17:28:02 +0200
Date: Thu, 12 Sep 2024 17:28:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>

> > Also, am i reading this correct. C22 transfers will go out a
> > completely different bus to C45 transfers when there is an SFP?
> 
> No. You are correct.
> This LAN743x driver support following chips
> 1. LAN7430 - C22 only with GMII/RGMII I/F
> 2. LAN7431 - C22 only with MII I/F

Fine, simple, not a problem.

> 3. PCI11010/PCI11414 - C45 with RGMII or SGMII/1000Base-X/2500Base-X
>    If SFP enable, then XPCS's C45 PCS access
>    If SGMII only enable, then SGMII (PCS) C45 access

Physically, there are two MDIO busses? There is an external MDIO bus
with two pins along side the RGMII/SGMII pins? And internally, there
is an MDIO bus to the PCS block?

Some designs do have only one bus, the internal PCS uses address X on
the bus and you are simply not allowed to put an external device at
that address.

But from my reading of the code, you have two MDIO busses, so you need
two Linux MDIO busses.

	Andrew

