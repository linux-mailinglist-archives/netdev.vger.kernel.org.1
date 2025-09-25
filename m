Return-Path: <netdev+bounces-226485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA9BA0F7B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C57A9186
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67733128BA;
	Thu, 25 Sep 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpKnSPfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078A3128AC
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823251; cv=none; b=TIPZ8r5pdtdyaE0BsWVor0o2WlMz/FYjk1eKDFt2/g90MMIcJKEW31xb8DqATV6enbX6kPRBLrhUMCf94luF5KtkK/6nal03RNFa0CQ3cAYfGGqrQSoMmrdhTTXEjdGhm+UlcVggjEMcnyMrs/OH+HYLVEoSwq7fT0rub7S3tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823251; c=relaxed/simple;
	bh=o0i6eLb82CDmHv3IDKdYuxByMtu6VG1uJdc7mqNYSyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r71SGnnRGU+OInuqgZn8yJ/t0zV2UUF/3iHBgNGzHJebVS4Gx/sXWwIT/PKy6H1TOUxRY6YLnG0buClz8ASZVXw0BcU/7V5vKNYeHCtMXKoXqUJhbvTyArkfIm5Ooes7vmDZBIj44+Z/G29QQltXxh+1KIjabwrwnJp+7PURYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpKnSPfx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso963278a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758823249; x=1759428049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19XbSqIuIQCk2xtUVuKvKYbAnOYLtOl8R56GVHvT50w=;
        b=dpKnSPfxpxwT2b8xr7X6k3LgP/rTAW+cMfPF+5FCitu6xeVFFXwp7vQADPvNrouU0D
         PuVswkJWaH1L4IvQ7Lm+Zzcmb598lfTMcGCicMEwpnBpE4F3fpxCLSW1Cp+xkbe/bh0D
         Egv1/5Dxy1WzqKYx39TLOejREPT/xXqrsibTWDpvabgMfe3/9xb1TcLsP8/l4PBIf9ta
         zBzxqNCTH3TypF0WsCALwcugxqKfhiJbvORTgbCvvn1xsvEf5QmQ/vAOa59yJltdH6Bb
         6EQqAnkUNYSzX0RDnOGvQx8xc+PG41VyhT/RsJxSMOiklH73+V8x1sANWRLOT7Ok0aeZ
         3+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823249; x=1759428049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19XbSqIuIQCk2xtUVuKvKYbAnOYLtOl8R56GVHvT50w=;
        b=OIXpyU3kMg3+cbUEe6phjkctcEfk9RJsBqVTtCjElE5UFBaVM51pE/0evEUato7ypr
         wLOtFRMk+yMexu1jABKj2wUiuCtYj4o3moqCPh+kf6OK/UCJ+jfexOdiPhO/IhpamfWC
         vu0iz7jNlnJY9E/G0G4HM55cyjc9xoYAlq1axQmCI3TtNnwenWSg7FsOnBitow5+gKT4
         GUlV+6WEVwnLG2pYdTP+ynDopxCeYQYx/gaQRpQnXhw+AVj+/ZkCzsC8So/4SJNJPzsm
         +0VAqzSuDHeCUSJVL/2yu9/oDQPrbvOL9tmpFmjV6+jZwQb6F9mMJ1lM9dEyUsCqnoI7
         pydA==
X-Forwarded-Encrypted: i=1; AJvYcCUr8k3sIf/at2FdBQjaSlyRIyAzNuydOi+CrFsm0DZivs60XaHbM6WipDH7sV0DXfvmtuMEnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEBm8MTolV4pHyPtTq9fL2pJr9TSdkC0T5XjAyg7U8ERHgE9V
	+mkzOx3BmMOz1z9LpyMp18/TLytjK4tBK7eQWM0HgH7ZYETJchkZPpHK6RyH4a98WFR6YxabXn1
	8dsF5F+NF6df4bIM+1hS0vcgRyCgat9HapgxIdSzY
X-Gm-Gg: ASbGnct3nXCsz/iWENWm24Ollr+E1qpyb2JmiF6nEdzhqKnRffS2FwDjJoMbsfN779E
	pfjW8Xb2VUK3GYPZN91+XJTpM3SnhN0hyENYpfGlfQnY2FKOh0LMXFEv/N0LKTIHQTD5nXSb4XL
	z1Hf28eB+OvVgXKs1G7iyXiP764hHJLnWEmwG+5zXo/nr4xUPltPCN6YhIotUxDblnDifMVd6C0
	trvWQghiiSYfzwgT9n8jGpTm4Wz5z+BgFBF2CzgPD/sOFs=
X-Google-Smtp-Source: AGHT+IHrKA9UVRs8oLMLInQWtOtJXu2aRiNqlztEeersVIIde1jWDx+3vgthMrkZAyt5I79ayKYlEHKGEKetBvwKbFQ=
X-Received: by 2002:a17:903:3d0e:b0:271:5bde:697e with SMTP id
 d9443c01a7336-27ed49b9e58mr45420605ad.3.1758823249216; Thu, 25 Sep 2025
 11:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev> <20250925021628.886203-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20250925021628.886203-3-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:00:37 -0700
X-Gm-Features: AS18NWD0-9fKJhkbcLAPX9KSe_rySltiVgNfVGjXO8-6pNvCPbtjbPCR4UMbtjs
Message-ID: <CAAVpQUBKLzVWs_gNZ-KUn9zjkyck5NBGQWsD+Am7kK7s3LZTWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
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
> introduces a new sk_nulls_replace_node_init_rcu() helper functions to
> implement atomic replacement.
>
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/net/sock.h         | 14 ++++++++++++++
>  net/ipv4/inet_hashtables.c |  4 +++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0fd465935334..5d67f5cbae52 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -854,6 +854,20 @@ static inline bool sk_nulls_del_node_init_rcu(struct=
 sock *sk)
>         return rc;
>  }
>
> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
> +                                                 struct sock *new)
> +{
> +       if (sk_hashed(old)) {
> +               hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
> +                                            &new->sk_nulls_node);
> +               DEBUG_NET_WARN_ON_ONCE(refcount_read(&old->sk_refcnt) =3D=
=3D 1);
> +               __sock_put(old);
> +               return true;
> +       }
> +
> +       return false;
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

As you need another iteration, remove else here since
we bail out above with goto:

    goto unlock;
}

if (found_dup_sk) {

Other than that

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!


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

