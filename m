Return-Path: <netdev+bounces-86705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886538A0028
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2842852AD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782491802D1;
	Wed, 10 Apr 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEiAGEGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E01802C7
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775468; cv=none; b=I6pcwMe4zu/wFxGfR1kSIpmbdqg2+UC94Xp23nlky/0VdXsE1O/O0DNGbiMC6iQJ3KPzGK2wE+JViVUSYEMwlEz1Bkm7xA9hOv11Q+g1vUUqBiEmnBxnlKEdrFy55XmuW94mdgh/Zp7OvosPgPkEFGF7IxK81VhB1BTzHXMYt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775468; c=relaxed/simple;
	bh=KlX284f4yQXiDGWtH3bt4pfML1o99Na0bVcuv8qOavc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvdiVxKz13k2fdHiNRVx52OxNdEvMmS9j+yLTZRyBD/DE/LBF5eUdg/OCugr3Pv//sAgOgo0GkLpfVkeDmH3zZWD8lDa8YRLshOHAOsDq54jmgG38mQS8niVKU7Iw4NOQv2OpIWcrqxe91pA078nVdpPRYmb52BjPSJYCGoexow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEiAGEGd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56fe56d4d9cso1815a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712775463; x=1713380263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd2wdnG0RX5rMnpoJRwuNNM8fADjb4cRXM9OMSTKb2o=;
        b=AEiAGEGdHHMINjbwMMrlUpaxCcN1/iTEOQiHdU9nDqjB6QyxD08dVZwpaF206/yzUQ
         CVsHS6UiklFZmXaYNJvchXP8kL4MTMbK/XOZy2gBVoWJjo7QO3p/B2+zMWyoiJ0ctrdl
         lJYGEkItiJL//rXjly2xKDmIAJlRS0dVK3+mLImY7KHmvX02nFQvw7woSxzuUf/SBqGS
         B5BDKQq+rxvJzSyewfuydwdDBTKQqsg75SwQ/ATYrmZPwnVYtCol2G+9owlrf5O1ZKmz
         zIymElfziAVWkms8PiCgseYPLC+1bWoL1NZDygXe+QbqUtMW4I5cRJ7+0w2OarICGEHJ
         VRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775463; x=1713380263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd2wdnG0RX5rMnpoJRwuNNM8fADjb4cRXM9OMSTKb2o=;
        b=mHsz+bIQdYeE9bNZ5wqX4AZZdIb4VDkfmU6/1wVQoJhPMQn9Qq0Qmzdj7s4rXsore6
         baEzoLW/OmytE5TK8pT9ITugUBmSuGOfiIXDGNJgxiHzH62dBk4XC7K+pJMBz84/7iuu
         yTRiLgVi9AQ1RHYnRLYBfScfDvKT8yNFwPZMPPGb+pj7EwVc1DlhBM1B+PDqAGKAZWT3
         ozrvotqkl4CdLtMtUGwIOHMl81jaj0Qe+PW/rndTa9tXo7+p3uBo0sbZKmt32dar6C90
         eFWQQC4nxs1HPwY/8y1V3nstuPs1OPZ0G+yyEQ6IEcTETv93NLRk9a8bM4OFobG1gqRy
         8KUg==
X-Gm-Message-State: AOJu0YzAutwq9+luFRQSBqRCUsMQ445pO8+Vk936TFspxdDK4pT2Jw9o
	6ZK7yZcrJR0A7YfkeLL0o4wR69G0TwFK8cH28WmcpWthzozCbfWF8C3AgWED18DF50kHuOv4Df5
	Qd4VJJToPPad5GdMDongkq5ODvEZo90Jav07g
