Return-Path: <netdev+bounces-201024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47208AE7E3C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB711188F37D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF429C32C;
	Wed, 25 Jun 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JdcJsCif"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B629AB0F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845234; cv=fail; b=Nl+RV3sdLiGnDkdzB7Yz3Z0HGY5VcjP+ZDr3PQcwMm1jujOwKLSt7IFKAx49YHIcmQmSRoenz+zC4GSJ9Z4DYrMxWn7RKhQxISW2qBXjbxua4/LEyDWn7mskJR0mjnFMzICUbZWs2c2FUKUaB4Pb7ceXSjqNcYC5QXCzB2Ce78Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845234; c=relaxed/simple;
	bh=zzStTOU7/Qq7znFwhicyhCwYZgMp9RVM+9Ey7ZktkDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IcvnEcHRKQktVkrl22xpW/VDloRhuatX5eLwPUilmCPzWWu4kbGvdE8aW4fxNQ3AJ91JqCyNIiFKAB27F3RFwnMK57lZBKvBKzK6lyFz3AVT2RKpCGmeYSegylfRWR7wWuIpoOBOtlAWX0n+EwV9poOZZTvqWpk7tk0eEyeRng0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JdcJsCif; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGH6OzUc2ryxwcAECYAExds21igpXcgW40Bk+GYZkPvMsF7WhU8KymvGN7P0LJb9gswQmjKsZC6TPqV2SirRImu4LvPPaGeLtWSiXbQcrTIyuBLSl02AkS6zsu3K8xRE18qxY/6/4d7yXrHncPOGxqYxuyy+aLDI8XJoZCo8TYwqdQi06YMI4+PNOlVCSx+c+io0jST9zhCXPLEEUIuXhip4qk6r6dgRZZDxg24rKnn9YioxTBJfRxyFEjCyB4lEwdnavtzaBfvK5BybGZ1YGW6QJPByQCPi4veoLehSs1omvqzB6toWQ0bQ/lLrSp2QnFLWJLq2yebDCW5095tv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL/mtdrQKsDqYLw+Q5m1N9esHqZwCCGru+SYwiajJok=;
 b=iBiQ3fFDHpqL2P44Bxgov343aRDHP4p3g9qUrXV4qrhgiTvtH2h7MoFYFSRWh06VlbMILy2idASqFRlpMUZgqOm/3zh2Es9Smgm0o04qbXPYD0A9BD/pGe2qgsEqlt/GuNuRJc6cu6hoN9MpFNLj4FZf3oHK6eZVkBSIgJ7/fl2Pe94bZ13HK+YdyqUhtxDyi8/FViEXTS8tzYwxEbgBY8CU2tByIecVpQKWrrVc6hX8Gzyz+PS6eBxB/h6OLNkH4qT8uLZwU4qvZkckmbUXQ0+GW/E0gUcd7sni9W1M65sZXsEXmFYnsL2/PFutbpQtYVJ/lrN5JbsxvLx73XMUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL/mtdrQKsDqYLw+Q5m1N9esHqZwCCGru+SYwiajJok=;
 b=JdcJsCifriU+vGH9xotrKvAB/Ez6WsPN7eh7Urto0bxKK+2TxcpKcA66Rfp4o/5eyECZfudNNFEsNlQhQvPRJdmSpDKhS/mlkIM84jTMUE3I5MQx5GNprA7kN2IxIHzjwIeHPeASZSExBkQUkkILSeLzc6l23bnMqyO/RVc11Nc=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 09:53:47 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::19) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Wed,
 25 Jun 2025 09:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 09:53:46 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 04:53:43 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net v2] amd-xgbe: do not double read link status
