Return-Path: <netdev+bounces-218659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C7B3DC7C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF36B189D268
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A32FB626;
	Mon,  1 Sep 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ak10N0Iw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8B2FABF5;
	Mon,  1 Sep 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715591; cv=fail; b=hPzZDHLz7TJQXTBlvnpTf4r1QWia2ssp9qMKpzYr7WF0Ec+mWyYLt3frqIcJb+WtzB+p5DzKyKwcM29227t+Dqgfpx2v1VmXfc9sB9Gh/miag8r3MWZLaiTi64Vb46Wodq70Sl59sHBMx+5okm51tBXyOrHGgJzJQevUOcBxmdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715591; c=relaxed/simple;
	bh=IjEPFizYnxDysctoap9yHn5R1ikSdSip8de6mWfUeuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R05QBkME4zgPlrGHO0XnSB5agi7ryicsIfWrVvC96ZrzaN5Ya7Ww7HKkvi2jbeBc6cWTlAimbjcT+db+eJ2ka5LeEewfs7b1gvRHtrdG0aCQYB5/1R1qPI+j20tbILIqzgOCTm6UvVBOvt5Y6BlwKxATpXP4gMh46h8abIazMP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ak10N0Iw; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5Qe2TuSOeQUXpf2kpyzc4D0ojwU9Ea/zdb3jhnwzHrBphALb4jWKxOAehxtVW1KdN5NLrZ+vjWRVIXsT7wcH6lM9Lu5I1VJc/MlMh68bhtqQhdRa9BmgxPvEHzORvRh1RG+xh4KOHXrQXuvITRNZHHPXW5up+pnmZsnIV9/D9rysfepJpt5AH1yI5xU4RxkQWO9nPM9QDv1qKPBA3FHjJiTpol8BhfCK3uUM76PXnqCrM8DqfuD0vXBYC8ZnN/76mBpXpBF/rVRVrFlhx7AptO35tISuGeI1SstFwrgIz0tpxRnNduTOXYulGex+W/H7z8q2sUzNigtrm6uw4yyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbWErs/1V3cO5z7KTSKyLnud19YYN/Y2FnFm7fTgFLY=;
 b=qaVzRnkrj2VJDLd79DXqJVE9xWtzS4nSZtrCSJDaxm8RxqqC4mEsSmdHGLmKVAsIPvQ548cX71j6OKI8W7dMO82RvrBBKOCwVyRtyK4Jh+jW9chMXnpG7lMQR0Pcdr96g/zjS10G0Jeyh2E+7/uZbB27S6MxobNwI1KpuWgY2vbbUUyKv9R1aH6RptvhZO3pC1iUpjOJQUjwryNyuvS2ikAJc52BeAPd2Bhc1mQJYRGYU8zU9+LPUsWAj3AXRR5EX6E2frRD0piGopIIRqxGNYSVV+ywLw78WSCEwP6lH2yezcow4a8RjoYeL3xE94L5u+FPIlVabjwpzbGVppRAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbWErs/1V3cO5z7KTSKyLnud19YYN/Y2FnFm7fTgFLY=;
 b=Ak10N0IwJE8SKVZBX6q2hdS8BzJIt1hrkfizJ/ch5UL4br/Pu3TFks7ToYHzOA1JLqc6evXzog9MLERO2S86k5sVXv8zaJiCrz07VRAlbDmOTD9No35JpcXNPj/VCbyaA0zSyPLR9i60clZatVnNcbgiGWN44HS35HsUX+TcBplb6/RRo/xIwXQqb2c9HvCoia5sXFcQhCoiMeAN3eIcnz2hyPMNg/8WLP/6BD216JubJKHFBnovzwPU+uzUoTAYliiQx8qHA4gI2J76YqRItobWJME4s4V1HiiKMxghb77HleUzIPvow1T7OQlkJcWQu9V800IZGGJkUi8mHxjkwg==
Received: from PH7P221CA0071.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::24)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 08:33:02 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::6) by PH7P221CA0071.outlook.office365.com
 (2603:10b6:510:328::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:33:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:45 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:42 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/8] selftests: traceroute: Reword comment
