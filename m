Return-Path: <netdev+bounces-199130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5801ADF1AD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9FD3BC362
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0BE18DB03;
	Wed, 18 Jun 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npZKAEJ1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E228E7
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261648; cv=fail; b=R93bYmtilTtkJvODQf89ZTIrNCOxkQuZGfmHRHHAxhsTfUK1pqx0aPzfmIrWK1vjl+fcthQdHtwx/oHusPryASUfdy5BRoT/mP6bstg1QuMMsDvXq3lX3VRLPAMWCcNkPXE6G8H8CzqI95If7XZjCNOphw6OdCYjmakDaJiSq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261648; c=relaxed/simple;
	bh=md3b5d9RMSOOco5uZERFW1Hy8fteVTWpK7PqteeP9uE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngP8YzjyYS3hIak1If2EvaYlk5LpGIegkTwgBm83sJwYLbscbxHssmHaB8ZLGf5b/w7qqJyEFu4T7bs1yg7NWN3rYFfh7T1xXkAdU3Y3YNhvAoGz5tQ87BDyRKKPMc97NRdQ7riZtnJbpqR8R4nCcLUOPEgONI9BltSYeBtMXAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npZKAEJ1; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqjZHWjd6/DV2u31SKbh6vVWw0SRMjdxwGbvMFrJFjNfdy2joRv47vrb5btfPEFMUWW210Txiejk8syWCk1k1Bc1KQPgZvYfkAIkL7kJkV41tT5mjvvGDjEn4QB2RJXHwqBdI4ZGg3HE37/KmjpzMlr64gsOmaGfTkY7UnOxWvvZnNmE99Z1d4d9Wy022xIre0IWQD/yd8mUNAlt0KXbgjxUXFLTYyb8O41gfWgCLxrxrVY6kpcJCsknRsjeQoZ4d6Uzxb477S89TQa+sdP0EH2aHv8ouAXA5v5/la+aM9yFy1jgew65SPSuBNNvLKbWCxd9paK9d14FajmXoO4dHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxM4FfkK9odOZXcSXOtFx+lZMmKb9VbTV9ttijeExFc=;
 b=JuHHMfRpgDQyC1jWrVDrZ4zBJ1z+/dC0YEiHm/i4hp87R3Fk0/4jPvja+AFz1CZaLtoK4dD5VtKbDylsMCYruPegyRgBHmfTuoT2c3t2J2Y84A9yEld0WG44D14BViZoJnKsFmiueIuoGn97mHj9QYsq/uDgR/TtlupBl5Xv20yDO1l4jsv8Ey338I4qIOnri9rIR1+Txvq1HP5Q/ZX7di5Xk30rdG/kKm+xDL2UMZoZOiHN8tr8KuJESswGb0XUua8JYJl7r4NxmbMfuhdCWntU4NAFqWVW6dT7F+k5v4/dJ32fHLRjwM8Xf3wnYkiNGJM069dafFbHd+GJdzrFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxM4FfkK9odOZXcSXOtFx+lZMmKb9VbTV9ttijeExFc=;
 b=npZKAEJ15yQZ6nHmE73fvz1OdWdzqqViI/AYdLAz0ZHxgm26T1/keCI8bMhH4RiMMyj3WY/7Il0jVESFzDRgHtuOmIJlVN9IMRDIu+e8Xf4UA/WN8uOWTJ8YVOUh1Ob/+siTfRFVXngQNSF4bjYJ1ons2yi17yQMWHMsP1wtVgPrBQNBW+wopqFimnrahVgaxBxAj1B+7gImbm24IvT3bSaZeSv60R4VYf2TQzu8/qRxcCEx7DsJfMGIVxprghWDLcoDdSnefLi1IgGfRkU169j5RiqmkJA7E0Vv0tlOv7Ug/4LOKcmZuNnV4DE+HRM+bP972b+WmF9Mk49jpIoybA==
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.19; Wed, 18 Jun 2025 15:47:24 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::17) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Wed,
 18 Jun 2025 15:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:47:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Jun
 2025 08:47:04 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 18 Jun
 2025 08:47:02 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next] ip: VXLAN: Add support for IFLA_VXLAN_MC_ROUTE
