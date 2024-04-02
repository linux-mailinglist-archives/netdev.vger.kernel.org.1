Return-Path: <netdev+bounces-84112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B398959D6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9097D281048
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8C5B692;
	Tue,  2 Apr 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ibc/5XXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B965159205
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075924; cv=none; b=WhCude0YYvzoOdMVm401vZI+MBvXcXZ0eaG5t7krSAsJ85lx8+xfz6sux6LktI6pWbzkeDMnDr9Vh53qEfERM5ZhULMrvgWoqxzklZkRo4hm8j0+IEJxal67PNMuW5yosMPkOEp7PxkM55k8C0RZJZD3cFhubIJyIUmDg5nKVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075924; c=relaxed/simple;
	bh=3+q76VA2DZj4uOi3eVzPqvRAw5fHP2dAapflKsNgOag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VL5mRVtslRYwazo2/8e0iYz+FSdcF5PvlooQR0cgebKeTYbqVN++aoAb7avI/dlLiwiEwZQnzxEZjmbWhCbNJJ00hzyM3B/93Dgv/alTL1MGkHN4s+7pZc1/GV8K6V/9n2+wxCNXxGnWbvwbSZwFfvUPJEnqnH/9iDLICk9jDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ibc/5XXc; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a4a102145fso2926480eaf.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712075921; x=1712680721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bywku0FkcXl3hfvmY3UtEc0wqdzAeFYpWFlaV8eQrok=;
        b=ibc/5XXcfjuMCTi+Frr9bBPquzV4YqVvz6qcnPQYREpJNzo+M1mjnxK0cgDe41mDJe
         W3r4lnFxiAfBtQCEtZ19jkrVBa1haunQMpplb1amYCYIfdIQ4tvi4gPj4d7Ix71G9KtL
         wPpZxascBXpTZc7wDo04o3KkRDWH4TlTgRyKsd+4Pp2OUAeb51NwERJMmzTIN5HQ1Uhi
         e9Q8Ujtjtu4DoF64P7otmWLHemw6EWAsztqQGpwz0q5gGDnb9Cjlhrw3hYyX8ETRgUM9
         ZEXulH88/tf/ckldmtJKWDCXNwUs8ZpmW9/+7XUSkytVH1FD0ddpEzgd7c6T3pVHDJ5R
         ZaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075921; x=1712680721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bywku0FkcXl3hfvmY3UtEc0wqdzAeFYpWFlaV8eQrok=;
        b=VtcKGy+yAmE77epaOMYyO9BsRmyM+dpqcK1Zh8rkie8vf1GtSbzg0tyx8QMmquSsc5
         5lEisTsYS7fThjrTJ8PC5AlpkQFIXeIrtiUj1xhD1FjiXXYFREJLCKHA3d/DoLMXEn0b
         siJ+TdI00rq1+TnC73ASdqndj7839kqe1qHdUoL+dtUvLIlJci8/LZ0g5dV2b9fGJR3v
         TQuS7sQn6fBM9IjZkFRywvGpvPUzpF0Hv1k/W3ZOEambZkU5OOIXOEZqK1YU5EQ+jwso
         AZ4VuTDceP6UaQq1rLfyNOFFxMa4XKhYRAUtOytgi2RF33enK0Ht36+puTgquz+XWmNt
         TBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUWeNcaDUalID5ER8Fx9vbcAilpXK/wV8Z+WsCR7NqgsRljKH5Pvb5ZCgOOj0WCRUv92aAaBH0gauedgUCKc3jv32SKxuZg
X-Gm-Message-State: AOJu0YzYuvn/269XMx9VOs5Q6sVlAtFfwXRslPudsLTi46gN/1qCbVUy
	tuO8NYbJk9b2dbfDMKX/O7bJGteijMLd7W4arN5l/lcIot52RwuyczEFj8QopupnJhI2P/5zFFP
	a6dIqPg6qvfkIwdimihoAPCie9biD27XThh/qKowl4RBR7ew=
