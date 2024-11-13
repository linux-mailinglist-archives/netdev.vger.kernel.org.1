Return-Path: <netdev+bounces-144483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B257A9C77FE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DE28B798
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158870833;
	Wed, 13 Nov 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YM3DRoqR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF8137C35
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513489; cv=none; b=eQJEhPs6Jz69nyH5aG2ZD6UdQXZpz+I6F9ZeSVUj6QCCkuNfNyvglXbSYhnCetJmJ/Rg/S8OjotfSPD1x/4EkOyLbmqOebYQDDgAtJdLZ0V+iE7/ZK9p9sEA15bkcV2F1dqUeJicDBVR7T8kBBRDTbKuzqhna8fg22Uvdxp32Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513489; c=relaxed/simple;
	bh=R+8c/mFVaGfzFWKnKLxWbnQEk+zfkh5pKuYb2TvdNTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBAcZMgt3rUo/buK8zsowB69fHT1Jy2c/iwindgZgv21j57ZVpWo9u1+SkE3ImO/exQPBcI5PWRxI4+HToSrxKIRoIAM6vCHL5bEKJUFCIfyE0s62HPQmmUIROe2TvinXiYtKYh6udCJBdULWR7cLrUF6R7rM+T3YNqZw/8YCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YM3DRoqR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dgnBqIZbxHp2r6NZfh04F67eD1rjlvGLxGBw//piS7k=; b=YM3DRoqRJ64dd3qTTujtMwW5LM
	p9d3YFHv3U7IDRkkGqzwAD3TTYrVlZYF2jTRFtLx0NAxKKEnFTz2HjaQmuxGAcug0yHADofqth9ma
	yb9LaBUmc8MB1p6IrfxgmD/VtAqlLzYALcAZS+I3mLZ/J3vpae+5543DueR81rYLWG5yRz9BzQYrp
	YQ+mJBut139ckPpPc0BVQvn4wvHmqzbFl686DPL2RcaYSw9zqeZ48UH/Kodr2oZeHel+XVJsd2yES
	NH4qCjCMnPIYlkWegy7FyNkgJMrtyD4rbnv+xZThbR8zxOPbVNn9LFLvhii7MlsTJ3clrc/eVc1lf
	pLrJ5n7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40622)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBFkj-0006UI-27;
	Wed, 13 Nov 2024 15:57:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBFki-00009Q-2G;
	Wed, 13 Nov 2024 15:57:56 +0000
Date: Wed, 13 Nov 2024 15:57:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
 <20241113161602.2d36080c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113161602.2d36080c@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 13, 2024 at 04:16:02PM +0100, Kory Maincent wrote:
> Hello Russell,
> 
> On Wed, 13 Nov 2024 14:46:25 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > Hi Kory,
> > 
> > I've finally found some cycles (and time when I'm next to the platform)
> > to test the selectable timestamping feature. However, I'm struggling to
> > get it to work.
> > 
> > In your email
> > https://lore.kernel.org/20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com/
> > you state that "You can test it with the ethtool source on branch
> > feature_ptp of: https://github.com/kmaincent/ethtool". I cloned this
> > repository, checked out the feature_ptp branch, and while building
> > I get the following warnings:
> > 
> > My conclusion is... your ethtool sources for testing this feature are
> > broken, or this is no longer the place to test this feature.
> 
> Yeah, it was for v3 of the patch series. It didn't follow up to v19, I am using
> ynl tool which is the easiest way to test it.
> As there were a lot of changes along the way, updating ethtool every time was
> not a good idea.
> 
> Use ynl tool. Commands are described in the last patch of the series:
> https://lore.kernel.org/all/20241030-feature_ptp_netnext-v19-10-94f8aadc9d5c@bootlin.com/
> 
> You simply need to install python python-yaml and maybe others python
> subpackages.
> Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" on the
> board.
> 
> Then run the ynl commands.

Thanks... fairly unweildly but at least it's functional. However,
running the first, I immediately find a problem:

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump tsinfo-get --json '{"header":{"dev-name":"eth0"}}'

One would expect this to only return results for eth0 ? I get:

[{'header': {'dev-index': 1, 'dev-name': 'lo'},
  'timestamping': {'bits': {'bit': [{'index': 1, 'name': 'software-transmit'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'}]},
                   'nomask': True,
                   'size': 17}},
... one entry per network device ...

Also, I don't see more than one timestamper on any interface - there
should be two on eth2, one for the MAC and one for the PHY. I see the
timestamper for the mvpp2 MAC, but nothing for the PHY. The PTP clock
on the PHY is definitely registered (/dev/ptp0), which means
phydev->mii_ts should be pointing to the MII timestamper for the PHY.

I've also tried with --json '{"header":{"dev-name":"eth2"}}' but no
difference - it still reports all interfaces and only one timestamper
for eth2.

I'm waiting for a kernel to build with nlmon modular to investigate
further.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

