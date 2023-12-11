Return-Path: <netdev+bounces-55882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A380CB07
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BC61C20CBE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573493D97E;
	Mon, 11 Dec 2023 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Am+lxk6i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E9FF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgGf/PSJOS1c1CLZ1MtBe1oTO1cvAa8dyCHbPooh3JAEZzAVW+hjMO0tEBfcbg7NCSgIGjPjivijx1jwsLvnQim7bIIJtX0fQIh9nobviL+WTVuupMqx5OuKU8vEdYSyYKhOpQonLuLotOluKeDCJJZWrK5i0ESsRdPEWs2px7yENj5jpbgMIOdoSOhlMoT0GWNZ05i22czunCQos1M7/8p44+SLtgweYBKDSesk43c2e9b4hrnvcZrxNry8fPzKFixy+2uYrBjwwKUnWehtwCKO/65SqukX5U6PPjLmb7LFvslMy7ZSI/1Zm3vB7/pUzDohTOk+W4ulhMyilpY50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ntZNX6TR4kHF25RyE8nlPBIzK9lF2WFKLovngzv6SU=;
 b=Wul6xktXuQeN7Pcd2k+2eQRDcAMtmienJsPK/Xq6n9Cjf5i7NGVPT9vvFVgE7PpbKLjCT807c8qyMi853NdOrJZUtdsT14u5LYFOrwFxnj+WQF0vApVOXshKcisis76vEp7SVr1zfnwEThhos9uZjK1S52psAlpzYhHHvcP9XnLMlRKL/k0649YdjS2KN4Yr2koY+uLoD3MjlDZD6osBcewZL09b3IWOZo4uyDmpAhD/T1XBcsYZuDJzcztO9lW7WD6qmA14OBPf4QfCkvvnpZONddu2thpgNEnm1RXpmv1g1eU5KIpwE9Z6CC0ohut3Qe4y+ofWBF7HDvmC+pQMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ntZNX6TR4kHF25RyE8nlPBIzK9lF2WFKLovngzv6SU=;
 b=Am+lxk6iknlgEQ5VdUpguwfxCXxk/yH9vgx/tZnT0US6uxZ8zOAI/yeiTBSUMCFj514prBqZHOhOFZcUU+tBxJ++wDbY0dfkBNnZ5OEQg1qWcCORD26In6o5LyU+6QvE6EUQuTVpAwHWVyar8JIZm6cSxMQadbQj0MKCYK0Q7eA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Mon, 11 Dec
 2023 13:29:05 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:29:05 +0000
Date: Mon, 11 Dec 2023 15:29:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231211132901.deqy2zpnxzowflud@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231207152409.v5nhbgn4pwdqunzw@skbuf>
 <ba4dcbe2-1dc4-4a64-92af-71d6a2783902@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4dcbe2-1dc4-4a64-92af-71d6a2783902@kernel.org>
