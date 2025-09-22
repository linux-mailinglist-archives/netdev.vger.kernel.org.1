Return-Path: <netdev+bounces-225140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E208B8F4C5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8397316D2D7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870A2D6E53;
	Mon, 22 Sep 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kim9Uj5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA6255F28
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526293; cv=none; b=qoEz7TxG410RMCN6sOp5U6iP8D7XI+Yi2lqpoQQScG53LGb92oKpK1kbPUwTgt+XrMFtRQJSSv6Aj49dX/d0pkJEZTlLZ7rlMYDqlV5cM76kt/rDvioulB6aUvR9eUIXfcUqPP4gat31GVCdKn9ZEfbA2c8Kn1mGKHbf5ucEL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526293; c=relaxed/simple;
	bh=mnBvhgeFItj7BcVPySrxXcc+ApnqA/GiSVXkn7ufK58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMBcfd/kKWShhgDfb/jo/8dkFlF2mtuInZH51xj1VMqam2ToXGSVnzAWxrhA0xg0LY0PSubDy+zY0371q9zUykeICdMEKjE2punkTy6fHATWEe1AGKfgOrvxxVTAPwcUbUEilDjKQAKdCUi08agz3kXMIq7GlddCDzDPNDlZXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kim9Uj5P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5eee40cc0so40258881cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758526290; x=1759131090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW7qdQhI1ajfdCgUAlDiHeRU2UazoIrmSwERtyYv9f0=;
        b=Kim9Uj5PKtSgHGQEiTXo4v2BqVPagekiTe5KqT9pVqQwW251gBDC4zM+y8mvQtpLm7
         Uv2MjeqJTAZJclx8j7ozcQQWG+ZHR7G/gk00WInc7Wq6NlsT2aI60lqTFv7QbGavnm9P
         TDdS5/qusExnTCUaN0aTYM85kWYD7gQaRdFEkY+/J2rqt+fkC9u1oZCHtcTS1YGgl5F6
         EUr/hwNer91Tcl0gJDEf3eE9RpK2R9YL5543jJRZ7zvvrXzbST/ZrvBNgOZ0iwFjZ1NA
         B/f2P24lE/zW1dvKdvHjQ4zgmwI08icfI64vdViBPYlU+ZPmt/+LPZN4H//gGajVNh/N
         EekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526290; x=1759131090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hW7qdQhI1ajfdCgUAlDiHeRU2UazoIrmSwERtyYv9f0=;
        b=jRNuYdbIRZn+fXjlFlkM1euXbTZrkjwHMxA+ByAmHtuwi37+JnctW+8s1Wbvni5IdV
         Fy9qL+naSDGBP2P365EDXT5eJTDS+oZZCZhZNtY4fUTxxtR7n2XKo7IMxTHr/Tvtz8n4
         6I8Dj45zxx7GUdUWnZPtug4Nrn/plkGi795eTHI0+U0VeHEKFBV51AiIWx2VC/G29A0r
         vF2ZJZroS8wi+++wCsj/DbR9tOOvyaNbiQ2VkM7UMTBZmD7hyUFeYsSsMharkEl6nRGi
         R4+xjzMw1dx41KSHf/3oERZaV9nidzKZ/BhrSCI+lHZ/vQxZkLObvEH7/h2Aa5CTj9jV
         Fg0w==
X-Forwarded-Encrypted: i=1; AJvYcCXapcRbl74fPLLeitikkAaoJvtw2KeuFuDQPoyP39tjoN2gp4SwgBNVXXLXy4O/rT//KQLC+10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabC3tJuJA5L2XX2NTnPEdZdU7t5PhowuX4s+wPs9myG4edVa3
	fPIqeFx05HoqrmQZxxAtpAigPJ6jYML7pIMb+VbFDT2wuq6XZpz41uy29jC8sHaantPlhhwYkIX
	s5h++OFauMe55zYCS0sdJSEIhtIhyKRrf7EbzclrO
X-Gm-Gg: ASbGncuxNr+uN9ROgngOGXRuPrkiLeSUddG+i1ufhjTolx25EdMpKZREnscR00zSQxF
	iYpa/4zS7lZ6aozzrylSTUbHshvCCPNxK16j6VnlzpvUWeJBw27ObtDFP1EybIcvzOn8JsvBeKN
	kLoYiIKcPxSbyMFFsrqoEn5Nomxi7qzaBCSQEBUlEBTtB0cakB11JNGElmi/I0emITii1mHca5C
	AXg8Bg=
