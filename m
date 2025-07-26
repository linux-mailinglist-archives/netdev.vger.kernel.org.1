Return-Path: <netdev+bounces-210295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6EB12B1B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB21C24E65
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB01D5CFE;
	Sat, 26 Jul 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1f4IvM9z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8419191499;
	Sat, 26 Jul 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753543976; cv=none; b=cyIFonCm5UbuLLKnL55x1Mgb7fw3pqHZGwni6XVdtJwMXL05mIP5KdYLNhZ+Q70ikRrT7oGIH2MV4QYGFv78N3tM8EV3KQOiSl1EDj8AMyc3po2Y9uUZ9rVCQPi9D6ZI1o54VJQtuL85jVFfJaoQar9HEMJ2bEFQfi+An89BkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753543976; c=relaxed/simple;
	bh=F4pSiM8sif6t2g8qvFAAosnygaFmnkUokHCeD5NcvxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjvb1ZiewQkjlE8CMFE+xJUk9Ocq+sf3DpovPalplpMvE57BzKcj1AbczZiVBbdvVUB3ikp4Yqmtkkw6noZBg5wDXIal5Q8XsK6fOhocm8NeE7Yg+rXvOg3lkE6tMRc76AUTDBU614g2IpemFv7BWshP+DXwXv2jCccQEZpSRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1f4IvM9z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aLkEy3g4vj/r0mSrOYBmhqyQ0HVZqYbFyEiyTsWXF0M=; b=1f
	4IvM9z2FrMXVnZn3sV3uVmmt0iV6nrn3fGF6l7Getl1E3rz9C9qFvRjqDdyqIduqk4k5szDySeKUy
	ovM3WWz4lImsJEuAhT/wRwdnI1p4rYmQIiE5IPfaueYpRK+CwpZbv/Qd8zUc5r+JPrDiztKX+uEVy
	/MUHCq911FfAfCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufgt9-002wyp-9z; Sat, 26 Jul 2025 17:32:43 +0200
Date: Sat, 26 Jul 2025 17:32:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	nicolas.ferre@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
Message-ID: <aaf014b1-d0c0-491e-99fb-9d1eb5abafb3@lunn.ch>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
 <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>

> > +	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
> 
> To simplify the error path you can use something like:
> 
>         struct queue_enst_configs *enst_queue __free(kfree) = kcalloc(...);
> 
> and drop the "goto cleanup" below.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

1.6.5. Using device-managed and cleanup.h constructs

Netdev remains skeptical about promises of all “auto-cleanup” APIs,
including even devm_ helpers, historically. They are not the preferred
style of implementation, merely an acceptable one.

Use of guard() is discouraged within any function longer than 20
lines, scoped_guard() is considered more readable. Using normal
lock/unlock is still (weakly) preferred.

Low level cleanup constructs (such as __free()) can be used when
building APIs and helpers, especially scoped iterators. However,
direct use of __free() within networking core and drivers is
discouraged. Similar guidance applies to declaring variables
mid-function.

> 
> You can use guard(spinlock_irqsave)(&bp->lock) or
> scoped_guard(spinlock_irqsave, &bp->lock)

scoped_guard() if anything.

> 
> > +
> > +	/* Disable ENST queues if running before configuring */
> > +	if (gem_readl(bp, ENST_CONTROL))
> 
> Is this read necessary?
> 
> > +		gem_writel(bp, ENST_CONTROL,
> > +			   GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET);
> 
> This could be replaced by GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you
> define GEM_ENST_DISABLE_QUEUE_SIZE along with GEM_ENST_DISABLE_QUEUE_OFFSET.
> 
> > +
> > +	for (i = 0; i < conf->num_entries; i++) {
> > +		queue = &bp->queues[enst_queue[i].queue_id];
> > +		/* Configure queue timing registers */
> > +		queue_writel(queue, ENST_START_TIME, enst_queue[i].start_time_mask);
> > +		queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
> > +		queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
> > +	}
> > +
> > +	/* Enable ENST for all configured queues in one write */
> > +	gem_writel(bp, ENST_CONTROL, configured_queues);
> 
> Can this function be executed while other queues are configured? If so,
> would the configured_queues contains it (as well as conf)?
> 
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	netdev_info(ndev, "TAPRIO configuration completed successfully: %lu entries, %d queues configured\n",
> > +		    conf->num_entries, hweight32(configured_queues));

guard() would put that netdev_info() print inside the guard. Do you
really want to be doing a print, inside a spinlock, with interrupts
potentially disabled? This is one of the reasons i don't like this
magical guard() construct, it is easy to forget how the magic works
and end up with sub optimal code. A scoped_guard() would avoid this
issue. You have to think about where you want to lock released in
order to place the } .

	Andrew

