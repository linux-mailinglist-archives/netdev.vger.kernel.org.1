Return-Path: <netdev+bounces-126235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C679702B7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1CC1F21790
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5C15CD77;
	Sat,  7 Sep 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlndL1es"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415B15C149
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725719291; cv=none; b=VF8I28C/PjmIWuWaxh21zhOxhA7pP6987IMTJOq7iUsPfrYe411cME210WR1PMnpcRAHiRDdUYSeg7dr9pfkazzQQQMJ+aB69DVJuB7LUlvjhgds5RgJV0nHqhQp5KtIBvG5dIDV/e2XNidpvxpwbYeyje5/cAUXUJKCXpnkEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725719291; c=relaxed/simple;
	bh=loETkMZF7Njukh5D7RGsH6S10/aaXJVqvOITcgZ6hsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwKX6yYkOCKX9jceWPsZqBMa9/awZsJ4mWnOH6ge7eofUuS3kvT3nyD+snF3Dc24Etpgx/tixwq/ddYgDIQj0jDl4sLrhOFtRixvd78EKMn9N1nQxV4wRrlAZg2WpaznSxYx6Lv0ANsABkxH3YmV7G10lPWMj90jlGuILOxZDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlndL1es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766FC4CEC2;
	Sat,  7 Sep 2024 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725719291;
	bh=loETkMZF7Njukh5D7RGsH6S10/aaXJVqvOITcgZ6hsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlndL1es5S3zRTt+N1dDcKmpk5k+460DIUDjtSMl0t73pbDDOHGPX0Ckz6TBVUKyy
	 fSGZY9kkgh5uQgem7dkTMZCX8h5h0I6att6Mr9HUlbtdMUwQ1hsJsiMtyV9lb14lqE
	 rvnsF0ll/hEUyovKnGgQ6qcEEP8DcMAtOW3HlZ7EfJOqPTjxW98RuuAyn/5AFEERSe
	 w8aKU0QYHJrLKu+pRJ8K9oipBOvo2jW/e+b9HHg6ueVe8F4g+tmuI6fNRwWhBV6Uzg
	 dyFPDmsxQhMbEYIJ0qIP1rc/rUBOsmrqbFlar+beow+xx8APDu5tAdORvw/g9Yea2R
	 trA1p04dEs9kA==
Date: Sat, 7 Sep 2024 15:28:06 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Subject: Re: [net-next V3 11/15] net/mlx5: HWS, added memory management
 handling
Message-ID: <20240907142806.GS2097826@kernel.org>
References: <20240906215411.18770-1-saeed@kernel.org>
 <20240906215411.18770-12-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906215411.18770-12-saeed@kernel.org>

On Fri, Sep 06, 2024 at 02:54:06PM -0700, Saeed Mahameed wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Added object pools and buddy allocator functionality.
> 
> Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

...

> +static struct mlx5hws_pool_resource *
> +hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
> +			     u32 fw_ft_type)
> +{
> +	struct mlx5hws_cmd_ste_create_attr ste_attr;
> +	struct mlx5hws_cmd_stc_create_attr stc_attr;
> +	struct mlx5hws_pool_resource *resource;
> +	u32 obj_id;
> +	int ret;
> +
> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> +	if (!resource)
> +		return NULL;
> +
> +	switch (pool->type) {
> +	case MLX5HWS_POOL_TYPE_STE:
> +		ste_attr.log_obj_range = log_range;
> +		ste_attr.table_type = fw_ft_type;
> +		ret = mlx5hws_cmd_ste_create(pool->ctx->mdev, &ste_attr, &obj_id);
> +		break;
> +	case MLX5HWS_POOL_TYPE_STC:
> +		stc_attr.log_obj_range = log_range;
> +		stc_attr.table_type = fw_ft_type;
> +		ret = mlx5hws_cmd_stc_create(pool->ctx->mdev, &stc_attr, &obj_id);
> +		break;
> +	default:
> +		return NULL;

Sorry, but this now appears to leak resource. Maybe:

		goto free_resource;

Or:

		ret = -EINVAL;

> +	}
> +
> +	if (ret) {
> +		mlx5hws_err(pool->ctx, "Failed to allocate resource objects\n");
> +		goto free_resource;
> +	}
> +
> +	resource->pool = pool;
> +	resource->range = 1 << log_range;
> +	resource->base_id = obj_id;
> +
> +	return resource;
> +
> +free_resource:
> +	kfree(resource);
> +	return NULL;
> +}

...

-- 
pw-bot: cr

