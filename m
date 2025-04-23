Return-Path: <netdev+bounces-185285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232DA99A9E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0613C1B87349
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38C2561A3;
	Wed, 23 Apr 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dh38jHKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF426B953
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443067; cv=none; b=YAaSia30zZD8ZIyLh3nDlP7Mk/rlxwVXxvIXmpAilKxSLj8FojHY/4kVcTgsetj4glJnq9198hNe0jug5EUOyZBr9/G54AcgDFBQWhgBBot4AHozWL+b5xuz5sArGXEihppW+tEM6koRVcMJNiGeXuDb/XeFQbZ/EqypynkuJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443067; c=relaxed/simple;
	bh=qjaU2wEsevCLtqxQSaM4YXYYr8eAhMGKQ9g4w2kNypM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMBdw8A30Wqed0S1Sy/NneD7jgP+wR4M39fHr4TLF7YseqzryL5i0mbvcMJFb9xGKtqjdIWGAAThv0mHOCBbQwBoRVJEt0hV/Qul6gtM3DoxvzAeoBu60T4CTs657/Qi6UgNemFcsURE6gRHHy2Slm77+NDvpfQfzjSm+9PRYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dh38jHKw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso16375ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745443064; x=1746047864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCHAoEFfkzTpgUu/TKnX4FSlor+AuzzXRrhTEfsor1M=;
        b=dh38jHKwxPSaF2y6SXbHM+jj+h6iE09ZwyQMRX0PN8aA1jMsrjp7LAIUxGBlKqiiBD
         Sr4AdMeJf1FMZpLZakDmDfP58jhJjX1pWDJDjjVc9x50w6exa5k4H5TZBFBRQ02qjo6x
         E0Dx0PaBq99wQVaOzZK87NEyakwD1+lB5d83c5IaiqDJEj/6PNZzEn/HGJkwA3wJo9Z0
         T7jkR1084ozNxHJXjxmrz+6h7jTsiru1xvtERzxCXA2VZSpgFc9jOJZx6IuUXehN2L9m
         /kR2M3FxI8xr2aWno+XFdtoLyuNgut8C4i9lqjN3tr4qPuXzwiAALnqJojw0V4jfd+kC
         MqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443064; x=1746047864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCHAoEFfkzTpgUu/TKnX4FSlor+AuzzXRrhTEfsor1M=;
        b=XQqnCxhNykZw6MZZaVScQRhrMwrN8yPQeYeDsAVzZPoGVjnfIj6GvSOAJDi8Yrzx6Y
         0Y++FHXNmf8uomg909T+E2mwhDQNkLQOvnEBXhTWZmh4btUm963B1OHemziuWSzgRRri
         JeLfxUq+qq+lOfVjm+vgrLk6lq1ayz8Wm4xRQ3WPeHP5b2NogBl1rvjJdaRuy9dBT44M
         961kxmAWkXXG4rqDuIGvaGgitSq/3rgzEtgrvavi8rVD9Z7+tcctMV62tUYiIJ5r1JGD
         +d8erSo8Fior4QC3CH0DXmw/FmOOhH12rUzVTQt2xAgIe/JZT+mttRjiIyEOujhHhJN4
         I1mg==
X-Forwarded-Encrypted: i=1; AJvYcCUbmd/A4dm6O8B/9HRXPgom12Sx7mMXCyqjZkzkhVNJEUkPXeXjdfa641DRDeKvUxvJ5HkU31Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoxpg6gZlQKHfCzVLIIN0KfWbqHs7w1NLy0XDFV56r9G9+9qLg
	ubOUrCBYwlnLh8/Ng9PW4BKClyy7Ps+KBpm5bKIeunpLynQWJF5LcmHTeHGc+3N/BrCMmXNEGLC
	+o1XmfRkmp1Fa9L79tjfv5y4eBY7K0kk95kcR
X-Gm-Gg: ASbGncuqiKUp39SUi2V9uMBWviO20ThTrT11hMn+WBTAQAXpgUlc6BziaZ8HFOWPQWO
	tuMKNasdRKL7G5QswlFo3wwXgJZTDL3epHog/NYE7vcCwLPvFQAwq5Ju0uAH3rAIclHAMgEUoTY
	f3wXpKnLqysX2dWx8xiIg7ibq95Gr6g3RQc6+3qo4Plj9qTns5Hnc3
