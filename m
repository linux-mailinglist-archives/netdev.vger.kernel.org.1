Return-Path: <netdev+bounces-94068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C678BE108
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838661C20BB2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF71152163;
	Tue,  7 May 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sb9QAXcc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C814E2F0
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081504; cv=fail; b=czo8HJGoljtqNaIRZ8QvQDYNvBpB3wkCV3Jq7mi59zITqcMPa2BpAusGLfwoIbJtPkR+cM5GuogwDgwN4UxyQpySBs7kw2MbXCwbQi+EQ6XcScDZ5LENnDxnIiYrw3swKNK3x0SJeTvgPl0OSa8qKJJkJxOQZ5Y9dON4DFEgTos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081504; c=relaxed/simple;
	bh=/hd5rfqG4frEh/iHENa65HVwlvxzM9jxbxP+9J3Uwjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5jmzBVViGF4VCxqCFsffi7XBljBdz5BNpvJjkkLPWDCZnc482/Gp/zHlpaT92u+Jwc5yAou3IFZp2L4n/kfI2tEIfUEZhdje1admzDYY6FPl8XhJelWqURi3poPQnV+hIWjgx3DmY0H/Oy9CAihYLzw5EkS8W8U0o5S523BiKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sb9QAXcc; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY4Wv7IWS6/PMJoH+FIGatdd5TtAjeANEXJPSwHIOSyGEhlUfpR5fltLqckEZnW1PpvrTsLrGMSVRWjg1rDQGAr0lN4FhHLJsk9ssomK9KvTCsT7d6BMM3BLwGaKac11608GeXwSETr70JD0eR3QXTiMsdCd7zjjIHGA44iOsOIsmxBStegFmiadhe0V4cPw6ge4L1OKuJNIgSecse56yIP51q/kDWEAZFrndNrzgEHdBWOr8a/VtaeOnwNiNwz+FLIHbune2b00TRoEPkIm5dGbwKovtxVTBtCUGxapuLzqEE/UUnZUkkrCIt1yZivEIpzOq4rLuxQZWUZHs8KEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK87y4QSAJMsn2Myd5gxBwgmV25cd5IwoEbGq+hc3Ns=;
 b=RS2NT7b+B5RFNEvktly0a/Bof+gjK/zZ9VNgrSBa+95oWBlYSsW0pHVeXT62xjFEpKWdVO/N+fa179hjgQNFliynNSJhR/cXnor30RL5q4OekSggVpIFWqPZ820bkJBcu19g+n8IH+RdWEMTj+qVdYbrUldrBoK/Sj01kcA/SWfHIZgon4l7j2qG8kSt4yDndgARxcTm7g/+Wv68dXjYdTIGuKihjrkZSsZS+2lVzuxDFpFXI3h8stXahXE4j7wCac0oCKQz0O8R+46Hu+QJBsz8STXA/TYBTBMAcpH3mKpNdGRepbcRMnxIhwFBusf5hu/NDZeY/zaP/1U9fUVx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK87y4QSAJMsn2Myd5gxBwgmV25cd5IwoEbGq+hc3Ns=;
 b=Sb9QAXccIYw9d1Q0JkAHUSX9PcyQyl31fAvQ1Zf/Q/PUOrha6EM6PlvvSrP6dWofrzm8D8zLTYgRe+RtIyzvelqIHpVIjmDyA0cEZaDJS4OlpRuPZ6MUM7xHQyKQz0VXNFUYVJrS7P2mtWOGvKDNqPg5LujnglqMqgyaXAh3Yxmayvpwa2awR4yzayRjUaUOBkQRaI7afZ43bDDxmrjq0RWAFVqSXUcUXt598L3eysS4a9ucMSVe1IxI+L6o4CRlTHAbC3UBmK6BztKLSeYQvcbV08ldO0YglG0Eh66MqD4eBlsW6p5ZalSXNF12QnMfm8SoQ1mI+vZ/Mn9yerqQmg==
