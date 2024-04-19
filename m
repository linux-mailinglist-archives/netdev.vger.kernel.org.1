Return-Path: <netdev+bounces-89759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C208AB734
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460941C20C24
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B156513D290;
	Fri, 19 Apr 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0sYfjoVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00716139583
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565427; cv=none; b=FUCgll4jSmIfDzdqUjWczhP4EV5UGEh11idXDu+9UOV0yyUE2sVasdGZudj+ZN5Q2XgE4l8ooz925JAfXAxx5EYsXqXiqhrXdOLzPUWchG8Rtqoid2ExeMKSH9jvOcd4YWD9DpfTDoCRachQdMQDNnUMmXJbX7QkVYRgFEokTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565427; c=relaxed/simple;
	bh=mkkNRdVMe5URbQTQB7oQJJpadymS+gsIVdKKLm7kXJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHv+mjoEt18HudY96UyYWuvXR4HIdjLMB5iL7R8w/6NnDhvAQWqadDZBd8t6GJ1c19T3XGF6VUy0MJwJyHoYdbREA2Cqud6RO9wHnyBTVQ3gY2nzB27QfE+GpKQFOaiSzcgeXxycUcAOa1c7IRsg246FkNAINh70qHP5Rj2xv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0sYfjoVR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a526803fccso1764079a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713565425; x=1714170225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v22El0/xvG9EZmbHP9MmHOq6JQcAfqm39WwnuUXedrk=;
        b=0sYfjoVRgH5ITrRSwqFWmVh1cHL/yWSfVuFRzJYce0YSjs/Cny0gOt9JnJ69P82inJ
         psfUbsuAMtI6/H8Z4JUZqDT6z8dWaEPr5mSMYOeErwUSTxbu9U9JytzVbPztn8+eexai
         FouO3HTKaAVJSXg1YJQNyl49mtGFwgl5ea4nYPzBUzPxMcDzCE9MkhtMDSdxAUsAwI0D
         d/aof1jL5532/yaX6TYLqAZ0D7xl/obz2UPWsR3NUegfyMTOuF+M+jTnZ5N6rfTlvGjG
         4/NmVtP5DpFuiKEQimOE3yGi2iYrA6FENyN/geMuBiRTm8P2yS7/jQ+Q1QsG2QPE3SDH
         EOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713565425; x=1714170225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v22El0/xvG9EZmbHP9MmHOq6JQcAfqm39WwnuUXedrk=;
        b=r5TwWe/R7A7bhkGQK7Eexu11BFMtSMtc3cOuIYUCan8f6s3Qz0TxKgETSf/dpy3x3H
         Dp8Ew6tPb/JmHsH7oFeq58e7V3UoZ5hcZXMAYDJ8qFXMGi1uCmW58IaJceFT2+8VOcCN
         DeEg0PSezXrnhPWf6fASS4Z2/iM3AGEJlc2RvfxztsN61deqx0ExjSX33FXIvEp4BMhu
         igJRl1oAyFmJhYC1btC1J+qhdFbWr3sFV9pWg/h3xWzM4bPRBv6X2TL6v8nzbkiGoDbE
         OoMl1S1x/67iTmYmmtLViH2EH7imo0fw55irrEkkq8H+vGfL23GD917I+a5G4pmlmDlP
         8eTQ==
X-Gm-Message-State: AOJu0YyTtEVQipv2d/mlHjbSzzrUP/UF/m1T4XnSiQPt4k3DMQZSwK3P
	TxadzDW0+jiaghG8IfbfurfSilxapH7F7uwzXmxs0sG+7xaelvTgDKhDCrXj34cjyVjNkVFDFH7
	fZUH5VyQq1SaTWeiwhTVZ0sx/ZCvFpeSUoi4GypnSMasAH4FVCHGQ
