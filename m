Return-Path: <netdev+bounces-125056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1696BC86
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F59B2265F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1A1D1754;
	Wed,  4 Sep 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G4Z+/pMB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D551DFFB;
	Wed,  4 Sep 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453431; cv=none; b=aAMX6EXIrmcqY9isAbxg5dALkVGZGwKdiFK6Z3QH+N7xa02p6es63kqdWW7qcs7GGS867ZNaCiE/8sdw9YItYjeImg3bOXPJLmXNOL7DZ176qyqLy66oze7YztHky0TuT2jIE6wy+zOPIV7hhlycvqfDl4IRHvy5tjwg6OlQpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453431; c=relaxed/simple;
	bh=H/rr9sawkoXHKqSJLkOQ6cu2iuCgdX5jk7QvQPD+uBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnJzGV6pKq5HPjL52utWyUHoCQgAK888pwfSvD4SUQxTNXmRnuEUTnlQagiFe/hbqzhVjgH822CuSLs+znI8nq4KGinTbcozpBV9zq7nWwpOe/PmZ10/kCvjbfAjKcrAMzWcHsOFghSjWjOFzNcDPzgftdSZnOtYuCPDIzs5XKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G4Z+/pMB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QeHS5gYeBwIHKYodExNcm3Ca29cLrkM3gWUGPTXMyb8=; b=G4Z+/pMByzWepvK55PL6wa7XUD
	2+e/gb3tIQpEcc9KItRjA5l2RTcx+56kge/vEJBIVgK2JhQiH2Le4yJHkI2VV5hW4VRDo8hz5ni+1
	ChdCZwh7/IY32fgzuZhizTJKd6K8zf+ISozo5hZkP4rqginFvDV3Q7tMp2yvmz/2FBiA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slpFq-006YP3-49; Wed, 04 Sep 2024 14:36:58 +0200
Date: Wed, 4 Sep 2024 14:36:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 3/7] net: ethernet: fs_enet: drop the
 .adjust_link custom fs_ops
Message-ID: <58cf7db3-4321-4bd9-a422-3642ce59f21f@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-4-maxime.chevallier@bootlin.com>
 <480a16fd-a1eb-4ea0-b859-5d874ecc3b15@lunn.ch>
 <20240904102711.1accc8ce@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102711.1accc8ce@fedora.home>

On Wed, Sep 04, 2024 at 10:27:11AM +0200, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On Fri, 30 Aug 2024 23:06:08 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > > @@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
> > >  	unsigned long flags;
> > >  
> > >  	spin_lock_irqsave(&fep->lock, flags);
> > > -
> > > -	if (fep->ops->adjust_link)
> > > -		fep->ops->adjust_link(dev);
> > > -	else
> > > -		generic_adjust_link(dev);
> > > -
> > > +	generic_adjust_link(dev);
> > >  	spin_unlock_irqrestore(&fep->lock, flags);  
> > 
> > Holding a spinlock is pretty unusual. We are in thread context, and
> > the phydev mutex is held. Looking at generic_adjust_link, do any of
> > the fep->foo variables actually need protecting, particularly from
> > changes in interrupts context?
> 
> Yes there are, the interrupt mask/event registers are being accessed
> from the interrupt handler and the ->restart() hook. I can try to
> rework this a bit for a cleaner interrupt handling, but I don't have
> means to test this on all mac flavors (fec/fcc/scc) :(

As far as i can see, none of the fep->old* members are accessed
outside of fs_enet-main.c. There values are not important for the
restart call. So the spinlock has nothing to do with adjust_link as
such, but restart. So maybe narrow down the lock to just the restart
call? But it is not a big issues, just unusual.

	Andrew


