Return-Path: <netdev+bounces-243279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A13C9C724
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25CE84E4852
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99A2C3244;
	Tue,  2 Dec 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dD6dxpwE"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616752C237F
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697506; cv=fail; b=FW//zZYbq4D57xg9ZWLV6Rjli2x56o+rPzGk/hlh34Xd+ARNrb9X3kWtQhXmVB7IcnqMuGwbSjUdoM3MwnWXFEgnPgaDQWh8014mV4BOfsO34AXtcCJ/P43nv4nVQY5YMzFtZ5sCVYxie0vqHPias3fipZIc4sxc+At0/8INeYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697506; c=relaxed/simple;
	bh=VH78SciMuqKI3r+3QYnwl0weC5TsLZAwD6Vifs00OFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o40q7vukj3gZBrQKwRbAs/EiyEOOPTQHJLWsC4idE1YxF2tacEvuyylxj+L+3LzjdskwhNmrm/cbcS+dDJGs4n8LY+maTMeopxkWdZRy4h9GpDLHHucTl4AloiUoMnLjVwZs3Obs3b1uQOXj/B+JpSiTtXRw7YXDLQa9VbbXO/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dD6dxpwE; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqqvAM6e66m/0k3p6yVuLNFcncU5u/dxEndB3WgSYU8I7V7R7w1BNA25FW3wQa516r2OYyfwBoq23pXWdSdEPbisZH8km5oHo7p8sqy2kfVA4c138yK5wO17Vwca7zyBR1OXdTxOMdqbByYLgNTmnDxSCSJ2YFEANQWriligU6M25cgYgZ1fLznpZKDSEhQi9Lrk+WbcIWp1jdMg5rJHd7QQ8Fxr0GDnoR/YrGz5g7+GQ7fmu+YMDpOkfPVubqLEN7UpkNhtZfgm/3qSAg3d2lKMKXQ7DFLQ4hWGKKx4RPn2OtD5Yr7ZiaI3VCY+DWJSoLDNuc1jqbpkAxEl5FqigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux6L95bOwYZZGXjYrZoBqJ3hA1F5RWqiS/U9lZRJbGE=;
 b=owM1tKSvXkSfgrD1atGj8Fy4vhTEwhX1T2Y9AsE8XNRSnE9yym2U4AXeYdcuYaDIEaVG5VSTHyWFXEm63pREYzRn74zilCemtnQ/7NvJQRqLEAoogNn6ATofU603LYhgQxBdAIc2Z6/d1Gjvsvq2caIdBD1l5ZrKV10FQzUZrIPYYWGuZe7QYcBbGXakABbhLNxb3wl3vFnENhjeNMLMFRI469ECAh050w/pLpIAUWcrE7J1irvdVVj9+yCmHoINleyD/+Zwr+FnF1WQ6nTGj8dsCs23QoyCInTzQqBw34eJxzaudrlKJrax7dC0vZMb/ntOlB0C3qmdM1w1c7gDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux6L95bOwYZZGXjYrZoBqJ3hA1F5RWqiS/U9lZRJbGE=;
 b=dD6dxpwEySmMN2J9Smci60QyqKdcCPi75aT85ruWZviqi45qcqtK6j7G5GV0AhcZM6SehvebEKIwX5oNPxzKuZBydah1Cc1afRz/5ydl3AnPoDsh8hG8puQ0DhikTqXZ/ScgwT3gpL8ieV36YCnZSm+DxQv2nWpAzr5sP5pYbwLLRjUBGzHj2Ny3boTzn2AucdMmOHGGd0dJJ1WxcTJiwfe94on3SpIIL4kFGOIw4WCxqgBUvrU/BA5NtcHkvPyNG2n5kziJ5ZjsCTTgQm7v/7EnCwK7wrtKUWYxGvJ0GNd0ZJg4noYnuSKUZ4GFGkKTPtmdIs+V5R8W0atEjq94Nw==
Received: from SJ0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:a03:2ef::23)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 17:45:01 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ac) by SJ0PR03CA0198.outlook.office365.com
 (2603:10b6:a03:2ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 17:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 17:45:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:39 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:34 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/3] mlxsw: spectrum_router: Fix possible neighbour reference count leak
