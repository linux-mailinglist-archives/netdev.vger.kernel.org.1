Return-Path: <netdev+bounces-237637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A29C4E382
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7DC44E7EC9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD624342508;
	Tue, 11 Nov 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="RcFrAQu3"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B74331217
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868665; cv=none; b=FqM3lYNuZJCQ0cLoH7E6LsOweyUJoSPvNp9WYFNIOD8VQv6rpFSiSvCSaZ8s0+prEq/eKuRrHFZ9gX/Dz9Yv+VwPgofUGkR+U4//QId+dVu43mzprco28ZvGjG79rCnsw8UpbFWlL/5OcVXt1PtlvSvyBFT0NoRmEWcfDzcoGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868665; c=relaxed/simple;
	bh=Q55nqoEekYUao91y3OmFNlqlvJI0GifnCmYnwNDHAaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Etm+K+UZHwiJumC52OQQFOBvgDYsGU0lb6iFwiEHrD6ga/2NpRvyuhIfecjdKD/qAJkBSPYZjG30hdNLRwqcPXhn0BGti2QdXXsAFGHXv3ZiHs6ExWuA0C9yvq07gqF5+xI49Ad46Na+1Ytj5/ju52LOL+s63zevcgw9g8CBq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=RcFrAQu3; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=9566; s=dkim-tub; t=1762868662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=clSAYU9UoIB5CIfdIcmlQh9p6U/BeO+a+pADyRysly8=;
  b=RcFrAQu3sSr1V0NW3PpLVrkUIym+avzFEH59e+usBX02Qcdv9REPN/tu
   d5GWGREj49Cn7EtRG+nQwMNVPplOKV5CtvIgN6NzG/v7bCwi4lE7fBjOA
   ZZFKRFVQ1gQpHgVmw4KqW7lcsYwEQGI/YhU9WNMlGrOkSumC29hwQkIOL
   4=;
X-CSE-ConnectionGUID: Be8tN3t9ScCI0sP1jJF30g==
X-CSE-MsgGUID: Pujd7XS+T0CdFcedU8wWIQ==
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="52264483"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 11 Nov 2025 14:44:14 +0100
Message-ID: <99ba3114-10a3-4df2-b49e-63ce8687836d@tu-berlin.de>
Date: Tue, 11 Nov 2025 14:44:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: Eric Dumazet <edumazet@google.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk> <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
 <87seemm8eb.fsf@toke.dk>
 <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
 <87ms4ulz7q.fsf@toke.dk>
 <CANn89i+dL6JUpbZgJ9DEGeVWpmrfv9q=Y_daFvHAPM4ZsjinQg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <CANn89i+dL6JUpbZgJ9DEGeVWpmrfv9q=Y_daFvHAPM4ZsjinQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 11/10/25 18:34, Eric Dumazet wrote:
