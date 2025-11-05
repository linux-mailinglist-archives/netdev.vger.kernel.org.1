Return-Path: <netdev+bounces-235931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D8C37419
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F17D189A917
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158A272E4E;
	Wed,  5 Nov 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cflWPXs+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D822690E7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366385; cv=none; b=LPmNTEIH5W9j6+U6MNkYViiwiHs84hv7fWe87v8CYZMEpKO6GRQr1d2wfWmFeJFMdyPgC8uAOBdcyxnUeXT6Jh00acyDCF5Sq2/mEn4DvgMxqy+B715wAvXHt/e0fokeijBb/sLG2JThYAj+zMEsMCXiYbopztGkj1IlbQ8bcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366385; c=relaxed/simple;
	bh=AVoNeEpe8Wu+RCauID280JwzLNw29vqgUoIjGUAq1Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJs3nR11EHpM+/y6cQuO8WLbDEzkOI7GLqNnd0FAV99OJM8MVLQwFtp3uv7xQI1eOOcz7hDSDJNsyYy/xnfv10qRcoMOSjzFOkd0dlGEX6qFrIZtlMzSDOxWa0wkWzSI9tzdzYQMuJoyJwNmUoX9EBecwpFzQX1i5C8t+ctqQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cflWPXs+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NDR+q2zeCYxeHmzpXH/Dda5YqWtZ7Vb4o/yh6EkNIEg=; b=cflWPXs+zbj5/nd+7TN66l9ou5
	WFOrS032mN7GeZrwsNGFyBeCCiozycElXmFZPezvFkgj41bWxdZgEhOWUJGhN0iyBRXycsDnZtrMd
	92jFb4qEPoAr3KUPehapj09B6XfKaBxDfFMyQAkOHnklfmv3f82MKlLnjWhew73x4cedUqN3gplj0
	PpfNanhBg7STMWcR1K5536JmDHugakzRBR1yusHUkAdYpSCnfb8CtX4eaQHT1EpOYfuod+Wbn7nmU
	qEZ+kWdg+kyrLqdxK0AvwAgoamvebZBk6X4n648D/Rz8Uv6DS35fzVOeCOyNI3FMm7RnEjOgbpeCC
	xjBHaf7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35518)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGhzv-000000003nT-1oKc;
	Wed, 05 Nov 2025 18:12:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGhzq-000000005tm-0jnF;
	Wed, 05 Nov 2025 18:12:38 +0000
Date: Wed, 5 Nov 2025 18:12:37 +0000
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
Message-ID: <aQuTldBf4CPTzS77@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQtxQgPWQ3+CCrZI@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQtxQgPWQ3+CCrZI@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 05, 2025 at 09:16:10PM +0530, Mohd Ayaan Anwar wrote:
> Hello Russell,
> 
> I finally got some time to test out 100M/1G/2.5G with all these changes
> on the QCS9100 Ride R3 board (AQR115C PHY, qcom-ethqos).
> 
> Apart from this patch series, I incorporated the following changes:
> 1. Hacks suggested to have the PCS code work for 2500Base-X.
> 2. Removed snps,ps-speed from DT.
> 3. Picked [PATCH net-next v2] net: stmmac: qcom-ethqos: remove
> MAC_CTRL_REG modification.
> 
> Apologies for the lengthy email- I’ve included phylink logs for all
> five points for completeness.

That's fine, thanks.

> *Observations:*
> 
> 1. 2.5G Link up - no warning about the PCS configuration getting changed
> by glue. Data path works fine.
> 
> 	[   10.342908] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
> 	[   10.352486] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
> 	[   10.363215] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=365)
> 	[   10.372690] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
> 	[   10.428389] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
> 	[   10.436717] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
> 	[   10.444870] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
> 	[   10.453913] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
> 	[   10.462506] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> 	[   10.485700] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> 	[   15.131941] qcom-ethqos 23000000.ethernet eth0: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
> 	[   15.143632] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 2500
> 	[   15.153226] stmmac_pcs: Link Up
> 	[   15.153274] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
> 
> 
> 2. 1G Link up - Warning (PCS configuration changed from phylink by glue,
> please report: 0x00040000 -> 0x00041200). Data path works fine.
> 
...
> 	[   10.532328] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
> 	[   10.540919] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> 	[   10.563437] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
> 	[   13.912074] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
> 	[   13.919074] stmmac_pcs: Link Up
> 	< a *bunch* of "stmmac_pcs: Link Down" prints, more details in 4.>
> 	[   14.948996] stmmac_pcs: Link Up
> 	[   14.949149] stmmac_pcs: Link Down
> 	[   14.949169] stmmac_pcs: Link Up

This is showing that the link state is flapping, which I guess is caused
by the PHY having switched to 1.25Mbaud SGMII but still being programmed
for 3.125Mbaud for 2.5G rate.

> 	[   14.949301] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
> 	[   14.949317] stmmac_pcs: Link Down
> 	[   14.949326] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
> 	[   14.949331] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
> 	[   14.949335] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
> 	[   14.952026] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
> 	[   14.952033] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
> 	[   14.952057] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 	[   15.035977] stmmac_pcs: ANE process completed
> 	[   15.035978] stmmac_pcs: Link Down
> 	[   15.036004] stmmac_pcs: Link Up

Since we are using phy/outband mode (see "major config, active") this
means we're not expecting to use in-band, so the PCS has in-band
disabled by the PCS code, but then re-enabled by the glue code.

