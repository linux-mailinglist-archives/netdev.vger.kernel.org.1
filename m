Return-Path: <netdev+bounces-212801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61059B22059
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91A2A06AB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC02E0B47;
	Tue, 12 Aug 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEvg39YD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868152E093F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986000; cv=fail; b=DBTCtcUr5OVe7C7GSF/AN+A4kxZItjmt/vjzUvErazPS7w45AuQoWdioFub/InQHuBU7v02thXHcfYzeIHBc3GhHnJIRvBJ7GEtz/Yt0EsCYU7oDa42fDIO0tFFikqjaATAr4EBeLEnz+zIQ2+9lbOjeSAjSjBPAYMjYyDHmbUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986000; c=relaxed/simple;
	bh=cVJr5HZa6yE0WebrzapOJBEBd1/4alA9c9ZF2xrcfUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m06XPgvv8uPkzXJ7s19JbmMZBuG3WpDoN+qNWNbEnROStEn3a33sjyP0e1BU7JJSQTU2n6GjekXXmKYflx5REzEjSsvMAHyp6ZER9FllC+eCBVW6wnxABxKD/LUSLPVqVvYVd6iblgEaIi+euQ0M8OX11rvRrbERbmUpavquhWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEvg39YD; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFW4KN6jmCuTyY5I9YdkBlxLY7CmcoG/JH58ZLvijtmLZbxmPdK5I0g9RY2+ThlKoniMxKFZe3qry+chkYo7kkVFRhfam/HFmlpRmvsegGu0BzBvJMOIZEEYpvTBITBdE6z3H0V2e4HItgDGJUjVOUQAiQCz+yPk+HDxM+fxldSKebHnIgP/Dx4IQYLBEdqQHJxPnXGmmHDd5SsnP2RhAUjob1Ssf+HBO3tnoA8z2miZ8fSitw15NI32y2NSXrxN61f2euhYUNcWUnc9OB/MDfoYeBOtXbgSDcZ0WPU1tPz1tFf8Pt3WtdkaIX6tIPgTlR2MtJf3ys6QUGxGotj1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWSVHr+zb6Yx3rFauYpqyKRjc7y9RTuYYGwLP8eAe0o=;
 b=QG4MnZVZExNXO6svea6yTy7lLp2Pm2nrAkA0Hhc5SsW3pUJFSMCsmeAqbFIDPFrapKHzEXTOiRyWgIrcXYkLHd1kVyo0+Ptau6XOI+zkoxkbfsG4/2LjGKe1lXxaDFvhKKiq8u/up4EGzga/zBaLTfEQqwzy6z9t1cCyXzmR0/N8HVPe0w8DmKtqvvKIIDQyWNKdswTsX/nFl6CjSFfyq6VLJOvXSv7gxkjJDRPV+76/H15NdkyB2v/PhotJppdrU3lGHaq6xVL+5HK07Rw5zsmeXqMJ5l8TZdyr6GqJTYnnNbMS3zSLs3ZcnJ66B0rfexvUuQ1mY5zzUcpoWanwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWSVHr+zb6Yx3rFauYpqyKRjc7y9RTuYYGwLP8eAe0o=;
 b=AEvg39YD32H2V3S0eYumrrwOyWgaZcbiSyDI6cpMpUXxbFc+nEMnDsR8MlgZXxJGuBpo3DuDokpKtLzDXnWgyMwfw4PuOguh0EqqW6rqqx5sUiGIeDkC+pliI2dzhxxYuK9RKiGbHy5FXpdCsASMfmXuYzzw3i+7t3IgIxq9DvNs8lkBgTLrTIlpez5VKUgUxDoGRYcMDjdd7AVXWydRg8HxFOq2IEMOLBbsh0Nc2XbhU77z94SaS8evteo6jlepu4fdD5lmRtomqEaE6hcz3ei8Uuq1gs9joeyVODUoNoDvpo/qT0P27nw3/oUT6fZqZcJoue4bF4jeQob1E81jpA==
