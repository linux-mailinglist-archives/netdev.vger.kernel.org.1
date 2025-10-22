Return-Path: <netdev+bounces-231898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E8BFE5E0
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2844E897C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20653054EC;
	Wed, 22 Oct 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo6csdbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A55287258
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170687; cv=none; b=fJE9NVd9EOvMTYTCJAtwDCkuAF0vVSZMHdmVzZ9on8h4pKf/FOolbvZIc5uiSNOutVBldK85qiTsjUowWcZs7RWn9jzX+3RFQ/K7t2ialijTmO77vKa82veqpIlXx5ae14zr2qW0nwjx33xyK1bBw23oOrYI0VVhY4IU86hy39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170687; c=relaxed/simple;
	bh=rWoxjM+PGkWnxVG9HCf/WTeZ1d8rynXAymqZXZkH/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HujPgTvsNeelH+5+3S9mdzy8/mTQ78cDvNT3DFxzjqnrUS2Ro/LqfskkduVhnBlmL0qEt3uSO3iv4J1Wi7l4Z0+A8OLw4UYmH7EIry9+EFgEYOLVMsruxB/ANZuhr6AWzy88vvBaaLhCoVyOxwqmM8ZvBkIn1NMNkLVYyu0QF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo6csdbg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a226a0798cso103288b3a.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170685; x=1761775485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qAhHCjmv5gkTy1a2o5t0ybUHeKCUs2J/4+wewPDG1E=;
        b=Vo6csdbgj7bRbWF8hSQOERde3ehr1F4MhRW9oZ34N/OH+axgnWJ+drcHu8QfYUf12N
         dCcEtv/Rs/kvv0X7og0u3hIFu5BPF3ojKnn3aLqyKRtMhqmHBrt2IQYWPaN2b7GIQmZ1
         GoePD9wNT7hDeYD9M8lsO30L+HYeOzUTcOuv8s+EgLv79+/ip+Y+baJwv5oqhIC0NOqR
         QEPQE3o4YuQ46tINgFaHfA7omy7aORd80dtiKQAt9ryE7IbtXtF4VDpQYdD/oG3cZFIR
         uFs4H92j4BkwR4DsGZiWt/e7MP37msQLDkZn1GEbJ2gSIWkBULF6Z4s97SGZdp44c6iI
         iX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170685; x=1761775485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qAhHCjmv5gkTy1a2o5t0ybUHeKCUs2J/4+wewPDG1E=;
        b=k+qGIzqYq+8A6sS7SyiROggu3c0ffdwm7/s9+/S5x2KmXRUDPU4w8uySAxVG/F80Fe
         Gf1hz+Dp9V+CWmES6a9W6cNSInEC6TeuRnZqlheX/3ARq6x09GF2KRROU5zBAyM80VA7
         zT38L8kYQm8AjaUG7j5b2yLv0OIyrK1SyfrTE7N0b84uT1g4M9ovTKs3W4Wk8gUETSGh
         KquGPltKDYCP7P2tVC38cr2kVrKjjbhqf+4kIuMSvc5V07i2bZ8fdpshIbTE9aqE44JA
         gzmOWKCli/rfOiX2Ur1Ynwqv/vuixwByiNnAcp7qmtxTHLpqmujqdpkIiauqPeLZ9hEz
         6HoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7TeKne7Cvkr2h46XHbEr4spsarenP5sb4waAPWspd0Z/bmR6oaRYfZXUmDul4Jr0RLWxXi2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzYBdO49pymacfh/ERmcQ1QXkQ5TFXAH2xRUIC7MolnlscTRc
	gtbuwta6rjPz6idYoiM3MqYO1Pql597mcnYKB58K7TGNT919UWUFikfSb1T+vOyE8LbfiaDcMHZ
	XzKsKPASddbjYBiqUvvOj3h3HD+IIxzzyhMSp
