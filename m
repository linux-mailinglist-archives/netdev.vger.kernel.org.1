Return-Path: <netdev+bounces-236988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83DC42ED1
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE35B4E0597
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47C1DED57;
	Sat,  8 Nov 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcL8aPM6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DD14884C
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762615308; cv=none; b=O50BM80fHnNsm0/gOqW+5NlH6sHHbR1DXXLe1fpMZ9phrbsecPWUfJCvSgsTBQbsaaVyFcLRt0YHAH2op3YOnfhGcvhjj/caqjJlg4H115/YvQLf6xQzdIKVYt2/VEa0itUAwRscX7VpQPEddqV5/SG/9RkSLRhodMOQghwodiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762615308; c=relaxed/simple;
	bh=VP9OHcfqYgHtwlQzDrlW0wejPk6ULAFUw92nuf8FCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX/7N+ZYx+E/MPVAOoJynf4sZOHohC/GD/QwAWe8H5c0QJ2sqw621CQ61NYNmH1ezM0VKqCbQzGtkICnlTwCov8F7LfhOAFCxBYQW+HiyccDfbquq7bz7XjmrXRIzJuc1JRRwOK6o8Th7dqOFx2M9O5Ld3pfM63Km+LgufUAqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcL8aPM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54D3C4CEF5;
	Sat,  8 Nov 2025 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762615308;
	bh=VP9OHcfqYgHtwlQzDrlW0wejPk6ULAFUw92nuf8FCCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcL8aPM6RnshElCPuaHl5l5kZxKSlcOTXOyyLltAmhkHcO/3y0o8phB5SsagBxZGF
	 tw84jxRxLC/LtY7IPY+KhkQDdT9u+kurZftRU0KZIT/CXweIgpPBAnbxnXE1tGaz/S
	 BZCoMkrj94M3StyBfHvWIquC/ttYIQJZbdUyANDc/485KsaIhOM85uQASKbWu2cxij
	 6hdwAbGbcJQFkh9I6tK8niih13XrKTvOL2/rHDTWEg7x8IkFprjB1/2UGgUhHNdQZV
	 7/q+29oXzKuRD21PkI231R76LTE4hmdXUne0W0X+QgH9+uo5Ze0AIXzso1cDYOyRk9
	 SpDpOO6u+KxEw==
Date: Sat, 8 Nov 2025 15:21:43 +0000
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com, Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 2/3] net/mlx5: MPFS, add support for dynamic
 enable/disable
Message-ID: <aQ9gB4lCBaK19bRo@horms.kernel.org>
References: <20251107000831.157375-1-saeed@kernel.org>
 <20251107000831.157375-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107000831.157375-3-saeed@kernel.org>

On Thu, Nov 06, 2025 at 04:08:30PM -0800, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> MPFS (Multi PF Switch) is enabled by default in Multi-Host environments,
> the driver keeps a list of desired unicast mac addresses of all vports
> (vfs/Sfs) and applied to HW via L2_table FW command.
> 
> Add API to dynamically apply the list of MACs to HW when needed for next
> patches, to utilize this new API in devlink eswitch active/in-active uAPI.
> 
> Issue: 4314625
> Change-Id: I185c144319e514f787811f556888e1b727bdbf35

nit: the issue and Change-Id should be dropped when upstreaming patches.

> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 115 +++++++++++++++---
>  .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 ++
>  2 files changed, 107 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c

...

> @@ -148,30 +151,34 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)

...

> +	if (mpfs->enabled) {
> +		err = alloc_l2table_index(mpfs, &index);
> +		if (err)
> +			goto hash_del;
> +		err = set_l2table_entry_cmd(dev, index, mac);
> +		if (err)
> +			goto free_l2table_index;
> +		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
> +			      l2addr->node.addr, l2addr->index);

nit: the following patch updates the line above to:

			      l2addr->node.addr, index);

     I don't think that change belongs in the following patch.

...

> +int mlx5_mpfs_enable(struct mlx5_core_dev *dev)
> +{
> +	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
> +	struct l2table_node *l2addr;
> +	struct hlist_node *n;
> +	int err = 0;
> +
> +	if (!mpfs)
> +		return -ENODEV;
> +
> +	mutex_lock(&mpfs->lock);
> +	if (mpfs->enabled)
> +		goto out;
> +	mpfs->enabled = true;
> +	mlx5_core_dbg(dev, "MPFS enabling mpfs\n");
> +
> +	mlx5_mpfs_foreach(l2addr, n, mpfs) {
> +		u32 index;
> +
> +		err = alloc_l2table_index(mpfs, &index);
> +		if (err) {
> +			mlx5_core_err(dev, "Failed to allocated MPFS index for %pM, err(%d)\n",
> +				      l2addr->node.addr, err);
> +			goto out;
> +		}
> +
> +		err = set_l2table_entry_cmd(dev, index, l2addr->node.addr);
> +		if (err) {
> +			mlx5_core_err(dev, "Failed to set MPFS l2table entry for %pM index=%d, err(%d)\n",
> +				      l2addr->node.addr, index, err);
> +			free_l2table_index(mpfs, index);
> +			goto out;
> +		}
> +
> +		l2addr->index = index;
> +		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
> +			      l2addr->node.addr, l2addr->index);
> +	}
> +out:
> +	mutex_unlock(&mpfs->lock);

I realise that error handling can be complex at best, and particularly
so when configuration ends up being partially applied. But I am wondering
if the cleanup here is sufficient.

In a similar vein, I also note that although this function returns an
error, it is ignored by callers which are added by the following patch.
Likewise for mlx5_esw_fdb_drop_create() which is also added by the
following patch.

> +	return err;
> +}

...

