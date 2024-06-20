Return-Path: <netdev+bounces-105243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBEA9103C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60ED12825B4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59C1A4F3D;
	Thu, 20 Jun 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViTjoJCM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D217BB05;
	Thu, 20 Jun 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885545; cv=none; b=ubf9Fzo3KumKrmXlkuw1IFGVA7Pszv5ZrDqeSVaWtQ0dDO4c+pZS+YGKofziDKnWObQH7M9s5OiVRrB7mBdbOsLBWAxOQvAMVXjH20J+0y0Q1f1+/DYWjUeS7N3KFz0cJyW7DTjVE1saxbD2y9yBxAybQRkKwUYsGqGIXNx+ZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885545; c=relaxed/simple;
	bh=9gA6x7ThvEsEIIx6P68uSU5DybT9VjDdOuHsNP/DR+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFVUqBTrrxqi/gVXN5IpTwSpgFO+zubHYkOaFNCLax7s9z+eliK3cWEJ27rF09fo8KbvsEdmqg3s2PNvSM/YllZ8RhzF+81YTvMh1mi4BUcDY59EhT2FFoJCUGOD1jzO8M6paVnBCDKDeU6vo+R/tAtsqZ99v/tmvrViVLMqM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViTjoJCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E679BC32781;
	Thu, 20 Jun 2024 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718885543;
	bh=9gA6x7ThvEsEIIx6P68uSU5DybT9VjDdOuHsNP/DR+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViTjoJCMYh9uWMXO/ABL2W/1as8Eqr6+gdLFZtxiQq37pRTh6EHYfi9mWTnfLcJaH
	 QN3hL+N8LYovC68f4tZTABqBhDezdPj6h1Fh/c4HD/OkY2BvyaGidrTqasaj/6gUFm
	 k+6lHEFxQ829k8uTmwXUOEHPNBTpnu0ZGSQGhK904LvH7rriE9u5loatBvzqf60zYH
	 0mmrFpP1SlD0nE4lor/O1YJuAzS/qbMDXfU9vhP1xjjqvNfSavFjKGnfInAe36JxT4
	 sWLYaVaefxJE+2je8dDbbxQPcKSENuYRBIBsP14mcz6VQKM/YU4QgPQZGe/P5xgGdQ
	 aWDZkG0z2XbWQ==
Date: Thu, 20 Jun 2024 13:12:15 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 2/5] dim: make DIMLIB dependent on NET
Message-ID: <20240620121215.GB959333@kernel.org>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618025644.25754-3-hengqi@linux.alibaba.com>

On Tue, Jun 18, 2024 at 10:56:41AM +0800, Heng Qi wrote:
> DIMLIB's capabilities are supplied by the dim, net_dim, and
> rdma_dim objects, and dim's interfaces solely act as a base for
> net_dim and rdma_dim and are not explicitly used anywhere else.
> rdma_dim is utilized by the infiniband driver, while net_dim
> is for network devices, excluding the soc/fsl driver.
> 
> In this patch, net_dim relies on some NET's interfaces, thus
> DIMLIB needs to explicitly depend on the NET Kconfig.
> 
> The soc/fsl driver uses the functions provided by net_dim, so
> it also needs to depend on NET.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


