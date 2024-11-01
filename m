Return-Path: <netdev+bounces-141021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873A9B91EC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F161C2249A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552F433B3;
	Fri,  1 Nov 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ym1jQbO0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B6381B9
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467361; cv=none; b=bmCWS3NabdMT4UmqKu373Rk61eN0oqoxOGAKYHSPLRmgRKJzhRsrjjMKDC/hqLFAhIPda0pr7338ZEH/rh+jeIlXV2ZR/iMmU1ijx2SyiX5RiYXZCXaFgDhKSeytlHENtR3porBNaU35ArTGWBqNYCWzLY7Nb1D+E7kkJ5tg84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467361; c=relaxed/simple;
	bh=DiY1DhM2jjRWOIFMbkpVO/KHpVwqTsf05Lp5hy/CQU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8398Gw4brnKQEvwrAVtFTgbRjnhD/fVGQ3/Bqe+bNs4FYfVZOLY44mrVYgGEnrz31eUr63bfwAW8N3BadzIB6oRe4EoWRB9AZdvo/BrcHt839t/bo0BnQqGo5qxUahdHxAYIYvJCTP8gZZv7ooc3dnk+KeGC3iIuS+R2wDz68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ym1jQbO0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730467358; x=1762003358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DiY1DhM2jjRWOIFMbkpVO/KHpVwqTsf05Lp5hy/CQU4=;
  b=ym1jQbO0CpTH8oRKZwHcH3WS5jCFHue7hr0VmM+wqE2XowA0OYEgXBdd
   a1ElITIOtzv4aJo84NlGhAis3Rs7R9thBxtEw3TKqSpCemzP39PAHD0gM
   NNHEU6ajiS5M2pT6yUWZOK64Sxf0aMGKMcRShNkVa17hO+odXe1ObnQOm
   2NRscmHUMljfmc3lo31ndQNejFSGvFjA23Ib7D+U6FmsXEYzAxRbzV2o5
   JJoEBRC7AnBlmw1aq6EN1tjRxgoXJhmGthCUKkUo39CdiCdvAHecLqGh2
   mR8AC5/jCDV0jxgYnTmts5wPzYczenj5oM5EZ+KwZ7DWI2HasJtsfAXe0
   w==;
X-CSE-ConnectionGUID: C1NTR8BdRbOpXkq+IL22/Q==
X-CSE-MsgGUID: 2tY68HBnQjO81hsN3w4+GQ==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="201190245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 06:22:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 06:22:16 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Nov 2024 06:22:14 -0700
Date: Fri, 1 Nov 2024 13:22:14 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, William Tu <witu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Subject: Re: [PATCH net-next 5/5] net/mlx5e: do not create xdp_redirect for
 non-uplink rep
Message-ID: <20241101132214.7m65kp434b364apl@DEN-DL-M70577>
References: <20241031125856.530927-1-tariqt@nvidia.com>
 <20241031125856.530927-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031125856.530927-6-tariqt@nvidia.com>

Hi Tariq, William

> From: William Tu <witu@nvidia.com>
> 
> XDP and XDP socket require extra SQ/RQ/CQs. Most of these resources
> are dynamically created: no XDP program loaded, no resources are
> created. One exception is the SQ/CQ created for XDP_REDRIECT, used
> for other netdev to forward packet to mlx5 for transmit. The patch
> disables creation of SQ and CQ used for egress XDP_REDIRECT, by
> checking whether ndo_xdp_xmit is set or not.
> 
> For netdev without XDP support such as non-uplink representor, this
> saves around 0.35MB of memory, per representor netdevice per channel.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c   | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 2f609b92d29b..59d7a0e28f24 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2514,6 +2514,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>                              struct mlx5e_params *params,
>                              struct mlx5e_channel_param *cparam)
>  {
> +       const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
>         struct dim_cq_moder icocq_moder = {0, 0};
>         struct mlx5e_create_cq_param ccp;
>         int err;
> @@ -2534,10 +2535,12 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>         if (err)
>                 goto err_close_icosq_cq;
> 
> -       c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
> -       if (IS_ERR(c->xdpsq)) {
> -               err = PTR_ERR(c->xdpsq);
> -               goto err_close_tx_cqs;
> +       if (netdev_ops->ndo_xdp_xmit) {

Is it possible to have ndo_xdp_xmit() set, but *not* have an XDP prog attached
to the netdevice? I see that c->xdp = !!params->xdp_prog - could that be
used instead?

/Daniel

> +               c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
> +               if (IS_ERR(c->xdpsq)) {
> +                       err = PTR_ERR(c->xdpsq);
> +                       goto err_close_tx_cqs;
> +               }
>         }
> 
>         err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
> @@ -2601,7 +2604,8 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>         mlx5e_close_cq(&c->rq.cq);
> 
>  err_close_xdpredirect_sq:
> -       mlx5e_close_xdpredirect_sq(c->xdpsq);
> +       if (c->xdpsq)
> +               mlx5e_close_xdpredirect_sq(c->xdpsq);
> 
>  err_close_tx_cqs:
>         mlx5e_close_tx_cqs(c);
> @@ -2629,7 +2633,8 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>         if (c->xdp)
>                 mlx5e_close_cq(&c->rq_xdpsq.cq);
>         mlx5e_close_cq(&c->rq.cq);
> -       mlx5e_close_xdpredirect_sq(c->xdpsq);
> +       if (c->xdpsq)
> +               mlx5e_close_xdpredirect_sq(c->xdpsq);
>         mlx5e_close_tx_cqs(c);
>         mlx5e_close_cq(&c->icosq.cq);
>         mlx5e_close_cq(&c->async_icosq.cq);
> --
> 2.44.0
> 
> 

