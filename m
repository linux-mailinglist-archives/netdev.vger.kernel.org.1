Return-Path: <netdev+bounces-241661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E78C8748F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18C474E2B91
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501430FF1D;
	Tue, 25 Nov 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bfhs1gJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614523002DE
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108255; cv=none; b=pNVw0SsLfel3DCx2OR5iXJe+6pa9n1qcNwFRehGy7kz2NGvTAZdpZG/Iui74BWWUB8QQxNY3oxM94VOlft6akOe+r+qhkpSw1Ol7QYY7FK/yDzZ+J18KdsXddSQf7pMGx+4d9cMlIqBy2btwrLm90p91lfeuQ0WB4/8tA0WWqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108255; c=relaxed/simple;
	bh=BdO9PIJjDm/1/COunANf/TWSE0zvesZqZjcNyEpuNyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4QKn9qKHOILIh+xt1Glx6MJle8Qn7apTunUjmW7RkDUEsI6mp693jDspQd3Bgf8gdtkQ2C0OhWaWi6bdamUFOyoe9J4bqw36FoRlxvZGiqEJq6+7YYWrGU3Xayg43JDxJzuJg8/FqLvCVMJDwsDoXJHO6dozTXmT17RAwUJK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bfhs1gJU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b22b1d3e7fso609842685a.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764108252; x=1764713052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFV5BEQO0h6WteiqsW0VzyRefRg4w03+xa45BOA9TX0=;
        b=bfhs1gJU6o4M9YvCP3v9CX55lgUnfZz+UB9zDTMnZGsAvs8isZ3gBY+ZRi/dmkgyMW
         7bqrMVnYdelWIlMuVNDqkQYG7Dbh+r4vKLBfzVBtRZNI++eDZKGNAuqLpBgKv7aJ2nkV
         /EFBRKEumoyB5qMstp/XzsLDV4YlfHsIxFExL17k60jzMFRf+lqbgZ2sE/pQo9sJQehH
         +STOvbuwV0Kz6Im0Mx8nJubS3YfQS5NeX5sM9CTGLufiNq6cNg1DKdYHaplyP3BGGlvo
         Bc4lVmyDeY/GjaiwdEHtY2dXm+mSd9cyY5GlwGb3NsJ09z5Ho8ZOHstgYu/bLU865OTD
         dRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764108252; x=1764713052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFV5BEQO0h6WteiqsW0VzyRefRg4w03+xa45BOA9TX0=;
        b=FQL56jH4qNPm4INz8+y0xxa6qVbkV+xn5anR1Bkdl1lEaZjRzWWnhskNlnR1Wm1KpK
         Dn98H9vHkRKUl5rEI8Dpg3aKRFWx7aDoaB2POhFByvTsIIBarbL8+1UuBll5GmHGG9ft
         Cfc+gSR9ohlQsXmlttV1mNXhGN0yuMRuSahagwdjD5j4fZ60+KcwClDzHy5xklyO6p1+
         1DttvgI4DBRoTwZ6Ud6Um1yDlTuprU6SO4iNf89pBtX1SkH0pDPxcbTbSHCNgH1dMtb6
         rDH4/zSG8HSDaGHkoQ/kOLMvYUBzU1s4Qc27UaXlMcaAZqwgswsgMLeDfyG6wUuTkk99
         Pgow==
X-Forwarded-Encrypted: i=1; AJvYcCUln+ZGAmzLy31+3IJWCdOto0240Vt2qNzKx2zooI/EGtHrFxbKS2noiUv6PRqs98DLUJpzfT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EHoq0Y+07Xxe1+dctaBbn9URyOXOTdoLUbbWzBIGiuwC6iYP
	P0ySPo1dXgQ95yswOr4xMQOpdBd0oqB2dQw6HZ9pHEXcAY/S9DCnBa96PlEmXbWmhjB87cr1XKb
	1GxpEtwUyEQ3P7Y0Cg+4kkc4lT+4g9IIcAdPbw0QY
