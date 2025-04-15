Return-Path: <netdev+bounces-182757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0EA89D48
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5561900113
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50896296D0F;
	Tue, 15 Apr 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c90rL0B2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F52951DD
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719174; cv=fail; b=E3Ik5JC4xwSxujh4lC/HRx4fstp/gBfenTU/WPwOCf2VaG94KM6RxpSbGnTZJpjauQUU9BMkGd3BTt7qJoGGksZgXd9/PnjCMshU3s6iZoLzjPrx/Lg9yFj9Vlu9u6DD9krDm359/Fm/mJpQq6z7gXioRRhQvoYJ0RnO/4+H7f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719174; c=relaxed/simple;
	bh=k/WKYAzyzt1NWxbh41LTAo96wCuIVtXCOBFDkU7ENLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGgy1AYz2KMy2H9gFytn9+Mkef/N2DYWEYTpLdPaWIhu+0enXJei/VXo4lyk/v43rAG9MN2YF99muSMtahAdCSW1qqo85vveK0fGrxoWTYyEMD+bDaZ9w1oi6qc5hsNTzkzEk4GnweyqlGatnSnpfto50XeTJYLQsp7v9WqzeGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c90rL0B2; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbBbtkmSalwcAtSbyVEQ/tP0KgYOMKKS+1ZN3YxqkbCEsgKoOWAlfIEc8JOAMCD+ZbqwGOvyABBpLHFSnkahtJ6zn2KFghUcEXW4E772YVFWFP2YyiuaLUGXqH29MBcy9xv0Ey7v+yhAlvXiz5j/bE5FPYopwNBouR0mf5kNbNlU4qhX5Gn9zTSFjoIgZLVY3giKOvDTW9F5kT5cDFvay1pQkwnDL7KH683FpoY3HmbJrmxt9X+cMwrkZcs+VSQlnY02feYHUHpnudEMG2IrcLocyGEL+P1HkHhrH2GezeRc7TM1DV1fkuOhsEV7F6aWCj3doURqQ2Gct6jUBGsnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7KqHwUrXG6sQh4+PccvrFNn5GkLGJSNLo6CTJL0kSQ=;
 b=GWEbkD0GdfP01Vl+6KATj+dYHm45+/LY4MwDfAV75qDPl7SBJbasdBSi6EeYf0NEYzm0bdnDRJ/qU6HG4zbUU5TBKjbOnFVyXXg+ssIWqDWTyg9+0SgU7DMRlUtzsXGPHX5nDmfV2OMBlsqgZ7n55e17GMNp1J9Klsp8fkB4WKmjOPxPCztdSQjUxckjjsNCistOm6z2mL9VIMGbQBgbShXMxIvXCEZSS5q9byUDGdjrRIHjGu+Qk7PYeuVtQPtWFwQcGrQx3KilQ5q44BLNUWDvf9qNJHl/rhgEDmOls1+FCjDDX2D/AOlJSoh9+XwtLbXQZzOEIDlrNETvgpL/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7KqHwUrXG6sQh4+PccvrFNn5GkLGJSNLo6CTJL0kSQ=;
 b=c90rL0B2JSZVyGRDq40BPu5OsGAHdotzCMmlHJ/VLtd3VL9QgVuznoXI/rAbNXJBR6VM+wT6z5JFMsGFsK3KoL2b0MoXoY9Fpi4f7tP/VgPb3Q/bEV5+cENRxNl9FxoyrpTHv8ZY85gyrbDxSR/vwR5jYFmCFMVOxXWbabmX0hm9hoqnvND8sq0v6FAWtQTtnCHx5i4b8wH3xTLRCGhnoatE3U59pqkvomKUEhamQKf6/lohgwTYZwgebkRhVw89WDQEilIho0pG1lDMWIIZaBbbWb5psTKI0HpzG2mN8n5pgvSDrXem9wpyf5NZYm1FzRCxamz0yZCsAMw0HtMlMw==
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 12:12:46 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::b2) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:36 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:33 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 10/15] vxlan: Convert FDB flushing to RCU
Date: Tue, 15 Apr 2025 15:11:38 +0300
Message-ID: <20250415121143.345227-11-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a5699e-2633-40bd-4fff-08dd7c16d548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mejQ3IMRYLo6JufUgrrgwu1Rw+WsFJagzDJR+KQIFnUjUawktBd34BmiLorc?=
 =?us-ascii?Q?cTjyAIJNzDuABNRNJ3KniQ41yxqyHgL1gCisGJGZ/0NDQyXj1cvFM3Bec2ha?=
 =?us-ascii?Q?CSKAYZ7SyWKbtKW9SbqvJgLb1mXpuxFBjxF3tn3Kuqo0kWW9k3n1NWcl/sD3?=
 =?us-ascii?Q?J/jfmsXp75WJNMoqCQhnBV1Kq8TZeGJo8Qkzux7DKulO00aRKqsh8bE2Q0hX?=
 =?us-ascii?Q?reh1TCnEXCUJYC06gxGhpiKDAVGnFqYBO2Ij7sTyYqyaxV+5hk+hmoUhJkUk?=
 =?us-ascii?Q?BLWu5voyTCYQV3921vtvS0YgXBRHCNSP26mOoZ5ZMDRp5S3qFkW9VNsc448A?=
 =?us-ascii?Q?hxgkNxV+ZeygwnuVygmi0+f7UN9wBmQxB1ScuQcusHktnHubWv6xm81CGfgu?=
 =?us-ascii?Q?rW1TGGL5zVtj1r/4bU2WAkigEgt4TbX7tJn+4xKRSOXRL8X17IE300PvqD9e?=
 =?us-ascii?Q?z/hvkl8yXFRiCJljifaGZ9CzKKcyO/Mv1iuomZ049SIqaF5E7Hj+2qDKy+y8?=
 =?us-ascii?Q?1DWnET9cr/PLtUbWCHOy3dG62OBS6cjTVJ+LrcgQUtbcuvjrXUTy2ZYjV5Me?=
 =?us-ascii?Q?nNIqN6dc8w4vwSfropNZOp1xiABNTOMeX9e0QQ8yNrUt0ptd9/fasF32rz/j?=
 =?us-ascii?Q?ctQZLCBxOLgIoGTkgCbVtUFhBbjaOy+Tg98qpOXx9rx7h9gpTeMm8SKHZDi2?=
 =?us-ascii?Q?CXDb7gKdceb1i7zdKDFvgpReLTsXgG7GYher7/JCRMJC7s34bbtewarp0uOp?=
 =?us-ascii?Q?sLyp7ibg1NUXiVpnhnFUxB4SM7ZkY7w1Fqr6BY5o4shDVhmp+O3zIGUjyS3p?=
 =?us-ascii?Q?zqKDLKor81T0fA9foMqBRvyy7c3ePKSq1B2cnZ8OPKltsQ+8Lm+U4YxN+/nq?=
 =?us-ascii?Q?UvtXDT80JZuzoqIq9WWWAVyEUy0UlXibv+Qyy0gloh2A3HSS8cTEJ1fnaenm?=
 =?us-ascii?Q?QcRcZ5C2gi0cqqc/ugH6Apdb309wTlJPn4tZaZ8OzJIBPCPo9M5NlLVGSWHh?=
 =?us-ascii?Q?kxq1rh8o+SrRyTSTEihDxh+4xTG9529WJnHujJQJ46+CVj1zCNsoq40/fd4/?=
 =?us-ascii?Q?cBcdzePHERnodBCiqbEwI068k5B3hpZUaxqYcdEMGZYNeIwAYiU/iCLBTVtB?=
 =?us-ascii?Q?tOZBUfDu0tqi5xRhuVHRftAPeXn23MNTq+JK0pr7z5s7FKV3qdk0qc8hSflC?=
 =?us-ascii?Q?bLpZfNuF0QJnIW49cc82svBfpAIZJ8Bb9q63o4YBR+s9RYHF4c4jCCoBaj0T?=
 =?us-ascii?Q?BztE8pl+v0LHb7MkGUwTz6wWxKF/u3tYS9+VnwtlM2sSG20MAhdoeJ87lVZt?=
 =?us-ascii?Q?wk9rkXrDAGNu0HSDZRg1Lfu7dNi4fljHMZ2bId9y0zzhdeM4QerxxqYk852g?=
 =?us-ascii?Q?hPjxUAMFcIZAVSrdkgnVEP9QGKnqX4vx86IiReQVjsoaTEzCYdbD1xvSHYAA?=
 =?us-ascii?Q?vA8bkRvikwEg3aWOQqoVBudsW7h3wULTmQ2guBC1kDIjrFLdMxsg8ZT7+0Qd?=
 =?us-ascii?Q?PKt1OCAKcm2BQktK3/QJ/ZAwAhmUIPwy/8Z+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:46.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a5699e-2633-40bd-4fff-08dd7c16d548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

