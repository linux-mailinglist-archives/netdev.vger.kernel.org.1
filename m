Return-Path: <netdev+bounces-168040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6777BA3D2CD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C23117A67A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2461E9B1C;
	Thu, 20 Feb 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7dJLbsH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361961E5B78
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038827; cv=fail; b=dpcd3Tc/SkrLCxR+hKHX4adwNTDJTW7ztDjuPqP+tSN56jw/ysVLJWKrikNNgvLAp4/s9fN5CHCTpY6f5+hZqPBfBGVHqPsGyjZCTj//s+GGPiyGMeSzD+c9VrJnrKFi/r+f02on27vSEnqCLWcCH7k39Gi1V8RoD6ag715kjlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038827; c=relaxed/simple;
	bh=xmeh0h+xjVp3rSedYsEEykHLcL3iqUcJmiGhYDUZ8Us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3Qvc7WQ3cvybHtvhUa7pCb1RJOLSHK+8E4W2jxhTwbgAshsETN0rl7HCR1d5IIofZeOU+0tFKl4W/RT/tevdXx/apDkSGVShLAMZMTQyEXxiPuyQRM5wjSIvM4dEa986gfdVeyECOpTmU42yhB/S2pS24hT7MTjY7KnxTFWid4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7dJLbsH; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl4BdTOQx3v/s8Tc8vwqc/RwixK8llB+ppoMt1cjqHklKZFME347Q5S/bMSrvblUBkeaL+FijX8iXLTbfMXNzkF9YQh4d6lEgqfvKSPwzX1IYU24lTnpXUOkDb13VpnO6ZxVqnNGP10oVlbARNhZDDC2hvcS+AoPCCCcyuW0IZfmcd8kR7hBPVlaM8fS05d4IHz98wXBZcaqSZONjDPIbguIGxos1RLhLTnKx2DcCJxzoyXtVTaLzbCWD5wRL47PMafZnBtT5f18XbOKXPjIeBgu1V4TfyTfLVS3Ukza34oGCEQZTf1dfDyWK1derKNhCUKIGGKT1raPMCDcQS8EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kahi7V23ScftKRfdweb3jD/iy7fXxEMS4DOsnwBXWlg=;
 b=Xy82oqGq3CNqZfWHYy9c1gj+1qQSrXqhyBaddL68nhMDV0lib2n6JWjvTZWtON01GqF62259TLUHUKGA4QStsLhXgbPR94thgIbnf3yIbr8wm0YsMTJFBUzbxa0qwkdBRRURhpJ3JMAdK4Xt4GvhNs/nAakVA5FjY3GziJsEfD/i38XGgRMc9yl8k5yEgB+6OvivblD6jB7UHXgrK9nJbpLrdiO+VFjT+fLdE5f/l1RwjAXDHaHp1l62sTtbz2EnJ/AwJoMNrT/sQ62KNbJgmLVSuR6c1UMCSSlr7E0JBL6zphbhy0/g/4lj8Fdvv9ikimT29USpvtZ6sk0SxVoqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kahi7V23ScftKRfdweb3jD/iy7fXxEMS4DOsnwBXWlg=;
 b=Q7dJLbsHUoBGvQ2aTe3IFEkwmuPVimLKCnhV+zrphQKwFiftEBAv9GyerWagugye22cb2CiK/tq1sSaYS0k63dr9VCKRivDBo1oDVKVvSAnKUtYGFSt1HftjbDhaxsPaO064sL2BI/5+oFs0uZf/If1tMEpGQmJD+TLEn9NftbohuWmSTRAj2kHWZbLe4ZaJX/XAeXgRrcGUyD4aaTzFD87n6yIWs4VFqtlx7wrPbZK/zhUdIZYN8S3Fl5+diz+doxhtpZjkCZIvr43BhYFqdjDDfPBn0NlaLqayz/ePaDAqt/k8ImQFzIafHwx518MthJyePxHTF4bddYZhYnCY9Q==
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:07:01 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::ce) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:07:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:48 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:45 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 6/6] selftests: fib_rule_tests: Add DSCP mask match tests
Date: Thu, 20 Feb 2025 10:05:25 +0200
Message-ID: <20250220080525.831924-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>
References: <20250220080525.831924-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f32c52-29fe-4403-1080-08dd51858e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLbd9Hy7zVT/crr8moAhV5u35sxKrr6WV5rG0r1owGS2w0SJgAXJQLAFSZW0?=
 =?us-ascii?Q?nR8ia28xtE6Ge+6BT78Rko/wbOQIl1LsHs1PKwqWTLgtpqxxs1soYPX8G6Qw?=
 =?us-ascii?Q?el4sFR2fx63AS92F5EVPSr0WPn7Px4TvgWE9YqgPRE38bVvxthb4iHLSsRLv?=
 =?us-ascii?Q?xirgs0uedS39WfrBZnNpfKYdPaC+ZV4j5bca6zvQv5s7/gRMFKbRXTpNHvE4?=
 =?us-ascii?Q?eC/BbEn3p99iGIt4DRsurHchh9pSjnnrPSOaEjeIjj8zG68RQgRNOc5mcl+m?=
 =?us-ascii?Q?UHFE1rMeZ7bbHBWxejmImUCARYoMRgUfVfePZKjMYQlER7IIqYGt+f/VyPzN?=
 =?us-ascii?Q?meQKwKyQbbrrDmjNFsFIUbb9s4+2WR3BiDpQ1ZkcuLWDjWA+MconU3tVCWZ+?=
 =?us-ascii?Q?hiqd6XAZTmBd1SAPOUN/NJ1qe+2R+gLvjTEm6XAaDOqvS0NkDvunc/8BCfel?=
 =?us-ascii?Q?YBTC426oP4wG7Mmj1FZkIcL+9B0hUX15giu/Tq2E9w+/c2+VXbeM0Iv3ptv2?=
 =?us-ascii?Q?9C4+3Pm0T1VJFmswZDnNrM2/uyGZZF1kEQk4xq+uoAknPl+UuEh8LCkK6AOO?=
 =?us-ascii?Q?5km1cg7KDmHvJhuZuqweOnFSta+nyRHmCo7z+w4039RipatpCT6DMpH2i7of?=
 =?us-ascii?Q?j4hjqBv9kXNkkgGgioSymbVSQ9MWTXUIY8RMsCvoauRR8BGMobLs2YcheRy0?=
 =?us-ascii?Q?Y+ITwqS+Qjr49uVf/irjP4Xmaw64oE8uyLCBSmDhNf3BgFMuBtXn5mZHAsrZ?=
 =?us-ascii?Q?Y/AT1ox3utbkrSAQ/nORQrPPZgFJDvy9yVs6pvNk+G01vS7DaBEmtfO+yDvp?=
 =?us-ascii?Q?tYSpYZ2GEwxoGdO40Q8GbQUvCh7cjp2MvYaLg481/vQTmxmYm+I6CPwq7sEN?=
 =?us-ascii?Q?DJehs9aUTkCSby7qwz0xtrZBArvRQKiGP0ZlocUo/v/aNdz4muiG2JVedOme?=
 =?us-ascii?Q?fd4RRPAbPI8yYm+PV73NZk9vaYh7RhAXIRbdkjmwEq6FIr9A/vmthD8M9EJq?=
 =?us-ascii?Q?S3r6NIe1PBv7EbpKur8/q54k2YOaM239tgp3V0jcQRO/61eb2L26H2gFTTt9?=
 =?us-ascii?Q?YSyjFxzPhiu2pj+4Q34dovnRJzA7gywZu6WoOsNxe6sG3P/1e/iM6qfrx2js?=
 =?us-ascii?Q?l+D2QkYsQrz/Ui/G3iQykx0hH0e5lvAb9VvUiLWfgiQwxPK9ZwNrnbfK7fq1?=
 =?us-ascii?Q?yxU20Y6pW0oifEMeJcaqe7o6tCH2j9csN4GjK3U6SZG1G6CM1+z23wsWQ5tT?=
 =?us-ascii?Q?21o9kblQsAwJg9J+808NB+xqr3i1SfUaQO/qJCEDPsTe/dabQImZhOxcr6Vj?=
 =?us-ascii?Q?VLJJSjaig8s1hEVBGJciv6F40jQwUujJVGZ5gxiqmemxq4Vub0oh3nK++8Yt?=
 =?us-ascii?Q?YcwBlzbQLm0zZCzkye+KMO5Lik1BRSWF/P6FQUWC4TmgNUZRY94ozMVpjttm?=
 =?us-ascii?Q?plqQRfvEnGaDLGpO2WcgyTiLOcWQFwpaCN/+PCT6r18cIjhwW24C0MDwsttV?=
 =?us-ascii?Q?TpqxEhik8NaYKzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:07:01.6036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f32c52-29fe-4403-1080-08dd51858e5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

