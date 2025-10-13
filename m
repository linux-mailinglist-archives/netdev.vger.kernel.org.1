Return-Path: <netdev+bounces-228695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F2BD25F7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C414EFF4B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E72FA0D3;
	Mon, 13 Oct 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fq+m4d1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305852FDC3A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348971; cv=none; b=KZV2qYi/ZQ2O4iQCBHGVFHvqnwVy0LeFBbRCGTlS08i+FyUCfUWqi0TAxEIGUBWffF8dF1/dlpDX/G1hBNZOQdjT79G3eCJmhGnilwIQXALKatyoXlHfta4cwsX26qO/R5+edeStuZGNTIGIhLmZaXUVebCxOyzM0sHW5ZVuWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348971; c=relaxed/simple;
	bh=4nov9Jj558BeQ95uiThVM11nI3KKAb6whRBQXkXuQDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdBYoMWANICAWVKvZ0H2wAbCdQd78/V+OiY5dLK5WR1Nnml8Gs2cprtYTh0yT2ipIOgF8TDGNY+Xfd4HO4B1dDWrG+dbKVfx96dnXYoM6kCcFh79jk7qi4EaZ9sdqLqCLJv2coL7SiRte9k8HDfqcZE9i1ha7H+49WvvVj1GBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fq+m4d1p; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-80ff41475cdso82852786d6.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760348967; x=1760953767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+P8gMigxQo6JKHqVp52XwSzL9kMvXyrC7PM4myIfBA=;
        b=fq+m4d1phM8PkiXSq3pNUik4OX/Axdh+iC1LIo46USW+wBFt7GnBO/ouMBvZ2K3EI5
         aMehQ2aKZX0z512PR17tu3J0k9tYaWJiJG3MLUpDaEYOYLG8xYk3Zu0o05f4XtPZstW6
         CYUGUzQy6nkZXiVMw6t/uF5F0F7cs4lNXNWa5jVdYSiWHXSgSd8J886jALKHKBF3+yml
         VWgZPW43j/uo2QLcWFFOCMtnDwncYp7QAX/8Ql/42A7GJejMjjNrSi34DEW0uC9J/oub
         p0qHm2fEDv2Rm10dRmmo53nDMrnefCCZBzlylLKyHzfdVBqTIwFvxxRA367gcJb93t2e
         1M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348967; x=1760953767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+P8gMigxQo6JKHqVp52XwSzL9kMvXyrC7PM4myIfBA=;
        b=aDLkfBahHHAMOAUVBMGNFTQi4rjeuxKpbSTMICI7vPDkMske4/qUr5hPbZ574EtluF
         GLSL48QBjs455dnqK2CiQjBvDJhrm4rpKOUyX5dqDtUbBremvv1RhIr/mbZYmc5+pKoI
         VCS8AozSeJ716wkiX6bimERrTaEV12ojLbrfoxEIozB+aj/4U1caogdoN2CNtpHR5hdc
         7wUSMHR94Dvp4SCfmgiGsVjG9N5EBDIO2UnQqgmp+CdBx/1bSnjikmxJT444+CTzoPFg
         gY796rRGRuqshq3H//rdc53Rz9NxEoWl7K+KzoV03S3T6FPbh4viQ3d++MewS0funaZN
         iQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXhTEepOCEIDto+nWn6188yzXcDJf/dB295rQKZNTzDV40nnYXAVIGVZMMqq2YDMvcqKrZZkew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCTnxvXpjITIFFuGe5WNy7swmuSVW/Uhe4UQrBueDvJvk4Ywg
	MJWvktPWe9BPRtDAhrYtGfpEoAYWzhnEmQe1U38DXvlCzp7R2+uXucKHpGqchRPHkSIkEvx6Trs
	zLY7juqb3lKLWGp/TYV7kFrwMl1ls44JgaDlfMV14
X-Gm-Gg: ASbGncuFWHWHwNMmOLjVrJwoCK77Di3JHpGwsTzXnm02HpS4dMy5CCvOERDGx2iEgja
	yWLA6N0E6dZzG/gGhz0JRo9Ac6zEj1KdU4+aa0C7AS5RNR84X1xOAZ81tNc72xAjDjpNnlvhmgR
	3dVraceHrwXHtLNUGLg8vzM45pFCS2dyRJqtF3yfz+M+kJn0QiVxFbsQ5VYjWWTx2aG0yifzSJb
	hFsExHWnU4htk3BIvGTLFkFg2hIaV0TFQwHzCm466U=
