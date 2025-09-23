Return-Path: <netdev+bounces-225452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F0B93AFC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64F67A2F1D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213472623;
	Tue, 23 Sep 2025 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yxrp5cGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD748488
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587051; cv=none; b=bXvp3zVE+MpdnoQH6cBOtLIuMpq02OPt9sqOmpY0gqR6ea0GHw18x0nzQpyCBRGsvD+krMyEMGCp71a0sO2GbwAAXVtK4VK35JjJ8kZJEf7OB6fkkMe7uc3ejjd4pUdhItKR2fhZaqD2yOW38E3rRreY8cnxnV3n+gpcbSKyZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587051; c=relaxed/simple;
	bh=eK9eAI2Ngw5MjW5ZI+XueDUgIcIq4f5p6hwMlNcsPKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqvWjzO6bflgjIg8Grpc97oBDbXvW7PzQUIJzM5DbyGnZ62MmbmpHA/whIjz/vu5ltLiMCHmk+htGqUxcTHK2+V6dqrFpeA0oLDmJuBl/81Ve6k37sD8BxqjBa2eLJgxJJN8qX+AxOeInxAhug+fvEPqSy1EEbj7/AXy2LaIskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yxrp5cGl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so53478725ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758587049; x=1759191849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4RV2pS1EwHkp4OEPebx/C9hIy8KtEzsF4sUi8ME9yE=;
        b=Yxrp5cGlrzpHzmXd+7iY4ywuqi344UwiBs3+45CCxZ2zS03DXh8tpFS9m0En8fayK8
         uGu5n1eXou3LhrF0WG+e1Lf4BMPHzHaTC9pmIoljsAhDHwlW6V3iYkfMvx7K981z/mlP
         cxgOlvjK705LHSGmvmiGSvy+IZdGK3cpLbkdeHMlDknrPjcfVdwKKwtoDzbaso1GkR+9
         K3Ph6oOg9NYtYFaRyQH4VmffcaUy+bGu4XgpGYIXtjMZUIlsOuX624PypOkRhCIogokl
         fyZToCa6jutGmmDy4+N32epgpKZxQxD5c5iBfrC8wFT4lVqIL+7Qyy1xK7QFt65c2Of2
         DJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587049; x=1759191849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4RV2pS1EwHkp4OEPebx/C9hIy8KtEzsF4sUi8ME9yE=;
        b=kAp+20d4JkMCRhuIEYYBTAeEK1IxMPU4Vwu18WO0ULPkSDbhvApuTQfP8kf7jWYDKo
         OIKVgwXPPIGIkvCoGS3UuTabKmqcs7nfCHgx3aXtvai7L16quEyyLCQVIbmQQ/rZlOvp
         E4M1Zl0uXGJYVzE+nP98OF/NE1eF6geyBC/Lz+Bwg0kcx37P0pvwCYYPGVr6b9T1JOF7
         EiOTVc3GmHttlxl0W+eym9Fv80S42eSNeCvQf+wD5R5IHJwgpWC3BZQYkoAcEX0oJb28
         ci+Q1vN+BqJGmO6z6ajgxo/RT09fjpRNBU9c6kj1ZoWhnVR84+WAQI5n8py0BZ/ZG2zT
         BDgw==
X-Forwarded-Encrypted: i=1; AJvYcCXJjp0laqKP4FCRfvkDwWOEwgUnyz6aL2yUz9nT7pMynvmnlU42cES9qD3xho7xYNP0tr+RSws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7h08HsPTyPTkJJO/NHBzsblqkfpoK1UD31szeeXz+SGkRv3cQ
	mUCUkdtzl0iuPJr466DBUO+NV0ZWrT5W5Li7zMWcakfF6pj6J1wEH0BQ970c0YDLwWj8J7hzeQP
	G/noko+/XwlK2X5sKZM2/4bZmufOz9RM2z9hvo4dB
X-Gm-Gg: ASbGncvtc3sHogIAmePJvAXthngxKttbYYAU76n2sb7NhUAHpsYNo5vQLFK/+kh8Gsn
	IvisH9ZveQOpXMKLc7ZQyNoHrIREW5PMB8xaHLQCh0/1CAEd1mOQGd2n3f5cJp9TKMZTrRo3mq0
	2DvSUkzXqieDFRm0NGEhzIoCUhS6oCt1kQfJBRL8K5EWL7VgnOkTAkynUDoAQ/Px6TngRPA0saK
	4+PWPxCB9t7LuL9jVKPnJeFHGb5gV1zlRr/vg==
X-Google-Smtp-Source: AGHT+IGCt3y1gG5kNg42w4j5lIVXO0QGW0pwu8D1x6gD+Bl3VH2Rq+v08CadUi0kMJqSYFtQdFN+CuaoXmxzNzTjEII=
X-Received: by 2002:a17:902:ce81:b0:24c:bc02:788b with SMTP id
 d9443c01a7336-27cc5a016b2mr7212995ad.44.1758587048761; Mon, 22 Sep 2025
 17:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev> <20250920105945.538042-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20250920105945.538042-3-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:23:57 -0700
X-Gm-Features: AS18NWANaQ8qjFb3Pq244M2uGvJ8kVFWeb1XAx77oT-gnIl0IBsL9tfqsK2nQJ4
Message-ID: <CAAVpQUBTeRk1r1jtxBU3L5Y1S_bcdJxOkhVRO=8a+=ix6-E0ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
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
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/net/sock.h         | 23 +++++++++++++++++++++++
>  net/ipv4/inet_hashtables.c |  4 +++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0fd465935334..e709376eaf0a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -854,6 +854,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct=
 sock *sk)
>         return rc;
>  }
>
> +static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
> +                                                   struct sock *new)

nit: This can be inlined into sk_nulls_replace_node_init_rcu() as
there is no caller of __sk_nulls_replace_node_init_rcu().


> +{
> +       if (sk_hashed(old)) {
> +               hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
> +                                            &new->sk_nulls_node);
> +               return true;
> +       }
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

nit: DEBUG_NET_WARN_ON_ONCE() would be better as
this is "paranoid" as commented in sk_del_node_init() etc.


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
> index ef4ccfd46ff6..83c9ec625419 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -685,7 +685,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *=
osk, bool *found_dup_sk)
>         spin_lock(lock);
>         if (osk) {
>                 WARN_ON_ONCE(sk->sk_hash !=3D osk->sk_hash);
> -               ret =3D sk_nulls_del_node_init_rcu(osk);
> +               ret =3D sk_nulls_replace_node_init_rcu(osk, sk);
> +               goto unlock;
>         } else if (found_dup_sk) {
>                 *found_dup_sk =3D inet_ehash_lookup_by_sk(sk, list);
>                 if (*found_dup_sk)
> @@ -695,6 +696,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *=
osk, bool *found_dup_sk)
>         if (ret)
>                 __sk_nulls_add_node_rcu(sk, list);
>
> +unlock:
>         spin_unlock(lock);
>
>         return ret;
> --
> 2.25.1
>