Date: Wed, 25 Jun 2025 15:23:15 +0530
Message-ID: <20250625095315.232566-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abc3e4e-d1aa-4e10-551e-08ddb3ce2d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTWTtms6aAxo3np3XmDpPTpxNibihmiFlZVaoVD+KlOxCNR8XDLeHZ8/Uzvv?=
 =?us-ascii?Q?ah2gnHufAaJCINPEU3M4jk9gguquC+O7UXvNGr4jugOiUw6PSGcLbI4J1crK?=
 =?us-ascii?Q?CfohMUt6bdJbWjtHhlT+XpQHMGTJIt7Y04RMzgx/lTMd38NW7Gc0QACQXSA2?=
 =?us-ascii?Q?XvjGF2PjxDWesEmEMKO8OBAZFcGg73tHNy+yFs7vS4pPwRzvr6fPlxNsfjTC?=
 =?us-ascii?Q?UOXTc31zkJMCSLwk/rD2fidD65etNjAJInuqUZJ0JjNJz4zO0MxmTxBuRynh?=
 =?us-ascii?Q?1ObdGlekWxspOD+iBvwyzkb0BTbohiAdfuRZ+fPZ6ZAxTcWfQZArdSg4q6F0?=
 =?us-ascii?Q?pIh/Y2Xiu6blEsW7nXTkA6XutzUT/YEUS5QEHm6XR6ih48lwA1pu3J4KBElM?=
 =?us-ascii?Q?mTcAFnJzJ1EPgB/QfG9TQo8x0S3daOzoiPxPa56nTxdHZSCC6kkrQtWNjplx?=
 =?us-ascii?Q?Wh/VlZ8w0hs9/L/8BF2p4xin2/6le1Pll0UfwBySz1RVByF0zAxTvPSHAoy8?=
 =?us-ascii?Q?dYQl56w2qJWlfX03jSGlJZ7TY+e8M3IBV4ikP/ivJvA2eMyXemohE4HoY/yA?=
 =?us-ascii?Q?u0fIXtSdbHYtVtj9ZMUQxrnSa0gpxpzcTAHyMAk2SICxlyYEAvawjdt8ChIS?=
 =?us-ascii?Q?PW8GZZYi5Qg4HRWxd2+y0BDnvRLBK44Hbq55PNFuVvzweqUfYiL1WUWsCUml?=
 =?us-ascii?Q?0k7/6QHtvYj+nYeG2C/b4RIic4g0Usrx2Hvx8F0KX1JaQVzZSb5Q9bkRGkSV?=
 =?us-ascii?Q?P93NAVx2IlE4V+671Dv0NO6C7UxIx+ztLri4C1vKy5ruoo9wd6kS4MRXk8pV?=
 =?us-ascii?Q?FAwV7ukrOhUKvrn4IcRR0QEp1whG9az5RRlW/YORP+N7BzC7JMQVj4e+bcpL?=
 =?us-ascii?Q?ooouAA/82naHqe47RsrCNOn3sE2BqKeFcDFEcFubGa3NjJN1uKVx/KvHRxZo?=
 =?us-ascii?Q?BflIGCg8HD2rLKwv0cY+w7qMp6cBRg5Np5qMuRTzQQZzEPHLV4fzNc/n+Hti?=
 =?us-ascii?Q?vhXc1IhvTKM0iGpyHqpwJhlItljRN6y9lEYIVgUOizAvwLE7c/yyGqxEn2bP?=
 =?us-ascii?Q?Xhwabko1NAFK/jIOf1aWZMU2mDmjldW0eB/sXRJZrB8xa3Xmc7onyovBT/FI?=
 =?us-ascii?Q?ARa67Fh11rES85rhpkwGxDdtdNFA+WLVoyRjUHsEYbjyordmtnbIlnl5Yre8?=
 =?us-ascii?Q?Q9UhHKADqQtd0lbN4+9FpYe82saKW+VbeYUwOf/WjVgX4FQvMoRXPZCakDwW?=
 =?us-ascii?Q?A8hKhjwdSZ1OewFtAj0jINW8ibCmqPBiRB6Wja/8qGE1s75EIrlMNjGd7bUP?=
 =?us-ascii?Q?vYhMn4NoMH61M+ZswYmYsnN9kmJKA/L4kEuvMRxbFoadAD9TsYmbhWC1CJ6q?=
 =?us-ascii?Q?4Oa2kgK1m/kReqKZg0xCKUXAbWVZGQbdWZKM+rwN/Zzms+e5q2XIuYqaQESt?=
 =?us-ascii?Q?Gjzo07ah+gCkS1O7hRdp7ctPfd3gm3X2yvQ2HtOjAzGUumJtn5Wsbgzevrf9?=
 =?us-ascii?Q?vlXOvFqHKvepVFgRclHs6dzBTvaC2dB04A0Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:53:46.5149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abc3e4e-d1aa-4e10-551e-08ddb3ce2d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

The link status is latched low so that momentary link drops
can be detected. Avoid double-reading the status to identify
short link interruptions, unless the link was already down.

This prevents unnecessary duplicate readings of the link status.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
- skip double-read to detect short link drops
- refine the subject line for clarity

 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   |  4 +++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 27 +++++++++++++--------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 71449edbb76d..f8a75532b11c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1295,6 +1295,10 @@ static void xgbe_phy_status(struct xgbe_prv_data *pdata)
 
 	pdata->phy.link = pdata->phy_if.phy_impl.link_status(pdata,
 							     &an_restart);
+	/* bail out if the link status register read fails */
+	if (pdata->phy.link < 0)
+		return;
+
 	if (an_restart) {
 		xgbe_phy_config_aneg(pdata);
 		goto adjust_link;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 7a4dfa4e19c7..94125197738c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2746,8 +2746,7 @@ static bool xgbe_phy_valid_speed(struct xgbe_prv_data *pdata, int speed)
 static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int reg;
-	int ret;
+	int reg, ret;
 
 	*an_restart = 0;
 
@@ -2780,13 +2779,23 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 		if (!phy_data->phydev->link)
 			return 0;
 	}
-
-	/* Link status is latched low, so read once to clear
-	 * and then read again to get current state
+	/* Link status is latched low so that momentary link drops
+	 * can be detected. Do not double-read the status to detect
+	 * short link drops except the link was already down.
 	 */
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (!pdata->phy.link) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		if (reg < 0)
+			return reg;
+
+		if (reg & MDIO_STAT1_LSTATUS)
+			goto skip_read;
+	}
 
+	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (reg < 0)
+		return reg;
+skip_read:
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
 		 * declare link up
@@ -2804,9 +2813,7 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
 		}
 
-		/* check again for the link and adaptation status */
-		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
-		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
+		if (pdata->rx_adapt_done)
 			return 1;
 	} else if (reg & MDIO_STAT1_LSTATUS)
 		return 1;
-- 
2.34.1


