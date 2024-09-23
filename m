Return-Path: <netdev+bounces-129305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0497EC90
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9901B1F21A27
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996819C56B;
	Mon, 23 Sep 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JS+82sM1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5619538A;
	Mon, 23 Sep 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099175; cv=fail; b=U7kuQtb2y3V8h0c31LTHx4Wa7vq/88I6m/Zqb/zZOxo09cwYG0tBTib69rC6rn1slv3ozmZVuOQP6haYj+BiT9WTThoAsD3F13OTW9Ei5/9DvvmqqXuFOPcdmD+muf+Af/E8xto2zDKqBoUmhdF1hk7Uz9QQbVvcFu8Tos1E8no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099175; c=relaxed/simple;
	bh=kb7aPYXnyqAo1H0eeUotyTNeGSpjG/aTVvDasEBBeYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=npWKVLIPolhifS0OA7zfLJ/OmAWTTsy9+iZzK9VbLibFndyrQ4FHuAFfxyPsymWBDj5J4kQgQ6TH37qLQ+7SzGcDpuVaFodh0ufSBKjXzAAIvTZHdvgDLhNBb345Hy2z39SIC6ayAe/nMQSpyBmhHkidjfrQCaBsvvhur13iJS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JS+82sM1; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0GL+LiEwZttHVrLVOnF2KojTB51TRpgfhhE2hWIeCm5Ttw6o8L2JaBdxGTi8DL+BjyfD6/WJ4WkJ4eAEhTrN/tHHwDU9jJOYF1JgV+Uo2D5POnPGIgYjAzIXufiaUEnJk4Ec6MGpKAfXzWFpSTt6Y8L9KDijKm6iuexCcc1UfTd/6JouloKWEVA5F9ZhxwGQG+gkhhNsyBTaKmCv92wrnpXq6Su57eWxEkgWvFSQtIxeuKoczJ4kfGFEyWZsNfj2LeYhWq+4cauDKPhlJ5aczZUHIgLCy1f5HjIcijTGCKaCh67gKz3E2Z0TuJa6giURlkgyERZ36h37SrrXzA9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEKb2c/3RF6EYl0tl2gzb7fZweSf3FBAVmWtY7RFUk=;
 b=hvObd41pk49ZJSC2fVi7xmTqhUYUG5BUMjjXl0M7TCIoDWewDBUm5uL79Th4NYO3e8/7A6lt8HHzqNf1yEJSu1erkQWPfZkuoV/Ix1Ja07S8AhWJkbe7OMo4psGLQ/5MMuSVIEQ5p22kp8miyx0zXklOHsNlxl941FnX5zCUPAPBUG5Qd4sI8MCOjq7B+IqIDsO5dtI69Aq+c43wsPLf9rZwP60Bs3cyi6nycNbps8nRkzYq0S35GhcbhGaNk/YCB+VjndmfQvp+UrHTynKBefLvVGZRavHXGRhE7f5GaoNuuvGxXyusNj1BQn4QaTMFF8V3zV5jU/IIk7MY22gSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=foss.st.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEKb2c/3RF6EYl0tl2gzb7fZweSf3FBAVmWtY7RFUk=;
 b=JS+82sM1YpCz1eQajRkc9E4f0boiyABWukNNlsCUUJsyhEfZ/m2jnlA2v2Cdkm7ZIb15Q5dtvC0BIR6E+RWDvAzoAPTGiaBaAEfDPOHm0NamxjCXp2gKKsuAXWwC+vqCHigoaA6f3NFTcy77lbGVNi9n68OAeIrh4RJwjU3wGyVyoGBbggLndQr7RS7DVDgrdpddmAx5V1jWLc0MlDIHlunICF+s0rG9vK+izkGEeVjJ1GBovnO5ha8ScEdGeV8DiVh96QHDTQv4aQ2wsc9c9GEV3X9/2eI/kKnD8D1FS3R5oCyVxZ0McoYOwYtnHieIj9A1bCyMjeYoxIgNDxfrZw==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 13:46:09 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::a9) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Mon, 23 Sep 2024 13:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 13:46:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Sep
 2024 06:45:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Sep
 2024 06:45:46 -0700
Received: from 8306d05-lcedt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 23 Sep 2024 06:45:45 -0700
From: Paritosh Dixit <paritoshd@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
CC: Bhadram Varka <vbhadram@nvidia.com>, Revanth Kumar Uppala
	<ruppala@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Paritosh Dixit <paritoshd@nvidia.com>
