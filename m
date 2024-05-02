Return-Path: <netdev+bounces-92943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2C8B9691
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65B5B20E3E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D06381DA;
	Thu,  2 May 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ2QOgb8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FB1CD39
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638979; cv=none; b=ULAfQFeGuBrXWEI3CzOQIsyxemevYrzMhPORW3lMJ9f0x+oJGhfoZOaisw5lSNS4E767styzq3x8BEKhQa966K89XxuKeCP0jXmaZtZ++hNkVuSA8gIFkRsRoFb4ZGuMuvG1hIqq/EojIL0j1YUkhl6G0itopQ7Xjb1QHCogtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638979; c=relaxed/simple;
	bh=UEw2hzafJgaMFiGMQiBvcEMNbYgiWh3L15EXHVkMbL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM/zLQTDutFfrFhiLrJKTPfyTg/IdDFTbEfX45WP2cY05VM/mpOTdfJonfvkEMdbtzkLc2617jF34y8L0svLnNaJhKVRLP5w5q/C0v4H21nfb3+HrREZYFglWN0uc5k5hrnmcXOYYdflxoaxESo0HNKL3KbmtcSdMXkFSeDe2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ2QOgb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB58C113CC;
	Thu,  2 May 2024 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714638978;
	bh=UEw2hzafJgaMFiGMQiBvcEMNbYgiWh3L15EXHVkMbL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJ2QOgb8AJv8OBupYgS/PjS/Y2p7AEv/wxw7n93UUAyoRPuSD5cFIeTp3U+s+bu3x
	 n1R3+TU0ChLBf8Vk7GunIBB/i4RSimnIETjovrwC8/zSP/fXdzReeclPr0TgKJmhkx
	 uh2QdOP4ij3XaMoOPxHgpGAlGwG6HIP9nOAGWbeZP93siPpFQ/ZsKbCs3jOoCxepgl
	 g8NIFE6aW55Xc7s4zE/aze8TTGj2/gV/Nf1JPqH1uYOG9IqvAkG/QkZuPMTaMUd+zL
	 pvE3pu5aMkxEykQlpYpnCagXgCexFBrvTN18QRkMXSMIJHxfNHJ0g6ya3dOFXDIF2Y
	 UrBFQvYBdLozA==
Date: Thu, 2 May 2024 09:36:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 2/4] net: wangxun: fix to change Rx features
Message-ID: <20240502083614.GC2821784@kernel.org>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
 <20240429102519.25096-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429102519.25096-3-jiawenwu@trustnetic.com>

On Mon, Apr 29, 2024 at 06:25:17PM +0800, Jiawen Wu wrote:
> Fix the issue where some Rx features cannot be changed.
> 
> When using ethtool -K to turn off rx offload, it returns error and
> displays "Could not change any device features". And netdev->features
> is not assigned a new value to actually configure the hardware.
> 
> Fixes: 6dbedcffcf54 ("net: libwx: Implement xx_set_features ops")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 6fae161cbcb8..667a5675998c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2690,12 +2690,14 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
>  		wx->rss_enabled = false;
>  	}
>  
> +	netdev->features = features;
> +

nit: I think it would be slightly nicer to place this
     at the end of the function, just before return.
     But it would make no difference to the logic,
     so I don't feel strongly about this.

>  	if (changed &
>  	    (NETIF_F_HW_VLAN_CTAG_RX |
>  	     NETIF_F_HW_VLAN_STAG_RX))
>  		wx_set_rx_mode(netdev);
>  
> -	return 1;
> +	return 0;
>  }
>  EXPORT_SYMBOL(wx_set_features);
>  
> -- 
> 2.27.0
> 
> 

