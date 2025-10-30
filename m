Return-Path: <netdev+bounces-234462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8986C20EA4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81211898DBE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6A363351;
	Thu, 30 Oct 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PA3ub+bu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4177157A72
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837595; cv=none; b=BjauSZ771FL07qzgWtEk9R6PZJZcoTNALJ1xghqnA5bxE6I1XuZbBZOP38ZUljj7MS7g5pOIR6uFyIdRAWCAch251JTSeqOWQuO6ULFqlX9wVl1VXVmuwSIP2DOkf0lwMf9twFnZUspUt1WH3XpyFwzqSzjL66wC4pd66DC+sWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837595; c=relaxed/simple;
	bh=AqaeW+vQvB0ue8QvsQciZ18rBhjYQ6eYcRMtiY5OVLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckg4sfypHzan4v5MY32m0AG/5yot4LE1ELUW95DeXRBCtjEMmTRWZbKQPcD6LRkTgZbRC5bGZqshPe6aC5LQEfpIrsYO5I48Tn5NkcE37REOwuFpev5VsFrBxmvMhkxr4YxFvdGo4X+8gxlrN8r8oEsB4QeUTE8XQP6bzujP/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PA3ub+bu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wvl1wULlPsH7hoZkM6Y8NRE1qWb5w+0oVN/bGJLNUUI=; b=PA3ub+bun3d2D08Kdx1Pzr+4yd
	xjQsir5EQJtCS7QcfH714iVa3uUoXmgvI2U1Fzk4kdQo3mZ1sOcWgYxnC/Mqon2wBIZRgMpaJj10+
	B83VmbtGcPE/52DgNXpReUT0tyI8TCdZNMJflp9QiPtqqbj0NoFV1jxudlvTVPD1vSZT+WFIk8OjG
	nUtyGHbgxMUN3SrVSxJgniok3hX53oxZGnMf+4ZGituT8FiNWtcX0Q6KtfNWPwkEm6gpzQDJc9N3H
	rin4gBvlc1GENrR1JuRGLiXkdowh62jNY8YsigpYs3hDnOblwfJLveTHRpy1erxYHyWhu+5TfEXp2
	O7BdGZGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEUR2-000000005rN-2rEZ;
	Thu, 30 Oct 2025 15:19:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEUQx-00000000079-3c0M;
	Thu, 30 Oct 2025 15:19:27 +0000
Date: Thu, 30 Oct 2025 15:19:27 +0000
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
Message-ID: <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNmM5+cptKllTS8@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 06:50:51PM +0530, Mohd Ayaan Anwar wrote:
> Hi Russell,
> On Wed, Oct 29, 2025 at 09:22:49AM +0000, Russell King (Oracle) wrote:
> > > # Patch Series (current): net: stmmac: phylink PCS conversion part 3
> > > (dodgy stuff)
> > >   - QCS9100 Ride R3 - functionality seems to be fine (again, probably
> > >     due to the changes only affecting SGMII mode). However, the warning
> > >     added in patch 2 comes up whenever there's a speed change (I added
> > >     an additional WARN_ON to check the sequence):
> > >   	[   61.663685] qcom-ethqos 23000000.ethernet eth0: Link is Down
> > > 	[   66.235461] dwmac: PCS configuration changed from phylink by glue, please report: 0x00001000 -> 0x00000000
> > 
> > That's clearing ANE, turning off AN. This will be because we're not
> > using the PCS code for 2500base-X.
> > 
> > Can you try:
> > 
> > 1. in stmmac_check_pcs_mode(), as a hack, add:
> > 
> > 	if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_2500BASEX)
> > 		priv->hw->pcs = STMMAC_PCS_SGMII;
> > 
> > 2. with part 3 added, please change dwmac4_pcs_init() to:
> > 
> > 	phy_interface_t modes[] = {
> > 		PHY_INTERFACE_MODE_SGMII,
> > 		PHY_INTERFACE_MODE_2500BASEX,
> > 	};
> > 	...
> > 	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
> > 					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
> > 					  modes, ARRAY_SIZE(modes));
> > 
> > This will cause the integrated PCS to also be used for 2500BASE-X.
> > 
> > 3. modify dwmac_integrated_pcs_inband_caps() to return
> >    LINK_INBAND_DISABLE for PHY_INTERFACE_MODE_2500BASEX.
> > 
> > This should result in the warning going away for you.
> > 
> > I'm not suggesting that this is a final solution.
> 
> Here are my observations (with phylink logs if it helps):
> 
> 1. Link up at 2.5G
> [    8.429331] qcom-ethqos 23000000.ethernet: User ID: 0x20, Synopsys ID: 0x52
> [    8.436610] qcom-ethqos 23000000.ethernet:   DWMAC4/5
> [   10.395163] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
> [   10.407759] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
> [   10.418507] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=343)
> [   10.428003] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
> [   10.461072] qcom-ethqos 23000000.ethernet eth0: Enabling Safety Features
> [   10.478201] qcom-ethqos 23000000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> [   10.487449] qcom-ethqos 23000000.ethernet eth0: registered PTP clock
> [   10.494010] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
> [   10.494014] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
> [   10.494018] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
> [   10.494021] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
> [   10.494024] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> [   10.508824] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> [   15.099693] qcom-ethqos 23000000.ethernet eth0: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
> [   15.122160] dwmac: PCS configuration changed from phylink by glue, please report: 0x00041000 -> 0x00040000
> [   15.140458] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
> [   15.140939] stmmac_pcs: Link Up
> 
> As I understand it, the glue layer disables ANE at 2.5G.

