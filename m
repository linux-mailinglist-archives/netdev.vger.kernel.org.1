Return-Path: <netdev+bounces-187660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C1AA8934
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 22:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9E63B3925
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AEB2472AB;
	Sun,  4 May 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jeKkhnxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A45367
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746389496; cv=none; b=Nr/cm8setVoS8OxevC6behRJNjO0Jw8JT6YBRW6q3c1nNhKwil0taTWjIHCyz4FNgAffgNKis4uj3K4KNth849b7gA9tzqVPxVujNVejvcNokBi3ZmvswEQhZbRMNA+GBDF1b4sfp7hyzHm6PzqbJqQHVoQPwp6oSMYzsFOSyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746389496; c=relaxed/simple;
	bh=Xzdz5Ei202U2ElHDS/8En5JPiLnH8Bsxb9QUfNeon4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpIzttU1G5BEky1kFaIkA6HMba5wfk3VtOaUe/HYFm8bRSNFLkgGxcgSadv7/JivKKZJiRo7MkozGIWWXEyG7JC4nmNQEpi/LxNczsdnbpivACo2QEywlx/tqr18gRUHlljwlNWUFRYXrUhkbmbnxZtM0Nq5p0s2DdJY8lBZYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jeKkhnxa; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746389496; x=1777925496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHD5YBruEGRXYmuqk4eJsB0nvuGTbAv0RuAFaCp9x6g=;
  b=jeKkhnxaljOFFQUaL/Sd+4GvjlCF7VaBYJUTPvwpIxt/0wSg60T3EnAe
   guBxX9xlT7sb+EbCT4gVqBYvQPt6lv7POawNd2uT4zGTNInwHLOWeeBmI
   I4HXSxTfe/6KXcc5GTB+URoi04Jv1OQYaynzhG42RT/jdheCtbMO8a6nP
   c=;
X-IronPort-AV: E=Sophos;i="6.15,262,1739836800"; 
   d="scan'208";a="89835744"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 20:11:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:27562]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.121:2525] with esmtp (Farcaster)
 id 95644d60-2c9b-4022-820b-ad5a8f34944c; Sun, 4 May 2025 20:11:30 +0000 (UTC)
