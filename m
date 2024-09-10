Return-Path: <netdev+bounces-126971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A949736EA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD8A2899A8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CC18F2F0;
	Tue, 10 Sep 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRxgIDYV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210F18C021;
	Tue, 10 Sep 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970348; cv=none; b=n06og0LgCPY6JSYiOvFr0MqZhYJd6MAhothbNk8X1f9RhthlSiPESsbVvoAAaipONYb3UdnbO4G5BA4LEA4zAE8XUr44XaC4QIAi/cPLXNrz8f2Lx7IqRwNCgZNUvMLV3DigC8rp7EULlZss4cW8rUpcbIBxsTA/lRIYukawEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970348; c=relaxed/simple;
	bh=nCmtNYl6PFgAuy/ejaKdSQO7yrl3z5VPdGNg+0ZOAfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1JGXJhh2U6rSNszxpGfvNsaZSExUONlKt6KZ5+nURclA91o1MgN6orm00uefjbqGpKNp3Uu7lzZNrGOcfHf2R5rRZu14MHgo2c7u/rRHzmIZeNA/d1nsMgL8Vwgl84fI7GGFzAizawZi84evEwoGhpxNCCknK+9waJJtqFLByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRxgIDYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBCC4CEC3;
	Tue, 10 Sep 2024 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725970347;
	bh=nCmtNYl6PFgAuy/ejaKdSQO7yrl3z5VPdGNg+0ZOAfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CRxgIDYVj++/7UYxRS/HCNsCyppNsagU+GRLfNKk60+GzgET4Wwkzf2KPmIXQysyS
	 fx5/Pe4jWANM0RtqGuZQ1a2Pna/XdU8+gy16Is74Gm4gnwyTad6+3NwVh0SNsUCuz3
	 3XZvm1T/+0mcs+kcfOGAFRnGX+vbuAea8kv9hF+JZMukpvyxcSguSRx0KXhS4cUyO4
	 CyYvIH6p/HmQvmcvsznbtwv5rOBmFQZcBB4ODM0zQ0rN/ZdB6SD/cHq/BYseWWi00y
	 AsFd56uvsbZSIPyiHdBo72aQ0ciXiMRzLP6ErGXOD42M7Ix/aywk/PVb260sRiRiR+
	 ztS1DceyhNLyw==
Message-ID: <cf462ca8-08bd-42bd-965a-88e28e63bb3f@kernel.org>
Date: Tue, 10 Sep 2024 15:12:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: MD Danish Anwar <danishanwar@ti.com>, robh@kernel.org,
 jan.kiszka@siemens.com, dan.carpenter@linaro.org, saikrishnag@marvell.com,
 andrew@lunn.ch, javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, horms@kernel.org, richardcochran@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
 <20240906111538.1259418-4-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240906111538.1259418-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 06/09/2024 14:15, MD Danish Anwar wrote:
> Add support for offloading HSR port-to-port frame forward to hardware.
> When the slave interfaces are added to the HSR interface, the PRU cores
> will be stopped and ICSSG HSR firmwares will be loaded to them.
> 
> Similarly, when HSR interface is deleted, the PRU cores will be
> restarted and the last used firmwares will be reloaded. PRUeth
> interfaces will be back to the last used mode.
> 
> This commit also renames some APIs that are common between switch and
> hsr mode with '_fw_offload' suffix.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 132 +++++++++++++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
>  4 files changed, 145 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index 9ec504d976d6..833ca86d0b71 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c

<snip>

> +static void emac_change_hsr_feature(struct net_device *ndev,
> +				    netdev_features_t features,
> +				    u64 hsr_feature)
> +{
> +	netdev_features_t changed = ndev->features ^ features;
> +
> +	if (changed & hsr_feature) {
> +		if (features & hsr_feature)
> +			ndev->features |= hsr_feature;
> +		else
> +			ndev->features &= ~hsr_feature;

You are not supposed to change ndev->features here.

From
"https://www.kernel.org/doc/Documentation/networking/netdev-features.txt"
"
 * ndo_set_features:

Hardware should be reconfigured to match passed feature set. The set
should not be altered unless some error condition happens that can't
be reliably detected in ndo_fix_features. In this case, the callback
should update netdev->features to match resulting hardware state.
Errors returned are not (and cannot be) propagated anywhere except dmesg.
(Note: successful return is zero, >0 means silent error.)"

This means only in 

> +	}
> +}
> +
> +static int emac_ndo_set_features(struct net_device *ndev,
> +				 netdev_features_t features)
> +{
> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_FWD);
> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_DUP);
> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_INS);
> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_RM);

I don't understand this part. 

As you are not changing hardware state in ndo_set_features, I'm not sure why
you even need ndo_set_features callback.

You didn't take my feedback about using ndo_fix_features().

Please read this.
https://www.kernel.org/doc/Documentation/networking/netdev-features.txt
"Part II: Controlling enabled features"
"Part III: Implementation hints"

Also look at how _netdev_update_features() works and calls ndo_fix_features()
and ndo_set_features()

https://elixir.bootlin.com/linux/v6.11-rc7/source/net/core/dev.c#L10023

> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_open = emac_ndo_open,
>  	.ndo_stop = emac_ndo_stop,
> @@ -737,6 +780,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
> +	.ndo_set_features = emac_ndo_set_features,
>  };

<snip>

-- 
cheers,
-roger

