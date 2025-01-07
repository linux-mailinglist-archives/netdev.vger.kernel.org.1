Return-Path: <netdev+bounces-156060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C550BA04CA7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2102A3A3607
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E11AAA1D;
	Tue,  7 Jan 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q69Qprwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6619D093
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290404; cv=none; b=EwTucJpFzZ+c8s0nXV0uNl30278QBpbHsAjxJ+czsaKdhKWa6Q3rTeHN2fzJ65zP8R1sSmifHFAnGz57RB+nvAwgCk2FhMNeJyYoAHXuzpv9qU2jch9KIHPejee9Rt8WpCF5pg0kfOOZLp/0eZfbMxtqWYG57qr6BzZxmGuIsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290404; c=relaxed/simple;
	bh=N7/gGRjaatpgQl7P5dYkrNr+Tj0IdmEvPzPvEZcNpWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWHZCv2mJaW+rSLS0m8vSwSUyTp5fmScJTmlv6uem1VfADLOk8JAeY8wBXzjPY2b9hOPbtshCe0gaUqTNhSKh6Cct+gOJTMkZBzE2Rl/ZtqnR/ef74++wvB4omCoFvOeK9XDMmMjHCVQK67ThllH7hgXqJ30lU+fLaze/7NwcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q69Qprwq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467896541e1so85011cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736290402; x=1736895202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x8xyVpSwrKW63fGDZJRBlcwuzW5LQDO44aw1NunmKs=;
        b=q69Qprwq6BTBm6QdLmX1sUpPm1dSKPzBk0u8cMy9/Zue1GK+d7HnoKtbxc4luTUS8g
         Z5WVrzj8sWTLn5FsrAIrRDZjUVmiNzWE7G6hhnmiwVA0QgfUMP8BPJ0GqbO4QuVA1vrU
         PN4qu+PdZxGB5h1iw/mcrrO0ZZ0141QCpK6bEmUa0Aq3jHlSN6MOMsOsUwo8OFog09HH
         zrVgpAdWStaUNsnAwZsxb0hsEFM35aTWJXUh4/GjwgmXzExL0jQym5V1xXQtFNvHzcX9
         Q/dZhi5ZDr5vfUVDHMZhNVpB1nAFkp3Uhv71Upo83nJ4YRFZmizdtBBGqWmCeVX9NXf/
         xXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736290402; x=1736895202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x8xyVpSwrKW63fGDZJRBlcwuzW5LQDO44aw1NunmKs=;
        b=l0z6j5R2XzjyNpsS4/hTQWmucZu3v4KNmcmiTZKwFpWu6a3NLU2+zq+ujU9Ekk8N49
         jPin4yjaD91CAgkD2RejcM9ZD6CapEJ4KgeQPdRDE2S2C924aV3GCXPXD3H1SkqKC5jZ
         hSkr65RK9++UuHj3Wvt1mK7juTixz0MI9Pls9oEg6FmPv4sZw0DUfRtBFxX5A+OPp/CI
         iY2M45bsZLZszkd9saMdOO7nhE0yJX8qaFZ8/uQJu/ITNbPRIAQxMNoGlHFDOeyObJ0l
         vQXYcuugImPb1cZoDD2+FXM+hvjm9/S/kFHKQ+Rw/RKacJ/A3tnUiqeo/0pKn5CB74zn
         Ll/w==
X-Forwarded-Encrypted: i=1; AJvYcCUP1nBd6OA0Evjzu3g7O+cLygE2AKsHdbdzT2dfSJFUXB0xABGSVsesJNR0+2VP8cHFCnermaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jizvxrmk3X3+A4VDlaD3pZoQtWwk2LN8rY13reyXBYwNCRRb
	G06ed1HBY0/xxnq1bs8GowsEt6SZK1Ot09DgwAjtbEFqBWuLTp+rIYCmbLEYKX2jwSQ1wPJp9qq
	eq6sfW7lB6NuYlEdnoI3LFEkWreC+wVyBHNrG
X-Gm-Gg: ASbGncumfCCS/Fje020vj0T9mxnlIGMpvy3C8/ogab5q7RRJ11sdVEAPByIx8o4xAH1
	8tAOLNrJ7AssE6SMvKvVwKmocLwp8v4meB0S6834gL0K8q8ZQ3KwMHRNnmr8V1x1YHcQ=