> On Mon, Nov 10, 2025 at 6:49 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> Eric Dumazet <edumazet@google.com> writes:
>>
>>> I can work on a patch today.
>> This sounds like an excellent idea in any case - thanks! :)
> The following (on top of my last series) seems to work for me
>
>   include/net/pkt_sched.h   |    5 +++--
>   include/net/sch_generic.h |   24 +++++++++++++++++++++++-
>   net/core/dev.c            |   33 +++++++++++++++++++--------------
>   net/sched/sch_cake.c      |    4 +++-
>   4 files changed, 48 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 4678db45832a1e3bf7b8a07756fb89ab868bd5d2..e703c507d0daa97ae7c3bf131e322b1eafcc5664
> 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -114,12 +114,13 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
>
>   void __qdisc_run(struct Qdisc *q);
>
> -static inline void qdisc_run(struct Qdisc *q)
> +static inline struct sk_buff *qdisc_run(struct Qdisc *q)
>   {
>          if (qdisc_run_begin(q)) {
>                  __qdisc_run(q);
> -               qdisc_run_end(q);
> +               return qdisc_run_end(q);
>          }
> +       return NULL;
>   }
>
>   extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 79501499dafba56271b9ebd97a8f379ffdc83cac..19cd2bc13bdba48f941b1599f896c15c8c7860ae
> 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -88,6 +88,8 @@ struct Qdisc {
>   #define TCQ_F_INVISIBLE                0x80 /* invisible by default in dump */
>   #define TCQ_F_NOLOCK           0x100 /* qdisc does not require locking */
>   #define TCQ_F_OFFLOADED                0x200 /* qdisc is offloaded to HW */
> +#define TCQ_F_DEQUEUE_DROPS    0x400 /* ->dequeue() can drop packets
> in q->to_free */
> +
>          u32                     limit;
>          const struct Qdisc_ops  *ops;
>          struct qdisc_size_table __rcu *stab;
> @@ -119,6 +121,8 @@ struct Qdisc {
>
>                  /* Note : we only change qstats.backlog in fast path. */
>                  struct gnet_stats_queue qstats;
> +
> +               struct sk_buff          *to_free;
>          __cacheline_group_end(Qdisc_write);
>
>
> @@ -218,8 +222,15 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
>          return true;
>   }
>
> -static inline void qdisc_run_end(struct Qdisc *qdisc)
> +static inline struct sk_buff *qdisc_run_end(struct Qdisc *qdisc)
>   {
> +       struct sk_buff *to_free = NULL;
> +
> +       if (qdisc->flags & TCQ_F_DEQUEUE_DROPS) {
> +               to_free = qdisc->to_free;
> +               if (to_free)
> +                       qdisc->to_free = NULL;
> +       }
>          if (qdisc->flags & TCQ_F_NOLOCK) {
>                  spin_unlock(&qdisc->seqlock);
>
> @@ -235,6 +246,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
>          } else {
>                  WRITE_ONCE(qdisc->running, false);
>          }
> +       return to_free;
>   }
>
>   static inline bool qdisc_may_bulk(const struct Qdisc *qdisc)
> @@ -1105,6 +1117,16 @@ static inline void tcf_set_drop_reason(const
> struct sk_buff *skb,
>          tc_skb_cb(skb)->drop_reason = reason;
>   }
>
> +static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
> +                                     enum skb_drop_reason reason)
> +{
> +       DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
> +
> +       tcf_set_drop_reason(skb, reason);
> +       skb->next = q->to_free;
> +       q->to_free = skb;
> +}
> +
>   /* Instead of calling kfree_skb() while root qdisc lock is held,
>    * queue the skb for future freeing at end of __dev_xmit_skb()
>    */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ac994974e2a81889fcc0a2e664edcdb7cfd0496d..18cfcd765b1b3e4af1c5339e36df517e7abc914f
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4141,7 +4141,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                                   struct net_device *dev,
>                                   struct netdev_queue *txq)
>   {
> -       struct sk_buff *next, *to_free = NULL;
> +       struct sk_buff *next, *to_free = NULL, *to_free2 = NULL;
>          spinlock_t *root_lock = qdisc_lock(q);
>          struct llist_node *ll_list, *first_n;
>          unsigned long defer_count = 0;
> @@ -4160,9 +4160,9 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                          if (unlikely(!nolock_qdisc_is_empty(q))) {
>                                  rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>                                  __qdisc_run(q);
> -                               qdisc_run_end(q);
> +                               to_free2 = qdisc_run_end(q);
>
> -                               goto no_lock_out;
> +                               goto free_out;
>                          }
>
>                          qdisc_bstats_cpu_update(q, skb);
> @@ -4170,18 +4170,15 @@ static inline int __dev_xmit_skb(struct
> sk_buff *skb, struct Qdisc *q,
>                              !nolock_qdisc_is_empty(q))
>                                  __qdisc_run(q);
>
> -                       qdisc_run_end(q);
> -                       return NET_XMIT_SUCCESS;
> +                       to_free2 = qdisc_run_end(q);
> +                       rc = NET_XMIT_SUCCESS;
> +                       goto free_out;
>                  }
>
>                  rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
> -               qdisc_run(q);
> +               to_free2 = qdisc_run(q);
>
> -no_lock_out:
> -               if (unlikely(to_free))
> -                       kfree_skb_list_reason(to_free,
> -                                             tcf_get_drop_reason(to_free));
> -               return rc;
> +               goto free_out;
>          }
>
>          /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue limit.
> @@ -4239,7 +4236,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                  qdisc_bstats_update(q, skb);
>                  if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
>                          __qdisc_run(q);
> -               qdisc_run_end(q);
> +               to_free2 = qdisc_run_end(q);
>                  rc = NET_XMIT_SUCCESS;
>          } else {
>                  int count = 0;
> @@ -4251,15 +4248,19 @@ static inline int __dev_xmit_skb(struct
> sk_buff *skb, struct Qdisc *q,
>                          rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>                          count++;
>                  }
> -               qdisc_run(q);
> +               to_free2 = qdisc_run(q);
>                  if (count != 1)
>                          rc = NET_XMIT_SUCCESS;
>          }
>   unlock:
>          spin_unlock(root_lock);
> +free_out:
>          if (unlikely(to_free))
>                  kfree_skb_list_reason(to_free,
>                                        tcf_get_drop_reason(to_free));
> +       if (unlikely(to_free2))
> +               kfree_skb_list_reason(to_free2,
> +                                     tcf_get_drop_reason(to_free2));
>          return rc;
>   }
>
> @@ -5741,6 +5742,7 @@ static __latent_entropy void net_tx_action(void)
>          }
>
>          if (sd->output_queue) {
> +               struct sk_buff *to_free;
>                  struct Qdisc *head;
>
>                  local_irq_disable();
> @@ -5780,9 +5782,12 @@ static __latent_entropy void net_tx_action(void)
>                          }
>
>                          clear_bit(__QDISC_STATE_SCHED, &q->state);
> -                       qdisc_run(q);
> +                       to_free = qdisc_run(q);
>                          if (root_lock)
>                                  spin_unlock(root_lock);
> +                       if (unlikely(to_free))
> +                               kfree_skb_list_reason(to_free,
> +                                             tcf_get_drop_reason(to_free));
>                  }
>
>                  rcu_read_unlock();
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 312f5b000ffb67d74faf70f26d808e26315b4ab8..a717cc4e0606e80123ec9c76331d454dad699b69
> 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -2183,7 +2183,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>                  b->tin_dropped++;
>                  qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
>                  qdisc_qstats_drop(sch);
> -               kfree_skb_reason(skb, reason);
> +               qdisc_dequeue_drop(sch, skb, reason);
>                  if (q->rate_flags & CAKE_FLAG_INGRESS)
>                          goto retry;
>          }
> @@ -2569,6 +2569,8 @@ static void cake_reconfigure(struct Qdisc *sch)
>
>          sch->flags &= ~TCQ_F_CAN_BYPASS;
>
> +       sch->flags |= TCQ_F_DEQUEUE_DROPS;
> +
>          q->buffer_limit = min(q->buffer_limit,
>                                max(sch->limit * psched_mtu(qdisc_dev(sch)),
>                                    q->buffer_config_limit));

