Return-Path: <netdev+bounces-205439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5AAFEAF3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CAC5601F2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777942E719C;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItPSvXtX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58F2E6D24;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=VHoAZL1VYgezwc5QztwUjrf1WNpdYUUYCKkgOFKDIGMpWnaAR4ZdMWLrgv+5O2zFWKYNKXxFlWBU21YKlEFlqArbYAKOBghyXuUuLSX1z3qxVQimEkH0py4X0f7ZRFc6KpetsaWTj32ZzSnAnM5lNjZCVhnc39WBol2FB0LxcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=mvj3Xvnz1Kow45xw72lXduZ8jwlthbe4eeg2CtKY50Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6CmXdxkbkPZkzXDzbvQFabN4DkL2ylHKv6pXdu2Spt18A23yqXCdqMEZZAcIaYZXfKPQtde4qQr5FvEfvyNI1fRNNNgKdvpZ1vB7bOyVu+ifrfi3eVJ7VN05007OeUZsKRyS1rbK/93Ge6TeUEpHKwC44Yg2ynO9VzOxvv+QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItPSvXtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B5C4CEEF;
	Wed,  9 Jul 2025 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069142;
	bh=mvj3Xvnz1Kow45xw72lXduZ8jwlthbe4eeg2CtKY50Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItPSvXtXomr5nuIXONW1K7s1DOERi206FPwuxMjSY331PBgqRd5J5GQwILUq3F4pm
	 iNLK/ccnYYE12i84M3ID4PZrjFBOY09l53hnGyQi6uB50vVZcyAqH6UJzby3z7nXNt
	 g5vqe8WS4waXqsmwuuNCSsJ2SZ2CrNXtj6vvEHv+WB5M3vPwLDlJye1IxV8lUdWI23
	 BgbdhmgpPyQxVUnH6X7SmyoC108zSXw0/vMfdg5QCvMOI34z4wjV1VaWu7/MsMszp6
	 jLPlnwlJidz2AQX4xbzKhsZg2rJo+JZ7atP7OYocgjgJ8n8PYhDVAlPrVYDZoS5S/K
	 SlidjF+ejyn+w==
Date: Wed, 9 Jul 2025 14:52:16 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [RFC] comparing the propesed implementation for standalone PCS
 drivers
Message-ID: <20250709135216.GA721198@horms.kernel.org>
References: <aEwfME3dYisQtdCj@pidgin.makrotopia.org>
 <24c4dfe9-ae3a-4126-b4ec-baac7754a669@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c4dfe9-ae3a-4126-b4ec-baac7754a669@linux.dev>

On Fri, Jun 13, 2025 at 12:06:23PM -0400, Sean Anderson wrote:
> On 6/13/25 08:55, Daniel Golle wrote:
> > Hi netdev folks,
> > 
> > there are currently 2 competing implementations for the groundworks to
> > support standalone PCS drivers.
> > 
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=970582&state=%2A&archive=both
> > 
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=961784&state=%2A&archive=both
> > 
> > They both kinda stalled due to a lack of feedback in the past 2 months
> > since they have been published.
> > 
> > Merging the 2 implementation is not a viable option due to rather large
> > architecture differences:
> > 
> > 				| Sean			| Ansuel
> > --------------------------------+-----------------------+-----------------------
> > Architecture			| Standalone subsystem	| Built into phylink
> > Need OPs wrapped		| Yes			| No
> > resource lifecycle		| New subsystem		| phylink
> > Supports hot remove		| Yes			| Yes
> > Supports hot add		| Yes (*)		| Yes
> > provides generic select_pcs	| No			| Yes
> > support for #pcs-cell-cells	| No			| Yes
> > allows migrating legacy drivers	| Yes			| Yes
> > comes with tested migrations	| Yes			| No
> > 
> > (*) requires MAC driver to also unload and subsequent re-probe for link
> > to work again
> > 
> > Obviously both architectures have pros and cons, here an incomplete and
> > certainly biased list (please help completing it and discussing all
> > details):
> > 
> > Standalone Subsystem (Sean)
> > 
> > pros
> > ====
> >  * phylink code (mostly) untouched
> >  * doesn't burden systems which don't use dedicated PCS drivers
> >  * series provides tested migrations for all Ethernet drivers currently
> >    using dedicated PCS drivers
> > 
> > cons
> > ====
> >  * needs wrapper for each PCS OP
> >  * more complex resource management (malloc/free) 
> >  * hot add and PCS showing up late (eg. due to deferred probe) are
> >    problematic
> >  * phylink is anyway the only user of that new subsystem
> 
> I mean, if you want I can move the whole thing to live in phylink.c, but
> that just enlarges the kernel if PCSs are not being used. The reverse
> criticism can be made for Ansuel's series: most phylink users do not
> have "dynamic" PCSs but the code is imtimately integrated with phylink
> anyway.

At the risk of stating the obvious it seems to me that a key decision
that needs to be made is weather a new subsystem is the correct direction.

If I understand things correctly it seems that not creating a new subsystem
is likely to lead to a simpler implementation, at least in the near term.
While doing so lends itself towards greater flexibility in terms of users,
I'd suggest a cleaner abstraction layer, and possibly a smaller footprint
(I assume space consumed by unused code) for cases where PCS is not used.

On the last point, I do wonder if there are other approaches to managing
the footprint. And if so, that may tip the balance towards a new subsystem.


Another way of framing this is: Say, hypothetically, Sean was to move his
implementation into phylink.c. Then we might be able to have a clearer
discussion of the merits of each implementation. Possibly driving towards
common ground. But it seems hard to do so if we're unsure if there should
be a new subsystem or not.

> > phylink-managed standalone PCS drivers (Ansuel)
> > 
> > pros
> > ====
> >  * trivial resource management
> 
> Actually, I would say the resource management is much more complex and
> difficult to follow due to being spread out over many different
> functions.
> 
> >  * no wrappers needed
> >  * full support for hot-add and deferred probe
> >  * avoids code duplication by providing generic select_pcs
> >    implementation
> >  * supports devices which provide more than one PCS port per device
> >    ('#pcs-cell-cells')
> > 
> > cons
> > ====
> >  * inclusion in phylink means more (dead) code on platforms not using
> >    dedicated PCS
> >  * series does not provide migrations for existing drivers
> >    (but that can be done after)
> >  * probably a bit harder to review as one needs to know phylink very well
> > 
> > 
> > It would be great if more people can take a look and help deciding the
> > general direction to go.
> 
> I also encourage netdev maintainers to have a look; Russell does not
> seem to have the time to review either system.
> 
> > There are many drivers awaiting merge which require such
> > infrastructure (most are fine with either of the two), some for more
> > than a year by now.
> 
> This is the major thing. PCS drivers should have been supported from the
> start of phylink, and the longer there is no solution the more legacy
> code there is to migrate.

This seems to be something we can all agree on :)

