Return-Path: <netdev+bounces-192260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58115ABF25F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB48F3A435D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8B21516E;
	Wed, 21 May 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LE0QMEYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A25A322
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825601; cv=none; b=WuB8Hfpxb3Ssugp+og3y6UV9v3nHhCseadzWYp09HYtZbE+Gd/iwNmzcjTw7tuyenHYJRHiSKGZJQDHKNTJ27glbZYxAx0D0OOK+CpQS+ZMGAwuXSjBwZsTogZXzFl4I3RKP8+coIZxeTZ4TFJWmzWCsyyIzistJfdbEP0N5chA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825601; c=relaxed/simple;
	bh=NicR8U1FNGfrvmFtufo8O2qGYGJVnnIbOuwhhdYAKec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTTtrsS4KkQyVvRCtwMpe3zXfF6aju4r2d5IWVnTA8tDkb53WgSMi+eXZ5OwkjnnSYWyhMmVeliO9f9ryfzT6fHu+P6c4jaHAQeQANVv7KbLKU9zvNOD4p1rKllQBOtPo94SUo9jdhx8WaK86p4EYrHO7smJSOtW1+llUOoYWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LE0QMEYv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c5f3456fso2928864b3a.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747825599; x=1748430399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXNQ4pNoXGXyHpi7zroPL7ccZ/a4UkyOQ0F0fviLUUQ=;
        b=LE0QMEYvFJ3vtuhbZLRWeupGKC7TxfQP/OL2VyuDMEgiYDbdxUEmTQHTIzXGaWKwv/
         f3PUOlQDjWSurUfNnTJOiA9R68hAPj/aN5Gc1YRzv2Nx3sSYcZ+9iDCrDt8OXrMUZ9xh
         Z3+DYy6y4OHW92TC9deUboMgENwfvKK8lP7fMITdSCvNfy7FYtW9F5RCXx6OcechZ7ry
         dN+Yi8cqHBMS6hOnHZ5wl1ShhBCVCtQ3+0tkmacv+36L1i8OanRFGIW6y9wvTBcCVYQs
         sGkbXP+hlWokVpyFueFxL9It5AMtImrJxAHyIY+EI7q14SJ6stmmmQ7Ec+65XwPcJEPg
         KUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747825599; x=1748430399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXNQ4pNoXGXyHpi7zroPL7ccZ/a4UkyOQ0F0fviLUUQ=;
        b=v6K/z7JKekbIkLAZfLnFKiAsFxupaZwaW1+F2lurgmSJ+2V2MbXdjFy/CVjRfRmGLZ
         kOMi9ER8XAlOxkunvqqOxUbU6LTb6YfafMCnVlEA7apDLZEaTXORyObRp0d4q77B1wQD
         CM/JQWT00W2gilweiuBi7gKupfGsLvH2UhT+q4bmnzvqPqtokQaI+OwwQ0VBC0mmPzsD
         y7duZQmk0tP02XfV9RLipuEc7ga8l5GLrEHzET3TmSNlClBMLar3fnKafCaMIDljQp3T
         FgRNXtZsTI+qx1uifsywi2xzLZtlnIxPQnniPP7RAwZe+ukLDLf6rQ7jscHei6G1EIlC
         7AEg==
X-Gm-Message-State: AOJu0Yz6+dmGqCVXi9E0I2BQfOkpQo3dSZvkLgFDz8Mbbstbbqoqd6f2
	0N69ik2FqOW41lH0FbJp2ULpKR4IDh/fjZNUsnkiWTk4rTJIpUL6c0zVeHHdCWeKooeyzYuBlTZ
	D8TimpM/0cakO0bAVh/mkBF5lHaEg3cuqNK8BxE3T
X-Gm-Gg: ASbGncsb2sWWPWMo8jFaagdswpViZvSpZ/WJn6I5DQ5QN2TkJ/dRdUwN4xv8yiToSh9
	NoZQLKgpI4Sv4phY8vJc99D34FS86DULN6ILO+UVHI47Da+E/Q+yz1XLKdygyh1nhfR9HyV0oJQ
	1HleFzlO3hd96CiqXPnmnDo4exp435CCxHhVvqYqESrg==
X-Google-Smtp-Source: AGHT+IEh+MIsBWa//0l9AHD/Nc9+C6kCiOSpUEvGuCdWF37Xcye3Y1UiRyXF56F9J1IKdYOAxUAN/EZyKPQ8mUkAj+g=
X-Received: by 2002:a05:6a00:9157:b0:742:a0c8:b5cd with SMTP id
 d2e1a72fcca58-742a988b3c3mr25198491b3a.19.1747825598680; Wed, 21 May 2025
 04:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com> <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
