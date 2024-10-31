Return-Path: <netdev+bounces-140748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6F9B7CE0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FD71C208E3
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586F19E97A;
	Thu, 31 Oct 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlAIsOHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50E199238
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385067; cv=none; b=I5K31YbRzluJ8LN2Zoef/P97ZfJEBB9n9JdHMqJDb4iyLnc5vvcGVmmB0le7NDZu4HGjZbiVPy13Ny0/RB9FSRWEr9k5/f5HrJ16noOHdOVxfRyP7bYk7OKzNFrLQ9H+far5qWZ2HGJFEEe05FXxzjYAFeQwxR2t4znMqQP7spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385067; c=relaxed/simple;
	bh=WFdTt+1GJ0V7ddHY81cgChe/RFVPqLw7rUm8w5GiO68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jM8jNxtDYAo8ScA1zyRQusky5LOw92oO+FumocKlrY7Zlr5eNCiUXsfOCJJfIcWb39qa1BQ4am9dWvQJhJFPuvlZlfH9pvKMlkZ03LgrNhfBgitj0tP07R8l+OJu3RH+0km1BQjXvJCEJ8hXZq1mQ0vCpKgcJNfm4i8gB4n00Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlAIsOHH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so1124248a12.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730385063; x=1730989863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux65onhD056AsOGZQFRmHACoME7CU+HCDiIBWmfwVzw=;
        b=GlAIsOHHhVUvGbTujEnIrHIrrl3mtZJWoV5WBVKjTvcE2QF1eSRwLIe28k4hIylved
         +bGeb07bfTmdtnSC0t+WDw2H3PYesDaWMchnGbWvPBrMJnws9qqocdNpql50EU1ati7b
         J+WtRz+JBZo+ukbH0+hniUj9uVK/T0uLrMwrEvQMKUq2S3RH9E2c9GfWTvzN0eL5r/Lt
         mB11ne9cjIOOHb2iMUQf1frCz24/AsAICySDDgbWkzvhUsmivafKCCSoFPwX5diPrYsF
         LMyuPGsustOiyrah3KLZEAs2rm7+C3ntS7kX1eY9B0izzrXF66ISlR9/146aPLyoHflN
         dbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385063; x=1730989863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux65onhD056AsOGZQFRmHACoME7CU+HCDiIBWmfwVzw=;
        b=XK1pw9jVOq8tlFUfkzHVNqDiljGeED/6S6b9Hy+3TdCLGxv2ce3wNZLqmPOEy6D/oP
         8NdYb59PdIiPrVV1eYKqTs+jl0MU95sD2DklcFoGQ+5yMeL8/p9IYtGcGgFf6wBxCGBA
         9dMavRRAqMZUd8M+zw+lFA5PHvKh7KA3DJiEXVHRs0VNjLmIzCTpFTQ+qNG/hATu1v8Y
         hLIpzByBcoRRNOZ0llApIIocUOM3OewcIDLgl8skUkEDFW+6fhuOuZ9nN9Q/jw84HiRQ
         E3t/EUERDeOp/WHYSN4IFmdawGp/FMWR/AWxIbWDBYBSiKERtgLtPDeQ6aCFgm1PIxUl
         kpIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHRnAfvg8B4mrarCYT1bb5iUD70kDHjImsEy3hqTznOrYKGud3JHYqvCHwqbrWqW1hom3fHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WLsoebxy/xviIW4MkjFERa5kvnGIwBHwulQo0ZDBey4ON5e4
	bUhqr4yv1VSxLfzDFqrLcNizF4wpGmYxuzWLLoBQgAwYTdPL2joWq8jQj1F4RnXqxHj+yTPwykL
	M6RrxP27ZGji18+S9qW/nv5UMI4cD/23x3FKq
X-Google-Smtp-Source: AGHT+IHoklTkQ+ukEWdkUOgFjc4mfbHRAmJAYT6Hlb24FuRHwDcQitTKMTaByxuK2zFqOIVhnxJGhOrAvc8r2r5Hfy4=
X-Received: by 2002:a05:6402:84f:b0:5cb:b65d:2b6 with SMTP id
 4fb4d7f45d1cf-5cea975527bmr2783582a12.32.1730385062660; Thu, 31 Oct 2024
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com> <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
 <CADVnQy=Gt+PHPJ+EdaXY=xcrgeDwusSBmmWV9+6-=93ZhD4SXw@mail.gmail.com>
In-Reply-To: <CADVnQy=Gt+PHPJ+EdaXY=xcrgeDwusSBmmWV9+6-=93ZhD4SXw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Oct 2024 15:30:48 +0100
Message-ID: <CANn89iJNi1=+gAx6P4keDb9wuHoTjZnN0DNRgBEZ5cJuUcaZHg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: Neal Cardwell <ncardwell@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, chia-yu.chang@nokia-bell-labs.com, 
	netdev@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org, 
	jhs@mojatatu.com, kuba@kernel.org, dsahern@kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, 
	Bob Briscoe <research@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:28=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Tue, Oct 29, 2024 at 12:53=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Oct 29, 2024 at 1:56=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 10/22/24 00:12, chia-yu.chang@nokia-bell-labs.com wrote:
