Return-Path: <netdev+bounces-237018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B5C433C6
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 20:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679843B2E90
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3631FF5F9;
	Sat,  8 Nov 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB5pClNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE425771
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630750; cv=none; b=bXElSWNt0embn0MZ/g0PDwGdUznDan0BCphjQfZnEm1odwIkCEE+59TFpHb7TxKkSjG2nqY2pHeUNs/vwQtEWrnlDk9nD3yOfUaIRy3k0/SN9GWVv76lgDMK6fqcB5VOTlWkhWMDbg5oZvpRDYDK+cAPd0yH2SZJdazdI4ReJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630750; c=relaxed/simple;
	bh=u8IwpErbNb91k81kVIvsvi0O1QyM5H1iLbUmNAxWxIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6DzhgxGhGWzuUn1502GZ0ZahAaWubvy7haQTd5guDNYUAYd/u9oAAuIWjCJQEOznWi2ZFWh1vlxOm7qE/6xwCPMQFsRdqOdKHdWLeoHvQnD+8Qo5PfkQUjB308mX2qulhDB+y4lRZF49Jn7p3+8Rpam6lXUBr5OYu9FFmPhGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB5pClNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B8C4CEF7;
	Sat,  8 Nov 2025 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762630748;
	bh=u8IwpErbNb91k81kVIvsvi0O1QyM5H1iLbUmNAxWxIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB5pClNVZrOUpUj3Yr2lOz0DuPH2+YJG3480UXMruVzPAJJozXigy2Ihb/jwryxFQ
	 Rb9q0baZvAWsSIxdbtAj/Z5RZ3idHiQw8xvDvQLtm3TvcqQUsSsJixoYaJ2ncDv+cY
	 3oMwmtxhVVPJlG1J2Ce7rcSXWgwqqRXNEeq1fk5ncdQWnHDPh9kjcO6Fwdg/zUMu4P
	 v9osTTpMo55KHL+wDNSDwfzMnbX0UQrcW/99umgjFGzwNPAZVFJbrMWunZXvziri87
	 KtrN5FMGPGuTK2wtVG3CiKH21NvYDnvHifSU+5pO+3KuRXa2/BI0sWsQuVXg3MSKoT
	 6IQL3yvvOldmQ==
Date: Sat, 8 Nov 2025 11:39:06 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com, Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 2/3] net/mlx5: MPFS, add support for dynamic
 enable/disable
Message-ID: <aQ-cWqrZr_1qkgCm@x130>
References: <20251107000831.157375-1-saeed@kernel.org>
 <20251107000831.157375-3-saeed@kernel.org>
 <aQ9gB4lCBaK19bRo@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aQ9gB4lCBaK19bRo@horms.kernel.org>

On 08 Nov 15:21, Simon Horman wrote:
>On Thu, Nov 06, 2025 at 04:08:30PM -0800, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> MPFS (Multi PF Switch) is enabled by default in Multi-Host environments,
>> the driver keeps a list of desired unicast mac addresses of all vports
>> (vfs/Sfs) and applied to HW via L2_table FW command.
>>
>> Add API to dynamically apply the list of MACs to HW when needed for next
>> patches, to utilize this new API in devlink eswitch active/in-active uAPI.
>>
>> Issue: 4314625
>> Change-Id: I185c144319e514f787811f556888e1b727bdbf35
>
>nit: the issue and Change-Id should be dropped when upstreaming patches.

Removed in V3. 

>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 115 +++++++++++++++---
>>  .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 ++
>>  2 files changed, 107 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
>
>...
>
>> @@ -148,30 +151,34 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)
>
>...
>
>> +	if (mpfs->enabled) {
>> +		err = alloc_l2table_index(mpfs, &index);
>> +		if (err)
>> +			goto hash_del;
>> +		err = set_l2table_entry_cmd(dev, index, mac);
>> +		if (err)
>> +			goto free_l2table_index;
>> +		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
>> +			      l2addr->node.addr, l2addr->index);
>
>nit: the following patch updates the line above to:
>
>			      l2addr->node.addr, index);
>
>     I don't think that change belongs in the following patch.
>

You are right, still in V3 also I will fix this.

>...
>
>> +int mlx5_mpfs_enable(struct mlx5_core_dev *dev)
>> +{
>> +	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
>> +	struct l2table_node *l2addr;
>> +	struct hlist_node *n;
>> +	int err = 0;
>> +
>> +	if (!mpfs)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&mpfs->lock);
>> +	if (mpfs->enabled)
>> +		goto out;
>> +	mpfs->enabled = true;
>> +	mlx5_core_dbg(dev, "MPFS enabling mpfs\n");
>> +
>> +	mlx5_mpfs_foreach(l2addr, n, mpfs) {
>> +		u32 index;
>> +
>> +		err = alloc_l2table_index(mpfs, &index);
>> +		if (err) {
>> +			mlx5_core_err(dev, "Failed to allocated MPFS index for %pM, err(%d)\n",
>> +				      l2addr->node.addr, err);
>> +			goto out;
>> +		}
>> +
>> +		err = set_l2table_entry_cmd(dev, index, l2addr->node.addr);
>> +		if (err) {
>> +			mlx5_core_err(dev, "Failed to set MPFS l2table entry for %pM index=%d, err(%d)\n",
>> +				      l2addr->node.addr, index, err);
>> +			free_l2table_index(mpfs, index);
>> +			goto out;
>> +		}
>> +
>> +		l2addr->index = index;
>> +		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
>> +			      l2addr->node.addr, l2addr->index);
>> +	}
>> +out:
>> +	mutex_unlock(&mpfs->lock);
>
>I realise that error handling can be complex at best, and particularly
>so when configuration ends up being partially applied. But I am wondering
>if the cleanup here is sufficient.
>

Cleanup is sufficient, the use of index -1 is an indication of the entry was
not successfully written to HW, so only if index is positive we will delete
it from hw on cleanup. 

>In a similar vein, I also note that although this function returns an
>error, it is ignored by callers which are added by the following patch.
>Likewise for mlx5_esw_fdb_drop_create() which is also added by the
>following patch.
>

This is best effort as there could be a lot of l2 entries and we might run
out of space, we don't want to cripple the whole system just because one VF
mac didn't make it to the mpfs table, the approach here is similar to
set_rx_mode ndo expectation, which this function also serves.


