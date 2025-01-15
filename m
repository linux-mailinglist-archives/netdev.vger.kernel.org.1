Return-Path: <netdev+bounces-158557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA6A127B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E337166943
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A31487DD;
	Wed, 15 Jan 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GcQ2FiDE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717520326;
	Wed, 15 Jan 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955685; cv=none; b=OfMU0ISRZbemJIMjZdElRZ/Asd8NWK9exTr85XnxA6ktEr2rWv0QLcC12u9vhSDOYJw1lLE8rO3bslGRK0+twIAAxSCAXAHyaBkSD0KdXaICHs3B9U1k8KRWAyCCbqpI/BZDqMSHaY6c9ve7ohvJVMwuyPjQCP/mDYQtWHzrVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955685; c=relaxed/simple;
	bh=64NEIoEQ0u1ocA/xyvPJwaz7EyARX4Ime40lVqNGAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1QpAP3oHsw00zk/Wd2aSSyT9GHKYWzkO3etLISXQZDaOMLiErdKU67rTzUHToa91sX+sNb8jiwzRl8XSYf8Gwi2fX7JUCjUWnB0PQrLQpyyrEM/L3YFABmPWoDvnhXX6J3hSLtOQsKYgry6DAq8/mSAwrrgqYlBcbm6KQNkXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GcQ2FiDE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=93rwv1ansdDHk58RJz190FX82+Zq5smcfY9/6AN7aSk=; b=GcQ2FiDEW8HYURxPpGzlY0Pq3Q
	hLQtGUkfelCf6nSpZvRZc1vMuKifeVmXqPwAT4m77rl8rtpVlGa+WyvfhE6ajnp19gg7uk/Q9W+Zl
	MANL7cK+EeqUcaO1GWJr++jBLBxlSkurW4rzQ4/qcU5EYz91LqaKsgUir5frLg/y615uVJ1DF+asB
	/pE2ns18BFiqIaWAgjEiPVQuCLHpxPL1F3N8+UXBqqDHSOkRHVNSECXhbHwMiYCCy521lMJb/Xlfz
	mgzuaHZ91zRYwckbWdHj4ElP8kobMkJkZGJVotLc0XYf5oFgakw+uMeaaXuq0z3k1uC8Ly1yfcBAE
	7K6HrF3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tY5W9-0001Lz-0T;
	Wed, 15 Jan 2025 15:41:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tY5W5-0006Gp-1L;
	Wed, 15 Jan 2025 15:41:13 +0000
Date: Wed, 15 Jan 2025 15:41:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: pcs: xpcs: actively unset
 DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
Message-ID: <Z4fXGULd-6_rxgRR@shell.armlinux.org.uk>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
 <20250114164721.2879380-2-vladimir.oltean@nxp.com>
 <Z4fJ5FIuotHMZ8fN@shell.armlinux.org.uk>
 <20250115145145.4jdajfaksyfkx5zh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115145145.4jdajfaksyfkx5zh@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 15, 2025 at 04:51:45PM +0200, Vladimir Oltean wrote:
> On Wed, Jan 15, 2025 at 02:44:52PM +0000, Russell King (Oracle) wrote:
> > On Tue, Jan 14, 2025 at 06:47:21PM +0200, Vladimir Oltean wrote:
> > > xpcs_config_2500basex() sets DW_VR_MII_DIG_CTRL1_2G5_EN, but
> > > xpcs_config_aneg_c37_sgmii() never unsets it. So, on a protocol change
> > > from 2500base-x to sgmii, the DW_VR_MII_DIG_CTRL1_2G5_EN bit will remain
> > > set.
> > > 
> > > Fixes: f27abde3042a ("net: pcs: add 2500BASEX support for Intel mGbE controller")
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > Thanks!
> > 
> > I wonder whether, now that we have in-band capabilities, and thus
> > phylink knows whether AN should be enabled or not, whether we can
> > simplify all these different config functions and rely on the
> > neg_mode from phylink to configure in-band appropriately.
> 
> I don't understand, many sub-functions of xpcs_do_config() use neg_mode
> already.
> 
> If you're talking about replacing compat->an_mode with something derived
> partially from the neg_mode and partially from state->interface, then in
> principle yes, sure, but we will need new neg_modes for clause 73
> auto-negotiation (to replace DW_AN_C73), plus appropriate handling in phylink.

