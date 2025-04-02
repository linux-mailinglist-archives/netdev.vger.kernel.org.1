Return-Path: <netdev+bounces-178884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0404A7957B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C916BB3B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB21C8604;
	Wed,  2 Apr 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX6TjqDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155118A93F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619985; cv=none; b=i+Mgt1MhpFm9jo3eq1ewx/tRUlV3Qxlf5KMBciD6S6/qUtYViTDXvaWjqGBgOwc1hIP4wC4IBxpilZVACrSOWw7l5j42ftV6HZUbsX2ImhuJNGQNWkt2UB2djQQjZx4qm8huP0FmBsbIG8yoYI155IiX+VqJKRigPyHMMz/2Hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619985; c=relaxed/simple;
	bh=geNOK0OPNZbATJ8am/nwtKyeqAl48mXj8iHhSIY1vPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ+TEh3LFRygM+975YToS5hg7rb17p5Ajj4bMeq39CU1hYgdJjG0CZ8cEwxhISH2vU7ibIO2TAKWxJj28yh0qq+zQfQjM8zuObr0210peqvFpen46zuJRcv04smXOK6QP4AYuqZ7scTkjtqirZ7UzKZ562WlTL60s5bR4JB4pFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vX6TjqDn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so331565ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743619983; x=1744224783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JsIXzo5q/0e3eJYx4lLzMaBL81s391SqSG2jZmhjPk=;
        b=vX6TjqDnfdikPqz8t28K5rv4jcYxCc5lr8hjXxge40MAUFmhVLycYeyff9w6nwGzIN
         yfXmP2IGnRxGUx3e/RHcsuxLWXY5vnayGpNcVbbZ++XfSFGs3VoVch7RlItKbAgv29Uc
         km1pt0mkHPWfxKGmFSa5l0IJE0L1FBq5bs15R7CeY+Ax4wPhtvtDrBTLGh3U8941JYX0
         +GFjOT+9T5vnTljjW4X0m1JbRzOc/FJ91snUICTfC4RwYdX9ouNlxbXOlchsIch0qvWj
         w4cFFJ0MpEcqfpkYzbCJRjRLWfpXqmCc9l5cdxOCqOq6rgIlJ91k9cAlkzto/6+ML830
         WcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619983; x=1744224783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JsIXzo5q/0e3eJYx4lLzMaBL81s391SqSG2jZmhjPk=;
        b=lBvnoC+69boD0qPryjJ6rNTQU+PiftgPOBktm1GdBKaVI6yskAmcotO72zVVbvcJVP
         I/czhN4CM/qVLtS7tp61y1LS7Y9qlGttlf/Sh33FgYi2E1K4rX12pXZvDh/Md0j+6aJM
         celNi3kTPKzXXKe3kc+oln9b+wsvNH/sxf+r5E7KJVDj/yx8xF6TAIzps8e+vwoeboDK
         so4M/R/PVRg54VxUYzWUi/Uy208gT2CdlyCWzDd9U+EJ/KwJNtuQgFU5Mf1FGwMj6H5y
         7yUWkdy5PC+8Ull012ClcDdS+4hiOzcz26oUBraWXbBCqL3tT1FZTpk9AIHY4XVckViB
         9s9A==
X-Forwarded-Encrypted: i=1; AJvYcCUDnIKg0VrLyOA4tRxZGOexr2qC/NIP6zl+5l71Lo3TQSSWSSz4zAiiGGHY4uPt8UfBWXiLP4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrk9naNAFViFpZvLaxz2SllhhNPDQfAddu3j2y2OhduX7MsyLu
	vQJUqVYoQWqj8/yw/d21u8n9ECDcSIs+pId3kvkIQCChrvzMsjBe1x7fv1nY8RDS5wPZfHrLWJP
	O24zT+3T7wmH4mcZhb5yDdF474S4fK8SgVfL/
X-Gm-Gg: ASbGncvDtrrdrhH2Soy/RdfUl66D5eIYGFuBNxMOMSd18O4F15L8/MUQ8dq8GvuDCxx
	HzMPqWH7c+JxBx1kQq3SaijUgV/ATEkXNrsplbCHCWX90Ghd6U2r20r3Gl8BqfBnFXEPpBHeo1Y
	/Xa9/OdJZiLx06Clxkfzcb/cg+k5Ed69FQPyYOBksLUDvcvxSGcsR2Bs6r