One thing which occurs to me though is that dwmac_ctrl_ane() doesn't
clear GMAC_AN_CTRL_SGMRAL when srgmi_ral is false, which means its
taking the speed information from the PS and FES bits in the MAC
control register.

Now, the question is, what happens if the call to
ethqos_pcs_set_inband() / stmmac_pcs_ctrl_ane() are omitted? Does
traffic still flow over the interface?

> 3. 100M Link up - Warning (PCS configuration changed from phylink by
> glue, please report: 0x00040000 -> 0x00041200). Data path works fine.
> 
...
> 	[   20.390144] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
> 	[   20.398720] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
> 	[   20.418477] stmmac_pcs: Link Down
> 	[   20.421912] stmmac_pcs: Link Down
> 	[   20.426255] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/100Mbps/Full/none/rx/tx/nolpi
> 	[   20.440795] stmmac_pcs: Link Down
> 	[   23.095229] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/100Mbps/Full/none/rx/tx/nolpi
> 	[   23.101362] stmmac_pcs: Link Down
> 	[   23.106527] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
> 	[   23.107624] stmmac_pcs: Link Down
> 	[   23.118707] stmmac_pcs: Link Down
> 	[   23.124703] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
> 	[   23.128141] stmmac_pcs: Link Down
> 	[   23.136699] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
> 	[   23.140126] stmmac_pcs: Link Down
> 	[   23.148232] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
> 	[   23.151657] stmmac_pcs: Link Down
> 	[   23.166924] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 100
> 	[   23.167584] stmmac_pcs: Link Down
> 	[   23.175511] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
> 	[   23.178944] stmmac_pcs: Link Up
> 	[   23.188862] qcom-ethqos 23000000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> 	[   23.192097] stmmac_pcs: Link Down
> 	[   23.204346] stmmac_pcs: ANE process completed
> 	[   23.208828] stmmac_pcs: Link Up

It would be interesting to see how this behaves as well without the
call to ethqos_pcs_set_inband() / stmmac_pcs_ctrl_ane().

> 4. Sometimes after toggling the interface or even during boot-up, the
> console gets flooded with "stmmac_pcs: Link Down" prints. For e.g.,
> 
> 	// Interface toggled
> 	< a bunch of "stmmac_pcs: Link Down" prints>
> 	[  549.898750] stmmac_pcs: Link Down
> 	[  549.902186] stmmac_pcs: Link Down
> 	[  549.905628] stmmac_pcs: Link Down
> 	[  549.909069] stmmac_pcs: Link Down
> 	[  549.912509] stmmac_pcs: Link Down
> 	[  549.915948] stmmac_pcs: Link Down
> 	[  549.919391] stmmac_pcs: Link Down
> 	[  549.922858] stmmac_pcs: Link Down
> 	[  549.924140] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 2500
> 	[  549.926304] stmmac_pcs: Link Down
> 	[  549.934349] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
> 	[  549.937746] stmmac_pcs: Link Up
> 
>    ethtool stats reveal an unusually high number of interrupts (I have
>    seen this number go as high as about 16000 when booting up with a 1G
>    link)
> 	     irq_pcs_ane_n: 0
> 	     irq_pcs_link_n: 1998	

Some PCS have this, caused by spuriously detecting what they think is a
valid signal but isn't. We don't enable comma detection for SGMII, but
maybe that would help avoid this? It depends how the serdes is
implemented. The alternative is that we may need to disable the IRQ
(we're not really using it for anything in this mode, as we're using
outband mode.)

> 5. Switching between 100M/1G/2.5G link is a bit of a mixed bag.
> Sometimes it works, sometimes the data path breaks and needs an
> interface toggle to be functional again. I don't necessarily think that
> it's due to the speed specific configurations done by configure_sgmii as
> that shouldn't impact switching between 1G and 2.5G, or even the switch
> from 1G/2.5G to 100M.

Maybe this is the lack of comma detect being enabled - what I read in
the databook, dwmac expects the external serdes to do comman detection
when enabled. It appears that the ECD bit just toggles an output to
the implementation's serdes to tell it to enable this, but it's
entirely possible that an implementation doesn't need this control.
It's something worth trying though.

> While this is *broken* on net-next as well, the current patch series
> allowed me to notice a peculiar behavior - it looks like sometimes the
> PCS link doesn't come up:
> 	
> 	[   55.491996] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
> 	[   55.501622] qcom-ethqos 23000000.ethernet eth0: Link is Down
> 	[   58.907705] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
> 	[   58.913724] stmmac_pcs: Link Down
> 	[   58.919947] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
> 	[   58.927656] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
> 	[   58.936256] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
> 	[   58.944409] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
> 	[   58.958298] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
> 	[   58.967448] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
> 	[   58.977392] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> 
> Since 5 is unrelated to this series (I'll try to debug it separately),
> let me know if you'd like me to run any other experiments for 2, 3, and
> 4.

As mentioned above, ECD may help. If the serdes needs this signal
enabled to perform command detection and word synchronisation, not
enabling it is likely to result in the PCS receiving unaligned words
that it can't make sense of.

> > The "invalid port speed" warning that results if this property is
> > not set to 10, 100 or 1000 is another bug - only if this warning
> > is printed will the "normal" mode be selected.
> > 
> > Since the PCS series 1 and 2 have been merged into net-next, it
> > will be safe to submit patches removing these properties from your
> > DT files, without fear of this warning appearing.
> > 
> 
> Thanks for the explanation. I see the incorrect use of snps,ps-speed in
> the DT of a couple of more boards that use the same MAC core. Would it
> be okay to add your Suggested-by when submitting the fix patches?

Yes please, and definitely! Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

