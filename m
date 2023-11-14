Return-Path: <netdev+bounces-47689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FD7EAFA2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5414E1C209C7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B53E483;
	Tue, 14 Nov 2023 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q97ZyIuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EF3E47D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3941C433C7;
	Tue, 14 Nov 2023 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699963610;
	bh=B/cuiYf3xoa7ZBqITbU7+4yaCtY4LMzTglSLKmmzqPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q97ZyIuqZAC5GgJUeQHnC0EOi3hcLKMDPeHFYwujSSyqNf1rawAxNOMRZ/WdL7ULF
	 vMfH9q+PluLnpg2b/BTYVpK2lU0othBWYt8ReI1MptYEyG8cGAqPQSTiKJVdATHtyU
	 l44zT3cgtUqOyQpyDZs97ax3uFYsjn/ybxdJITWu80esVJOI+/T/9A7uhnEeq4k+f3
	 1KYuNInJwVi5TBLFnMcaE1LITnBgS6CgEgojDc6Saann4TvhbjEVlbIryX8Hbnlifb
	 EwRsE5CjcBnqYG5aWgSNBrd2eYzTbPUmyWXMz0cANIY2LnTRNqvc/GKJTZ/MOveWV9
	 4J2s91JF+5cww==
Message-ID: <2b4c0405-064e-4e3d-8cf8-36fee1dcc687@kernel.org>
Date: Tue, 14 Nov 2023 14:06:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ethernet: am65-cpsw: Add standard
 Ethernet MAC stats to ethtool
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-2-rogerq@kernel.org>
 <20231113164204.GB4482@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231113164204.GB4482@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/11/2023 18:42, Simon Horman wrote:
> On Mon, Nov 13, 2023 at 01:07:06PM +0200, Roger Quadros wrote:
>> Gets 'ethtool -S eth0 --groups eth-mac' command to work.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index c51e2af91f69..ac7276f0f77a 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -662,6 +662,31 @@ static void am65_cpsw_get_ethtool_stats(struct net_device *ndev,
>>  					hw_stats[i].offset);
>>  }
>>  
>> +static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>> +					struct ethtool_eth_mac_stats *s)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_stats_regs *stats;
> 
> Hi Roger,
> 
> I think that stats needs an __iomem annotation
> to address the issues flagged by Sparse.
> 
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15: warning: incorrect type in assignment (different address spaces)
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15:    expected struct am65_cpsw_stats_regs *stats
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:671:15:    got void [noderef] __iomem *stat_base
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34:    expected void const volatile [noderef] __iomem *addr
> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:673:34:    got unsigned int *
> ...

Thanks for the catch Simon.
I'll fix it up.

> 
>> +
>> +	stats = port->stat_base;
>> +
>> +	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>> +	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>> +	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
>> +	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
>> +	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
>> +	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
>> +	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
>> +	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
>> +	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
>> +	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
>> +	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
>> +	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
>> +	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
>> +	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
>> +	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
>> +};
>> +
>>  static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
>>  					 struct ethtool_ts_info *info)
>>  {
> 
> ...

-- 
cheers,
-roger