Date: Wed, 18 Jun 2025 17:44:43 +0200
Message-ID: <14b0000cd0f10a03841ce62c40501a2dc1df2bc4.1750259118.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: f17594cf-c6c0-4bad-e54a-08ddae7f6b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKuBg+Ol9ELCuOv2fZPoa+ajCnAbg8vM/InhNjbefNq6pT2yTQbs34pYpeP2?=
 =?us-ascii?Q?ivXvqBTJjOupaZsoKqVHqyTq79pwc9mKEusAVdcBKSiZTG1O9r/E191xCPeq?=
 =?us-ascii?Q?W9i1UaasgwjXc7eT1qOHE1Zkk3g5JhRlp7VrS7brN70xPkDDCEQsnLGJRJgg?=
 =?us-ascii?Q?EGpws/8pBdlS77oVMYGPT6oNeusL1FOHxv1kJ42PwwV3QThzpSL+bIa3hSLl?=
 =?us-ascii?Q?Rts2vOLEU2ybIEUP6JOiNLMouRBEAW9OKwv5tOJgpdgzEi7Lu3m/nv2LwxEV?=
 =?us-ascii?Q?q7aVAlRgbPB9Opebte14o3WUQrfrZJmc08f/2AIatkd/O/9L45UxrO6ioZBv?=
 =?us-ascii?Q?75MzH/XDiLjEHYiNMjvX08TSkF26XgEjN2dggR6Qo7JQFxNCSajRdWzFwWUQ?=
 =?us-ascii?Q?8lsb8LIO9kbvSVrq24l7LW+wvmPYf1SXYIIq8Lr56J1BXrzCTg6Bu7eLEXpP?=
 =?us-ascii?Q?jLcl/iNjh6CJhBdaXeLTmXDoaytLjlNvt70x5HC40AcMzPcQPlsYOOg0ZWtG?=
 =?us-ascii?Q?19hQI/n38gA1fyxnXCka6ON9UZcK9kbEwJsZs3GGVwVSFcTEyxzrnwpxD0Z+?=
 =?us-ascii?Q?uamwbPriXFAtOB26iyBvYMMgRszL1VFHpHC13LkvmsqlD0Af3J7zy+r8tVWW?=
 =?us-ascii?Q?kNvesMYBCMvmqbhAoUMPAVz8nQ169NNnkFF7bCVnlK6lx8lVPE3gJt0Tl6c1?=
 =?us-ascii?Q?G1FJcSQ4NRNjHb2lA6/P698kPVFGwuycxFweBMOOK6qb6oBW6tfy1hrK7FlT?=
 =?us-ascii?Q?M6+rM479dtBRmrFpSNr/IOM5+KXuMCr+SgCwfAbvxUllfDca79CB0fKi4Xkk?=
 =?us-ascii?Q?l+y2qdJqHmpFdi9urnfS6/mYoFtCUIWEFfv7tj0CWyoahh8I/YEuJ+66wiDm?=
 =?us-ascii?Q?V4ZEkQ/PqaWhoR830b5hLT49/X6WEi8ldmLY4wFxfmy9wZONSI1U4pmc2fP4?=
 =?us-ascii?Q?Q0FyXQBU3GU2vu2ND5tPADwShLkhLM5RW3wd7xgIy16oNqvgh1mzrge88fG/?=
 =?us-ascii?Q?Fgil/lO1ht5ltiO8su6HcNdsGZZY/AfuIW7kZf94iCGJugp+Wm85E0udGtJm?=
 =?us-ascii?Q?Lh/w2R0VwY2Strq6NjkKWEDNDiK3uBLgx+rnFiJ3PtbBmEWzkqQb/R9gxAmP?=
 =?us-ascii?Q?6atANPLUnKZvDiJwsUT87Jd6RcDhExTBNONiLjSWTkdlES/5fXEI8N17lc+M?=
 =?us-ascii?Q?PLkIJxTB8lDMjrIRZjZHnrhtl+AmCRERP09Jy4EVVYXTx7s2xRyRRn0uzpr5?=
 =?us-ascii?Q?lGCd8gojTwLrrfvzdgjmpAtOTYtpLpDmLqDsMWdE7PTqT1cZDW3VMnR80f3+?=
 =?us-ascii?Q?DcMiQCIhWyafl7Nokv1u1JJVx8aH6UKbZlhWo1lZP65T5NNsdNo3Mkl4v1d5?=
 =?us-ascii?Q?z7qCFSadvCL+cZFwGnGistjJc3b6R2dWY3VB1UbtRVWhbFRyiTccEMJZhqAe?=
 =?us-ascii?Q?vEF4vWFyFPrl2G1YiyMazcQVIfOsxeH+y4+Y/1Z3ZjeXc7pxX+vabjHyMZW0?=
 =?us-ascii?Q?f2OipvrsM++hSpckPC7Z57BOLoH1Z77WrjFD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:47:23.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17594cf-c6c0-4bad-e54a-08ddae7f6b54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

