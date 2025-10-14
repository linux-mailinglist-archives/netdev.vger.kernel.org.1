Return-Path: <netdev+bounces-229350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C4BDAEA2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41B0D4F0E61
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753DC3002A6;
	Tue, 14 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P0/lh/Jp"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E430748E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465536; cv=fail; b=OovkfX4pcJHUGaHm+js8woPY5ew7XMbBp3Z7IsvokVIijj6QL6ZHBqNZ1GH/Uw6whYZg37yAWuAv84MhtafM4dEH/JnezdXXFUhDro0IGs80Xjt4V8R7FakRHDGuFuGGRAhdeatU2CR8eqgoetUyr/uVOwRG10ZimiwMAYCtvjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465536; c=relaxed/simple;
	bh=2WEmIQSRzBNjzDCRiw/sEwTINKLoocmsgR5y5RiwrFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD9+/HeXy4ZZfiisOc3B2PqXgqZk8OhNBzZwFGlUbegVeT4ibwQ2S1dppPeUDdb+7NKSMg7EJNNThAhcCXwCjiep3ZACU/9PribfYeedmjemHwIcE2Vqo6SAxPAtXIZd66lrPE0ZrVrpfxWFPnHnjutcDht3gUgfm1aD4JoOxJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P0/lh/Jp; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBCPt8YoRE7wCm8Q48+ZucR+FTlQiuKM03gv5khUxMw+KiRFbj980uL2YoL3MgNlioVysociVNsx37RpzZ7wVQuhhxdjuxGbt/FtBE8bmfe+DRc3ybFXzJ/73dE2auMGgFVd4bx9qr5O+oXfDwOF7O+I6TpOScl3YryEFQFAPA3yQmH18PCP4YcgRrXhFu0gQTBsVBYMMKAacyj1SHMlquNTA/HBm23hvz4wa7xdFKPhLenkmot11kStCIaGO7DUh0Gm3p8bt8RSIG3tUcNSq1SOGsPC9N6gZsztulucPAHMVU+wO+Xk8XnKW4EXcV/wDSf/baUyMOkaZ53srQ+2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0R0zgSWjE09c8bYcYZQHo3aUAYZ9FwmEBxnJJTCACE=;
 b=m9DjUDpaJcuabJUaA/Kv80npMS6Xp2apNfbN338iaadooYLlNsyXHz2JAB+WeYz/7RjTnr0wIh3YT98p6kL6Ym6/AH5CRd03Zc6J4sBlvwU8bgLZfWaqbf0B7fCEQw583y+mZz1Y7vBwoB+i7Gan3tMFUJkodoSc87/LwQwGVhEiLXc/WsXopHUJXkF4/9VwnAVjF2sxmTkB7gXMdANOUDHqnNUsetjM2AW4FYUWhpGYNUnFuoWSAXVyMgQ8PgeDkY6/fi+qiyUaxyt52bD00+Uxu327e7bn78PjiudcCy1XJqcqa69hac75ls3xTbdjk0nShQacL15Vth+iDevnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0R0zgSWjE09c8bYcYZQHo3aUAYZ9FwmEBxnJJTCACE=;
 b=P0/lh/JpOWXY9QjK2tB5Px/x7ebv10pZ+ggrdNhL2OegwHTtSzKryZ7xlyeyMN/ZgCa0hjj/QbqK/kHpFm6OLSqVH/mgItPR+wxHmwHrWdgt+2K6MftCLSmvDsf1GgcEtX5bQ6bsUiqAwvqluyVVRXrHTKaOImJHCCGwF3QMHKU=
Received: from SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 18:12:12 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::f4) by SN1PR12CA0065.outlook.office365.com
 (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 18:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 18:12:11 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 11:12:06 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 2/4] amd-xgbe: add ethtool phy selftest
