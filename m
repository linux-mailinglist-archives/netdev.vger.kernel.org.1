Return-Path: <netdev+bounces-249741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73621D1D075
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26F93066466
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAEA35F8B2;
	Wed, 14 Jan 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eBPvQ6yT"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EA36A021
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377872; cv=fail; b=DqeOPbAzD/MtrT0rIBofuLT2pzf4IWo0DW7iyUtyl9qTBlSC45ubB/a2QpoNF4plBPhOo+c/AerPJWcX5MGqy7lQ1KMArlqOunVWpoZ0PFG1MwoGKSQInIKRK60M+bXz8CJyqZFz5oIWwasKHU0Xx8nsz2cMaaqwxN02cvQExBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377872; c=relaxed/simple;
	bh=mkQ7kNkOKEGdNxzfLa5EdlUgaf9j+H9Bc+jy9SNaiFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QX5xY7Zoz5o6DCZ3JuXGRhScl5HlVsHHvAhX8uIbasPGRHmCs0OumUKpPezIEaVXMOUCTyZ4kw6z4nDFKqNdKPDSUwEwW5XLYKrj6AAaIhy1pC3lOk0FBoe3bCtJYrc2fK6X8e7+ZxyzXX70RNH/kj8EJSw9gW0+/RLUc488qg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eBPvQ6yT; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhVm2qH54Jid4RzWkr4DgpbwqRBsZyEIu0BwTb3bGAXlgTaB4GAN2QRqLTTg53imqDoX28toWVv/5p3bvBPnYGapAeiBX4ionRdNb7lvdG8g3RAOBQwbYVFREQS19H91tXsaA4TEnIpNo2VSR/3kPgQGrkss0jV6i2XH4cU5c0jC706LqvBh6w7qGTjxL8zfpMeTbWGR7B7iKupfdPOMc/ejHoXzqOgQ/C9hMdOdvyV6PRyjCI6XwaeVIcsw49A07kLhFMdiaEfqncVNUmk6MBt7ZGwJKgdjVB6r2X06yfqB9MsUi0JfrxvCn7DSwiX3ZJs5lVRoPVgIipepdGnbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZiI2vv2a2uRzNxxUNP+g5/ry6VL4TgsbmsCJa6OdzM=;
 b=jURJvm/VlEr0ilMXM73qDDe6Wvz1y4jEHHBUGVm8NtAzhJaZmQkEEeoYVwTmRXV6U+EzBj7qAAaSYfgVl/F2ISJeih1pWebxyHxE+P6vho2+ZTWpIggq4JsVznLisPokvcSGLnxABvG+GBntdvXzfO2qmYCIV/jMaRZ8w994dnHCWrGwyVXXE9eJt5Az5dpITMhuZaTNBMi9LC3xjgkHYlxKSsgefBWJaNB0p/zMlwjCkJKcouyhOwnB/jOi4nzY/6rHYBqyUugci9jPc7s9rymCi1898uWzOtGRUOQD5L4XeiStfpapdW7JZUU1HSDAYay/PMXZFjT4IsOSglm34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZiI2vv2a2uRzNxxUNP+g5/ry6VL4TgsbmsCJa6OdzM=;
 b=eBPvQ6yTtWi2tQApOwEtRTsS/ve5uB0fhYiKi/f578Lh2cMck1ZBup7aT4noF1pYjhw/LXRn6LXbtBEA7PbcsxtmYdLPl8bnH6y9Lqmp2hpkl1KWaeszcbT3Cv6bY7Kv4wNyzSzih6YViQenRZCwbVN0OowDRKz0mqEJ/TUFXeU=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 08:04:23 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::dc) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Wed,
 14 Jan 2026 08:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 08:04:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:04:20 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Vishal Badole <Vishal.Badole@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3] xgbe: Use netlink extack to report errors to ethtool
