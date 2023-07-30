Return-Path: <netdev+bounces-22638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF776864C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5DC1C20A0C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F4DDCC;
	Sun, 30 Jul 2023 15:54:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F13D6C
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E67C433C8;
	Sun, 30 Jul 2023 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690732453;
	bh=S58IlEzSt3rXtvvlGpJo/6PUEpPcAViWr3iyEBRkPZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfdMSQXYAZZNamoQpUjIRC8v7zNQphOebgZAOxL11PHthG3o190dkkESqdikGNOkO
	 beMGTUfOd3c/c61Gsr+DgNtCqFe/64Rr6yd+jAGukZRKHg2bZAEtBD7xUVZ15VS9gE
	 70V6fBjbVIin/gFjVtHt9FCAQe6mL3+kKsIewP4aBahWg+auBYf8PfGAOurEySk2fB
	 ys0Do6RDnxRfJzHu1HNDDgupTtcm65AxJye8r2sZqjR9Ed/X1a6ByYmleSOXJ649ja
	 UrCk/S+VIFbXvTeEYfK1lmXp8KO65iFuZfwaPYhj/X7hEvT4ZU3y9h7xeNGJOrIQs1
	 SS58A10HVsbJA==
Date: Sun, 30 Jul 2023 17:54:09 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <ZMaHobBXLeJS0dsj@kernel.org>
References: <20230728170954.2445592-1-anthony.l.nguyen@intel.com>
 <20230728170954.2445592-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728170954.2445592-3-anthony.l.nguyen@intel.com>

On Fri, Jul 28, 2023 at 10:09:54AM -0700, Tony Nguyen wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> This patch enables users to modify the tx-usecs parameter.
> The rx-usecs value will adhere to the same value as tx-usecs
> if the queue pair setting is enabled.
> 
> How to test:
> User can set the coalesce value using ethtool command.
> 
> Example command:
> Set: ethtool -C <interface>
> 
> Previous output:
> 
> root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> netlink error: Invalid argument
> 
> New output:
> 
> root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> rx-usecs: 10
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 10
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 33 ++++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 62d925b26f2c..1cf7131a82c5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -914,6 +914,34 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
>  			adapter->flags &= ~IGC_FLAG_DMAC;
>  	}
>  
> +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +		u32 old_tx_itr, old_rx_itr;
> +
> +		/* This is to get back the original value before byte shifting */
> +		old_tx_itr = (adapter->tx_itr_setting <= 3) ?
> +			      adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
> +
> +		old_rx_itr = (adapter->rx_itr_setting <= 3) ?
> +			      adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
> +
> +		if (old_tx_itr != ec->tx_coalesce_usecs) {
> +			if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
> +				adapter->tx_itr_setting = ec->tx_coalesce_usecs;
> +			else
> +				adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
> +
> +			adapter->rx_itr_setting = adapter->tx_itr_setting;
> +		} else if (old_rx_itr != ec->rx_coalesce_usecs) {
> +			if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
> +				adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> +			else
> +				adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
> +
> +			adapter->tx_itr_setting = adapter->rx_itr_setting;
> +		}
> +		goto program_itr;

This goto seems fairly gratuitous to me.
Couldn't the code be refactored to avoid it,
f.e. by moving ~10 lines below into an else clause?

My main objection here is readability,
I have no objections about correctness.

> +	}
> +
>  	/* convert to rate of irq's per second */
>  	if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
>  		adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> @@ -921,13 +949,12 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
>  		adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
>  
>  	/* convert to rate of irq's per second */
> -	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS)
> -		adapter->tx_itr_setting = adapter->rx_itr_setting;
> -	else if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
> +	if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
>  		adapter->tx_itr_setting = ec->tx_coalesce_usecs;
>  	else
>  		adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
>  
> +program_itr:
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		struct igc_q_vector *q_vector = adapter->q_vector[i];
>  
> -- 
> 2.38.1
> 
> 

