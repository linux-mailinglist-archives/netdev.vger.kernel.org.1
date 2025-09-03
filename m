Return-Path: <netdev+bounces-219428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D4B41438
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A191B26DA3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337726C3BE;
	Wed,  3 Sep 2025 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+Wzu42a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE447C2D1
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876596; cv=none; b=MIgX3T5+Qa0lVs4QyCNsfbHqocVeXSwHn11/tCDFpIojrZP3521HSBXxX8XEPUloYxYZ5akCbFuUwlMpwof2tvRw+SPNnN8NT/RfmWEDxcmljhA1vTx7SMoOzx3U6Shsf0VkHQ3Iyxhi2Yx5gsbbsdegpasexpMf83v7xnSFxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876596; c=relaxed/simple;
	bh=JM5lH8xOqN54oX2aKOaHkQ4+vlqZsma2v/a4OeLu1QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX4KgZ1fSKDMxUuYpiDphfBSXsCxwnWdwDWTL57E1vqurKVtUZG9w/UTmkNZFEYP5FaNGCHB9dUsO7DvHQQy//KCIxz6sSmPvRbgUMQPGu4aDsWwHHTVD1vKQXgXBJ6BUscS/qx8PKXXMgT0Uhm5ZgWLJOxl7NGmEYh82XABliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+Wzu42a; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4717543ed9so3898048a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 22:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756876594; x=1757481394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROov4QqfxUS+UxHRXuH01d0qfAyniJ0CqHCX/doKU/I=;
        b=m+Wzu42abTdQdnxPKMLInEQ5ZP5XBXYNsiZoNzrNNXxRVccLK3WJb0UVjdKHLgJwjY
         kL8WmaCMNusJPUcaKCuabPrF1YHo7YtErIzs1QB4VjzIyRaLIzmL3sGrYsU5X6K9852y
         Y8NVBdXLnkykATL5yD+M5Lf6rNDUYbMS5SXZuQC0PlFTtEZJVAXqzYnyc5UkySgIBSer
         xA0nWPts1r6NmUkibha8tScdd+u3MuEZ5ViTx7hCtmBw+uCFZTy1zsbMYqQsekpMEegF
         6OiUZztvRty0ze5QF9tLzTQ1NfJ4Pb1smeudd5h0OMwTW0zpJs8K86NpdbMK0oHdLoVN
         kk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756876594; x=1757481394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROov4QqfxUS+UxHRXuH01d0qfAyniJ0CqHCX/doKU/I=;
        b=qYcZ5M/cMUw1YhAMzinuOPx14kvscV5Ax8E1SyNowibEKeu137Rs1NTOrye6AN0kg1
         //bqkDQWSzN6/hGHySm6c1JwBhRdOC2N9kyWGfJUe7vOOPc3y6ADCuxqvEYo+LOFi7NC
         4ffRmbEOI4u5TYWb6Am4ljXCAUDTwZjnTOU7eC90HOtvJmA0KaAWL+Le5b6SnRibiCRp
         jVHiS4AdcpEXYJ/ArnYE6G2rMWatlMt1sTPa2qroSo7wTW2Rt/X+2GOomp1r3L91q1gd
         HGhHo/xg33p2/ordfo5SyhIxAtry8F43DTcfZ0ekTX6a1WXxSbnhFyfb6c/F5hODuFNm
         bk9A==
X-Forwarded-Encrypted: i=1; AJvYcCUntDcCfu7/y6I9mFCSEV0BJ3bYdxazLdEIOHpUADL342OJ9ISZn9FGtd+Q3LHV9OV/cDGS4uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFQ6PS+9/WW0/tsn0RAAi3rOKDgbg+kXGSnzE5brJSDFP1ud1
	0V/u9gLHSYQJiffzN3d2EZ2Lx+6dxQqnQJpA7lXQ2TLeDMI0ayU4qfN6Mep/TDQOrQo0p70PUGK
	29JR+PBPYbYhO5V4J4kTmQzH/dnCLeXdbQ1q+nNt5
X-Gm-Gg: ASbGncuHrPsOijUWHYqLsqTDkhEoZNay8CDvCF6BMOizi1Is+QuhdNXneCGjTe9o3w6
	PnIo2ssSJee+YSx72BxY5TNDbp2VzE/a8GKp/DRflmkaHioJAhoy4Zf+05PpL6d4nQZfBDhBfxZ
	qfMEYLVmHkI/3z3Ln+NSz+6S5m4kC4oP2PL0mhx2ajSr2yOJbleTRkZ2d3J1CRwo6p2+/uJNy00
	dSmXpVjj1TO9QrUCbMkaiYKGRKmhn+8P/Gs1QJAx8RWSs419WKtUl/gvvC2bXDrJxaKuIjyOWCe
	5IENupTOdYLp5eruvH1Va08=
