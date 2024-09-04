Return-Path: <netdev+bounces-125179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A943D96C2FB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3DE1C25040
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1681E0B86;
	Wed,  4 Sep 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iO71J4k0"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54E1E130F;
	Wed,  4 Sep 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465050; cv=none; b=fF+w9KN83xf+IkgSYkVfefDGC6ywekzw2UYfcM6JcWrJmsKUpEDOtcD4PCKuoEyT0Ma9oY+7XnPyplyZmVJRI8A7kHUrKPpcVrGcrD+Ot7KNfE6PX8523fKAZHHcIzER3nN7/0yGbXWAgHNMi3qfQZJf/Aitlqfg+A7lzv4iVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465050; c=relaxed/simple;
	bh=KZ6FUyu72L8cKs+7ivYFNKjxGHUuSSKaw3k+ttJcGjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVBaQgSz9gdW5U0cWQ34RcFNK6T61EVPrtYbU4d+aa4RsxjPnSG4KPNYb7C0ndOPprGlSV8+pYWh4NbCNoYJkwBVW4gNNp7XMwpTBxsDOtl/88seqgj95bucAIrqBo4A25kFsnLrV8Y1oPudvqcxPE+TiD59wG87Bp9h00fZCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iO71J4k0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B809240003;
	Wed,  4 Sep 2024 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725465046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxBVOgy6vP4MJ5wq+/uQVrDnftB3/9gQPnLp2KgLr6s=;
	b=iO71J4k0L60TPnkLcYV2Yzzo2S9KLm2KzdH/Pfewgw22XIEyt8Tjx9NZhhOIp/OAmpg5dt
	qGgBIvaBUSTXZ75BPmYrWSjw6uqjiFsFM2BLUMaPx9YcTejSGOCXHW7A5xfxerTP1odFRY
	DVw82mewO618HsWL3rBhvTis4oMkq2PowP1dlFcIWL+kCUZq7e+N3BP3kibLFv/2iH+MRe
	2J8Y1LPOEbiWpoWC+cZDnKzGg5DUt4G6dNlfC6HLuWEJVg5rGhXDsfIl+Kv+ta5NutYulh
	JYnRy79HRyD2phWbYU1iiU2H4nJuh7yBUM7Y/MJGHXruXGciFOYNaVHQViSDGw==
Date: Wed, 4 Sep 2024 17:50:43 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 3/7] net: ethernet: fs_enet: drop the
 .adjust_link custom fs_ops
Message-ID: <20240904175043.0f198836@fedora.home>
In-Reply-To: <58cf7db3-4321-4bd9-a422-3642ce59f21f@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
	<20240829161531.610874-4-maxime.chevallier@bootlin.com>
	<480a16fd-a1eb-4ea0-b859-5d874ecc3b15@lunn.ch>
	<20240904102711.1accc8ce@fedora.home>
	<58cf7db3-4321-4bd9-a422-3642ce59f21f@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 4 Sep 2024 14:36:58 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Sep 04, 2024 at 10:27:11AM +0200, Maxime Chevallier wrote:
> > Hi Andrew,
> > 
> > On Fri, 30 Aug 2024 23:06:08 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > > > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > > > @@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
> > > >  	unsigned long flags;
> > > >  
> > > >  	spin_lock_irqsave(&fep->lock, flags);
> > > > -
> > > > -	if (fep->ops->adjust_link)
> > > > -		fep->ops->adjust_link(dev);
> > > > -	else
> > > > -		generic_adjust_link(dev);
> > > > -
> > > > +	generic_adjust_link(dev);
> > > >  	spin_unlock_irqrestore(&fep->lock, flags);    
> > > 
> > > Holding a spinlock is pretty unusual. We are in thread context, and
> > > the phydev mutex is held. Looking at generic_adjust_link, do any of
> > > the fep->foo variables actually need protecting, particularly from
> > > changes in interrupts context?  
> > 
> > Yes there are, the interrupt mask/event registers are being accessed
> > from the interrupt handler and the ->restart() hook. I can try to
> > rework this a bit for a cleaner interrupt handling, but I don't have
> > means to test this on all mac flavors (fec/fcc/scc) :(  
> 
> As far as i can see, none of the fep->old* members are accessed
> outside of fs_enet-main.c. There values are not important for the
> restart call. So the spinlock has nothing to do with adjust_link as
> such, but restart. So maybe narrow down the lock to just the restart
> call? But it is not a big issues, just unusual.

I agree with you on that, and this is actually what end-up happening in
the final phylink conversion patch (only the restart() call gets called
wthin the spinlock).

I'll however include a patch that does exactly what you suggest as part
of the phylink conversion, both to make the big port-to-phylink patch
smaller, but also to better document why we only need to care about the
restart() part, if that's ok :)

Thanks,

Maxime