Please try again, this time with snps,ps-speed removed from the DT
description for the interface. This property was a buggy attempt at
reverse-SGMII, and incorrectly produced a warning if not specified
when the integrated PCS was being used. The "bug" in the attempt
with this was a typo in each MAC core driver, where specifying this
set the TE (transmit enable) bit rather than the TC (transmit
configuration) bit in the MAC control register. All the rest of the
setup for reverse-SGMII mode was in place, but this bug made the
entire thing useless.

The "invalid port speed" warning that results if this property is
not set to 10, 100 or 1000 is another bug - only if this warning
is printed will the "normal" mode be selected.

Since the PCS series 1 and 2 have been merged into net-next, it
will be safe to submit patches removing these properties from your
DT files, without fear of this warning appearing.

> 2. Link up at 1G:
> [    6.261112] qcom-ethqos 23000000.ethernet: User ID: 0x20, Synopsys ID: 0x52
> [    6.261116] qcom-ethqos 23000000.ethernet:   DWMAC4/5
> [    9.051693] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
> [    9.061261] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
> [    9.061266] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=305)
> [    9.061269] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
> [    9.080324] qcom-ethqos 23000000.ethernet eth0: Enabling Safety Features
> [    9.114550] qcom-ethqos 23000000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> [    9.123870] qcom-ethqos 23000000.ethernet eth0: registered PTP clock
> [    9.130412] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
> [    9.138726] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
> [    9.138729] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
> [    9.138731] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
> [    9.164930] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> [    9.194764] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> [   12.542771] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
> [   12.553890] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
> [   12.561617] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
> [   12.570220] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
> [   12.578367] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
> [   12.599545] stmmac_pcs: ANE process completed
> [   12.607910] dwmac: PCS configuration changed from phylink by glue, please report: 0x00041000 -> 0x00041200
> [   12.616188] stmmac_pcs: Link Up
> [   12.634351] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> [   12.639575] stmmac_pcs: ANE process completed
> [   12.647498] stmmac_pcs: Link Up
> 
> This is probably fine since Bit(9) is self-clearing and its value just
> after this is 0x00041000.

Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
but the PHY says to the MAC "this is how I'm operating" and the MAC says
"okay". Nothing more.

I'm afraid the presence of snps,ps-speed, this disrupts the test.

> > I haven't noticed qcom-ethqos using a register field that corresponds
> > with the phy_intf_sel inputs, so even in that series, this driver
> > doesn't get converted.
> 
> True, I think qcom-ethqos's behaviour is different than other glue
> drivers. For both SGMII and 2500Base-X, it uses the same
> ethqos_configure_sgmii() function which is just changing the SerDes
> speed and PCS and depending on the current speed.

Right, so it leaves the SGMIIRAL block in place, hoping that it
will be operating with no symbol replication.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