X-Google-Smtp-Source: AGHT+IGDiPDMqg05pnmA/8PQxQSDSLQiYk6FDvvAIIxgYq7+NOkRW9AlwOgtndxnlhvrdi63urEMweGzMtgO+B6U+ok=
X-Received: by 2002:aa7:c6c6:0:b0:56f:e261:2c03 with SMTP id
 b6-20020aa7c6c6000000b0056fe2612c03mr11843eds.2.1712775462850; Wed, 10 Apr
 2024 11:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-2-zijianzhang@bytedance.com> <CANn89iL5T9KzoQetcRQKfZCMbwtbfB9B3EzoYXYcKgZS86FZXA@mail.gmail.com>
 <a24412f8-3588-49e1-920d-5f70841ae420@bytedance.com>
In-Reply-To: <a24412f8-3588-49e1-920d-5f70841ae420@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2024 20:57:31 +0200
Message-ID: <CANn89iJxJK4Gya3DEsSgSKbVVVKo1vTSLWYxJ8NsMe0q1S3Srg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:01=E2=80=AFPM Zijian Zhang <zijianzhang@bytedance=
.com> wrote:
>
> On 4/9/24 2:18 PM, Eric Dumazet wrote:
> > On Tue, Apr 9, 2024 at 10:53=E2=80=AFPM <zijianzhang@bytedance.com> wro=
te:
> >>
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> >> However, zerocopy is not a free lunch. Apart from the management of us=
er
> >> pages, the combination of poll + recvmsg to receive notifications incu=
rs
> >> unignorable overhead in the applications. The overhead of such sometim=
es
> >> might be more than the CPU savings from zerocopy. We try to solve this
> >> problem with a new option for TCP and UDP, MSG_ZEROCOPY_UARG.
> >> This new mechanism aims to reduce the overhead associated with receivi=
ng
> >> notifications by embedding them directly into user arguments passed wi=
th
> >> each sendmsg control message. By doing so, we can significantly reduce
> >> the complexity and overhead for managing notifications. In an ideal
> >> pattern, the user will keep calling sendmsg with MSG_ZEROCOPY_UARG
> >> flag, and the notification will be delivered as soon as possible.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> >> ---
> >>   include/linux/skbuff.h                  |   7 +-
> >>   include/linux/socket.h                  |   1 +
> >>   include/linux/tcp.h                     |   3 +
> >>   include/linux/udp.h                     |   3 +
> >>   include/net/sock.h                      |  17 +++
> >>   include/net/udp.h                       |   1 +
> >>   include/uapi/asm-generic/socket.h       |   2 +
> >>   include/uapi/linux/socket.h             |  17 +++
> >>   net/core/skbuff.c                       | 137 ++++++++++++++++++++++=
--
> >>   net/core/sock.c                         |  50 +++++++++
> >>   net/ipv4/ip_output.c                    |   6 +-
> >>   net/ipv4/tcp.c                          |   7 +-
> >>   net/ipv4/udp.c                          |   9 ++
> >>   net/ipv6/ip6_output.c                   |   5 +-
> >>   net/ipv6/udp.c                          |   9 ++
> >>   net/vmw_vsock/virtio_transport_common.c |   2 +-
> >>   16 files changed, 258 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 03ea36a82cdd..19b94ba01007 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -1663,12 +1663,14 @@ static inline void skb_set_end_offset(struct s=
k_buff *skb, unsigned int offset)
> >>   #endif
> >>
> >>   struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> >> -                                      struct ubuf_info *uarg);
> >> +                                      struct ubuf_info *uarg, bool us=
er_args_notification);
> >>
> >>   void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
> >>
> >>   void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ua=
rg,
> >>                             bool success);
> >> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info=
 *uarg,
