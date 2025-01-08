Return-Path: <netdev+bounces-156325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C97A0612B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16B47A2B01
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEA1FE47F;
	Wed,  8 Jan 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgFuPswW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFF1FE475
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352651; cv=none; b=Qt0a0q9BvETiDPqk9Ep3IG4Q10Ouurki9QZgOkgccHClLwz1M+e3rPKhWPu/FEo85H0CHxhtD1ks8pTrzJfykoWsxqSQyuIu7HUu5Nhc9apsy3JRnbo2pFkvH+EQCMCLzLMj9hpIXsl6mvc7rGjCURIu1hD9urWrX3dJMERGjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352651; c=relaxed/simple;
	bh=sQ9J4IusuZsbHu7OXkoS6C/4llEoDhLydUPr1brIwFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8q7Xvv5p87U35r8UcTmYO4PV8GcjnpQF2eNiB5WvCq51vxbJ+kxa5aTJpyJJqGdX6yjv29CkSU486aR1k/mDj5FdrCTqzkqVZJoRMAL0GFXclrFZS7K2eADdu5ijl1wZ5qVFZB3In4R/ZZYLR1MGE3y/xAWW34VGCUPUtVgosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgFuPswW; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fe83208a4so501525fac.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736352648; x=1736957448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPtSTUIAPGBBTRy2J0lBosbiPvH9eGM/VsJyPdKLfFo=;
        b=LgFuPswWOWkMAvVGcwIsDLZMQwjzRW4T6U1lAd0IRVTOtAJArPhSuLTvL5tNCoNzlE
         kTFNE8W8SOVHHSUiqob0afp6HvwofP/Wu8Z2knDmvC/gsKj0CBZ+KYZ/qPUjtdqhYHtS
         sLNSOep8lqdOFfMcxIHwSuDkXjXDnMxUcj5Fvn2U4eYnxJP/fukO7itdCKtnSohYpPdw
         jupKwjNPDO0g390pH4qZ/jNE+svgFyNhcYAVfju2v+n1qjHkQJwWmrIP4w3xwoG0CUol
         8uVjIJposydRvZYd081+6+TJwYuRl3pzIgcVhDRSf+v8JToJA80v0DYHnpAFKQomWixk
         jT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352648; x=1736957448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPtSTUIAPGBBTRy2J0lBosbiPvH9eGM/VsJyPdKLfFo=;
        b=BsMlkYSSdGhKYiqhSob/h7DuHuKeSE9SSPD7doNkBXvMnfJ31LWOxdxCmkCPlNbH6v
         qyi67YIWCtOliOWaZwYowRnrcrxdU3fa/udI5ifCvBh0+B3px9qGcKpsnV+Vg5XukBT7
         3oR4rvpItHUwB9RlBkoPTOG8nYtPrytO7NHER/y3DAhgywsq0QTrpkatiWJmFgZeMV9N
         ERc4WF2X+v8lQZ0RxGFOS/Heu/9TMU7ko8JjpRCddmAlSPAuDYViT9vb0TRQJy20qJtA
         j3bp6mIeGt2bmx7uleq6HlMIKFG3T2sPKxR1Be1mPzP7euEElkWqtzqDj7Px2COutJ7z
         SDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVVU4BG+EL8yBc9KYvMvoG90rMdTUzlajFX15BUiQXcAn0WnBnyYujfQkNe0AktQbMAhLeF7bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHd3Lxp4uJD+LE5BdIpNm6QVobV9IbiI/bjf2GcfFwr1k172kp
	0VmdmimIaYzea2FmNs8uWR3R4DLz1o/9k9wVRkaA2No6lg06xzkpFmdj0KlYQjhmD2nhglH6v2h
	nseFenT4Om2ShAPIl1YX8oh+GtO0=
X-Gm-Gg: ASbGnctMM6TWFPBL0dA6nLmwlzCXwBe39I/SCPq2cjIklyEL55n8TR4C7rcpqjBglzT
	dVZEkDtbd9BoPveg/fGOaIbXwwsPlCxkZAvZVHGkOxnm6jjqA5OfYnm6zdmbICQkLdXFHBjT6
