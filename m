Return-Path: <netdev+bounces-88031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0B8A5649
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DE4B20C95
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B977F22;
	Mon, 15 Apr 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D5zcEsLk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3042047
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194705; cv=none; b=nS2svwzc+0BVEVzlHuklNATTDwc+Kv0MK6sI306kGaF5XRXpzOSt20Q9PI0iMtPIosWFIqyp+Z4NVoEhCqdlq2kJacn10k1OjilG6JujXAi37FVkMljrSqejOzuDyUJ3a8NWA0Mg6gVMBXxOWUQ7yhwkCmYqASx+VpJWzTf7vaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194705; c=relaxed/simple;
	bh=oy8hFLDtjc/3z9TAtvaf7rSWLWM47Dw5jq8lO257EnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZesUzTys3YsFjBOu3HKgHEq/gH543lK4vmDu/K1ZWBIm7kFDZRuA2UU9VGw5XqqbMA6XCYWOpSbDRUahbv6maDa+91IdxxLlVBYJYJ8Fdb9+H7v0NvnFAoxhvGWVoDVrvc6GuT7U3euJ8DX+CIA6a7jSO7Bs1HEiHc13dZF5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D5zcEsLk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=avnNlYUft5UUF98sKyfEio6pBY/rOYcoq9LS2fNp3co=; b=D5zcEsLkNhhkqmLdeOHihfy5mU
	hq8jm2zznGflGBBu+CNDQqZ7ttQHF+4eD5diP6mIyUuuikWFtVDqjmBYSLLzYVEQW4iExMdvj/q1m
	yRJWwjcsJbkjhTSGjHAhGA9eryamAYFAluDAiCg5f55wIB6qxOXFclsTciaAd7Oe/39+O+OcIuSjG
	pR7TGxB8XwqpOEvxigyy2ITutpz/KlUEW87v/OmYt9KXWfDBwsTSeanHTjarI4NSBmB4geBDlV5kw
	l2Xq5gtU/8nmRd/+lLmjqAgebH2sYOLTJFJKCzL5sQMnVGUQyr2CNuY/MH4BE3p+wln1u6nzBGTR3
	tqLeDZ1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34150)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwOCO-0006de-19;
	Mon, 15 Apr 2024 16:24:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwOCM-0002Ht-1J; Mon, 15 Apr 2024 16:24:46 +0100
Date: Mon, 15 Apr 2024 16:24:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Message-ID: <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <20240415103453.drozvtf7tnwtpiht@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415103453.drozvtf7tnwtpiht@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 01:34:53PM +0300, Vladimir Oltean wrote:
> On Fri, Apr 12, 2024 at 04:15:08PM +0100, Russell King (Oracle) wrote:
> > Convert felix to provide its own phylink MAC operations, thus
> > avoiding the shim layer in DSA's port.c.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
> > index 22187d831c4b..a8927dc7aca4 100644
> > --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> > +++ b/drivers/net/dsa/ocelot/ocelot_ext.c
> > @@ -96,6 +96,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
> >  	ds->num_tx_queues = felix->info->num_tx_queues;
> >  
> >  	ds->ops = &felix_switch_ops;
> > +	ds->phylink_mac_ops = &felix_phylink_mac_ops;
> 
> There are actually 2 more places which need this: felix_vsc9959.c,
> seville_vsc9953.c.

Looking at these three, isn't there good reason to merge the allocation
and initialisation of struct dsa_switch together in all three drivers?
All three are basically doing the same thing:

felix_vsc9959.c:
        ds->dev = &pdev->dev;
        ds->num_ports = felix->info->num_ports;
        ds->num_tx_queues = felix->info->num_tx_queues;
        ds->ops = &felix_switch_ops;
        ds->priv = ocelot;
        felix->ds = ds;

ocelot_ext.c:
        ds->dev = dev;
        ds->num_ports = felix->info->num_ports;
        ds->num_tx_queues = felix->info->num_tx_queues;
        ds->ops = &felix_switch_ops;
        ds->priv = ocelot;
        felix->ds = ds;

seville_vsc9953.c:
        ds->dev = &pdev->dev;
        ds->num_ports = felix->info->num_ports;
        ds->ops = &felix_switch_ops;
        ds->priv = ocelot;
        felix->ds = ds;

Also, I note that felix->info->num_tx_queues on seville_vsc9953.c
is set to OCELOT_NUM_TC, which is defined to be 8, and is the same
value for ocelot_ext and felix_vsc9959. Presumably this unintentionally
missing from seville_vsc9953.c... because why initialise a private
struct member to a non-zero value and then not use it.

An alternative would be to initialise .num_tx_queues in seville_vsc9953.c
to zero.

If we had common code doing this initialisation, then it wouldn't be
missed... and neither would have _this_ addition of the phylink MAC
ops missed the other two drivers - so I think that's something which
should be done as a matter of course - and thus there will be no need
to export these two data structures, just an initialisation (and
destruction) function. I don't think we would even need the destruction
function if we used devm_kzalloc().

Good idea?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

