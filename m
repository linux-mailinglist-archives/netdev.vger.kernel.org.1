Return-Path: <netdev+bounces-229152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421FBD8A79
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603244235B8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8542EDD60;
	Tue, 14 Oct 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uT4NvQ/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E32ECE8A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436136; cv=none; b=buzKo3J+p04WiZn+/gtbofP3FelTgmHjkkiJ8SM6pwoshyppQXAVdxrfWLWlPhGN50rvxwyJ2+YGSk/TVs/qNJjVlZTties0PnxcnQh7hWYi+a6b3uKaybD1I5jlDVFw9EdjrUXWBBqjosqpTEAMqHc3N5kCMJqiYw5NYe8ssIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436136; c=relaxed/simple;
	bh=o/3Z3fYY7vB6RiA2Nh07fYI/b/c9PGzsLzQHSECb+mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw4RQLioWq6PMBvPq1Kvw1WdLsQ5kOzYTpTUBc+hzppxEXCOCbMSPUADFtEfp4I4jp6OBZwGLeOQmc2hQnoRNqUve0awzZR6qpT5/rMka98k1Pp8mCKjSI5zEUMt/igNllJhecjH4lNvCHj7uD6iNeOz1IWJYIRzYsLlY3NcaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uT4NvQ/v; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-80ff41475cdso105750756d6.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760436133; x=1761040933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhP3+Bll6mM26bBf6+P2S2EUjBFp0OyO3ukAgFsV39Y=;
        b=uT4NvQ/vjE4LW9qctptbLaLxrhqitZVpSmZ7qwY+3QOgn2ozvgc0X3TLqDWANlVRsP
         7WMfyBsBKJKPQbVJGEciZUEdjPknELDN6tEq0x+Ns96GvanKF8a8v52OmottDzFkcPqs
         ZfwU3IphF/GLl84ssQBRp8S9jdFUUfd788eXngPkolItTaWXwsxab+tPk7BnPvy0bqDu
         6yyRLufFktp8JO40oFCD56CsdZZG7zluL2awGinaxqFTSIUh0gD5+Eyo7XwgLGDQHM0N
         3R/67S6HdVvOeI9H90/O3F0u7uv+O0rgdhe1d4ke11U3L9aZNDmV9G01EIyuyY7VFhbF
         ZoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436133; x=1761040933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhP3+Bll6mM26bBf6+P2S2EUjBFp0OyO3ukAgFsV39Y=;
        b=Uz1fbdB7VC6oN74XVhYhJPaYT00yC2cOWEZZOtiIzmc2cAdsyCeqgAs+Lp4aIKLEtv
         l7rCX44XCVT/809Mp5zONRLr+KafdaJg7cMrXu1aQpTUGOQ8gPVWaZJRQHM4jNFQLXLo
         rn1RxG3HBdNzHN6U6XblUsVS5lTmoQdELttKP4MTW7f8gvShhi3zpTrH53KjtPbO5m7I
         +NvgD2+/UsCTPZ+uG0Z/Xy8s3VYwy/ebZPDOdS7r6iYX4FFbLkF5p0zcN4Y6ZFjJHPHd
         El+ykHVR9gr9ko1OQnh+/u4Zuj1NWd7YgZr+6obs/1III0mo+1InXM6USs26tT2xWiFJ
         2/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtLlTJ9WD+GCO9L408uPqXQkN6BXSP+RMsdlvOV+W63ODOrVSmqw4yzquaqGmUbhSOLiqMM20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvB2/jUnFh33IqX6CkP/LclNS/M9uB9BP9nkafeGhUP9psyqJ
	eSwnWqpJ3o8Pkb4a5v45UhK7r8o/Luv8KAMXjKgkf80jo6/Jc6Mz1Vb/I0fOXHD1IqqBiT76CdG
	FV4ZryXIPTc1y8ICNaazhFDZ+C54usW4EF73FoC1A
X-Gm-Gg: ASbGncvkm0jve9F37k2NZL4e5HEeQ+GQM5dblmRDJUBFScKiqV4FDWnI88OW64B/DJb
	4tlOpcpEmNBKCyrwuqtuZAIqTNud9d9Hm9NAVKJrlH6jFYhT2RzokUX2pQLmcFN9hZv+vrEHAwe
	LG36HnfeiJ5yZpQ/AiHLL2SGp8GsINU5vJjYza5fkKxmAv2544fPM0bxawC3t8jXPsj6obdutR5
	4aM2uXDx6Z8de+xqiJexyZh1t/LLimAgOf8dZlIsb4=
