Return-Path: <netdev+bounces-122397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF0960FC3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6EA1C20C4B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B701C68B9;
	Tue, 27 Aug 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMO3UTJk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EB1C689C
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770895; cv=none; b=QHPdN+s8UJW7vIl4qXTbEskC1es7ynAYZp0lra9T99kPsWLMLvc9c/NyTmFQSTm1D1OkN8QeifZlbvb32JSggbBCGF9RQIasMvI7lX0MGEAgxM9pHoBP0gdgNiWL6agEKYRQqVvr/EOXAXTePsUS6KTx1rBbkRkUhtYl2gIhCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770895; c=relaxed/simple;
	bh=dkGA16NjgTkEId0Q94d9kQ8NxcSBHwNP0zYMEsY+hDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfCToLMIz+MAFcJcpiFY/5QrByZNMrDK/5FyDVOHwAF8qCqPssZ1k1qUP5uZJ0+X/suw8q/jvsP9fIACACWjQGSW72GVrvjNWOT3exgDyaoIbb53dQHl+mQgp6E6Z1Kl1HbfoD/THhO6NZzOjUwhaFcDAjRPsKoe5F2uK1ORALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMO3UTJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B98C4AF1C;
	Tue, 27 Aug 2024 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770894;
	bh=dkGA16NjgTkEId0Q94d9kQ8NxcSBHwNP0zYMEsY+hDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMO3UTJkUtx145wWXI7FgXWnxT9BDUeiOEDX8tEsXLGr+x65lHloufpntd0HngRwu
	 TjzamZ7p+rRjcniG8II3yiAvtGTSLztWUmTm3LI7vEmCPeHr4yuObiMG4HYx29R8bd
	 OSl3vqcf1L0VRPR/M3Gy6c+xhEa7D4P8+QkNjIKDFLJoQPiQNpCF9NStYKBr9flqD/
	 qZHQz8J2Y4zfLspCR6D9T2KvCTcx9siBbjze2hEuW8NsK5J7R70/vCICNVjozQsBrN
	 Xolj5nzcz+ptlaEQbm3zLWnOIv4iSI52nZiNgm6Ef7frusQvgFrZX6PAqL34hntlby
	 CPA6jTsH1itlQ==
Date: Tue, 27 Aug 2024 16:01:30 +0100
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
Message-ID: <20240827150130.GM1368797@kernel.org>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
 <20240815054656.2210494-4-tariqt@nvidia.com>
 <20240815134425.GD632411@kernel.org>
 <0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>

+ Dan

On Tue, Aug 27, 2024 at 11:14:10AM +0000, Cosmin Ratiu wrote:
> On Thu, 2024-08-15 at 14:44 +0100, Simon Horman wrote:
> > On Thu, Aug 15, 2024 at 08:46:49AM +0300, Tariq Toukan wrote:
> [...]
> > > +	u32 last_bulk_id = 0;
> > > +	u64 bulk_query_time;
> > >  	u32 bulk_base_id;
> [...]
> > > +	xas_for_each(&xas, counter, U32_MAX) {
> [...]
> > > +		if (unlikely(counter->id >= last_bulk_id)) {
> > > +			/* Start new bulk query. */
> > > +			/* First id must be aligned to 4 when using bulk query. */
> > > +			bulk_base_id = counter->id & ~0x3;
> [...]
> > > +			bulk_query_time = jiffies;
> [...]
> > >  		}
> > 
> > Hi Cosmin and Tariq,
> > 
> > It looks like bulk_query_time and bulk_base_id may be uninitialised or
> > stale - from a previous loop iteration - if the condition above is not met.
> > 
> > Flagged by Smatch.
> 
> I believe this is a false positive. I snipped parts from the reply
> above to focus on the relevant parts:
> - last_bulk_id always starts at 0 so
> - the if branch will always be executed in the first iteration and
> - it will set bulk_query_time and bulk_base_id for future iterations.

Thanks,

I will look over this a second time with that in mind, my base assumption
being that you are correct.

> I am not familiar with Smatch, is there a way to convince it to
> interpret the code correctly (some annotations perhaps)?
> The alternatives are to accept the false positive or explicitly
> initialize those vars to something, which is suboptimal and would be
> working around a tooling failure.

I think that if it is a false positive it can simply be ignored.
I CCed Dan in case he has any feedback on that.


