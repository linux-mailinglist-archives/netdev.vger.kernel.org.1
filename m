Return-Path: <netdev+bounces-16710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4874E7A2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396F6281504
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC71171A6;
	Tue, 11 Jul 2023 07:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B0171A4
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A902C433C7;
	Tue, 11 Jul 2023 07:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689058998;
	bh=huqmAHUdnAKdx0vgAkYyqtri1i014cHYTqLL1Kf9RoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=It3Lodd6o3FGP8B5+FfkmM60aimZHdYmrbHQO/w1S+ED7X7U47IQwDipvcIUOKUVs
	 3wll++EdwbXtchXNVuMv6zcF0JzQFmnROru4byx1UQLUHUxMN+0Saoz6S9pHwFnoPC
	 Sb2jrLrAERXCVyXYkCsS2CvVxLWE3nEvv4OS4mR8kTijxaS/TtI0mtndUib6i1gLwn
	 eVcp1FkgQ0G7Cv0wYok5ZHGoxrNX98hUeMJVhJ84dRcz7InR7UeLts3ydBATAiWViv
	 GMsD/KRLWTRA+8j5Ld81WxZaSK7xuxEJojzunL/9b1JX48SV28+O10g0bwk2/hQxpa
	 hQUhkSdbfMhSw==
Date: Tue, 11 Jul 2023 10:03:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 2/6] igc: Do not enable taprio offload for invalid
 arguments
Message-ID: <20230711070310.GD41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-3-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:34:59AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> Only set adapter->taprio_offload_enable after validating the arguments.
> Otherwise, it stays set even if the offload was not enabled.
> Since the subsequent code does not get executed in case of invalid
> arguments, it will not be read at first.
> However, by activating and then deactivating another offload
> (e.g. ETF/TX launchtime offload), taprio_offload_enable is read
> and erroneously keeps the offload feature of the NIC enabled.
> 
> This can be reproduced as follows:
> 
>     # TAPRIO offload (flags == 0x2) and negative base-time leading to expected -ERANGE
>     sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time -1000 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
>     # IGC_TQAVCTRL is 0x0 as expected (iomem=relaxed for reading register)
>     sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
>     # Activate ETF offload
>     sudo tc qdisc replace dev enp1s0 parent root handle 6666 mqprio \
> 	    num_tc 3 \
> 	    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
> 	    queues 1@0 1@1 2@2 \
> 	    hw 0
>     sudo tc qdisc add dev enp1s0 parent 6666:1 etf \
> 	    clockid CLOCK_TAI \
> 	    delta 500000 \
> 	    offload
> 
>     # IGC_TQAVCTRL is 0x9 as expected
>     sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
>     # Deactivate ETF offload again
>     sudo tc qdisc delete dev enp1s0 parent 6666:1
> 
>     # IGC_TQAVCTRL should now be 0x0 again, but is observed as 0x9
>     sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index fae534ef1c4f..fb8e55c7c402 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6097,6 +6097,7 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
>  
>  	adapter->base_time = 0;
>  	adapter->cycle_time = NSEC_PER_SEC;
> +	adapter->taprio_offload_enable = false;
>  	adapter->qbv_config_change_errors = 0;
>  	adapter->qbv_transition = false;
>  	adapter->qbv_count = 0;
> @@ -6124,20 +6125,12 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  	size_t n;
>  	int i;
>  
> -	switch (qopt->cmd) {
> -	case TAPRIO_CMD_REPLACE:
> -		adapter->taprio_offload_enable = true;
> -		break;
> -	case TAPRIO_CMD_DESTROY:
> -		adapter->taprio_offload_enable = false;
> -		break;
> -	default:
> -		return -EOPNOTSUPP;
> -	}

All this deleted code was changed in the previous patch. It raises the
question again if previous patch was really needed to be sent to net.

Thanks

> -
> -	if (!adapter->taprio_offload_enable)
> +	if (qopt->cmd == TAPRIO_CMD_DESTROY)
>  		return igc_tsn_clear_schedule(adapter);
>  
> +	if (qopt->cmd != TAPRIO_CMD_REPLACE)
> +		return -EOPNOTSUPP;
> +
>  	if (qopt->base_time < 0)
>  		return -ERANGE;
>  
> @@ -6149,6 +6142,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  
>  	adapter->cycle_time = qopt->cycle_time;
>  	adapter->base_time = qopt->base_time;
> +	adapter->taprio_offload_enable = true;
>  
>  	igc_ptp_read(adapter, &now);
>  
> -- 
> 2.38.1
> 
> 

