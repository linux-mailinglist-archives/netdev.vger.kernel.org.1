Return-Path: <netdev+bounces-248002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE76D019C6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0B8F30006DC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED223876A9;
	Thu,  8 Jan 2026 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi3npI/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AA35772C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860275; cv=none; b=cnhTCpi93XOEutyBtUzhBosiPGu65uRUL8Qe6i7WWg7Hr9apNs7NvUSeVizfJoJJO6DaXgbl9LczWq43sNW6W75BndiRp8wk51+hYGMBN0iQVuEnWkwYxkuNj6sF+/9Wwpvf7qEdCmhg2BsQEz8VNU5k7fzTqOCYRdZjvsIGijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860275; c=relaxed/simple;
	bh=o4MsYELLIRdpMavb58oxxcTrWEElqeifzs3r0QwK8Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOBePugw6W83LouDLr2W/jFVqjNC9JsAJ0jKMdXSSQ3riINafGPoGfSuAfApzbjuXuxDdACVZmcdKeQYRy0mS9df4VFRM1gyBq6K5/2QqCgzurBsv9kX3a6+OyVelHbfR6ZfmmQmvytAHqvjbkdG0irtrDn11t8Qz/ZW0t9oGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi3npI/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5824DC116D0;
	Thu,  8 Jan 2026 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767860274;
	bh=o4MsYELLIRdpMavb58oxxcTrWEElqeifzs3r0QwK8Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi3npI/j5aOGRk56+t6y+yOqn70I0DXEEM7RsohpkeLi7GZeqLkgWzgrjwSOni6X8
	 0jzRiIToeBB/rsSuUEtqSfQIi9FTEP/2j+YF4BZLryhk+FT7hRMXKeJKE7kApoExTN
	 8BaNvAESbwgIV4HE10KvxeEo4CgmzK43FvT4Q2Jg4FA0a9WkCeA1L3h7XWrXONZfzb
	 RROrtNHeydyGhSn3VQo6SQFCO2kfnsWJ9q22auBS6om38sEmgo+qozwnW1KFEeX+QQ
	 NMs7Z2pOFZe42evcBO6W0koelQRwewGzIav/FSb26FCozTYqKvY9fv/DkvWWGne72U
	 0h07gNlkGSkGQ==
Date: Thu, 8 Jan 2026 08:17:48 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dong Yibo <dong100@mucse.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	MD Danish Anwar <danishanwar@ti.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v18 4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260108081748.GF345651@kernel.org>
References: <20260105110712.22674-1-xuanzhuo@linux.alibaba.com>
 <20260105110712.22674-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105110712.22674-5-xuanzhuo@linux.alibaba.com>

On Mon, Jan 05, 2026 at 07:07:10PM +0800, Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit introduces the implementation for the netdevice open and
> stop.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c

...

> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	int err;
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = ctx->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(ctx);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	enet_bind_new_q_and_cfg(enet, ctx);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: active new ring and irq failed. err %d\n",
> +			    err);
> +		return err;
> +	}

I think that some unwinding of resources is needed if
eea_active_ring_and_irq() or eea_start_rxtx() fail.
Similar to what appears in eea_netdev_open().

Also flagged by Claude Code with Review Prompts.

> +
> +	err = eea_start_rxtx(enet->netdev);
> +	if (err)
> +		netdev_warn(enet->netdev,
> +			    "eea reset: start queue failed. err %d\n", err);
> +
> +	return err;
> +}

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c

...

> +static void eea_free_meta(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
> +{
> +	struct eea_sq_free_stats stats;
> +	struct eea_tx_meta *meta;
> +	int i;
> +
> +	while ((meta = eea_tx_meta_get(tx)))
> +		meta->skb = NULL;
> +
> +	for (i = 0; i < cfg->tx_ring_num; i++) {
> +		meta = &tx->meta[i];
> +
> +		if (!meta->skb)
> +			continue;
> +
> +		eea_meta_free_xmit(tx, meta, false, NULL, &stats);
> +
> +		meta->skb = NULL;
> +	}

Claude Code running with Review Prompts [1] flags that
in the loop above cfg->tx_ring_num is used as the bounds
for access to tx->meta. But elsewhere, including in the
allocation of tx->meta, ctx->cfg.tx_ring_depth is used.

[1] https://github.com/masoncl/review-prompts/

> +
> +	kvfree(tx->meta);
> +	tx->meta = NULL;
> +}

...

