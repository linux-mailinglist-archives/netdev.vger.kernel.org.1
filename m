Return-Path: <netdev+bounces-215051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255FB2CE84
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD3E14E3657
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD13345749;
	Tue, 19 Aug 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppL8acYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35D3451A0
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639005; cv=none; b=PaqG2YMKOlampJVmU9kqLHzRVFvCGwjWNX1qDOc0Du4S0l3/43AcvlBmTDOEdUthD5YQxRSlFMlvRsw3u4bcNkw2zfilN2E8NloOizTLxhhTAn+7xyZM5i+XRBufPiGJPips4/gapv0xWu2hb056Bfo0BQIm+xKg8lIlW8CCYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639005; c=relaxed/simple;
	bh=94Saal8DSRTagRypzBLqkwEyHkYApeYnXP4jrmwgIWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTd10RT63GWKydp0ddT3PEnYBBOLXXXr4AxA01u59iltCkb6tOZzV/ckIW8jEc9ZazblM3h0RypCqb/7Y31dulnazR9KWhBxzlfjR8tNxFiPOPwcQ0gAvSZCBCy7MtJy/V8MOY+SGWM7FkWHgnSqo+kMl47p5g9r9875Sa5iSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppL8acYi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cef2f624fso458e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755639000; x=1756243800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQKI96pvZFJRQ6lXwzt/yGbppL0TtT3IJWuFPeZ5ovE=;
        b=ppL8acYi1DZAY4sk0n+52YN0wSFB6fwcEMPtVs75/xKENrqUdnNa0oo391mjWpN8UP
         h8rMYUdACeYyKnCenyCbh+LB7sWe3P32EMC+IrVutKu5wMXCP1pfk7DYflwt75qG2Vrb
         3ltnHzNueZqTHEBFrfvqazgidVVdwpebPP+Rs5e+7pcLREIPSZKYAYO2iXcgsO1NYeEO
         EIMd8EpkvuuAfSTiTHndqxEzj1dN84YL1sEQEb9sqRn7Zm8rYYPDtf5td72WT6HiNqO3
         k3OAVqGYU9JIIOFhcsQRpQLyJL3jMgLQe/QXzksCD6yCwAe6iHvqOvdz1WGO/hFE9ZMC
         81Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639000; x=1756243800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQKI96pvZFJRQ6lXwzt/yGbppL0TtT3IJWuFPeZ5ovE=;
        b=uS41EfqOwWZAw4CQ1mMVZWBYWHKPcZMEmVSv88wsZgCRZi8e755c0az1UANSmGecso
         yopSxvA3UjKPWdtM5zVPpHQ+DZSOHWcvUNvfik4MgSe7aZGKs5E/0sfiOvDo1ZklX4tS
         bYh4ijvKyEYjX6kWDlzcMGggRqPNo7s6uAsdCtSki2PV3+M1BwTgdhGskrflc4DXBYk3
         UoJrzpRRm8LEWz2Vh6usfvWihg+ntt3wNmKCDVnrs+NdhPg3Z070EreUS5Z1kGcpZFKo
         xvKSYpeGue84v+qy6I7wRJb3ZdX+Vx/NL6egrKvWKnWLEP4iM29Na64XWvJXyZWo3PiB
         n9gA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8t0FLHxISCBInbSi+Nb/KHmcSpEzLbFoI63CHaOzBrCsQpe9spPez5JMq4mwJzYwhe2JwHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqsEAS+otoXeHTXKAoge9AvljsH/t0zzD1pQEyizGbwgP716v
	1PkDGvw2Y5LDWbvZhBSSSUOKW7e95PV2EOK6uxhKsiRHxcbbd+zc6qSjWhulhHOyALSTBm+bSTu
	5qVH4wZL5kyURj2lm+HABcP2IiJxw39v/W8sqo/EX
