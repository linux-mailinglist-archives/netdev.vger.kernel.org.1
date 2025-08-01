Return-Path: <netdev+bounces-211320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89CB17F8C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC85516610D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459F2264BD;
	Fri,  1 Aug 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7sK3xPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910511EC018
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041602; cv=none; b=dKOgLC7GanOyZXdFDZwGxKzHGefIHGhfCnT1QVgAMeeuksUYGk6E11rjNSV11ak2ty2ux6Ktyt+9+7tz/gmUodbtD0QOonMSU5I7JiD2tPa/XVahw+haq5vS2kuMy8XGDdAg1xe9iyGw/3Kuk2qktYU+XKBKQgl9v02OSK46FKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041602; c=relaxed/simple;
	bh=659EqXl6yE+K192+p2hXdLrilZLhFeUSbKmGL5IEDuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM8UFkWgTyBnqVFj2IFCTpQf8qopgdWNgcl3mva00eZ4EIicshwVQiiQkm0wRobEMOyl/iiWFeeutQvBX3M1esYee+7+focEIWN25NJz+5DbI+8RNze8GL3fi0jFLJ4IaKgmCwpE9A5QTUvMB65gOl2AqK4P3qEdJ1VFCckVFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7sK3xPd; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e29616cc4fso168294685a.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754041599; x=1754646399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPi1aRA1xy91XJSfBFoK3IbCuYOH+ZWgmp1gomg+FIY=;
        b=X7sK3xPdtIjUIUvE2ICZSNdL+u7DcbZ26VpNBZzAhs/mjgmxfak5b9q580nzmeejQX
         akBSAhahTe48ru1dsoFCkMJxOm26CmyQy7zm81wR+Jf8gCTMah0WZKT/OL/d1aXahKl2
         nLT8MwmRaDo1LV1cM3b7EgoTMyUVK2mW8hnSin5n+6PUXsNd1H7vOYn6+/qaJ++7PYge
         1cBMUH4gZM0K27W54OpOIfOPp6qrJ8K4x14cYRRaJXfqRlB31f0GI62V7ltVDG/tsIV5
         smXNWeHZsO0IW81rChHSL4yqY/Kybn6GZz89/bL+aL3xyz2/oa+1wqZZ4l+tOSUEi2kz
         52Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041599; x=1754646399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPi1aRA1xy91XJSfBFoK3IbCuYOH+ZWgmp1gomg+FIY=;
        b=Kd8S4fRl4+x8VdmIklnSG7rttd17/52PorYyBwEHZgkV44l5twClCbUX1MuFa2knlB
         y7/b0YOizJSq24FpIRCmVTSOtnMAqhLWlH0O0/aGspXxNDatyAHntGcDfU6pB0P35E47
         CQGWmal9NQl4qNnybWlPHRNf53bWOfoscjiZlMAmO8nTEjmse7hXWV5y9n6or5KfBf9n
         B/a0Xu9HQmBbj29HPVAugHSq+RpQaji++WBkqF4M0QSFV9pSLV24n+iM8Rcr/u6Ll3Sc
         FmSe6SlSWfdaWAoTHK8bHL/kCAFSNBG+r2hGeGIvmpv2N/ZfD1qbzLP+Chkzg0u9pFil
         rLEA==
X-Forwarded-Encrypted: i=1; AJvYcCXznjpmTdlyUE6gBfbazMVMrZWXcIZHcxaj1FDbXfDcMVV4mZbWElulN3gfFozm2jISOSeNyr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHSoHCrGJBlAvswmph1dWqywVoIMqk8qtthFWTTjPlev4jP5V
	beFpApnXcIddcKbjkzupGG2JIZulMqgU1/7nED5BIsNoffUy8fAEUmcv2yg5iqPQWHwsgAFTMBk
	nmrCzXh9Zpzsv2GWivmJxSfXhuWryEwFbu54/YfXN
X-Gm-Gg: ASbGnctCVfxJYEHDdHW564H/FY2TrzQBDGZQIru9e8o9x8PhrCdBdf12VKFwQLs7cv+
	wQph8hoDXTORkLFld6vcpiEmc2x53iLBCYS7ydeyFyyNHxPEqOgpmonQXH3sA87iNIwHMWzHTE/
	HexhgMX3yCwba8ZusuTmlZHjXdo89g8/ArZ3MAHesvFfqy5UasRrWYE3shDoAE4sGliMe1Uqea5
	QKqyEomoJ+17bviqQ==
X-Google-Smtp-Source: AGHT+IH5+AVzG2YKzJItrUExqdrxQbWcyIoiCHcENs4Lyz2n4Tl4WHQkFzDLbWs1ZPUbGv2W2sIGATnVtkwCM+4GgD4=
X-Received: by 2002:a05:620a:a901:b0:7e0:9b88:133f with SMTP id
 af79cd13be357-7e66f397bd8mr1279842385a.39.1754041599054; Fri, 01 Aug 2025
 02:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250801090949.129941-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Aug 2025 02:46:27 -0700
X-Gm-Features: Ac12FXx4oNA4sAnx7B_ITjSBDalU-s3xy4RLLSG5kiFNg6GqhW7MbWEy_QgYKYI
Message-ID: <CANn89i+1-geie7HrSmZeU-OvT-aDJabbtcwrZaHr-1S16yuRZw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuniyu@google.com, kraig@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:09=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> For now, the socket lookup will terminate if the socket is reuse port in
> inet_lhash2_lookup(), which makes the socket is not the best match.
>
> For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> but socket1 bind on "eth0". We create socket1 first, and then socket2.
> Then, all connections will goto socket2, which is not expected, as socket=
1
> has higher priority.
>
> This can cause unexpected behavior if TCP MD5 keys is used, as described
> in Documentation/networking/vrf.rst -> Applications.
>
> Therefore, we compute a score for the reuseport socket and add it to the
> list with order in __inet_hash(). Sockets with high score will be added
> to the head.
>
> Link: https://lore.kernel.org/netdev/20250731123309.184496-1-dongml2@chin=
atelecom.cn/
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

