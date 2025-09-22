Return-Path: <netdev+bounces-225251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0286B91254
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED93189E8E3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E831FDA82;
	Mon, 22 Sep 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI+mpt0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6973064BC
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544726; cv=none; b=MUAkRQvlxZJV30zLU6qHsHpMuMSKYLff+T8CgYAGmIazHHpqZ6chWp+0Ip4JyTZF7om1V+HwDGxJCkSPyAV9G84v0JQ81S6AT48QuKpX2me7jcZLgSdX+LTitgRqhpWi3Cj/GKEY18zZj2ejhDm2O/NuoyeZaS3ylcxBXRnJ1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544726; c=relaxed/simple;
	bh=Iyv4K1m7weBZ4VDEz8nq8rpOXote+U+kbJ5Ko1FeMf0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bVLoPM4QYuwQsa8HEhouuJrA0QsxVBseI8IgyeuRFilcwWWbknSWburr8fLJwSiS37aVtuJtPBKAzWbqt7uYhP3kOYwVmW5MDfkqdZuxgB2b5pe+M5PJ3PXT1eDervJs7SUUZMFdWClpuLA8I7QUSlYRXF6nYNr+nq6bkkGsv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI+mpt0V; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c6b9fcso40032341cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544723; x=1759149523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAH346XH8Zo9ISlMqWcIVck70XmrmSsMRfM/qKrsTe4=;
        b=bI+mpt0VU/u2dyzaz3VQzt4Ywy4hJm00nFiPX+/UaobRoCWslZ6nBqJ3CJXGnclGeu
         QCCwNW0vQBlvS99ShVIu2NPGhjktCT0GW1uDmhjl+paTGiPolOHaj9BeGD+4IiLlac7i
         TmAGAXgaKatmqoV1RBn2iQD2rG7m+89XrPtjwJd/m4cRieJnzY1yZdRb5hf0ttSPJKro
         K2MQ5CSit665rxy+/Kq43EijS/7bnu35z0navJK0RVbR28i/pE945JfB87WiGgDEDVhB
         c1xAwfmosNeU5hBPHQDwcvzaj4BGDKQQL0xjHHvoaUOYywt+8LzMdKJ0E/cxjSyv2xeV
         jvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544723; x=1759149523;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lAH346XH8Zo9ISlMqWcIVck70XmrmSsMRfM/qKrsTe4=;
        b=KndCHwZf/GxGB83DcsphL15Wlgbbm7t8s55bKLzRYvOuruYG7DuV1nm/D0sZe2KT/q
         KeJ5H+OxzYtbWTTTJTgQ5pUDsfSpl9utdCBuCaq0ox8/8kerciSosSMx8ZwFgy5bNJe2
         13YNaNMe7S15zrvja5S/fgqyphQ2SWz0rQ7U16pjc/2BU+ftACTs9JckR8EuSG5gl2u3
         PACthzkfuLnBPOhxYpUpQHWcrj3p87V9YEouC1pmo/3FU7SffyN7XJNPHZo5yInh8AnE
         W+3A2T2Os3xl+kSsdn6kvksMS2yNDqMlTsX87UMGqVb0unIYRG2LTdOcgl3Yg74Xkric
         icNw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+TlacPQKoVdpkUxI14TCpooWwUFprgXgvRO/pXgcq4SsCjYJVw+JRBkonYTcvvDdRiecHJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynobsl9AioS8Bywanlolih8zTLbPYk1Wx7XtyHw4G75HX68T/8
	aeDtGAn8RuJPo30tkMZtm4RItqD/lYcpzWg5N28kI8A5svntMUTabNGc
X-Gm-Gg: ASbGncuGgBAL87WBFCWVfVIZVR24r+iAYl8CU0IkUoKlzCI5aiAZ1K57tSKrApOySKa
	jeXsjldkZopL9uqCunO7ivYOm3LbcACn6Bs95e4Oo6b4LIvJFpE+cM7/eNYhRl1G4VD8POJcuLP
	T/XRF+DVk/XZmupBfxrcItFg4STdonZ7D/hCP0PSVlb/tmHfZC0Sbk18tIkHeq3zvaoO64gq6Va
	pEM917BF/ZmIGiJTvyw/8BD8HMPwCHGPF7SnGLJyGXspRcfhiAj+SNxKpXI7zBWwM08RtBEqu7k
	7fcrw+P3JxjrG8H9vStB9IPdPIpLquYjKu3WTM92q8b9U1ZypVBOVwoWxRev44/nGhS0HIjUE28
	hTsYvuhJ7WhkPe7ELEj8JPoJqPu8t3CKctQAS6QgkXZfMGBFPQ0ZPXa++CnLtieSPLfLBrg==
