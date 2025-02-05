Return-Path: <netdev+bounces-163136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE6A29659
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA5B163476
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145891FDA9D;
	Wed,  5 Feb 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX62JWXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE411FDA6D;
	Wed,  5 Feb 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772925; cv=none; b=R/TCFkfE+WOVFH9Sm0q+pwNg9+6THtdYNFy0tuPhGUIOELt+36K5xDCcqv29jLc5AfH3SSxWHyrfQ0FGD3z8umZqQYwGz2NmP1qyFhVBnjhNi9WlnzdEePTXlVrn0AE4Dkr6CJfqOc3cyTKqxNdKpk2EsmO5SPVxR2+i+SKPWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772925; c=relaxed/simple;
	bh=AsTcitZF5xSknPL05zHTxt9j1oHoMRMlOjYB1qmggDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgGgCI0OdHHzrrgl7I0c7sRTW6tN2F7lu4Oez9PxEkWMkRaMh4HFxuCa8bzOQ1fCP45Yv8GjkEM6KNsodzb7H+6EJ8Qy7y7+jOQvKMahorm4//076+SEP6tM2KibWdWThNVMgsLHfzTUWWSKxc+xRXtZw/ReP1vTXIoTt6LAWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX62JWXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0840C4CEE2;
	Wed,  5 Feb 2025 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738772924;
	bh=AsTcitZF5xSknPL05zHTxt9j1oHoMRMlOjYB1qmggDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PX62JWXBfArHum/7IqLbQ2IEzVIQc2gxZWLiqvoTrXhp0wM2hpKT9oj3Y+OLUI5Mp
	 zSDsP7jZLM9eM0zPJLA3rHXNVpSmkfzDWN4V+t2LErS/zsRtp777tIJfenuhXn/Co9
	 S3vY5L3Q80nDNWUWqDEtphogMok657SIbriLruFggbjBhWktBf6U6CRzfX2NX+oEAG
	 WA/XxZ1+n99hBCy35Fjm7mGkY4WOZtJm97wXF/M/4VZzG2GdaZiNjDFzqkMJUrkcd7
	 GDMqtSZAAbZvvqQFiMUFsoCicbYAWBm2a4MiJmrFIkjv5xmdv7heLphUbudNZgK5DL
	 u/GFv6zoefDUw==
Date: Wed, 5 Feb 2025 16:28:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com,
	shailend@google.com, andrew+netdev@lunn.ch, willemb@google.com,
	hramamurthy@google.com, ziweixiao@google.com,
	linux-kernel@vger.kernel.org, Jeroen de Borst <jeroend@google.com>
Subject: Re: [PATCH net-next v2] gve: Add RSS cache for non RSS device option
 scenario
Message-ID: <20250205162839.GH554665@kernel.org>
References: <20250204213121.14195-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204213121.14195-1-jeroendb@google.com>

On Tue, Feb 04, 2025 at 01:31:21PM -0800, Jeroen de Borst wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> Not all the devices have the capability for the driver to query for the
> registered RSS configuration. The driver can discover this by checking
> the relevant device option during setup. If it cannot, the driver needs
> to store the RSS config cache and directly return such cache when
> queried by the ethtool. RSS config is inited when driver probes. Also the
> default RSS config will be adjusted when there is RX queue count change.
> 
> At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
> GVE_RSS_INDIR_SIZE are supported.
> 
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Jeroen de Borst <jeroend@google.com>
> ---
> Changes in v2:
>  - Change to initialize RSS config when the driver is up instead of
>    doing that when the user setting the RSS.(Jakub Kicinski)
>  - Use NL_SET_ERR_MSG_MOD to log errors when there is extack
>    available.(Jakub Kicinski)
>  - Use ethtool_rxfh_indir_default to set default RSS indir
>    table.(Jakub Kicinski)
>  - Adjust the default RSS config when there is RX queue count change to
>    ensure the default RSS config is correct.
> 
>  drivers/net/ethernet/google/gve/gve.h         | 16 +++-
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 60 ++++++++++--
>  drivers/net/ethernet/google/gve/gve_main.c    | 92 ++++++++++++++++++-
>  4 files changed, 209 insertions(+), 23 deletions(-)

...

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index bdfc6e77b2af..efcafc607b2a 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -482,6 +482,7 @@ static int gve_set_channels(struct net_device *netdev,
>  	struct ethtool_channels old_settings;
>  	int new_tx = cmd->tx_count;
>  	int new_rx = cmd->rx_count;
> +	bool reset_rss;
>  
>  	gve_get_channels(netdev, &old_settings);
>  
> @@ -498,16 +499,14 @@ static int gve_set_channels(struct net_device *netdev,
>  		return -EINVAL;
>  	}
>  
> -	if (!netif_running(netdev)) {
> -		priv->tx_cfg.num_queues = new_tx;
> -		priv->rx_cfg.num_queues = new_rx;
> -		return 0;
> -	}
> +	if (new_rx != priv->rx_cfg.num_queues &&
> +	    priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
> +		reset_rss = true;

Hi Jerome,

This is not a full review (which I was working on but ran out of time for now).
But, if the condition above is not met then reset_rss will be used
uninitialised below.

Flagged by W=1 build with clang-19.

>  
>  	new_tx_cfg.num_queues = new_tx;
>  	new_rx_cfg.num_queues = new_rx;
>  
> -	return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg);
> +	return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
>  }
>  
>  static void gve_get_ringparam(struct net_device *netdev,

...

-- 
pw-bot: cr

