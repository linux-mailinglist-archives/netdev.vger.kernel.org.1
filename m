Return-Path: <netdev+bounces-223853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46230B7E50D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09B53A873A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331A21CA02;
	Wed, 17 Sep 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwtB0hZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46612249F9
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083266; cv=none; b=mi45k9NLHXBKZwTnN2O7klkYnTnKIQqL8g4DmMKqGBFNbGOycxiuSZ3mL2wKDGwBKtSTlB/S4w3JX1I86RlRuIzLVQhshpshM1nkmccH+nlu2dyDomULIsqdEWxqaWLj0F4IGEvefY4BDE64ddVb+2Hofxj8Xshb1OXgQlg+Vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083266; c=relaxed/simple;
	bh=XSep2r7wb8sNiQbyD1y95/7yARR136LBBQAD2PQkm44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmSWOBHTE6u9zLN0jiFVjZuI2hrdcSdh51U9TlJUQ0VX6VB6ZBZJMuLU9g25gFAj1fDYyxTcpXX3oJ3OCDO0guaZ0b8N970o0wrzdmZ3xkTIbW0og+TzF3Rs3nR2lcM9vyhGSEpezkPl4Km+trarXizlSSRQYfadZOQmEAiUUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwtB0hZe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c8ef94e5dso4656085ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758083264; x=1758688064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjxWdD1Z9k9YSaYLnca6+xrg7vEIEtuDytYAHnT4eFo=;
        b=YwtB0hZe40z31a3y96DB0345OSzcj6JLWosYr2nXqH6ZS4wwr7pp6B2OHLYvBgAWQx
         D5qnKtXHHBSj6nPqyDl0CVSop96fxUq7oGg76E03MF4PM2mYdF6KGgfg1EXTXUq6AAni
         nyg0RtObi8EQy8C3Jv3aInTBgjX1+GR1gYtlVyRbPRbU5/a6O+0Orc90LBheMegannOT
         DRTKtTv6LspQoNn2WGAouUnjYaNOwBaETHIgyYFsnJPWk1pMp3aBLMyYsLyFJ3+8/Q6B
         HH//RZh5iSrVxE+VnkMS0VSwjP1t3m+/oIT10WV0Nb7lS01pPhdMp/MgozbmCW0hN6X9
         EVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758083264; x=1758688064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjxWdD1Z9k9YSaYLnca6+xrg7vEIEtuDytYAHnT4eFo=;
        b=KBjMaJ8QwJa6wk1kYsc5IH6d3yyzpEDVcDc0BzAT4sMXLc2Gt+ak0ijnNE1pqKPKxt
         IpFY320oqjEY3rbDivEmXLnJ0kRKrH3ib8ebZc4ShqAKHmTl+jmj7UL/pl8RtEVj7dzx
         lfYW1puO7b6NyM94ZDK4W8iFm2VhRwqrxVf9OSy9uJtclP//asiBmHM7i0OsCLWZT6zE
         p1IE7h31yp54bAZasCifiYw9kfK0X2iZlrqoiVLSIxuM/k0gflbE5lMUez9Su4WN05bF
         YQRhrLE33mT1/g3UUpnQrxlmniF3NehVlyaQ5TIXWAPxgyaWwvvVCzXO+6pGcoAbU1x+
         1xbw==
X-Forwarded-Encrypted: i=1; AJvYcCXcz0R9e0hJ/36FCJJw1ospLalVWlibKLsURU59px3nYLzhp4DICk+hB2qitcf+d+iyLuehigI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtJSh5J6iHi//QOkx/P/6lIHTNLPCPLUNeuRQAxtUx8SWm38T
	27liPp46aHNshsvp5TtgGQ//cJQ1Cx5DKfHrNnmH01EJAORm/hwZ+7bqAwrFFEzhZ5mJgmHGW9+
	/+/RU/dL/fAtWyL+qOhefVqWITLmvMfpv6+C5sonP
