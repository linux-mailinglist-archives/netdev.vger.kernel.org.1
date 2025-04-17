Return-Path: <netdev+bounces-183633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C4A91588
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B16A3B2890
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E821A458;
	Thu, 17 Apr 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqN3/pFu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020202139DC
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875894; cv=none; b=NwUiknJrHoM3qmyAXPDjMyU48ICppdPGZRv4q6qkX25dDemo97ChXtUyvbQUsRVNOVQMoz6ABuNmJiI0JAOba2NTD+ITaGqrCfxMND0pD2mmoPmQkppiiG+MqTtvYBBYAWgzGYZ6igFW0hVygcfGs7sfDZVZGBLsVNWUxT7+Bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875894; c=relaxed/simple;
	bh=tslz6DlI/Mm4YFhda6oTOI/VUg3AL5GOdcZku7+10qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkBhbyhqJHNraR1wyG4U8aXhKmWvU3Q42efZ7E47L3UOTTN+qfn47RkLu+C0Ssks3xAzHVsvBbzU+ly4Yt7ibD6J4/sDoH0eYSslkDppdd6qvNQZkyFklBUakPCiRmwWxc3gaVFIs8acA8nzaTa2RuLqw1cOd7X14918n6uTxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqN3/pFu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744875893; x=1776411893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tslz6DlI/Mm4YFhda6oTOI/VUg3AL5GOdcZku7+10qg=;
  b=RqN3/pFu2mtqyrootBI/S3UB2tlKclZpfiMixjc/cgOiMLjORdpOhGDu
   hPLnJMWL954kTPGtkiTKChxt7oYwEiZriCL7wxvwR/dHVsLS5OpKn67rm
   nDh/uLozNGQUdRWQpKBfUQvAhWGNUY2Y9zIqXEEXqNft4szi7mts0ooQt
   YxrlxmTlTTMcQ0eLoRCKFKqvT2rvnNN+L4PFxx4L88id5A5vExqYFaUyT
   X67WrDMWgYX/2gHzBFiFmptQQW8BsYCwENELGUxp/CovDu1KVPM1pGDWP
   DsjZItcoh89sMq7qNKi3ufMc+tvMG8yN4yd2XBVoTFLbsCQ7ql6NEXnul
   g==;
X-CSE-ConnectionGUID: eEY97FU0SwKG6mp20lhqFw==
X-CSE-MsgGUID: ApazkKrjQ5+guf7fjbEaaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50099768"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="50099768"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 00:44:52 -0700
X-CSE-ConnectionGUID: SECiPiZnTDWrnD/BIEfxOA==
X-CSE-MsgGUID: oLWOzVShQrCnUO/bkHGTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="130586301"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 00:44:50 -0700
Date: Thu, 17 Apr 2025 09:44:32 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	horms@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 1/3] net: ibmveth: Indented struct
 ibmveth_adapter correctly
Message-ID: <aACxYGS9F8bh5PkG@mev-dev.igk.intel.com>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
 <20250416205751.66365-2-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416205751.66365-2-davemarq@linux.ibm.com>

On Wed, Apr 16, 2025 at 03:57:49PM -0500, Dave Marquardt wrote:
> Made struct ibmveth_adapter follow indentation rules
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.h | 64 +++++++++++++++---------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index 8468e2c59d7a..0f72ce54e7cf 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -134,38 +134,38 @@ struct ibmveth_rx_q {
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
> -- 
> 2.49.0

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


