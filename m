Return-Path: <netdev+bounces-204354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EAAFA24C
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02247A5929
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140B21B9D6;
	Sat,  5 Jul 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="PaDaAx5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DACFBF6
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751755794; cv=none; b=DuNg9kmxFRpbiFgMZ5NCD/L3cPFew6vYVWNNrMt0IzBN3L+DbmRBGOLy+zk0GhvzQNGTeOl42esEdrgiHd654/ogwjAbvbtLYOr6icp5fhUR74vb7qnxAJDDkoVEPj5zKcovfbCkYaQNystMj05g1/r3arxgkF/5Zvj50TJExiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751755794; c=relaxed/simple;
	bh=idgdz/t6GiVUp7YeP/z1mwqL60Qucygf1VjmYBc8jCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO7Mi7gj+35iRz+k7yneCVXKmPu9kO6dT1uUojuNvXCQyAexrLDc0Da+mDsb6gFOTTo3IZvbEkTMPR/FZAqWAoqP1oQQA2dpWcTq80NgduB5m7ohFo3FmhZFZ8zhoQRM0Yj050eh4/9u8JVYlK7NFk8zUwjUNTvNnu0Aygg4vug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PaDaAx5v; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so21845796d6.1
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751755791; x=1752360591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6FOI4swfFRegadFP7k8p5BvHsmjuoDx32UjcUkD92c=;
        b=PaDaAx5vxIZ+2QtTItzPuKvABfBW4FCZwPwhn7pu0S0LUVbEHG7aHsFJZfs5xgakGO
         DghG9MXhMg4/KNgQ7ZYrVFyJAsKFNFK8ddBNV1HxXwmw+7EamkitwC78Kts5qOq/1Gkq
         HOkFLFgEz7DcYsTWl1AwtIFX/cMjlxQOhBdQclFZWb8p5CqIxs69FiTjsQjSn5Dh9yh9
         s+wQTHUNsmwO6Vd2p8qk7vksNPH1SDZvgtp+KlxejpHJ8vdZHf9013YwcyQyMrHcUkjZ
         HPiUD4pWVzU/k0ilNsIXVuWbBsjCoMUrBae9I5Wb0gRZx8kxpybhX/WcyeiMRQIZ7khH
         jl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751755791; x=1752360591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6FOI4swfFRegadFP7k8p5BvHsmjuoDx32UjcUkD92c=;
        b=NTsoLtj4FauOcomLKeJo0v4pr4gg9+Lgu9T/sEIH42sedZ1N0TXqDrAd8M3rEn+9n5
         T7ceGPy3VHwqPAzaPhHUQaGfzcGo6pGGcfh1Y/hTVR+BfCiX0P6q4VXe22flDu6Pcisi
         vAViHUjDF/5E14Bx07IEVo3BjVGiRuM+PYkU1k05faCmr42ifV8LgyXBhEBBjCIlDyVk
         ZnPxK+oHMfq3LT0ELyWINyvaKW5NKPt8fg+nfpdjuKkOJAsYxbNZgjp/GeG5vA5rMcU3
         tVz9DlQVdd4j8w8sQdAIhmD+TXIuvW8RULIR76mywJ19nPqfoMkJcCsfKn8+Ng2e78B8
         3bwQ==
X-Gm-Message-State: AOJu0YzrJilkoBY9C0f5RzjhLO8jX4livWZi29ODjlo06R6TFcqiOHbM
	s+n8wFvbNoHVOVLk4oir4Qy4SoVQ0FQh0ZQh2OhqhVj67qoav+47hu3feQFSZnp/MjxhGUR4yOX
	Bl9QReCkNGUk0aYkOftD6WNtPalVYQsYY0iD180g6
X-Gm-Gg: ASbGncuAtPHNYJ8WQKftpDd0MqsQkwtGeG6BZBGmkPzfy4B9FSEaghYmLfGe8PcfmMZ
	Y4L2pz7XxcuWJbFnrBngkhTjLpcVz5r4N0VwrrsD1A205m33kk0v++yheZHH1KdHT0OnQ0gheOW
	LZKvzdu7gbb3Mked8b8hQpd2WVS4rw1OKe9c5yqoAZvQ==
X-Google-Smtp-Source: AGHT+IExQeghRsFhmvQnGOaz7+M0iceIzByjP3L5aHRK4GGkUz4+tvz7i5/cNlHKT3KHBdhTiVdi+fDwZkbWo6IgPIM=
X-Received: by 2002:a05:6214:3da1:b0:6fa:ba15:e8a with SMTP id
 6a1803df08f44-702d1675c2dmr58853246d6.8.1751755791554; Sat, 05 Jul 2025
 15:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGdevOopELhzlJvf@pop-os.localdomain> <20250705223958.4079242-1-xmei5@asu.edu>
