Return-Path: <netdev+bounces-220720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B50B48569
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94461899998
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871B2E610F;
	Mon,  8 Sep 2025 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vx019zqI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCD2E8B8F;
	Mon,  8 Sep 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316921; cv=fail; b=hn8rSEwm0yHYhcC+CgXnmBNAvoQNYLH0p6CRJEcJL95B5PJ524ipMH96eZ1+SGSlZyIWlwSNWFwB0AA7WVE+2TNMyey6iRr3qKeVBoiRNXvV9hMwZOr7KzVEIvGACGKGPYirQt1T7H+A9WzM0T5U3EAxyg/DTNhihc+sKfQNFCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316921; c=relaxed/simple;
	bh=aGYE32IWJtABLwOCzG3bgiZrUarxACtPDeV/SzjIv+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmiCiq6tDyVa/6X0CJmsRSoMBbOLpv6m9g8fdvVayWgZB4gwup+AXdzwrKcbrllklB8I2vm9Cv57Y09OHsJhYkxvFafDWDoNuIrxvMzY3F8pTcwyA+dlAWxzx2NuNyPA4uZuWV18aKexknsNO3ihV++SHSAIC3DzLF06vgTIjRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vx019zqI; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FifP0ynntbf5FuReoIjOtV/HfDkidxWN+ajLIHW4DPTuuCVyFZIfeEvsQ2wXyQyBs+HqCRmZU7NrBSWwFvcG0WPp1NkK4pvuRhv2ZLOloD+mubWzsqphyXs7mHrHGr1qhluT99kseRB1BW/khZB3helr6p6FSZha5fovtm5ryZiDZ9cBA5GxzOD1m/xV3hTMZyKk8cyVhZHIwaXPfndfrU2NSgDQ2SfSaUJEQ/afs8RdI7kiNDldZCb8iSGq5qrrkcPMW24m//8fxDHhJ1zkJM6WQXGNMH0XsV9idqfgkfkFbowryw1LJTsQrqr0jIRAM/kvHoY4iNFaGgYodkJaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srw3/vIPThLqQUZ/dneMgD2AxxBJFiMHl1lWud75bOs=;
 b=KtTugq+ZUzmt9GBvXHIufc7/IX6yYUN0LbKL/4kBOkewvaP8m/vttJA4+x4JHjv/BsGBZS79TPYRe+/ylwZ0JfEv1VB4DTQXcmZQd8NaHpjPtosSibm2PHgcrcKd411yOYkGPhPjzHFVpXEIh7ETqlDu2zCzsRpntpLBZNFJzx99LkvXPbP7x8cbQiwm+OJAXb3SWBFQlOt1jTqKzqPkE9wjWzC21e+CEAsuBEvkAf0dgRFVMdobVKyfyLyfhRzCo50IetSqY6Uh2yh5BXJXCJ/dSdRO3z73CgDQI1PkF/ncH4CYNFec9cMyWB9i1Exw73MD2kEe5d/65v5zn0KXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srw3/vIPThLqQUZ/dneMgD2AxxBJFiMHl1lWud75bOs=;
 b=Vx019zqI8A9jTscwaVeAgE5rXdI9VR2Q7K0XWn0HhXVMARfF9ZgTx3WTcpW/CyXGoM7hiJiXOE5PenEoaprhUqn1wIEv3hBMfcADHhiWz4mvSREW2PcVmVjyw5WvXqk9lejg3mRrkX1XB42KcdeUJ8Sw9j277FwraiM5P2rpR4O0uq4uhpfwHvBWWHkd6rPbovpSpwrsUNg+5uS0q7mmry7jUJMBZXCvSqk06B3GdFdof72ZHZ5I9sDqb5UKxJVsLoOxdNYU6PFNJ71HekNrfB65A8IEVBy96kJV80zIIRGAfnpR8DwK7qR//b2IWo1Y01YLIj4y6+1ic6jOGdZrZQ==
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:11 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::88) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.11 via Frontend Transport; Mon,
 8 Sep 2025 07:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:48 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:40 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 5/8] selftests: traceroute: Use require_command()