X-Gm-Gg: ASbGncvvP4QtkAOIPIC2GVxi3h/0FBVu1RKY+JUFD+lLzrqjyJRN3XMP6lepe9VsuYL
	tH1boh3MNYyoUgOxr63joD+N2Z2iLSpFLU9n8rPqHIEnyvUJZxyTRRF0dCV6mieA1oI5c//66Q7
	gdmM+a9lPOB4iiosS+8P7l1/dGKqHiSTgItOefqGxb00WPy2cnRllMh/XNmQsSoa+v3KxO7ccQr
	+9ip3IGydONKLTx4wAQwuLey1KuGGcsAKm6omlRfex0KvzUmnD4qf466AjizrwPsCoaLGGf
X-Google-Smtp-Source: AGHT+IESzt7BrjzYz4e8kdr8+LMVfFjZ8Q6Xq9xG+iiyoBcY83fq4TrwHsXgnDYyI7frxtco27d+yOIJ0IDn8jEzS38=
X-Received: by 2002:a05:620a:4709:b0:8b2:5fa9:61 with SMTP id
 af79cd13be357-8b33d267d7bmr2300085085a.25.1764108252165; Tue, 25 Nov 2025
 14:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121232735.1020046-1-xmei5@asu.edu> <87ms4bn1u9.fsf@toke.dk>
In-Reply-To: <87ms4bn1u9.fsf@toke.dk>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 25 Nov 2025 15:04:01 -0700
X-Gm-Features: AWmQ_bkZafX0FyomYdSL-ky-6_gsr8v5aKzzKvrUSz26Aqb26T7pNrCY8b1XZ7Q
Message-ID: <CAPpSM+SrDasWhhwPZUrTTov7q7XxSkrc9+mHc-H+TvJB_iRMaQ@mail.gmail.com>
Subject: Re: [PATCH net v5] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: security@kernel.org, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much for reviewing and pointing out my mistake on
`drop_overlimit.` New patches are sent.