X-Google-Smtp-Source: AGHT+IGIGo38kXBCJZoALiOXpfIwWf/HMPD6H0tg04MAx5Mf0xa4gTXoICi36aYN73mQ1aUhV88sPRbnyTTIjp0qWCw=
X-Received: by 2002:a17:903:1a0d:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22db3318c93mr153615ad.19.1745443063518; Wed, 23 Apr 2025
 14:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org> <20250421222827.283737-12-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-12-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 14:17:30 -0700
X-Gm-Features: ATxdqUGNtemrSuaEsJdMUNXl-cBkpcJ6lxntVY5XqgxaQTngsWBEy6ICGxeCXU4
Message-ID: <CAHS8izN5ZjCmBC-+_p0kLFNo5hexEG=GKfk7Jd7w4wokcw2F3w@mail.gmail.com>
Subject: Re: [RFC net-next 11/22] net: allocate per-queue config structs and
 pass them thru the queue API
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk, 
	asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com, 
	dtatulea@nvidia.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Create an array of config structs to store per-queue config.
> Pass these structs in the queue API. Drivers can also retrieve
> the config for a single queue calling netdev_queue_config()
> directly.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_queues.h                | 19 +++++++
>  net/core/dev.h                             |  3 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c  |  8 ++-
>  drivers/net/ethernet/google/gve/gve_main.c |  9 ++--
>  drivers/net/netdevsim/netdev.c             |  6 ++-
>  net/core/netdev_config.c                   | 58 ++++++++++++++++++++++
>  net/core/netdev_rx_queue.c                 | 11 ++--
>  7 files changed, 104 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index c50de8db72ce..1fb621a00962 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -31,6 +31,13 @@ struct netdev_config {
>         /** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
>          */
>         u8      hds_config;
> +
> +       /** @qcfg: per-queue configuration */
> +       struct netdev_queue_config *qcfg;
> +};
> +
> +/* Same semantics as fields in struct netdev_config */
> +struct netdev_queue_config {
>  };
>
>  /* See the netdev.yaml spec for definition of each statistic */
> @@ -129,6 +136,10 @@ struct netdev_stat_ops {
>   *
>   * @ndo_queue_mem_size: Size of the struct that describes a queue's memo=
ry.
>   *
> + * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
> + *                     defaults. Queue config structs are passed to this
> + *                     helper before the user-requested settings are app=
lied.
> + *
>   * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specifie=
d index.
>   *                      The new memory is written at the specified addre=
ss.
>   *
> @@ -146,12 +157,17 @@ struct netdev_stat_ops {
>   */
>  struct netdev_queue_mgmt_ops {
>         size_t  ndo_queue_mem_size;
> +       void    (*ndo_queue_cfg_defaults)(struct net_device *dev,
> +                                         int idx,
> +                                         struct netdev_queue_config *qcf=
g);
>         int     (*ndo_queue_mem_alloc)(struct net_device *dev,
> +                                      struct netdev_queue_config *qcfg,
>                                        void *per_queue_mem,
>                                        int idx);
>         void    (*ndo_queue_mem_free)(struct net_device *dev,
>                                       void *per_queue_mem);
>         int     (*ndo_queue_start)(struct net_device *dev,
> +                                  struct netdev_queue_config *qcfg,
>                                    void *per_queue_mem,
>                                    int idx);
>         int     (*ndo_queue_stop)(struct net_device *dev,

Doesn't the stop call need to return the config of the queue that was
stopped? Otherwise what do you pass to the start command if you want
to restart the old queue?

In general I thought what when we extend the queue API to handle
configs, the config of each queue would be part of the per_queue_mem
attribute, which is now a void *. Because seems to me the config needs
to be passed around with the per_queue_mem to all the functions?
Maybe.

I imagined you'd create a new wrapper struct that is the per queue
mem, and that one will contain a void * that is driver specific
memory, and a netdev_queue_config * inside of it as well, then the
queue API will use the new struct instead of void * for all the
per_queue_mem. At least that's what I was thinking.
> @@ -159,6 +175,9 @@ struct netdev_queue_mgmt_ops {
>                                   int idx);
>  };
>
> +void netdev_queue_config(struct net_device *dev, int rxq,
> +                        struct netdev_queue_config *qcfg);
> +
>  /**
>   * DOC: Lockless queue stopping / waking helpers.
>   *
> diff --git a/net/core/dev.h b/net/core/dev.h
> index c8971c6f1fcd..6d7f5e920018 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -9,6 +9,7 @@
>  #include <net/netdev_lock.h>
>
>  struct net;
> +struct netdev_queue_config;
>  struct netlink_ext_ack;
>  struct cpumask;
>
> @@ -96,6 +97,8 @@ int netdev_alloc_config(struct net_device *dev);
>  void __netdev_free_config(struct netdev_config *cfg);
>  void netdev_free_config(struct net_device *dev);
>  int netdev_reconfig_start(struct net_device *dev);
> +void __netdev_queue_config(struct net_device *dev, int rxq,
> +                          struct netdev_queue_config *qcfg, bool pending=
);
>
>  /* netdev management, shared between various uAPI entry points */
>  struct netdev_name_node {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index a86bb2ba5adb..fbbe02cefdf1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15728,7 +15728,9 @@ static const struct netdev_stat_ops bnxt_stat_ops=
 =3D {
>         .get_base_stats         =3D bnxt_get_base_stats,
>  };
>
> -static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int =
idx)
> +static int bnxt_queue_mem_alloc(struct net_device *dev,
> +                               struct netdev_queue_config *qcfg,
> +                               void *qmem, int idx)
>  {
>         struct bnxt_rx_ring_info *rxr, *clone;
>         struct bnxt *bp =3D netdev_priv(dev);
> @@ -15896,7 +15898,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
>         dst->rx_agg_bmap =3D src->rx_agg_bmap;
>  }
>
> -static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
> +static int bnxt_queue_start(struct net_device *dev,
> +                           struct netdev_queue_config *qcfg,
> +                           void *qmem, int idx)
>  {
>         struct bnxt *bp =3D netdev_priv(dev);
>         struct bnxt_rx_ring_info *rxr, *clone;
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 8aaac9101377..088ae19ddb24 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2428,8 +2428,9 @@ static void gve_rx_queue_mem_free(struct net_device=
 *dev, void *per_q_mem)
>                 gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
>  }
>
> -static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_me=
m,
> -                                 int idx)
> +static int gve_rx_queue_mem_alloc(struct net_device *dev,
> +                                 struct netdev_queue_config *qcfg,
> +                                 void *per_q_mem, int idx)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
>         struct gve_rx_alloc_rings_cfg cfg =3D {0};
> @@ -2450,7 +2451,9 @@ static int gve_rx_queue_mem_alloc(struct net_device=
 *dev, void *per_q_mem,
>         return err;
>  }
>
> -static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, i=
nt idx)
> +static int gve_rx_queue_start(struct net_device *dev,
> +                             struct netdev_queue_config *qcfg,
> +                             void *per_q_mem, int idx)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
>         struct gve_rx_ring *gve_per_q_mem;
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 0e0321a7ddd7..a2aa85a85e0f 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -661,7 +661,8 @@ struct nsim_queue_mem {
>  };
>
>  static int
> -nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int id=
x)
> +nsim_queue_mem_alloc(struct net_device *dev, struct netdev_queue_config =
*qcfg,
> +                    void *per_queue_mem, int idx)
>  {
>         struct nsim_queue_mem *qmem =3D per_queue_mem;
>         struct netdevsim *ns =3D netdev_priv(dev);
> @@ -710,7 +711,8 @@ static void nsim_queue_mem_free(struct net_device *de=
v, void *per_queue_mem)
>  }
>
>  static int
> -nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
> +nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcf=
g,
> +                void *per_queue_mem, int idx)
>  {
>         struct nsim_queue_mem *qmem =3D per_queue_mem;
>         struct netdevsim *ns =3D netdev_priv(dev);
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> index 270b7f10a192..bad2d53522f0 100644
> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -8,18 +8,29 @@
>  int netdev_alloc_config(struct net_device *dev)
>  {
>         struct netdev_config *cfg;
> +       unsigned int maxqs;
>
>         cfg =3D kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
>         if (!cfg)
>                 return -ENOMEM;
>
> +       maxqs =3D max(dev->num_rx_queues, dev->num_tx_queues);
> +       cfg->qcfg =3D kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOU=
NT);

I just thought of this, but for devices that can new rx/tx queues on
the fly, isn't num_rx_queues dynamically changing? How do you size
this qcfg array in this case?

Or do they go through a full driver reset everytime they add a queue
which reallocates dev->num_rx_queues?

...

> +
> +void __netdev_queue_config(struct net_device *dev, int rxq,
> +                          struct netdev_queue_config *qcfg, bool pending=
)
> +{
> +       memset(qcfg, 0, sizeof(*qcfg));
> +
> +       /* Get defaults from the driver, in case user config not set */
> +       if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
> +               dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcf=
g);
> +}
> +
> +/**
> + * netdev_queue_config() - get configuration for a given queue
> + * @dev:  net_device instance
> + * @rxq:  index of the queue of interest
> + * @qcfg: queue configuration struct (output)
> + *
> + * Render the configuration for a given queue. This helper should be use=
d
> + * by drivers which support queue configuration to retrieve config for
> + * a particular queue.
> + *
> + * @qcfg is an output parameter and is always fully initialized by this
> + * function. Some values may not be set by the user, drivers may either
> + * deal with the "unset" values in @qcfg, or provide the callback
> + * to populate defaults in queue_management_ops.
> + *
> + * Note that this helper returns pending config, as it is expected that
> + * "old" queues are retained until config is successful so they can
> + * be restored directly without asking for the config.
> + */
> +void netdev_queue_config(struct net_device *dev, int rxq,
> +                        struct netdev_queue_config *qcfg)
> +{
> +       __netdev_queue_config(dev, rxq, qcfg, true);
> +}
> +EXPORT_SYMBOL(netdev_queue_config);
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index d126f10197bf..d8a710db21cd 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -7,12 +7,14 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/memory_provider.h>
>
> +#include "dev.h"
>  #include "page_pool_priv.h"
>
>  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx=
)
>  {
>         struct netdev_rx_queue *rxq =3D __netif_get_rx_queue(dev, rxq_idx=
);
>         const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_ops;
> +       struct netdev_queue_config qcfg;
>         void *new_mem, *old_mem;
>         int err;
>
> @@ -32,7 +34,9 @@ int netdev_rx_queue_restart(struct net_device *dev, uns=
igned int rxq_idx)
>                 goto err_free_new_mem;
>         }
>
> -       err =3D qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
> +       netdev_queue_config(dev, rxq_idx, &qcfg);
> +
> +       err =3D qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
>         if (err)
>                 goto err_free_old_mem;
>
> @@ -45,7 +49,7 @@ int netdev_rx_queue_restart(struct net_device *dev, uns=
igned int rxq_idx)
>                 if (err)
>                         goto err_free_new_queue_mem;
>
> -               err =3D qops->ndo_queue_start(dev, new_mem, rxq_idx);
> +               err =3D qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_id=
x);
>                 if (err)
>                         goto err_start_queue;
>         } else {
> @@ -60,6 +64,7 @@ int netdev_rx_queue_restart(struct net_device *dev, uns=
igned int rxq_idx)
>         return 0;
>
>  err_start_queue:
> +       __netdev_queue_config(dev, rxq_idx, &qcfg, false);

Ah, on error, you reset the queue to its defaults, which I'm not sure
is desirable. I think we want to restart the queue with whatever
config it had before.

>         /* Restarting the queue with old_mem should be successful as we h=
aven't
>          * changed any of the queue configuration, and there is not much =
we can
>          * do to recover from a failure here.
> @@ -67,7 +72,7 @@ int netdev_rx_queue_restart(struct net_device *dev, uns=
igned int rxq_idx)
>          * WARN if we fail to recover the old rx queue, and at least free
>          * old_mem so we don't also leak that.
>          */
> -       if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
> +       if (qops->ndo_queue_start(dev, &qcfg, old_mem, rxq_idx)) {
>                 WARN(1,
>                      "Failed to restart old queue in error path. RX queue=
 %d may be unhealthy.",
>                      rxq_idx);
> --
> 2.49.0
>


--=20
Thanks,
Mina

