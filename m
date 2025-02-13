Return-Path: <netdev+bounces-165728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C1A33413
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB3F167590
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D373D984;
	Thu, 13 Feb 2025 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nxiu3aeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C903232
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407100; cv=none; b=RX7BeyayMWl2sND0SWxYRrwxX+d4YYU0sMj+CoqDxqLd3C7QsgQFGjd04APsnkayE1qyeVa/sOw3V/UIBArDj2pgD4ZaEfjzvsv6vydAbfPKtBe1LlB7LNK+Q5VVy0Kj4oi5H04pLJph3aJykyCA4BPmQSlyY8uHgaPaQO9uMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407100; c=relaxed/simple;
	bh=13UP63ZkmlzEcLIULb4lkVrpklgTXlFI3VAsBRP4lYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjpRGsxt28vtuyjr/7Ikmae3qzd833w5WiZX4bVsMdcvCYMCFiJJVnPeibHI0fsgNSM4+qYAJGCw/tldONjZjl++Z85J4lCQTAO0tkx8IgHeArabwZzcgpr4/O76I6duhn5Bs79Ob/tMWhk3IXEZ4Qkq3t/LR+7t8TN9PEOoJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nxiu3aeJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f032484d4so28835ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739407098; x=1740011898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EJboSgA5eBymMYU1PisqE5zQYXCC0Q7jB9CcaDtWkE=;
        b=Nxiu3aeJS0xp6ERXoW4gnhpIGqpsFojzxSL1wMafnooICrnOqBRzMFGIVth4z7hH3E
         9h4MuRGuV+RHHK7aylszAr0Ugp98xrQiuC4K+Y36/LlgkwkIwD/uxVcWrlFLuEU+DkuJ
         UZrMuoJPeuN7iAokqXo43j3M2rQf4nm5lsxS1bEgnrumE86RWd0Qi3v3Ua3pv9el6M6v
         6Jquey9wCaFjFLGZqKh47bR1Dd0TykMwmDTGcbThP4W7/BdfeP9c716dK/jY/+0/Vx+K
         gyjleq6Cfm1/6M1OFzQfj60XdX0vaOMxrhSQyCCsdvamYtTh8IqPpG+HK2gxqrXPlXxR
         G6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407098; x=1740011898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EJboSgA5eBymMYU1PisqE5zQYXCC0Q7jB9CcaDtWkE=;
        b=roCBfEImfK8i+tOJxWBHY/UxifioNQhjZkOx+CNMSIzgZ6dF1irDdhiPN8X+95ZEkU
         U9p7J3MrDXHLTZEiVaiYqobqCjDzJMegDCknmDfBQUPUGa39LjG7RxxDEqYyo6/EneIA
         +3mtwkx5uttKl7XVsWPiANRhIo3O1l0xPw3V1LwXabMMYzu6P1DhmyKT1/r2hgFidBhu
         RaCn72vhAJIhzxm00FudU/kjieP0qiH/wxZdiis5bOD7Q5mDyYcIKELvYXd/RM0b/biM
         9vi8huJT5nVcIZmUSZ7BlKYUAl7Dz/OLeqIhMpSs4FFaX4CiXxjl5yVeI2YCnVAtAhAg
         MHUw==
X-Forwarded-Encrypted: i=1; AJvYcCXLXqBNRbB6iCTmpOUJpMY8rZXoFwEMaISdebruKeITDGN9HQg0HZBnsMpHoFwj3/3K3+/Li2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8Mxxf4BZ2JytrBeWFaFH29L4ePzHnI0uHwj3BNxaHpRedJQO
	nPE2rbiL5a2YquossfUfnQ0H5OlLWBqgpl+QKXCSGcgzBAkODJaasbIGm8LYOk/mfEhWefOHqkJ
	dhZJHJzMXvA2ARPZnS+ybCg+18XvLP7g/DYUB
X-Gm-Gg: ASbGncs42IQPFsxD1XnF3x1DH7vJosqUW3LILI+CPruAsuqwSHoIYwBfm/8OOhCcQxN
	+L9FNU0tTbvBgkJXx5K5aUnQDjL64d/eTZOuBedfx10rq8Ypo/GKZUzqeqSfjRnToFjV0VTvKBB
	ruT67Lo3LfK1ccLQ/8c34QhxXqE3Q=
X-Google-Smtp-Source: AGHT+IFO+TE/FjEdQkzgg0aeUryTdSY0OWjwgwMYriv+G9qBvrfKxF/qg2KxCqyED/w9UyNe0qZGLfug/6Cl2r8NX5w=
X-Received: by 2002:a17:902:f689:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-220d35a2297mr1064725ad.26.1739407097596; Wed, 12 Feb 2025
 16:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
 <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com>
 <CAHS8izNSG_fC7t3cAaN0s3W2Mo-7J2UW8c-OxPSpdeuvK-mxxw@mail.gmail.com> <CAL+tcoD0CT_JmDcLEY6VGq2_+oU=TgHRfY6LPG70By3gm5CP0A@mail.gmail.com>