X-ClientProxiedBy: VI1PR09CA0177.eurprd09.prod.outlook.com
 (2603:10a6:800:120::31) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5e432d-8f9c-435c-ce2d-08dbfa4d2571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JkrgCjeK/54tzXcoOzXvbfP0xT8HOhEApdP/A9r2cJpIPea+52sWvIUjF6mIK31kgjJth6WYTED6vavn3Lv8wvzi/vltC3TsApqb5I7LNHHh5x1lS7dBxvdDICefQ5wrp3/OCjozg5Fr3C68dPB4gd9jKPxbABduAL9qt18YoT3zHlqVyQI5aQASmTK+dMiPmMI6lIRB2qXjBB0pMK/HOHEb+XwpS8pemP8RvH32R8bJZHVXvTWRrlMLUyjH6KkiPC4RnmKqMJCeVZlK8c9KPhfFSJdt5bE5jt73jl++RdPVjZmFNFqOb7mMV6UgkzSjtmBwkibQOrkkbW1cXSkfCJa9Y/quAFjasAgkXZMsRBWqr0ZUaxD4Z+GBtrAxQZyROrmkcI2X1t5gmaotuwV03Fy8IMufosNSKJ88ERHSdDPzvcHQ9+ARuildAHSQBaSfJ0z2rwqWM5PDKiSBgDkBU4IyNiDqcakNtSRddLchIJU2Myv0uWkWTZkrU/c+5YN0FxJoij/zQYOi77z5n77dDwmO8YvScWHhdkLLJTjVV5u5SZYBxDQMV5sUo90xrYcW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(1076003)(26005)(316002)(38100700002)(86362001)(6916009)(83380400001)(5660300002)(44832011)(7416002)(53546011)(6512007)(6666004)(6506007)(9686003)(66556008)(66946007)(8936002)(8676002)(6486002)(66476007)(2906002)(33716001)(41300700001)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYW18PE0rT0+EjNAvMJW6ILIwQ3gEEiC+It4U+UL3ywvBW9zdqSaUaYj0Efy?=
 =?us-ascii?Q?f/mVe5t51enPOPps7n48aa6i3Fjb6p4fdxsYtkGBi0r0STuBcG3f3ayqMnvm?=
 =?us-ascii?Q?povUyB5NpYGbHDMub6SQTPBK2lw632BY3mk/StuWbJNdIVX/U+7ZLG0QhS18?=
 =?us-ascii?Q?mtx8+Hqk7FBD2NtoODg2oidQnBc3texqC0+OTyrFDlaQQTb2XxOtupAqG/7B?=
 =?us-ascii?Q?uNGycTvFmoZQrsEg84peek+Ddy0r/VMjGOWIF4Jx0hfGhyoywuQuwJevDtOA?=
 =?us-ascii?Q?rnTm7OYJFGdKgjLEVl+i1cDMi81ePfwvH6g1II6liZDZdSthax32zmqv/q1a?=
 =?us-ascii?Q?f9qf50AtRVMp9V2+cj1wE0Jq7BaYNBOXupOTSCdMCOcP5H+Qjmj25SoI4hsL?=
 =?us-ascii?Q?raQHzAkfBLWTZSpPLnVJcz4p7MBvkoeuyfBsKkV4odYWKXxbR/2sqZ5dKH3X?=
 =?us-ascii?Q?VudgoWgdlWpd0DT9Zdz6j6EbPq+57VaMrgIkfbPipkqvfMlhHWwHeFEnUFaO?=
 =?us-ascii?Q?9Vi336IaMUN/1re/gblZFizLU5ioCr2PeM2huq1BxFSJoBXZ1v5wSOgaiuTF?=
 =?us-ascii?Q?KSEdfZ3Zt0wXMPM2D7SQIXdTVKsvyIS5lIvKMc7je0ep1u+sWRCuf5UmnF4u?=
 =?us-ascii?Q?0zXCcFpWAS8WgmzwunSiyKVwMkXdjXgtM8aXNKTTNByujsilYINBb0Rr6bIA?=
 =?us-ascii?Q?CCa0GePsGdnc6GeFKuMU4fpwWVfkB9TqzfHI19IrM9qo1URwwqBjmskfkIb6?=
 =?us-ascii?Q?dkLKlfMYFeya/7tQqGLlFbVY87qH7hvX6j8qlC6z+rHs8VLCdojmS0320a/5?=
 =?us-ascii?Q?wgF0r4fKiFP5bG7ceAlNDutvz6Rj/MfhkSh6hWGzsYNN6uID2NIlX2r27Dna?=
 =?us-ascii?Q?r1+ujdOM5D0NtSZeRvvZ+ezuTc1lHubAHTb4Eht1DhLoaO2Eey1sJrtYTGKH?=
 =?us-ascii?Q?5s4q0d+qfoYDEmTiLHwT8qVBPJn+83Mq5Dt5NDGmxVXNQbD/VhNIJvpQZy5P?=
 =?us-ascii?Q?yliF63G2tO3XEE1UdH3xBJ2dFjrMP0ulpGodClAlZXH/u5zokbmcBY9HU0Bz?=
 =?us-ascii?Q?c0eMuJeSWlDGps7XLUJfhFBoeYMhfu0OGngbOkocu4AC6kajQ2Sl2B1kHOt8?=
 =?us-ascii?Q?sFd7Gq3w91lAF2tkdAXCSqXgkwqOpOhe6beKc+XPq8hFcnZp+qPEqqNcjEVX?=
 =?us-ascii?Q?odmVhhGXk1Py5Re1VRMCvU7UBdZQIWkp4+vHYyWYTg/3VDtPSfOQ12MqOkCp?=
 =?us-ascii?Q?AthhbH/hVQWDSRZi17xNbJvd29L1jrciqeAKh4K8vHs2+NH8j5SwY3ig0/QI?=
 =?us-ascii?Q?BTmGjVWGK3HgfPZepyaPbGCIbNp6Ft2VBEZm3AFVdMzhnEdmbPlrUyI33PEE?=
 =?us-ascii?Q?/zng8kyoYsVWRpHn9ghfnnRihPmy4AqUSRPlHS1rQPHHWNpr5h1gALrIu6eo?=
 =?us-ascii?Q?wFHF5V8usc9mLT0IGaotyVIM/LAGcZiHzdz3Lc8hmRu2AhsDW5/SRHEYXhex?=
 =?us-ascii?Q?bwmSkud0Ik/jQ62kXhsBmqXZAp7dSKTZyKtUkXFB54J18T/QbbxOBo8wmI89?=
 =?us-ascii?Q?B38jY45QMKgZmt+2JbxjlFZAwZEUVw0LWAcPX4zGlcdFp3iABRRcVMH+nUH3?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5e432d-8f9c-435c-ce2d-08dbfa4d2571
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:29:05.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR8A+SEbHVDglrQzkLPw4PnFr0HFUKAWEKI82vpHC9nS517vbpqkgfhC21Eru+kFbEA2vlTMdwbkNLNFtqaRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

