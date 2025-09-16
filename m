Return-Path: <netdev+bounces-223707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8ECB5A19A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2294E161B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD927978C;
	Tue, 16 Sep 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFOpTt3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FD32D5C1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052117; cv=none; b=iWF8jFxvm/Fpfda8h6Me8veQ9v4jjCbCpiW1/hdZJ0mkXPHruM7xyv7I8mbC5l3vnEyNOd8b49JNbL2JKkdccKRbUrRy4aARIDMsxw3PCUBD/wcA1YFIIHFdNheTG+GYvsOjlmt3YiVWF6fW9zSPO5d3AFJS4Oo0fjpRAfKynDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052117; c=relaxed/simple;
	bh=LAHilFcFBxLiTfMMh7MZPh+Fg263nhuTfJTd4yEuND4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxCWtw/0St01qTBP9CBPisMyHoGTFcfexDNCbQFazJuw0eR0xkkEbAiCRZHcfKJtWcaTvrZ0rjtGHj+6yabsacg2OvilAY4IdMyPS2bIfilUQtpjcTxkerKA2Vd6U44z40upW+BlTj+TxZCUUNbchT1fU/nmcVoLcIXdDTIrZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFOpTt3f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-25669596955so60653095ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758052115; x=1758656915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlpJX45tzbTkdRIVsxKB67gq42MOYsqwpfwFAnbHXj8=;
        b=pFOpTt3fRSea/5rELqxTmcMmJLSiqCC5GeMHhaTtAjAy0fPHbZX7fwwO9QniOPLOHe
         iLnQbEpCSPv5inZ8ONZqF3g+HalsZ0u08iOkkP5X60IBa9LK6Fw545L70HUiIrMkv/mO
         B896hVD3vyvZQqrWAFVDQhtozM5BCToj82GsEuZh6L2T3U5ZLyWcox1VeD1f6raNPLwi
         0bv7DjCWxUjBwKq2HrG1MZq/KZcHKnMeJxMF3GOEIPUTEoaIuQ2yLEP7VV6vzPdS+JGk
         F2RfzbdNg0kW66LRZTie9Lq60oZr/vP+N5tUi0HW0KBZKKt7LuRk7bOsWee2JD9Eu7YF
         Qccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052115; x=1758656915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlpJX45tzbTkdRIVsxKB67gq42MOYsqwpfwFAnbHXj8=;
        b=Bksx+CVo9+M7mbq3n3ctd+0x9NuLzQg+lnPKpIJWd4+3yWp7A6WqO50YIDBpPdIvKi
         Vk2jFZOMwYicSU46DJh7jmVoIC3CdnWWedd3EdpSpTdTx3WiyFP9uiTl2DT+FvMOdJp4
         iTDqqAkn39iWSe6PupsiQUbNg68nqqSUnd3AbiR+ccCGKbquOyF/6AGih4kByfxko1/d
         dqhqR4+zZX2oaQieTsWuf1ZBzsf743YGhwKEZ7EW16YyvGG8ae2eiG9njqfapbXvtF4U
         ptjTa+ka/kUYbC9cWY3keo4DM64cL/S+efxMWAbE49eBbQCRtlreAsN0jkfrKm9A1VZx
         0jjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV/sVlsIHWxTagw85vE4vJHdT4O5LhPRx5iQWwI/pgLTJ5p8KDutdpV7xyCixC4IUOYA6qr9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkEXM9s9I3RUnR6itUmG+/1fLZfbALIkdwD+Ar0e3uaqImK2I
	xr5RDyOLR3mdFuJUyx+4pSwf+i/YXV4fWFqauICvqDIMmQkxUSQBpN7wejXe6Xh5Isr1JyAIUtd
	5XkFF01kUmv8kW889ye91Ogcrpkccmz0VV9kjhvstPcU1r+CBmkCO2qJw
X-Gm-Gg: ASbGnctbZVHQ2nv0fxhx/U6ozdBdVAYvQgO2HAB8qyKrGSaU9IBFnLY8wikV+zXhJDQ
	P9jPAEnSkvuuOmzUBSISkEy/VdHwEzeDXXTB4I+9wKit1sEV/MCA4xoa5vbs5Bndh0SdCE7ksfb
	dqpeujjsKz4bwsVETCJvqwGLIK62urEECwkomj+Lw1rDAuBamOfrdYxIOAIqeFfFtmD79jrN/qZ
	aku71Vm0Gemb8sxYn8e27rMwwr/a1AqMQg0HtguQiw=
X-Google-Smtp-Source: AGHT+IEpfUx1bISP2E9ZmZJiT0eG0dvm56HxGc9stXf1JqhgHuWmOnHb2LvRTlY0lkSCaPgCEl5Nq5wJso5hhCLOsa0=
X-Received: by 2002:a17:903:acb:b0:25f:45d9:6592 with SMTP id
 d9443c01a7336-25f45d96738mr155527995ad.48.1758052114771; Tue, 16 Sep 2025
 12:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev> <20250916103054.719584-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916103054.719584-4-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 12:48:22 -0700
X-Gm-Features: AS18NWC7JaavrH1iJa6lN3K9D-bBQGec-HYSAk-vd6QXXF4yQ7NXEOzMMYrYEXE
Message-ID: <CAAVpQUAEBeTjHxT7nk7qgOL8qmVxqdnSDeg=TKt4GjwNXEPxUA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:31=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
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
>  net/ipv4/inet_timewait_sock.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5b5426b8ee92..1ba20c4cb73b 100644
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
> @@ -162,6 +154,11 @@ void inet_twsk_hashdance_schedule(struct inet_timewa=
it_sock *tw,
>          */
>         refcount_set(&tw->tw_refcnt, 3);
>
> +       if (hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node=
))
> +               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +       else
> +               inet_twsk_add_node_rcu(tw, &ehead->chain);

When hlist_nulls_replace_init_rcu() returns false ?


> +
>         inet_twsk_schedule(tw, timeo);
>
>         spin_unlock(lock);
> --
> 2.25.1
>

