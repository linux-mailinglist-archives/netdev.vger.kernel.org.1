Return-Path: <netdev+bounces-118438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7AD95199F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BB91C20880
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1C1AE84E;
	Wed, 14 Aug 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elVw/bDW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50419FA66
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633864; cv=fail; b=pCoeHsfw1l1JypskaeIVNLocns050nHSh0zorc+CbZnfyMZV2y6j5SyAp0MTJNRbqlm47x95mGYyja06RPNE5r9RNCUsf6m0ecTQJZQ76TnUw9vypQa09RbgkoGnRYfDhY2L1CK+1VIfmnIlPPCIwMcLIw4pX3I7u/+eBsNxBHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633864; c=relaxed/simple;
	bh=HeanNDoyn6qroYWEOlm2GhD9g6Y1rTNwF+VbjXjYjJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBnv+NzbU8/TSgtyC+D2haH4oibYUpv4h4IOjIIB60xcYyNSQXwJJNw81JgKvR0MXakoPK6Bj58QzYeAajsyjvbZi2yT4+Zgd+VeJUtILKe7IRaUlPE17RxnX6Vsgt3zjL4OFrXblvFJCkDuEaHIzgDQ4midhtei2rClUaLtBlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elVw/bDW; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7DY2HbJyoMdi/hJLsGgyM/ceQzVXI2cNaGRPZMb87KB8Un6iLIHaFXcOWJ2bYIy6wxA4XM5mvq42p0e/lF1dLvU5MYM85mdrf7eKwzXJh1rBxVgt5OSoq5T+OFRchlEJ4UUb838wvUQ9a5Gu7PohP7elcf1FTP1OUHzbqbWYL3jceGYQ8KEB+BCnc87sBCp/21Ey6Ho4UUOPdkPGsfdynwruXoX2PoJ8jTUl9QAxofmGxtcw8/4Us7swJKHApjF3K8G4XL9cD2QxQ7f+r7OUrhmDSVp+bEy4r4YH/+AUUINOOFTBWvlKbcsLKEpc2VAmavHTXBE2asAMGghS1sqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqVBAbpDeFyyBaNy24p400JqQ2p4NepHkzWpAWtpwsQ=;
 b=gdhppcXMb8djnlYPDG4O0e+Uu35o3IAa6HTO6Ykrxxehy0mlpJZr+W0YBpq+6Cz3At/QVr0qeNBNoaYRiE8I42d2+GgaZP/BDw3rNpKYxgeLw88r13ITFnyiKqqLbgpvvOL+LiAC1gi9DlFhb4tvGKRliz8jQYnyHZ6+lv/jO7DhBgqoehxqoh3kk8MhwFuUYC5R3l5t+5F5fO3zxlZkqPpsn1eMBnucqp203/rn5mgSleWiItpbRbtWX9OB3t6lHjjplnuDoJjSdITX0J6UlaiEIJfHVSlxy+zfnUCjwj3TG6ENveE/cAswKPY9iJw1iktwQ1zFrd6d4YU1+bbzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqVBAbpDeFyyBaNy24p400JqQ2p4NepHkzWpAWtpwsQ=;
 b=elVw/bDWwsWaGqjbCA0EOz9dDcM/rjeMhT5NNoNyPYIOTOALHBP/ZFwzpv8ZkLP0oHw7uV3XlbIR8zjrhebPOWRltTuu4kioI5ttSULbeWQLbM9Fs20jZT+Jn3qPwjWMbxRKS3+T1q1zZb6JqCcH8rrIVMuVqY4Qa380xfAnbm9C/ETv1LlRfu4Ok7NaorAW4qg3nEL6LrAn0MqJYSSFi4ca5wvi+u/EtWBKCxZ9j8ctqIIQUL/VxCOAD6GpqEkwfMRHNkdetDsJ2Yx/FqeoczHbHKj/oiYES8mUNRUFAHlCtEFazhcF61zTphiaDEwVc37ywvYZMCFePPZTj48zKA==
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:10:59 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f8) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 11:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:10:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:47 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:42 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/5] selftests: fib_rule_tests: Remove unused functions
Date: Wed, 14 Aug 2024 14:10:01 +0300
Message-ID: <20240814111005.955359-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b08f5b-8592-4cdc-f9c6-08dcbc51c6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	GRvKd2w/UIKhIK5BVdF1oRnQWB2jIVOMITlmubtkYXdueT5X3xgt6eLSWUfgyro/ZFlxTU4vFAH3ty4peVHZOf/yL6vituDMOUUQWBQy7dQky2uCszRWUR9S0Uh3r9yAImS/JT3LQI+e2htpGkIwZ3P0xEBavaM3DupsYNpkIcZjMN7W+KWmoVMS96Cq27uF/KR89jdLl09rGKaeJt6PaPbx5TE5t4Pisu3F1pzy+mo07NcomsYeSCp8/mKSojPO0YeNjoL4dwa5gebqr3Ctwzj1RpeOvfPCMgpcB2BLOPfyAPbozdMCNsKr70Ng5+cBN5ZlmlJvQHfnQ+4yZNDOZPvVEdJIPezNw6zRlRq9cj02izROkVd5TqSaQhx5H32fK1zrb127tlm6KNHQUHrkn40EaDgvKOGMUlsOhjbSZtjylmiUdWrPIt0lvI1j1aYgiDsgilnUPS0zwMO2yn8Ee9zIcTWQLxwGlFtg7K5wdALfLx3Jgm5irH1OomIT1XWtUdGwccUQWMGP2dHvLqyPySaYRRPwJl+swquQ1dzvi7yeO1s6xDZFHn09/CEPBnuWc945TMPqysdjskhLqHi/V8vcJs0aaP6cHbBwyU4pRhmXFB/Z4w/fwt3pcogu/3bSZqO4OF2nPoR4OQBFWStJ1Kfhz1KfrlFdoQXqIiH5ye4oenADVumhwwzNRUR5z1xRcL9uoZ2lzAg3Tua9Rj04Fzqcdr9e+kN5c7VuS3c2TOqf1GaU+HZr6CqTAvGxJEKg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:10:59.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b08f5b-8592-4cdc-f9c6-08dcbc51c6f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

The functions are unused since commit 816cda9ae531 ("selftests: net:
fib_rule_tests: add support to select a test to run"). Remove them.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 7c01f58a20de..c821d91b9ee8 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -56,14 +56,6 @@ log_test()
 	fi
 }
 
-log_section()
-{
-	echo
-	echo "######################################################################"
-	echo "TEST SECTION: $*"
-	echo "######################################################################"
-}
-
 check_nettest()
 {
 	if which nettest > /dev/null 2>&1; then
@@ -453,14 +445,6 @@ fib_rule4_connect_test()
 	$IP -4 rule del dsfield 0x04 table $RTABLE_PEER
 	cleanup_peer
 }
-
-run_fibrule_tests()
-{
-	log_section "IPv4 fib rule"
-	fib_rule4_test
-	log_section "IPv6 fib rule"
-	fib_rule6_test
-}
 ################################################################################
 # usage
 
-- 
2.46.0