In-Reply-To: <20250705223958.4079242-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 5 Jul 2025 15:49:41 -0700
X-Gm-Features: Ac12FXzblIC_Kr5NR5vpogIb2lk04QZ0BcemxD_yfVFjkN_I19-zGHBsqnoICdU
Message-ID: <CAPpSM+RKqRQoc7+6zgC-7O_5O73X7CK=oOWdHafB-h9OHAuEfw@mail.gmail.com>
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on qfq_aggregate
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com, 
	jiri@resnulli.us, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cong,

This is a sch_tree_lock version of the patch. I agree with your point
that it's unusual to use sch_tree_lock for aggregation. What do you
think about applying RCU locks on agg pointers and using
rcu_dereference_bh?

Thanks,
Xiang


On Sat, Jul 5, 2025 at 3:40=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> A race condition can occur when 'agg' is modified in qfq_change_agg
> (called during qfq_enqueue) while other threads access it
> concurrently. For example, qfq_dump_class may trigger a NULL
> dereference, and qfq_delete_class may cause a use-after-free.
>
> This patch addresses the issue by:
>
> 1. Moved qfq_destroy_class into the critical section.
>
> 2. Added sch_tree_lock protection to qfq_dump_class and
> qfq_dump_class_stats.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v1: Apply sch_tree_lock to avoid race conditions on qfq_aggregate.
>
>  net/sched/sch_qfq.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 5e557b960..a2b321fec 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 cl=
assid, u32 parentid,
>         bool existing =3D false;
>         struct nlattr *tb[TCA_QFQ_MAX + 1];
>         struct qfq_aggregate *new_agg =3D NULL;
> -       u32 weight, lmax, inv_w;
> +       u32 weight, lmax, inv_w, old_weight, old_lmax;
>         int err;
>         int delta_w;
>
> @@ -446,12 +446,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 =
classid, u32 parentid,
>         inv_w =3D ONE_FP / weight;
>         weight =3D ONE_FP / inv_w;
>
> -       if (cl !=3D NULL &&
> -           lmax =3D=3D cl->agg->lmax &&
> -           weight =3D=3D cl->agg->class_weight)
> -               return 0; /* nothing to change */
> +       if (cl !=3D NULL) {
> +               sch_tree_lock(sch);
> +               old_weight =3D cl->agg->class_weight;
> +               old_lmax   =3D cl->agg->lmax;
> +               sch_tree_unlock(sch);
> +               if (lmax =3D=3D old_lmax && weight =3D=3D old_weight)
> +                       return 0; /* nothing to change */
> +       }
>
> -       delta_w =3D weight - (cl ? cl->agg->class_weight : 0);
> +       delta_w =3D weight - (cl ? old_weight : 0);
>
>         if (q->wsum + delta_w > QFQ_MAX_WSUM) {
>                 NL_SET_ERR_MSG_FMT_MOD(extack,
> @@ -558,10 +562,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsi=
gned long arg,
>
>         qdisc_purge_queue(cl->qdisc);
>         qdisc_class_hash_remove(&q->clhash, &cl->common);
> +       qfq_destroy_class(sch, cl);
>
>         sch_tree_unlock(sch);
>
> -       qfq_destroy_class(sch, cl);
>         return 0;
>  }
>
> @@ -628,6 +632,7 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned=
 long arg,
>  {
>         struct qfq_class *cl =3D (struct qfq_class *)arg;
>         struct nlattr *nest;
> +       u32 class_weight, lmax;
>
>         tcm->tcm_parent =3D TC_H_ROOT;
>         tcm->tcm_handle =3D cl->common.classid;
> @@ -636,8 +641,13 @@ static int qfq_dump_class(struct Qdisc *sch, unsigne=
d long arg,
>         nest =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
>         if (nest =3D=3D NULL)
>                 goto nla_put_failure;
> -       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
> -           nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
> +
> +       sch_tree_lock(sch);
> +       class_weight    =3D cl->agg->class_weight;
> +       lmax            =3D cl->agg->lmax;
> +       sch_tree_unlock(sch);
> +       if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
> +           nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
>                 goto nla_put_failure;
>         return nla_nest_end(skb, nest);
>
> @@ -654,8 +664,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, u=
nsigned long arg,
>
>         memset(&xstats, 0, sizeof(xstats));
>
> +       sch_tree_lock(sch);
>         xstats.weight =3D cl->agg->class_weight;
>         xstats.lmax =3D cl->agg->lmax;
> +       sch_tree_unlock(sch);
>
>         if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
>             gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
> --
> 2.43.0
>

