Return-Path: <netdev+bounces-197558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C6AD92C3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5011E1844
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB920C487;
	Fri, 13 Jun 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qf7zq5Rx"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5C200BA1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831774; cv=none; b=de0FlG0V9V1iUT/n/n82gQhgqUiVj0nmOWNOGT38pd0DQ3FeHNRM5hjxywA80MVPapYQd9J3oRddyv4pK3Kt2YQ4qZ9t0f0hXH8O7dZ+XbFPfkflgxU61bxy71FFfadTeUEgbFiZewPoIaxoz0JPy/MsU3RRGc8Z4tZrYO6MKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831774; c=relaxed/simple;
	bh=LDjtHlpn0gp3NwZiAFeYXi0uHXqcQmrxJa87CNTfMms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egtmG8L2hYbnxQwxwZs8dqJU6LKFG/P4ZUCctAKVCLY/MlQYYfqpx1fwKj8G3H9QNnFqv41jqzQyuNUUidAGN+rYREG1N9D46QfADzH1yA6De8BK1GdzibdoAOWrcRSbI4Dc+4ZydQ8F+6JVqRvFiZRr7GY9x21qEOWLpb3GF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qf7zq5Rx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1688e772-3067-4277-ad45-6564b4fbbddf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749831760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1YhpgIgW1NbawS2cb3Hh7ubcsGLiTlGNXGsiU6ZaTc=;
	b=Qf7zq5RxdrLsiNa7ByBMUkcNbcGe5IV1Q77GGC6RmSD7IZX6wvdvU9QYk6Jb+Eo/L7x5zi
	o6D2q7GRCEQqxZQ4WSYlUfnwobZfu4RctT+lpTYsn+Sufj4l4ARyzJsjDGCOI06lCgtIlm
	e4iEcM4TvL7aoPP78VQKmxN1M/zRnf4=
Date: Fri, 13 Jun 2025 09:22:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/9] net/mlx5: Ensure fw pages are always allocated on
 same NUMA
To: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Moshe Shemesh <moshe@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
 <20250610151514.1094735-2-mbloch@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250610151514.1094735-2-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/10 8:15, Mark Bloch 写道:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> When firmware asks the driver to allocate more pages, using event of
> give_pages, the driver should always allocate it from same NUMA, the
> original device NUMA. Current code uses dev_to_node() which can result
> in different NUMA as it is changed by other driver flows, such as
> mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
> allocating firmware pages.

I'm not sure whether NUMA balancing is currently being considered or not.

If I understand correctly, after this commit is applied, all pages will 
be allocated from the same NUMA node — specifically, the original 
device's NUMA node. This seems like it could lead to NUMA imbalance.

By using dev_to_node, it appears that pages could be allocated from 
other NUMA nodes, which might help maintain better NUMA balance.

In the past, I encountered a NUMA balancing issue caused by the mlx5 
NIC, so using dev_to_node might be beneficial in addressing similar 
problems.

Thanks,
Zhu Yanjun

> 
> Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on reader NUMA node")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 972e8e9df585..9bc9bd83c232 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
>   static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>   {
>   	struct device *device = mlx5_core_dma_dev(dev);
> -	int nid = dev_to_node(device);
> +	int nid = dev->priv.numa_node;
>   	struct page *page;
>   	u64 zero_addr = 1;
>   	u64 addr;


