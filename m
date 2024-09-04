Return-Path: <netdev+bounces-125013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064B96B954
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EA81C24FF2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D031D015D;
	Wed,  4 Sep 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AjO+zJcz"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29D1CF280;
	Wed,  4 Sep 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447214; cv=none; b=kRfmvcawTgIV2u0H/lzMhk5cSu+I+1EHSyPk93vPgngVeCqFbaDPqVzplA4hFe/WZZ6Jy6KnfJBv3dLfSrQaYjYPMaFWnG/0QCj6ZmvgBuIaJs5KaUJK8oDWTrszcUL07WRitfatoIsZX5GtIVYPtANj5TlIXvyMeJWdoBCG4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447214; c=relaxed/simple;
	bh=IAvCk1yjCPWRHhJhJZGE3McWze1Xp4mYQh62iJBq51I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxLUr67GnHaY9s64bapNMdvk5HhaCQmYieh8bCHRoQtyImK+M8Omj7XFCjMb++dfmt/qH1FDS4x+K1LU0DvluTAS38NTjkcpYfATr6JMFFo4DegPn8zj2DDfGT3KwLCj5SLIAQGRphQmSDsNihoTjZLpjo23Zl3VUNBhMSH6OgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AjO+zJcz; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C278EC37F8;
	Wed,  4 Sep 2024 10:49:59 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 805841BF206;
	Wed,  4 Sep 2024 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725446992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlQwp//l7+YMqCwEc62IbsKJVaVaIN0kbujxzcaSERM=;
	b=AjO+zJczyrIU9K82FhJ8IfAofM+yJtFx1/tB0Usq8CuxFJmN/lqMvG7f4uaUqRzzKIg32Y
	072cQqb2AYT+TcGFLby8CWj4hKXnCXptPUgIIXJ1a8KYaP8UNSiIFSV52DXfCMuy7V8Jbd
	67ZvV/uH0AlmbJ81czvB2WNIuDTpqwhNrOm2OUUojHecup2yvlEtUGdmNT6GUyJd3JihgY
	GjBlIAQUEwsCJoElvHxaqzCoGfd5HvX/ZgCtb3r5sM9HKrd/Y1q+k3RXuoL3bUPtv+xFt6
	RCfqul/llDwO58QjXYaEAQJF0+rROiGIUJskuUOfy9c8UGZN1Z7qFCCkeJHrCA==
Date: Wed, 4 Sep 2024 12:49:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 7/7] net: ethernet: fs_enet: phylink
 conversion
Message-ID: <20240904124949.563f1343@fedora.home>
In-Reply-To: <20240902185543.48d91e87@kernel.org>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
	<20240829161531.610874-8-maxime.chevallier@bootlin.com>
	<20240902185543.48d91e87@kernel.org>
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

Hi Jakub,

On Mon, 2 Sep 2024 18:55:43 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 29 Aug 2024 18:15:30 +0200 Maxime Chevallier wrote:
> > @@ -582,15 +591,12 @@ static void fs_timeout_work(struct work_struct *work)
> >  
> >  	dev->stats.tx_errors++;
> >  
> > -	spin_lock_irqsave(&fep->lock, flags);
> > -
> > -	if (dev->flags & IFF_UP) {
> > -		phy_stop(dev->phydev);
> > -		(*fep->ops->stop)(dev);
> > -		(*fep->ops->restart)(dev);
> > -	}
> > +	rtnl_lock();  
> 
> so we take rtnl_lock here..
> 
> > +	phylink_stop(fep->phylink);
> > +	phylink_start(fep->phylink);
> > +	rtnl_unlock();
> >  
> > -	phy_start(dev->phydev);
> > +	spin_lock_irqsave(&fep->lock, flags);
> >  	wake = fep->tx_free >= MAX_SKB_FRAGS &&
> >  	       !(CBDR_SC(fep->cur_tx) & BD_ENET_TX_READY);
> >  	spin_unlock_irqrestore(&fep->lock, flags);  
> 
> > @@ -717,19 +686,18 @@ static int fs_enet_close(struct net_device *dev)
> >  	unsigned long flags;
> >  
> >  	netif_stop_queue(dev);
> > -	netif_carrier_off(dev);
> >  	napi_disable(&fep->napi);
> >  	cancel_work_sync(&fep->timeout_work);  
> 
> ..and cancel_work_sync() under rtnl_lock here?
> 
> IDK if removing the the "dev->flags & IFF_UP" check counts as
> meaningfully making it worse, but we're going in the wrong direction.
> The _sync() has to go, and the timeout work needs to check if device
> has been closed under rtnl_lock ?

Arg that's true, I didn't consider that call path at all... Sorry about
that, I'll indeed rework that to address this deadlock waiting to
happen.

Thanks,

Maxime

