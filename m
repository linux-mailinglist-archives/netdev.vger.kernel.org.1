Return-Path: <netdev+bounces-245641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56DCD4192
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3652E300BB86
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751D2FE566;
	Sun, 21 Dec 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O3VnhsfD"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE692F83A2
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766328600; cv=fail; b=qVB+McoBvrqsOwNCoK+SYg22LbyzYpvwxaHdGwduAK1O1uofLln8e+YB+4xRJt1YsTvuvbauXEVtgsDQbPgBSGpK8DCREkXPOL9H5qvpgbAwV0kdhb6X1igClm4joKKgLbtcjxyn1dUH1bPm9T3wJdRns5fWIetkEdLvZpwT7K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766328600; c=relaxed/simple;
	bh=MpNgzYfFw8NLHdf8Jr9y5t8HPbKnTpHroy2/QbagzTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4UeYuURCpStDZBnjFBvl8P4WGeigACm8d77yDmdRtGN8+n3VxSgiK7L33mr863E/RJ7egY701WtdAwbCUAGeGGUtciNOhr8qKYfdID6O/40+9uRKMCiDPJ1t1X8BBSQpIUfz01oAZ0FIcDy2f2xlmXR1lM2et5lKDZVh28WQbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O3VnhsfD; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK96ZAnVIbfHPKi7FlVu+FjQUe6kGButPK/O9lFN8aJ9LAUCba1y9VCojbd0eZlY6MRPqSm6g7hVZtiXawViSt45fE25UAGqoNp8j4Ep9xrLUYdvXuP2Kc/VsBH3eXoZY9RqnZbtc+LHQ0zLoK9CKxdIcPien5Xl6qQnGJ2WDjMS18kGkFdckKM9tzqlePyW9kxcBam/vyODRvf8ZO2g6I7t1u+vWnL5c7H5JBDDyiF4sTEX1Do/TPmFt9V3tOTofIKOk8S4aA6jNyADloCxVfTxsYgrkLK5VDodkEmosmTSSLmvQyyTemJpdGaehgLOKTiUocbNApqgWl3xXcjLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Tforal58TfSpkbLWcFQruxyDEx5Pz3mXzWoj2OX/E=;
 b=XdBHgORfS/HVsldk+q+idIWl2MoIvYgj7UGjn0DVaoxvNPPl77xTymOYmK5OA61tmvIS9PGuxg1SUrR/c60D5BSHV0ptY/8yk8fOLRZZhf8sb64HiuzTlCzzeQmdt77i7Y/DLg5ftfOW2nPqF4U+x3LgU5pKXm2MWkFvxB2z2r3fKw9M+PR0EohP9/bo8a52xpBAxehTWpneRBbBhxTXpzpLJe549dUkUYEvdWNfBXDTnYmVdlix1SgiusnZxKqOO9LCMA04DHcHrE0CPz5CJRbAaJ4sqo+tDC7fIwKswVp2/PEe1ysD8zftKngJS9uXkriX4MhGjvLcXiNKyZu/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Tforal58TfSpkbLWcFQruxyDEx5Pz3mXzWoj2OX/E=;
 b=O3VnhsfDr0NdocEVBSMkXRHL+h8BytBbcoKzTseddXnd6n6zrNoukEfb+FTQHE4CkZy54aN1jDEUd28EVTbGW1Wu+vBgcDnfLFYrSdsEzCvrWKeE2o9YBk5Btf3HO+1x93MA9ycy/eNysuoAMi6ptnqNK2Ty6vMofKcjJ7R5W53xq6MkV1Kit3xeg87TGR0I+Vee9tXTgBOVH2aj35ozKVBg7X55TEZC8ZprUZjOfh+AvuBfcET2baUQRl0CK/I6cEuKVQ2tVT2zXBAKOG4wBBj1wd2ev0D/RvCOWoEKgdthbfffm717jI6OBMZutwuo5vEDGADDqD/Wx7oJ3DsQLg==
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Sun, 21 Dec
 2025 14:49:55 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::d3) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Sun,
 21 Dec 2025 14:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sun, 21 Dec 2025 14:49:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Dec
 2025 06:49:41 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Dec
 2025 06:49:37 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<penguin-kernel@I-love.SAKURA.ne.jp>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: fib_nexthops: Add test cases for error routes deletion
