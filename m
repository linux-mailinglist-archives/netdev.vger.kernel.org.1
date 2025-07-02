Return-Path: <netdev+bounces-203214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7397AF0C6F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2531C1799DF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F9229B21;
	Wed,  2 Jul 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dEJEgARE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94E1E47AE
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440864; cv=none; b=emxlSNSIRqPOofxn0Kkgw1DLGcwxc4SezIUMdRYV1Zb7GcpieOkKEU4pg/+xwm8ELEeJnpe/7pExyOlX/FoOCCXpoZ4+DcmWP25Cn/J8BJglzxEiqpfunwza31WZL1qVnxg8KQ1m5N1EVQxA+aWMEZZqQb3XxJZ3npEikER2WIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440864; c=relaxed/simple;
	bh=tZY/DrlGnyl16eYjqf9UQkSpCHrNPRCwVIqb6q2aGmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxSz1vdeLD0CBJp2aDWUistbDlDNWuJtU6+rodm0wACNgVyuicwPF3oUUxJH71TdSy0ZIAEbNA2iXbxeQcdcTVeRIkSdYEpIrsuWU9jsd+/UsT85ta68Gq6m3JIjLAplRuwR9TRyIDfVqUMnJ+fam8JJnxdqp8rSudLPndFcnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dEJEgARE; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4312b4849so75978391cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751440861; x=1752045661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue5I78f5HBerUh5eb4lxr4esjna08lC1QvK9e4dca04=;
        b=dEJEgAREZgvbNwax+VR/XYCxfJf8mTkMqf7LY6hT//lsFe7fi3fsSZFMmxMcoeGnvj
         jzAEQescWBgU++JMgfHZ0nI6Nqa2aBGXRwj6/TgHMAmNTQYsGR6RupU+ht9YyDBjO+PL
         3pa6s7/CjXc86XiJ1GNJbc0AyIEvfKIqILUSJhHrbfr0632Jf8QpBbEjhgxWaLvM4WBU
         /suue3DwXAZ33eiZNhyBsHN9cah/9sxmASZREHMEIUjsRiWkbSr1jDPShpZmtWF5lFKy
         3iChCr1uY2mYAjmoK16pQ3s9/Ni6jdAL40SzzbDXpD2YrIE6zHff75rFpclTHKEw/fsU
         Z5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440861; x=1752045661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue5I78f5HBerUh5eb4lxr4esjna08lC1QvK9e4dca04=;
        b=agN7xYZveqgGgDXwYmMxv4aGsU1YJqPOf2YgsS/WtoganJafk4H9fYFxRoGquGzSJl
         Sk6mFQf7fo9C4QuvpIMKD8f0uCyXjBDCc4C408JlQE8Ae0EkQTQPgs0Kf4isi4G0E9w9
         ImTo8NxpOOcJvfGCFQir47HNt2TaX5sQZ3tmYCSHlJgx4akS/i+mnFLHHgvqWua9Ycrv
         iXVlaqB/+0B67rs7fF7XwoPi6y0K8cvyTAQd0q/BoXTephAlQ5bHdpAH5moCtZIMvMas
         4JcAcOKNR0cOL+6SWB5gK+q3GZm6hpgfLNq7CLJV8jfg0JXkyM4mFIdY+iPsovgEhDLc
         V+tg==
X-Gm-Message-State: AOJu0YzURXp+o9VSuJc5V5QXbnDXktUft8Xe5LAq4CWC9aun/EhNeSz/
	2Q1Slr3YEls8ikdgOKECjC0ge3gJ0wcbLbX6IzE3uET4jY2WctLrSoulEHucCLEx/D/d1349aAH
	i69ldraA4gKcVnsa5CTMW0IJ9uKTEQzXlcmnWq2gY
X-Gm-Gg: ASbGncv/Y7AroIU4qdxjvOTWdzHI6QGk6m/vTXNzzxjb+JXsSohJH9s7A7lq93fPnaT
	yjwY81KIDkU4M4T5aluFAP2V2PoHjY7dUxstRQgnguDH7mMmNxRyLJ1Ul9KXw7lzg8uGbbfcimj
	pyoF1AgfM9mlnDu5G7SJRIYUDuct54migfrSElqbIm8UWQeTx7r7Q+kIO5oyAlOP/Mr0vhjig6R
	dTURA==
X-Google-Smtp-Source: AGHT+IETgVD7dU1QwNIrcEBht5QTx9oQB3AIzL/WoA6iEb7VcMeBwdBh1zSIaL4RT9AnGR/k3LEq0KVkPT+Lhk/3LS4=
X-Received: by 2002:a05:622a:190f:b0:499:5503:7b2c with SMTP id
 d75a77b69052e-4a976a76586mr29888501cf.43.1751440861206; Wed, 02 Jul 2025
 00:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025070231-unrented-sulfate-8b6f@gregkh> <20250702071818.10161-1-xmei5@asu.edu>
