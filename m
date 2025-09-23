Return-Path: <netdev+bounces-225453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE849B93BDD
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCACC19004D6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE814E2F2;
	Tue, 23 Sep 2025 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpeundID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41816522F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588344; cv=none; b=GDE1p2Qe4ulEgCxJv/DN5p208PpYgAZ7P6PieT1BP/dPv49s7ygNhbSm6atiPlfEZksDYMDoy3b+ykIc7gu4pX8kMX/cyVNNFSf8L/TeIsf20AmdTWuL06Hsg1hxMhwfFcDjrZRxqq01C3kCRkuBNu0YSDruI6BJs/sJh5iznp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588344; c=relaxed/simple;
	bh=sYtj2kqF0a48Ceef6YLOLVY3kwatVRZuQc0vCmPOFTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJcbaP4UnUueNSagx2ttJ57M02sZghAG/EABv6z7Sz0ED9mJxHhrnb4apGNOJGnGNFIRyJWothrfwrnOt8iRkfG1vcyTzB1/0wkO6QxWXL0Rzs/zo3BGKewdw3hz1D/1/cuTlEtvpKkF2qzIphwU4s8mP0EC2As005vEn3tFkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpeundID; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so1782498b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758588342; x=1759193142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iKIxEhfG4H1jtdKOP/PdiI2eRiRhSYphoYHFMaUlDc=;
        b=HpeundIDi5xv+DOUQ7wt8ZWDXYKRf6EvT2y94yg8Twwiw8Cwru+ztPDd58+Q4aF1PU
         rlVUcNQsgUFw8nkUaXYDIPlnCY922MHMOwa/ja/3sfyQnqkeQertVT5P9N+gTKpSVc8L
         nuGGnn4a78iOu8lkHK3gCDT9qS3SLHSWcwkeeXtwuzlS9OidGTrWkIP6v1UZw7X+Nh5P
         TZA+QV3uZc8xJ3s0194xkOLd+XT5+Sqs07g3Z9mz9Pu2hYYn8rCyai6XMlK2r1Eitdhi
         st67OSwE+TC4AZDM8N4NoPkfbMYeibavVFMSYpUFvXvi8UfhbwBVP59+mEgVprw96X9C
         sN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588342; x=1759193142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iKIxEhfG4H1jtdKOP/PdiI2eRiRhSYphoYHFMaUlDc=;
        b=HIiNEUioNq2+eURBnkcrpsnM0cHJRjd9G0b4AU2iQd9juB2CEQMiGmS5HCI2Hd9vAy
         EzE7lrGDi5cwHLmCLVE1sKUs9ceMDKfZAoUF5368B5zoUVMWiQ7e7EVpGoRD52zyEYcD
         jcjZtn9m25rUIiRqo4bC8yqvPCr7VbY1BSw3V474aNvzLeWcrfk/AzlfKr1qtduNLJhJ
         F65e4pQR8HJTeG2owksoXdqk4x6/xg/j1oXjjAzfT/UFnL5ARu4H+nRyAS9xK1cdPWRw
         twnPSTMw/+zf/fFp2WdBsJQZOSMUidFBIr1sekIi+KQFHo2/KnwEs2rbBiId3ThW23El
         CvtA==
X-Forwarded-Encrypted: i=1; AJvYcCUYt9tErl3Sjr0p2P8CluUv8neh2UHWFFJG7p3J+/lybHSJbvMI83rKbO0dG0LlkttUlSQea7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWWblqawYxYO/PfGGCOm+9eN6f7nUnn6zScH8itL+dvDsQJ8Q
	kfQmU1p8bz6ieaD6NbItNPXLnhxzHfon65v64KJS/1e506sg6kqlUgPbq6+POWJ/YtB3ZKRerRL
	x1k2eTdnYsle0D0V/bIMhMx5AQbMUXq8e+xR0ZCkg
