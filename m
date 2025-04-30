Return-Path: <netdev+bounces-187089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D47AA4DF9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C981BA7F48
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DC25332B;
	Wed, 30 Apr 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+7uvLIb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB945111AD;
	Wed, 30 Apr 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021460; cv=none; b=nAN1Mg5ACu5mwWKr5CTMhUX/VZWn5yYsD/9Q5G3YWg0H/ZwxVImt8h9jNt7EJnrQdQcsQ/qRv/e/tRhNFBChJFnzM5b5akDOUm3kfB+FWjodg2KQCvYf6GtCrDCtjCSzyoBTr2Y40RHKZ2PYVETm07ke1gAAJoX0mj9UtMZ9D40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021460; c=relaxed/simple;
	bh=+c9XrTAN8J1a90cuN4IhW/qyLi+qE6W0bg5bOqCAlB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxWzG0uazgJQvMUW0MLLxQgceJAzZNjjU2hvf87Tf8rV8uZGxVFFCDmYf5A+HfHbrXOgN/auJUHdHGj9/K+Ylb/gLmDpGVxhWkfPlZW93dHA55taamWKfM+yMKFnKS5lViAYaWBmJsNuOVbNkZWogbNVoaSgSnj9PfmekXeEs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+7uvLIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82854C4CEE7;
	Wed, 30 Apr 2025 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746021460;
	bh=+c9XrTAN8J1a90cuN4IhW/qyLi+qE6W0bg5bOqCAlB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+7uvLIbzzz0tyb4YaSAQyP3nNcZEdkL0GeoB5t0U/MTRTgnYc1jvuEl46aBl2L8d
	 I8vcAzXIaYTpJ1X9KoasxyyxAPN5q/ChRr331Qv2IhG7Zzn5B8wQpe2I0e7WmqyT2k
	 CS8+HwXBouvE8BuHIj0MapvQhbkPeT4c+CPBs/MuFssM1PiQbeVzxyBRECwaaiu54f
	 f30VeDzp/piBILyJ1MlYs4QT4g+SXwVjGmBi6DWMkvFC2uYM+XrID3Q9YHvIN3kcqX
	 VRXs83zOC09WtD1Jn/mlIWKApzzA3gYnMEPYGNQ67eI3VN4cJtutAQtFliGRF1IHFV
	 +CswkjC5mCRHA==
Date: Wed, 30 Apr 2025 14:57:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, hawk@kernel.org, john.fastabend@gmail.com,
	virtualization@lists.linux.dev, minhquangbui99@gmail.com
Subject: Re: [PATCH net] virtio-net: free xsk_buffs on error in
 virtnet_xsk_pool_enable()
Message-ID: <20250430135735.GU3339421@horms.kernel.org>
References: <20250429164323.2637891-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429164323.2637891-1-kuba@kernel.org>

On Tue, Apr 29, 2025 at 09:43:23AM -0700, Jakub Kicinski wrote:
> The selftests added to our CI by Bui Quang Minh recently reveals
> that there is a mem leak on the error path of virtnet_xsk_pool_enable():
> 
> unreferenced object 0xffff88800a68a000 (size 2048):
>   comm "xdp_helper", pid 318, jiffies 4294692778
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     __kvmalloc_node_noprof+0x402/0x570
>     virtnet_xsk_pool_enable+0x293/0x6a0 (drivers/net/virtio_net.c:5882)
>     xp_assign_dev+0x369/0x670 (net/xdp/xsk_buff_pool.c:226)
>     xsk_bind+0x6a5/0x1ae0
>     __sys_bind+0x15e/0x230
>     __x64_sys_bind+0x72/0xb0
>     do_syscall_64+0xc1/0x1d0
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: virtualization@lists.linux.dev
> CC: minhquangbui99@gmail.com
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..a3d4e666c2a0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5886,7 +5886,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
>  						 DMA_TO_DEVICE, 0);
>  	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
> -		return -ENOMEM;

Hi Jakub,

I think you need the following here:

		err = -ENOMEM;

Else err is uninitialised when jumping to the err_free_buffs label.

Flagged by clang 20.1.3 [-Wsometimes-uninitialized], and Smatch.

> +		goto err_free_buffs;
>  
>  	err = xsk_pool_dma_map(pool, dma_dev, 0);
>  	if (err)
> @@ -5914,6 +5914,8 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  err_xsk_map:
>  	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
>  					 DMA_TO_DEVICE, 0);
> +err_free_buffs:
> +	kvfree(rq->xsk_buffs);
>  	return err;
>  }
>  
> -- 
> 2.49.0
> 

