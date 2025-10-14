Return-Path: <netdev+bounces-229095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F4BD81AD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD80834E4EB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186530EF98;
	Tue, 14 Oct 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DqThMo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8530EF72
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429369; cv=none; b=ent0ES4ORZj2Tf3m6Gl7NBwbijvduyfgv/6kH4ODFnEYk9Zv5/1kVtE9Ci2uzHaInd4pac1511YK5XHu5ySA2Obsxw/cZI2bp/0qKgdeiL/80Zn/r7kP8xTF4BBGoFppT1qnNkeYguuSi5QslBKSae8tkD2temxYTaZfMc2Zqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429369; c=relaxed/simple;
	bh=0hOs6lNwFmOYVzCI4EOSKUppB0EOJbNGTp7yW01ruws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djFM9DjgEux2C05CXvwkRvX0HMzj7LN2RtMfeEf3/E9yzvheMdYJJNnDScnWHwrJirN+Jpg+nZVb5me2I3zvAqglWvSahQBA+n2rhVLwx1KiEPhFY9IpBcmb183JIOPt7RjbLX+C0FpaNdZQnS8/P1By+rKFT2jE1+k+R8KJnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DqThMo5; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85cee530df9so790171685a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760429366; x=1761034166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQxQ7zEJyamO3FYp7h53BV/ghyg1BHfo8dZmUXKe5TE=;
        b=4DqThMo5/mjLJ8RUlOo5IroQ5HS2vHy4N4TdTr/3uvhhUqt/Ci50dAQ/mEhoibI3BQ
         S/3/DuLUnpkbNT0B3di/oywudn8o4uYDWhqmK01o4Uznhal6Vcg2HWUDaYnet61L3e3G
         kFkapnAUuAU65mxcRR/lLc4PjbEvp+/VZluVt3TvsMKm6JcVYRnb1WmkDEKMls1LYyvc
         6YI6UEJL6T1ixSU2GrbYz8C4kiCs60V3HAFznDuWktkrRxt5Tz90Fxj3Z1tYDnCcA6/5
         HVoDrXdLJOCbmMRITi1EM8xwIp09w2325AeGPWqrIhy4B+tiNl6kCFqal5YwGVjdeS0+
         5k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429366; x=1761034166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQxQ7zEJyamO3FYp7h53BV/ghyg1BHfo8dZmUXKe5TE=;
        b=MpbX9OkWHn7rXAP7bz7j18IaCNOpfCgVN5PEmMAExvaGGaf/wemX2jIZgyoTulV87g
         DFlMTTyVqbqidyt+3mgCnxLCZcs0eyEefI423osAw+VJFeHyc830OFAC5hhAG+QTwCmy
         ZIVrtXhBsks6XyOnhq+K2Wq180mF4RgXvPKfrCxTo2MHyCfuaotgGLHnJR19lSknwBQ4
         kXKD40WQIXFt8Gq5OJokPub3e5InfwT97ZDMO6aBdbI2bDpaXII7TRVckuAPzH007mvq
         tjCNZSU7OmZwT72qT2+hD+vBSziAzH4TMP6Gr97w0HlqQ41/FJ7ouk3cqvAGQcgxbNq5
         F8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXcmfkudGKfwW7Q6j8HgEmmDgUUeaQy8Nz8UZ0/hcaTqypwJX55YbDoy9FPtpqvPUtxdJbFqKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwT+FNWB+RB5H4draTUgTJ3gOEhtaLidhD7gs+/UXAQRQ9YH2N
	7oLClM6SJdJwE3jDHirYc9g81zsKCs27fwH+0X+QLPmAnpTRs1tUOniBftEaM4ge+SrxfODzX5M
	uVyFnpgZDgF8Vof0N++NwAU6uuIuRieTmDwYiosMA
X-Gm-Gg: ASbGncsqMA97OFNO6vMg07E5+VUYGvj8ZqRv4NaNU8bhHSN1NRgyxhk10ETLLN3cyXY
	bXx71/Kli4S8/cLz5rUxIzGbjMx7bRx6g71dCxVY7tmnyYqrX3oU4o10hDM4GyFh+B7B6Nz6qvb
	KS6ANDSM8ijo6Pd+hV6I3LGCFJHsXPxfwvoVHyTVl+F7VB1G9XkWr0F6Y+KwJ//T5o2GZtct2Oj
	am5e8CxJH5munxnJB1uGgYLTBnVGNgYMxNWyCcEIHpp9pU+LVBqWw==
