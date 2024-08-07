Return-Path: <netdev+bounces-116512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9194A9B9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673031F2A6C4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BA768FD;
	Wed,  7 Aug 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cn9X8aRV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8B38DF9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040112; cv=fail; b=KGsG/sxBHL9obt4QoW49SYndTnHDcOhLMXoC9xi2Xt3vCSxGTDWoi0CXOmXv90fNm4gK3xWCNSoXOYOMT8ZgZ0Z/F1/1O1l2FhKJx/mWNGje9+a69aDZC09A4TfW06MzmxS9Fc7gPABRf+LsYD6PCZvtczVWt7fnNNwvEexpH9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040112; c=relaxed/simple;
	bh=6miFpYNzRMackEeOydVeriAmRtU5V7tYZMn3F2kFz8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL7AegIOkWIHWsS/IkncAuqbGWJqd5LSAS7S6Wk1mTtnl0Vlgahs/vOgERF4A4j71TZETsUckozGDKLRqFyDgiAi2UOWV02aypzqIU95liU6Um+Xvw4MKXHbUWV1myV402FTLEnG1bG19B4MoVNTVNmapXrS1hXYoSeghC2uaIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cn9X8aRV; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLV/USyw/EJ6O+9SyL8Z2KCpe7uvYma86C6CWdYT4/BtacZK42C8xzN9O5r07Da648Xq5gB/5h5UX/p/NNOUilm2J8FSu3CPnNnljwW760Fd5w6WO98JleO78AUt3PKv6wkhQiqqc78qV0HrnK0j6XDomo+QYeqCMv5NSChsLij3Id2pjSYE6WUmIRQrxLm4WN2aSsiL/abEus3BLMPLdLGGRqoF5vCY0JZH4UKOBwJkuwxNIBvvLr2upqsoemt1EX+ApDnWeavr7gWelp4p1H4aiJMpoWE0N6rznpheuKmdNZX2iGiX9znJi/KAivB3Lw4z7XDaErF30F0ACHbibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k0lBMy5QZSZR2BzfxYcrA95bG0Ibu2+a7VTRIyMqII=;
 b=oY7oZRwc6pJyCixwhGJQJ/Gm4oiv7n1jcphOZ6tt0/HFmF2Ez0NRAIXQ0fW+0WDOTyMJsaPBA76wi5TUyrqp7cH8vlE69ZzBtQriCcDM+4YQucAmkjYFBG6FyDOJfn9+pYz5LsiraQPpkS5MQwSfMduCaEF4V7hRhvbB9fxOEn7iCXYNPvRZ2lDDNdisrb1eZbFFx9GX3+26p0ruC1y7Y0gLO0nGbqcFKnM5mSOln+CtVmjRGggEXH72rmMk7ip1fSOYnWm27fXhL9X1i4PwX/yJiAqlFyrlRnlwRbhRk1bbkw3z7OueBJAg+ZvI8A3XDgIL+ZPrBldn/GP/0jMJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k0lBMy5QZSZR2BzfxYcrA95bG0Ibu2+a7VTRIyMqII=;
 b=Cn9X8aRVrFDXcluD/7hSGLiiwkbt3YF4aLm0guAwMNEaUiABATK638KRt79Y+ECDPZh7ixYj9oNxe3VGE2NIhjo40jjYwNGv9eL6KpMhgTS40FmJDsag+bCgOsNDKHUfVSEOM3Z39m9cqRb/Q6IS2j7s3ma4Ud/3QdpIii/3clF9RE1d0GDV6WgUyCZtg26HgGOBLSv49zAY+/5gsqqdB5pXJBjvnrUdGHF7UkHJ7ZKO+8phNIYD5dM4uujHAnT3uJHIIjrqSgDi4z0fMZZ4Ea/m5EnsN1zCwUnyFp8XdB7VMm5YBlpcGljCb/jameMw5T00QneCIPlKJgjzFMlAPw==
