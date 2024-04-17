Return-Path: <netdev+bounces-88603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E68A7DE9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5A1F22CA3
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF605839E3;
	Wed, 17 Apr 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbogXVAz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80408175B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341680; cv=none; b=okHzSR3tTwyMWSZxub58/6kwshBjOToKQOOV901FN+I2kllNbVPilJRZ/CGxH/qfB/8SgXD0ZpFz/QmI987YJy9bSrJ/dqWZCiR951e5tQQFCXYP7ddaEnU0fKTQzFZGHWU3ch5Pgmyha191zKTK5CeVOl1Vpn/osTPH1CM6eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341680; c=relaxed/simple;
	bh=B7XzM/gwXeM5hGmVFdPq++r0UO9h/qCQmb38qpTyGkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSRFh3XIT4GIpmkGMSESMeRIw5pwjNOotrp57sj6oXeX53IgeVHvmhJIZg2qRrG57AZXJdWA8cfJosWTboHbpY4THROeWnlenHm/r3U47msEJlpx7vopy5bAQ6W316k4nqWoUBdryDjRa17bFvR4JAy0tkZv8Gd38j8BlYG8bRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbogXVAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA12C4AF07;
	Wed, 17 Apr 2024 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713341680;
	bh=B7XzM/gwXeM5hGmVFdPq++r0UO9h/qCQmb38qpTyGkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbogXVAzJIhjfe51ZtEalg8knvQjRQNApV5vevPQADpRaJ3O/+jm2TEFFsXaU3gNb
	 m0p9AA48ogTBmYgbsjwfisEbepRAcBhs2HbK9jg5AOzSGvdJevC34iW5X+MuXlCiE8
	 TOQ9mZBpfMNQDoE9xN7d5AdMUUEX6bfE2X2Pl9U0jJw2xc3hvhZJrVjxlln9lO3Ydn
	 e7ycVm43Xt9F1n7MjXEWmXq4mJlxMTH0zMRbsUu3E4WMC5pMj73burkJ7yvqh/azZa
	 MhjH+SecBvBLRDjOXn3t+QqWLKPorYNB4e0VtbiD8Fi7chZmU++XDg7gDttJnuUoSN
	 DBBI6USgGYpVA==
Date: Wed, 17 Apr 2024 11:14:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <20240417081435.GD6832@unreal>
References: <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
 <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
 <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
 <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>

On Tue, Apr 16, 2024 at 07:46:06AM -0700, Alexander Duyck wrote:
> On Tue, Apr 16, 2024 at 7:05 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Alexander Duyck <alexander.duyck@gmail.com>
> > Date: Mon, 15 Apr 2024 11:03:13 -0700
> >
> > > On Mon, Apr 15, 2024 at 10:11 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >>
> > >> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
> > >>>>> The advantage of being a purpose built driver is that we aren't
> > >>>>> running on any architectures where the PAGE_SIZE > 4K. If it came to
> > >>>>
> > >>>> I am not sure if 'being a purpose built driver' argument is strong enough
> > >>>> here, at least the Kconfig does not seems to be suggesting it is a purpose
> > >>>> built driver, perhaps add a 'depend on' to suggest that?
> > >>>
> > >>> I'm not sure if you have been following the other threads. One of the
> > >>> general thoughts of pushback against this driver was that Meta is
> > >>> currently the only company that will have possession of this NIC. As
> > >>> such Meta will be deciding what systems it goes into and as a result
> > >>> of that we aren't likely to be running it on systems with 64K pages.
> > >>
> > >> Didn't take long for this argument to float to the surface..
> > >
> > > This wasn't my full argument. You truncated the part where I
> > > specifically called out that it is hard to justify us pushing a
> > > proprietary API that is only used by our driver.
> > >
> > >> We tried to write some rules with Paolo but haven't published them, yet.
> > >> Here is one that may be relevant:
> > >>
> > >>   3. External contributions
> > >>   -------------------------
> > >>
> > >>   Owners of drivers for private devices must not exhibit a stronger
> > >>   sense of ownership or push back on accepting code changes from
> > >>   members of the community. 3rd party contributions should be evaluated
> > >>   and eventually accepted, or challenged only on technical arguments
> > >>   based on the code itself. In particular, the argument that the owner
> > >>   is the only user and therefore knows best should not be used.
> > >>
> > >> Not exactly a contribution, but we predicted the "we know best"
> > >> tone of the argument :(
> > >
> > > The "we know best" is more of an "I know best" as someone who has
> > > worked with page pool and the page fragment API since well before it
> > > existed. My push back is based on the fact that we don't want to
> >
> > I still strongly believe Jesper-style arguments like "I've been working
> > with this for aeons", "I invented the Internet", "I was born 3 decades
> > before this API was introduced" are not valid arguments.
> 
> Sorry that is a bit of my frustration with Yunsheng coming through. He
> has another patch set that mostly just moves my code and made himself
> the maintainer. Admittedly I am a bit annoyed with that. Especially
> since the main drive seems to be to force everything to use that one
> approach and then optimize for his use case for vhost net over all
> others most likely at the expense of everything else.
> 
> It seems like it is the very thing we were complaining about in patch
> 0 with other drivers getting penalized at the cost of optimizing for
> one specific driver.
> 
> > > allocate fragments, we want to allocate pages and fragment them
> > > ourselves after the fact. As such it doesn't make much sense to add an
> > > API that will have us trying to use the page fragment API which holds
> > > onto the page when the expectation is that we will take the whole
> > > thing and just fragment it ourselves.
> >
> > [...]
> >
> > Re "this HW works only on x86, why bother" -- I still believe there
> > shouldn't be any hardcodes in any driver based on the fact that the HW
> > is deployed only on particular systems. Page sizes, Endianness,
> > 32/64-bit... It's not difficult to make a driver look like it's
> > universal and could work anywhere, really.
> 
> It isn't that this only works on x86. It is that we can only test it
> on x86. The biggest issue right now is that I wouldn't have any
> systems w/ 64K pages that I could test on.

Didn't you write that you will provide QEMU emulation for this device?

Thanks