X-Google-Smtp-Source: AGHT+IEtUGL0JNUDF5AHidHw+OPlouXcgmOV+tdpRx+U888eLqlABSpsCfW11L3L24T+xF3z/XxpJ/luTfo/jLJ+x8I=
X-Received: by 2002:a17:90b:228f:b0:2ac:5de8:54c0 with SMTP id
 kx15-20020a17090b228f00b002ac5de854c0mr3376364pjb.3.1713565424657; Fri, 19
 Apr 2024 15:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com> <20240418195159.3461151-10-shailend@google.com>
In-Reply-To: <20240418195159.3461151-10-shailend@google.com>
From: Shailend Chand <shailend@google.com>
Date: Fri, 19 Apr 2024 15:23:33 -0700
Message-ID: <CANLc=asOJE-pGV74hXaZT5C73gVvbmDC1Zr6F4wJ31cqLFqcFg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:52=E2=80=AFPM Shailend Chand <shailend@google.co=
m> wrote:
>
> An api enabling the net stack to reset driver queues is implemented for
> gve.
>
> Signed-off-by: Shailend Chand <shailend@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>  drivers/net/ethernet/google/gve/gve_main.c   | 143 +++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>  5 files changed, 167 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 9f6a897c87cb..d752e525bde7 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1147,6 +1147,12 @@ bool gve_tx_clean_pending(struct gve_priv *priv, s=
truct gve_tx_ring *tx);
>  void gve_rx_write_doorbell(struct gve_priv *priv, struct gve_rx_ring *rx=
);
>  int gve_rx_poll(struct gve_notify_block *block, int budget);
>  bool gve_rx_work_pending(struct gve_rx_ring *rx);
> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> +                         struct gve_rx_alloc_rings_cfg *cfg,
> +                         struct gve_rx_ring *rx,
> +                         int idx);
> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
> +                         struct gve_rx_alloc_rings_cfg *cfg);
>  int gve_rx_alloc_rings(struct gve_priv *priv);
>  int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
>                            struct gve_rx_alloc_rings_cfg *cfg);
> diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethe=
rnet/google/gve/gve_dqo.h
> index b81584829c40..e83773fb891f 100644
> --- a/drivers/net/ethernet/google/gve/gve_dqo.h
> +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
> @@ -44,6 +44,12 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
>                            struct gve_tx_alloc_rings_cfg *cfg);
>  void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx);
>  void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx);
> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> +                         struct gve_rx_alloc_rings_cfg *cfg,
> +                         struct gve_rx_ring *rx,
> +                         int idx);
> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> +                         struct gve_rx_alloc_rings_cfg *cfg);
>  int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
>                            struct gve_rx_alloc_rings_cfg *cfg);
>  void gve_rx_free_rings_dqo(struct gve_priv *priv,
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index c348dff7cca6..5e652958f10f 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -17,6 +17,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/utsname.h>
>  #include <linux/version.h>
> +#include <net/netdev_queues.h>
>  #include <net/sch_generic.h>
>  #include <net/xdp_sock_drv.h>
>  #include "gve.h"
> @@ -2070,6 +2071,15 @@ static void gve_turnup(struct gve_priv *priv)
>         gve_set_napi_enabled(priv);
>  }
>
> +static void gve_turnup_and_check_status(struct gve_priv *priv)
> +{
> +       u32 status;
> +
> +       gve_turnup(priv);
> +       status =3D ioread32be(&priv->reg_bar0->device_status);
> +       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK &=
 status);
