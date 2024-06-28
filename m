Return-Path: <netdev+bounces-107593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F991BA35
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD828551E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866C4D8C9;
	Fri, 28 Jun 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qldAGiO4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3714F98;
	Fri, 28 Jun 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563914; cv=none; b=e85Y8EDkDm2wH/Ln6Ebc5Uu69u6lX7U5BGaJ4NHGNdxQmuSMXfRd8HVN3KUv/apw6ds0Z5TkxKdagbeRq/NFOt+UU/Y1/7FCO/67O6fFEjR71qGmDZPRu3ZT8WMIBDG4HIiK2qTq4rTimJe1vPEEBplHNYS51lGcBXwPNq1K8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563914; c=relaxed/simple;
	bh=Cp7UOsqH9+oFOlQWBl6af7OVUHtrnoO60g0ds+3jFoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq3pEZJA6jippUzDs4SKWD36nFcawet0t3uOgX7tfW6H1rm7mX2m6sYUYI7srRTe1FbwdahT/HjYccjV8n5MnnWJrBoamh8vnxZyQA3zvcrL4wd6ziLxRkUPixcbKJmjEzKS/K/9NXmnzudNnclk7g0lTRPbYsjW1QHcMa/mpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qldAGiO4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j1V/dTARr9C8HnbNq8V7hCXxJBwquWLZu4F/EpaQ+ew=; b=qldAGiO41F7szT9Qj1MQAWCjmy
	V8gbVs4S+ZTjProuPoe3T8egpCVdpyyGn0mTXYoJpU3CnkDk51cfMDYjpFStu/RXqzJBksUJV2hCO
	lvE9IK23kODXbOt+XTA7wo0UW3xsUBgUSJRrLI8bsJyLcexEop1X0MEoFwNwjAQAp7upCEOAumMMP
	jv2sM3AKzPAkJoaJkXqNkKebR02WQSLJ3PcamLtWJGJaOgqiCaefF/1vz7lseBZbp2zzEn+aTeVgj
	P8eVMKUiPMWTisrIFKZaXCKTglU809cyewGXACoPQCe+MpbG/yTFDYAsBC0Gf/fF6CWuslwtR+H8Y
	wqh+vpTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57706)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sN77b-00066n-0r;
	Fri, 28 Jun 2024 09:38:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sN77d-0006NQ-Hg; Fri, 28 Jun 2024 09:38:21 +0100
Date: Fri, 28 Jun 2024 09:38:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to
 suspend
Message-ID: <Zn52fU7FbTwj67dq@shell.armlinux.org.uk>
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
> 
> 
> On 6/28/2024 9:17 AM, Russell King (Oracle) wrote:
> > On Fri, Jun 28, 2024 at 02:03:18PM +0800, Youwan Wang wrote:
> > > If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> > > we cannot suspend the PHY. Although the WOL status has been
> > > checked in phy_suspend(), returning -EBUSY(-16) would cause
> > > the Power Management (PM) to fail to suspend. Since
> > > phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> > > timely error reporting is needed. Therefore, an additional
> > > check is performed here. If the PHY of the mido bus is enabled
> > > with WOL, we skip calling phy_suspend() to avoid PM failure.
> > > 
> > > log:
> > > [  322.631362] OOM killer disabled.
> > > [  322.631364] Freezing remaining freezable tasks
> > > [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> > > [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
> > > [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
> > > PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
> > > [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
> > > PM: failed to suspend: error -16
> > > [  322.669699] PM: Some devices failed to suspend, or early wake event detected
> > > [  322.669949] OOM killer enabled.
> > > [  322.669951] Restarting tasks ... done.
> > > [  322.671008] random: crng reseeded on system resumption
> > > [  322.671014] PM: suspend exit
> > > 
> > > If the YT8521 driver adds phydrv->flags, ask the YT8521 driver to process
> > > WOL at suspend and resume time, the phydev->suspended_by_mdio_bus=1
> > > flag would cause the resume failure.
> 
> Did you mean to write that if the YT8521 PHY driver entry set the
> PHY_ALWAYS_CALL_SUSPEND flag, then it would cause an error during resume? If
> so, why is that?

It doesn't appear to do that - at least not in net-next, and not in
mainline.

> > I think the reason this is happening is because the PHY has WoL enabled
> > on it without the kernel/netdev driver being aware that WoL is enabled.
> > Thus, mdio_bus_phy_may_suspend() returns true, allowing the suspend to
> > happen, but then we find unexpectedly that WoL is enabled on the PHY.
> > 
> > However, whenever a user configures WoL, netdev->wol_enabled will be
> > set when _any_ WoL mode is enabled and cleared only if all WoL modes
> > are disabled.
> > 
> > Thus, what we have is a de-sync between the kernel state and hardware
> > state, leading to the suspend failing.
> > 
> > I don't see anything in the motorcomm driver that requires suspend
> > if WoL is enabled - yt8521_suspend() first checks to see whether WoL
> > is enabled, and exits if it is.
> > 
> > Andrew - how do you feel about reading the WoL state from the PHY and
> > setting netdev->wol_enabled if any WoL is enabled on the PHY? That
> > would mean that the netdev's WoL state is consistent with the PHY
> > whether or not the user has configured WoL.
> 
> Would not the situation described here be solved by having the Motorcomm PHY
> driver set PHY_ALWAYS_CALL_SUSPEND since it deals with checking whether WoL
> is enabled or not and will just return then.

Is there a reason that netdev->wol_enabled shouldn't reflect the
hardware configuration?

If netdev->wol_enabled is appropriately set, then it seems to me
that there's little reason for motorcomm to be checking whether
WoL is enabled in its suspend function - which means less driver
specific code and driver specific behaviour.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

