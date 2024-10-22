Return-Path: <netdev+bounces-137905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE09AB10B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BBD1C21541
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410A1A01AB;
	Tue, 22 Oct 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OF9J0eK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27B199248
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608054; cv=none; b=tlO2nlmv+R0SOgdo2aCoPybhOZypkMDQnQhh4EQma4ZOTA4azbN9o/D+KlZhMk9o9mGvzncX+77t+fpP+r1ozzJ8/g/CvaHjk1x3i7JStARXKFzw/W254AOdZVkOcB78iMrkvqMQNEbWGlLN/DwkfQye4AiUE+kp6vN6dIqbY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608054; c=relaxed/simple;
	bh=tzv4J5uMUVcj2p/Vy4ziRnBKCWsp//HKLfztq97SFuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0RXrKC9/foUo8+4Grki48SKjzcdDRu5AfmUVURQL4741ZJ/3qGMP9PWMP3mqWBo78gf5vXm0S98IossBs4Zh2l9/+Fa2VGU1gjO86f/vCnK1tIde9bHL13wcCk3q62Y/hTGgjHybmhRoj5AqnqOLQguZ6BQlLgTWD6qxhDmPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OF9J0eK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b63596e0so16797815ab.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729608052; x=1730212852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mctwXks0vml/CVmKaQAWDXHguHAc6gYQrcNKV/VH6AI=;
        b=4OF9J0eKLAzCZwRMNBMmSdXiNS27Iz5TlAW5k4UpTRJME7qa78eyxOmdWJYOzHjBmR
         m2L3r4iHb3AlIt2mXovNDX/LM1ud7fWFTSbmSdm1gF+Fgvhvm4pa7sM7Yf8rBDPuJLF3
         tFvR4jyupX2tSMeIRg1ptwe79l1huU+ICv1xdFW5IvZR9IFVYnS3C12oElXWQlTZwSEV
         rNgPlHpNmRZMiGpz6J6RIn2hHF+JhWWuu8jJgUZI177qstNSFTBuINeZbYzqZZNxjss3
         ED133z8gplv4sKuslFUJe8Re+LqkX1W8ovcuoRl7ZqVgkOGD7QxtXHrkBnwtveYbDsdf
         KpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608052; x=1730212852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mctwXks0vml/CVmKaQAWDXHguHAc6gYQrcNKV/VH6AI=;
        b=P6ZZFDDnL0ZWk1LmbVGRkdNwC6jlpYJ+zn6KHYPcZlxp2k5y9Rii5H0C8VuP3wTKSA
         SPsFd08m0qIarPR+NN8L4yX32he/bTV6po7skWPw1QOcHGgKsueaVw2rTWgprw+yn5S8
         uf4ZIQ//2v/hCUI2ew3IRDc9IpklB89iDbOniVYmkSVgcS22lqsoAWPAS2GnEDYPAhDm
         XFZHHvohiRERw+9NT+6p688234oEy/gld9/UkGCtkFcbt+jheJkNShfag2mDWa6NMCQz
         wOL8PxXfywYhKLPC5gO2Ia8sYSM4GiO7BSfIxE/Q6dMYYvBZozkMstcgOHiJqN/xNE13
         +qvg==
X-Gm-Message-State: AOJu0YxDp0Fvs4+3ICoPqUJn953pQyOh3EX8r/zs/Wis30V7LFOM69BH
	f8orSQQkIFQ+PLjqg+uKBC+/B6CbZIl70GBM4JkWu9mLjgLaBpZvXLbDWjZO1g8zEgiLbtt/KIU
	mUp6JoufJNWXDl8YlZEMRadIZpZImRXwf1ira
X-Google-Smtp-Source: AGHT+IHn1Rapcv0EOeFh39bTptIpoERNIB+OpZSimn9nvwlXEIy6/PeVTwzIhkIghkZoIcuXi1wJQWvVsK563s88cSk=
X-Received: by 2002:a05:6e02:1e07:b0:3a0:ce5a:1817 with SMTP id
 e9e14a558f8ab-3a4cbe359demr23860955ab.0.1729608048669; Tue, 22 Oct 2024
 07:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022134343.3354111-1-gnaaman@drivenets.com> <20241022134343.3354111-2-gnaaman@drivenets.com>