X-Google-Smtp-Source: AGHT+IHRk8qHaLGAqBJHMt1ynW0MPqUtHyFmTGhst0KGbNNHZEw3FENIOsDjx2iIY339rXwfWTEcjQ==
X-Received: by 2002:ac8:5e52:0:b0:4b4:8ee1:7d98 with SMTP id d75a77b69052e-4c06cbe9172mr155258571cf.8.1758544723256;
        Mon, 22 Sep 2025 05:38:43 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-79344899fe6sm71552306d6.10.2025.09.22.05.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:38:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:38:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.16b82d42e11ef@gmail.com>
In-Reply-To: <CANn89iKzgg9fFJdmEZcJkvc7Q1d-R=ZyrOc+E9zdA7LXaTd8Jg@mail.gmail.com>
References: <20250921095802.875191-1-edumazet@google.com>
 <willemdebruijn.kernel.1fae2e81b156b@gmail.com>
 <CANn89iKzgg9fFJdmEZcJkvc7Q1d-R=ZyrOc+E9zdA7LXaTd8Jg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Sun, Sep 21, 2025 at 7:21=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > busylock was protecting UDP sockets against packet floods,
> > > but unfortunately was not protecting the host itself.
> > >
> > > Under stress, many cpus could spin while acquiring the busylock,
> > > and NIC had to drop packets. Or packets would be dropped
> > > in cpu backlog if RPS/RFS were in place.
> > >
> > > This patch replaces the busylock by intermediate
> > > lockless queues. (One queue per NUMA node).
> > >
> > > This means that fewer number of cpus have to acquire
> > > the UDP receive queue lock.
> > >
> > > Most of the cpus can either:
> > > - immediately drop the packet.
> > > - or queue it in their NUMA aware lockless queue.
> > >
> > > Then one of the cpu is chosen to process this lockless queue
> > > in a batch.
> > >
> > > The batch only contains packets that were cooked on the same
> > > NUMA node, thus with very limited latency impact.
> > >
> > > Tested:
> > >
> > > DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes=

> > > (Intel(R) Xeon(R) 6985P-C)
> > >
> > > Before:
> > >
> > > nstat -n ; sleep 1 ; nstat | grep Udp
> > > Udp6InDatagrams                 1004179            0.0
> > > Udp6InErrors                    3117               0.0
> > > Udp6RcvbufErrors                3117               0.0
> > >
> > > After:
> > > nstat -n ; sleep 1 ; nstat | grep Udp
> > > Udp6InDatagrams                 1116633            0.0
> > > Udp6InErrors                    14197275           0.0
> > > Udp6RcvbufErrors                14197275           0.0
> > >
> > > We can see this host can now proces 14.2 M more packets per second
> > > while under attack, and the victim socket can receive 11 % more
> > > packets.
> >
> > Impressive gains under DoS!
> >
> > Main concern is that it adds an extra queue/dequeue and thus some
> > cycle cost for all udp sockets in the common case where they are not
> > contended. These are simple linked list operations, so I suppose the
> > only cost may be the cacheline if not warm. Busylock had the nice
> > property of only being used under mem pressure. Could this benefit
> > from the same?
> =

> I hear you, but the extra cache line is local to the node, compared to =
prior
> non-local  and shared cache line, especially on modern cpus (AMD Turin
> / Venice or Intel Granite Rapids)
> =

> This is a very minor cost, compared to the average delay between
> packet being received
> on the wire and being presented on __udp_enqueue_schedule_skb().
> =

> And the core of the lockless algorithm is that all packets go through
> the same logic.
> See my following answer.
> =

