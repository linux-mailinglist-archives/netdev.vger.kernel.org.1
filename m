Return-Path: <netdev+bounces-102390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17461902C35
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA628558B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD31527A3;
	Mon, 10 Jun 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1gsZ0OE0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50F15279E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060860; cv=fail; b=C5w3IdOvtxHAs/jMbujbRbNiLykrTMx6OKthD64brx3aZOVisOxhAMqpcPEpf2iBtY+UONDmurW0DbEOeaBrhtqTH70s3RjQ0Og1dIrANWbbYfWBymdBqwu6JFsM5cQiZO2m3z0ppDuLi7vK6rVQID6o/syxLWnOVvH04bobDIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060860; c=relaxed/simple;
	bh=7NPfARyBD6T7EJzXjt7Kt+Us8wC4SS0xczGyNzja5Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4zmuxeokeuLOIiMnzXq5IFBusAz/IOMePurc0+uqvQArJhOXlmeKi5gqQ9Bou1T4P2v/m/FFgIIqGKtFVrezwp+CTEANwqTd780U247dbcElUlEmBeDKd3bDdaIYhVTsF7Xj3YyJAOC9ucGj15gFC7lwkF1Utt9h0tWvSYQysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1gsZ0OE0; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjUGLESvwvGsa5i2iqLCHT3O/w9zmE3nWPAg4WFBucUyEH/zqdGMfZhp3yqUBStgLZPJxne9mpXmg/uGrmRXGZIxx8O3rhVmqrnhwqqUVcvEJ+2PJKjnn3pkNEUNgFDUfncfsV8BblT2f2BtsACISppYTS6cii/8F7c6829B2wNxc7Af06Kafi8lWQ1+O6hxAl6j49HiMKT9HeTcW/QTlRO8IbluQI25/zxj4A9VfCshGNmZmainZVusiymBIw2i+bF64jdgG8AeNmyXAxdG6RXcCt95eYl82OARi4qy/Cf1X8ssrrS6FHht0Cwu40q0ECPloI+Yc6EjXJPKVCJR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDYLNzSJiVivAy7/PO2pTERKnr2k64XVRKdiLO3mzA=;
 b=lsMozywiGgVvKiyWZU0PLvVCj1hqGjxkeiwkrc6MIBukKZKNjFjmO/jdPKHQc0McSBREY7wlGvPH+biei2+XqO9+cQB3SVBnlMkSlyW7uCy9OqxjjN/Grn2ysa5e7NPMQwJGErSVfim6+v/HGUzZAUw0NHkWyRdq9CMOpABKPlfk0ICvPIwz70tmICpwEAomuURDfZRt/CU5MEdRdgztJgJzfYHwn7b2XU4ExhDjgami3x3sSxyCbgcmH1CqxSwouZ0460uzVhyvt7UOrKHmGnZO01M1nEooGIo+hSpZqRyGvpiVo14H/AJOsniiR9S/CHlAwpR9KPS/kehFFhwM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDYLNzSJiVivAy7/PO2pTERKnr2k64XVRKdiLO3mzA=;
 b=1gsZ0OE0vQaGui6WEAhvuuMRp8nu4/AqLKpcz6gxyh097E+uNNGbQ2PejSOM1NXabg5trpebWbuU0yyDQxu7XNba263FL4yFA40kXZd5OkDG3vcFBWVToB8uhBLwjngHEtSXEapKaAr3mHcvvN79tWaA1uNmnWhPC2yPuUOsGHs=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 10 Jun
 2024 23:07:36 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::af) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:32 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Date: Mon, 10 Jun 2024 16:07:05 -0700
