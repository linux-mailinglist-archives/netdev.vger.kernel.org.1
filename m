Return-Path: <netdev+bounces-225038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9C8B8DD1C
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9545189CDFF
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9BD1D63F3;
	Sun, 21 Sep 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U2+GjXd8"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD6199FAC
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467417; cv=fail; b=HrysQ37HdP7dBfZutcgj9eNY8/HRrmzj+KZjzD4wM1D6/4yXws558dbPet91c3+xZY+XdkDbSqkhUg+h3Ar7jnE+eCWiwu/4u6EGFIytxadbd5GCFSuSpU5KOU7O8hVdkUg3x9mWSv19Ns9duiH5OPXMDtvUDgdXb3WtU/obiqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467417; c=relaxed/simple;
	bh=ok53FoMvD6tLN1ANMwewoWkdCahohHyr45dROgdd6I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVVloJHxslms9F1WUD3GNYr5G37En7+IhsL5iN+dCXZ+o6EtYuWin05tHYsQno/hPBdErnT7qBpCafT7HGeVUt20yI3VsShk1LgBZGamzmGp//awUr5eKrJ98AsIPIvZEGKGJk/cO9okKKNWzs0DdhmnYBSva2Q8Fn35yorqOKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U2+GjXd8; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtcc0HnVGLCRZuUov/RT0FoHoornNdxQmIEjIlMOg0LyMjWhUPzK37EfAR8BlafvUQhv/IUbZzxSX9ar3b8F4dDkcUmi+Q40FGw+8KqX7uopn1GFXN8zZ6kxaIAq8wgMA9lNw7GW2GRj/+HMSnbyD5VuNnuQvYoxY4XXcmExrfEV6hvgfvHTIiBSenvlcyOJrH1uUp1io/ABYQWjqdJgui+BJEEK5dBcD3VGXy0tKDZKcv5j0kOdGgixHyZT8FwkTJmXTkxIHgULaykCULGyOHo2ZqbwNKSU4RQPKtrXFKZvyU0mGiMROne5X6mNjZC5nkYGztJnwQj9+6vhKK961Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx+V9y/o/VRbMEpGgnZ5TIIwnBpZLsoSb564jbhdumw=;
 b=wLXAMibD/dO93M2XLQiFGorTFqKr1gmi9EvwJg1gmEhwB2cYesbsd0mFAQEu9sUrrJtpWXZWycnCO+3+cOP+2i02CbKc9GJdzQYLbehWz57UR8OFybpQyqnA1x0kFvaVfdYM8n3yTO4GC+Jbkt2nS4EtThHwcLqwEGaUXWRwNTPVPa+KQJYuZu7MJZ9JnIgM2k4jpIxXD0aBsooeO55Bl9fhmwLTZUAKghFyttdu417lSVO6hVWoCF9Yw7g2ZUbL1QpHu7wnbXoEbCU0pIsnnqy+DXODNwr3wHXPptKVK42w+JdF7QjvvZJiQPPAiA+orsJeJc9iw5JoQcJB55c5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx+V9y/o/VRbMEpGgnZ5TIIwnBpZLsoSb564jbhdumw=;
 b=U2+GjXd81O6jkHWq0X/NNK0QVeuLRGJQj2UrWp4I4u18/zVPp78nlJK41dx8I1rfmdlCx+5bvjhcwNVsch+IXiTgBw29V9O5Sn9dfdb0qtv2ZnMnAgyUCMSpnRV4fBLVbTAdXbSAqHDy/+JkXUZuxI6xDs3Y+Dt53bZ/JcllyA2f0Wb3SrXTCx6lDBwODR737U76wo6QgP3M3FQg6WSvW7kDvDDO+86ybvgVrraUV3ywdAH3+cDy5vGM0wXaNnHXo/LZHBmbIOqq2O7SmNpl1Fiz/obzwuIdXe1YJzy5Zp2LTMCNWBn5sX22V2zTwZQevUSWRB6YDfP3mwGpg4Jptg==
Received: from MN0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::35)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 15:10:11 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::59) by MN0P221CA0022.outlook.office365.com
 (2603:10b6:208:52a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Sun,
 21 Sep 2025 15:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 15:10:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 08:10:03 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 08:09:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<petrm@nvidia.com>, <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/3] selftests: fib_nexthops: Fix creation of non-FDB nexthops
