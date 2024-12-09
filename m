Return-Path: <netdev+bounces-150409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878ED9EA290
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE87162EA1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F997156F5F;
	Mon,  9 Dec 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygg5ZbUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378F19F41B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786113; cv=none; b=SeDVZNDQgsgcYqJMbGUtJiT4GCFbP6GLhlDlkdXnu2X4mklEwqoJMJBlS8AV7XWF8DcAxZOROHqnwxG21xTNXFPZzZDlRGkqbo8kdHJ7pwNDocwfMtUgKGIXdF5MYGneOUNKfWQa8DtQpGm+t7fzHX+raCxe/M4pFw+ha+6YFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786113; c=relaxed/simple;
	bh=z7w+UYztA7zsNUunoHdaIOCphX/2qeA/vx6sVSMCUjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4Tgv6RvNEkhVMWjEm0pSkNf3fE5Lj9mdi2+jOe9cskykz2PueDUKfBlb9Fkf1XOFxj8WtuFruEty6GVkdi+9HlFn9ehorvXnLvsDbsQrwE2DNt3f0nIMEAQ6njP3dWKzi/xaVZWmN/R9WDpyVFHX7Ev94yySrdCbKDc26RfHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygg5ZbUG; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29ff039dab2so292316fac.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786111; x=1734390911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT0taicduTyFzRj+hGHo9ToMaJn9bA+H0OcTkrm9EV4=;
        b=Ygg5ZbUGNbwRebLMgja+NwpWTvQlLDt1PtqJhh2alZkaDswN3srcqutc7gCMbwyHzF
         ccI7OUQgYOJS33bj/Wz36jSF+PkIBq9J88icbOMY3twJ5oJbLjBaOZdqFYMgxvHdluvs
         L0v2DussSFYcGN7GomxxAZ124ajv41LrWuTC7/Wdq08GZCf9/s/GS3JB2LRbeivP9YwI
         Uxm2Pv4nLz1WMHCBOrncp+fS/ZeBh+SRty1KfEbO8lXm3muQiTHfBjY3mdUVJdlPnskC
         ZEPeeARwRXKDISHpU4E5puubR6OTDM5M+4B9XD1rGM+PJbYKHlRrwHbCOYZUHv79m835
         77sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786111; x=1734390911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT0taicduTyFzRj+hGHo9ToMaJn9bA+H0OcTkrm9EV4=;
        b=WZR383DZ7J2m3quxI4KImbQYhG+YKCeNhuP4PoKvczXmdA0Gs60y0dYJh1BaDe/Hst
         ZFu1GIQrkC3vkmo/8RBBhHg66BzCSoJN9nj5yzlsRTOvYOGaF335ec+Is+brFlAoLiPV
         xSnYKcTuFKfgdLHGFVd3XwoTtDQI/TtjNH8cYgFKcSKUN80iZCJ6QCbkB8InjpNWPmeu
         0/VgGHAxc9s48Y9OMEnGDfDH68Kh0Zl94uDU84i8lUlsNK0u300mLd79lGlKTg2Y9VLF
         QMV7MYveHyPlSsptH14UiLdZJZg/xxN0TkoVoe9NJ0slG+zGAni2mlEvH0Vz+I1R5pVU
         FH/w==
X-Forwarded-Encrypted: i=1; AJvYcCW9IrSZTfS6whCkmFZLt/GD+GU2xV33yVEsPHARo4I9t6RM0rwMHFotY4J+aa5ezBdwn91ku2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QdoJUmyaa84UnZkQT3ie1SuxCFeeouhr1Si0BenOWC6i2APz
	brm4sHp0iaGfW6ZLuFO6gjdYxIGaqIRqlSejwW0jLtu0P7pV5JZM9PxhXre17SFMFD/sMFpd3lH
	KINS0tD7j/eNTMlbKht8HohPOSqrMsWHF
X-Gm-Gg: ASbGncse7fcVtnQwGOWO38H2RpDam6v+GPhSWAyPpthZa69A/rM1bBhAfB7SM4k6OGr
	3A20i0q80ocYo3aBVfhMQg+ZtG5AdEqGyhml86uy7S7M9e895S09Ls+XKEagtUZMzaVTEtw==
X-Google-Smtp-Source: AGHT+IEn+3skx6FmigV7ZMQEpIkDaJIGAiVLy0ww5xKkWsijLHrrkkQOAhw63Hy2tGYlpqBEC8/XakwSF2wefq/MygY=
X-Received: by 2002:a05:6870:390f:b0:296:fff8:817 with SMTP id
 586e51a60fabf-29fee724c79mr1524427fac.35.1733786110756; Mon, 09 Dec 2024
 15:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