> +}
> +
>  static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
>         struct gve_notify_block *block;
> @@ -2530,6 +2540,138 @@ static void gve_write_version(u8 __iomem *driver_=
version_register)
>         writeb('\n', driver_version_register);
>  }
>
> +static int gve_rx_queue_stop(struct net_device *dev, int idx,
> +                            void **out_per_q_mem)
> +{
> +       struct gve_priv *priv =3D netdev_priv(dev);
> +       struct gve_rx_ring *rx;
> +       int err;
> +
> +       if (!priv->rx)
> +               return -EAGAIN;
> +       if (idx < 0 || idx >=3D priv->rx_cfg.max_queues)
> +               return -ERANGE;
> +
> +       /* Destroying queue 0 while other queues exist is not supported i=
n DQO */
> +       if (!gve_is_gqi(priv) && idx =3D=3D 0)
> +               return -ERANGE;
> +
> +       rx =3D kvzalloc(sizeof(*rx), GFP_KERNEL);
> +       if (!rx)
> +               return -ENOMEM;
> +       *rx =3D priv->rx[idx];
> +
> +       /* Single-queue destruction requires quiescence on all queues */
> +       gve_turndown(priv);
> +
> +       /* This failure will trigger a reset - no need to clean up */
> +       err =3D gve_adminq_destroy_single_rx_queue(priv, idx);
> +       if (err) {
> +               kvfree(rx);
> +               return err;
> +       }
> +
> +       if (gve_is_gqi(priv))
> +               gve_rx_stop_ring_gqi(priv, idx);
> +       else
> +               gve_rx_stop_ring_dqo(priv, idx);
> +
> +       /* Turn the unstopped queues back up */
> +       gve_turnup_and_check_status(priv);
> +
> +       *out_per_q_mem =3D rx;
> +       return 0;
> +}
> +
> +static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_me=
m)
> +{
> +       struct gve_priv *priv =3D netdev_priv(dev);
> +       struct gve_rx_alloc_rings_cfg cfg =3D {0};
> +       struct gve_rx_ring *rx;
> +
> +       gve_rx_get_curr_alloc_cfg(priv, &cfg);
> +       rx =3D (struct gve_rx_ring *)per_q_mem;
> +       if (!rx)
> +               return;
> +
> +       if (gve_is_gqi(priv))
> +               gve_rx_free_ring_gqi(priv, rx, &cfg);
> +       else
> +               gve_rx_free_ring_dqo(priv, rx, &cfg);
> +
> +       kvfree(per_q_mem);
> +}
> +
> +static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
> +{
> +       struct gve_priv *priv =3D netdev_priv(dev);
> +       struct gve_rx_alloc_rings_cfg cfg =3D {0};
> +       struct gve_rx_ring *rx;
> +       int err;
> +
> +       gve_rx_get_curr_alloc_cfg(priv, &cfg);
> +       if (idx < 0 || idx >=3D cfg.qcfg->max_queues)
> +               return NULL;
> +
> +       rx =3D kvzalloc(sizeof(*rx), GFP_KERNEL);
> +       if (!rx)
> +               return NULL;
> +
> +       if (gve_is_gqi(priv))
> +               err =3D gve_rx_alloc_ring_gqi(priv, &cfg, rx, idx);
> +       else
> +               err =3D gve_rx_alloc_ring_dqo(priv, &cfg, rx, idx);
> +
> +       if (err) {
> +               kvfree(rx);
> +               return NULL;
> +       }
> +       return rx;
> +}
> +
> +static int gve_rx_queue_start(struct net_device *dev, int idx, void *per=
_q_mem)
> +{
> +       struct gve_priv *priv =3D netdev_priv(dev);
> +       struct gve_rx_ring *rx;
> +       int err;
> +
> +       if (!priv->rx)
> +               return -EAGAIN;
> +       if (idx < 0 || idx >=3D priv->rx_cfg.max_queues)
> +               return -ERANGE;
> +       rx =3D (struct gve_rx_ring *)per_q_mem;
> +       priv->rx[idx] =3D *rx;
> +
> +       /* Single-queue creation requires quiescence on all queues */
> +       gve_turndown(priv);
> +
> +       if (gve_is_gqi(priv))
> +               gve_rx_start_ring_gqi(priv, idx);
> +       else
> +               gve_rx_start_ring_dqo(priv, idx);
> +
> +       /* This failure will trigger a reset - no need to clean up */
> +       err =3D gve_adminq_create_single_rx_queue(priv, idx);
> +       if (err)
> +               return err;
> +
> +       if (gve_is_gqi(priv))
> +               gve_rx_write_doorbell(priv, &priv->rx[idx]);
> +       else
> +               gve_rx_post_buffers_dqo(&priv->rx[idx]);
> +
> +       /* Turn the unstopped queues back up */
> +       gve_turnup_and_check_status(priv);
> +       return 0;
> +}