X-Google-Smtp-Source: AGHT+IHHCle2QxSvLFY4TQjrndZJuDa+YEv6WZHVOF5yoBR4mYOf+ASQeJKJxNFWQ7V0aFCKyKJJT3L1vTcs/QYSwQM=
X-Received: by 2002:a05:622a:5c15:b0:4b3:417a:adcb with SMTP id
 d75a77b69052e-4c074544dafmr104694761cf.84.1758526289887; Mon, 22 Sep 2025
 00:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921095802.875191-1-edumazet@google.com> <willemdebruijn.kernel.1fae2e81b156b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1fae2e81b156b@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 00:31:18 -0700
X-Gm-Features: AS18NWA7IFHDO6TGPT6I-ccHh9nmXhvMOOPdXBeV51TNWjxJlBsFe0BbMTmYINk
Message-ID: <CANn89iKzgg9fFJdmEZcJkvc7Q1d-R=ZyrOc+E9zdA7LXaTd8Jg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:21=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > busylock was protecting UDP sockets against packet floods,
> > but unfortunately was not protecting the host itself.
> >
> > Under stress, many cpus could spin while acquiring the busylock,
> > and NIC had to drop packets. Or packets would be dropped
> > in cpu backlog if RPS/RFS were in place.
> >
> > This patch replaces the busylock by intermediate
> > lockless queues. (One queue per NUMA node).
> >
> > This means that fewer number of cpus have to acquire
> > the UDP receive queue lock.
> >
> > Most of the cpus can either:
> > - immediately drop the packet.
> > - or queue it in their NUMA aware lockless queue.
> >
> > Then one of the cpu is chosen to process this lockless queue
> > in a batch.
> >
> > The batch only contains packets that were cooked on the same
> > NUMA node, thus with very limited latency impact.
> >
> > Tested:
> >
> > DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes
> > (Intel(R) Xeon(R) 6985P-C)
> >
> > Before:
> >
> > nstat -n ; sleep 1 ; nstat | grep Udp
> > Udp6InDatagrams                 1004179            0.0
> > Udp6InErrors                    3117               0.0
> > Udp6RcvbufErrors                3117               0.0
> >
> > After:
> > nstat -n ; sleep 1 ; nstat | grep Udp
> > Udp6InDatagrams                 1116633            0.0
> > Udp6InErrors                    14197275           0.0
> > Udp6RcvbufErrors                14197275           0.0
> >
> > We can see this host can now proces 14.2 M more packets per second
> > while under attack, and the victim socket can receive 11 % more
> > packets.
>
> Impressive gains under DoS!
>
> Main concern is that it adds an extra queue/dequeue and thus some
> cycle cost for all udp sockets in the common case where they are not
> contended. These are simple linked list operations, so I suppose the
> only cost may be the cacheline if not warm. Busylock had the nice
> property of only being used under mem pressure. Could this benefit
> from the same?

I hear you, but the extra cache line is local to the node, compared to prio=
r
non-local  and shared cache line, especially on modern cpus (AMD Turin
/ Venice or Intel Granite Rapids)

This is a very minor cost, compared to the average delay between
packet being received
on the wire and being presented on __udp_enqueue_schedule_skb().

And the core of the lockless algorithm is that all packets go through
the same logic.
See my following answer.

>
> > I used a small bpftrace program measuring time (in us) spent in
> > __udp_enqueue_schedule_skb().
> >
> > Before:
> >
> > @udp_enqueue_us[398]:
> > [0]                24901 |@@@                                          =
       |
> > [1]                63512 |@@@@@@@@@                                    =
       |
