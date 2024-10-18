Return-Path: <netdev+bounces-136985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217829A3D93
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9A1C23D0F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A08F6B;
	Fri, 18 Oct 2024 11:52:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F722032A;
	Fri, 18 Oct 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252363; cv=none; b=hBhKXYej9BVrD3IZ5bb1b1z8NjUjLx+Kf/25NRDhkzv2SWKfHeNf3E+LQC6MvMy79HEfaf2RtK7YF4jFwYV63uD7P+KQYbRg3Izq5yHMAbVt/RaTfdG0eTlDA2E5aWKR722IRkHl3YMJ75G3FPJKkS85B5GA0hHL93W4A5tUQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252363; c=relaxed/simple;
	bh=gcH0UHUF9Kv6WheAovEgpDJvLUHETsVQejw7+67aEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2368RFab4LbmwYlevrnESi9MPtfa1/soAVlvUSpEvhVuex+WTlhP4sasWgMyzJt5+7I9OCzvOZOEbdf2sDbD719CIYwBuupjVh2pKbWGlXp0z6FbRMkmbJaD/4dBTjrihNwBNqOSN5pCaOz249i3zumQ4c+W/1KZpR60CleSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1lWx-0007bU-Eo; Fri, 18 Oct 2024 13:52:31 +0200
Date: Fri, 18 Oct 2024 13:52:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 09/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6mr_rtm_getroute()
Message-ID: <20241018115231.GB28324@breakpoint.cc>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-10-stefan.wiehler@nokia.com>
 <20241017181446.GC25857@breakpoint.cc>
 <a7f1f376-3f0e-4455-816e-ae7b4051d501@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f1f376-3f0e-4455-816e-ae7b4051d501@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stefan Wiehler <stefan.wiehler@nokia.com> wrote:
> >> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
> >> must be read under RCU or RTNL lock.
> >>
> >> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> >> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> >> ---
> >>  net/ipv6/ip6mr.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> >> index b169b27de7e1..39aac81a30f1 100644
> >> --- a/net/ipv6/ip6mr.c
> >> +++ b/net/ipv6/ip6mr.c
> >> @@ -2633,27 +2633,31 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
> >>               grp = nla_get_in6_addr(tb[RTA_DST]);
> >>       tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
> >>
> >> +     rcu_read_lock();
> > 
> > AFAICS ip6mr_rtm_getroute() runs with RTNL held, so I don't see
> > why this patch is needed.
> 
> That's true, but it's called neither with RCU nor RTNL lock when
> RTNL_FLAG_DOIT_UNLOCKED is set in rtnetlink_rcv_msg():

Sure, but RTNL_FLAG_DOIT_UNLOCKED is not set for this function:

        err = rtnl_register_module(THIS_MODULE, RTNL_FAMILY_IP6MR, RTM_GETROUTE,
                                   ip6mr_rtm_getroute, ip6mr_rtm_dumproute, 0);

(0 == flag field).  So RNTL is held.  Would of course be nice to convert it to RCU
eventually but thats an enhancement, not a bug fix, so this must be in
separate changesets, targetting net and net-next, respectively.

> I realized now that I completely misunderstood how ip6mr_rtm_dumproute() gets
> called - it should be still safe though because mpls_netconf_dump_devconf() and
> getaddr_dumpit() hold the RCU lock while mpls_dump_routes() asserts that the
> RTNL lock is held. Is that observation correct?

{THIS_MODULE, PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},

Both get called with RTNL mutex held, but not within an RCU read side
section.

but:
{THIS_MODULE, PF_MPLS, RTM_GETNETCONF, [..] mpls_netconf_dump_devconf,
       	RTNL_FLAG_DUMP_UNLOCKED}, // == no RTNL held

Means: dump callback is invoked without RTNL mutex.  Those functions
are also called without and RCU read-side section.

Both the get (doit) and the dumper function callbacks need to
explicitly opt-in for RTNL-less invocation at register time.

