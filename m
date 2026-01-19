Return-Path: <netdev+bounces-251267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0AD3B761
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B20243060265
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8762DCBFA;
	Mon, 19 Jan 2026 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjDzdU5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586872741B5
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851386; cv=none; b=dl/+56cOZ/ex6Im98SyQodoZwpeLulXoIalHZU8Byo0lo81ies16Eq1r9w43YcCuulWc/XBx3vBV+28I/x8EGR0kNarIFBSK8P9BZjJFjBYvbhtj9P+QEpApX+UZOgcA3PzKz+/IXrudC0Z2h++OyeaPDIKzsalNCmFYg9XIU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851386; c=relaxed/simple;
	bh=9qAgAK5541EYKVOhpBiyEEXk0wXbZIZX95kwx84spG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKzCzJ6Jto+Itcmr9yEowqIMsi0zXs1yYVvZfJd8OcRx5cRefRdem6Ii/nXWDbwXrfE3EvMWujYHXrTPR35aVTZcODrt1SHoUmHxE5wVXkUi5fP7uKACvcEvmiYJjqhoYxlY9sBR7xTa5g6nnRjsdpenenV5sGaNN9+F6K8LJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjDzdU5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86697C116C6;
	Mon, 19 Jan 2026 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851386;
	bh=9qAgAK5541EYKVOhpBiyEEXk0wXbZIZX95kwx84spG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjDzdU5/afneFLAC7gknS+tX0rwBaQZkpCQp9hNgMfN6XZhuUmkE0Rq9pNasCBl0T
	 dlWdCIyJPQKcr2sVYM1qbguYlcD5LyN5pgZP1RdBJu0gVnMcCml2G0JsjgeSzADw7k
	 cdxZnW1ERsVNHxjv+jZvmGZ8BOZAHQKlt48dBopaDJyX8zGlFgSRxpOE+3kPAcFZn4
	 AUth9MK92ehZuza6FeQiDKrhUqwlsHg18Cv28hjrexU24lnKCKAmGhWNII1H+3/pkN
	 RWlqanF2o2KKGLQitu1huXrXl9vF+FctgZlX3Lam01H3SfAuWPir+69nFIwyJNPxhk
	 q00xQkJeMyCbw==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [net-next,5/8] cadence: macb: add XDP support for gem
Date: Mon, 19 Jan 2026 11:36:24 -0800
Message-ID: <20260119193624.1255742-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-6-pvalerio@redhat.com>
References: <20260115222531.313002-6-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
cadence: macb: add XDP support for gem

This commit introduces XDP support for the macb/gem driver with XDP_PASS,
XDP_DROP, and XDP_REDIRECT verdicts.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 89f0c4dc3884..1f62100a4c4d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> -static int gem_create_page_pool(struct macb_queue *queue)
> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>  {
>  	struct page_pool_params pp_params = {
>  		.order = 0,
>  		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.pool_size = queue->bp->rx_ring_size,
>  		.nid = NUMA_NO_NODE,
> -		.dma_dir = DMA_FROM_DEVICE,
> +		.dma_dir = rcu_access_pointer(queue->bp->prog)
> +				? DMA_BIDIRECTIONAL
> +				: DMA_FROM_DEVICE,

The page pool is created with DMA direction based on whether an XDP program
is attached at creation time. However, gem_xdp_setup() below allows attaching
XDP programs to a running interface without recreating the page pool.

If the interface is opened without XDP (page pool uses DMA_FROM_DEVICE), and
then an XDP program is attached via ndo_bpf, the pool will still use
DMA_FROM_DEVICE. For XDP redirect, DMA_BIDIRECTIONAL is needed for proper
cache coherency on non-cache-coherent architectures.

The stmmac driver handles this by calling stmmac_xdp_release() and
stmmac_xdp_open() when XDP program state changes on a running interface,
which recreates the page pool with the correct DMA direction.

Should gem_xdp_setup() reset the interface (or at least the page pools) when
attaching or detaching XDP programs on a running interface to ensure the DMA
direction matches?

[ ... ]

> +static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +
> +	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
> +		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	return 0;
> +}

This function swaps the XDP program via RCU but does not reset the interface
or recreate the page pools. This relates to the DMA direction concern above.

