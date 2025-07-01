Return-Path: <netdev+bounces-202773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9BAEEF3E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92F77A59C8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434891E51FB;
	Tue,  1 Jul 2025 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NaLGYwNi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE11DF987
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352681; cv=fail; b=FwL6lXHuQ2KTyJ3T2k7rdb2VQJ7j3q0raEnXQUJ0xFDKGjriYA7gajZyKahymOfEVF5RuouiIYlVLS5Q2dAydAMO6dkz57LkBfMWSUq89ggih85hCGtOz1T6rrHjLgJozpTSSFXQO2XoN2iTDazp8VTVZf8//cCSseLQCRjG8/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352681; c=relaxed/simple;
	bh=zKl7gV+y6viTiXrJL0jtjb1qh05qwWgTkJPi1T4DXrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HwfNHsn3d2IVo5uUEsSpzZA4AR1jBCxc0Gh2Mo6qP6DwKzlcOK0jVdGKDgUFkmMCVqg5pEdGXFfwBLuAgFH155SBIMOzhK+g4UPWYW6yLS9y5WpGaHw/K5JH3yFYZKKTYsdVq1unI+vjlU6T9CF+lvCC5PeA0Dz5Y7RPw9f3nCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NaLGYwNi; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgT99VgCGZaxdu7Kwj0jzNVX0uLRxafDB0zz4XlK0cPqnkr2Mg4AruJ9uv0/PtGZVHsuyf4CtVF8GbX8qJ4UTLZtd/Dl6w0v4iJSoEe3Fb5WtMERiMw34Hi+LSnl10Or0yw0dVauu5+F/j+qXMYaf4zbaf2eNFsRyxHw/2kDNZu9D8z3NVZNBjvqdq0Ds90MOklIOlGBnc8igL56A1Rdr3LGtzFn7UPswfjOdVTsUVE8AGeNYyJXdtS1USi6QxP5PRkMtj7FZ8DlQgmjyln8PhcMjaKA7k7qIgyG2cXZOgVYhqpzpckSJznJsXvrGBm/PAA6llAk22z43o1bZWufBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTAsLFtXDYOY7fm4UjmQJz2tNMXmOAAzXjkXZQMePFQ=;
 b=Sg8H5Crog431dz/Xk9p1Z9ntvqsKtWNPulfgqJ1VChi1nOmFDNadx1ztoDEMYc0HWUA3duaQye2xLYBqY6ETS8yctqtfQsTw7NES3w/ES+/SNl6/35gi7WtUXMiZH7aaEtmzTornjqT9ju+oyPZ4k/LUqZs7nUQD3eZDw3MlOGk3B3p2NozuSAonTIac0WPwjg24d3MKyddQUA0SZAtmMEFQQEyFTg/Ud0xhOjikVO0sOV/583lxNwpWA1vAc4v5iffNjWfenyG5Pdhogn8/Cd7ovaMmH+GqmWvEQw4bZ34I84enpOWID+gULNzqfbK4ntYUxQG6Ft+mPKXi1/Qi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTAsLFtXDYOY7fm4UjmQJz2tNMXmOAAzXjkXZQMePFQ=;
 b=NaLGYwNiX8VQU+ZvNtpI/+PEpyXdvkS5mDZQpD4tUL+IiMvAFUvqdornLMvmGGFn887y7Fg+C7pzCOJYC6VU8UCM8NvYfmVjUVFRH2iT46ot1dtcdiStk+2UxN7+ABUI61vKFWza3dRIjOVyc4JP2+WUM55GZ2FAo4qTcadTQqQ=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 06:51:13 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::c1) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Tue,
 1 Jul 2025 06:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 06:51:12 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 01:51:05 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net v3] amd-xgbe: do not double read link status
