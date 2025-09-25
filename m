Return-Path: <netdev+bounces-226488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0EABA0FEE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5EC1BC6CB9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799483148CD;
	Thu, 25 Sep 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRkjy1NY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFA241663
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824577; cv=none; b=A2E8VEWBSwk/7CFEB9xgqdinlHgKlhrjmRTg6T+XEj7cyYkmOVqAVAzhUkI1AhXK/W3yKDVdvk55zbYQS0ieOgT9+Pl7ZypEKv3q+SgpYKW6VLpaR0TrbIO3eAkSFhQjAvVrnHS0V9GqbFhc/lMDHji3/fkZ/1A4rv6msFIFfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824577; c=relaxed/simple;
	bh=NEMTfHp3pWKxKHKhm3ZKnwtV8Sf1356zJ54+nKQrN54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCG5IMtZdHjwOsS0BmnyKMvP/9Wmw7Hk7WNlc63jO64pzICI3LdND+YDYV+a1djP4MBguzSa2jev0URjCS1+drXfRQ/a8QEocVAViFnGwIv1p1zqfVfnkCcqyFGzSunvuQsyS68ci4YlH2Bz6o+EXMfmlrpxmURbdJN1ZnPytYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRkjy1NY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244580523a0so14412855ad.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758824574; x=1759429374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13KKN1knQpC4Gybm3Q4Xow1MdiTElE8QtuEOW0gc9AY=;
        b=bRkjy1NYXx8Ur4mQ0/fHNK347R1HXQdNeN9uUinzcE6H+39rN8u16MtjHFyhvZ2C1R
         vntIaThQAMfDylZWupcswYs1zPkKaqn8JKCa/bI82KAyT2MtvFZp+QJ/3yXqzFxt0kbN
         wcKEoINA1Jjwc9p9faqM0t5yuoYROKUvkVO0f+0ubyizdvW3BzSYzYJ1jW9mmgysGAXt
         gz5gdrnCjhzSCct7ImQR9nn4Xdzyj/iDOG5Jqynvgoq3fUV9THZoidbI4Fh5MAmEANkx
         rbSj/nRSnKo8dMFVu5+QMEnCsk0y0AyJl1I/jRa1YWQ0GcVgQaNIA2a1J3csJv8wmi94
         0XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824574; x=1759429374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13KKN1knQpC4Gybm3Q4Xow1MdiTElE8QtuEOW0gc9AY=;
        b=h8mRjXnS8G0Xuz1khVSV3kCARv2ZaMp6K2PEqI5Fw8X2O23LH03dSYAdf38jp4maQk
         w2UFwMvHF3fH+GiL+U10VM7h8oEXDGdTGC/szKHrSRVuDZQoBmIcYie2nCd6oOWmJFR7
         muLUeyvc18Xc4sA2OzXL4W88K8VIo5d6nYfBGsgnDnDshcRlJUDAWskFkjcchaPdhiNS
         gcqIhuQIXxylXaZeS3zmij3aLiPUF2qBePhpMs1ko3WPoC2WsVVSSvz0upA0+n5Oub4N
         EPQoOF6QIZuwmyB751MSZOvlE10ckdn/GUv+V+vHKjrt4UGV4Ichk54ct4EGu6FBkg+O
         tUJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCu8PRIRhMxHVVvbPIzn9YgLQTesBP2YFhr5aUMt4o5d5kyLb7NRafNMQXQeEgw5DkmRxW+3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYrA+LzEQYlVU4pZHT+kHRbq+4G6DplmKeZq+40qTKVc+bElZ
	OlNLOtns7UqiV3suSaGpW8yvmXEh9PJ5nujajwp/MLhFgCmOwRumW3rGjbRCNHcaVqnriFEhSYI
	MeppiOXLor3voZ8zaMv01tAIt8Y45eWi7Gl4nUVjvLfCoysqVNajs1TMByWw=
X-Gm-Gg: ASbGncujwl3Tn8CJ9eCsDTaUfFNR7kN0IIFhVmWsdoZ5ZcvdUC4YYb569fYlwFYOC2y
	myNfe3E8yzXMUXEz+4PU8svsYAOC91pJOGGxW6cukzItFRoi/waRuIyvCOUQUIHg0T41w7mi4Hu
	JyNQLwbzxWltvFMaOXhMWBFYiUskfV1MYpy48MufhixXa+3AiqJBJv9A3a3O75sAJub586DQZSv
	N6Jm1eazl1t6WmpAv5swWzd2iNbm3SsQBM/CCpEPlWfdDM=
X-Google-Smtp-Source: AGHT+IEJwdNkNxqceB+eVbkTfty5OiXFLJf8G8aPK9wHvY0OgFmrFmEfXHwhZBVca3sWdTwRhDxJNBfb928Ozf9iorI=
X-Received: by 2002:a17:903:b10:b0:262:d081:96c with SMTP id
 d9443c01a7336-27ed49d2c1dmr53284255ad.17.1758824573908; Thu, 25 Sep 2025
 11:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev> <20250925021628.886203-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250925021628.886203-4-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:22:42 -0700
X-Gm-Features: AS18NWCmv-pBsDSh5xzbB72op49jcv70NYsSgQuRpgGCiROLR82HfSXIYuj8wvw
Message-ID: <CAAVpQUD7-6hgCSvhP3KL+thgxcyWAJQanfPHS+BQ5LDfrY9-bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:18=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
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
> It's worth noting that we held lock_sock() before the replacement, so
> there's no need to check if sk is hashed. Thanks to Kuniyuki Iwashima!
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  net/ipv4/inet_timewait_sock.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5b5426b8ee92..89dc0a5d7248 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -87,12 +87,6 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
>  }
>  EXPORT_SYMBOL_GPL(inet_twsk_put);
>
> -static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
> -                                  struct hlist_nulls_head *list)
> -{
> -       hlist_nulls_add_head_rcu(&tw->tw_node, list);
> -}
> -
>  static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
>  {
>         __inet_twsk_schedule(tw, timeo, false);
> @@ -112,11 +106,10 @@ void inet_twsk_hashdance_schedule(struct inet_timew=
ait_sock *tw,
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -       struct inet_ehash_bucket *ehead =3D inet_ehash_bucket(hashinfo, s=
k->sk_hash);
>         spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);
>         struct inet_bind_hashbucket *bhead, *bhead2;
>
> -       /* Step 1: Put TW into bind hash. Original socket stays there too=
.
> +       /* Put TW into bind hash. Original socket stays there too.
>            Note, that any socket with inet->num !=3D 0 MUST be bound in
>            binding cache, even if it is closed.

While at it, could you update the comment style at these 2 line above too ?

/* Put ..
 * Note, ...
 * binding ...
 */

Otherwise looks good, thanks.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>




>          */
> @@ -140,19 +133,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
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
> -       /* Ensure above writes are committed into memory before updating =
the
> -        * refcount.
> -        * Provides ordering vs later refcount_inc().
> -        */
> -       smp_wmb();
>         /* tw_refcnt is set to 3 because we have :
>          * - one reference for bhash chain.
>          * - one reference for ehash chain.
> @@ -162,6 +142,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>          */
>         refcount_set(&tw->tw_refcnt, 3);
>
> +       /* Ensure tw_refcnt has been set before tw is published.
> +        * smp_wmb() provides the necessary memory barrier to enforce thi=
s
> +        * ordering.
> +        */
> +       smp_wmb();
> +
> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
>         inet_twsk_schedule(tw, timeo);
>
>         spin_unlock(lock);
> --
> 2.25.1
>

