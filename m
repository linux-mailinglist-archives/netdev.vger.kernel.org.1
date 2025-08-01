Return-Path: <netdev+bounces-211371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C55B185FD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895CE189810D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2F1CD208;
	Fri,  1 Aug 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1W1dXQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477841C863B
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066811; cv=none; b=Hq3J+MeSwhlK5aa3xqd7r+2jV3htE9tyRvxRgbwZGkOW+gLO+n6aq1/OpjTwaAtWMLoCAuCPXWF51iT3c2fpdbg7u8GKaUyDp0PsIYnMmWlxfKlRVEVi5+R5gS+lcv+bAoj5e6kGqTEyZfVHiIUmcMuhcRgFjwkNFkKmqzVQxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066811; c=relaxed/simple;
	bh=5osWWsY6f3oevs5SRLlQcPTuE1vcvjPPIbSKd8+JQhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZqU6Dr8rzGGNco3RyZgc85gSFSeVwXyNDKneR+Ptsc8dBfk7Pbst1/xDpDr7ReIsXUg5l9MaMzTJuWJfecO0pPIbVLZ7cPZvEd8ifxohYQOuLNbZl8oHfA+AAYvfZxRKVQuR2i96R+8bXO6RXX1ciBaUg6yzvp9rUjUrELtblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1W1dXQ9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1110514b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754066808; x=1754671608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMogduaZqJf0tVoGWvKahCM4C1msXsOSuSwXjLBFk2s=;
        b=V1W1dXQ9xsyUZltU9ONc5fh3e5ng1VIOIJoxiO2SenzCynce78AsDESo2dcQ7yS6LC
         91SmmGspInF0gOa6jRF9frU2JhlSPGiviGZyCI6ncEiUVQyjn7iXzVVIjjRVmBan7fhO
         qZ8mZrSDkYW99hqceMbOPt/SS8HliwZck7zqzu3hqQ3OUXuRMOAFwW1pKnFaXp0lUKJO
         CasU8+Ud0hEl7KNDlpHmGWXBGsO8BVilBb5dpX61ZiIIJWmMSkcaCY3W7NtGLOA4MlEu
         pVQCNYF09rMn2w/lF8fJfMkcywPXNoxfDjhzJgNP9i64Jx3AEnlsFBPRlVyFkW4svjCH
         g/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066808; x=1754671608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMogduaZqJf0tVoGWvKahCM4C1msXsOSuSwXjLBFk2s=;
        b=RPvd6cnj65MqO6Z4ONIanMi+SK7rHwGTGHy/PkO/sqfz+oBm7QP6WpQhdJoH/SGc5D
         SVeIRar65UYaLkrM4xbgGLHSgys1rbO7Y4r+krZHc8StqSbGuLpsUYmDxVUs3jL49t/4
         4SDzqEUxRd+XRYnI+gH28RBtxJ3b0o1IWbqUrQotUVAYsvk5de0fWo4Pxf0wv//+ybjH
         snsoy/uji1JgNwz0M1/f5jRsEgAFz0I52TmRWEjs33T+3ofd1TNQDBx2/aMvzVrqMrIO
         uqgp0Pht7ey2P4F1sv8ANHryhMFNdAnwWgYwYYZxq5qRzj3OSLzFScpzREyn1oYrGOQt
         mwBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpNtgE9tBa6Ln+ct4Kn6knZdEIaSyzE+dpF9Sdpf2obtdfWGJdKT7OBptKSXlX/6Q9LFluP24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqmJ1WP1lsMz+XP2jhX6EgbvWksHD9eG2w+vrgHIfIeqFiI9T
	tCm7Vmd/xiYGahdzgk2AvuofcusAeYiSieV8lWqpjGfhNdi8kEnQSKilu2uzhXb4LsAuJY9fVI2
	75NtbUJcT/ojnPTRiq4jhIwTacfXN9Ear4i1fmRBa
X-Gm-Gg: ASbGncvzOBX8TrgwNW/QnU4klJpDRFjFU8sPElQ3SgcIakvPkCwDgsDM+a0fTN9vShQ
	IkGtnQ/eY2pP6XZXMZomKyRqVlk1N5dBWldlZ4GG5/pDRHl5nTKHfJ34GEiBxa3D+dRgnD5SunA
	IDkjlmwHbf31MvTkKe7LCf5sfTL+31jpDJj9VrQRhK2KNbOpQmfh9ivbNZiMfYH0nmmwjWk3p71
	wEnHzWdb6RZ8dny1p+Uos+85Ga1V5yhL8ZwDzBG
X-Google-Smtp-Source: AGHT+IFEwpZvnPSfLoN+JYo94UY1/WHDgCraPCEohzoaPzmI/BMQTIf6t0YHUkVbuWkRGynViCwdp7ew0BYFfa3k+40=
X-Received: by 2002:a05:6a20:7347:b0:23d:f079:60ec with SMTP id
 adf61e73a8af0-23df9141427mr498222637.37.1754066808305; Fri, 01 Aug 2025
 09:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <CANn89i+1-geie7HrSmZeU-OvT-aDJabbtcwrZaHr-1S16yuRZw@mail.gmail.com> <CADxym3Y2B+mcR6E_VYowE1VvCsa6X15RieOAr2nEofOswf_qfA@mail.gmail.com>