Message-ID: <20240610230706.34883-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240610230706.34883-1-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b2d970-35d0-4a79-7db1-08dc89a21e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONxxLSFWNv4cHdODDrCGgx6sgXQx/+PnX5ESiz8vbruGechJ3VDlyZwXLrPH?=
 =?us-ascii?Q?DeiXlC0d2fHqPbtrM3Ks8sDepykRZeabVwPY0d+gHC3l7ULcQMFHXqG6G70x?=
 =?us-ascii?Q?uLq39a/Ts4yX/LEZQUZVCk+GgfgcEO99FWFlC+7U5eYERXgaBFOuu3brIBrT?=
 =?us-ascii?Q?WvrB26ibLdWgkddy0dhsN+NeVxI2Q8ei8kGOO6GGLPU5z9Vbp/dsZ9dxc7aD?=
 =?us-ascii?Q?tmrEFGDnj9s5r8VKSV5YsALtZ9arZqs7ULz2QyRMA4r2BfedQ9dzfR5AGDX9?=
 =?us-ascii?Q?hThPrrvNq+oICbiSaf4yidzg9dCeDm89oP9KK0Kr9Me3FvUShgqMMTZzAfHr?=
 =?us-ascii?Q?87OYJAhRsDE+LdqTHohCwTeRqt9dTQXUBRVE3wVOUcIPgQ4C2hzyMKtwEX2S?=
 =?us-ascii?Q?YFHg7DQ3iiVV7irzn6mQP+wzsgcRzP7+sJGbJDah/LqbKYW2YB2NXWm4AHjk?=
 =?us-ascii?Q?o8qQ24tbgdt/HTAw1UIBEHgs7PuFHunlonZeJIPzPaPrrWQ1dYh6aPE3jD7h?=
 =?us-ascii?Q?CyS1XMuYu/lKkDQSshYkyevWPFGKtS5oLhQwY2qD088xie2IXsQqXhlwrOZX?=
 =?us-ascii?Q?rmeM9TpjyOXKgAWZ+7SheF3WHFkVgw2Xd2eAo/Rr1oNuUmfTh2piUCbQ+nDv?=
 =?us-ascii?Q?Vl+8Z5rvyhQrXl/kUG9WRkCC++Lu1q3G27Qsgnb1ePvMLxZGKLQtkjHs4KCh?=
 =?us-ascii?Q?DuIM6GvzZqe/3QQYbKCucx8n37SodztUTKUq0dC/UjWX19AUQxQnm3LpiKqh?=
 =?us-ascii?Q?i8lb+K0djenaNy+TsqGXRDQxOYc153w9jIFhO8cD370XbpQIMz1vm3QrZgRY?=
 =?us-ascii?Q?X20AqOzk6jiNza/lRk83oLoaWd0Q7nkrZ7zwEeDH0Ffsr+vXEv/HR/lbApGL?=
 =?us-ascii?Q?6endbJGF7reO/Li20gEs0ohSHCgIzJQ1aMFziyBbuc60NnF/+QHxleFB0UXa?=
 =?us-ascii?Q?AB/VgzDTRPalBjULkgZo5zj2KZH7rFMvjIKOLph0WmF4jLBUzChu9z+Il3l7?=
 =?us-ascii?Q?yHpmDRzWunBnc2uPUJAxkw1mpLbvxHWY//SpZauZkTAjtV9QibBQwylnNPF9?=
 =?us-ascii?Q?GsDzz24OlFw0aRWJAbeZfhtkqMAcq+vFSa62AoEz+fPf0BUyO9pfoZsLEEQC?=
 =?us-ascii?Q?MOx51FBHmzgVkgkz90RqAu6Wk0F001fzCXqrAAzvQ1rIn2+Qvd3zDyOoucbM?=
 =?us-ascii?Q?BtF9t7ec3XvZP+nxIuamEOO+XKEs446qz5wP1Mq4c9kb8R3x5w/xCY/w2J0/?=
 =?us-ascii?Q?Wq42Ct/YXSXRoNhoa3fIQQbA5OEjesiUtQArtoxrYLxO1BgLfmJ1qZn9jah8?=
 =?us-ascii?Q?2MMotqaVxrYldclM+in+rQ0NmU267iQ0UbCxo/+k5O36Tj+tE22pjVpt0XR1?=
 =?us-ascii?Q?yDwGYS8pcAqGRgFkp1qt0qvPFKhJiSyu7SuFFjeNqnuEpZt+1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:36.1040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2d970-35d0-4a79-7db1-08dc89a21e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

From: Brett Creeley <brett.creeley@amd.com>

To make space for other data members on the first cache line reduce
rx_copybreak from an u32 to u16.  The max Rx buffer size we support
is (u16)-1 anyway so this makes sense.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 +++++++++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 91183965a6b7..26acd82cf6bc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -872,10 +872,18 @@ static int ionic_set_tunable(struct net_device *dev,
 			     const void *data)
 {
 	struct ionic_lif *lif = netdev_priv(dev);
+	u32 rx_copybreak, max_rx_copybreak;
 
 	switch (tuna->id) {
 	case ETHTOOL_RX_COPYBREAK:
-		lif->rx_copybreak = *(u32 *)data;
+		rx_copybreak = *(u32 *)data;
+		max_rx_copybreak = min_t(u32, U16_MAX, IONIC_MAX_BUF_LEN);
+		if (rx_copybreak > max_rx_copybreak) {
+			netdev_err(dev, "Max supported rx_copybreak size: %u\n",
+				   max_rx_copybreak);
+			return -EINVAL;
+		}
+		lif->rx_copybreak = (u16)rx_copybreak;
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 40b28d0b858f..50fda9bdc4b8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -206,7 +206,7 @@ struct ionic_lif {
 	unsigned int nxqs;
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
-	u32 rx_copybreak;
+	u16 rx_copybreak;
 	u64 rxq_features;
 	u16 rx_mode;
 	u64 hw_features;
-- 
2.17.1


