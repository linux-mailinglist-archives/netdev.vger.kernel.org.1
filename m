Return-Path: <netdev+bounces-223252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A5B587F8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C877A8A28
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6178229B36;
	Mon, 15 Sep 2025 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHP8Z1JB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7018DF9D
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977259; cv=none; b=WWleLL9FllnWG+PiFpqgO15OGuUFPjY85LSZ7v0i/WC1sEfFt9tDp1mdC6LA4TN895TpLeXltnFIg20k3EPDQt1UBzeuo6rSGXxQOv/FpFhovqTS/0niKlcMPjQ6wupg5PA6r84nuKZvVXQKCosvWmrbO9ncDYKGUghGzkD2W+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977259; c=relaxed/simple;
	bh=erVAAAvOukAgrfBXQHf7QhK7ju4AbLKqtl6Bstbvimk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgimjTudeOODiTLQrGdzqfEHA4kB3U9joaybgXBlFeQMQV4lGL1SBOpDCJ95aRFPAhjE9aiYYlA9jt4ats71qbanoY7A89gJWugpQ7rTqmNnyB9fT6Senjb7O0vMDl5x9mjs/xNqett715vjC+Wq7BxMqmSGJV9jO63L9ZTaoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHP8Z1JB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a588ad96so3175545a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977257; x=1758582057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmjyU1xVRCtAzaD1dlBT3mGpxSenQTtWrHUuUbzkYHM=;
        b=DHP8Z1JBXZn8tlLuVQBiAV8JSsinBuK/eP2unouTiJK0PAWxRaNozs8ofS/TIiFw2m
         98GXcsKTykpePYkIzUM8N8ZnJfL5YZPeTTPvTFTO6iU9xdm1qDhbCQA4wClWT6AAHvt6
         FH6GWA4ZkDiPo7Izu+nj5SkDuAwgGasauT1xDwMIiuVxkgUjPh4m5Vb+MjAfSsKLpEKL
         +Qm2HR9az7I/Ne3/8cGuy4VJ1gRkC7MHFPWqACknDp4yqeF9TkjkN2Lz1Jj3kRdxYvSO
         QLOErUx4w71IogfF4eV/SKneysqmCDw0W73taLCofY88JSj+Vf133yi+JaNQD+RbjQ5Z
         Zttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977257; x=1758582057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmjyU1xVRCtAzaD1dlBT3mGpxSenQTtWrHUuUbzkYHM=;
        b=l0txiNNUq4vBi77ORZ0Hzhc3mGp/gkXa+h67zmA/t9/Su3DuExhVqlvxZ7WPrzcuQx
         Q+UZDl1kq8ouFtZz/2ZC7SY+CyxyehpFi5BkyxPpKQBDBanzzAM4xZAxMxLwcvOR7y8V
         pHZWfWRbekgowoeB7E1DxBJKY1PCKb0aXby/T3pHM7UMfubM9a93CLlt1BWht18KqWIl
         gC/yxBy2BHnvEZfpyZ0XCq9iJJ26BWJXsfz8nbXmGVdE6oHlHCPBDOJonxNZQ2nxbqtg
         x0sVx47+CrHbmr4ujhORiyvk1jiB5/Tk1p/fZWo0Bk7J0yBUvUyAU0rjuP7fNUZhSnii
         JVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWtREFOgbcxnZl2fsy1RuW7eeGF1mP+HxeVf2XSOMHNTZijTVyNpXJm6Ni1KR58UuibYZClPgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJokadZtru1zXBB8CTzR/fo/2HTERJodptC44IwMU+SkMuYs3v
	49OWquK0ghb9ziKIAq6BE6xi7jRdGe0APQj+OVJvTW757hHn0hLYgxWfzPNKk5Qhd+tMQAmWvRN
	VRc9CtVSMbyLvvPjc0NJnSQAIKBWhrYB8uct9GEUd
X-Gm-Gg: ASbGnct1o5owhjGpP4bq8OfdqhT7UKxr5Lcn9NFJCeBRN4By0SKSyaNQbs4+4m+VDIU
	PFhatOtbq4ZwhG9I1dDsGxNOjF04/LHZy7npTGLxIKHkWS2Noto7JYJ0JVWCdAkWgZ/E3moB1Gq
	ozn3wEeH+xUaIfUcXq1FHfWCPSjfhQ10bun5e8TBSe6QRBI0D3vOlybtMAtUI9a869YKnOl+rfd
	7PVxS3iPkUtzReBUNQzEeDyYNPsgNQU/0+OVaG3EQPMns3bPsBKFnM=