X-Gm-Gg: ASbGncvqIIDqjPAD1fUyxRSNl6u6j6zqDrTKY/nEgiP1Y0yfWxW4IrFUNGFXShM7rPC
	PnWdFOEOb40KM2dk3qRSvoBPyNgFptOz/dud1b5rxKK1+WIo6Bcsy99uybMiJnPYO9xSg6KHdsH
	OFBQnKZlfFCKGlWTniM5IL/NIH0lpqPf09sJfLoA9rhSqv8f13f7pdW2UyHHpA3tiL2NVK/GDU0
	zO7NF8Mbj1b4iL+Oy564mn/3/c9MK3mK1v+nL01lRUx1Q==
X-Google-Smtp-Source: AGHT+IFiqW/MHq4nw60MWwXqj2qoPzQYaDia3toOVd3Zz17x/wNFJ2UPnsuRYyEcjh2hf3Mtdx6TPyV0DFXqBwMc6ZQ=
X-Received: by 2002:a17:903:f8b:b0:267:c172:971a with SMTP id
 d9443c01a7336-26810a00e3bmr9795105ad.18.1758083264117; Tue, 16 Sep 2025
 21:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-2-xuanqiang.luo@linux.dev> <CAAVpQUDYG1p+2o90+HTSXe1aFsR4-KWZtSPC7YXKDuge+JOjjg@mail.gmail.com>
 <bdc27331-e1a3-4e49-ba58-d5b41171be3e@linux.dev>
In-Reply-To: <bdc27331-e1a3-4e49-ba58-d5b41171be3e@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Sep 2025 21:27:32 -0700
X-Gm-Features: AS18NWAY95vvjKvo66KaVMPH475KjdPcV1pHOf-l-C8xFC_P1JSGDxIEt8fgy3g
Message-ID: <CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:27=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/9/17 02:58, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Tue, Sep 16, 2025 at 3:31=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote=
:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> Add two functions to atomically replace RCU-protected hlist_nulls entr=
ies.
> >>
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 61 insertions(+)
> >>
> >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nul=
ls.h
> >> index 89186c499dd4..8ed604f65a3e 100644
> >> --- a/include/linux/rculist_nulls.h
> >> +++ b/include/linux/rculist_nulls.h
> >> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hl=
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
>
> Do we need to use WRITE_ONCE() here, as mentioned in efd04f8a8b45
> ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")?
> I am more inclined to think that it is necessary.

Good point, then WRITE_ONCE() makes sense.

>
> >> +       WRITE_ONCE(new->pprev, old->pprev);
> > As you don't use WRITE_ONCE() for ->next, the new node must
> > not be published yet, so WRITE_ONCE() is unnecessary for ->pprev
> > too.
>
> I noticed that point. My understanding is that using WRITE_ONCE()
> for new->pprev follows the approach in hlist_replace_rcu() to
> match the READ_ONCE() in hlist_nulls_unhashed_lockless() and
> hlist_unhashed_lockless().

Using WRITE_ONCE() or READ_ONCE() implies lockless readers
or writers elsewhere.

sk_hashed() does not use the lockless version, and I think it's
always called under lock_sock() or bh_.  Perhaps run kernel
w/ KCSAN and see if it complains.

[ It seems hlist_nulls_unhashed_lockless is not used at all and
  hlist_unhashed_lockless() is only used by bpf and timer code. ]

That said, it might be fair to use WRITE_ONCE() here to make
future users less error-prone.


>
> >
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
> > As mentioned in v1, this check is redundant.
>
> Apologies for bringing this up again. My understanding is that
> replacing a node requires checking if the old node is unhashed.

Only if the caller does not check it.

__sk_nulls_replace_node_init_rcu() has already checked
sk_hashed(old), which is !hlist_nulls_unhashed(old), no ?

__sk_nulls_replace_node_init_rcu(struct sock *old, ...)
  if (sk_hashed(old))
    hlist_nulls_replace_init_rcu(&old->sk_nulls_node, ...)
      if (!hlist_nulls_unhashed(old))


>
> If so, we need a return value to inform the caller that the
> replace operation would fail.
>
> >
> >> +               __hlist_nulls_replace_rcu(old, new);
> >> +               WRITE_ONCE(old->pprev, NULL);
> >> +               return true;
> >> +       }
> >> +       return false;
> >> +}
> >> +
> >>   /**
> >>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given t=
ype
> >>    * @tpos:      the type * to use as a loop cursor.
> >> --
> >> 2.25.1
> >>