> > > > +/* Default alpha/beta values give a 10dB stability margin with max=
_rtt=3D100ms. */
> > > > +static void dualpi2_reset_default(struct dualpi2_sched_data *q)
> > > > +{
> > > > +     q->sch->limit =3D 10000;                          /* Max 125m=
s at 1Gbps */
> > > > +
> > > > +     q->pi2.target =3D 15 * NSEC_PER_MSEC;
> > > > +     q->pi2.tupdate =3D 16 * NSEC_PER_MSEC;
> > > > +     q->pi2.alpha =3D dualpi2_scale_alpha_beta(41);    /* ~0.16 Hz=
 * 256 */
> > > > +     q->pi2.beta =3D dualpi2_scale_alpha_beta(819);    /* ~3.20 Hz=
 * 256 */
> > > > +
> > > > +     q->step.thresh =3D 1 * NSEC_PER_MSEC;
> > > > +     q->step.in_packets =3D false;
> > > > +
> > > > +     dualpi2_calculate_c_protection(q->sch, q, 10);  /* wc=3D10%, =
wl=3D90% */
> > > > +
> > > > +     q->ecn_mask =3D INET_ECN_ECT_1;
> > > > +     q->coupling_factor =3D 2;         /* window fairness for equa=
l RTTs */
> > > > +     q->drop_overload =3D true;        /* Preserve latency by drop=
ping */
> > > > +     q->drop_early =3D false;          /* PI2 drops on dequeue */
> > > > +     q->split_gso =3D true;
> > >
> > > This is a very unexpected default. Splitting GSO packets earlier WRT =
the
> > > H/W constaints definitely impact performances in a bad way.
> > >
> > > Under which condition this is expected to give better results?
> > > It should be at least documented clearly.
> >
> > I agree, it is very strange to see this orthogonal feature being
> > spread in some qdisc.
>
> IMHO it makes sense to offer this split_gso feature in the dualpi2
> qdisc because the dualpi2 qdisc is targeted at reducing latency and
> targeted mostly at hops in the last mile of the public Internet, where
> there can be orders of magnitude disparities in bandwidth between
> upstream and downstream links (e.g., packets arriving over 10G
> ethernet and leaving destined for a 10M DSL link). In such cases, GRO
> may aggregate many packets into a single skb receiving data on a fast
> ingress link, and then may want to reduce latency issues on the slow
> link by allowing smaller skbs to be enqueued on the slower egress
> link.
>
> > Also, it seems this qdisc could be a mere sch_prio queue, with two
> > sch_pie children, or two sch_fq or sch_fq_codel ?
>
> Having two independent children would not allow meeting the dualpi2
> goal to "preserve fairness between ECN-capable and non-ECN-capable
> traffic." (quoting text from https://datatracker.ietf.org/doc/rfc9332/
> ). The main issue is that there may be differing numbers of flows in
> the ECN-capable and non-ECN-capable queues, and yet dualpi2 wants to
> maintain approximate per-flow fairness on both sides. To do this, it
> uses a single qdisc with coupling of the ECN mark rate in the
> ECN-capable queue and drop rate in the non-ECN-capable queue.

Not sure I understand this argument.

The dequeue  seems to use WRR, so this means that instead of prio,
this could use net/sched/sch_drr.c,
then two PIE (with different settings) as children, and a proper
classify at enqueue to choose one queue or the other.

Reviewing ~1000 lines of code, knowing that in one year another
net/sched/sch_fq_dualpi2.c
will follow (as net/sched/sch_fq_pie.c followed net/sched/sch_pie.c )
is not exactly appealing to me.

/* Select the queue from which the next packet can be dequeued, ensuring th=
at
+ * neither queue can starve the other with a WRR scheduler.
+ *
+ * The sign of the WRR credit determines the next queue, while the size of
+ * the dequeued packet determines the magnitude of the WRR credit change. =
If
+ * either queue is empty, the WRR credit is kept unchanged.
+ *
+ * As the dequeued packet can be dropped later, the caller has to perform =
the
+ * qdisc_bstats_update() calls.
+ */
+static struct sk_buff *dequeue_packet(struct Qdisc *sch,
+                                     struct dualpi2_sched_data *q,
+                                     int *credit_change,
+                                     u64 now)
+{


>
> This could probably be made more clear in the commit message.
>
> > Many of us are using fq_codel or fq, there is no way we can switch to
> > dualpi2 just to experiment things.
>
> Yes, sites that are using fq_codel or fq do not need to switch to dualpi2=
.
>
> AFAIK the idea with dualpi2 is to offer a new qdisc for folks
> developing hardware for the last mile of the Internet where you want
> low latency via L4S, and want approximate per-flow fairness between
> L4S and non-L4S traffic, even in the presence of VPN-encrypted traffic
> (where flow identifiers are not available for fq_codel or fq fair
> queuing).
>
> Sites that don't have VPN traffic or don't care about the VPN issue
> can use fq or fq_codel with the ce_threshold parameter to allow low
> latency via L4S while achieving approximate per-flow fairness.
>
> best regards,
> neal

