Return-Path: <netdev+bounces-48770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512357EF75C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C752811CE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD91358B5;
	Fri, 17 Nov 2023 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr0RZ2kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356434CFA
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 18:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60643C433C7;
	Fri, 17 Nov 2023 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700244967;
	bh=bFIc0Jmb5tQNMyAhAlrxbHbRAO4Ghji+FMUgKLz3oAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nr0RZ2kgv1BDedZxHGKBq+ZCVgeKV5QRbY+pPYGSh0Q7na3FBIOD9gzGzhIPsJqsk
	 KPeoIStW0BBpkLXapz1exYcCWuqksLiTrwqAP+f4O3WiJ5QyGgTw6kpjY5tkVcU6Ya
	 ycVM2wZErXESDcMDVjpUJz72V6hZAgV9RGOGr7JbZ0eI/CX/uRLFanCchGiz7AMZ22
	 vZpD9KUyZQVAO0ihZ+Tjk08FC3adFZzxhL3v3h4q6INOL9VpOA/8kqOvQeQ5ZNFxbV
	 TR8pARNU2Dnt9TCUgs9KQee8ZVuU+k+R/15HqkvhusqKTkVqz3LudqgS3BpUBKIsVi
	 z8lgmLMuaFWwQ==
Date: Fri, 17 Nov 2023 18:16:02 +0000
From: Simon Horman <horms@kernel.org>
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	jacob.e.keller@intel.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: microchip: lan743x : bidirectional
 throughput improvement
Message-ID: <20231117181602.GP164483@vergenet.net>
References: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>

On Thu, Nov 16, 2023 at 11:13:50AM +0530, Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)
> 
> Test setup 1: x64 PC with LAN7430 ---> x64 PC
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver
> 
> Test setup 2 : RK3399 with LAN7430 ---> x64 PC
> 
> RK3399 Spec:
> The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
> Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
> Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
> PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
> [  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
> [  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
> [  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
> [  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
> [  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver
> 
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>

Thanks,

I think you should have included Jacob's Reviewed-by tag from
the previous posting of this patch [1].

And echoing his comments there, a very nice performance boost :)

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/netdev/e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com/