> >
> > > I used a small bpftrace program measuring time (in us) spent in
> > > __udp_enqueue_schedule_skb().
> > >
> > > Before:
> > >
> > > @udp_enqueue_us[398]:
> > > [0]                24901 |@@@                                      =
           |
> > > [1]                63512 |@@@@@@@@@                                =
           |
> > > [2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@|
> > > [4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     =
           |
> > > [8, 16)            54022 |@@@@@@@@                                 =
           |
> > > [16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        =
           |
> > > [32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       =
           |
> > > [64, 128)           4219 |                                         =
           |
> > > [128, 256)           188 |                                         =
           |
> > >
> > > After:
> > >
> > > @udp_enqueue_us[398]:
> > > [0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@|
> > > [1]              1111277 |@@@@@@@@@@                               =
           |
> > > [2, 4)            501439 |@@@@                                     =
           |
> > > [4, 8)            102921 |                                         =
           |
> > > [8, 16)            29895 |                                         =
           |
> > > [16, 32)           43500 |                                         =
           |
> > > [32, 64)           31552 |                                         =
           |
> > > [64, 128)            979 |                                         =
           |
> > > [128, 256)            13 |                                         =
           |
> > >
> > > Note that the remaining bottleneck for this platform is in
> > > udp_drops_inc() because we limited struct numa_drop_counters
> > > to only two nodes so far.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > > v3: - Moved kfree(up->udp_prod_queue) to udp_destruct_common(),
> > >       addressing reports from Jakub and syzbot.
> > >
> > >     - Perform SKB_DROP_REASON_PROTO_MEM drops after the queue
> > >       spinlock is released.
> > >
> > > v2: https://lore.kernel.org/netdev/20250920080227.3674860-1-edumaze=
t@google.com/
> > >     - Added a kfree(up->udp_prod_queue) in udpv6_destroy_sock() (Ja=
kub feedback on v1)
> > >     - Added bpftrace histograms in changelog.
> > >
> > > v1: https://lore.kernel.org/netdev/20250919164308.2455564-1-edumaze=
t@google.com/
> > >
> > >  include/linux/udp.h |   9 +++-
> > >  include/net/udp.h   |  11 ++++-
> > >  net/ipv4/udp.c      | 114 ++++++++++++++++++++++++++--------------=
----
> > >  net/ipv6/udp.c      |   5 +-
> > >  4 files changed, 88 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > > index e554890c4415b411f35007d3ece9e6042db7a544..58795688a18636ea79a=
a1f5d06eacc676a2e7849 100644
> > > --- a/include/linux/udp.h
> > > +++ b/include/linux/udp.h
> > > @@ -44,6 +44,12 @@ enum {
> > >       UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
> > >  };
> > >
> > > +/* per NUMA structure for lockless producer usage. */
> > > +struct udp_prod_queue {
> > > +     struct llist_head       ll_root ____cacheline_aligned_in_smp;=

> > > +     atomic_t                rmem_alloc;
> > > +};
> > > +
> > >  struct udp_sock {
> > >       /* inet_sock has to be the first member */
> > >       struct inet_sock inet;
> > > @@ -90,6 +96,8 @@ struct udp_sock {
> > >                                               struct sk_buff *skb,
> > >                                               int nhoff);
> > >
> > > +     struct udp_prod_queue *udp_prod_queue;
> > > +
> > >       /* udp_recvmsg try to use this before splicing sk_receive_que=
ue */
> > >       struct sk_buff_head     reader_queue ____cacheline_aligned_in=
_smp;
> > >
> > > @@ -109,7 +117,6 @@ struct udp_sock {
> > >        */
> > >       struct hlist_node       tunnel_list;
> > >       struct numa_drop_counters drop_counters;
> > > -     spinlock_t              busylock ____cacheline_aligned_in_smp=
;
> > >  };
> > >
> > >  #define udp_test_bit(nr, sk)                 \
> > > diff --git a/include/net/udp.h b/include/net/udp.h
> > > index 059a0cee5f559b8d75e71031a00d0aa2769e257f..cffedb3e40f24513e44=
fb7598c0ad917fd15b616 100644
> > > --- a/include/net/udp.h
> > > +++ b/include/net/udp.h
> > > @@ -284,16 +284,23 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struc=
t sk_buff *));
> > >  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> > >                                 netdev_features_t features, bool is=
_ipv6);
> > >
> > > -static inline void udp_lib_init_sock(struct sock *sk)
> > > +static inline int udp_lib_init_sock(struct sock *sk)
> > >  {
> > >       struct udp_sock *up =3D udp_sk(sk);
> > >
> > >       sk->sk_drop_counters =3D &up->drop_counters;
> > > -     spin_lock_init(&up->busylock);
> > >       skb_queue_head_init(&up->reader_queue);
> > >       INIT_HLIST_NODE(&up->tunnel_list);
> > >       up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> > >       set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> > > +
> > > +     up->udp_prod_queue =3D kcalloc(nr_node_ids, sizeof(*up->udp_p=
rod_queue),
> > > +                                  GFP_KERNEL);
> > > +     if (!up->udp_prod_queue)
> > > +             return -ENOMEM;
> > > +     for (int i =3D 0; i < nr_node_ids; i++)
> > > +             init_llist_head(&up->udp_prod_queue[i].ll_root);
> > > +     return 0;
> > >  }
> > >
> > >  static inline void udp_drops_inc(struct sock *sk)
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 85cfc32eb2ccb3e229177fb37910fefde0254ffe..fce1d0ffd6361d271ae=
3528fea026a8d6c07ac6e 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1685,25 +1685,6 @@ static void udp_skb_dtor_locked(struct sock =
*sk, struct sk_buff *skb)
> > >       udp_rmem_release(sk, udp_skb_truesize(skb), 1, true);
> > >  }
> > >
> > > -/* Idea of busylocks is to let producers grab an extra spinlock
> > > - * to relieve pressure on the receive_queue spinlock shared by con=
sumer.
> > > - * Under flood, this means that only one producer can be in line
> > > - * trying to acquire the receive_queue spinlock.
> > > - */
> > > -static spinlock_t *busylock_acquire(struct sock *sk)
> > > -{
> > > -     spinlock_t *busy =3D &udp_sk(sk)->busylock;
> > > -
> > > -     spin_lock(busy);
> > > -     return busy;
> > > -}
> > > -
> > > -static void busylock_release(spinlock_t *busy)
> > > -{
> > > -     if (busy)
> > > -             spin_unlock(busy);
> > > -}
> > > -
> > >  static int udp_rmem_schedule(struct sock *sk, int size)
> > >  {
> > >       int delta;
> > > @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *s=
k, int size)
> > >  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *sk=
b)
> > >  {
> > >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> > > +     struct udp_prod_queue *udp_prod_queue;
> > > +     struct sk_buff *next, *to_drop =3D NULL;
> > > +     struct llist_node *ll_list;
> > >       unsigned int rmem, rcvbuf;
> > > -     spinlock_t *busy =3D NULL;
> > >       int size, err =3D -ENOMEM;
> > > +     int total_size =3D 0;
> > > +     int q_size =3D 0;
> > > +     int nb =3D 0;
> > >
> > >       rmem =3D atomic_read(&sk->sk_rmem_alloc);
> > >       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> > >       size =3D skb->truesize;
> > >
> > > +     udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()=
];
> >
> > There is a small chance that a cpu enqueues to this queue and no
> > further arrivals on that numa node happen, stranding skbs on this
> > intermediate queue, right? If so, those are leaked on
> > udp_destruct_common.
> =

> There is absolutely 0 chance this can occur.
> =

> This is because I use llist_add() return value to decide to either :
> =

> A) Queue was empty, I am the first cpu to add a packet, I am elected
> to drain this queue.
> =

