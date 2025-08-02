Return-Path: <netdev+bounces-211437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2764B18A00
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C358AA60F2
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596072612;
	Sat,  2 Aug 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Maw9Io0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5642AA1;
	Sat,  2 Aug 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754096385; cv=none; b=L97u7T+oxFuyawM1Mhh5w/Dpgc66EzcDSPAh/sLJ/+YcWjH9F5nHpLlX/9lLsK7TyiKyJ8MG1gnmjUj503hgv5artC/D1jc6AzR9g47BKGxB+rCd6/4Qtd0p6qn0bmNxatOZwTYilNA7SMo00cJ3R16KEBOOFBfasA+Mnn6phjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754096385; c=relaxed/simple;
	bh=+zRwWjyipdQn3mNaXsAKNW13CYQMrGBcoGPCAWck4r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brO87jQKAsfd/oMmMDpWWhZVUhDd/z3BBCPEC+8iuuslLFnwBEWb65NCVTE4hCv+yG0CHqU2DWpvjR7SbGh9hwhT7jLC8mc3Z0ixLgwV8LEAkNTl+RNCq5sU7DH3oG6q5I5+2REQiGp1u8HlHLtO1Kag2i07+I5ENxATgsgm97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Maw9Io0L; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71b5279714cso18613057b3.0;
        Fri, 01 Aug 2025 17:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754096383; x=1754701183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MPz5rpHgJJRlmvm3FMAMlrpgOHFMIyYdFdgaDRRYUk=;
        b=Maw9Io0L6XCrU1H9FQz/K62lTK4qOSSA1XOKElyWGrMFAQYZwY1bac8iyjx4+gFGQ0
         9XakdTDWxcz6Rq4Exan7Bz7Wursd8saxugtHrYeGuLPKSD5zKyFXbpRG5uOLnn1Kb+GS
         rqHNIKYyethPk3WZXJwkRQBH3iIflGJMRLLt389gPwKv/u8lMY3O70fY9Gv1Hk+xLAQR
         vA4BqQ6wMRb3r5JPJsEu60yTv4XnfpKBUUOyi8M+b8IURZRrK3m2jdNKg8/io3LbM4b0
         ynhOzn8OR1nLWm7cO4sfXnnCjxqUqL/oyZkJIFuOYZF7SiP/Eoii0cEV53IT7MdrLNEv
         6MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754096383; x=1754701183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MPz5rpHgJJRlmvm3FMAMlrpgOHFMIyYdFdgaDRRYUk=;
        b=iattdP4ERL8zCHk5Rn57N25fgve5jEPugFzkF5ahummhv9/XX2TP+Yf6iaFcFyx9gk
         zfjUdKX2ZLnaPbP273FluX6gewwR5RPPN64JYqap3hhhOk9GTJo0yBfhyn5skpx4nOiA
         VI0cC3VSGbb8VgxW5OFCLiFGkXTVkaQgpcWMyIg6zQsV4tQNNh9MgluU1YZZUIHFF94f
         eLWwpaRpf9ocA6+15RRUMBqLh1sFDetS6NCXhS19YsX5r27AeQPiwAVApvr7eArGJpGK
         ITEedyUmTL8/a7E52eCn6tobmwfgPnprHL6BCLquovTAow/RrsFAUxyV17JPS1anJ8Cy
         qWDA==
X-Forwarded-Encrypted: i=1; AJvYcCUUpLoVxjsiA0unl0AkscN4noxmnEmI6UkaZbSppvoTYgsjk9WUQbQ2xx4OgGOcjVyLHW3wxhYN@vger.kernel.org, AJvYcCUpi5qH3+BnpxlN12SDvIRmRHvCWd3hiM1z0QkjFMx2Xre2HDz8xvcHjgMRYY8ct0hzH1+D+lmNEpKt1BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVF919xgs8XNLmhZq1yD6MvveBbtMzNUVT/ltfnCQ/mSFhYIt
	n3zU9BE6hLbIwSA/ZquTuzNCfvLKAYJx/DiNI0rRKTG0ONI/5GYXPjKWQN1gEXPSBK9vw+apSoN
	6OeG1lgvrQsQ1qABxoYZr2sEszSX8H8MIIDTC8PVMlg==
