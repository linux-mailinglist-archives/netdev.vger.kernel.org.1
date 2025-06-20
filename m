Return-Path: <netdev+bounces-199793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA0AE1CEF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C65166672
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CB28B51F;
	Fri, 20 Jun 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqlPPvUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F428BA9B
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427898; cv=none; b=P5NWRIWFUhm80J2DLfbe4ELUSZlK2No3uMJFXpbq1gcbqX5ZebaedLPf1/ZjFqs95eymmkrw5a78DGzCBSoZG+vGld7pn4e1LW6dSG0y4fAr3+/MvVB1MuBa/7Oj1otdXhSmoYrVyzDgnmuCHBy89GDzzz31N/xoQdppOCC1EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427898; c=relaxed/simple;
	bh=CzBJu2QRmtJNLNatP4Lv5TLETULoMo7lfGNcxdeqfYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/5CyTRl6fDVr2AK5r6crSA3T5uNNuQIs8/NKjPWjN/P6fggZ3uSEDUrYtdL8vAFWUPP7/ftCKDFXymWjgZaNclq76EmUqcV9P/V6ia8+jyA2Ywij8n7PDEY252WfXky3vzITeH2anRdDICzMKu/BOv5G91+eb4NHW2otrHdl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqlPPvUN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso19127a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750427894; x=1751032694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iSzwfi/v3TLSCuNn84tjoeSxP0BkjlDcxLe/0lQ7vE=;
        b=QqlPPvUNP/J+H7c/M0JW7uiBteJq/fS7hWK+QnFRRFSAP5zCvF2exk72//CiTMDqv4
         WgZEXMG/9RxBCrUqduV5cuFNrmGnQxltkHZmYs+zJYKgiZmp4TbUCI45VuFhIDtoBCDX
         ayIpdqnFq/T0c13v6PgnrivVHy3EPJ0NQyViT6EsHfB0M93vyZf0JVoOcJoZoN7E2Iov
         GgOWuryPznMW5n37rBs2POWaB96/LOMb9QRLITcjbaWTRK5u5hfCKtSBCdv1zkIBepmf
         IIL/qHEcOxlyntS3LCOFNT6l9zYIOHCJePTBRR9WbvDid05m/XThY73LvwPFuw4XRFJI
         gjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427894; x=1751032694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iSzwfi/v3TLSCuNn84tjoeSxP0BkjlDcxLe/0lQ7vE=;
        b=W7dzoB3I/pDXxikVOW0K/3kf5PaYEBJEXhrfzOf+gKaJR93woP7FaUfqsSx2sXDY+O
         0SKItxsfMDMSbmCKTWdtCDVyn8erUVH8R9yWyXx8e1BCoh7lJQMu1xr9pmslnTjWFT8y
         +6vwjT00bRY/cTtYGWR3/2zmNdw9RgKgfXwyq1AMmasuJzQXPku/iXGz2xaDDe1Np4zr
         KDL3am5VMdFNFHN+G5uF/voPmLqwbHxqqoK/BA+UfS5IbNDS6sztIkfRJJw8y5DbPK4B
         8GhBaF8YTHc99diUkENIDh7OFGsJd8/+ZjghLJkgr7EwOFFJ97UHNFbdqkSv1EUPfd/a
         bkZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/qKt1Ovk6FeaD034L1As601P620rQ5fmHhwgWot/oUw2aNm6UpIxyX3exgMwbCOZyNt1JeEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsbJLKhGDq3j2mVdga868zSvkIaZp4dFC1D61zySE2vpsH5i4
	+M3djNznU/B5ZHK1L3JgVA3kbtXrmvlplLGDRyNXJs0JQhhzGMC1GXOaS2EXVZTeHRvFAC51dS3
	rzzFaDC85CJ7e8sNE4NX62x9x9V+WsOfEKluFXOlP
X-Gm-Gg: ASbGncvB1BrCgW80VNOfY9oAWOVgWNDXNdsmnKSZIstwGB0ubme3ANwO26V2HStg278
	eO3vYrTwpSCez/qawIY55Lij1k9VfCPg8vv9YAtCHJlk1ZYpLB7mXDwhPFuT6TySZ76T3VxdIlf
	ycBBU/IP3Kgq3pzyBoaHJFg2scnrHJNjhd0Trrtg==
X-Google-Smtp-Source: AGHT+IEIIBiMV+5Id/Pn/iyxMAggAfxJsnOaZXEuPShTsdrtmcyqZyOwHA0XCu+3Ab2mgdDhEuRSn6TULc+fShaUfMQ=
X-Received: by 2002:a50:d70a:0:b0:600:9008:4a40 with SMTP id
 4fb4d7f45d1cf-609e77a45aamr147418a12.4.1750427893269; Fri, 20 Jun 2025
 06:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620133001.4090592-1-edumazet@google.com> <20250620133001.4090592-3-edumazet@google.com>
