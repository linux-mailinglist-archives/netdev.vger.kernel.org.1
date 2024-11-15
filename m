Return-Path: <netdev+bounces-145280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE49CE062
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B871F27E9A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F41CBA1D;
	Fri, 15 Nov 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kl27prUP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FB1C5798;
	Fri, 15 Nov 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677867; cv=none; b=BA5wcYv/cc3IfemfP4s6z4/MFACrn6dgEKMY/fodsmci7j0G5Phhuj/QibOpV00lbeQCnmeGzitk/cTzC2XXW1qtw4uWcV3eAtM3Rl1VunS9fM8bWYBv4sYlYUgOdP3sR2QhdANzfKeWK8d9CB6QAh07LYYRkij/2X6TIDQzuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677867; c=relaxed/simple;
	bh=NQpWmVhFjCz/wptYBuBsug630baqpkCBgf4u+LxRKT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWVdU8/EiI4glciZ+N754uhMe7lXi8bTGpZiBuFF77NWSHMWk+4lHkdA+BcBBP9YpyuT8F0Syx3487Lj/MOw9ep/XqDsiPxA9WMcbrh+Cu5lBLrk2TeDPh1No8iOohr5/1ngLW4Inaa/olN86OhkhDHH5jp7t2IYitybV8ThxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kl27prUP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8+1mHkW5xeUn98DLU2MzEmZyX/j5XKeY/1cmO/2lLi0=; b=Kl27prUPtKYLoQ/s2vZBSQyK7n
	io0y6C+YFo3TFcRYOPId/ovLvP0qnH4MTTmrLCxykNrMAgDlcjuEKYNVgmLD0AZp19EbK4AnN9AMQ
	d2BNDZbM9fF77Uc96Q+nxoFC+wIz1pzysRw6sDoZzSa5/0QH/84rJz04uqaaf8eUUavgjq89VY10V
	IDEScKjh1+tLlUHzQwe3Dcd/ZG9AUCz28wcHJEhUWDeaYKZjmqII/edIgVwkDKi5OuzyWvXADw4vR
	KkpT5l5b86Q3467cLtrC48K/+RD+6P5FkGnwLWRNB6g+B3DsMoen12t09Pu66ZSTV8DuHSRput/f7
	R8PShxVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBwVq-0001Pv-1F;
	Fri, 15 Nov 2024 13:37:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBwVk-00029i-1G;
	Fri, 15 Nov 2024 13:37:20 +0000
Date: Fri, 15 Nov 2024 13:37:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Re: [PATCH net v2 1/2] net: phy: replace phydev->eee_enabled with
 eee_cfg.eee_enabled
Message-ID: <ZzdOkE0lqpl6wx2d@shell.armlinux.org.uk>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 15, 2024 at 07:11:50PM +0800, Choong Yong Liang wrote:
> Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
> designed to have EEE hardware disabled during the initial state.
> 
> In the initial stage, phy_probe() sets phydev->eee_enabled to be disabled.
> Then, the MAC calls phy_support_eee() to set eee_cfg.eee_enabled to be
> enabled. However, when phy_start_aneg() is called,
> genphy_c45_an_config_eee_aneg() still refers to phydev->eee_enabled.
> This causes the 'ethtool --show-eee' command to show that EEE is enabled,
> but in actuality, the driver side is disabled.
> 
> This patch will remove phydev->eee_enabled and replace it with
> eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(),
> it will follow the master configuration to have software and hardware
> in sync.

Hmm. I'm not happy with how you're handling my patch. I would've liked
some feedback on it (thanks for spotting that the set_eee case needed
to pass the state to genphy_c45_an_config_eee_aneg()).

However, what's worse is, that the bulk of this patch is my work, yet
you've effectively claimed complete authorship of it in the way you
are submitting this patch. Moreover, you are violating the kernel
submission rules, as the Signed-off-by does not include one for me
(which I need to explicitly give.) I was waiting for the results of
your testing before finalising the patch.

The patch needs to be authored by me, the first sign-off needs to be
me, then optionally Co-developed-by for you, and then your sign-off.

See Documentation/process/submitting-patches.rst

Thanks.

pw-bot: cr

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

