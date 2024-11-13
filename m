Return-Path: <netdev+bounces-144490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6549C7952
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EBF2811A1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83D16EB5D;
	Wed, 13 Nov 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xpzRlhka"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BB139D19
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516746; cv=none; b=HHI1VU7BwUI3Aszz0Nyeae/N3kEqW9Iigy/nd3FEnVxzfZRemxp6anqNNe9GuSdVJOI1tjzzPUFOWKUhOFnTI5YxT9dBgu897lM4tmh1ZIqRTXLoT8c1pVEi0wQIywG+8mB7usCxOe/y7rbqoeSQMM8Ongc1nMMEcNxTkeWt714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516746; c=relaxed/simple;
	bh=0Z4o3TDZ693+wWh5VbaRiAwVcn4qWdFUZXK4rq+i7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgeGB+BJyoJJEn9pcogqtHGwW/o5mRjSWiclBpKoogeILIwEAPHZ+xHgfJ7gzvp3K2H/HfTTaanXIQJE0oPQh3+lJ2w1LyfsRsuhCmRjBUTNCgfqARvWsOkqWURNfLXd6F7ZIp0uyRv5n/r86U/ARdMS4FU7zrD446OTMag9fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xpzRlhka; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cr2GVmJrS4wCHQerCfK0osrD40pAehFQUM+8hUG8sEg=; b=xpzRlhkaKYoyFKbldT32qzp/e7
	GVeHZc88CJqy7PNqSQ0QM5oK/WkFLuDrjAZy9rELKtDg+h/rYlpVDjTV90oF7bmRkGCySfhlxWGRE
	7hfkluT6BAcTrUg124Bl141vxpXpPAp/Bum7ZjKaATtfJZ5PHsC78PE4wRqkh7HH3EoaCW7RIM8Wx
	OJ2sia9xLDP4RXsfTnlo90I7ZQ9rNc2k3u10br7HZQrEQgCFHLZXcjQofx7yJvdL512M+uiBaFhhO
	Q6ap4JW7IbgzwYrSYU1IAO4ovykofUgRxmB1wKCalwKheNc2NaFcJfe4oYJZjnBtuKc9ODkuPyGPl
	T7eYhzvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBGbN-0006YU-11;
	Wed, 13 Nov 2024 16:52:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBGbM-0000BW-1W;
	Wed, 13 Nov 2024 16:52:20 +0000
Date: Wed, 13 Nov 2024 16:52:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <ZzTZRCWLxHZ_WDhW@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
 <20241113161602.2d36080c@kmaincent-XPS-13-7390>
 <ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
 <20241113171443.697ac278@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113171443.697ac278@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 13, 2024 at 05:14:43PM +0100, Kory Maincent wrote:
> On Wed, 13 Nov 2024 15:57:56 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote:
> > > Hello Russell,
> > > 
> > > On Wed, 13 Nov 2024 14:46:25 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >   
> > > > Hi Kory,
> > > > 
> > > > I've finally found some cycles (and time when I'm next to the platform)
> > > > to test the selectable timestamping feature. However, I'm struggling to
> > > > get it to work.
> > > > 
> > > > In your email
> > > > https://lore.kernel.org/20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com/
> > > > you state that "You can test it with the ethtool source on branch
> > > > feature_ptp of: https://github.com/kmaincent/ethtool". I cloned this
> > > > repository, checked out the feature_ptp branch, and while building
> > > > I get the following warnings:
> > > > 
> > > > My conclusion is... your ethtool sources for testing this feature are
> > > > broken, or this is no longer the place to test this feature.  
> > > 
> > > Yeah, it was for v3 of the patch series. It didn't follow up to v19, I am
> > > using ynl tool which is the easiest way to test it.
> > > As there were a lot of changes along the way, updating ethtool every time
> > > was not a good idea.
> > > 
> > > Use ynl tool. Commands are described in the last patch of the series:
> > > https://lore.kernel.org/all/20241030-feature_ptp_netnext-v19-10-94f8aadc9d5c@bootlin.com/
> > > 
> > > You simply need to install python python-yaml and maybe others python
> > > subpackages.
> > > Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" on the
> > > board.
> > > 
> > > Then run the ynl commands.  
> > 
> > Thanks... fairly unweildly but at least it's functional. However,
> > running the first, I immediately find a problem:
> > 
> > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > tsinfo-get --json '{"header":{"dev-name":"eth0"}}'
> > 
> > One would expect this to only return results for eth0 ?
> 
> Indeed it should! That's weird, I will investigate.
> 
> > Also, I don't see more than one timestamper on any interface - there
> > should be two on eth2, one for the MAC and one for the PHY. I see the
> > timestamper for the mvpp2 MAC, but nothing for the PHY. The PTP clock
> > on the PHY is definitely registered (/dev/ptp0), which means
> > phydev->mii_ts should be pointing to the MII timestamper for the PHY.
> > 
> > I've also tried with --json '{"header":{"dev-name":"eth2"}}' but no
> > difference - it still reports all interfaces and only one timestamper
> > for eth2.
> 
> Sorry forgot to explain that you need to register PTP clock with the function
> phydev_ptp_clock_register() in the PHY driver.

That is certainly inconvenient. Marvell's PHY PTP/TAI implementation is
used elsewhere, so the TAI driver is not specific to it being on a PHY.
The drivers/ptp/marvell*.c that you find in my patches is meant to
eventually replace drivers/net/dsa/mv88e6xxx/ptp.c - the same hardware
block is in Marvell's DSA switches.

> It will be changed in v20 as request by Jakub. I will save the hwtstamp source
> and phydev pointer in the netdev core instead.

I think I'll shelve this until that happens, hopefully that will mean
my existing code will work and remain a re-usable library.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

