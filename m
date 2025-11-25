Return-Path: <netdev+bounces-241484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7EC846B1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C134667F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3021D5B0;
	Tue, 25 Nov 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMN9vTUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A116CA4E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065875; cv=none; b=coBdroAK7xOENbb+pL+5TaA477/052HdL0ZFucwGYpZLvTPYuDB96yFtdIfDRXF3UGFKS3CxvBgLkmxqTFHrKcm1E3xB6OC5Kp5VE+IIjfsu/jBWY9Y9tZg2vIBgyTM3LXivU2oypt2/RCRnjTAAV0CvOfbnFjPMKN1JSBwHD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065875; c=relaxed/simple;
	bh=o+Vfe0Fy4pq3eqIblH1sLFa/lglx2592/BxFmP59NsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obZewrFRzMAOOGaFRKNRBvquwqJKypMbaKvrCm1zE4IsxR1FyK9VZ5lZ9PsmTjjmHurnqqychA/l3WluqZgH+rgCsvY4GenIHNjhMb3koNwurBcoU1JhJ6b55RvRV09RH1zNr2/4GkNAqyOxdSZkm4vYQH6xfbumBZ4lSgKHT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMN9vTUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE3C4CEF1;
	Tue, 25 Nov 2025 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065874;
	bh=o+Vfe0Fy4pq3eqIblH1sLFa/lglx2592/BxFmP59NsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMN9vTUjvzZpDi2fIGWPjeImqIrBfjXFM+ZEAK4Dx4/dSE3xGwK5qJSZDUQF9mbSo
	 MdccPkck5lMpol/FoA/4tcbQKT8OxoMGfV7Rticcfbw//pDkao24w+Dwjn9UhwSeUo
	 lNCaCyQdI5rR6NB2Ar5Y/l3j5SvjG2abdvB/MvukcBuHfKVtEbiFxyFK3xv3K+QX0D
	 So+IVDOwGYLHUL9BSoF0clPjw58iS91tIWaOjjRdL9U2gRdJhgo92A3khD1Ev1DMHK
	 qf2MLzQ1o0+ulWpSeLGXKSkDMvwvQP8/MUtRV2fUHP2eixm7smrYr4uQnzsCE/QCXT
	 ZB0QsTAgF3cIw==
Date: Tue, 25 Nov 2025 10:17:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 6/6] ice: convert all ring stats to
 u64_stats_t
Message-ID: <aSWCT0eB79P6h18F@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:46PM -0800, Jacob Keller wrote:
> After several cleanups, the ice driver is now finally ready to convert all
> Tx and Rx ring stats to the u64_stats_t and proper use of the u64 stats
> APIs.
> 
> The final remaining part to cleanup is the VSI stats accumulation logic in
> ice_update_vsi_ring_stats().
> 
> Refactor the function and its helpers so that all stat values (and not
> just pkts and bytes) use the u64_stats APIs. The
> ice_fetch_u64_(tx|rx)_stats functions read the stat values using
> u64_stats_read and then copy them into local ice_vsi_(tx|rx)_stats
> structures. This does require making a new struct with the stat fields as
> u64.
> 
> The ice_update_vsi_(tx|rx)_ring_stats functions call the fetch functions
> per ring and accumulate the result into one copy of the struct. This
> accumulated total is then used to update the relevant VSI fields.
> 
> Since these are relatively small, the contents are all stored on the stack
> rather than allocating and freeing memory.
> 
> Once the accumulator side is updated, the helper ice_stats_read and
> ice_stats_inc and other related helper functions all easily translate to
> use of u64_stats_read and u64_stats_inc. This completes the refactor and
> ensures that all stats accesses now make proper use of the API.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks.

I do notice in the cover that you solicit alternate approaches to
lead to a yet cleaner solution. But I think that the approach you have
taken does significantly improve both the cleanliness and correctness
of the code. So even if we think of something better later, I think
this is a good step to take now.

Thanks for breaking out the series into bite-sized chunks, especially
the last few patches. It really helped me in my review.

Reviewed-by: Simon Horman <horms@kernel.org>

