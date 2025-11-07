Return-Path: <netdev+bounces-236583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A494C3E1BE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 02:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5FDD34B9A0
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40702F619A;
	Fri,  7 Nov 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWMy1MxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947E258EC1;
	Fri,  7 Nov 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478315; cv=none; b=EUNRkGHxskTsrMbBDzcCvyfe4i3Fpb0AWMuUfUldo7J4y87/qgdYuTfN2hN8OIW6tjNjb2/CbEgVUvO0SYVfmjvYo53YesOEkV0UYsjksecPN4yziJ0pG4Drb31pxROzZs0boxIpofUorDyE+y34kJvW+wf2zU//34qkZwK8wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478315; c=relaxed/simple;
	bh=rtuRpvmIO025oKHiCTjuNzRE/bOZ6K9jegUDzon8gt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpoE84WovID8wCq1ODt7drNzM1L94LKqzH/XtV661FcAtGmWO8VkEHCl1ExeiAtaRSU99HJ8Uf9SbkrXAMe/XFIF9x13sY7g7HYgsKr8fOnqoDyw5ZYe6T8TJi1fl+b+zUND83JWvIohsEWtNLfThXKf5CAmYEodf4eD3adIlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWMy1MxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B595C4CEF7;
	Fri,  7 Nov 2025 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762478315;
	bh=rtuRpvmIO025oKHiCTjuNzRE/bOZ6K9jegUDzon8gt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AWMy1MxUfKg9pWpjvxXVtHPrW4xCrqSy3FtY6swJ49XLpR611ErvJao9xj2pwItkT
	 F3zIG8Cw4qNxjZCPP0GN/isyW6zznum3oaVgrsck+BZ1/8fKNFkvL1aP1h+HOxtF+4
	 E93SqY4NdR6aVLwBblNu+8snLfso96zUa/iFhbRLVs7Wi2d78frCsTc3iomDVEboo6
	 a3XOcbQlRfu3D3DwpGs5hF4PscV5BRBbMtD+VkIG7KxtLNotCcjVnJkYx7I0+llHVa
	 NfuApYPFk0EVj2rIiswbG/2kbwHh9mklhLqm7nX39HnJHSrfholo0GQWDhNmS8UFvA
	 GHBw76da08IOA==
Date: Thu, 6 Nov 2025 17:18:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemb@google.com>, ziweixiao@google.com, Vedant Mathur
 <vedantmathur@google.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <20251106171833.72fe18a9@kernel.org>
In-Reply-To: <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
References: <20251105200801.178381-1-almasrymina@google.com>
	<20251105200801.178381-2-almasrymina@google.com>
	<20251105171142.13095017@kernel.org>
	<CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
	<20251105182210.7630c19e@kernel.org>
	<CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
	<qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 17:25:43 +0000 Dragos Tatulea wrote:
> On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
> > On Wed, Nov 5, 2025 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote: =20
> > > Increasing cache sizes to the max seems very hacky at best.
> > > The underlying implementation uses genpool and doesn't even
> > > bother to do batching.
> >=20
> > OK, my bad. I tried to think through downsides of arbitrarily
> > increasing the ring size in a ZC scenario where the underlying memory
> > is pre-pinned and allocated anyway, and I couldn't think of any, but I
> > won't argue the point any further.
> >  =20
> I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
> size there are ~1% allocation errors during a simple zcrx test.
>=20
> mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
> that size (16K * 4K). Increasing the buffer doesn't help because the
> pool size is still what the driver asked for (+ also the
> internal pool limit). Even worse: eventually ENOSPC is returned to the
> application. But maybe this error has a different fix.

Hm, yes, did you trace it all the way to where it comes from?
page pool itself does not have any ENOSPC AFAICT. If the cache
is full we free the page back to the provider via .release_netmem

> Adapting the pool size to the io_uring buffer size works very well. The
> allocation errors are gone and performance is improved.
>=20
> AFAIU, a page_pool with underlying pre-allocated memory is not really a
> cache. So it is useful to be able to adapt to the capacity reserved by
> the application.
>=20
> Maybe one could argue that the zcrx example from liburing could also be
> improved. But one thing is sure: aligning the buffer size to the
> page_pool size calculated by the driver based on ring size and MTU
> is a hassle. If the application provides a large enough buffer, things
> should "just work".

Yes, there should be no ENOSPC. I think io_uring is more thorough
in handling the corner cases so what you're describing is more of=20
a concern..

Keep in mind that we expect multiple page pools from one provider.
We want the pages to flow back to the MP level so other PPs can grab
them.

> > > The latter. We usually have the opposite problem - drivers configure
> > > the cache way too large for any practical production needs and waste
> > > memory.
> >=20
> > Sounds good, does this sound like roughly what we're looking for here?
> > I'm thinking configuring pp->ring size could be simpler than
> > rx-buf-len because it's really all used by core, so maybe not
> > something we need to bubble all the way down to the driver, so
> > something like:
> >=20
> > - We add a new field, netdev_rx_queue[->mp_params?]->pp_ring_size.

My series was extending dev->cfg / dev->cfg_pending to also have
per-queue params. So the user config goes there, not in the queue
struct.

> > - We add a netlink api to configure the above.
> > - When a pp is being created, we check
> > netdev_rx_queue[->mp_params]->pp_ring_size, if it's set, then it
> > overrides the driver-provided value.
>=20
> And you would do the last item in page_pool_init() when mp_ops and
> pp_ring_size is set?

Yes.

> > Does that make sense? =20
> It does to me.=20
>=20
> I would add that for this case the page_pool limit should not apply at
> all anymore. Maybe you thought about this but I didn't see it mentioned.
>=20
> > I don't immediately see why the driver needs to
> > be told the pp_ring_size via the queue API, as it's really needed by
> > the pp anyway, no? Or am I missing something? =20
> It doesn't. The only corner case to take care of is when the pool_size
> is below what the driver asked for.

Hm, I can't think why driver would care. Of course if someone sets the
cache size to a tiny value and enables IOMMU=3Dstrict they shouldn't
expect great performance..

If a driver appears that has a min I think we can plumb thru the
checking later.=20