Received: from SA9PR13CA0060.namprd13.prod.outlook.com (2603:10b6:806:22::35)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 08:06:33 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::d5) by SA9PR13CA0060.outlook.office365.com
 (2603:10b6:806:22::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 08:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 08:06:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:16 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <petrm@nvidia.com>,
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: net: Test bridge backup port when port is administratively down
Date: Tue, 12 Aug 2025 11:02:13 +0300
Message-ID: <20250812080213.325298-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812080213.325298-1-idosch@nvidia.com>
References: <20250812080213.325298-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: adbd59f8-d48e-4002-9a1d-08ddd97726b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gexZd3Y/g/CIUFarhCpgASc77gWekH55UOVAqJgc4esWoNyoUrl9mkZ1ovxq?=
 =?us-ascii?Q?zuoKBE7qpRVdpjoMKldbz0C7SG40ejCCt62jI3Oy7SXkGNiXUm1T9c/+9Qfy?=
 =?us-ascii?Q?YrhPDYH4grUoIlYm+alk8wYNzQK8WYl+teMB+FWb7y3vUAFTx8pID+s9exa4?=
 =?us-ascii?Q?VlqzR3RZFk331Lvv1HaEDS4KBbIJB+J9Bdl97+58VuPOwKTSuTDDIiLsGpsR?=
 =?us-ascii?Q?t8HHi19vnBK0iFfrGqu0cS5rlh3foNw5XEiKdvpRCg/ecKe14puaqtk/+oTQ?=
 =?us-ascii?Q?SOcC/qYyrZIZvLKy3rpP1+MYRnErCu4YMuBwCLtVn10MmtgFTaPjvg68lfnf?=
 =?us-ascii?Q?1GZsC7cfZOMfvoTzC8VMAFeQrFqrt4l9Y9jrM4nqqSjToG2X+3wNQjXRsvCr?=
 =?us-ascii?Q?h8eXfDXab8SpKpQ6BUhlKmtRuK6FNSEyPe6fXqt3kUrQRARLWTXoYUI1tiWG?=
 =?us-ascii?Q?7mh94V6HkbM/1rMCFh/ghytdjHLxhojYpzPAnCOVlTyeGBlRqHwVZRZHwVF4?=
 =?us-ascii?Q?FY3FTYFEKY4swT9hXxrROxfAPpKnF5rnFT2veqk3P3ccyr017uRZR/zg7GeK?=
 =?us-ascii?Q?paMucXM/ah9nAofGjVkP/VMtdXnDFSmRSmQU7+iCqZ7gvlT5kboODwFpklYe?=
 =?us-ascii?Q?REdQton3wUI3ppBvs95MUSKhRKRNhbgibWQlzEzcKVn+/GK0t8PQfD43ZfiD?=
 =?us-ascii?Q?byl9tTS4gFhK7OKG6vPys+InbF6yYt9tzbkv6kwTqQQE7ZIC6XxBW2gauBU4?=
 =?us-ascii?Q?QsHKbfz5my7aY2ltXr2iYhNnm2qGwh510bADaGUJEXATOa5bcB2UH27Hcp8q?=
 =?us-ascii?Q?gDnwhovAV/2+nh/fPNiD5Z4Rwlc5AedWzF11vxFCkL8KKPiZcD/tey6639UO?=
 =?us-ascii?Q?nOvMW15FZs3tsTvAlPVEyJC1l+MYG/FzJvp7MeGXnSWTahreLkPG1hYz85qi?=
 =?us-ascii?Q?9pNprKC9O/vKIwCzBjiiHEz9OtUZ/r0BrMfS+2beG6V98m2hO/RLjdErUjOo?=
 =?us-ascii?Q?ad9qUYo6kDYZsfHYKq0X+g1I5UzMjRraIkVXtcdptz5hLMmQxfQKioIIyMxo?=
 =?us-ascii?Q?vjpCDP2e/kFRXfNkqC07Aax3PoVP/UkCjC0C8NVoDp1R+6npYvkW8RQEHc+l?=
 =?us-ascii?Q?AW5TPBTZRMM6iuTtqIQievXvhwpPQIqoB9o6QgyPBiQBDAXalbEhEzb3jUe4?=
 =?us-ascii?Q?/OXeuFipiqobdUL5fgr0jlIB209tdJz74dWvts6s9J2sU3JLEEv1NsAJkCEu?=
 =?us-ascii?Q?yXvoSQMiqCtbpEoYBP+utzmkXVol0d/s0IH1VM9U4mpZ6BexWxcUU08L1bTd?=
 =?us-ascii?Q?qfvrUmozMMx2plLREiFzvOTji1+Pqxg3SpV7GtXccRZpZgWSax/rWB/Q4oh4?=
 =?us-ascii?Q?tbkVniAtaNoeHlwNLiW6vqfWFdx6a1xf4V9DoV75jpPI2hrt1OLGzhZHH23M?=
 =?us-ascii?Q?jlKCKwO2JbrSOA+F8oMxWtY7D6y+JZOejCfhITCaRFhAQZVqWiFL/DrBx0rN?=
 =?us-ascii?Q?qIxm/9+X2jP3dTKSUNTunGg+ybT+hctuy90Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:06:32.8871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adbd59f8-d48e-4002-9a1d-08ddd97726b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

Test that packets are redirected to the backup port when the primary
port is administratively down.

With the previous patch:

 # ./test_bridge_backup_port.sh
 [...]
 TEST: swp1 administratively down                                    [ OK ]
 TEST: No forwarding out of swp1                                     [ OK ]
 TEST: Forwarding out of vx0                                         [ OK ]
 TEST: swp1 administratively up                                      [ OK ]
 TEST: Forwarding out of swp1                                        [ OK ]
 TEST: No forwarding out of vx0                                      [ OK ]
 [...]
 Tests passed:  89
 Tests failed:   0

Without the previous patch:

 # ./test_bridge_backup_port.sh
 [...]
 TEST: swp1 administratively down                                    [ OK ]
 TEST: No forwarding out of swp1                                     [ OK ]
 TEST: Forwarding out of vx0                                         [FAIL]
 TEST: swp1 administratively up                                      [ OK ]
 TEST: Forwarding out of swp1                                        [ OK ]
 [...]
 Tests passed:  85
 Tests failed:   4

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/test_bridge_backup_port.sh  | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/tools/testing/selftests/net/test_bridge_backup_port.sh
index 1b3f89e2b86e..2a7224fe74f2 100755
--- a/tools/testing/selftests/net/test_bridge_backup_port.sh
+++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
@@ -315,6 +315,29 @@ backup_port()
 	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "No forwarding out of vx0"
 
+	# Check that packets are forwarded out of vx0 when swp1 is
+	# administratively down and out of swp1 when it is administratively up
+	# again.
+	run_cmd "ip -n $sw1 link set dev swp1 down"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
+	log_test $? 0 "swp1 administratively down"
+
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 3
+	log_test $? 0 "No forwarding out of swp1"
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
+	log_test $? 0 "Forwarding out of vx0"
+
+	run_cmd "ip -n $sw1 link set dev swp1 up"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
+	log_test $? 0 "swp1 administratively up"
+
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 4
+	log_test $? 0 "Forwarding out of swp1"
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
+	log_test $? 0 "No forwarding out of vx0"
+
 	# Remove vx0 as the backup port of swp1 and check that packets are no
 	# longer forwarded out of vx0 when swp1 does not have a carrier.
 	run_cmd "bridge -n $sw1 link set dev swp1 nobackup_port"
@@ -322,9 +345,9 @@ backup_port()
 	log_test $? 1 "vx0 not configured as backup port of swp1"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets $sw1 "dev swp1 egress" 101 4
+	tc_check_packets $sw1 "dev swp1 egress" 101 5
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets $sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
@@ -332,9 +355,9 @@ backup_port()
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets $sw1 "dev swp1 egress" 101 4
+	tc_check_packets $sw1 "dev swp1 egress" 101 5
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets $sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "No forwarding out of vx0"
 }
 
-- 
2.50.1