X-Gm-Gg: ASbGncv6rjpx7mQ1j+hnB/NvmI/j18gtaDBJPQplRHCSASo9RE5uvmN7dFclQKjB3fR
	6EBKJIRWj2WfopitzgDXTM5qdY4RgQ98buwDf9Bo2f/ssrliFbAfZmQZIrkRbfN+l4wH6WM5IwC
	8p/Sm4ocbeiTwmdi6T41V2jSzZZDM/aREbhE6MDOHpd6W41XaAmGuqLxhfvAM2hx1iE/yA+9tdg
	/jvprw=
X-Google-Smtp-Source: AGHT+IGGdqT4FwOhVhHdMG/2v3P9hWIM0wXMcrMQ/J/ITRvhNZ5r+4swcFfRZdPBIl0x70+Nz3j2/dg2pPhWknDNXyU=
X-Received: by 2002:a05:690c:22c6:b0:719:5337:59ef with SMTP id
 00721157ae682-71b7ef6d470mr22618497b3.27.1754096382429; Fri, 01 Aug 2025
 17:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <CANn89i+1-geie7HrSmZeU-OvT-aDJabbtcwrZaHr-1S16yuRZw@mail.gmail.com>
 <CADxym3Y2B+mcR6E_VYowE1VvCsa6X15RieOAr2nEofOswf_qfA@mail.gmail.com> <CAAVpQUC7HkbpVjYdG0q17uwXw0mH8z1nutyKyGcH9YD-CTwH6A@mail.gmail.com>
In-Reply-To: <CAAVpQUC7HkbpVjYdG0q17uwXw0mH8z1nutyKyGcH9YD-CTwH6A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 2 Aug 2025 08:59:31 +0800
X-Gm-Features: Ac12FXxYu_SS_JTkDJCwoOTNw2N2LhX7aqywmBz7apJDB_JUqCs81yQXoxOcBW4
Message-ID: <CADxym3ZV75C42oy54fUBMBtx8Yw6=XaBhvEedjeFgDWd+aZSnw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, kraig@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 12:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Aug 1, 2025 at 3:42=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > On Fri, Aug 1, 2025 at 5:46=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Fri, Aug 1, 2025 at 2:09=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > For now, the socket lookup will terminate if the socket is reuse po=
rt in
> > > > inet_lhash2_lookup(), which makes the socket is not the best match.
> > > >
> > > > For example, we have socket1 and socket2 both listen on "0.0.0.0:12=
34",
> > > > but socket1 bind on "eth0". We create socket1 first, and then socke=
t2.
> > > > Then, all connections will goto socket2, which is not expected, as =
socket1
> > > > has higher priority.
> > > >
> > > > This can cause unexpected behavior if TCP MD5 keys is used, as desc=
ribed
> > > > in Documentation/networking/vrf.rst -> Applications.
> > > >
> > > > Therefore, we compute a score for the reuseport socket and add it t=
o the
> > > > list with order in __inet_hash(). Sockets with high score will be a=
dded
> > > > to the head.
> > > >
> > > > Link: https://lore.kernel.org/netdev/20250731123309.184496-1-dongml=
2@chinatelecom.cn/
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > >
> > > You forgot a Fixes: tag, and a selftest.
> >
> > I was not sure if it should be a Fixes, I'll add it in the next version=
.
> > Kuniyuki's test case is nice. Should I put the selftests in the
> > commit log?
>
> The python example is handy and easy to understand the
> issue, so feel free to add it to the commit log if needed.
>
> But please add a separate patch to add a test under
> tools/testing/selftest/net/.
>
> It will help us not introduce regression in the future as it's
> run for each patch by NIPA CI.

Ok! I'll add a testcase to tools/testing/selftest/net/

