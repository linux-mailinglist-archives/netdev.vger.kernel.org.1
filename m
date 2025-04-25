Return-Path: <netdev+bounces-185985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92844A9C92E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A34C8453
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D2E24A06E;
	Fri, 25 Apr 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS0UMCWQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDA223DC3;
	Fri, 25 Apr 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585180; cv=none; b=MlcUmbMx4JzWj/g+P7YHhQS3SP29/3QfazafnSdPAlx6TOkzMYFLfbEnLAvi7YRXB0LmOwEBOlKydCaqdJq9SeSU2hX16U12si2uCYty3lhcwCx2wbKMd3yOzrVQlsLD1gfFzdT6IH/KCCClW5xeLsQMzKeh9cRfnyHKQM5OYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585180; c=relaxed/simple;
	bh=RyZzOhYNGchRN3ugr7fK0F/2/XaoG4Vzk96bQ8xPeeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bfyah54Kkic3dM6D4bGM9xGxWMs4KxUQ+lkt+a0pobhpSOTK5OdZ1lkA0qJ/X9f+g7Y2vvkb5zxioK0HKnKl6sAVkf+VXJ3ZbR66gPUCZTRIgL1cRI1QPNQ645UB0Hk49j7WEK3ecpGnITlbl8YIiYLtYwwBU9BdaE7/45ECni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS0UMCWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630AFC4CEE4;
	Fri, 25 Apr 2025 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745585179;
	bh=RyZzOhYNGchRN3ugr7fK0F/2/XaoG4Vzk96bQ8xPeeQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XS0UMCWQK0QkQK/d+i+sHrdlSBU7I6hgxvFgwNoS8kaW7X2e2BNLJFa7GatiXDGBE
	 R9IdtiTtmaNEc8q5CgW5rr5gRlslJoRfAIeiFIfMV7lEceBb/i3zpfIHOd8LDsAN8S
	 KJVx6fHKeZonYP6BIhFboAeyb0bIthXz6heLKJMH+4TMidyxJkHR+/C3FIBSkvbzrX
	 3ka09NeZ+3LiublSun31yxW0QVfJ79i9iQszXcbKG74PfcAwo1DyVzQmyqg81BM4wi
	 K/853y6FradARZ3rqKy/YjHvI001N0Ygtv3Ko/jodgNbeh1th/RHKJCWaVGBn00qxX
	 XPK0+z/YxjjbA==
Message-ID: <d6efca57733c141c6fdfa39b402d05db8badb8c6.camel@kernel.org>
Subject: Re: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
From: Jeff Layton <jlayton@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor
	 <nathan@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Fri, 25 Apr 2025 08:46:17 -0400
In-Reply-To: <20250424155238.7d0d2a29@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
		<20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
		<20250423165323.270642e3@kernel.org>
		<a07cd1c64b16b074d8e1ec2e8c06d31f4f27d5e5.camel@kernel.org>
		<20250423173231.5c61af5b@kernel.org>
		<cdfc5c6f260ee1f81b8bb0402488bb97dd4351bb.camel@kernel.org>
		<4118dbd6-2b4b-42c3-9d1e-2b533fc92a66@lunn.ch>
	 <20250424155238.7d0d2a29@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-24 at 15:52 -0700, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 14:10:03 +0200 Andrew Lunn wrote:
