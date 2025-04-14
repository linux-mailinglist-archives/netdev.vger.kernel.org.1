Return-Path: <netdev+bounces-182386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE9A889AC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E315189837B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9928A1D0;
	Mon, 14 Apr 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cYWvK5td"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809E289367
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651300; cv=fail; b=IntYIJ3ulcDz7RAVQiNTg7uiLVU+tfhR9MUZvmPz8tabf25x3iEay5YnmsjxVlMD98Vs/t1Oxnol7N+JRopeY4Myofq1ZNW58uq2sLYJD3jpEI7ZVUNNQaBgPIL0NYTMGN8Kr8Qjw0k7So2Sd5sVxLkCI8yrUIkiddQfHtdKRAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651300; c=relaxed/simple;
	bh=uktNAjarLbL5cWgnlTkGRZOTI7rfR5lIo1OQ2JAbGYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epHNVQlktgoArdzt+RlMKwdrQkz6CkaKEXZ2F++pDAGqPVSxSmDwvJctXV5YgaeNzaXAEFE5NOp8/pK93Rx9XSswT2yex1Er7j/CY6UPlwUtWY2VJE7cJq14fYVk8JyCBX16e7VGwoEwcGslZhopfnk9aWrr5sdMH1yADtmAjlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cYWvK5td; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jji1ZIaaOtytd0bAF1M+y0TUjyedzsARFgNI+n/kxEWp4pH1IelY0Y2ICacCFv6rMmlcoCEU7FoTb9/5GSrF5fmUrF9VMbOBIjdsADZ2+FKT+B2/33JOVQUZsWAN5ltEViyPODSC1tt+Zd7hfTjy20Bfk9j9bXJhrQqW7fRx9Z7JuSxUHxSy2n4rQ2YHuPFq4DQkTRUOIXzmUsgSABsbDVRbXfwzKxC3WB+7FxqolTCKkd9fIv04HbrEYr5EnmdyiLbox2W8cBoh+ARCDpyYCKxFE6hU9rsfPItUlM9cdHus5jFP6U+eZXR9mtHr+r+TMoC1DFELXfmlZY852YlCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M1jbMfMIiHpxNy3pG4ZV07pLQpalGPEPZOcQHzPezQ=;
 b=xBHR00VppThiNSDtRf7qzyGLP77EljMn0J1wpOWoywgAPb+kXjAmTE+NSqqtpe6/Lx09Vl07Jgb5GFSHiyYFhrPT9Ndr3ue0bvUpi+rU8TnqMA0kLOEONErTHBXpD5KDkkifS2FOkZRrJqgsajJpjg51IjQWiXlOWhoqTDr8g0hBsNLemZOMaZzDP7bpvAHjJR8emf1fMREzkJkXjSxCv5SVagYTzxo1UAd3g5PuAn7pLlewbxAMCz+zAaPMLA3CjU6dhmyCyAy4Tbo9adj/XM/tut96ybIv709LZIRFqJihSTH6UOZYdsKlvI86Zp0rsgXwBLSjRtUdfKouMfdv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M1jbMfMIiHpxNy3pG4ZV07pLQpalGPEPZOcQHzPezQ=;
 b=cYWvK5tdntH9RG7damGerJr/3nrdpx0YIxRhkz+r7lNXDKh0zKVuNdkmlAwqhw41eHc73MRTlFHdg1YlNzUxb10zmE/niHbJSDi2XG1PkpC+QC48Xk6QMvNMRIsuX/C/BOn00NYTWPBL8OkyVrUrGEqdtwvc7WEfpUgk0/Wo5/mU5q9sQ+Hv74PEugiACkoUqj8Lm+9XZv/OEHCogs5XLRbIBxv9XgkJgyiBSFF1a0vwvh/tERoJUX8HbcjldirCQrdyVsKbPLwcHqlsnjl/7//cC/FNT3pZPlddwVTFZwEJXRtIuwE3xofIQK2uVybOdPyyypFLnOksmmd1MhjHTg==
