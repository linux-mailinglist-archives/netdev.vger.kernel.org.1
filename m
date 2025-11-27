Return-Path: <netdev+bounces-242114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77688C8C77E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D19B4E120E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD8253F13;
	Thu, 27 Nov 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV7O1dXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DD244671
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204559; cv=none; b=N2U6MVGg5zBXFWWoRIyiLTpEkNDzsvSh+o6Q5ch4w0NXxdhi0G3nmiPRAQpsRj53ggtAsUDExmoc1VCWnpKSI3avJTEGwi0EgS90Hpm8qshDw44pLApsN3biLb8iQSZDq70iYpzkbKqc7XxJaGdQLZp6LugIjlY5z0FV+Us7I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204559; c=relaxed/simple;
	bh=xD5hCVSLfqAUZDT1fpLlaNqZ/OuqN0hmCZh14HR3MGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmsaYe83VMBkmo1vW20/N3Us51gpE4WT/HteJJmipIGCWzwlNK3gdXHwPoP8ivTfahgZ8AOUK4qsq2Zan0zIbhvLKbloli/IS0Qia1ADgL7ENiBVstWOOJvSZE6hU3IAWIhoB53VL8ktXd6D9g2vUnCps4rVL69s1YViC9vCy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV7O1dXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A24C4CEF7;
	Thu, 27 Nov 2025 00:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204558;
	bh=xD5hCVSLfqAUZDT1fpLlaNqZ/OuqN0hmCZh14HR3MGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rV7O1dXycoGrV0dFnpX/y43rDSKj0Pjd9CITFHYurj1VxsEIx0+balwLpjNvPqaym
	 qXXTszJ4E49YwyxMZbXTJPKXVvmOJfCazr9t5QRdrI6Ib6NduWhoBnSPunzu1UuJig
	 Sv4pkFIQC7WP6RK98OZ7MDVT7xB1jDvb2appXuD87PCfDBGrYPjkyBqPN7u+UVl6er
	 wDamgW+uqOaXlBB87AXGhUHyugl2UPyB+lIUDZOiAQscn3xCre+FyNTcC/S96QHZ0+
	 Hfu9X0hlR3eedmq3skUZkAzQkKTE4ydT6kOoXVuNQ9Lfo8C6rvzUOmvR+jzMAuduzc
	 t4z78v+HTz3tA==
Date: Wed, 26 Nov 2025 16:49:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Vivian Wang <wangruikang@iscas.ac.cn>, MD Danish
 Anwar <danishanwar@ti.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v16 4/5] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20251126164917.295b38ac@kernel.org>
In-Reply-To: <20251124014251.63761-5-xuanzhuo@linux.alibaba.com>
References: <20251124014251.63761-1-xuanzhuo@linux.alibaba.com>
	<20251124014251.63761-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 09:42:50 +0800 Xuan Zhuo wrote:
> +static void enet_bind_new_q_and_cfg(struct eea_net *enet,
> +				    struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int i;
> +
> +	enet->cfg = ctx->cfg;
> +
> +	enet->rx = ctx->rx;
> +	enet->tx = ctx->tx;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = ctx->rx[i];
> +		tx = &ctx->tx[i];
> +
> +		rx->enet = enet;
> +		tx->enet = enet;

I think you need to move it up sooner? Or re-implement the cleanup
paths to handle partial initialization correctly.. Right now if
eea_alloc_rx_hdr() fails, eea_alloc_rx()->eea_free_rx()->eea_free_rx_hdr()
will dereference rx->enet before it's set

> +static void eea_free_meta(struct eea_net_tx *tx)
> +{
> +	struct eea_sq_free_stats stats;
> +	struct eea_tx_meta *meta;
> +	int i;
> +
> +	while ((meta = eea_tx_meta_get(tx)))
> +		meta->skb = NULL;
> +
> +	for (i = 0; i < tx->enet->cfg.tx_ring_num; i++) {

Similarly is it okay to use enet->cfg here? Could be that we're freeing
cfg before it's bound to a device.

