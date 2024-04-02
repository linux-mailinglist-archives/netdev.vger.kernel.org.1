Return-Path: <netdev+bounces-83852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0189493A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7181C22407
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC30FBE8;
	Tue,  2 Apr 2024 02:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B91427E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024087; cv=none; b=ZUMIeAOrgB08D8t5Q0UanjHR5UjOUbjoRKJotGxLJCWW/qR8NoYqPbFKUTtknHlgjkXyt91Ubak6JUKc6YTnUl4kXSaZ2uTNtmu+AiTFmIqEZdvsQKfwOtYlnENyebt1jt9LkQqrn+Ik3oKI9v02IB4aB6MAmcB1F64aCigq95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024087; c=relaxed/simple;
	bh=hPZaI88h9uKL9JAGfeuJCLCkw/8W+oM+nUHDDlc3V3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoNpKTsd2Rnh1o85TyhGmfSl+9vqR8NuiHFIHpFrN/BpV9D60a0qBokf8ZZAGwqYfRBYsAjPjaSbea2kODjG8AL/rW2lrYZWxUbvNz5LMenCTptk6Rrp5NJAtebmNq9Vyrx2WVf5sW/9p+Pvv7CGWVsunfVcV23YRNbgRBJjpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V7ryv6lsmz1wprt;
	Tue,  2 Apr 2024 10:13:43 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id B59D91A0172;
	Tue,  2 Apr 2024 10:14:35 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 10:14:35 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <jhs@mojatatu.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jiri@resnulli.us>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<renmingshuai@huawei.com>, <victor@mojatatu.com>, <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
Date: Tue, 2 Apr 2024 10:00:48 +0800
Message-ID: <20240402020048.25103-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAM0EoMmO9pz7Y3ZMVL-QYAUB3kuxNQyK8h4OY-V1T99aE_Qbig@mail.gmail.com>
References: <CAM0EoMmO9pz7Y3ZMVL-QYAUB3kuxNQyK8h4OY-V1T99aE_Qbig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100005.china.huawei.com (7.185.36.102)