Date: Sun, 21 Sep 2025 18:08:23 +0300
Message-ID: <20250921150824.149157-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921150824.149157-1-idosch@nvidia.com>
References: <20250921150824.149157-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 6969c64f-f408-46c4-30e5-08ddf920f596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rm9CWirJhViOFjxKIL859T7+R/1O98xbTFdMtMktn+zacM6Yit8RGsZ+eoPF?=
 =?us-ascii?Q?o+AsRnLf7VHOVkFd0M/zVDAvX9mLebjPx9fslyBNOoneXbq3c5M0NYJC5qo7?=
 =?us-ascii?Q?ttFCuHP3iNEZW0QAH/knQobOsTeeYc6gyQQ1Pd/3lZ26ps66si4a0nRQxwgk?=
 =?us-ascii?Q?jNrtB2hZjIy4+ZYXrSLR0iJeqWk3AiGQBakPMP5Mc3vUx9n1UmWB81gI8Oy3?=
 =?us-ascii?Q?3tWLoqcCaLBbQaJMctm5PE8n/tE8HoI9NCIVf43co5Xyds9T9k84gKi5ckdT?=
 =?us-ascii?Q?WRjerF5Deev+CRQPcNTFYGPJ90eZa1QOwqav9WDFv/vZzzXPHgNtxG4AMj5A?=
 =?us-ascii?Q?65UDg26ZpTUij8SBqW1p6wnpvyJy2l+hqAPfE3tLZvD1DxrIr/iJK5FaN3cO?=
 =?us-ascii?Q?eVt+XPWIOz2xTIQaW3A3r4/nvjUWQFXAgkegCIC/tXlONXCHIVWqAKncttNA?=
 =?us-ascii?Q?0VCYfaiLhTP/e0Ep8BN93x5c3N9iRAzikkNQPfMvz+zhSdZxtbnw9kwyjQb8?=
 =?us-ascii?Q?1KpeNvqtHg67dqBJ57FJTL97GjO3gdCJ2/hMzJaGMVBqCBFoYbK0u3Z3BiZy?=
 =?us-ascii?Q?poLUzv91NzdBAthqaMSo8TlkbxXB4PcPPTakMX82B/CRs9TFzdLHM9wAKbQs?=
 =?us-ascii?Q?VxAytE3O14OVdNB0O3SNi6Viieo4n97Dzz+txphDpok/CCfYv4OSP/Gd9Id2?=
 =?us-ascii?Q?ifPLpp0lbBOk81MnE9IKdCZebLnHU9eC2ngb+RB8pvcnC4kXSDaiX94vMe1A?=
 =?us-ascii?Q?m0bH15BnIMVYySXwOHxtH9xFWAywDbT+bBjWxZdtAU/6vM7w8PJ9xXxz90Js?=
 =?us-ascii?Q?rC17cdfJqOBtxjB6sxKM0X6sy2yiMLB8kyj/dMnO/UprVXz9pNqgoKsq35Zu?=
 =?us-ascii?Q?NPtbOmau264S7/01W3Wo4E4mzaG9R+4Cj24SS8vfeX3aiI8Sge4+4PzN83t6?=
 =?us-ascii?Q?olCn9rrie68qgr6GDL60WyJSgmpF+xK7vDqzk9ziKoY0RQJ5UEM9BnQ3fazy?=
 =?us-ascii?Q?ksXwbepSfYExjPkSeNRBkOoUJhKwy2WmrAO8JtAxVbe+Bx+r3JRSTJ7uxUxa?=
 =?us-ascii?Q?RrFHUwMJAsPXdOvCKB1D4vWgxmXbM1DvXGPGgVeES8xvI94QsnTZ2xghYHcq?=
 =?us-ascii?Q?lkqRV9h/CXaMNMGdaKsCs/c5jCFnHCIAv8XmiLyLbGfEKXhbGrWuqs/h6IQj?=
 =?us-ascii?Q?m3wRTnsM8yY8KjAQKRW8y3STUEyX82VVXbc/tzUt0d7NZeIlv7tw0W+WGDhZ?=
 =?us-ascii?Q?mN1ji3BoO9BcABryJJa5xHL9IFFft/6g5dHDuS9h8vfzV5UJW3zoZp6UaQfk?=
 =?us-ascii?Q?5G+76LUq58d8Q4uFBhXNIBO9IYGXsEOqmdpkiEVQ9/eH/Xfda8FlLdcRknLX?=
 =?us-ascii?Q?neinLZir/P25xiOVOsQzUkjLdx3/qU81G8Tji3hAKyE7jqSxj4Zcx9d4PW5c?=
 =?us-ascii?Q?/BF/JS+OJJiQX1OpJGI3ypxqswm1A6yw8kg8v0e73RLJdDeBDHYDtuwbfiqp?=
 =?us-ascii?Q?ufLKaxcksF9kfWRUsv+oD+TuskZTEOxpXWCx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 15:10:10.9170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6969c64f-f408-46c4-30e5-08ddf920f596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

