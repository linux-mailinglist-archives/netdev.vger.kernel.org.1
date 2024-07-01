Return-Path: <netdev+bounces-108201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CB91E56B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163CFB23625
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C400B14D2AC;
	Mon,  1 Jul 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wchgJlhB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55B46525;
	Mon,  1 Jul 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851536; cv=none; b=FhXJ5NzgLwreIe8q0MMNh4nX3zQvK8B/VO7RAVphE0YS3U53Th9a8qqX/dporRPPh75GOGrRzVJPXywkk9iftolgAsFLoj80JO5w+/jX9b/V0Kwxg1+QwTIUee1CvfraATQEW7hLPVOINSTDVSbTMeqU43mlI3AaJwK7Wc/vFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851536; c=relaxed/simple;
	bh=MMBxZX2hH/sVgsNCW5bp8trGOlBYSIFLvqJ0oTPqdfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMbFu4PLSRl5fu3Zx/iokbAO+giC15Kz3PGaJiBC2dSqyosicjuPXCR19OAl1DJugoDhwybXQ4WToPpurkUh6ua4qAXHJevxB8Kz6f1JEiXb0xy/dmquoECa9XqquQ2TTofQqkLhFM7rjPMWj/pgj88lP5PyIPfRYcrWDX/4vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wchgJlhB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AU7N4szUOgDr+wW5jeX3otLSueJJ1dESnDFcAc2lRx8=; b=wchgJlhBT+amcPbLTjNHChiKX4
	sg526fH9p9aZdTjYQHC0n1NuH3zbXBevMlVae9DsHTTZTECMEi2csx4l3yst4N2XeQuJhc/KAyXFT
	Zs88HDf1CrMO8DtdtaSOLMmLf1pwrHT7m9Ut0mPaeu7nYL1Y0PbO6uOim8nSPypu/Oks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOJwi-001YvR-MG; Mon, 01 Jul 2024 18:32:04 +0200
Date: Mon, 1 Jul 2024 18:32:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Youwan Wang <youwan@nfschina.com>
Cc: davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [net-next,v1] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
Message-ID: <b61cae2b-6b94-465e-b4e4-6c220c6c66d9@lunn.ch>
References: <20240628060318.458925-1-youwan@nfschina.com>
 <20240701062144.552508-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701062144.552508-1-youwan@nfschina.com>

On Mon, Jul 01, 2024 at 02:21:44PM +0800, Youwan Wang wrote:

Please always start a new thread with a new version of a
patchset. Tools like patchwork require this, and without the patchset
in patchwork, it is not going to be applied.

> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
> 
> Thank you all for your analysis.
> I am using the Linux kernel version 6.6, the current system is
> utilizing ACPI firmware. However, in terms of configuration,
> the system only includes MAC layer configuration while lacking
> PHY configuration. Furthermore, it has been observed that the
> phydev->attached_dev is NULL
> 
> Is it possible to add a judgment about netdev is NULL?
> if (!netdev && phydev->wol_enabled &&
>     !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))

Comments like this should be placed below the --- so they don't make
it into the commit message.

Why is phydev->attached_dev NULL? Was a MAC never attached to the PHY?
Has the MAC disconnected the PHY as part of the suspend? It would be
odd that a device being used for WoL would disconnect the PHY.

> 
> log:
> [  322.631362] OOM killer disabled.
> [  322.631364] Freezing remaining freezable tasks
> [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
> [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
> [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: failed to suspend: error -16
> [  322.669699] PM: Some devices failed to suspend, or early wake event detected
> [  322.669949] OOM killer enabled.
> [  322.669951] Restarting tasks ... done.
> [  322.671008] random: crng reseeded on system resumption
> [  322.671014] PM: suspend exit
> 
> If the YT8521 driver adds phydrv->flags, ask the YT8521 driver to process
> WOL at suspend and resume time, the phydev->suspended_by_mdio_bus=1
> flag would cause the resume failure.
> 
> log:
> [  260.814763] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: dpm_run_callback():mdio_bus_phy_resume+0x0/0x160 [libphy] returns -95
> [  260.814782] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: failed to resume: error -95

-95 is EOPNOTSUPP. Where is that coming from?

	Andrew

