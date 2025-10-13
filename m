Return-Path: <netdev+bounces-228673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4912BD1D07
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139213C0457
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3927934B;
	Mon, 13 Oct 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJbukY1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA76274B42
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340727; cv=none; b=Z2bDVk+v/vdEYQimudLQKwXhLmN/IR8x4e6o2XCKr1qyw8u4pwXfuBwCggYKrGO57LYEDkIzipY6V8H7GMf520BmbsiSAnmKx9gu5swH3o9Nyxzt6fhbFCEgV2U8Zq99II4Ydn5CGAxZBVTk1ZdqbNUAkQZZFIOOqjvQbtmcwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340727; c=relaxed/simple;
	bh=YMQKWWAAQt92vmYhil6N6EMqmMZOmwO9jCJCjdjDPwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsjoKOeBgvCkYLRoDrDFZxhQlWYdBhJkQZ6yK76o0oiLS2SCf57RTyKEC3GmQDksmF1jau7dj895U/VKy99J1ZEUaOooW4Ind3V5wRa1EiEIBnUxILnEAMFJyIXTYGwTtWZCC+w2Wr/atdrjb+9txspjyodJRcQ2xhzgdLlT2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJbukY1H; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-859b2ec0556so567261485a.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760340723; x=1760945523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp6EMRShrEhNA/zc4orOacczfa9hILYLF0zSnXNWJ7A=;
        b=xJbukY1Hgtf723/EhwtG1soacm2tXXZc2PnqHf5zoh51PRODCEAfnD7qBTmPLi5AMG
         YGY+CH25QU7rPTQQzLNU1R5GPiGLfw3wOpMY1tXv6pN/K5lg55lABV+SikO+o74n+YqG
         c/iYwKZFkG6fyqEKk7XO7jcuZJ24MuxMN3tEilQUTMCCFt5gTJ2tf9JdqNY+s+Eyw7wf
         Icr3exToug5Y4NeUIB8chTOXnOmxLVE80kEyfrYagB6+afb7xmtmqGY/elX2oTIzzeQ3
         Jufh/I1ppQ0tiTauANCG11GWug7YK/H5jAVWsKcBTC0K498FRTUSlrTOooJkviM7Mewl
         fsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760340723; x=1760945523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp6EMRShrEhNA/zc4orOacczfa9hILYLF0zSnXNWJ7A=;
        b=VJK3udr9Zigbob8z9AJcL70OlS7nOF4ej7RalrrD1sorMd3NpcTE16vKSRg4gxm0xi
         oqL9Hlh0y8UVSsQL2zcpnYoeiUtxwUaATxAWGwxJlnelSBOcCrlI8LRx63uK0Q0OZQAA
         yCVn6raCofw02sLfmGAou0e8Qc3ukeLoRovSvY2w35XPmK1ur4EqLwd4mVbX2jiU32/n
         CotFnIK3rP9Kr6yb8XCrr0ioUPKx72iK3qoP005cPOtS4JKN62+XsiTvrPvPEc4lJm5I
         RmCOBUAfwQ6g1M57S9ShYNB4AdcVMSFlLMyWnAZXjlDWp+tinsHCunwxIwBo+rGnfOPc
         Pc0A==
X-Forwarded-Encrypted: i=1; AJvYcCVi0Ya0Gb/LS/+3GYwCJI6IoWx4uwqkVeZM+8RMJPq7OfJcNaRG9qHUvgmWDfbVaV8FkCA489s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQz1wbz9KRloXGkPoCk/dSNd29cOTW7ma9TWr/CfU61nQz5nm/
	KldIVH2ClauvL4KLBnt5asnr2KIFXQuIXmgQ+o/fAZhEwcS2IZ62s1Ed8WB4VKjfj/ZC+iFz0GK
	OVVig2Ij0fQH+TIDtSzFIh89Gwe384Pc2XzSilIsj
X-Gm-Gg: ASbGncsXOh/NDdiNhdYDBuzlELCSEXbo8zQazYXNC1Yy7PNlRHRhZzJG00FMifZdDpZ
	fOfNcf/aGB79v2o6u0TdJB2Fj2PVa40cjvoDmrW0uDuKL33XhiU+/zzzk/OAxg+d15JfFsHN9dg
	vUczWYuPTAUJOoGDbAN7sLlHak1V2/kqcxvOvhi5wiQ6/fFQCaMM8jWoJPlTkaCHXIDr5gVza4L
	Q0auPRMZoAGhWWxKNiagzuBo6Mlu8B99WznYa16SWQ=
X-Google-Smtp-Source: AGHT+IFW3d4QvT3vimvh6cf456FIjNSkEAY/i7iqvjn6DVRKEb+C7qK/eBvTOtLF19plwteHdyuWTafZyHXYB5LfnH4=
X-Received: by 2002:a05:622a:28b:b0:4e0:9097:a5ae with SMTP id
 d75a77b69052e-4e6eacd8493mr314392321cf.22.1760340722401; Mon, 13 Oct 2025
 00:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev> <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 00:31:50 -0700
X-Gm-Features: AS18NWDu76QxMqWFl0co_-djmn_p3UEoCDyJdLbE01KY7f7pO3sGwvsH0M73HRI
Message-ID: <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev fo=
r
> hlist_nulls")
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..c26cb83ca071 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hli=
st_nulls_node *n)
>  #define hlist_nulls_next_rcu(node) \
>         (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>
> +/**
> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
> + * @node: element of the list.
> + */
> +#define hlist_nulls_pprev_rcu(node) \
> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
> +
>  /**
>   * hlist_nulls_del_rcu - deletes entry from hash list without re-initial=
ization
>   * @n: the element to delete from the hash list.
> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist=
_nulls_node *n)
>         n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>  }
>
> +/**
> + * hlist_nulls_replace_rcu - replace an old entry by a new one
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
> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
> +                                          struct hlist_nulls_node *new)
> +{
> +       struct hlist_nulls_node *next =3D old->next;
> +
> +       WRITE_ONCE(new->next, next);
> +       WRITE_ONCE(new->pprev, old->pprev);
I do not think these two WRITE_ONCE() are needed.

At this point new is not yet visible.

The following  rcu_assign_pointer() is enough to make sure prior
writes are committed to memory.

> +       rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
> +       if (!is_a_nulls(next))
> +               WRITE_ONCE(next->pprev, &new->next);
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
> + * Note: @old must be hashed.
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
> +static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node =
*old,
> +                                               struct hlist_nulls_node *=
new)
> +{
> +       hlist_nulls_replace_rcu(old, new);
> +       WRITE_ONCE(old->pprev, NULL);
> +}
> +
>  /**
>   * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>   * @tpos:      the type * to use as a loop cursor.
> --
> 2.25.1
>