Received: from CH0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:610:e6::19)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 14:15:06 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::9c) by CH0PR03CA0284.outlook.office365.com
 (2603:10b6:610:e6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 14:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 14:15:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:48 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 6/6] selftests: fib_nexthops: Test 16-bit next hop weights
Date: Wed, 7 Aug 2024 16:13:51 +0200
Message-ID: <101cdd3f2bfd9511c9bec95f909d20ff56f70ba5.1723036486.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: bef0d631-41d9-4688-aec1-08dcb6eb5641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VFUT6jKsyr7vrCxSrNl7mZI28kWc/ETILI/Bt+ZDv82U2stychYV9SwIm4MY?=
 =?us-ascii?Q?JUuW+m6Bd9/O4CB1jl3s4KFv4LDOLdEzoqxZWNm7ALupLW05WxQwIp7cxteZ?=
 =?us-ascii?Q?6k2Ipqxja5BPxMZ8QU7qI6smjSzq6ZM+zELCFKsyPlygsQlCAsIfl/iYmVMC?=
 =?us-ascii?Q?jYSpxXStm/qiDyxewRVziM0CObDBLo10hcu8Bd3Ozmml+x16Gd2XBAjodRZD?=
 =?us-ascii?Q?ts38o8VPl1JeFBJlym5JN3hQClqTRlLV3pmaGhdm4VK3ejza6rJponAbFdDx?=
 =?us-ascii?Q?YaiXX6gjz2/KIINR4QCHtuslxisRwkSpDtq+zS2CSalnevxe30pr5HGZvy9L?=
 =?us-ascii?Q?1PrgmgE9bH0jq+lAjC67+KD5gbqSwHSBC8MP90cX4NSS5S+ejwhOaIfsw4yf?=
 =?us-ascii?Q?wAvoC6PFVMEdTfMHoGBCButj745n0H0JZFjGcbyitVm7462aZxTkvUOia6xW?=
 =?us-ascii?Q?hGLcnkuFOKwVa3fmXjoPg9GpmAYcz9FC6D6uJEHF3SQT6rgEAiOwnwee4+NK?=
 =?us-ascii?Q?lDVuBb/k0bYoQyC5iJUxZYMvFkr7oyDx6pgZBMFY8qP+QjEehIJ3xUzFFh0m?=
 =?us-ascii?Q?F40Ypk8BsTZIm/6wadvncMaedLuPF8w5DJ16Y70geBPGfDV07ZBhhxJNUOwa?=
 =?us-ascii?Q?GQdqU6UdnAZ9RZ1nN1bZvwSR8Nc0u7Ely1Sv+zXkSC/rerxYZejUzsQyoaEM?=
 =?us-ascii?Q?ihCbHgwDBesHDPWvKqnUaJ5MOas3924LncIiHX7r7BPFTWZEgLwRbgNkHZR/?=
 =?us-ascii?Q?iQLaIXfA4Ov/Hhfyh4cBhgdfgfhZfRlx4Om2dR1kJajRL8jKW4LZOmxlulG1?=
 =?us-ascii?Q?ueKzlElu9AZ+S8nyNuxo/uEw11eg3LTeWL4Q5Y5nUFVA2Q+8UIFJUzToxj2+?=
 =?us-ascii?Q?L65agI38c3fh4kMGWl0jdCN1wPYEgD3pBlLJh10bIcadd329A03I8Z6GBYOe?=
 =?us-ascii?Q?Ahlf60alVReuovSqKlkJSdsAIdeCxzr5n5e6zNf7KgLygkjhH4+nuAyQ1D6F?=
 =?us-ascii?Q?o9IBt3ILiNhV7rgHqk04sCusvcq/es+0QRZx1OwGDLsI5ZJgq0kfquuo3Wh2?=
 =?us-ascii?Q?dB5ZU52aJXlPya6/shLsXe4d/z5NqMMk3DdnU06YjPOhCJbg5sXsYCTqOHQd?=
 =?us-ascii?Q?ldv31njxQvKRYgfdvkQHCHfJFg4h6l4ZkTmHV42HQSGjJAk9doVmss+r85z+?=
 =?us-ascii?Q?LhlsL8Qs3GzKdVQXjRBTVCK4oWIniein5e81tBCPCfMmeC6OtcInKZTJiGke?=
 =?us-ascii?Q?S4Fx3+n77kVmX6fuyCmbYzRnQBlT6TNtOkSfCRMVddfQTUQxtxCRLyoIb+w+?=
 =?us-ascii?Q?F8EQT8YdLm6lETARzFXCW/HQQ5iYJ5n6o/4qNQs5zlXVKvvmWOlsign+mywA?=
 =?us-ascii?Q?ByOCE5/WbX/y+7SFQCC0wjwQZEV9Hy/VBOXX01VklP9tscMGtwCMuaiwHv6B?=
 =?us-ascii?Q?92lsnnos4RneYLsp+q5N1YnpIPlNCJov?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:15:05.9076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef0d631-41d9-4688-aec1-08dcb6eb5641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

