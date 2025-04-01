Return-Path: <netdev+bounces-178661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01BA78092
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5B57A3C69
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92597207A23;
	Tue,  1 Apr 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nuqjn/Yj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7289461
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525379; cv=none; b=PLn5TPwZv+FrLG4Nswf1tIwESV975ywtLAWoIbyhjv0+TbGJWU8W9nh0FHxD2aFr8Am3Zj8FQoaRnL51ydCbq0xRYO1C4EmV5oYdfVd8bPy579qGOljnCiRn/yPG7b4vrm+4pjWvwBfMOW9/VYXDEru/J9NnPwbPoqcXdI833hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525379; c=relaxed/simple;
	bh=VWvWxSKzRMYdZOT5it5TSFg2JkE7Y8XDXupCVK0gEOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWUH97mLXhGg8rmGc20coHN+AYhUmTRLiil544+XOTDVcUN308JgQe1NpkWZutQB2Q/YLwjFAwpkX1nvW/28WAQoEMPm4U0MGOCUOFLyEGWABqqKOMdxoLec+W9iNzHKM5ItQDWnkO4NHpj1chyZEFhOeEa1ctDhb8Fj9WCbifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nuqjn/Yj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b0e9f2948so53e87.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743525376; x=1744130176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCWfSwNPC+XN8l5NzUgrEcA3QoUtMWksUmqj6Ux0yG0=;
        b=Nuqjn/YjcssfX34TdyNQelK+8Nrs3nLPg3YDb+6il/JF2Hv6CuCqju2iNGduzP2Ipf
         JJA+YG9MGyEfmUY3E3AKDdNDGTHujbzkDagMUJVPaawMtesHB9rbq3+M5q1xFcwoTq89
         PwwGtZyJSEd/i1d40AKF6axoplGNvPHLL1ddT4bKpOBXz66dd/IR6Hcu5TqDe0mWUOak
         rKZoP7PligT+E+Px49Z9EpSE06Dijg8e3GhKiGSrju9P4abRgRTgzPR0Ecx7SGnAN9ME
         9zMpgplniySHo+u5rApq8ngA24KgQYOrEv9QOD0O8Z1T9nYQVg9KfIVytO37veM8529I
         +ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525376; x=1744130176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCWfSwNPC+XN8l5NzUgrEcA3QoUtMWksUmqj6Ux0yG0=;
        b=F9NlnI2RJypTpnvOLdIr8eVAUqKDqeO/VurG07cACrsfB9wrQ4XT8vgsW2heYWHP9g
         ICvE9l0QWRp6caoQB3H59r046YTRxnwtpzXzQS3K40hDoQkNokQ7s4EWa7BZo2OABX7J
         RPCsmKV10Fx7hBZHO8/pBbaLRD7ueS/mSgyiL5baG2K4dA+6khkKLULXEPlOSSy2a15H
         yDaiT9mY5Cue/CZOnewKIPR6fx6GEDFGkqRhUoSZ6jrqNjzbAyto8Sgf9vN+t4PDo4DS
         8aTpWjIsJJxaFOXET52P54t1LxIDafbZHu/UtU4eNoYcS//daywqLWueIrZw8gDA661L
         gS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+9GJNdhHPrfTpAS1JKFm2L58Yckdzhs2QwXUxs3vCpRi0TekbjIjds5eZ2jbtolCy5YV9voM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oyNZpwV6pfoybNA8QIqMAPNbU3MGAGUYIjAo+gInxQvTWczF
	rpp7oYWAg2d4uNFObmFjB02Uxdza+9smefYYmIazZfEIFjAa6UxxQFv1Jl8uh9eqDc84le2gy+4
	h+TSBOoMh+WtrQdOPvmraO2/eYbwYw2YdnCyw
X-Gm-Gg: ASbGnctpQTnMgznkBqXWPL4aAr5PCPqa0de1zMeuebOrEIEgsYoK6yP5VdyvIdI9v+8
	+SdOqmas9OmDbFn+x/X6NuXGgKGoydEwxLTij06tcQRyLI3Uv4BZs1ZMm0C23M+wpltO1DZFzgV
	7IH/yOC3Awek+dgyRua45qQu7hKHo1xt/DO2NdqY4V4Rq8nlCmkkd5dEDWbK0I
X-Google-Smtp-Source: AGHT+IHpu+RDXFLrhez/bO7qMNmDwjWuiBjk5wTt/bM7Ts4DoqGjoNUPykLhpB4CO5/guAREtDNJyFVJzR8TpsuSUP4=
X-Received: by 2002:a19:7412:0:b0:549:4bc4:d3f7 with SMTP id
 2adb3069b0e04-54c0ac5a47bmr252912e87.5.1743525375373; Tue, 01 Apr 2025
 09:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328201634.3876474-1-tavip@google.com> <20250328201634.3876474-2-tavip@google.com>
 <Z+nYlgveEBukySzX@pop-os.localdomain> <5f493420-d7ff-43ab-827f-30e66b7df2c9@redhat.com>
 <CANn89iJW0VGQMvq6Bs8co8Bq6Dq1dUT7TN+EXg=GwYbSywUz0A@mail.gmail.com> <18c69469-5357-422e-a7dd-9722d502fd95@redhat.com>
