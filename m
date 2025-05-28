Return-Path: <netdev+bounces-194078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44044AC739F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B871BC6316
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9E227E9F;
	Wed, 28 May 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="I7pXufFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECF21D5B4
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469611; cv=none; b=R6RBOD85rgxGaDp+CUecDVe6unfW50e4lCiSdHiI682A1b8ByBOlVPvH5DvpJIiLG2DpbSnICwDQ22cuRxY4bKq/Z43fm/M1K5zps4sDAk4PR3rtnBNwsOrbiOifdqMfc5K7T7JMI6+tcXCM0lhjsVhqFgInaP2BmNdLNkmj/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469611; c=relaxed/simple;
	bh=F83E9hCARfXwToImJlEKuNDI2B3Z76P9NR96jmjLxAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kR824wodKAAdsmoZ7jaIUzFVvcSHVpRU1K2/2xsVplYJj54b1e34/HxpULmLWv48pxb70ewfBFQ1c+o528BO8IRU2eXG9vY0oQXTvaYrfBxeV9k0OLkCs4R9k0LGeZkaXgpPB2WZXMeOJ4/zmQwYpJucULDoL+yQwMLWthNQuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=I7pXufFe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74267c68c11so162434b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748469609; x=1749074409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lSrQCvcTbNHd9Lc7rDf09MSkPaKy6xPOWgiO+ubzVE=;
        b=I7pXufFeo4yo4bgp6v9WMlXmB6EoYfjo64nFOshAgWmTrTrZt4SeZ1FZtrpGLLEOxr
         T9fogn6UfRJ6rIWnOZo2xnl8fHBCpY5cchRSVXSK7a1t825wcs5RttrDPZ8K2ybfOTNY
         KskRO9+bnlfV2XRgOzMGOitD+TF4ELaZs+FoX/+BjUtESiXVmsCNS1hrfa9RmFNP/HmJ
         KiprKQQOyjDehB661+5bEQmCR/RlbYzqgz3MLisrsu65Hv9toa90P9KHT9DvJ0kurFpS
         sTsS4WeKRS1RDeWsPQAl5c1IXShk2rPOM0t11NmBpmzKSs4odAKvfoth0smOIO4b2+V6
         gD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469609; x=1749074409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lSrQCvcTbNHd9Lc7rDf09MSkPaKy6xPOWgiO+ubzVE=;
        b=IpBazKUTyd3Oo189lG0EmrO1gQyKyJv3w2d+OAJ2WOuVfdZ7UTg3RKq4Gj62X8eZ+H
         3NXxLeJnrFl2mzQNlcTkiIWoURZo9pSr7M/G1fNw6cjR+MDXo1U26JEwq2CsYL5Vd560
         1rb2uxhQ4CFXCMztDh0hqQp7Mv8wdWuhv04Bjch636koVugE4icZJECEPIcg+tFLxNVF
         wOkOc85fgiT4ha2KXg8LmcqVOq8q5reEgY38O84ShiLac99RrR/491n++ULDdeOE6xeH
         1MqM6mWS4nkJyz+HNhQNpdt7Cjya8AS9EuoIiQeJliqlZ5s9H5214ytjqTRFMqe1fuq8
         sMdg==
X-Gm-Message-State: AOJu0Yw3dh3lf8pfoWS+lQQL3svO15Dipioeo0lehvHrOdQ+BK2FwbGm
	2Y9Fpyos0Z/mdLXjTLNWXdxyE4DxNWtIwQRkUEMMeC0prcGTAaDl6OcMLIgo4xyyWF1vnx0JsHi
	TzNy6j1S6sNWaeJgxzpYaWyPnAmGK6faot2+iJVTf
X-Gm-Gg: ASbGncsVnSgshD6oGNgeiPzolU6NvoxhfQOMbXNP5XAR+WR1Ovd4YAYtEx/UdY+iXuJ
	KkRW/WuKdGB60q8OjblwrLihRudh1uhvSxm2JgJU7f/86cIZkNhEcxI64AJneUZePHVzznrGrXf
	kqRiXPYP9rPGFYlXpSbOIg+fx5do7PfD98EcJrBDynFg==
X-Google-Smtp-Source: AGHT+IFyd684SqHQS+BYIE7YlJp7bdNajKN6a1K3dZT47T9CsIVuQmfJMJSzAl5Ck2tpBoj03vdFwQGzlYaLvwvsrjI=
X-Received: by 2002:a05:6a21:458a:b0:201:2834:6c62 with SMTP id
 adf61e73a8af0-2188c28d3d9mr27365791637.25.1748469608675; Wed, 28 May 2025
 15:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
 <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
 <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
 <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
 <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
 <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
 <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
 <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
 <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
 <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
In-Reply-To: <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 May 2025 17:59:57 -0400
X-Gm-Features: AX0GCFsdeLrkHyVDnMUSJ-ps7mFrugx3HI7A8jI6HdEVRuBoS02-MYcAj8g1gZY
Message-ID: <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Sorry for the latency..

On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu <will@willsroot.io> wro=
te:
>
> I did some more testing with the percpu approach, and we realized the fol=
lowing problem caused now by netem_dequeue.
>
> Recall that we increment the percpu variable on netem_enqueue entry and d=
ecrement it on exit. netem_dequeue calls enqueue on the child qdisc - if th=
is child qdisc is a netem qdisc with duplication enabled, it could duplicat=
e a previously duplicated packet from the parent back to the parent, causin=
g the issue again. The percpu variable cannot protect against this case.
>

I didnt follow why "percpu variable cannot protect against this case"
- the enqueue and dequeue would be running on the same cpu, no?
Also under what circumstances is the enqueue back to the root going to
end up in calling dequeue? Did you test and hit this issue or its just
theory? Note: It doesnt matter what the source of the skb is as long
as it hits the netem enqueue.

> However, there is a hack to address this. We can add a field in netem_skb=
_cb called duplicated to track if a packet is involved in duplicated (both =
the original and duplicated packet should have it marked). Right before we =
call the child enqueue in netem_dequeue, we check for the duplicated value.=
 If it is true, we increment the percpu variable before and decrement it af=
ter the child enqueue call.
>

is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
net/sched/ to see what i mean

> This only works under the assumption that there aren't other qdiscs that =
call enqueue on their child during dequeue, which seems to be the case for =
now. And honestly, this is quite a fragile fix - there might be other edge =
cases that will cause problems later down the line.
>
> Are you aware of other more elegant approaches we can try for us to track=
 this required cross-qdisc state? We suggested adding a single bit to the s=
kb, but we also see the problem with adding a field for a one-off use case =
to such a vital structure (but this would also completely stomp out this bu=
g).
>

It sounds like quite a complicated approach - i dont know what the
dequeue thing brings to the table; and if we really have to dequeue to
reinject into enqueue then i dont think we are looping anymore..

cheers,
jamal