> > [2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         =
       |
> > [8, 16)            54022 |@@@@@@@@                                     =
       |
> > [16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            =
       |
> > [32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           =
       |
> > [64, 128)           4219 |                                             =
       |
> > [128, 256)           188 |                                             =
       |
> >
> > After:
> >
> > @udp_enqueue_us[398]:
> > [0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [1]              1111277 |@@@@@@@@@@                                   =
       |
> > [2, 4)            501439 |@@@@                                         =
       |
> > [4, 8)            102921 |                                             =
       |
> > [8, 16)            29895 |                                             =
       |
> > [16, 32)           43500 |                                             =
       |
> > [32, 64)           31552 |                                             =
       |
> > [64, 128)            979 |                                             =
       |
> > [128, 256)            13 |                                             =
       |
> >
> > Note that the remaining bottleneck for this platform is in
> > udp_drops_inc() because we limited struct numa_drop_counters
> > to only two nodes so far.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > v3: - Moved kfree(up->udp_prod_queue) to udp_destruct_common(),
> >       addressing reports from Jakub and syzbot.
> >
> >     - Perform SKB_DROP_REASON_PROTO_MEM drops after the queue
> >       spinlock is released.
> >
> > v2: https://lore.kernel.org/netdev/20250920080227.3674860-1-edumazet@go=
ogle.com/
> >     - Added a kfree(up->udp_prod_queue) in udpv6_destroy_sock() (Jakub =
feedback on v1)
> >     - Added bpftrace histograms in changelog.
> >
> > v1: https://lore.kernel.org/netdev/20250919164308.2455564-1-edumazet@go=
ogle.com/
> >
> >  include/linux/udp.h |   9 +++-
> >  include/net/udp.h   |  11 ++++-
> >  net/ipv4/udp.c      | 114 ++++++++++++++++++++++++++------------------
> >  net/ipv6/udp.c      |   5 +-
> >  4 files changed, 88 insertions(+), 51 deletions(-)
> >
> > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > index e554890c4415b411f35007d3ece9e6042db7a544..58795688a18636ea79aa1f5=
d06eacc676a2e7849 100644
> > --- a/include/linux/udp.h
> > +++ b/include/linux/udp.h
> > @@ -44,6 +44,12 @@ enum {
> >       UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
> >  };
> >
> > +/* per NUMA structure for lockless producer usage. */
> > +struct udp_prod_queue {
> > +     struct llist_head       ll_root ____cacheline_aligned_in_smp;
> > +     atomic_t                rmem_alloc;
> > +};
> > +
> >  struct udp_sock {
> >       /* inet_sock has to be the first member */
> >       struct inet_sock inet;
> > @@ -90,6 +96,8 @@ struct udp_sock {
> >                                               struct sk_buff *skb,
> >                                               int nhoff);
> >
> > +     struct udp_prod_queue *udp_prod_queue;
> > +
> >       /* udp_recvmsg try to use this before splicing sk_receive_queue *=
/
> >       struct sk_buff_head     reader_queue ____cacheline_aligned_in_smp=
;
> >
> > @@ -109,7 +117,6 @@ struct udp_sock {
> >        */
> >       struct hlist_node       tunnel_list;
> >       struct numa_drop_counters drop_counters;
> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
> >  };
> >
> >  #define udp_test_bit(nr, sk)                 \
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > index 059a0cee5f559b8d75e71031a00d0aa2769e257f..cffedb3e40f24513e44fb75=
98c0ad917fd15b616 100644
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
> > @@ -284,16 +284,23 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk=
_buff *));
> >  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >                                 netdev_features_t features, bool is_ipv=
6);
> >
> > -static inline void udp_lib_init_sock(struct sock *sk)
> > +static inline int udp_lib_init_sock(struct sock *sk)
> >  {
> >       struct udp_sock *up =3D udp_sk(sk);
> >
> >       sk->sk_drop_counters =3D &up->drop_counters;
> > -     spin_lock_init(&up->busylock);
> >       skb_queue_head_init(&up->reader_queue);
> >       INIT_HLIST_NODE(&up->tunnel_list);
> >       up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> >       set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> > +
> > +     up->udp_prod_queue =3D kcalloc(nr_node_ids, sizeof(*up->udp_prod_=
queue),
> > +                                  GFP_KERNEL);
> > +     if (!up->udp_prod_queue)
> > +             return -ENOMEM;
> > +     for (int i =3D 0; i < nr_node_ids; i++)
> > +             init_llist_head(&up->udp_prod_queue[i].ll_root);
> > +     return 0;
> >  }
> >
> >  static inline void udp_drops_inc(struct sock *sk)
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 85cfc32eb2ccb3e229177fb37910fefde0254ffe..fce1d0ffd6361d271ae3528=
fea026a8d6c07ac6e 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1685,25 +1685,6 @@ static void udp_skb_dtor_locked(struct sock *sk,=
 struct sk_buff *skb)
> >       udp_rmem_release(sk, udp_skb_truesize(skb), 1, true);
> >  }
> >
> > -/* Idea of busylocks is to let producers grab an extra spinlock
> > - * to relieve pressure on the receive_queue spinlock shared by consume=
r.
> > - * Under flood, this means that only one producer can be in line
> > - * trying to acquire the receive_queue spinlock.
> > - */
> > -static spinlock_t *busylock_acquire(struct sock *sk)
> > -{
> > -     spinlock_t *busy =3D &udp_sk(sk)->busylock;
> > -
> > -     spin_lock(busy);
> > -     return busy;
> > -}
> > -
> > -static void busylock_release(spinlock_t *busy)
> > -{
> > -     if (busy)
> > -             spin_unlock(busy);
> > -}
> > -
> >  static int udp_rmem_schedule(struct sock *sk, int size)
> >  {
> >       int delta;
> > @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, i=
nt size)
> >  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >  {
> >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> > +     struct udp_prod_queue *udp_prod_queue;
> > +     struct sk_buff *next, *to_drop =3D NULL;
> > +     struct llist_node *ll_list;
> >       unsigned int rmem, rcvbuf;
> > -     spinlock_t *busy =3D NULL;
> >       int size, err =3D -ENOMEM;
> > +     int total_size =3D 0;
> > +     int q_size =3D 0;
> > +     int nb =3D 0;
> >
> >       rmem =3D atomic_read(&sk->sk_rmem_alloc);
> >       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> >       size =3D skb->truesize;
> >
> > +     udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()];
>
> There is a small chance that a cpu enqueues to this queue and no
> further arrivals on that numa node happen, stranding skbs on this
> intermediate queue, right? If so, those are leaked on
> udp_destruct_common.