Add tests for FIB rules that match on DSCP with a mask. Test both good
and bad flows and both the input and output paths.

 # ./fib_rule_tests.sh
 IPv6 FIB rule tests
 [...]
    TEST: rule6 check: dscp redirect to table                           [ OK ]
    TEST: rule6 check: dscp no redirect to table                        [ OK ]
    TEST: rule6 del by pref: dscp redirect to table                     [ OK ]
    TEST: rule6 check: iif dscp redirect to table                       [ OK ]
    TEST: rule6 check: iif dscp no redirect to table                    [ OK ]
    TEST: rule6 del by pref: iif dscp redirect to table                 [ OK ]
    TEST: rule6 check: dscp masked redirect to table                    [ OK ]
    TEST: rule6 check: dscp masked no redirect to table                 [ OK ]
    TEST: rule6 del by pref: dscp masked redirect to table              [ OK ]
    TEST: rule6 check: iif dscp masked redirect to table                [ OK ]
    TEST: rule6 check: iif dscp masked no redirect to table             [ OK ]
    TEST: rule6 del by pref: iif dscp masked redirect to table          [ OK ]
 [...]

 Tests passed: 316
 Tests failed:   0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 06c51d7ceb4a..b866bab1d92a 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -310,6 +310,25 @@ fib_rule6_test()
 			"iif dscp no redirect to table"
 	fi
 
