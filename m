Return-Path: <netdev+bounces-238480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F2C596F6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C473B960E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D963587A3;
	Thu, 13 Nov 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Fx47icwP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mk0LHyer"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585528150F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057851; cv=none; b=O8Z1YCYhx0TaKSE7aXynMrh7pJDJULmZ5wpkSdCjr1Z/p6qo5AGswLeioZ5wfllVID+vxVFzzxqfH0JTtAqvmQkjBwGj2n/0QrXt92etHiLgE/b3RZY6AXbNnBI5LeKtcPiMA1d2NejyZnZg2vZNZy0mff01ZEkJoAcfJKGB5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057851; c=relaxed/simple;
	bh=A0NoIlVUmAL7gMLcBA4v0DgCh2ZRH4OMmaH7CnEyLiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SShYSgz/+gr8TAk0fEfV1jXdP5LzNSEMDQ1xjNc2VWavvKtcElNEfAZ/oC3Dwu6lCYALunVUvu1JnLf88i1T0tZbL0hBwvrHr2Te5Cly0lRljG1JKaOdu7PMFAKWqfK1tfUl1Royl5rp2xgV2KimOJcCU6+CUQp8FCifQYxYhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Fx47icwP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mk0LHyer; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EB2114001EA;
	Thu, 13 Nov 2025 13:17:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 13 Nov 2025 13:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1763057847; x=1763144247; bh=JzGNxqJy/xHIW8t1Z4QVykQPySvfe71+
	zRXYYiPnPiU=; b=Fx47icwPo7c6hXkuL6H77EQwptxNoUYdGr91lJPQ1eWwgvll
	1ikct4CxFJXVhKVxEICzZnVUxvXGM49ocu6FBl/DbGohMHPqJdn519rACjsb7MIz
	PVNCp+WY3zX7U+LmzA21SZHW+dTC7CGr0cvwIkK2g/yll0kqG5M6jOJrrir+jBYm
	JXvZ0YiH8vSI3ae6GgNbKuhiyvMKh6uYNUtg1PZmgAtLHaVhA4cZ/+CgzE8+3SCT
	08vMJ7eow2e3axqlRB1wIybGWvPWxMLhaNkmFK4X4CRTrEkY4lpY4EtBJ5WRSADX
	uYD4mOMhuX1O1UnB7VDTmMrislUq8UTI4P0fEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763057847; x=
	1763144247; bh=JzGNxqJy/xHIW8t1Z4QVykQPySvfe71+zRXYYiPnPiU=; b=m
	k0LHyerKnnEXsjld46FSJ2MEJINN9dzWF6XlBX9kArNzvRjNlOIWDEOq+cUi62XL
	Rjvw+SUnC+C61nDlZJJL+okxvwKUnQDSQqNC+oSQMvfudGjTAUCrC31czYifrs/L
	cfQo4K5qFX6UxJ1cJ6M0uloMyvK+sQXDP0apGqvMX3UuEZUUDUHlMaGHMEc8bqy5
	Y+A6+f3MSe2dLClquCzp34QyXPc20RcO5ImgQguoJ4BLosTyf1HIv68CkyFnq1MN
	tORIdVMkES0p0Fu/13P1qNK0F/v7p8eORynUlCDNJUMQv/FdnQWhKGROQy5lilnC
	ZRaMwgCm9wFPitJGLxPmw==
X-ME-Sender: <xms:tiAWaQxps9NfqSlo626iVFGnkrqruiS4LmU2w6-y3yCAqqOmrmqcQg>
    <xme:tiAWaX_DRYqkrjKms1b9i22-SlY4Ih0rWcrGrHzu2aZvX9umR-Pzc2EGR2icPFF9I
    7x45mhxUP9WjxWJQXvqFh7ZXQzhbIkEiXmq5j8lFKbrUGoJF6v691A>
