Return-Path: <netdev+bounces-189103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06503AB060E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8657BE224
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3722DA12;
	Thu,  8 May 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rbui3bY1"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9D2153D3
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746744356; cv=none; b=pOYeF35MbReX5G5jpkOCMhUIV7NKG5LyJXyI7JXGLvyUNLPKFsh2ROAYUp+Qng2c4MrTMB0ryGOxx/IS8SlXNz+VYh/3RqbkWOqbbaGN03d/4BSpWqWBZgcDGbROYGmkXr/i9OqQli+XaFeHgtJxXJbMJ5NlaOB8/ZpYQcPd7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746744356; c=relaxed/simple;
	bh=0A2PyAe0FEWxU24BYezBxE14ElWWg1cQepZASFQ5RhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+fD/AMqrCDADQZd/oJSnwsMY45vCBJi9sFpgoNg+9g+TETFaV6qS+fgQQrlsK8jWZVCZa+G1QP81BzEX8noopTDJH85UztmOjj0AXsWAlumCP9s1rLWWYWQfd6t5lrQqvTr3LJxWB40b/LEzUNH0s0SnVXdlndqDhyQBiOXVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rbui3bY1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfb57a6c-8db7-4ab5-9d51-eec40cf8662e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746744352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zLrDmNRPDlp9ApamVxJavibI7Ej0iwc88PKAJoessY=;
	b=rbui3bY13NbbvkEFY4U4IDhY6PQ4MkQDV8Ny74RuhuERdEElVBZrLnJLZ+eMo3jsHBBsXG
	+2BtXVvxsRyoQYKz0ygcR7tXSVoxxLSR6nMSqqJiFUyz58n/eMozy1tOufWdNNlWpR/sLz
	PZs4V8gfxkQ13Ya+4NAyoBwfcs5Co+M=
