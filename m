Return-Path: <netdev+bounces-122406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24669961190
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528D01C23656
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA851C4EE8;
	Tue, 27 Aug 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exo5hrDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177951CFBC
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772046; cv=none; b=qgjB0PkScrnbe1u54y8toTfCkJtAoLIXpKcp22pSBWycrKhXckX5mr3UCAMks+gj4zzI9mOvR3FhrNCDJF0x4jqQVbE62l6F6NnBF8p+naKLxJ0O/4lVFBE5+5nIwwqsbBUPGSBDkzUtNqCGMy03+bhwO3nnIRL6REhD/23mIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772046; c=relaxed/simple;
	bh=QuhE+mOgNGyD70B2pr7owvI+xQGazPC7D2pi0kR4xGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBPphnrQUpDXLF3LzGOv9MOUl3qzRLZ10UIusCT6DqOCc2oBzWMZtw10A643r7kk0BTaPO9ENJB4TiFAnk6nZS7oWFeQXv//iFHZlSUDn6wYufoLLMum3/GJqL6G2PXntMu2lX4s+iezxnvZHnCjHxAURjpUPJdKXHA+iond1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exo5hrDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC235C4E697;
	Tue, 27 Aug 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724772045;
	bh=QuhE+mOgNGyD70B2pr7owvI+xQGazPC7D2pi0kR4xGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exo5hrDUu5hQOZzkJH3rlyNelbenAp5h25+G5K7W2g2QOn/FeetjJ2TOCqUCPCIGq
	 kkyO+VSZ3onb7Po8/1lnXYyxV2WtfTPm16uKlO5e93m3KRei7betqBlEEj6t3on0a1
	 wc3B3pEsCgkJaGBL8YhqE5BZ3ZACTPWdIXNRWMqK9GPpcRtMXk3bBOnLJHFwOi8fr4
	 AW4iCaMUyUDn39cak4ErFaB7N7b6O52KL4QzE2vMh5Vp+m+tPeQJtwXw+66TCtaa9O
	 nuJWxbUiFOltzfLF6vgvI55yOylaZ1RGaOrxDSnI2aNK2YM3N5kqpxJFPbPu4O9R7b
	 MipV4VmRba3UA==
Date: Tue, 27 Aug 2024 16:20:41 +0100
From: Simon Horman <horms@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <20240827152041.GN1368797@kernel.org>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
 <20240815054656.2210494-4-tariqt@nvidia.com>
 <20240815134425.GD632411@kernel.org>
 <0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>
 <20240827150130.GM1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827150130.GM1368797@kernel.org>

On Tue, Aug 27, 2024 at 04:01:30PM +0100, Simon Horman wrote:
> + Dan
> 
> On Tue, Aug 27, 2024 at 11:14:10AM +0000, Cosmin Ratiu wrote:
> > On Thu, 2024-08-15 at 14:44 +0100, Simon Horman wrote:
> > > On Thu, Aug 15, 2024 at 08:46:49AM +0300, Tariq Toukan wrote:
> > [...]
> > > > +	u32 last_bulk_id = 0;
> > > > +	u64 bulk_query_time;
> > > >  	u32 bulk_base_id;
> > [...]
> > > > +	xas_for_each(&xas, counter, U32_MAX) {
> > [...]
> > > > +		if (unlikely(counter->id >= last_bulk_id)) {
> > > > +			/* Start new bulk query. */
> > > > +			/* First id must be aligned to 4 when using bulk query. */
> > > > +			bulk_base_id = counter->id & ~0x3;
> > [...]
> > > > +			bulk_query_time = jiffies;
> > [...]
> > > >  		}
> > > 
> > > Hi Cosmin and Tariq,
> > > 
> > > It looks like bulk_query_time and bulk_base_id may be uninitialised or
> > > stale - from a previous loop iteration - if the condition above is not met.
> > > 
> > > Flagged by Smatch.
> > 
> > I believe this is a false positive. I snipped parts from the reply
> > above to focus on the relevant parts:
> > - last_bulk_id always starts at 0 so
> > - the if branch will always be executed in the first iteration and
> > - it will set bulk_query_time and bulk_base_id for future iterations.
> 
> Thanks,
> 
> I will look over this a second time with that in mind, my base assumption
> being that you are correct.

Thanks,

as both counter->id and last_bulk_id are unsigned I agree with your
analysis above, and that this is a false positive.

I don't think any further action is required at this time.
Sorry for the noise.

> 
> > I am not familiar with Smatch, is there a way to convince it to
> > interpret the code correctly (some annotations perhaps)?
> > The alternatives are to accept the false positive or explicitly
> > initialize those vars to something, which is suboptimal and would be
> > working around a tooling failure.
> 
> I think that if it is a false positive it can simply be ignored.
> I CCed Dan in case he has any feedback on that.
> 
> 