Subject: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
Date: Mon, 23 Sep 2024 09:44:10 -0400
Message-ID: <20240923134410.2111640-1-paritoshd@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c9af50-6247-48dd-99e4-08dcdbd61427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czewiuhlytgsDMu8verhlX/TwN/IiR+ihvLlAojrNblCjptbOjfben4LxhYr?=
 =?us-ascii?Q?uox2Apm36ZH2mZq6eeGPfCRvNWCJ27pIga4C9Ki221n35HjeqiCJCa+yThhG?=
 =?us-ascii?Q?HiXYJUtFjJDiBZBBipGKJvVT9rx234maoXP1Ryt9mAZ53GQEzAoDY28TrBrI?=
 =?us-ascii?Q?AMIw/gfHX08V3QpAGKpuo0jzjtwJDxERFR5fBXHKk7jaDlRZIt68FNViCN6c?=
 =?us-ascii?Q?TwGs6paJCitfNQZ06X8Xq0h41UILUKIeaF/GUuZMs7navcEIxHJ7QtEDgAtg?=
 =?us-ascii?Q?8iFAAU48K+slAKcSwPbf/uRvWH7afl/XfdEGaRcSSbLmM2pJa2QVsYVJ2L+R?=
 =?us-ascii?Q?l9yMPJGCxcaEPXLwSEh0DvuaLzvwLsoSDbgZzi5FPZgrhXhWnU146rVwu9kZ?=
 =?us-ascii?Q?d6+yx0CYDboS4rx0bf1FFibbWfYTVrSkV1uA+S9eZJZy5IGHRCEIXtR/ySb4?=
 =?us-ascii?Q?tU4M/+gqipS4KBI7tIMFoAyHVoPqMwWJRX5lO3EWvPJ35i1HeVxLgATp5VEf?=
 =?us-ascii?Q?1JQbXsfeW7TPakEQRgQ1elClE2ymNncfOccxnsHR4VkN9GHNeBH9MxtHilu/?=
 =?us-ascii?Q?IUngFUpXnXVaDDxl0aTCkzmKyTTk50Pl8wEkFUuvgTdQfOddz+0d0j+CyZn9?=
 =?us-ascii?Q?LdDM1YBYoA0K0GhpjiGmcLEFl/EdFesfy2mbF22nrjJ1SwJgN3mqDDaGS9l+?=
 =?us-ascii?Q?qVS0LpwBH+Yfi+lV9VkjWY9PXcf08LKdkxqmfnT6+GtklrGkrbHYmdunjMPz?=
 =?us-ascii?Q?QKitTuGBxRXWkp4ys9781XKNqQGwG3Lnduo97DNFcpWBkHQeXnGI07njPtir?=
 =?us-ascii?Q?F7sY2E8U5FQvLccqGsC2YCmJzOqbzG9aaE5ULvyVRBHkZH5Dlccny3D6GiC7?=
 =?us-ascii?Q?kipD15sBI80wS5oeJ/2B5Pxl3/hOyhyoULI6mSo/6JOw4gcKaLeR9O2MvapH?=
 =?us-ascii?Q?3l9CXlYXhFDsaSqitiW9mznsXRcOOQYAV44e/R8S344DrdyBbjY3XLXwqgQm?=
 =?us-ascii?Q?VyPWr2mldtRUFKHxSow8gVCsTHroD5ASzX7IPFUSmy6mNaaOfPXc8Fkfv9KA?=
 =?us-ascii?Q?JT/7gDpq8uQwxUAMPRFfZQ3XmdRYdklGjpnR0AokCYBOQP6GyUr1kF7GYjAJ?=
 =?us-ascii?Q?VztPN9G8FrsR+AgxF8EVtrM+Mk0X7eyIptLCnYgiGNvcCTtqddfxXkAuhxp9?=
 =?us-ascii?Q?pX8STn9BkF+SmwUmsnkk+PaA+F1zROni9rzJbZGixNvOSu2UH1TUB3QmDdZL?=
 =?us-ascii?Q?HLO0Us7qaXnZ8i+lVeAUQJNWX1ALM0H/aGnV7lRmjoHXtmFoxPsQLxo7lwym?=
 =?us-ascii?Q?wUA87pbwSu8sFLOR2uhlz9lhXpXSwJ1Ra1C3E0Ej0QBGKZwNB77M/7SBYIk3?=
 =?us-ascii?Q?8qThSHpDIJP2taClzZrXi6tT8sH5RkWAFKgbNCQvQ6G/RV6PmJwKD3QpQgIF?=
 =?us-ascii?Q?fGm+Vzy732a4kn4LLd/qIQLGzzCWyTlr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:46:08.6297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9af50-6247-48dd-99e4-08dcdbd61427
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

The Tegra MGBE driver sometimes fails to initialize, reporting the
following error, and as a result, it is unable to acquire an IP
address with DHCP:

 tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready

As per the recommendation from the Tegra hardware design team, fix this
issue by:
- clearing the PHY_RDY bit before setting the CDR_RESET bit and then
setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
data is present at UPHY RX inputs before starting the CDR lock.
- adding the required delays when bringing up the UPHY lane. Note we
need to use delays here because there is no alternative, such as
polling, for these cases.

Without this change we would see link failures on boot sometimes as
often as 1 in 5 boots. With this fix we have not observed any failures
in over 1000 boots.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Signed-off-by: Paritosh Dixit <paritoshd@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 362f85136c3e..c81ae5f8fef4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -127,10 +127,12 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
 	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_AUX_RX_IDDQ;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	ndelay(50);  // 50ns min delay needed as per HW design
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_SLEEP;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	ndelay(500);  // 500ns min delay needed as per HW design
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CAL_EN;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
@@ -143,22 +145,30 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
 		return err;
 	}
 
+	ndelay(50);  // 50ns min delay needed as per HW design
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_DATA_EN;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
-	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	ndelay(50);  // 50ns min delay needed as per HW design
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
-	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	ndelay(50);  // 50ns min delay needed as per HW design
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	msleep(30);  // 30ms delay needed as per HW design
+	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
+	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
+
 	err = readl_poll_timeout(mgbe->xpcs + XPCS_WRAP_IRQ_STATUS, value,
 				 value & XPCS_WRAP_IRQ_STATUS_PCS_LINK_STS,
 				 500, 500 * 2000);
-- 
2.25.1


