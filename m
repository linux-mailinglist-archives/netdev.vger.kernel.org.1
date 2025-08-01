Return-Path: <netdev+bounces-211328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E9B18052
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E8C627EBF
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7F233D88;
	Fri,  1 Aug 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlqmJQNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC422688C;
	Fri,  1 Aug 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044967; cv=none; b=pkZZNij5u7kx8jI23OXQuWeOz9A6zseuOyeaLgwBmpmmOjLf14blbSK1xJR7YCymsFI6RNAJlmL/in1iCN1uZwxLE9DGAibG698M4f9brhTvaLAkPMaodKbTHvdrpOd+fAKS2A/RK+bRZrQ8laracbL5g35H50LO4bWWX10V3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044967; c=relaxed/simple;
	bh=Jt5tBY+Xx4mf+jwc1RjCTmIxx+v8BfSVjSVSYI8YKZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCtGYcju06epQ/4RqBIGfLre1AtFOcS91Wvcz/2UEB/kGVrwHcnZwLWeLYemI0J/44zKAI0DolYzsze1RkVx45cj+J85OS/pVdhYkNjZRBwqe/ethfSpgRK6mfwpO4IcYwyaVG3tHeoxOAZLn2x3pmkAgvphFJFjgP+0drKXIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlqmJQNf; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso574704276.2;
        Fri, 01 Aug 2025 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754044965; x=1754649765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVMqVJZuAnuuF74U0yJYklbDE/G7ppW4BJX2FN7qWHE=;
        b=mlqmJQNf+iY6a3v3AJUdH5lX7QaH2YpZS7sIgvTknNzXIbzh1gUjgM65U8pGgUvI3O
         Ql8tUmEUUxbFvWrmIWG+iZh6eM5J9EnDgGzCkbZvEtFur3MJ59e3s8YAE6OI+/XGXtes
         gvJFvHYWWgpRoZI/BZcELMFbik5n5OZuzur6JrdESZbqJ9p8fmlSvQ15CaZw8uXXefKR
         wdwlmOJ4NTZpC/MSZc7kkjYcAS6NRNjN4EDkkm1pVHn3DqyGoGieHeCSb8RVpFLoj1dG
         FRr/a9zfaPI8d4smEhzTKFY5EiSUkFSzdaL3rMcXOZxGXX6j1Sx5xh+zOjfRUXdnQbW+
         zrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044965; x=1754649765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVMqVJZuAnuuF74U0yJYklbDE/G7ppW4BJX2FN7qWHE=;
        b=VhcNXOgowKFR9i4FEWQFLR9X4RjE/nYxSz/IlJM4lQwGiGkt9Yqwz8WlzK33JEczYe
         mezLdPHzF5z0RkzbD9XapprNaR24A+fB9afqsqTpibAo+MdUZywHC6lW3gFFdSAtEbla
         Wvn4gYh2hpFjDkqX/DzoRyjpdUHSV3Mm4yC+JIM3FCHjsxk6WVSTFjmJ0Bh5g9HvP6Mg
         ShKeQZWI3YPbbGAgsRr5d+TVyTUGyXg6sUCXYisrL3d0Gs+Zlv+RC127va/DQu3d6hIJ
         722sXrAz2cbQyQIMdA/5tpZE58mZui1xRAtMbDaDwmg9/QAKgwN3i3Vij2yBHUnuiDjG
         W99Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMoHpdlLHKQjOKxFBhGDY/1coupklMb0UVjeLXZEbYKWny2f6wftvBUDY/q6nXgiECn0tXxEsGKtrARY8=@vger.kernel.org, AJvYcCXoR61VUclEa2VWDAeau8nQs7wOdfU4KBJLQsW+k94taCRiOAH4F3ZUMXpIBq2AgUSVPcc9vFyt@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyRPpDxeTpl5RifUJsiJxhBE0kmDsmLaf9Tsso3b2YlHBL7o3
	kVkyf5kA0NtHvaodcZ8/v0ySK6A25cERhvo7J/4KIvSyfEfD2NWno2f+BBcG6M54/94lbkORt6/
	vL4Ezp7cu8AAaqvM5FpChdLX5Mo5pl5yvM165BZKHDg==
X-Gm-Gg: ASbGncuXsWbj7gRHys5XKMUj+U0rDw+lX06UW8QwbgQ/PBF8/VGKrtV64P7o4/vajxy
	XB/YFxinr28S/lboou2uRbOgVLXtt646eOOPMJKlfvpOc4Bn4idQhboPSotSMCKlyk116KVrVHG
	T+Qgw4f9HY4p0dafChDo+Q0POoP+fTeB2zbiCCnQT11tWX5V/1d3GBV7qYxmnKC1GxVJY8erkvh
	/DLcPM=
