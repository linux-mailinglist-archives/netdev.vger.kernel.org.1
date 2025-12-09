Return-Path: <netdev+bounces-244145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE928CB0684
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4225230D709B
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AF2FFDEB;
	Tue,  9 Dec 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O689e5qE"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E72571DD
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294268; cv=fail; b=r7x1QY0sIpDpLbJCQelsAT29BXYgiJTbZoZw09xrqKei0QtTEdDTPgRLF0n3KOkqQD1s6JTfSzdJFNAzOFRJFAJdrAl91w2GrHm/e4qAUlPQygZ/lQY82NtOeA0eDBsCSdvav0oSehBya5kVV+FHu6uEEcA3mD+qSryG3fTP0WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294268; c=relaxed/simple;
	bh=8VIV5gkSvDK11BZkQn0lWAzd4BmNvOu+xt008die3Y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbwAtoT0kbwq/wgy8+vu17oOj4Im4xk3JSqryGPWyBHDfd0n+SEwr3jhGuvRsIy7EawSB/EnT9xQ4yMHfirP7yCPtu9V5rJVBo8npkAF1JJlTnENBAe8j6x4rpHBfIMYcWZjSRxT6MZUjHR7qXjhRoQ4c8hGSQf6TlM8U+NnL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O689e5qE; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLiuaoC0gnOCXxRIAaSL2lYCl7VKbdmAqcTG+yj/0SV1CHUyCfrHw1raXprNRAJ7IRFGiayZKHfxTaZ+8D9vdKZxJh0XOhGEC3J1Xoetghga4RrdWvAw5k/1M16qgKnCDBj/AW6trL0qWkqh8KBSRAMyBEtj13xNYkGYpfByF7REplCgkTcr4uCMJUCWS1MH+DRkptv0XiKQET1oQ3VwJhO6RF0sJlcdTf0+cn5AXIgekufhcKlPrlWpN7rRoq9U2oNPnMUbUAIF6aX5X+Lb/OQ/U0X6Igupbf+sL4iPZgK50pbmxTJctbabKD8ufSOf6r4F28cv1pGodIjhZlqAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi0OfeEJCDifQTAvpRx/6KnNgHu7VpPzpJKAAcWZqhc=;
 b=vfbz44cJ+sHCN2SxkcZY7jgEvXjpd/nSmDcpob4thsbbXwdzH3xJU9hvarADCfv5rsRkGnjGM96WE4EkSoHerirUZSq9qXllsT9sov5tjRTQETh/ZSf/bAB1uZz/9/VBpwRCgnYmOjlDTxX2Jmrb/U6l+Ei+6GUjA7LlUee4MfE2fg7C72/8chOlBtrJ546UbkBZzfePZMuRpQ23xZcQDtTJgkrtW3DE2IWaqr4FtDSj62XhaVHS0qn7VuNfuGdYvq3hiiSil7gPy7a8Yg1rLrCFRcV8IQMt+Lpt/zCxCICg1MfH774aflAPsgdjvKdWXfwEvNsJgP0vhg1O3cICxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi0OfeEJCDifQTAvpRx/6KnNgHu7VpPzpJKAAcWZqhc=;
 b=O689e5qEFfGF2j0NSVv3/dWVCleWGBH1LbWBDM1thMGFxb2KBUFWIjcGNGMlmYMjB4yk8d0RniPAXfPZK4MjOI7ta8Okv8MMKfyFPW52RZ8ArT2cZL8ev/S5KO3yClJ2nhPNI+XS6t4u1nL84qhdvonz0Cz9BUnY4QqyjeNMKnXFQGrJm3CRF/vnYLuBKOb4P30xCwrNyazRo0UlvAClQp5bAnA8kO5G1ONgJ+lQ2+p3jwC/vvl+25f3eefB7R/UuK4hRUaYd1Wor5D8b22/EKtRoe4pGcy2LzmROveuL+iYe8V1h8EqPzLRzZhCTuZVcTp63xVWMcV0BlMOK4vLIQ==
