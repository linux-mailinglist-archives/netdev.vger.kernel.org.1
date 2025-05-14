Return-Path: <netdev+bounces-190527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC99AB7613
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF7B1BA5DD7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631029291E;
	Wed, 14 May 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lnsq0rew"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57838DD8;
	Wed, 14 May 2025 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251782; cv=fail; b=KUj++zV55fay/oh/Skhmg/5vnb95OPxoA1XBXLrkvjhs+a9hU4/B8EaTxAt3GqI6T5C6UwEXSDV/FpZaFPSCgr5u3ZR5bOLu06LTkxIQEhf8wvF3g+UEowr2AWFCOnL04v9LbHdY7WLXLAlrbcM5CPK4MijZLwbS+XrJNgyXZto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251782; c=relaxed/simple;
	bh=CbCYoyuFO9+06UQw3/CK8ZgJOOKbRm82rVNcNN8tIu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mWDPh6VXA0hsbAe2OpW1C0zPXW7QCuctq4I496zTdl+kvNng4o+bDtMmavLrYkvoimANuXb8zmO/FHlta6OntaXj70BdbaHwHwjnQ102uR5CemX2QZy/AFDrSZ5+n2NQM8aP39dyOrKy+tB8rWLZyGVUcG+1rzfUNllah8fKIEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lnsq0rew; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCyGHMgEKN4v5hcZsqGIxiyVD0lVwiK2k6vIWi3I4RAfAMHS7NFbRa6+EbFfjn1H+TJxoJw52qnHDtmbPnEGLxrUawDkrAKOIAmnEgEQu1v3VV7sBetbmxi4xaDluobU3DnMDEg4ODAB+kXvdbS4nT9V6YcktG8zNrSN2Y8fIrFsaA0WTdyxWos15q62BacDV510HYF+181rw2p69JLU4X/3XAs1L5rgDvdequzNJpmAJOTxNoyuqRvVjnLemM4Z2yx00DlsF02RDA/OxTIrrsw07Kjl1gl/ncOsmr76ESmXtM9fbtW25eNyLqrejACCz2LhCmRNrTfXQ7ombcGw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVb/1p79YTz9Viewm0nFriTAUlrmo3uEyBEzFtOuZOc=;
 b=ayXEPhG9s6ebzmsg7KE383wyHCidg2dG5FaoTlWnrBHHbLuDYB4gLM23Mo/P1pWKNMLGO67wmtB6g+rYbk3GGrB85Ms9cLSN2q96eodA1WojQg9H4lu6vdVgkgeQ+jdQqJL3ZWEdTLyJarsy/OZi6yhntJDT/uVLrYi+hrD8narIfxjLtUiNeNxNawXD1GhKYshyVoSzFL7KR5+o1UNVE1dnal59zCdiXr6MCvCwNTFXh40GKXjEdMoNSZfbnrbmTgNROHCEg5AGLMKK70QbUjMl2P1K96CfYwQr8slnKOUmpkFJyStaDgU1tgFwR014IUEfeikCUL5raEjK1MGpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVb/1p79YTz9Viewm0nFriTAUlrmo3uEyBEzFtOuZOc=;
 b=Lnsq0rew43DOjwDlZ3WCK7Y04CfGfJiuf6ge2Lkj+bwAF4ESYZIWMi2xxnyRLW8wDv5BsDfGzS6Bigl0oc82EH0fq4t9XZ9EvQFH0nTP+gtPYFNl0T5L/2J38L7Z5cCmHT4ZTcqr8HkB19SWmW5DiA3UFoFPxVenLx6bZ7VKxKM=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 14 May
 2025 19:42:58 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a2) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Wed,
 14 May 2025 19:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 19:42:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 14:42:54 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: read link status twice to avoid inconsistencies
