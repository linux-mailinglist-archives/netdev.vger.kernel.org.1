Return-Path: <netdev+bounces-190549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648DAB77E5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6517ABF48
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE529617F;
	Wed, 14 May 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e1+ImrDg"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2A1F0E47
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257912; cv=none; b=iBCdh/EHzhOMELi+NQ4iCozJMoy7BK7mDAcCbjGapW3eHeQ3N56rsFEyS4eVup6tR7af3PJG7zILtZlsg3zMsZUhm1t7Iil220xuGOB6hRTrlxVAysP/lfWYmdv/cv+W/04WKt6aC2fv3KVBSwP7Bx4oFsk3dOr5+/f0wSSLFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257912; c=relaxed/simple;
	bh=dLhBTXIfl0GiFUM2RiZ+CX1bZMoSSQdq1tA2vLy65jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqSXdU05/6Jmc6qHfAVtvfrvhW9nS0lYrUmG49ZVT4hjGKF8xOjfj2AzZiVKXkXvz8qdskytcK5L9jLdL+xLipUJcs+fEsaG2/zLyoGa88u7pJZG1s5aF5hB6AuznBfl9l+BGUo3GS7USSs/+kH69qcGZAvS8AwkKs9RZ3dz7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e1+ImrDg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68aefcfc-8a3b-49d0-94f9-072ce06a28df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747257906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Biii5glISgVJCTj4wlkOB7kHjPTzjh4lkAX1byuQYwA=;
	b=e1+ImrDgHzlUtAiw4cs2vRCr9HBzEK63fFImQUSJeUoNE9c6e+RDZ1lECdbagv8S8WTY3N
	NKMCdrn1RxwSyZ8LHGi/GjAxLfgqK9dgDUnHW9yYA8t0+uTs0vDTuAP+voogXAalUMS/1r
	Et20BU+U28g+2ku12seueByvJHxJMwk=
Date: Wed, 14 May 2025 22:25:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: lan743x: convert to ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/05/2025 16:19, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the lan743x driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl()
> path completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/microchip/lan743x_main.c |  3 +-
>   drivers/net/ethernet/microchip/lan743x_ptp.c  | 32 +++++--------------
>   drivers/net/ethernet/microchip/lan743x_ptp.h  |  4 ++-
>   3 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 73dfc85fa67e..b01695bf4f55 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3351,8 +3351,6 @@ static int lan743x_netdev_ioctl(struct net_device *netdev,
>   
>   	if (!netif_running(netdev))
>   		return -EINVAL;
> -	if (cmd == SIOCSHWTSTAMP)
> -		return lan743x_ptp_ioctl(netdev, ifr, cmd);
>   
>   	return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
>   }
> @@ -3447,6 +3445,7 @@ static const struct net_device_ops lan743x_netdev_ops = {
>   	.ndo_change_mtu		= lan743x_netdev_change_mtu,
>   	.ndo_get_stats64	= lan743x_netdev_get_stats64,
>   	.ndo_set_mac_address	= lan743x_netdev_set_mac_address,
> +	.ndo_hwtstamp_set	= lan743x_ptp_hwtstamp_set,
>   };
>   
>   static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
> index b07f5b099a2b..026d1660fd74 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
> @@ -1736,23 +1736,14 @@ void lan743x_ptp_tx_timestamp_skb(struct lan743x_adapter *adapter,
>   	lan743x_ptp_tx_ts_complete(adapter);
>   }
>   
> -int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack)
>   {
>   	struct lan743x_adapter *adapter = netdev_priv(netdev);
> -	struct hwtstamp_config config;
> -	int ret = 0;
>   	int index;
>   
> -	if (!ifr) {
> -		netif_err(adapter, drv, adapter->netdev,
> -			  "SIOCSHWTSTAMP, ifr == NULL\n");
> -		return -EINVAL;
> -	}
> -
> -	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> -		return -EFAULT;
> -
> -	switch (config.tx_type) {
> +	switch (config->tx_type) {
>   	case HWTSTAMP_TX_OFF:
>   		for (index = 0; index < adapter->used_tx_channels;
>   		     index++)
> @@ -1776,19 +1767,12 @@ int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>   		lan743x_ptp_set_sync_ts_insert(adapter, true);
>   		break;
>   	case HWTSTAMP_TX_ONESTEP_P2P:
> -		ret = -ERANGE;
> -		break;
> +		return -ERANGE;
>   	default:
>   		netif_warn(adapter, drv, adapter->netdev,
> -			   "  tx_type = %d, UNKNOWN\n", config.tx_type);
> -		ret = -EINVAL;
> -		break;
> +			   "  tx_type = %d, UNKNOWN\n", config->tx_type);
> +		return -EINVAL;

nit: can be easily transformed to extack, but I can do it later as a
follow-up

>   	}
>   
> -	ret = lan743x_rx_set_tstamp_mode(adapter, config.rx_filter);
> -
> -	if (!ret)
> -		return copy_to_user(ifr->ifr_data, &config,
> -			sizeof(config)) ? -EFAULT : 0;
> -	return ret;
> +	return lan743x_rx_set_tstamp_mode(adapter, config->rx_filter);
>   }
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
> index 0d29914cd460..9581a7992ff6 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.h
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
> @@ -52,7 +52,9 @@ void lan743x_ptp_close(struct lan743x_adapter *adapter);
>   void lan743x_ptp_update_latency(struct lan743x_adapter *adapter,
>   				u32 link_speed);
>   
> -int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> +int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack);
>   
>   #define LAN743X_PTP_NUMBER_OF_TX_TIMESTAMPS (4)
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

