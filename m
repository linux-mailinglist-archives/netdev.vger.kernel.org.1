Return-Path: <netdev+bounces-88062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80918A581C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA18EB20B35
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114F823BF;
	Mon, 15 Apr 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H8aefQLd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997E8062B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199759; cv=none; b=EmXgUqWy7O70wUXl1ORNMY3XEofbLox2bKuP3W26Bf22KwQkrURwB5Ti6dJu1rGnRVFMRzL0/6N21vi2Mff08iZLTaspMQFApl+FBY0pgaIBs+8SnkMXC4730dJcw+/FSrJcHumPdP3Ct07OVRQPDBeRIcWHyP6cdcMM/ofuk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199759; c=relaxed/simple;
	bh=HQsEQ4x8gLH8yJ4LsYcF3uXuTSqrpNMtkS9sHMjjyBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyQG0UA9Ux0RbyRlkuX3kYQkVQ3qTCpAL94HZLYT5A9ql0c8ZnGAtuzZKDMh60q+Ck/IRsO/EUgFcJzkSERyY1VsEGFXToJJfT1k9sBPcSnGZIvHszmRDYaVG32nQx7/4YV1ZY0evdg286XppaeeRpuCcGoIPCcU+kRT9nkbqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H8aefQLd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iB8ajGMhWxfvOG8pC5ljb7uqZ3qeS8bW6gHpL/q825k=; b=H8aefQLdQnB24ZcmRgmjJ4tpkS
	pXPnKgbCDJq5egAO/AMknlQEFPliBL1306HsQB3UbshILjKLW/WFo7QYNKq2yEz/GlJGs8jnKaw2p
	TuIUBViKjmWZQZWU4ZsgGm2n1/QW61TKGcj6rBE5vZBw5yETLI/YyeMJPN8UJ5kYQMbs6pQDJHA4j
	ZsQHOzdDZMGnECBIxQ0g+bWAdc1RtG61PQg1nXt3pZDicbsflRAbxal4qbRNWRTuhaskEXjOx/qka
	KMwGd9NQ4XGbywsdeUIvLwgTHmZkUK4BalzNUpvt/xR1XoqOx65MYNVhCklwhoqLJvpZUHEVnvJbY
	6XCCVPmA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55540)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwPVw-0006qk-0F;
	Mon, 15 Apr 2024 17:49:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwPVt-0002L0-Or; Mon, 15 Apr 2024 17:49:01 +0100
Date: Mon, 15 Apr 2024 17:49:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <Zh1afZNFnl0DObX0@shell.armlinux.org.uk>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <20240415103453.drozvtf7tnwtpiht@skbuf>
 <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
 <20240415160150.yejcazpjqvn7vhxu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415160150.yejcazpjqvn7vhxu@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 07:01:50PM +0300, Vladimir Oltean wrote:
> On Mon, Apr 15, 2024 at 04:24:45PM +0100, Russell King (Oracle) wrote:
> > Looking at these three, isn't there good reason to merge the allocation
> > and initialisation of struct dsa_switch together in all three drivers?
> > All three are basically doing the same thing:
> > 
> > felix_vsc9959.c:
> >         ds->dev = &pdev->dev;
> >         ds->num_ports = felix->info->num_ports;
> >         ds->num_tx_queues = felix->info->num_tx_queues;
> >         ds->ops = &felix_switch_ops;
> >         ds->priv = ocelot;
> >         felix->ds = ds;
> > 
> > ocelot_ext.c:
> >         ds->dev = dev;
> >         ds->num_ports = felix->info->num_ports;
> >         ds->num_tx_queues = felix->info->num_tx_queues;
> >         ds->ops = &felix_switch_ops;
> >         ds->priv = ocelot;
> >         felix->ds = ds;
> > 
> > seville_vsc9953.c:
> >         ds->dev = &pdev->dev;
> >         ds->num_ports = felix->info->num_ports;
> >         ds->ops = &felix_switch_ops;
> >         ds->priv = ocelot;
> >         felix->ds = ds;
> 
> Yes, there is :)
> 
> If dev_set_drvdata() were to be used instead of platform_set_drvdata()/
> pci_set_drvdata(), there's room for even more common code.
> 
> > Also, I note that felix->info->num_tx_queues on seville_vsc9953.c
> > is set to OCELOT_NUM_TC, which is defined to be 8, and is the same
> > value for ocelot_ext and felix_vsc9959. Presumably this unintentionally
> > missing from seville_vsc9953.c... because why initialise a private
> > struct member to a non-zero value and then not use it.
> > 
> > An alternative would be to initialise .num_tx_queues in seville_vsc9953.c
> > to zero.
> 
> It makes me wonder why felix->info->num_tx_queues even exists...
> 
> It was introduced by commit de143c0e274b ("net: dsa: felix: Configure
> Time-Aware Scheduler via taprio offload") at a time when vsc9959
> (LS1028A) was the only switch supported by the driver. It seems
> unnecessary.
> 
> 8 traffic classes, and 1 queue per traffic class, is a common
> architectural feature of all switches in the family. So they could all
> just set OCELOT_NUM_TC in the common allocation function and be fine
> (and remove felix->info->num_tx_queues).
> 
> When num_tx_queues=0, this is implicitly converted to 1 by dsa_user_create(),
> and this is good enough for basic operation for a switch port. The tc
> qdisc offload layer works with netdev TX queues, so for QoS offload we
> need to pretend we have multiple TX queues. The VSC9953, like ocelot_ext,
> doesn't export QoS offload, so it doesn't really matter. But we can
> definitely set num_tx_queues=8 for all switches.
> 
> > If we had common code doing this initialisation, then it wouldn't be
> > missed... and neither would have _this_ addition of the phylink MAC
> > ops missed the other two drivers - so I think that's something which
> > should be done as a matter of course - and thus there will be no need
> > to export these two data structures, just an initialisation (and
> > destruction) function. I don't think we would even need the destruction
> > function if we used devm_kzalloc().
> > 
> > Good idea?
> 
> Looking again at the driver, I see it's not very consistent in its use of
> devres... It is used elsewhere, including in felix_pci_probe() itself:
> devm_request_threaded_irq().
> 
> Yes, I think the use of devres here would be an improvement.
> 
> Note that felix_pci_probe() will still have to call pci_disable_device()
> on the error teardown path.
> 
> For even more consistency, it would be great if the error teardown
> labels were called after what they do, rather than after the path that
> triggered them. Example:
> - goto err_pci_enable -> goto out
> - goto err_alloc_felix -> goto out_pci_disable

Sounds like there's an opportunity to beneficially clean this driver
up before I make this change, so I'll hold off this patch until that's
happened. I probably don't have the spare cycles for that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

