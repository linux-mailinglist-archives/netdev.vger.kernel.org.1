Return-Path: <netdev+bounces-145290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E09CE103
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550AD1F21600
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E941CEEB2;
	Fri, 15 Nov 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FgChEBy7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB151CDA3F;
	Fri, 15 Nov 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679987; cv=none; b=RB/vuwx90n3b1ARr1L1vwiOdhQLX4EvUD2UzhhNXh1oCsjWYQ6VkuLRDihlml4+BC3ZwwyYzGRx06npimPOpUHpZB0eYZA7W3RLs6DFydg7NVJp8E1AGxP6iSLd1KQBmbV1l3dtf91Xnb2rGVlF6KV56LYMXDUISCMvOGKhjPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679987; c=relaxed/simple;
	bh=tEwx7ySV/rj0eZVT+xpG8c/YM2OZU0LddxtLl/tCygw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbS94cAMyqMZOMYxLK2Q94zPZ21f9NO6XBEinFFxcB0Z4M7Eh3Ik3TJOkP39KOpcmWezMxq+lSqM0AVd/c6ztnzqgYcgfkAZebsJ/rAnrnbxfbjCofIptvW1K10EZCY63mUqRhK+Ux7LRhIvnK193XQc2LJdeRc1eWV7Td9Bzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FgChEBy7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kCJamRcv160IaLBk591jHJ5/fIg4GfMqcqO3NZ/cgPo=; b=FgChEBy7f0xHqUezBIeOC59p8L
	ZIl1QDD3C+5HuUow1dNSNJBICuq78SuDCZidjKnpgYbz8kTvrQ7BDv2gYrDf0ktiu7yXzVHyHSc55
	58DVQAbV7yLJ1fpaTsghTN3jaGpHaX5Nvycf8LC8uIQNtLGSzTP4Br5xO63HQnQg9EodOdiswdHae
	f0Not3t/g8D22gAMIno8lPfFIAsDMjdfZTdeGJ3mQgBlfnnkfQtG5Sk/ahvHrUh5KaX0yuenCVC1e
	BhKEX/Gb/ggnrH/pzQJ53h0MT4qu4Kx46tv/SWxVHuxlLgax/+P6gra19Hbu/fA2wsn6QAvUKByJm
	NM4ZvpPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54080)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBx45-0001So-23;
	Fri, 15 Nov 2024 14:12:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBx3z-0002Bd-09;
	Fri, 15 Nov 2024 14:12:43 +0000
Date: Fri, 15 Nov 2024 14:12:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2 0/2] Fix 'ethtool --show-eee' during initial stage
Message-ID: <ZzdW2iB2OkbZxTgS@shell.armlinux.org.uk>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <403be2f6-bab1-4a63-bad4-c7eac1e572ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403be2f6-bab1-4a63-bad4-c7eac1e572ee@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 15, 2024 at 02:41:54PM +0100, Heiner Kallweit wrote:
> On 15.11.2024 12:11, Choong Yong Liang wrote:
> > From: Choong Yong Liang <yong.liang.choong@intel.com>
> > 
> > When the MAC boots up with a Marvell PHY and phy_support_eee() is implemented,
> > the 'ethtool --show-eee' command shows that EEE is enabled, but in actuality,
> > the driver side is disabled. If we try to enable EEE through
> > 'ethtool --set-eee' for a Marvell PHY, nothing happens because the eee_cfg
> > matches the setting required to enable EEE in ethnl_set_eee().
> > 
> > This patch series will remove phydev->eee_enabled and replace it with
> > eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(), it
> > will follow the master configuration to have software and hardware in sync,
> > allowing 'ethtool --show-eee' to display the correct value during the
> > initial stage.
> > 
> > v2 changes:
> >  - Implement the prototype suggested by Russell
> >  - Check EEE before calling phy_support_eee()
> > 
> > Thanks to Russell for the proposed prototype in [1].
> > 
> > Reference:
> > [1] https://patchwork.kernel.org/comment/26121323/
> > 
> > Choong Yong Liang (2):
> >   net: phy: replace phydev->eee_enabled with eee_cfg.eee_enabled
> >   net: stmmac: set initial EEE policy configuration
> > 
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +++
> >  drivers/net/phy/phy-c45.c                         | 11 +++++------
> >  drivers/net/phy/phy_device.c                      |  6 +++---
> >  include/linux/phy.h                               |  5 ++---
> >  4 files changed, 13 insertions(+), 12 deletions(-)
> > 
> 
> Russell submitted the proposed patch already:
> https://patchwork.kernel.org/project/netdevbpf/patch/E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk/
> So there's no need for your patch 1.

Patch 1 is an updated version of that patch, minus my authorship and of
course no sign-off. I've already marked this series as requiring changes
in patchwork (hopefully, if I did it correctly.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

