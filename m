Return-Path: <netdev+bounces-86281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF8989E4DB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F061C21265
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE745158871;
	Tue,  9 Apr 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpF5X4xW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60D157E6E
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697538; cv=none; b=jNcRLuF9TD7z1E5KuxjVqJPsTGJJlpyRS8GZXOmBtU+fznNHdUvuT/6jtA4pybyqqdGBOkeSI9PzpfMYtJqo2kP9gsNKSBvz4IBTWM7+E70suKuNFWZLQjXiHfTSJi9eWNS24BJQTung5Zydspkj89IHP6y9acwIQR92e5MLJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697538; c=relaxed/simple;
	bh=BA5gPBL3jUsQQ4rbmJEhSjcLjBX46a4FXMt077qU+sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKoeSOwOT6JuCXq1Dx45D6ATQOoDi3raerpOLfbOvpy/rHSqZYKUE9HX/gSLIS9N8Th8DbcVcJzMgkQg4/LMjhUeZhDihwStyZr5X7HJsLzwKTRhViHza8JNZzMMXJYQf4C6NY1bREdJWelNwYGw3OqnbyKCsPY9kjERnlhBbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpF5X4xW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso1548a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712697534; x=1713302334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFRXiE3IzsOWqIv5bkztOHx0+/n7Ympdv9FxPWOr3y8=;
        b=RpF5X4xWJuZFIu3GJHQA8/D3xXcNlUYrkFpClcfqCtkRLXGrjxBh/mRpCacY6vkP30
         IuUlD8xJt5ofeSb0gPOQ4u99uulDdOW1haKpxZbzJYkedNinnhKly0E+HvVX99PMnNdL
         53R31rN57/+QHT0yojpSEqcVrNlCKqOD680A38UofKZhRcJUqToW2DS+I8Xnstne1NP5
         fFHIYhtb9Ufbh4UPoY6Nz/xtv0vuPIs0Dwp0q6k+AoU7RxWJlHmSQ7toJJUdafM4+1OV
         9AXk8vuti/gwVzq/MzE2Ya01mWI6sjl3GPZGkd0xCvLOK4DvzEvN98FKGFO0g1fQwv3G
         qjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712697534; x=1713302334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFRXiE3IzsOWqIv5bkztOHx0+/n7Ympdv9FxPWOr3y8=;
        b=luwmUpQKBdJ5wK3qk2tt6Fg44OO1qpKFBnHNI56Ig67SSZMbGWAqyNqVoQnkTFlU/3
         fpY0E0FE35o+7ZA1bAtqcB7Uzm2X9epQiMr34x7l15jk+z+EFi9ofig7PEoWeWCY/HjM
         lg01eo1HIs6s9OC9hkziE2059uq5z1STeypd5A33GjMTQoRwVuLEoOefkRUkrV2bs4m2
         +a//d9Rm5lvidGKjKinjTnljShQP+tvKh6Ihbg2N0baSQpW/R6Xqpy3tl8X4nLEV6r7Z
         BBu574G+QZCRJYe3VYTrFNop5n5McPkX7SHUAsBSDDmB7noKnQ2V4vS+SFGzxWfr6jl9
         RXQw==
X-Gm-Message-State: AOJu0Yw+BKgJTM5zlskFmAa7nREfCVfgJZd/MrmdOeHfiWGBlG9wOgCz
	YJal7T/kKi4LZEyoUNbodLLq9RDhZhUaUh/xcYGZ4aSmOTl9ypxCt8ekf74YEU46NYDWVqUgtB9
	1ZDA3sUumNWenOodRSlBXz1dAZzbxpt0ybabc
X-Google-Smtp-Source: AGHT+IGreLjprjV1HoI3Ylz1zrqNzQE9zAkGSM55Wcpk3Ebbw6jn7g0vsuStlyR6+KvyOi8lT9DbQP5ouZzbqZnRk8Q=
X-Received: by 2002:aa7:d359:0:b0:56e:ac4:e1f3 with SMTP id
 m25-20020aa7d359000000b0056e0ac4e1f3mr4744edr.7.1712697534054; Tue, 09 Apr
 2024 14:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409205300.1346681-1-zijianzhang@bytedance.com> <20240409205300.1346681-2-zijianzhang@bytedance.com>
