Return-Path: <netdev+bounces-131987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655199016A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2597F1C22F0E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B81487E9;
	Fri,  4 Oct 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlSjBxrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC9155751
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038048; cv=none; b=Ct5ZDkPxGxqCLEmwIsQksXZZXEiKcGIPTXmPm1EnodGvtHBoBrSvNbnz/S7ENDc26XEyUGdfcGePC3w3d6j6sjKEz1W5xQrAob5qvHyXMAaT3SFqyV4FNMT+p2z8FO418/vfNrxa195rz5LzKOmlh6c81Aj2iOnYkbPZjPOg0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038048; c=relaxed/simple;
	bh=ks+CUFcE5DLWif5+j+sZOMG0yOPJH+18unPLqA4q6mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCmCPt2ilB5BhQUkRahAjUmFtS2+nKMXJPyJmj8szBQV7KyI5s98MCQKUlc0nM8YKTz7NEqu0r+Mc5s+dxSc772tmVOwvrSI5Tulzp7k16CY1hut+k4FYbkcp6DqELPn3wmtcJwP7GPDrOoX1s1MeX8mF2yNjEG7k90cYqfW1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlSjBxrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770FEC4CECC;
	Fri,  4 Oct 2024 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728038047;
	bh=ks+CUFcE5DLWif5+j+sZOMG0yOPJH+18unPLqA4q6mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlSjBxrvBFxIxI86RQ7Q3YmyOw9FWCp+dCvmI5EMeH5/LdJXSHVEbz/lGH85aBMCA
	 jGn0uPJMyL32E8R0x4gzJwLsZ0RImXc4aXFXNkJWoJ/INyD3XE0roWZVYrP2nlZTfi
	 oHiAg1pMux7Zlob4NBH5wWxY45fe4VLuMRK7SI/Y9NSvKb8WFpd9KO4H69SOiCSNm8
	 Eg6mXQF8tb8gn72slJM3JfCBYlRfXGWxE+lIKVvJLzBqXe17r7nZy14aVXt0SWHU3+
	 xIXfmkclzKST62D9QN/fN8+GHHupp8x5xujdQmrxL3LWuo1XOEdUF+6uIuJQosEmar
	 fR7Vp/VhJ+NCA==
Date: Fri, 4 Oct 2024 11:34:03 +0100
From: Simon Horman <horms@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next V2 3/6] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <20241004103403.GC1310185@kernel.org>
References: <20241001103709.58127-1-tariqt@nvidia.com>
 <20241001103709.58127-4-tariqt@nvidia.com>
 <20241004085844.GA1310185@kernel.org>
 <66ccbb841794c98b91d9e8aba48b90c63caa45e7.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ccbb841794c98b91d9e8aba48b90c63caa45e7.camel@nvidia.com>

