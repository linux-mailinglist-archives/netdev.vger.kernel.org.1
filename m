Return-Path: <netdev+bounces-223855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC48B7F6C4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89075248BB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A543223DE8;
	Wed, 17 Sep 2025 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxCMhpME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3B22156C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084218; cv=none; b=skhX0VAbCX1U+m+VJXdPOPQ0cbwCa6v7Xqpvf8jW3lDsO1g5CGLru4nC+bTEROwNxW+tS1YlKJBt3/tujNOXvTdLU6Jrwpm+1BTUnLoWyHARJOEs7uwd+P2uOZeFTeRSiGVmQx1dCAuDmrOnbxfajVuzLhx9+EAEL+hZQcLy8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084218; c=relaxed/simple;
	bh=fu+pZ2ywPQImOG/u7gGvyw+wiuAmQrkL6FU3kHI+KV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iv9k7SXEZncNbqQqJeuvAO0qoRxZ74zimvoURgd0OvHp9PxpioQcgeuxVNOz1NP+n+Gph/q5yJmI2FyAoGvUdXA1+YQB5OKVmKiImcKVa+1SURYeywL+cB4nqb+hIxLcsYHIURdI74VpRnuMiLL69jeOcd2Bu1R+1EDIqAPfWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxCMhpME; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso76796b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758084216; x=1758689016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUvfmrYQXqZ+rb/98/pL4+tRI50tRGmujVjYS4co4eM=;
        b=JxCMhpMEl9q0Y4VWO3eqX17Jn21Yeg5aByxU1w3Ysai6tXYPjmw6ti+VGedXeU1Pxk
         WV6ocsEpB3gay+3P/S/liuXAmiD/4fLV2km7eAF64AHBdAhXir7Ck07eQUthOGppKu1/
         FFg+7uhEme3bNa3HV4ndCeIML2Vt9gVf40zXncjySRQjoupv1dToD9O0KARU+oQWCXMV
         W3e8ezmgQVTAmqebnkyWJhdyGw6OSGwVqXpnlCvQo/t7FGHcVaDFQBfouuDQNxkookab
         Sj3nAGAmTN/Qxcgrj5fOXzqbezC9hJhYyvAw5HYoxgvHqEs1f808I+5aVvrBxWLUPqe1
         4U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084216; x=1758689016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUvfmrYQXqZ+rb/98/pL4+tRI50tRGmujVjYS4co4eM=;
        b=hFqR7vln92/iE7xV+NRq17S6qm/tgRlxRp5ZPBE1Ou2HyEM4blLeCCi58jFx5SGWIz
         Y5alPmPEQSm5HNzUPefzgyZRrN2fgL+pidoBVB/BiNiP0xAx4NMA8P/RPvfJaTK6oMKq
         vXSgv/3ZYhU2kqy6xocWepIQqLOOklrxue8ppChQpUBPD6xy316WtGFy0L18n6vJfr2I
         WUm7tB7CxJVj6O5XM/F0w6XaJU8mqG10IIuu4viYCRV5D/BBsQuW2HIk0BZIdlbJ+uq9
         F2Gh45Ja8uYTZQye2DYixMZ7WFvA864uApo8LJ6y7FTJ1G3lo+WTQPd9PwVC+N0pZ+7p
         Johw==
X-Forwarded-Encrypted: i=1; AJvYcCVq1RH/cd/ED/C4/86ijQUqCX2/11m9FJkiG/8NszdkGPGvjEoPiV3DoJc0JJ9X13S4zcL/LbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ftp/6qdXfJlAuKLm+9F2cJ1xi1g4vMR8EAsPdJtvk6NzGKMb
	xI/05HFv6MsXQqyDNWmhC4gALuH+9/om236NVH+gIWpFEA64h5PfP/yVZ0KjKkAezmmJwDAs7Hq
	rG22Bmc/4p0ZoREsTG5AxxJ8Ubv4L/AZGIFxljC2AuUIUMzpnAnhac2yL50w=
