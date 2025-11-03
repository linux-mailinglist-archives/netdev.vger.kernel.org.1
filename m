Return-Path: <netdev+bounces-234992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC6C2ADD7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A24518920AB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC52FAC0C;
	Mon,  3 Nov 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f0o0aiuS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F772FA0D3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163595; cv=none; b=gxHvsqM1Md5YW03iR2TOuu46KzG7he3H6YGdroWE6nh4b0hlK/Txbl4ZjJXA2vBev7ylBSxq8jh0wFZLTxvllUiSnHCgIIUFH1Epjx24SJFzjgt8rlhyQPyiugIyNc8PMsa5Mfwo8vnY+2pIIQEBVtG5jadIZUT5fXLk++wz4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163595; c=relaxed/simple;
	bh=2DLKMMDYDIwBWCZ+Hdh2QTXQ4OqfNeLj4JVT1oL8bdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyjka5qOLH9HEO7o7Bhjl88/0inA/03uuDy0nn70hXLWE+PDl/ukaXu1LFkufAj9N2qXHhgx+r9kxxkdlWGEUMxyUKd0WZW/dl57DpSyg3sgef4Ms+fV93Nw1MOGmgje4wj2c/4IWWFFsYHCmpKrWqTqooKkVETegrutZpdnfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f0o0aiuS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cMx/pBIc7baCIIFWi7F4x4oW//4oX2tqQgVeFsSMo44=; b=f0o0aiuSsPBELTITSHiT3sl/9F
	ShJW0uMV84XXqKe4DehAuu+wJzWgWhk7SWRFBP0A3rg76j4tuP6h7DgXL0+ao8kzDoUgxYVP9f6Kc
	obDUjGatfPJ1zHDrnwLuMjQItLa0XRvgJA7U6JQUvhQOxBJrNlVx+BUnb1P2aCM/gCPr1AoxGSa66
	8PdsRaHvNHOSdMpeDAUBDQLXtn/S4vzKPFVAAqLAFUHLmRDPbotH8s7FhKPmJvB/3tSOuAcsNPI6N
	2ZN0iLv6qwulY6mTM2Jj7MX5w5PmW4UoxJzDR0g9qtgzz3KvfxFLOGdYj8MU/t4KYfb4CuUlJxV4v
	Z04rEpow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54432)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFrEz-000000000Tv-17fT;
	Mon, 03 Nov 2025 09:52:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFrEs-000000003hg-47Cx;
	Mon, 03 Nov 2025 09:52:39 +0000
Date: Mon, 3 Nov 2025 09:52:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 02:28:24PM +0530, Mohd Ayaan Anwar wrote:
> On Thu, Oct 30, 2025 at 03:22:12PM +0000, Russell King (Oracle) wrote:
> > On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > > > 
> > > > This is probably fine since Bit(9) is self-clearing and its value just
> > > > after this is 0x00041000.
> > > 
> > > Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
> > > but the PHY says to the MAC "this is how I'm operating" and the MAC says
> > > "okay". Nothing more.
> > > 
> > > I'm afraid the presence of snps,ps-speed, this disrupts the test.
> > 
> > Note also that testing a 10M link, 100M, 1G and finally 100M again in
> > that order would also be interesting given my question about the RGMII
> > register changes that configure_sgmii does.
> > 
> 
> Despite several attempts, I couldn't get 10M to work. There is a link-up
> but the data path is broken. I checked the net-next tip and it's broken
> there as well.
> 
> Oddly enough, configure_sgmii is called with its speed argument set to
> 1000:
> [   12.305488] qcom-ethqos 23040000.ethernet eth0: phy link up sgmii/10Mbps/Half/pause/off/nolpi
> [   12.315233] qcom-ethqos 23040000.ethernet eth0: major config, requested phy/sgmii
> [   12.322965] qcom-ethqos 23040000.ethernet eth0: interface sgmii inband modes: pcs=00 phy=03
> [   12.331586] qcom-ethqos 23040000.ethernet eth0: major config, active phy/outband/sgmii
> [   12.339738] qcom-ethqos 23040000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/pause adv=0000000,00000000,00000000,00000000 pause=00
> [   12.355113] qcom-ethqos 23040000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
> [   12.363196] qcom-ethqos 23040000.ethernet eth0: Link is Up - 10Mbps/Half - flow control off

If you have "rate matching" enabled (signified by "pause" in the mode=
part of phylink_mac_config), then the MAC gets told the maximum speed for
the PHY interface, which for Cisco SGMII is 1G. This is intentional to
support PHYs that _really_ do use rate matching. Your PHY isn't using it,
and rate matching for SGMII is pointless.

Please re-run testing with phy-mode = "sgmii" which you've tested
before without your rate-matching patch to the PHY driver, so the
system knows the _correct_ parameters for these speeds.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

