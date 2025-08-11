Return-Path: <netdev+bounces-212419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5BB20317
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0056176980
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B72DCF70;
	Mon, 11 Aug 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC1/WLPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375813AD1C
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903970; cv=none; b=X97QbTJyCdyftisj1Ec6YjldOM92EP+72SbNOa67kRqv5uL+872V3aBG+NdPMM5ZHSXf1tTX2haLyUT4Pk+deV3uCNtNuApZBiDIyasEB1hnNr38Wus6jwOFLL2P+Abu9rD/wUwIIbSUKxtdL6xkdocdodYnGxYo13/DMx32vD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903970; c=relaxed/simple;
	bh=eOcXVHRq7KcT5QV7lddFhfB5s66umFv3YrBqQ/TX/uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKZiQbUS4+EivuUXPWV4E3aFKRtUvvrKuZGeFTNZ+lmkYVdcKqZlNca/Aw3VYkayinSU9S+f/l7ZcIkjXnVKm4tI1I0UD/yx9g9lK0MAs1hGHHFfmeYTWFDiJ4KczvQlzlPgFBkJg9GD0T9yQ+57QVHc58GBBZ4ZmKiRxtrV3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IC1/WLPH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b07d777d5bso47638661cf.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754903966; x=1755508766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X3+VyeiU1OgsV7atWhvLrxkvJsIXxj9Qgw0FX6QMEE=;
        b=IC1/WLPHof7gy7NDluHwPQCGGRp2bnxoJO4nLyeMuVaA16aD3gkdia/0IJYpGsPeOA
         fDEUWTLRFEY4x/jukbffuRlMkGPhe8jUSuvZ1yPPjOW/OD4TF5PTjoohB8ffB9FP6O3D
         /CJUO7Uqpl2ON+hNvU+owkyFKmK3aoCnsikY4BjlivzSsdtfdFu0w9uROLcP0c3SYJc2
         YJRBkBMz0vykid9wn4+q8Aolv31wwmF694SG9VkAzsE+kqHtqPApSPD5fh2XufQv0oah
         yuXzHBZNPPoD/rayCyX35a5NhVRLO5IKBfSWfiuprwJQLon+moeaW7p496duSTFbMbN6
         qQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903966; x=1755508766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X3+VyeiU1OgsV7atWhvLrxkvJsIXxj9Qgw0FX6QMEE=;
        b=K7fYy3kxEO19jEwChanBO9EHrYeWVrIHYm6aVHSOX9P3TuBYR5CstuzvoHb1jWBUbS
         qiAsQm11o8NvTWI0IUwrrGxV9sY+oW5n1VJ4zKuzxvJhnK4mQoyOCymvzJ45s+oIsvD3
         daeaBsPq667w05qzoC9oX2erhO4WFFLAmVES9fxb+vZmWoR1b2BQA5IujsXsgbI7LSAM
         JtQ2GwJQDgokoww1P5IbyXhkEb0Tf2v6D7MSxcnOLbmN3w0kJhQsFkbLsh/W1qT9NNol
         BCM36nPOoWzXjiOEgCEHhsyP8MqB6KqZjeQ4tVQg8rrAitxzkctKmhPJd3pLYMQ3LAvU
         3w4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8+0G0PcjzMGHvny8DMvJOTprrJM19W21fj4Cm+oDvpyuqfp1eRv/V2LCbpM1NOscqroo2fJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5xoXky1oCViJ33v0AaqOgvurok08IQHJauVoM8WZaEZPXrQB
	+JH1FKj91C98XUATCFlwTXpy/LE8J/ii+m2TDc/hP4zU2bydKSWS/BwQ0FKUdXXc7cKEtl7gbEW
	5fA/SOz58HnEEppyLjur7KLEYDT8OSUi10fqXW4A9
X-Gm-Gg: ASbGncsqXaDkZv1wCo/Ay5pQwsT5kwK/B7gh63K4QA4gMH/zUyXdOBA6NmsFDtvig3T
	dekyw7Ay/FRET9TU8VWImEAOYO0piOaYL4hN3IkWeQdwC0AvVRsJqqtc0XCAb9aG+pkef4MDsIP
	YLMsbPRRBRon8Wc99zgd5yoAextCKQsg3fD+U7qKqn25G9W28dhZ5ulPe+GariQBCilRSXEA/3m
	71bffo=
