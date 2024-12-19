Return-Path: <netdev+bounces-153240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7E9F751D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394737A0834
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827A1FBCAE;
	Thu, 19 Dec 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGUUfLTP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE901C69D;
	Thu, 19 Dec 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591924; cv=none; b=X1iLrMqsLMg9ycLG5nzIQ6DDPOqjHLGVLxJ8iMC5FK/bcu0I37tmxVhdvZ89aNEFETSYsuBFECoT+LNbt44NSIKbAMRO2oS4HJbFTE8xvh/zPv826Buo3lDp4j/KNSiCCvElmmhKfCqUPemxfs/zmNgaaJ664nsuDxcgRnn+HC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591924; c=relaxed/simple;
	bh=Qi2UEcvbZZoPHvb/nA7ujItzrBvcTHn280pAgV2Vk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMwPPVWPd5ZIB+WpB8WagEV7BBkKa7YFIC4Oakn2PNsXU/BLzGqwHwvtCtL4aRlmjvptO67XL6WQTjvZQVZfT1t/KvWFbIB2IJg/3LZf5OxEFd+GtlSFbSRxVTlf7+qEmZaooET8bTX41QuJyFGQtMnoXct32DZxHVB/+JVPKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGUUfLTP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734591922; x=1766127922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qi2UEcvbZZoPHvb/nA7ujItzrBvcTHn280pAgV2Vk1A=;
  b=bGUUfLTPvnJ/Rl4Bm4KaSEgvQo466a0Dvt2Zpcqq9OQvNd/QhxZlp+B3
   c0Ev/GQn/4oS0YgjFLzlb5qAJVee+pF1YYBcBzheUor5pToALfedvBxmg
   F2lM8/EF8kM9H8oMttu/NIMFD4Mbqs9KW/w70rZP9b51pI5zp7KzRuHxk
   +TLg2q9qbnXIOVNjaFh4+JMceZkS/hXDhztRZRTjz3Dqy7aZ8aClnMixn
   /dJ1H1y98NUR/hHCT9rKT6VGsy6PatLa4T3724sFAZ2MySUOzfa0M/oXg
   WzemORux3MDJy78lJGh08pxbXjCnFRX11lPIOu6rLhUzz9PioXqQtBqD1
   g==;
X-CSE-ConnectionGUID: dTrENtcmS6+HK/UwNdU3WQ==
X-CSE-MsgGUID: yO8F2novRVmFz97UENpJ8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35307902"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35307902"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:05:21 -0800
X-CSE-ConnectionGUID: hE6NrnDXQzaTx3E7puYn5Q==
X-CSE-MsgGUID: zfsYTSODRbeRyMtWKoA6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="102960238"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:05:16 -0800
Date: Thu, 19 Dec 2024 08:02:10 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: aleksander.lobakin@intel.com, lukma@denx.de, m-malladi@ti.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org,
	schnelle@linux.ibm.com, vladimir.oltean@nxp.com, horms@kernel.org,
	rogerq@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 2/4] net: ti: icssg-prueth: Add VLAN support in
 EMAC mode
Message-ID: <Z2PE5m8R5lM4/YRT@mev-dev.igk.intel.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216100044.577489-3-danishanwar@ti.com>

On Mon, Dec 16, 2024 at 03:30:42PM +0530, MD Danish Anwar wrote:
> Add support for vlan filtering in dual EMAC mode.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 29 +++++++++-----------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index c568c84a032b..e031bccf31dc 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -822,19 +822,18 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  	struct prueth *prueth = emac->prueth;
> +	int port_mask = BIT(emac->port_id);
>  	int untag_mask = 0;
> -	int port_mask;
>  
> -	if (prueth->is_hsr_offload_mode) {
> -		port_mask = BIT(PRUETH_PORT_HOST) | BIT(emac->port_id);
> -		untag_mask = 0;
> +	if (prueth->is_hsr_offload_mode)
> +		port_mask |= BIT(PRUETH_PORT_HOST);
>  
> -		netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
> -			   vid, port_mask, untag_mask);
> +	netdev_err(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
> +		   vid, port_mask, untag_mask);
> +
> +	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
> +	icssg_set_pvid(emac->prueth, vid, emac->port_id);
>  
> -		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
> -		icssg_set_pvid(emac->prueth, vid, emac->port_id);
> -	}
>  	return 0;
>  }
>  
> @@ -843,18 +842,16 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  	struct prueth *prueth = emac->prueth;
> +	int port_mask = BIT(emac->port_id);
>  	int untag_mask = 0;
> -	int port_mask;
>  
> -	if (prueth->is_hsr_offload_mode) {
> +	if (prueth->is_hsr_offload_mode)
>  		port_mask = BIT(PRUETH_PORT_HOST);
> -		untag_mask = 0;
>  
> -		netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
> -			   vid, port_mask, untag_mask);
> +	netdev_err(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
> +		   vid, port_mask, untag_mask);
Why error? It doesn't look like error path, previously there was
netdev_dbg (made more sense in my opinion)

> +	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
>  
> -		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
> -	}
>  	return 0;
>  }
>  
> -- 
> 2.34.1