>      A.1 Grab the spinlock  (competing with recvmsg() or other cpus on
> other NUMA nodes)
>            While waiting my turn in this spinlock acquisition, other
> cpus can add more packets
>             to the per-NUMA queue I was elected to drain.
> =

>      A.2  llist_del_all() to drain the Queue. I got my skb but
> possibly others as well.
> =

>             After llist_del_all(), one other cpu trying to add a new
> packet will eventually see the queue was empty again
>            and will be elected to serve it. It will go to A.1 and A.2
> =

> B)  Return immediately because there were other packets in the Queue,
> so I know one other
>     cpu is in A.1 or before A.2
> =

> =

> All A) and B) are under rcu lock, so udp_destruct_common() will not run=
.

Of course. Thanks. Nice lockless multi-producer multi-consumer struct.
I had not seen it before. A try_cmpxchg and xchg pair, but on an
uncontended NUMA local cacheline in the normal case.
 =

> =

> >
> > > +
> > > +     rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> > > +
> > >       /* Immediately drop when the receive queue is full.
> > >        * Cast to unsigned int performs the boundary check for INT_M=
AX.
> > >        */
> > > @@ -1747,45 +1737,75 @@ int __udp_enqueue_schedule_skb(struct sock =
*sk, struct sk_buff *skb)
> > >       if (rmem > (rcvbuf >> 1)) {
> > >               skb_condense(skb);
> > >               size =3D skb->truesize;
> > > -             rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);=

