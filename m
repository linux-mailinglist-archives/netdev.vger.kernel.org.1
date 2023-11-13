Return-Path: <netdev+bounces-47400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BB7EA167
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B4A1F21CD8
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E121A11;
	Mon, 13 Nov 2023 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnPyGvSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09D21A02
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A37C433C8;
	Mon, 13 Nov 2023 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699893728;
	bh=HqMXtrWSxjrCtdFd9atXD7V+Fi8AvvX+vHT85WZiBBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnPyGvSyT9ntR663bNXD5X30SvDQfzSECRWF8EldQveajlk47xSHlHgelt6tkCo/T
	 NWc8vlrrQtuxJSguZq6xliAmHd0V3tBpTj/TFzIBSWzL/76OIsxyRVoIQ7blZCUA1U
	 FMdalRP0D8ZXD5Ex+1FzvtTO2/B/dJUHE3Q6+ZTtgUBoTJe0WknV9wpnUQNsSyH9cB
	 w9Op67OljpQ44MYDz7Fx4Y2n36kKPveyptLlvQRANU5IWnFJj5WcZGClmBQq4iVrcx
	 Jrs6s8E0CVe5G4aWzcEhlUYWWc1IF5W/jue7JY9D2bj9klfHaA+uvYE6GNze/pojqN
	 kGU00h3RaHang==
Date: Mon, 13 Nov 2023 16:42:04 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: ethernet: am65-cpsw: Add standard
 Ethernet MAC stats to ethtool
Message-ID: <20231113164204.GB4482@kernel.org>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-2-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-2-rogerq@kernel.org>

On Mon, Nov 13, 2023 at 01:07:06PM +0200, Roger Quadros wrote:
> Gets 'ethtool -S eth0 --groups eth-mac' command to work.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index c51e2af91f69..ac7276f0f77a 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -662,6 +662,31 @@ static void am65_cpsw_get_ethtool_stats(struct net_device *ndev,
>  					hw_stats[i].offset);
>  }
>  
> +static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
> +					struct ethtool_eth_mac_stats *s)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_stats_regs *stats;

Hi Roger,

I think that stats needs an __iomem annotation
to address the issues flagged by Sparse.

drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15: warning: incorrect type in assignment (different address spaces)
drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15:    expected struct am65_cpsw_stats_regs *stats
drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15:    got void [noderef] __iomem *stat_base
drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34:    expected void const volatile [noderef] __iomem *addr
drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34:    got unsigned int *
...

> +
> +	stats = port->stat_base;
> +
> +	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
> +	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
> +	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
> +	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
> +	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
> +	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
> +	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
> +	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
> +	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
> +	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
> +	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
> +	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
> +	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
> +	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
> +	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
> +};
> +
>  static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
>  					 struct ethtool_ts_info *info)
>  {

...

