Return-Path: <netdev+bounces-228472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83EBCBD27
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ECD19E4EAB
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044EA26B2DC;
	Fri, 10 Oct 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YVxHQqa7"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4F2AD16
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079132; cv=fail; b=l+2e3XGJaMAOf3vb9vK6xs1EX4gKabWH2u6xzlVisNSVlcNPZPz914d0cpWp2xHO7/G9kJ/YGVL1cienzNN0DLdxsLo3bZ7/rNhXbgSqvwPxvpwxmvFxWnwhDemiiT9peP2JwtH1GdznWSdjoMBeJAxdjO/HTp0ezMP0HsqO35E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079132; c=relaxed/simple;
	bh=MVUyKRp4jWVhiLO5mseWmPV446YcSnmly/3YkR2yIw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/zuT9FXwbx6oztJIhlo/ufnkBr5k8Rc48VzYmjmImBYDDikNQqBGVFi+jKDWQQusXwhwJN6JI4f9itq4acNvNyqC7K5tbsc6DKoV9Rm2IilUcQBdtULswdWh2aiHjpqsqriLVLprzMWqG/euBFbHlV6mwv2zTNtLvSAjeH4Fsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YVxHQqa7; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkLokhSDe2KDOquF0/a4+sT+v/HZekPAIR9i03HlB3m0J5PPHI3f5JRbrqBdQpT6kVx2WwXHIooVU7QpqYPOdizAEGse+DPzCPQ804cXDqVojdFLS70uAySsEkRfwlYA4RmHBuUtKgTCv3Vz8a1OK5fp6N9FGYkAj3o/VX2VrkTe6NZJqZu7GsrLg/6TKl9I6l61s0VGcD3B7/VjUROdFKJE8KnDSN5h7xTejCupHGbXIsF23NWDSBoXvGilEDRW2pIO9vtnfMvrOhD7+ZkdElfHaPW7zpzC2bGjzD8jMSDld+V3gWT2FBbd1QNronOp+2+/FFZxclldvo6DcECh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUvB8xUvbC9D64w+G4mHf99O1K+9n+FCergETs9IjEg=;
 b=ZAqr6xjpUExNS0TgNDvNjshtAXbXf7npEjvMbCOMbtcbgojpBUyUg81tAjjHgqGAAg3RsMqyo98icQGbrX83I0uMCUJPPnZCo3Jd1KvbAEkoZldg0714BubidUnMrdEhK7uy9VHkQeuHPBkeLqRmKJO/Rgr4WmWDjmUebyER4lOit8SR80Jjpgc6NIHXRDHMSKrp+Es/xwl9PTpSGtl6HB796WaQODD6lai0Hs4QvnbLBcby+5+tqGhs4LuEW0+Efom/1k/EBAcqaXgPg9XfuDo4I7yC6bpq+17Pv3lfOBQZ6PXaxisnIzx/SnSOGSdiOjgPlAh3GvYK3OGzMmQV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUvB8xUvbC9D64w+G4mHf99O1K+9n+FCergETs9IjEg=;
 b=YVxHQqa7LFvHU7KVSiwLfUiqkjmM9hSHBRo2XOSGPp2ct9aty/GHef8JQKmek+4Slbrj5OzAATj84amKtB0BQo93gPvoKRIuFDlWmHss7exiy7Cm7htw2bt+bPUcgEsIzhWPw6QW0FDMDvwFAVIjupZDaJzgrrzR8XfUYCXk2TQ=
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:52:01 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::e0) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 06:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 06:52:01 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 23:51:58 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <thomas.lendacky@amd.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: Avoid spurious link down messages during interface toggle
Date: Fri, 10 Oct 2025 12:21:42 +0530
Message-ID: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f50e2ef-6d9f-41f2-95cf-08de07c9839a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u27gASrsXv+xqTDIpg49jvGbcKozsHiUE8/US+L6/l14bdTkmgcoCeBRocDk?=
 =?us-ascii?Q?WMTxwopP8OyETud4RFwqEtc3L9Ws3QslHEJvp21NNzYRn4dsMxAgO+XYKovi?=
 =?us-ascii?Q?dI6BgixYiUiBQqfcq6wLkIaJZHnTOU8V3C8T8Qv77brfoHW0Peaf5x/5b1uw?=
 =?us-ascii?Q?7hNR6NceIBb6Sx+fOA+oU5+pHqAby8wwF2ff2thBfn1D4kMS6ElYXbt4XidS?=
 =?us-ascii?Q?YWpGlQ+lNqHBwdVSS+aLPByduuY3E8TqRigXkkKAqbhUgJ/6fFiRrLr5fYAj?=
 =?us-ascii?Q?QUEn77s+FSNDYGyiSJc4R3kRwPaREELuR9i7kSLeZl2vhAMGuy8mldVP9HJI?=
 =?us-ascii?Q?2ygJhJjhWT8pVi8/1V2Dp5tJIjG4kThnTmeTKaYwcO4DLaFBP80BYkGJV2C6?=
 =?us-ascii?Q?pzZ5FI5DONniQ4mk1KGq2vRExobHvtJ7KGJitMSm6x4B+819mZpr/FIOAlla?=
 =?us-ascii?Q?BoK4yqQlQuVgmCPTurNTQFy01sHSiflIzxgo9AQgL5E+Qo+8rENInxQktOEG?=
 =?us-ascii?Q?NzTczaU+US8NVXsCEB0y6dqTKhV6P576vy+pnKjb4JEYTGMaIBUYxjfFaEjY?=
 =?us-ascii?Q?DPslbmApikQBshqCMgq2PWj+qi8GcYxjfWoQQwdpShTzsVOOsPLdsvX31JCi?=
 =?us-ascii?Q?gxRvsTnRF5kMD9JonUy4DPVX+vVQkNosHTMh3ZkNjm7OZv58iNb7xUA1gBar?=
 =?us-ascii?Q?zU2JgbWtTUXkMzndWZVyEOtkDn6w9sQcZn6jHHx6tI4WR9RqgQkw/W1asmZl?=
 =?us-ascii?Q?2SykvqcPu6ALIbL0rfxdFqGLUTmAXqUHyveLLInp5c3pz82Lty0HswX2sBRz?=
 =?us-ascii?Q?C7L8fuXyhBbLJCOMovAQRonb8HzRJRP7qnQzaxfsVFHjFW95+VVAL+TV9t98?=
 =?us-ascii?Q?eIcSqk7Kl4ut56DpjfF6tE1wabf30YRS+n7Bvzn4xfTeqm3qzqTVhyla7vTd?=
 =?us-ascii?Q?2s3AFihIKOxrARoE0947Fk0NoBLsia91YUIexTIamW6VhwbOIdx1PcQuSEHg?=
 =?us-ascii?Q?nLcv4WJMQQbCmye+7zQyK57NDhD6MCvnS0MDIGrO9VrRH+DUbRRUs4/WWkPX?=
 =?us-ascii?Q?jB9iOj8KIFFq0yVTUnaD+srcQd0hOwoV8RJfpdTNLKMchozcC6RggVaKhB9R?=
 =?us-ascii?Q?uW3K9Ike1VxqElhiRTr9E2FtHXOsBA8aqpg/AMwhxRinoiGGAg3SCjzcL0C4?=
 =?us-ascii?Q?2HDyB5U1E5D0HCpFGGtxL6jchBrKNz3cdBqWYzMxgIe0i4SXCxIGCENiKr2V?=
 =?us-ascii?Q?RT+SiWH1wP0dX3NWRz9AEiBx57e+M1vUNG/DScjBo05qABEJOurHtEx4mawF?=
 =?us-ascii?Q?xUSIq8fxTMjMDboZYGZ8emxRfiGZ2jgIMzJ5i/jdJS2MHqAm6KOj30otNrNx?=
 =?us-ascii?Q?lBb3WJeEuXwjWCM2MWBlaK7GD/6LoWUS0D16ghV3c5kH0qH0TDyUGTp8Ey1e?=
 =?us-ascii?Q?1mENLksNnf8w6frdOko3au+E4uVjLFQAFk5jop/UzVNgQ7GyYbEhCp4HwPLJ?=
 =?us-ascii?Q?Jd91TcBxiiWjd7vCsY+GieqWIRmvGwEXS9TS/GjlfBO0+/b/6DKcXkgAN6Xc?=
 =?us-ascii?Q?0HMh4zZ6OWHx0huib3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:52:01.0527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f50e2ef-6d9f-41f2-95cf-08de07c9839a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

During interface toggle operations (ifdown/ifup), the driver currently
resets the local helper variable 'phy_link' to -1. This causes the link
state machine to incorrectly interpret the state as a link change event,
resulting in spurious "Link is down" messages being logged when the
interface is brought back up.

Preserve the phy_link state across interface toggles to avoid treating
the -1 sentinel value as a legitimate link state transition.

Fixes: 88131a812b16 ("amd-xgbe: Perform phy connect/disconnect at dev open/stop")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 1 -
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f0989aa01855..4dc631af7933 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1080,7 +1080,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
 
 static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 {
-	pdata->phy_link = -1;
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return pdata->phy_if.phy_reset(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 1a37ec45e650..7675bb98f029 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1555,6 +1555,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
 		pdata->phy.duplex = DUPLEX_FULL;
 	}
 
+	pdata->phy_link = 0;
 	pdata->phy.link = 0;
 
 	pdata->phy.pause_autoneg = pdata->pause_autoneg;
-- 
2.34.1


