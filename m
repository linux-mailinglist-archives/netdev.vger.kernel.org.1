Return-Path: <netdev+bounces-100165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E08D8001
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ABE1F24EB2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836CC5821A;
	Mon,  3 Jun 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVbNOHZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAB82C6B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410653; cv=none; b=pILaKrJgMD+XRPZK8u6sW1Vm5xptEVye4OQFhaDN+y2o3/LrPGnCyVR9H4r8sVPnccP/Bqng91ANUCLO3QZi7/9BouSUxMVV3C/ML+HAjZXW/hPO5l2oH4Oj3iVhKAQ+pXEZB1jedJdo8dLjeWyQY1glc0KqHebNSjRNSUdYY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410653; c=relaxed/simple;
	bh=cFEZnWSO2Gf+oU70DTJblljvwFFV2MOSUF8sN3AeqjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZQwadz9l/GATKSWGErdQpekddZd5ICytRj4KmoHprlF0V9wqwh+oMhXNbVpPVZPLf1TYNc3YO8HZixiivhfe2yb5+Su1Mc9zIU0obKqQEjstsRPX2OZlBIfiePyOMYMEonlRvZdebW4YcufgwoLP0gQxR5BuaUJENJsCreKEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVbNOHZU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so17006a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717410650; x=1718015450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N29nT3PkJ/n7aIRWp2LYKmj1GT70goIWbtopauUn6OU=;
        b=OVbNOHZUySwwATNwDKjKMsOxUzs/sWh/dE5NOs0dcFGiY8YtSTujnJw3EZih6Rz5wK
         IxFkz/U/f2e0Iiu53xjkVLFGqw4kxYVIyRFEZPCdWAuLmCvBGVyTQP14jtkmbSwijUp7
         5WlLnHv7QuRnbUecdAunxPuTeX3xGxwJReXzk+aUiXlgSLhoDHzMSEs308M77hIKqAl6
         pOBja5NeAy7iSqd7g3z9+lBh8xhULuQ4igolkCOtjYkvd/+Ei1SWbWRVOJR4E9o5yTeq
         tDAJ1UDPqjCBC6O/E2TeN9BM7Nz3I8hF4P+vJrwr0f8SxM5BdH2iAhLzR/HI3haby83O
         eMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717410650; x=1718015450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N29nT3PkJ/n7aIRWp2LYKmj1GT70goIWbtopauUn6OU=;
        b=dpR2V6IfIWVZk25l4OZnwDNRRbDZHg/yKMFnwwTgGFl4equsDiDA92cTyao38dthv8
         EmTj4C1Fy3enDkHOk27mMtW4ZF72vOhHwF8zE50XLxR4Fs7hc3jTpDiBOOakP9pKnN1T
         tCWZ/soXMWly/JKp1MKcJ1jVxi05Bxm1GRpzJHtXiBG3VKe9qbHI1YgLQT7BdQLZ6DXi
         JZtxKSp+CVjOjVvmcw7Y91PK6xOIm9g6UnybPldJ6WTjs+ICxCZB9raaBC/9aAdSFpaG
         mNdKFtPGG6tGbrdGju+V77U/ja4J67LK02BUdnaYg0cvht1f0xVVFRr3Nnupna5JHo6R
         +nAA==
X-Gm-Message-State: AOJu0Yxlstwy3BLY2FCLmTedqdZghIjQdoI3Ee28YvjUVpVmZIzPo1jx
	8ExMBL27/8FDPgn+cV3rnnuvDi7xjCV4QZmyojx3d80t5Jpo6wS8b5Qo/TD7HHyEATKyJ3FHJPc
	8F8kBkApJJnjpCYKW2IueODjYGrCQrNRy2KMDC6W542IaWQzuCrTD
X-Google-Smtp-Source: AGHT+IGmQS0NJL+iOqFLzoeBvidn8IlDsriKPk4prG/51Uel0YBN+2ZWsyu+3GNyit373oQ6MQsyHTVJscuynM+1U/Y=
X-Received: by 2002:aa7:da8e:0:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a495cca66mr235434a12.3.1717410649196; Mon, 03 Jun 2024
 03:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603093625.4055-1-fw@strlen.de> <20240603093625.4055-2-fw@strlen.de>
In-Reply-To: <20240603093625.4055-2-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 12:30:35 +0200
Message-ID: <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer un-pinning
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com, 
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com, 
	dsahern@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:37=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> From: Valentin Schneider <vschneid@redhat.com>