In-Reply-To: <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 May 2025 07:06:27 -0400
X-Gm-Features: AX0GCFvTcAUiT5zoEATNLz2UBXGdKpsJsPxXormIa6p_vcC_mlGNCuOOmjlBel4
Message-ID: <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:04=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Saturday, May 17th, 2025 at 2:09 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> >
> > Unfortunately we cant change the approach of looping to the root at
> > this point because it may be expected behavior by some setups.
> >
> > To the setup in the script you shared: that is most certainly not a
> > practical setup
> > So, two approaches to resolve it:
> > 1) Either we disallow altogether the ability to have a hierarchy of
> > netems in a qdisc tree. It would mean to scan the tree on
> > configuration and make sure there's not already a parent netem in
> > existence. If you want to be more fine grained we can check that netem
> > is not trying to duplicate packets
> >
> > or 2) we put a loop counter to make sure - for the case of netem - we
> > dont loop more than once (which i believe is the design intent for
> > netem).
> >
> > cheers,
> > jamal
>
> Hi Jamal,
>
> We decided to opt for the second approach by adding a bitfield in sk_buff=
. We also moved the duplication to happen after the original sk_buff finish=
es the enqueue to avoid using a stale limit check value.
>

I am afraid using bits on the skb will not go well around here - and
zero chance if you are using those bits for a one-off like netem.
Take a look at net/sched/act_mirred.c for a more "acceptable"
solution, see use of mirred_nest_level.

Not that it matters but I dont understand why you moved the skb2 check
around. Was that resolving anything meaningful?

cheers,
jamal

> We also considered the first approach by traversing the tree and checking=
 for netem_ops as a way to idenitfy the netem qdisc, but feel that this is =
not very elegant.
>
> Of course, this approach would disable duplication in netem qdiscs
> that are children of a netem qdisc with duplication. However, we
> are not aware of a good way to do a real de-duplication check like that f=
or sk_buff. Let us know what you think of this patch below.
>
> Best,
> Will
> Savy
>
> From 33af24d4bef8b141b608fa513528a804f689f823 Mon Sep 17 00:00:00 2001
> From: William Liu <will@willsroot.io>
> Date: Mon, 19 May 2025 08:46:15 -0700
> Subject: [PATCH] net/sched: Fix duplication logic in netem_enqueue
>
> netem_enqueue's duplication prevention logic is broken when multiple
> netem qdiscs with duplication enabled are stacked together as seen
> in [1]. Add a bit in sk_buff to track whether it has previously been
> duplicated by netem. Also move the duplication logic to happen after
> the initial packet has finished the enqueue process to preserve the
> accuracy of the limit check.
>
> [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/
>
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
> ---
>  include/linux/skbuff.h |  4 ++++
>  net/sched/sch_netem.c  | 31 +++++++++++++++----------------
>  2 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index b974a277975a..e6b53af6322b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -844,6 +844,7 @@ enum skb_tstamp_type {
>   * @csum_level: indicates the number of consecutive checksums found in
>   *     the packet minus one that have been verified as
>   *     CHECKSUM_UNNECESSARY (max 3)
> + *      @netem_duplicate: indicates that netem has already duplicated th=
is packet
>   * @unreadable: indicates that at least 1 of the fragments in this skb i=
s
>   *     unreadable.
>   * @dst_pending_confirm: need to confirm neighbour
> @@ -1026,6 +1027,9 @@ struct sk_buff {
>     __u8            slow_gro:1;
>  #if IS_ENABLED(CONFIG_IP_SCTP)
>     __u8            csum_not_inet:1;
> +#endif
> +#if IS_ENABLED(CONFIG_NET_SCH_NETEM)
> +   __u8                    netem_duplicate:1;
>  #endif
>     __u8            unreadable:1;
>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..ce6e55b49acb 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>     skb->prev =3D NULL;
>
>     /* Random duplication */
> -   if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
> +   if (!skb->netem_duplicate && q->duplicate &&
> +       q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
>         ++count;
>
>     /* Drop packet? */
> @@ -531,21 +532,6 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>         return NET_XMIT_DROP;
>     }
>
> -   /*
> -    * If doing duplication then re-insert at top of the
> -    * qdisc tree, since parent queuer expects that only one
> -    * skb will be queued.
> -    */
> -   if (skb2) {
> -       struct Qdisc *rootq =3D qdisc_root_bh(sch);
> -       u32 dupsave =3D q->duplicate; /* prevent duplicating a dup... */
> -
> -       q->duplicate =3D 0;
> -       rootq->enqueue(skb2, rootq, to_free);
> -       q->duplicate =3D dupsave;
> -       skb2 =3D NULL;
> -   }
> -
>     qdisc_qstats_backlog_inc(sch, skb);
>
>     cb =3D netem_skb_cb(skb);
> @@ -613,6 +599,19 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>         sch->qstats.requeues++;
>     }
>
> +   /*
> +    * If doing duplication then re-insert at top of the
> +    * qdisc tree, since parent queuer expects that only one
> +    * skb will be queued.
> +    */
> +   if (skb2) {
> +       struct Qdisc *rootq =3D qdisc_root_bh(sch);
> +
> +       skb2->netem_duplicate =3D 1;
> +       rootq->enqueue(skb2, rootq, to_free);
> +       skb2 =3D NULL;
> +   }
> +
>  finish_segs:
>     if (skb2)
>         __qdisc_drop(skb2, to_free);
> --
> 2.43.0

