Return-Path: <netdev+bounces-207865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E69B08D8A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769921897D1D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045E2D46AD;
	Thu, 17 Jul 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5JLkSel"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622802D3219
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756766; cv=fail; b=WS2GUOqeqJXu6wynT0vCHunClmTtLg17JlzDFXo3cEZdw91kYJi73rfbLDf+P3pBiAHofaAb20HZGe2E7umqr6Swznx7u30fFPP9ZSFQL2d+ijk7r5DwjS2oksBh59+a1kXuPRgzED+7+3z+rbx2ceKzAOhquXbNb/BCoUMk0OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756766; c=relaxed/simple;
	bh=0fTSX02g7xsiREYTRCKxAGLvgQBe3QLo5m62zEfrCGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oX0ksxb+jl5QlwV0y1eApkdW0XCXl4iqjn4VZ2Vk6zCTinox0MZm4nO3MN05gKsiH4XN4uXSzlOdPiqba8ksPmIs7T7NHKVqxIaYCG/4o1CxWHE97M+3/BSzfgwiKjzM1zjYVLJNzamsnyZ/cZvw49VxsiZGSmCSGhZjKY5YXgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V5JLkSel; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1mXa5zdnAVk0wEoTOJQsdUEqUr5ggDHUvrLuKDZmB2lMHmPOP5KOeKP8Wj1Knjh7HL7egaFzJCgLRyoMIkWOzvBnTPlneLoTh1B8yfqqlxy1KSBvmTcSt6G9wLoxDj+nVZ4blyAA3X2Mf14CwWgB1DF8i0N3FyvsXuPEehBCGnAALptO03x3Kk2o2n/wcHXSXRQEI2/WJv4lKctzVwMc1jukzn38WMv9kM6R4FSTIKbXcnBkuy73jsijxw426EcbUrGtCt68VIDhIJZ6ADlb5ljFbodH0pUo0QJT+b+PTFwkW5FGyUwvYTvIyHyyoBbramuM/Ak6NkRLMY7yfbv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ewuO9hhNPGowSP5eMLwsMvgIjxSpAaftInxGJpREqM=;
 b=PLlz45qHPce2rML5MACoQEaGRSiqo/hja4BKL0qgXKEbhh4Hw1cx8t+NiE/pG6KjiFm30UJoJZIJny6HPqFKya/qM/9dKXMCQ8zUTGs6XciV2omf7RFvUmcOVayJEIUqSJ99KaeUwMxi8pi+NBKt19663pziCXZANi+qmqJvnXedNxE2GqAvIRRdOJ9Y5geFGkVX3XcDRszK+6CSx72p6629Je4ZEk1HUDM/nUejNTGpVEVz5Y2soMRwa0H+YQEbFIDXxhUtakvMpqu28X3g/jF6VNuAxOoPp1r0BH43+b3cr8B3e1BjEDbT8AZsqJBRovKhuQmIpEsW92svtxIkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ewuO9hhNPGowSP5eMLwsMvgIjxSpAaftInxGJpREqM=;
 b=V5JLkSelNXf7mQuvDjmIftgrpZ/WLdn+9SecA8vsiRHeN4BeofynHqmAtzcsCFxG+SXlgItotR7UhxAJb1QZV3C3e5R5tYx46sjPYKtaQJbYg5jcjtlqu0XEI6NdZIzlUC+xQY2diGpHUe3cIj1UzdtmIXu6Gp0H0CCAOvXQoe9hgYEAwVqu2hAY43ZyLgwENmN6k/DE7fVqn0jkBNbVhsO5zmW8OZlnPGa/WkyFCbkfyuoZWdeOQ/Q6r+EpKxJNUg4Isk4jAy8apOyMb0qYXwDe5vcRQ8cQO4KNXrLEIg6G4LWVoXL8u9GLr2KHobmH7irf2/LPkw6dBvfRsi6FjA==
Received: from DS7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::24) by
 CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:52:39 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::7a) by DS7P220CA0051.outlook.office365.com
 (2603:10b6:8:224::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 12:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 12:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 05:52:24 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 05:52:21 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] selftests: rtnetlink: Add operational state test