>
>
> >
> > >
> > > > ---
> > > > v2:
> > > > - As Kuniyuki advised, sort the reuseport socket in __inet_hash() t=
o keep
> > > >   the lookup for reuseport O(1)
> > >
> > > Keeping sorted the list is difficult, we would have to intercept
> > > SO_BINDTODEVICE, SO_BINDTOIFINDEX, SO_INCOMING_CPU.
> > >
> > > This also makes the patch risky to backport to stable versions,
> > > because it is complex and possibly buggy.
> > >
> > > Therefore I prefer your first approach.
> >
> > Kuniyuki also has a similar patch:
> > https://lore.kernel.org/netdev/CADxym3ZY7Lm9mgv83e2db7o3ZZMcLDa=3DvDf6n=
JSs1m0_tUk5Bg@mail.gmail.com/T/#m56ee67b2fdf85ce568fd1339def92c53232d5b49
> >
> > Will his be better and stable? Kuniyuki say the first approach
> > kill the O(1) lookup for reuseport socket :/
>
> At least your compute_reuseport_score() is wrong;
> so_incoming_cpu is not considered to group reuseport
> sockets, it does not take wildcard and ipv6_only into
> account, etc..

Should ipv6_only be considered? If socketA is ipv6_only,
and socketB is not, a IPv6 connection should select
socketA? I don't see such logic in compute_score() :/

>
> And I agree this is net-next material, a bit risky to backport.
>
> Once net-next is open, I'll follow up to restore the O(1)
> lookup with a few more patches to handle corner cases
> that I mentioned in v1 thread.
>
> >
> > Anyway, I'll send a V3 with the first approach, and with
> > the Fixes + selftests
>
> nit: The subject prefix should start with "tcp:" as UDP
> and SCTP do not seem to have this issue.

Ok!

