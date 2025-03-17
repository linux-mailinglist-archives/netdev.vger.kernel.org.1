Return-Path: <netdev+bounces-175416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB0A65B1E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340FA3BB2BB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943031B0435;
	Mon, 17 Mar 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsrdP8d6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A01AD403
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233253; cv=fail; b=WrhEtuADM07gG/a8zDtYBHIMivJgs2kWIc6yQhw7rGmR+6fJV1mYjSKiqTNyg/dP4akxU9I5Q6JsNhaz++I/Yv26uQSxP09dZf1k9sHiIiYR1nIKOTGtoyBEnYbHBo2sqFBrbigaoWOSrDA9A9EFlU7y5OdR4ZzFri2jBppMb4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233253; c=relaxed/simple;
	bh=5ZEYOx23O9gpQxAqMCO3qo9m6MFtekgYfFmAVoag80E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP8yiuYc7x0+Lt3EjK/hNxM3VU8oJkpN4Zw+vK40Q2gppig8UyjGJUiaGGBMbI/eKhX1PHeAvXumPXoELVfL5XsdlEXm+zFfUg01soJnscYtuGTj1KYeAn0JJJPhUMIdr9mdK9E/1x/HIwkznGJmKLuFf1XaiW3NnVRl2CXgjTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gsrdP8d6; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2Ab1RIZJa52ghXwLLP1V8GYk0velAF084tyM/viWcsk5fi+ClYjXo/DMH4Vs9E0ojE7DRaqBCMCuZp0mNLvPkdJZRm7M6EtU2Dk+b8dO8dzMBgur5HK0n1RNmT3V84fqj+eAfbkR7PbCk5HvsadErwEu5XliYhzYzzYRvtCSudWijearS4RSyjibK4uPT2+dpQdapnUddPZCAxMj6odHfWLM5Q1GtE5vwDzqU5ATBYdmFD2WXhcJbbqXPs2t8mAdHKgxj5Z1xodYtQqqWRUCP3uMFpvU5ceCuKhdb7qD71LeLfGxiBPGiBlYEFrkDLUN91FbfZBmNMmGctHgRqJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDevXCxqCoryhSRa6kCWQXUHvxm0Wb0ENQVIq88/Ctg=;
 b=lPV/VNctqlzFqvS1ppbaZYbbVt5UAsGyfw6uSqyL2xsJi+hOr1xJ1KPhRLM+pwvZaefDuIS5vvOGXfK1yj4eKINNRa9PJ4FiwzWZGacSofFPPsURtV4rUI1DB4fPVFPXlUcuvsOR5cElfZHDp8jt60RCQSq292uWnNAHESG5aLEPnlpXjWsgdgu4uOEkUD8g1R+lBlVwYk0OKuzKycB0UYNqkUa06HIyJT0pN/1sjVMQzFs148+WpqaVxo9WB2ddhgeCi3frGrpLkEIxQvD12f5YC5LfnJWJfSAts5GQNvNZeCF3ycis11bkUs5EGU+CpygeQUaCh2fVcTdRO7zS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDevXCxqCoryhSRa6kCWQXUHvxm0Wb0ENQVIq88/Ctg=;
 b=gsrdP8d62UjsOS4Bdl0ZjNSDIYWcsSXPGG4EusW7H35Ng+fMLGQ4CODC7f53szJpNBgbEacfieLhbbKFic066PuhyzQxiKpicg+RD0pgvA0LYKueQRaGEynYtFNt+sWnaTxL8pqA3I7SNvbmQLJI637pS3guBYjEmvVAXYPGC0uTn/lg6mq4Fhq2z84czGFfEzdAiJWrxSin23+xRlAtLHrg05axPo5li2PgBF7MWfMnwBhO2+qFZrYiqXIkgQlcJX2f03R6PXz18rWcS8ONaxIbhiLfkhC2xKn4aMny64cJhUgfMmVwNLFNp3WN7fcch2Oaj6ix8pAZSXV3m3NKhw==
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:44 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::78) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:40:25 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:40:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/6] selftests: vxlan_bridge: Test flood with unresolved FDB entry
Date: Mon, 17 Mar 2025 18:37:31 +0100
Message-ID: <7bc96e317531f3bf06319fb2ea447bd8666f29fa.1742224300.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742224300.git.petrm@nvidia.com>
References: <cover.1742224300.git.petrm@nvidia.com>
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
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b863ef2-1983-4e88-50b4-08dd657ad759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKucp1fLQKMKyod0mSot08ZkLghTkLBKWpote208LoHseeQoaUV0RiNeX9lP?=
 =?us-ascii?Q?LJUJcvP+UPJDpbnKpZPYnuKyfwdUOlWc9oSdOjbcawEhIxqx++exXhztFKqp?=
 =?us-ascii?Q?sE1PYAXBYXOmWD9wAY9701odDcDWK8amnKI6lhYU/NYk+I4Y4g9uaskP2Bam?=
 =?us-ascii?Q?FvsgQ5PpxhhYgOA1hTSqSkgEeJMEactW9KQ2s8xjW9sCuYuvLu0KasLkUGVr?=
 =?us-ascii?Q?j2RMy00BM9iLSt1mAMx15vFvTR4f9HgMLm88prU3uhcHcBYBU5SQw/109ekM?=
 =?us-ascii?Q?YKdz2x3GbmqMIDv/topwYNS1zpul49MMMfBrNp1kKCFD0Pd/fJjZZP2KF92h?=
 =?us-ascii?Q?HCHXy1fT6pbXNE0EQDBSZJnL/B3KVEk+KprO/oM0odvcbOP97264FYEjyRIK?=
 =?us-ascii?Q?riceVOs+gqiHfqDQqlW1JTctvyrs5cbniheNQHQ69vV0Rx5ucKX0+CZoTayA?=
 =?us-ascii?Q?sFDMt5+xhkpYCBNbIBtrhNKiBqT9uwuX2gnmd83YeOa1k1ICVWJ+IOZMpIb7?=
 =?us-ascii?Q?GUBG6tMc1txTsYQS4y0B2RsmNof0Hpo4JrDcH9tyweqyWJavWLtFoCuikrtC?=
 =?us-ascii?Q?nWsZOUXqGxVRNlpr0oZ5i+xfssupDBHVFLLxjv8KXCyveYsdZKPB+VNyRcMC?=
 =?us-ascii?Q?WwAhnOQ94W48biN2C2tOr7kiPbUuYtBqLRZ3OBzfgUfevTxvZMPv6mxQL6/Q?=
 =?us-ascii?Q?5YLpZRjdMgkL913za0k9aBQQAQD9J6oBzHx0Cp0exa7UqjuVmNkZMzzojcjz?=
 =?us-ascii?Q?DFXuQT3/edD4u3DXMr/ap3OTra1Q8nVeDc52Edwsn9F+ZKeLubij/jvTA9OO?=
 =?us-ascii?Q?3BzcjLhvdwNskOoNVuhR7r/LiLztGfiRQ5vkkgynwO9sqlry5I6LqfdIwY6P?=
 =?us-ascii?Q?lNXA68HWQjwVPNH5u7gERPGGEZprv0qrPPmKOgXQYnV9BuybFEOMStIXy/ct?=
 =?us-ascii?Q?HsebZZC2QGsroDERoSsMwjRMlsRucV2FEzJq/CvZHWCf0OfT3MAGUhPF5kdc?=
 =?us-ascii?Q?on60D/5/Sdr2RLg4kQaGTSSCKEvvz6rd9yF8LDXluDehS/tOeBBpCuoNDayp?=
 =?us-ascii?Q?lU6mB+9nIkYFd4fIbhWw74NK+ZSJKKLGMwNI/QD4ntwgQGkOIweSTE2OfVHw?=
 =?us-ascii?Q?2hZz7WCU/YFi8AomcHQq8zFs6etfxS2yHNEAft9N/220EedzdkP6jXyH+2+J?=
 =?us-ascii?Q?q/1aq2h+xkwYWqcDAAS8T3509WzO4ntlFVafIEzpLqdXBmu4GBhHdwVvd7NL?=
 =?us-ascii?Q?gY66HTOlQ6GVniHvNS7ITcriQyfzMQlN9YAaou9ZcAlzfyly48t0rId4kq5X?=
 =?us-ascii?Q?N+BfnOGGWL5VGPa37i09CNfowIJNTvjicTKx0YxXVXMRsHMV6qP6M28Zxfq9?=
 =?us-ascii?Q?OWmnpnn+RYMT1K8T9mBpgjt2O/Le7VW/lbGVSOpiXDa1LI8pN2CWZ4ABkwNI?=
 =?us-ascii?Q?CKbb8IV5EhKDY0bYla3GxGlGCq2ev0GZ0TDtDGgHBTGkhp70scUOdPb1+Oqw?=
 =?us-ascii?Q?nI5f2OXVbz9d56M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:42.7817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b863ef2-1983-4e88-50b4-08dd657ad759
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

