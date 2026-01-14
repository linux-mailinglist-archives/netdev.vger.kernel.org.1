Return-Path: <netdev+bounces-249714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4DD1C560
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 05:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0203018182
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72A1D5ABA;
	Wed, 14 Jan 2026 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xuY4rOwv"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1D17A309
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365048; cv=fail; b=RAYUgQXREX32+AJyCpdfPBM9bQc3aHrg1zW9yD0Px0n/Nbbkp7lo/RGXDWcvUbBFTS0APJl2OI1F4Gf/L+x7pEqOD9MLIfQ5RPt4ic96jaEvDjEC4/TSXXIB9Zyfh0PpgOW4TO81Qcf0SEFgsxysYMFawUCpj5pkYDh15cM0D3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365048; c=relaxed/simple;
	bh=+gROynBGZPym1dfnrMOZzorD+Glp89Bh8OLLi1UGgTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fN3bTg6LCIdhP219Oqdx/WNMCjNd617KT76KtHOFtQWBs4si+BMyT/Rd/KwOaSDniVzVnnEuQjw/JWTW2Kdz4xH8Piyf1XqoimAXVmUq4M4vZyH9sMHGFqiGNmV1OGopLJQUiYi77zoI5prxTkC1C8R4EUdMpw15kmewxdHBFns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xuY4rOwv; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI1O/rRCQQnMVEYy6xROLMQaT3FtNKzMMTiN8FPs20cVLNiduKTZwoAR3HdRKVqyZFQ6/tlcYJ1W3mBhff8phamVkJztaZ+uQ8FB5nZHE22mM8zOdepaZ8yjBG3WY+0kbkt2O/QHt1CZ8dp8Jw1D7QULAtHId73zi5X7wSg+7iEtCc5BAqqBr4u8snY4oghYH04PRViyOOl7IRl8nVMjlmQVxzd/5vTUKTLzdugSN/aVP/tLyKdPhrhfzSWUvM+D8avuPOqzmRsPU5Tq/omfoH0ymemMsKX5FZxNCqvg4cXE+9HLy8QtqQ94zuU9lK6KXO+w4oIM1fgbmn9BnyI1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzeZecGml2sJoX2BcGwiipTz+0o8h1d95VIkqNLhwzc=;
 b=yGHYCaFu6/5lUQlN6tYYrEOQ/OpP2VcxtEkOz1RP2TOJfTviGJc5fjjrkz8bQ8lYRBLzWkJ7ZxNmlayT69Ncy8hYlHpRb9gLvTLWGaXB9SyDWE8Rsq+1mvKhyzWnYtat6HaloqmYyOb94HFf42sBAAB+KCCIihrZAK1PfEVbhOb3apDc5tkvNI9ZhKVhOu3dV3vuI7wz7nKp8N4dz79yQqpXnnuBceAjOYC74M04GF5FTjWbCFNYdmZQ+ouZmrlL4JUDsdG715zWeV47HAQZ7Wn2X+nWnS+LRny865zqkqExVR3kO6bZl22kt21ZOuaCYZTbpFPMdAC6qFOoCEyWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzeZecGml2sJoX2BcGwiipTz+0o8h1d95VIkqNLhwzc=;
 b=xuY4rOwvYskluVqtdlEM/xQinYZ8Lo6w8GkGMcf6In5fBo31n0tNk+Auchi2AwSOSh87OEASqmqUKauVjU3VA+0+B38FGWIg27liAc2TxXG5w4VA30P9O4iW37joIcYg5X6bk868aHaTXVbsGoyV0dWPBEL0RvP5kxdiMS7EB6g=
Received: from BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19) by
 MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 04:30:41 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::73) by BYAPR01CA0042.outlook.office365.com
 (2603:10b6:a03:94::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 04:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 04:30:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 22:30:37 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH net-next v2] xgbe: Use netlink extack to report errors to ethtool
