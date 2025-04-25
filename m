Return-Path: <netdev+bounces-186091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A466A9D112
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D25D7AD963
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CF21A427;
	Fri, 25 Apr 2025 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asHGJjoU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E744217647;
	Fri, 25 Apr 2025 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607832; cv=none; b=AOs8wJm5Nht4FQNKc3ZIWKvdQwOVyFpG0+tnPatLvTuvR6490t1jPFWIQ3cdFo4e+vwkRjRVsv5j/fLEMLmCC7f2aPFAaEoSTh/acC3qwbOF+tpuOYmtqwveoPv1OHSOwE7NUTnnCm6d6/fcMJ7C26Y+Jq0R1y6Uk0jwYi88rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607832; c=relaxed/simple;
	bh=8b1jSipE8vvTKtYxEIerxYV+fQ6mJiSmPoltSWnlsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhMrNIePr36IJScs2oCBpxjChiUmQZhBJcpbtC1UgqkNKjDyWBxCcN8zVfwR2tTVqnQISExkVrwIbib0mpRePEcIzIv5o9j2FL6rI9kXBUkfM5e25iLYz9gzPB/zMyhDR2QohsT0GgIvwOBoooxEI2b3xiD3Fgtn4QCj7y0MfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asHGJjoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE1CC4CEE4;
	Fri, 25 Apr 2025 19:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607831;
	bh=8b1jSipE8vvTKtYxEIerxYV+fQ6mJiSmPoltSWnlsY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asHGJjoUtY3RrySnOFcQZSI/W0Kma/L3xi8Pq2sVUQ7Pho6sR15Hc3VCCplaLPz2l
	 SQtHBKauAs6Ern4DTfsAfSUB6L4esqCR4DHL2ILGKodHKyy5L5Z92xKM4lwhuYL6dk
	 5xZsj4agG3s/us9uLHRPGKCaYALUY6ymNGslA7vSI1HUCTsJIXHdsvQxx2361oPaCR
	 0gZw/rm2TTBfq1kkj6xRdaFNGUhHtHa8vUDScJKcSYiT6ee3vM3si2InsECmjMmiNW
	 P70X3oUmAQou4jsDl/VIPqcmiEg7XR/3VYS+dBmuEeKaxbaya5Ih3NKlO8TFFgWfAM
	 EJ3qJzwiB5Z9A==
Date: Fri, 25 Apr 2025 09:03:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aAvcltpVFqRmcfM5@slm.duckdns.org>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <aAqHKWU2xFk2X2ZD@slm.duckdns.org>
 <aAtfe1-ncE_oxt9H@harry>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAtfe1-ncE_oxt9H@harry>

On Fri, Apr 25, 2025 at 07:10:03PM +0900, Harry Yoo wrote:
> > I don't exactly know what that should look like but maybe a
> > simplified version of sl*b serving power of two sizes should do or maybe it
> > needs to be smaller and more adaptive. We'd need to collect some data to
> > decide which way to go.
> 
> I'm not sure what kind of data we need — maybe allocation size distributions,
> or more profiling data on workloads that contend on percpu allocator's locks?

Oh yeah, mostly distributions of memory allocation sizes across different
systems and workloads.

Thanks.

-- 
tejun