In-Reply-To: <CAL+tcoD0CT_JmDcLEY6VGq2_+oU=TgHRfY6LPG70By3gm5CP0A@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Feb 2025 16:38:04 -0800
X-Gm-Features: AWEUYZldTMyPBIiMBwNXz7bPf1BS_rU5-upFJppzNFcrnh51o9iaPiQlHtA5QTg
Message-ID: <CAHS8izNyeOThGCt=tO-0xoAEOsoQJLF_DJxF1iV8zJnJoyW-=g@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:39=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Feb 13, 2025 at 3:24=E2=80=AFAM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 10:37=E2=80=AFAM Mina Almasry <almasrymina@go=
ogle.com> wrote:
> > > >
> > > > On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > If the buggy driver causes the inflight less than 0 [1] and warns
> > > >
> > > > How does a buggy driver trigger this?
> > >
> > > We're still reproducing and investigating. With a certain version of
> > > driver + XDP installed, we have a very slight chance to see this
> > > happening.
> > >
> > > >
> > > > > us in page_pool_inflight(), it means we should not expect the
> > > > > whole page_pool to get back to work normally.
> > > > >
> > > > > We noticed the kworker is waken up repeatedly and infinitely[1]
> > > > > in production. If the page pool detect the error happening,
> > > > > probably letting it go is a better way and do not flood the
> > > > > var log messages. This patch mitigates the adverse effect.
> > > > >
> > > > > [1]
> > > > > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > > > > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> > > > > ...
> > > > > [Mon Feb 10 20:36:11 2025] Call Trace:
> > > > > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > > > > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > > > > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > > > > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > > > > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > > > > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > > > > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > > > > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> > > > >
> > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > ---
> > > > >  net/core/page_pool.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > > index 1c6fec08bc43..8e9f5801aabb 100644
> > > > > --- a/net/core/page_pool.c
> > > > > +++ b/net/core/page_pool.c
> > > > > @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *po=
ol)
> > > > >         page_pool_disable_direct_recycling(pool);
> > > > >         page_pool_free_frag(pool);
> > > > >
> > > > > -       if (!page_pool_release(pool))
> > > > > +       if (page_pool_release(pool) <=3D 0)
> > > > >                 return;
> > > >
> > > > Isn't it the condition in page_pool_release_retry() that you want. =
to
> > > > modify? That is the one that handles whether the worker keeps spinn=
ing
> > > > no?
> > >
> > > Right, do you mean this patch?
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 8e9f5801aabb..7dde3bd5f275 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1112,7 +1112,7 @@ static void page_pool_release_retry(struct
> > > work_struct *wq)
> > >         int inflight;
> > >
> > >         inflight =3D page_pool_release(pool);
> > > -       if (!inflight)
> > > +       if (inflight < 0)
> > >                 return;
> > >
> > > It has the same behaviour as the current patch does. I thought we
> > > could stop it earlier.
> > >
> >
> > Yes I mean this.
>
> I'm going to post the above diff patch in V2. Am I understanding right?
>

Please also add Jakub's request, i.e. a code comment indicating why we
return early.

Also, now that I look more closely, we want to make sure we get at
least one warning when inflight goes negative, so, maybe something
like (untested, may need some iteration):

```
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2ea8041aba7e..6d62ea45571b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1113,13 +1113,12 @@ static void page_pool_release_retry(struct
work_struct *wq)
        int inflight;

        inflight =3D page_pool_release(pool);
-       if (!inflight)
-               return;

        /* Periodic warning for page pools the user can't see */
        netdev =3D READ_ONCE(pool->slow.netdev);
        if (time_after_eq(jiffies, pool->defer_warn) &&
-           (!netdev || netdev =3D=3D NET_PTR_POISON)) {
+           (!netdev || netdev =3D=3D NET_PTR_POISON) &&
+           inflight !=3D 0) {
                int sec =3D (s32)((u32)jiffies - (u32)pool->defer_start) / =
HZ;

                pr_warn("%s() stalled pool shutdown: id %u, %d
inflight %d sec devmem=3D%d\n",
@@ -1128,7 +1127,15 @@ static void page_pool_release_retry(struct
work_struct *wq)
                pool->defer_warn =3D jiffies + DEFER_WARN_INTERVAL;
        }

-       /* Still not ready to be disconnected, retry later */
+       /* In rare cases, a driver bug may cause inflight to go negative. D=
on't
+        * reschedule release if inflight is 0 or negative.
+        *      - If 0, the page_pool has been destroyed
+        *      - if negative, we will never recover
+        * in both cases no reschedule necessary.
+        */
+       if (inflight < 1)
+               return;
+
        schedule_delayed_work(&pool->release_dw, DEFER_TIME);
 }
```

--=20
Thanks,
Mina