X-Google-Smtp-Source: AGHT+IFbwjURAdETg/w04ShhWGZR5fyJsfReH3Yy4UUvhGdx25tfAoRZqUWXzpaoEUUJHiNcLj5+2lVKnzL2f22y/2k=
X-Received: by 2002:a05:690c:fce:b0:71b:78f2:9599 with SMTP id
 00721157ae682-71b78f296ddmr5458607b3.22.1754044964539; Fri, 01 Aug 2025
 03:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn> <CANn89i+1-geie7HrSmZeU-OvT-aDJabbtcwrZaHr-1S16yuRZw@mail.gmail.com>
In-Reply-To: <CANn89i+1-geie7HrSmZeU-OvT-aDJabbtcwrZaHr-1S16yuRZw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 18:42:33 +0800
X-Gm-Features: Ac12FXw9it7Ti6kFvJ4Jsa-x-hKmriQJoq8hUiAxJEQRGS4yIvS_JFu_kK1G9Q8
Message-ID: <CADxym3Y2B+mcR6E_VYowE1VvCsa6X15RieOAr2nEofOswf_qfA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, kraig@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Aug 1, 2025 at 2:09=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > For now, the socket lookup will terminate if the socket is reuse port i=
n
> > inet_lhash2_lookup(), which makes the socket is not the best match.
> >
> > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> > but socket1 bind on "eth0". We create socket1 first, and then socket2.
> > Then, all connections will goto socket2, which is not expected, as sock=
et1
> > has higher priority.
> >
> > This can cause unexpected behavior if TCP MD5 keys is used, as describe=
d
> > in Documentation/networking/vrf.rst -> Applications.
> >
> > Therefore, we compute a score for the reuseport socket and add it to th=
e
> > list with order in __inet_hash(). Sockets with high score will be added
> > to the head.
> >
> > Link: https://lore.kernel.org/netdev/20250731123309.184496-1-dongml2@ch=
inatelecom.cn/
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> You forgot a Fixes: tag, and a selftest.

I was not sure if it should be a Fixes, I'll add it in the next version.
Kuniyuki's test case is nice. Should I put the selftests in the
commit log?

>
> > ---
> > v2:
> > - As Kuniyuki advised, sort the reuseport socket in __inet_hash() to ke=
ep
> >   the lookup for reuseport O(1)
>
> Keeping sorted the list is difficult, we would have to intercept
> SO_BINDTODEVICE, SO_BINDTOIFINDEX, SO_INCOMING_CPU.
>
> This also makes the patch risky to backport to stable versions,
> because it is complex and possibly buggy.
>
> Therefore I prefer your first approach.

Kuniyuki also has a similar patch:
https://lore.kernel.org/netdev/CADxym3ZY7Lm9mgv83e2db7o3ZZMcLDa=3DvDf6nJSs1=
m0_tUk5Bg@mail.gmail.com/T/#m56ee67b2fdf85ce568fd1339def92c53232d5b49

Will his be better and stable? Kuniyuki say the first approach
kill the O(1) lookup for reuseport socket :/

Anyway, I'll send a V3 with the first approach, and with
the Fixes + selftests

Thanks!
Menglong Dong

