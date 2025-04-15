Return-Path: <netdev+bounces-182756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D0A89D46
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E76189FBF0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D277296D02;
	Tue, 15 Apr 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JI5wQWD6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4228A1DE
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719173; cv=fail; b=oamxFDWdmbbIA9aVmxg+cTs65xWmR64pFv4pFNbXMTEOcOgLjZMXksWIWgUsTgP9/89kPdbqdOjrygNpq1ZsH2NKtjoakzuCMRck0t9zyVSSYBkZPsmaEh+w9XPMtG7HcUzX36pImPI3J0dQ+0mbnBFSNJ7omJ0Vt991isS+bnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719173; c=relaxed/simple;
	bh=5UXBwdwmsDwlZg3coI+g4q3a7I6X0m22Rkw4D6wOuGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtF1xQI+0GovrdGmcN2QZitr3LSovpEAzOMTg+aZVl4sTobsld/k5xga9g9heLA0OpC7u2CG0k/G4+OZzldbvUH7hX9CNYI/ow2JWakkzp8ZQOhE1+be0KKJU3Ei3W81fiRHMEHjEvUb44WanD5qcaLeXogqYn/XsNQp+F24T8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JI5wQWD6; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFGgbRrgmF3Y0l/lgGoxVcg2U3uIoNigryBg8nZqEufLcBwrm5ATAa+V8YpfrHbIGbIJveKJBZhd4JdKSMC2vkP2HIJoc7VyTYdK/9Qbja/pfs6/qiZtEZIfvkpw+aKlSXoIiaYfBm7j8BWO+pyfxFn/9wwhmK7g5GwiE+Dn05jgRwid7ZqGkVdz68g8uyR1H9njOYuThkj891BYjUan+OZTLAIvDXWjrkMAMMuXTiPyXbcsplNz92ICPxQTGYmi/j+MO8djwkUXyntUzIZIxFT29QkTyHBL4HFAXOyYQrdHZba3BrnCY1a4ONzXTjJ9YwpwBRhIevNp6euwkM92ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB55FHG61yhUXYf+Q7G3ZwIRkv9ztQ0idfPEk+dRhVQ=;
 b=DdZmIP2TyJCZbP81dQePh5H18Y4/OQAGRaCi2MsJ5WExMZg7ec6mwh3IaeT3A5bXrnhkO+sJlNU5P5+BHrGvMyLve4A3AlvLbLYNBvRTwK1hdsnH+JXVsLv7McCBYJpSYhvsDSvD5tFzZO56SOVkxjIP+gVavuXS/UXM9nQe7+TWp4J0nxshv/hL9HsGSM/QVtTdoifO7DNWZ3vTz6JpoogMOHdywW1ScuHdS6NzuPbYuwsUsTqVBQIqFgARWy9Tk+WFwbe4gokfDwN9eawLHbbSFs6r87zVYPHubCrXaXkI8Dnu0FDoCDskh9wuFv4SEhqFP/ioGQQ7qzRFro3/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB55FHG61yhUXYf+Q7G3ZwIRkv9ztQ0idfPEk+dRhVQ=;
 b=JI5wQWD6Ej+r7/m7kAHCIoyBF0HM/KwODkqY1xwaT720PExZPtWc5L1DnrhCERzCs61IerI491hcgizzA92t1Nuzmf2Uga+e7WcJdnOaolCROqjCUnnCl4hH6dtPSQed1QO7XG2AKVDAK5aJL5LPvlUU1/GA2+/jdGR9r7iMukZ38Tk28u+Gi72EEvYcH2aCvbOWOyj/rbo494r0ZTn83YmUvHY/Wr4uCw+GvRAsNYmCtrooPOnw6Ofh6/tmVPkQRL58hm4hedWzuu6IK9v2FoTrIonBBZd53sDlumB0HpidcbhNg9ad6VtTXmBsv6tW5guGJj6Hl4hH5kYgDFwQ7Q==
Received: from BN9PR03CA0597.namprd03.prod.outlook.com (2603:10b6:408:10d::32)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 12:12:47 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::d0) by BN9PR03CA0597.outlook.office365.com
 (2603:10b6:408:10d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 12:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:33 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 09/15] vxlan: Convert FDB garbage collection to RCU
