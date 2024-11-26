Return-Path: <netdev+bounces-147342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980CC9D9361
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E21655BB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A419340F;
	Tue, 26 Nov 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJfvSOZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236D14A85;
	Tue, 26 Nov 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610120; cv=none; b=PRa2LNNKjpwy+1tA3T2i03KmMKcVLLdl7v4+EMUBVi4uUUL0oDpGHm+mRaomDJ7pODQgPzaSQWOYiRN+p9XYQ2mc5vUHYzqYFqgiDvFOpk0kU0wJDbX62vTieWjXHYzEdpPHinK2uwUQuNIxWQRU8o4WvhwAgKmv1Ze/U0cTmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610120; c=relaxed/simple;
	bh=/4PLu2C6BQdanrECJ4n+b3N01GoWhjzw4LadXl0QVi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQCa2SKdLYVqAumLq3YTi2zg53Ysv4p/x0sBh3DVLKuqZUrzJDqR8A/qR3MuJh9+KUNhLTfAWhE4k4HjJgrl5z7rop7vCMr/zh0hvqCnWdO3TLazaAZvA7+HVvmF7i2fQycGGSWJ35g040vOQv+lcHn4mttXiNN225WzJe+tEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJfvSOZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD7C4CECF;
	Tue, 26 Nov 2024 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732610119;
	bh=/4PLu2C6BQdanrECJ4n+b3N01GoWhjzw4LadXl0QVi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJfvSOZYKlT1M/j4Q/WoPOK26ZJ0K4mNMSP7SaYhdnTZRfGRlYADf71G/SHWUz4Yj
	 ZxTb9BRzskjv/RB9MNm9S3Sm6h4SbaxwFIqsZttbSv3MJLr7cdTcxcx25RO02MVuzZ
	 QkCvAGsvHGruQRl6pQmbQmdrjOTQvibfS0zwmihiJYR/29hc3uJvsYgBbTntlTgoId
	 8IQPoMEC3RYV8vUYWpE9ugT7Vlc4+D6ckUNr63oA0M9E9/QaCAUZvYdVGwAP+ugi4p
	 ll82TOJG87AueRXs6QiEOY7d1j58xTkgbhCeUVfJGXzOilwFfjGBOBgQLpr0aI1rq8
	 TkNT/EuQ2lrWQ==
Date: Tue, 26 Nov 2024 10:35:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: herbert@gondor.apana.org.au, David Miller <davem@davemloft.net>,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241126083513.GL160612@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
 <20241125194340.GI160612@unreal>
 <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>

On Tue, Nov 26, 2024 at 09:09:03AM +0200, Ilia Lin wrote:
> On Mon, Nov 25, 2024 at 9:43 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Nov 25, 2024 at 11:26:14AM +0200, Ilia Lin wrote:
> > > On Sun, Nov 24, 2024 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > > > > In packet offload mode the raw packets will be sent to the NiC,
> > > > > and will not return to the Network Stack. In event of crossing
> > > > > the MTU size after the encapsulation, the NiC HW may not be
> > > > > able to fragment the final packet.
> > > >
> > > > Yes, HW doesn't know how to handle these packets.
> > > >
> > > > > Adding mandatory pre-encapsulation fragmentation for both
> > > > > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > > > > on the state.
> > > >
> > > > I was under impression is that xfrm_dev_offload_ok() is responsible to
> > > > prevent fragmentation.
> > > >
> https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410
> > >
> > > With my change we can both support inner fragmentation or prevent it,
> > > depending on the network device driver implementation.
> >
> > The thing is that fragmentation isn't desirable thing. Why didn't PMTU
> > take into account headers so we can rely on existing code and do not add
> > extra logic for packet offload?
> 
> I agree that PMTU is preferred option, but the packets may be routed from
> a host behind the VPN, which is unaware that it transmits into an IPsec
> tunnel,
> and therefore will not count on the extra headers.

My basic web search shows that PMTU works correctly for IPsec tunnels too.

Steffen, do we need special case for packet offload here? My preference is
to make sure that we will have as less possible special cases for packet
offload.

Thanks

> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks

