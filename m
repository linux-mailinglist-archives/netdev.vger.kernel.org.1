Return-Path: <netdev+bounces-193001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDFAC21AF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25A47A71E0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B1227EB9;
	Fri, 23 May 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eR6m//y+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE404183CC3
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998084; cv=none; b=Frqhu0QS/U9CJe0JIgxIV13wCYBbzsOYAehehUEBYICFJVj2m62PMIhS3r2lnmkYLocFvwMNDaiclwWzf/Ma1h20HqSrMzvM2FAu/JsDGoQbeLFiFSnl0WpE+diLyedzL2u3QA437SDUF2T78XZ5cpMdpqy76Ari5KKRIqU54w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998084; c=relaxed/simple;
	bh=PDkbkNTHf0EVKUKcrOKy9iqTG6aPF2jbmB+MpBaHu1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcVCqHBTWnInm3GDy+U29aHT+o3MGton9802x7DQNP3P40QGiyHTUFK0SCSDF76N/zFTjNGbY+vT2seogi73/GwGxK30BoZhyX0dkefOV0FcRY9pgm/flil6oj2RbV5Ltx0B7MCZKvX2lMdiUKaDcW36/DKu2LyI4TuUfHB2I9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eR6m//y+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74267c68c11so7756416b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747998082; x=1748602882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nF1HNq5qwTWm95AUVWEWWSgkx0EPutUizH+4VAXtRc=;
        b=eR6m//y+qIXMTWxOFscMtV4Ny6xAmsyqBTDRs9BQNogIBmz3KFcR0+Tkdn+XHtWXHA
         LeDheQibJp2dyTgsnKcJdEvrVftzHU5UJhX9D2ecqYqLiUoIycvEAv/g9PO9bmgYRBk8
         I1o/xIFjSsUDZYbkJn51y51xKmAHGyD0gxkb3mWkvHEaB8XWbqqewey7oijQmgPrq8jZ
         DVBZ7T0fmUt64SCXT3Noo4lTbmCMigdeDkaliKxA1YS6l/soKeVJKyN4RcqeANf28kS1
         UzkOvNxpD8BJa8ZJpDKwbngVuZOCADedbjqTJ3QphB9aI8xUfd8HjHwfYlUbL4J8qRTc
         4b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747998082; x=1748602882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nF1HNq5qwTWm95AUVWEWWSgkx0EPutUizH+4VAXtRc=;
        b=VpQSADy/4wySQZwGE8dY+sG+/QwEx6zvc9KSBLZxHnYivTS7+azrPSPT/BSyMunOMH
         AaQDmV5jyUreh+8NO65j9T53a/wxS/EyykLa55c/HSvd/ORzJuFlusNdrnfLptmuWPDT
         5a8cZ4vJXG1w9+j8RIaNzp7Knwzsd59NSLijWjN0w8r6lcx1jLXTW4VgsBrdnurfl9er
         TC+A3G9+jBfAzm9uXfAJ9SSTtNgk0vSngWR8k4BmN6w/SN/YGUgjs3WcKMx04AkCRFii
         PUL3BJJ7xLd39zinD/N74EzORqkrpsRu7lP6siCzOq6xSlsC0GN7ko55KCBwewsVnwJ+
         4w6w==
X-Gm-Message-State: AOJu0YwGri0309vYs4hvOn9925HJkGF9AUR7vKE40Yro8lWn3g2c/+Ri
	wq6GVm1jAAyPMMrnn1JhT1whwJzq/fBD2gPHDm+UClZRRm6TMCpBcGcrvVVGP7b9Y/x4LSIn4Si
	Kec44Yv3vzmC9cDbmI5+qTtRrNHK1AxpHGuf6m9BC
X-Gm-Gg: ASbGncuKmB79FfPc/UoCr+sQO8P8YTeeeoNfotvg0Fw2r3XIbQL3lGQoJggL38DGG0U
	u1M3fHPof0cEvnBWpEi74PjsFHSztLKFIbxXw9MVvBExwbDGr4SS7xCvYQGaiVBoT8pxOfXhByP
	idKqR8FviZSKE29ClOjGrQqkrkleZMbUY=
X-Google-Smtp-Source: AGHT+IF5oHs6VXNZ6x5MOkiEoNOremC3HSNwLBUFFl4OBQciMaWG3xy+n2OQ5Z/8ZGszPi1J8H1hnU56DEJKd7A9DEg=
X-Received: by 2002:a05:6a20:72a6:b0:215:e818:9fd4 with SMTP id
 adf61e73a8af0-2170cdf1510mr39065721637.27.1747998082065; Fri, 23 May 2025
 04:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com>
 <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
 <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
 <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
 <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
 <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com> <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
In-Reply-To: <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 May 2025 07:01:11 -0400
X-Gm-Features: AX0GCFveVz3BOhEpXXNhOW_Q2wBIghCOtTPnMzGfXrXwNXHVz4xjxXGFSTbmcHo
Message-ID: <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 5:03=E2=80=AFPM William Liu <will@willsroot.io> wro=
te:
>
> On Thursday, May 22nd, 2025 at 12:34 PM, Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>
> > > If we do a per cpu global variable approach like in act_mirred.c to t=
rack nesting, then wouldn't this break in the case of having multiple norma=
l qdisc setups run in parallel across multiple interfaces?
> >
> >
> > A single skb cannot enter netem via multiple cpus. You can have
> > multiple cpus entering the netem but they would be different skbs - am
> > i missing something? Note mirred uses per-cpu counter which should
> > suffice for being per skb counters.
> >
>
> Ah right, you are correct. This approach will be fine then. We were origi=
nally concerned about another netem qdisc being interwoven during the opera=
tions, but that is not possible.
>
> > > This brings us back to the approach where we don't allow duplication =
in netem if a parent qdisc is a netem with duplication enabled. However, on=
e issue we are worried about is in regards to qdisc_replace. This means thi=
s check would have to happen everytime we want to duplicate something in en=
queue right? That isn't ideal either, but let me know if you know of a bett=
er place to add the check.
> >
> >
> > I didnt follow - can you be more specific?
> >
>
> Oh, I meant that disablement of duplication due to an ancestor netem in t=
he qdisc tree isn't possible at class instantiation time because
> qdiscs can be replaced. So we would have to do the check at every skb enq=
ueue, which would be far from ideal. The per cpu approach is better.
>
> Anyways, please let us know how the patch below looks - it passes all the=
 netem category test cases in tc-testing and avoids the problem for me. Tha=
nk you for all the help so far!
>

looks ok from 30k feet. Comments:
You dont need a count variable anymore because the per-cpu variable
serves the same goal - so please get rid of it.
Submit a formal patchset - including at least one tdc test(your
validation tests are sufficient) then we can do a better review.
And no netdev comments are complete if we dont talk about the xmas
tree variable layout. Not your fault on the state of the lights on
that tree but dont make it worse;-> move the nest_level assignment as
the first line in the function.

cheers,
jamal
> From c96d94ab2155e18318a29510f0ee8f3983a14274 Mon Sep 17 00:00:00 2001
> From: William Liu <will@willsroot.io>
> Date: Thu, 22 May 2025 13:08:30 -0700
> Subject: [PATCH] net/sched: Fix duplication logic in netem_enqueue
>
> netem_enqueue's duplication prevention logic is broken when multiple
> netem qdiscs with duplication enabled are stacked together as seen
> in [1]. Ensure that duplication does not happen more than once in a
> qdisc tree with netem qdiscs. Also move the duplication logic to
> happen after the initial packet has finished the enqueue process
> to preserve the accuracy of the limit check.
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
>  net/sched/sch_netem.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..651fae1cd7d6 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -167,6 +167,8 @@ struct netem_skb_cb {
>     u64         time_to_send;
>  };
>
> +static DEFINE_PER_CPU(unsigned int, enqueue_nest_level);
> +
>  static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
>  {
>     /* we assume we can use skb next/prev/tstamp as storage for rb_node *=
/
> @@ -454,13 +456,21 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>     struct sk_buff *skb2 =3D NULL;
>     struct sk_buff *segs =3D NULL;
>     unsigned int prev_len =3D qdisc_pkt_len(skb);
> +   int nest_level =3D __this_cpu_inc_return(enqueue_nest_level);
> +   int retval;
>     int count =3D 1;
>
>     /* Do not fool qdisc_drop_all() */
>     skb->prev =3D NULL;
>
> -   /* Random duplication */
> -   if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
> +   /*
> +    * Random duplication
> +    * We must avoid duplicating a duplicated packet, but there is no
> +    * good way to track this. The nest_level check disables duplication
> +    * if a netem qdisc duplicates the skb in the call chain already
> +    */
> +   if (q->duplicate && nest_level < 1 &&
> +       q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
>         ++count;
>
>     /* Drop packet? */
> @@ -473,7 +483,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>     if (count =3D=3D 0) {
>         qdisc_qstats_drop(sch);
>         __qdisc_drop(skb, to_free);
> -       return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +       retval =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +       goto dec_nest_level;
>     }
>
>     /* If a delay is expected, orphan the skb. (orphaning usually takes
> @@ -528,7 +539,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>         qdisc_drop_all(skb, sch, to_free);
>         if (skb2)
>             __qdisc_drop(skb2, to_free);
> -       return NET_XMIT_DROP;
> +       retval =3D NET_XMIT_DROP;
> +       goto dec_nest_level;
>     }
>
>     /*
> @@ -642,9 +654,14 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>         /* Parent qdiscs accounted for 1 skb of size @prev_len */
>         qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
>     } else if (!skb) {
> -       return NET_XMIT_DROP;
> +       retval =3D NET_XMIT_DROP;
> +       goto dec_nest_level;
>     }
> -   return NET_XMIT_SUCCESS;
> +   retval =3D NET_XMIT_SUCCESS;
> +
> +dec_nest_level:
> +   __this_cpu_dec(enqueue_nest_level);
> +   return retval;
>  }
>
>  /* Delay the next round with a new future slot with a
> --
> 2.43.0
>

