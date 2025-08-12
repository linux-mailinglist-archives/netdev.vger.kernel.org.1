Return-Path: <netdev+bounces-212877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07AB2259E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D45660E4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6599D2ED14B;
	Tue, 12 Aug 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/OIa0Mq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB02ED14C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997152; cv=none; b=XJGBEgiYXx4L/K57hiWX60Rg9TsX3w6IxHHuVGxFl0qGTwoA7d+yVlWZqglV/5/XskEaKc4YgRje1XEwIFy09Vi2bJZVdE5VYdJAzibbeFyWN1i2H8Cg7CXPPBykEpzHsK2k29m8JYo6T5ZKkL8Sc6a+9301SP2JQFlnN3JefX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997152; c=relaxed/simple;
	bh=CsyIz9FBfMl64+vhq/zb6Wr2znPOgRbayHIf5gsfNCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzSqlQGhi0zle7dFnS2txlXcl6QZe2NRfGteYfq3+ojm9lKlYY5AMD7sIa1fTe4PvkHGZzBllk7UY8vZJQU57noF7zG6hSyi+0KuHqkitwVPfpvOhXRHMD5Lx71bx6uJd713PFUFvhTMhdLUTDdqdlujSlVnKWnI/ELhAFEzwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/OIa0Mq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754997151; x=1786533151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsyIz9FBfMl64+vhq/zb6Wr2znPOgRbayHIf5gsfNCE=;
  b=N/OIa0Mqn9PfA6aBm8apz90W1LNjg73+R3yGWI3hD83Lw+pmKf0fk8u2
   ApUjywTAw8m7/uczQmiihd8hGH1dhms+cI1Kw7pKYl4DFLD29G+CmF7tm
   M5copbbInohsB48zog1bptZKImoHrA+TEdFsLOl1pIh7K3sKFE5hPwsBk
   X4YIA5hz6QWqTwWDCw7vam/zL3SNdLb1+Sd5jwpDKX7HL2SrL2ShCb9/5
   mETb3XarVm3iIw0HA5enl/b4mi7p+H6JzKk51oJsFKeXpX8PGkVbPS82X
   XWKaotHWN8VGM7u37/fRKIC8MruQ3h4EcJHM4jY0TrdsMlSgr1NbaXADI
   g==;
X-CSE-ConnectionGUID: eMSe6UBxRCynq16JOtIruA==
X-CSE-MsgGUID: 8WvrwgfeQSilmH33B+lPnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68722955"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68722955"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:12:30 -0700
X-CSE-ConnectionGUID: Z8Jso3cmTKG5exWKwyUevA==
X-CSE-MsgGUID: EZl5uBfuQ8y89MUz70xdKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166059984"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:12:27 -0700
Date: Tue, 12 Aug 2025 13:11:06 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 1/4] net: ngbe: change the default ITR setting
Message-ID: <aJshSlT+YuSjlz0n@mev-dev.igk.intel.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
 <20250812015023.12876-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812015023.12876-2-jiawenwu@trustnetic.com>

On Tue, Aug 12, 2025 at 09:50:20AM +0800, Jiawen Wu wrote:
> Change the default RX/TX ITR for wx_mac_em devices from 20K to 7K, which
> is an experience value from out-of-tree ngbe driver, to get higher
> performance on some platforms with weak single-core performance.
> 
> TCP_SRTEAM test on Phytium 2000+ shows that the throughput of 64-Byte
> packets is increased from 350.53Mbits/s to 395.92Mbits/s.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 12 ++++++++----
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  5 ++---
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index c12a4cb951f6..d9412e55b5b2 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -359,10 +359,14 @@ int wx_set_coalesce(struct net_device *netdev,
>  	else
>  		wx->rx_itr_setting = ec->rx_coalesce_usecs;
>  
> -	if (wx->rx_itr_setting == 1)
> -		rx_itr_param = WX_20K_ITR;
> -	else
> +	if (wx->rx_itr_setting == 1) {
> +		if (wx->mac.type == wx_mac_em)
> +			rx_itr_param = WX_7K_ITR;
> +		else
> +			rx_itr_param = WX_20K_ITR;
> +	} else {
>  		rx_itr_param = wx->rx_itr_setting;
> +	}
>  
>  	if (ec->tx_coalesce_usecs > 1)
>  		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
> @@ -377,7 +381,7 @@ int wx_set_coalesce(struct net_device *netdev,
>  			tx_itr_param = WX_12K_ITR;
>  			break;
>  		default:
> -			tx_itr_param = WX_20K_ITR;
> +			tx_itr_param = WX_7K_ITR;
>  			break;

You are removing these code in patch 3, maybe just move the patch after
it.

>  		}
>  	} else {
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index e0fc897b0a58..3fff73ae44af 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -119,9 +119,8 @@ static int ngbe_sw_init(struct wx *wx)
>  						   num_online_cpus());
>  	wx->rss_enabled = true;
>  
> -	/* enable itr by default in dynamic mode */
> -	wx->rx_itr_setting = 1;
> -	wx->tx_itr_setting = 1;
> +	wx->rx_itr_setting = WX_7K_ITR;
> +	wx->tx_itr_setting = WX_7K_ITR;

Seems fine,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
>  	/* set default ring sizes */
>  	wx->tx_ring_count = NGBE_DEFAULT_TXD;
> -- 
> 2.48.1
> 

