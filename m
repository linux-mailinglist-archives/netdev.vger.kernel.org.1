Return-Path: <netdev+bounces-89337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4A8AA0F7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808051C20D46
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201A171092;
	Thu, 18 Apr 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jsvsCI2p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F515E20F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460889; cv=none; b=OJOpIolBA90bNVcUpDegfYTtdtbGg7O4y3R7P+gpVuG1UAJ3Sfr6zxm0t9Q+C3SoqxKoFciD+o0Nd7/4oJP4/XC2kC7o3x4hJKkUyDPyxKoNKH+LDIXw8+gkkUGt5FRpdSEkW264cJjjaMUfmrUxx+v9aFk+8vaVLHDQnYEfQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460889; c=relaxed/simple;
	bh=Eu/gLIB1Z1ejZc1xK+1tWN/sAtqzbT/7dBsgvhkbblY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJI+HsUyrQFOh82DAJel3hRVbqbYn2vj4whSJbEFUasS71CJar8qauQN/owo2YlQ1TQTDDCmEgr3tb7zq5Cbzlb9lOIu3Khn29CwDYkOIkQ783LXjmdCzObZ8aYKrNTbalRQBl4TFPjNjyUdOgLZLaQxxPC6a2zFyusAPfe9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jsvsCI2p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=41KZcV8qu3QXQoKHzPCznCZwSrRQjK7fxMZyrIzK93A=; b=jsvsCI2pOcAHgMW1HrFh4zivVV
	xp4vEraOcjA6tz0QtxKbUOIx6QkMn+sQ+9+WpIB4Oiy8zpTP0fQoxOWZXZngZpN6OEWu0eVpFggqv
	irGg5VlRwJlkpNTaxe5NtoL0X4aPUAqouh5IMzTrSQjXXt5kZyT0UbXpyqwjTb/vTg3sqLnaitkHJ
	blPdaY1tNRwTKOFqFLhEsUoEN9koKONAqGm/uXPI1IRqMomU9w651gh2SAYo3/PSN1M2tsj+P0L/H
	6v0QcpMTAQxK/iOwbIGeplF4LA00cTU5c7uMMNYBwLvnbId+7+K7IM6DPEvxB9Mh72cCHF3jJzPYR
	VMmNgN6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rxVRl-0006eA-2A;
	Thu, 18 Apr 2024 18:21:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rxVRk-00075t-Id; Thu, 18 Apr 2024 18:21:16 +0100
Date: Thu, 18 Apr 2024 18:21:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: bcm_sf2: provide own phylink MAC
 operations
Message-ID: <ZiFWjE++/i8+lDJa@shell.armlinux.org.uk>
References: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
 <3b57b26c-3f1e-4db6-a584-59c84f16dcae@gmail.com>
 <Zh7AaJd4jno/NQDR@shell.armlinux.org.uk>
 <88dda23e-3aa8-43c1-879c-06afc8462938@broadcom.com>
 <36c85e92-911d-4c47-84ac-fa02a7f25c3d@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c85e92-911d-4c47-84ac-fa02a7f25c3d@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 18, 2024 at 09:52:02AM -0700, Florian Fainelli wrote:
> On 4/16/24 20:13, Florian Fainelli wrote:
> > 
> > 
> > On 4/16/2024 11:16 AM, Russell King (Oracle) wrote:
> > > On Tue, Apr 16, 2024 at 10:44:38AM -0700, Florian Fainelli wrote:
> > > > On 4/16/24 03:19, Russell King (Oracle) wrote:
> > > > > Convert bcm_sf2 to provide its own phylink MAC operations, thus
> > > > > avoiding the shim layer in DSA's port.c
> > > > > 
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > 
> > > > Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > 
> > > Great, thanks for testing.
> > > 
> > > (Unrelated to this patch... so please don't delay applying based on
> > > ongoing discussion!)
> > > 
> > > The other Broadcom driver, b53, isn't going to be as simple - I believe
> > > it uses a mixture of the .adjust_link method for shared ports, and
> > > .phylink_mac_* for user ports. That makes it very awkward now, given
> > > the check that was added (and suggested by Vladimir) to check for the
> > > legacy methods if dsa_switch's .phylink_mac_ops is populated.
> > > 
> > > Is there any scope for converting b53 to use only phylink methods for
> > > everything, thus eliminating the .adjust_link callback?
> > 
> > It is on the TODO list for sure, and there might be a window later this
> > week to actually work on removing the adjust_link callback once and for
> > all.
> 
> This is what I came up with so far:
> 
> https://github.com/ffainelli/linux/commits/b53-phylink
> 
> Will test later today on the various devices I have.

A few comments...

In "net: dsa: b53: Configure RGMII for 531x5 and MII for 5325", the
commit description says about adding to b53_mac_config(), but the
code change modifies b53_phylink_mac_link_up(). I would think that
the former (as mentioned in the commit message) was the better
place for this rather than in b53_phylink_mac_link_up().

However, I see you move this to b53_phylink_mac_prepare() in
"net: dsa: b53: Move MII/RGMII configuration to mac_prepare" but
I'm not sure why you've chosen mac_prepare() over mac_config().

FYI, the order in which methods at the MAC and PCS are called on a
reconfiguration is:

	mac_prepare()
	if changing pcs && oldpcs:
		oldpcs::pcs_disable()
	if newpcs:
		newpcs::pre_config()
	mac_config()
	if newpcs:
		newpcs::post_config()
		if changing pcs:
			newpcs::pcs_enable()
		newpcs::pcs_config()
		newpcs::pcs_an_restart()
	mac_finish()

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