Date: Tue, 15 Apr 2025 15:11:37 +0300
Message-ID: <20250415121143.345227-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 434a2842-76cb-480c-9c9f-08dd7c16d5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fxFGK6fh9AtHa8S+KKQW1usKLf1hn0lSsCD1rJtYfKKgL6LzFtjiD3Ik0uly?=
 =?us-ascii?Q?5F667FwfE54DW3g8NolPqNv8yl6zS5X4Hu/Wdw9dqtO2ZJF0qIoxYuNslQb7?=
 =?us-ascii?Q?uSgQJjCYSRvW73RNe+CFNUdIy+WdT8aePEot86dvIUxAnBeYjGW5QiZ1hxxu?=
 =?us-ascii?Q?2CONMAGLX2Unb0o3sKHu53usfblkhfrE4tsVX10yWqQW2OsKWzOVaTvLnblz?=
 =?us-ascii?Q?oCg2jT7+yXrW61cgsjt4T/5k4ALdNSf6vc0BJ9TCFEMJlGfwRQK2Z12q/x6R?=
 =?us-ascii?Q?1R6J5X2tivTX4Mc9ogWJtO/pST8zMladziOyaMfaGwNKRxAZi2jjOTW4aun7?=
 =?us-ascii?Q?hr/PIuVOM3+lkSIDYG9UDiQbTazFN5dVeWoB6G1OSA8EYQvrIRXLXFv+09Na?=
 =?us-ascii?Q?H2rMosG7vEAGJlMcFeZ27XgE/MYtpOZb65n3Cvqwyumj/JYiD3cxA0Nnf+Zd?=
 =?us-ascii?Q?LZ4Sl24YAlcul5KwF4Nw4igaIn2H5dpsLqM2eSSsZvmhR4n1Io3DxBdjEP7a?=
 =?us-ascii?Q?W2JmV+AKiE/ZrbcFsU2/tlmyEebsvp2JAaGAAL5cj41/928wct5VK3r+XGez?=
 =?us-ascii?Q?kRPgDSrUvzMFxT8sUek3fO+g2KwUJ4Q4tNHlDH6SgnSdu33B6+yy1w36SHvQ?=
 =?us-ascii?Q?pEzkJ1hIeyEaPMX9GxS62nplNX6w9IU2KHEJxbZMDaE9f5GTcG2lEkzH4w8N?=
 =?us-ascii?Q?twAXAiMegIrDDq32Mlh8ifDFeQLnO8JvTlsmfs94SVl2sWWowFEiFLafCd/n?=
 =?us-ascii?Q?xVpemjVeSwf+zZ3eMMAgebKwYXPHoWV2zup4hEze3aiTCyZNXTgXt7oQ/aFa?=
 =?us-ascii?Q?FUITWRIzQBjy/j1xIAseyHuYJDhi4d4t0QchCTdVUA1/e30I42K0aKF9lGQx?=
 =?us-ascii?Q?+xAbvNTX477Oy9iYqxzHCBsIFL4zZ4iHOhu0WKw5A+fuOqjeKMWl3VV2bJKj?=
 =?us-ascii?Q?aV47zZCX7vnd++bXLkuyvCPlCVeR8GwabDktmh8L5+8ObT8huetsSNP/K4wr?=
 =?us-ascii?Q?AV+h/i7gYfycEXubKTnaxZvAXr1rPLWHVm6jE75fddXkNGfvbQQnA8aVgxBW?=
 =?us-ascii?Q?vELZBNe1R1j84gy7ubg47EqMVgaasIFlZHi4iw0oo/AluBu4f0+dnsnxYdEX?=
 =?us-ascii?Q?SutzwGKQiQH1+CtfYSgaEidXBW+5gJZgAXlY/TK1hVYlaGmMQeKtNK9UYM9Z?=
 =?us-ascii?Q?ewtlQfe79Ob3P+lPyVjBTH4/MR8x7N9hsS4MmzPnyvUmHechkZ4WQUn+7rpP?=
 =?us-ascii?Q?L+yyLjoLxXP5FXZkiIS5udww4dwj5LltQr6y607ymBm2pzYfwjiox3OvwSRv?=
 =?us-ascii?Q?lzZV8O3WEvs7MUeIMixBcAukELrUTmbFBMmOq+8yl9bUrnz+OVIDP2JEsTST?=
 =?us-ascii?Q?9biz3lJFPOdRGpNMRvE5aO0hDOn+ehesc5QiOfyto5SoVRtjX3EYNBTfdSrG?=
 =?us-ascii?Q?V/9qgaaWGwObUNyrDFJkHAM7XABUagiQGdjScSXhDp69JmL77cNhuWocy/zQ?=
 =?us-ascii?Q?Uao4dNvjIdtXdBSikW+GWgjnEOOYit91jmsV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:47.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a2842-76cb-480c-9c9f-08dd7c16d5e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127

Instead of holding the FDB hash lock when traversing the FDB linked list
during garbage collection, use RCU and only acquire the lock for entries
that need to be removed (aged out).

Avoid races by using hlist_unhashed() to check that the entry has not
been removed from the list by another thread.

Note that vxlan_fdb_destroy() uses hlist_del_init_rcu() to remove an
entry from the list which should cause list_unhashed() to return true.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f9840a4b6e44..c3511a43ce99 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2819,14 +2819,13 @@ static void vxlan_cleanup(struct timer_list *t)
 {
 	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
-	struct hlist_node *n;
 	struct vxlan_fdb *f;
 
 	if (!netif_running(vxlan->dev))
 		return;
 
-	spin_lock(&vxlan->hash_lock);
-	hlist_for_each_entry_safe(f, n, &vxlan->fdb_list, fdb_node) {
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		unsigned long timeout;
 
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
@@ -2837,15 +2836,19 @@ static void vxlan_cleanup(struct timer_list *t)
 
 		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
-			netdev_dbg(vxlan->dev, "garbage collect %pM\n",
-				   f->eth_addr);
-			f->state = NUD_STALE;
-			vxlan_fdb_destroy(vxlan, f, true, true);
+			spin_lock(&vxlan->hash_lock);
+			if (!hlist_unhashed(&f->fdb_node)) {
+				netdev_dbg(vxlan->dev, "garbage collect %pM\n",
+					   f->eth_addr);
+				f->state = NUD_STALE;
+				vxlan_fdb_destroy(vxlan, f, true, true);
+			}
+			spin_unlock(&vxlan->hash_lock);
 		} else if (time_before(timeout, next_timer)) {
 			next_timer = timeout;
 		}
 	}
-	spin_unlock(&vxlan->hash_lock);
+	rcu_read_unlock();
 
 	mod_timer(&vxlan->age_timer, next_timer);
 }
-- 
2.49.0