X-Google-Smtp-Source: AGHT+IGsGqL0Tet528TAr+FeI8cqB44Iw1Yw7vkXFDKW2y66uKrMwpszv3VtSYrNMrGppCnsouzQ6A2JECoC7Hzay+s=
X-Received: by 2002:a05:622a:548:b0:4af:203f:73e9 with SMTP id
 d75a77b69052e-4b0aecff0afmr124996791cf.3.1754903965426; Mon, 11 Aug 2025
 02:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811084427.178739-1-dqfext@gmail.com>
In-Reply-To: <20250811084427.178739-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Aug 2025 02:19:14 -0700
X-Gm-Features: Ac12FXyDAHXwINvs0_c2V2RB4ZbG2aFo4c_KD22t99jVdd62EqxWa-M4aOJp_VE
Message-ID: <CANn89iLEMss3VGiJCo=XGVFBSA12bz0y01vVdmBN7WysBLtoUA@mail.gmail.com>
Subject: Re: [PATCH net] ppp: fix race conditions in ppp_fill_forward_path
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:44=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> ppp_fill_forward_path() has two race conditions:
>
> 1. The ppp->channels list can change between list_empty() and
>    list_first_entry(), as ppp_lock() is not held. If the only channel
>    is deleted in ppp_disconnect_channel(), list_first_entry() may
>    access an empty head or a freed entry, and trigger a panic.
>
> 2. pch->chan can be NULL. When ppp_unregister_channel() is called,
>    pch->chan is set to NULL before pch is removed from ppp->channels.
>
> Fix these by using a lockless RCU approach:
> - Use list_first_or_null_rcu() to safely test and access the first list
>   entry.
> - Convert list modifications on ppp->channels to their RCU variants and
>   add synchronize_rcu() after removal.
> - Check for a NULL pch->chan before dereferencing it.
>
> Fixes: f6efc675c9dd ("net: ppp: resolve forwarding path for bridge pppoe =
devices")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  drivers/net/ppp/ppp_generic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.=
c
> index 8c98cbd4b06d..fd3ac75a56e3 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -33,6 +33,7 @@
>  #include <linux/ppp_channel.h>
>  #include <linux/ppp-comp.h>
>  #include <linux/skbuff.h>
> +#include <linux/rculist.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/if_arp.h>
>  #include <linux/ip.h>
> @@ -1598,11 +1599,14 @@ static int ppp_fill_forward_path(struct net_devic=
e_path_ctx *ctx,
>         if (ppp->flags & SC_MULTILINK)
>                 return -EOPNOTSUPP;
>
> -       if (list_empty(&ppp->channels))
> +       pch =3D list_first_or_null_rcu(&ppp->channels, struct channel, cl=
ist);

It is unclear if rcu_read_lock() is held at this point.

list_first_or_null_rcu() does not have a builtin __list_check_rcu()



> +       if (!pch)
>                 return -ENODEV;
>
> -       pch =3D list_first_entry(&ppp->channels, struct channel, clist);
>         chan =3D pch->chan;

chan =3D READ_ONCE(pch->chan);

And add a WRITE_ONCE(pch->chan, NULL) in ppp_unregister_channel()

And/or add __rcu to pch->chan

> +       if (!chan)
> +               return -ENODEV;
> +
>         if (!chan->ops->fill_forward_path)
>                 return -EOPNOTSUPP;
>
> @@ -3515,7 +3519,7 @@ ppp_connect_channel(struct channel *pch, int unit)
>         hdrlen =3D pch->file.hdrlen + 2;  /* for protocol bytes */
>         if (hdrlen > ppp->dev->hard_header_len)
>                 ppp->dev->hard_header_len =3D hdrlen;
> -       list_add_tail(&pch->clist, &ppp->channels);
> +       list_add_tail_rcu(&pch->clist, &ppp->channels);
>         ++ppp->n_channels;
>         pch->ppp =3D ppp;
>         refcount_inc(&ppp->file.refcnt);
> @@ -3545,10 +3549,11 @@ ppp_disconnect_channel(struct channel *pch)
>         if (ppp) {
>                 /* remove it from the ppp unit's list */
>                 ppp_lock(ppp);
> -               list_del(&pch->clist);
> +               list_del_rcu(&pch->clist);
>                 if (--ppp->n_channels =3D=3D 0)
>                         wake_up_interruptible(&ppp->file.rwait);
>                 ppp_unlock(ppp);
> +               synchronize_rcu();

synchronize_net() is preferred.

>                 if (refcount_dec_and_test(&ppp->file.refcnt))
>                         ppp_destroy_interface(ppp);
>                 err =3D 0;
> --
> 2.43.0
>