> >> +                          bool success);
> >>
> >>   int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
> >>                              struct sk_buff *skb, struct iov_iter *fro=
m,
> >> @@ -1763,7 +1765,8 @@ static inline void net_zcopy_put(struct ubuf_inf=
o *uarg)
> >>   static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool =
have_uref)
> >>   {
> >>          if (uarg) {
> >> -               if (uarg->callback =3D=3D msg_zerocopy_callback)
> >> +               if (uarg->callback =3D=3D msg_zerocopy_callback ||
> >> +                       uarg->callback =3D=3D msg_zerocopy_uarg_callba=
ck)
> >>                          msg_zerocopy_put_abort(uarg, have_uref);
> >>                  else if (have_uref)
> >>                          net_zcopy_put(uarg);
> >> diff --git a/include/linux/socket.h b/include/linux/socket.h
> >> index 139c330ccf2c..de01392344e1 100644
> >> --- a/include/linux/socket.h
> >> +++ b/include/linux/socket.h
> >> @@ -326,6 +326,7 @@ struct ucred {
> >>                                            * plain text and require en=
cryption
> >>                                            */
> >>
> >> +#define MSG_ZEROCOPY_UARG      0x2000000 /* MSG_ZEROCOPY with UARG no=
tifications */
> >>   #define MSG_ZEROCOPY   0x4000000       /* Use user data in kernel pa=
th */
> >>   #define MSG_SPLICE_PAGES 0x8000000     /* Splice the pages from the =
iterator in sendmsg() */
> >>   #define MSG_FASTOPEN   0x20000000      /* Send data in TCP SYN */
> >> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> >> index 55399ee2a57e..e973f4990646 100644
> >> --- a/include/linux/tcp.h
> >> +++ b/include/linux/tcp.h
> >> @@ -501,6 +501,9 @@ struct tcp_sock {
> >>           */
> >>          struct request_sock __rcu *fastopen_rsk;
> >>          struct saved_syn *saved_syn;
> >> +
> >> +/* TCP MSG_ZEROCOPY_UARG related information */
> >> +       struct tx_msg_zcopy_queue tx_zcopy_queue;
> >>   };
> >>
> >>   enum tsq_enum {
> >> diff --git a/include/linux/udp.h b/include/linux/udp.h
> >> index 3748e82b627b..502b393eac67 100644
> >> --- a/include/linux/udp.h
> >> +++ b/include/linux/udp.h
> >> @@ -95,6 +95,9 @@ struct udp_sock {
> >>
> >>          /* Cache friendly copy of sk->sk_peek_off >=3D 0 */
> >>          bool            peeking_with_offset;
> >> +
> >> +       /* This field is used by sendmsg zcopy user arg mode notificat=
ion */
> >> +       struct tx_msg_zcopy_queue tx_zcopy_queue;
> >>   };
> >>
> >>   #define udp_test_bit(nr, sk)                   \
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 2253eefe2848..f7c045e98213 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -544,6 +544,23 @@ struct sock {
> >>          netns_tracker           ns_tracker;
> >>   };
> >>
> >> +struct tx_msg_zcopy_node {
> >> +       struct list_head node;
> >> +       struct tx_msg_zcopy_info info;
> >> +       struct sk_buff *skb;
> >> +};
> >> +
> >> +struct tx_msg_zcopy_queue {
> >> +       struct list_head head;
> >> +       spinlock_t lock; /* protects head queue */
> >> +};
> >> +
> >> +static inline void tx_message_zcopy_queue_init(struct tx_msg_zcopy_qu=
eue *q)
> >> +{
> >> +       spin_lock_init(&q->lock);
> >> +       INIT_LIST_HEAD(&q->head);
> >> +}
> >> +
> >>   enum sk_pacing {
> >>          SK_PACING_NONE          =3D 0,
> >>          SK_PACING_NEEDED        =3D 1,
> >> diff --git a/include/net/udp.h b/include/net/udp.h
> >> index 488a6d2babcc..9e4d7b128de4 100644
> >> --- a/include/net/udp.h
> >> +++ b/include/net/udp.h
> >> @@ -182,6 +182,7 @@ static inline void udp_lib_init_sock(struct sock *=
sk)
> >>          skb_queue_head_init(&up->reader_queue);
> >>          up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> >>          set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> >> +       tx_message_zcopy_queue_init(&up->tx_zcopy_queue);
> >>   }
> >>
> >>   /* hash routines shared between UDPv4/6 and UDP-Litev4/6 */
> >> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gene=
ric/socket.h
> >> index 8ce8a39a1e5f..86aa4b5cb7f1 100644
> >> --- a/include/uapi/asm-generic/socket.h
> >> +++ b/include/uapi/asm-generic/socket.h
> >> @@ -135,6 +135,8 @@
> >>   #define SO_PASSPIDFD           76
> >>   #define SO_PEERPIDFD           77
> >>
> >> +#define SO_ZEROCOPY_NOTIFICATION 78
> >> +
> >>   #if !defined(__KERNEL__)
> >>
> >>   #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> >> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> >> index d3fcd3b5ec53..469ed8f4e6c8 100644
> >> --- a/include/uapi/linux/socket.h
> >> +++ b/include/uapi/linux/socket.h
> >> @@ -35,4 +35,21 @@ struct __kernel_sockaddr_storage {
> >>   #define SOCK_TXREHASH_DISABLED 0
> >>   #define SOCK_TXREHASH_ENABLED  1
> >>
> >> +/*
> >> + * Given the fact that MSG_ZEROCOPY_UARG tries to copy notifications
> >> + * back to user as soon as possible, 8 should be sufficient.
> >> + */
> >> +#define SOCK_USR_ZC_INFO_MAX 8
> >> +
> >> +struct tx_msg_zcopy_info {
> >> +       __u32 lo;
> >> +       __u32 hi;
> >> +       __u8 zerocopy;
> >> +};
> >> +
> >> +struct tx_usr_zcopy_info {
> >> +       int length;
> >> +       struct tx_msg_zcopy_info info[SOCK_USR_ZC_INFO_MAX];
> >> +};
> >> +
> >>   #endif /* _UAPI_LINUX_SOCKET_H */
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 2a5ce6667bbb..d939b2c14d55 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -1661,6 +1661,16 @@ void mm_unaccount_pinned_pages(struct mmpin *mm=
p)
> >>   }
> >>   EXPORT_SYMBOL_GPL(mm_unaccount_pinned_pages);
> >>
> >> +static void init_ubuf_info_msgzc(struct ubuf_info_msgzc *uarg, struct=
 sock *sk, size_t size)
> >> +{
> >> +       uarg->id =3D ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
> >> +       uarg->len =3D 1;
> >> +       uarg->bytelen =3D size;
> >> +       uarg->zerocopy =3D 1;
> >> +       uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
> >> +       refcount_set(&uarg->ubuf.refcnt, 1);
> >> +}
> >> +
> >>   static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t =
size)
> >>   {
> >>          struct ubuf_info_msgzc *uarg;
> >> @@ -1682,12 +1692,38 @@ static struct ubuf_info *msg_zerocopy_alloc(st=
ruct sock *sk, size_t size)
> >>          }
> >>
> >>          uarg->ubuf.callback =3D msg_zerocopy_callback;
> >> -       uarg->id =3D ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
> >> -       uarg->len =3D 1;
> >> -       uarg->bytelen =3D size;
> >> -       uarg->zerocopy =3D 1;
> >> -       uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
> >> -       refcount_set(&uarg->ubuf.refcnt, 1);
> >> +       init_ubuf_info_msgzc(uarg, sk, size);
> >> +       sock_hold(sk);
> >> +
> >> +       return &uarg->ubuf;
> >> +}
> >> +
> >> +static struct ubuf_info *msg_zerocopy_uarg_alloc(struct sock *sk, siz=
e_t size)
> >> +{
> >> +       struct sk_buff *skb;
> >> +       struct ubuf_info_msgzc *uarg;
> >> +       struct tx_msg_zcopy_node *zcopy_node_p;
> >> +
> >> +       WARN_ON_ONCE(!in_task());
> >> +
> >> +       skb =3D sock_omalloc(sk, sizeof(*zcopy_node_p), GFP_KERNEL);
> >> +       if (!skb)
> >> +               return NULL;
> >> +
> >> +       BUILD_BUG_ON(sizeof(*uarg) > sizeof(skb->cb));
> >> +       uarg =3D (void *)skb->cb;
> >> +       uarg->mmp.user =3D NULL;
> >> +       zcopy_node_p =3D (struct tx_msg_zcopy_node *)skb_put(skb, size=
of(*zcopy_node_p));
> >> +
> >> +       if (mm_account_pinned_pages(&uarg->mmp, size)) {
> >> +               kfree_skb(skb);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       INIT_LIST_HEAD(&zcopy_node_p->node);
> >> +       zcopy_node_p->skb =3D skb;
> >> +       uarg->ubuf.callback =3D msg_zerocopy_uarg_callback;
> >> +       init_ubuf_info_msgzc(uarg, sk, size);
> >>          sock_hold(sk);
> >>
> >>          return &uarg->ubuf;
> >> @@ -1699,7 +1735,7 @@ static inline struct sk_buff *skb_from_uarg(stru=
ct ubuf_info_msgzc *uarg)
> >>   }
> >>
> >>   struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> >> -                                      struct ubuf_info *uarg)
> >> +                                      struct ubuf_info *uarg, bool us=
r_arg_notification)
> >>   {
> >>          if (uarg) {
> >>                  struct ubuf_info_msgzc *uarg_zc;
> >> @@ -1707,7 +1743,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct so=
ck *sk, size_t size,
> >>                  u32 bytelen, next;
> >>
> >>                  /* there might be non MSG_ZEROCOPY users */
> >> -               if (uarg->callback !=3D msg_zerocopy_callback)
> >> +               if (uarg->callback !=3D msg_zerocopy_callback &&
> >> +                   uarg->callback !=3D msg_zerocopy_uarg_callback)
> >>                          return NULL;
> >>
> >>                  /* realloc only when socket is locked (TCP, UDP cork)=
,
> >> @@ -1744,6 +1781,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct so=
ck *sk, size_t size,
> >>          }
> >>
> >>   new_alloc:
> >> +       if (usr_arg_notification)
> >> +               return msg_zerocopy_uarg_alloc(sk, size);
> >>          return msg_zerocopy_alloc(sk, size);
> >>   }
> >>   EXPORT_SYMBOL_GPL(msg_zerocopy_realloc);
> >> @@ -1830,6 +1869,86 @@ void msg_zerocopy_callback(struct sk_buff *skb,=
 struct ubuf_info *uarg,
> >>   }
> >>   EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
> >>
> >> +static bool skb_zerocopy_uarg_notify_extend(struct tx_msg_zcopy_node =
*node, u32 lo, u16 len)
> >> +{
> >> +       u32 old_lo, old_hi;
> >> +       u64 sum_len;
> >> +
> >> +       old_lo =3D node->info.lo;
> >> +       old_hi =3D node->info.hi;
> >> +       sum_len =3D old_hi - old_lo + 1ULL + len;
> >> +
> >> +       if (sum_len >=3D (1ULL << 32))
> >> +               return false;
> >> +
> >> +       if (lo !=3D old_hi + 1)
> >> +               return false;
> >> +
> >> +       node->info.hi +=3D len;
> >> +       return true;
> >> +}
> >> +
> >> +static void __msg_zerocopy_uarg_callback(struct ubuf_info_msgzc *uarg=
)
> >> +{
> >> +       struct sk_buff *skb =3D skb_from_uarg(uarg);
> >> +       struct sock *sk =3D skb->sk;
> >> +       struct tx_msg_zcopy_node *zcopy_node_p, *tail;
> >> +       struct tx_msg_zcopy_queue *zcopy_queue;
> >> +       unsigned long flags;
> >> +       u32 lo, hi;
> >> +       u16 len;
> >> +
> >> +       mm_unaccount_pinned_pages(&uarg->mmp);
> >> +
> >> +       /* if !len, there was only 1 call, and it was aborted
> >> +        * so do not queue a completion notification
> >> +        */
> >> +       if (!uarg->len || sock_flag(sk, SOCK_DEAD))
> >> +               goto release;
> >> +
> >> +       /* only support TCP and UCP currently */
> >> +       if (sk_is_tcp(sk)) {
> >> +               zcopy_queue =3D &tcp_sk(sk)->tx_zcopy_queue;
> >> +       } else if (sk_is_udp(sk)) {
> >> +               zcopy_queue =3D &udp_sk(sk)->tx_zcopy_queue;
> >> +       } else {
> >> +               pr_warn("MSG_ZEROCOPY_UARG only support TCP && UDP soc=
kets");
> >> +               goto release;
> >> +       }
> >> +
> >> +       len =3D uarg->len;
> >> +       lo =3D uarg->id;
> >> +       hi =3D uarg->id + len - 1;
> >> +
> >> +       zcopy_node_p =3D (struct tx_msg_zcopy_node *)skb->data;
> >> +       zcopy_node_p->info.lo =3D lo;
> >> +       zcopy_node_p->info.hi =3D hi;
> >> +       zcopy_node_p->info.zerocopy =3D uarg->zerocopy;
> >> +
> >> +       spin_lock_irqsave(&zcopy_queue->lock, flags);
> >> +       tail =3D list_last_entry(&zcopy_queue->head, struct tx_msg_zco=
py_node, node);
> >> +       if (!tail || !skb_zerocopy_uarg_notify_extend(tail, lo, len)) =
{
> >> +               list_add_tail(&zcopy_node_p->node, &zcopy_queue->head)=
;
> >> +               skb =3D NULL;
> >> +       }
> >> +       spin_unlock_irqrestore(&zcopy_queue->lock, flags);
> >> +release:
> >> +       consume_skb(skb);
> >> +       sock_put(sk);
> >> +}
> >> +
> >> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info=
 *uarg,
> >> +                               bool success)
> >> +{
> >> +       struct ubuf_info_msgzc *uarg_zc =3D uarg_to_msgzc(uarg);
> >> +
> >> +       uarg_zc->zerocopy =3D uarg_zc->zerocopy & success;
> >> +
> >> +       if (refcount_dec_and_test(&uarg->refcnt))
> >> +               __msg_zerocopy_uarg_callback(uarg_zc);
> >> +}
> >> +EXPORT_SYMBOL_GPL(msg_zerocopy_uarg_callback);
> >> +
> >>   void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
> >>   {
> >>          struct sock *sk =3D skb_from_uarg(uarg_to_msgzc(uarg))->sk;
> >> @@ -1838,7 +1957,7 @@ void msg_zerocopy_put_abort(struct ubuf_info *ua=
rg, bool have_uref)
> >>          uarg_to_msgzc(uarg)->len--;
> >>
> >>          if (have_uref)
> >> -               msg_zerocopy_callback(NULL, uarg, true);
> >> +               uarg->callback(NULL, uarg, true);
> >>   }
> >>   EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
> >>
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 5ed411231fc7..a00ebd71f6ed 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2843,6 +2843,56 @@ int __sock_cmsg_send(struct sock *sk, struct cm=
sghdr *cmsg,
> >>          case SCM_RIGHTS:
> >>          case SCM_CREDENTIALS:
> >>                  break;
> >> +       case SO_ZEROCOPY_NOTIFICATION:
> >> +               if (sock_flag(sk, SOCK_ZEROCOPY)) {
> >> +                       int i =3D 0;
> >> +                       struct tx_usr_zcopy_info sys_zcopy_info;
> >> +                       struct tx_msg_zcopy_node *zcopy_node_p, *tmp;
> >> +                       struct tx_msg_zcopy_queue *zcopy_queue;
> >> +                       struct tx_msg_zcopy_node *zcopy_node_ps[SOCK_U=
SR_ZC_INFO_MAX];
> >> +                       unsigned long flags;
> >> +
> >> +                       if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(void *=
)))
> >> +                               return -EINVAL;
> >> +
> >> +                       if (sk_is_tcp(sk))
> >> +                               zcopy_queue =3D &tcp_sk(sk)->tx_zcopy_=
queue;
> >> +                       else if (sk_is_udp(sk))
> >> +                               zcopy_queue =3D &udp_sk(sk)->tx_zcopy_=
queue;
> >> +                       else
> >> +                               return -EINVAL;
> >> +
> >> +                       spin_lock_irqsave(&zcopy_queue->lock, flags);
> >> +                       list_for_each_entry_safe(zcopy_node_p, tmp, &z=
copy_queue->head, node) {
> >> +                               sys_zcopy_info.info[i].lo =3D zcopy_no=
de_p->info.lo;
> >> +                               sys_zcopy_info.info[i].hi =3D zcopy_no=
de_p->info.hi;
> >> +                               sys_zcopy_info.info[i].zerocopy =3D zc=
opy_node_p->info.zerocopy;
> >> +                               list_del(&zcopy_node_p->node);
> >> +                               zcopy_node_ps[i++] =3D zcopy_node_p;
> >> +                               if (i =3D=3D SOCK_USR_ZC_INFO_MAX)
> >> +                                       break;
> >> +                       }
> >> +                       spin_unlock_irqrestore(&zcopy_queue->lock, fla=
gs);
> >> +
> >> +                       if (i > 0) {
> >> +                               sys_zcopy_info.length =3D i;
> >> +                               if (unlikely(copy_to_user(*(void **)CM=
SG_DATA(cmsg),
> >
> > This is going to break if user space is 32bit, and kernel 64bit ?
> >
>
> Nice catch, thanks for pointing this out!
>
> I may update the code like this?
>
> ```
> if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(void *)) &&
>      cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
>      return -EINVAL;
>
> ...

I would instead use u64 convention, instead of "void *" or u32.

>
> void __user *user;
> if (cmsg->cmsg_len =3D=3D 8)
>      user =3D *(void **)CMSG_DATA(cmsg);
> else if (cmsg->cmsg_len =3D=3D 4) {
>      u32 val =3D *(u32 *)CMSG_DATA(cmsg);
>      user =3D (void *)(uintptr_t)val;
> }
> copy_to_user(user, ...)
> ```
>
> I assume it's user's duty to pass in the right address and cmsg_len.
> Malicious address or invalid address because of wrong cmsg_len will be
> protected by copy_to_user.



>
> > Also SOCK_USR_ZC_INFO_MAX is put in stone, it won't change in the futur=
e.
> >
>
> In the scenario where users keep calling sendmsg, at most time, the user
> will get one notification from the previous sendmsg. Sometimes, users
> get two notifications. Thus, we give SOCK_USR_ZC_INFO_MAX a small but
> sufficient number 8. We put it in stone here to avoid dynamic allocation
> and memory management of the array.
>
> If the memory management worth it, we can change it to a sysctl
> variable?

Convention for user space -> kernel space , is to pass not only a base
pointer, but also a length.

Of course the kernel implementation can still use a local/automatic
array in the stack with 8 elems,
but this could change eventually

Few system calls that did not follow this convention had to be
extended to other system calls.

>
> Or, how about we keep SOCK_USR_ZC_INFO_MAX, the max value here, and let
> the users pass in the length (could be any number less than MAX) of info
> they want to get?
>
> >> +                                                         &sys_zcopy_i=
nfo,
> >> +                                                         sizeof(sys_z=
copy_info))
> >
> > Your are leaking to user space part of kernel stack, if (i <
> > SOCK_USR_ZC_INFO_MAX)
> >
>
> Agree, I should do memset to clear the array.

Or copy only the part that has been initialized, struct_size() might help .=
..