In-Reply-To: <20241022134343.3354111-2-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 16:40:34 +0200
Message-ID: <CANn89iKGa9TWnGZJJZAL-B-onmJ7gRXQsWxy=7FvwJr+Y2DuCg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] neighbour: Add hlist_node to struct neighbour
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:44=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com=
> wrote:
>
> Add a doubly-linked node to neighbours, so that they
> can be deleted without iterating the entire bucket they're in.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  include/net/neighbour.h |  2 ++
>  net/core/neighbour.c    | 40 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 3887ed9e5026..0402447854c7 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -136,6 +136,7 @@ struct neigh_statistics {
>
>  struct neighbour {
>         struct neighbour __rcu  *next;
> +       struct hlist_node       hash;
>         struct neigh_table      *tbl;
>         struct neigh_parms      *parms;
>         unsigned long           confirmed;
> @@ -191,6 +192,7 @@ struct pneigh_entry {
>
>  struct neigh_hash_table {
>         struct neighbour __rcu  **hash_buckets;
> +       struct hlist_head       *hash_heads;
>         unsigned int            hash_shift;
>         __u32                   hash_rnd[NEIGH_NUM_HASH_RND];
>         struct rcu_head         rcu;
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 395ae1626eef..7df4cfc0ac9a 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -217,6 +217,7 @@ static bool neigh_del(struct neighbour *n, struct nei=
ghbour __rcu **np,
>                 neigh =3D rcu_dereference_protected(n->next,
>                                                   lockdep_is_held(&tbl->l=
ock));
>                 rcu_assign_pointer(*np, neigh);
> +               hlist_del_rcu(&n->hash);
>                 neigh_mark_dead(n);
>                 retval =3D true;
>         }
> @@ -403,6 +404,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, =
struct net_device *dev,
>                         rcu_assign_pointer(*np,
>                                    rcu_dereference_protected(n->next,
>                                                 lockdep_is_held(&tbl->loc=
k)));
> +                       hlist_del_rcu(&n->hash);
>                         write_lock(&n->lock);
>                         neigh_del_timer(n);
>                         neigh_mark_dead(n);
> @@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
>
>  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  {
> +       size_t hash_heads_size =3D (1 << shift) * sizeof(struct hlist_hea=
d);
>         size_t size =3D (1 << shift) * sizeof(struct neighbour *);
> -       struct neigh_hash_table *ret;
>         struct neighbour __rcu **buckets;
> +       struct hlist_head *hash_heads;
> +       struct neigh_hash_table *ret;
>         int i;
>
> +       hash_heads =3D NULL;
> +
>         ret =3D kmalloc(sizeof(*ret), GFP_ATOMIC);
>         if (!ret)
>                 return NULL;
>         if (size <=3D PAGE_SIZE) {
>                 buckets =3D kzalloc(size, GFP_ATOMIC);
> +
> +               if (buckets) {
> +                       hash_heads =3D kzalloc(hash_heads_size, GFP_ATOMI=
C);
> +                       if (!hash_heads)
> +                               kfree(buckets);
> +               }

Oh well, I strongly suggest we first switch to kvzalloc() and
kvfree(), instead of copy/pasting old work arounds...

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395ae1626eef2f22f5b81051671371ed67eb5943..a44511218a600ff55513a7255e9=
0641cd7c2e983
100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -538,14 +538,7 @@ static struct neigh_hash_table
*neigh_hash_alloc(unsigned int shift)
        ret =3D kmalloc(sizeof(*ret), GFP_ATOMIC);
        if (!ret)
                return NULL;
-       if (size <=3D PAGE_SIZE) {
-               buckets =3D kzalloc(size, GFP_ATOMIC);
-       } else {
-               buckets =3D (struct neighbour __rcu **)
-                         __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-                                          get_order(size));
-               kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-       }
+       buckets =3D kvzalloc(size, GFP_ATOMIC);
        if (!buckets) {
                kfree(ret);
                return NULL;
@@ -562,15 +555,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
        struct neigh_hash_table *nht =3D container_of(head,
                                                    struct neigh_hash_table=
,
                                                    rcu);
-       size_t size =3D (1 << nht->hash_shift) * sizeof(struct neighbour *)=
;
-       struct neighbour __rcu **buckets =3D nht->hash_buckets;

-       if (size <=3D PAGE_SIZE) {
-               kfree(buckets);
-       } else {
-               kmemleak_free(buckets);
-               free_pages((unsigned long)buckets, get_order(size));
-       }
+       kvfree(nht->hash_buckets);
        kfree(nht);
 }