There is absolutely 0 chance this can occur.

This is because I use llist_add() return value to decide to either :

A) Queue was empty, I am the first cpu to add a packet, I am elected
to drain this queue.

     A.1 Grab the spinlock  (competing with recvmsg() or other cpus on
other NUMA nodes)
           While waiting my turn in this spinlock acquisition, other
cpus can add more packets
            to the per-NUMA queue I was elected to drain.

     A.2  llist_del_all() to drain the Queue. I got my skb but
possibly others as well.

            After llist_del_all(), one other cpu trying to add a new
packet will eventually see the queue was empty again
           and will be elected to serve it. It will go to A.1 and A.2

B)  Return immediately because there were other packets in the Queue,
so I know one other
    cpu is in A.1 or before A.2


All A) and B) are under rcu lock, so udp_destruct_common() will not run.


>
> > +
> > +     rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> > +
> >       /* Immediately drop when the receive queue is full.
> >        * Cast to unsigned int performs the boundary check for INT_MAX.
> >        */
> > @@ -1747,45 +1737,75 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> >       if (rmem > (rcvbuf >> 1)) {
> >               skb_condense(skb);
> >               size =3D skb->truesize;
> > -             rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);
> > -             if (rmem > rcvbuf)
> > -                     goto uncharge_drop;
> > -             busy =3D busylock_acquire(sk);
> > -     } else {
> > -             atomic_add(size, &sk->sk_rmem_alloc);
> >       }
> >
> >       udp_set_dev_scratch(skb);
> >
> > +     atomic_add(size, &udp_prod_queue->rmem_alloc);
> > +
> > +     if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
> > +             return 0;
> > +
> >       spin_lock(&list->lock);
> > -     err =3D udp_rmem_schedule(sk, size);
> > -     if (err) {
> > -             spin_unlock(&list->lock);
> > -             goto uncharge_drop;
> > -     }
> >
> > -     sk_forward_alloc_add(sk, -size);
> > +     ll_list =3D llist_del_all(&udp_prod_queue->ll_root);
> >
> > -     /* no need to setup a destructor, we will explicitly release the
> > -      * forward allocated memory on dequeue
> > -      */
> > -     sock_skb_set_dropcount(sk, skb);
> > +     ll_list =3D llist_reverse_order(ll_list);
> > +
> > +     llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> > +             size =3D udp_skb_truesize(skb);
> > +             total_size +=3D size;
> > +             err =3D udp_rmem_schedule(sk, size);
> > +             if (unlikely(err)) {
> > +                     /*  Free the skbs outside of locked section. */
> > +                     skb->next =3D to_drop;
> > +                     to_drop =3D skb;
> > +                     continue;
> > +             }
> > +
> > +             q_size +=3D size;
> > +             sk_forward_alloc_add(sk, -size);
> > +
> > +             /* no need to setup a destructor, we will explicitly rele=
ase the
> > +              * forward allocated memory on dequeue
> > +              */
> > +             sock_skb_set_dropcount(sk, skb);
>
> Since drop counters are approximate, read these once and report the
> same for all packets in a batch?

Good idea, thanks !
(My test receiver was not setting SOCK_RXQ_OVFL)

I can squash in V4 , or add this as a separate patch.

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fce1d0ffd6361d271ae3528fea026a8d6c07ac6e..95241093b7f01b2dc31d9520b69=
3f46400e545ff
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1706,6 +1706,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
        int size, err =3D -ENOMEM;
        int total_size =3D 0;
        int q_size =3D 0;
+       int dropcount;
        int nb =3D 0;

        rmem =3D atomic_read(&sk->sk_rmem_alloc);
@@ -1746,6 +1747,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
        if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
                return 0;

+       dropcount =3D sock_flag(sk, SOCK_RXQ_OVFL) ? sk_drops_read(sk) : 0;
+
        spin_lock(&list->lock);

        ll_list =3D llist_del_all(&udp_prod_queue->ll_root);
@@ -1769,7 +1772,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
                /* no need to setup a destructor, we will explicitly releas=
e the
                 * forward allocated memory on dequeue
                 */
-               sock_skb_set_dropcount(sk, skb);
+               SOCK_SKB_CB(skb)->dropcount =3D dropcount;
                nb++;
                __skb_queue_tail(list, skb);
        }