No, I'm thinking that xpcs_config_aneg_c37_sgmii(),
xpcs_config_aneg_c37_1000basex() and xpcs_config_2500basex() can
be rolled into a single function.


	SGMII
	modify vendor 2 MII_BMCR
	- clear BMCR_ANENABLE
	modify vendor 2 DW_VR_MII_AN_CTRL
	- set DW_VR_MII_PCS_MODE_MASK to 
	  DW_VR_MII_PCS_MODE_C37_SGMII
	- configure  DW_VR_MII_TX_CONFIG_MASK for MAC or if txgbe, PHY side
	- set DW_VR_MII_AN_CTRL_8BIT (if txgbe)
	modify vendor 2 DW_VR_MII_DIG_CTRL1
	- set DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW if
	    PHYLINK_PCS_NEG_INBAND_ENABLED
	- set DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL if txgbe
	write vendor 2 DW_VR_MII_DIG_CTRL1
	set BMCR_ANENABLE in vendor 2 MII_BMCR if
	  PHYLINK_PCS_NEG_INBAND_ENABLED

	1000BASE-X
	modify vendor 2 MII_BMCR
	- clear BMCR_ANENABLE
	modify DW_VR_MII_AN_CTRL
	- set DW_VR_MII_PCS_MODE_MASK to
	  DW_VR_MII_PCS_MODE_C37_1000BASEX
	- set DW_VR_MII_AN_INTR_EN if using interrupts (shouldn't SGMII
	  also do this?)
	encode advertisement and write to vendor 2 MII_ADVERTISE
	clear vendor 2 DW_VR_MII_AN_INTR_STS register (if using
	interrupts shouldn't this also apply to SGMII?)
	set BMCR_ANENABLE in vendor 2 MII_BMCR if
	  PHYLINK_PCS_NEG_INBAND_ENABLED

	2500BASE-X
	modify vendor 2 DW_VR_MII_DIG_CTRL1:
	- set DW_VR_MII_DIG_CTRL1_2G5_EN
	- clear DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW
	modify vendor 2 MII_BMCR:
	- clear BMCR_ANENABLE, BMCR_SPEED100
	- set BMCR_SPEED1000
	(shouldn't this clear BMCR_ANENABLE first, like the other two
	 configurations above?)

So, sticking this altogether, making some assumptions on the above
questions, it becomes:

	modify vendor 2 MII_BMCR
	- clear BMCR_ANENABLE
	modify DW_VR_MII_AN_CTRL
	- set DW_VR_MII_PCS_MODE_MASK to 
	  - DW_VR_MII_PCS_MODE_C37_SGMII if using SGMII
	  - DW_VR_MII_PCS_MODE_C37_1000BASEX if using 1000BASE-X or
	    2500BASE-X
	- configure  DW_VR_MII_TX_CONFIG_MASK for MAC or if txgbe, PHY
	  side
	- set DW_VR_MII_AN_CTRL_8BIT (if txgbe)
	- set DW_VR_MII_AN_INTR_EN if using interrupts (shouldn't SGMII
	  also do this?)
	modify vendor 2 DW_VR_MII_DIG_CTRL1
	- set DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW if
	    PHYLINK_PCS_NEG_INBAND_ENABLED
	- set DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL if txgbe
	encode advertisement and write to vendor 2 MII_ADVERTISE
	clear vendor 2 DW_VR_MII_AN_INTR_STS register
	set BMCR_ANENABLE in vendor 2 MII_BMCR if
	  PHYLINK_PCS_NEG_INBAND_ENABLED

Which would avoid variability in register values when phylink
transitions the PCS between SGMII, 1000base-X and 2500base-X that
will occur today - e.g., when switching from either SGMII or
1000base-X to 2500base-X, then the following register fields do
not get written and are left how they were last configured:

	DW_VR_MII_AN_CTRL at all
	DW_VR_MII_PCS_MODE_MASK
	DW_VR_MII_TX_CONFIG_MASK
	DW_VR_MII_AN_CTRL_8BIT
	DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL

For example, switching from SGMII to 2500base-X, the
DW_VR_MII_PCS_MODE_MASK field will be left as
DW_VR_MII_PCS_MODE_C37_SGMII, but if switching from 1000base-X to
2500base-X, it will be DW_VR_MII_PCS_MODE_C37_1000BASEX.

Maybe it doesn't matter, because maybe setting
DW_VR_MII_DIG_CTRL1_2G5_EN overrides a whole host of register
configuration?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

