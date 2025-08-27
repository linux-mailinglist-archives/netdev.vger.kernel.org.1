Return-Path: <netdev+bounces-217427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF7B38A33
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598203A508E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBB2E92D2;
	Wed, 27 Aug 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8c0BkHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EB1B4F1F;
	Wed, 27 Aug 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322901; cv=none; b=F6QKcMBEmpO/YIWxmOpPIcSqRCEmVtG9BCJyeWxmtNkcN/ASFKT32gPHgwJ5gYldVLmxuIkaZ2wQOplx/0p3GFigWQhQf1heZrXYJQIa6ump4/Izb0eCXQu9MxfJGV0/SRPBi2xGtCxzYZyjJ19gHPgrQRxq7HOHCFlFkUz9S2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322901; c=relaxed/simple;
	bh=CPWLRl5BO9/nJa55iDTHPc76PA354nWBWQeRZkn8TUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYVionBeUhciWVfPSBT62rlFye0LTXrYwcVWCW6viw1sTV3bXeh73RyIKLxazQy4WksUuRGx6swv+x+e35Y5T0pOtWZf32c7JF0/6pl4XJIp2WT6+cm09sRTk7DpCTWkXOQcrN0CIME1aIYxA7eaL5XKgC0IqBnKVG9LTMRQaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8c0BkHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043C0C4CEF4;
	Wed, 27 Aug 2025 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756322901;
	bh=CPWLRl5BO9/nJa55iDTHPc76PA354nWBWQeRZkn8TUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8c0BkHhitpLACHEWY8u0X+J0AJOhkMBalOELzx2q0RqC4GH0Jc6wS7BI1O9C1/ZO
	 68VIevA1L/h/od30KzFkja/KON1dXvbgCAf5SWWJWjPC7tOVu6DIBX6kjfBc4CDUQN
	 dJqbuwmq+DgJX+k1cMw1udsks8xiBRap/sdLrlr44eNsABP/ulfdwnCNupg9Okc6xC
	 P67bDHRX5+bfiv9E9HZ8si0kt36mpoVXSx2GBdNS4YyttCVmIuG3ARaRX5FjaAdsFK
	 BnsKdl3gR6xLaXjFEs/1nKVLgYswQiR8K+jUfyKa52v4qQGUd16JwX7g0jyFWwU+11
	 x3ceT0QLdXR5w==
Date: Wed, 27 Aug 2025 20:28:16 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net-next 4/7] net: stmmac: enable ARP Offload on
 mac_link_up()
Message-ID: <20250827192816.GR10519@horms.kernel.org>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <20250826113247.3481273-5-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826113247.3481273-5-konrad.leszczynski@intel.com>

On Tue, Aug 26, 2025 at 01:32:44PM +0200, Konrad Leszczynski wrote:
> From: Karol Jurczenia <karol.jurczenia@intel.com>
> 
> Add Address Resolution Protocol (ARP) Offload support in
> stmmac_mac_link_up() to enable ARP Offload beside the selftests.
> 
> Introduce STMMAC_FLAG_ARP_OFFLOAD_EN flag, which is used to enable the
> feature with the stmmac_set_arp_offload().
> 
> Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>

Konrad,

AFAIK, as you are posting this patches, your SoB line needs to go here.
(And correspondingly, your Reviewed-by line should be removed.)

...

> @@ -1075,6 +1078,20 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  
>  	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>  		stmmac_hwtstamp_correct_latency(priv, priv);
> +
> +	if (priv->plat->flags & STMMAC_FLAG_ARP_OFFLOAD_EN) {
> +		in_dev = in_dev_get(priv->dev);
> +		if (!in_dev)
> +			return;
> +
> +		ifa = in_dev->ifa_list;

ifa_list is protected by RCU, so I think the code needs to take that into
account. E.g. by doing the following and making sure that the RCU read lock
is held.

		ifa = rcu_dereference(idev->ifa_list);

Flagged by Sparse.


> +		if (!ifa)
> +			return;
> +
> +		stmmac_set_arp_offload(priv, priv->hw, true,
> +				       ntohl(ifa->ifa_address));
> +		in_dev_put(in_dev);
> +	}
>  }
>  
>  static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 26ddf95d23f9..aae522f37710 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -185,6 +185,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>  #define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
> +#define STMMAC_FLAG_ARP_OFFLOAD_EN		BIT(14)

I see that the following patch in this series also makes use of this bit.
But I don't see any thing (platform) that sets this bit. Perhaps I'm
missing something. But I think that would be best included in the patchset
that adds this bit.

>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.34.1
> 
> 

