Return-Path: <netdev+bounces-214111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758FB284E4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05350AE3140
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A222E403;
	Fri, 15 Aug 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRSypKfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF049475
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278666; cv=none; b=cL7IylWwoypyJ3vhCma9yX9eL4lp3Eaf/PI4J/zQCazXhv1ZX1AZZBqFQ+RL9lKBMXRf/8Qmq7LbLONmh4dbPXs1v4R2jFE/mjllRQVHRLOGEv+J3BSwnfF+wT7SGueyZ4H1AUlRyL9eZkfHEfKQlFZNMYJCNJMVkRSMvZMp9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278666; c=relaxed/simple;
	bh=XFrsjxpUzi5bhqpSZjf9YfTwjoxZtx6DnQQB4JvLOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpUvoqusg5FQQFh8r10RtVZp9KBzdyESXlLDuEPl4c/G45id3EUBXja1N1r5S5qgK+I6Kgbb7XJ8GwCMeikPG2VZycYs9iZYBzye7izAp4AtBlyG78Zp702CoyVRbtxmPAeREfRHs0zv6htNyn27GP+DY8NT7M/95TQjcOJUqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRSypKfE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1384554a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755278664; x=1755883464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzg1sXt30P5Z9/BfPnmiaFGjEcn/JQQ0ZCMOCPQMKE4=;
        b=WRSypKfEdyZ8+hV3WZzHyjQZtxAxeEdD1lD2Rgv6+WBWoj5U1wytsEfyq309nAAPXh
         MUeV6u1hYeNj/5VFIB/FkF3lzRoFTVCF/MBDdc1NSBcm5P0AwHTupQUBqeKN+ZNN7jfs
         lVpvR4qplkXDmnGBO6BKMl1IKPcFJx4RHatUx4K8BcELqBZzFpUmnjrJkgIJ2NiMiHp2
         tMo+CRzR7aWLASK7CcKmCDX9NmNe+cLP32dLChPGFpCcYFtyW7dHpQJZWQygq+v/RmkA
         yuhhExUQxPUhXpsAm4pBn/8/2/Tuv8T71AffIlKDD4pPYpVo6pLufnxg2VQPgr2szNr3
         EudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278664; x=1755883464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzg1sXt30P5Z9/BfPnmiaFGjEcn/JQQ0ZCMOCPQMKE4=;
        b=kGVro4N2zesyGr5SjDBbg/eV7bQt10EVs9mYdKYS8Sha0hlDcHPKVX/dzLBFKhRBrq
         8eFE3+1PB2EQvMOJ3Vs6uk6N+5AMUrhVDzZbRnulNksP2+sqpUYufNlO6NLDckfKLfE6
         F/hco1LzaLDuVQTD+xGugUc+gra3+qntxQoZLGU5/v2QZL5Sus3wkZfP5exR4bRou2N2
         bfTVURlgcN8Y2bsNidiidIfKzDIZpOZj2J/maPPN0vNmCXqXyqIHz9OAJgWDDfvcvCxZ
         y3Jt9W1ln47XM/neN7ET1+SnNcYwcnl7lW5fzWsxri2+EJ80Q1y8aRSoJAsTbu7LO25H
         iXvw==
X-Forwarded-Encrypted: i=1; AJvYcCUvfDk7UmOq1HDEiUKJVh58oaEQZVAvU7Qx84la8QJd5vGXOryCEtzTSza/x3ISIv9meMnpb5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+pIDOLZ92ZjgdpKHmCulmYot4a6sL+9uck7LEjGZiBhu2uTU
	suMqG4W8G3Z2RTDbAGGEuw9ZUAewA00SXuZazdQf9XZ2azBhUa/Oil1okwPS5i6mBw5fp70mxXg
	g+CAKBru5HA37wqW+oNzgvNYf3uwnlAdPO3U1VEFN
X-Gm-Gg: ASbGncunK1TyixtflhZtD9WBt9JFnOuEr+NUncFj+roFEcItwgY66FObCe6lWlHspPi
	dTwqEtdfIViFPe+hgJePmCVXNE9HE82fiWd4NAs0OBPVEfLc0kYhFwpagsv6GB4n1DUavbYIjuK
	qEj8PtgXnPn9IUtuExPvyJsvX7FSzmlgMym5y9nC0X8vJ+HkQHJuopHzojkE0mb9uNY7k5ATYyj
	fsj8nyqRZHJ3A+aRYfuOsBewtAZ25nmNdXav+deHjipuzUcLAsBPN3xLw==