The flag controls whether underlay packets should be MC-routed or (default)
sent to the indicated physical netdevice.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/iplink_vxlan.c     | 10 ++++++++++
 man/man8/ip-link.8.in | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/ip/iplink_vxlan.c b/ip/iplink_vxlan.c
index 9649a8eb..a6e95398 100644
--- a/ip/iplink_vxlan.c
+++ b/ip/iplink_vxlan.c
@@ -37,6 +37,7 @@ static const struct vxlan_bool_opt {
 	{ "remcsum_tx", IFLA_VXLAN_REMCSUM_TX,		false },
 	{ "remcsum_rx", IFLA_VXLAN_REMCSUM_RX,		false },
 	{ "localbypass", IFLA_VXLAN_LOCALBYPASS,	true },
+	{ "mcroute",	IFLA_VXLAN_MC_ROUTE,		false },
 };
 
 static void print_explain(FILE *f)
@@ -67,6 +68,7 @@ static void print_explain(FILE *f)
 		"		[ [no]localbypass ]\n"
 		"		[ [no]external ] [ gbp ] [ gpe ]\n"
 		"		[ [no]vnifilter ]\n"
+		"		[ [no]mcroute ]\n"
 		"\n"
 		"Where:	VNI	:= 0-16777215\n"
 		"	ADDR	:= { IP_ADDRESS | any }\n"
@@ -378,6 +380,14 @@ static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
 			check_duparg(&attrs, IFLA_VXLAN_VNIFILTER,
 				     *argv, *argv);
 			addattr8(n, 1024, IFLA_VXLAN_VNIFILTER, 0);
+		} else if (!strcmp(*argv, "mcroute")) {
+			check_duparg(&attrs, IFLA_VXLAN_MC_ROUTE,
+				     *argv, *argv);
+			addattr8(n, 1024, IFLA_VXLAN_MC_ROUTE, 1);
+		} else if (!strcmp(*argv, "nomcroute")) {
+			check_duparg(&attrs, IFLA_VXLAN_MC_ROUTE,
+				     *argv, *argv);
+			addattr8(n, 1024, IFLA_VXLAN_MC_ROUTE, 0);
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 91fa0cf1..e3297c57 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -663,6 +663,8 @@ the following additional arguments are supported:
 .B gpe
 ] [
 .RB [ no ] vnifilter
+] [
+.RB [ no ] mcroute
 ]
 
 .in +8
@@ -796,6 +798,14 @@ device with external flag set. once enabled, bridge vni command is used to manag
 vni filtering table on the device. The device can only receive packets with vni's configured
 in the vni filtering table.
 
+.sp
+.RB [ no ] mcroute
+- when the VXLAN tunnel has a multicast remote, whether the underlay packets
+should be sent directly to the physical device (the default), or whether they
+should be multicast-routed. In the latter case, for purposes of matching a
+multicast route, (S,G) are, respectively, local and remote address of the
+tunnel, and iif is the tunnel physical device.
+
 .sp
 .B gbp
 - enables the Group Policy extension (VXLAN-GBP).
-- 
2.49.0


