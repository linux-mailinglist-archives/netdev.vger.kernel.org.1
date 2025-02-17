Return-Path: <netdev+bounces-167016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF5A3850D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EC3A1612
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527B21D001;
	Mon, 17 Feb 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l1BM5VaD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209A21C18A
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799745; cv=fail; b=i2rc00OpVfqUivRhC4FZr8qO/adnOeqCD1L4AQjewAAAaTDB/IfZhUaAvvkfNfQN744mykDR8Ce3Bd+Fq8NiOJz1O398YZy9Sbo+CeJ/KVMX9xLeg2qIBomcEMaZ6H0a/lTz8OqmfcB+ztzI0VNKyf9nJkvBCTvtZEHh+AfQ0cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799745; c=relaxed/simple;
	bh=DilJQkOSLa+gPIu4yP+RcJ+eZemrkVcm2KwiezFIStI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDcguw9/ylY0nY3YiRdS0B940eqektLFQ0K1bhFMTG3IXCUF03nMXKgccOKR5V7PvT1H0Mo+SxUFPvr93WzU7WT2VxEYftFkhfmelbQy3w9EmrE9r7T9NgOYcRJRO8b+jTn23mMzSqV8YhhRUlsfBwTd3VZPqLy7CJbwkX7yIAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l1BM5VaD; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peMKW8WDO+AobKTH/z8VXFLshsmIyrfEnyJQaR6YgbQ1g8TTFVdlCMhGtKS9oLPnmWOjDCNWETOIXvknTe8zSBxQZia2EkvFp065jHak8m0hHItNBwca7R/zGoWQCnBM6tcJ5GMHsLHH5V1u4CqPEUra6bFusBOUWfYtT+31OHcd+kMPxvTnWMxYkBGxBXwlbCF3vt5ZhTiRNlwGY+GcHYvRaUHkFg6yYcb+M2HKRgSnM0r6A/UeVVNu3lUdXQf6wJ9sgMVgnYaOW3O3CqH9zHHv2YPE521VAN1DTYy8dLXzOaVCE8jbRR96O3LQB4PZ8CShLDBUtBiCq+/hp4sIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4FwNpd6UBFnjPgFbpsnuaBuFvpi1vEt9OYlG+x4sdA=;
 b=FO4eq5DJ30pa+7spXavkIWcw6/7WVZ0IXRu1dBLgbP/KTya+RVmG8e8QdgWHWXzjg0X8E+2yIJAeooIwA/fVzxp9QYz3K+ubxgOt82DwOILMZLtwWhPGOB2kHoUDHv27/B2Kz994VO08cwNPtMo4eirYTzN6dKyH3cIkcUoF1hlrdqKepvOHWXEVYdFFiS82aCHKdEBjuNHF6ha+bmPAQMeWvTrGWYXNRBQAXTDvirHeaMGzNCuFGieNRP8tyjCGJvGaRQV0B7Aq+gSEWgii8BL28a82ivFnLwhms3eoxmtD/Nzh1au9UJQfvjmq87MQYfJVM4p5ksjyasBNB09/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4FwNpd6UBFnjPgFbpsnuaBuFvpi1vEt9OYlG+x4sdA=;
 b=l1BM5VaDefuNe2keXG5dBrWa8qiXsEuyZ0/HbmaSnsA2NmNHanHfrEfX9XknGbq7AY6KbZ7ArBWaTqW45SJ58G5q3jnzeEOxSGxN46ib9AWztjlK0ZfSBWTfLEgMV5LdlICtqT1/+G7IweXZrtwh5f8Us+etknx4VIdnXfdSX2LI2WnrbyDllN4dFmuOB9pVhrVgM9tmblk3EiCz9WrV5IuUjAu0NUYCA9D57wsZUmUe5Ty3hnSQqW/2JzjfMB6hCPpkdB9c3JyD6NolQMbnAiGkaoaaXBOC0NWcPry8wsdaX0M3lz99JJpyJe+ZMCkLQ8leUjrMPhHP3xOq7xsmhA==
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 13:42:20 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::8b) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 13:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:42:10 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:42:07 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 7/8] selftests: fib_rule_tests: Add port range match tests
Date: Mon, 17 Feb 2025 15:41:08 +0200
Message-ID: <20250217134109.311176-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: dec82b4f-4e0a-4542-029d-08dd4f58e6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4NiTHZgzIYnfdz1PlvwyKSiSv7dyKa8thvFLNjyoyhX0RtCXpLBEQbgBdwg?=
 =?us-ascii?Q?zsv4LQYYG8gVOYgqVk1NQUH66kTNSOQ1kYV0yr3AATyYvwWiGKmr9Ove1EF4?=
 =?us-ascii?Q?g9hrTS0UQGSlHDCRwttySrD5df4iuMfYIWYojc9fdvx1OI79zHL7nZuIKVwy?=
 =?us-ascii?Q?o6cC/IB0MMevNQoRsmjFkOGMTqTPVTb9f59Q3USeYGRdrUOqaZcDTKjKFP59?=
 =?us-ascii?Q?+Lne88+Ozx3c4rXZgSJCtBFLQKds2r7R92bB73YPAWUvyxPKLiXfNIOyzKHv?=
 =?us-ascii?Q?FLt4J8/ka34QTZvSUmr69BUYhEwLnfAtosRpOygUMwv9YaO26UmQYNlxT8vZ?=
 =?us-ascii?Q?6HBnzBKYm1NBCYyCbLS5NJ8V4azms3A1NPfpYUGE3nYPyxuU/m5h1DH/UAsu?=
 =?us-ascii?Q?M+ZP8R8GlSdCj0r5UadBhAhyMYHBsWpFYavpStG97B/PDq+1YAlEo0AcNOfE?=
 =?us-ascii?Q?io1KcHDnUt/7w/kxktxaLg2DJK+ZWe9zLCXhUUGL3yw+roiIO7Zuu8GbJidR?=
 =?us-ascii?Q?DR1Gzn50EftSwKdltaDrRV8ezErl5T6wHqhAqiJ8trYH4eHeqlKqdRoXkUI4?=
 =?us-ascii?Q?wAu0eHroizr36H2PEyat6JmpbKihHPyYoJAk5p2qkjKgy224gbhEPQDlaQjc?=
 =?us-ascii?Q?95kjNX8VXDFikLe/SYq+9HXZt/rIYXs0+iMTJYkR4tiV/HDBN2SICdXgEaTK?=
 =?us-ascii?Q?4IPH9DOCz1ySIWIpVAbLXitOUH3jSBlTYZFQQ6h9O2EazP3vpppJM8aUCl/w?=
 =?us-ascii?Q?p8l5vAodOnvS8irV06zAUBdoRlIK4U49JFqtS2GVVwKwr66cBjiRZA6bwiDe?=
 =?us-ascii?Q?Tn6BR6IXzf1ddkUVfs/o/2Ke6oK4Z6NYc3+azn/Fw4bbL/Gpf4e8MpQPpuX8?=
 =?us-ascii?Q?WbKNQpXp8E60L9sWymmJM+3L2xPmoZ0HXuLvBV/YSkUBpKp+nBJmOYDrOhzh?=
 =?us-ascii?Q?9cWNwzpR1+IdIWAkdm4YRZ35bCD3AYxNj+V9gEcZi3GzORoSFbBwmkJsMQUk?=
 =?us-ascii?Q?3Iwt9gH72zihLcn//bGfL/7ZDBKcUvZvnzr3xtolRjwM68MAiDKYoR+D2VmJ?=
 =?us-ascii?Q?2q7RokAESLGmhFgwNZaApurQS3hqrUcM850Qz2MVN7eUZFkPyG7OEdNKHsIM?=
 =?us-ascii?Q?83jSuYpw2P9kWGHqf1m0FUT8Sfqfdc+AKjdrIiHOuyHl9mo7RvPR56reSX5C?=
 =?us-ascii?Q?klXDHN7DfMXtxW1d64fjkwx8HfOZ2oCcGmQJ6i1tWCTxPdDpgWQsBu5YgsIQ?=
 =?us-ascii?Q?4x3Cmoi6zfk5clVDZFtIdbsQRYKJCLxjy2GxrZqnK9Xlq8ITyd6t1XrbXk6V?=
 =?us-ascii?Q?0KF6/Bsyj1y158YRhqboopzSs+JajscBaHb2QCYRz/0G2BPQNWlZcbruLIO7?=
 =?us-ascii?Q?+nlQX3RfIJmJmOagGs+O0OjkHIlJ+hdW/XnEHup00LKzjBiY2+z9ZFjoWHg5?=
 =?us-ascii?Q?Hp153o4LaI3xuTLmsZ8hzISOpYFeMxFDjXo8aME2XOkGucKbRMS0VvM/dS6o?=
 =?us-ascii?Q?DOt540FnmZDoXY0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:20.2837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec82b4f-4e0a-4542-029d-08dd4f58e6c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

Currently, only matching on specific ports is tested. Add port range
testing to make sure this use case does not regress.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 847936363a12..12a6e219d683 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -256,6 +256,14 @@ fib_rule6_test()
 		fib_rule6_test_match_n_redirect "$match" "$match" \
 			"$getnomatch" "sport and dport redirect to table" \
 			"sport and dport no redirect to table"
+
+		match="sport 100-200 dport 300-400"
+		getmatch="sport 100 dport 400"
+		getnomatch="sport 100 dport 401"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" \
+			"sport and dport range redirect to table" \
+			"sport and dport range no redirect to table"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
@@ -525,6 +533,14 @@ fib_rule4_test()
 		fib_rule4_test_match_n_redirect "$match" "$match" \
 			"$getnomatch" "sport and dport redirect to table" \
 			"sport and dport no redirect to table"
+
+		match="sport 100-200 dport 300-400"
+		getmatch="sport 100 dport 400"
+		getnomatch="sport 100 dport 401"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" \
+			"sport and dport range redirect to table" \
+			"sport and dport range no redirect to table"
 	fi
 
 	fib_check_iproute_support "ipproto" "ipproto"
-- 
2.48.1