X-Google-Smtp-Source: AGHT+IGOeHzguq0H49KnfwRNBN4KHk/rEdxFjz1gBmVI9CUvhaLBILRetMCU8KSgGN+j2f2hFkx+G5OoFKZhh3FV0pc=
X-Received: by 2002:a17:90a:d00c:b0:321:7528:ab43 with SMTP id
 98e67ed59e1d1-32342159927mr4699112a91.24.1755278663907; Fri, 15 Aug 2025
 10:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
 <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f> <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
In-Reply-To: <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 15 Aug 2025 10:24:12 -0700
X-Gm-Features: Ac12FXwIRxgeuD6PT09lmdII8NjN1ufyiLIBuu7fCCCW8-jhnwo582zSPLhZK3E
Message-ID: <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Aug 14, 2025 at 6:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Thu, Aug 14, 2025 at 05:05:56PM -0700, Kuniyuki Iwashima wrote:
> > > On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > > > > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.but=
t@linux.dev> wrote:
> > > > > >
> > > > > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wro=
te:
> > > > > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() set=
s
> > > > > > > sk->sk_memcg based on the current task.
> > > > > > >
> > > > > > > MPTCP subflow socket creation is triggered from userspace or
> > > > > > > an in-kernel worker.
> > > > > > >
> > > > > > > In the latter case, sk->sk_memcg is not what we want.  So, we=
 fix
> > > > > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_c=
group().
> > > > > > >
> > > > > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is =
buried
> > > > > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > > > > >
> > > > > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled w=
ithout
> > > > > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not ch=
arged
> > > > > > > correctly.
> > > > > > >
> > > > > > > Let's wrap sock_create_kern() for subflow with set_active_mem=
cg()
> > > > > > > using the parent sk->sk_memcg.
> > > > > > >
> > > > > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent=
 cgroup")
> > > > > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > ---
> > > > > > >  mm/memcontrol.c     |  5 ++++-
> > > > > > >  net/mptcp/subflow.c | 11 +++--------
> > > > > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > > > > --- a/mm/memcontrol.c
> > > > > > > +++ b/mm/memcontrol.c
> > > > > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *=
sk)
> > > > > > >       if (!in_task())
> > > > > > >               return;
> > > > > > >
> > > > > > > +     memcg =3D current->active_memcg;
> > > > > > > +
> > > > > >
> > > > > > Use active_memcg() instead of current->active_memcg and do befo=
re the
> > > > > > !in_task() check.
> > > > >
> > > > > Why not reuse the !in_task() check here ?
> > > > > We never use int_active_memcg for socket and also
> > > > > know int_active_memcg is always NULL here.
> > > > >
> > > >
> > > > If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> > > > infra then make it work for both in_task() and !in_task() contexts.
> > >
> > > Considering e876ecc67db80, then I think we should add
> > > set_active_memcg_in_task() and active_memcg_in_task().
> > >
> > > or at least we need WARN_ON() if we want to place active_memcg()
> > > before the in_task() check, but this looks ugly.
> > >
> > >         memcg =3D active_memcg();
> > >         if (!in_task() && !memcg)
> > >                 return;
> > >         DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))
> >
> > You don't have to use the code as is. It is just an example. Basically =
I
> > am asking if in future someone does the following:
> >
> >         // in !in_task() context
> >         old_memcg =3D set_active_memcg(new_memcg);
> >         sk =3D sk_alloc();
> >         set_active_memcg(old_memcg);
> >
> > mem_cgroup_sk_alloc() should work and associate the sk with the
> > new_memcg.
> >
> > You can manually inline active_memcg() function to avoid multiple
> > in_task() checks like below:
>
> Will do so, thanks!

I noticed this won't work with the bpf approach as the
hook is only called for !sk_kern socket (MPTCP subflow
is sk_kern =3D=3D 1) and we need to manually copy the
memcg anyway.. so I'll use the original patch 1 in the
next version.


> >
> > void mem_cgroup_sk_alloc(struct sock *sk)
> > {
> >         struct mem_cgroup *memcg;
> >
> >         if (!mem_cgroup_sockets_enabled)
> >                 return;
> >
> >         if (!in_task()) {
> >                 memcg =3D this_cpu_read(int_active_memcg);
> >
> >                 /*
> >                  * Do not associate the sock with unrelated interrupted
> >                  * task's memcg.
> >                  */
> >                 if (!memcg)
> >                         return;
> >         } else {
> >                 memcg =3D current->active_memcg;
> >         }
> >
> >         rcu_read_lock();
> >         if (likely(!memcg))
> >                 memcg =3D mem_cgroup_from_task(current);
> >         if (mem_cgroup_is_root(memcg))
> >                 goto out;
> >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem=
_active(memcg))
> >                 goto out;
> >         if (css_tryget(&memcg->css))
> >                 sk->sk_memcg =3D memcg;
> > out:
> >         rcu_read_unlock();
> > }
> >