Date: Thu, 17 Jul 2025 15:51:51 +0300
Message-ID: <20250717125151.466882-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6c5d68-b630-479b-358f-08ddc530cfee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nqxYIqOg/T3YTmgjfvBZOJ/OMpPhsd700iIL4plo0t2KW9KiEVF2dxOJ7/o1?=
 =?us-ascii?Q?IOPSWF8VYvUDaxWixSEoUBjs6g47HfDdzNucH9QsmdD9rRN12hZijkauCyew?=
 =?us-ascii?Q?hp5qfoD6zfZZcilreV6/XXQb8fiVyfFGlmiwavI72+/+N7GzyKhNuVmT6HpL?=
 =?us-ascii?Q?yK7nT6vgwlhd5pueXNM8mxc6s4PigOuz5xvREtmQaDkn3+XJmPzgN6Gte3Eq?=
 =?us-ascii?Q?4QoNlPUgUs+s85N5i9n28ZzvmpF0ZLYKLESxy3LsZyTWMSui9zER7dZwlccE?=
 =?us-ascii?Q?GGAM/KcVV/ZR2LOfpFBps7d1tj6tjMbTjkZbn/boZwYJJ+Buz21ygkL5bVVe?=
 =?us-ascii?Q?goxZe6I0/7Xx8FHBcvL1yJK0mUyosLX3xrQj4sbH5t2nquIQCwPUd8VnWvan?=
 =?us-ascii?Q?xv9i81T0Azh9fToPyY/akp/x/0C5e7n4VIumK06qZiNKBLzy1iNEqnyk0chk?=
 =?us-ascii?Q?gfd3dbxrKokc7eUIMhNQ3pekDiF44XbURSvvx0pdzs6EcnerQAO9qlOZPD4T?=
 =?us-ascii?Q?L20Esgf5/e6ipLNGlSen3R57r0GUt5oHxOvucqQI/6zp867DQ1abSq0/Hihz?=
 =?us-ascii?Q?gy4MQan1mn0elhllfBXOfmqxTZA2QhipY+hthFkHN6aNxyWeKTpkH+8iyPk0?=
 =?us-ascii?Q?UzhkVn/jKBCw1qyXUO857Qp3XaxK6TVLsQ2hfRu3AivTWsNVy+NkUbgC2aug?=
 =?us-ascii?Q?IQa4+TRTNJ5Z0Eflxc4ggyT5EkmBQv+vEWQ/edcv+l1f89QGkB64J+46/eFv?=
 =?us-ascii?Q?AG19WwK79SckXD6z+ibaOvuFPug0d1hpWaKr7SMaSGda0MCPZLM852PGUBOm?=
 =?us-ascii?Q?dthaF0hOZ24zUQ3PSAiQw0ALv0ce+4nQq6la0Fwrt7k0qmYXUwuDFilDykM8?=
 =?us-ascii?Q?8VBZOJol5eemmO9v8keoh2LkawMs5EcZPrW7hEl2MKWBagVf7/sl8vyhlzKR?=
 =?us-ascii?Q?aOFseG/rFuugcXPYUWA7sJxgZi/Yl7CmofXfGzwsptU+blzPXrj2p6WsHmJd?=
 =?us-ascii?Q?jvOlwvzeSm3k05cJEIQZYM8irgApzBs8EPzkeFmhNSdNUnrWmc58/G7iaURU?=
 =?us-ascii?Q?0wfivnyG35F86YczmjZwUVURcgzgC9IninZlSHZMxJacdqdTnN1fBOcTFZC4?=
 =?us-ascii?Q?sQ1O19ClbLc6QtImYXVsjFKbjqDd6xOPtHUXl6X/ZN9gyA9KYjEqrJslzTrz?=
 =?us-ascii?Q?YsPvgjcKh2mxfKiIzt5itkBmMdTHRPs3oW27V6XURoZ1eVvu5yYsSIhsYILT?=
 =?us-ascii?Q?6+/8TfPfyYy7a2ecPZmDoK7K/1ZBQIu49Q3MdHw5qMvqTp5JALL95OVa1g4R?=
 =?us-ascii?Q?etfnUARi5ge+tG6Cq7zQvac3T//2s7KUMbzGbBxZKavDDKSjkpg3T4RMl5Eq?=
 =?us-ascii?Q?LaduXG8QfTv9TkR01DBY6c9AQ+oGBrR36AoFxkAAGIojCl0IWUTZqOeSuMFb?=
 =?us-ascii?Q?48U9fAbfviI7BR/dnwYmqKEd2bG2S3qK1b759P+nZQG7KuTpwt94rmyUDsVw?=
 =?us-ascii?Q?mXpp0E6xtUa4dox29LsFgy8ZObuttQjbgjQyZN3lgKKEVWCT9nc2yLHQRA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:52:39.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6c5d68-b630-479b-358f-08ddc530cfee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

Virtual devices (e.g., VXLAN) that do not have a notion of a carrier are
created with an "UNKNOWN" operational state which some users find
confusing [1].

It is possible to set the operational state from user space either
during device creation or afterwards and some applications will start
doing that in order to avoid the above problem.

Add a test for this functionality to ensure it does not regress.

[1] https://lore.kernel.org/netdev/20241119153703.71f97b76@hermes.local/

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 49141254065c..441b17947230 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -30,6 +30,7 @@ ALL_TESTS="
 	kci_test_address_proto
 	kci_test_enslave_bonding
 	kci_test_mngtmpaddr
+	kci_test_operstate
 "
 
 devdummy="test-dummy0"
@@ -1344,6 +1345,39 @@ kci_test_mngtmpaddr()
 	return $ret
 }
 
+kci_test_operstate()
+{
+	local ret=0
+
+	# Check that it is possible to set operational state during device
+	# creation and that it is preserved when the administrative state of
+	# the device is toggled.
+	run_cmd ip link add name vx0 up state up type vxlan id 10010 dstport 4789
+	run_cmd_grep "state UP" ip link show dev vx0
+	run_cmd ip link set dev vx0 down
+	run_cmd_grep "state DOWN" ip link show dev vx0
+	run_cmd ip link set dev vx0 up
+	run_cmd_grep "state UP" ip link show dev vx0
+
+	run_cmd ip link del dev vx0
+
+	# Check that it is possible to set the operational state of the device
+	# after creation.
+	run_cmd ip link add name vx0 up type vxlan id 10010 dstport 4789
+	run_cmd_grep "state UNKNOWN" ip link show dev vx0
+	run_cmd ip link set dev vx0 state up
+	run_cmd_grep "state UP" ip link show dev vx0
+
+	run_cmd ip link del dev vx0
+
+	if [ "$ret" -ne 0 ]; then
+		end_test "FAIL: operstate"
+		return 1
+	fi
+
+	end_test "PASS: operstate"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.50.0


