Return-Path: <netdev+bounces-56461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B580EF70
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63E0281A9F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40A745E2;
	Tue, 12 Dec 2023 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GE5x9u0z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFAC3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HibFMT1mOYabZ5SSbZQdHlQmPkk+ua5VTx30gyi/P4WwB/YRhZoBwE9Yia5QIht9iG65w6BU+VrMm47kJ1RbOMDwaDytLJP+h6xqlj+qePkSCGM8OvqUx6S4uZogfd7qFaeyKFgBl1TrrPLJqIWXsbnwKfiFDN2PoqgdS/j8ZxUT248OCkxh+rD1dkBS8gYWtA5hiyt34GLAgTDejHzOMYIDzAeajkZ4WNiObcwGMM+hkthbYvbBs9RM4jGucKZZXQKULltAC8Iiyrcwkb7xUFf22Waisr/pSyvI/k9V7JMXoWVpM+qZPDDGqkd8/ru9BDhS865ICv+D6fbEswIA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ3EIptdm2ugHWZLdQb4CAYHXOi4VGl+OgfVLHpXghI=;
 b=N6lqSsa/N1JtPBfn/cfsMhj6PWO24hHSXsqueL103t6DplRf8mnALa8dE8Qp17LgYmLW/AvwlNXmqUbI75ah73IXc1Z/jbuh33LYP+ZG7ywN2xzqEh1P7lE9vTD62Ae97KrtmdDFmc+cM91vBxB5aod2i6OmKzwDdPNhVABt0xdbWm4Jym7YCLBfpJu67Rr/z9FACwfEwjbidq8ehXYq+GKIIVOnncb0OkjrM2KcENw/3OZ7ZHEpcKN1w94fVWhJuBryA0XN5nc5m82MmaoH9C8hXs3VBA6ITlyRBnoMFUhavsdqzyEPOjrpmCcQkpEhu3OF/hGQyc7XzJMG70ZmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ3EIptdm2ugHWZLdQb4CAYHXOi4VGl+OgfVLHpXghI=;
 b=GE5x9u0zWm26pLGKh0h3GwDYpK0bHIkJErMaTNeqAz5z8U8tQEIPYIrHQezsefozCKP6h16dSSECh753IESRaD+J1qCIl/gcqYlKGt2wen7COvwmH+fJ3K1hp3GCI8wO11cxikkZbg4YmOv2M4Zv3v/jfvIjN0ih7/23/g3rERs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:57:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:57:51 +0000
Date: Tue, 12 Dec 2023 16:57:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: forwarding: ethtool_mm: support devices
 that don't support pmac stats
