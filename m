Return-Path: <netdev+bounces-127620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814B975E26
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88093285C13
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C59475;
	Thu, 12 Sep 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj/CNfxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B578C06
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102315; cv=none; b=hvj84Q1JdkIKLDTYSWHZOg7XQ6tKKSnrPtHZ8nFv2fFbz7dos8Nfx+l8OPoQsitrS68qdYfg0iYpdtCipzIgnJLX21NNeBC/Gs4ZZw9x1DIwR1zWSj7YrMIG8cTqObCDX7ptq8TjrJk7bCnltm8ti9/zmEVWF78z8yXQD8kV6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102315; c=relaxed/simple;
	bh=nipjDUySQ1RMFgDSCZZM9WLFQczTP06ArLYfjUsZ/CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTP+tR8CE9sgoiy0jTveHhl/TXcfDbVLca0OQhvSz0lYXFTIo3x2a8joSbLckJDNA9IfIVB38gXEMNSh0Lyz8WfC/Q6/rDAuJwKobitCd6bpUyAcJYc95/uFOBfx4iIOFUObk2+fbyDi98t/20x/z5pl9F6XRXdGmE9xESEUCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj/CNfxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5ADC4CEC0;
	Thu, 12 Sep 2024 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726102314;
	bh=nipjDUySQ1RMFgDSCZZM9WLFQczTP06ArLYfjUsZ/CI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fj/CNfxgNVGoulIvb7rIuzH4hQqdHDTPQ1ts9ImR697uWrD7J62ikdgssEZNssxg6
	 zbka//R+RYQnt5RxIAR7gQak/0oWZgWPrjOIFBIopfZM55LjjRyG5bNRAh6n6im+Ol
	 VqJjVEUGjHxx4ndL8Byidfti8Ej8wmIJbeo23WthoYol9GPBWKcNHBflDle3y+JYya
	 0xrKjtp3KtYNLJmoXMlgA5k6iuuqvMHk8+ut8TQtraeq3ccfoaaZt9Fvp8/cmSbDTv
	 0X/QNadPGTfwEXv9RdUlousfEOvlLhJXYhiTbiAjY8V4kXnQS9m9/akeT7YXmVll3q
	 WrUP0+h/+itOg==
Date: Wed, 11 Sep 2024 17:51:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, ziweixiao@google.com
Subject: Re: [PATCH net-next 2/2] gve: adopt page pool for DQ RDA mode
Message-ID: <20240911175153.1a84a28b@kernel.org>
In-Reply-To: <20240910175315.1334256-3-pkaligineedi@google.com>
References: <20240910175315.1334256-1-pkaligineedi@google.com>
	<20240910175315.1334256-3-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:53:15 -0700 Praveen Kaligineedi wrote:
> +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	struct gve_priv *priv = rx->gve;
> +	struct page *page;
> +
> +	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
> +	page = page_pool_alloc(rx->dqo.page_pool, &buf_state->page_info.page_offset,
> +			       &buf_state->page_info.buf_size, GFP_ATOMIC);
> +
> +	if (!page) {
> +		priv->page_alloc_fail++;

Is this counter global to the device? No locking or atomicity needed?

> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv, struct gve_rx_ring *rx)
> +{
> +	struct page_pool_params pp = {
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order = 0,
> +		.pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
> +		.dev = &priv->pdev->dev,
> +		.netdev = priv->dev,
> +		.max_len = PAGE_SIZE,
> +		.dma_dir = DMA_FROM_DEVICE,

Can the allocation run from process context in parallel with the NAPI
that uses the pool? It's uncommon for drivers to do that. If not you
can set the NAPI pointer here and get lock-free recycling.

> +	};
> +
> +	return page_pool_create(&pp);
> +}

Could you make sure to wrap the new code at 80 chars?

./scripts/checkpatch.pl --strict --max-line-length=80 
-- 
pw-bot: cr