In-Reply-To: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Mon, 9 Dec 2024 15:14:58 -0800
Message-ID: <CAA93jw4S_fLpZDvk04QxeAaBaH5m6d8px1jE-B4KKqR-C88Khw@mail.gmail.com>
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, cake@lists.bufferbloat.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen via=
 Cake
<cake@lists.bufferbloat.net> wrote:
>
> Add three qdisc-specific drop reasons for sch_cake:
>
>  1) SKB_DROP_REASON_CAKE_CONGESTED
>     Whenever a packet is dropped by the CAKE AQM algorithm because
>     congestion is detected.
>
>  2) SKB_DROP_REASON_CAKE_FLOOD
>     Whenever a packet is dropped by the flood protection part of the
>     CAKE AQM algorithm (BLUE).
>
>  3) SKB_DROP_REASON_CAKE_OVERLIMIT
>     Whenever the total queue limit for a CAKE instance is exceeded and a
>     packet is dropped to make room.
>
> Also use the existing SKB_DROP_REASON_QUEUE_PURGE in cake_clear_tin().
>
> Reasons show up as:
>
> perf record -a -e skb:kfree_skb sleep 1; perf script
>
>           iperf3     665 [005]   848.656964: skb:kfree_skb: skbaddr=3D0xf=
fff98168a333500 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x10f0 reason: CAKE_OVERLIMIT
>          swapper       0 [001]   909.166055: skb:kfree_skb: skbaddr=3D0xf=
fff98168280cee0 rx_sk=3D(nil) protocol=3D34525 location=3Dcake_dequeue+0x5e=
f reason: CAKE_CONGESTED
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Acked-by: Dave Taht <dave.taht@gmail.com>

