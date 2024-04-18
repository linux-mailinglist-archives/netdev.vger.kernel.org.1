Return-Path: <netdev+bounces-89407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606C8AA38E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C443F284600
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7B17F394;
	Thu, 18 Apr 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzNh+rki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B817AD74
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470103; cv=none; b=j6kU8BJUa9JFJEdWkbIKaaNWupm6rEqqpmYr5Utaw1YJpcNQrkhdyjpOsBNSpt8OhgnC0XhzIOU26FoPY4KhRvBoYlL3oJkjamVxyyA6d3TanwFfdtHQ84YcxplSY/8TrsMzcQXeM0O5lDaTAfKwoQ4n2jB/gB9V2hFdNnNoais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470103; c=relaxed/simple;
	bh=H+2iIBefHd+ikEZV+VAXUJjf2yjDh997PWIVaUvG4x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plaHtzKXSf2lspWoIXCLJ+bwoexEkRiENqQyP7K7t88bwadtnNk16u4LZ2l4Lvum7FOyOzRvmtYfyhOAjDO2nwoUIkSKlKQbrFO7sRwwybYU/Gyl0bDe7dJObXrOeHyHQYaFNv5JQdMxvCmbwP4tUwDHU4movg30W3bAttHq78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzNh+rki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2225CC113CC;
	Thu, 18 Apr 2024 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713470103;
	bh=H+2iIBefHd+ikEZV+VAXUJjf2yjDh997PWIVaUvG4x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzNh+rkij77771rHZclameZpMt4AZmAO3Hh35nFqyrHYrhPX5oyp1CXN2nMJviPp2
	 mm1Yqif/tKaD+FeKZELacn3qsTCNuSwiOa1ksBXKpY31Zo+rHYajutLUclcqjpZu0K
	 IlsFPBPD+u473m2n8cgTXD/fXXAlOIxwVDAUvZDbbAuNjfEVqU96coivv1uNJXMRBX
	 ubsEZ1QrCOxK/O3eotZrNMnZqnj62iT+C60HRbvHg9kn3A7RBijVUkWnl9Nc3ELQsZ
	 GU7FfHjEWEE3l/MNmmS0y5NWA2YFgmVAAcSOX5Mas7s7qHJfYDO5yRasegK0P1UvFP
	 bRG0rzHk7Sfvg==
Date: Thu, 18 Apr 2024 20:54:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net 5/5] net: txgbe: fix to control VLAN strip
Message-ID: <20240418195458.GR3975545@kernel.org>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-6-jiawenwu@trustnetic.com>

On Tue, Apr 16, 2024 at 02:29:52PM +0800, Jiawen Wu wrote:
> When VLAN tag strip is changed to enable or disable, the hardware requires
> the Rx ring to be in a disabled state, otherwise the feature cannot be
> changed.
> 
> Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 58 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index af0c548e52b0..2a6b35036fce 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

...

> +static int txgbe_set_features(struct net_device *netdev, netdev_features_t features)

There seems to be a lot of overlap between this function and
wx_set_features(). To aid maintenance, the common code be
factored out into a shared function?

> +{
> +	netdev_features_t changed = netdev->features ^ features;
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	if (features & NETIF_F_RXHASH) {
> +		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
> +		      WX_RDB_RA_CTL_RSS_EN);
> +		wx->rss_enabled = true;
> +	} else {
> +		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
> +		wx->rss_enabled = false;
> +	}
> +
> +	netdev->features = features;
> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
> +		txgbe_do_reset(netdev);
> +	else if (changed & NETIF_F_HW_VLAN_CTAG_FILTER)
> +		wx_set_rx_mode(netdev);

I see the following in wx_set_features():

        if (changed &
	    (NETIF_F_HW_VLAN_CTAG_RX |
	     NETIF_F_HW_VLAN_STAG_RX))
		wx_set_rx_mode(netdev);

Should NETIF_F_HW_VLAN_STAG_RX and NETIF_F_HW_VLAN_STAG_FILTER
also be checked in this function?

> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops txgbe_netdev_ops = {
>  	.ndo_open               = txgbe_open,
>  	.ndo_stop               = txgbe_close,
>  	.ndo_change_mtu         = wx_change_mtu,
>  	.ndo_start_xmit         = wx_xmit_frame,
>  	.ndo_set_rx_mode        = wx_set_rx_mode,
> -	.ndo_set_features       = wx_set_features,
> +	.ndo_set_features       = txgbe_set_features,
>  	.ndo_fix_features       = wx_fix_features,
>  	.ndo_validate_addr      = eth_validate_addr,
>  	.ndo_set_mac_address    = wx_set_mac,
> -- 
> 2.27.0
> 
> 

