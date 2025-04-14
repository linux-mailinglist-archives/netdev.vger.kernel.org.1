Return-Path: <netdev+bounces-182358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C69A888AC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984D13A894A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD127B4E2;
	Mon, 14 Apr 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e2tBJQCH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6442DFA3D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648569; cv=none; b=T/Ft2lAet1TE4nRW8leXkFDrmrecHK6MM8ox6tFplOvJSG+Q6x3pJm9hMk2ty06D/J8e/xVRisgFipi8l2MngR+Vm6wIMB8MjMqxxm1cNAdI/4kjFX+rLl+8jPY5nDeIWARrgjrYrVFn23ZLPxnDlgQkwMtINzddDhg1v76w7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648569; c=relaxed/simple;
	bh=GbJlHUT2+E1OPyCe6KI2xpg1QVijGO5oq4TryJHTw58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9J9qE3MYjXCMvIxcbffKyx1dcvW9RdFHVEPKlzihpzFl/fT9op3Tv0wSFL1n5LSTJg6+d3x7g8m2Gve2+aLaugwxITXePylWaTHxArYDCqJnpVFYHVDrgbLbWt1XneziNB8e14bPqV4LumOPyVipUsyZX5LuJTs/OsD41nJjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e2tBJQCH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B+ynyl1iOpOSht+KaCAJKMbUSeW+vv8NYPDYi6yqEEQ=; b=e2tBJQCHmb4JhdLhJ/yzvuj8Tx
	ayrSdKwRp6iUiE3IEQ3odbvtZTyJhDi8MgnzNgzgNIoe8j16GBjvpmJOygW4H8SODMvS1zEFUr1nK
	gBzYy/gSYrj1z7mixhS30HtTCOf3ktgKg8IKEAPYeVCr3kEbEZ2QtTBlXrP73kAvrDR2aXPbkPBTz
	x82kvPUhx7ITKXjGHKZA62u5M36117pigbETfbuc4t+IQjKyrotUNYCnbXsaFXP+wsuFUWRx/k5ht
	esy+T8aBVF1Cj4Lb/3n7SlX0iRsq6UuTFxisKY06gs/+25hoTkiTq1QhN9kGvKvKNpyTa9MnbCVON
	ph/lboGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32840)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4Mmu-0006r0-1A;
	Mon, 14 Apr 2025 17:36:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4Mms-0007u4-1E;
	Mon, 14 Apr 2025 17:35:58 +0100
Date: Mon, 14 Apr 2025 17:35:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <Z_05bl9ykY9UzCEI@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
 <20250414164314.033a74d2@kmaincent-XPS-13-7390>
 <Z_0hzd7Bl6ECzyBB@shell.armlinux.org.uk>
 <20250414172137.42e98e29@kmaincent-XPS-13-7390>
 <20250414181643.7eca2d2c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414181643.7eca2d2c@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 06:16:43PM +0200, Kory Maincent wrote:
> On Mon, 14 Apr 2025 17:21:37 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> 
> > On Mon, 14 Apr 2025 15:55:09 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > > On Mon, Apr 14, 2025 at 04:43:14PM +0200, Kory Maincent wrote:  
> > > > On Fri, 11 Apr 2025 22:26:42 +0100
> > > > Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > >     
> >  [...]  
> > > > 
> > > > It seems a lot less stable than the first version of the driver.
> 
> FYI there is also an invalid wait context error:
> [   65.041285] =============================
> [   65.045286] [ BUG: Invalid wait context ]
> [   65.049289] 6.14.0-13314-g04846c13cbec-dirty #91 Not tainted
> [   65.054938] -----------------------------
> [   65.058939] swapper/0/0 is trying to lock:
> [   65.063028] ffff000805b0c110 (&rxq->rx_mutex){....}-{4:4}, at:
> marvell_ptp_rxtstamp+0xf0/0x228 
> [   65.071665] other info that might help us debug this: 
> [   65.076707] context-{3:3}
> [   65.079320] no locks held by swapper/0/0.
> [   65.083321] stack backtrace:
> [   65.086198] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.14.0-13314-g04846c13cbec-dirty #91 PREEMPT(voluntary)
> [   65.086207] Hardware name: Fluyt Prototype 1 Carrier Board ZU9 mpsoc  (DT)
> [   65.086211] Call trace: 
> [   65.086214]  show_stack+0x18/0x24 (C)
> [   65.086224]  dump_stack_lvl+0xa4/0xf4
> [   65.086233]  dump_stack+0x18/0x24
> [   65.086240]  __lock_acquire+0xa14/0x2000
> [   65.086250]  lock_acquire+0x1c4/0x360
> [   65.086259]  __mutex_lock+0xa0/0x52c
> [   65.086266]  mutex_lock_nested+0x24/0x30
> [   65.086273]  marvell_ptp_rxtstamp+0xf0/0x228
> [   65.086282]  marvell_phy_ptp_rxtstamp+0x18/0x24
> [   65.086290]  skb_defer_rx_timestamp+0x104/0x31c

Hmm, I guess that mutex needs to be a spinlock then.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

