Return-Path: <netdev+bounces-107619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8491BB61
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8F828130B
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0F14F9DC;
	Fri, 28 Jun 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XJ+al+3X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21181465A1;
	Fri, 28 Jun 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566710; cv=none; b=bi/5CG5rAK3n0XmPH8ETtKFUjusyUQoAPVLWmLxPtNJkyfuMK1fgcXw+tqYnd4TwhuCN/zpamhEAMdTtt486O7/VXNCm/AkMxC3KUEdfieVX//Lw3i1ZEc06Xyrx+uyQLZAo6hofVDwoFR77K0UXojjrnHJAXIpiCmsXSmbfTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566710; c=relaxed/simple;
	bh=18TYaRN/VD3M+NTbtvZRXFNKYo91KOmQHfGyYOcXug8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me6eM4lKjlrtQfaxytUbx8vbQZYVDJHT+YSRrSFRFQbpKueOjcHyv081dxezkCVE3XrQkngJdmMvas6Uvb3Eh0Jaz8nNeSawHjAJgSuj5qIHxVLCib779b2obnp9hepHG7AW2trDYkHF0yrrMBMJvtc+JWWBht9O4RbwNh79cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XJ+al+3X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RDssPQKk0DP2H8FGxxbB4dIquMeh6O1Th4YqfuxP+0A=; b=XJ+al+3XFwWBfIWgZTF2PDhXDc
	bgv+0ZPIRzl1UnHlQ8aQd8VaCQqAIW1LxcTU4qBw2/47Qj5AtTu7oWmOcgm3IkfaQO0Yglg634sDv
	V+hkuZ13Sb8wfF0jejchiM/Q2ewqyAnwHcdYKIVdqqCU9Zq7k+jWgNCnu5aprqeWhJ3CEnRm6DTLm
	JbhOuGwbDYRMBnE+Uz7DoCJLukT73IKEuXDyY+95QZguOTDCq665ZBrj1DdWbb6ari8FnUxMylo2y
	MekWai7Bd0UOjMwM3j4U4L2XPmOhsFDPvoYhz0wA3yfg1FOQaKVoSAg+06YXNjLQUYGOS9I2GKa6q
	3NfvYYLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sN7qh-0006FT-06;
	Fri, 28 Jun 2024 10:24:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sN7qi-0006PK-0M; Fri, 28 Jun 2024 10:24:56 +0100
Date: Fri, 28 Jun 2024 10:24:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to
 suspend
Message-ID: <Zn6BZ4b4h8YJ3Z0u@shell.armlinux.org.uk>
References: <20240628060318.458925-1-youwan@nfschina.com>
 <Zn5xmMpTLK/fRoYh@shell.armlinux.org.uk>
 <249879ad-aa97-452c-a173-65255818d2d4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249879ad-aa97-452c-a173-65255818d2d4@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 09:25:54AM +0100, Florian Fainelli wrote:
> Would not the situation described here be solved by having the Motorcomm PHY
> driver set PHY_ALWAYS_CALL_SUSPEND since it deals with checking whether WoL
> is enabled or not and will just return then.

Let's also look at PHY_ALWAYS_CALL_SUSPEND. There are currently two
drivers that make use of it - realtek and broadcom.

Looking at realtek, it is used with driver instances that call
	rtl821x_suspend
	rtl821x_resume

rtl821x_suspend() does nothing if phydev->wol_enabled is true.
rtl821x_resume() only re-enabled the clock if phydev->wol_enabled
was false (in other words, rtl821x has disabled the clock.) However,
it always calls genphy_resume() - presumably this is the reason for
the flag.

The realtek driver instances do not populate .set_wol nor .get_wol,
so the PHY itself does not support WoL configuration. This means
that the phy_ethtool_get_wol() call in phy_suspend() will also fail,
and since wol.wolopts is initialised to zero, phydev->wol_enabled
will only be true if netdev->wol_enabled is true.

Thus, for phydev->wol_enabled to be true, netdev->wol_enabled must
be true, and we won't get here via mdio_bus_phy_suspend() as 
mdio_bus_phy_may_suspend() will return false in this case.


Looking at broadcom, it's used with only one driver instance for
BCM54210E which calls:
	bcm54xx_suspend
	bcm54xx_resume

Other driver instances also call these two functions but do not
set this flag - BCM54612E, BCM54810, BCM54811, BCM50610, and
BCM50610M. Moreover, none of these implement the .get_wol and
.set_wol methods which means the behaviour is as I describe for
Realtek above that also doesn't implement these methods.

The only case where this is different is BCM54210E which does
populate these methods.

bcm54xx_suspend() stops ptp, and if WoL is enabled, configures the
wakeup IRQ. bcm54xx_resume() deconfigures the wakeup IRQ.

This could lead us into a case where the PHY has WoL enabled, the
phy_ethtool_get_wol() call returns that, causing phydev->wol_enabled
to be set, and netdev->wol_enabled is not set.

However, in this case, it would not be a problem because the driver
has set PHY_ALWAYS_CALL_SUSPEND, so we won't return -EBUSY.


Now, looking again at motorcomm, yt8521_resume() disables auto-sleep
before checking whether WoL is enabled. So, the driver is probably
missing PHY_ALWAYS_CALL_SUSPEND if auto-sleep needs to be disabled
each and every resume whether WoL is enabled or not.

However, if we look at yt8521_config_init(), this will also disable
auto sleep. This will be called from phy_init_hw(), and in the
mdio_bus_phy_resume() path, immediately before phy_resume(). Likewise
when we attach the PHY.

Then we have some net drivers that call phy_resume() directly...

drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
	(we already have a workaround merged for
	PHY-not-providing-clock)

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
	A suspend/resume cycle of the PHY is done when entering loopback mode.

drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
	No idea on this one - it resumes the PHY before enabling
	loopback mode, and enters suspend when disabling loopback
	mode!

drivers/net/ethernet/broadcom/genet/bcmgenet.c
	bcmgenet_resume() calls phy_init_hw() before phy_resume().

drivers/net/ethernet/broadcom/bcmsysport.c
	bcm_sysport_resume() *doesn't* appear to call phy_init_hw()
	before phy_resume(), so I wonder whether the config is
	properly restored on resume?

drivers/net/ethernet/realtek/r8169_main.c
	rtl8169_up() calls phy_init_hw() before phy_resume().

drivers/net/usb/ax88172a.c
	This doesn't actually call phy_resume(), but calls
	genphy_resume() directly from ax88172a_reset() immediately
	after phy_connect(). However, connecting to a PHY will
	call phy_resume()... confused here.

So I'm left wondering whether yt8521_resume() should be fiddling with
this auto-sleep mode, especially as yt8521_config_init() will do that
if the appropriate DT property is set... and whether this should be
done unconditionally.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

