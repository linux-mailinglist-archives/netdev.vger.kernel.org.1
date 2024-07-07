Return-Path: <netdev+bounces-109665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928392975A
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0305F1F214E8
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B03125DB;
	Sun,  7 Jul 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uIkDw9Tl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179A2914
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720346183; cv=fail; b=l24lr4RnR24s4x6Sq5Byw/F8ZNc/nXwN6sW55FvS504GhLf6ib3jM4FjsrUpUUSXwQctXaecMqX0Q5J07ppp3ILZfrcYK+uWrT77G1HNpyJNgyZhbhYYSwPoPkah7ogFMylhMWygBodHjxdyyzgcyIzQREkRvoGBtiWdWjwymNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720346183; c=relaxed/simple;
	bh=3/8qfCqcaRXa8KK5W60USfAFRSMH6sVqdn+IVacJgmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pa+bORfoZbk9D3hZLto4al4HSDn0J47H0URcgo+6CrqI6cEFYIzJ6AbhP2WJF2IDrEwm4aaB4yrvHzQcILh/xfiLwpJokx8aOftw6uayxI6lV/B1edhMOhosMn3Bo4baBXPEkZFHzgckgLUpB51AKCorjTu1re+4/tPLVgR/jGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uIkDw9Tl; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA61W3q3u0/XRsnASy1xBV5Gg6TBSj9tlIB4URWA8lNW1VXKyESqpv767EgPKj3ePYbyAb5hIP+eEjlM/hxyikn5Y+cwxsFC9wBgxx6Rr3RVjFxgwgFSoxWoL+7s8BlyICwQFUSmfFxJJsosXkreL0nuEHpdRdgucZFFRiPVhTMVv8wuhsJZuq0fs+LmDj4uZNz39Vm8/NY/LvB2PpD0kUB9bQxNfbPGKl7jcna+mUkpyl0OqBjRJcpw5v/hP0zESIgEYQESrV3fQRoReQqk4P1T68iinAQcDze8paMwkwANK//Tfllk7XoJFIp0xe2joDwrGKQsK4ViTkFRjBv+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4x9fEP4uK3jHNG/+/9cSRhjtmz4warPBGAElAmlzWU=;
 b=KywnOX6SNQ88dICLQjq+mg/4iHgcD1KRS21BmNZmEPfRFgOYBo9bPyy2GlwWpz9pe9/6CIX8rZ7CGvmLJD54JRAICkgeAKeY1Ou6796cHOBO7rie+iVtGokSaXl+te2lISWFh1LKhSn5DYg5hsZUNq5hroiZhlX96hED+GOcfMS+1FrHouGCSPjwgvj5Hreyy5Gm/G/HW8ctqb5KjAL8b548S74xRcTcFqH8wwYiVNBanTv8vU1X2kgDOyek21O6vYPFZZyNSaAupk9ITebl/7bkAuAVueHO85q2N5u6lbe8OP3pnidW9eUaQ2VOSiihucyQpudTDH2nCxDETD3eKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4x9fEP4uK3jHNG/+/9cSRhjtmz4warPBGAElAmlzWU=;
 b=uIkDw9TlCsZUdRKfVP8m6mr3oB4Fr7bkq0CzykCXfpuI6MqnSc9+rpEAz5ghHx6TlIMB7L6EOs7fOEoQ6IbRi6Som3AxCxtYSXmP1ZgJ/JpK8ZTwubSRu1okxJoHaaxiMV0t3PMaD7kZGXaB3ueuM019QiH8+R4Jq3fThsXicAQ4tmLzyOeU6o2Lv6HdKqVeCgVjXj9xO3rjbpjKWeUe3JGNYw/PK9wA1dzCcXf1uWWu7LaNPUdCpd8EjJazt1E6VYSMJLygnWgPcGloFB2aJ2QeRBov6wo2bdH9X8z+GjJzm9IBitEC4jp41ItKzHDY3Vplam3d8tanEkRKd+8uUA==
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 09:56:19 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::7b) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34 via Frontend
 Transport; Sun, 7 Jul 2024 09:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Sun, 7 Jul 2024 09:56:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Jul 2024
 02:56:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Jul 2024 02:56:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: Make vxlan-bridge-1d pass on debug kernels