In-Reply-To: <20240409205300.1346681-2-zijianzhang@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 23:18:40 +0200
Message-ID: <CANn89iL5T9KzoQetcRQKfZCMbwtbfB9B3EzoYXYcKgZS86FZXA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:53=E2=80=AFPM <zijianzhang@bytedance.com> wrote:
>
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. The overhead of such sometimes
> might be more than the CPU savings from zerocopy. We try to solve this
> problem with a new option for TCP and UDP, MSG_ZEROCOPY_UARG.
> This new mechanism aims to reduce the overhead associated with receiving
> notifications by embedding them directly into user arguments passed with
> each sendmsg control message. By doing so, we can significantly reduce
> the complexity and overhead for managing notifications. In an ideal
> pattern, the user will keep calling sendmsg with MSG_ZEROCOPY_UARG
> flag, and the notification will be delivered as soon as possible.
>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  include/linux/skbuff.h                  |   7 +-
>  include/linux/socket.h                  |   1 +
>  include/linux/tcp.h                     |   3 +
>  include/linux/udp.h                     |   3 +
>  include/net/sock.h                      |  17 +++
>  include/net/udp.h                       |   1 +
>  include/uapi/asm-generic/socket.h       |   2 +
>  include/uapi/linux/socket.h             |  17 +++
>  net/core/skbuff.c                       | 137 ++++++++++++++++++++++--
>  net/core/sock.c                         |  50 +++++++++
>  net/ipv4/ip_output.c                    |   6 +-
>  net/ipv4/tcp.c                          |   7 +-
>  net/ipv4/udp.c                          |   9 ++
>  net/ipv6/ip6_output.c                   |   5 +-
>  net/ipv6/udp.c                          |   9 ++
>  net/vmw_vsock/virtio_transport_common.c |   2 +-
>  16 files changed, 258 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 03ea36a82cdd..19b94ba01007 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1663,12 +1663,14 @@ static inline void skb_set_end_offset(struct sk_b=
uff *skb, unsigned int offset)
>  #endif
>
>  struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> -                                      struct ubuf_info *uarg);
> +                                      struct ubuf_info *uarg, bool user_=
args_notification);
>
>  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
>
>  void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
>                            bool success);
> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info *u=
arg,
> +                          bool success);
>
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>                             struct sk_buff *skb, struct iov_iter *from,
> @@ -1763,7 +1765,8 @@ static inline void net_zcopy_put(struct ubuf_info *=
uarg)
>  static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have=
_uref)
>  {
>         if (uarg) {
> -               if (uarg->callback =3D=3D msg_zerocopy_callback)
> +               if (uarg->callback =3D=3D msg_zerocopy_callback ||
> +                       uarg->callback =3D=3D msg_zerocopy_uarg_callback)
>                         msg_zerocopy_put_abort(uarg, have_uref);
>                 else if (have_uref)
>                         net_zcopy_put(uarg);
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 139c330ccf2c..de01392344e1 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -326,6 +326,7 @@ struct ucred {
>                                           * plain text and require encryp=
tion
>                                           */
>
> +#define MSG_ZEROCOPY_UARG      0x2000000 /* MSG_ZEROCOPY with UARG notif=
ications */
>  #define MSG_ZEROCOPY   0x4000000       /* Use user data in kernel path *=
/
>  #define MSG_SPLICE_PAGES 0x8000000     /* Splice the pages from the iter=
ator in sendmsg() */
>  #define MSG_FASTOPEN   0x20000000      /* Send data in TCP SYN */
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 55399ee2a57e..e973f4990646 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -501,6 +501,9 @@ struct tcp_sock {
>          */
>         struct request_sock __rcu *fastopen_rsk;
>         struct saved_syn *saved_syn;
> +
> +/* TCP MSG_ZEROCOPY_UARG related information */
> +       struct tx_msg_zcopy_queue tx_zcopy_queue;
>  };
>
>  enum tsq_enum {
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..502b393eac67 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -95,6 +95,9 @@ struct udp_sock {
>
>         /* Cache friendly copy of sk->sk_peek_off >=3D 0 */
>         bool            peeking_with_offset;
> +
> +       /* This field is used by sendmsg zcopy user arg mode notification=
 */
> +       struct tx_msg_zcopy_queue tx_zcopy_queue;
>  };
>
>  #define udp_test_bit(nr, sk)                   \
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2253eefe2848..f7c045e98213 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -544,6 +544,23 @@ struct sock {
>         netns_tracker           ns_tracker;
>  };
>
> +struct tx_msg_zcopy_node {
> +       struct list_head node;
> +       struct tx_msg_zcopy_info info;
> +       struct sk_buff *skb;
> +};
> +
> +struct tx_msg_zcopy_queue {
> +       struct list_head head;
> +       spinlock_t lock; /* protects head queue */
> +};
> +
> +static inline void tx_message_zcopy_queue_init(struct tx_msg_zcopy_queue=
 *q)
> +{
> +       spin_lock_init(&q->lock);
> +       INIT_LIST_HEAD(&q->head);
> +}
> +
>  enum sk_pacing {
>         SK_PACING_NONE          =3D 0,
>         SK_PACING_NEEDED        =3D 1,
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 488a6d2babcc..9e4d7b128de4 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -182,6 +182,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
>         skb_queue_head_init(&up->reader_queue);
>         up->forward_threshold =3D sk->sk_rcvbuf >> 2;
>         set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> +       tx_message_zcopy_queue_init(&up->tx_zcopy_queue);
>  }
>
>  /* hash routines shared between UDPv4/6 and UDP-Litev4/6 */
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 8ce8a39a1e5f..86aa4b5cb7f1 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SO_ZEROCOPY_NOTIFICATION 78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> index d3fcd3b5ec53..469ed8f4e6c8 100644
> --- a/include/uapi/linux/socket.h
> +++ b/include/uapi/linux/socket.h
> @@ -35,4 +35,21 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED 0
>  #define SOCK_TXREHASH_ENABLED  1
>
> +/*
> + * Given the fact that MSG_ZEROCOPY_UARG tries to copy notifications
> + * back to user as soon as possible, 8 should be sufficient.
> + */
> +#define SOCK_USR_ZC_INFO_MAX 8
> +
> +struct tx_msg_zcopy_info {
> +       __u32 lo;
> +       __u32 hi;
> +       __u8 zerocopy;
> +};
> +
> +struct tx_usr_zcopy_info {
> +       int length;
> +       struct tx_msg_zcopy_info info[SOCK_USR_ZC_INFO_MAX];
> +};
> +
>  #endif /* _UAPI_LINUX_SOCKET_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2a5ce6667bbb..d939b2c14d55 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1661,6 +1661,16 @@ void mm_unaccount_pinned_pages(struct mmpin *mmp)
>  }
>  EXPORT_SYMBOL_GPL(mm_unaccount_pinned_pages);
>
> +static void init_ubuf_info_msgzc(struct ubuf_info_msgzc *uarg, struct so=
ck *sk, size_t size)
> +{
> +       uarg->id =3D ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
> +       uarg->len =3D 1;
> +       uarg->bytelen =3D size;
> +       uarg->zerocopy =3D 1;
> +       uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
> +       refcount_set(&uarg->ubuf.refcnt, 1);
> +}
> +
>  static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size=
)
>  {
>         struct ubuf_info_msgzc *uarg;
> @@ -1682,12 +1692,38 @@ static struct ubuf_info *msg_zerocopy_alloc(struc=
t sock *sk, size_t size)
>         }
>
>         uarg->ubuf.callback =3D msg_zerocopy_callback;
> -       uarg->id =3D ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
> -       uarg->len =3D 1;
> -       uarg->bytelen =3D size;
> -       uarg->zerocopy =3D 1;
> -       uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
> -       refcount_set(&uarg->ubuf.refcnt, 1);
> +       init_ubuf_info_msgzc(uarg, sk, size);
> +       sock_hold(sk);
> +
> +       return &uarg->ubuf;
> +}
> +
> +static struct ubuf_info *msg_zerocopy_uarg_alloc(struct sock *sk, size_t=
 size)
> +{
> +       struct sk_buff *skb;
> +       struct ubuf_info_msgzc *uarg;
> +       struct tx_msg_zcopy_node *zcopy_node_p;
> +
> +       WARN_ON_ONCE(!in_task());
> +
> +       skb =3D sock_omalloc(sk, sizeof(*zcopy_node_p), GFP_KERNEL);
> +       if (!skb)
> +               return NULL;
> +
> +       BUILD_BUG_ON(sizeof(*uarg) > sizeof(skb->cb));
> +       uarg =3D (void *)skb->cb;
> +       uarg->mmp.user =3D NULL;
> +       zcopy_node_p =3D (struct tx_msg_zcopy_node *)skb_put(skb, sizeof(=
*zcopy_node_p));
> +
> +       if (mm_account_pinned_pages(&uarg->mmp, size)) {
> +               kfree_skb(skb);
> +               return NULL;
> +       }
> +
> +       INIT_LIST_HEAD(&zcopy_node_p->node);
> +       zcopy_node_p->skb =3D skb;
> +       uarg->ubuf.callback =3D msg_zerocopy_uarg_callback;
> +       init_ubuf_info_msgzc(uarg, sk, size);
>         sock_hold(sk);
>
>         return &uarg->ubuf;
> @@ -1699,7 +1735,7 @@ static inline struct sk_buff *skb_from_uarg(struct =
ubuf_info_msgzc *uarg)
>  }
>
>  struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> -                                      struct ubuf_info *uarg)
> +                                      struct ubuf_info *uarg, bool usr_a=
rg_notification)
>  {
>         if (uarg) {
>                 struct ubuf_info_msgzc *uarg_zc;
> @@ -1707,7 +1743,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock =
*sk, size_t size,
>                 u32 bytelen, next;
>
>                 /* there might be non MSG_ZEROCOPY users */
> -               if (uarg->callback !=3D msg_zerocopy_callback)
> +               if (uarg->callback !=3D msg_zerocopy_callback &&
> +                   uarg->callback !=3D msg_zerocopy_uarg_callback)
>                         return NULL;
>
>                 /* realloc only when socket is locked (TCP, UDP cork),
> @@ -1744,6 +1781,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock =
*sk, size_t size,
>         }
>
>  new_alloc:
> +       if (usr_arg_notification)
> +               return msg_zerocopy_uarg_alloc(sk, size);
>         return msg_zerocopy_alloc(sk, size);
>  }
>  EXPORT_SYMBOL_GPL(msg_zerocopy_realloc);
> @@ -1830,6 +1869,86 @@ void msg_zerocopy_callback(struct sk_buff *skb, st=
ruct ubuf_info *uarg,
>  }
>  EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
>
> +static bool skb_zerocopy_uarg_notify_extend(struct tx_msg_zcopy_node *no=
de, u32 lo, u16 len)
> +{
> +       u32 old_lo, old_hi;
> +       u64 sum_len;
> +
> +       old_lo =3D node->info.lo;
> +       old_hi =3D node->info.hi;
> +       sum_len =3D old_hi - old_lo + 1ULL + len;
> +
> +       if (sum_len >=3D (1ULL << 32))
> +               return false;
> +
> +       if (lo !=3D old_hi + 1)
> +               return false;
> +
> +       node->info.hi +=3D len;
> +       return true;
> +}
> +
> +static void __msg_zerocopy_uarg_callback(struct ubuf_info_msgzc *uarg)
> +{
> +       struct sk_buff *skb =3D skb_from_uarg(uarg);
> +       struct sock *sk =3D skb->sk;
> +       struct tx_msg_zcopy_node *zcopy_node_p, *tail;
> +       struct tx_msg_zcopy_queue *zcopy_queue;
> +       unsigned long flags;
> +       u32 lo, hi;
> +       u16 len;
> +
> +       mm_unaccount_pinned_pages(&uarg->mmp);
> +
> +       /* if !len, there was only 1 call, and it was aborted
> +        * so do not queue a completion notification
> +        */
> +       if (!uarg->len || sock_flag(sk, SOCK_DEAD))
> +               goto release;
> +
> +       /* only support TCP and UCP currently */
> +       if (sk_is_tcp(sk)) {
> +               zcopy_queue =3D &tcp_sk(sk)->tx_zcopy_queue;
> +       } else if (sk_is_udp(sk)) {
> +               zcopy_queue =3D &udp_sk(sk)->tx_zcopy_queue;
> +       } else {
> +               pr_warn("MSG_ZEROCOPY_UARG only support TCP && UDP socket=
s");
> +               goto release;
> +       }
> +
> +       len =3D uarg->len;
> +       lo =3D uarg->id;
> +       hi =3D uarg->id + len - 1;
> +
> +       zcopy_node_p =3D (struct tx_msg_zcopy_node *)skb->data;
> +       zcopy_node_p->info.lo =3D lo;
> +       zcopy_node_p->info.hi =3D hi;
> +       zcopy_node_p->info.zerocopy =3D uarg->zerocopy;
> +
> +       spin_lock_irqsave(&zcopy_queue->lock, flags);
> +       tail =3D list_last_entry(&zcopy_queue->head, struct tx_msg_zcopy_=
node, node);
> +       if (!tail || !skb_zerocopy_uarg_notify_extend(tail, lo, len)) {
> +               list_add_tail(&zcopy_node_p->node, &zcopy_queue->head);
> +               skb =3D NULL;
> +       }
> +       spin_unlock_irqrestore(&zcopy_queue->lock, flags);
> +release:
> +       consume_skb(skb);
> +       sock_put(sk);
> +}
> +
> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info *u=
arg,
> +                               bool success)
> +{
> +       struct ubuf_info_msgzc *uarg_zc =3D uarg_to_msgzc(uarg);
> +
> +       uarg_zc->zerocopy =3D uarg_zc->zerocopy & success;
> +
> +       if (refcount_dec_and_test(&uarg->refcnt))
> +               __msg_zerocopy_uarg_callback(uarg_zc);
> +}
> +EXPORT_SYMBOL_GPL(msg_zerocopy_uarg_callback);
> +
>  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
>  {
>         struct sock *sk =3D skb_from_uarg(uarg_to_msgzc(uarg))->sk;
> @@ -1838,7 +1957,7 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg,=
 bool have_uref)
>         uarg_to_msgzc(uarg)->len--;
>
>         if (have_uref)
> -               msg_zerocopy_callback(NULL, uarg, true);
> +               uarg->callback(NULL, uarg, true);
>  }
>  EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5ed411231fc7..a00ebd71f6ed 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2843,6 +2843,56 @@ int __sock_cmsg_send(struct sock *sk, struct cmsgh=
dr *cmsg,
>         case SCM_RIGHTS:
>         case SCM_CREDENTIALS:
>                 break;
> +       case SO_ZEROCOPY_NOTIFICATION:
> +               if (sock_flag(sk, SOCK_ZEROCOPY)) {
> +                       int i =3D 0;
> +                       struct tx_usr_zcopy_info sys_zcopy_info;
> +                       struct tx_msg_zcopy_node *zcopy_node_p, *tmp;
> +                       struct tx_msg_zcopy_queue *zcopy_queue;
> +                       struct tx_msg_zcopy_node *zcopy_node_ps[SOCK_USR_=
ZC_INFO_MAX];
> +                       unsigned long flags;
> +
> +                       if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(void *)))
> +                               return -EINVAL;
> +
> +                       if (sk_is_tcp(sk))
> +                               zcopy_queue =3D &tcp_sk(sk)->tx_zcopy_que=
ue;
> +                       else if (sk_is_udp(sk))
> +                               zcopy_queue =3D &udp_sk(sk)->tx_zcopy_que=
ue;
> +                       else
> +                               return -EINVAL;
> +
> +                       spin_lock_irqsave(&zcopy_queue->lock, flags);
> +                       list_for_each_entry_safe(zcopy_node_p, tmp, &zcop=
y_queue->head, node) {
> +                               sys_zcopy_info.info[i].lo =3D zcopy_node_=
p->info.lo;
> +                               sys_zcopy_info.info[i].hi =3D zcopy_node_=
p->info.hi;
> +                               sys_zcopy_info.info[i].zerocopy =3D zcopy=
_node_p->info.zerocopy;
> +                               list_del(&zcopy_node_p->node);
> +                               zcopy_node_ps[i++] =3D zcopy_node_p;
> +                               if (i =3D=3D SOCK_USR_ZC_INFO_MAX)
> +                                       break;
> +                       }
> +                       spin_unlock_irqrestore(&zcopy_queue->lock, flags)=
;
> +
> +                       if (i > 0) {
> +                               sys_zcopy_info.length =3D i;
> +                               if (unlikely(copy_to_user(*(void **)CMSG_=
DATA(cmsg),

This is going to break if user space is 32bit, and kernel 64bit ?

Also SOCK_USR_ZC_INFO_MAX is put in stone, it won't change in the future.

> +                                                         &sys_zcopy_info=
,
> +                                                         sizeof(sys_zcop=
y_info))

Your are leaking to user space part of kernel stack, if (i <
SOCK_USR_ZC_INFO_MAX)

> +                                       )) {
> +                                       spin_lock_irqsave(&zcopy_queue->l=
ock, flags);
> +                                       while (i > 0)
> +                                               list_add(&zcopy_node_ps[-=
-i]->node,
> +                                                        &zcopy_queue->he=
ad);



> +                                       spin_unlock_irqrestore(&zcopy_que=
ue->lock, flags);
> +                                       return -EFAULT;
> +                               }
> +
> +                               while (i > 0)
> +                                       consume_skb(zcopy_node_ps[--i]->s=
kb);
> +                       }
> +               }
> +               break;
>         default:
>                 return -EINVAL;
>         }
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 1fe794967211..5adb737c4c01 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1005,7 +1005,7 @@ static int __ip_append_data(struct sock *sk,
>             (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSU=
M)))
>                 csummode =3D CHECKSUM_PARTIAL;
>
> -       if ((flags & MSG_ZEROCOPY) && length) {
> +       if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && le=
ngth) {
>                 struct msghdr *msg =3D from;
>
>                 if (getfrag =3D=3D ip_generic_getfrag && msg->msg_ubuf) {
> @@ -1022,7 +1022,9 @@ static int __ip_append_data(struct sock *sk,
>                                 uarg =3D msg->msg_ubuf;
>                         }
>                 } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
> -                       uarg =3D msg_zerocopy_realloc(sk, length, skb_zco=
py(skb));
> +                       bool user_args =3D flags & MSG_ZEROCOPY_UARG;
> +
> +                       uarg =3D msg_zerocopy_realloc(sk, length, skb_zco=
py(skb), user_args);
>                         if (!uarg)
>                                 return -ENOBUFS;
>                         extra_uref =3D !skb_zcopy(skb);   /* only ref on =
new uarg */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e767721b3a58..6254d0eef3af 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -462,6 +462,8 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> +
> +       tx_message_zcopy_queue_init(&tp->tx_zcopy_queue);
>  }
>  EXPORT_SYMBOL(tcp_init_sock);
>
> @@ -1050,14 +1052,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
>
>         flags =3D msg->msg_flags;
>
> -       if ((flags & MSG_ZEROCOPY) && size) {
> +       if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && si=
ze) {
>                 if (msg->msg_ubuf) {
>                         uarg =3D msg->msg_ubuf;
>                         if (sk->sk_route_caps & NETIF_F_SG)
>                                 zc =3D MSG_ZEROCOPY;
>                 } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
> +                       bool zc_uarg =3D flags & MSG_ZEROCOPY_UARG;
>                         skb =3D tcp_write_queue_tail(sk);
> -                       uarg =3D msg_zerocopy_realloc(sk, size, skb_zcopy=
(skb));
> +                       uarg =3D msg_zerocopy_realloc(sk, size, skb_zcopy=
(skb), zc_uarg);
>                         if (!uarg) {
>                                 err =3D -ENOBUFS;
>                                 goto out_err;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 11460d751e73..6c62aacd74d6 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1126,6 +1126,15 @@ int udp_sendmsg(struct sock *sk, struct msghdr *ms=
g, size_t len)
>                 if (ipc.opt)
>                         free =3D 1;
>                 connected =3D 0;
> +
> +               /* If len is zero and flag MSG_ZEROCOPY_UARG is set,
> +                * it means this call just wants to get zcopy notificatio=
ns
> +                * instead of sending packets. It is useful when users
> +                * finish sending and want to get trailing notifications.
> +                */
> +               if ((msg->msg_flags & MSG_ZEROCOPY_UARG) &&
> +                   sock_flag(sk, SOCK_ZEROCOPY) && len =3D=3D 0)
> +                       return 0;
>         }
>         if (!ipc.opt) {
>                 struct ip_options_rcu *inet_opt;
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index b9dd3a66e423..891526ddd74c 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1493,7 +1493,7 @@ static int __ip6_append_data(struct sock *sk,
>             rt->dst.dev->features & (NETIF_F_IPV6_CSUM | NETIF_F_HW_CSUM)=
)
>                 csummode =3D CHECKSUM_PARTIAL;
>
> -       if ((flags & MSG_ZEROCOPY) && length) {
> +       if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && le=
ngth) {
>                 struct msghdr *msg =3D from;
>
>                 if (getfrag =3D=3D ip_generic_getfrag && msg->msg_ubuf) {
> @@ -1510,7 +1510,8 @@ static int __ip6_append_data(struct sock *sk,
>                                 uarg =3D msg->msg_ubuf;
>                         }
>                 } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
> -                       uarg =3D msg_zerocopy_realloc(sk, length, skb_zco=
py(skb));
> +                       uarg =3D msg_zerocopy_realloc(sk, length, skb_zco=
py(skb),
> +                                                   flags & MSG_ZEROCOPY_=
UARG);
>                         if (!uarg)
>                                 return -ENOBUFS;
>                         extra_uref =3D !skb_zcopy(skb);   /* only ref on =
new uarg */
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 2e4dc5e6137b..98f6905c5db9 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1490,6 +1490,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
>                 if (!(opt->opt_nflen|opt->opt_flen))
>                         opt =3D NULL;
>                 connected =3D false;
> +
> +               /* If len is zero and flag MSG_ZEROCOPY_UARG is set,
> +                * it means this call just wants to get zcopy notificatio=
ns
> +                * instead of sending packets. It is useful when users
> +                * finish sending and want to get trailing notifications.
> +                */
> +               if ((msg->msg_flags & MSG_ZEROCOPY_UARG) &&
> +                   sock_flag(sk, SOCK_ZEROCOPY) && len =3D=3D 0)
> +                       return 0;
>         }
>         if (!opt) {
>                 opt =3D txopt_get(np);
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 16ff976a86e3..d6e6830f6ffe 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -84,7 +84,7 @@ static int virtio_transport_init_zcopy_skb(struct vsock=
_sock *vsk,
>
>                 uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
>                                             iter->count,
> -                                           NULL);
> +                                           NULL, false);
>                 if (!uarg)
>                         return -1;
>
> --
> 2.20.1
>