Date: Sun, 21 Dec 2025 16:48:29 +0200
Message-ID: <20251221144829.197694-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251221144829.197694-1-idosch@nvidia.com>
References: <20251221144829.197694-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e0cc67-7020-41c4-b57d-08de40a033fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KiVgmbXdBMY05OMYC9foDK6/dipvU8PQOk6/Hj5x3nkLnybm6Mftn7MQuGi?=
 =?us-ascii?Q?UuwOCIb/F9rRixo2h7irYVBOlsaaNLnGBJLIqliQxY+1AzQswe/IQrDsJuIN?=
 =?us-ascii?Q?F4td4Qzzh9wWaNcmwHGSQFWaAnMvDMr8PmavcqbUOazJJVXdJCvAT/i6m3Pd?=
 =?us-ascii?Q?DgiCVKNVvZZcPYToyefVbxueZHDskxfoXMKYJdac3m8jrdmvJ8VM4aHbNEab?=
 =?us-ascii?Q?FCoCqztoEcG6f+hSBc1CEgH/qE/ICPph6QpHcpR0qnAYTnZTq9w4/1ZWWMO8?=
 =?us-ascii?Q?7jvJDuNfJpNsDphbtJZhQx6HN4jQfT/EmUdhIUqdsXb+ndySebdoU1iFv2sV?=
 =?us-ascii?Q?+03F0lNW1RMR1Qq2yL24+2E9R35LIOfZRnO0twiR5kMtrwNQhryFdLJRb1aE?=
 =?us-ascii?Q?wel2dfIWo2+QI+n0Y4Zh9zgP4n9Ddof9P48RyVbRF9AfHA6QOUzr+Ky8K523?=
 =?us-ascii?Q?IdyEmIASR+SaDwrVVP/0a0x1XklzSEJiB8huvZkHStsIlhovo27Yp1wbBQvR?=
 =?us-ascii?Q?GEi7yeWl5l7oAs/hIo1F6u6PSyzRpNYANKHgUTRGB5W4lNCyNAgdKqErrkSz?=
 =?us-ascii?Q?3uBf+KEL2vfJnPHuOvr8chFizbEz60JZcKlTNTcnjckUcEVjCFG2HBDtWrPD?=
 =?us-ascii?Q?1Dpz/z6qrlu4Dd+xQk7E0L9aCvQVvXvqHn2MaY9bvfO6S5fbCVKBc10IvTPU?=
 =?us-ascii?Q?8HF8HvMbSYI+xdGwupHjfNB74DLHAFL6eKj+AB42moSi64pnX+Kbch7EwGqX?=
 =?us-ascii?Q?vbWfhIifao/p4c4Vn0t3fVFH2WWSmM2AZQT2LDnNrz4obTq4aHTy5BpYDQxj?=
 =?us-ascii?Q?5oaq55889vQYook+K8mye9ETtmNMTnGJ3o739L5CStrPR+SrLjT1PrgcrU8O?=
 =?us-ascii?Q?duBxmYor2l0Mw07grM3CKRgAqHAtJoQVIVSIdyaUD6nhY5XCwRqUnK0JtbxS?=
 =?us-ascii?Q?fS+TW3VvRJEi0flIb/yhnDynepK5XBW7O2SKySd1hHwLgeMhIzF7FyL2Xg3j?=
 =?us-ascii?Q?cYO5hYOCPz9b7ZRcL75WGslDKjtKLPfx9cegV64kdKE/TKby0Xx8k5yMUXB8?=
 =?us-ascii?Q?0DJE2xUAZeg0EMdTz/aqhjh5jBcmW8rug/6kI0fhw2c/UB/YPB544XpBj1+k?=
 =?us-ascii?Q?Xiv2jIaoZx5OJN+Y7SNqiB0Ql/pf25SrqYfY5gE5zQuJvpZY5uTJ+ajNSY+k?=
 =?us-ascii?Q?edx2bWtSHFoz/c0jDmYR4Vbr3afKjcTLo0d46M2ISR+Fu+cFkILzyRT4tP+y?=
 =?us-ascii?Q?BhfXUh800eHmo2S3VvGLl94TFdLrePkX1gSRr0Vzyp75KT+ClNE2eaeKfeyh?=
 =?us-ascii?Q?c04niYoEKp5F430KKl5S5PGM47imiqwPnRCFIYyN+PgX1BlpEwHTHxaQ6Ces?=
 =?us-ascii?Q?qyuoW46lTDH82XFo5iutNJ/Htw7xof4S+F3o6SdEqSRuSZ1p+XlBJ8xb6T7V?=
 =?us-ascii?Q?ZL/EUq0h2hsaQicKQjkFk6M/ZfWXjFnk4mdBTQm1nNJX83HSoeud8+cjy0Bc?=
 =?us-ascii?Q?RvvjYten6x8faByv3r5XupSGJiTVH14Kwx3AD19PVIv1khtHGfr2g2aW5q33?=
 =?us-ascii?Q?j/DzkZz47QLUwDLcE+A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2025 14:49:54.3203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e0cc67-7020-41c4-b57d-08de40a033fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

