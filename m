Return-Path: <netdev+bounces-161617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B151A22B96
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ED13A938C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CFF1B87CF;
	Thu, 30 Jan 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPVKRosm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8B1ADFE0
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232897; cv=none; b=eT0di7GFaRTyQbcx+vv9o/yCFFEYzIrJ34ZyraUcicKnH6e2bIsH7sGEhL+u17ORieGF0X29Pc6mt7d4WzaA/Y3Zqy105wcQyCAGGmu09PG2cmXNMyCN9TljO/lv4DwqyuzsISf6oCGdyHr/Aa4F6TSSy7bvvcyDLLpqFW5L16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232897; c=relaxed/simple;
	bh=fx5mvH5yM6eCNfabGNwHfvXE+wD6v7NjQ0aCgT82TEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnKWmkQ621n+1ayPb8iX6tPLHY1EZlaGi0a+HJn85Ou22yjUaeGVECwPR9hu+4lQ8oodZJZvkYIBfoFzghGHCk8MRRKOjHugn/4OlIVpITAFmWNuj9f1SfDQgaz8UTUi/oRFM5lBi1qEuWjwWE9kFOX1jmXwPqKb049q7Vaxg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPVKRosm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5992BC4CED2;
	Thu, 30 Jan 2025 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738232897;
	bh=fx5mvH5yM6eCNfabGNwHfvXE+wD6v7NjQ0aCgT82TEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPVKRosmmf237YNc0d0BX/E8A0y4DVGSnAD6nS9Xwsh3QRU9TRFSD/bF3gmp3Xtcu
	 mhYWVQ/vRb8mrZR1O2QGrsxG4o7GKtNqW7tdvWPgxPLAPz2glig01+ppAkoVLfn4jI
	 qqrM5pDUn2XsLCZ82XsB7C8yb2b3lJuUpENu8orGqWZ6PBoENYxRuBTTNb1UpOXCTi
	 wie6OcfnBniF+dWT5DAdQPed2LXiwjxYnUnWSQCKr2y3T2yMbZkAxqsumKynYJC/Sr
	 i0NF2HF/NwS+QRb9VFOirwIwRl6VT4S1Ky21m0Oxe5MxnKpPLBx10X/mOFh1i5vK4z
	 rWPVuOR4E+TIw==
Date: Thu, 30 Jan 2025 10:28:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
Message-ID: <20250130102813.GD113107@kernel.org>
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130031519.2716843-2-kuba@kernel.org>

On Wed, Jan 29, 2025 at 07:15:19PM -0800, Jakub Kicinski wrote:
> Some lwtunnels have a dst cache for post-transformation dst.
> If the packet destination did not change we may end up recording
> a reference to the lwtunnel in its own cache, and the lwtunnel
> state will never be freed.
> 
> Discovered by the ioam6.sh test, kmemleak was recently fixed
> to catch per-cpu memory leaks. I'm not sure if rpl and seg6
> can actually hit this, but in principle I don't see why not.
> 
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - fix spello in the comments
> v1: https://lore.kernel.org/20250129021346.2333089-2-kuba@kernel.org

Hi Jakub,

This fix looks correct to me. And I believe that the double allocation
issue raised at the cited link for v1 relates to an optimisation
rather than a bug, so this patch seems appropriate for net without
addressing that issue.

I am, however, unsure why the cited patches are used in the Fixes tags
rather than the patches that added use of the cache to the output
routines.

e.g. af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")

...

