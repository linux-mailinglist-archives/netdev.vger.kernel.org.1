Return-Path: <netdev+bounces-118441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F469519A4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97CF1F2367D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8581AE870;
	Wed, 14 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upoAHkgZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757B1AE864
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633874; cv=fail; b=EbQNJ+esgXlrunxyl9cB/Iw9bfb/dY+kFqU07k9MdqnE7EUN0lslBzfkbbHihAEw234GLavhAF06F7/s74TXkh/V9W9Xq+fAJ0gHO0aKMVdegKSK6v1s99hOJzroIkVivWCH9a97RNcZqBaMrZhTunZU0fT5EALbwg3Ao0xSr3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633874; c=relaxed/simple;
	bh=FRwN8BANTa4Ks7L3/XXI8SzCnUAzII81YWVFQtRri98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm0N3gr93V5IyHm/x6iQq/YlgU9qBdOWWoGpxajknbQZLlIUTPy05j4V6hZDWqS1Ev9/UP0pG1ekC4pgvHVDUxKwV7H5Yc6Qg5X1Sy+zGW1JO2MFPTa/GZEFo1CmYnUjeVn1MmLfPjnVAbellnqWM0FHJ2gWBPASrkU0ZLqSspA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upoAHkgZ; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCTTLIEZ0bRFc+jlnLUGwtKqthnK1obSwdioBAU4g6U10hF0N6oxja0m3h9QvFVuSa0BUYajsa3E0CEXHBRT5gdj5ynBqZ6UuI7x9jfTMl+21O4xDtGA4q8GMgwRxt4co6uh2E2Hz1Q3Yx9S160Nw3Mf5eE6RDsdV7TeMqNm5IeHUDnqM3YBeXwLHZB4Zodrku0nVPolphiVOLYpiRhnjICIxG121zVGBir6pjA2o+iflXAM3S/C8cR1yZC9z4h6CXJ6OwB0bbm+oQWoybHiBdGIYa7BPhiVSIonsVN9B+lCYQ/lxNt0Enf5pU2Q+D1KvtmxfajLG4Xe7ptwCvA6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAVTBI5D9cU1Ntqv47jjSzItE+cSP0RlwvAcrY0SGyU=;
 b=HCERR5CiTOIXslh/lbfPImC4tz/7y6gLGHsYwZp+IOaQSLi4Iv+iVRnwCvuHGd/x2AomxW04z102D7Qpnga1hfPcgmBAKklFZR3XQG3+Ctu3sHg4b+Ci/dlXv5EMq76sk1iLepey560FupZxTDQ6GfF6MM4dcW12tkBGSEcUpXo8fhXipIaP01wvF+rBhJqTIKvwEcNF0Hzma0cY2/aTekjcVxxYlcM/eyHWimhC1T2LtvuniqJ96Wftr38cB3cJXnDBAem2EFDDNV2tIurioddxmi8wxaqc/yIOv7QZkPB5hZi8mvsbC1Eh6vU5P3u/44n13B0uMU4tYmgXb/bVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAVTBI5D9cU1Ntqv47jjSzItE+cSP0RlwvAcrY0SGyU=;
 b=upoAHkgZTG1j6T0b7HVLxnc/UzxcL7mLNENRHfGvByX/4/seeKLov/lQh9KnpYln0uP4IesguyIZYNyK/mqWKZe1jIbepcaOAWC9GAbLoO96vMd6QCvYatqob8lfXORvpmja7SVccn65AxCE6LboZMFCflC0y/CsJ9yvDDJSslQhdU0PuFsW55HPw4uTN1cHb9o86RWjxPrYQtNZ9jmJPcQLSqQCMFsgUfVMgPk/uGmEWAPiqHLC0+w5R0FM0HZ9MSbr4BiJwM2kwjZxKZGix7Vy1DE8a5Tn7CDI3JlbB7c8i/dA/gAMNtqo68VH2bqTFRnyWOqPfdbD4dN+K87iug==
Received: from BYAPR08CA0029.namprd08.prod.outlook.com (2603:10b6:a03:100::42)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:11:09 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::de) by BYAPR08CA0029.outlook.office365.com
 (2603:10b6:a03:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 11:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:11:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:59 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/5] selftests: fib_rule_tests: Test TOS matching with input routes