Received: from MN2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:208:1a0::27)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:30:57 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::95) by MN2PR07CA0017.outlook.office365.com
 (2603:10b6:208:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 15:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 15:30:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 07:30:30 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 07:30:24 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 3/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Drop useless sleeping
Date: Tue, 9 Dec 2025 16:29:03 +0100
Message-ID: <eabfe4fa12ae788cf3b8c5c876a989de81dfc3d3.1765289566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765289566.git.petrm@nvidia.com>
References: <cover.1765289566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d0aba2-749f-43b3-2c26-08de3737f2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vQWpE/58ripfTCMVtIoXtQ1MjD2tlwogkuynO2uu0vMyQxDJkF6xWwfJnAq?=
 =?us-ascii?Q?txBmUlBo+L3qBQ8+1pAXiQm/yLr7jUW0yzC92mqL58/JaiVU8nx+C6Vn1X6I?=
 =?us-ascii?Q?i6TVB+eNKsCZSa0PCkGSUDuOqSpzBCSbaxwHshbCAPVHgnM0bYeK2TR+IXuq?=
 =?us-ascii?Q?J+I77+0GERGdqn00CNaRuhll+1oWi5lt0KsK4sUuh5FdOAXDYGTFMspKZ6gc?=
 =?us-ascii?Q?Gdb7v0B+kTkhdMdiNjlmlruN2pzV41LI+Jb4MTwOYqfNXxkVRBWOAWdg22wn?=
 =?us-ascii?Q?cXeqq5kAOYAFofxT+dVj4xO2JQY27m1N5hVMvfuZ9vI4kxsUyWDpu4ZVaEWY?=
 =?us-ascii?Q?RFrBWOxMSNzKYhRVWFZwNU/lVrnnTu7OIKA2n/coQdSwLpG9OY2RIoH2/rIe?=
 =?us-ascii?Q?wF2sXMl8YUyicPHcEODsq+YlRI7MAHYLvvdEJR77eB9oIuLmxAgo58P7VHlc?=
 =?us-ascii?Q?8sE6LjmmbbqJID+25rqJMhbNE1664SLRc5/hRVswelOzopnYgHia4Q7sFmi7?=
 =?us-ascii?Q?K+F5DWiRQ//K2Lq+5qFxPxwhKYx7lEREWF15RkhWhonX3+4uls7PNDj6sWyh?=
 =?us-ascii?Q?zxaHVtle51dOr0JcPoFoPAiVhk2aL+HEMp1rE/3+/BEy3y9w1ChQs9gDE2XA?=
 =?us-ascii?Q?GTblfxh8wjsGlShs8Ns2pv+O2abI2phFpFs/QGF21EvevY++0/9nZo1w8MNS?=
 =?us-ascii?Q?6hAAAQUs7Jn/excfwMOP5gwG1zMdJmCGafOc800YUa846B/4ANj1vO7DRshm?=
 =?us-ascii?Q?1VXus6veeur6GtC2yhKQ3mwepdF/oFr7L0mORIkeUrVgzpLEdAK668nntBBd?=
 =?us-ascii?Q?Nsaovhwj/M0huxTxl7Q/7tGuTZsZv8kmSV/jnDP+r9EO+T3XfsUtaypNeQgT?=
 =?us-ascii?Q?rRy7p67Ma2oM7qDWSnrDcAHbbCD5ZTj+hUbVGh2AECpHYYWXKO9QiujETqQz?=
 =?us-ascii?Q?tn8PgZoC+ayj/ba+2+h6db0wmc3LSu0EqcA7K7kq0G4NXQYJUtqy+hbr4wb5?=
 =?us-ascii?Q?YYEd4Ttt7MohiBhYyeJrpRxS6/3bKrT/R93cf53dobnNWFFjBeAw33OEGZ33?=
 =?us-ascii?Q?5UA8D7a2N8lwNcb7n+IMzZ8qQhDjMc+rVb5LBtU3Lnv835jmuOctRY9AKGGs?=
 =?us-ascii?Q?4oHr1tmb0aqDCW7obG9stYCxsPt/Hpbn/AXz4a/b1s6zoRdLUS8a6aqtrbG7?=
 =?us-ascii?Q?ekS9c/bLmOx7w7i5Amwa/9L5gS9XHY8ZVo/q7S5nyrLpdA0SA7jaqC3iPUJZ?=
 =?us-ascii?Q?IC0RvjTbiJUC6LLOmCAUxWrh1Zyz4nBxMZaHgz3QCieaNQebmnGS2NgmKzsj?=
 =?us-ascii?Q?3RrvvtemKnusWHm6efwTi6DwuP9MeTcaJDbBYEWlBcncVpH6nZCZTNS8yESg?=
 =?us-ascii?Q?O2jsRxsKYzEk73BsidTKX/FWpTVCmx1AKzJv0Fn08qOmdgFuH/6+D7B7CBwg?=
 =?us-ascii?Q?FgudVj6oU/t3iCuDHmODUOAW6lxLssr33WOeI0WeahqFUwELYQfTVO2+LbmT?=
 =?us-ascii?Q?I2Ooo0PMMR0fd9Wnyjvz+Oza5qC79uqZOB5fbjU+Vz4jqeldc0RxIYiG6qDC?=
 =?us-ascii?Q?fUinCdQsMfx2UKrLEoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:30:56.7917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d0aba2-749f-43b3-2c26-08de3737f2d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

After fixing traffic matching in the previous patch, the test does not need
to use the sleep anymore. So drop vx_wait() altogether, migrate all callers
of vx{10,20}_create_wait() to the corresponding _create(), and drop the now
unused _create_wait() helpers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 63 +++++++------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 5ce19ca08846..2cf4c6d9245b 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -253,13 +253,6 @@ vx_create()
 }
 export -f vx_create
 
