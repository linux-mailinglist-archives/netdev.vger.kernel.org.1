Return-Path: <netdev+bounces-223256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E84B58840
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3401358290F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C22DCF72;
	Mon, 15 Sep 2025 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWtZESs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABC29BDA7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978760; cv=none; b=B9ph4dvMRLBOg4WqOFWSLP7QS65HI30wWxgqrfxLvdwulikuRd9cUqcbvm5VK4mdd51d+tNVkU0I/cbNoZLo1MRVNGuMt3p/Yr7Xf/BY1DMNenRWoMhy+i9Q8tfcXHwn5N/y53flt/y6Cjt19xKecwAMkEsaelDNmbRRRinj47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978760; c=relaxed/simple;
	bh=fFUO1aL/drGItHDAZqlvwKA+82pDKtim/dNcPKZvqy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSge4WIbZFfBhKmWtA9c+xbbAqkpPtxmTuMZcM00n2upOlJys9Jkzv3EmEAksqHjF90r1h3flBl4Bd0swO1bsE1ALeEChyPHSm0kbpQxYMJM+kz8p+sQ1XG+MtN9WNCf3bcWERF00c3koJUTDzydZqgqXsiGqKLFiW5kDEpitWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWtZESs1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26488308cf5so14404495ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757978758; x=1758583558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCzduuDvtopMg6t6sGQt66qxBdWgrv0ypssHuO+zarc=;
        b=wWtZESs17XnBWeGfaF/NKNLcWN6HX6pQWn2zvagOTHM5ajTIILDbozPikWl2sCGOH9
         OlX0XmBQWCZPQkXaYdOQv56WFa6zw4GG2mlmrFL9+NQnE94DZxtKxD3ttK+HF5sv2/Iv
         Pg55yEbLYoGYUbzLRNrzlj/ZE5N//q8oBNg1w/BZbX+rYUnGtsjbCGgr7zCzdoRp1/Nf
         ZzPO0Y/1jZ9ZgtHw/2VekTzgAO+Q8Kgqh4jBOZdvALI+FQZ20ROl7VrfTKEJ60TussD+
         TOR09ewfByMIwo91Bh0LP6MUHRiXmhqlbUKpx6NCxdBi/n9FdPTu0NCJdrKEJehPdfFV
         tZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757978758; x=1758583558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCzduuDvtopMg6t6sGQt66qxBdWgrv0ypssHuO+zarc=;
        b=bSwyQht6qDnD8g2H7B1iRrq8gJMTeWZMiPWUfsK292EW5+v50GksfFtzEn7lBS99AQ
         DqCyWBSs0aFq3btKbwuXr0bVtXG1s1tTZs/Mcdj+YaW3q68IsAbhoQufCNr8zbz9i8RX
         no7kWHSfoWX8OyCBEPwsoheDYoGK6wFE8YfGO7imIi8JKk1IucqherY9UW79WelhLwBf
         v1w8R+aIMjRjuufagWUf9gBX6T9RXvPoBgNETufoBlGO6YucsTt4s3NwkLT+moN69wro
         cXwvS9sAiNBsl4rv3Yi86EsMWrcONpM3Gf4GneTbAYFzfdJ9bTU++sZjynD87yP3MVNF
         CFDw==
X-Forwarded-Encrypted: i=1; AJvYcCXeFh8b6drO8+Y24nSHIxNADxnOwy3Fd7pjrvWF2emPZ+eVzyQKzpKo5qsB3s7L8jEhuBX1q54=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJ/TbR4SDqnT1QTY8HgfdpK4aCtE4rlxURKq29QUawg9vwSX2
	NdldCk/KrIQ4o3g8PMAYFV4nuki0GzbTQUuJ33JWBNVXdCSeNSyAsLTPfKN1w73Q+1Yup9fXwNp
	fmSYH0M6WkWxMYVTHw6DEvHIPB/6hm/ss+PkCodcO
X-Gm-Gg: ASbGnctrKLZ4C7DZdgl4EVzBn1e13Pi+bRqghaDTi2XbxbulQQU4V7GwdfN6Zftgsg/
	2x0UiJzpbgIdq0+4Am1PwJys/ovINs/bQPu2g3py1BrwfrZJVUrD6fJdLebELaRqqe4zxIZ7DfQ
	u4mpgTUnNkXFkW3gCX8xoNC3HjD+tSsbxfRXyP3VpV09F6MJg5Mj2c4am5/SFyVUbxoKe7JomSQ
	9Rq5poycpJdcRTHps0+90/har3RICGFTMunjJX7xsY4
X-Google-Smtp-Source: AGHT+IEUc9mDdinpsmhP+UsWC+/avjrX96+NVGLhQ3rUSLJ/LDR00OXJoYhHMl83AR2C9qtujlCXcrqenboX2o+3o18=
X-Received: by 2002:a17:903:2f87:b0:267:b6f9:2cd with SMTP id
 d9443c01a7336-267b6f9075cmr28195515ad.46.1757978757740; Mon, 15 Sep 2025
 16:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev> <20250915070308.111816-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250915070308.111816-4-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 16:25:45 -0700
X-Gm-Features: Ac12FXyCP8o7FqnnvHLey_4eJ_CG2zYO6WK0ogINPYdxdqH76mB2hJmmks5Cr90
Message-ID: <CAAVpQUDJU7arjM_7LjrLY-5tNZ0Ch_ZPXCvmmaVD+rBb3LvxHw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:04=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
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
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  net/ipv4/inet_timewait_sock.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5b5426b8ee92..4c84a020315d 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -115,8 +115,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewai=
t_sock *tw,
>         struct inet_ehash_bucket *ehead =3D inet_ehash_bucket(hashinfo, s=
k->sk_hash);
>         spinlock_t *lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);
>         struct inet_bind_hashbucket *bhead, *bhead2;
> +       bool ret =3D false;
>
> -       /* Step 1: Put TW into bind hash. Original socket stays there too=
.
> +       /* Put TW into bind hash. Original socket stays there too.
>            Note, that any socket with inet->num !=3D 0 MUST be bound in
>            binding cache, even if it is closed.
>          */
> @@ -140,14 +141,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
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
> @@ -162,6 +155,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>          */
>         refcount_set(&tw->tw_refcnt, 3);
>
> +       if (sk_hashed(sk)) {

Is this check necessary ?

I think tcp_time_wait() is called under bh_lock_sock() and there
will be no racing thread unlike reqsk vs full sk for 3WHS.

I guess the existing code checks the retval of
__sk_nulls_del_node_init_rcu() just in case.


> +               ret =3D hlist_nulls_replace_init_rcu(&sk->sk_nulls_node,
> +                                                  &tw->tw_node);
> +               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +       }
> +
> +       if (!ret)
> +               inet_twsk_add_node_rcu(tw, &ehead->chain);
> +
>         inet_twsk_schedule(tw, timeo);
>
>         spin_unlock(lock);
> --
> 2.27.0
>

