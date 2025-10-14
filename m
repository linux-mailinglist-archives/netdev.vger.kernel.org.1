Return-Path: <netdev+bounces-229254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA88BD9D67
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E493B3497
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFC31353C;
	Tue, 14 Oct 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqbrlJD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98B30CD9E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450394; cv=none; b=sTnu0zuSgDx8Q4xCESQ6vw3UxpMh+6JchcyHwh0kgzVzuFYVFtuKRvgm56wu5t83P/5rB1mPLABaiK8AOtLjuo8nHaXIwHyljK+mb/Nmw1GCj/+JJTfm3Gv4YWmSxEDKUeXcyeLnZnz9WI5Arn6ZbFC5cJgwcbyYyIQ1WGbFnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450394; c=relaxed/simple;
	bh=nhnZY29oAMEmAcEp0j7Tsrqu0C0/+duWzEQfWjMWXHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDRoX9p3A92ce8z7EMrZ8CJtGtr4E5mqJ8DIDBXcDeMqjUHTkPc43Hib7D84xdjHb0axdoZAqGALCDtyUqzq8hO+hlncx7JlcAr8Ybw0vhMcnwQMg5vCNhtsAMHupfxKN+Satl8lFCLaIBwhiGrNivycQdiViNIBU+KEeP6jxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AqbrlJD0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85b94fe19e2so761067485a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760450391; x=1761055191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiJcJ1553CNt1W0zyJKQLz2bZiHr9+/j5jOOwpBlpmg=;
        b=AqbrlJD0NIc00XufTVRAcYKCIPKWsf27t7pQx4HjABtSkbTUXg48vw72Xo0tc9YnGh
         SsKQgmQi83mY2IrHPDgJAd1z0AJ+xMUketNK+PXNmDz2OH0I56vvwmpKHXdNjHu5LmrS
         C9fJtNgokjUG8v71/ZfjUbSbgS245P50UWLJ9wnICd0NiAp7MAj42BuitWRInzEBIkHZ
         nEwWCEe22ehK4MSqe6P3c1NJHsg/NRF9uxyMAvcnRDXnVKKzHGBR+I3uNSyI/0nGgcCi
         DkUwQppAGzvF1O7gqvYZZwILr2S71mGVKJJGI6/o+xwWO8BXceuRcIq35ota/W8WhASS
         BuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450391; x=1761055191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiJcJ1553CNt1W0zyJKQLz2bZiHr9+/j5jOOwpBlpmg=;
        b=eXDox5KcMbvheZBGZ0znE4VL+AqhPyEwRgt1Qw/8jZ/eqkIwNm0wUhRmy5JJfC2HtI
         XsbZpfEk31tPKqDrnRP/Vj0eDYxeYhgqpDklanVV5G7H/ikwRl+c5XexBsTChLQhau0s
         BNC51M9aneEuqNlJE+nZQfM0KCFnQnn/cf5XxvHiIqs5lObr4U8qYE2YBUUl5DXzeHUg
         ZEb1Dfste0Qk3GW4ARtGPwOau6j0T2e8eyP1/qgkLDf5iILcRk5KGtcDj/b/rnf/fRZa
         QL2IA6xySjIHN/ARmlCCw9GJeAzn+gIeLU6V+PLfNhYnZtALRc6bREj1bv6wDTf4kS56
         EiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1GpoIpyjOcQ8akxzirQwDRPvLGTr1sl5deYP+WbY6La/trAseF0TUDX3NhXpgM1VXV7N9OFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxGvIwx7OhTtI4SMR61BRt1rO9G9Ns6rw/MUU7hyGtwlvATJc
	F+DpXd/HOsaNih7QoDGgFBQDHA+3N8Tc5y8Fal5TOO8YGl6iiflBXIYGVAKunronGhgLZFjc4vC
	AQLv5jqLwGxF76WYE8yOOyLJrJPrRPNg5SZGZpi99
X-Gm-Gg: ASbGncv/0HExEM9mRTBSEwXLii3B3Bx1FeAOySLcSm1M83WkXIbtnFnO0Sns/WrHJfR
	+nqQykL6udT758lsV63WqVFji1/6dGb59WwnboM/VF9bKtPzRueYmlH52Nii4VE3BYzZqXaokDq
	KOSeRLjvW7JixI4o5Wkv9fERDW2oeXKtDovnzBONGTNWQ9grA/7LqFfKIzfWAW//1N2cDf83gPZ
	rHRvwsZXgBwLTCSp1lOsUO99aeNVafBG+YC5vCixYBzXoIJ6FscmA==