On Mon, Nov 24, 2025 at 3:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Xiang Mei <xmei5@asu.edu> writes:
>
> > In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> > and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> > that the parent qdisc will enqueue the current packet. However, this
> > assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> > qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> > accounting inconsistent. This mismatch can lead to a NULL dereference
> > (e.g., when the parent Qdisc is qfq_qdisc).
> >
> > This patch computes the qlen/backlog delta in a more robust way by
> > observing the difference before and after the series of cake_drop()
> > calls, and then compensates the qdisc tree accounting if cake_enqueue()
> > returns NET_XMIT_CN.
> >
> > To ensure correct compensation when ACK thinning is enabled, a new
> > variable is introduced to keep qlen unchanged.
> >
> > Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN w=
hen past buffer_limit")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: add missing cc
> > v3: move qdisc_tree_reduce_backlog out of cake_drop
> > v4: remove redundant variable and handle ack branch correctly
> > v5: add the PoC as a test case
>
> Please split the test case into its own patch and send both as a series.
>
> Otherwise, the changes LGTM apart from the few nits below:
>
> > ---
> >  net/sched/sch_cake.c                          | 52 +++++++++++--------
> >  .../tc-testing/tc-tests/qdiscs/cake.json      | 28 ++++++++++
> >  2 files changed, 58 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index 32bacfc314c2..cf4d6454ca9c 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, =
struct sk_buff **to_free)
> >
> >       qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLI=
MIT);
> >       sch->q.qlen--;
> > -     qdisc_tree_reduce_backlog(sch, 1, len);
> >
> >       cake_heapify(q, 0);
> >
> > @@ -1750,7 +1749,8 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >       ktime_t now =3D ktime_get();
> >       struct cake_tin_data *b;
> >       struct cake_flow *flow;
> > -     u32 idx, tin;
> > +     u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> > +     bool same_flow =3D false;
>
> Please make sure to maintain the reverse x-mas tree ordering of the
> variable declarations.
>
> >
> >       /* choose flow to insert into */
> >       idx =3D cake_classify(sch, &b, skb, q->flow_mode, &ret);
> > @@ -1823,6 +1823,8 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >               consume_skb(skb);
> >       } else {
> >               /* not splitting */
> > +             int ack_pkt_len =3D 0;
> > +
> >               cobalt_set_enqueue_time(skb, now);
> >               get_cobalt_cb(skb)->adjusted_len =3D cake_overhead(q, skb=
);
> >               flow_queue_add(flow, skb);
> > @@ -1834,7 +1836,7 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >                       b->ack_drops++;
> >                       sch->qstats.drops++;
> >                       b->bytes +=3D qdisc_pkt_len(ack);
> > -                     len -=3D qdisc_pkt_len(ack);
> > +                     ack_pkt_len =3D qdisc_pkt_len(ack);
>
> There's a qdisc_tree_reduce_backlog() that uses qdisc_pkt_len(ack) just
> below this; let's also change that to use ack_pkt_len while we're at it.
>
> >                       q->buffer_used +=3D skb->truesize - ack->truesize=
;
> >                       if (q->rate_flags & CAKE_FLAG_INGRESS)
> >                               cake_advance_shaper(q, b, ack, now, true)=
;
> > @@ -1848,11 +1850,11 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >
> >               /* stats */
> >               b->packets++;
> > -             b->bytes            +=3D len;
> > -             b->backlogs[idx]    +=3D len;
> > -             b->tin_backlog      +=3D len;
> > -             sch->qstats.backlog +=3D len;
> > -             q->avg_window_bytes +=3D len;
> > +             b->bytes            +=3D len - ack_pkt_len;
> > +             b->backlogs[idx]    +=3D len - ack_pkt_len;
> > +             b->tin_backlog      +=3D len - ack_pkt_len;
> > +             sch->qstats.backlog +=3D len - ack_pkt_len;
> > +             q->avg_window_bytes +=3D len - ack_pkt_len;
> >       }
> >
> >       if (q->overflow_timeout)
> > @@ -1927,24 +1929,30 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >       if (q->buffer_used > q->buffer_max_used)
> >               q->buffer_max_used =3D q->buffer_used;
> >
> > -     if (q->buffer_used > q->buffer_limit) {
> > -             bool same_flow =3D false;
> > -             u32 dropped =3D 0;
> > -             u32 drop_id;
> > +     if (q->buffer_used <=3D q->buffer_limit)
> > +             return NET_XMIT_SUCCESS;
> >
> > -             while (q->buffer_used > q->buffer_limit) {
> > -                     dropped++;
> > -                     drop_id =3D cake_drop(sch, to_free);
> > +     prev_qlen =3D sch->q.qlen;
> > +     prev_backlog =3D sch->qstats.backlog;
> >
> > -                     if ((drop_id >> 16) =3D=3D tin &&
> > -                         (drop_id & 0xFFFF) =3D=3D idx)
> > -                             same_flow =3D true;
> > -             }
> > -             b->drop_overlimit +=3D dropped;
> > +     while (q->buffer_used > q->buffer_limit) {
> > +             drop_id =3D cake_drop(sch, to_free);
> > +             if ((drop_id >> 16) =3D=3D tin &&
> > +                 (drop_id & 0xFFFF) =3D=3D idx)
> > +                     same_flow =3D true;
> > +     }
> > +
> > +     /* Compute the droppped qlen and pkt length */
> > +     prev_qlen -=3D sch->q.qlen;
> > +     prev_backlog -=3D sch->qstats.backlog;
> > +     b->drop_overlimit +=3D prev_backlog;
>
> drop_overlimit was accounted in packets before, so this should be +=3D pr=
ev_qlen.
>
> -Toke

