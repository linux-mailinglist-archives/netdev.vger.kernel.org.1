Return-Path: <netdev+bounces-223330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8950B58BC7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3581B1BC3230
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FE824A3;
	Tue, 16 Sep 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Br3xGwO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28435979
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989096; cv=none; b=GZFz7JeZJmMrHXsiLcZucn+pKhbjCF2gEnhKLMA4rNZROWXkH35v/oe1SlUhRCAR2l1KAeuyxnYyYYlFhPJz00usa7h0DVWlcSdv+a6HYjhiEb5e5dWADxo4VN0XGtCqDlIV9kpp+3vTah4y0jUucOKXz4S/QliWgbjQpoDROno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989096; c=relaxed/simple;
	bh=mpPSDgeNkUAqFoVVZ2bx+ygac0btPPgnr2ovAgHP0B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMIfjUbxjLpAvOPK94mgVfQ6fgDm+cJda0unjKW6iky7jKRO10hadcM8Jw9gzY+uIM5RW+/MMGrrY4KRjXbr8QeENpggadjnatiVWabVbd+HrWvoEhachX2nEsyHPXhavb8Gm0AjVStrdarVAKAQvSBZalUCe+KSHPdXJnCQkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Br3xGwO8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25669596955so50470615ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757989095; x=1758593895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssZ0+1jnVXkqZJ2FRTLCf5eCIXUo61GU6BCvoka6zGk=;
        b=Br3xGwO88d+OforUP4f3nuxs0pglRDsPFsfFZ2I6ohNbJdup6zoh6vSz/SivI9wht/
         b0nFpTPE2bYKiGOSIWeLwkYX129UYk6NXHMl+8tnbUpwpZ59UlaSd8HV5j+A5qAmT5ao
         ciqRjScq9dJEqyqjysQ/2qroF7BCmUwr8vPebHul2t0x9fPd9D9jmmpFvQXHKIQs0kUS
         D/V9Aqkc/HD1CZUuPMzDJ+z8wSPeMKVh+gq1TXbCTeVrKnk9uJJlpPP2ic1TSu+OE8Jn
         1wybe/1oXW+5WoTcEYWGlJjqLKsRCJ8eZ1n+OlSA28NqSXEvEb51Pw2nVyeIjGJy001t
         qieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757989095; x=1758593895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssZ0+1jnVXkqZJ2FRTLCf5eCIXUo61GU6BCvoka6zGk=;
        b=ST1JCEc8xplsWX5fDty+562SJms3Wm0bnMw1wzLG+vlMN5NmmR6dtUifYKZJVhPPZt
         hAnwUUCjvu145vw16qt9nCjKwvCuAxJDSw1czjuB66g5XPGdgnHhA6plPUnUHMgkLirE
         RLUS3uFxktbdesSVKjp4gS+OA+eSfOMNKpMC3FAy92bnAOoJXciTpMorZFfOJLNDzlnl
         9pH7gW9Pbk8V7+Am9gTE8i12YoZYcuj9b7GehoWLPhjZUiHBKw/A3eekzkluSluan+eI
         LU1/cyWtCWIZXDgb+USK6V4rSM36bPvKR1mspiKLB/0MsqN3rBey16TophMHV56k82WV
         1zeA==
X-Forwarded-Encrypted: i=1; AJvYcCVkUn9HDZruwFKGqaYIUqeppRfGcUa8MGeGm64PLwO9qcZJBXSR7hdTWHCeYdUufwZuXp36354=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhpv4x3IYxa0zvSjz/M8j+pgBSeww9pTH2XFe+wQqvVEIs1of
	X3+p6DCMiZFOOwbAFvgfboaS9fmn0hk1fZMz8/N4TA0swz5/7CNXhsZEnfQKaC3rmOec7tsfmqN
	CLPBR+zxJtnusZb0l+oPIp4SI5OoLkiFoANcOi1i6zFnjVak8P8qQ14OQAr4=
X-Gm-Gg: ASbGncsYXL8//HSm7YFa3UD9QUlrpNg7rJvzcGpA48oaQWzb77UsR5HZKvXNIsuHV8R
	D3+LbwtxTY7vG7uiQDEWVrt8Tg+bS3TIEE4pwpuWkoxhB2F//qLt/ojFAsG9cyuAGTIOPlTjP9p
	+umhqqryuV2OeGSMqBvJCgRQ3de4eF+AJc4wlSFu1pBM/OfilNGahAVzaQTJDaxna3lVsdc3DrS
	t4YLGlqY0w7w4VWHwSB9nXvDLdsS5vIJhCw2vTJJPDVsBU=
X-Google-Smtp-Source: AGHT+IFe/D+xcMVimoB2NBJoFP2ubkzFSeQRFLIDGsoIWjEleqKa5czYy1MXHPqTbnZqOgNuaN3ddEuk21+CNVTtm+w=
X-Received: by 2002:a17:903:13d0:b0:24b:270e:56c7 with SMTP id
 d9443c01a7336-25d2528be3dmr174708825ad.7.1757989094382; Mon, 15 Sep 2025
 19:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
 <20250915070308.111816-3-xuanqiang.luo@linux.dev> <CAAVpQUDHF_=gdXSr4TX=11gn7_-NObqN156x_rtQMPitL+YUTg@mail.gmail.com>
 <fdaa51d5-a196-4910-bfea-ba554d95623b@linux.dev>