> Anyways, below is a diff with our fix plus the test suites to catch for t=
his bug as well as to ensure that a packet loss takes priority over a packe=
t duplication event.
>
> Please let me know of your thoughts - if this seems like a good enough fi=
x, I will submit a formal patchset. If any others cc'd here have any good i=
deas, please chime in too!
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..38bf85e24bbd 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -165,8 +165,11 @@ struct netem_sched_data {
>   */
>  struct netem_skb_cb {
>         u64             time_to_send;
> +       bool            duplicated;
>  };
>
> +static DEFINE_PER_CPU(unsigned int, enqueue_nest_level);
> +
>  static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
>  {
>         /* we assume we can use skb next/prev/tstamp as storage for rb_no=
de */
> @@ -448,32 +451,39 @@ static struct sk_buff *netem_segment(struct sk_buff=
 *skb, struct Qdisc *sch,
>  static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                          struct sk_buff **to_free)
>  {
> +       int nest_level =3D __this_cpu_inc_return(enqueue_nest_level);
>         struct netem_sched_data *q =3D qdisc_priv(sch);
> -       /* We don't fill cb now as skb_unshare() may invalidate it */
> -       struct netem_skb_cb *cb;
> +       unsigned int prev_len =3D qdisc_pkt_len(skb);
>         struct sk_buff *skb2 =3D NULL;
>         struct sk_buff *segs =3D NULL;
> -       unsigned int prev_len =3D qdisc_pkt_len(skb);
> -       int count =3D 1;
> +       /* We don't fill cb now as skb_unshare() may invalidate it */
> +       struct netem_skb_cb *cb;
> +       bool duplicate =3D false;
> +       int retval;
>
>         /* Do not fool qdisc_drop_all() */
>         skb->prev =3D NULL;
>
> -       /* Random duplication */
> -       if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q=
->prng))
> -               ++count;
> +       /*
> +        * Random duplication
> +        * We must avoid duplicating a duplicated packet, but there is no
> +        * good way to track this. The nest_level check disables duplicat=
ion
> +        * if a netem qdisc duplicates the skb in the call chain already
> +        */
> +       if (q->duplicate && nest_level <=3D1 &&
> +           q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng)) {
> +               duplicate =3D true;
> +       }
>
>         /* Drop packet? */
>         if (loss_event(q)) {
> -               if (q->ecn && INET_ECN_set_ce(skb))
> -                       qdisc_qstats_drop(sch); /* mark packet */
> -               else
> -                       --count;
> -       }
> -       if (count =3D=3D 0) {
> -               qdisc_qstats_drop(sch);
> -               __qdisc_drop(skb, to_free);
> -               return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +               qdisc_qstats_drop(sch); /* mark packet */
> +               if (!(q->ecn && INET_ECN_set_ce(skb))) {
> +                       qdisc_qstats_drop(sch);
> +                       __qdisc_drop(skb, to_free);
> +                       retval =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +                       goto dec_nest_level;
> +               }
>         }
>
>         /* If a delay is expected, orphan the skb. (orphaning usually tak=
es
> @@ -486,7 +496,7 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>          * If we need to duplicate packet, then clone it before
>          * original is modified.
>          */
> -       if (count > 1)
> +       if (duplicate)
>                 skb2 =3D skb_clone(skb, GFP_ATOMIC);
>
>         /*
> @@ -528,27 +538,15 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>                 qdisc_drop_all(skb, sch, to_free);
>                 if (skb2)
>                         __qdisc_drop(skb2, to_free);
> -               return NET_XMIT_DROP;
> -       }
> -
> -       /*
> -        * If doing duplication then re-insert at top of the
> -        * qdisc tree, since parent queuer expects that only one
> -        * skb will be queued.
> -        */
> -       if (skb2) {
> -               struct Qdisc *rootq =3D qdisc_root_bh(sch);
> -               u32 dupsave =3D q->duplicate; /* prevent duplicating a du=
p... */
> -
> -               q->duplicate =3D 0;
> -               rootq->enqueue(skb2, rootq, to_free);
> -               q->duplicate =3D dupsave;
> -               skb2 =3D NULL;
> +               retval =3D NET_XMIT_DROP;
> +               goto dec_nest_level;
>         }
>
>         qdisc_qstats_backlog_inc(sch, skb);
>
>         cb =3D netem_skb_cb(skb);
> +       if (duplicate)
> +               cb->duplicated =3D true;
>         if (q->gap =3D=3D 0 ||              /* not doing reordering */
>             q->counter < q->gap - 1 ||  /* inside last reordering gap */
>             q->reorder < get_crandom(&q->reorder_cor, &q->prng)) {
> @@ -613,6 +611,19 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>                 sch->qstats.requeues++;
>         }
>
> +       /*
> +        * If doing duplication then re-insert at top of the
> +        * qdisc tree, since parent queuer expects that only one
> +        * skb will be queued.
> +        */
> +       if (skb2) {
> +               struct Qdisc *rootq =3D qdisc_root_bh(sch);
> +
> +               netem_skb_cb(skb2)->duplicated =3D true;
> +               rootq->enqueue(skb2, rootq, to_free);
> +               skb2 =3D NULL;
> +       }
> +
>  finish_segs:
>         if (skb2)
>                 __qdisc_drop(skb2, to_free);
> @@ -642,9 +653,14 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>                 /* Parent qdiscs accounted for 1 skb of size @prev_len */
>                 qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_le=
n));
>         } else if (!skb) {
> -               return NET_XMIT_DROP;
> +               retval =3D NET_XMIT_DROP;
> +               goto dec_nest_level;
>         }
> -       return NET_XMIT_SUCCESS;
> +       retval =3D NET_XMIT_SUCCESS;
> +
> +dec_nest_level:
> +       __this_cpu_dec(enqueue_nest_level);
> +       return retval;
>  }
>
>  /* Delay the next round with a new future slot with a
> @@ -743,8 +759,11 @@ static struct sk_buff *netem_dequeue(struct Qdisc *s=
ch)
>                                 unsigned int pkt_len =3D qdisc_pkt_len(sk=
b);
>                                 struct sk_buff *to_free =3D NULL;
>                                 int err;
> -
> +                               if (netem_skb_cb(skb)->duplicated)
> +                                       __this_cpu_inc(enqueue_nest_level=
);
>                                 err =3D qdisc_enqueue(skb, q->qdisc, &to_=
free);
> +                               if (netem_skb_cb(skb)->duplicated)
> +                                       __this_cpu_dec(enqueue_nest_level=
);
>                                 kfree_skb_list(to_free);
>                                 if (err !=3D NET_XMIT_SUCCESS) {
>                                         if (net_xmit_drop_count(err))
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.jso=
n b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> index 3c4444961488..f5dd9c5cd9b2 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> @@ -336,5 +336,46 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> +    },
> +    {
> +        "id": "d34d",
> +        "name": "NETEM test qdisc duplication recursion limit",
> +        "category": ["qdisc", "netem"],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link set lo up || true",
> +            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate=
 100%",
> +            "$TC qdisc add dev lo parent 1: handle 2: netem gap 1 limit =
1 duplicate 100% delay 1us reorder 100%"
> +        ],
> +        "cmdUnderTest": "ping -I lo -c1 127.0.0.1 > /dev/null",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s qdisc show dev lo",
> +        "matchPattern": "qdisc netem",
> +        "matchCount": "2",
> +        "teardown": [
> +            "$TC qdisc del dev lo handle 1:0 root"
> +        ]
> +    },
> +    {
> +        "id": "b33f",
> +        "name": "NETEM test qdisc maximum duplication and loss",
> +        "category": ["qdisc", "netem"],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link set lo up || true",
> +            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate=
 100% loss 100%"
> +        ],
> +        "cmdUnderTest": "ping -I lo -c1 127.0.0.1 > /dev/null",
> +        "expExitCode": "1",
> +        "verifyCmd": "$TC -s qdisc show dev lo",
> +        "matchPattern": "Sent 0 bytes 0 pkt",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev lo handle 1:0 root"
> +        ]
>      }
>  ]
>

