Return-Path: <netdev+bounces-233484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93457C1433F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D85402F7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51452302150;
	Tue, 28 Oct 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FmlJ9xZ3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA72D73A5
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648062; cv=none; b=Ozj2F1taqHAeE4rRvKIMhzof4cGDgiTl2+g88gLaP3a7j+pdr+Mv3MWC32d3EMMIlIOMj3dA8FqDxR0t28xDihHJrLHXZ8dwWeqPtAPAyC6xVrTJVLE8ERxxfNEKKAZScYGfLcr1xF13fJVMXmqfxUVSHt4FHV8OVSOEtLZZSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648062; c=relaxed/simple;
	bh=DeTwFzhPx+qK1HHpl+YgMGztxI9YizNfhUcr9TRNn0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+FwTGLlN6FHTdjkyBfj+jRI8uVLirTeOkHs+3GSOx/GAHaYDiAYRNdyCt3x0r4zFrG4vDJr9uIb3i1nvv899Vyo87aFek3aPCXoQg7FYiHHA5h/rbtyFFGktbAEsTyRWDpvwAaDvKaqKS/Pb93dlZA0mr35bNX/seggxwuJsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FmlJ9xZ3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c0wxYpGazz/mbNZkEG1ty2jCdBuuX7dP/ZCMsktvXgQ=; b=FmlJ9xZ3AY35fJOn9eqW4EynqN
	4md0M+JNO60HV64L82O8Q+kAXwSzTSZN8aPxxeiMYBVZ5WP19k8UPJijuTrqIHxsC0ulDf0Y8VZBf
	89DqVHJNgHjrNestsskRMz2dSzcy5w+Qk60EoQJpRKekZw5LrmWRhUY05mp0C6EJZavc1tAyv1C0G
	YNQNMpI+PJxz0WCx4Msg8YSUo0vG59zHvmIsWEMh0+sCJJrbs4QmpT6PkbNSUQoC0HviSuoGnRme3
	ShHPYC/bh9+TgDXHb+WrxgoXMqgc48fmiCQmFGfzRS3wmGhJcbhuhil3H9l4pPIsVzj2qh5PT4wqf
	7FMhcGww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDh8A-0000000034l-3TOU;
	Tue, 28 Oct 2025 10:40:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDh88-000000006V0-1YLu;
	Tue, 28 Oct 2025 10:40:44 +0000
Date: Tue, 28 Oct 2025 10:40:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis Lothor__ <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: add support specifying PCS
 supported interfaces
Message-ID: <aQCdrNQHF07BVPti@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
 <604b68ce-595f-4d50-92ad-3d1d5a1b4989@bootlin.com>
 <aQCcVOYV15SeHAMU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCcVOYV15SeHAMU@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 10:35:00AM +0000, Russell King (Oracle) wrote:
> Thanks for giving Jakub a reason to mark this "changes required." :D
> I'm not really expecting this to be merged as-is. So why didn't I
> post it as RFC? Too many people see "RFC" as a sign to ignore the
> patch series. Some people claim that "RFC" means it isn't ready and
> thus isn't worth reviewing/testing/etc. I say to those people... I
> can learn their game and work around their behaviour.
> 
> Yes, it will need a better commit log, but what I'm much much more
> interested in is having people who are using the integrated PCS (in
> SGMII mode as that's all we support) to test this, especially
> dwmac-qcom-ethqos folk.
> 
> The 2.5G support was submitted by Sneh Shah, and my attempts to make
> contact have resulted in no response.

I should add - I'm expecting dwmac-qcom-ethqos to reveal that we need
to include 2500BASE-X for the PCS, and possibly 1000BASE-X as well
(which in dwmac terms uses the TBI interface to a platform integrator
provided serdes block.)

The most important thing is for people with the hardware that would be
affected by these patches to test. However, I'm expecting no testing
feedback from such people based on experience - it seems stmmac is rife
for "throw code over the wall into mainline and run away" behaviour. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

