Return-Path: <netdev+bounces-220726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1CBB48619
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CD63B4AA9
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E02E7BBB;
	Mon,  8 Sep 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFyZIm/F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF027B328
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318012; cv=fail; b=QhZAn70DkZWqyJGbeHFHUtagjlP4dmFDxa3BNEIOZPWx48x1YBhi7/WMa61qmy+qxz3oV5TIY5RrLjYe5wTWk9q79XGsTHHLge7PUfldDxMy8+ee/7kQlog4z3oT2VUZPBggkAXm5mcEVtGF5btIQutgflzc0Gmu+emO3FgYCtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318012; c=relaxed/simple;
	bh=EQDQuWbyr6EuoPQ6jPru5vauNi85uJt+/CWoShnOnWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sEYerB85GQGdk/JiZ4rApwI68VGalsxFss/neyfghf/Onip9VEeYymmdYLQDgfG17jDA4rGlTJQ8O1jY5zhY57LkmyckKTVKdDtC1uheqNLw4iuBq9jHSEfcHFC9pRKbowYRB5xkvokW7ww3LPQCl0XhDyTzAyJ2eroFM9jTRb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kFyZIm/F; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ekz5yuRrz/8FIH3teykPm90rQvbjcdtq3yki9kWhjrgvoeu8LZ7iXgfFfUvpG4c0OOmUA1I1rxnf/Qo0hM6XySGnJAhBfREsG5I346LXQcmNjDQysARAn6gYSUC82RbCizQyAsKCDMbaBVk7fPVb6lN/huFrR7An26kfu2Zb8ooI3PN4XnER4shYO3MsBTqsmxY5CPjv1j0UV1iSzao2q1Geeq4PI77zMZnq1gzt/tBa4/mXjJ8pzieLSJECI7YUV6a2lDM241399dtn/+v7VgVY5Hv1QGaG1vnKoO10s47zm3vRjbVGqIDOs+fZHhaX5Xxkhe4wAHlM9IsJGR6t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pzMvZrDuaBh4pS8p+BbHIv4hDsMIKwxwq5+55nTReo=;
 b=QbTzwDf7JptUAD6K2AwHOxKNDWI/Xx96V0SXq/7jZ6Vp5rDXs3kcFWhBsWdJb1cY5g3kB0IJ0uHiqtwrd0qU+DJtw50/Okc1NJQss62dXl1+swXf8QdWvazcli08ub6yZ47+bnIUZY3FablNBJHlb1uwH7ftMvejZ+Pj40ecTZz0SSatAQUdrQ5zQOtn0/FHwNtO9gOxPaUACQjvOInRksgQu5pl0jNDWAbTLLgKeT8brKj71yPTCaiWtR7eOjuK0P7J9PJIesrgPuPWWiuNSIdgkzJLEOmXPc1+p5NJijtWQHj1FvBUFveq5BHhsv9DfxvAsvYFa452kAsn9vrR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pzMvZrDuaBh4pS8p+BbHIv4hDsMIKwxwq5+55nTReo=;
 b=kFyZIm/FIzz+4hpw5Ob5PRd1MMZvkbzKCBaiPQ/aQdx9q03AyA9Sy+5LGp6Q34Y2rEu0VU6rFVpY2vVNM+5Q7yfYSsha1xdR8Yjg3rH/MUrBek7AXBLI/z8HVtUiMPsei0y79QHtcWCvCZ9eqr5By0ULCC4JoMceQ0r+lwPQoD7f2UL2FA6UhZK1+pf7xBlWJUJjw1u+VcFzg+a0c7npsluL5Z7hiGGZsmZv/BPl1S8+LzD/zuyH9EFqsJl3hnV3koXCrOOu0QW9ZW14+uq45YmRgKee1nB1hIfvQ/0DMMldSua8kimpZb7OR1+AsW87srh+Ei/u2qWdWNRuQ9g2Nw==
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:53:27 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::8b) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:53:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:53:05 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:53:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] vxlan: Make vxlan_fdb_find_uc() more robust against NPDs
Date: Mon, 8 Sep 2025 10:51:41 +0300
Message-ID: <20250908075141.125087-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 20300c44-52a6-41b9-28f7-08ddeeaccba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vXZmS83rLIO8J9G1XmsXLCEQRjjlJsVGZu9+z617StyvHtq5QNJIjXO7N13?=
 =?us-ascii?Q?oVaWglVOKpI+zJXYUQ2evFn/hAZ2sUTurNns9vHlQwS1vYpTrXNQH37B3Qn8?=
 =?us-ascii?Q?94uRGyyUFVGC8ZU94HyTeAZtEF/nSdZw6VRHlPB5nDv6XMaL7vcxVfI8BdYU?=
 =?us-ascii?Q?Nd+282kgvm7fdL5fYGqBNbEBvKOGMssbL8/mx01O1d9VEa+YPOj1CBAhqxCr?=
 =?us-ascii?Q?f322tGSQXrfjiFLDRunUvlogQasrfyVEUH2RSAtOjYIqkki8VDKyV++rt8pD?=
 =?us-ascii?Q?TEwZMvOXG0ifzzqhW1tFCesbtJacZqnRlopcfmsVJjmlTsvU5Zaa+upAS1cx?=
 =?us-ascii?Q?sTRca+6GcKz6PMYxEgwC9BrWDr53A4pqrYc9Adp4zH9pBZ/utoGr4J8/bX1+?=
 =?us-ascii?Q?B7k8CeA7EWvs8yN7v/SvgICcnFCsDIR1w/QdN+72hvXvsnux6IU5UkssmlfF?=
 =?us-ascii?Q?AHm8f4HGmDdh2swt+Y3eq0/ZnlUIvpfxcTRKzlTd/svjhUYh/EFAIbw9BKmt?=
 =?us-ascii?Q?JAFcB2ON5iezc+A+rt5+igwqA744ax838PTuPLWb/AwEakFfwzWDz037LHKa?=
 =?us-ascii?Q?+Ip6GqrqCMb903vb3t14e1qGjkMWune+6+yQ94atT8Lzgz0U3Uzf9QWllqwv?=
 =?us-ascii?Q?NUxgpWZW+kePtVyTRq6ixDvcOEJ2DRN7P+wKSCS//ZYMr5eqbyf+M/+o6om1?=
 =?us-ascii?Q?bjcLJ6iSX5MWbRC7n407lZ6TH5YuYHNnQ/lgGWSmowfq9BPgfYv5FkOLx9SR?=
 =?us-ascii?Q?9A1a1XSiEJhFVerBF3rhRy3Qj7r1/9AcIWOOderZGOTzmZ2in9J77VPdJPSe?=
 =?us-ascii?Q?ozoCWUnrfy8Nul2b4g07xk5bVi8cuuLzAaZk8zW382XYuwqaJsbBElmUOWAa?=
 =?us-ascii?Q?JINlgGgkGuDS0udUa5OtQZufRKRFqNhpHLqKIm5sNPOQ847yDGepDNT56SVq?=
 =?us-ascii?Q?jL/uLerX3RC+OnQ0+xzkmMVMfU2EfeLRRVpKjoQA4QvKNcaO9UKuw4qj1YtJ?=
 =?us-ascii?Q?zTLCOlaHYXQF8xYjTwrx75AyJzl4vb89s+zI3+h5RteAUYZuZWVPAC2ADkMj?=
 =?us-ascii?Q?N52uhRyZ3BBfoClQskjP3FzGAtM+prkGRil9MVWeWPVrvpZdpezvGYjIKlc0?=
 =?us-ascii?Q?qlr8HzVaUTc1CBxBoId4VxIVMhAMtjIqvEKl+JSflv/Fh5a21Uz1C7EuChvA?=
 =?us-ascii?Q?ROHtHfqXAuAobxUmCLFixHtrmqIzbfxNZPWJLstbaYpVXjW1yvB5kwLYmbVS?=
 =?us-ascii?Q?D0t2w/PheXeckIqUPnosRHABRYwnUhGG3I5c+MwD3Af7zLzY+hXTVleysJ9U?=
 =?us-ascii?Q?HCH5MryAIfS6BGBGwhFMiEjW5OKC14l05ERIxZoi70kHN3+3G7L1zG30udYD?=
 =?us-ascii?Q?hWi+jgUwHfLIyBU9g5mf9SLtjm78Du1TM4D3BQ0RLDUEFmwsucdKD9wOureJ?=
 =?us-ascii?Q?egPXltpsCfUYt7blYNra4ZnRyhqzdReWB4Sk9Io6Jw0vVk9+7/V0Pf6TM18c?=
 =?us-ascii?Q?f731QeFeiwPR54tNq6g9yhfMkrrsPeTZOVET?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:53:27.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20300c44-52a6-41b9-28f7-08ddeeaccba4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132

first_remote_rcu() can return NULL if the FDB entry points to an FDB
nexthop group instead of a remote destination. However, unlike other
users of first_remote_rcu(), NPD cannot currently happen in
vxlan_fdb_find_uc() as it is only invoked by one driver which vetoes the
creation of FDB nexthops.

Make the function more robust by making sure the remote destination is
only dereferenced if it is not NULL.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index dab864bc733c..a5c55e7e4d79 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -446,7 +446,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	u8 eth_addr[ETH_ALEN + 2] = { 0 };
-	struct vxlan_rdst *rdst;
+	struct vxlan_rdst *rdst = NULL;
 	struct vxlan_fdb *f;
 	int rc = 0;
 
@@ -459,12 +459,13 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 	rcu_read_lock();
 
 	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
-	if (!f) {
+	if (f)
+		rdst = first_remote_rcu(f);
+	if (!rdst) {
 		rc = -ENOENT;
 		goto out;
 	}
 
-	rdst = first_remote_rcu(f);
 	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
 
 out:
-- 
2.51.0


