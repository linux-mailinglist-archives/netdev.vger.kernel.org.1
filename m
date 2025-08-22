Return-Path: <netdev+bounces-215895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2988B30D19
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF84960096C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403226D4F9;
	Fri, 22 Aug 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8zmBh3s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB1393DC5
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835148; cv=none; b=UH4vpagITZOseEWBxq5FJRzJjWiRkmZg3fHkgaSqSRMnW4s0FDRQl41nElq4/zWTVQFFPObSMvCygXKJRZtbauw7IGr+p7LYJkcNyUrPba+9fFRJRfDmem6ffyWtB4wc8O9rnn5cPILTRk5hrbXgZQw0p8hC32PpFZnMMt6HaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835148; c=relaxed/simple;
	bh=81hqPFmRmqOwwlHYVVtuKMqtStu0kVPfsYXXcqWAz/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm1CjoB2C8RDm5XCm0SQcuqDHzjbt58aqRBXeUQoqHit2+dYNN0Y05CjpO9EXdRmx136oyyh2dBy2c4l2D4BBQ85X0KHbK3zwFQ2LnZpw9JFQyRd1RDstlDg1s1u7T9aJFPFVbvK9RZJx1B/ZyO0iIiazqiqP5XwcAihATZbOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8zmBh3s; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47174b3429so1121394a12.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755835144; x=1756439944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ4kGkX+vuvN02aUcSNxoSl3qwI2khYrDXoV7E8nVUM=;
        b=t8zmBh3sc4ZBZUjQEoIumX29ZibhUH0rjCXz6WEccHI0wMLFBoOmUc/uztOa6FjZBK
         Y/WJ805TDFLUbMdWotAf7k/EOelA7fSpF6ahxsjdU6zcDE6bzjfe5FTlQu25vtTb7asM
         uw28KNBpDA3VgRfgxfsL9N3etNyqRcqL/2Lk2MSWC9RQ+pe2rG+QTgfxdj6w1luubFS1
         1ODwkg/vQ9JSNtJrMH2KNj64WQ91okNqmbZUsn50m19hA+gzK8TTnotCsj5zAVk252xO
         kUOacRdHCXXzJdvZZaAz6GKvzx9OEpkDuZRV+LpAFiW1LaQPmKWVpjX7FCooLQMEzY10
         Y0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835144; x=1756439944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ4kGkX+vuvN02aUcSNxoSl3qwI2khYrDXoV7E8nVUM=;
        b=LLuwQeuovBsi2WOzJxbTnI/5tp8wPnbDaK1Ha8PCmPlPl2Gc5rFio6QUZdwmwU4gbh
         OLPDe9gcikwyv8J7K9mL8aSm83A3Rgm7YBkdPhDJBzbnqemlwdH78oNlpTI2ndjU/j1b
         rqDsc4Nzku1IA2zrQ7g3pbJDzvtltmruzzXPFVunjBsDFdKS+YkUk8mLhNmrqPrZoiaC
         vY/xNthQyv4abcBrprVLyGAE3pk2uW0GhOATFzQNpk6BOBerPOHeCBEl6lEwLQ3mYLR8
         C883W2fv/ulkF5pFMiNJuCe0aEvEx7TR4bV4FUKeyT7JYEnzQqFgCDEd/Vmh5KGTC/OH
         /tbw==
X-Gm-Message-State: AOJu0YzvHOv1p+oUSoFes+HSwvf7azMmNAWGGJdHgCw55e6o7cJ7G8Om
	LT6joNGRQkjGpUQjE499U2pPV3yi/2BTQiMtFhPkr6Hv031aBRgaI2+FROelCPxzY4Os7saeQPB
	xlB4Fx70FscvBp2PUUSYRez1NZ+GWVE+LDn67RpGb
X-Gm-Gg: ASbGnctERDXN3rXyfIqQ9pJZu36tgxdFt7tm3V4Q6pPenH8cc5C5d0XHFYy6K304rEK
	hlG0iAAC2LlBIXER/SkuhwovmJg0aPH4y8fwckicEIf5xSEaJwtqr+vieOguFNoniVrt6NU69J4
	yekoklb/sOlIvx5ye335lq+zFthBXhxUuOhYkAVM/eAPrLoDqfJ5SzCvS7NuUhLMRjQMF7vc1qZ
	bBhy+wcmdmWYRJkdMurVAoj6Bt1hAqZq9o4621ey2WZ6Fi7UHRXavAygQZRAhapSAHp2LU5Jif2
	1lE=
