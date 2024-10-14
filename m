Return-Path: <netdev+bounces-135105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F099C436
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC8FB2938E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C2153812;
	Mon, 14 Oct 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VSImPcr4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6EE1531E3
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896092; cv=none; b=NT4b95pgxBx162quqjvOzoqBB0zu3sb0J6j/P/gIJv8AWqwh3+yPzrmlfHA3jdHgDETVCKR+kNenfI7eSLrOvB8er4gzq5m9V80PqjmL6nN8pYCnP8rrj9uhkCDP6iJybSAsWNBPnZX3sCztLGLm0gP5DVRiSos+Isvi3jCgKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896092; c=relaxed/simple;
	bh=c/ZYioKK6UheIuVlDLSzQ0sGefMJo7sZVxq3k7ojQp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYU3gnOXtuR+bgOMHXi8W9pGpgbbeXeLjuIq/rlPwyKuJOCLQGYtp6vLvoxAHfCqxr9WXVjZUAOUbZ1yRwwHY5GzSnj0xiNDk3aWn2mF4ON0xzprqABqni0dmsGMqS3pJVK+9HH6wyG8TooPbrZeuNTG68QfUUU1j6trvFnFdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VSImPcr4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728896090; x=1760432090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/ZYioKK6UheIuVlDLSzQ0sGefMJo7sZVxq3k7ojQp4=;
  b=VSImPcr40vVPwJqBO/ScqYRREN8FcWtgd02eJCIQmowHIbYcpxPc2LQw
   lGgnbjV+hALk9p0oIsQbp5CYL2FGMe3Qrx6u6hCRb0dk+ALgjs2gJT1Ri
   uQwyfBQBhSrDGyboru72NlqI10JMvcFnA5pn5zMVK9EnCwNRn5IXnStyd
   6u6Fehz7KodYC18kC6x8VnnJTO09xw0aEyPgg5x//nysqN8MKbV3ucieD
   jhaV44E6p3M4dbUQyvcj1Yhn5CDqWuRJAX5DyLFjNdQ5RPt4Pg4gXzUxP
   ae5iyX95KG6UzXDxPgMeFS4ICPgvEYtpTPo8cFegDOO896euDqFGYxvIl
   w==;
X-CSE-ConnectionGUID: r+obOHDmSZW+osn/zUiy0g==
X-CSE-MsgGUID: qb7dIcGwRDuI/vA0BGMJFQ==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32776524"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 01:54:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 01:54:48 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 14 Oct 2024 01:54:47 -0700
Date: Mon, 14 Oct 2024 08:54:46 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>
Subject: Re: [PATCH net-next 01/15] net/mlx5: Refactor QoS group scheduling
 element creation
Message-ID: <20241014085446.gjlhbj377nadis55@DEN-DL-M70577>
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241013064540.170722-2-tariqt@nvidia.com>

Hi,

> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce `esw_qos_create_group_sched_elem` to handle the creation of
> group scheduling elements for E-Switch QoS, Transmit Scheduling
> Arbiter (TSAR).
> 
> This reduces duplication and simplifies code for TSAR setup.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 63 +++++++++----------
>  1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index ee6f76a6f0b5..e357ccd7bfd3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -371,6 +371,33 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
>         return err;
>  }
> 
> +static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
> +                                          u32 *tsar_ix)
> +{
> +       u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
> +       void *attr;
> +
> +       if (!mlx5_qos_element_type_supported(dev,
> +                                            SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
> +                                            SCHEDULING_HIERARCHY_E_SWITCH) ||
> +           !mlx5_qos_tsar_type_supported(dev,
> +                                         TSAR_ELEMENT_TSAR_TYPE_DWRR,
> +                                         SCHEDULING_HIERARCHY_E_SWITCH))
> +               return -EOPNOTSUPP;
> +
> +       MLX5_SET(scheduling_context, tsar_ctx, element_type,
> +                SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
> +       MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
> +                parent_element_id);
> +       attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
> +       MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
> +
> +       return mlx5_create_scheduling_element_cmd(dev,
> +                                                 SCHEDULING_HIERARCHY_E_SWITCH,
> +                                                 tsar_ctx,
> +                                                 tsar_ix);
> +}
> +
>  static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
>                                               u32 max_rate, u32 bw_share)
>  {
> @@ -496,21 +523,10 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
>  static struct mlx5_esw_rate_group *
>  __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
>  {
> -       u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
>         struct mlx5_esw_rate_group *group;
> -       int tsar_ix, err;
> -       void *attr;
> +       u32 tsar_ix, err;
> 
> -       MLX5_SET(scheduling_context, tsar_ctx, element_type,
> -                SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
> -       MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
> -                esw->qos.root_tsar_ix);
> -       attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
> -       MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
> -       err = mlx5_create_scheduling_element_cmd(esw->dev,
> -                                                SCHEDULING_HIERARCHY_E_SWITCH,
> -                                                tsar_ctx,
> -                                                &tsar_ix);
> +       err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);

'err' is now u32 and esw_qos_create_group_sched_elem returns an int -
is this intentional? the error check should still work though.


>         if (err) {
>                 NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
>                 return ERR_PTR(err);
> @@ -591,32 +607,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
> 
>  static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
>  {
> -       u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
>         struct mlx5_core_dev *dev = esw->dev;
> -       void *attr;
>         int err;
> 
>         if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
>                 return -EOPNOTSUPP;
> 
> -       if (!mlx5_qos_element_type_supported(dev,
> -                                            SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
> -                                            SCHEDULING_HIERARCHY_E_SWITCH) ||
> -           !mlx5_qos_tsar_type_supported(dev,
> -                                         TSAR_ELEMENT_TSAR_TYPE_DWRR,
> -                                         SCHEDULING_HIERARCHY_E_SWITCH))
> -               return -EOPNOTSUPP;
> -
> -       MLX5_SET(scheduling_context, tsar_ctx, element_type,
> -                SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
> -
> -       attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
> -       MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
> -
> -       err = mlx5_create_scheduling_element_cmd(dev,
> -                                                SCHEDULING_HIERARCHY_E_SWITCH,
> -                                                tsar_ctx,
> -                                                &esw->qos.root_tsar_ix);
> +       err = esw_qos_create_group_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);

Same here.

>         if (err) {
>                 esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
>                 return err;
> --
> 2.44.0
> 
> 

