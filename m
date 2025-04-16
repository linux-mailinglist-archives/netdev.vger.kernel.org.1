Return-Path: <netdev+bounces-183285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E27A8B938
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684FE189ADB7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208894A24;
	Wed, 16 Apr 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGR7ML/k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE02179A3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806894; cv=none; b=e4ytyVBrurv9L7W3UY1Uko8XO1pkQAAkPr58h6Vn2qZYbwkmMk1DeGHXpbRtqVdDTxiXDf73lcupfU7o3R9VRumM5Z9SL1Id28b/JM80JUG3JLNOxTZ4RIuABBtbYuE1Gfsg/R18Kol/9k4DOJCx1I+QW0Oc1TvspMjE2fdPHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806894; c=relaxed/simple;
	bh=MQzAdBu/uMebeOJA/sZbwOp+jPQg3Wn4NmMIMqB48Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjFE13LZgFvc1DlPTPdt4YTVJQMTPqkWoJVW1hNhLnOAIkJCHwhvjJuaKsG8LjJQsNrvr4rXJK0LBHAJMdgjlzkG8xy9KnkMeaOF6EEazs5FJc6FTMmExRfCZT0++E/UnpRW5IB5N6EjQvIxyOikMMsZodM5wf1J29pEKscOesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGR7ML/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6967BC4CEE2;
	Wed, 16 Apr 2025 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744806892;
	bh=MQzAdBu/uMebeOJA/sZbwOp+jPQg3Wn4NmMIMqB48Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGR7ML/k61FQ1FDw+5qwWmSxs2bICPqLtCebdQiV+rrFlRGCb+cQytXead4oJXV2h
	 7eS8lqlYz+k7UdzujkSijNg3fM9I6YjNNStBsl1D7L6S2d2l9rLVHLAuXVjZnm9WNP
	 96ScdzXOCavsO33Vn5AE0SKhnJc0LdEVmVbyUVvb1xleJVr4HEAUW6ZJ/bakNnaFSG
	 Xihc/B8idKJVFoV9qu1PoknzSE5lzPW+gKN7Fb8/fb9K/SbmJV12W9A++H+DeAi6I5
	 +/NqWTLBaEJBCGQdMP4kntCh+rb/2WZoeYPQI/Pn5a5YL6uY0Y4MBxETwQ7q9hbFEG
	 oYUMv8uF8GELA==
Date: Wed, 16 Apr 2025 13:34:49 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 1/2] net: ibmveth: make ibmveth use WARN_ON
 instead of BUG_ON
Message-ID: <20250416123449.GQ395307@horms.kernel.org>
References: <20250414194016.437838-1-davemarq@linux.ibm.com>
 <20250414194016.437838-2-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414194016.437838-2-davemarq@linux.ibm.com>

On Mon, Apr 14, 2025 at 02:40:15PM -0500, Dave Marquardt wrote:
> Replaced BUG_ON calls with WARN_ON calls with error handling, with
> calls to a new ibmveth_reset routine, which resets the device. Removed
> conflicting and unneeded forward declaration.

To me the most important change here is adding the ibmveth_reset.
So I would report that in the subject (rather than the WARN_ON) change.
But perhaps that is just me.

> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 116 ++++++++++++++++++++++++-----
>  drivers/net/ethernet/ibm/ibmveth.h |  65 ++++++++--------
>  2 files changed, 130 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c

...

> @@ -370,20 +372,36 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  	}
>  }
>  
> -/* remove a buffer from a pool */
> -static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> -					    u64 correlator, bool reuse)
> +/**
> + * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
> + * @adapter: adapter instance
> + * @correlator: identifies pool and index
> + * @reuse: whether to reuse buffer

The above is the correct way to document function parameters in a Kernel doc.

> + *
> + * Return:
> + * * %0       - success
> + * * %-EINVAL - correlator maps to pool or index out of range
> + * * %-EFAULT - pool and index map to null skb
> + */
> +static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> +					   u64 correlator, bool reuse)

...

> +/**
> + * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
> + *
> + * @adapter - pointer to adapter
> + * @reuse   - whether to reuse buffer

But this is not correct. IOW, tooling expects
f.e. @adapter: ...  rather than @adapter - ...

Flagged by W=1 builds and ./scripts/kernel-doc -none

> + *
> + * Context: called from ibmveth_poll
> + *
> + * Return:
> + * * %0    - success
> + * * other - non-zero return from ibmveth_remove_buffer_from_pool
> + */
> +static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> +				      bool reuse)

...

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index 8468e2c59d7a..b0a2460ec9f9 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -134,38 +134,39 @@ struct ibmveth_rx_q {
>  };
>  
>  struct ibmveth_adapter {
> -    struct vio_dev *vdev;
> -    struct net_device *netdev;
> -    struct napi_struct napi;
> -    unsigned int mcastFilterSize;
> -    void * buffer_list_addr;
> -    void * filter_list_addr;
> -    void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
> -    unsigned int tx_ltb_size;
> -    dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
> -    dma_addr_t buffer_list_dma;
> -    dma_addr_t filter_list_dma;
> -    struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
> -    struct ibmveth_rx_q rx_queue;
> -    int rx_csum;
> -    int large_send;
> -    bool is_active_trunk;
> -
> -    u64 fw_ipv6_csum_support;
> -    u64 fw_ipv4_csum_support;
> -    u64 fw_large_send_support;
> -    /* adapter specific stats */
> -    u64 replenish_task_cycles;
> -    u64 replenish_no_mem;
> -    u64 replenish_add_buff_failure;
> -    u64 replenish_add_buff_success;
> -    u64 rx_invalid_buffer;
> -    u64 rx_no_buffer;
> -    u64 tx_map_failed;
> -    u64 tx_send_failed;
> -    u64 tx_large_packets;
> -    u64 rx_large_packets;
> -    /* Ethtool settings */
> +	struct vio_dev *vdev;
> +	struct net_device *netdev;
> +	struct napi_struct napi;
> +	struct work_struct work;
> +	unsigned int mcastFilterSize;
> +	void *buffer_list_addr;
> +	void *filter_list_addr;
> +	void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
> +	unsigned int tx_ltb_size;
> +	dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
> +	dma_addr_t buffer_list_dma;
> +	dma_addr_t filter_list_dma;
> +	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
> +	struct ibmveth_rx_q rx_queue;
> +	int rx_csum;
> +	int large_send;
> +	bool is_active_trunk;
> +
> +	u64 fw_ipv6_csum_support;
> +	u64 fw_ipv4_csum_support;
> +	u64 fw_large_send_support;
> +	/* adapter specific stats */
> +	u64 replenish_task_cycles;
> +	u64 replenish_no_mem;
> +	u64 replenish_add_buff_failure;
> +	u64 replenish_add_buff_success;
> +	u64 rx_invalid_buffer;
> +	u64 rx_no_buffer;
> +	u64 tx_map_failed;
> +	u64 tx_send_failed;
> +	u64 tx_large_packets;
> +	u64 rx_large_packets;
> +	/* Ethtool settings */
>  	u8 duplex;
>  	u32 speed;
>  };

If you would like to update the indentation of this structure
then please do so in a separate patch which precedes
adding/removing/chainging fields of the structure.

As it, it's very hard to see the non-formatting changes in this hunk.

-- 
pw-bot: changes-requested

