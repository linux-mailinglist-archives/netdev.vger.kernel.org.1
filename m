Return-Path: <netdev+bounces-178391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C63A76D0D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97588188BF2A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D8218E97;
	Mon, 31 Mar 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZdFGcaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8E218E91
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447047; cv=none; b=PhT3V/Y9OMNdmCLq2mbdRa+YLZg2LHMwmDYTIcYDmps1M8/6DTJRL4sybNr7cbunnh2AYzD2rsmdNeTGytLb0MmYU+uEE+o6A37mXPpnvh6D1UcKpeVzM44SteDGnQ4KE6bJlIdWHkNd2ZKP7rGxO2QauqaUCFrd/RmVO/BExMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447047; c=relaxed/simple;
	bh=rDE4uEoivk03HC/g+MmMpUTIBidzIQZJUzmm1hRK/Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOgAS6UINyLqt+hqEDn0UtxrqDzbLEZeZXFLvj5eR06knN9Hozjqy/KDrMwZUwMjcsWvr9ecyAcTuwfYj14Zv6/ugd+wlxP8lVSrPtMFRM+BLAIbojdUGMcC66ZUyMkOuVnl23Fd7LSxLZZjruhtlMYqxBjqxD177PARnTAXBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZdFGcaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D1EC4CEE3;
	Mon, 31 Mar 2025 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743447046;
	bh=rDE4uEoivk03HC/g+MmMpUTIBidzIQZJUzmm1hRK/Ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZdFGcaf5Axj0IdmRG0DiTqYh9u1NenlKgjnjvYAXDKQpz3rkMb6ewhNBXBpvsAnn
	 7BbQG4lPHA9V10dow0hrH9Dp1M2GsPRvaXi6Mw7/8J5Cpe4FomSWbE0TucqfSyAOaF
	 zMYInAAwcT7k2xV3sDLAAfNG9URNoeDpaix87BC6L97ZKhJ85m/9yiF7yCXnOjNrqI
	 5BtLpmpdDMmnNRs8Lc6L2B3UgMf33ZS9vGJzYJTCoClSTOl7SnbXZQ8WqO5vvE9qr0
	 RUrNWNUKRU0QjbLUnIn/tLhQMCGIug4+giDlmIEbX4xNCC/ShZKkIeCXmw6/nnKvLo
	 Awbp8jVTP9uGA==
Date: Mon, 31 Mar 2025 11:50:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk,
 netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me,
 aleksander.lobakin@intel.com
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory
 TCP
Message-ID: <20250331115045.032d2eb7@kernel.org>
In-Reply-To: <20250331114729.594603-3-ap420073@gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
	<20250331114729.594603-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:47:29 +0000 Taehee Yoo wrote:
> Currently, bnxt_en driver satisfies the requirements of the Device
> memory TCP, which is HDS.
> So, it implements rx-side Device memory TCP for bnxt_en driver.
> It requires only converting the page API to netmem API.
> `struct page` for rx-size are changed to `netmem_ref netmem` and
> corresponding functions are changed to a variant of netmem API.
> 
> It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> page_pool.
> The netmem will be activated only when a user requests devmem TCP.
> 
> When netmem is activated, received data is unreadable and netmem is
> disabled, received data is readable.
> But drivers don't need to handle both cases because netmem core API will
> handle it properly.
> So, using proper netmem API is enough for drivers.

> @@ -1352,15 +1367,15 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi,
>  	if (!skb)
>  		return NULL;
>  
> -	page_pool_dma_sync_for_cpu(rxr->head_pool, page,
> -				   offset + bp->rx_dma_offset,
> -				   bp->rx_copybreak);
> +	page_pool_dma_sync_netmem_for_cpu(rxr->head_pool, netmem,
> +					  offset + bp->rx_dma_offset,
> +					  bp->rx_copybreak);
>  
>  	memcpy(skb->data - NET_IP_ALIGN,
> -	       bnxt_data_ptr(bp, page, offset) - NET_IP_ALIGN,
> +	       bnxt_data_ptr(bp, netmem, offset) - NET_IP_ALIGN,
>  	       len + NET_IP_ALIGN);
>  
> -	page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page),
> +	page_pool_dma_sync_for_device(rxr->head_pool, netmem,
>  				      bp->rx_dma_offset, bp->rx_copybreak);
>  	skb_put(skb, len);
>  

Do we check if rx copybreak is enabled before allowing ZC to be enabled?
We can't copybreak with unreadable memory.

> @@ -15912,7 +15941,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  			goto err_reset;
>  	}
>  
> -	napi_enable(&bnapi->napi);
> +	napi_enable_locked(&bnapi->napi);
>  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
>  
>  	for (i = 0; i < bp->nr_vnics; i++) {
> @@ -15964,7 +15993,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	page_pool_disable_direct_recycling(rxr->page_pool);
> -	if (bnxt_separate_head_pool())
> +	if (bnxt_separate_head_pool(rxr))
>  		page_pool_disable_direct_recycling(rxr->head_pool);
>  
>  	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> @@ -15974,7 +16003,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	 * completion is handled in NAPI to guarantee no more DMA on that ring
>  	 * after seeing the completion.
>  	 */
> -	napi_disable(&bnapi->napi);
> +	napi_disable_locked(&bnapi->napi);

This is a fix right? The IRQ code already calls the queue reset without
rtnl_lock. Let's split it up and submit for net.

> @@ -2863,15 +2865,15 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
>  #endif
>  }
>  
> -static inline u8 *bnxt_data_ptr(struct bnxt *bp, struct page *page,
> +static inline u8 *bnxt_data_ptr(struct bnxt *bp, netmem_ref netmem,
>  				unsigned int offset)
>  {
> -	return page_address(page) + offset + bp->rx_offset;
> +	return netmem_address(netmem) + offset + bp->rx_offset;
>  }
>  
> -static inline u8 *bnxt_data(struct page *page, unsigned int offset)
> +static inline u8 *bnxt_data(netmem_ref netmem, unsigned int offset)
>  {
> -	return page_address(page) + offset;
> +	return netmem_address(netmem) + offset;
>  }

This is not great, seems like the unification of normal vs agg bd struct
backfires here. unreadable netmem can only be populated in agg bds
right? So why don't we keep the structs separate and avoid the need
to convert from netmem back to a VA?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index 9592d04e0661..85b6df6a9e7f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -18,7 +18,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  				   struct xdp_buff *xdp);
>  void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
>  bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
> -		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
> +		 struct xdp_buff *xdp, netmem_ref netmem, u8 **data_ptr,
>  		 unsigned int *len, u8 *event);
>  int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp);
>  int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
> @@ -27,7 +27,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
>  bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr);
>  
>  void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
> -			u16 cons, struct page *page, unsigned int len,
> +			u16 cons, netmem_ref netmem, unsigned int len,
>  			struct xdp_buff *xdp);

We also shouldn't pass netmem to XDP init, it's strange conceptually.
If we reach XDP it has to be a non-net_iov page.

