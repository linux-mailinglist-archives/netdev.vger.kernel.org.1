Return-Path: <netdev+bounces-216641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F09B34B8F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A307A428A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77DD1993B9;
	Mon, 25 Aug 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWCj9Bf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A8393DF3
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152961; cv=none; b=UO11rdQQxP3w4FXDWy/PZ3c1kJO5haIE1rbQA05ZihXIDsAgFEGFu6RqyKWbd1i9uAYNrhXulbE+H7wZOW2CL6w1RWwfmTV9FR0EYyqbdIa8U0/NYO6oTC1YaZpcbB5bXQhrPRSKq+o/coa5kD+kDdLFA+CwXNjyvQxhMsxw8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152961; c=relaxed/simple;
	bh=E9MYKKRf/3oCCBwz6/ddQxofLd4wgRdIJDzAWDfRaUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYMyH/u7deGoQrfGCZ9xzzlAbwZ9Er5/cmTjBAE/yqYHZpDiwPcBk85oveyk51In/dmncBoxq7dVCbaG2kdvSWgxtHU/mC7qvGPV4b11tcOUstA5sJ8dzeJ9xxZnQD8qUIgEni2VBpihElEi0uXNMoKNr/rLGBe2n801hBznvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWCj9Bf5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458272c00so56616975ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756152959; x=1756757759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z09GrQH4DOvKv6lKO55llRmcj5TTBArx7YH7GDKJk9s=;
        b=oWCj9Bf58Psqmbq58JuGaCKL6J9AvM8ppVVqWHz4R72h9fDWm9R4KFRurLoK1cwKXB
         82WkXkAy65ljOk/E9p6lr4tXi/Xxk7aO0I/4D9E/Rohs/s5OOXOHoVHEt6a5hY4Sg1XT
         vXYrMOYfaMcGEpQs74vo/9H1cN6ihb7pUy5l+HY7QjWZyzEXhHkT2dBUIq59jbrldpbQ
         X9R41lw00UwjwXhcB2VzXd6A2vF+eFkPcfhbq/nDnT6gof++qXZVyMeJ3BxUqBK/zTCn
         fRU+1IJk+d4yinx5T/8NWJiu6dK67qQOYLLn20jTUlB4lFa1kW/NqxSczPUhZoSVy6lO
         pQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152959; x=1756757759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z09GrQH4DOvKv6lKO55llRmcj5TTBArx7YH7GDKJk9s=;
        b=lHPZcuOL3/rHqHTMHTkwvhayT5xQCuHVm9mU9zrcaipXSsZsn89aFo50abVmDqZfkm
         pcb4uNuJL0RmmVXtfN4BSBO9oOM9w/0i+Y+9HSrGat4uhj6Zo6LApCeeW0ergVH5TbDe
         +yjN7XbR5chJ95sBS2KwCpUOCQPC/usvoetNZphccboCGYQge4cf377MWEzhoGf0N8Pm
         Lc7EN6gH1cOSLrzeMtEDM6BN/IjRdgTai7HRKwZq9L+AerT/kDRlkwk6jUXiaYkd69Nn
         Sec082jHp18o7IPIjZ1Iy1FL+10RZSQgJV3nzgmC6gUpk6jlN4VNAV1pKcJ1emITvdMj
         GcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9njIiFrgB+xCs4r0q+XQfkIKNOjEg02Bo+RVXp3oHBWVCWfKiXqhJcWlydXWiZaCMAHzbmgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFNjipgpGsD2smzlrzLL/PYH+4x0S6blPoPaOGE/xLyo1ql+k
	QKuM0Jg4sjJqpcQiYgKd9nia38JoW0JvbVMCqW2Hx3KWM2p16fMK7gMuIcIC4iy310XfE6foTio
	BcWz/3lJOewW8WPqk4SVMTyP6dxHSYOFn00Q3T41u
