Return-Path: <netdev+bounces-167017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DFA3850F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361963B44FA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837AA21CA10;
	Mon, 17 Feb 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMmw+AwV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068D21C18A
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799750; cv=fail; b=scgH1Ng3+FtvSV8YLWTqZK34uoJ62TKtXgzF9S381pIKE8bT8mLFFfjrreAiNC+Yz5OW6fSItR6cx12rYu32bW5bTIqNEYuXoCyH491OK2xrt1koZW9MkLT1Tda7Ymc3x6WguF75DxWtPY4mUEpkTBNHL+Lh2Mbkyzj1H3vPNZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799750; c=relaxed/simple;
	bh=e/q1GwghJsJln8zwlVDKOMh3c/7T5auKElnyE0nImPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eioKmoSOwdlVnnaB/LxwMPCaetZj8IRVURgVYOAZp6+tOqizUy6Ijz6DsiI9PedQFGYV2JQ3RrJ0H72MyYuqXBdmYFJncHlIvAHvmDCQmXUYvdU+02srnurQSE/pvDSu6NTS8OT8I3Mm0leClPvNRElRTRmQRY+zf1uo5kP8r0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMmw+AwV; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rerEM22NMrD2W1FhqKesiYTK05U864LshjcWstIfK0bF3i3BVbOrdVWWAmBC5v+ltlRyUxuhQ2nzbMXRch2uCHNs8OCDHQJzXzMcQSTdj+XXazfir8nodORCyPzm9rTQfSD0wYBLu+WdAhz2Hl1/BSQZrIrPREO6IwnrDqW9YIK6GUbhInHYkGV7hlyt4L1xeYQxvuRr/yVB7YzOuViQks6C1wm5PoT2/PrepbOrIQDjILAwqlPuNRgD1bXVmrPVRbV3dtbkMskHTS1foyhpsrNj+dbm9HKNedwCX+7cmjtV39glBvIz05CTTTLb1cspn3yGeWwiISWMpRCcwHncPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L2UmyFVIAM71C4WevtT7HAPLuAy+S9zqKFT0/i2x3k=;
 b=wGZ1/ZW3BhH6Ln9Sv3nElwOvYFJeUWU105j/jEckmaxkTiZW+3AOPPNMHa5tbgeXRRygCsdufVyVLE+jfwPzpiBk4Q/CUnyMPT5e4KvhzmK4xDEq1AQ57cjyBvKZRbUGOuep0YJUNgxNaKC3dqcsRTy/+XZ6yC3J1h77Gf3Q5wDGdbQuUDNYvVxpees4jYQ0NzFJFhJA4ADi+qNHG3syD8CPl4rK/QbLO8CT0FR+fuzlbDYFl1ScuRKGJKEyA+NzoYAnjozP7284TRhVmy6Rs5bqaEIFGwXXsFRYie06/tPvLiFGdQ3Gi1oHiJ3xr8txEieNRVj1KePrj8rFG3YoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L2UmyFVIAM71C4WevtT7HAPLuAy+S9zqKFT0/i2x3k=;
 b=bMmw+AwVH6P0KDat8pwc8BcARCSI/c1XIf6KLOr0lrtXem9l0KtUDHh2txosBkCtEfUNm25I06n0RGarleRyQLMbWihlzUsYh35TLMTRDkktJqXKpR3B3pWvcOpp9l1XQYTwK8gIDOUrkUkngCCvuJsVLNTfjRLOMWXAcfUyFRaPibYVJs5HeG7YogZPpN+DF11M3TfZjNNDj4nNdMM9Cq55sFV3dZzx3wD7oFBxQIp2hGvYKbaiFpdqikyFgL+FGIumDBTCGOhihfPJ2j8qRB3nymDhx+wGJamfTZlW7n82IDx+bx8f/XM2APW9f7sbxX1e9uvwCIA9wyZdDsykNg==
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 17 Feb
 2025 13:42:24 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::26) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Mon,
 17 Feb 2025 13:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:42:13 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:42:10 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 8/8] selftests: fib_rule_tests: Add port mask match tests
