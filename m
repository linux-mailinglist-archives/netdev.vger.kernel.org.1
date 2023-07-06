Return-Path: <netdev+bounces-15731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06097496DC
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C6128127A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F415BB;
	Thu,  6 Jul 2023 07:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED09184C
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2782DC433C7;
	Thu,  6 Jul 2023 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688630186;
	bh=ZlAkzPnv2sgTe5Q7jCVACU0AXlFuDcsq8sC63FRaqG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJRyX4MB0Ph6oKI74Mosp/YH4a6V4P4pkGN4Wvykq/waK+yLfKjKoYUVXBoLz7Xqe
	 2AjGWqZAUcrXgDe0t9S2b06DylO1t29ChAU+Oxr7+zYQsEHBfBwdjT/Fp7w1Hf3sC0
	 UrOEhj8omRhuaVIqC9X1icJBsVxQrh/ZkgquSgLkSIVLdezyNQyWBJsxn+sJv93ox5
	 J7vj2FRAK6IgQ6vB6R7/zrE48iyU3aHjRB+wgg5vu3wXSLatFOf44mcpgDNgRIlaA2
	 kXkiXNGOLyKuFp2N60AjQhcA/zOBnw2wjb15bJZzKpijiyt/qKe9tF+ikl+za8g9Y/
	 jkMnHok1UP3iw==
Date: Thu, 6 Jul 2023 10:56:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	sasha.neftin@intel.com, richardcochran@gmail.com,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Chwee Lin Choong <chwee.lin.choong@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Message-ID: <20230706075621.GS6455@unreal>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
 <20230705201905.49570-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705201905.49570-4-anthony.l.nguyen@intel.com>

On Wed, Jul 05, 2023 at 01:19:02PM -0700, Tony Nguyen wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> If a user schedules a Gate Control List (GCL) to close one of
> the QBV gates while also transmitting a packet to that closed gate,
> TX Hang will be happen. HW would not drop any packet when the gate
> is closed and keep queuing up in HW TX FIFO until the gate is re-opened.
> This patch implements the solution to drop the packet for the closed
> gate.
> 
> This patch will also reset the adapter to perform SW initialization
> for each 1st Gate Control List (GCL) to avoid hang.
> This is due to the HW design, where changing to TSN transmit mode
> requires SW initialization. Intel Discrete I225/6 transmit mode
> cannot be changed when in dynamic mode according to Software User
> Manual Section 7.5.2.1. Subsequent Gate Control List (GCL) operations
> will proceed without a reset, as they already are in TSN Mode.
> 
> Step to reproduce:
> 
> DUT:
> 1) Configure GCL List with certain gate close.
> 
> BASE=$(date +%s%N)
> tc qdisc replace dev $IFACE parent root handle 100 taprio \
>     num_tc 4 \
>     map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 \
>     queues 1@0 1@1 1@2 1@3 \
>     base-time $BASE \
>     sched-entry S 0x8 500000 \
>     sched-entry S 0x4 500000 \
>     flags 0x2
> 
> 2) Transmit the packet to closed gate. You may use udp_tai
> application to transmit UDP packet to any of the closed gate.
> 
> ./udp_tai -i <interface> -P 100000 -p 90 -c 1 -t <0/1> -u 30004
> 
> Fixes: ec50a9d437f0 ("igc: Add support for taprio offloading")
> Co-developed-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> Tested-by: Chwee Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  6 +++
>  drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_tsn.c  | 41 ++++++++++------
>  3 files changed, 87 insertions(+), 18 deletions(-)

<...>

> @@ -6149,6 +6157,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  	adapter->cycle_time = qopt->cycle_time;
>  	adapter->base_time = qopt->base_time;
>  
> +	igc_ptp_read(adapter, &now);
> +
>  	for (n = 0; n < qopt->num_entries; n++) {
>  		struct tc_taprio_sched_entry *e = &qopt->entries[n];
>  
> @@ -6183,7 +6193,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  				ring->start_time = start_time;
>  			ring->end_time = end_time;
>  
> -			queue_configured[i] = true;
> +			if (ring->start_time >= adapter->cycle_time)
> +				queue_configured[i] = false;
> +			else
> +				queue_configured[i] = true;
>  		}
>  
>  		start_time += e->interval;
> @@ -6193,8 +6206,20 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  	 * If not, set the start and end time to be end time.
>  	 */
>  	for (i = 0; i < adapter->num_tx_queues; i++) {
> +		struct igc_ring *ring = adapter->tx_ring[i];
> +
> +		if (!is_base_time_past(qopt->base_time, &now)) {
> +			ring->admin_gate_closed = false;
> +		} else {
> +			ring->oper_gate_closed = false;
> +			ring->admin_gate_closed = false;
> +		}
> +
>  		if (!queue_configured[i]) {
> -			struct igc_ring *ring = adapter->tx_ring[i];
> +			if (!is_base_time_past(qopt->base_time, &now))
> +				ring->admin_gate_closed = true;
> +			else
> +				ring->oper_gate_closed = true;
>  
>  			ring->start_time = end_time;
>  			ring->end_time = end_time;
> @@ -6575,6 +6600,27 @@ static const struct xdp_metadata_ops igc_xdp_metadata_ops = {
>  	.xmo_rx_timestamp		= igc_xdp_rx_timestamp,
>  };
>  
> +static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
> +{
> +	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
> +						   hrtimer);
> +	unsigned int i;
> +
> +	adapter->qbv_transition = true;
> +	for (i = 0; i < adapter->num_tx_queues; i++) {
> +		struct igc_ring *tx_ring = adapter->tx_ring[i];
> +
> +		if (tx_ring->admin_gate_closed) {

Doesn't asynchronic access to shared variable through hrtimer require some sort of locking?

Thanks

> +			tx_ring->admin_gate_closed = false;
> +			tx_ring->oper_gate_closed = true;
> +		} else {
> +			tx_ring->oper_gate_closed = false;
> +		}
> +	}
> +	adapter->qbv_transition = false;
> +	return HRTIMER_NORESTART;
> +}
> +

