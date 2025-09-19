Return-Path: <netdev+bounces-224697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BCB8872B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079555252F4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F4303C8A;
	Fri, 19 Sep 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcPiN9rs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AF2FFDD2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271141; cv=none; b=lRA2DNODqq4IrHu8BFIB8DRGS4EmDrl93Y+gk1P1tU3rPNDZYUy4B34AP2CQMO6PxSicwTjXqpq1MdouHuADOewi2RWo0Gn1mw3mD+KDG8oxs0ECXjp+mKAOgHwYHW7YpINg12hAqklIJ/vL5rSqlsS+YGhAq61BV5mF/aI62TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271141; c=relaxed/simple;
	bh=PWkqXim616caMCUoB2MBVEytxRJh/jTEPv/iBDN0tnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRmlPhY8G7PGZOuhXdT36x6wyi5qYC9qvPIeD29TGwn9an4NpHp1siMPpOMFWsxhGLaw2b+1SlZbVA0mvkecht5XktvZCeDN/H4YQ116P3WJm/OPeIiE3pYfN5pe/yahK27/7nsR302O73MlV0H4d/ym8b24xtrA4dCkS54+oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcPiN9rs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26d0fbe238bso1245705ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758271139; x=1758875939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr+8Xbo6KMRqSiylMH3Kp3P98dZ/zYzG962CM8qCQZc=;
        b=UcPiN9rs80MmoHPKA9iaD6mAHqcQBiPE469EbY3y+NiJwIQ8tJ0ODNNHtCa+uWWFW3
         A2hB3MRcTesvcYTAzK0akpA8LZuFvy15VzjlJHooQD0Ng/XWTlpk8zvSYrQeYzKw6cG8
         4+bCW2tKBQ9mbkAc/PCBHGr89XwCuokiWVh1z4bnKcBmkAVBCU/o1qWOo45/lyj9MbX6
         MJfu+5cQJe3I3UEt60PmjBVfuNwtp3ndD7HBePgCPiYTKyGM7Xrh6chBiMpXppKicNvB
         1IvCXogDmttnDvSLhLFFDdCaJW9O/uLiGE3RXbmXsbKZVzSpzR7V/7i/Lhcl37f2iI6j
         Cbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271139; x=1758875939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr+8Xbo6KMRqSiylMH3Kp3P98dZ/zYzG962CM8qCQZc=;
        b=v1TOIPPTtVSo3MhpxbWxSUPaJbhAa1bM+q7+PhisqiCe00kSA+Wfb3YCAJXApllPYm
         f4phNu/SRs6ICTNjpl8gobiHVfw81AjCGWKXh9h045iz4wtBhKB6unYZzfB1xB5s5oPV
         cDhcY36PiPWljjBto3vDLzIp+CBKX8+8G7cby30Bh/OtvadbirsIY9V8RPLL4NdqsKnZ
         l9u+t6XTfMRojDmwW3q5D9v8fV6IrvO4uJD+AbVdUSXynAWHKGEr1QtzP8gi6Zsdamoh
         m4XbnfguNk7lrvgaBqaXZAnDoEx+svLgcK8/2HnLcXi+HjkJIVimsSioMowe2bcGHWyq
         A80A==
X-Forwarded-Encrypted: i=1; AJvYcCVX9NHJvUCKof86to3P/s8YsmidxmQcR/P5TQsRrwFxh7uYOMKhxOibLZ6qpZIqeeLdAPb8zgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5xHPXKicPax1wHZTV7Pthv8Dl2PVBBzDgTGf7oazF0eWW/lZ
	GA7+VSb+wJwTev1/cfjlUJEJw+EInQm7XvR7HagkcU1XQMMc2j5CzYTPMLY7AORkrhDa5RU4b/r
	CMuXlp3RP84j7LTExpBQeukNY9NV2eXqwGs1rBR1J
X-Gm-Gg: ASbGncspDjHBMzoYsEDKBslj0nhTZ/GgZyrp7aD3Ld9Zw2OjOIWJEcz7etx3nKvdyLP
	kOHDWMJqtQTnezxsQCoKIwvfu+HHe6Ld/8iWKiigTxEUYXAfWy3juWu1SgB8PrH3kn/JKMyTctj
	StvFdyPPAHgUcm1+APZl7JiHhkTtLnoQAvQQjo1Uu4IYopiQzcxVdiNpPTi26EQP6yzlQzyxGWF
	/2nAtP/2j2jOFBymTXOo3zQlXUK4OS6o1Ap672eQV+uy2Bb8+o=
X-Google-Smtp-Source: AGHT+IGvuOdE18B7llRrsq5DbsUqq1m1FaNijof4TJfbxShE5FBofJsWDBafmEbZsNpJLSzANhPC5a3FIjGc9dgNjPI=
X-Received: by 2002:a17:902:ef48:b0:248:6d1a:4304 with SMTP id
 d9443c01a7336-269ba50119amr41603245ad.38.1758271138720; Fri, 19 Sep 2025
 01:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-4-xuanqiang.luo@linux.dev> <CAAVpQUAEBeTjHxT7nk7qgOL8qmVxqdnSDeg=TKt4GjwNXEPxUA@mail.gmail.com>
 <9d6b887f-c75c-468b-beaf-a3c7979bd132@linux.dev> <CAAVpQUBY=h3gDfaX=J9vbSuhYTn8cfCsBGhPLqoer0OSYdihDg@mail.gmail.com>
 <c7a91e0c-b575-43b3-af5b-64fc35b46fac@linux.dev>