Date: Wed, 14 Jan 2026 09:59:27 +0530
Message-ID: <20260114042927.1745503-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f006a4-f912-483c-0e05-08de5325ace9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?71K3pUpikk0uwhetstixSbObqIjSW6uz96j5hAON11c21hbdAIjhP5B3EOki?=
 =?us-ascii?Q?EVDi7oI5nAHdhu5l/DakiaPWIhKrOulXKQPlauKNpj8ZVI1WiXltXylQOm0H?=
 =?us-ascii?Q?w+MNP7fwp4kP6+ZYeflMHrmxrS/lGViOjpwwfDJvpSKtVrVL+Vp+fI77KT8T?=
 =?us-ascii?Q?SveteAIFny5z9ywQfA9XMPO9Beu1wL2SFmkZhIisUOFDUm+wu3HAykb2BykN?=
 =?us-ascii?Q?CNi3x69ElcMbwZevB10PdSPUxHTVZ+MuRKZ2tKd8FXemARBDx2CznGy0u6bh?=
 =?us-ascii?Q?8/6EDHVbkeFq22ryB5ITB8YHJowf0P7Yj/Xm9JbYAtcb8PU/y0dpT/yfVfU0?=
 =?us-ascii?Q?hB3c2MgRLD2tRPnG7NfafTBny01H2+Rak1h+reftkHP/asdVZUi785SSjRIi?=
 =?us-ascii?Q?04BSCEze18ZgCm8TxKoSo5pBawuR2vk0rdG4Rv3tKoeJakcRxItRAM09djrv?=
 =?us-ascii?Q?c4GDNh7ISsTECq+tnLZj2+qhztebf4p2y+/rS044iMdAogJ2Zr3TFgMQQ6ek?=
 =?us-ascii?Q?55mYvLnqd1kx3LXVLqsev5j+JnRf9J3XsJOkbr0L+DO+pMVc22bRsks63vrG?=
 =?us-ascii?Q?bfJUxM0PtMRfVrRTQeU7yPIgz/JtVOtXiUt2pa4iU/fbe5LHfH3tz8hLjSiG?=
 =?us-ascii?Q?jGFSDpwu8EjOiCpsrHtVhmngp2nc0Zi66dfE9h7fALuHSP4RAbO7Mj6QcEvZ?=
 =?us-ascii?Q?Q4Fo7iODnOibdeIwjfT4goH1moz/KZgYHKTKrTvpK8eTkFLJW71NkIhP56Np?=
 =?us-ascii?Q?u7v/bFGLd/w6sHXolrch0bYOMwPPUAqoQWZDkKm7dTmprHD96KCMdUC8mWSD?=
 =?us-ascii?Q?wwIgIpwoG9yvSZH5QfNtUx0yYfaoUQQQFmwY+BPFglLGdrmhECfhL0FwQI8P?=
 =?us-ascii?Q?JqlrXSqYx+n/Wf2DxxaQCi0q/7enVWPov7+ZvrfiabndlTo0Uxu/cdWx3uRz?=
 =?us-ascii?Q?VsejL0IHLp0AEIoJfzudKBfH6WL2PG4z+rz3FwvkBa+2xJoRIfoIZRTt1rWi?=
 =?us-ascii?Q?NUF06eWI+pdvfZl6UQrA5W8hPpGwDAVvN93Ffd3fLMDltpTvnlRt6rWpYgJS?=
 =?us-ascii?Q?4gxZAVCvwfnVS7WD9F1uhrjn1vSzmDGNjVxuB/lhPp/Qjd6jJMt0bcc/HK/+?=
 =?us-ascii?Q?W8B582vSiJkiPZNH25uIHdYSpdIqMcJmTAK8C2VtCbFWjXg7XwIKu03UDT1M?=
 =?us-ascii?Q?xh75iCriA1t6g0enWndh93Br1/2XoQFF24qXP0FGIw8/CnNazpKMrfAERP0e?=
 =?us-ascii?Q?IaWM9N12paK8kGLpXdG1IbNfdyTy/Zy4ndjmbOTvS1+CITzBGJYRYqD/zFZN?=
 =?us-ascii?Q?S1pS1FLfHoGmZkNm6f5ULfzp+vEfFAKEoL9THjPPHkFVD8n4XKQvIlkTJS0D?=
 =?us-ascii?Q?VQRRehmUes9Z2LCTK3Kw0dQeQLxTL2bkpcCuuFPUT0Lz5pBZgo/MdeG/Qr2Q?=
 =?us-ascii?Q?bOOeASzSnDnBG12lO5OqgFeZm43hW/7fe6NSD2zCSzOKotCt/+3hqSZd/zTn?=
 =?us-ascii?Q?WSoW0SE66+i92FBqQi33mNKrPqE7ENbyrBduVtY8jmlah8utnl9iT3fI7pta?=
 =?us-ascii?Q?AB09oKHRw/FnxzGdQMg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 04:30:41.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f006a4-f912-483c-0e05-08de5325ace9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

From: Vishal Badole <Vishal.Badole@amd.com>