X-Gm-Gg: ASbGnctwvwMjpfDGeSSm/Z0hu9oUH1QUkHIJtRACz/j5qIB7p2QURQW5sNIDSQ5dQub
	MIm3Kzo/cuJe4N9UzTZINorta5uIdp7Tkp64RGyahbdotELEN1RH2lHfc6nS57scqV33QOV62Vl
	llJ9+6fgyCpefApPPLqn2Ojc2TUN0tyLvaRBpjmG4BxtN1HE1pku0aZCQPJrw8CYU+Z5oB1EsYJ
	1wriCM=
X-Google-Smtp-Source: AGHT+IHNP8i81XTkY0PaZ6SI48opaOPrCGYX3obfqVSSvJwebKpFGCqaKBm1HNBHvvgFK+J5+m0doW2WNfkmbBFPGcQ=
X-Received: by 2002:a05:6a20:7f87:b0:262:c083:bb3a with SMTP id
 adf61e73a8af0-2d001584c04mr1191855637.60.1758588342351; Mon, 22 Sep 2025
 17:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev> <20250920105945.538042-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250920105945.538042-4-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:45:31 -0700
X-Gm-Features: AS18NWDA4ZrWo5ntmwLLA36SFVEDsgnLADUF_QQ_0CjaEKkuAe-YzHHbZcmECEQ
Message-ID: <CAAVpQUDaYX5ZQN+EYL3q4yeu0Ni2cqNODEY--Wb-2+yY650Mbw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:00=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since ehash lookups are lockless, if another CPU is converting sk to tw
> concurrently, fetching the newly inserted tw with tw->tw_refcnt =3D=3D 0 =
cause
> lookup failure.
>
> The call trace map is drawn as follows:
>    CPU 0                                CPU 1
>    -----                                -----
>                                      inet_twsk_hashdance_schedule()
>                                      spin_lock()
>                                      inet_twsk_add_node_rcu(tw, ...)
> __inet_lookup_established()
> (find tw, failure due to tw_refcnt =3D 0)
>                                      __sk_nulls_del_node_init_rcu(sk)
>                                      refcount_set(&tw->tw_refcnt, 3)
>                                      spin_unlock()
>
> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() aft=
er
> setting tw_refcnt, we ensure that tw is either fully initialized or not
> visible to other CPUs, eliminating the race.
>
> It's worth noting that we replace under lock_sock(), so no need to check =
if sk
> is hashed. Thanks to Kuniyuki Iwashima!
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>

This is not needed.  A pure review does not deserve Suggested-by.
This is used when someone suggests changing the core idea of
the patch.


> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  net/ipv4/inet_timewait_sock.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5b5426b8ee92..bb98888584a8 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewai=
t_sock *tw,
>         spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);
>         struct inet_bind_hashbucket *bhead, *bhead2;
>
> -       /* Step 1: Put TW into bind hash. Original socket stays there too=
.
> +       /* Put TW into bind hash. Original socket stays there too.
>            Note, that any socket with inet->num !=3D 0 MUST be bound in
>            binding cache, even if it is closed.
>          */
> @@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>
>         spin_lock(lock);
>
> -       /* Step 2: Hash TW into tcp ehash chain */
> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
> -
> -       /* Step 3: Remove SK from hash chain */
> -       if (__sk_nulls_del_node_init_rcu(sk))
> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> -
> -
>         /* Ensure above writes are committed into memory before updating =
the
>          * refcount.
>          * Provides ordering vs later refcount_inc().
> @@ -162,6 +154,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewai=
t_sock *tw,
>          */
>         refcount_set(&tw->tw_refcnt, 3);

I discussed this series with Eric last week, and he pointed out
(thanks!) that we need to be careful here about memory barrier.

refcount_set() is just WRITE_ONCE() and thus can be reordered,
and twsk could be published with 0 refcnt, resulting in another RST.


>
> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
>         inet_twsk_schedule(tw, timeo);
>
>         spin_unlock(lock);
> --
> 2.25.1
>