I realized that due to not kvfree-ing the passed-in `per_q_mem`, there
is a leak. The alloc and stop hooks kvzalloc
a temp ring struct, which means the start and free hooks ought to have
kvfreed them to keep symmetry and avoid leaking.
The free hook is doing it but I forgot to do it in the start hook.

If we go down the route of making core aware of the ring struct size,
then none of the four hooks
need to worry about the temp struct: core can just alloc and free it
for both the old and new queue.

> +
> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops =3D {
> +       .ndo_queue_mem_alloc    =3D       gve_rx_queue_mem_alloc,
> +       .ndo_queue_mem_free     =3D       gve_rx_queue_mem_free,
> +       .ndo_queue_start        =3D       gve_rx_queue_start,
> +       .ndo_queue_stop         =3D       gve_rx_queue_stop,
> +};
> +
>  static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *e=
nt)
>  {
>         int max_tx_queues, max_rx_queues;
> @@ -2584,6 +2726,7 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>         pci_set_drvdata(pdev, dev);
>         dev->ethtool_ops =3D &gve_ethtool_ops;
>         dev->netdev_ops =3D &gve_netdev_ops;
> +       dev->queue_mgmt_ops =3D &gve_queue_mgmt_ops;
>
>         /* Set default and supported features.
>          *
> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ether=
net/google/gve/gve_rx.c
> index 1d235caab4c5..307bf97d4778 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> @@ -101,8 +101,8 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int =
idx)
>         gve_rx_reset_ring_gqi(priv, idx);
>  }
>
> -static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ri=
ng *rx,
> -                                struct gve_rx_alloc_rings_cfg *cfg)
> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
> +                         struct gve_rx_alloc_rings_cfg *cfg)
>  {
>         struct device *dev =3D &priv->pdev->dev;
>         u32 slots =3D rx->mask + 1;
> @@ -270,10 +270,10 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, i=
nt idx)
>         gve_add_napi(priv, ntfy_idx, gve_napi_poll);
>  }
>
> -static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> -                                struct gve_rx_alloc_rings_cfg *cfg,
> -                                struct gve_rx_ring *rx,
> -                                int idx)
> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> +                         struct gve_rx_alloc_rings_cfg *cfg,
> +                         struct gve_rx_ring *rx,
> +                         int idx)
>  {
>         struct device *hdev =3D &priv->pdev->dev;
>         u32 slots =3D cfg->ring_size;
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index dc2c6bd92e82..dcbc37118870 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -299,8 +299,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int =
idx)
>         gve_rx_reset_ring_dqo(priv, idx);
>  }
>
> -static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ri=
ng *rx,
> -                                struct gve_rx_alloc_rings_cfg *cfg)
> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> +                         struct gve_rx_alloc_rings_cfg *cfg)
>  {
>         struct device *hdev =3D &priv->pdev->dev;
>         size_t completion_queue_slots;
> @@ -373,10 +373,10 @@ void gve_rx_start_ring_dqo(struct gve_priv *priv, i=
nt idx)
>         gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
>  }
>
> -static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> -                                struct gve_rx_alloc_rings_cfg *cfg,
> -                                struct gve_rx_ring *rx,
> -                                int idx)
> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> +                         struct gve_rx_alloc_rings_cfg *cfg,
> +                         struct gve_rx_ring *rx,
> +                         int idx)
>  {
>         struct device *hdev =3D &priv->pdev->dev;
>         size_t size;
> --
> 2.44.0.769.g3c40516874-goog
>