The test creates non-FDB nexthops without a nexthop device which leads
to the expected failure, but for the wrong reason:

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v

 IPv6 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-nRsN3E nexthop add id 63 via 2001:db8:91::4
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 64 via 2001:db8:91::5
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 63/64 fdb
 Error: Invalid nexthop id.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-nRsN3E nexthop add id 14 via 172.16.1.2
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 15 via 172.16.1.3
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 14/15 fdb
 Error: Invalid nexthop id.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]

 COMMAND: ip -netns me-nRsN3E nexthop add id 16 via 172.16.1.2 fdb
 COMMAND: ip -netns me-nRsN3E nexthop add id 17 via 172.16.1.3 fdb
 COMMAND: ip -netns me-nRsN3E nexthop add id 104 group 14/15
 Error: Invalid nexthop id.
 TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
 [...]
 COMMAND: ip -netns me-0dlhyd ro add 172.16.0.0/22 nhid 15
 Error: Nexthop id does not exist.
 TEST: Route add with fdb nexthop                                    [ OK ]

In addition, as can be seen in the above output, a couple of IPv4 test
cases used the non-FDB nexthops (14 and 15) when they intended to use
the FDB nexthops (16 and 17). These test cases only passed because
failure was expected, but they failed for the wrong reason.

Fix the test to create the non-FDB nexthops with a nexthop device and
adjust the IPv4 test cases to use the FDB nexthops instead of the
non-FDB nexthops.

Output after the fix:

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v

 IPv6 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-lNzfHP nexthop add id 63 via 2001:db8:91::4 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 64 via 2001:db8:91::5 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 63/64 fdb
 Error: FDB nexthop group can only have fdb nexthops.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-lNzfHP nexthop add id 14 via 172.16.1.2 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 15 via 172.16.1.3 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 14/15 fdb
 Error: FDB nexthop group can only have fdb nexthops.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]

 COMMAND: ip -netns me-lNzfHP nexthop add id 16 via 172.16.1.2 fdb
 COMMAND: ip -netns me-lNzfHP nexthop add id 17 via 172.16.1.3 fdb
 COMMAND: ip -netns me-lNzfHP nexthop add id 104 group 16/17
 Error: Non FDB nexthop group cannot have fdb nexthops.
 TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
 [...]
 COMMAND: ip -netns me-lNzfHP ro add 172.16.0.0/22 nhid 16
 Error: Route cannot point to a fdb nexthop.
 TEST: Route add with fdb nexthop                                    [ OK ]
 [...]
 Tests passed:  30
 Tests failed:   0
 Tests skipped:  0

Fixes: 0534c5489c11 ("selftests: net: add fdb nexthop tests")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index b39f748c2572..2ac394c99d01 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -467,8 +467,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -547,15 +547,15 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 14 via 172.16.1.2"
-	run_cmd "$IP nexthop add id 15 via 172.16.1.3"
+	run_cmd "$IP nexthop add id 14 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 15 via 172.16.1.3 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 14/15 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
 	# Non fdb nexthop group can not contain fdb nexthops
 	run_cmd "$IP nexthop add id 16 via 172.16.1.2 fdb"
 	run_cmd "$IP nexthop add id 17 via 172.16.1.3 fdb"
-	run_cmd "$IP nexthop add id 104 group 14/15"
+	run_cmd "$IP nexthop add id 104 group 16/17"
 	log_test $? 2 "Non-Fdb Nexthop group with fdb nexthops"
 
 	# fdb nexthop cannot have blackhole
@@ -582,7 +582,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"
-- 
2.51.0