Date: Wed, 14 Jan 2026 13:33:57 +0530
Message-ID: <20260114080357.1778132-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: a2828acf-5e49-42d4-2f97-08de53438793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyJ/mn5dH/cHdFfWtctJizi6XS5D1iybMV5wTuxeaMtBlqXnEVQPqB4dqmMy?=
 =?us-ascii?Q?+CEz/UvRA3jqZd3dn+nFd/ielSynwNC7dgruwenULokUWfb1SUQZ8sc2LBtc?=
 =?us-ascii?Q?oXptTEcqAm4tSwjAwlP6HBJLElc6QDwwQSWcEVnUUIPpEHqZTQMxD2H+fOgn?=
 =?us-ascii?Q?NuHByOQUjHeNVSwc55uhQCAPChrHv0GGWTXw5aaOU8dr4hxkfDqBpDLQ1oSz?=
 =?us-ascii?Q?UO+fusRbWGfJOfppw6iybjVzOIVf9kgjGU2cjffe0EeniWw1SjbffH7cjn3R?=
 =?us-ascii?Q?lJNraffxa2mQOHUiYj6Vw7Wjow8mSshEe+g64Sy6Nf4bSCfki4yHD6El6hpF?=
 =?us-ascii?Q?obY7SCXURUXw77DykdAO1A7EEm2ZviZyBWg/VYYlHSMh2WxwnXnH6Bgti2nd?=
 =?us-ascii?Q?6KzOpYQCfccqZ2C7eRKgUSIcr3VPxYZoYQXKQ5a49pM0taVEOn/dorJFaK88?=
 =?us-ascii?Q?9S7bhuUbD+yHNo91THB7m7LyYDM+m2MHGVDbC/DLSLLy810G9WJfzAO+l/86?=
 =?us-ascii?Q?HR0TOmPGM1R/K4hYSKgHEMGeI6U334BaGF5HZJkTblqW6i6NW+LTadrZx9cK?=
 =?us-ascii?Q?pDYy9QCgpHLsODGSsWylYSWHOpcE1ZPGEpWkiCpKy4FiSEeSHOv6hjp4vjvb?=
 =?us-ascii?Q?60glx+arYZ2NqKsKlZc+Kp8CUaCXdMvnRH/Czsu0DJCHSwLzMNYvX89lmAxT?=
 =?us-ascii?Q?7ecz5kddLZsDjvVk2HvVcAdLYq2cUxn1rV5MrNfqnahApzg4lg2L/+xpYX2p?=
 =?us-ascii?Q?QBo2SOOHlQ1j3l7dL1OPI8R2LLYG/8vUmOhP2+XcxxWptYQycP/Nu3TGSsb3?=
 =?us-ascii?Q?T3c675JEl7Krdd7NiFK6ZFuwaPfTzoRk9jj1ZxpIC0G3RN7hZS1YV79I6ZAY?=
 =?us-ascii?Q?QJA/2DhAr1bOTG1Awg4iiQXSgBSZCeu/d7JM1fqM9j3ww1ZQQnKlPskmabRm?=
 =?us-ascii?Q?I8+csDa8OKtA8qL9SJAVytomIdIr1vn1fYv0JyJ8FFjZO6LRkpTLdyIWLtcB?=
 =?us-ascii?Q?p9IqtjsQ9wY+pB64nEn6T4/yKVf7R89da6ik+xpJS+cFEJ1CsPM8MGr5zmuf?=
 =?us-ascii?Q?HdTXpbmtKTOM4ZrWHauabP2QH76T3KaE22s8buUEtlBCWmb4LsCk7AJRXkwF?=
 =?us-ascii?Q?IvJnspSTcXg3j/Na90ZGqJOBqEEDJulcliSaKRHXKe4/lnSkCGoxHnAqttcZ?=
 =?us-ascii?Q?X5xAnXBIUACusg8H4PIXdm/vUDhXVuQbg6RaPqgyVONlVDHFX2olk0pbhUl7?=
 =?us-ascii?Q?koNpp9dYlDScDoEn2J3r5s+3CJlN5HOhMz62cN20X82XQ9WW4JKmtokJmQzu?=
 =?us-ascii?Q?G6Mmd5B4oCVc3ZLahdYHACYMVya4Pct3PCO2n+v76oO+ncOYJV/I9lk6dvNS?=
 =?us-ascii?Q?apdVTMQvOT7sF2BEie9TBBt3zgl0p7W7+0iS2CULxQBQSnKonsHB0hys4Fvx?=
 =?us-ascii?Q?j9hrDoYpK8Sc6r4xAojOcZh/ba4kafn/EUxxLxFMrT3gdywGm6BFxRYcGyTT?=
 =?us-ascii?Q?Rv/GrGr+v/UUwhIGb9wQ3ZlZ1anvOBd/p/KVp3/yZAIVYhQvcevZtfmGnrNY?=
 =?us-ascii?Q?tgEFWLQLL2UY6uRAPlM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:04:23.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2828acf-5e49-42d4-2f97-08de53438793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

From: Vishal Badole <Vishal.Badole@amd.com>

Upgrade XGBE driver to report errors via netlink extack instead
of netdev_error so ethtool userspace can be aware of failures.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - Add missing Signed-off-by tag
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


