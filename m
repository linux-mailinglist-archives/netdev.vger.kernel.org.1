Return-Path: <netdev+bounces-225483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC3B94292
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 05:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BFF18A21CB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351E26CE28;
	Tue, 23 Sep 2025 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIisEbJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B8265CA6
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599785; cv=none; b=czS8SH/aN6ukpzj81wSJlETgO1YO638lDolbXdejNqD4ZpL4lAgBl/6NQkjgRByfDvxrpZ1xlrckRK1HucTqBKRiEXM6aEa0oWMAek/7uC+UR2uWzhWcZ3qOk4/PLndO96xckPQf/nIthPWJ+TIZcG06NTdUs7RjLR4YYdMKS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599785; c=relaxed/simple;
	bh=iOAiEoepOu18Hw9N1gwun3yiAgJXP1UHkDE0nH+jq4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/75GJBb3EHeeoyw3RdsGrwiimFcbLiKlV95FgT7mECGR/z+INHsJ0pNXJF2FPi3IpM4XQQgbx+Y9emg/wi3q+J9QszulTLet8xrlAHXrEiTHIsBWeR3Lya/SqUD8Z63KjbHf/Dxa6Xyh1lzPS302j6dmhBJYy+3Y8UgZmVzUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIisEbJr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1a79d7e5so2804660b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758599783; x=1759204583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO/FS1xsYwnRo3KBFyWHEF4FP/tco9xCBUaXgYPX6hc=;
        b=ZIisEbJrOu/DuekD8rWG/5RamuxjtYq9kN8dD6KDLDyOwJGmQoflw7wuqJWY65qBEN
         XTachW/Oq4znteGOdOn+R1TpRX8cTriJ28gnJsVmxoF2N73QEReiSgiBxFejnL8t51zU
         jbpGovgksCgqxsQTd0Ac2sc2C5kzbmps+ioJEpkC7pjtq3yZozW0/a176IMEHceHTkav
         JO88z+ZViAx//BuxEmT2d4yoqCQHZwyeRWTqtQkgFYj8ZBLDfJqAwsCGxW4KaTWjrfmV
         yKc0vu1vRv/+HLJPXSaBCNNBhQNYzj5e6jgBAYZDpYvQd1qGVuiNfAQZjsQI1nsoKPvA
         i9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599783; x=1759204583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO/FS1xsYwnRo3KBFyWHEF4FP/tco9xCBUaXgYPX6hc=;
        b=PHvX/SexxtY0C1G1ll2gK/juYN8pPzc93hisL6C3Dzx7XrBrFHd0YuvHpRuvrgtKMk
         mEMLpNLRGLIOiEISv2LSfF/oUH1GMtNIzbOJWLsiacb7CSzT2JCJFQkPUHU8TrMjcLKT
         aZpHs9QtmnvVYcKwAidgxxb1IEGoNntsoWOpniyEQIOWxL6L6crq+82/pvYg3K5M8YQ9
         9PVwPAvLFO858QyRGpf3Hk9+qApe2PYSZkrx6Z1ZUwnQBE9p/C8Fq/YppSPn+2S8lge2
         /oYyeTKACaBKxocRGRZfXUYeJyad1XpNODzBwiPradFMt8kfofY2d9vEos0GWnqxiQW+
         6O4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVW2IdzFImyJOwKcPrzwS/W5fmNiJLwqqPx/J+jT0TDqZIDfecp3CpE2GwVXSE7Q056+LOnUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7UssohFMHs3J5/nCnmnukJhwalvxSMqHtZYOnKKDAm6CY+IM
	YGx3LevbKkiceGHk7EHX/B93fz9xjaCNtXQZu+nFdAm78dWKaZzVPXoeaX4mtGNZHTJ0RJKud/W
	rOKZiJ7hQNELsBvsfudSzCZH7eIXRDJDciJGnX6gt
X-Gm-Gg: ASbGncs/DvzRjJ0wMiAADt4Ph3DG7CDM/XB59Ll+B5FJFHheCDx5SoNymS+RNELUmuY
	lN8kXdCwgdJzjXxOD0za8oUkm6xZw3IeOdfUWkxgAZ7Wfsl4Wo9UQHAWt+8ZugTTc6eMCYH11Fn
	DD8SbkBtsejjpEb5ogm5MJoKnkNsIegVRs27TmskmYgjXUzORcUDzCfDsl2dt8dAU5qUcldtvu1
	tv+9VI8QwlJy9LRbLnwd7Xvqp91+B65UbZ4jd2M
X-Google-Smtp-Source: AGHT+IF5jQgeWHAmCyXtiipb20RwfRMSnBAf4jBsbzGpJZ6BIHPRw8lI8g89KwmcUJEYnCK7RLc+8WV+z9BPpvy9Jvk=
X-Received: by 2002:a05:6a20:e292:b0:247:65a0:822 with SMTP id
 adf61e73a8af0-2cff1c61c0amr1966138637.40.1758599782914; Mon, 22 Sep 2025
 20:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
 <20250920105945.538042-4-xuanqiang.luo@linux.dev> <CAAVpQUDaYX5ZQN+EYL3q4yeu0Ni2cqNODEY--Wb-2+yY650Mbw@mail.gmail.com>
 <c90e37cf-82a5-4c31-abe1-1fca8bfc8867@linux.dev>
