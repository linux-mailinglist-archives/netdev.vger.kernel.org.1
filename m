Return-Path: <netdev+bounces-80890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D28817F3
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 20:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2881C22124
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796B5026C;
	Wed, 20 Mar 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="w4Tpk+YP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439985933
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963286; cv=none; b=GQpnLphn+6eYFs68bOhZy8YSly2e1xMb4xddGgCBVKbhQ4TaZeKC3ujxoZTw7ymnv0LivXotGGCvdlm14UxC2lNB/Chsxj1yQ8R8jzHQiZEsaGLCekKG3h0n2I0B9eWoI3ACv5KbURkDcTdIoSBMenBADodKC1lN1CRwJt6zuoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963286; c=relaxed/simple;
	bh=8wBMnu+9HpIuBzv1z/XJ16QWRebFonwMmVHoe/DsAPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSfa2jihafoYScNP8piLotOIhyyRQKk/MacHWOYffo+EaKdFIBaasj5EDg2dgjymNB+Gf9wOR3UFc61z3OF1mNLS6jM5k17yTRmK9Jyi0TSWhRG1+R3W0a/9qy+5aDhtnG5x0vAsl3auScUeDGIMb3Q1VRCv1wu+8DKk/sBa4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=w4Tpk+YP; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso126257276.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710963283; x=1711568083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kcTrB3LG+qBE6xyShe5QpeC4N5tFO43o4RN4E2AuLE=;
        b=w4Tpk+YPh/VNxiwL0IWjh2yPzi5SxFDMEAQyNHORivogkWsCFweUOidYt2WXjZpcZ2
         CO1Xb6VGk6EFrlNX/rR+g0E2B9T6fxjChzoYupqiTa8YpQHBh4DPC52KLjg2CDcXHu9S
         OUYOwNsMvx1swN+y6/Q5kHn7GoarvS2xnrzjJLoDgY1jsoeFJpixuAhv3zxFQG0wRzDe
         uzX3njNp1Dayi30LXjtCSdyMrVwZp2ZitG53vG3gy63ndPYkBGu6I2SkVszZPs5Kr5yo
         /3rgknQ62dE6qGA6+imebDyfHTNE4/pn07B1CVyx/PnWNLUGSLEOUON75rR562zMABk2
         c9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963283; x=1711568083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kcTrB3LG+qBE6xyShe5QpeC4N5tFO43o4RN4E2AuLE=;
        b=WRTWNbBelFR31ZDClh5KXNxzgoh5SL1vGuTvBfo7A0/VdIuG8/rNFeSqYOShPiWBx8
         23hZ3QL00wnCeGPyIizKLqSaTtKLMqsnsBGzsRqp36YwGfXfgZeDXFeiCPVlHPtjYhSz
         c0/amtuM3SsKgZO3QHBys+sY2O9A/qk2a2DiW+FjXbqQ7OmOvq4M8FeiXUNbtA0h75pV
         uIpu5jbnAToJMkKBYl0rN53hD5nStcV0qwDBxZmn75BdPKijqtBcvljnhLbvDrohlDJS
         DAATlxQXDlhY9V09TjsAhwCf9XLNMfDFhDHDVW2oUxo+Wux25XpllqdBqHHD/ke372UG
         5osg==
X-Forwarded-Encrypted: i=1; AJvYcCXuMdJLecTgDarpnDbPFrTd1E5temvqcsp7deeJbI9rOkJa3CT9kNDaVmJK6CCV9U0chejLoqphQ3lhOZF1yJrxRML62Nmp
X-Gm-Message-State: AOJu0YyvgrU2ZAbiUoamx5F1i3BtJP07cbgIusZjQbTKRK0Y7WJR8yd/
	bhdlV3C0IOJRrCx19UfCjYD3DIZCri/fcAlwT1SaOdcdpuI0ny/qjyZqCyJG5SMwBNR1uUsd/Bx
	tem1qBzC5wF8UyFG3VtVDGcoTEAgFEeFJo8Zb