Date: Sun, 7 Jul 2024 12:54:58 +0300
Message-ID: <20240707095458.2870260-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba2ab2-44fa-4f63-ffdf-08dc9e6b0c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ccFw3IQCSNZracwbk06KyvREhhyRzWh4PxuI9v7GuTJp8VKV5OVIz+KAnLG?=
 =?us-ascii?Q?Wmt0BdAwoqlzaVDjojDilWegIxV3esx0T8s5QJBjhFoDAEGM60mhzeCFq4GP?=
 =?us-ascii?Q?NW2Lh6ZwSummnYtn618IBuMcYI6UHCrlTVPgN3O2Lnbr/5GjWQ7VBDmEe5hs?=
 =?us-ascii?Q?DcwKNuSZ9gDlGkq5Z9xdiTcn+U6YvEHR8qmcf6RL5ma6UT6TNggWy1sLZOML?=
 =?us-ascii?Q?Se+8jxfzbvdQ8C977wEHk2ZX6S3b+lJvBhZjbsvyue7eqEwv0cMnT6j6hFzR?=
 =?us-ascii?Q?Q/cVSJQoYa1ClUZhHMoqERqaM6XeREiU+SAtK6Lv+nqNqGQXfUY0ylz5tb5Z?=
 =?us-ascii?Q?ITVZexH8GMELaa7mFtu/Wq9dnnmXr6ictVSXLcCYPaeRK9J9R579xMKZDBpy?=
 =?us-ascii?Q?iy/+rBIecVPtrHFNHMcidvq2VlRE59oNS6TdTM43Hj969O0oKzygLOTqUgMb?=
 =?us-ascii?Q?NYRpLNYjbO4zpLBVuw7HDE23iPKqUAYD/Bl4ulo0L4PSuL04z816U5YQZM0h?=
 =?us-ascii?Q?RMcGGVVP60DcmdjqgzDxBvLzuPJrAbE3TpeBRhahegXgXKkZkWIJLO9/3QRJ?=
 =?us-ascii?Q?o+IXsME0amgVzY9ignTZVgExKTeYQm6NSZ1jtsQaJKPaHhA4VZmr00Rr81v3?=
 =?us-ascii?Q?DtNoW/jxAruksQVfz+HpNz1gzOH0/n/vG2eX0YMHRlbdBODQPDmE3k9udX3j?=
 =?us-ascii?Q?+aQkMonc7weHbjMwKE+GXJqtCWbBRWPJUyxt5HrZY8u5oMBoycc1intkXD6I?=
 =?us-ascii?Q?QmCcssAgZ18i/7pXyVLGsQS7SN9Ig1AFnehxgyLSIR1QXzOXmrnxHiMSLMAb?=
 =?us-ascii?Q?WhDwJcvoG36MlpRtjwkRU6WXVhe3zREpxZJIcC3yzGR+39M+LDjUfDijYCV4?=
 =?us-ascii?Q?VkalK8t9vsWpdeQB95rXpsjm5cRhcB/hvVfO0ZGohOMJCw9STL7WUncb6gmp?=
 =?us-ascii?Q?H2I5JR872AiubTfg8UFLjDYCAE8RZ613oSaWvbSiKSF12WOFk//DRzBinMgf?=
 =?us-ascii?Q?OaGu3AQpPVdtzsMAWciIy76eD3tYMtl8lzXu47gmze+PruYnSoLU6u8cPyUM?=
 =?us-ascii?Q?/Xfa9n5CNLraOVY/BVdPnhmCn0twSxML0YCNkTFlFFm0QdVFF3FJj+bHAqw0?=
 =?us-ascii?Q?3CP0k8uqPuUG/QUA+ToZyZ3kv7a3Bwf+LtSE4vjhicS2haWRZkpPioG2EQ3V?=
 =?us-ascii?Q?6AsBOGirnL2vv/V8sW0vsEsJyNZyl95F+PQ9y2DQbsJkL54SRprhGoTjbhKz?=
 =?us-ascii?Q?deo942ql8Sxb6Ud8AYJFFfGLQcCJqU/ASPsVRpBeDfT6pWSzXj0x5vjXL+rP?=
 =?us-ascii?Q?lmIINFZWJMjYq0PDiqP35fRhg6ye6oDUiD4xYlaDws5Q95g4YNwKh/3UVffl?=
 =?us-ascii?Q?fExbT3fCW9OvOQhp7yE+GotfD4Z+h9hs73oqqm2Epb8LneIY3vH1PYLtmFn8?=
 =?us-ascii?Q?Rr1NxBC6Y5++N++7NF9nYtKXO8LFyTjA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 09:56:18.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba2ab2-44fa-4f63-ffdf-08dc9e6b0c7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

The ageing time used by the test is too short for debug kernels and
results in entries being aged out prematurely [1].

Fix by increasing the ageing time.

The same change was done for the VLAN-aware version of the test in
commit dfbab74044be ("selftests: forwarding: Make vxlan-bridge-1q pass
on debug kernels").

[1]
 # ./vxlan_bridge_1d.sh
 [...]
 # TEST: VXLAN: flood before learning                                  [ OK ]
 # TEST: VXLAN: show learned FDB entry                                 [ OK ]
 # TEST: VXLAN: learned FDB entry                                      [FAIL]
 # veth3: Expected to capture 0 packets, got 4.
 # RTNETLINK answers: No such file or directory
 # TEST: VXLAN: deletion of learned FDB entry                          [ OK ]
 # TEST: VXLAN: Ageing of learned FDB entry                            [FAIL]
 # veth3: Expected to capture 0 packets, got 2.
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index 6f0a2e452ba1..3f9d50f1ef9e 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -680,9 +680,9 @@ test_learning()
 	local mac=de:ad:be:ef:13:37
 	local dst=192.0.2.100
 
-	# Enable learning on the VxLAN device and set ageing time to 10 seconds
-	ip link set dev br1 type bridge ageing_time 1000
-	ip link set dev vx1 type vxlan ageing 10
+	# Enable learning on the VxLAN device and set ageing time to 30 seconds
+	ip link set dev br1 type bridge ageing_time 3000
+	ip link set dev vx1 type vxlan ageing 30
 	ip link set dev vx1 type vxlan learning
 	reapply_config
 
@@ -740,7 +740,7 @@ test_learning()
 
 	vxlan_flood_test $mac $dst 0 10 0
 
-	sleep 20
+	sleep 60
 
 	bridge fdb show brport vx1 | grep $mac | grep -q self
 	check_fail $?
-- 
2.45.1


