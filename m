Return-Path: <netdev+bounces-243830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF9ECA84A7
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BDBB304E2C7
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89013337103;
	Fri,  5 Dec 2025 15:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3032AAC9;
	Fri,  5 Dec 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949258; cv=none; b=qH2sskZ1m0AIfXersLFHlFFDsmmGEijeGmGDpK82FAkFkUDFAr7SMb+DUi825iC+8AZ/CQZOue/WwpHZHTiA352gFbBh98qIrSLWatldVfIC49xIj/yA98fSZAJRJuCEgWKO4/gRr4z711bHIkHMr282Zuco9+QdzQVcs8lIJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949258; c=relaxed/simple;
	bh=Akqkzha9JkUbWA3fa2cCzxev5Dc4x2qdRvtoXwN5mcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jruEz9iOoWAak/Mm9Dfl90sywKx3QygDfNXfHEJIIxQ+LRsrswCMCxu40rj7mAUVBSsDgipHBZ9K5uEl89ginLNtVFGlRPa/okH8d6MGRaM1JfHOBArZaJ2QSgjV363uzMucqn8Qw8Pgbie3KcvDhBl32PASrZdZ2UoOB/mXAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vRXvD-0000000068C-3h7z;
	Fri, 05 Dec 2025 15:40:39 +0000
Date: Fri, 5 Dec 2025 15:40:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTL886vReHP74XPn@makrotopia.org>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
 <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>

On Fri, Dec 05, 2025 at 03:17:37PM +0000, Russell King (Oracle) wrote:
> On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> > On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > > remains set, preventing auto-negotiation from happening.
> > > > 
> > > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > > delayed_work emulating the asynchronous self-clearing behavior.
> > > 
> > > Maybe add some text why the complexity of delayed work is used, rather
> > > than just a msleep(10)?
> > > 
> > > Calling regmap_read_poll_timeout() to see if it clears itself could
> > > optimise this, and still be simpler.
> > 
> > Is the restart_an() operation allowed to sleep? Looking at other
> > drivers I only ever see that it sets a self-clearing AN RESTART bit,
> > never waiting for that bit to clear. Hence I wanted to immitate
> > that behavior by clearing the bit asynchronously. If that's not needed
> > and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
> > be much easier, of course.
> 
> Sleeping is permitted in this code path, but bear in mind that it
> will be called from ethtool ops, and thus the RTNL will be held,
> please keep sleep durations to a minimum.

In that sense 10ms (on top of the MDIO operation) is not that little.
Maybe it is worth to use delayed_work to clear the bit after all...

