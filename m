Return-Path: <netdev+bounces-100234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86868D846D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159BA1C20920
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14512D767;
	Mon,  3 Jun 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epL/ApU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77791E4A2;
	Mon,  3 Jun 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422837; cv=none; b=jDH3+o51WRS0q+NwgtH/9igK7pOItm4uY9PIkdhpdq4Nt0LRdUQDkI3G1RAHbPeTsImALlZ1KVl41HBHHx8sSb+H2j0kpfuVtOKv1s/0zdyTCCJz0T9Y31zbk01Xr8CUK16cD1/sXGvkgF9luyhlisRJsQmLq42VpHzrFl/I+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422837; c=relaxed/simple;
	bh=67N6myEhz31OreafUCQyi9SAqb0lxOP/O//o8ECIsi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqO/JMxXG0teg5evaD9gc0FO5dE1/r27ThQlOBBN89u8K0M4yYExhMD4zukhy1Jej9fHA0T/rLxEgSSK+xEwuDzEwth0+KI48FYqAppQV65D9pWl0Oc3z+gtJgeqj5y13iG58YV5vADe6E0u9wj+7v1dSBKjdRob0vLMNs0c4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epL/ApU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5305CC2BD10;
	Mon,  3 Jun 2024 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422837;
	bh=67N6myEhz31OreafUCQyi9SAqb0lxOP/O//o8ECIsi4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=epL/ApU7gyuKSmcUfSaph/nh7OIzTDppO9H2bdra5I3PCEJ2CXD6p24p9yanbNntj
	 oVS5QApuYyEesM3PNcE9DaLxYAMmsG6HnlvkGN1KN7mKGtIjAF7HfeZrcR+dCju7tq
	 zb8J9puN3l/c/irehc9UBViUrzivZKd/5PNBd1BaE8ItQesELlNGvU+Jw9rGa+aWVP
	 eZydsFnJcds18b4oN7M+6WjwoizEjEdhsEGlGK2Nh70FedUOWl1yqd4AEs7ix8YGio
	 GaNHcnWwT79aJuEowgKKVDejAjPKXdNWHIOR5ypHALKuR/m4Acw0tLy6+pQLmKpjpm
	 Tq28peyOwl5AA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB966CE3B76; Mon,  3 Jun 2024 06:53:56 -0700 (PDT)
Date: Mon, 3 Jun 2024 06:53:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Message-ID: <636f066d-3a32-462c-ae37-2e576fac8f2c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
 <875xuqiivg.fsf@toke.dk>
 <CANn89iJ5UzQGBMNvZJqknuTCn13Ov4pXp7Rr+pq0G+BkJ53g7Q@mail.gmail.com>
 <8734puies5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734puies5.fsf@toke.dk>

On Mon, Jun 03, 2024 at 10:58:18AM +0200, Toke Høiland-Jørgensen wrote:
> Eric Dumazet <edumazet@google.com> writes:
> 
> > On Mon, Jun 3, 2024 at 9:30 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >>
> >> Eric Dumazet <edumazet@google.com> writes:
> >>
> >> > On Wed, May 29, 2024 at 1:21 PM Petr Machata <petrm@nvidia.com> wrote:
> >> >>
> >> >> When calculating hashes for the purpose of multipath forwarding, both IPv4
> >> >> and IPv6 code currently fall back on flow_hash_from_keys(). That uses a
> >> >> randomly-generated seed. That's a fine choice by default, but unfortunately
> >> >> some deployments may need a tighter control over the seed used.
> >> >>
> >> >> In this patch, make the seed configurable by adding a new sysctl key,
> >> >> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is used
> >> >> specifically for multipath forwarding and not for the other concerns that
> >> >> flow_hash_from_keys() is used for, such as queue selection. Expose the knob
> >> >> as sysctl because other such settings, such as headers to hash, are also
> >> >> handled that way. Like those, the multipath hash seed is a per-netns
> >> >> variable.
> >> >>
> >> >> Despite being placed in the net.ipv4 namespace, the multipath seed sysctl
> >> >> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
> >> >> variables.
> >> >>
> >> > ...
> >> >
> >> >> +       rtnl_lock();
> >> >> +       old = rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipath_hash_seed,
> >> >> +                                      mphs);
> >> >> +       rtnl_unlock();
> >> >> +
> >> >
> >> > In case you keep RCU for the next version, please do not use rtnl_lock() here.
> >> >
> >> > A simple xchg() will work just fine.
> >> >
> >> > old = xchg((__force struct struct sysctl_fib_multipath_hash_seed
> >> > **)&net->ipv4.sysctl_fib_multipath_hash_seed,
> >> >                  mphs);
> >>
> >> We added a macro to do this kind of thing without triggering any of the
> >> RCU type linter warnings, in:
> >>
> >> 76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointer")
> >>
> >> So as an alternative to open-coding the cast, something like this could
> >> work - I guess it's mostly a matter of taste:
> >>
> >> old = unrcu_pointer(xchg(&net->ipv4.sysctl_fib_multipath_hash_seed, RCU_INITIALIZER(mphs)));
> >
> > Good to know, thanks.
> >
> > Not sure why __kernel qualifier has been put there.
> 
> Not sure either. Paul, care to enlighten us? :)

Because __kernel says "just plain kernel access".  Here are the options:

# define __kernel       __attribute__((address_space(0)))
# define __user         __attribute__((noderef, address_space(__user)))
# define __iomem        __attribute__((noderef, address_space(__iomem)))
# define __percpu       __attribute__((noderef, address_space(__percpu)))
# define __rcu          __attribute__((noderef, address_space(__rcu)))

So casting to __kernel removes the __rcu, thus avoiding the sparse
complaint.

							Thanx, Paul