X-Farcaster-Flow-ID: 95644d60-2c9b-4022-820b-ad5a8f34944c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 4 May 2025 20:11:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 4 May 2025 20:11:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Sun, 4 May 2025 13:11:11 -0700
Message-ID: <20250504201116.30743-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CANn89i+fLC6fd-1ea7W3OhL+562qpjBEbKj7sgtCG7ogZj=dOQ@mail.gmail.com>
References: <CANn89i+fLC6fd-1ea7W3OhL+562qpjBEbKj7sgtCG7ogZj=dOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun, 4 May 2025 12:34:49 -0700
> On Sun, May 4, 2025 at 10:22 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Sun, 4 May 2025 02:16:13 -0700
> > > On Thu, Apr 17, 2025 at 5:10 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.
> > > >
> > > > The remaining things to do are
> > > >
> > > >   1. pass false to lwtunnel_valid_encap_type_attr()
> > > >   2. use rcu_dereference_rtnl() in fib6_check_nexthop()
> > > >   3. place rcu_read_lock() before ip6_route_info_create_nh().
> > > >
> > > > Let's complete the RTNL-free conversion.
> > > >
> > > > When each CPU-X adds 100000 routes on table-X in a batch
> > > > concurrently on c7a.metal-48xl EC2 instance with 192 CPUs,
> > > >
> > > > without this series:
> > > >
> > > >   $ sudo ./route_test.sh
> > > >   ...
> > > >   added 19200000 routes (100000 routes * 192 tables).
> > > >   time elapsed: 191577 milliseconds.
> > > >
> > > > with this series:
> > > >
> > > >   $ sudo ./route_test.sh
> > > >   ...
> > > >   added 19200000 routes (100000 routes * 192 tables).
> > > >   time elapsed: 62854 milliseconds.
> > > >
> > > > I changed the number of routes in each table (1000 ~ 100000)
> > > > and consistently saw it finish 3x faster with this series.
> > > >
> > > > Note that now every caller of lwtunnel_valid_encap_type() passes
> > > > false as the last argument, and this can be removed later.
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/ipv4/nexthop.c |  4 ++--
> > > >  net/ipv6/route.c   | 18 ++++++++++++------
> > > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > > > index 6ba6cb1340c1..823e4a783d2b 100644
> > > > --- a/net/ipv4/nexthop.c
> > > > +++ b/net/ipv4/nexthop.c
> > > > @@ -1556,12 +1556,12 @@ int fib6_check_nexthop(struct nexthop *nh, struct fib6_config *cfg,
> > > >         if (nh->is_group) {
> > > >                 struct nh_group *nhg;
> > > >
> > > > -               nhg = rtnl_dereference(nh->nh_grp);
> > > > +               nhg = rcu_dereference_rtnl(nh->nh_grp);
> > >
> > > Or add a condition about table lock being held ?
> >
> > I think in this context the caller is more of an rcu reader
> > than a ipv6 route writer.
> >
> >
> >
> > >
> > > >                 if (nhg->has_v4)
> > > >                         goto no_v4_nh;
> > > >                 is_fdb_nh = nhg->fdb_nh;
> > > >         } else {
> > > > -               nhi = rtnl_dereference(nh->nh_info);
> > > > +               nhi = rcu_dereference_rtnl(nh->nh_info);
> > > >                 if (nhi->family == AF_INET)
> > > >                         goto no_v4_nh;
> > > >                 is_fdb_nh = nhi->fdb_nh;
> > > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > > index c8c1c75268e3..bb46e724db73 100644
> > > > --- a/net/ipv6/route.c
> > > > +++ b/net/ipv6/route.c
> > > > @@ -3902,12 +3902,16 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
> > > >         if (IS_ERR(rt))
> > > >                 return PTR_ERR(rt);
> > > >
> > > > +       rcu_read_lock();
> > >
> > > This looks bogus to me (and syzbot)
> > >
> > > Holding rcu_read_lock() from writers is almost always wrong.
> >
> > Yes, but I added it as a reader of netdev and nexthop to guarantee
> > that they won't go away.
> 
> We have standard ways for preventing this, acquiring a refcount on the objects.
> >
> >
> > >
> > > In this case, this prevents any GFP_KERNEL allocations to happen
> > > (among other things)
> >
> > Oh, I completely missed this path, thanks!
> >
> > Fortunately, it seems all ->build_state() except for
> > ip_tun_build_state() use GFP_ATOMIC.
> >
> > So, simply changing GFP_KERNEL to GFP_ATOMIC is acceptable ?
> 
> What protects against writers' mutual exclusion ?
> 
> I dislike using GFP_ATOMIC in control paths. This is something that we
> must avoid.
> 
> This will make admin operations unpredictable. Many scripts would
> break under pressure.

I see.  I'll rework this and convert RCU to refcounting of
netdev and nexthop.

Then, I'll change the rcu_dereference_rtnl() above and friends to
check the table lock as you suggested.


> 
> >
> >
> > lwtunnel_state_alloc
> >   - kzalloc(GFP_ATOMIC)
> >
> > ip_tun_build_state
> >   - dst_cache_init(GFP_KERNEL)
> >
> > ip6_tun_build_state / mpls_build_state / xfrmi_build_state
> > -> no alloc other than lwtunnel_state_alloc()
> >
> > bpf_build_state
> >   - bpf_parse_prog
> >     - nla_memdup(GFP_ATOMIC)
> >
> > ila_build_state / ioam6_build_state / rpl_build_state / seg6_build_state
> >   - dst_cache_init(GFP_ATOMIC)
> >
> > seg6_local_build_state
> >   - seg6_end_dt4_build / seg6_end_dt6_build / seg6_end_dt46_build
> >     -> no alloc other than lwtunnel_state_alloc()
> >
> 
> You mean, following the wrong fix done in :
> 
> 14a0087e7236228d56bfa3fab7084c19fcb513fb ipv6: sr: switch to
> GFP_ATOMIC flag to allocate memory during seg6local LWT setup

Oh it's last week... somehow I missed this mail..
maybe I filtered it with ipv6: sr.. :/

In the rework, I'll include the revert of that.

Thanks!