Date: Tue, 2 Dec 2025 18:44:11 +0100
Message-ID: <ec2934ae4aca187a8d8c9329a08ce93cca411378.1764695650.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764695650.git.petrm@nvidia.com>
References: <cover.1764695650.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: f255a77f-b8eb-40e3-337d-08de31ca843a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUOfynsfeSqMmnDwTiTS2JznvfOiM6+Xr4c+YC2W0ch43b77sW3dc6FH4Kzx?=
 =?us-ascii?Q?rcraOg6fThcsItBujjvYDNT/YBAz3j3TjhETVroMXCFO2OC3L1K5+DboZDYw?=
 =?us-ascii?Q?RAKsEflfhIpBlAPDLHthojR9+F4SVUip5jzmALeZPQcFLp3acMbiVZWsAlBb?=
 =?us-ascii?Q?CyoAr4GVh0iLHxWVGHJASM0hZEhp15NYyvlatHUbG1HZHmMH1rwX878MdfoH?=
 =?us-ascii?Q?IetWxEW9fpAg1px/CPIgb4+QTNSraoxsUdhoDVpbKcCZyJJeszVqdLBQU6kH?=
 =?us-ascii?Q?2racuErrp76jRE9UJBeBHUolp8eT7Pc/IH90TRWrmxooa1iePb365ASxSWNg?=
 =?us-ascii?Q?1YpKLgxKX2ZTPMjJirGMon8RlJRnx72NEyD0UBXQARqECBsGFKep5ZEHQdVY?=
 =?us-ascii?Q?5uOPr/+G1IQ+rxA21WQos/RTMyKIvKqeZsD/zKYpfC7FMWLLitXMflChe9Ze?=
 =?us-ascii?Q?0j1zeawmh4rvf9MVT4W3OWtGF7mH0GOKxoFXVMeqnzHMVOM4iGtHiWbWSxzr?=
 =?us-ascii?Q?T1WwuZPWVAhN5ZUqzPakF08hcq5pgc2qxI60NPkyrBgtGVoPD6JSDDZILW5I?=
 =?us-ascii?Q?UB4QPAXChS3VaUzsaFOw7ZyxcmGq45MOdfz896CpIb1RRAj1CelOaXw7VpSZ?=
 =?us-ascii?Q?f+C+t0v6C1vzt8FpJ9k+abLqlb3Vt7Fdo25YGKhan0fK7g29m6r4DxNmd7/L?=
 =?us-ascii?Q?Ii4fGmA6Sh3Xz/2knnQJ9tO6bJVRCsFx0ez7JCVDFifwj4nKL4XK+ZqmCScV?=
 =?us-ascii?Q?C5v75CPYafrdkfvF3qwHlRNJpMJcu9WCndReEVTs5BuhKygFqJZCnz77q4Rz?=
 =?us-ascii?Q?rrY0XCUcs5kBsKxTs7Bj7hM4T2bsEmETDI6EHXBZ6li5kr2ap/vphCSp0reD?=
 =?us-ascii?Q?OVN2FEaU3Sw6W2VLTka+k9e2feHKm6MWfyf5FCWwnagIuni0qWQpmhFgWCVC?=
 =?us-ascii?Q?Q+JD70X4s2LmRiKG6Fipel4ycai/PR7h6RqWErfMpX3PgZEIQx8hy/ewO/zU?=
 =?us-ascii?Q?0c0miiquBEqoI8KLsDbZD5SV+oN2HVL6WLfcK/+LFFVTM+WN1e/8DHSXUwAT?=
 =?us-ascii?Q?1Ey/O3YzwNGsLQPZDdIVsxcsJhNHO+PKGUHseRUB6sxDJ5y6tll8C9EbQnhQ?=
 =?us-ascii?Q?6IAKCz9xWg81CXPgVEV8Rv8MUdIhmf7gWLDH10QYn4LUIve2ypn/KWiMT/LJ?=
 =?us-ascii?Q?nklE2V3XuGWEf8e2XQlDOzZ7Mj5+ZZ9PMfi5ReBXvpbS80gTDd24ub0/GzDa?=
 =?us-ascii?Q?5ipxwnf7mydgW+BvGob5AYs6AZi7ixZW/djPUM8OongeQQmlmKwxo13bbQ8r?=
 =?us-ascii?Q?GNXxDCEM1Rpf41/fJHzVKydAzX91aIFZXnZnD40gFZs6spHpEvntKqCi6gfN?=
 =?us-ascii?Q?LZaJoe2UMZQ/+RSdWwUT/3Ul+a4+oD7K7SQkB46bE/Gyi2ETHi2H92bEJHO6?=
 =?us-ascii?Q?+pwJ7jbeB1CEZ/2KVEsGgd+SBJgsNiFl1I3LjIw4gKvLYzJn69yhZ9SoLwRn?=
 =?us-ascii?Q?E6pK5tvxhRExOf9nIfK/enAP8+EZUmHCXPmX41ZJM1HGEeDyNY7XQ9lmOmwM?=
 =?us-ascii?Q?/k5ICCxvKWgp7PzR04o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:45:00.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f255a77f-b8eb-40e3-337d-08de31ca843a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

From: Ido Schimmel <idosch@nvidia.com>

mlxsw_sp_router_schedule_work() takes a reference on a neighbour,
expecting a work item to release it later on. However, we might fail to
schedule the work item, in which case the neighbour reference count will
be leaked.

Fix by taking the reference just before scheduling the work item. Note
that mlxsw_sp_router_schedule_work() can receive a NULL neighbour
pointer, but neigh_clone() handles that correctly.

Spotted during code review, did not actually observe the reference count
leak.

Fixes: 151b89f6025a ("mlxsw: spectrum_router: Reuse work neighbor initialization in work scheduler")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

CC: Simon Horman <horms@kernel.org>

---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index a2033837182e..f4e9ecaeb104 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2858,6 +2858,11 @@ static int mlxsw_sp_router_schedule_work(struct net *net,
 	if (!net_work)
 		return NOTIFY_BAD;
 
+	/* Take a reference to ensure the neighbour won't be destructed until
+	 * we drop the reference in the work item.
+	 */
+	neigh_clone(n);
+
 	INIT_WORK(&net_work->work, cb);
 	net_work->mlxsw_sp = router->mlxsw_sp;
 	net_work->n = n;
@@ -2881,11 +2886,6 @@ static int mlxsw_sp_router_schedule_neigh_work(struct mlxsw_sp_router *router,
 	struct net *net;
 
 	net = neigh_parms_net(n->parms);
-
-	/* Take a reference to ensure the neighbour won't be destructed until we
-	 * drop the reference in delayed work.
-	 */
-	neigh_clone(n);
 	return mlxsw_sp_router_schedule_work(net, router, n,
 					     mlxsw_sp_router_neigh_event_work);
 }
-- 
2.51.1


