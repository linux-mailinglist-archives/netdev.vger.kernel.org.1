Return-Path: <netdev+bounces-156035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBCEA04B60
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A0216650F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DABA1E0E1A;
	Tue,  7 Jan 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyiD9dbF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F41D63EB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284148; cv=none; b=uxXZuVL5kVn72fd/R9A4TGrsnVk/fC2tZVFkZodauDLP5fn2EnpVQyWMbc/3AR9hTVInXZ94bxvV7P/B7mD+E5xyaMl5fPA2b0Qo6mdJ/tn7GzuQPEidFPod54EYVTBW5zmjtkGW+58EZsU5Z+IKhf8nhXMb8Nen0ihp8FN4cNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284148; c=relaxed/simple;
	bh=O9yeKU+aDLkbe5Y+st1eaESauyloNDhBO/f2RKbWUkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDpzhW/dGkXwVeAvb/HGxMoMY81ksyWq7a+7N77Z2NoHvIY6Y+EmJ9dMiQVfbo8sVlwb9W2+PDebfs8BR9G4SoPAlj7M3C1Gldg5h6gPICEf2k77QfNLY8YDwVCCsXp34gr0dnnDHNfRkvuZu8ZibFMP97VXXX72yz4eWRG9I44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyiD9dbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13C6C4CED6;
	Tue,  7 Jan 2025 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736284147;
	bh=O9yeKU+aDLkbe5Y+st1eaESauyloNDhBO/f2RKbWUkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JyiD9dbFavrqM/Md67vj87Pyy5Nq+Mn3HtZJF+Cnclr6PLxwx4h/jSjnhrOOkO58N
	 1/BVgd5fPUHoBJh4VfxKypUfgRbGVtbnByrF9P13Z6wKWT3gYaSXtUQOu5+0G0Vrri
	 eV3HOWFVyPJK9dzynjBHEGieK7kNE5hMv6UfdhX59lUuruUa11XF39ok424qNM0IiR
	 DZeMZEVAmdfj0jkNftyhJb3Ami3oO2TR3Hz4MwlohzkKuHC1duX42bOcXMkzpqU/z1
	 v+i23zGLZwBPHfxbqz48Tufwv1iC6/6EXnDX4NVRMNl0FOhRXQtrRZqKRHUWtK0NT/
	 MNrwxVnJQ8UOg==
Date: Tue, 7 Jan 2025 13:09:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/4] net: reduce RTNL pressure in
 unregister_netdevice()
Message-ID: <20250107130906.098fc8d6@kernel.org>
In-Reply-To: <CANn89i+dN11K7EushTwsT0tchEytceTWHqiB23KqrYvfauRjWg@mail.gmail.com>
References: <20250107173838.1130187-1-edumazet@google.com>
	<20250107121148.7054518d@kernel.org>
	<CANn89iJkxX1d-SKN6WVJST=5X7KqXdJ+OKcCVDEFCedJ7ArSig@mail.gmail.com>
	<CANn89i+dN11K7EushTwsT0tchEytceTWHqiB23KqrYvfauRjWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 21:46:41 +0100 Eric Dumazet wrote:
> > > I think we'll need:
> > >
> > > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > > index 939081a0e615..cdfa22453a55 100644
> > > --- a/net/devlink/port.c
> > > +++ b/net/devlink/port.c
> > > @@ -1311,6 +1311,7 @@ int devlink_port_netdevice_event(struct notifier_block *nb,
> > >                 __devlink_port_type_set(devlink_port, devlink_port->type,
> > >                                         netdev);
> > >                 break;
> > > +       case NETDEV_UNREGISTERING:  
> >
> > Not sure I follow ?

I was worried some code assumed devlink_port->netdev is safe to access
under rtnl_lock. But looking closer it's only used in trivial ways, so
you can ignore that.

> > >         case NETDEV_UNREGISTER:
> > >                 if (devlink_net(devlink) != dev_net(netdev))
> > >                         return NOTIFY_OK;
> > >
> > >
> > > There is no other way to speed things up? Use RT prio for the work?
> > > Maybe WRITE_ONCE() a special handler into backlog.poll, and schedule it?
> > >
> > > I'm not gonna stand in your way but in general re-taking caller locks
> > > in a callee is a bit ugly :(  
> >
> > We might restrict this stuff to cleanup_net() caller only, we know the
> > netns are disappearing and that no other thread can mess with them.  

Unless the interface has a peer in another netns. But that should be
fine, interface will be de-listed. I'm slightly more concerned that some
random code in the kernel assumes its stashed netdev pointer to be valid
under rtnl_lock, as long as it has not seen an NETDEV_UNREGISTER event.
I guess we'll find out..? :)

> ie something like:
> [...]

LGTM!