X-Gm-Gg: ASbGncvZn8DaaEOr699teUniUUxsGSnxOoFBmExQPbz8wFfaYZpzwrp2PIWCSelg3D+
	ga6zHYGftkGFLt3IboY8A+OqYyHBgrIOCk4HUmxMldxGezxRbn4fl0u65JLDGgE2K2ONyvg0TJg
	ehy4MKA3aNZhAHkdcoZzhwJRbAGpttguXIMvI5z/ib0TBlg3fms2oP6LAsZnmGM1B3WTjmPTwni
	K0MI7aFr8V9muip6jDb3E7OyCfUJCtFSaWWCgM/dRz9
X-Google-Smtp-Source: AGHT+IEKkdLqG1G89s18kVowt35cw3Za8E2n2gKF2oDZ13d4EfU6TGbW4/ajEwJqdbX6pVXJAwbcsoBnHoRX/c1FSuM=
X-Received: by 2002:a05:6512:1412:b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-55e067e2d86mr96867e87.6.1755639000113; Tue, 19 Aug 2025
 14:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <9a2571a308e1a2ac600bc23db4911c03fc923d11.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <9a2571a308e1a2ac600bc23db4911c03fc923d11.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:29:47 -0700
X-Gm-Features: Ac12FXwkrfX4-EoQEINPDFYTc_gyohegEZdplF_qJnpWFODjzwnV-h7TcJxuWy8
Message-ID: <CAHS8izPgcjR-L=xfLvJDEVVt3uUOfavoEAWuCZ9F4DgpoAmHtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 12/23] net: allocate per-queue config structs
 and pass them thru the queue API
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Create an array of config structs to store per-queue config.
> Pass these structs in the queue API. Drivers can also retrieve
> the config for a single queue calling netdev_queue_config()
> directly.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: patch up mlx callbacks with unused qcfg]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++-
>  drivers/net/ethernet/google/gve/gve_main.c    |  9 ++-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  9 +--
>  drivers/net/netdevsim/netdev.c                |  6 +-
>  include/net/netdev_queues.h                   | 19 ++++++
>  net/core/dev.h                                |  3 +
>  net/core/netdev_config.c                      | 58 +++++++++++++++++++
>  net/core/netdev_rx_queue.c                    | 11 +++-
>  8 files changed, 109 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index d3d9b72ef313..48ff6f024e07 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15824,7 +15824,9 @@ static const struct netdev_stat_ops bnxt_stat_ops=
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
> @@ -15992,7 +15994,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
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
> index 1f411d7c4373..f40edab616d8 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2580,8 +2580,9 @@ static void gve_rx_queue_mem_free(struct net_device=
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
> @@ -2602,7 +2603,9 @@ static int gve_rx_queue_mem_alloc(struct net_device=
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
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 21bb88c5d3dc..83264c17a4f7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5541,8 +5541,9 @@ struct mlx5_qmgmt_data {
>         struct mlx5e_channel_param cparam;
>  };
>
> -static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
> -                                int queue_index)
> +static int mlx5e_queue_mem_alloc(struct net_device *dev,
> +                                struct netdev_queue_config *qcfg,
> +                                void *newq, int queue_index)
>  {
>         struct mlx5_qmgmt_data *new =3D (struct mlx5_qmgmt_data *)newq;
>         struct mlx5e_priv *priv =3D netdev_priv(dev);
> @@ -5603,8 +5604,8 @@ static int mlx5e_queue_stop(struct net_device *dev,=
 void *oldq, int queue_index)
>         return 0;
>  }
>
> -static int mlx5e_queue_start(struct net_device *dev, void *newq,
> -                            int queue_index)
> +static int mlx5e_queue_start(struct net_device *dev, struct netdev_queue=
_config *qcfg,
> +                            void *newq, int queue_index)
>  {
>         struct mlx5_qmgmt_data *new =3D (struct mlx5_qmgmt_data *)newq;
>         struct mlx5e_priv *priv =3D netdev_priv(dev);
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 0178219f0db5..985c3403ec57 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -733,7 +733,8 @@ struct nsim_queue_mem {
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
> @@ -782,7 +783,8 @@ static void nsim_queue_mem_free(struct net_device *de=
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
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index d73f9023c96f..b850cff71d12 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -32,6 +32,13 @@ struct netdev_config {
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

I was very confused why this is empty until I looked at patch 18 :-D

>
>  /* See the netdev.yaml spec for definition of each statistic */
> @@ -136,6 +143,10 @@ void netdev_stat_queue_sum(struct net_device *netdev=
,
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
> @@ -153,12 +164,17 @@ void netdev_stat_queue_sum(struct net_device *netde=
v,
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
> @@ -166,6 +182,9 @@ struct netdev_queue_mgmt_ops {
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
> index 7041c8bd2a0f..a553a0f1f846 100644
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

I honestly did not think about tx queues at all for the queue api thus
far. The ndos do specify that api applies to rx queues, and maybe the
driver only implemented them to assume indeed the calls are to rx
queues. Are you intentionally extending the queue api support for tx
queues? Or maybe you're allocing configs for the tx queues to be used
in some future?

Other places in this patch series uses num_rx_queues directly. Feels
like this should do the same.

> +       cfg->qcfg =3D kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOU=
NT);
> +       if (!cfg->qcfg)
> +               goto err_free_cfg;
> +
>         dev->cfg =3D cfg;
>         dev->cfg_pending =3D cfg;
>         return 0;
> +
> +err_free_cfg:
> +       kfree(cfg);
> +       return -ENOMEM;
>  }
>
>  void __netdev_free_config(struct netdev_config *cfg)
>  {
> +       kfree(cfg->qcfg);
>         kfree(cfg);
>  }
>
> @@ -32,12 +43,59 @@ void netdev_free_config(struct net_device *dev)
>  int netdev_reconfig_start(struct net_device *dev)
>  {
>         struct netdev_config *cfg;
> +       unsigned int maxqs;
>
>         WARN_ON(dev->cfg !=3D dev->cfg_pending);
>         cfg =3D kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
>         if (!cfg)
>                 return -ENOMEM;
>
> +       maxqs =3D max(dev->num_rx_queues, dev->num_tx_queues);
> +       cfg->qcfg =3D kmemdup_array(dev->cfg->qcfg, maxqs, sizeof(*cfg->q=
cfg),
> +                                 GFP_KERNEL_ACCOUNT);
> +       if (!cfg->qcfg)
> +               goto err_free_cfg;
> +
>         dev->cfg_pending =3D cfg;
>         return 0;
> +
> +err_free_cfg:
> +       kfree(cfg);
> +       return -ENOMEM;
> +}
> +
> +void __netdev_queue_config(struct net_device *dev, int rxq,
> +                          struct netdev_queue_config *qcfg, bool pending=
)
> +{
> +       memset(qcfg, 0, sizeof(*qcfg));
> +

This memset 0 is wrong for queue configs like hds_thresh where 0 is a
value, not 'restore default'.

Either netdev_queue_config needs to have a comment that says 'only
values where 0 is restore default is allowed in this struct', or this
function needs to handle 0-as-value configs correctly.

But I wonder if the memset(0) is wrong in general. Isn't this helper
trying to grab the _current_ configuration? So qcfg should be seeded
with appropriate value from dev->qcfgs[rxq]? This function reads like
it's trying to get the default configuration, but in a way that
doesn't handle hds_thresh style semantics correctly?

> +       /* Get defaults from the driver, in case user config not set */
> +       if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
> +               dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcf=
g);

If this function is trying to get the _current_ cfg, then overwriting
with the queue defaults doesn't seem correct?

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

So the helper should be used with drivers that support queue
configuration, which are a subset of drivers that support queue mgmt
API. I don't see in this patch a signal from the driver that it
supports queue configuration, and core acting on that signal. Even the
added ndo_queue_cfg_defaults is just not called if it's not
implemented? Is that intended to be in the later patch with
netdev_queue_mgmt_ops->supported_ring_params?

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
>  }
> +EXPORT_SYMBOL(netdev_queue_config);
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 3bf1151d8061..fb87ce219a8a 100644
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


--
Thanks,
Mina