X-Gm-Gg: ASbGncta3ki6z7EqV41diPltBmxLZttxQp65B0yJOlQ/SaM7Lo59SFDvTsYPR6wf+ND
	h/hCgejJrJBzVDC/pFG3ccOcmMwLWJxjZwkZfj4un5oLei3i0GzlqFGn8c5aYNfdSj1GS9oBp1J
	niLD9hsx10Gnk6wqDuQkHGHUAlzNmH1Sd1lkBDN4NHEkup8B4EdRbgwkIbgT+SFbWNoSU5Ea+SQ
	axnTPFH401l4Zw69+C3nHrQ/MNO2VzAVaQ6FWpe6hMSaOby64F7L75pwz8RbQ+PHfFlMIcQTb7p
	dMPvwPLKyQ==
X-Google-Smtp-Source: AGHT+IHEIT8Y8RW6kP24/cPWrMfIcIY8mZuMo1j/ZV2yydxkCflVF0bYU6SUWZ6/gJVE77Su6Sb/JAV2IjDTvfdgrO8=
X-Received: by 2002:a17:903:22c5:b0:246:1c6a:702f with SMTP id
 d9443c01a7336-2462ee7b0fcmr165813065ad.20.1756152958294; Mon, 25 Aug 2025
 13:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-2-edumazet@google.com>
In-Reply-To: <20250825195947.4073595-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 13:15:46 -0700
X-Gm-Features: Ac12FXxLKPEsLdbO38RMnn2lzpzLwoqZZPK5N0TL6EhfIhchhNCZAkQyARd3KCU
Message-ID: <CAAVpQUBN5DsyQ2dhJ+zwqdugMTrZ2aXw5VnVyyru2v9MakxUDQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: add sk_drops_read(), sk_drops_inc() and
 sk_drops_reset() helpers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:59=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> We want to split sk->sk_drops in the future to reduce
