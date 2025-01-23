Return-Path: <netdev+bounces-160547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AAA1A212
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99767188F3DA
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4820E009;
	Thu, 23 Jan 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiwVKsH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BF20DD7F
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629010; cv=none; b=JvV8L98wPFmTgSNsaDC4Gfn8iihO3tLL5pdstpnLoFqHrqUxHEhLr9CFGhz7cYtwH2u4uz9ltZN/iOUVki+1hndvTQxOeM074VF3UQr48sn2b8P24YSiFiTPQ75eNy9zh0BFsg6jCztUSkefA7mFnvZwQX0SgAVz5X/6IaMCXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629010; c=relaxed/simple;
	bh=dGRhaKURQTAwCQirlBEV5EhuzLWRx5fQon9AoRuGIDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3nDEHXNxc8KjEkkhScp6uFZR+cyrTPYPvDrvGDwUZcQflAWZRngm79uuH04xIKzKAKJbsxyxcn/uKtJuClrK12Si60PviRNaNqBKuVMAY/MgBAZ7R5h4Wngfugg7+PZCzyniwlREmQxV82k0id6yUXHGUOd6CAi1Ju4eV+RFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiwVKsH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340FC4CED3;
	Thu, 23 Jan 2025 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737629009;
	bh=dGRhaKURQTAwCQirlBEV5EhuzLWRx5fQon9AoRuGIDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiwVKsH/AVaSZwLZLendFLMiiTkBEo5T5DiMJcqD4Fbmf57g1aXZ+CcViBXN3Zseo
	 SCI9RiHYqODBKGcKA95E2UWMIbXB/HtK54C1jRtLyyUFIJSuEVvqQc1dQtU/DicjF0
	 vhEyhmWmAI3tk43BVLbXcEuI8obShDBPPZfZ9DCVkR4J9W+oz/XyE4kg3SwXNo03yI
	 UTJfQ7IdYtfXpn8+iGZxxhIPKDxjAO17JaBp7tDoMzFPdXm9LDkpgrqJnJ9/QwOvsI
	 iQZXJtw75sMpGZrWtkQsMNrPLegWK9YVm0a+Fis/iVlrUiEMxILbRoxLk3hijr1AvI
	 8K8P4BM/H9nkA==
Date: Thu, 23 Jan 2025 10:43:25 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
	jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v4 iwl-net 2/3] ice: gather page_count()'s of each frag
 right before XDP prog call
Message-ID: <20250123104325.GK395043@kernel.org>
References: <20250122151046.574061-1-maciej.fijalkowski@intel.com>
 <20250122151046.574061-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122151046.574061-3-maciej.fijalkowski@intel.com>

On Wed, Jan 22, 2025 at 04:10:45PM +0100, Maciej Fijalkowski wrote:
> If we store the pgcnt on few fragments while being in the middle of
> gathering the whole frame and we stumbled upon DD bit not being set, we
> terminate the NAPI Rx processing loop and come back later on. Then on
> next NAPI execution we work on previously stored pgcnt.
> 
> Imagine that second half of page was used actively by networking stack
> and by the time we came back, stack is not busy with this page anymore
> and decremented the refcnt. The page reuse algorithm in this case should
> be good to reuse the page but given the old refcnt it will not do so and
> attempt to release the page via page_frag_cache_drain() with
> pagecnt_bias used as an arg. This in turn will result in negative refcnt
> on struct page, which was initially observed by Xu Du.
> 
> Therefore, move the page count storage from ice_get_rx_buf() to a place
> where we are sure that whole frame has been collected, but before
> calling XDP program as it internally can also change the page count of
> fragments belonging to xdp_buff.
> 
> Fixes: ac0753391195 ("ice: Store page count inside ice_rx_buf")
> Reported-and-tested-by: Xu Du <xudu@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