Date: Thu, 8 May 2025 23:45:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 22:10, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the intel ixp4xx ethernet driver to the new API, so that
> the ndo_eth_ioctl() path can be removed completely.
> 
> hwtstamp_get() and hwtstamp_set() are only called if netif_running()
> when the code path is engaged through the legacy ioctl. As I don't
> want to make an unnecessary functional change which I can't test,
> preserve that restriction when going through the new operations.
> 
> When cpu_is_ixp46x() is false, the execution of SIOCGHWTSTAMP and
> SIOCSHWTSTAMP falls through to phy_mii_ioctl(), which may process it in
> case of a timestamping PHY, or may return -EOPNOTSUPP. In the new API,
> the core handles timestamping PHYs directly and does not call the netdev
> driver, so just return -EOPNOTSUPP directly for equivalent logic.
> 
> A gratuitous change I chose to do anyway is prefixing hwtstamp_get() and
> hwtstamp_set() with the driver name, ipx4xx. This reflects modern coding
> sensibilities, and we are touching the involved lines anyway.
> 
> The remainder of eth_ioctl() is exactly equivalent to
> phy_do_ioctl_running(), so use that.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/xscale/ixp4xx_eth.c | 61 +++++++++++-------------
>   1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> index a2ab1c150822..e1e7f65553e7 100644
> --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> @@ -394,16 +394,20 @@ static void ixp_tx_timestamp(struct port *port, struct sk_buff *skb)
>   	__raw_writel(TX_SNAPSHOT_LOCKED, &regs->channel[ch].ch_event);
>   }
>   
> -static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
> +static int ixp4xx_hwtstamp_set(struct net_device *netdev,
> +			       struct kernel_hwtstamp_config *cfg,
> +			       struct netlink_ext_ack *extack)
>   {
> -	struct hwtstamp_config cfg;
>   	struct ixp46x_ts_regs *regs;
>   	struct port *port = netdev_priv(netdev);
>   	int ret;
>   	int ch;
>   
> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> +	if (!cpu_is_ixp46x())
> +		return -EOPNOTSUPP;
> +
> +	if (!netif_running(netdev))
> +		return -EINVAL;
>   
>   	ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>   	if (ret)
> @@ -412,10 +416,10 @@ static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
>   	ch = PORT2CHANNEL(port);
>   	regs = port->timesync_regs;
>   
> -	if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
> +	if (cfg->tx_type != HWTSTAMP_TX_OFF && cfg->tx_type != HWTSTAMP_TX_ON)
>   		return -ERANGE;
>   
> -	switch (cfg.rx_filter) {
> +	switch (cfg->rx_filter) {
>   	case HWTSTAMP_FILTER_NONE:
>   		port->hwts_rx_en = 0;
>   		break;
> @@ -431,39 +435,45 @@ static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
>   		return -ERANGE;
>   	}
>   
> -	port->hwts_tx_en = cfg.tx_type == HWTSTAMP_TX_ON;
> +	port->hwts_tx_en = cfg->tx_type == HWTSTAMP_TX_ON;
>   
>   	/* Clear out any old time stamps. */
>   	__raw_writel(TX_SNAPSHOT_LOCKED | RX_SNAPSHOT_LOCKED,
>   		     &regs->channel[ch].ch_event);
>   
> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>   }
>   
> -static int hwtstamp_get(struct net_device *netdev, struct ifreq *ifr)
> +static int ixp4xx_hwtstamp_get(struct net_device *netdev,
> +			       struct kernel_hwtstamp_config *cfg)
>   {
> -	struct hwtstamp_config cfg;
>   	struct port *port = netdev_priv(netdev);
>   
> -	cfg.flags = 0;
> -	cfg.tx_type = port->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
> +	if (!cpu_is_ixp46x())
> +		return -EOPNOTSUPP;
> +
> +	if (!netif_running(netdev))
> +		return -EINVAL;

One interesting fact is that phy_do_ioctl_running() will return -ENODEV
in case of !netif_running(netdev) while previous code would return
-EINVAL. Probably it's ok, but may be it's better to have consistent
error path for both options.

Otherwise LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


> +
> +	cfg->flags = 0;
> +	cfg->tx_type = port->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
>   
>   	switch (port->hwts_rx_en) {
>   	case 0:
> -		cfg.rx_filter = HWTSTAMP_FILTER_NONE;
> +		cfg->rx_filter = HWTSTAMP_FILTER_NONE;
>   		break;
>   	case PTP_SLAVE_MODE:
> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
>   		break;
>   	case PTP_MASTER_MODE:
> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
>   		break;
>   	default:
>   		WARN_ON_ONCE(1);
>   		return -ERANGE;
>   	}
>   
> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>   }
>   
>   static int ixp4xx_mdio_cmd(struct mii_bus *bus, int phy_id, int location,
> @@ -985,21 +995,6 @@ static void eth_set_mcast_list(struct net_device *dev)
>   }
>   
>   
> -static int eth_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
> -{
> -	if (!netif_running(dev))
> -		return -EINVAL;
> -
> -	if (cpu_is_ixp46x()) {
> -		if (cmd == SIOCSHWTSTAMP)
> -			return hwtstamp_set(dev, req);
> -		if (cmd == SIOCGHWTSTAMP)
> -			return hwtstamp_get(dev, req);
> -	}
> -
> -	return phy_mii_ioctl(dev->phydev, req, cmd);
> -}
> -
>   /* ethtool support */
>   
>   static void ixp4xx_get_drvinfo(struct net_device *dev,
> @@ -1433,9 +1428,11 @@ static const struct net_device_ops ixp4xx_netdev_ops = {
>   	.ndo_change_mtu = ixp4xx_eth_change_mtu,
>   	.ndo_start_xmit = eth_xmit,
>   	.ndo_set_rx_mode = eth_set_mcast_list,
> -	.ndo_eth_ioctl = eth_ioctl,
> +	.ndo_eth_ioctl = phy_do_ioctl_running,
>   	.ndo_set_mac_address = eth_mac_addr,
>   	.ndo_validate_addr = eth_validate_addr,
> +	.ndo_hwtstamp_get = ixp4xx_hwtstamp_get,
> +	.ndo_hwtstamp_set = ixp4xx_hwtstamp_set,
>   };
>   
>   static struct eth_plat_info *ixp4xx_of_get_platdata(struct device *dev)