In-Reply-To: <c7a91e0c-b575-43b3-af5b-64fc35b46fac@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Sep 2025 01:38:47 -0700
X-Gm-Features: AS18NWDBExmK9dK9S_Z67feq7iXc5jeWyjAJuL163ZRjPgeRom-1fdJ0iDIV6Fw
Message-ID: <CAAVpQUCAfZNd94eXuZs1FuQJq-3-Li0td1gg5Eiave+Sv7wBBg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:33=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/17 12:36, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Tue, Sep 16, 2025 at 8:27=E2=80=AFPM luoxuanqiang <xuanqiang.luo@lin=
ux.dev> wrote:
> >>
> >> =E5=9C=A8 2025/9/17 03:48, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> >>> On Tue, Sep 16, 2025 at 3:31=E2=80=AFAM <xuanqiang.luo@linux.dev> wro=
te:
> >>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>
> >>>> Since ehash lookups are lockless, if another CPU is converting sk to=
 tw
> >>>> concurrently, fetching the newly inserted tw with tw->tw_refcnt =3D=
=3D 0 cause
> >>>> lookup failure.
> >>>>
> >>>> The call trace map is drawn as follows:
> >>>>      CPU 0                                CPU 1
> >>>>      -----                                -----
> >>>>                                        inet_twsk_hashdance_schedule(=
)
> >>>>                                        spin_lock()
> >>>>                                        inet_twsk_add_node_rcu(tw, ..=
.)
> >>>> __inet_lookup_established()
> >>>> (find tw, failure due to tw_refcnt =3D 0)
> >>>>                                        __sk_nulls_del_node_init_rcu(=
sk)
> >>>>                                        refcount_set(&tw->tw_refcnt, =
3)
> >>>>                                        spin_unlock()
> >>>>
> >>>> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu(=
) after
> >>>> setting tw_refcnt, we ensure that tw is either fully initialized or =
not
> >>>> visible to other CPUs, eliminating the race.
> >>>>
> >>>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU=
 / hlist_nulls")
> >>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>> ---
> >>>>    net/ipv4/inet_timewait_sock.c | 15 ++++++---------
> >>>>    1 file changed, 6 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_=
sock.c
> >>>> index 5b5426b8ee92..1ba20c4cb73b 100644
> >>>> --- a/net/ipv4/inet_timewait_sock.c
> >>>> +++ b/net/ipv4/inet_timewait_sock.c
> >>>> @@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_ti=
mewait_sock *tw,
> >>>>           spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_has=
h);
> >>>>           struct inet_bind_hashbucket *bhead, *bhead2;
> >>>>
> >>>> -       /* Step 1: Put TW into bind hash. Original socket stays ther=
e too.
> >>>> +       /* Put TW into bind hash. Original socket stays there too.
> >>>>              Note, that any socket with inet->num !=3D 0 MUST be bou=
nd in
> >>>>              binding cache, even if it is closed.
> >>>>            */
> >>>> @@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_t=
imewait_sock *tw,
> >>>>
> >>>>           spin_lock(lock);
> >>>>
> >>>> -       /* Step 2: Hash TW into tcp ehash chain */
> >>>> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
> >>>> -
> >>>> -       /* Step 3: Remove SK from hash chain */
> >>>> -       if (__sk_nulls_del_node_init_rcu(sk))
> >>>> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >>>> -
> >>>> -
> >>>>           /* Ensure above writes are committed into memory before up=
dating the
> >>>>            * refcount.
> >>>>            * Provides ordering vs later refcount_inc().
> >>>> @@ -162,6 +154,11 @@ void inet_twsk_hashdance_schedule(struct inet_t=
imewait_sock *tw,
> >>>>            */
> >>>>           refcount_set(&tw->tw_refcnt, 3);
> >>>>
> >>>> +       if (hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw=
_node))
> >>>> +               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >>>> +       else
> >>>> +               inet_twsk_add_node_rcu(tw, &ehead->chain);
> >>> When hlist_nulls_replace_init_rcu() returns false ?
> >> When hlist_nulls_replace_init_rcu() returns false, it means
> >> sk is unhashed,
> > and how does this happen ?
> >
> > Here is under lock_sock() I think, for example, you can
> > find a lockdep annotation in the path:
> >
> > tcp_time_wait_init
> >    tp->af_specific->md5_lookup / tcp_v4_md5_lookup
> >      tcp_md5_do_lookup
> >        __tcp_md5_do_lookup
> >          rcu_dereference_check(tp->md5sig_info, lockdep_sock_is_held(sk=
));
> >
> > So, is there a path that unhashes socket without holding
> > lock_sock() ?
> >
> I'm not entirely sure about this point yet, because
> inet_unhash() is called in too many places and uses
> __sk_nulls_del_node_init_rcu() to unhash sockets without
> explicitly requiring bh_lock_sock().
>
> Until I can verify this, I'll keep the original check
> for old socket unhashed state to ensure safety.
>
> It would be great if you could confirm this behavior.

See:
https://lore.kernel.org/netdev/20250919083706.1863217-4-kuniyu@google.com/

