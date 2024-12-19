Return-Path: <netdev+bounces-153203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2119F728F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2E188B998
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F87580C;
	Thu, 19 Dec 2024 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP7FOC/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28EB665;
	Thu, 19 Dec 2024 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575150; cv=none; b=YeBbzqxajoTx9o0/8hH7MaE0UJsTeiqgY8+xJUI/pAwvrBQ5CtBkPy/mJ1OWQ+Mi6A44PLwt1Z6610fs/bKov2YyC56/IvvErjxQJsjJeTDNQaLw8PghKgWTgLH/xS2BoBrHtNQZuUbzhpwr1TEjx4FYTb7qamtnmTDVhx2AzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575150; c=relaxed/simple;
	bh=+0NOtrmq8FIr/AUqm/wCu7PlSuiDYzL04GYeAsxctdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQr/LFORkGgXPyU3JRWWohW6NYCcZIkraRdGfPNaKK6jDl7XMHiGXVHsbol4Y2wysDt/+SyhjA2kH7LMd7qJcm08M8XxBfngmQb0QqOCwVCnSaIFejmV4t6VMBqIZdhi6VvlFG6DGXylswWt/NQYdEiTZjqwi6klZ6E3OhuNxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP7FOC/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F44C4CECD;
	Thu, 19 Dec 2024 02:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734575149;
	bh=+0NOtrmq8FIr/AUqm/wCu7PlSuiDYzL04GYeAsxctdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GP7FOC/c9bC46GSuks1u31vDzEauAtGxpgn/KwC0kytMHYsHnJgzRdpb88oT4fH3Z
	 SDxa5Yu7zSw4LYXZnl4H4JWtWBs3aGf/EDflZWfOTMb+ueYCA0c/Y3jcXHNrPqx3mA
	 XKXoWO+KxWRRXxRkiyF077QuHzz7bBu4ThE4kVPIe3FOv9gfILvTdJCGDqAjdzUcB4
	 qXav3vShQ111NmlKQMHvDA9L6gWvn5kX1qP8uKJcI5cK7PsSWKu7jKzQ6/Bz78EpWH
	 1gJRjWb05CBQNf9GcThE5GmChFdbtG8NkAqYsEJeqd3inowi7wItf2SHWLPyuoq0oK
	 Z16ZUu3KTvHEg==
Date: Wed, 18 Dec 2024 18:25:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241218182547.177d83f8@kernel.org>
In-Reply-To: <20241218144530.2963326-4-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:24 +0000 Taehee Yoo wrote:
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
> +		return -EOPNOTSUPP;

I think ethtool ops generally return -EINVAL when param not supported.
EOPNOTSUPP means entire op is not supported (again, that's just how
ethtool ops generally work, not a kernel-wide rule).

> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    hds_config_mod && BNXT_RX_PAGE_MODE(bp)) {

Looks like patch 4 adds this check in the core. I think adding the
check in the core can be a separate patch. If you put it before this
patch in the series this bnxt check can be removed?

I mean this chunk in the core:

+	hds_config_mod = old_hds_config != kernel_ringparam.tcp_data_split;
+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    hds_config_mod && dev_xdp_sb_prog_count(dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "tcp-data-split can not be enabled with single buffer XDP");
+		return -EINVAL;
+	}

It's currently in the hds-thresh patch but really it's unrelated 
to the threshold..

> +		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, false, false);
>  
> +	if (hds_config_mod) {
> +		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> +			bp->flags |= BNXT_FLAG_HDS;
> +		else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
> +			bp->flags &= ~BNXT_FLAG_HDS;
> +	}
> +
>  	bp->rx_ring_size = ering->rx_pending;
>  	bp->tx_ring_size = ering->tx_pending;
>  	bnxt_set_ring_params(bp);
> @@ -5354,6 +5374,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
>  				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>  				     ETHTOOL_COALESCE_USE_CQE,
> +	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
>  	.get_link_ksettings	= bnxt_get_link_ksettings,
>  	.set_link_ksettings	= bnxt_set_link_ksettings,
>  	.get_fec_stats		= bnxt_get_fec_stats,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index f88b641533fc..1bfff7f29310 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
>  		return -EOPNOTSUPP;
>  	}
> +	if (prog && bp->flags & BNXT_FLAG_HDS) {
> +		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> +		return -EOPNOTSUPP;
> +	}

And this check should also live in the core, now that core has access
to dev->ethtool->hds_config ? I think you can add this check to the
core in the same patch as the chunk referred to above.