In-Reply-To: <20250620133001.4090592-3-edumazet@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 20 Jun 2025 15:57:51 +0200
X-Gm-Features: Ac12FXyESgb6tRNqie-w6yt1dxUyc7qp97MTSOjWbLQ2L2sjmOnAr4hgTMeeE0M
Message-ID: <CANP3RGciRgv527qWw5riLJhZ_36PHN8DgWekhJ3Y7t=FZ6TrJg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: remove sock_i_uid()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Lorenzo Colitti <lorenzo@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Difference between sock_i_uid() and sk_uid() is that
> after sock_orphan(), sock_i_uid() returns GLOBAL_ROOT_UID
> while sk_uid() returns the last cached sk->sk_uid value.
>
> None of sock_i_uid() callers care about this.
>
> Use sk_uid() which is much faster and inlined.
>
> Note that diag/dump users are calling sock_i_ino() and
> can not see the full benefit yet.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> ---
>  include/net/sock.h              |  2 --
>  net/appletalk/atalk_proc.c      |  2 +-
>  net/bluetooth/af_bluetooth.c    |  2 +-
>  net/core/sock.c                 | 11 -----------
>  net/ipv4/inet_connection_sock.c | 27 ++++++++++++---------------
>  net/ipv4/inet_diag.c            |  2 +-
>  net/ipv4/inet_hashtables.c      |  4 ++--
>  net/ipv4/ping.c                 |  2 +-
>  net/ipv4/raw.c                  |  2 +-
>  net/ipv4/tcp_ipv4.c             |  8 ++++----
>  net/ipv4/udp.c                  | 16 ++++++++--------
>  net/ipv6/datagram.c             |  2 +-
>  net/ipv6/tcp_ipv6.c             |  4 ++--
>  net/key/af_key.c                |  2 +-
>  net/llc/llc_proc.c              |  2 +-
>  net/packet/af_packet.c          |  2 +-
>  net/packet/diag.c               |  2 +-
>  net/phonet/socket.c             |  4 ++--
>  net/sctp/input.c                |  2 +-
>  net/sctp/proc.c                 |  4 ++--
>  net/sctp/socket.c               |  4 ++--
>  net/smc/smc_diag.c              |  2 +-
>  net/tipc/socket.c               |  2 +-
>  net/unix/af_unix.c              |  2 +-
>  net/unix/diag.c                 |  2 +-
>  net/xdp/xsk_diag.c              |  2 +-
>  26 files changed, 50 insertions(+), 66 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index fc5e6f66b00a0c0786d29c8967738e45ab673071..bbd97fbc5935cd44eb2b23c20=
5473856cda44451 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2092,8 +2092,6 @@ static inline void sock_graft(struct sock *sk, stru=
ct socket *parent)
>         write_unlock_bh(&sk->sk_callback_lock);
>  }
>
> -kuid_t sock_i_uid(struct sock *sk);
> -
>  static inline kuid_t sk_uid(const struct sock *sk)
>  {
>         /* Paired with WRITE_ONCE() in sockfs_setattr() */
> diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
> index 9c1241292d1d2efbc9b0de39f39f23aa0bf4f6a8..01787fb6a7bce27669e4a31d6=
38fb63a40767c1b 100644
> --- a/net/appletalk/atalk_proc.c
> +++ b/net/appletalk/atalk_proc.c
> @@ -181,7 +181,7 @@ static int atalk_seq_socket_show(struct seq_file *seq=
, void *v)
>                    sk_wmem_alloc_get(s),
>                    sk_rmem_alloc_get(s),
>                    s->sk_state,
> -                  from_kuid_munged(seq_user_ns(seq), sock_i_uid(s)));
> +                  from_kuid_munged(seq_user_ns(seq), sk_uid(s)));
>  out:
>         return 0;
>  }
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 6ad2f72f53f4e546dd4a3267c8f3d87c8f4118ee..ee9bf84c88a70bd926ec5aace=
b3a326817e48c5f 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -815,7 +815,7 @@ static int bt_seq_show(struct seq_file *seq, void *v)
>                            refcount_read(&sk->sk_refcnt),
>                            sk_rmem_alloc_get(sk),
>                            sk_wmem_alloc_get(sk),
> -                          from_kuid(seq_user_ns(seq), sock_i_uid(sk)),
> +                          from_kuid(seq_user_ns(seq), sk_uid(sk)),
>                            sock_i_ino(sk),
>                            bt->parent ? sock_i_ino(bt->parent) : 0LU);
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 502042a0d3b5f80529ca8be50e9d9d6585091054..ceb74ceecb6c0dd836f25e156=
59c7ee8d71565eb 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2780,17 +2780,6 @@ void sock_pfree(struct sk_buff *skb)
>  EXPORT_SYMBOL(sock_pfree);
>  #endif /* CONFIG_INET */
>
> -kuid_t sock_i_uid(struct sock *sk)
> -{
> -       kuid_t uid;
> -
> -       read_lock_bh(&sk->sk_callback_lock);
> -       uid =3D sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_uid : GLOBAL=
_ROOT_UID;
> -       read_unlock_bh(&sk->sk_callback_lock);
> -       return uid;
> -}
> -EXPORT_SYMBOL(sock_i_uid);
> -
>  unsigned long __sock_i_ino(struct sock *sk)
>  {
>         unsigned long ino;
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 46750c96d08ea3ed4d6b693618dbb79d7ebfedc0..f4157d26ec9e41eb2650b4d01=
55f796d2d535766 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -168,7 +168,7 @@ static bool inet_use_bhash2_on_bind(const struct sock=
 *sk)
>  }
>
>  static bool inet_bind_conflict(const struct sock *sk, struct sock *sk2,
> -                              kuid_t sk_uid, bool relax,
> +                              kuid_t uid, bool relax,
>                                bool reuseport_cb_ok, bool reuseport_ok)
>  {
>         int bound_dev_if2;
> @@ -185,12 +185,12 @@ static bool inet_bind_conflict(const struct sock *s=
k, struct sock *sk2,
>                         if (!relax || (!reuseport_ok && sk->sk_reuseport =
&&
>                                        sk2->sk_reuseport && reuseport_cb_=
ok &&
>                                        (sk2->sk_state =3D=3D TCP_TIME_WAI=
T ||
> -                                       uid_eq(sk_uid, sock_i_uid(sk2))))=
)
> +                                       uid_eq(uid, sk_uid(sk2)))))
>                                 return true;
>                 } else if (!reuseport_ok || !sk->sk_reuseport ||
>                            !sk2->sk_reuseport || !reuseport_cb_ok ||
>                            (sk2->sk_state !=3D TCP_TIME_WAIT &&
> -                           !uid_eq(sk_uid, sock_i_uid(sk2)))) {
> +                           !uid_eq(uid, sk_uid(sk2)))) {
>                         return true;
>                 }
>         }
> @@ -198,7 +198,7 @@ static bool inet_bind_conflict(const struct sock *sk,=
 struct sock *sk2,
>  }
>
>  static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *s=
k2,
> -                                  kuid_t sk_uid, bool relax,
> +                                  kuid_t uid, bool relax,
>                                    bool reuseport_cb_ok, bool reuseport_o=
k)
>  {
>         if (ipv6_only_sock(sk2)) {
> @@ -211,20 +211,20 @@ static bool __inet_bhash2_conflict(const struct soc=
k *sk, struct sock *sk2,
>  #endif
>         }
>
> -       return inet_bind_conflict(sk, sk2, sk_uid, relax,
> +       return inet_bind_conflict(sk, sk2, uid, relax,
>                                   reuseport_cb_ok, reuseport_ok);
>  }
>
>  static bool inet_bhash2_conflict(const struct sock *sk,
>                                  const struct inet_bind2_bucket *tb2,
> -                                kuid_t sk_uid,
> +                                kuid_t uid,
>                                  bool relax, bool reuseport_cb_ok,
>                                  bool reuseport_ok)
>  {
>         struct sock *sk2;
>
>         sk_for_each_bound(sk2, &tb2->owners) {
> -               if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
> +               if (__inet_bhash2_conflict(sk, sk2, uid, relax,
>                                            reuseport_cb_ok, reuseport_ok)=
)
>                         return true;
>         }
> @@ -242,8 +242,8 @@ static int inet_csk_bind_conflict(const struct sock *=
sk,
>                                   const struct inet_bind2_bucket *tb2, /*=
 may be null */
>                                   bool relax, bool reuseport_ok)
>  {
> -       kuid_t uid =3D sock_i_uid((struct sock *)sk);
>         struct sock_reuseport *reuseport_cb;
> +       kuid_t uid =3D sk_uid(sk);
>         bool reuseport_cb_ok;
>         struct sock *sk2;
>
> @@ -287,11 +287,11 @@ static int inet_csk_bind_conflict(const struct sock=
 *sk,
>  static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int por=
t, int l3mdev,
>                                           bool relax, bool reuseport_ok)
>  {
> -       kuid_t uid =3D sock_i_uid((struct sock *)sk);
>         const struct net *net =3D sock_net(sk);
>         struct sock_reuseport *reuseport_cb;
>         struct inet_bind_hashbucket *head2;
>         struct inet_bind2_bucket *tb2;
> +       kuid_t uid =3D sk_uid(sk);
>         bool conflict =3D false;
>         bool reuseport_cb_ok;
>
> @@ -425,15 +425,13 @@ inet_csk_find_open_port(const struct sock *sk, stru=
ct inet_bind_bucket **tb_ret,
>  static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
>                                      struct sock *sk)
>  {
> -       kuid_t uid =3D sock_i_uid(sk);
> -
>         if (tb->fastreuseport <=3D 0)
>                 return 0;
>         if (!sk->sk_reuseport)
>                 return 0;
>         if (rcu_access_pointer(sk->sk_reuseport_cb))
>                 return 0;
> -       if (!uid_eq(tb->fastuid, uid))
> +       if (!uid_eq(tb->fastuid, sk_uid(sk)))
>                 return 0;
>         /* We only need to check the rcv_saddr if this tb was once marked
>          * without fastreuseport and then was reset, as we can only know =
that
> @@ -458,14 +456,13 @@ static inline int sk_reuseport_match(struct inet_bi=
nd_bucket *tb,
>  void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
>                                struct sock *sk)
>  {
> -       kuid_t uid =3D sock_i_uid(sk);
>         bool reuse =3D sk->sk_reuse && sk->sk_state !=3D TCP_LISTEN;
>
>         if (hlist_empty(&tb->bhash2)) {
>                 tb->fastreuse =3D reuse;
>                 if (sk->sk_reuseport) {
>                         tb->fastreuseport =3D FASTREUSEPORT_ANY;
> -                       tb->fastuid =3D uid;
> +                       tb->fastuid =3D sk_uid(sk);
>                         tb->fast_rcv_saddr =3D sk->sk_rcv_saddr;
>                         tb->fast_ipv6_only =3D ipv6_only_sock(sk);
>                         tb->fast_sk_family =3D sk->sk_family;
> @@ -492,7 +489,7 @@ void inet_csk_update_fastreuse(struct inet_bind_bucke=
t *tb,
>                          */
>                         if (!sk_reuseport_match(tb, sk)) {
>                                 tb->fastreuseport =3D FASTREUSEPORT_STRIC=
T;
> -                               tb->fastuid =3D uid;
> +                               tb->fastuid =3D sk_uid(sk);
>                                 tb->fast_rcv_saddr =3D sk->sk_rcv_saddr;
>                                 tb->fast_ipv6_only =3D ipv6_only_sock(sk)=
;
>                                 tb->fast_sk_family =3D sk->sk_family;
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 1d1d6ad53f4c9173cbcb644a301bfbc2f2d5925c..2fa53b16fe7788eed9796c847=
6157a77eced096c 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -181,7 +181,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct =
sk_buff *skb,
>                 goto errout;
>  #endif
>
> -       r->idiag_uid =3D from_kuid_munged(user_ns, sock_i_uid(sk));
> +       r->idiag_uid =3D from_kuid_munged(user_ns, sk_uid(sk));
>         r->idiag_inode =3D sock_i_ino(sk);
>
>         memset(&inet_sockopt, 0, sizeof(inet_sockopt));
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 77a0b52b2eabfc6b08c34acea9fda092b88a32b5..ceeeec9b7290aabdab8c400cd=
202312b0f0be70b 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -721,8 +721,8 @@ static int inet_reuseport_add_sock(struct sock *sk,
>  {
>         struct inet_bind_bucket *tb =3D inet_csk(sk)->icsk_bind_hash;
>         const struct hlist_nulls_node *node;
> +       kuid_t uid =3D sk_uid(sk);
>         struct sock *sk2;
> -       kuid_t uid =3D sock_i_uid(sk);
>
>         sk_nulls_for_each_rcu(sk2, node, &ilb->nulls_head) {
>                 if (sk2 !=3D sk &&
> @@ -730,7 +730,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
>                     ipv6_only_sock(sk2) =3D=3D ipv6_only_sock(sk) &&
>                     sk2->sk_bound_dev_if =3D=3D sk->sk_bound_dev_if &&
>                     inet_csk(sk2)->icsk_bind_hash =3D=3D tb &&
> -                   sk2->sk_reuseport && uid_eq(uid, sock_i_uid(sk2)) &&
> +                   sk2->sk_reuseport && uid_eq(uid, sk_uid(sk2)) &&
>                     inet_rcv_saddr_equal(sk, sk2, false))
>                         return reuseport_add_sock(sk, sk2,
>                                                   inet_rcv_saddr_any(sk))=
;
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 4eacaf00e2e9b7780090af4d10a9f974918282fd..031df4c19fcc5ca18137695c7=
8358c3ad96a2c4a 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -1116,7 +1116,7 @@ static void ping_v4_format_sock(struct sock *sp, st=
ruct seq_file *f,
>                 sk_wmem_alloc_get(sp),
>                 sk_rmem_alloc_get(sp),
>                 0, 0L, 0,
> -               from_kuid_munged(seq_user_ns(f), sock_i_uid(sp)),
> +               from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
>                 0, sock_i_ino(sp),
>                 refcount_read(&sp->sk_refcnt), sp,
>                 atomic_read(&sp->sk_drops));
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 32f942d0f944cc3e60448d9d24ab0ae2b03e73e6..1d2c89d63cc71f39d742c8156=
879847fc4e53c71 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -1043,7 +1043,7 @@ static void raw_sock_seq_show(struct seq_file *seq,=
 struct sock *sp, int i)
>                 sk_wmem_alloc_get(sp),
>                 sk_rmem_alloc_get(sp),
>                 0, 0L, 0,
> -               from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
> +               from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
>                 0, sock_i_ino(sp),
>                 refcount_read(&sp->sk_refcnt), sp, atomic_read(&sp->sk_dr=
ops));
>  }
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 6a14f9e6fef645511be5738e0ead22e168fb20b2..429fb34b075e0bdad0e1c55dd=
6b1101b3dfe78dd 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2896,7 +2896,7 @@ static void get_openreq4(const struct request_sock =
*req,
>                 jiffies_delta_to_clock_t(delta),
>                 req->num_timeout,
>                 from_kuid_munged(seq_user_ns(f),
> -                                sock_i_uid(req->rsk_listener)),
> +                                sk_uid(req->rsk_listener)),
>                 0,  /* non standard timer */
>                 0, /* open_requests have no inode */
>                 0,
> @@ -2954,7 +2954,7 @@ static void get_tcp4_sock(struct sock *sk, struct s=
eq_file *f, int i)
>                 timer_active,
>                 jiffies_delta_to_clock_t(timer_expires - jiffies),
>                 icsk->icsk_retransmits,
> -               from_kuid_munged(seq_user_ns(f), sock_i_uid(sk)),
> +               from_kuid_munged(seq_user_ns(f), sk_uid(sk)),
>                 icsk->icsk_probes_out,
>                 sock_i_ino(sk),
>                 refcount_read(&sk->sk_refcnt), sk,
> @@ -3246,9 +3246,9 @@ static int bpf_iter_tcp_seq_show(struct seq_file *s=
eq, void *v)
>                 const struct request_sock *req =3D v;
>
>                 uid =3D from_kuid_munged(seq_user_ns(seq),
> -                                      sock_i_uid(req->rsk_listener));
> +                                      sk_uid(req->rsk_listener));
>         } else {
> -               uid =3D from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)=
);
> +               uid =3D from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
>         }
>
>         meta.seq =3D seq;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index f94bb222aa2d4919ffd60b51ed74b536fb9a218d..19573ee64a0f18cf55df34ace=
1956e9c3e20172c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -145,8 +145,8 @@ static int udp_lib_lport_inuse(struct net *net, __u16=
 num,
>                                unsigned long *bitmap,
>                                struct sock *sk, unsigned int log)
>  {
> +       kuid_t uid =3D sk_uid(sk);
>         struct sock *sk2;
> -       kuid_t uid =3D sock_i_uid(sk);
>
>         sk_for_each(sk2, &hslot->head) {
>                 if (net_eq(sock_net(sk2), net) &&
> @@ -158,7 +158,7 @@ static int udp_lib_lport_inuse(struct net *net, __u16=
 num,
>                     inet_rcv_saddr_equal(sk, sk2, true)) {
>                         if (sk2->sk_reuseport && sk->sk_reuseport &&
>                             !rcu_access_pointer(sk->sk_reuseport_cb) &&
> -                           uid_eq(uid, sock_i_uid(sk2))) {
> +                           uid_eq(uid, sk_uid(sk2))) {
>                                 if (!bitmap)
>                                         return 0;
>                         } else {
> @@ -180,8 +180,8 @@ static int udp_lib_lport_inuse2(struct net *net, __u1=
6 num,
>                                 struct udp_hslot *hslot2,
>                                 struct sock *sk)
>  {
> +       kuid_t uid =3D sk_uid(sk);
>         struct sock *sk2;
> -       kuid_t uid =3D sock_i_uid(sk);
>         int res =3D 0;
>
>         spin_lock(&hslot2->lock);
> @@ -195,7 +195,7 @@ static int udp_lib_lport_inuse2(struct net *net, __u1=
6 num,
>                     inet_rcv_saddr_equal(sk, sk2, true)) {
>                         if (sk2->sk_reuseport && sk->sk_reuseport &&
>                             !rcu_access_pointer(sk->sk_reuseport_cb) &&
> -                           uid_eq(uid, sock_i_uid(sk2))) {
> +                           uid_eq(uid, sk_uid(sk2))) {
>                                 res =3D 0;
>                         } else {
>                                 res =3D 1;
> @@ -210,7 +210,7 @@ static int udp_lib_lport_inuse2(struct net *net, __u1=
6 num,
>  static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hsl=
ot)
>  {
>         struct net *net =3D sock_net(sk);
> -       kuid_t uid =3D sock_i_uid(sk);
> +       kuid_t uid =3D sk_uid(sk);
>         struct sock *sk2;
>
>         sk_for_each(sk2, &hslot->head) {
> @@ -220,7 +220,7 @@ static int udp_reuseport_add_sock(struct sock *sk, st=
ruct udp_hslot *hslot)
>                     ipv6_only_sock(sk2) =3D=3D ipv6_only_sock(sk) &&
>                     (udp_sk(sk2)->udp_port_hash =3D=3D udp_sk(sk)->udp_po=
rt_hash) &&
>                     (sk2->sk_bound_dev_if =3D=3D sk->sk_bound_dev_if) &&
> -                   sk2->sk_reuseport && uid_eq(uid, sock_i_uid(sk2)) &&
> +                   sk2->sk_reuseport && uid_eq(uid, sk_uid(sk2)) &&
>                     inet_rcv_saddr_equal(sk, sk2, false)) {
>                         return reuseport_add_sock(sk, sk2,
>                                                   inet_rcv_saddr_any(sk))=
;
> @@ -3387,7 +3387,7 @@ static void udp4_format_sock(struct sock *sp, struc=
t seq_file *f,
>                 sk_wmem_alloc_get(sp),
>                 udp_rqueue_get(sp),
>                 0, 0L, 0,
> -               from_kuid_munged(seq_user_ns(f), sock_i_uid(sp)),
> +               from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
>                 0, sock_i_ino(sp),
>                 refcount_read(&sp->sk_refcnt), sp,
>                 atomic_read(&sp->sk_drops));
> @@ -3630,7 +3630,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *s=
eq, void *v)
>                 goto unlock;
>         }
>
> -       uid =3D from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
> +       uid =3D from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
>         meta.seq =3D seq;
>         prog =3D bpf_iter_get_info(&meta, false);
>         ret =3D udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index 83f5aa5e133ab291b46fe73eff4cb12954834340..281722817a65c4279c6569d8b=
dce471ed294919c 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -1064,7 +1064,7 @@ void __ip6_dgram_sock_seq_show(struct seq_file *seq=
, struct sock *sp,
>                    sk_wmem_alloc_get(sp),
>                    rqueue,
>                    0, 0L, 0,
> -                  from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
> +                  from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
>                    0,
>                    sock_i_ino(sp),
>                    refcount_read(&sp->sk_refcnt), sp,
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index f61b0396ef6b1831592c40862caabd73abd92489..f0ce62549d90d6492b8ab1396=
40cca91e4a9c2c7 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2168,7 +2168,7 @@ static void get_openreq6(struct seq_file *seq,
>                    jiffies_to_clock_t(ttd),
>                    req->num_timeout,
>                    from_kuid_munged(seq_user_ns(seq),
> -                                   sock_i_uid(req->rsk_listener)),
> +                                   sk_uid(req->rsk_listener)),
>                    0,  /* non standard timer */
>                    0, /* open_requests have no inode */
>                    0, req);
> @@ -2234,7 +2234,7 @@ static void get_tcp6_sock(struct seq_file *seq, str=
uct sock *sp, int i)
>                    timer_active,
>                    jiffies_delta_to_clock_t(timer_expires - jiffies),
>                    icsk->icsk_retransmits,
> -                  from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
> +                  from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
>                    icsk->icsk_probes_out,
>                    sock_i_ino(sp),
>                    refcount_read(&sp->sk_refcnt), sp,
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index efc2a91f4c487ed0f1375568f3d02c2bfd5344fc..1f82f69acfde23f24e801db95=
3c0632400c2fa7f 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3788,7 +3788,7 @@ static int pfkey_seq_show(struct seq_file *f, void =
*v)
>                                refcount_read(&s->sk_refcnt),
>                                sk_rmem_alloc_get(s),
>                                sk_wmem_alloc_get(s),
> -                              from_kuid_munged(seq_user_ns(f), sock_i_ui=
d(s)),
> +                              from_kuid_munged(seq_user_ns(f), sk_uid(s)=
),
>                                sock_i_ino(s)
>                                );
>         return 0;
> diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
> index 07e9abb5978a71e2570278b6bb554f41d64693d5..aa81c67b24a1566149fca5652=
f95ad4ba226552d 100644
> --- a/net/llc/llc_proc.c
> +++ b/net/llc/llc_proc.c
> @@ -151,7 +151,7 @@ static int llc_seq_socket_show(struct seq_file *seq, =
void *v)
>                    sk_wmem_alloc_get(sk),
>                    sk_rmem_alloc_get(sk) - llc->copied_seq,
>                    sk->sk_state,
> -                  from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
> +                  from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
>                    llc->link);
>  out:
>         return 0;
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 3d43f3eae7599ebc331bca46e5145fe4b43e8f5a..f6b1ff883c9318facdcb9c311=
2b94f0b6e40d504 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -4783,7 +4783,7 @@ static int packet_seq_show(struct seq_file *seq, vo=
id *v)
>                            READ_ONCE(po->ifindex),
>                            packet_sock_flag(po, PACKET_SOCK_RUNNING),
>                            atomic_read(&s->sk_rmem_alloc),
> -                          from_kuid_munged(seq_user_ns(seq), sock_i_uid(=
s)),
> +                          from_kuid_munged(seq_user_ns(seq), sk_uid(s)),
>                            sock_i_ino(s));
>         }
>
> diff --git a/net/packet/diag.c b/net/packet/diag.c
> index 47f69f3dbf73e98b24fd4012eb048c776c15618f..6ce1dcc284d92021ca7b53b9a=
0fd5626918ef8aa 100644
> --- a/net/packet/diag.c
> +++ b/net/packet/diag.c
> @@ -153,7 +153,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_bu=
ff *skb,
>
>         if ((req->pdiag_show & PACKET_SHOW_INFO) &&
>             nla_put_u32(skb, PACKET_DIAG_UID,
> -                       from_kuid_munged(user_ns, sock_i_uid(sk))))
> +                       from_kuid_munged(user_ns, sk_uid(sk))))
>                 goto out_nlmsg_trim;
>
>         if ((req->pdiag_show & PACKET_SHOW_MCLIST) &&
> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index 5ce0b3ee5def8471ab1231d32bc16840d842bdbd..ea4d5e6533dba737f77bedbba=
1b1ef2ec3c17568 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -584,7 +584,7 @@ static int pn_sock_seq_show(struct seq_file *seq, voi=
d *v)
>                         sk->sk_protocol, pn->sobject, pn->dobject,
>                         pn->resource, sk->sk_state,
>                         sk_wmem_alloc_get(sk), sk_rmem_alloc_get(sk),
> -                       from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)=
),
> +                       from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
>                         sock_i_ino(sk),
>                         refcount_read(&sk->sk_refcnt), sk,
>                         atomic_read(&sk->sk_drops));
> @@ -755,7 +755,7 @@ static int pn_res_seq_show(struct seq_file *seq, void=
 *v)
>
>                 seq_printf(seq, "%02X %5u %lu",
>                            (int) (psk - pnres.sk),
> -                          from_kuid_munged(seq_user_ns(seq), sock_i_uid(=
sk)),
> +                          from_kuid_munged(seq_user_ns(seq), sk_uid(sk))=
,
>                            sock_i_ino(sk));
>         }
>         seq_pad(seq, '\n');
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index 0c0d2757f6f8df8f1930557ef3bbf25ab6a07217..2dc2666988fbc97a8a52b885a=
e12c19ffce4b7f4 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -756,7 +756,7 @@ static int __sctp_hash_endpoint(struct sctp_endpoint =
*ep)
>                         struct sock *sk2 =3D ep2->base.sk;
>
>                         if (!net_eq(sock_net(sk2), net) || sk2 =3D=3D sk =
||
> -                           !uid_eq(sock_i_uid(sk2), sock_i_uid(sk)) ||
> +                           !uid_eq(sk_uid(sk2), sk_uid(sk)) ||
>                             !sk2->sk_reuseport)
>                                 continue;
>
> diff --git a/net/sctp/proc.c b/net/sctp/proc.c
> index ec00ee75d59a658b7ad0086314f7e82a49ffc876..74bff317e205c841b9862f7af=
a80fed811d53c89 100644
> --- a/net/sctp/proc.c
> +++ b/net/sctp/proc.c
> @@ -177,7 +177,7 @@ static int sctp_eps_seq_show(struct seq_file *seq, vo=
id *v)
>                 seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5lu "=
, ep, sk,
>                            sctp_sk(sk)->type, sk->sk_state, hash,
>                            ep->base.bind_addr.port,
> -                          from_kuid_munged(seq_user_ns(seq), sock_i_uid(=
sk)),
> +                          from_kuid_munged(seq_user_ns(seq), sk_uid(sk))=
,
>                            sock_i_ino(sk));
>
>                 sctp_seq_dump_local_addrs(seq, &ep->base);
> @@ -267,7 +267,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq,=
 void *v)
>                    assoc->assoc_id,
>                    assoc->sndbuf_used,
>                    atomic_read(&assoc->rmem_alloc),
> -                  from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
> +                  from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
>                    sock_i_ino(sk),
>                    epb->bind_addr.port,
>                    assoc->peer.port);
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1e5739858c2067381ccc713756ff56e585d152ad..aa6400811018e0835ad91990f=
363c69d439c5aa0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -8345,8 +8345,8 @@ static int sctp_get_port_local(struct sock *sk, uni=
on sctp_addr *addr)
>         bool reuse =3D (sk->sk_reuse || sp->reuse);
>         struct sctp_bind_hashbucket *head; /* hash list */
>         struct net *net =3D sock_net(sk);
> -       kuid_t uid =3D sock_i_uid(sk);
>         struct sctp_bind_bucket *pp;
> +       kuid_t uid =3D sk_uid(sk);
>         unsigned short snum;
>         int ret;
>
> @@ -8444,7 +8444,7 @@ static int sctp_get_port_local(struct sock *sk, uni=
on sctp_addr *addr)
>                             (reuse && (sk2->sk_reuse || sp2->reuse) &&
>                              sk2->sk_state !=3D SCTP_SS_LISTENING) ||
>                             (sk->sk_reuseport && sk2->sk_reuseport &&
> -                            uid_eq(uid, sock_i_uid(sk2))))
> +                            uid_eq(uid, sk_uid(sk2))))
>                                 continue;
>
>                         if ((!sk->sk_bound_dev_if || !bound_dev_if2 ||
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8ed2f6689b017098ff8e8a3c1=
5b8104d69643437 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -64,7 +64,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, str=
uct sk_buff *skb,
>         if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown))
>                 return 1;
>
> -       r->diag_uid =3D from_kuid_munged(user_ns, sock_i_uid(sk));
> +       r->diag_uid =3D from_kuid_munged(user_ns, sk_uid(sk));
>         r->diag_inode =3D sock_i_ino(sk);
>         return 0;
>  }
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 7c61d47ea2086058c6fe11a19383c3029f4acb52..e028bf6584992c5ab7307d810=
82fbe4582e78068 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -3642,7 +3642,7 @@ int tipc_sk_fill_sock_diag(struct sk_buff *skb, str=
uct netlink_callback *cb,
>             nla_put_u32(skb, TIPC_NLA_SOCK_INO, sock_i_ino(sk)) ||
>             nla_put_u32(skb, TIPC_NLA_SOCK_UID,
>                         from_kuid_munged(sk_user_ns(NETLINK_CB(cb->skb).s=
k),
> -                                        sock_i_uid(sk))) ||
> +                                        sk_uid(sk))) ||
>             nla_put_u64_64bit(skb, TIPC_NLA_SOCK_COOKIE,
>                               tipc_diag_gen_cookie(sk),
>                               TIPC_NLA_SOCK_PAD))
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 22e170fb5dda7f9a4b40ac6406047780eecff3e1..1e320f89168d1cd4b5e8fa565=
65cce9f008ab857 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3682,7 +3682,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *=
seq, void *v)
>                 goto unlock;
>         }
>
> -       uid =3D from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
> +       uid =3D from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
>         meta.seq =3D seq;
>         prog =3D bpf_iter_get_info(&meta, false);
>         ret =3D unix_prog_seq_show(prog, &meta, v, uid);
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index 79b182d0e62ae4e2faf8358e36ee39e6facdc766..ca34730261510c2b34dc6661e=
adaa9d1651e59d2 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -106,7 +106,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct=
 sk_buff *nlskb)
>  static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb,
>                             struct user_namespace *user_ns)
>  {
> -       uid_t uid =3D from_kuid_munged(user_ns, sock_i_uid(sk));
> +       uid_t uid =3D from_kuid_munged(user_ns, sk_uid(sk));
>         return nla_put(nlskb, UNIX_DIAG_UID, sizeof(uid_t), &uid);
>  }
>
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 09dcea0cbbed97d9a41e88224994279cfbf8c536..0e0bca031c0399901949982bf=
430ade6cde286d3 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -119,7 +119,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_b=
uff *nlskb,
>
>         if ((req->xdiag_show & XDP_SHOW_INFO) &&
>             nla_put_u32(nlskb, XDP_DIAG_UID,
> -                       from_kuid_munged(user_ns, sock_i_uid(sk))))
> +                       from_kuid_munged(user_ns, sk_uid(sk))))
>                 goto out_nlmsg_trim;
>
>         if ((req->xdiag_show & XDP_SHOW_RING_CFG) &&
> --
> 2.50.0.rc2.701.gf1e915cc24-goog
>

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