In-Reply-To: <CADxym3Y2B+mcR6E_VYowE1VvCsa6X15RieOAr2nEofOswf_qfA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 Aug 2025 09:46:37 -0700
X-Gm-Features: Ac12FXxkLrmiLcpeN8amCoGgfAsHLBVxYdE4e3TWNFSN7GdApxWXwM0Q-sic8vE
Message-ID: <CAAVpQUC7HkbpVjYdG0q17uwXw0mH8z1nutyKyGcH9YD-CTwH6A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, kraig@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 3:42=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Fri, Aug 1, 2025 at 5:46=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Aug 1, 2025 at 2:09=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > For now, the socket lookup will terminate if the socket is reuse port=
 in
> > > inet_lhash2_lookup(), which makes the socket is not the best match.
> > >
> > > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234=
",
> > > but socket1 bind on "eth0". We create socket1 first, and then socket2=
.
> > > Then, all connections will goto socket2, which is not expected, as so=
cket1
> > > has higher priority.
> > >
> > > This can cause unexpected behavior if TCP MD5 keys is used, as descri=
bed
> > > in Documentation/networking/vrf.rst -> Applications.
> > >
> > > Therefore, we compute a score for the reuseport socket and add it to =
the
> > > list with order in __inet_hash(). Sockets with high score will be add=
ed
> > > to the head.
> > >
> > > Link: https://lore.kernel.org/netdev/20250731123309.184496-1-dongml2@=
chinatelecom.cn/
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > You forgot a Fixes: tag, and a selftest.
>
> I was not sure if it should be a Fixes, I'll add it in the next version.
> Kuniyuki's test case is nice. Should I put the selftests in the
> commit log?

The python example is handy and easy to understand the
issue, so feel free to add it to the commit log if needed.

But please add a separate patch to add a test under
tools/testing/selftest/net/.

It will help us not introduce regression in the future as it's
run for each patch by NIPA CI.


>
> >
> > > ---
> > > v2:
> > > - As Kuniyuki advised, sort the reuseport socket in __inet_hash() to =
keep
> > >   the lookup for reuseport O(1)
> >
> > Keeping sorted the list is difficult, we would have to intercept
> > SO_BINDTODEVICE, SO_BINDTOIFINDEX, SO_INCOMING_CPU.
> >
> > This also makes the patch risky to backport to stable versions,
> > because it is complex and possibly buggy.
> >
> > Therefore I prefer your first approach.
>
> Kuniyuki also has a similar patch:
> https://lore.kernel.org/netdev/CADxym3ZY7Lm9mgv83e2db7o3ZZMcLDa=3DvDf6nJS=
s1m0_tUk5Bg@mail.gmail.com/T/#m56ee67b2fdf85ce568fd1339def92c53232d5b49
>
> Will his be better and stable? Kuniyuki say the first approach
> kill the O(1) lookup for reuseport socket :/

At least your compute_reuseport_score() is wrong;
so_incoming_cpu is not considered to group reuseport
sockets, it does not take wildcard and ipv6_only into
account, etc..

And I agree this is net-next material, a bit risky to backport.

Once net-next is open, I'll follow up to restore the O(1)
lookup with a few more patches to handle corner cases
that I mentioned in v1 thread.

>
> Anyway, I'll send a V3 with the first approach, and with
> the Fixes + selftests

nit: The subject prefix should start with "tcp:" as UDP
and SCTP do not seem to have this issue.


>
> Thanks!
> Menglong Dong
>
> >
> > > ---
> > >  include/linux/rculist_nulls.h | 34 ++++++++++++++++++++++++
> > >  include/net/sock.h            |  5 ++++
> > >  net/ipv4/inet_hashtables.c    | 49 ++++++++++++++++++++++++++++++++-=
--
> > >  3 files changed, 84 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nu=
lls.h
> > > index 89186c499dd4..da500f4ae142 100644
> > > --- a/include/linux/rculist_nulls.h
> > > +++ b/include/linux/rculist_nulls.h
> > > @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct=
 hlist_nulls_node *n)
