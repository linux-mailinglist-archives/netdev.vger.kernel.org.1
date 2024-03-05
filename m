Return-Path: <netdev+bounces-77335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FC8714E9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0E1F23139
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E381803A;
	Tue,  5 Mar 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcoV2b2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91877405F2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613771; cv=none; b=nE9z/onLqcnzHGumVRP5FeL4K9rDc8FwRLqfDgandjjykPNQr0oexbxZhtWfU9veAgsRUQRonuV8O0QPnwni9SGHsGvWWkAxImO3KxqUTKOxGQKOVbgnrR0c0CLUD9HfxOcxllG7ZEx/X7sCVzgEHCV5LhporvmNY5faQadeZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613771; c=relaxed/simple;
	bh=kInWDpNJYdfASvcKKWYy8LXQBr7YKwbhHEgqjG3jnvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRZWGu6NfNcQFkPJuYU539bH43JyZMLiNiwKmdt6tqR84ORsbcmW1JYdT3HBMeIwRM1QnEu5fihzHPEd9LkCCRk06nQ2HLJaQ+vtEiXqygEL8iXgVb/AegiLNMroGNH1QjERaqEI1cdEJkW299fO4eXlRT/zzbIMmXQs3Zdd+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcoV2b2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E663AC43390;
	Tue,  5 Mar 2024 04:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709613771;
	bh=kInWDpNJYdfASvcKKWYy8LXQBr7YKwbhHEgqjG3jnvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IcoV2b2nEN4QhqoRRAID8/+yd3rUkvgGP8CxOfQQPGNNev9d4pBmWfMI0G9Z4h01k
	 6M2dZDCrr7O4a0TpXEwpZiu8Tj8kJ4F+Zsj52wqitZauGfucGy8NLUWGH8xo0H14r9
	 0BaCpgzmloyyutdankAhLnGj8tO53kF/LHIkYlAZ6UMTFiYxM6c5QNFn0ZpzmmxPAY
	 5SIEdEOiQDnKjMCd2D60zedVG8AplsNm7kABlOu+aIGKkTJ5rQ4w2CXpifeLJCg8Ee
	 pVAUE3knS0gN9u/iF4Ns4nZGWIPqJmZZ0ubt0ivfB9e8Hk/Icmsuwza6ZY51yXCS9R
	 PmMmXZQEheu8Q==
Date: Mon, 4 Mar 2024 20:42:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geoff Levand <geoff@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v1] ps3_gelic_net: Use napi routines for RX SKB
Message-ID: <20240304204249.64fc470f@kernel.org>
In-Reply-To: <ddb7f076-06a7-45df-ae98-b4120d9dc275@infradead.org>
References: <ddb7f076-06a7-45df-ae98-b4120d9dc275@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 17:20:11 +0900 Geoff Levand wrote:
> +	descr->skb = napi_build_skb(napi_buff, napi_buff_size);
> +
> +	if (unlikely(!descr->skb)) {
> +		skb_free_frag(napi_buff);
>  		return -ENOMEM;
>  	}
>  
> -	offset = ((unsigned long)descr->skb->data) &
> -		(GELIC_NET_RXBUF_ALIGN - 1);
> -	if (offset)
> -		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
> -	/* io-mmu-map the skb */
> -	cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
> -				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
> -	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
> -	if (dma_mapping_error(ctodev(card), cpu_addr)) {
> -		dev_kfree_skb_any(descr->skb);
> +	cpu_addr = dma_map_single(dev, napi_buff, napi_buff_size,
> +				  DMA_FROM_DEVICE);
> +
> +	if (dma_mapping_error(dev, cpu_addr)) {
> +		skb_free_frag(napi_buff);

After you called napi_build_skb() you should be operating (here:
freeing) the skb not the underlying buffer.
-- 
pw-bot: cr

