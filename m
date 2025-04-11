Return-Path: <netdev+bounces-181656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC27A85FDD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0719A7813
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6AD1E2847;
	Fri, 11 Apr 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8R2pS/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6576F30F
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379948; cv=none; b=YGtQq6npskK8w/WQFh3682y6l4Hw6Jy7rIOxsYhA0sHy1IrkzufbH6d8TODPh57npVFIC0FbsSJjo8doZIN31xwl4fWkbAd5a8KHIagAIbuvYMqsCdPUZC8T9gQw81/rQECgUNMvRy+kAlT8z6pd1iBtibl8qJ3qOrGDjcoKbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379948; c=relaxed/simple;
	bh=W/OyPlQVd1SzO3TMQXiXo+rtL7/pwgBsXBelgfi4Rog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4bEizDb1nhVCFTdFCcfjbAn2A3kiuK4iayO4CUQAmToDPe8XqCUASCYziKiXmiGqbythAVtfKRN0wrf4pAr6EU4NdOgwlAkSQFuV4Eo452Pk+YETxE3lhD2hmzuDr1B+YQrdryPr1/BHOT68140VjDit2OQNceO/J9GS6+JqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8R2pS/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B0C4CEE2;
	Fri, 11 Apr 2025 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379947;
	bh=W/OyPlQVd1SzO3TMQXiXo+rtL7/pwgBsXBelgfi4Rog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8R2pS/CSSEkqJSK5UIEnE3BVXieYSp/95seEwJ4QqkNg/Vx2sia9iVWVLHXJ8GZ8
	 AUOIU+thVGf0NpactGhdnPJF05F6VRGQFEt1gzydm9i9iG5Nt4TQ11nzNp0vtdCyJY
	 4+Y3jB+KuXppSNow0IqrKgT6uw9NZtQt1vxFOP7//Y5szbkGhnAh5AvuWsOSrH5tJv
	 Sxc/hwWDZIoqc2esYK2u86BaiWWHN1O/lca95yApvsC2o01576DdSAoLvypgpmYTgM
	 wLYUESUwsXbsIszMTCtjz7KigRCmLPWpSQY6rlRIh3S0ETFlysWwXW2F/vgRDMFikY
	 ortVvi4RJWR4A==
Date: Fri, 11 Apr 2025 14:59:04 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/2] espintcp: remove encap socket caching to avoid
 reference leak
Message-ID: <20250411135904.GG395307@horms.kernel.org>
References: <cover.1744206087.git.sd@queasysnail.net>
 <fba712655d0ec4003b28e432e5ba43d20f6d750f.1744206087.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba712655d0ec4003b28e432e5ba43d20f6d750f.1744206087.git.sd@queasysnail.net>

On Wed, Apr 09, 2025 at 03:59:57PM +0200, Sabrina Dubroca wrote:
> The current scheme for caching the encap socket can lead to reference
> leaks when we try to delete the netns.
> 
> The reference chain is: xfrm_state -> enacp_sk -> netns
> 
> Since the encap socket is a userspace socket, it holds a reference on
> the netns. If we delete the espintcp state (through flush or
> individual delete) before removing the netns, the reference on the
> socket is dropped and the netns is correctly deleted. Otherwise, the
> netns may not be reachable anymore (if all processes within the ns
> have terminated), so we cannot delete the xfrm state to drop its
> reference on the socket.
> 
> This patch results in a small (~2% in my tests) performance
> regression.
> 
> A GC-type mechanism could be added for the socket cache, to clear
> references if the state hasn't been used "recently", but it's a lot
> more complex than just not caching the socket.

Less is more :)

> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>

