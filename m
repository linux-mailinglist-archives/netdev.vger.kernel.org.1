Return-Path: <netdev+bounces-224954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57488B8BCAF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 03:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDCF3A7AC1
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64617154BE2;
	Sat, 20 Sep 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NH+VC4yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DA156F45
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758331100; cv=none; b=P63Vyu4KUqrLMGcOdxb0e/0eqwzYw0liSI2vM6kMK+Dbi/WVUSMvLiX35y+BIZk79fojYvhj+dyhz8YBBKr9td9OprjOtS9hKFWSU2Rh7HZoM0kjnj0R24I+5ShffrgPnC5lIl6GeW1Ju8uGkoqJw8aE2y3U5jh/iMDTv9RgyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758331100; c=relaxed/simple;
	bh=Mrkvi5i+KJrUDOvl47cqKS4Kg122r5NcZzsTLurqwCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr26qtZLdO4niRnVTr3XE+70mNAzCDqnu9UtNdxHnWeq6Yj/AUEhUpvZdbrZmRAXl+3Q6Fov1F7katIuDBVTKX7iolajLei/ns04dgVP0cCXELLkpCaLThjkTJjs41dPCK82Kj+33SDj9IDgpdwDbtQjMmo97Xbkz/bYRWr7xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NH+VC4yk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330b4739538so964127a91.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758331098; x=1758935898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h81wbkWSgPTY7ChRrflzhd8CQh6ilQCuoD+lEC52yGo=;
        b=NH+VC4ykkjx+PsHTycZfSqupQ565SfzIKN1eOI7waPgZWPrLA6X46teSGwKlzGT8bT
         ZAPsqQgr3ItJcDPCVaD88LK1DHTPntaCK5948jPpuGcfA6Fr/QC7CR0Cl9HhIPxfK1Of
         75q6RYaFnJn6JvM0fMCZJOSUtevrmcUEWI/4wRiT3wlKtXZoTl3XoiSXuB6zGyK3+M3H
         BA7wTh4s3/MtPFZnJTnK6OP+s4rImSr4Oq6Cf4YHne/dhmhEXKpHFq3Yx4aCvcnyNfsA
         Qjevgs3TiWlKo9dzUDotAl7NL3OVQBUTXRm+UaINmko+tYsXf5rhrVIaAzLwhESUN1tY
         K/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758331098; x=1758935898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h81wbkWSgPTY7ChRrflzhd8CQh6ilQCuoD+lEC52yGo=;
        b=XA51saUSuA4ZlzkTdDeXsIKNtmrDv2X649GfKOz/zj43Snbz/c09I/hpqcbZCT6MIX
         xwY9uZ1mTtMUWxYBgoaEt3vQ1jMfRlGi7qIy1+HXH63ebLi16YzOTsthnsSYtcvuuiR9
         utEVFCRQxvbwwTcZMRb9/Up0TyWUxLk2kuROmvj/jCGH/GkibjGlUjPR27PgYcww1hGB
         VVBopZDqJV0aQE0ZVNKnEvHxqenRhRzJcaPhK3RM9i/C0KaCEA1IzIobO0c/D44Aa/A5
         GNbUn1XJymPsRddZ0HhI/xU6Zu3ZUtSsBMKUTAY8vbt/sy5B4icKAfcnIsfEGdRIBs06
         jxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF3thJpAbX28fmPgCNpFA2yi15R1pHE5pVtxoUNq7A33t9e0i1Gk8sExyqeIaRyci+IrH9fSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MNfTlux9ly/GCPxZTfEglRG24+Od6qOQpYMZIBLT3yNG0iNN
	uuhuZA/dcGuSLkiJhTMaX3Lmge3cPyj6Z8ZyuaW2GPUQciWlUm0HPWTbB0lmjHJPEWdJOAkSXRd
	dpjDFdGw5sd+xHHVhibCZcFY+bp3iLPl8t05I1K0sKooFR/b7hdRAmCWan2s=
