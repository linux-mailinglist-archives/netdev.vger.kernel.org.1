Return-Path: <netdev+bounces-223328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C530B58BBD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E021BC25DC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1C22A4D8;
	Tue, 16 Sep 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/OWMtpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCE230D1E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988652; cv=none; b=nhzwReLmhnLrWha/bFqLxL3uW8SJNFCcRFg4jXbG6WaCX84UtypGE6bCVp+iu/GLYOFUPrZOGDsK605/AaLAHEUuF+c9MvzmepGzFCqr2pTqCO/yu+p7NKWpbN4c+hEPrDqC7RnwIR/Tt/vl8iNG/xnapGoaVf7sFKHAd9VKi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988652; c=relaxed/simple;
	bh=JZw6U7kl9sTv4BEn681td2LyVUInbGThkt8p0uWlpw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBY2HOeqdoTs5h/5hHY/fD3iWFZ67HnxhmSQTkOs287xgq5DDsg6w6DkOS1TN4hwr+65M1GIqxv9nt2x+VnzVrzz09escbFK9hPaA/AnZJe5HJ/dfOgBPlcI6scx3Wki5Jkt/0EA8FLgG8HXpB5hVH1wJST1/SkIn6RsNi2/lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/OWMtpp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so4151847a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757988649; x=1758593449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWIgwS8oDn3CeB8SxFqfKyGhV+dAepsDr9CthgIzOmM=;
        b=t/OWMtppzn7/yEFRVKkc/p946F4iLNb2LP7vkFg1sF4sCWX9o5wkR3BJJCxvR1SgVY
         tqFX+q1bRilU0+K/lpxtN3mpky6n7fgq8nR7R8pPUrkTU08IWbTc3LeEKFjvNdS69Fjj
         2pwr7FR6XRVsLgJSYU5yNa86s81nYYERRjJnNoXiTUOj4ZKsb5cmUFE6hz2sgMTjs5nU
         lsuwqMdYjJDAHRme6CusXVD00WhlLUxuKCJPc8Xx5q7GxWrCnPqfXB3emcAA5D1YoNTj
         Cwo5zA17s3HgxMVtpygbWyjm1HSH3IjhnrfORsWMmFI0gQcRr5d7dHWWYvdRKgvXvySY
         BJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757988649; x=1758593449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWIgwS8oDn3CeB8SxFqfKyGhV+dAepsDr9CthgIzOmM=;
        b=MA+pbiaKqIfGnR0UMJFwu4OPNoy8gbL0DUtBwbUtDqhLxT1Ei2M5jhf0OLO2CbYi9m
         qZ3Fm1xI7tItFpoxh992GbLhjtU+IobDrDvoSZA3uAigUxwSsJuURqSm+mGpXezpFnqk
         aQ+Nx8qWs5NPZFzVrNDfbqHUfdcBNlE3EMXl3DF2Q/ol7fLjfiOSoplTtsK15M8jivpA
         voei96yYWqUr+PyQDMgwUF7OVQ4vPTKMwwBtPS9wkMjT/e/kgYl+y9AnWjV3rZuxp8np
         +icNrg9nvA13q7sHDYzhIXyyfJTgdwEvvVTNVuapM8J8N5A8wnR/u8vo26gH0g/w5Cqb
         0VDg==
X-Forwarded-Encrypted: i=1; AJvYcCW5PjwZGKFuQrHFPtUhSwdU6jA5MCtYIKBVzU7cml3Rx1xBgbK+g9cYcqTXfaahjz1Sd4MfbcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTUwJ8TNPm0NJHPQi0ydUsbnpCCpyfvr43EyQYTJqe9pwYzKU
	Qlqv4VunZccJ9uqPRxpq17QhjVNMRjv8zwZVpkvgMUPg9rDoZhxMF8YqEa4mehvG2Pb0O+WdzsP
	+gxk797NGEs2zSSYUK4rDFAA3dgfRXJbXTFXD/6Ak
X-Gm-Gg: ASbGncvNRNBAJvdhnkdw+VGDI0FKCifyU6bCkO18PR9zM+Fbyoxn7BDIhKXBlPd/Ubq
	O3aSAiFgihTY5RExZUtI+HVhjdi5YWLo+fCgwgb/vAs7a51lkUH7X2OY8WXlKF8mc4qhJcn82kn
	Hb3kniBHZD65EEw0biNw7208bBhTC5kxP+uVBM9ZM3QDf9Iv2sP7/293mXqOvlmhjKCFGayF6lo
	r0vBmOonvk7lENS1B8mg60hhtQqqTvx2eIvvdaKXDwQ5AfQv0eRz9wODA1V2Cp+qg==