X-Google-Smtp-Source: AGHT+IELS86HXfVCnlwuHvRpzbVEy1fJ+oq9XxLNYG8wGrqwYMIYgim5RkRNMDKdPzyXbv3BX8RjcYv0tF2KP/lBZtE=
X-Received: by 2002:a17:902:ecc5:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-22977502490mr431645ad.12.1743619982856; Wed, 02 Apr 2025
 11:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331194201.2026422-1-kuba@kernel.org> <20250331194308.2026940-1-kuba@kernel.org>
In-Reply-To: <20250331194308.2026940-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Apr 2025 11:52:50 -0700
X-Gm-Features: AQ5f1Jpl1_5crUFj3FJ3pr2r7MZoiDh0Qo1_0cr8KGp4A5Fbc6LfmiNUT42-v9o
Message-ID: <CAHS8izNWqPpeRvnF4no8VOs0YpFCahG9WNsVB8VLuaWsUy_-+w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: avoid false positive warnings in __net_mp_close_rxq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ap420073@gmail.com, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Commit under Fixes solved the problem of spurious warnings when we
> uninstall an MP from a device while its down. The __net_mp_close_rxq()
> which is used by io_uring was not fixed. Move the fix over and reuse
> __net_mp_close_rxq() in the devmem path.
>
> Fixes: a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev=
_rx_queue_restart()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/devmem.c          | 12 +++++-------
>  net/core/netdev_rx_queue.c | 17 +++++++++--------
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f2ce3c2ebc97..6e27a47d0493 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -116,21 +116,19 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
>         struct netdev_rx_queue *rxq;
>         unsigned long xa_idx;
>         unsigned int rxq_idx;
> -       int err;
>
>         if (binding->list.next)
>                 list_del(&binding->list);
>
>         xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> -               WARN_ON(rxq->mp_params.mp_priv !=3D binding);
> -
> -               rxq->mp_params.mp_priv =3D NULL;
> -               rxq->mp_params.mp_ops =3D NULL;
> +               const struct pp_memory_provider_params mp_params =3D {
> +                       .mp_priv        =3D binding,
> +                       .mp_ops         =3D &dmabuf_devmem_ops,
> +               };
>
>                 rxq_idx =3D get_netdev_rx_queue_index(rxq);
>
> -               err =3D netdev_rx_queue_restart(binding->dev, rxq_idx);
> -               WARN_ON(err && err !=3D -ENETDOWN);
> +               __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
>         }
>
>         xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 556b5393ec9f..3e906c2950bd 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -154,17 +154,13 @@ void __net_mp_close_rxq(struct net_device *dev, uns=
igned int ifq_idx,
>                         const struct pp_memory_provider_params *old_p)
>  {
>         struct netdev_rx_queue *rxq;
> +       int err;
>
>         if (WARN_ON_ONCE(ifq_idx >=3D dev->real_num_rx_queues))
>                 return;
>
>         rxq =3D __netif_get_rx_queue(dev, ifq_idx);
> -
> -       /* Callers holding a netdev ref may get here after we already
> -        * went thru shutdown via dev_memory_provider_uninstall().
> -        */
> -       if (dev->reg_state > NETREG_REGISTERED &&
> -           !rxq->mp_params.mp_ops)
> +       if (!rxq->mp_params.mp_ops)
>                 return;
>
>         if (WARN_ON_ONCE(rxq->mp_params.mp_ops !=3D old_p->mp_ops ||
> @@ -173,13 +169,18 @@ void __net_mp_close_rxq(struct net_device *dev, uns=
igned int ifq_idx,
>
>         rxq->mp_params.mp_ops =3D NULL;
>         rxq->mp_params.mp_priv =3D NULL;
> -       WARN_ON(netdev_rx_queue_restart(dev, ifq_idx));
> +       err =3D netdev_rx_queue_restart(dev, ifq_idx);
> +       WARN_ON(err && err !=3D -ENETDOWN);
>  }
>
>  void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
>                       struct pp_memory_provider_params *old_p)
>  {
>         netdev_lock(dev);
> -       __net_mp_close_rxq(dev, ifq_idx, old_p);
> +       /* Callers holding a netdev ref may get here after we already
> +        * went thru shutdown via dev_memory_provider_uninstall().
> +        */
> +       if (dev->reg_state <=3D NETREG_REGISTERED)
> +               __net_mp_close_rxq(dev, ifq_idx, old_p);

Not obvious to me why this check was moved. Do you expect to call
__net_mp_close_rxq on an unregistered netdev and expect it to succeed
in io_uring binding or something?

--=20
Thanks,
Mina