In-Reply-To: <c90e37cf-82a5-4c31-abe1-1fca8bfc8867@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 20:56:11 -0700
X-Gm-Features: AS18NWD803ltbZQDGHPtxQ_eNJk4XK1UOY3AGwqzsHdiBC2_Emr-LHGSG6UeXBg
Message-ID: <CAAVpQUBqiSkPGSGLqDweeOifGUPVx6TvyYcy2BoxKSY2qrtOPg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:07=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/23 08:45, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Sat, Sep 20, 2025 at 4:00=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote=
:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> Since ehash lookups are lockless, if another CPU is converting sk to t=
w
> >> concurrently, fetching the newly inserted tw with tw->tw_refcnt =3D=3D=
 0 cause
> >> lookup failure.
> >>
> >> The call trace map is drawn as follows:
> >>     CPU 0                                CPU 1
> >>     -----                                -----
> >>                                       inet_twsk_hashdance_schedule()
> >>                                       spin_lock()
> >>                                       inet_twsk_add_node_rcu(tw, ...)
> >> __inet_lookup_established()
> >> (find tw, failure due to tw_refcnt =3D 0)
> >>                                       __sk_nulls_del_node_init_rcu(sk)
> >>                                       refcount_set(&tw->tw_refcnt, 3)
> >>                                       spin_unlock()
> >>
> >> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() =
after
> >> setting tw_refcnt, we ensure that tw is either fully initialized or no=
t
> >> visible to other CPUs, eliminating the race.
> >>
> >> It's worth noting that we replace under lock_sock(), so no need to che=
ck if sk
> >> is hashed. Thanks to Kuniyuki Iwashima!
> >>
> >> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU /=
 hlist_nulls")
> >> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> > This is not needed.  A pure review does not deserve Suggested-by.
> > This is used when someone suggests changing the core idea of
> > the patch.
>
> Got it, but still really appreciate your detailed
> and patient review!
>
> >
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   net/ipv4/inet_timewait_sock.c | 13 ++++---------
> >>   1 file changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_so=
ck.c
> >> index 5b5426b8ee92..bb98888584a8 100644
> >> --- a/net/ipv4/inet_timewait_sock.c
> >> +++ b/net/ipv4/inet_timewait_sock.c
> >> @@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_time=
wait_sock *tw,
> >>          spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);
> >>          struct inet_bind_hashbucket *bhead, *bhead2;
> >>
> >> -       /* Step 1: Put TW into bind hash. Original socket stays there =
too.
> >> +       /* Put TW into bind hash. Original socket stays there too.
> >>             Note, that any socket with inet->num !=3D 0 MUST be bound =
in
> >>             binding cache, even if it is closed.
> >>           */
> >> @@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_tim=
ewait_sock *tw,
> >>
> >>          spin_lock(lock);
> >>
> >> -       /* Step 2: Hash TW into tcp ehash chain */
> >> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
> >> -
> >> -       /* Step 3: Remove SK from hash chain */
> >> -       if (__sk_nulls_del_node_init_rcu(sk))
> >> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >> -
> >> -
> >>          /* Ensure above writes are committed into memory before updat=
ing the
> >>           * refcount.
> >>           * Provides ordering vs later refcount_inc().
> >> @@ -162,6 +154,9 @@ void inet_twsk_hashdance_schedule(struct inet_time=
wait_sock *tw,
> >>           */
> >>          refcount_set(&tw->tw_refcnt, 3);
> > I discussed this series with Eric last week, and he pointed out
> > (thanks!) that we need to be careful here about memory barrier.
> >
> > refcount_set() is just WRITE_ONCE() and thus can be reordered,
> > and twsk could be published with 0 refcnt, resulting in another RST.
> >
> Thanks for Eric's pointer!
>
> Could you let me know if my modification here works?
>
> That is, moving smp_wmb() to after the refcount update:

I think this should be fine, small comment below

>
> @@ -140,19 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>
>          spin_lock(lock);
>
> -       /* Step 2: Hash TW into tcp ehash chain */
> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
> -
> -       /* Step 3: Remove SK from hash chain */
> -       if (__sk_nulls_del_node_init_rcu(sk))
> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> -
> -
> -       /* Ensure above writes are committed into memory before updating =
the
> -        * refcount.
> -        * Provides ordering vs later refcount_inc().
> -        */
> -       smp_wmb();
>          /* tw_refcnt is set to 3 because we have :
>           * - one reference for bhash chain.
>           * - one reference for ehash chain.
> @@ -162,6 +149,14 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>           */
>          refcount_set(&tw->tw_refcnt, 3);
>
> +       /* Ensure tw_refcnt has been set before tw is published by
> +        * necessary memory barrier.

This sounds like tw is published by memory barrier,
perhaps remove after 'by' ?  It's obvious that the comment
is for smp_wmb() below.



> +        */
> +       smp_wmb();
> +
> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
>          inet_twsk_schedule(tw, timeo);
>
>          spin_unlock(lock);
>
> Thanks!
> Xuanqiang
>
> >> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node)=
;
> >> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >> +
> >>          inet_twsk_schedule(tw, timeo);
> >>
> >>          spin_unlock(lock);
> >> --
> >> 2.25.1
> >>