Received: from MW2PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:302:1::34)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 11:31:38 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::33) by MW2PR2101CA0021.outlook.office365.com
 (2603:10b6:302:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.11 via Frontend
 Transport; Tue, 7 May 2024 11:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 11:31:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 04:31:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 04:31:21 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <mlxsw@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Fix failures due to duplicate MAC
Date: Tue, 7 May 2024 14:30:33 +0300
Message-ID: <20240507113033.1732534-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 75192c6a-bc17-4dfb-a6cd-08dc6e894242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVebFeK+d+xqOJE8k6Ti3YAupDQHILQTbF1SwfOzxEvbD3AE+mTVueIPJm80?=
 =?us-ascii?Q?iwqVA1HNvwDW6KUfkWtBHMbmltLZG+QSPReptrfqa8gldyn4iWCz5YSkwYuN?=
 =?us-ascii?Q?cwZQKiTXRvk69Q8WuSSaZ1LEJ8KshWCOiYbTRbQNgDbOzda1bSL2Gj4KMF8Q?=
 =?us-ascii?Q?9J8U99Vxykmk66cgP22F4HyE/5mjD9AuCQTqV0SPGAvi/O6p8d7VjakHKheT?=
 =?us-ascii?Q?B1zwN/ZPdAdKshEMRoZZ94zcLfzNeGXGTGrpk8v1TOJy+39+iU8TfVQBeNqR?=
 =?us-ascii?Q?zX/MvJ8CUatQTW2CdIDBDRFZViITDsbk0eADpOTABRX+U9ehcxn+DURYgEJ5?=
 =?us-ascii?Q?wMBNN8lH8ONkbdXv/ugyDXM7lYxMsL305/g8QWpx8f3Cux9SZeo8qJwBVSPA?=
 =?us-ascii?Q?AUSqWwuBVYiGYwsXnGoG7F3dWIS/vYmQNn2YAvzgGXwnJrxxLlfYTUErFkZV?=
 =?us-ascii?Q?k8Nqyaz6Sp1vksKXTUEzW8gvaKr4tzytlM5+ppyPnpHbQduF748AHHuRQkeD?=
 =?us-ascii?Q?xFOUp50CRHPYvuAT6gBJO9XVawOLdBarI3LAkYVAhZa1qzJkRgPrG0z94hVG?=
 =?us-ascii?Q?S3gwLxP6gMPQRiBbQSETt8MzeYxcka//O1FST8MiGttsZdONti5ZsK8rMMBu?=
 =?us-ascii?Q?UkbLnLcjIoyAF6EGSsdmT6Du/KZLrsR25swO5CUKDoZ4Gc6eEvsvzlplmyO+?=
 =?us-ascii?Q?4hBg8DqAkhraRPiwto3VLnamYQ6/+qbSPp02H3Qp0qx7bHvLI+hmv6q0nfi8?=
 =?us-ascii?Q?h7E7z8o62hcIWL/wDuvpe3lN2lpjzkSDIy9hhu9zxPz90S23xjPYjBUrxsHY?=
 =?us-ascii?Q?vbqyAQMmLwBh1UgRiRPAKI328dtCnJWkdUh1TUqI96UDESiQCAyfDj55VGxL?=
 =?us-ascii?Q?Ly0ljyvgQ4PSkIg7atHoM0ftpr1KElMkDzin2EaO3Qk3UBcNoR+4oDSgO1si?=
 =?us-ascii?Q?ZDb85FGoSO8PYktG8zn93aep4WODn/+35Zi02cnyg52Or9Dk3ZNB8464A7NN?=
 =?us-ascii?Q?FGV31HIg1XOj9oUm82Va7l2MCcHdR8bhPv19+RrNmOmap4hl+WcAo3926AW7?=
 =?us-ascii?Q?bBHiaHnqAwlCnDd717lc8yXfP7ULiLRz5xCS4xI4d6124COK6yc5/LvSCzgv?=
 =?us-ascii?Q?CerGkjJskbY0g4E6Se8DV0DexAOvEmzMeckgqorfTLmhhIhYznGLTQBXwXxa?=
 =?us-ascii?Q?kU62j+eorJgvyNw9cF/x1A/NyK9Q9btrmS6tWHaT2KtYiRHHGILr6+hkVyM4?=
 =?us-ascii?Q?BNLaB0Dv7y86BYjl9R8Jg0dp695hgg21SMSD0HlhXo5FGzcQIMMJqbsEYCuW?=
 =?us-ascii?Q?7X7xS45KNbHj51PAJqw+H9lBLi6UZiQ2FhO8xeEdRvAL7j26M0ewa+6sW65V?=
 =?us-ascii?Q?5XAZyNY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 11:31:38.0069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75192c6a-bc17-4dfb-a6cd-08dc6e894242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

When creating the topology for the test, three veth pairs are created in
the initial network namespace before being moved to one of the network
namespaces created by the test.

On systems where systemd-udev uses MACAddressPolicy=persistent (default
since systemd version 242), this will result in some net devices having
the same MAC address since they were created with the same name in the
initial network namespace. In turn, this leads to arping / ndisc6
failing since packets are dropped by the bridge's loopback filter.

Fix by creating each net device in the correct network namespace instead
of moving it there from the initial network namespace.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240426074015.251854d4@kernel.org/
Fixes: 7648ac72dcd7 ("selftests: net: Add bridge neighbor suppression test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/test_bridge_neigh_suppress.sh    | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 8533393a4f18..02b986c9c247 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -154,17 +154,9 @@ setup_topo()
 		setup_topo_ns $ns
 	done
 
-	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns $h1 name eth0
-	ip link set dev veth1 netns $sw1 name swp1
-
-	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns $sw1 name veth0
-	ip link set dev veth1 netns $sw2 name veth0
-
-	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns $h2 name eth0
-	ip link set dev veth1 netns $sw2 name swp1
+	ip -n $h1 link add name eth0 type veth peer name swp1 netns $sw1
+	ip -n $sw1 link add name veth0 type veth peer name veth0 netns $sw2
+	ip -n $h2 link add name eth0 type veth peer name swp1 netns $sw2
 }
 
 setup_host_common()
-- 
2.43.0