X-Google-Smtp-Source: AGHT+IEwkNsHNl1uHIT6nDQlgI1k3sVQ2k0qS78o9+8wQu1MqTB6utYjidJ2q2NOqpedie34dGyRQ0Q+00nZ/7Ji174=
X-Received: by 2002:a05:6358:3408:b0:183:4d1d:8697 with SMTP id
 h8-20020a056358340800b001834d1d8697mr9010762rwd.24.1712075921022; Tue, 02 Apr
 2024 09:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMmO9pz7Y3ZMVL-QYAUB3kuxNQyK8h4OY-V1T99aE_Qbig@mail.gmail.com>
 <20240402020048.25103-1-renmingshuai@huawei.com>
In-Reply-To: <20240402020048.25103-1-renmingshuai@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Apr 2024 12:38:29 -0400
Message-ID: <CAM0EoMnPK3hHCWF0aQOcSXJyqWsZ-xBwK5Vs8tw1uVSFp=QrnA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: renmingshuai <renmingshuai@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	victor@mojatatu.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:15=E2=80=AFPM renmingshuai <renmingshuai@huawei.c=
om> wrote:
>
> > On Wed, Mar 27, 2024 at 6:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > When the mirred action is used on a classful egress qdisc and a p=
acket is
> > > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > > See trace below.
> > > > >
> > > > > [..... other info removed for brevity....]
> > > > > [   82.890906]
> > > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > [   82.890906] WARNING: possible recursive locking detected
> > > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G   =
     W
> > > > > [   82.890906] --------------------------------------------
> > > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > [   82.890906]
> > > > > [   82.890906] but task is already holding lock:
> > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > [   82.890906]
> > > > > [   82.890906] other info that might help us debug this:
> > > > > [   82.890906]  Possible unsafe locking scenario:
> > > > > [   82.890906]
> > > > > [   82.890906]        CPU0
> > > > > [   82.890906]        ----
> > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > [   82.890906]
> > > > > [   82.890906]  *** DEADLOCK ***
> > > > > [   82.890906]
> > > > > [..... other info removed for brevity....]
> > > > >
> > > > > Example setup (eth0->eth0) to recreate
> > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth0
> > > > >
> > > > > Another example(eth0->eth1->eth0) to recreate
> > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth1
> > > > >
> > > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth0
> > > > >
> > > > > We fix this by adding a per-cpu, per-qdisc recursion counter whic=
h is
> > > > > incremented the first time a root qdisc is entered and on a secon=
d attempt
> > > > > enter the same root qdisc from the top, the packet is dropped to =
break the
> > > > > loop.
> > > > >
> > > > > Reported-by: renmingshuai@huawei.com
> > > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renm=
ingshuai@huawei.com/
> > > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_ac=
tion()")
> > > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify=
 loops")
> > > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > ---
> > > > >  include/net/sch_generic.h |  2 ++
> > > > >  net/core/dev.c            |  9 +++++++++
> > > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > > >  net/sched/sch_generic.c   |  2 ++
> > > > >  4 files changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.=
h
> > > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > > --- a/include/net/sch_generic.h
> > > > > +++ b/include/net/sch_generic.h
> > > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > > >         spinlock_t              busylock ____cacheline_aligned_in=
_smp;
> > > > >         spinlock_t              seqlock;
> > > > >
> > > > > +       u16 __percpu            *xmit_recursion;
> > > > > +
> > > > >         struct rcu_head         rcu;
> > > > >         netdevice_tracker       dev_tracker;
> > > > >         /* private data */
> > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > index 9a67003e49db..2b712388c06f 100644
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk=
_buff *skb, struct Qdisc *q,
> > > > >         if (unlikely(contended))
> > > > >                 spin_lock(&q->busylock);
> > > >
> > > > This could hang here (busylock)
> > >
> > > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> > > its code vicinity. Am I missing something?
> > >
> > > >
> > > > >
> > > > > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > > > > +               __qdisc_drop(skb, &to_free);
> > > > > +               rc =3D NET_XMIT_DROP;
> > > > > +               goto free_skb_list;
> > > > > +       }
> > > >
> > > >
> > > > I do not think we want to add yet another cache line miss and
> > > > complexity in tx fast path.
> > > >
> > >
> > > I empathize. The cache miss is due to a per-cpu variable? Otherwise
> > > that seems to be in the vicinity of the other fields being accessed i=
n
> > > __dev_xmit_skb()
> > >
> > > > I think that mirred should  use a separate queue to kick a transmit
> > > > from the top level.
> > > >
> > > > (Like netif_rx() does)
> > > >
> > >
> > > Eric, here's my concern: this would entail restructuring mirred
> > > totally just to cater for one use case which is in itself _a bad
> > > config_ for egress qdisc case only. Mirred is very heavily used in
> > > many use cases and changing its behavior could likely introduce other
> > > corner cases for some use cases which we would be chasing for a while=
.
> > > Not to forget now we have to go via an extra transient queue.
> > > If i understood what you are suggesting is to add an equivalent of
> > > backlog queu for the tx side? I am assuming in a very similar nature
> > > to backlog, meaning per cpu fired by softirq? or is it something
> > > closer to qdisc->gso_skb
> > > For either of those cases, the amount of infrastructure code there is
> > > not a few lines of code. And then there's the desire to break the loo=
p
> > > etc.
> > >
> > > Some questions regarding your proposal - something I am not following
> > > And i may have misunderstood what you are suggesting, but i am missin=
g
> > > what scenario mirred can directly call tcf_dev_queue_xmit() (see my
> > > comment below)..
> > >
> > > > Using a softnet.xmit_qdisc_recursion (not a qdisc-per-cpu thing),
> > > > would allow mirred to bypass this additional queue
> > > > in most cases.
> > > >
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index cb37817d6382c29117afd8ce54db6dba94f8c930..62ba5ef554860496ee9=
28f7ed6b7c3ea46b8ee1d
> > > > 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -3217,7 +3217,8 @@ struct softnet_data {
> > > >  #endif
> > > >         /* written and read only by owning cpu: */
> > > >         struct {
> > > > -               u16 recursion;
> > > > +               u8 recursion;
> > > > +               u8 qdisc_recursion;
> > > >                 u8  more;
> > > >  #ifdef CONFIG_NET_EGRESS
> > > >                 u8  skip_txqueue;
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..7ac59835edef657e955=
8d4d4fc0a76b171aace93
> > > > 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -4298,7 +4298,9 @@ int __dev_queue_xmit(struct sk_buff *skb, str=
uct
> > > > net_device *sb_dev)
> > > >
> > > >         trace_net_dev_queue(skb);
> > > >         if (q->enqueue) {
> > > > +               __this_cpu_inc(softnet_data.xmit.qdisc_recursion);
> > >
> > > This increments the count by 1..
> > >
> > > >                 rc =3D __dev_xmit_skb(skb, q, dev, txq);
> > > > +               __this_cpu_dec(softnet_data.xmit.qdisc_recursion);
> > > >                 goto out;
> > > >         }
> > > >
> > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > index 5b38143659249e66718348e0ec4ed3c7bc21c13d..0f5f02e6744397d33ae=
2a72670ba7131aaa6942e
> > > > 100644
> > > > --- a/net/sched/act_mirred.c
> > > > +++ b/net/sched/act_mirred.c
> > > > @@ -237,8 +237,13 @@ tcf_mirred_forward(bool at_ingress, bool
> > > > want_ingress, struct sk_buff *skb)
> > > >  {
> > > >         int err;
> > > >
> > > > -       if (!want_ingress)
> > > > -               err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> > > > +       if (!want_ingress) {
> > > > +               if (__this_cpu_read(softnet_data.xmit.qdisc_recursi=
on)) {
> > >
> > > Where does the defered
> > > So this will always be 1 assuming the defer queue will have to be
> > > something like a workqueue
> >
> > Sorry, sent too fast - meant we would always enter here..
> Is there a final fix?

That fix should work - but you can view this as "discussion in progress" ;-=
>

cheers,
jamal