Date: Mon, 8 Sep 2025 10:32:35 +0300
Message-ID: <20250908073238.119240-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d073bbc2-ca3a-4fd8-2893-08ddeeaa3e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqeEj2uyl9H7Xnqs4JynkHjFOic0R/NwyV8Uqsebn4mmLTGXc19Ws3vXsspV?=
 =?us-ascii?Q?GlUPyetYZd0Iouzb72Fy3vRh63m8M1wUCW3CnIHubWpmwV1yxrkvEAJhXlaR?=
 =?us-ascii?Q?1gTyP2WyKJVVP6i4nqjA2Ui3Z/F449/KPn5VuWiNZvmlh1I0foP+AocBdCDF?=
 =?us-ascii?Q?rYkkmkN/IcWNhlWp3HmP4eqoy7yjW/wqA++8+lJ29rGHs9Xw6R88hMhRqoXN?=
 =?us-ascii?Q?ObkqPEKQRnmPahI6DMo5eC9QuxPRqrus9pDLCbDbSlgtUIseQE+U7JxENO76?=
 =?us-ascii?Q?XCKFmOIcSbN0RWtyIjKjeplb4+hMsUBF/5RWls2IWNfP+izs0j8QgXIS/GyL?=
 =?us-ascii?Q?lU0OabVMI+VIVWsf/EgKcfNdrHV9Dxa84BibWEf+j2OinkeT0IIZrbmH/nhA?=
 =?us-ascii?Q?92GneWnQItLWNlLYMgXhpdw9iO/0j//Ez8yES75aqlUHoNyDE+k+RyiZf67f?=
 =?us-ascii?Q?SsD8zGhUmmfmpdrZfqTOOJA7pMS6rv2niK0s1eU8DsrB01V8vAoYtaeJ5z0a?=
 =?us-ascii?Q?3mPKUVtmw+Pna3cYUwfA+wIC4W/8ueZ6RBHcnmW73+fGIG3BQCD+tjvFgw7h?=
 =?us-ascii?Q?R/363XWP16z42BmXfr6aM24n1LI5J+i9g5CMHgyaz1qhhJ6QdFzlMq0fchr8?=
 =?us-ascii?Q?CI4TzFFMF7CGFJ8gWB2akaZtO7b5JIl3HT0N02ZSv38h9e3Ti2vGPJW2QfVY?=
 =?us-ascii?Q?zjxzq4tW0NaY0x9VYkMroonJpEJDDAOCP9jHV6VVLRvUzBfl9KBXYU1cuxTM?=
 =?us-ascii?Q?Ok6dh7vBELOu7IdHKb1odoX06dinpra5I5HGCNn+JxCzKR4ZzZqmQIy45zgl?=
 =?us-ascii?Q?aGXdGTyFptt6M8vm1AEHzBtJskB0/5IYSkf4XZvwXRgOL4kSy0ygUCSD/u1c?=
 =?us-ascii?Q?vRyH2DqDiRZVv2RtZCLT/iOuKT3ky499V8uuTweo46EYKP1SywpgXORClu2b?=
 =?us-ascii?Q?WrO9LH82VDCXt6rV1bq/rR4s49lckXDdIpSbVuWwI+GJIPf43k+xD64+nj9q?=
 =?us-ascii?Q?O+NStCBfyOOL1WGiprS9vm0v3ovyLyG8RafQUabz6dEn2bi5rcgYEEPCRBMg?=
 =?us-ascii?Q?7ZpmLTvOrm/igmpLbxbeaL0QwIRx770yAVn2HQdjYuvtFgZnUFyq8q6oX7PQ?=
 =?us-ascii?Q?iP9E9KsvDcL3v6Oxx9drie0X7dI4JR/ENcODHI4SNfxf132ePbaZ59olIW31?=
 =?us-ascii?Q?X3789BTZLQyKf5uH0RpDfVEkZsxoOho5Rb8aUrjA3pDo0hQhXGT532UfuVie?=
 =?us-ascii?Q?7+D2NZPg04toQfYzkb158tCkc+HcfVjSOuTFxeNVdjlYiTZ+eYUAtqGpm5QF?=
 =?us-ascii?Q?0zq/8z90lQNciCP1PbkI97g0W0fD02gwE4vwdLuvLAfjhY8zP3n2Vsb2lCCj?=
 =?us-ascii?Q?7HQ271D53R3rnjnEIXRZoyFsUh9MoQy6JX09FD+GvgfbSaVxlu0BV1xw6+YT?=
 =?us-ascii?Q?rOywxX4vHTwNIbKvlu8RtPJZ8kECD5jl63BqVUrVDYO7nu93ud1HhVWosSwy?=
 =?us-ascii?Q?nfLZw9vrn/U2HJi57MP8nXpUq9aHINktrRuC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:10.6506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d073bbc2-ca3a-4fd8-2893-08ddeeaa3e10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

Use require_command() so that the test will return SKIP (4) when a
required command is not present.

Before:

 # ./traceroute.sh
 SKIP: Could not run IPV6 test without traceroute6
 SKIP: Could not run IPV4 test without traceroute
 $ echo $?
 0

After:

 # ./traceroute.sh
 TEST: traceroute6 not installed                                    [SKIP]
 $ echo $?
 4

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 46cb37e124ce..1ac91eebd16f 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -181,11 +181,6 @@ setup_traceroute6()
 
 run_traceroute6()
 {
-	if [ ! -x "$(command -v traceroute6)" ]; then
-		echo "SKIP: Could not run IPV6 test without traceroute6"
-		return
-	fi
-
 	setup_traceroute6
 
 	RET=0
@@ -249,11 +244,6 @@ setup_traceroute()
 
 run_traceroute()
 {
-	if [ ! -x "$(command -v traceroute)" ]; then
-		echo "SKIP: Could not run IPV4 test without traceroute"
-		return
-	fi
-
 	setup_traceroute
 
 	RET=0
@@ -287,6 +277,9 @@ do
 	esac
 done
 
+require_command traceroute6
+require_command traceroute
+
 run_tests
 
 exit "${EXIT_STATUS}"
-- 
2.51.0