X-Google-Smtp-Source: AGHT+IH/dWhoPzEyfqKZhpl9EUBKcY5MZWG2lOi5ULZT6oxI9zLixwvwXY8shOQq/o9+wnzOHkuxLWFiUbdQzIXiPa4=
X-Received: by 2002:a05:622a:2cf:b0:4b4:9522:67a with SMTP id
 d75a77b69052e-4e6ead12f0amr298247811cf.33.1760429365512; Tue, 14 Oct 2025
 01:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev> <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
 <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev> <CANn89iLQMVms1GF_oY1WSCtmxLZaBJrTKaeHnwRo5p9uzFwnVw@mail.gmail.com>
 <82a04cb1-9451-493c-9b1e-b4a34f2175cd@linux.dev> <CANn89iJdXiE3b8x8vQtbOOi2DTC5P9bOO1HsnRwSPC8qQC--8g@mail.gmail.com>
 <7d89cff3-1045-4901-bdd3-f669eecfee97@linux.dev>
In-Reply-To: <7d89cff3-1045-4901-bdd3-f669eecfee97@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:09:14 -0700
X-Gm-Features: AS18NWDvY5FrE0lRRsQ5p3vmdjBROe3O0IUuYTIr4LtgXah8la5zPqyw2r_AeyU
Message-ID: <CANn89iJtMVRhcdfaH3Qz0cLf30cV32jYpAA5YBcL1Auovccdug@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:05=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/10/14 15:34, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Oct 14, 2025 at 12:21=E2=80=AFAM luoxuanqiang <xuanqiang.luo@li=
nux.dev> wrote:
> >>
> >> =E5=9C=A8 2025/10/13 17:49, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Mon, Oct 13, 2025 at 1:26=E2=80=AFAM luoxuanqiang <xuanqiang.luo@l=
inux.dev> wrote:
> >>>> =E5=9C=A8 2025/10/13 15:31, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>> On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev> =
wrote:
> >>>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>>>
> >>>>>> Add two functions to atomically replace RCU-protected hlist_nulls =
entries.
> >>>>>>
> >>>>>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> >>>>>> mentioned in the patch below:
> >>>>>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->n=
ext for
> >>>>>> rculist_nulls")
> >>>>>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->p=
prev for
> >>>>>> hlist_nulls")
> >>>>>>
> >>>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>>> ---
> >>>>>>     include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++=
++++++++
> >>>>>>     1 file changed, 59 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist=
_nulls.h
> >>>>>> index 89186c499dd4..c26cb83ca071 100644
> >>>>>> --- a/include/linux/rculist_nulls.h
> >>>>>> +++ b/include/linux/rculist_nulls.h
> >>>>>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(str=
uct hlist_nulls_node *n)
> >>>>>>     #define hlist_nulls_next_rcu(node) \
> >>>>>>            (*((struct hlist_nulls_node __rcu __force **)&(node)->n=
ext))
> >>>>>>
> >>>>>> +/**
> >>>>>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @nod=
e.
> >>>>>> + * @node: element of the list.
> >>>>>> + */
> >>>>>> +#define hlist_nulls_pprev_rcu(node) \
> >>>>>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev=
))
> >>>>>> +
> >>>>>>     /**
> >>>>>>      * hlist_nulls_del_rcu - deletes entry from hash list without =
re-initialization
> >>>>>>      * @n: the element to delete from the hash list.
> >>>>>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struc=
t hlist_nulls_node *n)
> >>>>>>            n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NUL=
L);
> >>>>>>     }
> >>>>>>
> >>>>>> +/**
> >>>>>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
> >>>>>> + * @old: the element to be replaced
> >>>>>> + * @new: the new element to insert
> >>>>>> + *
> >>>>>> + * Description:
> >>>>>> + * Replace the old entry with the new one in a RCU-protected hlis=
t_nulls, while
> >>>>>> + * permitting racing traversals.
> >>>>>> + *
> >>>>>> + * The caller must take whatever precautions are necessary (such =
as holding
> >>>>>> + * appropriate locks) to avoid racing with another list-mutation =
primitive, such
> >>>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), runnin=
g on this same
> >>>>>> + * list.  However, it is perfectly legal to run concurrently with=
 the _rcu
> >>>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_=
rcu().
> >>>>>> + */
> >>>>>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_nod=
e *old,
> >>>>>> +                                          struct hlist_nulls_node=
 *new)