Message-ID: <20231212145748.zuhn4o5j63ejcfyz@skbuf>
References: <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
 <20231211132415.ilhkajslbxf3wxjn@skbuf>
 <59f0dc65-127d-4668-9662-3eee2ab7af8a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f0dc65-127d-4668-9662-3eee2ab7af8a@kernel.org>
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee1bf08-d338-46e6-e99c-08dbfb22b6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Inh1vjuZ80mHcb4cddHyYdRimnfGB/rcc/jU0uidg+im2IdU684MTa+lp8DNdRyiQd6HFQM0g9MehVEV9Aplf/zfqShzK8LTNwACQLOqBOCwd+DjYcyJHyB9UKTUSzKY9hIlahFRCBOoza+6xUOHDmb86wTSeMWiBJdfFzXuKJhUtqB/aibmZEzebs+3fOBD6JBQEpqWLmAHWZQAFulTW0r/6oJyvjLAI17fQzeKVzjfiZLJ1ONclHqUwXM1WDkRG+Ro0FcivkVzEnc2WNvqEjXIUNhRRd9Eyq8HlfwL0emiKgBC9pfxH+6nWw3ovVNgPHLJKNPR24TYI47IVpC8ZfHo5FjrhynpJEdtjzMQC271s0dL3rhP6OBCeSGovTpI2MvvgUgY4kvWu88gUrDaAS7V2rFjXDGYEGoUT/nax1odRfpBggIgALVBVq5NPh2OytOwMZpG065l4BdiHErBk/q01FOQ2CSI09Guoi2t0Cq0+5eadVQTKxr9QqDPNjjT1voW5qqZhSOghczBKYrxQDqumJJklAo6d44vBMduix6M8ikLyaqbz9QZZbK4Ygh/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(7416002)(44832011)(2906002)(8936002)(8676002)(4326008)(316002)(66476007)(66556008)(6916009)(38100700002)(66946007)(41300700001)(6506007)(6666004)(86362001)(33716001)(478600001)(83380400001)(6486002)(1076003)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rfnh3ZaRbKUKBjy9GUvAyIlpjrVmQPl9TSrlLltykcZWBMb9TCdFeq7HqCI?=
 =?us-ascii?Q?ZU+U7bXmNpn5EeUNjnU/I0P++ODEiEeorBE3pSiOIALN6J1rrVhTC1IRgM8O?=
 =?us-ascii?Q?LDBF9UsKAJeW4ASqGhimKUwEoi+Xn+vjGaeCCxa+idUvsZFXRr16ItGiFc3n?=
 =?us-ascii?Q?bTJsozbJsx0WKmDL1+Z+1s0JTfr1F6nSJG5cnAgoBOd7+IY1OhOZXS/oyQg8?=
 =?us-ascii?Q?wq5ZCvfUUWA92kDCicx5ruJIUEDrVaO51C07H4AxXvyfRLsNLpGW6jXjMLe2?=
 =?us-ascii?Q?kFihgXa/weKw++RPRZ9yXBgQT01UH9Weey1MJftixdJMNZyAIWo+d0XH8QpT?=
 =?us-ascii?Q?erZjoCpUMorY4mKuXUzjuaShUTPi9XZFCjqEiIXxlxY2knlgocImRq6FxcNd?=
 =?us-ascii?Q?yPED7S2TVIsfT/0ug++Bx8je1sW4V/6vZ+TFbLYTe4t2H773leUwcz/uh/R7?=
 =?us-ascii?Q?MedOFqZ0Xll7djyMoQ9lmpXHBV2V7Aq8jp+ZOirJXMz3opZ7J6AXe+qGkudZ?=
 =?us-ascii?Q?W+HKwBxuWpU05L6+XwJTnjWmh/PIHpoImtN5R/6XXdrwVoSnR2GBalxpRoXG?=
 =?us-ascii?Q?I6ozJCRRQqHUgy5YDsltdsi7tAdD+0QK/E8bJrOzEDfKOxZI8ggqLM7RYggJ?=
 =?us-ascii?Q?OvaMq5I255oH64G+F5D2V/Ra9sboWRmHjtbTZe2uUqfczQg5b/tiJGUZkQ+2?=
 =?us-ascii?Q?JtM/kcYz8BxGYSuB4YKrKxCI2p5VwfQYtC5bBn5F3ZqeXKgn13UL7xePShbP?=
 =?us-ascii?Q?BWfytP3tS6kUCqCnDdJhCstyEruxzTLlnYYlesNwq3GkG75OxQqrUGYJkAmg?=
 =?us-ascii?Q?IldjC/Mz77qZXv2Ph0zuJ3eZEm3exY0eHuNYzI1HH7S/BkmqcXGeTVZtXXCt?=
 =?us-ascii?Q?Sz0vP60MRMLtxHzHkVOG5AUQUyu8X8Gc2Y7j/pkHWFP57tknwmKbfNMslaaG?=
 =?us-ascii?Q?qiaBkYsdb7ndl9kqHjimDdKo/Tr8r697Z5EtnYsxviXnhWf9wd0bxrDQsaPE?=
 =?us-ascii?Q?1uARRsxCdy2hqYMhzJ+sXpENuwIsqutOhsOvde3lzN0UmZgZfUNhmgPyFyNC?=
 =?us-ascii?Q?OtRqG/7sbxLmI1/Lc5R+tSnZGcAkmL4mwXO0/M0G2ZzjQqeh1f1r4KB9aaGM?=
 =?us-ascii?Q?OMQYTjYg+iFnl9DtT3c88L5AxD4ceRXJAcd3oUis5CZMR2NYLfft/R9fHqob?=
 =?us-ascii?Q?NHyMyqOp/tawPEzytbUcJE3qYSbsuFit81joJjCASILTFpnL8ju11ZVfO59n?=
 =?us-ascii?Q?LWYf/kcgBTorInfuiEQE8Lesos86gPwGw5TD/dAD1PzfZ14XJyF5ZFlIj+/c?=
 =?us-ascii?Q?KneuHSKxNqEFK2lDydxpcxr+ZCpBdJQmgDBkVDATil4hfVx0nXxg2DBQC1yU?=
 =?us-ascii?Q?yCWFT+CiyAyJ9vcdIlRSb/pU0kaKVc7vwN1IYgzP7azINIc7acKXpDpv/Hf5?=
 =?us-ascii?Q?dlchUsxVcnqh5fIIoU2Cuizg8u9+e8Fe2DKwFxMLDdE4BNfymMZ7eJOMcnaG?=
 =?us-ascii?Q?s2BfdrF0D6p8tmo3c9GX7F7OvzbGbVQnoNBtdWSDXXJtJ+i6O7IOiEwZlWm5?=
 =?us-ascii?Q?51S6i/ZZcBbJIRRw/ceE6kKzlAhxywxEOFj268A8yX9kPLQMVf5yw/PSRMxR?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee1bf08-d338-46e6-e99c-08dbfb22b6aa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:57:51.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69VhJRENQ8Mq1DezEGaBDXWSpuXk8QrclSxPYBej/PC3LkDaE2XSLD68/m4MUPN5xLR+EHrxedBMo9ci70xRWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950

