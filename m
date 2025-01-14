Return-Path: <netdev+bounces-157947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2EFA0FECF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E2188950B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BAF23027D;
	Tue, 14 Jan 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOO0TsYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8523099A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821822; cv=none; b=KWLThZQhHdrzPaDpLtFebMEFDeb/tT026lHTG9naOPQrGAEpd83aGhcPOc4m8RqYrfkuZAGlEboWlxBc7bVkscD/+FL9HWklI82VpqMXlGG/Rw5ynpiF25FLjl55lm412ADNyZmv8isbQFCsvh41a8lO3MLge60OkWmpVCVLJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821822; c=relaxed/simple;
	bh=1JGxDPlVJKwJ2pOm0AYyOTwzDG6j5Rq9cVKC/n6+X1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj4w8/nGSypN4T/Q2S2H5BLDgHGb/Pz3KhMs5dkZJ1sDVc4x2xdRFqgK4wYaxTj5Hk+H0Lb/a3gxgjJ5QqE6zKj8Nw07bcm//zN+jFxtSafWUei61bHQ+fQwVU1dstaLI0qLBuc1Y6RK5kD9Cc1JAQ8rUhPsVys8/vHpbe6VygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOO0TsYJ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e6d1283aso194656339f.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821819; x=1737426619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi4nx1sWNXbvZ3D5K/fRFrFHiw+XD+GO1PsMwT5Ekks=;
        b=fOO0TsYJKAqmq35xZPAd5254VdDN6P3gOJykqvLmDcY6tSD9MwlkK/WGjQcjic+84P
         uHhDRnDjgLOQmnuNNcbQj2f8R7RxHQ8mCO5Pg8V9d+ilI4FMXrGlWZ8Mdly68qzed+SP
         /IXZaopiOyBXnONkM0VGQj4tf4DLk+e8JZ/2xwf4M1a4nqfG1jsIcbq0Wn2ezbEGvA67
         Lcodva13fwW4VudhJh8kG4lRGDk+GzgspTHVXLnM4vABzy/n2pr36jAK5nhhchH15INn
         RU85+6fx621wgwUwdPxytcGW5O5+PQ81lfQ3U4BVsgBYZxshFfo8lBDZ/SN+LaKtEjEv
         XnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821819; x=1737426619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wi4nx1sWNXbvZ3D5K/fRFrFHiw+XD+GO1PsMwT5Ekks=;
        b=a9ChrZKFp/TGOIKcYpS3wCU67Gv6cn2Xt7/2tcCyMxxHnJk7zf44WtPRw/ye3NyTA7
         lwYZVvVZeOMmJG1WX5G6QZvWneXxpGLd6UXlUUn1k0d268KaWCr5jSK8MSI7jUbKMWVi
         lURs3uGnhxWYo8pD9WYJ+mUE1Tt8dhcVv+BMrm48XHCUaPVMf0c5hoTDLmyriUtlgr/0
         vtgbzQvRNQSX/eJeaeqEjrNhfrV3NIm7pkK3Ur181+YJExxVrUyywogK4sPxiQHaKsJb
         Jn1OhrBuf8zxsfKBKMeNgy/9mFc8PEm/tWH42anFqLlpM/AOy7yHZOLQKsVhOpYLr8Dw
         aBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvBjPDiSSF3r3Q9XH2exYvtHF3+C8EstCYlgg5c5XpAWAQNJWZiM3Sn1A9qyGNuUWib5yEWjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDF/Ng41iAZSBeNqUTqwTRmjOh5Qe6M2C9EogswDJ5tBAH48R
	8lKXm7xip0gQszKbN8My78BeIZlw/SCugP+yFzmtdiasyjJeWhPKVhB8U6SCjq2/9OBWa7cgyqv
	Z6tU7HjnhFeAn9Uqim0ym9MR5IZI=
X-Gm-Gg: ASbGnctU7Mex+F5OmyeXRPRl+T7kMZ+MFg1cHPKnNhJO4Z5T1zgq2VLnE3CJukaKY1S
	yA/lwtu0YLsvVSRwCidR8W9+vVs5ca+kbNSJMQbr/
X-Google-Smtp-Source: AGHT+IF1V1F3d+zIryz+B4ybxxhH50JwzGeXSKZlUlWyxsM7eaQtJMqML1bnrLwpV2ctDAx7JFoJInB+X2PBNgSt+7M=
X-Received: by 2002:a05:6e02:13a6:b0:3cd:bcbf:1091 with SMTP id
 e9e14a558f8ab-3ce4b21610amr152770125ab.10.1736821819236; Mon, 13 Jan 2025
 18:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
 <8cf44ce9-e117-46fe-8bef-21200db97d0f@fiberby.net>
In-Reply-To: <8cf44ce9-e117-46fe-8bef-21200db97d0f@fiberby.net>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 13 Jan 2025 21:30:08 -0500
X-Gm-Features: AbW1kvaYlyrOesiepOgV7EdfHrBKhmiUCmAPbXgvE242g3EVR4-bQ9P7sdTpPas
Message-ID: <CADvbK_dYKMvZ8iUS-CvzNYYue1qxTsWXDpvcETyBD+sWOJcaSA@mail.gmail.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Shuang Li <shuali@redhat.com>, 
	network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:41=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> Hi Xin,
