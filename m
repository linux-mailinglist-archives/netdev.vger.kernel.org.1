Return-Path: <netdev+bounces-55879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1680CADD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DF01F210D6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216E3E467;
	Mon, 11 Dec 2023 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IzHU3Vjf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A909F
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:24:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntOEewVwiFuVOpvEorpWXOTEAPv+xdNGY91I1u3KFSBFY6u5FdNuebd0+51PIcSm15jShUGB6u+MxCuEtahY1beNbb3+ZfIDrO2QfSRmAg1C3EQX7v7pzcmMJu3HlYw2YNaR0V1ZiwHD0cjCf6T+ElQESHm9yv2qXwV4I6p6/8h4IwZPMb6QMxuR5Sw4BY8BwJUmVd/YlkvArIcgcs1oIfK0CUIA1ofsUUPivtFO7LTAn1qQGWiez3EbsbMjdZaSPTYvde31NVdFmn+GlzdED1fT14jjBS97zkn3lpB1dfK1/DytIDzC64oNNwbI8EWfzzSNaie1tA2K+kOX1mrz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9jcoZbglmNHxBXdk7gHh7WvmHubka6bFTIHKqNjAN0=;
 b=hNukPAJusVDkHOn/i6Ygfd8RgyBaoPaWsNsge/dcSBZHZgwO0HXok1UF9qXNRx0+zbkEANMXEyyXkcQtO/1kg42EMGcn6spm+ZktUXxh+m4n/Lesakp9A6XWs2smF8Ulmqkk1eSw12WIfw2dt/+4tZ2o/MmBITTRjnYL7yLf6gDwDkPzsiY7InTQRZ45Lc3mGX3+TR0r5w9grIYvHHfszNnk2rTwzsYMg++w1GQhpy/sQLpOrr/7RlLxlXZyf+VRtWlTMYSiTI3UsihuMJ60J24w6hvdhwTsBBGmMBQD+4IJyL0nmQfBbefjoRE2P4p/ctCSf9zNU41x/hGZHeN9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9jcoZbglmNHxBXdk7gHh7WvmHubka6bFTIHKqNjAN0=;
 b=IzHU3VjfmTLbbH1trtcB+7CPNpatLIvLw9ZPqhlZ0NrxpqDjw/QsT1+y8ttqUtuWK2CdO2rSpEarZtl6e0vi4B0ppfo5vNzLCTbfzhl6LSNAaBaHQ9oQ2O4eGYT3xrIAV9je0SNTvimwp8bdYoA31+Ex0B5YTiPGVJ9VHtMewI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:24:19 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:24:19 +0000
Date: Mon, 11 Dec 2023 15:24:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: forwarding: ethtool_mm: support devices
 that don't support pmac stats