> > >  #define hlist_nulls_next_rcu(node) \
> > >         (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
> > >
> > > +/**
> > > + * hlist_nulls_pprev_rcu - returns the element of the list after @no=
de.
> > > + * @node: element of the list.
> > > + */
> > > +#define hlist_nulls_pprev_rcu(node) \
> > > +       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> > > +
> > >  /**
> > >   * hlist_nulls_del_rcu - deletes entry from hash list without re-ini=
tialization
> > >   * @n: the element to delete from the hash list.
> > > @@ -145,6 +152,33 @@ static inline void hlist_nulls_add_tail_rcu(stru=
ct hlist_nulls_node *n,
> > >         }
> > >  }
> > >
> > > +/**
> > > + * hlist_nulls_add_before_rcu
> > > + * @n: the new element to add to the hash list.
> > > + * @next: the existing element to add the new element before.
> > > + *
> > > + * Description:
> > > + * Adds the specified element to the specified hlist
> > > + * before the specified node while permitting racing traversals.
> > > + *
> > > + * The caller must take whatever precautions are necessary
> > > + * (such as holding appropriate locks) to avoid racing
> > > + * with another list-mutation primitive, such as hlist_nulls_add_hea=
d_rcu()
> > > + * or hlist_nulls_del_rcu(), running on this same list.
> > > + * However, it is perfectly legal to run concurrently with
> > > + * the _rcu list-traversal primitives, such as
> > > + * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consiste=
ncy
> > > + * problems on Alpha CPUs.
> > > + */
> > > +static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_nod=
e *n,
> > > +                                             struct hlist_nulls_node=
 *next)
> > > +{
> > > +       WRITE_ONCE(n->pprev, next->pprev);
> > I do not think WRITE_ONCE() is necessary here, @n is private to this cp=
u,
> > and following rcu_assign_pointer() has the needed barrier.
> >
> > > +       n->next =3D next;
> > > +       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> > > +       WRITE_ONCE(next->pprev, &n->next);
> > > +}
> > > +
> > >  /* after that hlist_nulls_del will work */
> > >  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
> > >  {
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index c8a4b283df6f..42aa1919eeee 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -885,6 +885,11 @@ static inline void __sk_nulls_add_node_tail_rcu(=
struct sock *sk, struct hlist_nu
> > >         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
> > >  }
> > >
> > > +static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, s=
truct sock *next)
> > > +{
> > > +       hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_null=
s_node);
> > > +}
> > > +
> > >  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hli=
st_nulls_head *list)
> > >  {
> > >         sock_hold(sk);
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index ceeeec9b7290..80d8bec41a58 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -334,6 +334,26 @@ static inline int compute_score(struct sock *sk,=
 const struct net *net,
> > >         return score;
> > >  }
> > >
> > > +static inline int compute_reuseport_score(struct sock *sk)
> > > +{
> > > +       int score =3D 0;
> > > +
> > > +       if (sk->sk_bound_dev_if)
> > > +               score +=3D 2;
> > > +
> > > +       if (sk->sk_family =3D=3D PF_INET)
> > > +               score +=3D 10;
> > > +
> > > +       /* the priority of sk_incoming_cpu should be lower than sk_bo=
und_dev_if,
> > > +        * as it's optional in compute_score(). Thank God, this is th=
e only
> >
> > Please do not bring God here.
> >
> > > +        * variable condition, which we can't judge now.
> > > +        */
> > > +       if (READ_ONCE(sk->sk_incoming_cpu))
> > > +               score++;
> > > +
> > > +       return score;
> > > +}
> > > +
> > >  /**
> > >   * inet_lookup_reuseport() - execute reuseport logic on AF_INET sock=
et if necessary.
> > >   * @net: network namespace.
> > > @@ -739,6 +759,27 @@ static int inet_reuseport_add_sock(struct sock *=
sk,
> > >         return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
> > >  }
> > >
> > > +static void inet_hash_reuseport(struct sock *sk, struct hlist_nulls_=
head *head)
> > > +{
> > > +       const struct hlist_nulls_node *node;
> > > +       int score, curscore;
> > > +       struct sock *sk2;
> > > +
> > > +       curscore =3D compute_reuseport_score(sk);
> > > +       /* lookup the socket to insert before */
> > > +       sk_nulls_for_each_rcu(sk2, node, head) {
> > > +               if (!sk2->sk_reuseport)
> > > +                       continue;
> > > +               score =3D compute_reuseport_score(sk2);
> > > +               if (score <=3D curscore) {
> > > +                       __sk_nulls_add_node_before_rcu(sk, sk2);
> > > +                       return;
> > > +               }
> > > +       }
> > > +
> > > +       __sk_nulls_add_node_tail_rcu(sk, head);
> > > +}
> > > +
> > >  int __inet_hash(struct sock *sk, struct sock *osk)
> > >  {
> > >         struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> > > @@ -761,11 +802,11 @@ int __inet_hash(struct sock *sk, struct sock *o=
sk)
> > >                         goto unlock;
> > >         }
> > >         sock_set_flag(sk, SOCK_RCU_FREE);
> > > -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> > > -               sk->sk_family =3D=3D AF_INET6)
> > > -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> > > -       else
> > > +       if (!sk->sk_reuseport)
> > >                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> > > +       else
> > > +               inet_hash_reuseport(sk, &ilb2->nulls_head);
> > > +
> > >         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> > >  unlock:
> > >         spin_unlock(&ilb2->lock);
> > > --
> > > 2.50.1
> > >