Date: Tue, 14 Oct 2025 23:40:38 +0530
Message-ID: <20251014181040.2551144-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
References: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: fd83a317-8aad-4c78-fde7-08de0b4d324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bfgx2rKZYkw21YQDZ0rvt1hD224ijQ/nrqCh+l7dhrwc5MPyL0CHlzjS0DKM?=
 =?us-ascii?Q?y9G7B+PQ9mrbrnP3aB4div1vp3RKksYumvYVu5ZqIyPjTDLIQRp+8LeC4t6k?=
 =?us-ascii?Q?n0oj9hgwOPwy7bJ2kIlOM8k6q4s9c78vdBRORfI0u9s68ACe88AFKaW3w6+4?=
 =?us-ascii?Q?B8oT4lE60SX+mwjo37PVUPYu1bbD64y/PE5vSq/2SpxJL4RPjlDtk4hy7Xd4?=
 =?us-ascii?Q?YJW5bvSSrVoY8jiq4/BhhB4ItqwBFbEvuI4MJ8q7QKgnSu+GIL9fJz+t4oye?=
 =?us-ascii?Q?VdZ2a21FPc3GOd8lZtJ6NgC3P6fdHqTT4M0TqFVvMt7uN1xpZdmDi4HHxn7S?=
 =?us-ascii?Q?Fj0V/DLJy6wKFKMbz+bKtxHHkTa6kwtO48aL0PMLID6kHc1p1SxHgA2QtRM1?=
 =?us-ascii?Q?nb7VOn+ARdjwcenGhrUp4qnt1DGM1eDD7sJNOyhukkUWohM8+sJzzQ+Nd1F/?=
 =?us-ascii?Q?LuDhsReFj3sejNijx18lhwV3Vofo7PB4mfiCZfFRZJpKSRsO1kitChtthch/?=
 =?us-ascii?Q?DVFzFiivCK1ZYMI1pQwulktHaDe5/1/IrbOmDpbNQ3p1KnQSCaKcAx3Na72L?=
 =?us-ascii?Q?MdWDrvESM/t9xCZngkh+OR5nzhETIy1ck8q/GILRl+vpQdBBu5JTGZmJq8fo?=
 =?us-ascii?Q?pGCts2lqtnuXwhgCapbupfmhFiX/FH1aUvpWkUA0GtrvrMxWEx6X7BlJ7o6i?=
 =?us-ascii?Q?LEIX+1WDca2j0/uHes4cwyo8Qv7BIpQeYF1Pcv/PD3ACl+guXL90CJ4BoVda?=
 =?us-ascii?Q?BmAtpPsnNK0ipWclfGKQPjcze8VoAohYwiP0g0mlsYgdcCnWPuzLklAiPkZq?=
 =?us-ascii?Q?bGY/AilsuoYtESfQ93c/g2DR9p7BHIg9Z8M7sU8M0P5l4rD05x5R67w1uBf/?=
 =?us-ascii?Q?1Oa2PHm8Nmh4z3XbYzhcagTyBbYz3ddsuyDhwXLcw/3zAgHST1R/N+ZuE9ao?=
 =?us-ascii?Q?W81K47Brq/jxdVJTHBEDqPhED0XvRI6dyaM1fTvWdKcARSznkRJeV06uXqpO?=
 =?us-ascii?Q?sA+X4XoUdJrU8gPh8l2MlmXimxYQaYK7vxMl9+nQ1JTOgssfsm7Sq/NguK2R?=
 =?us-ascii?Q?ouw5wSXWOpqNh31sEM1nvDQdtcYVoKLV9cbw3fMqCSAjBmdCHAADEQ4PBP0h?=
 =?us-ascii?Q?idCIOVfNIv/J0wgVzvJXaK83hHyHIfz5nPbU1g3d7S0Y471MeUFfDjhd32vE?=
 =?us-ascii?Q?yfoS4HQk15vTLAUD4L2izaii1x6T/JMnZcLPJDolSEMhtgAHErgnlpjwX/SK?=
 =?us-ascii?Q?7ZJXrgCNSacsoEOngKPvgDfiNkyz2CgkHOCN7zRXlFvwx/PZfnGzmKjaLv3M?=
 =?us-ascii?Q?TscA1H26tRfCcUe/y2Zlwi2RSiuo7W23Tr/HRsG/wIIcKTJ6tiCqJ/QIHTOX?=
 =?us-ascii?Q?tMvOAOEEtkF1+oCTPr3nxGgMj6wjCzZwoRf3x+mkaGNQKMbzX13aRE4z4Cx8?=
 =?us-ascii?Q?7syKbdLsBHGyGudF8rBZI6FeJ31eekxkbXniee3RP1v0CWvwtX/L5KSZOinh?=
 =?us-ascii?Q?jG9hnM7Bg+mD5Lk3oRVk6pSO8vzMlk7F9Tuah/iPjKlG03aeJ+j/unpupD5D?=
 =?us-ascii?Q?/925/VwrbM2ZiswWpEU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:12:11.6903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd83a317-8aad-4c78-fde7-08de0b4d324d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

Adds support for ethtool PHY loopback selftest. It uses
genphy_loopback function, which use BMCR loopback bit to
enable or disable loopback.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index b8d1de07d570..927c7aed7e4a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -23,6 +23,7 @@
 
 #define XGBE_LOOPBACK_NONE	0
 #define XGBE_LOOPBACK_MAC	1
+#define XGBE_LOOPBACK_PHY	2
 
 struct xgbe_hdr {
 	__be32 version;
@@ -307,11 +308,36 @@ static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 	return __xgbe_test_loopback(pdata, &attr);
 }
 
+static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_pkt_attrs attr = {};
+	int ret;
+
+	if (!pdata->netdev->phydev) {
+		netdev_err(pdata->netdev, "phydev not found: cannot start PHY loopback test\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = phy_loopback(pdata->netdev->phydev, true, 0);
+	if (ret)
+		return ret;
+
+	attr.dst = pdata->netdev->dev_addr;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	phy_loopback(pdata->netdev->phydev, false, 0);
+	return ret;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback               ",
 		.lb = XGBE_LOOPBACK_MAC,
 		.fn = xgbe_test_mac_loopback,
+	}, {
+		.name = "PHY Loopback               ",
+		.lb = XGBE_LOOPBACK_NONE,
+		.fn = xgbe_test_phy_loopback,
 	},
 };
 
@@ -343,6 +369,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		ret = 0;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, true, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			ret = xgbe_config_mac_loopback(pdata, true);
 			break;
@@ -369,6 +402,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		buf[i] = ret;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, false, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			xgbe_config_mac_loopback(pdata, false);
 			break;
-- 
2.34.1


