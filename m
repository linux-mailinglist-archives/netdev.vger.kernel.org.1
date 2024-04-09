Return-Path: <netdev+bounces-86217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939E89E093
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF7DB26760
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFB13E40F;
	Tue,  9 Apr 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a4IMNqme"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93953E37
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680177; cv=none; b=WmGz/0gbUtlwGEpPmBLUllzBQZi7gZVwnGQAly9OJrfu6f7eA7sw+fefj6+UiACIgNXaBNtNKMaDkgfgZ4/DaiPpb/Tl0uIJXF+xklEQMjZJkofrnzfPeP9aB7+txfvBce0BIJd8hyJkLqPfUIy3EOfh9Xi4W83R5WKV9IsuQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680177; c=relaxed/simple;
	bh=ioIe6eZus62djC60qKC/+0IDglC1uSRhrGzv49xWJGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdQv7MnybSovF6Yzt+/usxjxxoS1QFNOn8XaPlVPjo4gigUTF2mEWAJC9++aaLRquKOCRij+jyWMfRSs/rDS9tOSguBcWo4FePVfp8pKtN/RXKQiYK/0LQuMJcRxrsQxo4jxWkJtHNNRDFGqUaycOJRzW8QNTL/94VLPc5tcVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a4IMNqme; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fxJPOXf4P+gzSeDjd7IZt/EqlylRVvFoXrZcrKHol7E=; b=a4IMNqmes/1pKsG3FMrKk9weJr
	flv4o4EsY5aQQxjOx2xVrvT1nw9lc6BVqHSYnnH8b7WIkXEhg2KPQIOa/oswrZ9PnSpxa8E1xZ3MU
	GAxaloezOzAKyrEgpIF5Q2HBH4HDTA3a5u52W/q4N/Aqbe+37QG5toF9wHqN+JAAFupbAeIaH4Kj3
	1gDJgvon/xruKK5bGWjBug++jQWoI2XthtY/5hEM50QNy2cWN5/u/TxBCra0NUcAUCAhyy3Uq4ZN9
	XMTk8yf/Ut1fZ8aynLwuc1aC8oHYiGZZdi+4Ts6dH7U0O9bRQSindQL1Mo1CK3iHhkWO2+i1Zivrt
	rc9ZCtSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43536)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ruELd-0006mx-07;
	Tue, 09 Apr 2024 17:29:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ruELc-0005Bs-1L; Tue, 09 Apr 2024 17:29:24 +0100
Date: Tue, 9 Apr 2024 17:29:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <ZhVs41dODkA/B7JH@shell.armlinux.org.uk>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
 <20240409123731.t3stvkcnjnr6mswb@skbuf>
 <20240409153346.atvof7b6ziaf2xr5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409153346.atvof7b6ziaf2xr5@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 06:33:46PM +0300, Vladimir Oltean wrote:
> On Tue, Apr 09, 2024 at 03:37:31PM +0300, Vladimir Oltean wrote:
> > On Mon, Apr 08, 2024 at 12:19:25PM +0100, Russell King (Oracle) wrote:
> > > +static void dsa_shared_port_link_down(struct dsa_port *dp)
> > > +{
> > > +	struct dsa_switch *ds = dp->ds;
> > > +
> > > +	if (ds->phylink_mac_ops) {
> > > +		if (ds->phylink_mac_ops->mac_link_down)
> > > +			ds->phylink_mac_ops->mac_link_down(&dp->pl_config,
> > > +							   MLO_AN_FIXED,
> > > +							   PHY_INTERFACE_MODE_NA);
> > > +	} else {
> > > +		if (ds->ops->phylink_mac_link_down)
> > > +			ds->ops->phylink_mac_link_down(ds, dp->index,
> > > +				MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
> > > +	}
> > > +}
> > 
> > Please roll this other change into the patch when respinning:
> > 
> > else {
> > 	if { }
> > }
> > 
> > becomes
> > 
> > else if {}

This would destroy the symmetry that I think aids readability. I did
consider it at the time and decided against it.

> Something like this:
> 
> static void dsa_shared_port_link_down(struct dsa_port *dp)
> {
> 	struct dsa_switch *ds = dp->ds;
> 
> 	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down) {
> 		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
> 						   PHY_INTERFACE_MODE_NA);
> 	} else if (ds->ops->phylink_mac_link_down) {
> 		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
> 					       PHY_INTERFACE_MODE_NA);
> 	}

This changes the logic - it allows driver authors to provide the
MAC operations, omit the mac_link_down() op _and_ an
ops->phylink_mac_link_down() function. This could lead to buggy
drivers since this will only happen in this path and none of the
others.

I want this to be an "either provide phylink_mac_ops, and thus
none of the phylink_mac_* ops in dsa_switch_ops will be called" or
"don't provide phylink_mac_ops and the phylink_mac_* ops in
dsa_switch_ops will be called". It's then completely clear cut
that it's one or the other, whereas the code above makes it
unclear.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

