Return-Path: <netdev+bounces-184976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B686CA97DEB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B5A17C20D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348AF264FBA;
	Wed, 23 Apr 2025 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="gUL3XrCX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27645262FCD;
	Wed, 23 Apr 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745383659; cv=fail; b=RzpHc3ECekzZZUWLY1LhRrjyK+pflGgeFAdWuA6h6JhR2t/bTRx2OU/uic4cBEscvZmsrkY0s14d6Jga1JUpxMZD+oBC6QHwduo6PFURixyF8w++O5dq4++78FFjg9kqbtm6ocALjUN0qsyV2uLiQTTC2jrcsOYSNr4ytD70w5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745383659; c=relaxed/simple;
	bh=bGpVAdw3lTy/sdZuonzzLi5GuA2hpCeN6fLI6sewHwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=otF8vqyDWP3ibP90VeuQ6+3UCBFeRy3RHhWo73dJFKFAFFjdR5VYNIxezhKk7N8tC/P14hRjamRQ3GJL3peRisC9t/XviQ/Rfqmzrv9LHYnr5V5kXTCX1sO9pEmMzPnGH4bpgTwlkDV9b7LvTN+HJ9m8LXBExF0TbtgoQNsM7iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=gUL3XrCX; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NALQEyQwbM184xCLe7pYbYQqJORHeukNLPng9DNRUZ+PZa/EcemjId1lKnR8U1stJJ15ANTObRwvED28QeafSHuUztCQNQAO6c+/iIr7AKqV5/ssiC0el5ogsbkNf2csYJzB0KJWsI9b6i7BryW0Jmc18TzhTiqhAIYkGqNQumz7M5L3gnZFn15AOyA+NW9aD5PmhUgjBidVjRThqITUPNRMY4mLl0wS/m9VNkpWFr9qbpvjhDlfODOxog5qixOISG5gQmJwoAOHg+fO8vCsI5X1AU+EP1tvfyxxMXyD/Jz4v4NmA70OgZKFzbfvjNyXqgVEwghhk0bNR0RVw55vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fEJlMMXhFIQhsHTjm+cmLsV/PPz7J/PvTIYEFlCAqo=;
 b=d0DRFMFx03Ypv37uduIxFw+pB9hgIMV6DyWWfaEQeGCz4dwuXrE40U3SpV6Bbzlddcl+JWLe4DfuETenNOc1uRmHynmDsmpBlvwkmvdP7eoTdJ+YfQVrDJjU6q7J3T+eMi8lXva61lbwuRhg9V6GTsjapTZ7KBnzcpx37op4NihpXEStfMbBp94lFD0UB4fg+NLCRlqDmwxz8OlovnFYwGJLsvdjmB2jy3Pg9OiCWu4pSM4sG8SS5sHmf4He1rVNiJ+DdHdloRg1R4P6pcM3YgYbWXjD68G+Uz7dih9g0wlszVQWTIFLQWEKUHcjK3UZNQWrLOh7cw4mBObJVPh7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fEJlMMXhFIQhsHTjm+cmLsV/PPz7J/PvTIYEFlCAqo=;
 b=gUL3XrCXa7Atj1IdmFSnt1gxNsd/53n13HgoEXiGKZXYo9BsJgU7+ceW8RwPdQ6Jar2eYVRC5SOyW8VXetonTGVBZVIOwww6cjyE36Q9SSHbP23u/gN5RSbe1aQlYYPQA49RgLu8v3pFwTfsAd4xlbv2a/WivTOSRp2axD2Al2k=