Upgrade XGBE driver to report errors via netlink extack instead
of netdev_error so ethtool userspace can be aware of failures.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
Changes since v1:
 - Remove \n at the end of the extack string
 - Don't use _FMT if there's no formatting going on

 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 49 +++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 0d19b09497a0..46b69166e74a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -362,13 +362,16 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 
 	/* Check the bounds of values for Rx */
 	if (rx_riwt > XGMAC_MAX_DMA_RIWT) {
-		netdev_err(netdev, "rx-usec is limited to %d usecs\n",
-			   hw_if->riwt_to_usec(pdata, XGMAC_MAX_DMA_RIWT));
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx-usec is limited to %d usecs",
+				       hw_if->riwt_to_usec(pdata,
+							   XGMAC_MAX_DMA_RIWT));
 		return -EINVAL;
 	}
 	if (rx_frames > pdata->rx_desc_count) {
-		netdev_err(netdev, "rx-frames is limited to %d frames\n",
-			   pdata->rx_desc_count);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx-frames is limited to %d frames",
+				       pdata->rx_desc_count);
 		return -EINVAL;
 	}
 
@@ -377,8 +380,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 
 	/* Check the bounds of values for Tx */
 	if (!tx_usecs) {
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "tx-usecs must not be 0");
+		NL_SET_ERR_MSG_MOD(extack, "tx-usecs must not be 0");
 		return -EINVAL;
 	}
 	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
@@ -387,8 +389,9 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 	if (tx_frames > pdata->tx_desc_count) {
-		netdev_err(netdev, "tx-frames is limited to %d frames\n",
-			   pdata->tx_desc_count);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx-frames is limited to %d frames",
+				       pdata->tx_desc_count);
 		return -EINVAL;
 	}
 
@@ -474,7 +477,7 @@ static int xgbe_set_rxfh(struct net_device *netdev,
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
-		netdev_err(netdev, "unsupported hash function\n");
+		NL_SET_ERR_MSG_MOD(extack, "unsupported hash function");
 		return -EOPNOTSUPP;
 	}
 
@@ -561,37 +564,39 @@ static int xgbe_set_ringparam(struct net_device *netdev,
 	unsigned int rx, tx;
 
 	if (ringparam->rx_mini_pending || ringparam->rx_jumbo_pending) {
-		netdev_err(netdev, "unsupported ring parameter\n");
+		NL_SET_ERR_MSG_MOD(extack, "unsupported ring parameter");
 		return -EINVAL;
 	}
 
 	if ((ringparam->rx_pending < XGBE_RX_DESC_CNT_MIN) ||
 	    (ringparam->rx_pending > XGBE_RX_DESC_CNT_MAX)) {
-		netdev_err(netdev,
-			   "rx ring parameter must be between %u and %u\n",
-			   XGBE_RX_DESC_CNT_MIN, XGBE_RX_DESC_CNT_MAX);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx ring parameter must be between %u and %u",
+				       XGBE_RX_DESC_CNT_MIN,
+				       XGBE_RX_DESC_CNT_MAX);
 		return -EINVAL;
 	}
 
 	if ((ringparam->tx_pending < XGBE_TX_DESC_CNT_MIN) ||
 	    (ringparam->tx_pending > XGBE_TX_DESC_CNT_MAX)) {
-		netdev_err(netdev,
-			   "tx ring parameter must be between %u and %u\n",
-			   XGBE_TX_DESC_CNT_MIN, XGBE_TX_DESC_CNT_MAX);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx ring parameter must be between %u and %u",
+				       XGBE_TX_DESC_CNT_MIN,
+				       XGBE_TX_DESC_CNT_MAX);
 		return -EINVAL;
 	}
 
 	rx = __rounddown_pow_of_two(ringparam->rx_pending);
 	if (rx != ringparam->rx_pending)
-		netdev_notice(netdev,
-			      "rx ring parameter rounded to power of two: %u\n",
-			      rx);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx ring parameter rounded to power of two: %u",
+				       rx);
 
 	tx = __rounddown_pow_of_two(ringparam->tx_pending);
 	if (tx != ringparam->tx_pending)
-		netdev_notice(netdev,
-			      "tx ring parameter rounded to power of two: %u\n",
-			      tx);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx ring parameter rounded to power of two: %u",
+				       tx);
 
 	if ((rx == pdata->rx_desc_count) &&
 	    (tx == pdata->tx_desc_count))
-- 
2.34.1