Message-ID: <20231211132415.ilhkajslbxf3wxjn@skbuf>
References: <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211120138.5461-3-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR06CA0203.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cde1938-89c5-4557-37df-08dbfa4c7abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aBGolRdewjqbULFbdf1spniP1bRZeLJsn/TSgz2e4rP/Tia5o0A9cm3xW8Nq8f47ybGFBNtkLnrrHj4SZkx8GT9kfMyCDpdXmuYvM2bBoPOZNC0S3Sbcr2glDpIQJD7OA5XSXM796byJyYSpAPjpnapkCn76HZAiog2ive8Tu9R3/StFB73oTipj2v7GkIAnVaN6lhZ61XAUUBueypHNgjTCLAMGNIPbee+49xbtSNZXwP0AMPyVG3RPtZG8xF8hlKL98u8oOzLOdOfmSWgMtlPRqBUDBxQaozF9t+3aCilfnxY9DeBl7/z/y1VRkxHevzW5ZN0649LtxI1HN5NLr7KI34IiVqmyxEN9OCDr9atE9vlpOa8aKgAFB8iPn69v5jVjDrlhVgFLtUW5BNa76ktym7wq24/eA+LSgcl+vxKczTo8V+vaFMtkvgXUERbmpraMWfQZBKnQaNu67TjgkGoIOP94nI+uqf5mBqyOCAv9UlytGWS9oytwFpo8kVi+pMx/Ft4MIt6dT2di0cP0OnjaaQgpJvALvyyDpKy31MpyOWYhOELXfdXtT3xqtsZC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(44832011)(8676002)(8936002)(4326008)(2906002)(41300700001)(5660300002)(66556008)(66946007)(316002)(66476007)(6916009)(478600001)(6486002)(26005)(1076003)(9686003)(6666004)(53546011)(6506007)(6512007)(83380400001)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hB27L1/+e6wG7vWdrL7wJp6kXeSncpnKlOX42PhvXh9CexIODoFbjQmsPZKV?=
 =?us-ascii?Q?FeAtJQYdc4svAG7SrD+K7PwnphrSgLLEzlYBCMRf5DOsbGsWm0pYwC2fj1Ru?=
 =?us-ascii?Q?8RSqH0PsAxrGVIMSK5tR4xnlOkPMiNWg2cb95rkzvUYLPnLbWa74WXy5jozU?=
 =?us-ascii?Q?jElPunqS2sCZU0XV/ytBqJ0dDD8mXyEfK9yqn0zaWXsNooaYbL6sj5ZfoBff?=
 =?us-ascii?Q?1eCfixhX6H2uYuOCGamRkdM7e3LRLtef1x6V9cYtaXcsZPAWljpqoqVEmwrd?=
 =?us-ascii?Q?Owc0Vp9LvY0/ohtv61PRh/500sOyRkY4Yz50OTcA27sGUKQUx/mhpPIxWYeM?=
 =?us-ascii?Q?u2/VkdRacz7EfXKcVR7Vqf7F1vHLcjYREWr0yDHedaTDT6oAdT+5ohsPTv7q?=
 =?us-ascii?Q?5WnnIevRjBtMJ2V8qULdkQ0Jdt+BMYLhBKTLYTi7FJNdZc4zuBBDQNXAK4oJ?=
 =?us-ascii?Q?0zMjscL+DoFRRKcix1akWgtY/sfcVaGXwGkUJ65eHcEUmAgeNGel6T7QH2Dk?=
 =?us-ascii?Q?m3dFMlYJ7u80IKpRFKEH0a6hVsfPBApBkrUNY1CaNb6q9sp+23NkPu53K6xt?=
 =?us-ascii?Q?CN0GeUcnqUQ8Q7LV0fe9B60c2tOyvR+7UGYToRturEXT7mGn9kdmnRZ0q2FX?=
 =?us-ascii?Q?QN4aXvNXQYo94/SgvqB34EF3c/ahw7cMXZzWhY22s49BZpaXtTFzQjNgekyo?=
 =?us-ascii?Q?K+eNUNnZexuWf4GZz/oUQxFuNHSEPKjTyzqljtGbRiedruXqgB3Wu3k8ZKtX?=
 =?us-ascii?Q?zk1V3MSkCcUOyJ0qLRYJfGwkqMNAEGfeqmKWJs+RMvbWdGStWj1J9zxyhqzD?=
 =?us-ascii?Q?cSO/esY1BTl08arUGV22S2tC+bFz15Ft1iFdu0HpaA64R3Q2j0kc/ziDIVoj?=
 =?us-ascii?Q?L5HljHwK+cg73+QQOMlMUGjdSjTQSdWMJFx1W+rvUtB22fqbuc7WlQK+nFm9?=
 =?us-ascii?Q?hMXf91Z7MELkydssnNBojdD3MP41VN7iERCUgtWfSnOlUVbcO4I2O1u2Q3vE?=
 =?us-ascii?Q?nRifS3dz3W2hIuqoSyH0QMP+DIXVkVcpP4vh7jrqv7AN48bTqW41P1PLfO1P?=
 =?us-ascii?Q?CV7KDteb+MdJQKA+XAe3ZBHleg5UtAws6o9/F0kBsXItx1rnyp6so108G8a1?=
 =?us-ascii?Q?u+a96l0Uamexon5LnyEdYcq3xUdLLaJj+DGHzmi21NPG/UCgHIWwf7P6xV4E?=
 =?us-ascii?Q?jcFWma1MUkUHv8HotjsG7FMBhSTq0VCBH+j1CAv0KZ8QsgljcKBypNGVkpUP?=
 =?us-ascii?Q?NH2uHdjKa7s0TUZ8Lpv1ac/btQdWgdb5GVlXQMo4YLXU/NrWXrq81rvuk3fq?=
 =?us-ascii?Q?UgHD63v3nfqjaFtGFyy/eEDqPapQH456tA9IQu2Z/AivvD7cYOEtQAKpIgDU?=
 =?us-ascii?Q?/jN5MbQpIF/YyIRAQHXFi0TtEKOWJFJ9lY7zHa/MJZ0WDJWawA+CdU4ZSlW7?=
 =?us-ascii?Q?oTPeM2GyVP3zYnfuoBpBeL52EGusBOHFwkgsQ6AeWa1dy/41tx6ijxkVqUCN?=
 =?us-ascii?Q?iqj9JToXvkUOaeS4KeFwR8QJZBWJ+FZ4v1idmCTGC//gMOKQ8GxlB9ylqN7l?=
 =?us-ascii?Q?VYJQFlxry/Pg93MpwqGYH34V6e9Zkv/KaFcx8Zo7bFs+bBmzpoGWXE3d8j7x?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cde1938-89c5-4557-37df-08dbfa4c7abd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:24:19.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih0tBHJJrSKzGgN7DDm3AIuNjLN/QAeZqwg8G1BRd5an+5Y5G8SohPLuGULADLOW8mhOOn1HK1hZro+VHMEi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594