> > > -             if (rmem > rcvbuf)
> > > -                     goto uncharge_drop;
> > > -             busy =3D busylock_acquire(sk);
> > > -     } else {
> > > -             atomic_add(size, &sk->sk_rmem_alloc);
> > >       }
> > >
> > >       udp_set_dev_scratch(skb);
> > >
> > > +     atomic_add(size, &udp_prod_queue->rmem_alloc);
> > > +
> > > +     if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
> > > +             return 0;
> > > +
> > >       spin_lock(&list->lock);
> > > -     err =3D udp_rmem_schedule(sk, size);
> > > -     if (err) {
> > > -             spin_unlock(&list->lock);
> > > -             goto uncharge_drop;
> > > -     }
> > >
> > > -     sk_forward_alloc_add(sk, -size);
> > > +     ll_list =3D llist_del_all(&udp_prod_queue->ll_root);
> > >
> > > -     /* no need to setup a destructor, we will explicitly release =
the
> > > -      * forward allocated memory on dequeue
> > > -      */
> > > -     sock_skb_set_dropcount(sk, skb);
> > > +     ll_list =3D llist_reverse_order(ll_list);
> > > +
> > > +     llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> > > +             size =3D udp_skb_truesize(skb);
> > > +             total_size +=3D size;
> > > +             err =3D udp_rmem_schedule(sk, size);
> > > +             if (unlikely(err)) {
> > > +                     /*  Free the skbs outside of locked section. =
*/
> > > +                     skb->next =3D to_drop;
> > > +                     to_drop =3D skb;
> > > +                     continue;
> > > +             }
> > > +
> > > +             q_size +=3D size;
> > > +             sk_forward_alloc_add(sk, -size);
> > > +
> > > +             /* no need to setup a destructor, we will explicitly =
release the
> > > +              * forward allocated memory on dequeue
> > > +              */
> > > +             sock_skb_set_dropcount(sk, skb);
> >
> > Since drop counters are approximate, read these once and report the
> > same for all packets in a batch?
> =

> Good idea, thanks !
> (My test receiver was not setting SOCK_RXQ_OVFL)
> =

> I can squash in V4 , or add this as a separate patch.
> =

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index fce1d0ffd6361d271ae3528fea026a8d6c07ac6e..95241093b7f01b2dc31d952=
0b693f46400e545ff
> 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1706,6 +1706,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
> struct sk_buff *skb)
>         int size, err =3D -ENOMEM;
>         int total_size =3D 0;
>         int q_size =3D 0;
> +       int dropcount;
>         int nb =3D 0;
> =

>         rmem =3D atomic_read(&sk->sk_rmem_alloc);
> @@ -1746,6 +1747,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
> struct sk_buff *skb)
>         if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
>                 return 0;
> =

> +       dropcount =3D sock_flag(sk, SOCK_RXQ_OVFL) ? sk_drops_read(sk) =
: 0;
> +
>         spin_lock(&list->lock);
> =

>         ll_list =3D llist_del_all(&udp_prod_queue->ll_root);
> @@ -1769,7 +1772,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
> struct sk_buff *skb)
>                 /* no need to setup a destructor, we will explicitly re=
lease the
>                  * forward allocated memory on dequeue
>                  */
> -               sock_skb_set_dropcount(sk, skb);
> +               SOCK_SKB_CB(skb)->dropcount =3D dropcount;
>                 nb++;
>                 __skb_queue_tail(list, skb);
>         }