Received: from DU2P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::6) by
 AS5PR06MB9037.eurprd06.prod.outlook.com (2603:10a6:20b:67d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.36; Wed, 23 Apr 2025 04:47:33 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::cc) by DU2P251CA0011.outlook.office365.com
 (2603:10a6:10:230::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 04:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 04:47:33 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 23 Apr 2025 06:47:33 +0200
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
Subject: [PATCH net v3] net: dp83822: Fix OF_MDIO config check
Date: Wed, 23 Apr 2025 06:47:24 +0200
Message-Id: <20250423044724.1284492-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Apr 2025 04:47:33.0116 (UTC) FILETIME=[D3A6D3C0:01DBB40A]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|AS5PR06MB9037:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf679758-ad2f-4247-0ca0-08dd8221f659
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oR8ho/KIzm3SeISKgjvF+M364Ef5I1rCY6ROABvhDm1FiLiV6z6meTSsUupt?=
 =?us-ascii?Q?XcioB/8Bfv1ggl0oUZwmvMMxEtKk4hdMrIZqdh04e6at18iyuLsVJK/RAkzJ?=
 =?us-ascii?Q?m07/10PFJ+5hrLCjtzb3Kskop1AoF7CbDHxTl/qz0uCU+tgd2xImyP8l+gOm?=
 =?us-ascii?Q?8CvoOBaaLWWWIMY2T+7VU2A5sEzvaNcXcjtJr/YBs+1kYyTYcd0xhjI473un?=
 =?us-ascii?Q?gQwijsaPkE1IDfgdyDk8me15Aw9ES4XD7RVi5G06aLT4cM+U6k3c+OyN2nlL?=
 =?us-ascii?Q?s2S5iHWW+QeEvMrrjW6OC3Fw3UpB6Ut7vzGpZ8wr1cv3H66CjVDNhEzPn5wy?=
 =?us-ascii?Q?rI+J6V+9GZ2FL9mG7ba63Oe7Rfmrnxv0/pJ4wgUMiDS/lb1CVvOJz6B3v2z9?=
 =?us-ascii?Q?Hh+TpOQmLXad8RPvFrlrUprHXB+EUXJa9TtbKPBnBxv7l74LmKysUJGIYtNs?=
 =?us-ascii?Q?WcCR2nLy76jMvS267ujwjxByQCQg0eQ6sNT3QYG/loqVf+hVvTOlT3VYHqKQ?=
 =?us-ascii?Q?4SHhwuOlHntI0kuEQJWw5TehzcXwAEmZrKrl+5EDJVJ1T/I383CY/pM/8vx5?=
 =?us-ascii?Q?LFt4Z54x99e6UGSSVGmFQ+6D13SIa3Iu5QuF8j6WGzZ4vBIJ2w78cst5E7/0?=
 =?us-ascii?Q?jyVw3Qlh+Gk5x6HIkyCP9kM3xvUM5gXN3pNXsbhqSlLyBA6IFH0DevCC4xU9?=
 =?us-ascii?Q?4ZqqFE61SqkWTeHU9+HoF5RC9lKvfFYVylsgyezdmsNBvu20+I67tW5+o7nl?=
 =?us-ascii?Q?+Y9XCtAcPvsonCSUClL9jqFjlspkYFJA3hn3HKDoei3b7NwgVKfWRY77APUl?=
 =?us-ascii?Q?RcTX16xiK/bobxBRXImtFkB3KgjKkFeEDGK7JFMysQNuJ5Dvn+Me9ab4yhk0?=
 =?us-ascii?Q?8ztPi1ELYavoyfFiIEPKPgF5gNEYGdcLfLiA+hPXytWsH3UoKVQQHVB09LKv?=
 =?us-ascii?Q?zJ6lYypEwLoSaV0UM10Yg4H3WccdFWEWA4AD1Mzre1OtRc/CGk01UgAu+Hk7?=
 =?us-ascii?Q?2QO1Lg8iuYGnRVbJt1rOl10JwS4LY7szP+ZhZnTSUDHzbwuv1NwuJaeFu3kz?=
 =?us-ascii?Q?RLlObokGmPVDIFANsAbr84bbrP56CBlZXfs1TATu22J4p2Bix/BSRWWOQ0Hn?=
 =?us-ascii?Q?Q2PF2ruqrINQ4OQ7Ug4s4GNGeZ59Ky0CzuBGM6cuNfyBaV4VRl9E6FoyNEZl?=
 =?us-ascii?Q?JHcCRwwVP4d+VNGBBjjfpC+5aNspUb49Sh/7YW1J6Tv5iCCY0rz+21ge7tXc?=
 =?us-ascii?Q?a1LV6bUtOGVt/cjXpfrwqve876yKuZr3njLqiALvt8lJSPwjTyyIobBatcvk?=
 =?us-ascii?Q?WXSzAiB5FlgNfzmv/OUELk+18dz0sCKS2EO1PxDc6Arcy5l/22fgJN0LXHU+?=
 =?us-ascii?Q?1wxNtwOvTZRVHg7GfsNxaPVXX27mJROg2lrKCcXLBfTnDn2Xg+Yodppk2V8e?=
 =?us-ascii?Q?tfOUf0TQ488dX9KUebVLThFuD8HcSY2Zy7FmSskV/6Xt+BmFxmIQU5uct6gP?=
 =?us-ascii?Q?I44ugmUN9stoBS3UfHRyM75K7OyoCUqKp2ZL?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 04:47:33.3710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf679758-ad2f-4247-0ca0-08dd8221f659
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB9037

When CONFIG_OF_MDIO is set to be a module the code block is not
compiled. Use the IS_ENABLED macro that checks for both built in as
well as module.

Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")
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

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.34.1