X-Google-Smtp-Source: AGHT+IFl1ESYTJ1uW/MHo3QlPdBCgrp85YibOSWMyiQlhHYwE+IZICRvMZMWJv8RJN1w7vRjucwhrQo7ih/sjxc8viw=
X-Received: by 2002:a25:84c3:0:b0:dcd:905:3d17 with SMTP id
 x3-20020a2584c3000000b00dcd09053d17mr5970435ybm.32.1710963283626; Wed, 20 Mar
 2024 12:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
 <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
 <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
 <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com>
 <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
 <CAM0EoMnddJgPYR75qTfxAdKsN3-bRuqXrDMxuwAa3y95iahWFQ@mail.gmail.com>
 <CANn89iKrW4em3Ck=czoR32WBkhqXs7P=K3_dMX9hdv7wVGvKJA@mail.gmail.com> <CANn89iLzc7onLZ6c9OJ-8GW8DpoGHFNWagqttZ99hkhRzVpSOg@mail.gmail.com>
In-Reply-To: <CANn89iLzc7onLZ6c9OJ-8GW8DpoGHFNWagqttZ99hkhRzVpSOg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Mar 2024 15:34:32 -0400
Message-ID: <CAM0EoM=1DyZsgYnuTjXB88L=41g00pjat+Jq4jThpciXzcEKJQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Mar 20, 2024 at 7:13=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Mar 20, 2024 at 6:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>
> > Nope, you just have to complete the patch, moving around
> > dev_xmit_recursion_inc() and dev_xmit_recursion_dec()
>
> Untested part would be:
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 303a6ff46e4e16296e94ed6b726621abe093e567..dbeaf67282e8b6ec164d00d79=
6c9fd8e4fd7c332
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4259,6 +4259,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>          */
>         rcu_read_lock_bh();
>
> +       dev_xmit_recursion_inc();
> +
>         skb_update_prio(skb);
>
>         qdisc_pkt_len_init(skb);
> @@ -4331,9 +4333,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>                         HARD_TX_LOCK(dev, txq, cpu);
>
>                         if (!netif_xmit_stopped(txq)) {
> -                               dev_xmit_recursion_inc();
>                                 skb =3D dev_hard_start_xmit(skb, dev, txq=
, &rc);
> -                               dev_xmit_recursion_dec();
>                                 if (dev_xmit_complete(rc)) {
>                                         HARD_TX_UNLOCK(dev, txq);
>                                         goto out;
> @@ -4353,12 +4353,14 @@ int __dev_queue_xmit(struct sk_buff *skb,
> struct net_device *sb_dev)
>         }
>
>         rc =3D -ENETDOWN;
> +       dev_xmit_recursion_dec();
>         rcu_read_unlock_bh();
>
>         dev_core_stats_tx_dropped_inc(dev);
>         kfree_skb_list(skb);
>         return rc;
>  out:
> +       dev_xmit_recursion_dec();
>         rcu_read_unlock_bh();
>         return rc;
>  }

This removed the deadlock but now every packet being redirected will
be dropped. I was wrong earlier on the tc block because that only
works on clsact and ingress which are fine not needing this lock.
Here's a variation of the earlier patch that may work but comes at the
cost of a new per-cpu increment on the qdisc.

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3789,6 +3789,11 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
        if (unlikely(contended))
                spin_lock(&q->busylock);

+       if (__this_cpu_read(q->recursion_xmit) > 0) {
+               //drop
+       }
+
+       __this_cpu_inc(q->recursion_xmit);
        spin_lock(root_lock);
        if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
                __qdisc_drop(skb, &to_free);
@@ -3825,6 +3830,7 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                }
        }
        spin_unlock(root_lock);
+       __this_cpu_dec(q->recursion_xmit);
        if (unlikely(to_free))
                kfree_skb_list_reason(to_free,
                                      tcf_get_drop_reason(to_free));


cheers,
jamal