You forgot a Fixes: tag, and a selftest.

> ---
> v2:
> - As Kuniyuki advised, sort the reuseport socket in __inet_hash() to keep
>   the lookup for reuseport O(1)

Keeping sorted the list is difficult, we would have to intercept
SO_BINDTODEVICE, SO_BINDTOIFINDEX, SO_INCOMING_CPU.

This also makes the patch risky to backport to stable versions,
because it is complex and possibly buggy.

Therefore I prefer your first approach.

> ---
>  include/linux/rculist_nulls.h | 34 ++++++++++++++++++++++++
>  include/net/sock.h            |  5 ++++
>  net/ipv4/inet_hashtables.c    | 49 ++++++++++++++++++++++++++++++++---
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..da500f4ae142 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hli=
st_nulls_node *n)
>  #define hlist_nulls_next_rcu(node) \
>         (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>
> +/**
> + * hlist_nulls_pprev_rcu - returns the element of the list after @node.
> + * @node: element of the list.
> + */
> +#define hlist_nulls_pprev_rcu(node) \
> +       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> +
>  /**
>   * hlist_nulls_del_rcu - deletes entry from hash list without re-initial=
ization
>   * @n: the element to delete from the hash list.
> @@ -145,6 +152,33 @@ static inline void hlist_nulls_add_tail_rcu(struct h=
list_nulls_node *n,
>         }
>  }
>
> +/**
> + * hlist_nulls_add_before_rcu
> + * @n: the new element to add to the hash list.
> + * @next: the existing element to add the new element before.
> + *
> + * Description:
> + * Adds the specified element to the specified hlist
> + * before the specified node while permitting racing traversals.
> + *
> + * The caller must take whatever precautions are necessary
> + * (such as holding appropriate locks) to avoid racing
> + * with another list-mutation primitive, such as hlist_nulls_add_head_rc=
u()
> + * or hlist_nulls_del_rcu(), running on this same list.
> + * However, it is perfectly legal to run concurrently with
> + * the _rcu list-traversal primitives, such as
> + * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
> + * problems on Alpha CPUs.
> + */
> +static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n=
,
> +                                             struct hlist_nulls_node *ne=
xt)
> +{
> +       WRITE_ONCE(n->pprev, next->pprev);
I do not think WRITE_ONCE() is necessary here, @n is private to this cpu,
and following rcu_assign_pointer() has the needed barrier.

> +       n->next =3D next;
> +       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> +       WRITE_ONCE(next->pprev, &n->next);
> +}
> +
>  /* after that hlist_nulls_del will work */
>  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>  {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c8a4b283df6f..42aa1919eeee 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -885,6 +885,11 @@ static inline void __sk_nulls_add_node_tail_rcu(stru=
ct sock *sk, struct hlist_nu
>         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
>  }
>
> +static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, struc=
t sock *next)
> +{
> +       hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_nulls_no=
de);
> +}
> +
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_n=
ulls_head *list)
>  {
>         sock_hold(sk);
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..80d8bec41a58 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -334,6 +334,26 @@ static inline int compute_score(struct sock *sk, con=
st struct net *net,
>         return score;
>  }
>
> +static inline int compute_reuseport_score(struct sock *sk)
> +{
> +       int score =3D 0;
> +
> +       if (sk->sk_bound_dev_if)
> +               score +=3D 2;
> +
> +       if (sk->sk_family =3D=3D PF_INET)
> +               score +=3D 10;
> +
> +       /* the priority of sk_incoming_cpu should be lower than sk_bound_=
dev_if,
> +        * as it's optional in compute_score(). Thank God, this is the on=
ly

Please do not bring God here.

> +        * variable condition, which we can't judge now.
> +        */
> +       if (READ_ONCE(sk->sk_incoming_cpu))
> +               score++;
> +
> +       return score;
> +}
> +
>  /**
>   * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket i=
f necessary.
>   * @net: network namespace.
> @@ -739,6 +759,27 @@ static int inet_reuseport_add_sock(struct sock *sk,
>         return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
>  }
>
> +static void inet_hash_reuseport(struct sock *sk, struct hlist_nulls_head=
 *head)
> +{
> +       const struct hlist_nulls_node *node;
> +       int score, curscore;
> +       struct sock *sk2;
> +
> +       curscore =3D compute_reuseport_score(sk);
> +       /* lookup the socket to insert before */
> +       sk_nulls_for_each_rcu(sk2, node, head) {
> +               if (!sk2->sk_reuseport)
> +                       continue;
> +               score =3D compute_reuseport_score(sk2);
> +               if (score <=3D curscore) {
> +                       __sk_nulls_add_node_before_rcu(sk, sk2);
> +                       return;
> +               }
> +       }
> +
> +       __sk_nulls_add_node_tail_rcu(sk, head);
> +}
> +
>  int __inet_hash(struct sock *sk, struct sock *osk)
>  {
>         struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> @@ -761,11 +802,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>                         goto unlock;
>         }
>         sock_set_flag(sk, SOCK_RCU_FREE);
> -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> -               sk->sk_family =3D=3D AF_INET6)
> -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> -       else
> +       if (!sk->sk_reuseport)
>                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> +       else
> +               inet_hash_reuseport(sk, &ilb2->nulls_head);
> +
>         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  unlock:
>         spin_unlock(&ilb2->lock);
> --
> 2.50.1
>