X-Google-Smtp-Source: AGHT+IFVL68aUt8UrL4CyInyAhni4Rg+m1OY/4cJ3XWsQSRbrFaxVPlTTBniUJ0kE/3mL4m9St0ZQe/D88Z9yTizv20=
X-Received: by 2002:a05:6870:2f0b:b0:297:683:8b5b with SMTP id
 586e51a60fabf-2a9eab27e66mr3896617fac.10.1736352648176; Wed, 08 Jan 2025
 08:10:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107120105.70685-1-toke@redhat.com>
In-Reply-To: <20250107120105.70685-1-toke@redhat.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 8 Jan 2025 08:10:36 -0800
X-Gm-Features: AbW1kvZ1n8EFC7vOnu3ElN0IgDGZKcpL6qnOmOY6nRxve3H4wPGpS2_wjBxL_mQ
Message-ID: <CAA93jw7zsuC-TNK-XFUzXk1H7npcPgiaCg+dybNV5-s3ji5Pzw@mail.gmail.com>
Subject: Re: [Cake] [PATCH net v2] sched: sch_cake: add bounds checks to host
 bulk flow fairness counts
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	cake@lists.bufferbloat.net, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:01=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen via=
 Cake
<cake@lists.bufferbloat.net> wrote:
>
> Even though we fixed a logic error in the commit cited below, syzbot
> still managed to trigger an underflow of the per-host bulk flow
> counters, leading to an out of bounds memory access.
>
> To avoid any such logic errors causing out of bounds memory accesses,
> this commit factors out all accesses to the per-host bulk flow counters
> to a series of helpers that perform bounds-checking before any
> increments and decrements. This also has the benefit of improving
> readability by moving the conditional checks for the flow mode into
> these helpers, instead of having them spread out throughout the
> code (which was the cause of the original logic error).
>
> v2:
> - Remove now-unused srchost and dsthost local variables in cake_dequeue()
>
> Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for=
 host fairness")
> Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
>  1 file changed, 75 insertions(+), 65 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 8d8b2db4653c..2c2e2a67f3b2 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -627,6 +627,63 @@ static bool cake_ddst(int flow_mode)
>         return (flow_mode & CAKE_FLOW_DUAL_DST) =3D=3D CAKE_FLOW_DUAL_DST=
;
>  }
>
> +static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
> +                                            struct cake_flow *flow,
> +                                            int flow_mode)
> +{
> +       if (likely(cake_dsrc(flow_mode) &&
> +                  q->hosts[flow->srchost].srchost_bulk_flow_count))
> +               q->hosts[flow->srchost].srchost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
> +                                            struct cake_flow *flow,
> +                                            int flow_mode)
> +{
> +       if (likely(cake_dsrc(flow_mode) &&
> +                  q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE=
_QUEUES))
> +               q->hosts[flow->srchost].srchost_bulk_flow_count++;
> +}
> +
> +static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +                                            struct cake_flow *flow,
> +                                            int flow_mode)
> +{
> +       if (likely(cake_ddst(flow_mode) &&
> +                  q->hosts[flow->dsthost].dsthost_bulk_flow_count))
> +               q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +                                            struct cake_flow *flow,
> +                                            int flow_mode)
> +{
> +       if (likely(cake_ddst(flow_mode) &&
> +                  q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE=
_QUEUES))
> +               q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
> +}
> +
> +static u16 cake_get_flow_quantum(struct cake_tin_data *q,
> +                                struct cake_flow *flow,
> +                                int flow_mode)
> +{
> +       u16 host_load =3D 1;
> +
> +       if (cake_dsrc(flow_mode))
> +               host_load =3D max(host_load,
> +                               q->hosts[flow->srchost].srchost_bulk_flow=
_count);
> +
> +       if (cake_ddst(flow_mode))
> +               host_load =3D max(host_load,
> +                               q->hosts[flow->dsthost].dsthost_bulk_flow=
_count);
> +
> +       /* The get_random_u16() is a way to apply dithering to avoid
> +        * accumulating roundoff errors
> +        */
> +       return (q->flow_quantum * quantum_div[host_load] +
> +               get_random_u16()) >> 16;
> +}
> +
>  static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
>                      int flow_mode, u16 flow_override, u16 host_override)
>  {
> @@ -773,10 +830,8 @@ static u32 cake_hash(struct cake_tin_data *q, const =
struct sk_buff *skb,
>                 allocate_dst =3D cake_ddst(flow_mode);
>
>                 if (q->flows[outer_hash + k].set =3D=3D CAKE_SET_BULK) {
> -                       if (allocate_src)
> -                               q->hosts[q->flows[reduced_hash].srchost].=
srchost_bulk_flow_count--;
> -                       if (allocate_dst)
> -                               q->hosts[q->flows[reduced_hash].dsthost].=
dsthost_bulk_flow_count--;
> +                       cake_dec_srchost_bulk_flow_count(q, &q->flows[out=
er_hash + k], flow_mode);
> +                       cake_dec_dsthost_bulk_flow_count(q, &q->flows[out=
er_hash + k], flow_mode);
>                 }
>  found:
>                 /* reserve queue for future packets in same flow */
> @@ -801,9 +856,10 @@ static u32 cake_hash(struct cake_tin_data *q, const =
struct sk_buff *skb,
>                         q->hosts[outer_hash + k].srchost_tag =3D srchost_=
hash;
>  found_src:
>                         srchost_idx =3D outer_hash + k;
> -                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> -                               q->hosts[srchost_idx].srchost_bulk_flow_c=
ount++;
>                         q->flows[reduced_hash].srchost =3D srchost_idx;
> +
> +                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> +                               cake_inc_srchost_bulk_flow_count(q, &q->f=
lows[reduced_hash], flow_mode);
>                 }
>
>                 if (allocate_dst) {
> @@ -824,9 +880,10 @@ static u32 cake_hash(struct cake_tin_data *q, const =
struct sk_buff *skb,
>                         q->hosts[outer_hash + k].dsthost_tag =3D dsthost_=
hash;
>  found_dst:
>                         dsthost_idx =3D outer_hash + k;
> -                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> -                               q->hosts[dsthost_idx].dsthost_bulk_flow_c=
ount++;
>                         q->flows[reduced_hash].dsthost =3D dsthost_idx;
> +
> +                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BU=
LK)
> +                               cake_inc_dsthost_bulk_flow_count(q, &q->f=
lows[reduced_hash], flow_mode);
>                 }
>         }
>
> @@ -1839,10 +1896,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>
>         /* flowchain */
>         if (!flow->set || flow->set =3D=3D CAKE_SET_DECAYING) {
> -               struct cake_host *srchost =3D &b->hosts[flow->srchost];
> -               struct cake_host *dsthost =3D &b->hosts[flow->dsthost];
> -               u16 host_load =3D 1;
> -
>                 if (!flow->set) {
>                         list_add_tail(&flow->flowchain, &b->new_flows);
>                 } else {
> @@ -1852,18 +1905,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>                 flow->set =3D CAKE_SET_SPARSE;
>                 b->sparse_flow_count++;
>
> -               if (cake_dsrc(q->flow_mode))
> -                       host_load =3D max(host_load, srchost->srchost_bul=
k_flow_count);
> -
> -               if (cake_ddst(q->flow_mode))
> -                       host_load =3D max(host_load, dsthost->dsthost_bul=
k_flow_count);
> -
> -               flow->deficit =3D (b->flow_quantum *
> -                                quantum_div[host_load]) >> 16;
> +               flow->deficit =3D cake_get_flow_quantum(b, flow, q->flow_=
mode);
>         } else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
> -               struct cake_host *srchost =3D &b->hosts[flow->srchost];
> -               struct cake_host *dsthost =3D &b->hosts[flow->dsthost];
> -
>                 /* this flow was empty, accounted as a sparse flow, but a=
ctually
>                  * in the bulk rotation.
>                  */
> @@ -1871,12 +1914,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>                 b->sparse_flow_count--;
>                 b->bulk_flow_count++;
>
> -               if (cake_dsrc(q->flow_mode))
> -                       srchost->srchost_bulk_flow_count++;
> -
> -               if (cake_ddst(q->flow_mode))
> -                       dsthost->dsthost_bulk_flow_count++;
> -
> +               cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
> +               cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
>         }
>
>         if (q->buffer_used > q->buffer_max_used)
> @@ -1933,13 +1972,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  {
>         struct cake_sched_data *q =3D qdisc_priv(sch);
>         struct cake_tin_data *b =3D &q->tins[q->cur_tin];
> -       struct cake_host *srchost, *dsthost;
>         ktime_t now =3D ktime_get();
>         struct cake_flow *flow;
>         struct list_head *head;
>         bool first_flow =3D true;
>         struct sk_buff *skb;
> -       u16 host_load;
>         u64 delay;
>         u32 len;
>
> @@ -2039,11 +2076,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>         q->cur_flow =3D flow - b->flows;
>         first_flow =3D false;
>
> -       /* triple isolation (modified DRR++) */
> -       srchost =3D &b->hosts[flow->srchost];
> -       dsthost =3D &b->hosts[flow->dsthost];
> -       host_load =3D 1;
> -
>         /* flow isolation (DRR++) */
>         if (flow->deficit <=3D 0) {
>                 /* Keep all flows with deficits out of the sparse and dec=
aying
> @@ -2055,11 +2087,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>                                 b->sparse_flow_count--;
>                                 b->bulk_flow_count++;
>
> -                               if (cake_dsrc(q->flow_mode))
> -                                       srchost->srchost_bulk_flow_count+=
+;
> -
> -                               if (cake_ddst(q->flow_mode))
> -                                       dsthost->dsthost_bulk_flow_count+=
+;
> +                               cake_inc_srchost_bulk_flow_count(b, flow,=
 q->flow_mode);
> +                               cake_inc_dsthost_bulk_flow_count(b, flow,=
 q->flow_mode);
>
>                                 flow->set =3D CAKE_SET_BULK;
>                         } else {
> @@ -2071,19 +2100,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>                         }
>                 }
>
> -               if (cake_dsrc(q->flow_mode))
> -                       host_load =3D max(host_load, srchost->srchost_bul=
k_flow_count);
> -
> -               if (cake_ddst(q->flow_mode))
> -                       host_load =3D max(host_load, dsthost->dsthost_bul=
k_flow_count);
> -
> -               WARN_ON(host_load > CAKE_QUEUES);
> -
> -               /* The get_random_u16() is a way to apply dithering to av=
oid
> -                * accumulating roundoff errors
> -                */
> -               flow->deficit +=3D (b->flow_quantum * quantum_div[host_lo=
ad] +
> -                                 get_random_u16()) >> 16;
> +               flow->deficit +=3D cake_get_flow_quantum(b, flow, q->flow=
_mode);
>                 list_move_tail(&flow->flowchain, &b->old_flows);
>
>                 goto retry;
> @@ -2107,11 +2124,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>                                 if (flow->set =3D=3D CAKE_SET_BULK) {
>                                         b->bulk_flow_count--;
>
> -                                       if (cake_dsrc(q->flow_mode))
> -                                               srchost->srchost_bulk_flo=
w_count--;
> -
> -                                       if (cake_ddst(q->flow_mode))
> -                                               dsthost->dsthost_bulk_flo=
w_count--;
> +                                       cake_dec_srchost_bulk_flow_count(=
b, flow, q->flow_mode);
> +                                       cake_dec_dsthost_bulk_flow_count(=
b, flow, q->flow_mode);
>
>                                         b->decaying_flow_count++;
>                                 } else if (flow->set =3D=3D CAKE_SET_SPAR=
SE ||
> @@ -2129,12 +2143,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>                                 else if (flow->set =3D=3D CAKE_SET_BULK) =
{
>                                         b->bulk_flow_count--;
>
> -                                       if (cake_dsrc(q->flow_mode))
> -                                               srchost->srchost_bulk_flo=
w_count--;
> -
> -                                       if (cake_ddst(q->flow_mode))
> -                                               dsthost->dsthost_bulk_flo=
w_count--;
> -
> +                                       cake_dec_srchost_bulk_flow_count(=
b, flow, q->flow_mode);
> +                                       cake_dec_dsthost_bulk_flow_count(=
b, flow, q->flow_mode);
>                                 } else
>                                         b->decaying_flow_count--;
>
> --
> 2.47.1
>

Acked-By: Dave Taht <dave.taht@gmail.com>



--=20
Dave T=C3=A4ht CSO, LibreQos