On Fri, Dec 08, 2023 at 03:43:45PM +0200, Roger Quadros wrote:
> How do the below 2 patches look to resolve this?
> 
> From af2a8503dc04c54d6eaf50954628009aba54e2c8 Mon Sep 17 00:00:00 2001
> From: Roger Quadros <rogerq@kernel.org>
> Date: Fri, 8 Dec 2023 15:11:06 +0200
> Subject: [PATCH] net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats
> 
> We do not support individual stats for PMAC and EMAC so
> report only aggregate stats.
> 
> Fixes: 67372d7a85fcd ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 37 ++++++++++++---------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index 44e01d68db39..934b03382508 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -671,21 +671,28 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>  
>  	stats = port->stat_base;
>  
> -	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
> -	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
> -	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
> -	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
> -	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
> -	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
> -	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
> -	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
> -	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
> -	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
> -	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
> -	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
> -	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
> -	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
> -	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
> +        switch (s->src) {
> +	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
> +		s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
> +		s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
> +		s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
> +		s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
> +		s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
> +		s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
> +		s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
> +		s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
> +		s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
> +		s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
> +		s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
> +		s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
> +		s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
> +		s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
> +		s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
> +		break;
> +	default:
> +		break;
> +	}
>  };

	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
		return;

Also, again, tabs mixed with spaces. What editor are you using, notepad?

>  
>  static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
> 
> base-commit: a78e0a2c4353d6c100e45c5ef738113bf2d0fda5
> -- 
> 2.34.1
> 
> 
> 
> 
> From 0b20d8b8ef110d886396ee2486f3a9e20170cc85 Mon Sep 17 00:00:00 2001
> From: Roger Quadros <rogerq@kernel.org>
> Date: Fri, 8 Dec 2023 15:38:57 +0200
> Subject: [PATCH] selftests: forwarding: ethtool_mm: support devices that don't
>  support pmac stats
> 
> Some devices do not support individual 'pmac' and 'emac' stats.
> For such devices, resort to 'aggregate' stats.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  tools/testing/selftests/net/forwarding/ethtool_mm.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> index 6212913f4ad1..e3f2e62029ca 100755
> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> @@ -26,6 +26,13 @@ traffic_test()
>  	local delta=
>  
>  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
> +	# some devices don't support individual pmac/emac stats,
> +	# use aggregate stats for them.
> +        if [ "$before" == null ]; then
> +                src="aggregate"
> +                before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOO
> +K" $src)
> +        fi
>  
>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>  
> 
> base-commit: af2a8503dc04c54d6eaf50954628009aba54e2c8
> -- 
> 2.34.1
> 
> -- 
> cheers,
> -roger

I commented on the second patch when you submitted it.