X-Google-Smtp-Source: AGHT+IGvVSZlQx07IrE8SHZzHiA7UU0+Y0I+8HhJag0YsojwcXAlf/bVxhcX4AOuwhw7F5tjqBm1C0tX2Jul8zR6NCc=
X-Received: by 2002:a05:622a:554:b0:4df:d1e5:47ac with SMTP id
 d75a77b69052e-4e6ead07cadmr306061391cf.22.1760348966463; Mon, 13 Oct 2025
 02:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev> <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
 <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev>
In-Reply-To: <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 02:49:14 -0700
X-Gm-Features: AS18NWB6G6wjZ1a9k85i4wHSSQ6DX0cNBRDtRG67jmDyxRNC9o6gB4vLv6CD27k
Message-ID: <CANn89iLQMVms1GF_oY1WSCtmxLZaBJrTKaeHnwRo5p9uzFwnVw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:26=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
>
>
> =E5=9C=A8 2025/10/13 15:31, Eric Dumazet =E5=86=99=E9=81=93:
> > On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev> wrot=
e:
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> Add two functions to atomically replace RCU-protected hlist_nulls entr=
ies.
> >>
> >> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> >> mentioned in the patch below:
> >> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next =
for
> >> rculist_nulls")
> >> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev=
 for
> >> hlist_nulls")
> >>
> >> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >> ---
> >>   include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 59 insertions(+)
> >>
> >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nul=
ls.h
> >> index 89186c499dd4..c26cb83ca071 100644
> >> --- a/include/linux/rculist_nulls.h
> >> +++ b/include/linux/rculist_nulls.h
> >> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct =
hlist_nulls_node *n)
> >>   #define hlist_nulls_next_rcu(node) \
> >>          (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
> >>
> >> +/**
> >> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
> >> + * @node: element of the list.
> >> + */
> >> +#define hlist_nulls_pprev_rcu(node) \
> >> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
> >> +
> >>   /**
> >>    * hlist_nulls_del_rcu - deletes entry from hash list without re-ini=
tialization
> >>    * @n: the element to delete from the hash list.
> >> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hl=
ist_nulls_node *n)
> >>          n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> >>   }
> >>
> >> +/**
> >> + * hlist_nulls_replace_rcu - replace an old entry by a new one
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
> >> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *o=
ld,
> >> +                                          struct hlist_nulls_node *ne=
w)
> >> +{
> >> +       struct hlist_nulls_node *next =3D old->next;
> >> +
> >> +       WRITE_ONCE(new->next, next);
> >> +       WRITE_ONCE(new->pprev, old->pprev);
> > I do not think these two WRITE_ONCE() are needed.
> >
> > At this point new is not yet visible.
> >
> > The following  rcu_assign_pointer() is enough to make sure prior
> > writes are committed to memory.
>
> Dear Eric,
>
> I=E2=80=99m quoting your more detailed explanation from the other patch [=
0], thank
> you for that!
>
> However, regarding new->next, if the new object is allocated with
> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in commi=
t
> efd04f8a8b45 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->next fo=
r
> rculist_nulls=E2=80=9D)?
>
> Also, for the WRITE_ONCE() assignments to ->pprev introduced in commit
> 860c8802ace1 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->pprev f=
or
> hlist_nulls=E2=80=9D) within hlist_nulls_add_head_rcu(), is that also unn=
ecessary?

I forgot sk_unhashed()/sk_hashed() could be called from lockless contexts.

It is a bit weird to annotate the writes, but not the lockless reads,
even if apparently KCSAN
is okay with that.


>
> [0]: https://lore.kernel.org/all/CANn89iKQM=3D4wjCLxpg-m3jYoUm=3DrsSk68xV=
LN2902di2+FkSFg@mail.gmail.com/
>
> Thanks!
>
> >> +       rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
> >> +       if (!is_a_nulls(next))
> >> +               WRITE_ONCE(next->pprev, &new->next);
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
> >> + * Note: @old must be hashed.
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
> >> +static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_no=
de *old,
> >> +                                               struct hlist_nulls_nod=
e *new)
> >> +{
> >> +       hlist_nulls_replace_rcu(old, new);
> >> +       WRITE_ONCE(old->pprev, NULL);
> >> +}
> >> +
> >>   /**
> >>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given t=
ype
> >>    * @tpos:      the type * to use as a loop cursor.
> >> --
> >> 2.25.1
> >>