X-Google-Smtp-Source: AGHT+IEP8Ql0u90PH9jvasFksPbc2C0UpF/YCVxwCNlZAcl8OyGd6SZ2/YHCMkJlLlfBkgmdXVlWK7x0ClDjG3QcR2g=
X-Received: by 2002:a17:903:1211:b0:246:c421:6303 with SMTP id
 d9443c01a7336-24944ae7fefmr192886015ad.46.1756876593919; Tue, 02 Sep 2025
 22:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 22:16:22 -0700
X-Gm-Features: Ac12FXxQPj_XWYEbXOwnx5-fbsxNpQvsZ1MlcGD0to0ifHMVO2ne37rsQ3FiJyg
Message-ID: <CAAVpQUCKDi0aZcraeZaMY4ebuoBoB_Ymdy1RGb1247JznArTJg@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:45=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@linux.d=
ev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since the lookup of sk in ehash is lockless, when one CPU is performing a
> lookup while another CPU is executing delete and insert operations
> (deleting reqsk and inserting sk), the lookup CPU may miss either of
> them, if sk cannot be found, an RST may be sent.
>
> The call trace map is drawn as follows:
>    CPU 0                           CPU 1
>    -----                           -----
>                                 spin_lock()
>                                 sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>                                 __sk_nulls_add_node_rcu(sk, list)
>                                 spin_unlock()

This usually does not happen except for local communication, and
retrying on the client side is much better than penalising all lookups
for SYN.

>
> We can try using spin_lock()/spin_unlock() to wait for ehash updates
> (ensuring all deletions and insertions are completed) after a failed
> lookup in ehash, then lookup sk again after the update. Since the sk
> expected to be found is unlikely to encounter the aforementioned scenario
> multiple times consecutively, we only need one update.
>
> Similarly, an issue occurs in tw hashdance. Try adjusting the order in
> which it operates on ehash: remove sk first, then add tw. If sk is missed
> during lookup, it will likewise wait for the update to find tw, without
> worrying about the skc_refcnt issue that would arise if tw were found
> first.
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  net/ipv4/inet_hashtables.c    | 12 ++++++++++++
>  net/ipv4/inet_timewait_sock.c |  9 ++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..4eb3a55b855b 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -505,6 +505,7 @@ struct sock *__inet_lookup_established(const struct n=
et *net,
>         unsigned int hash =3D inet_ehashfn(net, daddr, hnum, saddr, sport=
);
>         unsigned int slot =3D hash & hashinfo->ehash_mask;
>         struct inet_ehash_bucket *head =3D &hashinfo->ehash[slot];
> +       bool try_lock =3D true;
>
>  begin:
>         sk_nulls_for_each_rcu(sk, node, &head->chain) {
> @@ -528,6 +529,17 @@ struct sock *__inet_lookup_established(const struct =
net *net,
>          */
>         if (get_nulls_value(node) !=3D slot)
>                 goto begin;
> +
> +       if (try_lock) {
> +               spinlock_t *lock =3D inet_ehash_lockp(hashinfo, hash);
> +
> +               try_lock =3D false;
> +               spin_lock(lock);
> +               /* Ensure ehash ops under spinlock complete. */
> +               spin_unlock(lock);
> +               goto begin;
> +       }
> +
>  out:
>         sk =3D NULL;
>  found:
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 875ff923a8ed..a91e02e19c53 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -139,14 +139,10 @@ void inet_twsk_hashdance_schedule(struct inet_timew=
ait_sock *tw,
>
>         spin_lock(lock);
>
> -       /* Step 2: Hash TW into tcp ehash chain */
> -       inet_twsk_add_node_rcu(tw, &ehead->chain);

You are adding a new RST scenario where the corresponding
socket is not found and a listener or no socket is found.

The try_lock part is not guaranteed to happen after twsk
insertion below.


> -
> -       /* Step 3: Remove SK from hash chain */
> +       /* Step 2: Remove SK from hash chain */
>         if (__sk_nulls_del_node_init_rcu(sk))
>                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>
> -
>         /* Ensure above writes are committed into memory before updating =
the
>          * refcount.
>          * Provides ordering vs later refcount_inc().
> @@ -161,6 +157,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewai=
t_sock *tw,
>          */
>         refcount_set(&tw->tw_refcnt, 3);
>
> +       /* Step 3: Hash TW into tcp ehash chain */
> +       inet_twsk_add_node_rcu(tw, &ehead->chain);
> +
>         inet_twsk_schedule(tw, timeo);
>
>         spin_unlock(lock);
> --
> 2.25.1
>