> potential contention on this field.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  include/net/sock.h       | 17 ++++++++++++++++-
>  include/net/tcp.h        |  2 +-
>  net/core/datagram.c      |  2 +-
>  net/core/sock.c          | 14 +++++++-------
>  net/ipv4/ping.c          |  2 +-
>  net/ipv4/raw.c           |  6 +++---
>  net/ipv4/udp.c           | 14 +++++++-------
>  net/ipv6/datagram.c      |  2 +-
>  net/ipv6/raw.c           |  8 ++++----
>  net/ipv6/udp.c           |  6 +++---
>  net/iucv/af_iucv.c       |  4 ++--
>  net/netlink/af_netlink.c |  4 ++--
>  net/packet/af_packet.c   |  2 +-
>  net/phonet/pep.c         |  6 +++---
>  net/phonet/socket.c      |  2 +-
>  net/sctp/diag.c          |  2 +-
>  net/tipc/socket.c        |  6 +++---
>  17 files changed, 57 insertions(+), 42 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 63a6a48afb48ad31abf05f5108886bac9831842a..34d7029eb622773e40e7c4ebd=
422d33b1c0a7836 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2682,11 +2682,26 @@ struct sock_skb_cb {
>  #define sock_skb_cb_check_size(size) \
>         BUILD_BUG_ON((size) > SOCK_SKB_CB_OFFSET)
>
> +static inline void sk_drops_inc(struct sock *sk)
> +{
> +       atomic_inc(&sk->sk_drops);
> +}
> +
> +static inline int sk_drops_read(const struct sock *sk)
> +{
> +       return atomic_read(&sk->sk_drops);
> +}
> +
> +static inline void sk_drops_reset(struct sock *sk)
> +{
> +       atomic_set(&sk->sk_drops, 0);
> +}
> +
>  static inline void
>  sock_skb_set_dropcount(const struct sock *sk, struct sk_buff *skb)
>  {
>         SOCK_SKB_CB(skb)->dropcount =3D sock_flag(sk, SOCK_RXQ_OVFL) ?
> -                                               atomic_read(&sk->sk_drops=
) : 0;
> +                                               sk_drops_read(sk) : 0;
>  }
>
>  static inline void sk_drops_add(struct sock *sk, const struct sk_buff *s=
kb)
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2936b8175950faa777f81f3c6b7230bcc375d772..16dc9cebb9d25832eac7a6ad5=
90a9e9e47e85142 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2612,7 +2612,7 @@ static inline void tcp_segs_in(struct tcp_sock *tp,=
 const struct sk_buff *skb)
>   */
>  static inline void tcp_listendrop(const struct sock *sk)
>  {
> -       atomic_inc(&((struct sock *)sk)->sk_drops);
> +       sk_drops_inc((struct sock *)sk);
>         __NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
>  }
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 94cc4705e91da6ba6629ae469ae6507e9c6fdae9..ba8253aa6e07c2b0db361c9df=
daf66243dc1024c 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -345,7 +345,7 @@ int __sk_queue_drop_skb(struct sock *sk, struct sk_bu=
ff_head *sk_queue,
>                 spin_unlock_bh(&sk_queue->lock);
>         }
>
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>         return err;
>  }
>  EXPORT_SYMBOL(__sk_queue_drop_skb);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8002ac6293dcac694962be139eadfa6346b72d5b..75368823969a7992a55a6f40d=
87ffb8886de2f39 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -491,13 +491,13 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk=
_buff *skb)
>         struct sk_buff_head *list =3D &sk->sk_receive_queue;
>
>         if (atomic_read(&sk->sk_rmem_alloc) >=3D READ_ONCE(sk->sk_rcvbuf)=
) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 trace_sock_rcvqueue_full(sk, skb);
>                 return -ENOMEM;
>         }
>
>         if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 return -ENOBUFS;
>         }
>
> @@ -562,7 +562,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff =
*skb,
>         skb->dev =3D NULL;
>
>         if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 reason =3D SKB_DROP_REASON_SOCKET_RCVBUFF;
>                 goto discard_and_relse;
>         }
> @@ -585,7 +585,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff =
*skb,
>                         reason =3D SKB_DROP_REASON_PFMEMALLOC;
>                 if (err =3D=3D -ENOBUFS)
>                         reason =3D SKB_DROP_REASON_SOCKET_BACKLOG;
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 goto discard_and_relse;
>         }
>
> @@ -2505,7 +2505,7 @@ struct sock *sk_clone_lock(const struct sock *sk, c=
onst gfp_t priority)
>         newsk->sk_wmem_queued   =3D 0;
>         newsk->sk_forward_alloc =3D 0;
>         newsk->sk_reserved_mem  =3D 0;
> -       atomic_set(&newsk->sk_drops, 0);
> +       sk_drops_reset(newsk);
>         newsk->sk_send_head     =3D NULL;
>         newsk->sk_userlocks     =3D sk->sk_userlocks & ~SOCK_BINDPORT_LOC=
K;
>         atomic_set(&newsk->sk_zckey, 0);
> @@ -3713,7 +3713,7 @@ void sock_init_data_uid(struct socket *sock, struct=
 sock *sk, kuid_t uid)
>          */
>         smp_wmb();
>         refcount_set(&sk->sk_refcnt, 1);
> -       atomic_set(&sk->sk_drops, 0);
> +       sk_drops_reset(sk);
>  }
>  EXPORT_SYMBOL(sock_init_data_uid);
>
> @@ -3973,7 +3973,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem=
)
>         mem[SK_MEMINFO_WMEM_QUEUED] =3D READ_ONCE(sk->sk_wmem_queued);
>         mem[SK_MEMINFO_OPTMEM] =3D atomic_read(&sk->sk_omem_alloc);
>         mem[SK_MEMINFO_BACKLOG] =3D READ_ONCE(sk->sk_backlog.len);
> -       mem[SK_MEMINFO_DROPS] =3D atomic_read(&sk->sk_drops);
> +       mem[SK_MEMINFO_DROPS] =3D sk_drops_read(sk);
>  }
>
>  #ifdef CONFIG_PROC_FS
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 031df4c19fcc5ca18137695c78358c3ad96a2c4a..f119da68fc301be00719213ad=
33615b6754e6272 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -1119,7 +1119,7 @@ static void ping_v4_format_sock(struct sock *sp, st=
ruct seq_file *f,
>                 from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
>                 0, sock_i_ino(sp),
>                 refcount_read(&sp->sk_refcnt), sp,
> -               atomic_read(&sp->sk_drops));
> +               sk_drops_read(sp));
>  }
>
>  static int ping_v4_seq_show(struct seq_file *seq, void *v)
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 1d2c89d63cc71f39d742c8156879847fc4e53c71..0f9f02f6146eef6df3f5bbb4f=
564e16fbabd1ba2 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -178,7 +178,7 @@ static int raw_v4_input(struct net *net, struct sk_bu=
ff *skb,
>
>                 if (atomic_read(&sk->sk_rmem_alloc) >=3D
>                     READ_ONCE(sk->sk_rcvbuf)) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         continue;
>                 }
>
> @@ -311,7 +311,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buf=
f *skb)
>  int raw_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>         if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
>                 return NET_RX_DROP;
>         }
> @@ -1045,7 +1045,7 @@ static void raw_sock_seq_show(struct seq_file *seq,=
 struct sock *sp, int i)