Add test cases that check that error routes (e.g., blackhole) are
deleted when their nexthop is deleted.

Output without "ipv4: Fix reference count leak when using error routes
with nexthop objects":

 # ./fib_nexthops.sh -t "ipv4_fcnal ipv6_fcnal"

 IPv4 functional
 ----------------------
 [...]
       WARNING: Unexpected route entry
 TEST: Error route removed on nexthop deletion                       [FAIL]

 IPv6
 ----------------------
 [...]
 TEST: Error route removed on nexthop deletion                       [ OK ]

 Tests passed:  20
 Tests failed:   1
 Tests skipped:  0

Output with "ipv4: Fix reference count leak when using error routes
with nexthop objects":

 # ./fib_nexthops.sh -t "ipv4_fcnal ipv6_fcnal"

 IPv4 functional
 ----------------------
 [...]
 TEST: Error route removed on nexthop deletion                       [ OK ]

 IPv6
 ----------------------
 [...]
 TEST: Error route removed on nexthop deletion                       [ OK ]

 Tests passed:  21
 Tests failed:   0
 Tests skipped:  0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 2b0a90581e2f..21026b667667 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -800,6 +800,14 @@ ipv6_fcnal()
 	set +e
 	check_nexthop "dev veth1" ""
 	log_test $? 0 "Nexthops removed on admin down"
+
+	# error routes should be deleted when their nexthop is deleted
+	run_cmd "$IP li set dev veth1 up"
+	run_cmd "$IP -6 nexthop add id 58 dev veth1"
+	run_cmd "$IP ro add blackhole 2001:db8:101::1/128 nhid 58"
+	run_cmd "$IP nexthop del id 58"
+	check_route6 "2001:db8:101::1" ""
+	log_test $? 0 "Error route removed on nexthop deletion"
 }
 
 ipv6_grp_refs()
@@ -1459,6 +1467,13 @@ ipv4_fcnal()
 
 	run_cmd "$IP ro del 172.16.102.0/24"
 	log_test $? 0 "Delete route when not specifying nexthop attributes"
+
+	# error routes should be deleted when their nexthop is deleted
+	run_cmd "$IP nexthop add id 23 dev veth1"
+	run_cmd "$IP ro add blackhole 172.16.102.100/32 nhid 23"
+	run_cmd "$IP nexthop del id 23"
+	check_route "172.16.102.100" ""
+	log_test $? 0 "Error route removed on nexthop deletion"
 }
 
 ipv4_grp_fcnal()
-- 
2.52.0


