Return-Path: <netdev+bounces-233860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CEC195AD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673FB3B81AE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBF304BA3;
	Wed, 29 Oct 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zWmoctBO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAB30F958
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729795; cv=none; b=c+JROgiUug5a88IM8LpyhRNO9VNpKK1O0ksHnoHkq0MhG4g5oF9LjVlmABRQG3xOrb/B5jty0t2tEcGRPiTXIsPXE6iKDkOaf7ETNs9wRexErbgraK2CRw4nIks9SKF3ADmblrfk3DzMlxgMePKtBtigmhJL5+t6hy7OyzxWexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729795; c=relaxed/simple;
	bh=646vkVVl7F+rI54Z5jq6NIPieKx/LAyvberC7mOwkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln+LcOUE8/8Pnq/k4umZX/5kTmnd7o7PhGAKkrV1WGzk0GnP2sqlp+2Myl2ZF5lMtYXqAy8OBEiqwkkCtA75EOLvTOGDR6jPZ9DjQsW9Lnfk35LbenLxmoNgWpDxTlWZDL7+a8hnJhXZrk2H9FXN0zEuNHDp8c5A9O8dJuuoKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zWmoctBO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=46RQrnXqiBA0cxZyrVc9FkASOa/aXQGVTHVdiJHXrhs=; b=zWmoctBOmF/zzqo/gbH4OFCRzX
	nF5KLTDWnIOmli1Xxf/JKCnDOnUNVlg5QFanKYAwA5l0bQn9N3eI+XdfXULM8xgA4nS3bVLazVxC+
	mlKGKzSAdWEnLQCytZwHoNlBscrn/H4td/UalPv5ei6xon5xuHZQDH3bS8UgGff4IssWJUzj91HOD
	papJefxLxlyERmphp2Uppp0GDDOlcKO0Mr40mE/W+I1cPxHcv76jkEi6XM01FMblP1Lq3MTWfK0Ye
	pTPZjlCwWkM1tRJOBIXU054Tkp16+abE0X17VT+6S3xfuwFV+NUHmFJG/4F/bVEyz4IyWEsymx9dz
	j5mGQYsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vE2OM-0000000049a-0LSK;
	Wed, 29 Oct 2025 09:22:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vE2OH-000000007PZ-41sq;
	Wed, 29 Oct 2025 09:22:49 +0000
Date: Wed, 29 Oct 2025 09:22:49 +0000
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
Message-ID: <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQExx0zXT5SvFxAk@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 29, 2025 at 02:42:39AM +0530, Mohd Ayaan Anwar wrote:
> Hi Russell,
> 
> On Sat, Oct 25, 2025 at 09:47:37PM +0100, Russell King (Oracle) wrote:
> > Hi,
> > 
> > This series is currently the last of the phylink PCS conversion for
> > stmmac. This series contains changes that will cause potential breakage,
> > so I suggest to netdev maintainers that it is only applied if there is
> > a significant response from testers using the PCS.
> > 
> > Paritcularly, dwmac-qcom-ethqos.c users need to test this, since this
> > platform glue driver manipulates the PCS state. Patch 2 is designed to
> > print a warning to the kernel log if this glue driver calls
> > stmmac_pcs_ctrl_ane() to set the AN state differently to how phylink
> > has set it. If this happens, we need to do some pre-work to prevent
> > these prints.
> > 
> >  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  7 +++++-
> >  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  7 +++++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 29 +++++++++++++++++++---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  8 +++++-
> >  4 files changed, 44 insertions(+), 7 deletions(-)
> > 
> 
> Thank you for the recent stmmac cleanup patches. I apologize for the
> late reply. I had limited time to test due to some urgent tasks at work.
> This is a long email, please bear with me.

Thanks for the feedback.

> I have the following devices on which I try to test whatever I can (both
> of them have the same GMAC core with an integrated PCS, both use
> phy-mode="2500base-x"):
>   - Qualcomm QCS9100 Ride R3 (2xAQR115C PHYs)
>   - Qualcomm IQ8 EVK (QCA808X PHY) - this is the same board for which I
>     had posted [1] to resolve its issue with advertising only 2.5G
> 
> # Patch Series: net: stmmac: phylink PCS conversion
> I tested this series soon after it got merged to net-next, probably when
> I tested out the hwif.c cleanups. A summary:
>   - QCS9100 Ride R3 - no issues found.
>   - IQ8 EVK - same behavior as without this patch, i.e. 2.5G was working
>     fine, other speeds aren't advertised.

Great.

> However, this might have been expected as both boards are using
> 2500Base-X whereas the integrated PCS changes are limited to SGMII.
> *Sidenote*: I was able to get 2.5G and lower speeds to work on the IQ8
> EVK after adding an additional case for 2500Base-X on top of your patch.
> 
> # Patch Series (current): net: stmmac: phylink PCS conversion part 3
> (dodgy stuff)
>   - QCS9100 Ride R3 - functionality seems to be fine (again, probably
>     due to the changes only affecting SGMII mode). However, the warning
>     added in patch 2 comes up whenever there's a speed change (I added
>     an additional WARN_ON to check the sequence):
>   	[   61.663685] qcom-ethqos 23000000.ethernet eth0: Link is Down
> 	[   66.235461] dwmac: PCS configuration changed from phylink by glue, please report: 0x00001000 -> 0x00000000

That's clearing ANE, turning off AN. This will be because we're not
using the PCS code for 2500base-X.

Can you try:

1. in stmmac_check_pcs_mode(), as a hack, add:

	if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_2500BASEX)
		priv->hw->pcs = STMMAC_PCS_SGMII;

2. with part 3 added, please change dwmac4_pcs_init() to:

	phy_interface_t modes[] = {
		PHY_INTERFACE_MODE_SGMII,
		PHY_INTERFACE_MODE_2500BASEX,
	};
	...
	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
					  modes, ARRAY_SIZE(modes));

This will cause the integrated PCS to also be used for 2500BASE-X.

3. modify dwmac_integrated_pcs_inband_caps() to return
   LINK_INBAND_DISABLE for PHY_INTERFACE_MODE_2500BASEX.

This should result in the warning going away for you.

I'm not suggesting that this is a final solution.

Please note, however, that the stmmac driver does not support on-the-fly
reconfiguration of the PHY-side interface as it stands (and questionable
whether it ever will do.) The hardware samples phy_intf_sel inputs to
the core at reset (including, I believe, software reset) which
configures the core to use the appropriate PHY interface. Performing
any kind of reset is very disruptive to the core - likely even causes
the PTP timekeeping block to be reset. In my opinion, PHYs that switch
their host-side interface were not considered when this IP was
designed.

To get stmmac's driver to a state where it _can_ do this if desired is
going to take a massive amount of work due to all these glue drivers.

I do have patches which introduce a new callback into platform drivers
to set the phy_intf_sel inputs from the core code... but that's some
way off before it can be merged (too many other patches I need to get
in first.)

I haven't noticed qcom-ethqos using a register field that corresponds
with the phy_intf_sel inputs, so even in that series, this driver
doesn't get converted.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

