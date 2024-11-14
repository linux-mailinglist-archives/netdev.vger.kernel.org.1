Return-Path: <netdev+bounces-144739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC19C857C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8812E2820DD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493A1DC74A;
	Thu, 14 Nov 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zD5NOp4D"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4DE573;
	Thu, 14 Nov 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574992; cv=none; b=IziF5EGZaodkcpcZV0aFGIB1Qky9cSlUYn1XVNFtSZeTIbvXTZsUQCAQmA6LfLmFWBCzj7/Ketdioou+LKzH3xsOAMjl5eHNkLE4Fqw2PXdmTlAQs2rClxqAUaTWDOxnTpV8qMExaMyHy6DNMKGBl+m+Vp21RrllkEbAie2uo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574992; c=relaxed/simple;
	bh=J220O8UfL3Mq3B3v+52/12kVBuBMYemtHeBSz+8e0pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4UL3yw5m08VGIgkiv7bA/KqLyhrMebDKmMsyHQzBmRzbzJuQlKTYrWmm8qEALn+Sz/8cDqupGLKkVQmZ9cwch17ivLLoJMTejHw2NCcyvUP5GQnOq1JVs/mXzkVMDUmgTXhjX0KtKBsuruDndFGdJCPf9j8R7jCZN3KOv7Tv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zD5NOp4D; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vq+0o5UZAFxdEgelWoO434l6bAqjjNI/4fem/VNfZD0=; b=zD5NOp4D51nL3FAW1pcBwyJVl2
	FxhxfgJ3tpP/uZ27OAg5hY80Mu9kbLJ7MGktRo9pgJd+G3N8RUkVd1wzUb8YIzxXs6iEI2PMBaqsH
	hoStN7BCuIY/scBdom8a4Mtt72KeszUUBSK1BALW+ob16VYfc2EzNzdztNStW7d9CULAVpHecCKfC
	KAaitanOUdWUkOIUukRB+yRq0Y5y7xJon0P3oEinFzgd7YMQ+43ZBZ3tLN+huJGGe8KLNKNyeLU3k
	UM4P2lYEXKASMHptYgHYQ8Ngglt07QHh8cNWQ3AFhVnb/mrMhxlbM4HqkFDRNXQJASNlQ+OP8J32I
	VQocwMsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBVkc-0007gg-0b;
	Thu, 14 Nov 2024 09:02:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBVkV-0000yG-1x;
	Thu, 14 Nov 2024 09:02:47 +0000
Date: Thu, 14 Nov 2024 09:02:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to
 update eee_cfg values
Message-ID: <ZzW8t2bCTXJCP7-_@shell.armlinux.org.uk>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 13, 2024 at 06:10:55PM +0800, Choong Yong Liang wrote:
> On 12/11/2024 9:04 pm, Andrew Lunn wrote:
> > On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
> > > In stmmac_ethtool_op_get_eee() you have the following:
> > > 
> > > edata->tx_lpi_timer = priv->tx_lpi_timer;
> > > edata->tx_lpi_enabled = priv->tx_lpi_enabled;
> > > return phylink_ethtool_get_eee(priv->phylink, edata);
> > > 
> > > You have to call phylink_ethtool_get_eee() first, otherwise the manually
> > > set values will be overridden. However setting tx_lpi_enabled shouldn't
> > > be needed if you respect phydev->enable_tx_lpi.
> > 
> > I agree with Heiner here, this sounds like a bug somewhere, not
> > something which needs new code in phylib. Lets understand why it gives
> > the wrong results.
> > 
> > 	Andrew
> Hi Russell, Andrew, and Heiner, thanks a lot for your valuable feedback.
> 
> The current implementation of the 'ethtool --show-eee' command heavily
> relies on the phy_ethtool_get_eee() in phy.c. The eeecfg values are set by
> the 'ethtool --set-eee' command and the phy_support_eee() during the initial
> state. The phy_ethtool_get_eee() calls eeecfg_to_eee(), which returns the
> eeecfg containing tx_lpi_timer, tx_lpi_enabled, and eee_enable for the
> 'ethtool --show-eee' command.

These three members you mention are user configuration members.

> The tx_lpi_timer and tx_lpi_enabled values stored in the MAC or PHY driver
> are not retrieved by the 'ethtool --show-eee' command.

tx_lpi_timer is the only thing that the MAC driver should be concerned
with - it needs to program the MAC according to the timer value
specified. Whether LPI is enabled or not is determined by
phydev->enable_tx_lpi. The MAC should be using nothing else.

> Currently, we are facing 3 issues:
> 1. When we boot up our system and do not issue the 'ethtool --set-eee'
> command, and then directly issue the 'ethtool --show-eee' command, it always
> shows that EEE is disabled due to the eeecfg values not being set. However,
> in the Maxliner GPY PHY, the driver EEE is enabled.

So the software state is out of sync with the hardware state. This is a
bug in the GPY PHY driver.

If we look at the generic code, we can see that genphy_config_aneg()
calls __genphy_config_aneg() which then goes on to call
genphy_c45_an_config_eee_aneg(). genphy_c45_an_config_eee_aneg()
writes the current EEE configuration to the PHY.

Now if we look at gpy_config_aneg(), it doesn't do this. Therefore,
the GPY PHY is retaining its hardware state which is different from
the software state. This is wrong.

> 2. The 'ethtool --show-eee' command does not display the correct status,
> even if the link is down or the speed changes to one that does not support
> EEE.

"eee_enabled" means that the user has enabled EEE. It does not mean the
hardware is using EEE. It is a user configuration knob to turn EEE
on/off.

"eee_active" reports whether EEE has been negotiated, and thus will be
made use of.

There has been a lot of misinterpretation of the EEE API, and this is
one of them - some have thought that "eee_enabled" refers to whether EEE
has been negotiated, and "eee_active" means that the interface is
currently in low-power state. This is wrong.

> 3. The tx_lpi_timer in 'ethtool --show-eee' always shows 0 if we have not
> used 'ethtool --set-eee' to set the values, even though the driver sets
> different values.

The driver needs to set these when attaching the PHY.

> I appreciate Russell's point that eee_enabled is a user configuration bit,
> not a status bit. However, I am curious if tx_lpi_timer, tx_lpi_enabled, and
> other fields are also considered configuration bits.

tx_lpi_timer and tx_lpi_enabled are also user configuration.

> It does not specify which fields are configuration bits and which are status
> bits.

The documentation is in include/uapi/linux/ethtool.h:

 * @eee_active: Result of the eee auto negotiation.
 * @eee_enabled: EEE configured mode (enabled/disabled).
 * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
 *      that eee was negotiated.
 * @tx_lpi_timer: Time in microseconds the interface delays prior to asserting
 *      its tx lpi (after reaching 'idle' state). Effective only when eee
 *      was negotiated and tx_lpi_enabled was set.

and has been for a very long time, yet people in the past have
implemented it against the documentation, leading to the stupid
situation where using ethtool --set-eee on one network driver
works differently to another network driver. This has to stop,
and by implementing most of the logic for the interface in phylib,
it means there's less scope for misinterpretation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

