Return-Path: <netdev+bounces-88105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292408A5BF2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F591C21A61
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45215625E;
	Mon, 15 Apr 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeN8pphw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43657823CE;
	Mon, 15 Apr 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211430; cv=none; b=uvsETZPLH95kLhCC5nRTWYQD+xzGM+yVv0KyXkjV3Pz+f1FFyfdx1h6q2vo+CrtSMuitiddCRTIk7NwGcDY+is4RXEvkeY8kuDAOJeYOZyHl92g8Oi6j5E0u8orYZDP0abK5s2+tSPUZS4Iic/ZdJq5xpBxibcxtKM/UR+c4IPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211430; c=relaxed/simple;
	bh=Um5/+vZJep1UNa+DWSW2O68e8djK4oq1dauDJrQxFlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2iV4bIeYeVx+ymgbgOcC9p7gwL4QdxlbjJ7aaU8XsqaHctQ2l+gk++fAhJLdEt2lFZZQucywZHvTl3OK1Xh6Zr+cgS2qkh5WUsvWE1wYLlM7Bnsy9vlpi1wZY2CkpW0xRTqFe3maJ4Hf9A/DwCtoBlr4YbbRzO7nafqOS0FrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeN8pphw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BAAC113CC;
	Mon, 15 Apr 2024 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713211428;
	bh=Um5/+vZJep1UNa+DWSW2O68e8djK4oq1dauDJrQxFlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeN8pphwPo9pyuy6eX3Kx7NTwQdd7ce02R/uhEt25x9IvBF5RYLnzk+Hcxz2UsC15
	 SlDgQ43dWzmvxl+1j1Anwjhar4wyyrsy7lUv6vT9jmNa3qMylQMFxuaU+JGBwslmVM
	 zl3k8D9bsKv5tZhNo2cw6173p83NpjklLAjKKe3CsqzgZ8IvJM4MKwGOvbvFmbOZj/
	 x6DaO3VB/wNALW1Xt8PkviPwvxJQbxtTjGpL1CARfeTpcoSktAu11MOC+r9ZxAqous
	 +mi6aTpOO/Zkd9JM0nDUglN0fEk/+TAEZy34P1knwrujuYd0yu4AqwhiS2j8j4GTj3
	 b4x6ao9CRo9Jg==
Date: Mon, 15 Apr 2024 21:03:43 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240415200343.GG2320920@kernel.org>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
 <20240415093638.123962-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415093638.123962-3-hengqi@linux.alibaba.com>

On Mon, Apr 15, 2024 at 05:36:36PM +0800, Heng Qi wrote:

...

> @@ -10229,6 +10230,61 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
>  	}
>  }
>  
> +static int dev_dim_profile_init(struct net_device *dev)
> +{
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	u32 supported = dev->ethtool_ops->supported_coalesce_params;
> +	struct netdev_profile_moder *moder;
> +	int length;
> +
> +	dev->moderation = kzalloc(sizeof(*dev->moderation), GFP_KERNEL);
> +	if (!dev->moderation)
> +		goto err_moder;
> +
> +	moder = dev->moderation;
> +	length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_eqe_profile);
> +
> +	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
> +		moder->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
> +		if (!moder->rx_eqe_profile)
> +			goto err_rx_eqe;
> +		memcpy(moder->rx_eqe_profile, rx_profile[0], length);
> +	}
> +	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
> +		moder->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
> +		if (!moder->rx_cqe_profile)
> +			goto err_rx_cqe;
> +		memcpy(moder->rx_cqe_profile, rx_profile[1], length);
> +	}
> +	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
> +		moder->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
> +		if (!moder->tx_eqe_profile)
> +			goto err_tx_eqe;
> +		memcpy(moder->tx_eqe_profile, tx_profile[0], length);
> +	}
> +	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
> +		moder->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
> +		if (!moder->tx_cqe_profile)
> +			goto err_tx_cqe;
> +		memcpy(moder->tx_cqe_profile, tx_profile[1], length);
> +	}

nit: Coccinelle suggests that the kzalloc()/memcpy() pattern above
     could be replaced with calls to kmemdup()

> +#endif
> +	return 0;
> +
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +err_tx_cqe:
> +	kfree(moder->tx_eqe_profile);
> +err_tx_eqe:
> +	kfree(moder->rx_cqe_profile);
> +err_rx_cqe:
> +	kfree(moder->rx_eqe_profile);
> +err_rx_eqe:
> +	kfree(moder);
> +err_moder:
> +	return -ENOMEM;
> +#endif
> +}
> +
>  /**
>   * register_netdevice() - register a network device
>   * @dev: device to register

...

