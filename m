Return-Path: <netdev+bounces-144747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709049C85B8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30921282914
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDB1DE4EF;
	Thu, 14 Nov 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RDkKWExw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8D1DE3B7;
	Thu, 14 Nov 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575544; cv=none; b=lc2QRzl8+4JEgQQXhBEvpclXyulKCkAlY02IGKN2HE/PveHuShyoRN1uqsoRD8wNHA8JpiNUkMrpk3XG7wlhfC8aLj12Ur6ij0Vfs/N+BTIGRcBfvxPIO6Zom2/59qXYFziWcKT0FHQrmguMl8o8u2pgT+2Af41SC9Sd6qQuQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575544; c=relaxed/simple;
	bh=/FNXeBtwBLZaRaEpTbvM/HoWlTPqr8De8F0vVcJ4AEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6XhudZ9qm724i2rGA5UfzjePZhhjJgLNVbBVM9hEZZ4WcO1XgHoo6ypP2U4uWtDpx1+6oHlmG1aWzMEGKuIArDGY3SN3ybQ5ETbPTQhMrDkLEMPJEbnTNVeuRKsCyoK04SY1dU4ft8oB0PbjNkHuPOj3bOY5vDiMxGYHbZtHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RDkKWExw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hUnkAXCEYyWhwqu2Ap7JAT2p1h1b8+9Y1xqlGsEdk38=; b=RDkKWExwPhrgX3aYe5B32yxGK8
	IqIHixh0BHo4a8oa8eEAdCICIsPU+UkMN3XX9rrKT6jdgWPJFqyoZQWhWL9dpreSjHM8twJPG7q3A
	V6UtO1JmkfqE4sDoOTdAD1vD4op74dN2g6Tir/DMWbesEEMznSgYsiDRpR8J9AqGuTRTAMRKvTHPc
	nU2I8OP3TNbiX0FJBe6wM2skax5S9rUPC8ySxgCfpfEr5gxJOTtMjViUEQFg7sqKsU2yaput+XC0Q
	dschMRkuOyhkvzrB21aZYqq0OrtCREcUYhcaLm89J1aJYAwi/avmiUYW2a6GbxxdGN3rbfSoWGcSs
	zbfoZMuA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50080)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBVtZ-0007he-0J;
	Thu, 14 Nov 2024 09:12:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBVtW-0000zI-2c;
	Thu, 14 Nov 2024 09:12:06 +0000
Date: Thu, 14 Nov 2024 09:12:06 +0000
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
Message-ID: <ZzW-5gj0cdbwdwZv@shell.armlinux.org.uk>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
 <ZzW8t2bCTXJCP7-_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzW8t2bCTXJCP7-_@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 14, 2024 at 09:02:47AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 13, 2024 at 06:10:55PM +0800, Choong Yong Liang wrote:
> > On 12/11/2024 9:04 pm, Andrew Lunn wrote:
> > > On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
> > > > In stmmac_ethtool_op_get_eee() you have the following:
> > > > 
> > > > edata->tx_lpi_timer = priv->tx_lpi_timer;
> > > > edata->tx_lpi_enabled = priv->tx_lpi_enabled;
> > > > return phylink_ethtool_get_eee(priv->phylink, edata);
> > > > 
> > > > You have to call phylink_ethtool_get_eee() first, otherwise the manually
> > > > set values will be overridden. However setting tx_lpi_enabled shouldn't
> > > > be needed if you respect phydev->enable_tx_lpi.
> > > 
> > > I agree with Heiner here, this sounds like a bug somewhere, not
> > > something which needs new code in phylib. Lets understand why it gives
> > > the wrong results.
> > > 
> > > 	Andrew
> > Hi Russell, Andrew, and Heiner, thanks a lot for your valuable feedback.
> > 
> > The current implementation of the 'ethtool --show-eee' command heavily
> > relies on the phy_ethtool_get_eee() in phy.c. The eeecfg values are set by
> > the 'ethtool --set-eee' command and the phy_support_eee() during the initial
> > state. The phy_ethtool_get_eee() calls eeecfg_to_eee(), which returns the
> > eeecfg containing tx_lpi_timer, tx_lpi_enabled, and eee_enable for the
> > 'ethtool --show-eee' command.
> 
> These three members you mention are user configuration members.
> 
> > The tx_lpi_timer and tx_lpi_enabled values stored in the MAC or PHY driver
> > are not retrieved by the 'ethtool --show-eee' command.
> 
> tx_lpi_timer is the only thing that the MAC driver should be concerned
> with - it needs to program the MAC according to the timer value
> specified. Whether LPI is enabled or not is determined by
> phydev->enable_tx_lpi. The MAC should be using nothing else.
> 
> > Currently, we are facing 3 issues:
> > 1. When we boot up our system and do not issue the 'ethtool --set-eee'
> > command, and then directly issue the 'ethtool --show-eee' command, it always
> > shows that EEE is disabled due to the eeecfg values not being set. However,
> > in the Maxliner GPY PHY, the driver EEE is enabled.
> 
> So the software state is out of sync with the hardware state. This is a
> bug in the GPY PHY driver.
> 
> If we look at the generic code, we can see that genphy_config_aneg()
> calls __genphy_config_aneg() which then goes on to call
> genphy_c45_an_config_eee_aneg(). genphy_c45_an_config_eee_aneg()
> writes the current EEE configuration to the PHY.
> 
> Now if we look at gpy_config_aneg(), it doesn't do this. Therefore,
> the GPY PHY is retaining its hardware state which is different from
> the software state. This is wrong.

Also note that phy_probe() reads the current configuration from the
PHY. The supported mask is set via phydev->drv->get_features,
which calls genphy_c45_pma_read_abilities() via the GPY driver and
genphy_c45_read_eee_abilities().

phy_probe() then moved on to genphy_c45_read_eee_adv(), which reads
the advertisement mask. If the advertising mask is non-zero, then
EEE is set as enabled.

From your description, it sounds like this isn't working right, and
needs to be debugged. For example, is the PHY changing its EEE
advertisement between phy_probe() and when it is up and running?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