On Fri, Oct 04, 2024 at 09:32:11AM +0000, Cosmin Ratiu wrote:
> On Fri, 2024-10-04 at 09:58 +0100, Simon Horman wrote:
> > On Tue, Oct 01, 2024 at 01:37:06PM +0300, Tariq Toukan wrote:
> > > From: Cosmin Ratiu <cratiu@nvidia.com>
> > 
> > ...
> > 
> > > +/* Synchronization notes
> > > + *
> > > + * Access to counter array:
> > > + * - create - mlx5_fc_create() (user context)
> > > + *   - inserts the counter into the xarray.
> > > + *
> > > + * - destroy - mlx5_fc_destroy() (user context)
> > > + *   - erases the counter from the xarray and releases it.
> > > + *
> > > + * - query mlx5_fc_query(), mlx5_fc_query_cached{,_raw}() (user context)
> > > + *   - user should not access a counter after destroy.
> > > + *
> > > + * - bulk query (single thread workqueue context)
> > > + *   - create: query relies on 'lastuse' to avoid updating counters added
> > > + *             around the same time as the current bulk cmd.
> > > + *   - destroy: destroyed counters will not be accessed, even if they are
> > > + *              destroyed during a bulk query command.
> > > + */
> > > +static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
> > >  {
> > >  	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
> > > -	bool query_more_counters = (first->id <= last_id);
> > > -	int cur_bulk_len = fc_stats->bulk_query_len;
> > > +	u32 bulk_len = fc_stats->bulk_query_len;
> > > +	XA_STATE(xas, &fc_stats->counters, 0);
> > >  	u32 *data = fc_stats->bulk_query_out;
> > > -	struct mlx5_fc *counter = first;
> > > +	struct mlx5_fc *counter;
> > > +	u32 last_bulk_id = 0;
> > > +	u64 bulk_query_time;
> > >  	u32 bulk_base_id;
> > > -	int bulk_len;
> > >  	int err;
> > >  
> > > -	while (query_more_counters) {
> > > -		/* first id must be aligned to 4 when using bulk query */
> > > -		bulk_base_id = counter->id & ~0x3;
> > > -
> > > -		/* number of counters to query inc. the last counter */
> > > -		bulk_len = min_t(int, cur_bulk_len,
> > > -				 ALIGN(last_id - bulk_base_id + 1, 4));
> > > -
> > > -		err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len,
> > > -					     data);
> > > -		if (err) {
> > > -			mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> > > -			return;
> > > -		}
> > > -		query_more_counters = false;
> > > -
> > > -		list_for_each_entry_from(counter, &fc_stats->counters, list) {
> > > -			int counter_index = counter->id - bulk_base_id;
> > > -			struct mlx5_fc_cache *cache = &counter->cache;
> > > -
> > > -			if (counter->id >= bulk_base_id + bulk_len) {
> > > -				query_more_counters = true;
> > > -				break;
> > > +	xas_lock(&xas);
> > > +	xas_for_each(&xas, counter, U32_MAX) {
> > > +		if (xas_retry(&xas, counter))
> > > +			continue;
> > > +		if (unlikely(counter->id >= last_bulk_id)) {
> > > +			/* Start new bulk query. */
> > > +			/* First id must be aligned to 4 when using bulk query. */
> > > +			bulk_base_id = counter->id & ~0x3;
> > > +			last_bulk_id = bulk_base_id + bulk_len;
> > > +			/* The lock is released while querying the hw and reacquired after. */
> > > +			xas_unlock(&xas);
> > > +			/* The same id needs to be processed again in the next loop iteration. */
> > > +			xas_reset(&xas);
> > > +			bulk_query_time = jiffies;
> > > +			err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len, data);
> > > +			if (err) {
> > > +				mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> > > +				return;
> > >  			}
> > > -
> > > -			update_counter_cache(counter_index, data, cache);
> > > +			xas_lock(&xas);
> > > +			continue;
> > >  		}
> > > +		/* Do not update counters added after bulk query was started. */
> > 
> > Hi Cosmin and Tariq,
> > 
> > I'm sorry if it is obvious, but I'm wondering if you could explain further
> > the relationship between the if block above, where bulk_query_time (and
> > bulk_base_id) is initialised and if block below, which is conditional on
> > bulk_query_time.
> > 
> > > +		if (time_after64(bulk_query_time, counter->cache.lastuse))
> > > +			update_counter_cache(counter->id - bulk_base_id, data,
> > > +					     &counter->cache);
> > >  	}
> > > +	xas_unlock(&xas);
> > >  }
> > 
> > ...
> 
> Hi Simon. Of course.
> 
> The first if (with 'unlikely') is the one that starts a bulk query.
> The second if is the one that updates a counter's cached value with the
> output from the bulk query. Bulks are usually ~32K counters, if I
> remember correctly. In any case, a large number.
> 
> The first if sets up the bulk query params and executes it without the
> lock held. During that time, counters could be added/removed. We don't
> want to update counter values for counters added between when the bulk
> query was executed and when the lock was reacquired. bulk_query_time
> with jiffy granularity is used for that purpose. When a counter is
> added, its 'cache.lastuse' is initialized to jiffies. Only counters
> with ids between [bulk_base_id, last_bulk_id) added strictly before the
> jiffy when bulk_query_time was set will be updated because the hw might
> not have set newer counter values in the bulk result and values might
> be garbage.
> 
> I also have this blurb in the commit description, but it is probably
> lost in the wall of text:
> "
> Counters could be added/deleted while the HW is queried. This is safe,
> as the HW API simply returns unknown values for counters not in HW, but
> those values won't be accessed. Only counters present in xarray before
> bulk query will actually read queried cache values.
> "

Thanks, I did see that, but for some reason I didn't relate
it to the question I asked.

> 
> There's also a comment bit in the "Synchronization notes" section:
>  * - bulk query (single thread workqueue context)
>  *   - create: query relies on 'lastuse' to avoid updating counters
> added
>  *             around the same time as the current bulk cmd.

But this one I had missed.

> 
> Hope this clears things out, let us know if you'd like something
> improved.

Yes, thank you. It is clear now :)

