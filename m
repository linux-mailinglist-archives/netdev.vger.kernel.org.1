Return-Path: <netdev+bounces-92977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF38B97A8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9577B1F26FF8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614F5466B;
	Thu,  2 May 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgP/sRfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091850291
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641932; cv=none; b=ZrIWzuw4mYR0Vy3YvwpEexzJOQyTmVDhLNXA7h+FTjZv70vru+/2udK5jHS5wFoRfsybNDdSsCRV42/InxB99IZcLzzgViya117XlswajH/hCWJzzaIzc06QWu5loU8Osp34ucRviA+ym9PvYtMOioiCFHiBaAZmRS+KEl2YGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641932; c=relaxed/simple;
	bh=30sYwZ0gP3irPjjbxtgbJAISRnmZrJuOGNwGLkOSBGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNlmuT3bQsGetiL11yI46qTmYaY3a/OidxDwAoSlxUW3Bm/WN0mt5g2LJZyw03/BHCseaiEYQ7b/DYJvcXtcbcuXLQ9bOHoO0R/eFXJYxg5pSUaS7ySbgaYHIcmZRTS0vaEDpiG0wtyZmGwzgM8RlmlUVCPjsDzf7XV2YHfgdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgP/sRfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ECCC113CC;
	Thu,  2 May 2024 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714641932;
	bh=30sYwZ0gP3irPjjbxtgbJAISRnmZrJuOGNwGLkOSBGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgP/sRfHT1/AmsvVDNenMKO63aTlizmb6IgElKkrMZoG4/2s3HsZmy482lWiHu7j9
	 XfKqYLFHYoqgNIiFajifGbge5yvazpo+g5cs1+BXhCm0sz0lQSrCLQt0uO0QA1gRw1
	 iTA0Bv0LIwcCBA+Y5/UBthpLUCj28WAiJJYwrYghdxP8KLGPLIn1kJnQH/V9ExMMbw
	 +nffhMqaDMCkmhaBmwZjkLB9nEo6qjlCAwOmoqyBumQmzhB24oJmG1WrKnOOtvWswM
	 hQClR9oDiYEWzRYKIEOvu3tgTk6lRnMOMLcPHhkZyKgVharAxRDW1CKCBqaJ6/KJsl
	 eqgLhoH/P6ZtQ==
Date: Thu, 2 May 2024 10:25:26 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 4/4] net: txgbe: fix to control VLAN strip
Message-ID: <20240502092526.GD2821784@kernel.org>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
 <20240429102519.25096-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429102519.25096-5-jiawenwu@trustnetic.com>

On Mon, Apr 29, 2024 at 06:25:19PM +0800, Jiawen Wu wrote:
> When VLAN tag strip is changed to enable or disable, the hardware requires
> the Rx ring to be in a disabled state, otherwise the feature cannot be
> changed.
> 
> Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 ++
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  6 ++--
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++++++++
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 +++++++----
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 +++++++----
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 30 +++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
>  7 files changed, 84 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 945c13d1a982..c09a6f744575 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1958,6 +1958,8 @@ int wx_sw_init(struct wx *wx)
>  		return -ENOMEM;
>  	}
>  
> +	bitmap_zero(wx->state, WX_STATE_NBITS);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(wx_sw_init);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index aefd78455468..ed6a168ff136 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2692,9 +2692,9 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
>  
>  	netdev->features = features;
>  
> -	if (changed &
> -	    (NETIF_F_HW_VLAN_CTAG_RX |
> -	     NETIF_F_HW_VLAN_STAG_RX))
> +	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
> +		wx->do_reset(netdev);
> +	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
>  		wx_set_rx_mode(netdev);
>  
>  	return 0;

Hi Jiawen Wu,

NETIF_F_HW_VLAN_CTAG_RX appears in both the "if" and "if else" condition.
Should "if else" be changed to "if" ?

...