Date: Wed, 14 Aug 2024 14:10:05 +0300
Message-ID: <20240814111005.955359-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814111005.955359-1-idosch@nvidia.com>
References: <20240814111005.955359-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b82482c-44ae-4d86-5ce5-08dcbc51cd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	3fwpllWoFVWq75RRM+ptS3TusQsOi6dgBj3JuMUNmMNEvewPRQ1ckfBSZMLMjoDrXbqBNBWuFBiFZYjgJrHJY0Kl3rs//f965mYiSd0+XP7mbRzC45i7H8AHJWAUqA7wxhOxEhLhqT3hqIH5HGvF1UH05379alok10jWsdTOUXthjo/nHNInvdr2epz3pNaXLVO/uhT0o6D0og2yQmbesFB29GVhCulsWWYy1x+TeRQSbLow0LTmHNoSm5PFY24FTOybMGA6DIWGoqIltvvzNe1cYFZBnB9Jg0pVhn0x3IG9KrXvbgIfikBxvDBFit6lOPtdZilSXRM20K0KZuUasUc0HioNVqw0CJynVYX80P2Dbw3j5HQnyijhxZMcVlKGetsSYEC1vdevXAxp9+klG4t68IRkO/oDjD1jfm7y6Ph0pnkP01E9edVXlsVpV7NXCMbOhgiA2L7aFFpYTlSKfp6khzgJopVn6guuHtu87Yyi66wMvCMLV2BYYS7sTLqQv+qCQ4tMq5a9RghoABpHeY277Gdnw6Z+MQ7ZVXEkn+ZpzyIKnndXzYDFlQvqjUjZrDNJRAQeme0LqH6r8cXnvtUVqq2/0M7CI/ikhfoLYU0Zzbtv57MTL2GkTF2rIFTSRtMuM1/po0nM43wthTOHwT/90yj3/3/mzG3p4J+4w3isWNDK8fXeVGdLeIRpboTLyYqwnnHrMcUGf8kra+OA+4Qz071t4X6D7/q0iXqIuwtx2eZvQxdAaWQsVgH3BfpD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:11:09.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b82482c-44ae-4d86-5ce5-08dcbc51cd01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766

The TOS value reaches the FIB rule core via different call paths when an
input route is looked up compared to an output route.

Re-test TOS matching with input routes to exercise these code paths.

Pass the 'iif' and 'from' selectors separately from the 'get{,no}match'
variables as otherwise the test name is too long to be printed without
misalignments.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index a3b2c833f050..89034c5b69dc 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -245,6 +245,19 @@ fib_rule6_test()
 			"$getnomatch no redirect to table"
 	done
 
+	# Re-test TOS matching, but with input routes since they are handled
+	# differently from output routes.
+	match="tos 0x10"
+	for cnt in "0x10" "0x11" "0x12" "0x13"; do
+		getmatch="tos $cnt"
+		getnomatch="tos 0x20"
+		fib_rule6_test_match_n_redirect "$match" \
+			"from $SRC_IP6 iif $DEV $getmatch" \
+			"from $SRC_IP6 iif $DEV $getnomatch" \
+			"iif $getmatch redirect to table" \
+			"iif $getnomatch no redirect to table"
+	done
+
 	match="fwmark 0x64"
 	getmatch="mark 0x64"
 	getnomatch="mark 0x63"
@@ -403,15 +416,14 @@ fib_rule4_test()
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
 		"oif redirect to table" "oif no redirect to table"
 
-	# need enable forwarding and disable rp_filter temporarily as all the
-	# addresses are in the same subnet and egress device == ingress device.
+	# Enable forwarding and disable rp_filter as all the addresses are in
+	# the same subnet and egress device == ingress device.
 	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=1
 	ip netns exec $testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
 	getnomatch="from $SRC_IP iif lo"
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
 		"iif redirect to table" "iif no redirect to table"
-	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=0
 
 	# Reject dsfield (tos) options which have ECN bits set
 	for cnt in $(seq 1 3); do
@@ -431,6 +443,19 @@ fib_rule4_test()
 			"$getnomatch no redirect to table"
 	done
 
+	# Re-test TOS matching, but with input routes since they are handled
+	# differently from output routes.
+	match="tos 0x10"
+	for cnt in "0x10" "0x11" "0x12" "0x13"; do
+		getmatch="tos $cnt"
+		getnomatch="tos 0x20"
+		fib_rule4_test_match_n_redirect "$match" \
+			"from $SRC_IP iif $DEV $getmatch" \
+			"from $SRC_IP iif $DEV $getnomatch" \
+			"iif $getmatch redirect to table" \
+			"iif $getnomatch no redirect to table"
+	done
+
 	match="fwmark 0x64"
 	getmatch="mark 0x64"
 	getnomatch="mark 0x63"
-- 
2.46.0


