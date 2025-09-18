Return-Path: <netdev+bounces-213912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B2B2748E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF6C1CC1073
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1D72627;
	Fri, 15 Aug 2025 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJ5YDnsB"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D47080D
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219967; cv=none; b=saFO5Gc3xdXYUeKeT0k+Zn2lEmEKRxQteJN/qlTAJSRu+ti2DCmvdX7fnx7zlvxv3z4qh8otrm/+IctgPD3dMtUX6uyPOB41NBjJZddZGJUZd0Nh4nYIm2f0jaHoGAX1eMHeF18vcj1+W2YOLY8yBCHerZQE2avvhbd77ceEg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219967; c=relaxed/simple;
	bh=0cJ/F9fxFvlX61vS4+feIxuYiHm9CmGKsDy0sFn5cF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPVRXvUAjh3WYgpVYTTlTh2mS1jQDeodiSZ5gh0oGgwjaC/EQ7lCvxtfcaoPfeiCaKI8ypbboMVDSHdhspWovN9XcpeyBFSlmB9fwI75DdhqBDsBrkjN/1CuXFvM7XshFlZV04QT5R47SR/8ouVTb4jMzC0SZC4SZks61qsm6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJ5YDnsB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 18:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755219961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meWYiTmUDScKABPl2O7R845IioH2Heb/mh0B6qa7TBU=;
	b=SJ5YDnsBvMYFhc/KlqlDBClj6OTe+WrHP1a5N8p2RFqM0BsFX20eKDNNtYkQWBjzS7fYAu
	pfaPMcEMMfHqV+ZKDFVXi95j7AbwNPbLt15wNcyp+ySMuOyQs62Qh9Hsu2UgfSBJ4cW7Na
	G64fs0jbovc/jG/lVMi2rv1JjDyfsTU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 05:05:56PM -0700, Kuniyuki Iwashima wrote:
> On Thu, Aug 14, 2025 at 4:46 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > > On Thu, Aug 14, 2025 at 2:44 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > > > sk->sk_memcg based on the current task.
> > > > >
> > > > > MPTCP subflow socket creation is triggered from userspace or
> > > > > an in-kernel worker.
> > > > >
> > > > > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> > > > >
> > > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > > >
> > > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > > > > correctly.
> > > > >
> > > > > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > > > > using the parent sk->sk_memcg.
> > > > >
> > > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> > > > > Suggested-by: Michal Koutný <mkoutny@suse.com>
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > ---
> > > > >  mm/memcontrol.c     |  5 ++++-
> > > > >  net/mptcp/subflow.c | 11 +++--------
> > > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> > > > >       if (!in_task())
> > > > >               return;
> > > > >
> > > > > +     memcg = current->active_memcg;
> > > > > +
> > > >
> > > > Use active_memcg() instead of current->active_memcg and do before the
> > > > !in_task() check.
> > >
> > > Why not reuse the !in_task() check here ?
> > > We never use int_active_memcg for socket and also
> > > know int_active_memcg is always NULL here.
> > >
> >
> > If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> > infra then make it work for both in_task() and !in_task() contexts.
> 
> Considering e876ecc67db80, then I think we should add
> set_active_memcg_in_task() and active_memcg_in_task().
> 
> or at least we need WARN_ON() if we want to place active_memcg()
> before the in_task() check, but this looks ugly.
> 
>         memcg = active_memcg();
>         if (!in_task() && !memcg)
>                 return;
>         DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))

You don't have to use the code as is. It is just an example. Basically I
am asking if in future someone does the following:

	// in !in_task() context
	old_memcg = set_active_memcg(new_memcg);
	sk = sk_alloc();
	set_active_memcg(old_memcg);

mem_cgroup_sk_alloc() should work and associate the sk with the
new_memcg.

You can manually inline active_memcg() function to avoid multiple
in_task() checks like below:

void mem_cgroup_sk_alloc(struct sock *sk)
{
	struct mem_cgroup *memcg;

	if (!mem_cgroup_sockets_enabled)
		return;
	
	if (!in_task()) {
		memcg = this_cpu_read(int_active_memcg);

		/*
		 * Do not associate the sock with unrelated interrupted
		 * task's memcg.
		 */
		if (!memcg)
			return;
	} else {
		memcg = current->active_memcg;
	}

	rcu_read_lock();
	if (likely(!memcg))
		memcg = mem_cgroup_from_task(current);
	if (mem_cgroup_is_root(memcg))
		goto out;
	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
		goto out;
	if (css_tryget(&memcg->css))
		sk->sk_memcg = memcg;
out:
	rcu_read_unlock();
}


