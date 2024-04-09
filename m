Return-Path: <netdev+bounces-86236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87389E274
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77831C2305C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CC156F28;
	Tue,  9 Apr 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hS46MhZn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1EE156C57
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686945; cv=none; b=rmyJX6N3GxZ5oRlDheS0Ss3or4ue5nAwyT/fNLBU8/b7W6nyxAsMK76YAGNfWFdoCjWeeUIXQ65KJWObL6HklaM9l8lM2vUIRmkFzJftXrAW9y1ZE9nevw4+V9S93ynmHIozCdYekMceiArTinz6E5snocMvQs+59DNqKv7GqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686945; c=relaxed/simple;
	bh=PhAB6xwAb1MOHRciK4SsHlTbtY+AOeaXyGgTG0+/GVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njJgtOw7Ix/2Oi2YwJE1hScF//uTLCzJdbuVsH8lggN0nrOOa18U8hIqKqUnRUJyxFxbhfmrC91MSlmO+oMESvssYd7vjtpN4jXJ5hpDZlD8fNfAxWFaWPOyD2wNrh6T7gFv+ff91Qw0d0dD7UCi9UHr1Uvf0Hud5+nPi7BXN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hS46MhZn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2NUJ9OVC063PMeNqCwUC3jB8Sg0p7p4X9jty4IJZE98=; b=hS46MhZnYZdqeUNUrxocsQov0s
	HFv6L0zFwLhpEOpm0yxGGzrUb3cMHuPFNG1omJOhpIFDsMTnRw6nl2mdvshM+VCJn5ckrk6Ji/JN4
	Q1upzClOAXeSk9PHNdVto9vSLOAXeF7XwG5Z96hzbCk7qYgK7svnZ46yVM4JsxXB2sGTtAbYr5uLj
	D/ZDVEVpKS1RJv8aWf2UqwhmZ1BA6RxqMR4MpfjYMFSLA6sl33+SXjgF1HmLwXc3DUIRSG5AKtVf1
	wSGu7D9xECyXIhXtRw3ttPkZiiCB6EFlkPhlng1B7TrpgJO7oUmgt+0VDHBpewiXTbDuBW8q9SIcc
	i3wYbjsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56412)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ruG6p-0006v1-05;
	Tue, 09 Apr 2024 19:22:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ruG6n-0005GW-RB; Tue, 09 Apr 2024 19:22:13 +0100
Date: Tue, 9 Apr 2024 19:22:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <ZhWHVc/bhaC/rYq7@shell.armlinux.org.uk>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
 <20240409123731.t3stvkcnjnr6mswb@skbuf>
 <20240409153346.atvof7b6ziaf2xr5@skbuf>
 <ZhVs41dODkA/B7JH@shell.armlinux.org.uk>
 <20240409165230.eznwc4opf3mq7qkl@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409165230.eznwc4opf3mq7qkl@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 07:52:30PM +0300, Vladimir Oltean wrote:
> On Tue, Apr 09, 2024 at 05:29:23PM +0100, Russell King (Oracle) wrote:
> > This changes the logic - it allows driver authors to provide the
> > MAC operations, omit the mac_link_down() op _and_ an
> > ops->phylink_mac_link_down() function. This could lead to buggy
> > drivers since this will only happen in this path and none of the
> > others.
> > 
> > I want this to be an "either provide phylink_mac_ops, and thus
> > none of the phylink_mac_* ops in dsa_switch_ops will be called" or
> > "don't provide phylink_mac_ops and the phylink_mac_* ops in
> > dsa_switch_ops will be called". It's then completely clear cut
> > that it's one or the other, whereas the code above makes it
> > unclear.
> 
> If you want for the API transition to be self-documenting and clear,
> it would be good to do that validation separately and more comprehensively
> rather than just a fall-through for one single operation here.
> 
> If phylink_mac_link_ops is provided, the following ds->ops methods are
> obsoleted and can't be provided at the same time (fail probing otherwise):
> 
> - phylink_mac_select_pcs()
> - phylink_mac_prepare()
> - phylink_mac_config()
> - phylink_mac_finish()
> - phylink_mac_link_down()
> - phylink_mac_link_up()
> 
> Hopefully it makes it more clear that the following are _not_ obsoleted
> by the dedicated phylink mac_ops:
> 
> - phylink_get_caps()
> - phylink_fixed_state()
> 
> Then (after this validation), the simplified
> "if (ops && ops->mac_link_down) else (ds->ops->phylink_mac_link_down)"
> would be equivalent, because we've errored out on the case which has a
> mix of old and new API.

Okay. However, I can't predict when I'll get around to doing these
changes as my time is very limited over this week and next week - so
may be right before the merge window is due.

Maybe we should've done that for the ops->adjust_link vs
ops->phylink_mac_link_down/ops->phylink_mac_link_up as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

