Return-Path: <netdev+bounces-184564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6203A963A6
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2F3A2243
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA31EF37A;
	Tue, 22 Apr 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="CDiAeWH9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08661EFFAB;
	Tue, 22 Apr 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312804; cv=fail; b=VmB/Lfsgyg/m3XCbq2xtIXxbV5A1gPha9k8eJ7FnR15BlK+iiFkb/L9RvteIxo+0H8hyjSl7fvc2yzWylCj7TQEU15vYfpQA53wbzzeHVuesiUvbk/xnQesiUSZA5iVXuljWQRZcRE0GpC5IounRCcCzUlKNkHUurotwUShELgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312804; c=relaxed/simple;
	bh=DoMmLt05+dVQaGSQLDhFL6olUM9fU2ScDn4mSfIdfOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jhox0POXt9VJnByNDlS4V43MISLyrXfHaWE0uIEVORNH6VNM+T96sZZbVLwRJraYupsOhoRFt5bLYtdKVaDpcTWtfS0+fUbl21+1HVXGTSMV8+2zJc+wxNSjKFgCnrMJX/yLtP7vxOg5UuFQblR/ELIV3zbBiInFo6udfCNibBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=CDiAeWH9; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDCu5ZczMx2OltNrBWWif1yK0SbtkQTmiJy+eR78BTuLDLdn6dFfGVQ+BGuXD7zdY/eBXDDOKeN4fBjRt1S68BVydbIMisRxwPp0oqYH8PwBjrJtaqRoAY8mKTHC1sHFi9MahJTjut1e5nBaR6siOT/vaybkmC5qSbbTZsC24TpM4anV9NinHrF09HMIF6TdY3YBpD+OOrueUzotfVzIrVXusaLS8SxPPNsmMZdEhhVwpCLTC69gU9cIKcvVBUSFbzvTJjYjs1Q0tKp/dSYiuXHYVqubvbEf0V+L4e/OQwp/W/+eNVUuX+YEJVLk8rw3a5m/7jF8hi/bKM8HwuSUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrTKIOumvKP8HT8o1Xi8ttGxMYZBT78PsbScPtmIjY8=;
 b=Zy34FzwhPp3BhGZ0mBxDRYbtJ0jf7ITF8xC9jESKV43oy+xNgJYZLVHncbt2FBru6XqR8g9WuqpU4/8IcyPAIi7/PvlmaHqa+Rk1YNL1kteSAIYW1R+iEqQ3UIaDHddHqsFXHrhzlMlFD9prhtJf9qGfecr2Qbr2UfQ/mVzGqRqQJcKQAQkPS36iyNZ+v3wajTiI6l616P4GFrCvjiHUutmay4IN4fJW6YceE7lWU74xZMMt5dLVPNYsqlKkqALczyKe73Xp8DFB0vscsCOLefzGPwZJi84HVv06jpGgK998/Y27xtj9T9SCBONFqK/HvkrqrBmK2ZBK5gq5L0bn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrTKIOumvKP8HT8o1Xi8ttGxMYZBT78PsbScPtmIjY8=;
 b=CDiAeWH9+Ya56WdRPf1FxoBiQyPhsFkIvRGMdlrQ/zRfUm+YCXSVQO+lcSUp/hJplDjsvIgLuSp8VEZmXY9u6k6D0xmxmLYrceKM8uW9WkBbzol6GJ9MxWX9+leyQ+ZB3lgWItajWtvjbX4Hho7uLvy+n3boB9VXdhbC4u7UwKo=
Received: from AM6PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::40)
 by AM8PR06MB7556.eurprd06.prod.outlook.com (2603:10a6:20b:354::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 09:06:38 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:209:89:cafe::50) by AM6PR10CA0027.outlook.office365.com
 (2603:10a6:209:89::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 09:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 09:06:36 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 22 Apr 2025 11:06:36 +0200
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
To: dmurphy@ti.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	michael@walle.cc,
	netdev@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH net v2] net: dp83822: Fix OF_MDIO config check
