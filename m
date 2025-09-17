Return-Path: <netdev+bounces-223854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B284B7EC00
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE41526E35
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D5199920;
	Wed, 17 Sep 2025 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zY+mr0kB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160C469D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083804; cv=none; b=epWPFBiFOB/fCECi7isRmfujsoY3xQxDZRUX+4ofHm+1lqFmVfDHtXTTsNPIYOrPF0b/5VmIBCT/wz2LLQlgZMKLvwvoQ3LzDAwMgaXzm5/a9E9BISgyyke8NjtzcrvGqH1hZEiLtj+/7GwSSr6dsHDwfPEPddPWB9hOiLf69KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083804; c=relaxed/simple;
	bh=s8v/Gzy/XLwKvlRWKrx5hQ13y3yv2+82V/p1QiOJUo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPxwnzI2ZjwiOSnYdvs5xJCbxyFKT1W80ChfmEoNlWATZQN3o6MPmQ0xmjuMslSBNtmDEg72c9fM0IAzesj/Jp66yhlEYCphl0PyLDDjvR+p43t/whxHVD+gv87gtTk7IRYNGyampncYx+kbcYcn/oHxPIlKrq4bKtdfB5/HGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zY+mr0kB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-25669596921so64302995ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758083802; x=1758688602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj3DjHWrSkaxObZQ8u8phhXvz2NknqsvBdFCEYE6rUU=;
        b=zY+mr0kBaMi4axgl/HsWBzGeiy7VfqzIoqq4gu/KVkUDvl/rq/Zzb9dv7hdEg13Lrr
         qxqYy98moNqW4LBM9P7bv+QYr03fJtGQr/59R26sGV3FwVpuNjV2axD3yYtJeD+3yvgN
         +EH7H53MONsGUz3GJ3psVh/NAoa9gActCPIG0/5KmSyRXAlJZCeK/M/nSdqRQWnF/m2Q
         tj16cKRngSBcKfF6Bv3Zv+b8V11JA1YKDx0kGT5hHjLZAaiuy0+YozJIGjR8ReE45uUa
         cVCg0cARJJ9RZJeluc6wXHt2Il2rBmzhKYrhP0PF5o356wdWvUA09dmaRaX4uWHIScpg
         0cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758083802; x=1758688602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj3DjHWrSkaxObZQ8u8phhXvz2NknqsvBdFCEYE6rUU=;
        b=GzX2XioX4CbP8scGxKTj9Pwd8YsB6Z6sPElTqA054IT2uzi38UC0qttBE8CgiSdtgA
         Zi3UUd0BoryiNzqJJHMf0vEHhQqrmTLICSO7JvWLaFGEtgkejljlZwsQjY7Zg8VJpc5V
         fF7Qfjg6Sa35bOxpg2R1UDzJ5qC3ImJiQq4we1ffBD110uQylc2ZhgBlkIh+6RQwqwRO
         tltSqHU7m5LM8Y/9zA2gz44Vnq5OqSxOL00xMYNSRKaQhDDpauugAFh9gLPCqvrLiIg2
         GTRq8YnPw0Plb9uumPDNgw1YGKu/a1VInO+5vbwl1DX9mf8dGsouDmZX2OfrCVh6EG09
         3bNw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMTkx9aMndW89D3jKQl3ur6Tf6i1lEehlK1MMHgdfq1PQUtcLzCBkmai9QCs3xds3nJ8xsSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapE7RR5Rb2hm05BKPZFG9vTdqdzIqG4GpT4XSiilAl0FjOOUi
	VsOZy4XaVM1WUcdPxmOpYqSJTkvnluApcGiCcsSIfOdEB0iuJEGmeBjh0wMEi70TyBLzqddppbe
	DrP7+8M8IWzYwq/wgCTtmvWmXw7bQ9hKbLDh6OoWv
X-Gm-Gg: ASbGncsWqSWYQtHrlkRxIsOvf1Hu2gz9gdv52mhtldzUCp/n4bMs4nrODwhj7MgtTny
	fXLouIN1OcQBOfIpa7YtfLGI9A7r/IqW9DccuABh5BWo0/qZJthw8VUzMe2txqa9Vj6q4icUeFq
	JOjeLK3ghctdfEYC5AuqOpitmQIa1H+kpFmFRv0FgtP+bXxLFoFfw+JaYNtLzOhQJrWqde9i3MV
	vIMJKVlzeol++CHca23zQ18OEc75JsPMb3jdO/mweYcTKexyKrwzIPu
X-Google-Smtp-Source: AGHT+IF+EfnvHV63Qn3qeboHWvymYkGuTobTdywhdUqj6UHCb1aGtfoHnWuqz1dVX/QATAmVDJFIgmVWD5tzFFD9sQw=
X-Received: by 2002:a17:902:d511:b0:267:a1f1:9b23 with SMTP id
 d9443c01a7336-2681218fc5fmr11080995ad.18.1758083802199; Tue, 16 Sep 2025
 21:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-4-xuanqiang.luo@linux.dev> <CAAVpQUAEBeTjHxT7nk7qgOL8qmVxqdnSDeg=TKt4GjwNXEPxUA@mail.gmail.com>
 <9d6b887f-c75c-468b-beaf-a3c7979bd132@linux.dev>
In-Reply-To: <9d6b887f-c75c-468b-beaf-a3c7979bd132@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 21:36:31 -0700
X-Gm-Features: AS18NWBN4G0YdzGuSeBgbqbMYr4qHUI-HXFRELyNk4EvU_e6eeZzP8b4HB3hc5k
Message-ID: <CAAVpQUBY=h3gDfaX=J9vbSuhYTn8cfCsBGhPLqoer0OSYdihDg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:27=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/17 03:48, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Tue, Sep 16, 2025 at 3:31=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote=
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
> >> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU /=
 hlist_nulls")
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   net/ipv4/inet_timewait_sock.c | 15 ++++++---------
> >>   1 file changed, 6 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_so=
ck.c
> >> index 5b5426b8ee92..1ba20c4cb73b 100644
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
> >> @@ -162,6 +154,11 @@ void inet_twsk_hashdance_schedule(struct inet_tim=
ewait_sock *tw,
> >>           */
> >>          refcount_set(&tw->tw_refcnt, 3);
> >>
> >> +       if (hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_n=
ode))
> >> +               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >> +       else
> >> +               inet_twsk_add_node_rcu(tw, &ehead->chain);
> > When hlist_nulls_replace_init_rcu() returns false ?
>
> When hlist_nulls_replace_init_rcu() returns false, it means
> sk is unhashed,

and how does this happen ?

Here is under lock_sock() I think, for example, you can
find a lockdep annotation in the path:

tcp_time_wait_init
  tp->af_specific->md5_lookup / tcp_v4_md5_lookup
    tcp_md5_do_lookup
      __tcp_md5_do_lookup
        rcu_dereference_check(tp->md5sig_info, lockdep_sock_is_held(sk));

So, is there a path that unhashes socket without holding
lock_sock() ?


> the replacement operation failed, we need
> to insert tw, and this doesn't change the original logic.
>
> >
> >> +
> >>          inet_twsk_schedule(tw, timeo);
> >>
> >>          spin_unlock(lock);
> >> --
> >> 2.25.1
> >>

