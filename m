Return-Path: <netdev+bounces-118850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B895309A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF97CB24767
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8121A00DF;
	Thu, 15 Aug 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPK9Dycm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E9176ADE
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729469; cv=none; b=qojbpqO/Sd18TsTzum6rgbeHBxeEyuv8/6QQWAnPnUqHchRAHTUceaGDRZBrZ/tmuIt5nZDb5uJFW8C6BfzrBVBGGg59oJi8ig6NSJRpIy+f0CtUx1frwbm7WuwSeZQUsGsqZhnGDr3Jk/OtKsjg7PDOE1+x1WesWwkiDvmKhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729469; c=relaxed/simple;
	bh=JAhkToa8kENM9IWhecnUHOPPD3QlivwP5mYXpK0KO0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpidP5u8HlbiYsGoicmMgOzy1uIhlNG23JyAJwxg/63Ycg4jaMFWGSPMG7ClFdcM8tnK3j8og3ZvH6a40w9xfRBxVuQOd4ten2XgqjlomneRwkIf209fdPypklFbYHHaSYJPeQVu4NQJvZI8e65Xw4Mr662liqhpXm2/RbmeTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPK9Dycm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FEFC32786;
	Thu, 15 Aug 2024 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729469;
	bh=JAhkToa8kENM9IWhecnUHOPPD3QlivwP5mYXpK0KO0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPK9Dycm8Vpj3zV7/0+5ojf7UWmU2lpvepQYRH+AGfZVBzGYgJuny3mOXZwfdvrmr
	 ePAOu7sXRUjFSrBkbFoSOI3BdsrOpmx+O/oyJHvrXYQRnVU3ddzNmXxpR1zUJPOY/0
	 xPvvtgUirbCiQn07/ywx4+Ri493nRH7ycg8vYe0C8c11DsX8LF58+Sy82mtxdFOPad
	 4xFqSCHkzdbOYS7ffqnl+CiB9iICh/5qkXpxNmEflquL53AcmaNq8gKL69G925sw+5
	 DdlgpuTCVJhTw4EvxFf7oIX/os6bQopvHTGUaYccGcyvn/IDgUULErN+OMeoHJP6Va
	 zJWaL9WZsrpSw==
Date: Thu, 15 Aug 2024 14:44:25 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <20240815134425.GD632411@kernel.org>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
 <20240815054656.2210494-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815054656.2210494-4-tariqt@nvidia.com>

On Thu, Aug 15, 2024 at 08:46:49AM +0300, Tariq Toukan wrote:

...

> +/* Synchronization notes
> + *
> + * Access to counter array:
> + * - create - mlx5_fc_create() (user context)
> + *   - inserts the counter into the xarray.
> + *
> + * - destroy - mlx5_fc_destroy() (user context)
> + *   - erases the counter from the xarray and releases it.
> + *
> + * - query mlx5_fc_query(), mlx5_fc_query_cached{,_raw}() (user context)
> + *   - user should not access a counter after destroy.
> + *
> + * - bulk query (single thread workqueue context)
> + *   - create: query relies on 'lastuse' to avoid updating counters added
> + *             around the same time as the current bulk cmd.
> + *   - destroy: destroyed counters will not be accessed, even if they are
> + *              destroyed during a bulk query command.
> + */
> +static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
> -	bool query_more_counters = (first->id <= last_id);
> -	int cur_bulk_len = fc_stats->bulk_query_len;
> +	u32 bulk_len = fc_stats->bulk_query_len;
> +	XA_STATE(xas, &fc_stats->counters, 0);
>  	u32 *data = fc_stats->bulk_query_out;
> -	struct mlx5_fc *counter = first;
> +	struct mlx5_fc *counter;
> +	u32 last_bulk_id = 0;
> +	u64 bulk_query_time;
>  	u32 bulk_base_id;
> -	int bulk_len;
>  	int err;
>  
> -	while (query_more_counters) {
> -		/* first id must be aligned to 4 when using bulk query */
> -		bulk_base_id = counter->id & ~0x3;
> -
> -		/* number of counters to query inc. the last counter */
> -		bulk_len = min_t(int, cur_bulk_len,
> -				 ALIGN(last_id - bulk_base_id + 1, 4));
> -
> -		err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len,
> -					     data);
> -		if (err) {
> -			mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> -			return;
> -		}
> -		query_more_counters = false;
> -
> -		list_for_each_entry_from(counter, &fc_stats->counters, list) {
> -			int counter_index = counter->id - bulk_base_id;
> -			struct mlx5_fc_cache *cache = &counter->cache;
> -
> -			if (counter->id >= bulk_base_id + bulk_len) {
> -				query_more_counters = true;
> -				break;
> +	xas_lock(&xas);
> +	xas_for_each(&xas, counter, U32_MAX) {
> +		if (xas_retry(&xas, counter))
> +			continue;
> +		if (unlikely(counter->id >= last_bulk_id)) {
> +			/* Start new bulk query. */
> +			/* First id must be aligned to 4 when using bulk query. */
> +			bulk_base_id = counter->id & ~0x3;
> +			last_bulk_id = bulk_base_id + bulk_len;
> +			/* The lock is released while querying the hw and reacquired after. */
> +			xas_unlock(&xas);
> +			/* The same id needs to be processed again in the next loop iteration. */
> +			xas_reset(&xas);
> +			bulk_query_time = jiffies;
> +			err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len, data);
> +			if (err) {
> +				mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> +				return;
>  			}
> -
> -			update_counter_cache(counter_index, data, cache);
> +			xas_lock(&xas);
> +			continue;
>  		}
> +		/* Do not update counters added after bulk query was started. */

Hi Cosmin and Tariq,

It looks like bulk_query_time and bulk_base_id may be uninitialised or
stale - from a previous loop iteration - if the condition above is not met.

Flagged by Smatch.

> +		if (time_after64(bulk_query_time, counter->cache.lastuse))
> +			update_counter_cache(counter->id - bulk_base_id, data,
> +					     &counter->cache);
>  	}
> +	xas_unlock(&xas);
>  }

...

