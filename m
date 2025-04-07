Return-Path: <netdev+bounces-179747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4EA7E6E7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827DE176E0E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38365209681;
	Mon,  7 Apr 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eAadvGkK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F4209F2D;
	Mon,  7 Apr 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043579; cv=none; b=kbB5PSPKckyHl5Nv59NI0vrN8qamLfh9zJTg7YAIqRPXm3BoaFnlhhjMIITY5VbGYGcZak+ODgsE158U+D77nSNVTPb7L4ued0ORgIS9uzsLOdeCFR2hp5K7x0pizUcGjR0W1iLAnFp2B1RhK9lp2M4IpiG+0xTq5IrKotBT3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043579; c=relaxed/simple;
	bh=LGtX53OtMpXApFpTQkQiQKYlJ7eOPTUUkrl2g7LUHY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjE2VI5Bgs3Rph15owU4eWpekaNDyP3gWXTfuFZFfgu+0YYp85eHaOVpgTXpidf8PDhGS9mtWe4qH9A6YFOoVvXysVXxLSIzvmxJqn6/7Hjnk5lWivg0wyL86UaGKRLOg/82J0gsf80Gyiz4bsEDabhRAEAmsZvsLWhoBsOYk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eAadvGkK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wNe0DF/LSdewm7FfMvCiB9sCaLK1XEWV69yNTkeFdCY=; b=eAadvGkKwDaGFwzVAfZgmBIWwW
	Y9hQNLkP/FZfiulkoe190VKWRvC/akqaNkPa9GsFodQzdsST8RK7WKf/ivfPRHxinulMruyzWhRUa
	sJECwSZdHnkeOwKG6yOa3EarsmUAQsJb0o04H6CORPNIJWGinwlmiu1hXT9IR/Hz0QkImzVpfSH+i
	mVYn8cAL3f0WvTKUt+wGGjc50ccumWkO6+xHhupjl8+ZyfdBEs+XGpHvRRyoA3cSYru6uZpVdUYpz
	322hNaGPZ2ZNr3UUhFYlnwUF/R3XY6h0J+wM49PApDNK6ZGIfvCGmSrzCJuDDehbovvUYSVgVrVY1
	65I27c6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u1pOw-0005hu-2i;
	Mon, 07 Apr 2025 17:32:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u1pOt-0000X8-2n;
	Mon, 07 Apr 2025 17:32:43 +0100
Date: Mon, 7 Apr 2025 17:32:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407182028.75531758@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 07, 2025 at 06:20:28PM +0200, Kory Maincent wrote:
> On Mon, 7 Apr 2025 17:02:28 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:
> > > Add PTP basic support for Marvell 88E151x PHYs.
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > Is the PTP selection stuff actually sorted now? Last time I tested it
> > after it having been merged into the kernel for a while, it didn't work,
> > and I reported that fact. You haven't told me that you now expect it to
> > work.
> 
> The last part of the series, the PTP selection support wasn't merged when you
> tested it, although the default PTP choice that causes your regression was
> merged.
> Now it is fully merged, even the ethtool support.
> https://lore.kernel.org/netdev/mjn6eeo6lestvo6z3utb7aemufmfhn5alecyoaz46dt4pwjn6v@4aaaz6qpqd4b/
> 
> The only issue is the rtln warning from the phy_detach function. About it, I
> have already sent you the work I have done throwing ASSERT_RTNL in phy_detach.
> Maybe I should resend it as RFC.
> 
> > I don't want this merged until such time that we can be sure that MVPP2
> > platforms can continue using the MVPP2 PTP support, which to me means
> > that the PTP selection between a MAC and PHY needs to work.
> 
> It should works, the default PTP will be the MAC PTP and you will be able to
> select the current PTP between MAC and PHY with the following command:
> # ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise
> Time stamping configuration for eth0:
> Hardware timestamp provider index: 0
> Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> Hardware Transmit Timestamp Mode:
> 	off
> Hardware Receive Filter Mode:
> 	none
> Hardware Flags: none
> # ethtool --set-hwtimestamp-cfg eth0 index 1 qualifier precise
> Time stamping configuration for eth0:
> Hardware timestamp provider index: 1
> Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> Hardware Transmit Timestamp Mode:
> 	off
> Hardware Receive Filter Mode:
> 	none
> Hardware Flags: none
> 
> You can list the PTPs with the dump command:
> # ethtool --show-time-stamping "*"
> 
> You will need to stop phc2sys and ptp4l during these change as linuxptp may
> face some issues during the PTP change.

I'm preferring to my emails in connection with:

https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk

when I tested your work last time, it seemed that what was merged hadn't
even been tested. In the last email, you said you'd look into it, but I
didn't hear anything further. Have the problems I reported been
addressed?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