> >>>>>> +{
> >>>>>> +       struct hlist_nulls_node *next =3D old->next;
> >>>>>> +
> >>>>>> +       WRITE_ONCE(new->next, next);
> >>>>>> +       WRITE_ONCE(new->pprev, old->pprev);
> >>>>> I do not think these two WRITE_ONCE() are needed.
> >>>>>
> >>>>> At this point new is not yet visible.
> >>>>>
> >>>>> The following  rcu_assign_pointer() is enough to make sure prior
> >>>>> writes are committed to memory.
> >>>> Dear Eric,
> >>>>
> >>>> I=E2=80=99m quoting your more detailed explanation from the other pa=
tch [0], thank
> >>>> you for that!
> >>>>
> >>>> However, regarding new->next, if the new object is allocated with
> >>>> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in =
commit
> >>>> efd04f8a8b45 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->ne=
xt for
> >>>> rculist_nulls=E2=80=9D)?
> >>>>
> >>>> Also, for the WRITE_ONCE() assignments to ->pprev introduced in comm=
it
> >>>> 860c8802ace1 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->pp=
rev for
> >>>> hlist_nulls=E2=80=9D) within hlist_nulls_add_head_rcu(), is that als=
o unnecessary?
> >>> I forgot sk_unhashed()/sk_hashed() could be called from lockless cont=
exts.
> >>>
> >>> It is a bit weird to annotate the writes, but not the lockless reads,
> >>> even if apparently KCSAN
> >>> is okay with that.
> >>>
> >> Dear Eric,
> >>
> >> I=E2=80=99m sorry=E2=80=94I still haven=E2=80=99t fully grasped the sc=
enario you mentioned where
> >> sk_unhashed()/sk_hashed() can be called from lock=E2=80=91less context=
s. It seems
> >> similar to the race described in commit 860c8802ace1 (=E2=80=9Crcu: Us=
e
> >> WRITE_ONCE() for assignments to ->pprev for hlist_nulls=E2=80=9D), e.g=
.: [0].
> >>
> > inet_unhash() does a lockless sk_unhash(sk) call, while no lock is
> > held in some cases (look at tcp_done())
> >
> > void inet_unhash(struct sock *sk)
> > {
> > struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> >
> > if (sk_unhashed(sk))    // Here no lock is held
> >      return;
> >
> > Relevant lock (depending on (sk->sk_state =3D=3D TCP_LISTEN)) is acquir=
ed
> > a few lines later.
> >
> > Then
> >
> > __sk_nulls_del_node_init_rcu() is called safely, while the bucket lock =
is held.
> >
> Dear Eric,
>
> Thanks for the quick response!
>
> In the call path:
>          tcp_retransmit_timer()
>                  tcp_write_err()
>                          tcp_done()
>
> tcp_retransmit_timer() already calls lockdep_sock_is_held(sk) to check th=
e
> socket=E2=80=91lock state.
>
> void tcp_retransmit_timer(struct sock *sk)
> {
>          struct tcp_sock *tp =3D tcp_sk(sk);
>          struct net *net =3D sock_net(sk);
>          struct inet_connection_sock *icsk =3D inet_csk(sk);
>          struct request_sock *req;
>          struct sk_buff *skb;
>
>          req =3D rcu_dereference_protected(tp->fastopen_rsk,
>                                   lockdep_sock_is_held(sk)); // Check her=
e
>
> Does that mean we=E2=80=99re already protected by lock_sock(sk) or
> bh_lock_sock(sk)?

But the socket lock is not protecting ehash buckets. These are other locks.

Also, inet_unhash() can be called from other paths, without a socket
lock being held.