X-Gm-Gg: ASbGnctd8v1hS2sk1cR/NTHgyJAE53PLNSdj7CC9arcELRRH/cAiCUhchKHueeJHYA1
	e4KASpu9CSZguK1hGpR78asofynsOJgMPIYoL1MDaCDso/IUB5SggNnT3Pwil54/290haq70TTR
	WASrxDRPrj/pjPUuG6e96wTNQoU1B+JzEhic7X5zuYMMVcdWDv8RSX5TCkT5sd6q6NBtC0d4lO5
	5ebQH4b67BirtWHZSFQFzbiB1KhX7ro3DtUsohgsYER1mSASoI=
X-Google-Smtp-Source: AGHT+IHNAUEqaPE35UgIwFYPsdxTqsoN2XFvRkrmmbqhYkuRmpdFtrBork7Cr2UvxdbYcbjCEaidDuGyNHC0uGMlp5A=
X-Received: by 2002:a17:90b:33c8:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-33097ff7032mr6918592a91.12.1758331097298; Fri, 19 Sep 2025
 18:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919164308.2455564-1-edumazet@google.com>
In-Reply-To: <20250919164308.2455564-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Sep 2025 18:18:06 -0700
X-Gm-Features: AS18NWCEVRkkqvaHAAOPnuvZFWdMsugbnnHBaE-V0KtSo1nD6PJ0DNX1pIMkXVQ
Message-ID: <CAAVpQUDz7PQHK68bMt2FVt2Zo473L7d-XHnAgpFNP6VwApSL-w@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: remove busylock and add per NUMA queues
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> busylock was protecting UDP sockets against packet floods,
> but unfortunately was not protecting the host itself.
>
> Under stress, many cpus could spin while acquiring the busylock,
> and NIC had to drop packets. Or packets would be dropped
> in cpu backlog if RPS/RFS were in place.
>
> This patch replaces the busylock by intermediate
> lockless queues. (One queue per NUMA node).
>
> This means that fewer number of cpus have to acquire
> the UDP receive queue lock.
>
> Most of the cpus can either:
> - immediately drop the packet.
> - or queue it in their NUMA aware lockless queue.
>
> Then one of the cpu is chosen to process this lockless queue
> in a batch.
>
> The batch only contains packets that were cooked on the same
> NUMA node, thus with very limited latency impact.
>
> Tested:
>
> DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes
> (Intel(R) Xeon(R) 6985P-C)
>
> Before:
>
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1004179            0.0
> Udp6InErrors                    3117               0.0
> Udp6RcvbufErrors                3117               0.0
>
> After:
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1116633            0.0
> Udp6InErrors                    14197275           0.0
> Udp6RcvbufErrors                14197275           0.0
>
> We can see this host can now proces 14.2 M more packets per second
> while under attack, and the victim socket can receive 11 % more
> packets.
>
> Note that the remaining bottleneck for this platform is in
> udp_drops_inc() because we limited struct numa_drop_counters
> to only two nodes so far.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/udp.h |  9 ++++-
>  include/net/udp.h   | 11 ++++-
>  net/ipv4/udp.c      | 99 ++++++++++++++++++++++++---------------------
>  net/ipv6/udp.c      |  5 ++-
>  4 files changed, 73 insertions(+), 51 deletions(-)
>
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index e554890c4415b411f35007d3ece9e6042db7a544..58795688a18636ea79aa1f5d0=
6eacc676a2e7849 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -44,6 +44,12 @@ enum {
>         UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
>  };
>
> +/* per NUMA structure for lockless producer usage. */
> +struct udp_prod_queue {
> +       struct llist_head       ll_root ____cacheline_aligned_in_smp;
> +       atomic_t                rmem_alloc;
> +};
> +
>  struct udp_sock {
>         /* inet_sock has to be the first member */
>         struct inet_sock inet;
> @@ -90,6 +96,8 @@ struct udp_sock {
>                                                 struct sk_buff *skb,
>                                                 int nhoff);
>
> +       struct udp_prod_queue *udp_prod_queue;
> +
>         /* udp_recvmsg try to use this before splicing sk_receive_queue *=
/
>         struct sk_buff_head     reader_queue ____cacheline_aligned_in_smp=
;
>
> @@ -109,7 +117,6 @@ struct udp_sock {
>          */
>         struct hlist_node       tunnel_list;
>         struct numa_drop_counters drop_counters;
> -       spinlock_t              busylock ____cacheline_aligned_in_smp;
>  };
>
>  #define udp_test_bit(nr, sk)                   \
> diff --git a/include/net/udp.h b/include/net/udp.h
> index eecd64097f91196897f45530540b9c9b68c5ba4e..ae750324bc87a79d0e9182c55=
89371d82be3e3ee 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -284,16 +284,23 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_b=
uff *));
>  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>                                   netdev_features_t features, bool is_ipv=
6);
>
> -static inline void udp_lib_init_sock(struct sock *sk)
> +static inline int udp_lib_init_sock(struct sock *sk)
>  {
>         struct udp_sock *up =3D udp_sk(sk);
>
>         sk->sk_drop_counters =3D &up->drop_counters;
> -       spin_lock_init(&up->busylock);
>         skb_queue_head_init(&up->reader_queue);
>         INIT_HLIST_NODE(&up->tunnel_list);
>         up->forward_threshold =3D sk->sk_rcvbuf >> 2;
>         set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> +
> +       up->udp_prod_queue =3D kcalloc(nr_node_ids, sizeof(*up->udp_prod_=
queue),
> +                                    GFP_KERNEL);
> +       if (!up->udp_prod_queue)
> +               return -ENOMEM;
> +       for (int i =3D 0; i < nr_node_ids; i++)
> +               init_llist_head(&up->udp_prod_queue[i].ll_root);
> +       return 0;
>  }
>
>  static inline void udp_drops_inc(struct sock *sk)
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0c40426628eb2306b609881341a51307c4993871..f2d95fe18aec8f317ab33b4ed=
3306149fce6690b 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1685,25 +1685,6 @@ static void udp_skb_dtor_locked(struct sock *sk, s=
truct sk_buff *skb)
>         udp_rmem_release(sk, udp_skb_truesize(skb), 1, true);
>  }
>
> -/* Idea of busylocks is to let producers grab an extra spinlock
> - * to relieve pressure on the receive_queue spinlock shared by consumer.
> - * Under flood, this means that only one producer can be in line
> - * trying to acquire the receive_queue spinlock.
> - */
> -static spinlock_t *busylock_acquire(struct sock *sk)
> -{
> -       spinlock_t *busy =3D &udp_sk(sk)->busylock;
> -
> -       spin_lock(busy);
> -       return busy;
> -}
> -
> -static void busylock_release(spinlock_t *busy)
> -{
> -       if (busy)
> -               spin_unlock(busy);
> -}
> -
>  static int udp_rmem_schedule(struct sock *sk, int size)
>  {
>         int delta;
> @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, int=
 size)