X-Google-Smtp-Source: AGHT+IFmvLtcAG86L4BZSo5UjsR4i0EBi7q2h10mfcDj6K+VrCMjaUsWsfNCKslPLBeGiu7Bey3CAufj+xWmysDbhQU=
X-Received: by 2002:a17:902:e542:b0:240:2eae:aecb with SMTP id
 d9443c01a7336-2462ef872cemr25386145ad.43.1755835144157; Thu, 21 Aug 2025
 20:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
 <20250821-update-bind-bucket-state-on-unhash-v2-1-0c204543a522@cloudflare.com>
In-Reply-To: <20250821-update-bind-bucket-state-on-unhash-v2-1-0c204543a522@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 Aug 2025 20:58:52 -0700
X-Gm-Features: Ac12FXz87g4Dc-bYunSu7wzjmJCishRPfmHJ8OCPaLKL6VYdnO9jtR7_bkZXgJY
Message-ID: <CAAVpQUAV8KnFOxr61Qmb2grsd=CYP_aakP5XApis_Od424xM+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Update bind bucket state on port release
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Currently, when an inet_bind_bucket enters a state where fastreuse >=3D 0=
 or
> fastreuseport >=3D 0, after a socket explicitly binds to a port, it stays=
 in
> that state until all associated sockets are removed and the bucket is
> destroyed.
>
> In this state, the bucket is skipped during ephemeral port selection in
> connect(). For applications using a small ephemeral port range (via
> IP_LOCAL_PORT_RANGE option), this can lead to quicker port exhaustion
> because "blocked" buckets remain excluded from reuse.
>
> The reason for not updating the bucket state on port release is unclear. =
It
> may have been a performance trade-off to avoid scanning bucket owners, or
> simply an oversight.
>
> Address it by recalculating the bind bucket state when a socket releases =
a
> port. To minimize overhead, use a divide-and-conquer strategy: duplicate
> the (fastreuse, fastreuseport) state in each inet_bind2_bucket. On port
> release, we only need to scan the relevant port-addr bucket, and the
> overall port bucket state can be derived from those.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/net/inet_connection_sock.h |  5 +++--
>  include/net/inet_hashtables.h      |  2 ++
>  include/net/inet_sock.h            |  2 ++
>  include/net/inet_timewait_sock.h   |  3 ++-
>  include/net/tcp.h                  | 15 +++++++++++++++
>  net/ipv4/inet_connection_sock.c    | 12 ++++++++----
>  net/ipv4/inet_hashtables.c         | 32 +++++++++++++++++++++++++++++++-
>  net/ipv4/inet_timewait_sock.c      |  1 +
>  8 files changed, 64 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 1735db332aab..072347f16483 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -322,8 +322,9 @@ int inet_csk_listen_start(struct sock *sk);
>  void inet_csk_listen_stop(struct sock *sk);
>
>  /* update the fast reuse flag when adding a socket */
> -void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
> -                              struct sock *sk);
> +void inet_csk_update_fastreuse(const struct sock *sk,
> +                              struct inet_bind_bucket *tb,
> +                              struct inet_bind2_bucket *tb2);
>
>  struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
>
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 19dbd9081d5a..d6676746dabf 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -108,6 +108,8 @@ struct inet_bind2_bucket {
>         struct hlist_node       bhash_node;
>         /* List of sockets hashed to this bucket */
>         struct hlist_head       owners;
> +       signed char             fastreuse;
> +       signed char             fastreuseport;
>  };
>
>  static inline struct net *ib_net(const struct inet_bind_bucket *ib)
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 1086256549fa..9614d0430471 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -279,6 +279,8 @@ enum {
>         INET_FLAGS_RTALERT_ISOLATE =3D 28,
>         INET_FLAGS_SNDFLOW      =3D 29,
>         INET_FLAGS_RTALERT      =3D 30,
> +       /* socket bound to a port at connect() time */
> +       INET_FLAGS_AUTOBIND     =3D 31,

AUTOBIND sounds like inet_autobind() was called.

__inet_bind() saves similar flags in sk->sk_userlocks and
it has 3 bits available.

How about flagging SOCK_BINDPORT_CONNECT in
sk->sk_userlocks ?


>  };
>
>  /* cmsg flags for inet */
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait=
_sock.h
> index 67a313575780..ec99176d576f 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -70,7 +70,8 @@ struct inet_timewait_sock {
>         unsigned int            tw_transparent  : 1,
>                                 tw_flowlabel    : 20,
>                                 tw_usec_ts      : 1,
> -                               tw_pad          : 2,    /* 2 bits hole */
> +                               tw_autobind     : 1,
> +                               tw_pad          : 1,    /* 1 bit hole */
>                                 tw_tos          : 8;
>         u32                     tw_txhash;
>         u32                     tw_priority;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2936b8175950..c4bb6e56a668 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2225,6 +2225,21 @@ static inline bool inet_sk_transparent(const struc=
t sock *sk)
>         return inet_test_bit(TRANSPARENT, sk);
>  }
>
> +/**
> + * inet_sk_autobind - Check if socket was bound to a port at connect() t=
ime.
> + * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
> + */
> +static inline bool inet_sk_autobind(const struct sock *sk)
> +{
> +       switch (sk->sk_state) {
> +       case TCP_TIME_WAIT:
> +               return inet_twsk(sk)->tw_autobind;
> +       case TCP_NEW_SYN_RECV:
> +               return false; /* n/a to request sock */

This never happens.  Maybe remove the case
or add DEBUG_NET_WARN_ON_ONCE(1) ?


> +       }
> +       return inet_test_bit(AUTOBIND, sk);
> +}
> +
>  /* Determines whether this is a thin stream (which may suffer from
>   * increased latency). Used to trigger latency-reducing mechanisms.
>   */
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 0ef1eacd539d..34e4fe0c7b4b 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -423,7 +423,7 @@ inet_csk_find_open_port(const struct sock *sk, struct=
 inet_bind_bucket **tb_ret,
>  }
>
>  static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
> -                                    struct sock *sk)
> +                                    const struct sock *sk)
>  {
>         if (tb->fastreuseport <=3D 0)
>                 return 0;
> @@ -453,8 +453,9 @@ static inline int sk_reuseport_match(struct inet_bind=
_bucket *tb,
>                                     ipv6_only_sock(sk), true, false);
>  }
>
> -void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
> -                              struct sock *sk)
> +void inet_csk_update_fastreuse(const struct sock *sk,
> +                              struct inet_bind_bucket *tb,
> +                              struct inet_bind2_bucket *tb2)
>  {
>         bool reuse =3D sk->sk_reuse && sk->sk_state !=3D TCP_LISTEN;
>
> @@ -501,6 +502,9 @@ void inet_csk_update_fastreuse(struct inet_bind_bucke=
t *tb,
>                         tb->fastreuseport =3D 0;
>                 }
>         }
> +
> +       tb2->fastreuse =3D tb->fastreuse;
> +       tb2->fastreuseport =3D tb->fastreuseport;
>  }
>
>  /* Obtain a reference to a local port for the given sock,
> @@ -582,7 +586,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short=
 snum)
>         }
>
>  success:
> -       inet_csk_update_fastreuse(tb, sk);
> +       inet_csk_update_fastreuse(sk, tb, tb2);
>
>         if (!inet_csk(sk)->icsk_bind_hash)
>                 inet_bind_hash(sk, tb, tb2, port);
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..f644ffe43018 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -87,10 +87,22 @@ struct inet_bind_bucket *inet_bind_bucket_create(stru=
ct kmem_cache *cachep,
>   */
>  void inet_bind_bucket_destroy(struct inet_bind_bucket *tb)
>  {
> +       const struct inet_bind2_bucket *tb2;
> +
>         if (hlist_empty(&tb->bhash2)) {
>                 hlist_del_rcu(&tb->node);
>                 kfree_rcu(tb, rcu);
> +               return;
> +       }
> +
> +       if (tb->fastreuse =3D=3D -1 && tb->fastreuseport =3D=3D -1)
> +               return;
> +       hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
> +               if (tb2->fastreuse !=3D -1 || tb2->fastreuseport !=3D -1)
> +                       return;
>         }
> +       tb->fastreuse =3D -1;
> +       tb->fastreuseport =3D -1;
>  }
>
>  bool inet_bind_bucket_match(const struct inet_bind_bucket *tb, const str=
uct net *net,
> @@ -121,6 +133,8 @@ static void inet_bind2_bucket_init(struct inet_bind2_=
bucket *tb2,
>  #else
>         tb2->rcv_saddr =3D sk->sk_rcv_saddr;
>  #endif
> +       tb2->fastreuse =3D 0;
> +       tb2->fastreuseport =3D 0;
>         INIT_HLIST_HEAD(&tb2->owners);
>         hlist_add_head(&tb2->node, &head->chain);
>         hlist_add_head(&tb2->bhash_node, &tb->bhash2);
> @@ -143,11 +157,23 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(=
struct kmem_cache *cachep,
>  /* Caller must hold hashbucket lock for this tb with local BH disabled *=
/
>  void inet_bind2_bucket_destroy(struct kmem_cache *cachep, struct inet_bi=
nd2_bucket *tb)
>  {
> +       const struct sock *sk;
> +
>         if (hlist_empty(&tb->owners)) {
>                 __hlist_del(&tb->node);
>                 __hlist_del(&tb->bhash_node);
>                 kmem_cache_free(cachep, tb);
> +               return;
> +       }
> +
> +       if (tb->fastreuse =3D=3D -1 && tb->fastreuseport =3D=3D -1)
> +               return;
> +       sk_for_each_bound(sk, &tb->owners) {
> +               if (!inet_sk_autobind(sk))
> +                       return;
>         }
> +       tb->fastreuse =3D -1;
> +       tb->fastreuseport =3D -1;
>  }
>
>  static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket =
*tb2,
> @@ -191,6 +217,7 @@ static void __inet_put_port(struct sock *sk)
>         tb =3D inet_csk(sk)->icsk_bind_hash;
>         inet_csk(sk)->icsk_bind_hash =3D NULL;
>         inet_sk(sk)->inet_num =3D 0;
> +       inet_clear_bit(AUTOBIND, sk);
>
>         spin_lock(&head2->lock);
>         if (inet_csk(sk)->icsk_bind2_hash) {
> @@ -277,7 +304,7 @@ int __inet_inherit_port(const struct sock *sk, struct=
 sock *child)
>                 }
>         }
>         if (update_fastreuse)
> -               inet_csk_update_fastreuse(tb, child);
> +               inet_csk_update_fastreuse(child, tb, tb2);
>         inet_bind_hash(child, tb, tb2, port);
>         spin_unlock(&head2->lock);
>         spin_unlock(&head->lock);
> @@ -1136,6 +1163,8 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>                                                head2, tb, sk);
>                 if (!tb2)
>                         goto error;
> +               tb2->fastreuse =3D -1;
> +               tb2->fastreuseport =3D -1;
>         }
>
>         /* Here we want to add a little bit of randomness to the next sou=
rce
> @@ -1148,6 +1177,7 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>
>         /* Head lock still held and bh's disabled */
>         inet_bind_hash(sk, tb, tb2, port);
> +       inet_set_bit(AUTOBIND, sk);
>
>         if (sk_unhashed(sk)) {
>                 inet_sk(sk)->inet_sport =3D htons(port);
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 875ff923a8ed..0150f5697040 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -206,6 +206,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const stru=
ct sock *sk,
>                 tw->tw_hash         =3D sk->sk_hash;
>                 tw->tw_ipv6only     =3D 0;
>                 tw->tw_transparent  =3D inet_test_bit(TRANSPARENT, sk);
> +               tw->tw_autobind     =3D inet_test_bit(AUTOBIND, sk);
>                 tw->tw_prot         =3D sk->sk_prot_creator;
>                 atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie=
));
>                 twsk_net_set(tw, sock_net(sk));
>
> --
> 2.43.0
>