> ---
>  include/net/dropreason-core.h | 18 ++++++++++++++++++
>  net/sched/sch_cake.c          | 43 +++++++++++++++++++++++--------------=
------
>  2 files changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index c29282fabae6cdf9dd79f698b92b4b8f57156b1e..a9be76be11ad67d6cc7175f1a=
643314a7dcdf0b8 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -61,6 +61,9 @@
>         FN(FQ_BAND_LIMIT)               \
>         FN(FQ_HORIZON_LIMIT)            \
>         FN(FQ_FLOW_LIMIT)               \
> +       FN(CAKE_CONGESTED)              \
> +       FN(CAKE_FLOOD)                  \
> +       FN(CAKE_OVERLIMIT)              \
>         FN(CPU_BACKLOG)                 \
>         FN(XDP)                         \
>         FN(TC_INGRESS)                  \
> @@ -329,6 +332,21 @@ enum skb_drop_reason {
>          * exceeds its limits.
>          */
>         SKB_DROP_REASON_FQ_FLOW_LIMIT,
> +       /**
> +        * @SKB_DROP_REASON_CAKE_CONGESTED: dropped by the CAKE qdisc AQM
> +        * algorithm due to congestion.
> +        */
> +       SKB_DROP_REASON_CAKE_CONGESTED,
> +       /**
> +        * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection p=
art of
> +        * CAKE qdisc AQM algorithm (BLUE).
> +        */
> +       SKB_DROP_REASON_CAKE_FLOOD,
> +       /**
> +        * @SKB_DROP_REASON_CAKE_OVERLIMIT: dropped by CAKE qdisc when a =
qdisc
> +        * instance exceeds its total buffer size limit.
> +        */
> +       SKB_DROP_REASON_CAKE_OVERLIMIT,
>         /**
>          * @SKB_DROP_REASON_CPU_BACKLOG: failed to enqueue the skb to the=
 per CPU
>          * backlog queue. This can be caused by backlog queue full (see
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 8d8b2db4653c0c9f271f9c1953e8c61175d8f76b..a57bdc771dd14e81fb0cdf54c=
a7890ac96f1e311 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -484,13 +484,14 @@ static bool cobalt_queue_empty(struct cobalt_vars *=
vars,
>  /* Call this with a freshly dequeued packet for possible congestion mark=
ing.
>   * Returns true as an instruction to drop the packet, false for delivery=
.
>   */
> -static bool cobalt_should_drop(struct cobalt_vars *vars,
> -                              struct cobalt_params *p,
> -                              ktime_t now,
> -                              struct sk_buff *skb,
> -                              u32 bulk_flows)
> +static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
> +                                              struct cobalt_params *p,
> +                                              ktime_t now,
> +                                              struct sk_buff *skb,
> +                                              u32 bulk_flows)
>  {
> -       bool next_due, over_target, drop =3D false;
> +       enum skb_drop_reason reason =3D SKB_NOT_DROPPED_YET;
> +       bool next_due, over_target;
>         ktime_t schedule;
>         u64 sojourn;
>
> @@ -533,7 +534,8 @@ static bool cobalt_should_drop(struct cobalt_vars *va=
rs,
>
>         if (next_due && vars->dropping) {
>                 /* Use ECN mark if possible, otherwise drop */
> -               drop =3D !(vars->ecn_marked =3D INET_ECN_set_ce(skb));
> +               if (!(vars->ecn_marked =3D INET_ECN_set_ce(skb)))
> +                       reason =3D SKB_DROP_REASON_CAKE_CONGESTED;
>
>                 vars->count++;
>                 if (!vars->count)
> @@ -556,16 +558,17 @@ static bool cobalt_should_drop(struct cobalt_vars *=
vars,
>         }
>
>         /* Simple BLUE implementation.  Lack of ECN is deliberate. */
> -       if (vars->p_drop)
> -               drop |=3D (get_random_u32() < vars->p_drop);
> +       if (vars->p_drop && reason =3D=3D SKB_NOT_DROPPED_YET &&
> +           get_random_u32() < vars->p_drop)
> +               reason =3D SKB_DROP_REASON_CAKE_FLOOD;
>
>         /* Overload the drop_next field as an activity timeout */
>         if (!vars->count)
>                 vars->drop_next =3D ktime_add_ns(now, p->interval);
> -       else if (ktime_to_ns(schedule) > 0 && !drop)
> +       else if (ktime_to_ns(schedule) > 0 && reason =3D=3D SKB_NOT_DROPP=
ED_YET)
>                 vars->drop_next =3D now;
>
> -       return drop;
> +       return reason;
>  }
>
>  static bool cake_update_flowkeys(struct flow_keys *keys,
> @@ -1528,12 +1531,11 @@ static unsigned int cake_drop(struct Qdisc *sch, =
struct sk_buff **to_free)
>
>         flow->dropped++;
>         b->tin_dropped++;
> -       sch->qstats.drops++;
>
>         if (q->rate_flags & CAKE_FLAG_INGRESS)
>                 cake_advance_shaper(q, b, skb, now, true);
>
> -       __qdisc_drop(skb, to_free);
> +       qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_CAKE_OVERLIM=
IT);
>         sch->q.qlen--;
>         qdisc_tree_reduce_backlog(sch, 1, len);
>
> @@ -1926,7 +1928,7 @@ static void cake_clear_tin(struct Qdisc *sch, u16 t=
in)
>         q->cur_tin =3D tin;
>         for (q->cur_flow =3D 0; q->cur_flow < CAKE_QUEUES; q->cur_flow++)
>                 while (!!(skb =3D cake_dequeue_one(sch)))
> -                       kfree_skb(skb);
> +                       kfree_skb_reason(skb, SKB_DROP_REASON_QUEUE_PURGE=
);
>  }
>
>  static struct sk_buff *cake_dequeue(struct Qdisc *sch)
> @@ -1934,6 +1936,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>         struct cake_sched_data *q =3D qdisc_priv(sch);
>         struct cake_tin_data *b =3D &q->tins[q->cur_tin];
>         struct cake_host *srchost, *dsthost;
> +       enum skb_drop_reason reason;
>         ktime_t now =3D ktime_get();
>         struct cake_flow *flow;
>         struct list_head *head;
> @@ -2143,12 +2146,12 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>                         goto begin;
>                 }
>
> +               reason =3D cobalt_should_drop(&flow->cvars, &b->cparams, =
now, skb,
> +                                           (b->bulk_flow_count *
> +                                            !!(q->rate_flags &
> +                                               CAKE_FLAG_INGRESS)));
>                 /* Last packet in queue may be marked, shouldn't be dropp=
ed */
> -               if (!cobalt_should_drop(&flow->cvars, &b->cparams, now, s=
kb,
> -                                       (b->bulk_flow_count *
> -                                        !!(q->rate_flags &
> -                                           CAKE_FLAG_INGRESS))) ||
> -                   !flow->head)
> +               if (reason =3D=3D SKB_NOT_DROPPED_YET || !flow->head)
>                         break;
>
>                 /* drop this packet, get another one */
> @@ -2162,7 +2165,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>                 b->tin_dropped++;
>                 qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
>                 qdisc_qstats_drop(sch);
> -               kfree_skb(skb);
> +               kfree_skb_reason(skb, reason);
>                 if (q->rate_flags & CAKE_FLAG_INGRESS)
>                         goto retry;
>         }
>
> ---
> base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
> change-id: 20241205-cake-drop-reason-b1661e1e7f0a
>
> _______________________________________________
> Cake mailing list
> Cake@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/cake



--=20
Dave T=C3=A4ht CSO, LibreQos