>                 0, 0L, 0,
>                 from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
>                 0, sock_i_ino(sp),
> -               refcount_read(&sp->sk_refcnt), sp, atomic_read(&sp->sk_dr=
ops));
> +               refcount_read(&sp->sk_refcnt), sp, sk_drops_read(sp));
>  }
>
>  static int raw_seq_show(struct seq_file *seq, void *v)
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index cc3ce0f762ec211a963464c2dd7ac329a6be1ffd..732bdad43626948168bdb9e40=
c151787f047bbfd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1787,7 +1787,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, str=
uct sk_buff *skb)
>         atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>
>  drop:
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>         busylock_release(busy);
>         return err;
>  }
> @@ -1852,7 +1852,7 @@ static struct sk_buff *__first_packet_length(struct=
 sock *sk,
>                                         IS_UDPLITE(sk));
>                         __UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
>                                         IS_UDPLITE(sk));
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         __skb_unlink(skb, rcvq);
>                         *total +=3D skb->truesize;
>                         kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> @@ -2008,7 +2008,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t =
recv_actor)
>
>                 __UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
>                 __UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
>                 goto try_again;
>         }
> @@ -2078,7 +2078,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg=
, size_t len, int flags,
>
>         if (unlikely(err)) {
>                 if (!peeking) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         UDP_INC_STATS(sock_net(sk),
>                                       UDP_MIB_INERRORS, is_udplite);
>                 }
> @@ -2449,7 +2449,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, s=
truct sk_buff *skb)
>         __UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
>  drop:
>         __UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>         sk_skb_reason_drop(sk, skb, drop_reason);
>         return -1;
>  }
> @@ -2534,7 +2534,7 @@ static int __udp4_lib_mcast_deliver(struct net *net=
, struct sk_buff *skb,
>                 nskb =3D skb_clone(skb, GFP_ATOMIC);
>
>                 if (unlikely(!nskb)) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         __UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
>                                         IS_UDPLITE(sk));
>                         __UDP_INC_STATS(net, UDP_MIB_INERRORS,
> @@ -3386,7 +3386,7 @@ static void udp4_format_sock(struct sock *sp, struc=
t seq_file *f,
>                 from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
>                 0, sock_i_ino(sp),
>                 refcount_read(&sp->sk_refcnt), sp,
> -               atomic_read(&sp->sk_drops));
> +               sk_drops_read(sp));
>  }
>
>  int udp4_seq_show(struct seq_file *seq, void *v)
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index 972bf0426d599af43bfd2d0e4236592f34ec7866..33ebe93d80e3cb6d897a3c7f7=
14f94c395856023 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -1068,5 +1068,5 @@ void __ip6_dgram_sock_seq_show(struct seq_file *seq=
, struct sock *sp,
>                    0,
>                    sock_i_ino(sp),
>                    refcount_read(&sp->sk_refcnt), sp,
> -                  atomic_read(&sp->sk_drops));
> +                  sk_drops_read(sp));
>  }
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 4c3f8245c40f155f3efde0d7b8af50e0bef431c7..4026192143ec9f1b071f43874=
185bc367c950c67 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -163,7 +163,7 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int=
 nexthdr)