>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  {
>         struct sk_buff_head *list =3D &sk->sk_receive_queue;
> +       struct udp_prod_queue *udp_prod_queue;
> +       struct llist_node *ll_list;
>         unsigned int rmem, rcvbuf;
> -       spinlock_t *busy =3D NULL;
>         int size, err =3D -ENOMEM;
> +       struct sk_buff *next;
> +       int total_size =3D 0;
> +       int q_size =3D 0;
> +       int nb =3D 0;
>
>         rmem =3D atomic_read(&sk->sk_rmem_alloc);
>         rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
>         size =3D skb->truesize;
>
> +       udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()];
> +
> +       rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> +
>         /* Immediately drop when the receive queue is full.
>          * Cast to unsigned int performs the boundary check for INT_MAX.
>          */
> @@ -1747,45 +1737,60 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
>         if (rmem > (rcvbuf >> 1)) {
>                 skb_condense(skb);
>                 size =3D skb->truesize;
> -               rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);
> -               if (rmem > rcvbuf)
> -                       goto uncharge_drop;
> -               busy =3D busylock_acquire(sk);
> -       } else {
> -               atomic_add(size, &sk->sk_rmem_alloc);
>         }
>
>         udp_set_dev_scratch(skb);
>
> +       atomic_add(size, &udp_prod_queue->rmem_alloc);
> +
> +       if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
> +               return 0;
> +
>         spin_lock(&list->lock);
> -       err =3D udp_rmem_schedule(sk, size);
> -       if (err) {
> -               spin_unlock(&list->lock);
> -               goto uncharge_drop;
> -       }
>
> -       sk_forward_alloc_add(sk, -size);
> +       ll_list =3D llist_del_all(&udp_prod_queue->ll_root);
>
> -       /* no need to setup a destructor, we will explicitly release the
> -        * forward allocated memory on dequeue
> -        */
> -       sock_skb_set_dropcount(sk, skb);
> +       ll_list =3D llist_reverse_order(ll_list);
> +
> +       llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> +               size =3D udp_skb_truesize(skb);
> +               total_size +=3D size;
> +               err =3D udp_rmem_schedule(sk, size);
> +               if (err) {
> +                       udp_drops_inc(sk);
> +                       // TODO update SNMP values.
> +                       sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO=
_MEM);

