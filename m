Return-Path: <netdev+bounces-122410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69E96125D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBCA1C23A3D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11D1CF28D;
	Tue, 27 Aug 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdlQaoq9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B811C8FCF
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772481; cv=none; b=ZP2iBqR0/lWix29ubxfNQWILdmd1GQ76VtjxpYGD9gFLUXKP/avo2CM0vVAZyVqZq4LvNz2rbuNPXUaKNaR1BQB/02l4VEo8Bglep7kLCOv49ddsurVeRSHXI3rPdv9hsVFnXzwjRlN51g5RkGWUgR2olswEXT06AkhyO3xtL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772481; c=relaxed/simple;
	bh=U/yk2jLzvm8jFGGfrYlGHFHln3jyaLm67J7dn8EvEdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkaQrHGhGTmWGVzeVZCOZGRIJFgomPHK810xiPJWwqHFkZDthq0gI8K4PLVocvDD6qCqL6R853l5rbD95/9KwyUOzc+9289ZcgH+Ed9LD/bBa43JjPIVpPi8CP3Ac0sX/WfKWP+iZ2ns73Z1kcZ73AG7Fpf18bXy8+83UOkkbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdlQaoq9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428178fc07eso46976265e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724772477; x=1725377277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia07+GjgaF5oLBanaD8yREYYcT00opYh2W/hZ+alLOs=;
        b=xdlQaoq9oTGXMOn9iUiMv3PUntwLv4wCG7wWjEJ9ZYDr4ZH6Iwi1grJjoIpBZn//a9
         gs+0DjWztfbULQFDU4G6/6Vdcd54uaHsmx36Mzmdx5Xk6ewbIJmv8zKbdkmuzvU0DpJ7
         rWIgWhu94jb5ljkrOfEDZMbH04o2Dq4r4qekqDqW6BpsKMolWJjWAib6B2y0TCVeg4O5
         VEm1CHOaCl9SOxnNrJkFzqLGDhis1XHhREyRmq9Lqlf8rSe8/+ZuwsgFysINu0S6n8Bz
         FunZYuppnJVXPLKdrwKhZ1Sc3Uxm9T+6bsuz5azkI4dRhHu51l4oWK5dn1rDg0JHoDjJ
         yxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772477; x=1725377277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia07+GjgaF5oLBanaD8yREYYcT00opYh2W/hZ+alLOs=;
        b=TuQApmkTp/1jMCDjM3I0lNKaY1O5ntQFKboO/Ac88X6m8xXEideCSATj1AMzKpX+nz
         WbGJ73qf8kR6A7Ptho2yvqsqIsrZ90DreWsYFaqM7RA6ykeRAe9sD8rJLtHpUsKoJVyx
         ghfd925wkAEnBY+RJTmJ3InUP7S5me6XDdNPOoYXXXJxfDOSzdhj0wN7jci90/0CBDIa
         2qm6N1XDtn8AUMKpw5qhO+Cvrcj2k7ElJIcUE4YxZBTcBHkXGLKh+UFLmkLj8qaznzBQ
         Z6D8/IKbQjOhIJd/dCwBEdvzYzKRLKhFOAbZ04Qa1MwTfDctYPdDfG6/iA5Cxz+7aLQP
         SFlA==
X-Forwarded-Encrypted: i=1; AJvYcCUCb2yeRaoCCJIC+sNHQQ76d3YzHftdI2v1B5U2GNz2UxQvtL1k79jSEQdKg5K60mhjvXukxTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvgmdik93ebWlLIQ2V8Eru/HEAInVvGJNnXGJa5r7Mj9Vh8WYk
	osnNR32aw8gIeaU2QKvV969krz5idzAnSu+go3Zigw0mVkqpTf3Igl8V/ph+YwY=
X-Google-Smtp-Source: AGHT+IGRh/gNC7yLGyFZwQuMHEeo/AqPDyI+aRrt5Xrourx+X9iuzGhnwROcT83JCUaupsXs7dAeNg==
X-Received: by 2002:a05:600c:3547:b0:426:6000:565a with SMTP id 5b1f17b1804b1-42acd56028bmr88173115e9.16.1724772476400;
        Tue, 27 Aug 2024 08:27:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9d9561b1sm19923305e9.0.2024.08.27.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:27:56 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:27:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <fcecb18a-1a30-400d-b8ec-1806d856d145@stanley.mountain>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
 <20240815054656.2210494-4-tariqt@nvidia.com>
 <20240815134425.GD632411@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815134425.GD632411@kernel.org>

