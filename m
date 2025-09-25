Return-Path: <netdev+bounces-226483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163BBA0F65
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7791C24F12
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B493064B2;
	Thu, 25 Sep 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYWDofhy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03481DE3DC
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823030; cv=none; b=PLORIk7I9dKSjSxqvh6ON0axa418UMjs11JeMFUtZRIpr+a9PihgcmwpDX8GKcUJdHvZnD9ArBxLfltuHzdROgB/qdi0J0h9kqdngiMiDDPwGxDBKaKUoI3J78f2GEKw0dgw7jpBuOBJc7GhttEiHzn2Kh3og//PTGTaoiZ1jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823030; c=relaxed/simple;
	bh=EbdG7V81pu90iejsyhKo95owybGLx96TwDOKu3dMPRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV/M0+ygsPmNaVy9ZC4TzTW7e4FxxOtGOo6O0WpIqb8fBNFwD5mE8iADKkReFPFZ0mAIjWfPXiL/uVcxpWsL+9fe9zGtXpjRvHCoZwB2zghiRu/vIJ4CIm7zMBKbhV/UOpfUtQrp9NZcXgg2/aAH2MMAkCTlmEoAQwLq5rM6yLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYWDofhy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso1356381a91.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758823028; x=1759427828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqXkB57On4uS8bDc2xWGndi8Elal12GhorDr1bW3AFI=;
        b=SYWDofhypPin1+LXVZZ9rIFE9VzvNXJwdED1QIuCB9W3k4h0DT5FHNSLNJjMN87gHD
         dnMIKZSpt2tYmRqtmhOe1acIGr6TT/TpsO33PvR0Tl6mVovgXY7MLhLzUYfqcFDRYU0I
         Rg7WbPIR9rjXxxG/FvW9WsTqCBZrwLwvtD8ELLBvYbmxVrO2XLoyPr7hNcv/8ODP10IN
         TtUVI6uxwNZ/HVq0OBdaGejTIcdqCLVsXecrlvJWfO3kcvtWK/lLy0NgwY6pIiAhOjzQ
         GCwSQvfwpUtRjLfabHG2CYhkubkK7/xVCqKE5SJ3AcvhQlvR1lvPzA/GUMqB69/5gurB
         E8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823028; x=1759427828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqXkB57On4uS8bDc2xWGndi8Elal12GhorDr1bW3AFI=;
        b=Wbc+2ht//WOHZ/omVzR8eZr6zD8gpfifl11A3ZLeSxfWJSoexesiJeeboaX5SjcPnY
         4TnJobz2bRrwLGA0WJj+mHkY6SXOtOaBJ9yBYclmQRQtOlcrqAMvci79tFaE67923BgD
         Sx/U6fyRXG3ahxd2Y8AINh0+MjvtRwxAPeXHsDjSP3wQWoKsCXXVFAkeGGEl3xUsKQrI
         S6W01gqmgTMlMH37Buf20NH0zxeBAJAg0o3W21yMYwvMSpIe3j6gmvlulLP3UArRdVEe
         HBgPqP60zRbKBo181jmvBAjvrlDxKCbSn9Oh/qlt3TMx9lTJTzpyMW8B7Ibho55d+AAx
         /Pww==
X-Forwarded-Encrypted: i=1; AJvYcCUe29HUUNipdbTr49Sx8MjZJirPlNPJVi/NptLGzo5wjK3cALDlUBCnoYNNZ53ppafVsn6hQzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vH0q/1URBBXobV6Gy0WRP5pyCKtkEaVa8Q8VVf2unFE/MSqd
	OOZ1oxm6dYXVdeqxsp5zXVLI5lHJQ0IA/ERS1Rqy/89YwPrrolYjKAXtIZ3Owzmr0gyARPT8zB/
	nMfDHkZVEEYbILeOb9ZcUT6qv6kFF9PupESXdixV+
X-Gm-Gg: ASbGnctbudD2gKpB4qQTpfgGiOeMt3rDcy+3dYS/CezgDo+sAyUX9MxhvIF3vU3wN9+
	pxRS6Ika8EBRzyzowllzFrhyAfgLYGkq2rJJP3Vd8zXgE53+ZqmVhNg0UcogpbuUitdcdDTCDkV
	FJOsnuV8zk0cc0lVGGfb0bEH/G51zOzjJQk2tMXeLMvMYs5Yx4laZrM6ZVbPVRQ4hgHdcyIcHNQ
	dU4Qtr92uwQ1Jxz7G573//TS4tIM+vT2yAF12TusUNi3OU=
X-Google-Smtp-Source: AGHT+IFKhEQRlR2jQiD3UJ5dJi86a0xkbeDXxuCH4Cep+fCFsRCI2p43BRTLMkgVWiYwJ8xiCQG1tE9kV63KS/HtMv8=
X-Received: by 2002:a17:90b:4b10:b0:32b:ab04:291e with SMTP id
 98e67ed59e1d1-3342a2af4b5mr4299628a91.25.1758823027636; Thu, 25 Sep 2025
 10:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev> <20250925021628.886203-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250925021628.886203-2-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 10:56:56 -0700
X-Gm-Features: AS18NWBvTLzsJFJbo144ff1nH8QOme_2CBK4VXbI_Wy8AWNA-iOI7iKVnZxz-5c
Message-ID: <CAAVpQUDNiOyfUz5nwW+v7oZ-EvR0Pf82yD0S2Wsq+LEO2Y2hhA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:18=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
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
>  include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..c3ba74b1890d 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -152,6 +152,58 @@ static inline void hlist_nulls_add_fake(struct hlist=
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
> +                                            struct hlist_nulls_node *new=
)

nit: checkpatch complains here..
https://patchwork.kernel.org/project/netdevbpf/patch/20250925021628.886203-=
2-xuanqiang.luo@linux.dev/

CHECK: Alignment should match open parenthesis
#46: FILE: include/linux/rculist_nulls.h:171:
+static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
+     struct hlist_nulls_node *new)


> +{
> +       struct hlist_nulls_node *next =3D old->next;
> +
> +       WRITE_ONCE(new->next, next);
> +       WRITE_ONCE(new->pprev, old->pprev);
> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev,=
 new);

nit: define hlist_nulls_prev_rcu() like hlist_nulls_next_rcu().


> +       if (!is_a_nulls(next))
> +               WRITE_ONCE(new->next->pprev, &new->next);

nit: s/new->next->pprev/next->pprev/

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

