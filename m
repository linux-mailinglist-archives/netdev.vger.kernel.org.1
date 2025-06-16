Return-Path: <netdev+bounces-198321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B94CADBD7E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319857A8EB7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1D22AE45;
	Mon, 16 Jun 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MckM5IBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE417225795
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116041; cv=none; b=nHsNRK5MpvlbvUukt54djiT0enSFynam69LXzLtOAq7KIwRMlmM/rZ89jmhW88AVYxLr7hIYnTmwFRl7PSOkxgEI0ZEc/vefr7XJX9BU2k13NL8owtkSMu0lPGc7cDJkPx5osDrVy+1O7+G0m/NloXrivmkzWvF/IIsvkaeChnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116041; c=relaxed/simple;
	bh=vNTnwF9GKK0IoF6o/nzhrJo2uLgI+FrXJuwxp8SqTQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyTt5cWaV/o/3X0kTQsTvOwLcQSUBa5+qGgjKF8UGkUjDZhd2x9IuRNL1DmpToQP437tDVBpUX6TUjJn8pzkME8+d19AU+dmQ9uEmA7KK5DReyLmVS7Mmtf2gLmY63q1xQ23xOYuXPGwanAFViquiFfjw7tJ66ExHDUgTyOtD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MckM5IBx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e389599fso85185ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750116039; x=1750720839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyytRBIss30VLX92/RelICIPjiY1WTLTsOKNaQMthuE=;
        b=MckM5IBxSpxEkpnREDbQCGssFi2zwwoMzRv/sKjHGFe3Y21GIsKmbZHS1tw74x01PO
         wFcsw+HnJ2D2dorp+sNRQS95c3nzqyAKN4BLNKC9accNGTN1dDIYa2ZNri8TDNW/XTZs
         YMiVrpw/d4zNEa2gLWH4bTNxh0y4roULFxryzC/yMq4YMv0m0Fe3DY+nxOtd9ee+VbQk
         IE9wR/r2EnIJNz8Ze/EJ6j1MTNJn6HY+p49afoGBJ4qjM1E1YOSN2rifo95w0xFGNt/N
         kyCqaCsz1eAQC0x+5pNejlZNluMbjQbzVVz0YVwWWMRwuyxISouxIQ/ul6jT7WgR/unu
         gExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116039; x=1750720839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyytRBIss30VLX92/RelICIPjiY1WTLTsOKNaQMthuE=;
        b=HWuARZSJM9tlIVyPOP3uU8OUzFqfuUUvdBXb9HmX2KvFwLUUJXNGjqONTIGWwEF2Mx
         Bjk/voe+8+ot7Nt316d3fiFq0OBUrMWcbKPBC5hBh9cK7X82y+l7fGrOIWnFFDJNbPhA
         GWNskV+x9QevuZazA/T0HOKcf/dMw2ATkXn5IW8MA6sSZa++1MQBQ98dpN22msMg84Ff
         RSjVyeircC0C64rV1jr4KJZLtYQL/UTS6mjL062oGHj6/xttrdT9uYXnlp2pHAlqYNAZ
         A78zugZESOUR88vaBOVXDevXGy4WNAXkK5JIm1DRB+Tf1bNBRUOk96e7IaO27IuxGx04
         34nw==
X-Forwarded-Encrypted: i=1; AJvYcCVtAmr99KnV+v4RYo4dhZl5zg8X88ej/aztLVvIVF5K6odql0d7Dacp2PZzGxI61X1xBrt+vM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yR6BZRzRr6pULIl/w22uti3owo89ci5mPdY8M5X3DdYGDMNZ
	TZF37HSsaIb50jAzPBNhRi9VGftpEfBXPym39a64bKLvgOTxxlB1pSUQFgA2ZfdkXga6fJMLHKk
	sEipYSI2lEwLMYfdRrRhKL3V9nKjeLmMlI84DNNZJ
X-Gm-Gg: ASbGnctekdukQCcSq9c83Be3OPdxlyrXqa4AOLvmWGvPl34hfvr2nvLG0CKsLhfKxr1
	/N4Nv6Bfg+YsW9OTGQYWtO0/Ogw9FyfNbVdQAVF7+nGvw0VJUyuuu62JR/bzGjcbFYcjCTw7p5U
	Cezfg5NIvOFeAi15BXxAXjnC/9P8As51oXeiYwZ1Qnvaiu
X-Google-Smtp-Source: AGHT+IHXnwARWegGFo3Ls/RMFPkkol/qsUQos1PSrw1y658KGXmes/6RuO0wwXI83dq5TgtFosifbJghm7S3DE4kZ4Y=
X-Received: by 2002:a17:903:2f07:b0:22e:1858:fc25 with SMTP id
 d9443c01a7336-2366eef4f2bmr5835145ad.9.1750116038794; Mon, 16 Jun 2025
 16:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616141441.1243044-1-mbloch@nvidia.com> <20250616141441.1243044-11-mbloch@nvidia.com>
In-Reply-To: <20250616141441.1243044-11-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Jun 2025 16:20:25 -0700
X-Gm-Features: AX0GCFtZpxhZvU77AkL5_V9_bYi_u1lZxXIho5kV2sVVHPGhYrOea7qfCuTr1rU
Message-ID: <CAHS8izN_Aj6jswP=FRDu6a4TG1Qcc2HHQYxRUuL4HO_UShHkRg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:22=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
> and create the new channel resources, similar to
> mlx5e_safe_switch_params, but here we do it for a single channel using
> existing params, sort of a clone channel.
> To swap the old channel with the new one, we deactivate and close the
> old channel then replace it with the new one, since the swap procedure
> doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index a51e204bd364..873a42b4a82d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5494,6 +5494,103 @@ static const struct netdev_stat_ops mlx5e_stat_op=
s =3D {
>         .get_base_stats      =3D mlx5e_get_base_stats,
>  };
>
> +struct mlx5_qmgmt_data {
> +       struct mlx5e_channel *c;
> +       struct mlx5e_channel_param cparam;
> +};
> +
> +static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
> +                                int queue_index)
> +{
> +       struct mlx5_qmgmt_data *new =3D (struct mlx5_qmgmt_data *)newq;
> +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> +       struct mlx5e_channels *chs =3D &priv->channels;
> +       struct mlx5e_params params =3D chs->params;
> +       struct mlx5_core_dev *mdev;
> +       int err;
> +
> +       mutex_lock(&priv->state_lock);
> +       if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
> +               err =3D -ENODEV;
> +               goto unlock;
> +       }
> +
> +       if (queue_index >=3D chs->num) {
> +               err =3D -ERANGE;
> +               goto unlock;
> +       }
> +
> +       if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
> +           chs->params.ptp_rx   ||
> +           chs->params.xdp_prog ||
> +           priv->htb) {
> +               netdev_err(priv->netdev,
> +                          "Cloning channels with Port/rx PTP, XDP or HTB=
 is not supported\n");
> +               err =3D -EOPNOTSUPP;

I would have used a different error code here as EOFNOTSUPP usually
means the driver doesn't support queue API at all.

--=20
Thanks,
Mina