On Tue, Dec 12, 2023 at 04:07:18PM +0200, Roger Quadros wrote:
> What is the proper way to run the script?
> 
> I've been hardcoding the following in the script.
> 
> NETIFS=( "eth0" "eth1" )
> 
> in setup_prepare()
> 	h1=eth0
> 	h2=eth1
> 
> and run the script like so
> 
> ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh

IDK. I rsync the selftest dir to my board and do:

$ cd selftests/net/forwarding
$ ./ethtool.mm eth0 eth1

Running through run_kselftest.sh is probably better. I think that also
supports passing the network interfaces as arguments, no need to hack up
the script.

> > diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > index 39e736f30322..2740133f95ec 100755
> > --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > @@ -25,6 +25,10 @@ traffic_test()
> >  	local after=
> >  	local delta=
> >  
> > +	if [ has_pmac_stats[$netif] = false ]; then
> 
> This should be
> 	if [ ${has_pmac_stats[$if]} = false ]; then
> 
> otherwise it doesn't work.

Makes sense.

> > +		src="aggregate"
> > +	fi
> > +
> >  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
> >  
> >  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
> > @@ -284,6 +288,13 @@ for netif in ${NETIFS[@]}; do
> >  		echo "SKIP: $netif does not support MAC Merge"
> >  		exit $ksft_skip
> >  	fi
> > +
> > +	if check_ethtool_pmac_std_stats_support $netif; then
> > +		has_pmac_stats[$netif]=true
> 
> 
> > +	else
> > +		has_pmac_stats[$netif]=false
> > +		echo "$netif does not report pMAC statistics, falling back to aggregate"
> > +	fi
> >  done
> >  
> >  trap cleanup EXIT
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 8f6ca458af9a..82ac6a066729 100755
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -146,6 +146,14 @@ check_ethtool_mm_support()
> >  	fi
> >  }
> >  
> > +check_ethtool_pmac_std_stats_support()
> > +{
> > +	local dev=$1; shift
> > +
> > +	[ -n "$(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null | \
> > +		jq '.[]')" ]
> 
> This is evaluating to true instead of false on my platform so something needs to be fixed here.
> 
> Below is the output of "ethtool --json -S eth0 --all-groups --src pmac"
> 
> [ {
>         "ifname": "eth0",
>         "eth-phy": {},
>         "eth-mac": {},
>         "eth-ctrl": {},
>         "rmon": {}
>     } ]
> 
> I suppose we want to check if eth-mac has anything or not.
> 
> Something like this works
> 
> 	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
> 		| jq '.[]."eth-mac" | length') ]
> 
> OK?

Maybe giving the stats group as argument instead of hardcoding "eth-mac"
would make sense. I hoped we could avoid hardcoding one particular group
of counters in check_ethtool_pmac_std_stats_support().

> > +}
> > +
> >  check_locked_port_support()
> >  {
> >  	if ! bridge -d link show | grep -q " locked"; then
> 
> also I had to revert a recent commit 
> 
> 25ae948b4478 ("selftests/net: add lib.sh")
> 
> else i get an error message syaing ../lib.sh not found.
> Looks like that is not getting deployed on kselftest-install
> 
> I will report this in the original patch thread as well.

I'm not using that part, so I didn't notice it :)