Date: Thu, 15 May 2025 01:11:45 +0530
Message-ID: <20250514194145.3681817-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 551d292c-3629-4284-ec0c-08dd931f86fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvzaFIXaTtQR171X4c2zHUa+yJ/pGPHXubMIjd96uXtMcR8kwngA11oTZfSJ?=
 =?us-ascii?Q?o3Cxh35h2NaoKykVdA0Phdg/V+S5pZM6edroAuJdni8MWshLEWvAZWjUWMpW?=
 =?us-ascii?Q?8Ve3DMg4hUN5VJdlu3HUxhFSnkEaMh0523QJf2JQMxlV6aCYhJPrjFX8UkNJ?=
 =?us-ascii?Q?4+968svonNzb3KS2lwNzw8Q+aQI3933bxBBnB+7TvLCId3xdyPXTj2fldqy1?=
 =?us-ascii?Q?q263MXGWYuXSIFEXXNMT2hDymgEHpXjIB+21F8hpPfEEHnRyhbFNwy9U/0Q6?=
 =?us-ascii?Q?uc2eKiMvE2r/1RBkBURogyyiEYBrtcsBhTvKB/yLUNlny79bBV9It2VrtQsR?=
 =?us-ascii?Q?ORe2jJcbNQKE5iXgfw5Og9So3X5XGmdr0TICV5XSOiPbuZx8tutm8urTjxSS?=
 =?us-ascii?Q?QcDAy7F7y4AE6jnkMy3a04uFvPRKXHpaSMbLfYomu1Y3pCnhO6LxVvBx27iY?=
 =?us-ascii?Q?XiWiiXsdKvVp+6Kb00BLWdjLGmZsVGnhxDVQU8Pd/rKBqAn6zftatpDWk2qZ?=
 =?us-ascii?Q?Qt5ljFK6/1bda4zC8QBnYfQZ0Gha9vdkZ6lAuPLzDkDuyPcyku8SDnGxqrv9?=
 =?us-ascii?Q?Me9/wacAGtZTPXYwoReyn4k9hyxdcSGby5hKaFw1r9+VL8IXq8IahS05yM1J?=
 =?us-ascii?Q?BzKVRtt/C5sLvktKhXqzztlyqzGXXFHHYGWOxI2AqEEWkccwggQGebIqPRne?=
 =?us-ascii?Q?kSB3oRcNzM2KdWh7utcPeoQ7onxMwJTwrYUutwCiezh3YRkjRmDm40N1v1Tw?=
 =?us-ascii?Q?8GXykyGt8lrmxV+gGzHdVYSh4ldMtmEeDVFKvLAK6PaUfNjSGbC8aNOiCndS?=
 =?us-ascii?Q?lFBbhg37VqQjyp6U5kWV74sGScXmet2QwH0KVOtcHCmlUMhxyGpvHcaqQIwY?=
 =?us-ascii?Q?p9ZRA/gq4/ZnAudlk13eGHo//QqZmwqgqz59KM9IZ5EXjrLtIxRDm3An5UQf?=
 =?us-ascii?Q?gqWNTKh/8bxTN5UQ4y8cw4JazuOZtgdhSrtQnShu89w//nPEsN5OeCeFnXLZ?=
 =?us-ascii?Q?az+zGoc9yyXXbOtS/xtTNb97eZWzAWJ6Miy/To93ztLYMcelwthAoLTaQXyP?=
 =?us-ascii?Q?YikK4GkvwjhaGz+fMq741xTyUITuHef8UPe25vrQO/9wmbAGwIyi7tCK2Izp?=
 =?us-ascii?Q?l0EYy5wnuAWaFMxsxix7p1vfJGc+ItFcEre7OaucDQ6DoedqAytjAaCdgZjm?=
 =?us-ascii?Q?RUDbj2SvD9/ZMPQzmUIkJVzhWCRwXutUnhoIKDObvTOraXbw6R//nFRAFTbv?=
 =?us-ascii?Q?Jlbw9Huah/w2nPNKeo6LiNJ9ZfGuEj/ZmxTv5dXDIzsj/KjWp0cDGSu/oc+i?=
 =?us-ascii?Q?gYI1GbXJPyrjDoPHB/O/yWOVgAGSsE5Ai9Pvo4Bc7Ac1AXSX636OI+LMlUJk?=
 =?us-ascii?Q?nloeeOvndmrTZEA4zssIL1AzWok27qi5Cf24EkqWD3hiJ9+4yLiX5Q7sxdW1?=
 =?us-ascii?Q?AFHr9+e2zEjVS4mG8TPpSzps8B/57Z595R8RfcyUZ563R12nLBJHuc6eSzEq?=
 =?us-ascii?Q?LXDSaLw0Ea7EtvLrFYtXm7ofdbTVEbOc5lnb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:42:57.3134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551d292c-3629-4284-ec0c-08dd931f86fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8

The link status is latched low, so read the register twice to get the
current status and avoid link inconsistencies.

As per IEEE 802.3 "Table 22-8 - Status register bit definitions"
1.2  Link Status  1 = link is up    0 = link is down    RO/LL

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 268399dfcf22..d233e3faa1a9 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2914,6 +2914,10 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 		}
 
 		/* check again for the link and adaptation status */
+		/* Link status is latched low, so read once to clear
+		 * and then read again to get current state
+		 */
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
 			return 1;
-- 
2.34.1