X-Google-Smtp-Source: AGHT+IHeOXuLv/bYyF05bNjAKp3gcZtitkQE8CXsjuhD1iN+rwJvgHziEaLKkx8/4AZ6c994/TeJzCNnflGcaAPDHTQ=
X-Received: by 2002:a05:622a:391:b0:4b6:38f8:4edf with SMTP id
 d75a77b69052e-4e6ead1dfb3mr357461061cf.29.1760436132713; Tue, 14 Oct 2025
 03:02:12 -0700 (PDT)
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
 <7d89cff3-1045-4901-bdd3-f669eecfee97@linux.dev> <CANn89iJtMVRhcdfaH3Qz0cLf30cV32jYpAA5YBcL1Auovccdug@mail.gmail.com>
 <5d0df381-5a17-4b90-92dc-0d2976b585e0@linux.dev>
In-Reply-To: <5d0df381-5a17-4b90-92dc-0d2976b585e0@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 03:02:00 -0700
X-Gm-Features: AS18NWA0z5Xhq7Ehm-8UWu3FMuLGmX44Kw0G5JN-y1Sv9VCIANZAWLWKcUCjmIQ
Message-ID: <CANn89iKa9kTLSPLf+OBR=Tbs9SE=qpSMrR==L9sW9xc=Mgi0Fw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:41=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/10/14 16:09, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Oct 14, 2025 at 1:05=E2=80=AFAM luoxuanqiang <xuanqiang.luo@lin=
ux.dev> wrote:
> >>
> >> =E5=9C=A8 2025/10/14 15:34, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Tue, Oct 14, 2025 at 12:21=E2=80=AFAM luoxuanqiang <xuanqiang.luo@=
linux.dev> wrote:
> >>>> =E5=9C=A8 2025/10/13 17:49, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>> On Mon, Oct 13, 2025 at 1:26=E2=80=AFAM luoxuanqiang <xuanqiang.luo=
@linux.dev> wrote:
> >>>>>> =E5=9C=A8 2025/10/13 15:31, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>>>> On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev=
> wrote:
> >>>>>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>>>>>
> >>>>>>>> Add two functions to atomically replace RCU-protected hlist_null=
s entries.
> >>>>>>>>
> >>>>>>>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, =
as
> >>>>>>>> mentioned in the patch below:
> >>>>>>>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to -=
>next for
> >>>>>>>> rculist_nulls")
> >>>>>>>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to -=
>pprev for
> >>>>>>>> hlist_nulls")
> >>>>>>>>
> >>>>>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>>>>> ---
> >>>>>>>>      include/linux/rculist_nulls.h | 59 ++++++++++++++++++++++++=
+++++++++++
> >>>>>>>>      1 file changed, 59 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculi=
st_nulls.h
> >>>>>>>> index 89186c499dd4..c26cb83ca071 100644
> >>>>>>>> --- a/include/linux/rculist_nulls.h
> >>>>>>>> +++ b/include/linux/rculist_nulls.h
> >>>>>>>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(s=
truct hlist_nulls_node *n)
> >>>>>>>>      #define hlist_nulls_next_rcu(node) \
> >>>>>>>>             (*((struct hlist_nulls_node __rcu __force **)&(node)=
->next))
> >>>>>>>>
> >>>>>>>> +/**
> >>>>>>>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @n=
ode.
> >>>>>>>> + * @node: element of the list.
> >>>>>>>> + */
> >>>>>>>> +#define hlist_nulls_pprev_rcu(node) \
> >>>>>>>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->ppr=
ev))
> >>>>>>>> +
> >>>>>>>>      /**
> >>>>>>>>       * hlist_nulls_del_rcu - deletes entry from hash list witho=
ut re-initialization
> >>>>>>>>       * @n: the element to delete from the hash list.
> >>>>>>>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(str=
uct hlist_nulls_node *n)
> >>>>>>>>             n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(=
NULL);
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +/**
> >>>>>>>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
> >>>>>>>> + * @old: the element to be replaced
> >>>>>>>> + * @new: the new element to insert
> >>>>>>>> + *
> >>>>>>>> + * Description:
> >>>>>>>> + * Replace the old entry with the new one in a RCU-protected hl=
ist_nulls, while
> >>>>>>>> + * permitting racing traversals.
> >>>>>>>> + *
> >>>>>>>> + * The caller must take whatever precautions are necessary (suc=
h as holding
> >>>>>>>> + * appropriate locks) to avoid racing with another list-mutatio=
n primitive, such
> >>>>>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), runn=
ing on this same
> >>>>>>>> + * list.  However, it is perfectly legal to run concurrently wi=
th the _rcu
> >>>>>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entr=
y_rcu().
> >>>>>>>> + */
> >>>>>>>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_n=
ode *old,
> >>>>>>>> +                                          struct hlist_nulls_no=
de *new)
> >>>>>>>> +{
> >>>>>>>> +       struct hlist_nulls_node *next =3D old->next;
> >>>>>>>> +
> >>>>>>>> +       WRITE_ONCE(new->next, next);
> >>>>>>>> +       WRITE_ONCE(new->pprev, old->pprev);
> >>>>>>> I do not think these two WRITE_ONCE() are needed.
> >>>>>>>
> >>>>>>> At this point new is not yet visible.
> >>>>>>>
> >>>>>>> The following  rcu_assign_pointer() is enough to make sure prior
> >>>>>>> writes are committed to memory.
> >>>>>> Dear Eric,
> >>>>>>
> >>>>>> I=E2=80=99m quoting your more detailed explanation from the other =
patch [0], thank
> >>>>>> you for that!
> >>>>>>
> >>>>>> However, regarding new->next, if the new object is allocated with
> >>>>>> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as i=
n commit
> >>>>>> efd04f8a8b45 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->=
next for
> >>>>>> rculist_nulls=E2=80=9D)?
> >>>>>>
> >>>>>> Also, for the WRITE_ONCE() assignments to ->pprev introduced in co=
mmit
> >>>>>> 860c8802ace1 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->=
pprev for
> >>>>>> hlist_nulls=E2=80=9D) within hlist_nulls_add_head_rcu(), is that a=
lso unnecessary?
> >>>>> I forgot sk_unhashed()/sk_hashed() could be called from lockless co=
ntexts.
> >>>>>
> >>>>> It is a bit weird to annotate the writes, but not the lockless read=
s,
> >>>>> even if apparently KCSAN
> >>>>> is okay with that.
> >>>>>
> >>>> Dear Eric,
> >>>>
> >>>> I=E2=80=99m sorry=E2=80=94I still haven=E2=80=99t fully grasped the =
scenario you mentioned where
> >>>> sk_unhashed()/sk_hashed() can be called from lock=E2=80=91less conte=
xts. It seems
> >>>> similar to the race described in commit 860c8802ace1 (=E2=80=9Crcu: =
Use
> >>>> WRITE_ONCE() for assignments to ->pprev for hlist_nulls=E2=80=9D), e=
.g.: [0].
> >>>>
> >>> inet_unhash() does a lockless sk_unhash(sk) call, while no lock is
> >>> held in some cases (look at tcp_done())
> >>>
> >>> void inet_unhash(struct sock *sk)
> >>> {
> >>> struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> >>>
> >>> if (sk_unhashed(sk))    // Here no lock is held
> >>>       return;
> >>>
> >>> Relevant lock (depending on (sk->sk_state =3D=3D TCP_LISTEN)) is acqu=
ired
> >>> a few lines later.
> >>>
> >>> Then
> >>>
> >>> __sk_nulls_del_node_init_rcu() is called safely, while the bucket loc=
k is held.
> >>>
> >> Dear Eric,
> >>
> >> Thanks for the quick response!
> >>
> >> In the call path:
> >>           tcp_retransmit_timer()
> >>                   tcp_write_err()
> >>                           tcp_done()
> >>
> >> tcp_retransmit_timer() already calls lockdep_sock_is_held(sk) to check=
 the
> >> socket=E2=80=91lock state.
> >>
> >> void tcp_retransmit_timer(struct sock *sk)
> >> {
> >>           struct tcp_sock *tp =3D tcp_sk(sk);
> >>           struct net *net =3D sock_net(sk);
> >>           struct inet_connection_sock *icsk =3D inet_csk(sk);
> >>           struct request_sock *req;
> >>           struct sk_buff *skb;
> >>
> >>           req =3D rcu_dereference_protected(tp->fastopen_rsk,
> >>                                    lockdep_sock_is_held(sk)); // Check=
 here
> >>
> >> Does that mean we=E2=80=99re already protected by lock_sock(sk) or
> >> bh_lock_sock(sk)?
> > But the socket lock is not protecting ehash buckets. These are other lo=
cks.
> >
> > Also, inet_unhash() can be called from other paths, without a socket
> > lock being held.
>
> Dear Eric,
>
> I understand the distinction now, but looking at the call stack in [0],
> both CPUs reach inet_unhash() via the tcp_retransmit_timer() path, so onl=
y
> one of them should pass the check, right?
>
> I=E2=80=99m still not clear how this race condition arises.

Because that is two different sockets. This once again explains why
holding or not the socket lock is not relevant.

One of them is changing pointers in the chain, messing with
surrounding pointers.

The second one is reading sk->sk_node.pprev without using
hlist_unhashed_lockless().

I do not know how to explain this...

Please look at the difference between hlist_unhashed_lockless() and
hlist_unhashed().