Thanks for the patches. I experimented with these patches and these are the results:
Running UDP flood (~21 Mpps load) over 2 minutes.
pre-patch (baseline):
   cake achieves stable packet rate of 0.476 Mpps

     qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth unlimited
         besteffort flows nonat nowash no-ack-filter split-gso rtt 100ms
         noatm overhead 18 mpu 64
       Sent 3593552166 bytes 56149224 pkt (dropped 2183, overlimits 0
         requeues 311)
       backlog 0b 0p requeues 311
       memory used: 15503616b of 15140Kb

net-next/main:
   cake throughput drops from 0.61 Mpps to 0.15 Mpps (the expected collapse
   we've seen before)

     qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth unlimited
         besteffort flows nonat nowash no-ack-filter split-gso rtt 100ms
         noatm overhead 18 mpu 64
       Sent 1166199994 bytes 18221827 pkt (dropped 71317773, overlimits 0
         requeues 1914)
       backlog 0b 0p requeues 1914
       memory used: 15504576b of 15140Kb

net-next/main + this dequeue patch:
   cake throughput drops in the first 6 seconds from 0.65 Mpps  and then
   oscillates between 0.27–0.36 Mpps

     qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth unlimited
         besteffort flows nonat nowash no-ack-filter split-gso rtt 100ms
         noatm overhead 18 mpu 64
       Sent 2627464378 bytes 41054083 pkt (dropped 50102108, overlimits 0
         requeues 1008)
       backlog 0b 0p requeues 1008
       memory used: 15503616b of 15140Kb

net-next/main + this dequeue patch + limiting the number of deferred packets:
   cake throughput drops in the first 6 seconds from 0.65 Mpps  and then
   oscillates between 0.35–0.43 Mpps

     qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth unlimited
         besteffort flows nonat nowash no-ack-filter split-gso rtt 100ms
         noatm overhead 18 mpu 64
       Sent 2969529126 bytes 46398843 pkt (dropped 43618919, overlimits 0
         requeues 814)
       backlog 0b 0p requeues 814
       memory used: 15503616b of 15140Kb

I can provide the full throughput traces if needed.
So the last patches definitely mitigate cake's performance degradation.

- Jonas



