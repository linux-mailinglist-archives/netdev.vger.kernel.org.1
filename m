Return-Path: <netdev+bounces-55902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFA80CC46
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FF7280D1F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A533481AC;
	Mon, 11 Dec 2023 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWECisDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101281F60B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFA7C433C8;
	Mon, 11 Dec 2023 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303188;
	bh=rU5y8TREUm+Fh2v6xsqVQRML7ECeO9i2H0Ir2DKyCXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWECisDWqFWgce/TRfMtx/5S5i/lmqy+C0BXcE9QhFukbF9UXsyzJogCbcOlSzrSU
	 6Qz5mbiM6eseokiD9Kubd3NsagddTxajm9nsI9FMjR+rcIIDZ6yxFbmwMg6y33KRDQ
	 mt8QT7mjXPX2RxWcmwSVrbrikmnzpCt+Lfw6Ae/BAB+cSXG2qZDt6ZHt/tRNRla+vh
	 SIwqjDnbiU5QZhSHuCmZwcsTBUSvsdx/2bF+8cu00aWU3i0sq1TjN7L5X0hxSt9814
	 wGDmffwlvhJYJg5dxNyIrwzBUDQkTxSPfMGwVXYcS2G2ar2MpjUQv0kUhxAX1iCn5n
	 GIYpdCCN6xOEQ==
Message-ID: <54e4634d-2dd4-4180-939d-32d070b0aa59@kernel.org>
Date: Mon, 11 Dec 2023 15:59:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231207152409.v5nhbgn4pwdqunzw@skbuf>
 <ba4dcbe2-1dc4-4a64-92af-71d6a2783902@kernel.org>
 <20231211132901.deqy2zpnxzowflud@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211132901.deqy2zpnxzowflud@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2023 15:29, Vladimir Oltean wrote:
> On Fri, Dec 08, 2023 at 03:43:45PM +0200, Roger Quadros wrote:
>> How do the below 2 patches look to resolve this?
>>
>> From af2a8503dc04c54d6eaf50954628009aba54e2c8 Mon Sep 17 00:00:00 2001
>> From: Roger Quadros <rogerq@kernel.org>
>> Date: Fri, 8 Dec 2023 15:11:06 +0200
>> Subject: [PATCH] net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats
>>
>> We do not support individual stats for PMAC and EMAC so
>> report only aggregate stats.
>>
>> Fixes: 67372d7a85fcd ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 37 ++++++++++++---------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index 44e01d68db39..934b03382508 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -671,21 +671,28 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>>  
>>  	stats = port->stat_base;
>>  
>> -	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>> -	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>> -	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
>> -	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
>> -	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
>> -	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
>> -	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
>> -	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
>> -	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
>> -	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
>> -	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
>> -	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
>> -	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
>> -	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
>> -	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
>> +        switch (s->src) {
>> +	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
>> +		s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>> +		s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>> +		s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
>> +		s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
>> +		s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
>> +		s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
>> +		s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
>> +		s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
>> +		s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
>> +		s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
>> +		s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
>> +		s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
>> +		s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
>> +		s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
>> +		s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>  };
> 
> 	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> 		return;

Is better.

> 
> Also, again, tabs mixed with spaces. What editor are you using, notepad?

I'm using vim but I didn't run checkpatch on it before pasting
it here for quick feedback.

> 
>>  
>>  static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
>>
>> base-commit: a78e0a2c4353d6c100e45c5ef738113bf2d0fda5
>> -- 
>> 2.34.1
>>
>>
>>
>>
>> From 0b20d8b8ef110d886396ee2486f3a9e20170cc85 Mon Sep 17 00:00:00 2001
>> From: Roger Quadros <rogerq@kernel.org>
>> Date: Fri, 8 Dec 2023 15:38:57 +0200
>> Subject: [PATCH] selftests: forwarding: ethtool_mm: support devices that don't
>>  support pmac stats
>>
>> Some devices do not support individual 'pmac' and 'emac' stats.
>> For such devices, resort to 'aggregate' stats.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  tools/testing/selftests/net/forwarding/ethtool_mm.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> index 6212913f4ad1..e3f2e62029ca 100755
>> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> @@ -26,6 +26,13 @@ traffic_test()
>>  	local delta=
>>  
>>  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
>> +	# some devices don't support individual pmac/emac stats,
>> +	# use aggregate stats for them.
>> +        if [ "$before" == null ]; then
>> +                src="aggregate"
>> +                before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOO
>> +K" $src)
>> +        fi
>>  
>>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>>  
>>
>> base-commit: af2a8503dc04c54d6eaf50954628009aba54e2c8
>> -- 
>> 2.34.1
>>
>> -- 
>> cheers,
>> -roger
> 
> I commented on the second patch when you submitted it.

-- 
cheers,
-roger

