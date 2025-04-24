Return-Path: <netdev+bounces-185763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190EA9BAF3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D044678FD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCF21E087;
	Thu, 24 Apr 2025 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYasCJ+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA319DF7D;
	Thu, 24 Apr 2025 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535162; cv=none; b=GL+3cXaquWM5Y0LB1v0mgINgzF4cCjjGgDoeWqNk0HJ7c1y3R1YF6cJR9v9PWco4Nk8w/H3dDgmqt7iuQ9qnf7ZngzjBfQp4lM1L8KVqGIKeI8L65WvR4JNNjfsaga898vFIcaoRFXHzN463XWa+WsQ/dLI9i32KFXIRZN0aXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535162; c=relaxed/simple;
	bh=vPcIZ8pDaO2fxwVC5G00kxdWjIdGTsiuQwohPKn5T0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVsZQV6bMbtvJ+IXTHIju4PHCCdsfDbyRr94wsj7DFppxRyXiuJNpeJt2bErV1NYemvz5uLHw7Gof43I5iTmutfZQ4iTXX2S41iuSjdsN8hAR8+AMVqqYf7v+hpPuQ+EMvArzyQ809RyKBB0qJkhwgLdU1q2u/1GKTCK2rGW3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYasCJ+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5211C4CEE3;
	Thu, 24 Apr 2025 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745535160;
	bh=vPcIZ8pDaO2fxwVC5G00kxdWjIdGTsiuQwohPKn5T0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EYasCJ+PCKWsJfy6QKCS+dED2eee1eSGBrM6XFnNE259pPlh18AJDP8PmN1suzJQQ
	 cH/grB+hHocnc8k+6xVMygiJ+X27thXwsQ25O+O9YSsSDOUpCj1QXmQFORXYlAcZt+
	 KcByJOBeC3WcI8zrYfr+IGT1+tjjWEXc1uteTduLxmiG40HnS17N046oN3r2/ltS+7
	 FL/k75eqNsXpmOhGT8IOdM8AzQAK7SmVbHWfHsycpJmKk9j+TXCQeONjrE3JmYzY/L
	 h0t8O9Mc1LIPwprxr8tA7o6dVSp6g+jdCQTENRnKq2RUZyU7D3udtg33XZXgthg0U7
	 2xxPaLfNpOp+A==
Date: Thu, 24 Apr 2025 15:52:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jeff Layton <jlayton@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim
 Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <20250424155238.7d0d2a29@kernel.org>
In-Reply-To: <4118dbd6-2b4b-42c3-9d1e-2b533fc92a66@lunn.ch>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
	<20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
	<20250423165323.270642e3@kernel.org>
	<a07cd1c64b16b074d8e1ec2e8c06d31f4f27d5e5.camel@kernel.org>
	<20250423173231.5c61af5b@kernel.org>
	<cdfc5c6f260ee1f81b8bb0402488bb97dd4351bb.camel@kernel.org>
	<4118dbd6-2b4b-42c3-9d1e-2b533fc92a66@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 14:10:03 +0200 Andrew Lunn wrote:
> > > > > How much naming the objects in a "user readable" fashion actually
> > > > > matter? It'd be less churn to create some kind of "object class"
> > > > > with a directory level named after what's already passed to
> > > > > ref_tracker_dir_init() and then id the objects by the pointer value 
> > > > > as sub-dirs of that?    
> > > > 
> > > > That sounds closer to what I had done originally. Andrew L. suggested
> > > > the flat directory that this version represents. I'm fine with whatever
> > > > hierarchy, but let's decide that before I respin again.  
> > > 
> > > Sorry about that :(
> > >   
> > 
> > No worries...but we do need to decide what this directory hierarchy
> > should look like.
> > 
> > Andrew's point earlier was that this is just debugfs, so a flat
> > "ref_tracker" directory full of files is fine. I tend to agree with
> > him; NAME_MAX is 255, so we have plenty of room to make uniquely-named
> > files.
> > 
> > We could build a dir hierarchy though. Something like:
> > 
> > - ref_tracker
> >     + netdev
> >     + netns  
> 
> How do you make that generic? How due the GPU users of reftracker fit
> in? And whatever the next users are? A flat directory keeps it
> simple. Anybody capable of actually using this has to have a level of
> intelligence sufficient for glob(3).
> 
> However, a varargs format function does make sense, since looking at
> the current users, many of them will need it.

No preference on my side about the hierarchy TBH. I just defaulted to
thinking about it in terms of a hierarchy class/id rather than class-id
but shouldn't matter.

The main point I was trying to make was about using a synthetic ID -
like the pointer value. For the netdevs this patchset waits until 
the very end of the registration process to add the debugfs dir
because (I'm guessing) the name isn't assigned when we alloc 
the device (and therefore when we call ref_tracker_dir_init()).

Using synthetic ID lets us register the debugfs from
ref_tracker_dir_init().

In fact using "registered name" can be misleading. In modern setups
where devices are renamed based on the system topology, after
registration.

The Ethernet interface on my laptop is called enp0s13f0u1u1,
not eth0. It is renamed by systemd right _after_ registration.

[45224.911324] r8152 2-1.1:1.0 eth0: v1.12.13
[45225.220032] r8152 2-1.1:1.0 enp0s13f0u1u1: renamed from eth0

so in (most?) modern systems the name we carefully printed
into the debugfs name will in fact not match the current device name.
What more we don't try to keep the IDs monotonically increasing. 
If I plug in another Ethernet card it will also be called eth0 when
it's registered, again. You can experiment by adding dummy devices:

# ip link add type dummy
# ip link
...
2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff

# ip link set dev dummy0 name other-name
[  206.747381][  T670] other-name: renamed from dummy0
# ip link
...
2: other-name: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff

# ip link add type dummy
# ip link
...
2: other-name: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b2:51:ee:5b:4b:83 brd ff:ff:ff:ff:ff:ff


The second device is called dummy0, again, because that name was
"free". So with the current code we delay the registration of debugfs
just to provide a name which is in fact misleading :S

But with all that said, I guess you still want the "meaningful" ID for
the netns, and that one is in fact stable :S

