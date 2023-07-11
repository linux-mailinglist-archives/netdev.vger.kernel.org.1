Return-Path: <netdev+bounces-16715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448374E7B8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F52F28151A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4F171CD;
	Tue, 11 Jul 2023 07:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C8171BB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FC1C433C7;
	Tue, 11 Jul 2023 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689059485;
	bh=1/jhBCtkM57QOZ7Pk7Kbw7Q8u4FJ6Qf6XiAg+VLrlic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fht6G14n348FLvAvLbtQMsmlUyKGS8FqveTf1xifE/FZ4PnO0lbZKl03cNN5L1Sby
	 /VblYaBypaDVdxG4V1elhZLAK1zp13FU7fFddnnjWUPfeZh8cBMQfkD0nC/YDHdYI0
	 v4E3Fx4XySTcs++fiVcRxOqeMJsXiAlKVzaCBcznFC2s6tdYVbJbuxefApAo8LzO8j
	 qRmT/360RGDYeWAVDLryx4RQedCulMT8Z/kb07DmcR0sPEurP9Rja2xxbkrcFn2amX
	 /lML50hZOwiZu0+INyBqptTLd9R2m2EoLiqD4pBIFw32Bk3WH8I8Ua7YH5aviC/g+5
	 5MwExYEdO7QXg==
Date: Tue, 11 Jul 2023 10:11:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 6/6] igc: Fix inserting of empty frame for launchtime
Message-ID: <20230711071121.GH41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-7-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:35:03AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> The insertion of an empty frame was introduced with
> commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> in order to ensure that the current cycle has at least one packet if
> there is some packet to be scheduled for the next cycle.
> 
> However, the current implementation does not properly check if
> a packet is already scheduled for the current cycle. Currently,
> an empty packet is always inserted if and only if
> txtime >= end_of_cycle && txtime > last_tx_cycle
> but since last_tx_cycle is always either the end of the current
> cycle (end_of_cycle) or the end of a previous cycle, the
> second part (txtime > last_tx_cycle) is always true unless
> txtime == last_tx_cycle.
> 
> What actually needs to be checked here is if the last_tx_cycle
> was already written within the current cycle, so an empty frame
> should only be inserted if and only if
> txtime >= end_of_cycle && end_of_cycle > last_tx_cycle.
> 
> This patch does not only avoid an unnecessary insertion, but it
> can actually be harmful to insert an empty packet if packets
> are already scheduled in the current cycle, because it can lead
> to a situation where the empty packet is actually processed
> as the first packet in the upcoming cycle shifting the packet
> with the first_flag even one cycle into the future, finally leading
> to a TX hang.
> 
> The TX hang can be reproduced on a i225 with:
> 
>     sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x1 \
> 	    txtime-delay 500000 \
> 	    clockid CLOCK_TAI
>     sudo tc qdisc replace dev enp1s0 parent 100:1 etf \
> 	    clockid CLOCK_TAI \
> 	    delta 500000 \
> 	    offload \
> 	    skip_sock_check
> 
> and traffic generator
> 
>     sudo trafgen -i traffic.cfg -o enp1s0 --cpp -n0 -q -t1400ns
> 
> with traffic.cfg
> 
>     #define ETH_P_IP        0x0800
> 
>     {
>       /* Ethernet Header */
>       0x30, 0x1f, 0x9a, 0xd0, 0xf0, 0x0e,  # MAC Dest - adapt as needed
>       0x24, 0x5e, 0xbe, 0x57, 0x2e, 0x36,  # MAC Src  - adapt as needed
>       const16(ETH_P_IP),
> 
>       /* IPv4 Header */
>       0b01000101, 0,   # IPv4 version, IHL, TOS
>       const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
>       const16(2),      # IPv4 ident
>       0b01000000, 0,   # IPv4 flags, fragmentation off
>       64,              # IPv4 TTL
>       17,              # Protocol UDP
>       csumip(14, 33),  # IPv4 checksum
> 
>       /* UDP Header */
>       10,  0, 48, 1,   # IP Src - adapt as needed
>       10,  0, 48, 10,  # IP Dest - adapt as needed
>       const16(5555),   # UDP Src Port
>       const16(6666),   # UDP Dest Port
>       const16(1008),   # UDP length (UDP header 8 bytes + payload length)
>       csumudp(14, 34), # UDP checksum
> 
>       /* Payload */
>       fill('W', 1000),
>     }
> 
> and the observed message with that is for example
> 
>  igc 0000:01:00.0 enp1s0: Detected Tx Unit Hang
>    Tx Queue             <0>
>    TDH                  <32>
>    TDT                  <3c>
>    next_to_use          <3c>
>    next_to_clean        <32>
>  buffer_info[next_to_clean]
>    time_stamp           <ffff26a8>
>    next_to_watch        <00000000632a1828>
>    jiffies              <ffff27f8>
>    desc.status          <1048000>
> 
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

