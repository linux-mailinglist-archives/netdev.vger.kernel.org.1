Return-Path: <netdev+bounces-215424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 770DCB2E9E9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1268B188B76D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7B1FE455;
	Thu, 21 Aug 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLwOri2b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479E3B29E;
	Thu, 21 Aug 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738061; cv=none; b=JI+INDBzTzDhdtnW+tSYrgMRcwAEosxe/arEtds5xEFCqQ+7KcaN0aEZpNXr9xcx99/bjYhtEXSKLY8e6aSHahxdLS4xWB38IYNwHdd9MSrDoXSZikzLJmItY4UFSGKZGd/zqsnsB6SR/jMZ1582+j6ZrFUSw59LTxmQIyxmO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738061; c=relaxed/simple;
	bh=srlr/JyDGFW1tS266XiF97s3jH641lf5zMxmC8eNrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piw2buETrMQrHxL4V46vYXPSiQd3FPLYwk/lwSM4fvyIqKMyrHX7Hs7mifnWLugCvFtBdNghWSpSvQg3fOGrXsZUHPkdBZfYLRHgyockTe8z87/iswSrp7YFgGl66/tytcrOpj2nD6r+YKpfpjS/U8FNAHqRuXCGXPMcJbxIqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLwOri2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD766C4CEE7;
	Thu, 21 Aug 2025 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738061;
	bh=srlr/JyDGFW1tS266XiF97s3jH641lf5zMxmC8eNrBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sLwOri2bJW7ZNpVIgYEsN/glrZic+smJ5+XpEm9lqVq98d6vARO/pxoWXtdy8LY3j
	 X40ZRpDHvoKbp0jZZOEqR0TG87kl3E/ZPkqaOVLMtUX5P6uyjXFs6IDJ8bx7dL20qt
	 ShQQIlyaScWBOb9WKxghyciRV28HOequwaULfcyAHGfa0Nuf9pjbvnVnrbDSamSAV5
	 LAt9JWBkwcbJQxzALR1Tj7GBpZUfcape/X8KeyrQmqpiugwweFjY+3dW/7Xk81Cy6M
	 TmVURr6SYDczerY73GyQKX5z1HRO9+soCaplm1Ysd8eZy+SOCMxePMNy1J3LQxi3KV
	 PTqUWsExgTUZQ==
Date: Wed, 20 Aug 2025 18:01:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <20250820180100.7085a7d3@kernel.org>
In-Reply-To: <20250820171214.3597901-3-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
	<20250820171214.3597901-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 20:11:52 +0300 Dragos Tatulea wrote:
> + * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
> + *			   for this queue. When such device is not available,
> + *			   the function will return NULL.

nit: I think you're using a different tense/grammar than the doc for
other callbacks (which is admittedly somewhat unusual :$) 
Also should we indicate that "not available" is an error? Maybe just:

	Get dma device for zero-copy operations to be used
	for this queue. Return NULL on error.

>   * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
>   * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
>   * be called for an interface which is open.

> +/**
> + * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
> + * @dev:	net_device
> + * @idx:	queue index
> + *
> + * Get dma device for zero-copy operations to be used for this queue.
> + * When such device is not available or valid, the function will return NULL.

Unfortunately kdoc really wants us to add Return: statements to all
functions...

> + */
> +struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
> +{
> +	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
> +	struct device *dma_dev;
> +
> +	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
> +		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
> +	else
> +		dma_dev = dev->dev.parent;
> +
> +	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
> +}
> +EXPORT_SYMBOL(netdev_queue_get_dma_dev);
> \ No newline at end of file

This is in desperate need of a terminating new line.

But also -- why the export? iouring and devmem can't be modules.

