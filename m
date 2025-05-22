Return-Path: <netdev+bounces-192663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDEAC0BC7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E83AE187
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95728B3EB;
	Thu, 22 May 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uAaiQ/Dc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083F28B3E2
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917622; cv=none; b=SQEHuEl1wvfgOD2jw2VwQQuYFR7x1oYUnpElEFMLTvKsaJdwG+ttuN5ugGL+yh7lKERRutT8AS28eszHTejefn6N1OH1+0yqtFfC06iKpnLsMYnLqmKe9Z1r/Plh3jy51jXvRp6tovfaH7ZhuptZfV908SlDuyFN3b0KULCahN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917622; c=relaxed/simple;
	bh=D7/o3G/FLiWC04zNI2LUYfxQcxkgrRkebOw/RYu9u7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFHJMNOnH/RdjtWv/q3NxirdmuhhrSbc1q42WDuUBFCnuVmZsQOWADftA+V+jpwxjZsmursO0IQXe5GysQekO6q6xaZeL3CCC3/7Wo+UBKi+goLiBDMQyaFYfB6nn6Zri772smOLGBEp2hy0V67TYP7JfJ2lbKbw33D+u3SYfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=uAaiQ/Dc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9563fd9so4188974b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747917620; x=1748522420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9nkPqZzKJEfuuS02rpd9TdBTZk6ORVeOMt0hg43isU=;
        b=uAaiQ/DcK3+MFP4qZn26A5KkNHYF/ImGh7YNHiIKRC6y9+Ulzyd2LoiZPR2M9qzXA0
         SSx2mro/fOAOqPBXISpFVQmRpW86e93qnCVFCO6Koyn9dsKD9vRqOQEfC6N/r9J7Q3wN
         ENN+uuQ0mSspXGQS1q+fP/J6Qkejb9CN+OQmO2sYdpjnDcfDM4VWFdEHfA0AbGTB6Sh3
         jyJCoQnf55by3H/cXwthdceVrKBBK4NvBHvDv9WAFGFN7n+I5azSD2AQhkt9WKsn459i
         WF3wv5R2tExyDQLqaFicOfqGruH7dloQRCMoWFYcFLwsdjFlIOnBmy2a8FhR9QDvFm/w
         HP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917620; x=1748522420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9nkPqZzKJEfuuS02rpd9TdBTZk6ORVeOMt0hg43isU=;
        b=Q3YNo3R4/6mpfYIl3Lj9VeRRrnpP7Stm+uLwNXUGha8bUUq2Rm6amR4iyLdzy4n7au
         RwEaECSvpRNGhjV9wJJrXUSueQn3B71rj9NeA6mKBfOzAb69ROmFCymUvAmGiqqOQGqG
         Xdotnzf6HtBZ2zhKgxD6+dwx2m5cydwerUsIkOlP6oB0SA4SO1aVWvEY6pGZp899o75g
         V88LWZfQr0/LgtSLYg8nHQsZ9iNM9taoI9JZ/RZugDnGOwgUW8jfskhvxyWEcR0NdV76
         DHEAkCmxYrh0/CgTzCjarFVlLE2YGHKFv2rtp3e5ngj9+2OGg9mKexOq8eTErR8b+aoH
         3o3w==
X-Gm-Message-State: AOJu0YwDvSsYf11Pzzmh1vFReWM1/E1O1392+T34AmoaYdycamH7F1xa
	sGy0tQl74Ua9fBVd4hznNqWM360uJuAt2L6cQuBByJOjzwxcbKMd9GQ5KWiDd/iCurpl0OaULxY
	SPvXqt7KdT0GBzKaR4/YlYh7Qn2ukEe7atlwRwYmI
X-Gm-Gg: ASbGncs8fpnPKdUKvFHKSgLnUU5Ljv5WfpY7rIBNIzSSmzGmI4DPHqHWtBDGtRqPsTP
	2nTnk1gO58nMpYKU+ygEGInP9IwL1RK/6smyeUJfbtPNGnUVa7fD1zAocgugFNP07U636FhCF7E
	A+lbgTmgGxfvZQhdQ2WZ+maPyzT3/hpuQ=