On Mon, Dec 11, 2023 at 02:01:38PM +0200, Roger Quadros wrote:
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

1. please follow the existing indentation scheme, don't mix tabs with spaces
2. someone mangled your patch into invalid bash syntax, splitting a line
   into 2
3. "FramesTransmittedOOK" has an extra "O"
4. it would be preferable if you could evaluate only once whether pMAC
   counters are reported, set a global variable, and in traffic_test(),
   if that variable is true, override $src with "aggregate".
5. why did you split the selftest patches out of the am65-cpsw patch
   set? It is for the am65-cpsw that they are needed.

>  
>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>  
> -- 
> 2.34.1
>

Something like this?

From ef5688a78908d99b607909fd7c93829c6a018b61 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 11 Dec 2023 15:21:25 +0200
Subject: [PATCH] selftests: forwarding: ethtool_mm: fall back to aggregate if
 device does not report pMAC stats

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/ethtool_mm.sh | 11 +++++++++++
 tools/testing/selftests/net/forwarding/lib.sh        |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 39e736f30322..2740133f95ec 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -25,6 +25,10 @@ traffic_test()
 	local after=
 	local delta=
 
+	if [ has_pmac_stats[$netif] = false ]; then
+		src="aggregate"
+	fi
+
 	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
 
 	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
@@ -284,6 +288,13 @@ for netif in ${NETIFS[@]}; do
 		echo "SKIP: $netif does not support MAC Merge"
 		exit $ksft_skip
 	fi
+
+	if check_ethtool_pmac_std_stats_support $netif; then
+		has_pmac_stats[$netif]=true
+	else
+		has_pmac_stats[$netif]=false
+		echo "$netif does not report pMAC statistics, falling back to aggregate"
+	fi
 done
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..82ac6a066729 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -146,6 +146,14 @@ check_ethtool_mm_support()
 	fi
 }
 
+check_ethtool_pmac_std_stats_support()
+{
+	local dev=$1; shift
+
+	[ -n "$(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null | \
+		jq '.[]')" ]
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then
-- 
2.34.1