Date: Tue, 1 Jul 2025 12:20:16 +0530
Message-ID: <20250701065016.4140707-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: e886220c-13fe-4f31-53b1-08ddb86baaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TopEiR2j75wQQW6rlw22QprLMwFK3ZtwqkCf/kAPnzD9x2YacOmE5BbidlsR?=
 =?us-ascii?Q?ZufsOkaJy9hgTjZwl81nxN54h7LQb7s+Ue+tSc+w/Jhbvkuzv6F08PvDPODx?=
 =?us-ascii?Q?d+PkdL6TGT8aGBBreIvOlQnCiU9HRJtbZAqn51IJeZhw7GyJ/l22EvlDLjTL?=
 =?us-ascii?Q?/lDpGogmR7wNnsN1ipdSp+FKGZ2pNOIiOhQKopZazTE0KN0N+0P0Ttplfe7b?=
 =?us-ascii?Q?LNqcQkgrN7JnwlshH6Cr5PN7pz1OAYW/ResRIJw6d8BkG1k7IfC8OFjdh57t?=
 =?us-ascii?Q?Cu4McRqrACTSrcBVICnTx2TXgq+uJNMsUJ3sgRgbPnh5bn9WyDUBHh6Xjc2e?=
 =?us-ascii?Q?p40WQSLZ3beYSqFrAFBRwuJabAap+KTgmiw7y6Zc79PicL5svAgKiWTzhpyZ?=
 =?us-ascii?Q?GKeiPt8loNhJAVdnWsAHXfobnPuKogH3OXbvV2GFtDgFS5CbUtF1IoOnbOK/?=
 =?us-ascii?Q?WUZuvngt/uv2xmmgfeChEFLg+vkf45Qx7yd1ONWrCEB5lupca9UEU17BJUQx?=
 =?us-ascii?Q?seMDpusHW+ABfGCJz9yvxcqnmCu/BMj/MLm0ctexnNW7K3NXqin2EBSNqme1?=
 =?us-ascii?Q?wKMb7knKq2Llh5mNyiIcwRlMjYwEwLQfKLKgqpc1D9fY0NfOLTyR8Jknpd/T?=
 =?us-ascii?Q?LCW9rTmBZOwLjI/OetN/hnNqkB8PTMnww3tJxj3FrSGSb67dowzCFxlq+Mgg?=
 =?us-ascii?Q?+wHwiThVRGlz6vtiH7oKKwTk4Nc/IzIg64XoMuTmHyVMVN0lQ22Jh5vnRZiM?=
 =?us-ascii?Q?F5jEOIQQF7lEO+pJiFfsStlUTpt1J4YoDJ7OjW+5/WG6g/8ggDbb5s893ncf?=
 =?us-ascii?Q?m0KimQRMjAZfOPR2GqVum6WzFpeBZvNdG9pyF5P+MS7MmYDzI/IocqJF9vH3?=
 =?us-ascii?Q?Te5cRhFfvvrc5zyxeme4ljhIFY7S7ssE2VXfuVUuyWpTOcLrYjU9YOnvBVhP?=
 =?us-ascii?Q?VDRGPmx1nlBPUaM4ardfewB81A4dR5CNWrgxpWUEMYQRZ//M03Jjvea7UeZ0?=
 =?us-ascii?Q?9A7DnfdZu73baW985mZx1siqURE5yt8oLArvVj6YRQ4q62KFPZANmbzsByEm?=
 =?us-ascii?Q?auMsBXLwmy9uhHlluXsceLa20hRKPSuAC0A+9Ah86cm9T0BvIiDxbNhFyWyJ?=
 =?us-ascii?Q?0U3qDa9AvQpjtgvMFK4qVfgAdAaidOHx+Xww4BVcf8pE5u899W4FWZXC9BL7?=
 =?us-ascii?Q?D97ZUN7KHKVMkQ+3fY6XnuBlf0udk3RozaKMfG/yCpjyEYRQMPy34YmgH2v5?=
 =?us-ascii?Q?CG7yd54Mq+XR7UrobZBpWqrl80wjb9UsG1yx9Jdi2Jso7yLv0X2XJ30/m+n4?=
 =?us-ascii?Q?JizF+4oagxZWUun9Ri60EEI2n0pnPO4gm00xmC5W+mKCmY8lbEeKEoMQNh3h?=
 =?us-ascii?Q?+oTpIxfahp4jvwZkLfSwhRw97lhG+dn+3tEvSaB5h9vl8gfJlRNcfFnMga8d?=
 =?us-ascii?Q?Bdnsnk+6FWN9e9L/M3v+VZazJiqn2z+yXbrCVOWO2p+f1Z6AEjIHtE/4+PNt?=
 =?us-ascii?Q?dZTZzyVPvmwSPqSGCHFgXCi+Lcg+QcADEazS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:51:12.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e886220c-13fe-4f31-53b1-08ddb86baaf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

The link status is latched low so that momentary link drops
can be detected. Always double-reading the status defeats this
design feature. Only double read if link was already down

This prevents unnecessary duplicate readings of the link status.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- update the commit message
- avoid using gotos for normal function control flow

Changes since v1:
- skip double-read to detect short link drops
- refine the subject line for clarity

 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   |  4 ++++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 24 +++++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index fb5b7eceb73f..1a37ec45e650 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1304,6 +1304,10 @@ static void xgbe_phy_status(struct xgbe_prv_data *pdata)
 
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
index 7a4dfa4e19c7..23c39e92e783 100644
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
 
@@ -2781,11 +2780,20 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			return 0;
 	}
 
-	/* Link status is latched low, so read once to clear
-	 * and then read again to get current state
-	 */
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (reg < 0)
+		return reg;
+
+	/* Link status is latched low so that momentary link drops
+	 * can be detected. If link was already down read again
+	 * to get the latest state.
+	 */
+
+	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		if (reg < 0)
+			return reg;
+	}
 
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
@@ -2804,9 +2812,7 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
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


