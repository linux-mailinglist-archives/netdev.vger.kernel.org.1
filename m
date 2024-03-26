Return-Path: <netdev+bounces-82309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C188D2C2
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76789B216DA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896013D8BF;
	Tue, 26 Mar 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gkrug4cE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702823FD4
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495148; cv=none; b=gugXa2tm+Bwkdn8cibuQ9dHNKgrE8kfKaEz8BlC4Jd6e8ikGJBzBs9+aEPpqD8h5GV8v9P0GwcpFRWpijkSWRe3wVG57K+Z6ud41pPD1Ao++uoUgQbqfYhqB95F/q0KO3gHvQlR82hb34YcxjljI7WgcSeaZBbniP+JnPX6VaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495148; c=relaxed/simple;
	bh=gV3W15R3vUX4PMPMBy4NHr1LJEqVzwAjypFsld2e6vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPj0hXV0SJT/lXVNUyQ2tDW0+JhKBQo3Qr2YHwzu2ygFE0EFklbhY5SkBy/zFQy66tzoQR55Lhmdo6ZNReAaP6nT6DZLzrdYBaRlCBetev2uKBBNuxHAFfVD92EX6hg2iM/UwDuvbg51GK/z3XesfA6HyUPkLiDiPG1Xhjb7aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gkrug4cE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed179f0faso239913276.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711495145; x=1712099945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9srQMmnnZCSWRPMoJxprJcNxewSqCITJAjKxwV38r4=;
        b=gkrug4cEvdx/hOtfnBL0NMAQLGbJKEPRR3HrKDQ12YohKAHHn/2nLEg9o0Th4ph2Ju
         7BJaeFKviwHAyXKJCXVk+XWusaQuyFao3Dz9fXjUo/B9V/SOdUYFsefpAcDXgoTbn34T
         oxv+M+dpVn0tc32JGBhvnIHHUuRyQPzEAgOj5Dy/EObpCTgROe4FPZAVtovyZPdRS8Cq
         rSi3yGQ2TEAqa1nj1W9UHm5dQmKZtni5LsHFde0w7qYhP//xVkCE4kyDYsQSINGR4Gb9
         Ku+VN9BWDc/zQKmyltQuQfn/1Nn8LDGFrEK/ocetmtKth6B1slA0MLkZAe8DmBJwb8zq
         3eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711495145; x=1712099945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9srQMmnnZCSWRPMoJxprJcNxewSqCITJAjKxwV38r4=;
        b=fwAVqziBM5I1P6arBdsO90HdKhe11AmkPjiZ3eudoa12uJBJitHLfuYc92D8l5PBoI
         r1mjQW6M1hTfjgVKvtAvRX0Kp8teJ7UHa0zl6BbVjrhBuZDwRnfWbIXJsjBE/WTZKu2y
         JFbDZl+mvI2FY09T+0y5lCQjaVOUyHioHNBqQQoTBZhdsCTxioQ59T/yG67qH7ikPYtI
         j+uStcd0YL5rg0XLOeQvuvDVP1sxS9WAd6eUHa/0oaY/Yblf9lPOJIxbevPN7LBMJAvc
         M8kwhw6RWCXaUtkQNclPfi8tR530Kzw1Yq+9d6GnqqS06rvmxu0mXWi16/J6q0HYB4U4
         OU4g==
X-Forwarded-Encrypted: i=1; AJvYcCXabpYjaqeZhiutCyeXoJl/mRXQ7O5zBGc6bh9N+lCe88U+Es5Li4xT2wvnvPrK17Yc+NZC146TKZfQZBkd87KuitJFElIA
X-Gm-Message-State: AOJu0Yxo6ADfclDC5nKiWfkw/Voc8/S9GrzXEYXrQ2jXMRN50HcIC1Df
	p7EKCJqSwNRT72kinFet1u93CF4eZQdxczu0ObzR1L+EHymeRJ0S8kal1AAsbOI8FU7/V5RcMJ2
	7SwZvxv4UALBppA5XsFOnjGUPpYU9Dt1Qwn8p