>
> > ---
> >  include/linux/rculist_nulls.h | 34 ++++++++++++++++++++++++
> >  include/net/sock.h            |  5 ++++
> >  net/ipv4/inet_hashtables.c    | 49 ++++++++++++++++++++++++++++++++---
> >  3 files changed, 84 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_null=
s.h
> > index 89186c499dd4..da500f4ae142 100644
> > --- a/include/linux/rculist_nulls.h
> > +++ b/include/linux/rculist_nulls.h
> > @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct h=
list_nulls_node *n)
> >  #define hlist_nulls_next_rcu(node) \
> >         (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
> >
> > +/**
> > + * hlist_nulls_pprev_rcu - returns the element of the list after @node=
.
> > + * @node: element of the list.
> > + */
> > +#define hlist_nulls_pprev_rcu(node) \
> > +       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> > +
> >  /**
> >   * hlist_nulls_del_rcu - deletes entry from hash list without re-initi=
alization
> >   * @n: the element to delete from the hash list.
> > @@ -145,6 +152,33 @@ static inline void hlist_nulls_add_tail_rcu(struct=
 hlist_nulls_node *n,
> >         }
> >  }
> >
> > +/**
> > + * hlist_nulls_add_before_rcu
> > + * @n: the new element to add to the hash list.
> > + * @next: the existing element to add the new element before.
> > + *
> > + * Description:
> > + * Adds the specified element to the specified hlist
> > + * before the specified node while permitting racing traversals.
> > + *
> > + * The caller must take whatever precautions are necessary
> > + * (such as holding appropriate locks) to avoid racing
> > + * with another list-mutation primitive, such as hlist_nulls_add_head_=
rcu()
> > + * or hlist_nulls_del_rcu(), running on this same list.
> > + * However, it is perfectly legal to run concurrently with
> > + * the _rcu list-traversal primitives, such as
> > + * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistenc=
y
> > + * problems on Alpha CPUs.
> > + */
> > +static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node =
*n,
> > +                                             struct hlist_nulls_node *=
next)
> > +{
> > +       WRITE_ONCE(n->pprev, next->pprev);
> I do not think WRITE_ONCE() is necessary here, @n is private to this cpu,
> and following rcu_assign_pointer() has the needed barrier.
>
> > +       n->next =3D next;
> > +       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> > +       WRITE_ONCE(next->pprev, &n->next);
> > +}
> > +
> >  /* after that hlist_nulls_del will work */
> >  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
> >  {
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index c8a4b283df6f..42aa1919eeee 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -885,6 +885,11 @@ static inline void __sk_nulls_add_node_tail_rcu(st=
ruct sock *sk, struct hlist_nu
> >         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
> >  }
> >
> > +static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, str=
uct sock *next)
> > +{
> > +       hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_nulls_=
node);
> > +}
> > +
> >  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist=
_nulls_head *list)
> >  {
> >         sock_hold(sk);
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index ceeeec9b7290..80d8bec41a58 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -334,6 +334,26 @@ static inline int compute_score(struct sock *sk, c=
onst struct net *net,
> >         return score;
> >  }
> >
> > +static inline int compute_reuseport_score(struct sock *sk)
> > +{
> > +       int score =3D 0;
> > +
> > +       if (sk->sk_bound_dev_if)
> > +               score +=3D 2;
> > +
> > +       if (sk->sk_family =3D=3D PF_INET)
> > +               score +=3D 10;
> > +
> > +       /* the priority of sk_incoming_cpu should be lower than sk_boun=
d_dev_if,
> > +        * as it's optional in compute_score(). Thank God, this is the =
only
>
> Please do not bring God here.
>
> > +        * variable condition, which we can't judge now.
> > +        */
> > +       if (READ_ONCE(sk->sk_incoming_cpu))
> > +               score++;
> > +
> > +       return score;
> > +}
> > +
> >  /**
> >   * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket=
 if necessary.
> >   * @net: network namespace.
> > @@ -739,6 +759,27 @@ static int inet_reuseport_add_sock(struct sock *sk=
,
> >         return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
> >  }
> >
> > +static void inet_hash_reuseport(struct sock *sk, struct hlist_nulls_he=
ad *head)
> > +{
> > +       const struct hlist_nulls_node *node;
> > +       int score, curscore;
> > +       struct sock *sk2;
> > +
> > +       curscore =3D compute_reuseport_score(sk);
> > +       /* lookup the socket to insert before */
> > +       sk_nulls_for_each_rcu(sk2, node, head) {
> > +               if (!sk2->sk_reuseport)
> > +                       continue;
> > +               score =3D compute_reuseport_score(sk2);
> > +               if (score <=3D curscore) {
> > +                       __sk_nulls_add_node_before_rcu(sk, sk2);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       __sk_nulls_add_node_tail_rcu(sk, head);
> > +}
> > +
> >  int __inet_hash(struct sock *sk, struct sock *osk)
> >  {
> >         struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> > @@ -761,11 +802,11 @@ int __inet_hash(struct sock *sk, struct sock *osk=
)
> >                         goto unlock;
> >         }
> >         sock_set_flag(sk, SOCK_RCU_FREE);
> > -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> > -               sk->sk_family =3D=3D AF_INET6)
> > -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> > -       else
> > +       if (!sk->sk_reuseport)
> >                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> > +       else
> > +               inet_hash_reuseport(sk, &ilb2->nulls_head);
> > +
> >         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >  unlock:
> >         spin_unlock(&ilb2->lock);
> > --
> > 2.50.1
> >

