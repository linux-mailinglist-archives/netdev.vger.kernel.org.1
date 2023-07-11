Return-Path: <netdev+bounces-16714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22F74E7B3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B23F1C20B80
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241CC171B8;
	Tue, 11 Jul 2023 07:10:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7A1643F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE2C433C8;
	Tue, 11 Jul 2023 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689059399;
	bh=J5dPFWayAHymGhGoWOwA1Md3KDXTm8NjXATd6bPe9fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2YvfoM1iQe8wwieuv9OH7O5hgtn596YmZtTZh9ShXMl3TuyNANTGa0w9EdNAuoWS
	 mIx2uWZKdXpuTRmsNffN4UU9JWglxEJHo26wxr1l7Y9KeEDUs455En8U/6j0e2wdVr
	 y//LvVj1veV5SASdwnzFnFjmWOrCkopGLDLZyyqngx0MoUQgTJ1YsUREkpifsxRO2F
	 TyzJyB5Mv7tB9ld+g8h8PVa+nvWCsFJdzvEqykUlCKD39QBLqY00Mhg8qY5jefNYkj
	 sxXjenPiU1guUPa81DZxL/2icEB9X9Hgr3LkWVcSxFHe06v2ApOHs6UW0RJjw4FLwA
	 9d/+uKl/s1XAg==
Date: Tue, 11 Jul 2023 10:09:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 4/6] igc: No strict mode in pure launchtime/CBS
 offload
Message-ID: <20230711070955.GG41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-5-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:35:01AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> The flags IGC_TXQCTL_STRICT_CYCLE and IGC_TXQCTL_STRICT_END
> prevent the packet transmission over slot and cycle boundaries.
> This is important for taprio offload where the slots and
> cycles correspond to the slots and cycles configured for the
> network.
> 
> However, the Qbv offload feature of the i225 is also used for
> enabling TX launchtime / ETF offload. In that case, however,
> the cycle has no meaning for the network and is only used
> internally to adapt the base time register after a second has
> passed.
> 
> Enabling strict mode in this case would unnecessarily prevent
> the transmission of certain packets (i.e. at the boundary of a
> second) and thus interferes with the ETF qdisc that promises
> transmission at a certain point in time.
> 
> Similar to ETF, this also applies to CBS offload that also should
> not be influenced by strict mode unless taprio offload would be
> enabled at the same time.
> 
> This fully reverts
> commit d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
> but its commit message only describes what was already implemented
> before that commit. The difference to a plain revert of that commit
> is that it now copes with the base_time = 0 case that was fixed with
> commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> 
> In particular, enabling strict mode leads to TX hang situations
> under high traffic if taprio is applied WITHOUT taprio offload
> but WITH ETF offload, e.g. as in
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
>    TDH                  <d0>
>    TDT                  <f0>
>    next_to_use          <f0>
>    next_to_clean        <d0>
>  buffer_info[next_to_clean]
>    time_stamp           <ffff661f>
>    next_to_watch        <00000000245a4efb>
>    jiffies              <ffff6e48>
>    desc.status          <1048000>
> 
> Fixes: d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