Date: Tue, 22 Apr 2025 11:06:34 +0200
Message-Id: <20250422090634.4145880-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2025 09:06:36.0207 (UTC) FILETIME=[D9A48BF0:01DBB365]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|AM8PR06MB7556:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 97c50340-b0e3-4b70-7487-08dd817cfc61
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9npoyGPo/3hjz0XcANwZpcnjvFu/XwoAtrZRiW+EPLMuj9Umb1z2U/jZvoHf?=
 =?us-ascii?Q?jwcblg2zWQTuikQ6Spokd7xrqjRpiTZOdDobg/x80zoG24FjWBsh/Uyhgn6y?=
 =?us-ascii?Q?XZAF5MVpAL1RvlEeY4fKQEUk1DHARxugzxATFUJkI4rlLZr8S1aIjSIl5VB1?=
 =?us-ascii?Q?bLZyJ0fviyvB8TEjfVfMK0bmH8/ze1c7lLZSDIsnbT2SXmB4uVyNZcR8S1KI?=
 =?us-ascii?Q?0aXiDr7BBYgD8Bgtr0bmHPbhqiyogTupHxS0/xQHdku3TzKlXorSQbGUw4It?=
 =?us-ascii?Q?/gJw3vCSIhxowQZuvL/NaxH/g45JPhaxQ9/C1X6Ak8TNZz8tZjwFolkNXWAh?=
 =?us-ascii?Q?8GSczUj246FbckAOtPWaVh+hxZhI9vpxYrOmW/4G/BC8JRN1exzKee5JfHhk?=
 =?us-ascii?Q?RTAbWww4lr29KGgn2krpVodX6HddD5+wv5sj8kphBJ5BxnIgUX5xoURjCvba?=
 =?us-ascii?Q?r8Jh7/3AG0EvG8bxF2+eQewZbdcg/LA2M8nuupx0dkK9WZA5quONG7SDES0w?=
 =?us-ascii?Q?SkGG39R73LlsbaKbesjNl5XWekdtEtj+79ognLl4keNrlg6m5Xl+SLSJ8Taq?=
 =?us-ascii?Q?FT2ltRuGAxMbrQDUZQZBSoj4Wf8ecZ/tzdzilNRnxiN9k7G+Ezk5G8dzadOF?=
 =?us-ascii?Q?ZFruzEmux4vVsIL0FQ/MYrsg4CNQUmHEzrX4rwQxRovVSVhklTRLM36pmzhe?=
 =?us-ascii?Q?zub2vbNqczauCaXe8bVPYzcpDJQxkXPnD+4SUxzeelDR9M3CScf8fH6bhuR/?=
 =?us-ascii?Q?XZKbdzcQSZ8XdwzFbMPlJyOGQrJmRc0QXZbzZ0mTizppM5uZ02icbB+X+5W3?=
 =?us-ascii?Q?SuFNWKJ8V3FLGNtRwea7oeeyiKsV3FUx835SUGhy4x/UUjmk/sHdzvw+LPe3?=
 =?us-ascii?Q?c4WZXbwwSiJlMDM8cuRkCrn7ZzIC7ub1ItPOrMiRHMCFZM1L6BnLBE/MxoNk?=
 =?us-ascii?Q?oNHAwRYxmDcTLf4AYiN+AHEV1lYTCzioCRBryOKL4OHsjIIWsQXz/Kyr5QIh?=
 =?us-ascii?Q?Xfes/FwxxTMnTWo6ovl1+0dANGnfs44mqM00fmtmqqTpGpFqDzWQhMhX6Xi7?=
 =?us-ascii?Q?VJHsniIS/D2P2X8fdtqOuT3R/ybR4D4ev9nC3mtDNz+th3XYSkfymKTHYmW2?=
 =?us-ascii?Q?QIZMZsGEviw4o6dH713cCpoHi6FH8WlZFBvk/6igI2BCxXU1Z0IGtlcFDinv?=
 =?us-ascii?Q?deCmatHLfKQMRVrYn0ECKJdvZfL2vH3CHoTeHFq4mVBtMlrro6qnBCnDTpX6?=
 =?us-ascii?Q?x63/4KumREahw1qRsPNLUtgolXrAgSqsTC8PtU2QC0wc8s2BgzkK88d+bZJM?=
 =?us-ascii?Q?0+Qm2ooTO5Ye2nzZxW1T5Vp+/gZBMwbmP4Dc98iJEHE9sMSO2tOmgxGgxDKv?=
 =?us-ascii?Q?fVgwHscEc20ZQaFhJMjSbJpAfe5chE/3oebIDIu2ntibCx5VHad/Ukit01vc?=
 =?us-ascii?Q?y1luqfnn07+q2sOLfPXGJEWgRMBs0lH0F4mcZtqKZkmqTL/V9kDKH59v1/Ik?=
 =?us-ascii?Q?TMAlYUJjAqU60EMk9Hzv/Ghc9HJqE9JMoeA0?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:06:36.5713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c50340-b0e3-4b70-7487-08dd817cfc61
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7556

When CONFIG_OF_MDIO is set to be a module the code block is not
compiled. Use the IS_ENABLED macro that checks for both built in as
well as module.

Fixes: 5dc39fd ("net: phy: DP83822: Add ability to advertise Fiber connection")
Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 drivers/net/phy/dp83822.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 14f361549638..e32013eb0186 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -730,7 +730,7 @@ static int dp83822_phy_reset(struct phy_device *phydev)
 	return phydev->drv->config_init(phydev);
 }
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 static const u32 tx_amplitude_100base_tx_gain[] = {
 	80, 82, 83, 85, 87, 88, 90, 92,
 	93, 95, 97, 98, 100, 102, 103, 105,
-- 
2.34.1