X-Gm-Gg: ASbGncuh8oNLei3/OEBgqRlkxWFvr3Css4RIIap+QxWbOqRYRbMSks3CTO7leBA08xS
	ZoJFRtcTS8VrK7vgocoHYkubO2uV/MdcIfNJjFrUZ6cEc54wppTo3rlnl9NUAMD6dxwn6q//fIH
	bxXeyQYL4Zc+5BPw7FehTHOYmBC3h4YqvynztR+X6Q3lV24DM452ATXBQa3kCXvb6sYlumywI76
	3JSjhW9rvX9c7r8Id5v9fesoFNMHoF/cuKZFurMYjbKoDY3KS8FVvhdYgQCRwg=
X-Google-Smtp-Source: AGHT+IGYxCBoyWvdN/VSG8pA0bcr4l1tn5ydnzTb6Pqhj+Nv75wr3lySUDaqralKwaL5k87KpZ8lQzvkP5mpnSGUVHw=
X-Received: by 2002:a17:902:d506:b0:290:c5c8:9412 with SMTP id
 d9443c01a7336-290c9cf37demr306635615ad.5.1761170685314; Wed, 22 Oct 2025
 15:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
In-Reply-To: <20251022211722.2819414-5-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 22 Oct 2025 18:04:33 -0400
X-Gm-Features: AS18NWAe9qGCNUxQfSkBRK1m93hvTLQCEetKXxHtraeklL49ANOwRClJpLhBhFg
Message-ID: <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_accept() will use sk_clone_lock(), but it will be called
> with the parent socket locked, and sctp_migrate() acquires the
> child lock later.
>
> Let's add no lock version of sk_clone_lock().
>
> Note that lockdep complains if we simply use bh_lock_sock_nested().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/sock.h |  7 ++++++-
>  net/core/sock.c    | 21 ++++++++++++++-------
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 01ce231603db..c7e58b8e8a90 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int family,=
 gfp_t priority,
>  void sk_free(struct sock *sk);
>  void sk_net_refcnt_upgrade(struct sock *sk);
>  void sk_destruct(struct sock *sk);
> -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
> +struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool =
lock);
> +
> +static inline struct sock *sk_clone_lock(const struct sock *sk, const gf=
p_t priority)
> +{
> +       return sk_clone(sk, priority, true);
> +}
>
>  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int fo=
rce,
>                              gfp_t priority);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a99132cc0965..0a3021f8f8c1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
>  }
>
>  /**
> - *     sk_clone_lock - clone a socket, and lock its clone
> - *     @sk: the socket to clone
> - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> + * sk_clone - clone a socket
> + * @sk: the socket to clone
> + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> + * @lock: if true, lock the cloned sk
>   *
> - *     Caller must unlock socket even in error path (bh_unlock_sock(news=
k))
> + * If @lock is true, the clone is locked by bh_lock_sock(), and
> + * caller must unlock socket even in error path by bh_unlock_sock().
>   */
> -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
> +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> +                     bool lock)
>  {
>         struct proto *prot =3D READ_ONCE(sk->sk_prot);
>         struct sk_filter *filter;
> @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk, =
const gfp_t priority)
>                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker=
,
>                                       false, priority);
>         }
> +
>         sk_node_init(&newsk->sk_node);
>         sock_lock_init(newsk);
> -       bh_lock_sock(newsk);
> +
> +       if (lock)
> +               bh_lock_sock(newsk);
> +
does it really need bh_lock_sock() that early, if not, maybe we can move
it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone()?

>         newsk->sk_backlog.head  =3D newsk->sk_backlog.tail =3D NULL;
>         newsk->sk_backlog.len =3D 0;
>
> @@ -2595,7 +2602,7 @@ struct sock *sk_clone_lock(const struct sock *sk, c=
onst gfp_t priority)
>         newsk =3D NULL;
>         goto out;
>  }
> -EXPORT_SYMBOL_GPL(sk_clone_lock);
> +EXPORT_SYMBOL_GPL(sk_clone);
>
>  static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device =
*dev)
>  {
> --
> 2.51.1.814.gb8fa24458f-goog
>