>
> With the concept turned on it's head, we properly shouldn't call it a byp=
ass
> anymore? Now that software processing is only enabled, if there are any r=
ules
> that needs it.
cool, I missed that.

>
> s/PATCHv2 net/PATCH v2 net/g, but I think my patch below pushes it
> firmly into net-next territory, unless you can convince the maintainers t=
hat
> usesw is always set correctly.
yeah, it's now changing the code tc_run() in  net/core/dev.c.

>
> I will run it through some tests tomorrow with my patch applied.
That will be great. :-)

Thanks.
>
> On 1/13/25 6:42 PM, Xin Long wrote:
> > [...]
> > @@ -410,48 +411,17 @@ static void tcf_proto_get(struct tcf_proto *tp)
> >       refcount_inc(&tp->refcnt);
> >   }
> >
> > -static void tcf_maintain_bypass(struct tcf_block *block)
> > -{
> > -     int filtercnt =3D atomic_read(&block->filtercnt);
> > -     int skipswcnt =3D atomic_read(&block->skipswcnt);
> > -     bool bypass_wanted =3D filtercnt > 0 && filtercnt =3D=3D skipswcn=
t;
> > -
> > -     if (bypass_wanted !=3D block->bypass_wanted) {
> > -#ifdef CONFIG_NET_CLS_ACT
> > -             if (bypass_wanted)
> > -                     static_branch_inc(&tcf_bypass_check_needed_key);
>
> This enabled the global sw bypass checking static key, when sw was NOT us=
ed.
>
> > [...]
> > @@ -2409,7 +2379,13 @@ static int tc_new_tfilter(struct sk_buff *skb, s=
truct nlmsghdr *n,
> >               tfilter_notify(net, skb, n, tp, block, q, parent, fh,
> >                              RTM_NEWTFILTER, false, rtnl_held, extack);
> >               tfilter_put(tp, fh);
> > -             tcf_block_filter_cnt_update(block, &tp->counted, true);
> > +             spin_lock(&tp->lock);
> > +             if (tp->usesw && !tp->counted) {
> > +                     if (atomic_inc_return(&block->useswcnt) =3D=3D 1)
> > +                             static_branch_inc(&tcf_bypass_check_neede=
d_key);
>
> This enables the global sw bypass checking static key, when sw IS used.
>
> I think you are missing the below patch (not tested in anyway, yet):
>
> This patch:
> - Renames the static key, as it's use has changed.
> - Fixes tc_run() to the new way to use the static key.
>
> ---
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index e4fea1decca1..4eb0ebb9e76c 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -75,7 +75,7 @@ static inline bool tcf_block_non_null_shared(struct tcf=
_block *block)
>   }
>
>   #ifdef CONFIG_NET_CLS_ACT
> -DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
> +DECLARE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
>
>   static inline bool tcf_block_bypass_sw(struct tcf_block *block)
>   {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a9f62f5aeb84..3ec89165296f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2134,8 +2134,8 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
>   #endif
>
>   #ifdef CONFIG_NET_CLS_ACT
> -DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
> -EXPORT_SYMBOL(tcf_bypass_check_needed_key);
> +DEFINE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
> +EXPORT_SYMBOL(tcf_sw_enabled_key);
>   #endif
>
>   DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
> @@ -4030,10 +4030,13 @@ static int tc_run(struct tcx_entry *entry, struct=
 sk_buff *skb,
>         if (!miniq)
>                 return ret;
>
> -       if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
> -               if (tcf_block_bypass_sw(miniq->block))
> -                       return ret;
> -       }
> +       /* Global bypass */
> +       if (!static_branch_likely(&tcf_sw_enabled_key))
> +               return ret;
> +
> +       /* Block-wise bypass */
> +       if (tcf_block_bypass_sw(miniq->block))
> +               return ret;
>
>         tc_skb_cb(skb)->mru =3D 0;
>         tc_skb_cb(skb)->post_ct =3D false;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 358b66dfdc83..617fcb682209 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -419,7 +419,7 @@ static void tcf_proto_destroy(struct tcf_proto *tp, b=
ool rtnl_held,
>         tp->ops->destroy(tp, rtnl_held, extack);
>         if (tp->usesw && tp->counted) {
>                 if (!atomic_dec_return(&tp->chain->block->useswcnt))
> -                       static_branch_dec(&tcf_bypass_check_needed_key);
> +                       static_branch_dec(&tcf_sw_enabled_key);
>                 tp->counted =3D false;
>         }
>         if (sig_destroy)
> @@ -2382,7 +2382,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>                 spin_lock(&tp->lock);
>                 if (tp->usesw && !tp->counted) {
>                         if (atomic_inc_return(&block->useswcnt) =3D=3D 1)
> -                               static_branch_inc(&tcf_bypass_check_neede=
d_key);
> +                               static_branch_inc(&tcf_sw_enabled_key);
>                         tp->counted =3D true;
>                 }
>                 spin_unlock(&tp->lock);