In-Reply-To: <18c69469-5357-422e-a7dd-9722d502fd95@redhat.com>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 1 Apr 2025 09:36:03 -0700
X-Gm-Features: AQ5f1JoYw-u8hZr02SnkpnUyS41F3d8e1yK-8RZWtkFsZz6yKsH1VZ3RUC5rC6w
Message-ID: <CAGWr4cTaUcX+QWsQoDALRJEyEuD5Tm8fv2d6K4=FSYTHQrcMTA@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area for
 validating configuration
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, jhs@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 4:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 4/1/25 12:47 PM, Eric Dumazet wrote:
> > On Tue, Apr 1, 2025 at 11:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 3/31/25 1:49 AM, Cong Wang wrote:
> >>> On Fri, Mar 28, 2025 at 01:16:32PM -0700, Octavian Purdila wrote:
> >>>> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> >>>> index 65d5b59da583..027a3fde2139 100644
> >>>> --- a/net/sched/sch_sfq.c
> >>>> +++ b/net/sched/sch_sfq.c
> >>>> @@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct=
 nlattr *opt,
> >>>>      struct red_parms *p =3D NULL;
> >>>>      struct sk_buff *to_free =3D NULL;
> >>>>      struct sk_buff *tail =3D NULL;
> >>>> +    /* work area for validating changes before committing them */
> >>>> +    struct {
> >>>> +            int limit;
> >>>> +            unsigned int divisor;
> >>>> +            unsigned int maxflows;
> >>>> +            int perturb_period;
> >>>> +            unsigned int quantum;
> >>>> +            u8 headdrop;
> >>>> +            u8 maxdepth;
> >>>> +            u8 flags;
> >>>> +    } tmp;
> >>>
> >>> Thanks for your patch. It reminds me again about the lacking of compl=
ete
> >>> RCU support in TC. ;-)
> >>>
> >>> Instead of using a temporary struct, how about introducing a new one
> >>> called struct sfq_sched_opt and putting it inside struct sfq_sched_da=
ta?
> >>> It looks more elegant to me.
> >>
> >> I agree with that. It should also make the code more compact. @Octavia=
n,
> >> please update the patch as per Cong's suggestion.
> >
> > The concern with this approach was data locality.
>
> I did not consider that aspect.
>
> How about not using the struct at all, then?
>
>         int cur_limit;
>         // ...
>         u8 cur_flags;
>
> the 'tmp' struct is IMHO not so nice.
>

Thanks Paolo and Cong for the review.

I'll drop the structure, my initial thoughts were that by grouping
them into a structure it would make it easier to understand the
purpose of those variables, especially since we have a lot of local
variables now.

> > I had in my TODO list a patch to remove (accumulated over time) holes
> > and put together hot fields.
> >
> > Something like :
> >
> > struct sfq_sched_data {
> > int                        limit;                /*     0   0x4 */
> > unsigned int               divisor;              /*   0x4   0x4 */
> > u8                         headdrop;             /*   0x8   0x1 */
> > u8                         maxdepth;             /*   0x9   0x1 */
> > u8                         cur_depth;            /*   0xa   0x1 */
> > u8                         flags;                /*   0xb   0x1 */
> > unsigned int               quantum;              /*   0xc   0x4 */
> > siphash_key_t              perturbation;         /*  0x10  0x10 */
> > struct tcf_proto *         filter_list;          /*  0x20   0x8 */
> > struct tcf_block *         block;                /*  0x28   0x8 */
> > sfq_index *                ht;                   /*  0x30   0x8 */
> > struct sfq_slot *          slots;                /*  0x38   0x8 */
> > /* --- cacheline 1 boundary (64 bytes) --- */
> > struct red_parms *         red_parms;            /*  0x40   0x8 */
> > struct tc_sfqred_stats     stats;                /*  0x48  0x18 */
> > struct sfq_slot *          tail;                 /*  0x60   0x8 */
> > struct sfq_head            dep[128];             /*  0x68 0x200 */
> > /* --- cacheline 9 boundary (576 bytes) was 40 bytes ago --- */
> > unsigned int               maxflows;             /* 0x268   0x4 */
> > int                        perturb_period;       /* 0x26c   0x4 */
> > struct timer_list          perturb_timer;        /* 0x270  0x28 */
> >
> > /* XXX last struct has 4 bytes of padding */
> >
> > /* --- cacheline 10 boundary (640 bytes) was 24 bytes ago --- */
> > struct Qdisc *             sch;                  /* 0x298   0x8 */
> >
> > /* size: 672, cachelines: 11, members: 20 */
> > /* paddings: 1, sum paddings: 4 */
> > /* last cacheline: 32 bytes */
> > };
> >
> >
> > With this patch :
> >
> > diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> > index 65d5b59da583..f8fec2bc0d25 100644
> > --- a/net/sched/sch_sfq.c
> > +++ b/net/sched/sch_sfq.c
> > @@ -110,10 +110,11 @@ struct sfq_sched_data {
> >         unsigned int    divisor;        /* number of slots in hash tabl=
e */
> >         u8              headdrop;
> >         u8              maxdepth;       /* limit of packets per flow */
> > -
> > -       siphash_key_t   perturbation;
> >         u8              cur_depth;      /* depth of longest slot */
> >         u8              flags;
> > +       unsigned int    quantum;        /* Allotment per round: MUST
> > BE >=3D MTU */
> > +
> > +       siphash_key_t   perturbation;
> >         struct tcf_proto __rcu *filter_list;
> >         struct tcf_block *block;
> >         sfq_index       *ht;            /* Hash table ('divisor' slots)=
 */
> > @@ -132,7 +133,6 @@ struct sfq_sched_data {
> >
> >         unsigned int    maxflows;       /* number of flows in flows arr=
ay */
> >         int             perturb_period;
>
> Would it make any sense to additionally move 'maxflows' and
> 'perturb_period' at the top, just after 'perturbation'?
>
> Thanks,
>
> Paolo
>