>
>                 if (atomic_read(&sk->sk_rmem_alloc) >=3D
>                     READ_ONCE(sk->sk_rcvbuf)) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         continue;
>                 }
>
> @@ -361,7 +361,7 @@ static inline int rawv6_rcv_skb(struct sock *sk, stru=
ct sk_buff *skb)
>
>         if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) =
&&
>             skb_checksum_complete(skb)) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
>                 return NET_RX_DROP;
>         }
> @@ -389,7 +389,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
>         struct raw6_sock *rp =3D raw6_sk(sk);
>
>         if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
>                 return NET_RX_DROP;
>         }
> @@ -414,7 +414,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
>
>         if (inet_test_bit(HDRINCL, sk)) {
>                 if (skb_checksum_complete(skb)) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_C=
SUM);
>                         return NET_RX_DROP;
>                 }
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6a68f77da44b55baed42b44c936902f865754140..a35ee6d693a8080b9009f61d2=
3fafd2465b8c625 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -524,7 +524,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg=
, size_t len,
>         }
>         if (unlikely(err)) {
>                 if (!peeking) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         SNMP_INC_STATS(mib, UDP_MIB_INERRORS);
>                 }
>                 kfree_skb(skb);
> @@ -908,7 +908,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, s=
truct sk_buff *skb)
>         __UDP6_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
>  drop:
>         __UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>         sk_skb_reason_drop(sk, skb, drop_reason);
>         return -1;
>  }
> @@ -1013,7 +1013,7 @@ static int __udp6_lib_mcast_deliver(struct net *net=
, struct sk_buff *skb,
>                 }
>                 nskb =3D skb_clone(skb, GFP_ATOMIC);
>                 if (unlikely(!nskb)) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         __UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
>                                          IS_UDPLITE(sk));
>                         __UDP6_INC_STATS(net, UDP_MIB_INERRORS,
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index cc2b3c44bc05a629d455e99369491b28b4b93884..6c717a7ef292831b49c1dca22=
ecc2bb7a7179b0f 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1187,7 +1187,7 @@ static void iucv_process_message(struct sock *sk, s=
truct sk_buff *skb,
>
>         IUCV_SKB_CB(skb)->offset =3D 0;
>         if (sk_filter(sk, skb)) {
> -               atomic_inc(&sk->sk_drops);      /* skb rejected by filter=
 */
> +               sk_drops_inc(sk);       /* skb rejected by filter */
>                 kfree_skb(skb);
>                 return;
>         }
> @@ -2011,7 +2011,7 @@ static int afiucv_hs_callback_rx(struct sock *sk, s=
truct sk_buff *skb)
>         skb_reset_network_header(skb);
>         IUCV_SKB_CB(skb)->offset =3D 0;
>         if (sk_filter(sk, skb)) {
> -               atomic_inc(&sk->sk_drops);      /* skb rejected by filter=
 */
> +               sk_drops_inc(sk);       /* skb rejected by filter */
>                 kfree_skb(skb);
>                 return NET_RX_SUCCESS;
>         }
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e2f7080dd5d7cd52722248b719c294cdccf70328..2b46c0cd752a313ad95cf17c4=
6237883d6b85293 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -356,7 +356,7 @@ static void netlink_overrun(struct sock *sk)
>                         sk_error_report(sk);
>                 }
>         }
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>  }
>
>  static void netlink_rcv_wake(struct sock *sk)
> @@ -2711,7 +2711,7 @@ static int netlink_native_seq_show(struct seq_file =
*seq, void *v)
>                            sk_wmem_alloc_get(s),
>                            READ_ONCE(nlk->cb_running),
>                            refcount_read(&s->sk_refcnt),
> -                          atomic_read(&s->sk_drops),
> +                          sk_drops_read(s),
>                            sock_i_ino(s)
>                         );
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f09272058106181e95367080dc821da69..9d42c4bd6e390c7212fc0a8dd=
e5cc14ba7a00d53 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2265,7 +2265,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>
>  drop_n_acct:
>         atomic_inc(&po->tp_drops);
> -       atomic_inc(&sk->sk_drops);
> +       sk_drops_inc(sk);
>         drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
>
>  drop_n_restore:
> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index 62527e1ebb883d2854bcdc5256cd48e85e5c5dbc..4db564d9d522b639e9527d48e=
aa42a1cd9fbfba7 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -376,7 +376,7 @@ static int pipe_do_rcv(struct sock *sk, struct sk_buf=
f *skb)
>
>         case PNS_PEP_CTRL_REQ:
>                 if (skb_queue_len(&pn->ctrlreq_queue) >=3D PNPIPE_CTRLREQ=
_MAX) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         break;
>                 }
>                 __skb_pull(skb, 4);
> @@ -397,7 +397,7 @@ static int pipe_do_rcv(struct sock *sk, struct sk_buf=
f *skb)
>                 }
>
>                 if (pn->rx_credits =3D=3D 0) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         err =3D -ENOBUFS;
>                         break;
>                 }
> @@ -567,7 +567,7 @@ static int pipe_handler_do_rcv(struct sock *sk, struc=
t sk_buff *skb)
>                 }
>
>                 if (pn->rx_credits =3D=3D 0) {
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         err =3D NET_RX_DROP;
>                         break;
>                 }
> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index 2b61a40b568e91e340130a9b589e2b7a9346643f..db2d552e9b32e384c332774b9=
9199108abd464f2 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -587,7 +587,7 @@ static int pn_sock_seq_show(struct seq_file *seq, voi=
d *v)
>                         from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
>                         sock_i_ino(sk),
>                         refcount_read(&sk->sk_refcnt), sk,
> -                       atomic_read(&sk->sk_drops));
> +                       sk_drops_read(sk));
>         }
>         seq_pad(seq, '\n');
>         return 0;
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 23359e522273f0377080007c75eb2c276945f781..996c2018f0e611bd0da2df2f7=
3e90e2f94c463d9 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -173,7 +173,7 @@ static int inet_sctp_diag_fill(struct sock *sk, struc=
t sctp_association *asoc,
>                 mem[SK_MEMINFO_WMEM_QUEUED] =3D sk->sk_wmem_queued;
>                 mem[SK_MEMINFO_OPTMEM] =3D atomic_read(&sk->sk_omem_alloc=
);
>                 mem[SK_MEMINFO_BACKLOG] =3D READ_ONCE(sk->sk_backlog.len)=
;
> -               mem[SK_MEMINFO_DROPS] =3D atomic_read(&sk->sk_drops);
> +               mem[SK_MEMINFO_DROPS] =3D sk_drops_read(sk);
>
>                 if (nla_put(skb, INET_DIAG_SKMEMINFO, sizeof(mem), &mem) =
< 0)
>                         goto errout;
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index e028bf6584992c5ab7307d81082fbe4582e78068..1574a83384f88533cfab330c5=
59512d5878bf0aa 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -2366,7 +2366,7 @@ static void tipc_sk_filter_rcv(struct sock *sk, str=
uct sk_buff *skb,
>                 else if (sk_rmem_alloc_get(sk) + skb->truesize >=3D limit=
) {
>                         trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL,
>                                            "err_overload2!");
> -                       atomic_inc(&sk->sk_drops);
> +                       sk_drops_inc(sk);
>                         err =3D TIPC_ERR_OVERLOAD;
>                 }
>
> @@ -2458,7 +2458,7 @@ static void tipc_sk_enqueue(struct sk_buff_head *in=
putq, struct sock *sk,
>                 trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL, "err_overload!=
");
>                 /* Overload =3D> reject message back to sender */
>                 onode =3D tipc_own_addr(sock_net(sk));
> -               atomic_inc(&sk->sk_drops);
> +               sk_drops_inc(sk);
>                 if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
>                         trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
>                                               "@sk_enqueue!");
> @@ -3657,7 +3657,7 @@ int tipc_sk_fill_sock_diag(struct sk_buff *skb, str=
uct netlink_callback *cb,
>             nla_put_u32(skb, TIPC_NLA_SOCK_STAT_SENDQ,
>                         skb_queue_len(&sk->sk_write_queue)) ||
>             nla_put_u32(skb, TIPC_NLA_SOCK_STAT_DROP,
> -                       atomic_read(&sk->sk_drops)))
> +                       sk_drops_read(sk)))
>                 goto stat_msg_cancel;
>
>         if (tsk->cong_link_cnt &&
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

