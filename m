Return-Path: <netdev+bounces-235349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7DC2EF62
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB1E1886DDA
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC623AE66;
	Tue,  4 Nov 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzM8GPn1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D379EA
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223085; cv=none; b=WuXzckY5Wt3c/vgasmce8gA0k4kkZ7ZPOVTv+G09okvRYaQjw7iX5v3BRi9eARtxVwWxVRGViFBxHJbCtv93vmmDN5yonraySfxgolGm7QakfN35/NpdYOcr/CupgxZMEJ6hlWHrVJTLd/RAPpQ0hWyFdnCJHhm+sc/1aery+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223085; c=relaxed/simple;
	bh=70HPMrbKPrxN9q2o4MD99ClRKe7o6salikYYnp9b50U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scw0xvih21EQBWQuahFXrQ4l0+svyvJrLNVGtMN0gAsM2M4W2EG81E2NY1AXKhRkWDBpFRJBMTRifbcYEMcX1ixGm9ERV1AvQu/JC87oOYp3/PrPDyTMVCtMKXl9s9nYVKa4yeBxT/xfsG1zFOaog80zCeBYLZHFCwbyfE2DSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzM8GPn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BCFC4CEE7;
	Tue,  4 Nov 2025 02:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762223084;
	bh=70HPMrbKPrxN9q2o4MD99ClRKe7o6salikYYnp9b50U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzM8GPn1grli5Fui1irqc1P7BGCt0D5w3IWpuAS1BVX2OwWCiklpp1jLjzmsMDVu9
	 eHCK+AjOu2yb5kaLjoKqBO/oeJDsvSgNYGYayGW0nnKUmcGAx11Bx8szINJz8waqp2
	 TDZvUhTEDC+L6PFP/wrmNEHObeulAS5DvkgJ8yvrZIpW4Rh698HlGf7Vk9RICXuCq1
	 r46fnbzX3ye0pBX+IhYHgDeZ65ZxiKN41eg3ehvPKs0KDCXXYM02g6SkT7DJ61V6x9
	 itvRJuBMj9gfjdycmaLc8wmL1r3ymtnjHXhOKWjtZyiwrCwb+TrHP3X5SGPR3W+yzk
	 hRrGUrx6hhFcg==
Date: Mon, 3 Nov 2025 18:24:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 2/5] eea: introduce ring and descriptor
 structures
Message-ID: <20251103182443.54a12faf@kernel.org>
In-Reply-To: <20251029080145.18967-3-xuanzhuo@linux.alibaba.com>
References: <20251029080145.18967-1-xuanzhuo@linux.alibaba.com>
	<20251029080145.18967-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 16:01:42 +0800 Xuan Zhuo wrote:
> +static void *ering_alloc_queue(struct eea_device *edev, size_t size,
> +			       dma_addr_t *dma_handle)
> +{
> +	gfp_t flags = GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;
> +
> +	return dma_alloc_coherent(edev->dma_dev, size, dma_handle, flags);

dma_alloc_coherent() always zeros allocated memory you can drop the __GFP_ZERO.