X-Google-Smtp-Source: AGHT+IHcZl0nNVHCVnd2WKWq5gM3PRNKOiXacSPDA28wyU7Q6etDhfytDq4k7HvYYGSxIW2bZO8abZpkKNw6HpNGbgQ=
X-Received: by 2002:ac8:5d46:0:b0:4ce:9cdc:6f2f with SMTP id
 d75a77b69052e-4e72122afacmr133744731cf.13.1760450391187; Tue, 14 Oct 2025
 06:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014022703.1387794-1-xuanqiang.luo@linux.dev> <20251014022703.1387794-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20251014022703.1387794-3-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 06:59:39 -0700
X-Gm-Features: AS18NWBADVQ-EonwFHxi8Izz0NUUghMI-JUjvf4CIj2cjRMPAfjjRpT16RXLvyg
Message-ID: <CANn89iJyKo0xLh5EE1hTJQF8vmqKT-yeK1oWokRpguEdjF-eoA@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v7 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, pabeni@redhat.com, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	horms@kernel.org, jiayuan.chen@linux.dev, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:28=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since ehash lookups are lockless, if one CPU performs a lookup while
> another concurrently deletes and inserts (removing reqsk and inserting sk=
),
> the lookup may fail to find the socket, an RST may be sent.
>
> The call trace map is drawn as follows:
>    CPU 0                           CPU 1
>    -----                           -----
>                                 inet_ehash_insert()
>                                 spin_lock()
>                                 sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>         (lookup failed)
>                                 __sk_nulls_add_node_rcu(sk, list)
>                                 spin_unlock()
>
> As both deletion and insertion operate on the same ehash chain, this patc=
h
> introduces a new sk_nulls_replace_node_init_rcu() helper functions to
> implement atomic replacement.
>
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/net/sock.h         | 14 ++++++++++++++
>  net/ipv4/inet_hashtables.c |  8 ++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60bcb13f045c..5d299a954859 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -858,6 +858,20 @@ static inline bool sk_nulls_del_node_init_rcu(struct=
 sock *sk)
>         return rc;
>  }
>
> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
> +                                                 struct sock *new)
> +{
> +       if (sk_hashed(old)) {
> +               hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
> +                                            &new->sk_nulls_node);
> +               DEBUG_NET_WARN_ON_ONCE(refcount_read(&old->sk_refcnt) =3D=
=3D 1);

This  DEBUG_NET_WARN_ON_ONCE() is not needed.

You copied a WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1) which
predates the conversion
of sk_refcnt from atomic_t to refcount_t

refcount_dec() has a check which will complain just the same.

I will send a patch  removing the leftovers:

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..596302bffedf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -828,11 +828,9 @@ static inline bool sk_del_node_init(struct sock *sk)
 {
        bool rc =3D __sk_del_node_init(sk);

-       if (rc) {
-               /* paranoid for a while -acme */
-               WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);
+       if (rc)
                __sock_put(sk);
-       }
+
        return rc;
 }
 #define sk_del_node_init_rcu(sk)       sk_del_node_init(sk)
@@ -850,11 +848,9 @@ static inline bool
sk_nulls_del_node_init_rcu(struct sock *sk)
 {
        bool rc =3D __sk_nulls_del_node_init_rcu(sk);

-       if (rc) {
-               /* paranoid for a while -acme */
-               WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);
+       if (rc)
                __sock_put(sk);
-       }
+
        return rc;
 }

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2b46c0cd752a..687a84c48882 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -596,10 +596,8 @@ static void netlink_remove(struct sock *sk)

        table =3D &nl_table[sk->sk_protocol];
        if (!rhashtable_remove_fast(&table->hash, &nlk_sk(sk)->node,
-                                   netlink_rhashtable_params)) {
-               WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);
+                                   netlink_rhashtable_params))
                __sock_put(sk);
-       }

        netlink_table_grab();
        if (nlk_sk(sk)->subscriptions) {
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 1574a83384f8..bc614a1f019c 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3031,10 +3031,8 @@ static void tipc_sk_remove(struct tipc_sock *tsk)
        struct sock *sk =3D &tsk->sk;
        struct tipc_net *tn =3D net_generic(sock_net(sk), tipc_net_id);

-       if (!rhashtable_remove_fast(&tn->sk_rht, &tsk->node, tsk_rht_params=
)) {
-               WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);
+       if (!rhashtable_remove_fast(&tn->sk_rht, &tsk->node, tsk_rht_params=
))
                __sock_put(sk);
-       }
 }

 static const struct rhashtable_params tsk_rht_params =3D {

