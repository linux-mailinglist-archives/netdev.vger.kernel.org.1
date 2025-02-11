Return-Path: <netdev+bounces-165256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CCA3149B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAF93A14A2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC99253B6E;
	Tue, 11 Feb 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIzlXA/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D5261594
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300797; cv=none; b=WKWqgD5qamMk4DxywnO/UAHsdoWgdqAI8eUqiC6SchMS3qi6W4Riw4hKp6d4GESi7CeZTbUKShqhtWXU2pP8nomQXhR3DEXqzRSCsUqfepDbALTybl/s0GjzivGPFUj1x4O3pYvR46byo5LTXg+YeyYu/HXILeSkT+G+kAS9eIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300797; c=relaxed/simple;
	bh=cfZjxEBAhMOnlY1B01FhQU5UOel14f8XEBuCQZBgaNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgYcDHOf3mTR3h2Gb1f2eT865PngdEjBb7y2do5T3hSe13frCW4YDTkt+AX4jypMmdJak4cpWBB//ISuwO/xHfSGtpRTHWe3UaVkbLKLHxTj8VuD4S/nRFmoMRQLiWg2ojgKnTetO03IfWx7+2FybdyvXkDySXRIDBb2bbWPnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIzlXA/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB0C4CEDD;
	Tue, 11 Feb 2025 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739300796;
	bh=cfZjxEBAhMOnlY1B01FhQU5UOel14f8XEBuCQZBgaNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HIzlXA/AdT2o7pkpQ70Hey0Os40enATW6DJ9Jbdqaghk3xKNpTT2YnoiZYBy8t3sy
	 9xUjr1ciEoVyySiYwo8ikMSXEKeFYP6HCed8QjgCdm7y+Y6FPuCOpJ2GlQd5n+ACO7
	 RQmXjwi+0UAcOSmpAE+41rPGsxcD4OCmP0MInnHzUS+manS502YWW1i6Mg842qkXDQ
	 tojlcwA0SRrodqaD12y8nfvPrIm9WGAQrIdQECzhKoPY8ClUGxXqSKE1lsq1bT2B1A
	 UB2VAj9r8vrJ1QYRL4EJlAITGimVf75ggV0OmHAYBjC3xbDl8MA4PHbON/m+Fyw5/p
	 z+gFkhqGY3PSA==
Date: Tue, 11 Feb 2025 11:06:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
Message-ID: <20250211110635.16a43562@kernel.org>
In-Reply-To: <18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-2-kuba@kernel.org>
	<76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
	<20250206150434.4aff906b@kernel.org>
	<18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 20:01:08 +0200 Tariq Toukan wrote:
> > The pool_size is just the size of the cache, how many unallocated
> > DMA mapped pages we can keep around before freeing them to system
> > memory. It has no implications for correctness.  
> 
> Right, it doesn't hurt correctness.
> But, we better have the cache size derived from the overall ring buffer 
> size, so that the memory consumption/footprint reflects the user 
> configuration.
> 
> Something like:
> 
> ring->size * (priv->frag_info[i].frag_stride for i < num_frags).
> 
> or roughly ring->size * MLX4_EN_EFF_MTU(dev->mtu).

These calculations appear to produce byte count?
The ring size is in *pages*. Frag is also somewhat irrelevant, given
that we're talking about full pages here, not 2k frags. So I think 
I'll go with:

	pp.pool_size =
		size * DIV_ROUND_UP(MLX4_EN_EFF_MTU(dev->mtu), PAGE_SIZE);