> On Wed, Mar 27, 2024 at 6:57 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 9:23 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 12:03 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > >
> > > > When the mirred action is used on a classful egress qdisc and a packet is
> > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > See trace below.
> > > >
> > > > [..... other info removed for brevity....]
> > > > [   82.890906]
> > > > [   82.890906] ============================================
> > > > [   82.890906] WARNING: possible recursive locking detected
> > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
> > > > [   82.890906] --------------------------------------------
> > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > __dev_queue_xmit+0x1778/0x3550
> > > > [   82.890906]
> > > > [   82.890906] but task is already holding lock:
> > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > __dev_queue_xmit+0x1778/0x3550
> > > > [   82.890906]
> > > > [   82.890906] other info that might help us debug this:
> > > > [   82.890906]  Possible unsafe locking scenario:
> > > > [   82.890906]
> > > > [   82.890906]        CPU0
> > > > [   82.890906]        ----
> > > > [   82.890906]   lock(&sch->q.lock);
> > > > [   82.890906]   lock(&sch->q.lock);
> > > > [   82.890906]
> > > > [   82.890906]  *** DEADLOCK ***
> > > > [   82.890906]
> > > > [..... other info removed for brevity....]
> > > >
> > > > Example setup (eth0->eth0) to recreate
> > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth0
> > > >
> > > > Another example(eth0->eth1->eth0) to recreate
> > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth1
> > > >
> > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth0
> > > >
> > > > We fix this by adding a per-cpu, per-qdisc recursion counter which is
> > > > incremented the first time a root qdisc is entered and on a second attempt
> > > > enter the same root qdisc from the top, the packet is dropped to break the
> > > > loop.
> > > >
> > > > Reported-by: renmingshuai@huawei.com
> > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmingshuai@huawei.com/
> > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action()")
> > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loops")
> > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > >  include/net/sch_generic.h |  2 ++
> > > >  net/core/dev.c            |  9 +++++++++
> > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > >  net/sched/sch_generic.c   |  2 ++
> > > >  4 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > --- a/include/net/sch_generic.h
> > > > +++ b/include/net/sch_generic.h
> > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > >         spinlock_t              busylock ____cacheline_aligned_in_smp;
> > > >         spinlock_t              seqlock;
> > > >
> > > > +       u16 __percpu            *xmit_recursion;
> > > > +
> > > >         struct rcu_head         rcu;
> > > >         netdevice_tracker       dev_tracker;
> > > >         /* private data */
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 9a67003e49db..2b712388c06f 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
> > > >         if (unlikely(contended))
> > > >                 spin_lock(&q->busylock);
> > >
> > > This could hang here (busylock)
> >
> > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> > its code vicinity. Am I missing something?
> >
> > >
> > > >
> > > > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > > > +               __qdisc_drop(skb, &to_free);
> > > > +               rc = NET_XMIT_DROP;
> > > > +               goto free_skb_list;
> > > > +       }
> > >
> > >
> > > I do not think we want to add yet another cache line miss and
> > > complexity in tx fast path.
> > >
> >
> > I empathize. The cache miss is due to a per-cpu variable? Otherwise
> > that seems to be in the vicinity of the other fields being accessed in
> > __dev_xmit_skb()
> >
> > > I think that mirred should  use a separate queue to kick a transmit
> > > from the top level.
> > >
> > > (Like netif_rx() does)
> > >
> >
> > Eric, here's my concern: this would entail restructuring mirred
> > totally just to cater for one use case which is in itself _a bad
> > config_ for egress qdisc case only. Mirred is very heavily used in
> > many use cases and changing its behavior could likely introduce other
> > corner cases for some use cases which we would be chasing for a while.
> > Not to forget now we have to go via an extra transient queue.
> > If i understood what you are suggesting is to add an equivalent of
> > backlog queu for the tx side? I am assuming in a very similar nature
> > to backlog, meaning per cpu fired by softirq? or is it something
> > closer to qdisc->gso_skb
> > For either of those cases, the amount of infrastructure code there is
> > not a few lines of code. And then there's the desire to break the loop
> > etc.
> >
> > Some questions regarding your proposal - something I am not following
> > And i may have misunderstood what you are suggesting, but i am missing
> > what scenario mirred can directly call tcf_dev_queue_xmit() (see my
> > comment below)..
> >
> > > Using a softnet.xmit_qdisc_recursion (not a qdisc-per-cpu thing),
> > > would allow mirred to bypass this additional queue
> > > in most cases.
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index cb37817d6382c29117afd8ce54db6dba94f8c930..62ba5ef554860496ee928f7ed6b7c3ea46b8ee1d
> > > 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3217,7 +3217,8 @@ struct softnet_data {
> > >  #endif
> > >         /* written and read only by owning cpu: */
> > >         struct {
> > > -               u16 recursion;
> > > +               u8 recursion;
> > > +               u8 qdisc_recursion;
> > >                 u8  more;
> > >  #ifdef CONFIG_NET_EGRESS
> > >                 u8  skip_txqueue;
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..7ac59835edef657e9558d4d4fc0a76b171aace93
> > > 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4298,7 +4298,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> > > net_device *sb_dev)
> > >
> > >         trace_net_dev_queue(skb);
> > >         if (q->enqueue) {
> > > +               __this_cpu_inc(softnet_data.xmit.qdisc_recursion);
> >
> > This increments the count by 1..
> >
> > >                 rc = __dev_xmit_skb(skb, q, dev, txq);
> > > +               __this_cpu_dec(softnet_data.xmit.qdisc_recursion);
> > >                 goto out;
> > >         }
> > >
> > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > index 5b38143659249e66718348e0ec4ed3c7bc21c13d..0f5f02e6744397d33ae2a72670ba7131aaa6942e
> > > 100644
> > > --- a/net/sched/act_mirred.c
> > > +++ b/net/sched/act_mirred.c
> > > @@ -237,8 +237,13 @@ tcf_mirred_forward(bool at_ingress, bool
> > > want_ingress, struct sk_buff *skb)
> > >  {
> > >         int err;
> > >
> > > -       if (!want_ingress)
> > > -               err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
> > > +       if (!want_ingress) {
> > > +               if (__this_cpu_read(softnet_data.xmit.qdisc_recursion)) {
> >
> > Where does the defered
> > So this will always be 1 assuming the defer queue will have to be
> > something like a workqueue
> 
> Sorry, sent too fast - meant we would always enter here..
Is there a final fix?