X-Google-Smtp-Source: AGHT+IEBfLUhsSLHsTBWgIu6NIMI3Yr2DZZsLFan5IbtKOtDwBa92qT/53AKKDa6yHk+V0jgV8kk9hVB9J96jIvuH4Y=
X-Received: by 2002:a17:90b:49:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-32e528c62abmr8601018a91.24.1757988649317; Mon, 15 Sep 2025
 19:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
 <20250915070308.111816-2-xuanqiang.luo@linux.dev> <CAAVpQUBuV9ixMheieH137YNxZsKAZhQekjudpiw-=7DsvxV7BA@mail.gmail.com>
 <91b6398c-70fb-440a-a654-a3e618338134@linux.dev>
In-Reply-To: <91b6398c-70fb-440a-a654-a3e618338134@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 19:10:37 -0700
X-Gm-Features: Ac12FXwRdgnCAGdkDtKPQYa2uPCZ8IvlMwP1mPSrwMicU4nIQI0VP5vUhKCivMU
Message-ID: <CAAVpQUCc1ajczhau-iOE8AWHySOowdg0XvSk_WUUmDy4ka_V4w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:34=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/16 06:50, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Mon, Sep 15, 2025 at 12:04=E2=80=AFAM <xuanqiang.luo@linux.dev> wrot=
e:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> Add two functions to atomically replace RCU-protected hlist_nulls entr=
ies.
> >>
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   include/linux/rculist_nulls.h | 62 +++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 62 insertions(+)
> >>
> >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nul=
ls.h
> >> index 89186c499dd4..eaa3a0d2f206 100644
> >> --- a/include/linux/rculist_nulls.h
> >> +++ b/include/linux/rculist_nulls.h
> >> @@ -152,6 +152,68 @@ static inline void hlist_nulls_add_fake(struct hl=
ist_nulls_node *n)
> >>          n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> >>   }
> >>
> >> +/**
> >> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
> >> + * @old: the element to be replaced
> >> + * @new: the new element to insert
> >> + *
> >> + * Description:
> >> + * Replace the old entry with the new one in a RCU-protected hlist_nu=
lls, while
> >> + * permitting racing traversals.
> >> + *
> >> + * The caller must take whatever precautions are necessary (such as h=
olding
> >> + * appropriate locks) to avoid racing with another list-mutation prim=
itive, such
> >> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on=
 this same
> >> + * list.  However, it is perfectly legal to run concurrently with the=
 _rcu
> >> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu(=
).
> >> + */
> >> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node =
*old,
> >> +                                            struct hlist_nulls_node *=
new)
> >> +{
> >> +       struct hlist_nulls_node *next =3D old->next;
> >> +
> >> +       new->next =3D next;
> >> +       WRITE_ONCE(new->pprev, old->pprev);
> >> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->ppr=
ev, new);
> >> +       if (!is_a_nulls(next))
> >> +               WRITE_ONCE(new->next->pprev, &new->next);
> >> +}
> >> +
> >> +/**
> >> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one a=
nd
> >> + * initialize the old
> >> + * @old: the element to be replaced
> >> + * @new: the new element to insert
> >> + *
> >> + * Description:
> >> + * Replace the old entry with the new one in a RCU-protected hlist_nu=
lls, while
> >> + * permitting racing traversals, and reinitialize the old entry.
> >> + *
> >> + * Return: true if the old entry was hashed and was replaced successf=
ully, false
> >> + * otherwise.
> >> + *
> >> + * Note: hlist_nulls_unhashed() on the old node returns true after th=
is.
> >> + * It is useful for RCU based read lockfree traversal if the writer s=
ide must
> >> + * know if the list entry is still hashed or already unhashed.
> >> + *
> >> + * The caller must take whatever precautions are necessary (such as h=
olding
> >> + * appropriate locks) to avoid racing with another list-mutation prim=
itive, such
> >> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on=
 this same
> >> + * list. However, it is perfectly legal to run concurrently with the =
_rcu
> >> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu(=
).
> >> + */
> >> +static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_no=
de *old,
> >> +                                               struct hlist_nulls_nod=
e *new)
> >> +{
> >> +       if (!hlist_nulls_unhashed(old)) {
> > This is already checked by __sk_nulls_replace_node_init_rcu().
> >
> It seems to me that hlist_nulls_replace_init_rcu() checks whether the
> sk_nulls_node is unhashed, while __sk_nulls_replace_node_init_rcu() check=
s the
> sk_node's unhashed status.

sk_nulls_node and sk_node have the same size and
are defined in union so that we can reuse sk_hashed()
for both types.


> Perhaps these serve different purposes?
> This would maintain parity with how hlist_nulls_del_init_rcu verifies
> sk_nulls_node and __sk_nulls_del_node_init_rcu() checks sk_node.
>
>
> Thanks
> Xuanqiang
>
> >> +               __hlist_nulls_replace_rcu(old, new);
> >> +               old->pprev =3D NULL;
> >> +               return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >>   /**
> >>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given t=
ype
> >>    * @tpos:      the type * to use as a loop cursor.
> >> --
> >> 2.27.0
> >>