>
> The TCP timewait timer is proving to be problematic for setups where
> scheduler CPU isolation is achieved at runtime via cpusets (as opposed to
> statically via isolcpus=3Ddomains).
>
> What happens there is a CPU goes through tcp_time_wait(), arming the
> time_wait timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer
> fires, causing interference for the now-isolated CPU. This is conceptuall=
y
> similar to the issue described in commit e02b93124855 ("workqueue: Unbind
> kworkers before sending them to exit()")
>
> Move inet_twsk_schedule() to within inet_twsk_hashdance(), with the ehash
> lock held. Expand the lock's critical section from inet_twsk_kill() to
> inet_twsk_deschedule_put(), serializing the scheduling vs descheduling of
> the timer. IOW, this prevents the following race:
>
>                              tcp_time_wait()
>                                inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     del_timer_sync()
>                                inet_twsk_schedule()
>
> Thanks to Paolo Abeni for suggesting to leverage the ehash lock.
>
> This also restores a comment from commit ec94c2696f0b ("tcp/dccp: avoid
> one atomic operation for timewait hashdance") as inet_twsk_hashdance() ha=
d
> a "Step 1" and "Step 3" comment, but the "Step 2" had gone missing.
>
> inet_twsk_deschedule_put() now acquires the ehash spinlock to synchronize
> vs. reschedule and timer firing: timer_del_sync() is replaced with
> timer_shutdown().
>
> This means that tw_timer may still be running on another CPU.  However, a=
s
> the timer owns a reference on tw sk that is only put at the end this
> should be fine.
>
> To ease possible regression search, actual un-pin is done in next patch.
>
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/net/inet_timewait_sock.h |  6 ++-
>  net/dccp/minisocks.c             |  3 +-
>  net/ipv4/inet_timewait_sock.c    | 74 ++++++++++++++++++++++++++------
>  net/ipv4/tcp_minisocks.c         |  3 +-
>  4 files changed, 68 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait=
_sock.h
> index 2a536eea9424..5b43d220243d 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struc=
t sock *sk,
>                                            struct inet_timewait_death_row=
 *dr,
>                                            const int state);
>
> -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
> -                        struct inet_hashinfo *hashinfo);
> +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> +                                 struct sock *sk,
> +                                 struct inet_hashinfo *hashinfo,
> +                                 int timeo);
>
>  void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
>                           bool rearm);
> diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> index 251a57cf5822..deb52d7d31b4 100644
> --- a/net/dccp/minisocks.c
> +++ b/net/dccp/minisocks.c
> @@ -59,11 +59,10 @@ void dccp_time_wait(struct sock *sk, int state, int t=
imeo)
>                  * we complete the initialization.
>                  */
>                 local_bh_disable();
> -               inet_twsk_schedule(tw, timeo);
>                 /* Linkage updates.
>                  * Note that access to tw after this point is illegal.
>                  */
> -               inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> +               inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, time=
o);
>                 local_bh_enable();
>         } else {
>                 /* Sorry, if we're out of memory, just CLOSE this
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index e28075f0006e..2b1d836df64e 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -44,14 +44,14 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock =
*tw,
>         __sock_put((struct sock *)tw);
>  }
>
> -/* Must be called with locally disabled BHs. */
> -static void inet_twsk_kill(struct inet_timewait_sock *tw)
> +static void __inet_twsk_kill(struct inet_timewait_sock *tw, spinlock_t *=
lock)
> +__releases(lock)
>  {
>         struct inet_hashinfo *hashinfo =3D tw->tw_dr->hashinfo;
> -       spinlock_t *lock =3D inet_ehash_lockp(hashinfo, tw->tw_hash);
>         struct inet_bind_hashbucket *bhead, *bhead2;
>
> -       spin_lock(lock);
> +       lockdep_assert_held(lock);
> +
>         sk_nulls_del_node_init_rcu((struct sock *)tw);
>         spin_unlock(lock);
>
> @@ -71,6 +71,16 @@ static void inet_twsk_kill(struct inet_timewait_sock *=
tw)
>         inet_twsk_put(tw);
>  }
>
> +/* Must be called with locally disabled BHs. */
> +static void inet_twsk_kill(struct inet_timewait_sock *tw)
> +{
> +       struct inet_hashinfo *hashinfo =3D tw->tw_dr->hashinfo;
> +       spinlock_t *lock =3D inet_ehash_lockp(hashinfo, tw->tw_hash);
> +
> +       spin_lock(lock);
> +       __inet_twsk_kill(tw, lock);
> +}
> +
>  void inet_twsk_free(struct inet_timewait_sock *tw)
>  {
>         struct module *owner =3D tw->tw_prot->owner;
> @@ -96,9 +106,13 @@ static void inet_twsk_add_node_rcu(struct inet_timewa=
it_sock *tw,
>   * Enter the time wait state. This is called with locally disabled BH.
>   * Essentially we whip up a timewait bucket, copy the relevant info into=
 it
>   * from the SK, and mess with hash chains and list linkage.
> + *
> + * The caller must not access @tw anymore after this function returns.
>   */
> -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
> -                          struct inet_hashinfo *hashinfo)
> +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> +                                 struct sock *sk,
> +                                 struct inet_hashinfo *hashinfo,
> +                                 int timeo)
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> @@ -129,26 +143,33 @@ void inet_twsk_hashdance(struct inet_timewait_sock =
*tw, struct sock *sk,
>
>         spin_lock(lock);
>
> +       /* Step 2: Hash TW into tcp ehash chain */
>         inet_twsk_add_node_rcu(tw, &ehead->chain);
>
>         /* Step 3: Remove SK from hash chain */
>         if (__sk_nulls_del_node_init_rcu(sk))
>                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>
> -       spin_unlock(lock);
>
> +       /* Ensure above writes are committed into memory before updating =
the
> +        * refcount.
> +        * Provides ordering vs later refcount_inc().
> +        */
> +       smp_wmb();
>         /* tw_refcnt is set to 3 because we have :
>          * - one reference for bhash chain.
>          * - one reference for ehash chain.
>          * - one reference for timer.
> -        * We can use atomic_set() because prior spin_lock()/spin_unlock(=
)
> -        * committed into memory all tw fields.
>          * Also note that after this point, we lost our implicit referenc=
e
>          * so we are not allowed to use tw anymore.
>          */
>         refcount_set(&tw->tw_refcnt, 3);
> +
> +       inet_twsk_schedule(tw, timeo);
> +
> +       spin_unlock(lock);
>  }
> -EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
> +EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
>
>  static void tw_timer_handler(struct timer_list *t)
>  {
> @@ -217,8 +238,37 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
>   */
>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>  {
> -       if (del_timer_sync(&tw->tw_timer))
> -               inet_twsk_kill(tw);
> +       struct inet_hashinfo *hashinfo =3D tw->tw_dr->hashinfo;
> +       spinlock_t *lock =3D inet_ehash_lockp(hashinfo, tw->tw_hash);
> +
> +       /* inet_twsk_purge() walks over all sockets, including tw ones,
> +        * and removes them via inet_twsk_deschedule_put() after a
> +        * refcount_inc_not_zero().
> +        *
> +        * inet_twsk_hashdance_schedule() must (re)init the refcount befo=
re
> +        * arming the timer, i.e. inet_twsk_purge can obtain a reference =
to
> +        * a twsk that did not yet schedule the timer.
> +        *
> +        * The ehash lock synchronizes these two:
> +        * After acquiring the lock, the timer is always scheduled (else
> +        * timer_shutdown returns false).
> +        *
> +        * With plain timer_shutdown_sync() and without grabbing the ehas=
h
> +        * lock, we can get:
> +        * 1) cpu x sets twsk refcount to 3
> +        * 2) cpu y bumps refcount to 4
> +        * 3) cpu y calls inet_twsk_deschedule_put() and shuts timer down
> +        * 4) cpu x tries to start timer, but mod_timer is a noop post-sh=
utdown
> +        * -> timer refcount is never decremented.
> +        */
> +       spin_lock(lock);
> +       if (timer_shutdown(&tw->tw_timer)) {
> +               /* releases @lock */
> +               __inet_twsk_kill(tw, lock);
> +       } else {

If we do not have a sync variant here, I think that inet_twsk_purge()
could return while ongoing timers are alive.

tcp_sk_exit_batch() would then possibly hit :

WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

The alive timer are releasing tw->tw_dr->tw_refcount at the end of
inet_twsk_kill()

Presumably, adding some udelay(200) in inet_twsk_kill() could help a
syzkaller instance to trigger a bug.

> +               spin_unlock(lock);
> +       }
> +
>         inet_twsk_put(tw);
>  }
>  EXPORT_SYMBOL(inet_twsk_deschedule_put);
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 538c06f95918..47de6f3efc85 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -344,11 +344,10 @@ void tcp_time_wait(struct sock *sk, int state, int =
timeo)
>                  * we complete the initialization.
>                  */
>                 local_bh_disable();
> -               inet_twsk_schedule(tw, timeo);
>                 /* Linkage updates.
>                  * Note that access to tw after this point is illegal.
>                  */
> -               inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashi=
nfo);
> +               inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_=
row.hashinfo, timeo);
>                 local_bh_enable();
>         } else {
>                 /* Sorry, if we're out of memory, just CLOSE this
> --
> 2.44.2
>