+	ip rule help 2>&1 | grep -q "DSCP\[/MASK\]"
+	if [ $? -eq 0 ]; then
+		match="dscp 0x0f/0x0f"
+		tosmatch=$(printf 0x"%x" $((0x1f << 2)))
+		tosnomatch=$(printf 0x"%x" $((0x1e << 2)))
+		getmatch="tos $tosmatch"
+		getnomatch="tos $tosnomatch"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "dscp masked redirect to table" \
+			"dscp masked no redirect to table"
+
+		match="dscp 0x0f/0x0f"
+		getmatch="from $SRC_IP6 iif $DEV tos $tosmatch"
+		getnomatch="from $SRC_IP6 iif $DEV tos $tosnomatch"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif dscp masked redirect to table" \
+			"iif dscp masked no redirect to table"
+	fi
+
 	fib_check_iproute_support "flowlabel" "flowlabel"
 	if [ $? -eq 0 ]; then
 		match="flowlabel 0xfffff"
@@ -597,6 +616,25 @@ fib_rule4_test()
 			"$getnomatch" "iif dscp redirect to table" \
 			"iif dscp no redirect to table"
 	fi
+
+	ip rule help 2>&1 | grep -q "DSCP\[/MASK\]"
+	if [ $? -eq 0 ]; then
+		match="dscp 0x0f/0x0f"
+		tosmatch=$(printf 0x"%x" $((0x1f << 2)))
+		tosnomatch=$(printf 0x"%x" $((0x1e << 2)))
+		getmatch="tos $tosmatch"
+		getnomatch="tos $tosnomatch"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "dscp masked redirect to table" \
+			"dscp masked no redirect to table"
+
+		match="dscp 0x0f/0x0f"
+		getmatch="from $SRC_IP iif $DEV tos $tosmatch"
+		getnomatch="from $SRC_IP iif $DEV tos $tosnomatch"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif dscp masked redirect to table" \
+			"iif dscp masked no redirect to table"
+	fi
 }
 
 fib_rule4_vrf_test()
-- 
2.48.1