In-Reply-To: <fdaa51d5-a196-4910-bfea-ba554d95623b@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 19:18:03 -0700
X-Gm-Features: Ac12FXwxVouER1jNQH1y0J7-Mvh--3a9WED5_B0Nz1UH_jyHn76BT__OHqqAzfc
Message-ID: <CAAVpQUDwKTOpJAHU7W2rkjb91U8WE6mL3vdTxx_3wAb4C-M4vQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:57=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/16 07:00, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Mon, Sep 15, 2025 at 12:04=E2=80=AFAM <xuanqiang.luo@linux.dev> wrot=
e:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> Since ehash lookups are lockless, if one CPU performs a lookup while
> >> another concurrently deletes and inserts (removing reqsk and inserting=
 sk),
> >> the lookup may fail to find the socket, an RST may be sent.
> >>
> >> The call trace map is drawn as follows:
> >>     CPU 0                           CPU 1
> >>     -----                           -----
> >>                                  inet_ehash_insert()
> >>                                  spin_lock()
> >>                                  sk_nulls_del_node_init_rcu(osk)
> >> __inet_lookup_established()
> >>          (lookup failed)
> >>                                  __sk_nulls_add_node_rcu(sk, list)
> >>                                  spin_unlock()
> >>
> >> As both deletion and insertion operate on the same ehash chain, this p=
atch
> >> introduces two new sk_nulls_replace_* helper functions to implement at=
omic
> >> replacement.
> >>
> >> If sk_nulls_replace_node_init_rcu() fails, it indicates osk is either
> >> hlist_unhashed or hlist_nulls_unhashed. The former returns false; the
> >> latter performs insertion without deletion.
> >>
> >> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive session=
s")
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   include/net/sock.h         | 23 +++++++++++++++++++++++
> >>   net/ipv4/inet_hashtables.c |  7 +++++++
> >>   2 files changed, 30 insertions(+)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 896bec2d2176..26dacf7bc93e 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -859,6 +859,29 @@ static inline bool sk_nulls_del_node_init_rcu(str=
uct sock *sk)
> >>          return rc;
> >>   }
> >>
> >> +static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
> >> +                                                   struct sock *new)
> >> +{
> >> +       if (sk_hashed(old) &&
> >> +           hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
> >> +                                        &new->sk_nulls_node))
> >> +               return true;
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
> >> +                                                 struct sock *new)
> >> +{
> >> +       bool rc =3D __sk_nulls_replace_node_init_rcu(old, new);
> >> +
> >> +       if (rc) {
> >> +               WARN_ON(refcount_read(&old->sk_refcnt) =3D=3D 1);
> >> +               __sock_put(old);
> >> +       }
> >> +       return rc;
> >> +}
> >> +
> >>   static inline void __sk_add_node(struct sock *sk, struct hlist_head =
*list)
> >>   {
> >>          hlist_add_head(&sk->sk_node, list);
> >> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> >> index ef4ccfd46ff6..7803fd3cc8e9 100644
> >> --- a/net/ipv4/inet_hashtables.c
> >> +++ b/net/ipv4/inet_hashtables.c
> >> @@ -685,6 +685,12 @@ bool inet_ehash_insert(struct sock *sk, struct so=
ck *osk, bool *found_dup_sk)
> >>          spin_lock(lock);
> >>          if (osk) {
> >>                  WARN_ON_ONCE(sk->sk_hash !=3D osk->sk_hash);
> >> +               /* Since osk and sk should be in the same ehash bucket=
, try
> >> +                * direct replacement to avoid lookup gaps. On failure=
, no
> >> +                * changes. sk_nulls_del_node_init_rcu() will handle t=
he rest.
> > Both sk_nulls_replace_node_init_rcu() and
> > sk_nulls_del_node_init_rcu() return true only when
> > sk_hashed(osk) =3D=3D true.
> >
> > Only thing sk_nulls_del_node_init_rcu() does is to
> > set ret to false.
> >
> >
> >> +                */
> >> +               if (sk_nulls_replace_node_init_rcu(osk, sk))
> >> +                       goto unlock;
> >>                  ret =3D sk_nulls_del_node_init_rcu(osk);
> > So, should we simply do
> >
> > ret =3D sk_nulls_replace_node_init_rcu(osk, sk);
> > goto unlock;
> >
> > ?
>
> sk_nulls_replace_node_init_rcu() only returns true if both
> sk_hashed(osk) =3D=3D true and hlist_nulls_unhashed(old) =3D=3D false.

sk_hashed(sk) =3D=3D !hlist_nulls_unhashed(&sk->sk_nulls_node)
is always true as sk_node and sk_nulls_node are in union.


> However, in the original sk_nulls_del_node_init_rcu() logic, when
> sk_hashed(osk) =3D=3D true,

So this should be an unreachable branch.

> it always performs __sock_put(sk) regardless of
> the hlist_nulls_unhashed(old) check. Therefore, if
> sk_nulls_replace_node_init_rcu() fails, we can safely let ret or
> __sock_put(sk) be handled by the subsequent
> sk_nulls_del_node_init_rcu(osk) call. Thanks Xuanqiang.
>
> >
> >>          } else if (found_dup_sk) {
> >>                  *found_dup_sk =3D inet_ehash_lookup_by_sk(sk, list);
> >> @@ -695,6 +701,7 @@ bool inet_ehash_insert(struct sock *sk, struct soc=
k *osk, bool *found_dup_sk)
> >>          if (ret)
> >>                  __sk_nulls_add_node_rcu(sk, list);
> >>
> >> +unlock:
> >>          spin_unlock(lock);
> >>
> >>          return ret;
> >> --
> >> 2.27.0
> >>

