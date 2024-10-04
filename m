Return-Path: <netdev+bounces-131923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D098FF27
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADBDB21B78
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7C314373F;
	Fri,  4 Oct 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX/EtesE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF331411DE
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032328; cv=none; b=M8pIUcpJoEMvZsLcA8r7v9c63TGfK3o/x3/8IX9XKkCE4wBl6ZtAIJPddUXqI8UF9D2TCUgPPJuOKEqmfqsGxJQhps8wEM8iDKVcozXv0um/48H9MJN711blFXcES0DVM2JKuX9VtvwtTJBp/3mmLZ6zGgk70HfNy6e6o7KZOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032328; c=relaxed/simple;
	bh=UGUMZS56XnEZ/WzX+1Eq6zTe8RSNwKLkE+NmX0YMinE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzrHhyxeMqQ5nD4P8wbqBlmxKbNb/P6099UIIhEXQerhL7gMDxezYyuqZhSfdXF2iuOjW9GbS3zOp1eywVGM7rkOAGYkm33txohFLUEeayf6x8V5y4/nm5ssrPphHP41vPWpdWN2m79MR+bRTRsZPbJXVKLH9npYPjD5943TLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX/EtesE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB89C4CEC6;
	Fri,  4 Oct 2024 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728032328;
	bh=UGUMZS56XnEZ/WzX+1Eq6zTe8RSNwKLkE+NmX0YMinE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZX/EtesEpbIUCS/zC4cX/UhsP846optAl4PAFgppUoJKIa4vEsJqDo8otWbDcDv/n
	 Vllgc37Nu7YTMfiDqQ5iYPhguW8AA+UfVGEsGDXoEvbOPtAshOPr/DDn5XgwsJKmyu
	 F4Eo4JeiBkPwDgtnUtBk01ZVpdpfLp97vDmgnIM8Hp6fIxtfux0I7XJwsXdHpkI1i9
	 PsuNVK0fuiPsiCytkUV73d4YJi8ab5l9Vx795DOHpvMSXGGiDKr4Lt6JdddrhHEiE5
	 Cxi2vp7sQVLV9yG19zXmAbdoCKzfYkfW9RY5YURGw3I3sV43FuG0m9Dlf/n1Wjt5zs
	 HpwI5pFgry6PQ==
Date: Fri, 4 Oct 2024 09:58:44 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 3/6] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <20241004085844.GA1310185@kernel.org>
References: <20241001103709.58127-1-tariqt@nvidia.com>
 <20241001103709.58127-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001103709.58127-4-tariqt@nvidia.com>

On Tue, Oct 01, 2024 at 01:37:06PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>

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

I'm sorry if it is obvious, but I'm wondering if you could explain further
the relationship between the if block above, where bulk_query_time (and
bulk_base_id) is initialised and if block below, which is conditional on
bulk_query_time.

> +		if (time_after64(bulk_query_time, counter->cache.lastuse))
> +			update_counter_cache(counter->id - bulk_base_id, data,
> +					     &counter->cache);
>  	}
> +	xas_unlock(&xas);
>  }

...