Date: Mon, 1 Sep 2025 11:30:25 +0300
Message-ID: <20250901083027.183468-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: d27dc76d-8a13-4a5e-7039-08dde9322a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UZuItEs5ETpBuNlQlIH2HGhbA+szjOpEf5p1xfENflIJWtIpPQ4I+Yc3BLdv?=
 =?us-ascii?Q?ulPU8WA8XHtsfXw9D3xolb3dGpZYF2Ad6CmJQQ2n6vbu2hbiHt0mAsWIJlLz?=
 =?us-ascii?Q?O3G8+Gw4r+wCoyjdJjtFSrqfyJhHVbhQhtHl6NXU16CC1Vpbmilx2lqmmBxr?=
 =?us-ascii?Q?q2zMeGGmrbUqhj18V5LbkCC7fIre+q+Vpnqfy6W6MY0XP7vhHdG5WhUYeVSk?=
 =?us-ascii?Q?pAItmTvsbaVP7QFI7yRx6vtDKwHIhDqcpqEIXrcsucdd6nbuE0LqHH3u68DQ?=
 =?us-ascii?Q?Dye/h78pMTZQ9qtl4XJ7n9yRVVldLODWsHMvtmciBwlKC9AyRBiyFAtt1XY/?=
 =?us-ascii?Q?36kgL2CyuzBpERFi0ZoC23EIsVCfI0Q45+OboLCMdgdbPzrzQKsuS68DNCLW?=
 =?us-ascii?Q?AVu5nlFf1vHqaJcX0WJriMcfvFQysfKboHgBHWkKTGV4C7gnGXq2yKtF8v6r?=
 =?us-ascii?Q?LxaFvVIjuJbK5xCNXucsAGtIYCshKAM49boJQBJj/IHdRV35VwcFKLWXFoh4?=
 =?us-ascii?Q?cMnZUFwmVWQ6Xu8nV47GNwfD/MQUlsvm+KD2yQgO3eewnCT+Fl1tohNZt4Bh?=
 =?us-ascii?Q?hLhavmN6dWPDFd7o4hxV6f9pl4wjn7YQyT/qvupPjNVZo9NW90WQoWi5BttW?=
 =?us-ascii?Q?8GhpBfHDP43QNLkRN1CuJtEauSawCDUykFsZuY/bsuDHJX7rxKAsQdCJ95Ff?=
 =?us-ascii?Q?GUclwN4Ok1FTIg6+CF8FuL8lr2v6jd3UmpnMuuJ8ftz9/wMqBp2nasiJwUuj?=
 =?us-ascii?Q?uf8lBQ6ee3HIaHDUObHT62m6SdBWNt5+o+8eHeKu83mLQ1UQbYSMfK40WFBc?=
 =?us-ascii?Q?51Ba38JTP8il8ToUTyR5GMlAwx2mfLJh2X3TsslyP4EOwWjLP4+vHrzFSg29?=
 =?us-ascii?Q?pIdoQdG/aQ8NZjtpaiked0CPoErLxU7eVaJELAZnNbT13Qyctm+2Ss5diWyR?=
 =?us-ascii?Q?qJHb5EJ6aJOSTTDHKXyEhDf5509o/4Bj6o+XpmoKkFKX6N+nfW0kpOVSPqNA?=
 =?us-ascii?Q?JOztGNdRcKMqB79ugMbGxxaWK8ypELImXzuchTgvq1r4KmyY448P/rkuM2Zo?=
 =?us-ascii?Q?qYqPkNdZD08Obt1bIQ92L1WkIcv3tMLxFAQPd0mL5wN2it6FAqYEMAxsQjrO?=
 =?us-ascii?Q?MYqZccuwc7gUqY1Yoj1QCJBdmDZvt+cXRGl3CCtO8rFx4hiLaizUkAnAaCiW?=
 =?us-ascii?Q?roYMpaF0zpiaNvLYRDt+txINbnd0nV1tVJshbWmLC9QwB4eagStmOlk/3Zzo?=
 =?us-ascii?Q?1JdNREc2AnbTmCCXlmj/+Ii9kI5WuJTOSiLz1KwSYD1MygwXx8S5oOU+O6YP?=
 =?us-ascii?Q?8+6qrNnVUss4Dcuv6ztzVItCJJuADO/DolE3SOhJnpua2tkog69pYYX3qp3Q?=
 =?us-ascii?Q?LDyWYtA2L1oD2xdurAJ2xOlv2yYH5U/Il+V7RRYgqCRcydwW4DJZbMghVZ+A?=
 =?us-ascii?Q?LtFDkY+5tLiWgQPBTlcvmRqhdHhv3gZuQL31n6gGNbqmzfeMeI8p1KBjxU5b?=
 =?us-ascii?Q?5yxRoW+mjciOAMTyAIyfbkS4nullkmy64O8u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:33:02.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27dc76d-8a13-4a5e-7039-08dde9322a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

Both of the addresses are configured as primary addresses, but the
kernel is expected to choose 10.0.1.1/24 as the source IP of the ICMP
error message since it is on the same subnet as the destination IP of
the message (10.0.1.3/24). Reword the comment to reflect that.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 1ac91eebd16f..8dc4e5d03e43 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -203,10 +203,10 @@ run_traceroute6()
 # |H1|--------------------------|R1|--------------------------|H2|
 # ----            N1            ----            N2            ----
 #
-# where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and
-# 1.0.3.1/24 and 1.0.1.1/24 are respectively R1's primary and secondary
-# address on N1.
-#
+# where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and 1.0.3.1/24 and
+# 1.0.1.1/24 are R1's primary addresses on N1. The kernel is expected to prefer
+# a source address that is on the same subnet as the destination IP of the ICMP
+# error message.
 
 cleanup_traceroute()
 {
-- 
2.51.0