X-Google-Smtp-Source: AGHT+IHh9zdDZrJpNf9OpZppuMnq6ZI32i8IypvUyHO1Ug1PDslol5kRx2M/cXrjsTruBaIFqqtxIODk9hpMWfbZC7k=
X-Received: by 2002:a05:6a00:1495:b0:740:6615:33c7 with SMTP id
 d2e1a72fcca58-742acd7280fmr31958370b3a.23.1747917620288; Thu, 22 May 2025
 05:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521205351.1395206-1-pctammela@mojatatu.com>
In-Reply-To: <20250521205351.1395206-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 May 2025 08:40:09 -0400
X-Gm-Features: AX0GCFvtlgd8BtTZU0-p34lcPDsF6c2EesA6cKGmjalJl1KZdzBIw0RZQ8UA7mY
Message-ID: <CAM0EoMnA8rKvj5mG7fq9hXUPbaGRqcZJG7=2C2eJ-2cfLgwtSg@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: hfsc: Address reentrant enqueue adding
 class to eltree twice
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Savy <savy@syst3mfailure.io>, Will <will@willsroot.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 4:54=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Savy says:
>     "We are writing to report that this recent patch
>     (141d34391abbb315d68556b7c67ad97885407547) [1]
>     can be bypassed, and a UAF can still occur when HFSC is utilized with
>     NETEM.
>
>     The patch only checks the cl->cl_nactive field to determine whether
>     it is the first insertion or not [2], but this field is only
>     incremented by init_vf [3].
>
>     By using HFSC_RSC (which uses init_ed) [4], it is possible to bypass =
the
>     check and insert the class twice in the eltree.
>     Under normal conditions, this would lead to an infinite loop in
>     hfsc_dequeue for the reasons we already explained in this report [5].
>
>     However, if TBF is added as root qdisc and it is configured with a
>     very low rate,
>     it can be utilized to prevent packets from being dequeued.
>     This behavior can be exploited to perform subsequent insertions in th=
e
>     HFSC eltree and cause a UAF."
>
> To fix both the UAF and the inifinite loop, with netem as an hfsc child,
> check explicitly in hfsc_enqueue whether the class is already in the eltr=
ee
> whenever the HFSC_RSC flag is set.
>
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D141d34391abbb315d68556b7c67ad97885407547
> [2] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L1572
> [3] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L677
> [4] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L1574
> [5] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/T/#u
>
> Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdisc=
s")
> Reported-by: Savy <savy@syst3mfailure.io>
> Reported-by: Will <will@willsroot.io>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/sch_hfsc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index cb8c525ea..1c4067bec 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -175,6 +175,11 @@ struct hfsc_sched {
>
>  #define        HT_INFINITY     0xffffffffffffffffULL   /* infinite time =
value */
>
> +static bool cl_in_el_or_vttree(struct hfsc_class *cl)
> +{
> +       return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
> +               ((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node=
));
> +}
>
>  /*
>   * eligible tree holds backlogged classes being sorted by their eligible=
 times.
> @@ -1089,6 +1094,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u=
32 parentid,
>                 qdisc_purge_queue(parent->qdisc);
>         hfsc_adjust_levels(parent);
>         sch_tree_unlock(sch);
> +       RB_CLEAR_NODE(&cl->el_node);
>
>         qdisc_class_hash_grow(sch, &q->clhash);
>
> @@ -1569,7 +1575,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch=
, struct sk_buff **to_free)
>                 return err;
>         }
>
> -       if (first && !cl->cl_nactive) {
> +       if (first && !cl_in_el_or_vttree(cl)) {
>                 if (cl->cl_flags & HFSC_RSC)
>                         init_ed(cl, len);
>                 if (cl->cl_flags & HFSC_FSC)
> --
> 2.43.0
>