Add tests that attempt to create NH groups that use full 16 bits of NH
weight.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fib_nexthops.sh | 55 ++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index ac0b2c6a5761..77c83d9508d3 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -78,7 +78,12 @@ log_test()
 	else
 		ret=1
 		nfail=$((nfail+1))
-		printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		if [[ $rc -eq $ksft_skip ]]; then
+			printf "TEST: %-60s  [SKIP]\n" "${msg}"
+		else
+			printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		fi
+
 		if [ "$VERBOSE" = "1" ]; then
 			echo "    rc=$rc, expected $expected"
 		fi
@@ -923,6 +928,29 @@ ipv6_grp_fcnal()
 
 	ipv6_grp_refs
 	log_test $? 0 "Nexthop group replace refcounts"
+
+	#
+	# 16-bit weights.
+	#
+	run_cmd "$IP nexthop add id 62 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::3 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 65 via 2001:db8:91::5 dev veth1"
+	run_cmd "$IP nexthop add id 66 dev veth1"
+
+	run_cmd "$IP nexthop add id 103 group 62,1000"
+	if [[ $? == 0 ]]; then
+		local GRP="id 103 group 62,254/63,255/64,256/65,257/66,65535"
+		run_cmd "$IP nexthop replace $GRP"
+		check_nexthop "id 103" "$GRP"
+		rc=$?
+	else
+		rc=$ksft_skip
+	fi
+
+	$IP nexthop flush >/dev/null 2>&1
+
+	log_test $rc 0 "16-bit weights"
 }
 
 ipv6_res_grp_fcnal()
@@ -987,6 +1015,31 @@ ipv6_res_grp_fcnal()
 	check_nexthop_bucket "list id 102" \
 		"id 102 index 0 nhid 63 id 102 index 1 nhid 62 id 102 index 2 nhid 62 id 102 index 3 nhid 62"
 	log_test $? 0 "Nexthop buckets updated after replace - nECMP"
+
+	#
+	# 16-bit weights.
+	#
+	run_cmd "$IP nexthop add id 62 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::3 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 65 via 2001:db8:91::5 dev veth1"
+	run_cmd "$IP nexthop add id 66 dev veth1"
+
+	run_cmd "$IP nexthop add id 103 group 62,1000 type resilient buckets 32"
+	if [[ $? == 0 ]]; then
+		local GRP="id 103 group 62,254/63,255/64,256/65,257/66,65535 $(:
+			  )type resilient buckets 32 idle_timer 0 $(:
+			  )unbalanced_timer 0"
+		run_cmd "$IP nexthop replace $GRP"
+		check_nexthop "id 103" "$GRP unbalanced_time 0"
+		rc=$?
+	else
+		rc=$ksft_skip
+	fi
+
+	$IP nexthop flush >/dev/null 2>&1
+
+	log_test $rc 0 "16-bit weights"
 }
 
 ipv6_fcnal_runtime()
-- 
2.45.2