Could using skb_attempt_defer_free() here and
cpu_to_node(skb->alloc_cpu) for prod_queue selection help further ?

Or cache miss of alloc_cpu and defer_lock & IPI could be
rather expensive under DDoS ?


> +                       continue;
> +               }
> +
> +               q_size +=3D size;
> +               sk_forward_alloc_add(sk, -size);
> +
> +               /* no need to setup a destructor, we will explicitly rele=
ase the
> +                * forward allocated memory on dequeue
> +                */
> +               sock_skb_set_dropcount(sk, skb);
> +               nb++;
> +               __skb_queue_tail(list, skb);
> +       }
> +
> +       atomic_add(q_size, &sk->sk_rmem_alloc);
>
> -       __skb_queue_tail(list, skb);
>         spin_unlock(&list->lock);
>
> -       if (!sock_flag(sk, SOCK_DEAD))
> -               INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk)=
;
> +       atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
>
> -       busylock_release(busy);
> -       return 0;
> +       if (!sock_flag(sk, SOCK_DEAD)) {
> +               while (nb) {
> +                       INDIRECT_CALL_1(sk->sk_data_ready, sock_def_reada=
ble, sk);
> +                       nb--;
> +               }
> +       }
>
> -uncharge_drop:
> -       atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +       return 0;
>
>  drop:
>         udp_drops_inc(sk);
> -       busylock_release(busy);
>         return err;
>  }
>  EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
> @@ -1814,10 +1819,11 @@ static void udp_destruct_sock(struct sock *sk)
>
>  int udp_init_sock(struct sock *sk)
>  {
> -       udp_lib_init_sock(sk);
> +       int res =3D udp_lib_init_sock(sk);
> +
>         sk->sk_destruct =3D udp_destruct_sock;
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> -       return 0;
> +       return res;
>  }
>
>  void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
> @@ -2906,6 +2912,7 @@ void udp_destroy_sock(struct sock *sk)
>                         udp_tunnel_cleanup_gro(sk);
>                 }
>         }
> +       kfree(up->udp_prod_queue);
>  }
>
>  typedef struct sk_buff *(*udp_gro_receive_t)(struct sock *sk,
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 9f4d340d1e3a63d38f80138ef9f6aac4a33afa05..813a2ba75824d14631642bf69=
73f65063b2825cb 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -67,10 +67,11 @@ static void udpv6_destruct_sock(struct sock *sk)
>
>  int udpv6_init_sock(struct sock *sk)
>  {
> -       udp_lib_init_sock(sk);
> +       int res =3D udp_lib_init_sock(sk);
> +
>         sk->sk_destruct =3D udpv6_destruct_sock;
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> -       return 0;
> +       return res;
>  }
>
>  INDIRECT_CALLABLE_SCOPE
> --
> 2.51.0.470.ga7dc726c21-goog
>