X-ME-Received: <xmr:tiAWacKxLzHGCdXEjvzi6L3zHsO70jetMswR4L6GVB8T6sN-boUTTbLsvMNz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpeevuddvtdevheetkedvieeugeehieevjeekteefgfeffeefjefgvdef
    tdelueefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhl
    rdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhmihgvthhu
    sheljeeshigrhhhoohdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tiAWaVdryMlyeLaly55ATzjxYF5y_AI0e_vOr1knH3IMbInTjOqxGg>
    <xmx:tiAWaT-tb8eTfKbwV1LA5XNeThOAEYrL4F0UzT1EsUqZaLv-opiE2Q>
    <xmx:tiAWaap8dye4DniTniwnFYiXHOZai0a8zdKQTM7YrvZJTepIYFvsPw>
    <xmx:tiAWaQBHoY7Aj7bG6k0JjTfZapNHfzcpnLpVkVBusBxI0GCbaEAMaA>
    <xmx:tyAWaZ3e4QhMefHVjhh06bT_KpIXuUGFEH-ZRaMHWM0EqcB-mvLGLP8X>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 13:17:26 -0500 (EST)
Date: Thu, 13 Nov 2025 19:17:24 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Marek Mietus <mmietus97@yahoo.com>, pabeni@redhat.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst
 entry
Message-ID: <aRYgtN-nToS4MQ3r@krikkit>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
 <20251112072720.5076-3-mmietus97@yahoo.com>
 <aRS_SEUbglrR_MeX@krikkit>
 <5af3e1bd-6b20-432b-8223-9302a8f9fe44@yahoo.com>
 <CANn89i+qce6WJYUpjH93SMRKA8cQ6Wt-b81O6gu9V5GGnDeo_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+qce6WJYUpjH93SMRKA8cQ6Wt-b81O6gu9V5GGnDeo_A@mail.gmail.com>

Eric, it seems your email didn't make it to netdev, quoting:

2025-11-13, 02:38:02 -0800, Eric Dumazet wrote:
> On Thu, Nov 13, 2025 at 1:37 AM Marek Mietus <mmietus97@yahoo.com> wrote:
> 
> > W dniu 11/12/25 o 18:09, Sabrina Dubroca pisze:
> > > 2025-11-12, 08:27:08 +0100, Marek Mietus wrote:
> > >> Use the newly introduced dstref object for storing the dst entry
> > >> in skb instead of using _skb_refdst, and remove code related
> > >> to _skb_refdst.
> > >
> > > This is an important change to a very core part of networking. You
> > > need to CC all the networking maintainers/reviewers for this series
> > > (ask scripts/get_maintainer.pl).
> >
> > Noted for next time.
> >
> > >
> > >> This is mostly a cosmetic improvement. It improves readability
> > >
> > > That rename, and the rest of the changes in this series. is causing
> > > some non-negligible churn and will take a while to review, to ensure
> > > all the conversions are correct.
> > >
> > > @Maintainers can I get some time to look at this in detail?
> > >
> >
> > I figured it would require a thorough review.
> > Thank you for taking the time to look at it!
> >
> > >
> > > Also, I'm not sure how we ended up from the previous proposal ("some
> > > tunnels are under RCU so they don't need a reference" [1]) to this.
> > >
> > > [1]
> > https://lore.kernel.org/netdev/20250922110622.10368-1-mmietus97@yahoo.com/
> > >
> >
> > As previously discussed with Jakub [2], tunnels that use
> > udp_tunnel_dst_lookup
> > add notable complexity because the returned dst could either be from
> > ip_route_output_key (referenced) or from the dst_cache (which I'm changing
> > to
> > be noref). There are also other tunnels that follow a similar pattern.

But IMO Jakub's comment about technical debt is not addressed by
pushing dstref all over the tunnel code.


> > The cleanest way to keep track of which dst is referenced and which isn't
> > is to borrow existing refdst concepts. This allows us to more easily track
> > the ref state of dst_entries in later flows to avoid unnecessarily taking
> > a reference. I played around with a couple implementations and this turned
> > out to be the most elegant. It's a big change, but it's mostly semantic.
> >
> > [2] https://lore.kernel.org/netdev/20250923184856.6cce6530@kernel.org/
> 
> 
> I have not seen the series, so I had to go to the archives.
> 
> Too much code churn for my taste, and a true nightmare for future backports
> to stable kernels.
> 
> Unless I am mistaken, this is your first submission to the linux kernel,
> please start with more manageable patches.

-- 
Sabrina

