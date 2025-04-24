Return-Path: <netdev+bounces-185307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E47A99BD2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEE27A92A9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C961223DDD;
	Wed, 23 Apr 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R/jHDlrK"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADEB1F584E
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745449178; cv=none; b=OoP1HeWRUxnmaYddHjPlTMU3GHxiB5Q8oNLmDrPeKhJtdAW1uHPlwaTrwP8KpSKnxhmRbK1RjpfmvTl2u7ZqvdnoxjDjHiIUtFjzHLacv216uH3SsD3NDWsLotmYydqZ0wEu7Lwx6rmp+MMZrhulzKU18ypeA2oRALIFJG+f97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745449178; c=relaxed/simple;
	bh=ANM1L0fguovtc5G10RZhCVZ6sfOMQzacN9PCVs7IQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl0vkColsnF2cBNUPL04wf0Jur93KTIcOLAQJj5vDuA6MhPmEuU4IeTlK6Ykwlh5nZYDDAcFvd+Nxo/JO9vDgE4ly1yafy4puG8No4zPllTyKDeohqSlGQ14Ojkyp+1RKlQ1byfZtEtWLSpLwMnly2lpki2s5k27d7+q6e2+v7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R/jHDlrK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 15:59:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745449163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FD1aCXz6k1Jg0AnKxmnZHvXUq4o3mf+YIXA3Fl6SqoY=;
	b=R/jHDlrKZgVW0GCW96rhyiqI6YnD5xtDMGwoo1oNLRj2fVRKDrh6KmAIm7qD90e8JubDzX
	ua56Bp6ukaev27wDIN48iLTDca/GfUdS5y6ny4gwJtK+9RnXs3H3fqd+QI4l3374GuaBtv
	5aNZfIGGaoVtYBpacUKmrF7iPdrzK3Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Eric Dumazet <edumazet@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <agazegt7js4jrbbng2di33xggfswxgrdrojoiqh4vaqxxmdidj@zmyzkgfuhykl>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <20250422181022.308116c1@kernel.org>
 <ha4sqstdknwvvubs2g33r3itrabepz2jwlr3ksrbjdlgjnbuel@appekpf6ffud>
 <20250423153046.54d135f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423153046.54d135f2@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 23, 2025 at 03:30:46PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 15:16:56 -0700 Shakeel Butt wrote:
> > > > -	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > > +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> > > > +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > >  		/*
> > > > -		 * In case of unlikely failure to lock percpu stock_lock
> > > > -		 * uncharge memcg directly.
> > > > +		 * In case of larger than batch refill or unlikely failure to
> > > > +		 * lock the percpu stock_lock, uncharge memcg directly.
> > > >  		 */  
> > > 
> > > We're bypassing the cache for > CHARGE_BATCH because the u8 math 
> > > may overflow? Could be useful to refocus the comment on the 'why'
> > 
> > We actually never put more than MEMCG_CHARGE_BATCH in the cache and thus
> > we can use u8 as type here. Though we may increase the batch size in
> > future, so I should put a BUILD_BUG_ON somewhere here.
> 
> No idea if this matters enough to deserve its own commit but basically
> I was wondering if that behavior change is a separate optimization.
> 
> Previously we'd check if the cache was for the releasing cgroup and sum
> was over BATCH - drain its stock completely. Now we bypass looking at
> the cache if nr_pages > BATCH so the cgroup may retain some stock.

Yes indeed there is a little bit behavior change as you have explained.
The older behavior (fully drain if nr_pages > BATCH) might be due to
single per-cpu memcg cache limitation and in my opinion is problematic
in some scenarios. If you see commit 5387c90490f7 ("mm/memcg: improve
refill_obj_stock() performance"), a very similar behavior for objcg
cache was having a performance impact and was optimized by only allowing
the drain for some code paths. With multi-memcg support, I think we
don't need to worry about it. Multi-objcg per-cpu cache is also on my
TODO list.