>
>
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > > > ---
> > > >  include/linux/rculist_nulls.h | 34 ++++++++++++++++++++++++
> > > >  include/net/sock.h            |  5 ++++
> > > >  net/ipv4/inet_hashtables.c    | 49 +++++++++++++++++++++++++++++++=
+---
> > > >  3 files changed, 84 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_=
nulls.h
> > > > index 89186c499dd4..da500f4ae142 100644
> > > > --- a/include/linux/rculist_nulls.h
> > > > +++ b/include/linux/rculist_nulls.h
> > > > @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(stru=
ct hlist_nulls_node *n)
> > > >  #define hlist_nulls_next_rcu(node) \
> > > >         (*((struct hlist_nulls_node __rcu __force **)&(node)->next)=
)
> > > >
> > > > +/**
> > > > + * hlist_nulls_pprev_rcu - returns the element of the list after @=
node.
> > > > + * @node: element of the list.
> > > > + */
> > > > +#define hlist_nulls_pprev_rcu(node) \
> > > > +       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev=
))
> > > > +
> > > >  /**
> > > >   * hlist_nulls_del_rcu - deletes entry from hash list without re-i=
nitialization
> > > >   * @n: the element to delete from the hash list.
> > > > @@ -145,6 +152,33 @@ static inline void hlist_nulls_add_tail_rcu(st=
ruct hlist_nulls_node *n,
> > > >         }
> > > >  }
> > > >
> > > > +/**
> > > > + * hlist_nulls_add_before_rcu
> > > > + * @n: the new element to add to the hash list.
> > > > + * @next: the existing element to add the new element before.
> > > > + *
> > > > + * Description:
> > > > + * Adds the specified element to the specified hlist
> > > > + * before the specified node while permitting racing traversals.
> > > > + *
> > > > + * The caller must take whatever precautions are necessary
> > > > + * (such as holding appropriate locks) to avoid racing
> > > > + * with another list-mutation primitive, such as hlist_nulls_add_h=
ead_rcu()
> > > > + * or hlist_nulls_del_rcu(), running on this same list.
> > > > + * However, it is perfectly legal to run concurrently with
> > > > + * the _rcu list-traversal primitives, such as
> > > > + * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consis=
tency
> > > > + * problems on Alpha CPUs.
> > > > + */
> > > > +static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_n=
ode *n,
> > > > +                                             struct hlist_nulls_no=
de *next)
> > > > +{
> > > > +       WRITE_ONCE(n->pprev, next->pprev);
> > > I do not think WRITE_ONCE() is necessary here, @n is private to this =
cpu,
> > > and following rcu_assign_pointer() has the needed barrier.
> > >
> > > > +       n->next =3D next;
> > > > +       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> > > > +       WRITE_ONCE(next->pprev, &n->next);
> > > > +}
> > > > +
> > > >  /* after that hlist_nulls_del will work */
> > > >  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n=
)
> > > >  {
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index c8a4b283df6f..42aa1919eeee 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -885,6 +885,11 @@ static inline void __sk_nulls_add_node_tail_rc=
u(struct sock *sk, struct hlist_nu
> > > >         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
> > > >  }
> > > >
> > > > +static inline void __sk_nulls_add_node_before_rcu(struct sock *sk,=
 struct sock *next)
> > > > +{
> > > > +       hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_nu=
lls_node);
> > > > +}
> > > > +
> > > >  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct h=
list_nulls_head *list)
> > > >  {
> > > >         sock_hold(sk);
> > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.=
c
> > > > index ceeeec9b7290..80d8bec41a58 100644
> > > > --- a/net/ipv4/inet_hashtables.c
> > > > +++ b/net/ipv4/inet_hashtables.c
> > > > @@ -334,6 +334,26 @@ static inline int compute_score(struct sock *s=
k, const struct net *net,
> > > >         return score;
> > > >  }
> > > >
> > > > +static inline int compute_reuseport_score(struct sock *sk)
> > > > +{
> > > > +       int score =3D 0;
> > > > +
> > > > +       if (sk->sk_bound_dev_if)
> > > > +               score +=3D 2;
> > > > +
> > > > +       if (sk->sk_family =3D=3D PF_INET)
> > > > +               score +=3D 10;
> > > > +
> > > > +       /* the priority of sk_incoming_cpu should be lower than sk_=
bound_dev_if,
> > > > +        * as it's optional in compute_score(). Thank God, this is =
the only
> > >
> > > Please do not bring God here.
> > >
> > > > +        * variable condition, which we can't judge now.
> > > > +        */
> > > > +       if (READ_ONCE(sk->sk_incoming_cpu))
> > > > +               score++;
> > > > +
> > > > +       return score;
> > > > +}
> > > > +
> > > >  /**
> > > >   * inet_lookup_reuseport() - execute reuseport logic on AF_INET so=
cket if necessary.
> > > >   * @net: network namespace.
> > > > @@ -739,6 +759,27 @@ static int inet_reuseport_add_sock(struct sock=
 *sk,
> > > >         return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
> > > >  }
> > > >
> > > > +static void inet_hash_reuseport(struct sock *sk, struct hlist_null=
s_head *head)
> > > > +{
> > > > +       const struct hlist_nulls_node *node;
> > > > +       int score, curscore;
> > > > +       struct sock *sk2;
> > > > +
> > > > +       curscore =3D compute_reuseport_score(sk);
> > > > +       /* lookup the socket to insert before */
> > > > +       sk_nulls_for_each_rcu(sk2, node, head) {
> > > > +               if (!sk2->sk_reuseport)
> > > > +                       continue;
> > > > +               score =3D compute_reuseport_score(sk2);
> > > > +               if (score <=3D curscore) {
> > > > +                       __sk_nulls_add_node_before_rcu(sk, sk2);
> > > > +                       return;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       __sk_nulls_add_node_tail_rcu(sk, head);
> > > > +}
> > > > +
> > > >  int __inet_hash(struct sock *sk, struct sock *osk)
> > > >  {
> > > >         struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> > > > @@ -761,11 +802,11 @@ int __inet_hash(struct sock *sk, struct sock =
*osk)
> > > >                         goto unlock;
> > > >         }
> > > >         sock_set_flag(sk, SOCK_RCU_FREE);
> > > > -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> > > > -               sk->sk_family =3D=3D AF_INET6)
> > > > -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head)=
;
> > > > -       else
> > > > +       if (!sk->sk_reuseport)
> > > >                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> > > > +       else
> > > > +               inet_hash_reuseport(sk, &ilb2->nulls_head);
> > > > +
> > > >         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> > > >  unlock:
> > > >         spin_unlock(&ilb2->lock);
> > > > --
> > > > 2.50.1
> > > >