Instead of holding the FDB hash lock when traversing the FDB linked list
during flushing, use RCU and only acquire the lock for entries that need
to be flushed.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c3511a43ce99..762dde70d9e9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3037,14 +3037,17 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 			const struct vxlan_fdb_flush_desc *desc)
 {
 	bool match_remotes = vxlan_fdb_flush_should_match_remotes(desc);
-	struct hlist_node *n;
 	struct vxlan_fdb *f;
 
-	spin_lock_bh(&vxlan->hash_lock);
-	hlist_for_each_entry_safe(f, n, &vxlan->fdb_list, fdb_node) {
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		if (!vxlan_fdb_flush_matches(f, vxlan, desc))
 			continue;
 
+		spin_lock_bh(&vxlan->hash_lock);
+		if (hlist_unhashed(&f->fdb_node))
+			goto unlock;
+
 		if (match_remotes) {
 			bool destroy_fdb = false;
 
@@ -3052,12 +3055,14 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 						      &destroy_fdb);
 
 			if (!destroy_fdb)
-				continue;
+				goto unlock;
 		}
 
 		vxlan_fdb_destroy(vxlan, f, true, true);
+unlock:
+		spin_unlock_bh(&vxlan->hash_lock);
 	}
-	spin_unlock_bh(&vxlan->hash_lock);
+	rcu_read_unlock();
 }
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
-- 
2.49.0