In-Reply-To: <20250702071818.10161-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 2 Jul 2025 00:20:51 -0700
X-Gm-Features: Ac12FXzwRRbZh07a7Sd7qO61mi2weeDfjUhZRWxqJqdw_XILvQfv-xYgODXo1XE
Message-ID: <CAPpSM+Toj3BJyz2NhtSGS2k3io26x+f5eh1cg-_E_6ePARcCmw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: Fix null-deref in agg_dequeue
To: gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jhs@mojatatu.com, 
	jiri@resnulli.us, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am sorry for the inconvenience and I appreciate your patience and
help. The new patch was sent.


On Wed, Jul 2, 2025 at 12:18=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
> when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
> value before using it, similar to the existing approach in sch_hfsc.c.
>
> To avoid code duplication, the following changes are made:
>
> 1. Moved qdisc_warn_nonwc to include/net/sch_generic.h and removed
> its EXPORT_SYMBOL declaration, since all users include the header.
>
> 2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
> include/net/sch_generic.h so that sch_qfq can reuse it.
>
> 3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  include/net/sch_generic.h | 24 ++++++++++++++++++++++++
>  net/sched/sch_api.c       | 10 ----------
>  net/sched/sch_hfsc.c      | 16 ----------------
>  net/sched/sch_qfq.c       |  2 +-
>  4 files changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 3287988a6a98..d090aaa59ef2 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -814,11 +814,35 @@ static inline bool qdisc_tx_is_noop(const struct ne=
t_device *dev)
>         return true;
>  }
>
> +static inline void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc=
)
> +{
> +       if (!(qdisc->flags & TCQ_F_WARN_NONWC)) {
> +               pr_warn("%s: %s qdisc %X: is non-work-conserving?\n",
> +                       txt, qdisc->ops->id, qdisc->handle >> 16);
> +               qdisc->flags |=3D TCQ_F_WARN_NONWC;
> +       }
> +}
> +
>  static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
>  {
>         return qdisc_skb_cb(skb)->pkt_len;
>  }
>
> +static inline unsigned int qdisc_peek_len(struct Qdisc *sch)
> +{
> +       struct sk_buff *skb;
> +       unsigned int len;
> +
> +       skb =3D sch->ops->peek(sch);
> +       if (unlikely(skb =3D=3D NULL)) {
> +               qdisc_warn_nonwc("qdisc_peek_len", sch);
> +               return 0;
> +       }
> +       len =3D qdisc_pkt_len(skb);
> +
> +       return len;
> +}
> +
>  /* additional qdisc xmit flags (NET_XMIT_MASK in linux/netdevice.h) */
>  enum net_xmit_qdisc_t {
>         __NET_XMIT_STOLEN =3D 0x00010000,
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index df89790c459a..6518fdc63dc2 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -594,16 +594,6 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
>         qdisc_skb_cb(skb)->pkt_len =3D pkt_len;
>  }
>
> -void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc)
> -{
> -       if (!(qdisc->flags & TCQ_F_WARN_NONWC)) {
> -               pr_warn("%s: %s qdisc %X: is non-work-conserving?\n",
> -                       txt, qdisc->ops->id, qdisc->handle >> 16);
> -               qdisc->flags |=3D TCQ_F_WARN_NONWC;
> -       }
> -}
> -EXPORT_SYMBOL(qdisc_warn_nonwc);
> -
>  static enum hrtimer_restart qdisc_watchdog(struct hrtimer *timer)
>  {
>         struct qdisc_watchdog *wd =3D container_of(timer, struct qdisc_wa=
tchdog,
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index afcb83d469ff..751b1e2c35b3 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -835,22 +835,6 @@ update_vf(struct hfsc_class *cl, unsigned int len, u=
64 cur_time)
>         }
>  }
>
> -static unsigned int
> -qdisc_peek_len(struct Qdisc *sch)
> -{
> -       struct sk_buff *skb;
> -       unsigned int len;
> -
> -       skb =3D sch->ops->peek(sch);
> -       if (unlikely(skb =3D=3D NULL)) {
> -               qdisc_warn_nonwc("qdisc_peek_len", sch);
> -               return 0;
> -       }
> -       len =3D qdisc_pkt_len(skb);
> -
> -       return len;
> -}
> -
>  static void
>  hfsc_adjust_levels(struct hfsc_class *cl)
>  {
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 5e557b960bde..e0cefa21ce21 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -992,7 +992,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggrega=
te *agg,
>
>         if (cl->qdisc->q.qlen =3D=3D 0) /* no more packets, remove from l=
ist */
>                 list_del_init(&cl->alist);
> -       else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdi=
sc))) {
> +       else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
>                 cl->deficit +=3D agg->lmax;
>                 list_move_tail(&cl->alist, &agg->active);
>         }
> --
> 2.43.0
>

