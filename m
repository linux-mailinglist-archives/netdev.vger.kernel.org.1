Return-Path: <netdev+bounces-143302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42139C1E1C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FFF288FEA
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113381E907A;
	Fri,  8 Nov 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbdEmcmP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91F192B95;
	Fri,  8 Nov 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072651; cv=none; b=alcJK2YgsvhdjKpF2kEL1mbBJQiItJhwG96iRAazjmU54z/aKt40pTEkeEOSl3kAyX2WrzE4n20xbhEywE5ROzYbT5bOVUj84Top0O+3pJ1LU2hmgBjj4gwqB4oIaN9BG0+QBMf49Vg4Itc4aybXrRtN2LC4D9TMNawatqr/Odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072651; c=relaxed/simple;
	bh=TV7tQY4wboLhy0g0stdHI8twRDkbQn0BDxeQXTe8Ifo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEQ0DebfswLpdd/lAMpUfH64s4KbrwW8VJvXd8Ka4R0ESQVZG+HGSGFZr7ZDC+Qx95XpTUz8G3BRuQVaAU/X+0JegnMC5Wq67xmOQNupkq2jtK4yZvANkPZnt/ElSFuIEv5l7QWZsoMGOa81nuvKxOzc+ndV6m1QvkYGuE/eTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbdEmcmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1832EC4CECD;
	Fri,  8 Nov 2024 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731072650;
	bh=TV7tQY4wboLhy0g0stdHI8twRDkbQn0BDxeQXTe8Ifo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbdEmcmPdFwfI9Ika8/S38CQc7m8+KAdEPhU+mJyP4bhAEYncCpBsmGi4NO4EH/UG
	 6TrYJAPWRmsbivDUM2STEyd6hUveECepSwzHHTAsQcEkhCyCIJIO7Ienj5J0n9Wvco
	 R8wB2QpgBE3C8OCNKAd9Aa1v0UdH+kKmWoxYkItcLCx+k1vszXz40yPkLGVc2FTEmb
	 hVp3exzKgUcHDnRgXDFNz/jZc3Ss2a48SIfxoGA1i21jX+HGTj86BsApu31jywUYgR
	 NX3toa4QQGIHjTkeeWLFcKsI1aTWvnbaBIA69W9Je/mx9wIN0T2j2JA5m1UfjBH6QV
	 gkV6SuE+rstKg==
Date: Fri, 8 Nov 2024 13:30:44 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, m-karicheri2@ti.com, jan.kiszka@siemens.com,
	javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
	diogo.ivo@siemens.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
Message-ID: <20241108133044.GB4507@kernel.org>
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074040.3361730-2-m-malladi@ti.com>

On Wed, Nov 06, 2024 at 01:10:39PM +0530, Meghana Malladi wrote:
> From: MD Danish Anwar <danishanwar@ti.com>
> 
> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
> and SLICE1. Currently whenever any ICSSG interface comes up we load the
> respective firmwares to PRU cores and whenever interface goes down, we
> stop the respective cores. Due to this, when SLICE0 goes down while
> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
> stopped. This results in clock jump for SLICE1 interface as the timesync
> related operations are no longer running.
> 
> Fix this by running both PRU0 and PRU1 firmwares as long as at least 1
> ICSSG interface is up.
> 
> rx_flow_id is updated before firmware is loaded. Once firmware is loaded,
> it reads the flow_id and uses it for rx. emac_fdb_flow_id_updated() is
> used to let firmware know that the flow_id has been updated and to use the
> latest rx_flow_id.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 0556910938fa..9df67539285b 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -534,6 +534,7 @@ static int emac_ndo_open(struct net_device *ndev)
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  	int ret, i, num_data_chn = emac->tx_ch_num;
> +	struct icssg_flow_cfg __iomem *flow_cfg;
>  	struct prueth *prueth = emac->prueth;
>  	int slice = prueth_emac_slice(emac);
>  	struct device *dev = prueth->dev;
> @@ -549,8 +550,12 @@ static int emac_ndo_open(struct net_device *ndev)
>  	/* set h/w MAC as user might have re-configured */
>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>  
> +	if (!prueth->emacs_initialized) {
> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
> +	}
> +
>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
> -	icssg_class_default(prueth->miig_rt, slice, 0, false);
>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>  
>  	/* Notify the stack of the actual queue counts. */
> @@ -588,10 +593,31 @@ static int emac_ndo_open(struct net_device *ndev)
>  		goto cleanup_napi;
>  	}
>  
> -	/* reset and start PRU firmware */
> -	ret = prueth_emac_start(prueth, emac);
> -	if (ret)
> -		goto free_rx_irq;
> +	if (!prueth->emacs_initialized) {
> +		if (prueth->emac[ICSS_SLICE0]) {
> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE0]);

I wonder if it is worth simplifying this by having prueth_emac_start()
check if it's 2nd parameter is NULL. Likewise for prueth_emac_stop().

> +			if (ret) {
> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE0);
> +				goto free_rx_irq;
> +			}
> +		}
> +		if (prueth->emac[ICSS_SLICE1]) {
> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE1]);
> +			if (ret) {
> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE1);
> +				goto halt_slice0_prus;
> +			}
> +		}
> +	}
> +
> +	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
> +	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
> +	ret = emac_fdb_flow_id_updated(emac);
> +
> +	if (ret) {
> +		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
> +		goto stop;

Branching to stop may result in calls to prueth_emac_stop() which does not
seem symmetrical with the condition on prueth->emacs_initialized for calls
to prueth_emac_start() above.

If so, is this intended?

> +	}
>  
>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>  

...

