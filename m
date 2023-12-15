Return-Path: <netdev+bounces-57902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93115814742
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52771C22E84
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C0250F3;
	Fri, 15 Dec 2023 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPD02VnO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865024B52
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64740C433C7;
	Fri, 15 Dec 2023 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702640983;
	bh=9ZZ9pO+YZPFZrj/cpV6/L1X+dL6XlkD9xAXgSvhyXQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPD02VnO8hnpYa1PMeVsniaCeEa0jwPJsyQTGfjzn1/Pw+QpycytRq091fnSwkEnz
	 cdQz1qcPE+/V6UhP7u+bHGKP0QDTkq0O/EzqHSBs6/CpJDED6tRng8PeRKYSYKiGTA
	 1czKWvU9LlrADqvsF2EGdq7JHh972EJOpZeUYQpgaXQCYFyKDKAMPz8NW4z+diIBBE
	 KR8byVJgG0LBktmAb+5LkIr8Y1f80oHCk0tBaq8y3ASGEY2nTMoBu2yukQnPlHEVix
	 q22kAeKVCIUt2frsZaUQcCTufWNCJSpWTzik7qutqCJSQa4A52zOQFhkpAWtQrfsAa
	 zMIlTjrBl+8tw==
Date: Fri, 15 Dec 2023 11:49:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/8] dpaa2-switch: reorganize the
 [pre]changeupper events
Message-ID: <20231215114939.GB6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-7-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-7-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:09PM +0200, Ioana Ciornei wrote:
> Create separate functions, dpaa2_switch_port_prechangeupper and
> dpaa2_switch_port_changeupper, to be called directly when a DPSW port
> changes its upper device.
> 
> This way we are not open-coding everything in the main event callback
> and we can easily extent when necessary.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
> - none
> 
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 76 +++++++++++++------
>  1 file changed, 52 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index d9906573f71f..58c0baee2d61 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2180,51 +2180,79 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
>  	return 0;
>  }
>  
> -static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
> -					     unsigned long event, void *ptr)
> +static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
> +					    struct netdev_notifier_changeupper_info *info)
>  {
> -	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> -	struct netdev_notifier_changeupper_info *info = ptr;
>  	struct netlink_ext_ack *extack;
>  	struct net_device *upper_dev;
>  	int err = 0;

nit: I don't think that err needs to be initialised here.

>  
>  	if (!dpaa2_switch_port_dev_check(netdev))
> -		return NOTIFY_DONE;
> +		return 0;
>  
>  	extack = netdev_notifier_info_to_extack(&info->info);
> -
> -	switch (event) {
> -	case NETDEV_PRECHANGEUPPER:
> -		upper_dev = info->upper_dev;
> -		if (!netif_is_bridge_master(upper_dev))
> -			break;
> -
> +	upper_dev = info->upper_dev;
> +	if (netif_is_bridge_master(upper_dev)) {
>  		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
>  								upper_dev,
>  								extack);
>  		if (err)
> -			goto out;
> +			return err;
>  
>  		if (!info->linking)
>  			dpaa2_switch_port_pre_bridge_leave(netdev);
> +	}

FWIIW, I think that a more idomatic flow would be to return if
netif_is_bridge_master() is false. Something like this (completely untested!):

	if (!netif_is_bridge_master(upper_dev))
		return 0;

	err = dpaa2_switch_prechangeupper_sanity_checks(netdev, upper_dev,
							extack);
	if (err)
		return err;

	if (!info->linking)
		dpaa2_switch_port_pre_bridge_leave(netdev);

> +
> +	return 0;
> +}
> +
> +static int dpaa2_switch_port_changeupper(struct net_device *netdev,
> +					 struct netdev_notifier_changeupper_info *info)
> +{
> +	struct netlink_ext_ack *extack;
> +	struct net_device *upper_dev;
> +	int err = 0;

nit: I don't think err is needed in this function it's value never changes.

> +
> +	if (!dpaa2_switch_port_dev_check(netdev))
> +		return 0;
> +
> +	extack = netdev_notifier_info_to_extack(&info->info);
> +
> +	upper_dev = info->upper_dev;
> +	if (netif_is_bridge_master(upper_dev)) {
> +		if (info->linking)
> +			return dpaa2_switch_port_bridge_join(netdev,
> +							     upper_dev,
> +							     extack);
> +		else
> +			return dpaa2_switch_port_bridge_leave(netdev);
> +	}
> +
> +	return err;
> +}

In a similar vein to my comment above, FWIIW, I would have
gone for something more like this (completely untested!).

	if (!netif_is_bridge_master(upper_dev))
		return 0;

	if (info->linking)
		return dpaa2_switch_port_bridge_join(netdev, upper_dev,
						     extack);

	return dpaa2_switch_port_bridge_leave(netdev);

> +
> +static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
> +					     unsigned long event, void *ptr)
> +{
> +	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> +	int err = 0;
> +
> +	switch (event) {
> +	case NETDEV_PRECHANGEUPPER:
> +		err = dpaa2_switch_port_prechangeupper(netdev, ptr);
> +		if (err)
> +			return notifier_from_errno(err);
>  
>  		break;
>  	case NETDEV_CHANGEUPPER:
> -		upper_dev = info->upper_dev;
> -		if (netif_is_bridge_master(upper_dev)) {
> -			if (info->linking)
> -				err = dpaa2_switch_port_bridge_join(netdev,
> -								    upper_dev,
> -								    extack);
> -			else
> -				err = dpaa2_switch_port_bridge_leave(netdev);
> -		}
> +		err = dpaa2_switch_port_changeupper(netdev, ptr);
> +		if (err)
> +			return notifier_from_errno(err);
> +
>  		break;
>  	}
>  
> -out:
> -	return notifier_from_errno(err);
> +	return NOTIFY_DONE;
>  }
>  
>  struct ethsw_switchdev_event_work {
> -- 
> 2.34.1
> 