X-Google-Smtp-Source: AGHT+IHRV5UvIywiz71bjRtbUbXNSW9In7DyHjxzqQ6fXpIrRGgYoTHl0VhOitrUMAsY+p+exFQ6Q1XgEngMnJDxpFs=
X-Received: by 2002:ac8:7f82:0:b0:460:f093:f259 with SMTP id
 d75a77b69052e-46c70cb67c0mr971421cf.22.1736290401502; Tue, 07 Jan 2025
 14:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107160846.2223263-1-kuba@kernel.org> <20250107160846.2223263-7-kuba@kernel.org>
In-Reply-To: <20250107160846.2223263-7-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jan 2025 14:53:09 -0800
X-Gm-Features: AbW1kvYg62U6lsw0tPRJUJIqSSugacH4112PpQ26Hw9ywOUc0K8311kJjofEtQA
Message-ID: <CAHS8izO3FWZ6Wgnf0jwHLo8xDczz1zmCq_ypXRAWijYuxUY0MA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/8] netdevsim: add queue management API support
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, sdf@fomichev.me, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 8:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Add queue management API support. We need a way to reset queues
> to test NAPI reordering, the queue management API provides a
> handy scaffolding for that.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
> v2:
>  - don't null-check page pool before page_pool_destroy()
>  - controled -> controlled
> ---
>  drivers/net/netdevsim/netdev.c    | 134 +++++++++++++++++++++++++++---
>  drivers/net/netdevsim/netdevsim.h |   2 +
>  2 files changed, 124 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 7b80796dbe26..cfb079a34532 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -359,25 +359,24 @@ static int nsim_poll(struct napi_struct *napi, int =
budget)
>         return done;
>  }
>
> -static int nsim_create_page_pool(struct nsim_rq *rq)
> +static int nsim_create_page_pool(struct page_pool **p, struct napi_struc=
t *napi)
>  {
> -       struct page_pool_params p =3D {
> +       struct page_pool_params params =3D {
>                 .order =3D 0,
>                 .pool_size =3D NSIM_RING_SIZE,
>                 .nid =3D NUMA_NO_NODE,
> -               .dev =3D &rq->napi.dev->dev,
> -               .napi =3D &rq->napi,
> +               .dev =3D &napi->dev->dev,
> +               .napi =3D napi,
>                 .dma_dir =3D DMA_BIDIRECTIONAL,
> -               .netdev =3D rq->napi.dev,
> +               .netdev =3D napi->dev,
>         };
> +       struct page_pool *pool;
>
> -       rq->page_pool =3D page_pool_create(&p);
> -       if (IS_ERR(rq->page_pool)) {
> -               int err =3D PTR_ERR(rq->page_pool);
> +       pool =3D page_pool_create(&params);
> +       if (IS_ERR(pool))
> +               return PTR_ERR(pool);
>
> -               rq->page_pool =3D NULL;
> -               return err;
> -       }
> +       *p =3D pool;
>         return 0;
>  }
>
> @@ -396,7 +395,7 @@ static int nsim_init_napi(struct netdevsim *ns)
>         for (i =3D 0; i < dev->num_rx_queues; i++) {
>                 rq =3D ns->rq[i];
>
> -               err =3D nsim_create_page_pool(rq);
> +               err =3D nsim_create_page_pool(&rq->page_pool, &rq->napi);
>                 if (err)
>                         goto err_pp_destroy;
>         }
> @@ -613,6 +612,116 @@ static void nsim_queue_free(struct nsim_rq *rq)
>         kfree(rq);
>  }
>
> +/* Queue reset mode is controlled by ns->rq_reset_mode.
> + * - normal - new NAPI new pool (old NAPI enabled when new added)

Nit, probably not worth a respin: Normal seems to me to delete old
napi after the new one is added and enabled.

queue stop -> napi_disable(old)
queue alloc -> netif_napi_add_config(new)
queue start -> napi_enable(new)
queue free -> netif_napi_del(old)

> + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> + */

Which modes are 'correct' for a driver to implement? 2/3 is for
testing only, as you note in the code, the add/del functions should
really be called from alloc/free and not from queue_start. I assume
modes normal and 1 are both correct implementations of the queue API
and the driver gets to pick whether to reuse the napi instance or not?
Asking because IIRC GVE implements mode 1, not what you consider
'normal'.


--
Thanks,
Mina

