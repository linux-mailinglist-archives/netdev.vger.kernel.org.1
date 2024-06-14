Return-Path: <netdev+bounces-103715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11690932C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C34A1C22BEB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47216D339;
	Fri, 14 Jun 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ8adDct"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D9383
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395676; cv=none; b=CKgRyCtneoBEsbjKir9LhB+UpXoNWBZqDYEhP8gBVDOdXCRZVudW9LdnvHI6PirBwfRCZoYmlVHuDt5ApP6mGemaFi/V96lBjaMook4aGU/FQD84FKk0pJ+yMmKj1EW3cdf16qE3eSQkXiNdOEI3AjdJ1i35ffTs7Ybj0ttd3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395676; c=relaxed/simple;
	bh=dqV4Cu+9KeoPj+/hyBeYsBT3Q/OPv0b+wYlB4To6psU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFnxFoFgEaIHYuMor9f4r5MeCf3Q6pGCat2CfbgMA//mCMnX0O0SJflPMhfyGnbY7BFcj5YVIdQnSyWO9oDhJjZY7/+UwKy7muxO16GksgKwtsXexan0w8l4CsEJQH+/6WgZh7Q1jnPmysrzk5qyR6suQ7USQINdlGICvxKUNis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ8adDct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65968C4AF1A;
	Fri, 14 Jun 2024 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718395675;
	bh=dqV4Cu+9KeoPj+/hyBeYsBT3Q/OPv0b+wYlB4To6psU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ8adDctga5v8D+0FB6IEp9lGQcugJzN/lnJDE51ox71LqkvlNZHlVQ7oWueTVHTX
	 6NW5sqQhvFhvB3rrtb4DbFNsSqE/jgo2grXdq3cqHjT3IrJwDZQfwDv0Yvp/5nVt1v
	 d+rS3uNl7G0xMZAjE0yssNSHt4rLv5f/xLkiA5pEt24nmTZkIHIo74oBFSmhJQmskX
	 i4LfbvvI/vYyI2BGVwIci6qvDKCV7xNZzS7wBZr9lPnvDxnqCBnps6A491JkFMwURP
	 DdokO1qK7yR1XjDMDt4H9b80EtgNUpt5w8x5wx7+i7DcCMOG+eAKPT9Bg06iMc+e2F
	 +ZjRRjBWm0gFQ==
Date: Fri, 14 Jun 2024 21:07:51 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] bnxt_en: implement netdev_queue_mgmt_ops
Message-ID: <20240614200751.GY8447@kernel.org>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <20240611023324.1485426-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611023324.1485426-4-dw@davidwei.uk>

On Mon, Jun 10, 2024 at 07:33:24PM -0700, David Wei wrote:
> Implement netdev_queue_mgmt_ops for bnxt added in [1].
> 
> Two bnxt_rx_ring_info structs are allocated to hold the new/old queue
> memory. Queue memory is copied from/to the main bp->rx_ring[idx]
> bnxt_rx_ring_info.
> 
> Queue memory is pre-allocated in bnxt_queue_mem_alloc() into a clone,
> and then copied into bp->rx_ring[idx] in bnxt_queue_mem_start().
> 
> Similarly, when bp->rx_ring[idx] is stopped its queue memory is copied
> into a clone, and then freed later in bnxt_queue_mem_free().
> 
> I tested this patchset with netdev_rx_queue_restart(), including
> inducing errors in all places that returns an error code. In all cases,
> the queue is left in a good working state.
> 
> Rx queues are stopped/started using bnxt_hwrm_vnic_update(), which only
> affects queues that are not in the default RSS context. This is
> different to the GVE that also implemented the queue API recently where
> arbitrary Rx queues can be stopped. Due to this limitation, all ndos
> returns EOPNOTSUPP if the queue is in the default RSS context.
> 
> Thanks to Somnath for helping me with using bnxt_hwrm_vnic_update() to
> stop/start an Rx queue. With their permission I've added them as
> Acked-by.
> 
> [1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/
> 
> Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 307 ++++++++++++++++++++++
>  1 file changed, 307 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> +static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
> +{
> +	struct bnxt_rx_ring_info *rxr = qmem;
> +	struct bnxt *bp = netdev_priv(dev);
> +	struct bnxt_ring_struct *ring;
> +
> +	if (bnxt_get_max_rss_ring(bp) >= idx)
> +		return -EOPNOTSUPP;

Hi David,

I guess there was some last minute refactoring and these sloped through the
cracks. The two lines above seem a bit out of place here.

* idx doesn't exist in this context
* The return type of this function is void

> +
> +	bnxt_free_one_rx_ring(bp, rxr);
> +	bnxt_free_one_rx_agg_ring(bp, rxr);
> +
> +	/* At this point, this NAPI instance has another page pool associated
> +	 * with it. Disconnect here before freeing the old page pool to avoid
> +	 * warnings.
> +	 */
> +	rxr->page_pool->p.napi = NULL;
> +	page_pool_destroy(rxr->page_pool);
> +	rxr->page_pool = NULL;
> +
> +	ring = &rxr->rx_ring_struct;
> +	bnxt_free_ring(bp, &ring->ring_mem);
> +
> +	ring = &rxr->rx_agg_ring_struct;
> +	bnxt_free_ring(bp, &ring->ring_mem);
> +
> +	kfree(rxr->rx_agg_bmap);
> +	rxr->rx_agg_bmap = NULL;
> +}

...