Date: Mon, 17 Feb 2025 15:41:09 +0200
Message-ID: <20250217134109.311176-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: af492f0d-0a32-4f57-c273-08dd4f58e915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkpBUG7RnijGOWHWLTCOreVVOc1YHZ1Tb9ljslLRKAEgVN8CkIY+qO+HUwgk?=
 =?us-ascii?Q?6il3lNgmpC5oXKJHP1X9hxuVKRHvg9LSlgkM8E6MjEXS5NXE+mzD03g3sIeW?=
 =?us-ascii?Q?kTJODPir2w0/vLZ2tT5KlT8PNlfmZ0lyV6C7gu7+e4vLNm3xiPi8AfrGQTNs?=
 =?us-ascii?Q?IYq4nq0Fl7i1J+NH2TC5CBSLJzUZQa/BFO+ktg1SPk5NM3Z34KhGYk7o/gZw?=
 =?us-ascii?Q?AsytWpm44QczsJigF1s/UuBKrKLGn+qCKcSg337OlwoZPcjRayFvrIo3gfwS?=
 =?us-ascii?Q?bnDpKZM+0vEE6bY7d57vtV+jBFxoYlTmO7RftdTa6ekG3SicbMaQ2mkHrEqv?=
 =?us-ascii?Q?ruf/uUQboubOHi6aa4vmlTkaRcTHIynAG3nJ50BPZDsdPdWY9+C65vaVUFlJ?=
 =?us-ascii?Q?bHD7BzKXolr4j/Tryw4DoS7IuvjVRSFvzYMgmN4ptxDBvkLd0g6t4L78uM9P?=
 =?us-ascii?Q?Mk4EuD+Fp3QTlq0yI+NPD27t0cKZ1r3JJ8BCUVq1AJOaujJffj9AFuj5UQE4?=
 =?us-ascii?Q?kZikT2/olUAEO044nqFiuRfnnZYOsqTZ+857IvLSl+gQdp2BaISbykRtxF5h?=
 =?us-ascii?Q?cURRwZDadbNLK8GbdwGDmr96w7VVxhFL+o3egvW3rmnutADsH/SS1eqh8Mpl?=
 =?us-ascii?Q?o27yDF+xTS4J+76sStk13yDyu3uKTFps626rybDqrXoHyFFWakWk15PDTnBZ?=
 =?us-ascii?Q?m52KjmJxo2TQNnll6wTKCm0zvs/hnDLc8/Hj7ln2HCUFYgYzWcf4DJd7qnAl?=
 =?us-ascii?Q?dRMFIdIeFcu4qTgWeUlAiapj/Q9aSwO+ctOO9pmhDcSKzNoHbe5eymhHvYxE?=
 =?us-ascii?Q?pE9wNYwxZFbEkn3m+ELQGWFYR96eNc2mvKnu1V09cZVJOHjL6coq6i72FcHi?=
 =?us-ascii?Q?7DjbBLEa8YLbr6+h11lFjZpckai2zEsGzW9vlyp+MlyBIuK8N3LrJW62YhCb?=
 =?us-ascii?Q?1TddMIn/qml8hai8T9E//TfA8jxIC3OJ/2esFX+28YTNHPVhknT548iLUxyO?=
 =?us-ascii?Q?DBD+SesQuVq6NcFDVGmNCvmRHBFhSmgOeT+rLjierjdZovqcJcYkMnZKGxu6?=
 =?us-ascii?Q?scBKfMsL9o6EXQ2KMPrlU6fZsuOKQ2eT3jKENghDi2Fil4kUVMsu8zv0hcOI?=
 =?us-ascii?Q?v02diXGpru9cKApzSOpScWrKNrSuEEQIUwRlv5Yk5hNk7dW5Y4uwN4w0cEw8?=
 =?us-ascii?Q?MTlidzofUDnC5l+e3gYB4CMaaXL/g+f6GGvqZ9uF1fkxmKqta4qrE1xpBI42?=
 =?us-ascii?Q?iue+JM+RgkyCF9bNjlSewlquJri2Edglt27SwmPijnWQAlBTPFSIskD/xsKu?=
 =?us-ascii?Q?X1DuG9wzwof+0RicNsXPQ5n8o1JjRpUdz4BTAOUDEhpoM+uQkQli8eIDetw4?=
 =?us-ascii?Q?STtBZYjyFSV/+clI2EsDRYuVc72mLh5RRk/6uGbvIGKG6Nns49DqCO+ZCe70?=
 =?us-ascii?Q?J63QSwwBxWj6xiwCe3gIViOFv3On9KVYGNqeCNsAauO9+ArniGdNFgTJn4+E?=
 =?us-ascii?Q?aWDipuF0Un6iEp0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:24.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af492f0d-0a32-4f57-c273-08dd4f58e915
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804

Add tests for FIB rules that match on source and destination ports with
a mask. Test both good and bad flows.

 # ./fib_rule_tests.sh
 IPv6 FIB rule tests
 [...]
    TEST: rule6 check: sport and dport redirect to table                [ OK ]
    TEST: rule6 check: sport and dport no redirect to table             [ OK ]
    TEST: rule6 del by pref: sport and dport redirect to table          [ OK ]
    TEST: rule6 check: sport and dport range redirect to table          [ OK ]
    TEST: rule6 check: sport and dport range no redirect to table       [ OK ]
    TEST: rule6 del by pref: sport and dport range redirect to table    [ OK ]
    TEST: rule6 check: sport and dport masked redirect to table         [ OK ]
    TEST: rule6 check: sport and dport masked no redirect to table      [ OK ]
    TEST: rule6 del by pref: sport and dport masked redirect to table   [ OK ]
 [...]

 Tests passed: 292
 Tests failed:   0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 12a6e219d683..06c51d7ceb4a 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -266,6 +266,16 @@ fib_rule6_test()
 			"sport and dport range no redirect to table"
 	fi
 
+	ip rule help 2>&1 | grep sport | grep -q MASK
+	if [ $? -eq 0 ]; then
+		match="sport 0x0f00/0xff00 dport 0x000f/0x00ff"
+		getmatch="sport 0x0f11 dport 0x220f"
+		getnomatch="sport 0x1f11 dport 0x221f"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "sport and dport masked redirect to table" \
+			"sport and dport masked no redirect to table"
+	fi
+
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto tcp"
@@ -543,6 +553,16 @@ fib_rule4_test()
 			"sport and dport range no redirect to table"
 	fi
 
+	ip rule help 2>&1 | grep sport | grep -q MASK
+	if [ $? -eq 0 ]; then
+		match="sport 0x0f00/0xff00 dport 0x000f/0x00ff"
+		getmatch="sport 0x0f11 dport 0x220f"
+		getnomatch="sport 0x1f11 dport 0x221f"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "sport and dport masked redirect to table" \
+			"sport and dport masked no redirect to table"
+	fi
+
 	fib_check_iproute_support "ipproto" "ipproto"
 	if [ $? -eq 0 ]; then
 		match="ipproto tcp"
-- 
2.48.1


