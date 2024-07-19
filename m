Return-Path: <netdev+bounces-112158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69809372CA
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 05:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8836C281C28
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 03:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C532111AD;
	Fri, 19 Jul 2024 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vWO7986s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DF21373
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359928; cv=none; b=iP1zrFE7F9R0MN4WxwxDLrSMJWanADKIFsZ0kzol2ZRvvaEjCV16yJOMM416JMqNn5QE3Iz8QdE5tlz4MBI6bkPd5wgpm+cfb9IjYwaN7Rsu+c0/dbxf1y3QmFOMYjwGS8pm3wG0tPcSlY+Re25FBa0rWo0lOfVj9jTTo95bceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359928; c=relaxed/simple;
	bh=FQfbys6Wn7Oh3yRT6yf7mH+BdvQyTdS8NUkZ5KVSG0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRpuFslG8mvG0lVE20LmfN/5rRQrjRaW1sqdqFLrLqUA5J3Tsma0nXS33+jAmDZtFOVz4o41qLZCM1fxKAzdhQhHhAtSXtBXZ+VLUMzeeBa0WrE2RpqJgMnGzUnHnVSebhKCI0y8Nl/ZmzC51GJb2U3vUkHP09aRyab2AMJ2K7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vWO7986s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yqChc2ei8UxPLr3pnvLe/G+BMs1epH7V7Y8G8+1U204=; b=vWO7986sKKrh9lIURms/1Kg2nK
	+BcD3jYIYBNKBCWTWOeEQppEj2m3/CbvgI+K2ip5eV/zs5p6xObMfzg6U6pgoZt7xwlGmau3RxSmo
	kjMwPx+ouM5woQE5dMV/jgNG8Ty+ZomG1ZhIRMsMLkblgz175VtCRODT1JdZlaBr4ivo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUeLb-002oai-08; Fri, 19 Jul 2024 05:31:55 +0200
Date: Fri, 19 Jul 2024 05:31:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	kuba@kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
Message-ID: <ea6e8939-5dc2-4322-a67f-207a6aa65da9@lunn.ch>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net>
 <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
 <69bab34d-2bf2-48b8-94f7-748ed71c07d3@lunn.ch>
 <4c26fc98-1748-4344-bb1c-11d8d47cc3eb@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c26fc98-1748-4344-bb1c-11d8d47cc3eb@openvpn.net>

On Thu, Jul 18, 2024 at 09:46:00AM +0200, Antonio Quartulli wrote:
> On 18/07/2024 04:01, Andrew Lunn wrote:
> > > > > +		if (ovpn_is_keepalive(skb)) {
> > > > > +			netdev_dbg(peer->ovpn->dev,
> > > > > +				   "ping received from peer %u\n", peer->id);
> > > > 
> > > > That should probably be _ratelimited, but it seems we don't have
> > > > _ratelimited variants for the netdev_* helpers.
> > > 
> > > Right.
> > > I have used the net_*_ratelimited() variants when needed.
> > > Too bad we don't have those.
> > 
> > If you think netdev_dbg_ratelimited() would be useful, i don't see why
> > you cannot add it.
> > 
> > I just did an search and found something interesting in the history:
> > 
> > https://lore.kernel.org/all/20190809002941.15341-1-liuhangbin@gmail.com/T/#u
> > 
> > Maybe limit it to netdev_dbg_ratelimited() to avoid the potential
> > abuse DaveM was worried about.
> 
> I see what Dave says however...
> 
> ...along the packet processing routine there are several messages (some are
> err or warn or info) which require ratelimiting.
> Otherwise you end up with a gazilion log entries in case of a long lasting
> issue.
> 
> Right now I am using net_dbg/warn/err/info_ratelimited(), therefore not
> having a netdev counterpart is not really helping with Dave's argument.

Yes, i think Dave' argument is weak because these alternatives
exist. Maybe they did not at the time? 

I suspect he was using it as a way to force fixing the real issue. A
driver should not be issues lots of err or info messages. Protocol
errors are part of normal behaviour, just increment a counter and keep
going. Peer devices disappearing is normal behaviour, count it and
keep going. _err is generally reserved for something fatal happened,
and there is no recovery, other than unload the kernel module and
reload it.

	Andrew