X-Google-Smtp-Source: AGHT+IF7oKSWn9wX7QxcvB2PurJoyt+XK9FJ/6iFEB0N+LYmEGrK72PtrEqWAKeo7p5+yIGSBTx9eekFWeDFP/XKYA8=
X-Received: by 2002:a17:902:c40e:b0:251:a3b3:1572 with SMTP id
 d9443c01a7336-267d1549123mr2237475ad.9.1757977256740; Mon, 15 Sep 2025
 16:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev> <20250915070308.111816-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20250915070308.111816-3-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 16:00:44 -0700
X-Gm-Features: Ac12FXwWGwNxI9iLrAozV-F_CQr_ObLyj1hd2np6n0N8jchh-XHP_1Yyaa7Znx4
Message-ID: <CAAVpQUDHF_=gdXSr4TX=11gn7_-NObqN156x_rtQMPitL+YUTg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
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
> Since ehash lookups are lockless, if one CPU performs a lookup while
> another concurrently deletes and inserts (removing reqsk and inserting sk=
),
> the lookup may fail to find the socket, an RST may be sent.
>
> The call trace map is drawn as follows:
>    CPU 0                           CPU 1
>    -----                           -----
>                                 inet_ehash_insert()
>                                 spin_lock()
>                                 sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>         (lookup failed)
>                                 __sk_nulls_add_node_rcu(sk, list)
>                                 spin_unlock()
>
> As both deletion and insertion operate on the same ehash chain, this patc=
h
> introduces two new sk_nulls_replace_* helper functions to implement atomi=
c
> replacement.
>
> If sk_nulls_replace_node_init_rcu() fails, it indicates osk is either
> hlist_unhashed or hlist_nulls_unhashed. The former returns false; the
> latter performs insertion without deletion.
>
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/net/sock.h         | 23 +++++++++++++++++++++++
>  net/ipv4/inet_hashtables.c |  7 +++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 896bec2d2176..26dacf7bc93e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -859,6 +859,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct=
 sock *sk)
>         return rc;
>  }
>
> +static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
> +                                                   struct sock *new)
> +{
> +       if (sk_hashed(old) &&
> +           hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
> +                                        &new->sk_nulls_node))
> +               return true;
> +
> +       return false;
> +}
> +
> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
> +                                                 struct sock *new)
> +{
> +       bool rc =3D __sk_nulls_replace_node_init_rcu(old, new);
> +
> +       if (rc) {
> +               WARN_ON(refcount_read(&old->sk_refcnt) =3D=3D 1);
> +               __sock_put(old);
> +       }
> +       return rc;
> +}
> +
>  static inline void __sk_add_node(struct sock *sk, struct hlist_head *lis=
t)
>  {
>         hlist_add_head(&sk->sk_node, list);
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ef4ccfd46ff6..7803fd3cc8e9 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -685,6 +685,12 @@ bool inet_ehash_insert(struct sock *sk, struct sock =
*osk, bool *found_dup_sk)
>         spin_lock(lock);
>         if (osk) {
>                 WARN_ON_ONCE(sk->sk_hash !=3D osk->sk_hash);
> +               /* Since osk and sk should be in the same ehash bucket, t=
ry
> +                * direct replacement to avoid lookup gaps. On failure, n=
o
> +                * changes. sk_nulls_del_node_init_rcu() will handle the =
rest.

Both sk_nulls_replace_node_init_rcu() and
sk_nulls_del_node_init_rcu() return true only when
sk_hashed(osk) =3D=3D true.

Only thing sk_nulls_del_node_init_rcu() does is to
set ret to false.


> +                */
> +               if (sk_nulls_replace_node_init_rcu(osk, sk))
> +                       goto unlock;
>                 ret =3D sk_nulls_del_node_init_rcu(osk);

So, should we simply do

ret =3D sk_nulls_replace_node_init_rcu(osk, sk);
goto unlock;

?


>         } else if (found_dup_sk) {
>                 *found_dup_sk =3D inet_ehash_lookup_by_sk(sk, list);
> @@ -695,6 +701,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *=
osk, bool *found_dup_sk)
>         if (ret)
>                 __sk_nulls_add_node_rcu(sk, list);
>
> +unlock:
>         spin_unlock(lock);
>
>         return ret;
> --
> 2.27.0
>

