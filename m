Return-Path: <netdev+bounces-107577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60E91B9A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98571B2090E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E8142642;
	Fri, 28 Jun 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ffeaizWy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726879D1;
	Fri, 28 Jun 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562665; cv=none; b=OtKj5oiYRNKYzMxO60ji6/SLXzwaBhjFjYnXzO2mHP/WKT+WgOZhJlRfcXs6Hg3kCUmr2031WWbNNVdtUC6lr2nfTtF4lSjlno/86E5G1dKf7ZAQl0h0JcEJNUZXIfCxHPsFMzsmqLy2zKew97rdoBJrIM/+OGH5u4E6FMMSi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562665; c=relaxed/simple;
	bh=vp3ns55itRct6zcfeCEtePjn0D6Djhat8Tf5amfowNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYlyDaRR0hkLb3Uw/UHOCDv+7vqT8CuK8V8ZioAajO4WM1dD8M3w04P5vcglox8xvKiMxkcKCXTPmljTBtxILJvBfggR4I2YGJuOH4RO0vBQrIkILNSCqda2/t6EHbZ7zEPrbEUXkHU19g9iMXuv+9+Kqbt1zvU6taLD/oyRsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ffeaizWy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D8eTs4y+IrJGf7dAqpGknDiVLuigqvNAsUhRewlqFeE=; b=ffeaizWyRS+Q93tIsc2bcR0WII
	oKH6HIsUyL5w52CePk7iYaFccOuCAclDZgPN+YUE+zTNyIsRd2dzFW3YWOoaH8PUtcAyXgjZBmC9o
	qC/meWM5VKI732zX8Y+7/8GrvjVgvnrZ9b98sso5rBiRjN/cLw4tZu+baKIXOM225GUDU+K3oKwyW
	mSa03TBzPA0JKGsjSLdgLkxNNLzpz2KH3LoZssIr9o/WK6Eos2GlX6klW+K+mHqAMplEdjcQx5xmd
	TOqD07N4yl5RnFtPcg+HQiL+YzcpSUT4Pvuo1/3wVFgElFUm98kk3abcVxtc71n0jiVi+kSB4NO9B
	qd2m9DPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53916)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sN6nO-00064Z-39;
	Fri, 28 Jun 2024 09:17:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sN6nQ-0006NC-8p; Fri, 28 Jun 2024 09:17:28 +0100
Date: Fri, 28 Jun 2024 09:17:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to
 suspend
Message-ID: <Zn5xmMpTLK/fRoYh@shell.armlinux.org.uk>
References: <20240628060318.458925-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628060318.458925-1-youwan@nfschina.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 02:03:18PM +0800, Youwan Wang wrote:
> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
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

I think the reason this is happening is because the PHY has WoL enabled
on it without the kernel/netdev driver being aware that WoL is enabled.
Thus, mdio_bus_phy_may_suspend() returns true, allowing the suspend to
happen, but then we find unexpectedly that WoL is enabled on the PHY.

However, whenever a user configures WoL, netdev->wol_enabled will be
set when _any_ WoL mode is enabled and cleared only if all WoL modes
are disabled.

Thus, what we have is a de-sync between the kernel state and hardware
state, leading to the suspend failing.

I don't see anything in the motorcomm driver that requires suspend
if WoL is enabled - yt8521_suspend() first checks to see whether WoL
is enabled, and exits if it is.

Andrew - how do you feel about reading the WoL state from the PHY and
setting netdev->wol_enabled if any WoL is enabled on the PHY? That
would mean that the netdev's WoL state is consistent with the PHY
whether or not the user has configured WoL.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

