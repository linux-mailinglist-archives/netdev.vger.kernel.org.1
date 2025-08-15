Return-Path: <netdev+bounces-214109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49FB284D1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647214E5D4D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91B2F9C39;
	Fri, 15 Aug 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2IryycX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEE2F9C24;
	Fri, 15 Aug 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278188; cv=none; b=Y5FSxGTUiZpqIKqyFnvBJ4hx0ulmD/HbUy5DYp5wfAi3dtganyi0/DXNjcX9yLfCqBGsmpBKzHM4+uqe3iOXXsds8R+6wE5YCeO2dgXzeAGSzduiafdg2XbGO9GIz2PjHKxg+N3ohR5TCVB4NrNKY77GfPitm2LcnwQqf7pnB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278188; c=relaxed/simple;
	bh=vUSlgNbostwDHn7HetcT1k1vd03/2QSR/Hejw5tNUz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYhT7HvygJV0u02jD8I6lQ2v7jBg3nMC/HcFv1GxAzoph9U8leQ326OTaOM6cK6OyZz4zQHjZM3Xm4AJZLtFCNRGRIjnyDCs+qVGiskdjTtU3UJL8+K4y1g853xbajWnWOyx6Y6MBuzQACVynyeL+ay7N88A3u9mvp1jAKk+iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2IryycX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4D2C4CEEB;
	Fri, 15 Aug 2025 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278188;
	bh=vUSlgNbostwDHn7HetcT1k1vd03/2QSR/Hejw5tNUz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2IryycXkmA/OqUaHz2j7xUV83YCDH4tDaM8iHMdrkGYlj/28iHyS9Svgq6Ho1Cx6
	 ANcsPXPP7ciOZo47Qp1QLrbdBCbOSlbvp/GF2cmtst4e/Y5LUjzyB1G49DC8bkXrwj
	 YsZ2b2PnpwrUw94qXlKHpL4wv+s+gjmBQSQEcb6EThto1PXvDq5whpBQPOY8OyuDW0
	 o+2iOyt01ir2AXmbFlkt9UT41UZbWjgTPG3cVAHctx3bKQaayiGmehHI3tMCTbIN2w
	 RJvTtlP1spSIRKenJwGtplnh5Yq9lk+qyqKCABdak5lxQDh5IoYnyGD+cBic1onoeq
	 dViKS/ov7YLFw==
Date: Fri, 15 Aug 2025 10:16:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
 <hch@infradead.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <20250815101627.3c0bc59d@kernel.org>
In-Reply-To: <20250815110401.2254214-3-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
	<20250815110401.2254214-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:03:42 +0300 Dragos Tatulea wrote:
> +static inline struct device *
> +netdev_queue_get_dma_dev(struct net_device *dev, int idx)
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

This really does not have to live in the header file.