On Thu, Aug 15, 2024 at 02:44:25PM +0100, Simon Horman wrote:
> On Thu, Aug 15, 2024 at 08:46:49AM +0300, Tariq Toukan wrote:
> 
> ...
> 
> > +/* Synchronization notes
> > + *
> > + * Access to counter array:
> > + * - create - mlx5_fc_create() (user context)
> > + *   - inserts the counter into the xarray.
> > + *
> > + * - destroy - mlx5_fc_destroy() (user context)
> > + *   - erases the counter from the xarray and releases it.
> > + *
> > + * - query mlx5_fc_query(), mlx5_fc_query_cached{,_raw}() (user context)
> > + *   - user should not access a counter after destroy.
> > + *
> > + * - bulk query (single thread workqueue context)
> > + *   - create: query relies on 'lastuse' to avoid updating counters added
> > + *             around the same time as the current bulk cmd.
> > + *   - destroy: destroyed counters will not be accessed, even if they are
> > + *              destroyed during a bulk query command.
> > + */
> > +static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
> >  {
> >  	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
> > -	bool query_more_counters = (first->id <= last_id);
> > -	int cur_bulk_len = fc_stats->bulk_query_len;
> > +	u32 bulk_len = fc_stats->bulk_query_len;
> > +	XA_STATE(xas, &fc_stats->counters, 0);
> >  	u32 *data = fc_stats->bulk_query_out;
> > -	struct mlx5_fc *counter = first;
> > +	struct mlx5_fc *counter;
> > +	u32 last_bulk_id = 0;
> > +	u64 bulk_query_time;
> >  	u32 bulk_base_id;
> > -	int bulk_len;
> >  	int err;
> >  
> > -	while (query_more_counters) {
> > -		/* first id must be aligned to 4 when using bulk query */
> > -		bulk_base_id = counter->id & ~0x3;
> > -
> > -		/* number of counters to query inc. the last counter */
> > -		bulk_len = min_t(int, cur_bulk_len,
> > -				 ALIGN(last_id - bulk_base_id + 1, 4));
> > -
> > -		err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len,
> > -					     data);
> > -		if (err) {
> > -			mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> > -			return;
> > -		}
> > -		query_more_counters = false;
> > -
> > -		list_for_each_entry_from(counter, &fc_stats->counters, list) {
> > -			int counter_index = counter->id - bulk_base_id;
> > -			struct mlx5_fc_cache *cache = &counter->cache;
> > -
> > -			if (counter->id >= bulk_base_id + bulk_len) {
> > -				query_more_counters = true;
> > -				break;
> > +	xas_lock(&xas);
> > +	xas_for_each(&xas, counter, U32_MAX) {
> > +		if (xas_retry(&xas, counter))
> > +			continue;
> > +		if (unlikely(counter->id >= last_bulk_id)) {
> > +			/* Start new bulk query. */
> > +			/* First id must be aligned to 4 when using bulk query. */
> > +			bulk_base_id = counter->id & ~0x3;
> > +			last_bulk_id = bulk_base_id + bulk_len;
> > +			/* The lock is released while querying the hw and reacquired after. */
> > +			xas_unlock(&xas);
> > +			/* The same id needs to be processed again in the next loop iteration. */
> > +			xas_reset(&xas);
> > +			bulk_query_time = jiffies;
> > +			err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len, data);
> > +			if (err) {
> > +				mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
> > +				return;
> >  			}
> > -
> > -			update_counter_cache(counter_index, data, cache);
> > +			xas_lock(&xas);
> > +			continue;
> >  		}
> > +		/* Do not update counters added after bulk query was started. */
> 
> Hi Cosmin and Tariq,
> 
> It looks like bulk_query_time and bulk_base_id may be uninitialised or
> stale - from a previous loop iteration - if the condition above is not met.
> 
> Flagged by Smatch.

I don't see this warning on my end.  For me what Smatch says is that
last_bulk_id is 0U so the "counter->id >= last_bulk_id" condition is true.
Smatch doesn't warn about the uninitialized varabiable because it appears to
smatch to be in dead code.  In other words smatch is doing the correct thing but
for the wrong reasons.  :/

I've tested on the released code and I'm not seing this warning.

regards,
dan carpenter