X-Google-Smtp-Source: AGHT+IHZCl5a5LSLxdzAHPK2twM4FaaOmPrWuH5fGSunYPFHu2sJaB6RxLHqA3h8hn/nXbcl460e1Lmn3DvZdDyIegY=
X-Received: by 2002:a25:c5c8:0:b0:dc2:2f3f:2148 with SMTP id
 v191-20020a25c5c8000000b00dc22f3f2148mr2061072ybe.29.1711495145444; Tue, 26
 Mar 2024 16:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
 <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
 <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
 <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com>
 <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
 <CAM0EoMnddJgPYR75qTfxAdKsN3-bRuqXrDMxuwAa3y95iahWFQ@mail.gmail.com>
 <CANn89iKrW4em3Ck=czoR32WBkhqXs7P=K3_dMX9hdv7wVGvKJA@mail.gmail.com>
 <CANn89iLzc7onLZ6c9OJ-8GW8DpoGHFNWagqttZ99hkhRzVpSOg@mail.gmail.com>
 <CAM0EoM=1DyZsgYnuTjXB88L=41g00pjat+Jq4jThpciXzcEKJQ@mail.gmail.com> <CAM0EoM=28nsomF9PniYNtpjD4+=+hVi-dA2befgW0OCz+v0y3Q@mail.gmail.com>
In-Reply-To: <CAM0EoM=28nsomF9PniYNtpjD4+=+hVi-dA2befgW0OCz+v0y3Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 Mar 2024 19:18:54 -0400
Message-ID: <CAM0EoMkQMgYF5isb9JOQDbUhoq3VeEt3a8L2qyD4xUfrtyyGYw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 11:27=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Mar 20, 2024 at 3:34=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Mar 20, 2024 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Mar 20, 2024 at 7:13=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2024 at 6:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > >
> > > > Nope, you just have to complete the patch, moving around
> > > > dev_xmit_recursion_inc() and dev_xmit_recursion_dec()
> > >
> > > Untested part would be:
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 303a6ff46e4e16296e94ed6b726621abe093e567..dbeaf67282e8b6ec164d0=
0d796c9fd8e4fd7c332
> > > 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4259,6 +4259,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struc=
t
> > > net_device *sb_dev)
> > >          */
> > >         rcu_read_lock_bh();
> > >
> > > +       dev_xmit_recursion_inc();
> > > +
> > >         skb_update_prio(skb);
> > >
> > >         qdisc_pkt_len_init(skb);
> > > @@ -4331,9 +4333,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struc=
t
> > > net_device *sb_dev)
> > >                         HARD_TX_LOCK(dev, txq, cpu);
> > >
> > >                         if (!netif_xmit_stopped(txq)) {
> > > -                               dev_xmit_recursion_inc();
> > >                                 skb =3D dev_hard_start_xmit(skb, dev,=
 txq, &rc);
> > > -                               dev_xmit_recursion_dec();
> > >                                 if (dev_xmit_complete(rc)) {
> > >                                         HARD_TX_UNLOCK(dev, txq);
> > >                                         goto out;
> > > @@ -4353,12 +4353,14 @@ int __dev_queue_xmit(struct sk_buff *skb,
> > > struct net_device *sb_dev)
> > >         }
> > >
> > >         rc =3D -ENETDOWN;
> > > +       dev_xmit_recursion_dec();
> > >         rcu_read_unlock_bh();
> > >
> > >         dev_core_stats_tx_dropped_inc(dev);
> > >         kfree_skb_list(skb);
> > >         return rc;
> > >  out:
> > > +       dev_xmit_recursion_dec();
> > >         rcu_read_unlock_bh();
> > >         return rc;
> > >  }
> >
> > This removed the deadlock but now every packet being redirected will
> > be dropped. I was wrong earlier on the tc block because that only
> > works on clsact and ingress which are fine not needing this lock.
> > Here's a variation of the earlier patch that may work but comes at the
> > cost of a new per-cpu increment on the qdisc.
> >
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3789,6 +3789,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >         if (unlikely(contended))
> >                 spin_lock(&q->busylock);
> >
> > +       if (__this_cpu_read(q->recursion_xmit) > 0) {
> > +               //drop
> > +       }
> > +
> > +       __this_cpu_inc(q->recursion_xmit);
> >         spin_lock(root_lock);
> >         if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
> >                 __qdisc_drop(skb, &to_free);
> > @@ -3825,6 +3830,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >                 }
> >         }
> >         spin_unlock(root_lock);
> > +       __this_cpu_dec(q->recursion_xmit);
> >         if (unlikely(to_free))
> >                 kfree_skb_list_reason(to_free,
> >                                       tcf_get_drop_reason(to_free));
> >
>
> And here's a tested version(attached) that fixes both the A->A and A->B->=
A.

Sent a proper patch as RFC, Eric please take a look.

cheers,
jamal

> cheers,
> jamal