> > > > > > How much naming the objects in a "user readable" fashion actual=
ly
> > > > > > matter? It'd be less churn to create some kind of "object class=
"
> > > > > > with a directory level named after what's already passed to
> > > > > > ref_tracker_dir_init() and then id the objects by the pointer v=
alue=20
> > > > > > as sub-dirs of that?   =20
> > > > >=20
> > > > > That sounds closer to what I had done originally. Andrew L. sugge=
sted
> > > > > the flat directory that this version represents. I'm fine with wh=
atever
> > > > > hierarchy, but let's decide that before I respin again. =20
> > > >=20
> > > > Sorry about that :(
> > > >  =20
> > >=20
> > > No worries...but we do need to decide what this directory hierarchy
> > > should look like.
> > >=20
> > > Andrew's point earlier was that this is just debugfs, so a flat
> > > "ref_tracker" directory full of files is fine. I tend to agree with
> > > him; NAME_MAX is 255, so we have plenty of room to make uniquely-name=
d
> > > files.
> > >=20
> > > We could build a dir hierarchy though. Something like:
> > >=20
> > > - ref_tracker
> > >     + netdev
> > >     + netns =20
> >=20
> > How do you make that generic? How due the GPU users of reftracker fit
> > in? And whatever the next users are? A flat directory keeps it
> > simple. Anybody capable of actually using this has to have a level of
> > intelligence sufficient for glob(3).
> >=20
> > However, a varargs format function does make sense, since looking at
> > the current users, many of them will need it.
>=20
> No preference on my side about the hierarchy TBH. I just defaulted to
> thinking about it in terms of a hierarchy class/id rather than class-id
> but shouldn't matter.
>=20
> The main point I was trying to make was about using a synthetic ID -
> like the pointer value. For the netdevs this patchset waits until=20
> the very end of the registration process to add the debugfs dir
> because (I'm guessing) the name isn't assigned when we alloc=20
> the device (and therefore when we call ref_tracker_dir_init()).
>=20
> Using synthetic ID lets us register the debugfs from
> ref_tracker_dir_init().
>=20

Yes, exactly. dev->name doesn't get populated until later, so we have
to delay creating the debugfs file if we want the name to be
meaningful. Ditto for the netns and its inode number.

We certainly could move to "classname@%px" format. If we go that route,
I'd suggest that we convert the ref_tracker_dir.name field to a const
char * pointer, and have the ref_tracker_dir_init() callers pass in a
pointer to a static classname string. No need to keep copies in that
case. The i915 ref_trackers would need to be changed, but hopefully
that's not a problem.

With that change we could register the debugfs files in
ref_tracker_dir_init() instead of having an extra call. The caveat
there is that some of these objects get created very early (e.g.
init_net), before debugfs comes online, so we'll miss creating debugfs
files for those objects. Maybe that's no big deal.

> In fact using "registered name" can be misleading. In modern setups
> where devices are renamed based on the system topology, after
> registration.
>=20
> The Ethernet interface on my laptop is called enp0s13f0u1u1,
> not eth0. It is renamed by systemd right _after_ registration.
>=20
> [45224.911324] r8152 2-1.1:1.0 eth0: v1.12.13
> [45225.220032] r8152 2-1.1:1.0 enp0s13f0u1u1: renamed from eth0
>=20
> so in (most?) modern systems the name we carefully printed
> into the debugfs name will in fact not match the current device name.
> What more we don't try to keep the IDs monotonically increasing.=20
> If I plug in another Ethernet card it will also be called eth0 when
> it's registered, again. You can experiment by adding dummy devices:
>=20
> # ip link add type dummy
> # ip link
> ...
> 2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT =
group default qlen 1000
>     link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff
>=20
> # ip link set dev dummy0 name other-name
> [  206.747381][  T670] other-name: renamed from dummy0
> # ip link
> ...
> 2: other-name: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFA=
ULT group default qlen 1000
>     link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff
>=20
> # ip link add type dummy
> # ip link
> ...
> 2: other-name: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFA=
ULT group default qlen 1000
>     link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff
> 3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT =
group default qlen 1000
>     link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff
>=20
>=20
> The second device is called dummy0, again, because that name was
> "free". So with the current code we delay the registration of debugfs
> just to provide a name which is in fact misleading :S
>=20

Lovely.

> But with all that said, I guess you still want the "meaningful" ID for
> the netns, and that one is in fact stable :S

I would prefer that, but if that's not feasible then I can live without
meaningful names. We'd just have to determine some way to get the
address of a particular netns or netdev, which is an extra step when
debugging, but one we can do (e.g., with drgn).
--=20
Jeff Layton <jlayton@kernel.org>