Received: from MN2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:208:134::41)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 17:21:31 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::a0) by MN2PR16CA0028.outlook.office365.com
 (2603:10b6:208:134::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 17:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:21:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 10:21:15 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 10:21:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<hanhuihui5@huawei.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: fib_rule_tests: Add VRF match tests
Date: Mon, 14 Apr 2025 20:20:22 +0300
Message-ID: <20250414172022.242991-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414172022.242991-1-idosch@nvidia.com>
References: <20250414172022.242991-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8731d7cf-4a6f-4f61-0b70-08dd7b78cc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwApIn+OFsU+Cdj3MhVaBcGFOSab7LSvUfsEhNL5tgXI1TRwePMWlUOA8MnI?=
 =?us-ascii?Q?GvPxX6WQyfLq9fy7c4m4q9eb2PSab5l+OQcQmAWdVz3bHQNavauPZ5k8SWLa?=
 =?us-ascii?Q?9LrgwHROf9Tz290hBzK7Sbt3aZ/GGdrZpuToHm8qM63VPPByBpu2W6z83F0R?=
 =?us-ascii?Q?yUq0r0A/CS6jQcNF49/VjJks1ttvr8GWtrpsZBJFrEAzVk3QlgTOlUC4IWKG?=
 =?us-ascii?Q?ywrG5A7fJj+HI6jCqj8QYLI1dON1MGEe2ZFtQNk50S9yXjZVTo6a/zYZR/xe?=
 =?us-ascii?Q?b6hTymo1Mr2zIB9kMLB/4kdh+Q4nvtDg7N4y1qUNbNkhnJI7drgJsdxRQQr9?=
 =?us-ascii?Q?hUXkgVzE9dS+x3Vgxv6r2oIfYae5x7qaDR1XzVIBW4S+L49jHpUh+iWR6aRd?=
 =?us-ascii?Q?aB4sHovcbC4CZqQ5xfzwonfQtdb5meZQ5CFHbIjrM/DyuUJD7MDGMaq4/GA5?=
 =?us-ascii?Q?BrgQ29RZ5HFmoJKIYP5uemrCikanaXbBkEUTyKMRMfPXNEW4y7uuWODY3DC+?=
 =?us-ascii?Q?WENBXlNg7d64sIkMHfve4ZTiMaavN7cpQqwKe3hyu0TH+uoimuci1h4a+jVv?=
 =?us-ascii?Q?Ociyjwn9zgc0BcQTCSC2LFsYi8SI88UEJadOKRWRQB5akhDGktqsoz+KzLcn?=
 =?us-ascii?Q?VSnV5+CUOldplBFH2W4dlXsiwnlTGKmbYsI/q//n+ZhfFGtSbmrRIikGut22?=
 =?us-ascii?Q?63WwuuWhTiTS7W8Tf51ZpsjvSGFNSkxn43LrymAwlL9cv18Lw5xbcXuHPeW6?=
 =?us-ascii?Q?4nbM4U5UlVNz2R2rOabMLvw840GfcVJDZdyJgJgzBb6ubgcBpMmo7a0UsjCA?=
 =?us-ascii?Q?Rs8eHZjGxnPXjH1MDvuHDywrVwXf9wR78/PmeXkNMKOsvBbwX9kWd4xAd6Op?=
 =?us-ascii?Q?pOASsareKYiaO7u6L0FqQbbuLysC2DNbcOpac8Ytwxbx8LGGo869lJy2dHJn?=
 =?us-ascii?Q?nhqfJqeS1vt9BA01xCMdI+LVAKyRVqZaQJF/9AQDS81JvgMmYU2rOEATsuAR?=
 =?us-ascii?Q?i1X5Hj8N+AVw91EuTa9IzQUXp3jrOSmCCJxbOMIV3R/UOUVRsDsq9ExtOtVd?=
 =?us-ascii?Q?ohu7i+NgW3FMCH+lPN8IBjMikcXmbvFw2/2v8QSneWxJ5ElaK4wCepRTtune?=
 =?us-ascii?Q?Xwt9Nt43Ij5tUhR8uDLlXCu9S6TQF6zBUhxMkylY4yfSLU5dXyiQnhAfKptS?=
 =?us-ascii?Q?AZ9kOse2KheIT1G5pf9kIWz30ndSVyiQGkgg/9lxStZJqdPSGI5ywcU22UxB?=
 =?us-ascii?Q?sITBtCc2eS9dKpP0vNaszVXOn/W5dHWeGtRdf7o7Zcbypye5lYJ0r+SL1ROE?=
 =?us-ascii?Q?TPO5YGJseVbdqxSFFJRIuMiVhxXtuJuU/i3wpr23pZm4YZsrldwitCesnivt?=
 =?us-ascii?Q?ll9JWVj2JxJHktgFE6ui+uZKhSHadclFu9pS3PntA0HTKDLcXZHeHr9TaRrU?=
 =?us-ascii?Q?K1Yn9348uhUp5ubHtn70c6i5LdOs6hyQsIqYp83SsVVRNVszMhmgYsf/zNZs?=
 =?us-ascii?Q?HJhHvCO4ink8GZ6m5vn24snu/X++PsvlQlcX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:21:31.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8731d7cf-4a6f-4f61-0b70-08dd7b78cc86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

Add tests for FIB rules that match on iif / oif being a VRF device. Test
both good and bad flows.

With previous patch ("net: fib_rules: Fix iif / oif matching on L3
master device"):

 # ./fib_rule_tests.sh
 [...]
 Tests passed: 328
 Tests failed:   0

Without it:

 # ./fib_rule_tests.sh
 [...]
 Tests passed: 324
 Tests failed:   4

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index b866bab1d92a..c7cea556b416 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -359,6 +359,23 @@ fib_rule6_test()
 			"$getnomatch" "iif flowlabel masked redirect to table" \
 			"iif flowlabel masked no redirect to table"
 	fi
+
+	$IP link show dev $DEV | grep -q vrf0
+	if [ $? -eq 0 ]; then
+		match="oif vrf0"
+		getmatch="oif $DEV"
+		getnomatch="oif lo"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "VRF oif redirect to table" \
+			"VRF oif no redirect to table"
+
+		match="from $SRC_IP6 iif vrf0"
+		getmatch="from $SRC_IP6 iif $DEV"
+		getnomatch="from $SRC_IP6 iif lo"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "VRF iif redirect to table" \
+			"VRF iif no redirect to table"
+	fi
 }
 
 fib_rule6_vrf_test()
@@ -635,6 +652,23 @@ fib_rule4_test()
 			"$getnomatch" "iif dscp masked redirect to table" \
 			"iif dscp masked no redirect to table"
 	fi
+
+	$IP link show dev $DEV | grep -q vrf0
+	if [ $? -eq 0 ]; then
+		match="oif vrf0"
+		getmatch="oif $DEV"
+		getnomatch="oif lo"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "VRF oif redirect to table" \
+			"VRF oif no redirect to table"
+
+		match="from $SRC_IP iif vrf0"
+		getmatch="from $SRC_IP iif $DEV"
+		getnomatch="from $SRC_IP iif lo"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "VRF iif redirect to table" \
+			"VRF iif no redirect to table"
+	fi
 }
 
 fib_rule4_vrf_test()
-- 
2.49.0


