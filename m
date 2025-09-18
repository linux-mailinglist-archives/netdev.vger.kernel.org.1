Return-Path: <netdev+bounces-224220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7CB8270E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3721E1C27847
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0C192598;
	Thu, 18 Sep 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5OCRe7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AB148832
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156401; cv=none; b=FvvBkKozLjvMflyklTZVl6255EIy/MwJnDbKsmNekzXGoVflyPzWllKSCtk1B6XXOqQOqHjoH+utMJS8lCiyV5Ci58qtnf5KocNBFrVc3nYOC+qZ3vPcUjUMFF6jVvgnCJJ/YcXeKV2xx7UjdHt7qaiv/3tufpRmvJNOIwtZ2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156401; c=relaxed/simple;
	bh=lNGmY3o1ccmZCWS4874pPo4nNHHvU2+63aqEDcNOe50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQGHCxo9U3uTmnld7enzmHCviM3aGODi6jfEG68aHwPOxj8Js2pdZxw+h+/IlocMTLTtvksgI/D1ymWOdWr78ze308/uVIIwL1yLosxWteIVpMZ8LmP7P+c9Ada+BU4fd77kkr1T6soN752ANhAhMmX5erLUMoEYUBNIkTqrjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5OCRe7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF572C4CEE7;
	Thu, 18 Sep 2025 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758156400;
	bh=lNGmY3o1ccmZCWS4874pPo4nNHHvU2+63aqEDcNOe50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5OCRe7f97f9q2GvQL96b8tJOFvbI7MsmOZYfL4R69lL4n0/qZzzM4tI/NA6fRrqh
	 N3V75EJ4q1S4JEBq1a5VjNiQNx/HL21tkQDB6qqdsmAsF5p+m/J24lUgCRbC2SZBsm
	 vYPF3wQcxWV0fVVnZpNv2lMvop3R8JgddXNEORGIJdREyFgyV1mMFhJ3RPfvBRUARq
	 M5qq9uMvQ95602uEp3B0jeFT/9ado+g4ydlMGLz4a2FYsrU+vWE6aK+Woa/zkGyt4P
	 oTF/sSMW5nO1fmKN1ULrRmAHBjDcz7NgREDWjTmiDOIX+ykqF5oI1VPKDSezlGAW9G
	 sQoY/LVOVQ8Ow==
Date: Wed, 17 Sep 2025 17:46:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v3 3/4] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
Message-ID: <20250917174638.238fa5fc@kernel.org>
In-Reply-To: <20250916191257.13343-4-vadim.fedorenko@linux.dev>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 19:12:56 +0000 Vadim Fedorenko wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce support for querying the Ports Phy Histogram Configuration
> Register (PPHCR) to retrieve RS-FEC histogram bin ranges. The ranges
> are stored in a static array and will be used to map histogram counters
> to error levels.
> 
> The actual RS-FEC histogram statistics are not yet reported in this
> commit and will be handled in a downstream patch.

> @@ -6246,8 +6246,17 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>  	if (!priv->channel_stats)
>  		goto err_free_tx_rates;
>  
> +	priv->fec_ranges = kcalloc_node(ETHTOOL_FEC_HIST_MAX,
> +					sizeof(*priv->fec_ranges),
> +					GFP_KERNEL,
> +					node);

Why bother allocating his on the device node? We have no reason to
believe user will pin eth process that reads these stats to the node
where the device is :\

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index aae0022e8736..476689cb0c1f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -1490,8 +1490,63 @@ static void fec_set_corrected_bits_total(struct mlx5e_priv *priv,
>  				      phy_corrected_bits);
>  }
>  
> +#define MLX5E_FEC_RS_HIST_MAX 16
> +
> +static u8
> +fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv,
> +			     const struct ethtool_fec_hist_range **ranges)
> +{
> +	struct mlx5_core_dev *mdev = priv->mdev;
> +	u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
> +	u32 in[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
> +	int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
> +	u8 active_hist_type, num_of_bins;
> +
> +	memset(priv->fec_ranges, 0,
> +	       ETHTOOL_FEC_HIST_MAX * sizeof(*priv->fec_ranges));
> +	MLX5_SET(pphcr_reg, in, local_port, 1);
> +	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
> +		return 0;
> +
> +	active_hist_type = MLX5_GET(pphcr_reg, out, active_hist_type);
> +	if (!active_hist_type)
> +		return 0;
> +
> +	num_of_bins = MLX5_GET(pphcr_reg, out, num_of_bins);
> +	if (WARN_ON_ONCE(num_of_bins > MLX5E_FEC_RS_HIST_MAX))

why does MLX5E_FEC_RS_HIST_MAX exist?
We care that bins_cnt <= ETHTOOL_FEC_HIST_MAX - 1
or is there something in the interface that hardcodes 16?

> +		return 0;

> @@ -2619,3 +2675,4 @@ unsigned int mlx5e_nic_stats_grps_num(struct mlx5e_priv *priv)
>  {
>  	return ARRAY_SIZE(mlx5e_nic_stats_grps);
>  }
> +

spurious change

