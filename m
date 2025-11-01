Return-Path: <netdev+bounces-234861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31998C28120
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AB91897131
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929923313E;
	Sat,  1 Nov 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QTHqesBE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208021DED7B;
	Sat,  1 Nov 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762008229; cv=none; b=D93Zpiw/hY/QDzhWBVjJqU4MeMKF9bpXhQuZfsumT7gPpDX1gX8T7RBoYkoT/lcIercudzhOIgxXcSAaAOzASHDX3agg5dWxzN5UowGAZqMzfktYctuK0XYrYndPGuqSc/cCpgZ7SZuTbGADiC8U+Fl+ggSZ8o5qApBXOfcSkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762008229; c=relaxed/simple;
	bh=CHj1Zkul6hoVNKjHSeA7+UVJxNaSbzYzOpQ/55QeZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ldyHq9esk/XeWuqZq6vZGgwNNl4BdmyFV7SUYK2r5SlwWN+QhyNRZDjBuB1wxg4k9DdE5JVFHIqEAFPq0rEuGaaHDVvV1vXYRZXNSl/jTA99y3dmWFGfvj2qIYgGDcl/rs2CTnTjl6lvqQBGixtwW/9/n8rWNJxaYPPrQHrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QTHqesBE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kbrQJNAxkCeAlLdCX6AM0uLGxMIQSMwoVqkBE0HruFk=; b=QTHqesBE/rr9SPQWh1nAIjaULw
	IP+06M4QcoN3gZcv/zQvkXIGEOiftxnyf8ljgtb6GYVONV2IYA1yoEo1zZ75m1WMpQY0A3jx5R+H4
	VTEV+q46wSSb14kP+8e3LDBMBpbutfuuzHoz2IXFgs9L0wsneNmOm73bc42A3iWynGpk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFCpE-00CfRd-Le; Sat, 01 Nov 2025 15:43:28 +0100
Date: Sat, 1 Nov 2025 15:43:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Message-ID: <157cf60d-5fc2-4da0-be71-3c495e018c3d@lunn.ch>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
 <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Sat, Nov 01, 2025 at 12:24:42AM +0000, Wei Fang wrote:
> > > What we get from the DT is the external PHY address, just like the mdio
> > > driver, this external PHY address based on the board, ENETC needs to
> > > know its external PHY address so that its port MIDO can work properly.
> > 
> > So i don't get this. MDIO is just a bus, two lines. It can have up to
> > 32 devices on it. The bus master should not need to have any idea what
> > devices are on it, it just twiddles the lines as requested.
> > 
> > Why does it need to know the external PHY address? In general, the
> > only thing which needs to know the PHY address is phylib.
> > 
> 
> >From the hardware perspective, NETC IP has only one external master MDIO
> interface (eMDIO) for managing external PHYs. The 'EMDIO function' and the
> ENETC port MDIO are all virtual ports of the eMDIO.
> 
> The difference is that 'EMDIO function' is a 'global port', it can access and
> control all the PHYs on the eMDIO, so it provides a means for different
> software modules to share a single set of MDIO signals to access their PHYs.
> 
> But for ENETC port MDIO, each ENETC can access its set of registers to
> initiate accesses on the MDIO and the eMDIO arbitrates between them,
> completing one access before proceeding with the next. It is required that
> each ENETC port MDIO has exclusive access and control of its PHY. That is
> why we need to set the external PHY address for ENETCs, so that its port
> MDIO can only access its PHY. If the PHY address accessed by the port
> MDIO is different from the preset PHY address, the MDIO access will be
> invalid.
> 
> Normally, all ENETCs use the interfaces provided by the 'EMDIO function'
> to access their PHYs, provided that the ENETC and EMDIO are on the same
> OS. If an ENETC is assigned to a guest OS, it will not be able to use the
> interfaces provided by EMDIO, so it must uses its port MDIO to access and
> manage its PHY.

So you have up to 32 virtual MDIO busses stacked on top of one
physical MDIO bus. When creating the virtual MDIO bus, you need to
tell it what address it should allow through and which it should
block?

If what i'm saying is correct, please make the commit message a lot
easier to understand.

But this is still broken. Linux has no restrictions on the number of
PHYs on an MDIO bus. It also does not limit the MDIO bus to only
PHYs. It could be an Ethernet switch on the bus, using a number of
addresses on the bus. So its not an address you need to program into
the virtual MDIO bus, it is a bitmap of addresses.

	Andrew