-vx_wait()
-{
-	# Wait for all the ARP, IGMP etc. noise to settle down so that the
-	# tunnel is clear for measurements.
-	sleep 10
-}
-
 vx10_create()
 {
 	vx_create vx10 10 id 1000 "$@"
@@ -272,18 +265,6 @@ vx20_create()
 }
 export -f vx20_create
 
-vx10_create_wait()
-{
-	vx10_create "$@"
-	vx_wait
-}
-
-vx20_create_wait()
-{
-	vx20_create "$@"
-	vx_wait
-}
-
 ns_init_common()
 {
 	local ns=$1; shift
@@ -559,7 +540,7 @@ ipv4_nomcroute()
 	# Install a misleading (S,G) rule to attempt to trick the system into
 	# pushing the packets elsewhere.
 	adf_install_broken_sg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$swp2"
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$swp2"
 	do_test 4 10 0 "IPv4 nomcroute"
 }
 
@@ -567,7 +548,7 @@ ipv6_nomcroute()
 {
 	# Like for IPv4, install a misleading (S,G).
 	adf_install_broken_sg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$swp2"
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$swp2"
 	do_test 6 10 0 "IPv6 nomcroute"
 }
 
@@ -586,35 +567,35 @@ ipv6_nomcroute_rx()
 ipv4_mcroute()
 {
 	adf_install_sg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	do_test 4 10 10 "IPv4 mcroute"
 }
 
 ipv6_mcroute()
 {
 	adf_install_sg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	do_test 6 10 10 "IPv6 mcroute"
 }
 
 ipv4_mcroute_rx()
 {
 	adf_install_sg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	ipv4_do_test_rx 0 "IPv4 mcroute ping"
 }
 
 ipv6_mcroute_rx()
 {
 	adf_install_sg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	ipv6_do_test_rx 0 "IPv6 mcroute ping"
 }
 
 ipv4_mcroute_changelink()
 {
 	adf_install_sg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR"
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR"
 	ip link set dev vx10 type vxlan mcroute
 	sleep 1
 	do_test 4 10 10 "IPv4 mcroute changelink"
@@ -623,7 +604,7 @@ ipv4_mcroute_changelink()
 ipv6_mcroute_changelink()
 {
 	adf_install_sg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	ip link set dev vx20 type vxlan mcroute
 	sleep 1
 	do_test 6 10 10 "IPv6 mcroute changelink"
@@ -632,47 +613,47 @@ ipv6_mcroute_changelink()
 ipv4_mcroute_starg()
 {
 	adf_install_starg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	do_test 4 10 10 "IPv4 mcroute (*,G)"
 }
 
 ipv6_mcroute_starg()
 {
 	adf_install_starg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	do_test 6 10 10 "IPv6 mcroute (*,G)"
 }
 
 ipv4_mcroute_starg_rx()
 {
 	adf_install_starg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	ipv4_do_test_rx 0 "IPv4 mcroute (*,G) ping"
 }
 
 ipv6_mcroute_starg_rx()
 {
 	adf_install_starg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	ipv6_do_test_rx 0 "IPv6 mcroute (*,G) ping"
 }
 
 ipv4_mcroute_noroute()
 {
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	do_test 4 0 0 "IPv4 mcroute, no route"
 }
 
 ipv6_mcroute_noroute()
 {
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	do_test 6 0 0 "IPv6 mcroute, no route"
 }
 
 ipv4_mcroute_fdb()
 {
 	adf_install_sg
-	vx10_create_wait local 192.0.2.100 dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 dev "$IPMR" mcroute
 	bridge fdb add dev vx10 \
 		00:00:00:00:00:00 self static dst "$GROUP4" via "$IPMR"
 	do_test 4 10 10 "IPv4 mcroute FDB"
@@ -681,7 +662,7 @@ ipv4_mcroute_fdb()
 ipv6_mcroute_fdb()
 {
 	adf_install_sg
-	vx20_create_wait local 2001:db8:4::1 dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 dev "$IPMR" mcroute
 	bridge -6 fdb add dev vx20 \
 		00:00:00:00:00:00 self static dst "$GROUP6" via "$IPMR"
 	do_test 6 10 10 "IPv6 mcroute FDB"
@@ -691,7 +672,7 @@ ipv6_mcroute_fdb()
 ipv4_mcroute_fdb_oif0()
 {
 	adf_install_sg
-	vx10_create_wait local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.100 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst "$GROUP4"
 	do_test 4 10 10 "IPv4 mcroute oif=0"
@@ -708,7 +689,7 @@ ipv6_mcroute_fdb_oif0()
 	defer ip -6 route del table local multicast "$GROUP6/128" dev "$IPMR"
 
 	adf_install_sg
-	vx20_create_wait local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:4::1 group "$GROUP6" dev "$IPMR" mcroute
 	bridge -6 fdb del dev vx20 00:00:00:00:00:00
 	bridge -6 fdb add dev vx20 00:00:00:00:00:00 self static dst "$GROUP6"
 	do_test 6 10 10 "IPv6 mcroute oif=0"
@@ -721,7 +702,7 @@ ipv4_mcroute_fdb_oif0_sep()
 	adf_install_sg_sep
 
 	adf_ip_addr_add lo 192.0.2.120/28
-	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst "$GROUP4"
 	do_test 4 10 10 "IPv4 mcroute TX!=RX oif=0"
@@ -732,7 +713,7 @@ ipv4_mcroute_fdb_oif0_sep_rx()
 	adf_install_sg_sep_rx lo
 
 	adf_ip_addr_add lo 192.0.2.120/28
-	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst "$GROUP4"
 	ipv4_do_test_rx 0 "IPv4 mcroute TX!=RX oif=0 ping"
@@ -743,7 +724,7 @@ ipv4_mcroute_fdb_sep_rx()
 	adf_install_sg_sep_rx lo
 
 	adf_ip_addr_add lo 192.0.2.120/28
-	vx10_create_wait local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
+	vx10_create local 192.0.2.120 group "$GROUP4" dev "$IPMR" mcroute
 	bridge fdb del dev vx10 00:00:00:00:00:00
 	bridge fdb add \
 	       dev vx10 00:00:00:00:00:00 self static dst "$GROUP4" via lo
@@ -755,7 +736,7 @@ ipv6_mcroute_fdb_sep_rx()
 	adf_install_sg_sep_rx "X$IPMR"
 
 	adf_ip_addr_add "X$IPMR" 2001:db8:5::1/64
-	vx20_create_wait local 2001:db8:5::1 group "$GROUP6" dev "$IPMR" mcroute
+	vx20_create local 2001:db8:5::1 group "$GROUP6" dev "$IPMR" mcroute
 	bridge -6 fdb del dev vx20 00:00:00:00:00:00
 	bridge -6 fdb add dev vx20 00:00:00:00:00:00 \
 			  self static dst "$GROUP6" via "X$IPMR"
-- 
2.51.1