From: Amit Cohen <amcohen@nvidia.com>

Extend flood test to configure FDB entry with unresolved destination IP,
check that packets are not sent twice.

Without the previous patch which handles such scenario in mlxsw, the
tests fail:

$ TESTS='test_flood' ./vxlan_bridge_1d.sh
Running tests with UDP port 4789
TEST: VXLAN: flood                                                  [ OK ]
TEST: VXLAN: flood, unresolved FDB entry                            [FAIL]
        vx2 ns2: Expected to capture 10 packets, got 20.

$ TESTS='test_flood' ./vxlan_bridge_1q.sh
INFO: Running tests with UDP port 4789
TEST: VXLAN: flood vlan 10                                          [ OK ]
TEST: VXLAN: flood vlan 20                                          [ OK ]
TEST: VXLAN: flood vlan 10, unresolved FDB entry                    [FAIL]
        vx10 ns2: Expected to capture 10 packets, got 20.
TEST: VXLAN: flood vlan 20, unresolved FDB entry                    [FAIL]
        vx20 ns2: Expected to capture 10 packets, got 20.

With the previous patch, the tests pass.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/vxlan_bridge_1d.sh   |  8 ++++++++
 .../selftests/net/forwarding/vxlan_bridge_1q.sh   | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index 180c5eca556f..b43816dd998c 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -428,6 +428,14 @@ __test_flood()
 test_flood()
 {
 	__test_flood de:ad:be:ef:13:37 192.0.2.100 "flood"
+
+	# Add an entry with arbitrary destination IP. Verify that packets are
+	# not duplicated (this can happen if hardware floods the packets, and
+	# then traps them due to misconfiguration, so software data path repeats
+	# flooding and resends packets).
+	bridge fdb append dev vx1 00:00:00:00:00:00 dst 198.51.100.1 self
+	__test_flood de:ad:be:ef:13:37 192.0.2.100 "flood, unresolved FDB entry"
+	bridge fdb del dev vx1 00:00:00:00:00:00 dst 198.51.100.1 self
 }
 
 vxlan_fdb_add_del()
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
index fb9a34cb50c6..afc65647f673 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
@@ -539,6 +539,21 @@ test_flood()
 		10 10 0 10 0
 	__test_flood ca:fe:be:ef:13:37 198.51.100.100 20 "flood vlan 20" \
 		10 0 10 0 10
+
+	# Add entries with arbitrary destination IP. Verify that packets are
+	# not duplicated (this can happen if hardware floods the packets, and
+	# then traps them due to misconfiguration, so software data path repeats
+	# flooding and resends packets).
+	bridge fdb append dev vx10 00:00:00:00:00:00 dst 203.0.113.1 self
+	bridge fdb append dev vx20 00:00:00:00:00:00 dst 203.0.113.2 self
+
+	__test_flood de:ad:be:ef:13:37 192.0.2.100 10 \
+		"flood vlan 10, unresolved FDB entry" 10 10 0 10 0
+	__test_flood ca:fe:be:ef:13:37 198.51.100.100 20 \
+		"flood vlan 20, unresolved FDB entry" 10 0 10 0 10
+
+	bridge fdb del dev vx20 00:00:00:00:00:00 dst 203.0.113.2 self
+	bridge fdb del dev vx10 00:00:00:00:00:00 dst 203.0.113.1 self
 }
 
 vxlan_fdb_add_del()
-- 
2.47.0