X-Gm-Gg: ASbGncvQgujweeh7hls0cSTJp3ytqkdJDRgzpNtlH4LV8keS2qAckHgR3JclktBj3+g
	uSheUIfOm+8VJwHGKaqsnnemDITVubmzQIYqmoqJm/G7oxOgl61xhGMCpLkD39HHWOOEhlCSjHP
	CcCoEYWglWY1QbjPzWcMJXXJbgo9OxHYuX6UOguEiGRh/MPsOp6DzQZ5S8VIU4ClDSJfm+h8LrT
	EyH+D8jxAHx9wTaKcf+p8fDXETmHxYwp+M4aGC6bQ9Av6QQnwSckCSt
X-Google-Smtp-Source: AGHT+IEPAHPmmdBCcICEHPr63Pr6gC02NAY/0bBHudJojdbFlfK8XY1qMUgdyPDEl8DTtO/1PgFA9GHrEKBlAEPZuGc=
X-Received: by 2002:a05:6a20:7343:b0:266:1f27:a020 with SMTP id
 adf61e73a8af0-27aa3cf5bc4mr946468637.35.1758084215865; Tue, 16 Sep 2025
 21:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-2-xuanqiang.luo@linux.dev> <CAAVpQUDYG1p+2o90+HTSXe1aFsR4-KWZtSPC7YXKDuge+JOjjg@mail.gmail.com>
 <bdc27331-e1a3-4e49-ba58-d5b41171be3e@linux.dev> <CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com>
In-Reply-To: <CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 21:43:23 -0700
X-Gm-Features: AS18NWAzlSDzWx9xBrgkMWYktf-9nFiofYpOcrSs2O8-wd3EQgEaAT99rJbmqHs
Message-ID: <CAAVpQUAWijPEtD=1pp-u8tbqWUkJxn94+A12yfdVC0QwAiuTSA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:27=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Sep 16, 2025 at 8:27=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux=
.dev> wrote:
> >
> >
> > =E5=9C=A8 2025/9/17 02:58, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > > On Tue, Sep 16, 2025 at 3:31=E2=80=AFAM <xuanqiang.luo@linux.dev> wro=
te:
> > >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > >>
> > >> Add two functions to atomically replace RCU-protected hlist_nulls en=
tries.
> > >>
> > >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > >> ---
> > >>   include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++=
++++
> > >>   1 file changed, 61 insertions(+)
> > >>
> > >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_n=
ulls.h
> > >> index 89186c499dd4..8ed604f65a3e 100644
> > >> --- a/include/linux/rculist_nulls.h
> > >> +++ b/include/linux/rculist_nulls.h
> > >> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
> > >>          n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> > >>   }
> > >>
> > >> +/**
> > >> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
> > >> + * @old: the element to be replaced
> > >> + * @new: the new element to insert
> > >> + *
> > >> + * Description:
> > >> + * Replace the old entry with the new one in a RCU-protected hlist_=
nulls, while
> > >> + * permitting racing traversals.
> > >> + *
> > >> + * The caller must take whatever precautions are necessary (such as=
 holding
> > >> + * appropriate locks) to avoid racing with another list-mutation pr=
imitive, such
> > >> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running =
on this same
> > >> + * list.  However, it is perfectly legal to run concurrently with t=
he _rcu
> > >> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rc=
u().
> > >> + */
> > >> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_nod=
e *old,
> > >> +                                            struct hlist_nulls_node=
 *new)
> > >> +{
> > >> +       struct hlist_nulls_node *next =3D old->next;
> > >> +
> > >> +       new->next =3D next;
> >
> > Do we need to use WRITE_ONCE() here, as mentioned in efd04f8a8b45
> > ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")?
> > I am more inclined to think that it is necessary.
>
> Good point, then WRITE_ONCE() makes sense.

and it would be nice to have such reasoning in the commit
message as we were able to learn from efd04f8a8b45.

