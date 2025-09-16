Return-Path: <netdev+bounces-223687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCCFB5A0D9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68AF481756
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B12C1591;
	Tue, 16 Sep 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOmVreAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419A2698AF
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049101; cv=none; b=V4jmfT/qNzhClHwxvpj5wwuCGlVoXdzCmWHmIaDQANyXg45ElGtTx/ZZ62ec09Gba/42zsBpYboUj4Gp3I7WkuPEm1ZhHAAeOuab9ntBOX3GE0AqrpwJT2aOMcD2dd8XlIiKGP4UGx4FLp+rI05uAL978mTbYYfCv3DtZfaGMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049101; c=relaxed/simple;
	bh=i7pG9LRJblTwnrveZZ8KPXT6GFmKdh7X+GJqm5x1ozQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy/LNOVPuiL3R5IAUyIBArSV+FP1GbAmy9vmG7q3sszHzGE/zvbfQm3OC8sJlaR/QxA31MtItr+reOr3mGtr1X+ZEbozm1Qb6IsLmku75v2xvgRECYeJBK6ao7Ycp0I5Ib9QVWEYDm8wWGQhb6g5p2TiNB9/Tb4b4i0jr0G0rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOmVreAC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267facf9b58so2911425ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758049099; x=1758653899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcRvFWAQagaZM488SMeFqPnYBcXWAjC26Vxq5hGQlqo=;
        b=XOmVreACQtTUosjAPvoqDNs6ndXJe0CiPMFYcY9X88E9Xrqonz5Ewtw15AEPs+x5Mj
         Hg/+ZhqeqBOENHnJWtVpGesQavTPHm9skeAFVVuiG601ANYUGEDQ7vPIdL6BTGyqvhlJ
         +rfZNDak9zOhS62J+LmV8mFbib5ZSMv+1sp3RUsI3M08M2iXk2TJUFL4lNHR2qx7BsDh
         /ZFfGehN3LJ7bCikwsXISeekmLvEcYS8gcz+XU1IFn6MC/z5nW3TjmegBBjYA1Wngrpe
         JYFzz7FBBuBXDYkNar836gXrj/U9bNWuJPoXJrXcOOu7y8KX64vVT/UiUsnOGdsA3uWj
         Aatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758049099; x=1758653899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcRvFWAQagaZM488SMeFqPnYBcXWAjC26Vxq5hGQlqo=;
        b=TzOPooige+V656M29xXEATCKnh6/v5/ahUGQWYovOMBq3ZfD1nKVnnjxDgpHZu05NH
         yhKEo24CfFj09rHPB7hIYmUyjs7YKuyGmthERvTQgYs0pMOhApDxTvgb4A14Q7YJBCM5
         m5A4tyMX/4HrFmgLY8rgz+/oeCUC/zREPcd/E4EhrEZRd7Hyb7gfpqzmZen4v6mdh/Jk
         45sg/VqeCV3QkP91dAGvdEfp8pw2B6NTfTMlZT9RiuMqr9x6dLaHiTyTGBbpV7wrr7m7
         t4HxqED1Pg5pDJhJ8rZygfo2ffJvAUbRWVwiNr97kRlc3qVzSW69KzVE51TWWU/Zqp/4
         mZoA==
X-Forwarded-Encrypted: i=1; AJvYcCVxX7qvpMIC3taA6LW/OI/OUlL78OmR8PHWEmGvodqdTgaCEy1QBJ2xx+H20ATdYGOFofssr+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6jo5rTI/KA37dfK3lP2oJbGF6ECE95sQAWBYZQwYg6uKHtwA
	Y29xZ7W+SFfHd/A1iRMH4gdl23CuVBhLpZGJGxgMX7xFGXuk6xGNAj5WaUpvYVRKWn/i+F3N4cy
	NQr8qaEgzQYV78Ec50n3ADKCnK6DmtrLQQ6Afq41B
X-Gm-Gg: ASbGncvHbB9Lw/g6LYSFpJ4DvmnxsBWoGh28AnYrrQ9WiwBy/8QvdF8FaOybN/7bj37
	Ab7d6k5Z9jlbSZzp61Q0FCg61zn9haHx2mADS/0B4ye/FLFp5nR33rWMAHznbgVlOB4R3WjDNWH
	BKgERKnK+LpyKsXbwui91rS2eNTTpFE0vW3yut71OAxMAiU+JCt3CTIrwF3hinHIWHwnpfwkKEE
	dCNrHVK3WN1KSaXigwLfCUcSNA9Uppf4ThiPW3gqxza3BC9WPpbVqB5hMgssl0F
X-Google-Smtp-Source: AGHT+IFqPCAIWilJ4nD8yq/MDtRzpsFj8OQH9rOra44GFtoYQh8jEvEUZj73NriYjI+qIQGR9qP1pY6NY/bPYB3SgPw=
X-Received: by 2002:a17:902:fc4f:b0:264:5f1a:1e46 with SMTP id
 d9443c01a7336-2645f1a2097mr121318595ad.26.1758049098478; Tue, 16 Sep 2025
 11:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev> <20250916103054.719584-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916103054.719584-2-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 11:58:07 -0700
X-Gm-Features: AS18NWDBf6vXR3W_ETVn-di-7WnFgKqyOuz1b4Ftek_l6IRmNxqki144xYimcmg
Message-ID: <CAAVpQUDYG1p+2o90+HTSXe1aFsR4-KWZtSPC7YXKDuge+JOjjg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
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
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..8ed604f65a3e 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hlist=
_nulls_node *n)
>         n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>  }
>
> +/**
> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals.
> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list.  However, it is perfectly legal to run concurrently with the _r=
cu
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *ol=
d,
> +                                            struct hlist_nulls_node *new=
)
> +{
> +       struct hlist_nulls_node *next =3D old->next;
> +
> +       new->next =3D next;
> +       WRITE_ONCE(new->pprev, old->pprev);

As you don't use WRITE_ONCE() for ->next, the new node must
not be published yet, so WRITE_ONCE() is unnecessary for ->pprev
too.


> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev,=
 new);
> +       if (!is_a_nulls(next))
> +               WRITE_ONCE(new->next->pprev, &new->next);
> +}
> +
> +/**
> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
> + * initialize the old
> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals, and reinitialize the old entry.
> + *
> + * Return: true if the old entry was hashed and was replaced successfull=
y, false
> + * otherwise.
> + *
> + * Note: hlist_nulls_unhashed() on the old node returns true after this.
> + * It is useful for RCU based read lockfree traversal if the writer side=
 must
> + * know if the list entry is still hashed or already unhashed.
> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list. However, it is perfectly legal to run concurrently with the _rc=
u
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_node =
*old,
> +                                               struct hlist_nulls_node *=
new)
> +{
> +       if (!hlist_nulls_unhashed(old)) {

As mentioned in v1, this check is redundant.


> +               __hlist_nulls_replace_rcu(old, new);
> +               WRITE_ONCE(old->pprev, NULL);
> +               return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>   * @tpos:      the type * to use as a loop cursor.
> --
> 2.25.1
>

