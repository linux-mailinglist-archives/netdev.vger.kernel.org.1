Return-Path: <netdev+bounces-137466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9019A685F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F6284763
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E91F8936;
	Mon, 21 Oct 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlF6z4iS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CC1E908A;
	Mon, 21 Oct 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513566; cv=none; b=kn6mFcPGWVKP0K080F3J+YypSvQyiGksIenKxGwt1+EyjYQlE+t0K3/+fmuOXCNno50lLStooWxp9KUPNbccRXzx2OOFetEdxUv2RLwVyHjBY7kZRSlcXoLylfyPG1CRl0WcakxmsABdaAjXnp65B3NrYXxGlr+UmkIFPyQeIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513566; c=relaxed/simple;
	bh=cx/tLvH9CPRgHxEav9sPf4o/gHFa4lb5PR3fe7KBDA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY6CAl9W/BWYRSUSOt5fVrAizfMff3rRAG4k/kZV55w9lA8cUE/UuAhK/iQPL7lG4YxXG5RDx+7OGPcjC6xAFJ5KeOc+zyNoNY6leoZYjNR6dsJEO2qL12FQGSxzlND6K3MRjnIkMd7tYQbDAvYhJV/R3h3UkLd+iit7qAnn624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlF6z4iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F5EC4CEC3;
	Mon, 21 Oct 2024 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513565;
	bh=cx/tLvH9CPRgHxEav9sPf4o/gHFa4lb5PR3fe7KBDA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlF6z4iSE4m4KO6vx5hubfGjBlUBCwj1PXsxIH+/Xcop+vfX86LaDkpRtod2cq+MH
	 xH+iCQ7icStQOSTZEWdc7fwJ2/vdFJWRYkY8zGc56jciyDi9wjqf3ULXVX0bpDynPR
	 TABkMjgXNxkDAXPztzvpPj4Y0rCfErFGxe9c9p5bryS3zWbd8G4u9ot6FCw+FIbdfv
	 Pi3m1RlJ4bGU9Z8TSdjIx1fidU6H8IECafN4z0VFaBT+I+dzNoeq1cC5K/+tD2XSYa
	 CY3zwTqSII+OWs2FChK3B0e9JOcWROv1/xtstboToEqnH7FR+5JCEpEFWZpZ1FpbJG
	 deqz1OZtUifHg==
Date: Mon, 21 Oct 2024 13:26:01 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <20241021122601.GI402847@kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021061023.2162701-1-0x1207@gmail.com>

On Mon, Oct 21, 2024 at 02:10:23PM +0800, Furong Xu wrote:
> In case the non-paged data of a SKB carries protocol header and protocol
> payload to be transmitted on a certain platform that the DMA AXI address
> width is configured to 40-bit/48-bit, or the size of the non-paged data
> is bigger than TSO_MAX_BUFF_SIZE on a certain platform that the DMA AXI
> address width is configured to 32-bit, then this SKB requires at least
> two DMA transmit descriptors to serve it.
> 
> For example, three descriptors are allocated to split one DMA buffer
> mapped from one piece of non-paged data:
>     dma_desc[N + 0],
>     dma_desc[N + 1],
>     dma_desc[N + 2].
> Then three elements of tx_q->tx_skbuff_dma[] will be allocated to hold
> extra information to be reused in stmmac_tx_clean():
>     tx_q->tx_skbuff_dma[N + 0],
>     tx_q->tx_skbuff_dma[N + 1],
>     tx_q->tx_skbuff_dma[N + 2].
> Now we focus on tx_q->tx_skbuff_dma[entry].buf, which is the DMA buffer
> address returned by DMA mapping call. stmmac_tx_clean() will try to
> unmap the DMA buffer _ONLY_IF_ tx_q->tx_skbuff_dma[entry].buf
> is a valid buffer address.
> 
> The expected behavior that saves DMA buffer address of this non-paged
> data to tx_q->tx_skbuff_dma[entry].buf is:
>     tx_q->tx_skbuff_dma[N + 0].buf = NULL;
>     tx_q->tx_skbuff_dma[N + 1].buf = NULL;
>     tx_q->tx_skbuff_dma[N + 2].buf = dma_map_single();
> Unfortunately, the current code misbehaves like this:
>     tx_q->tx_skbuff_dma[N + 0].buf = dma_map_single();
>     tx_q->tx_skbuff_dma[N + 1].buf = NULL;
>     tx_q->tx_skbuff_dma[N + 2].buf = NULL;
> 
> On the stmmac_tx_clean() side, when dma_desc[N + 0] is closed by the
> DMA engine, tx_q->tx_skbuff_dma[N + 0].buf is a valid buffer address
> obviously, then the DMA buffer will be unmapped immediately.
> There may be a rare case that the DMA engine does not finish the
> pending dma_desc[N + 1], dma_desc[N + 2] yet. Now things will go
> horribly wrong, DMA is going to access a unmapped/unreferenced memory
> region, corrupted data will be transmited or iommu fault will be
> triggered :(
> 
> In contrast, the for-loop that maps SKB fragments behaves perfectly
> as expected, and that is how the driver should do for both non-paged
> data and paged frags actually.
> 
> This patch corrects DMA map/unmap sequences by fixing the array index
> for tx_q->tx_skbuff_dma[entry].buf when assigning DMA buffer address.
> 
> Tested and verified on DWXGMAC CORE 3.20a
> 
> Reported-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> Fixes: f748be531d70 ("stmmac: support new GMAC4")
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Thanks for the very thorough explanation, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

