Return-Path: <netdev+bounces-214306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150EFB28E71
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF4F5C0549
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55912E2844;
	Sat, 16 Aug 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYmgzF2u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E72E54A9;
	Sat, 16 Aug 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755354018; cv=fail; b=b9pqz+61qjhXy7cHzTgKfXqkUFQ+AD3TRzeXBRjPbA/d9pINWDteuqm9iOSty4CZCPIP4QPGD5VLcVjVgqvMDmp13ZZWxzJGyI9s60q1Ulqw/cxmf8HEpBZFmJIRh+yCMdEHi/B7GlPrLDWVQ0A8Jj9qwyjZhNGavKOrP0vAF2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755354018; c=relaxed/simple;
	bh=ZzHh/FX2VUarM6VAtidCcdid0aKKvKjEXFQ9xq6FoKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZMATLlfD7Mp/r+y2Zst2n7DiWNZQYl717dcwbX2fNWNwHmKTpRLZBMPB/8RCFEJRVEOv9F8rx4wiv1eT8MsvJVfhY/IPUIpGt6Qw+X4NgD7UiMbFpFWScHWlx1ztaZawRGnGuYkZ3vi0fIHYS1jlgc0DUCJwVwxFXPXQhNqqjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYmgzF2u; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soa0CQu6m/k/WDxe5MhZFrJIPHSUOc+O0i0NeWIpoCwJCT52xM1erSkRVr3oAOcE9JHKoIkM3WGuFgVlo1FOd7o5ThC8f9NLE5z/e1gcZZeMoYNNnDAsJIYzc8W0ZoZsQRqwkS64ykJ4LpJoNpB2HOCbj4+g1y4tGiO6D6Q4FeoWPoLf819PKa0KIYlsT+9Yu/HTWe09Zg+jNKF/wi6JUmdgLYppQOpHlnqb7oWkUL61kq9MHN5ePbcHPs05FUAtr91hcR1UELnRdTQaj8vFfDBVtxVmU7oELQrtCEDYZNehJkTjOiihUJHH1VzBTo4KCN+mffZTkmeEVNVBZCus9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZvJJ2uJbu7UtkMQXt+brTrsJh5ZbvCAnC2GlBpDLGQ=;
 b=ZtlX0zFGMRpS+STxPGrMIWVnbx/glc0TInLs6J8XeBRDYaqrrS1VpYdqzGjUPwcPeH09nZ9fBhKyJVMtTInGCTGsoMitg3UIv/QtUwqziffRBnaP2Cl7wEKHHr2AmcmF9ZekfaYpbAFhwlIto0IAExhMmYkUkk+R/0jwzMRkvmDO7Z9GWbPFPnitEvirtgcu/UPkbNDCN0rx085xxf8xwcyfK8k0YiV35rB4t9aoj3du/B/k2A2+mWDOGUGZQrBFfzN4IKxKgqax9cWtOLB7NSgRtRBkZN04ok7oLwfVip8/NMonFh2ibFV1YDvkV4uFZWzZ4a3JhqD3QF5TIzTmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZvJJ2uJbu7UtkMQXt+brTrsJh5ZbvCAnC2GlBpDLGQ=;
 b=uYmgzF2uygM+0r1Lk3LcgYtYwLBgcLSr+AHw2Ycy4g/AQDfb8cy9c2WBf944CyVDIEbU1qX9K8CEY+yT42ocRvHv+u09gwSduPxl4OgVT2+iLbyXYeI1xSD3QZFE7NgUe9TeYMW4A3C6JfP4ZfHDnMyg+w+qNSfPyFmkddL3dd4=
Received: from BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25) by
 MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Sat, 16 Aug
 2025 14:20:12 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::2b) by BYAPR01CA0012.outlook.office365.com
 (2603:10b6:a02:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Sat,
 16 Aug 2025 14:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 16 Aug 2025 14:20:10 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 16 Aug
 2025 09:20:01 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v3 net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing
Date: Sat, 16 Aug 2025 19:49:41 +0530
Message-ID: <20250816141941.126054-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: a21f42b0-e178-4f62-09a1-08dddcd00294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KQLaGeIH8DHvX6L5pUptYLeOEUd9JvQVUFE8Z/exHCVe14rltCPepmAPHDf?=
 =?us-ascii?Q?iEM8BAtgoomXfJu0+dG+gEV3TtVZPlRK5pKV80hNl+WfuoscxcIqpK/TaVkE?=
 =?us-ascii?Q?FiCTzplieQ6f7CfB4iZH0mjV0n5hN+LbbTDKoVkjzJBuvhIXvrEiYp0MA9vr?=
 =?us-ascii?Q?SvJbAKK2Ept/NWyX7mGmyDLkTyE9gWojfW/+v3EOra8vPjPk+vZN4ZP2JrIv?=
 =?us-ascii?Q?wucVlgTvf1pQaEehOyiPoYH9K140htiD3uCgHPrUzfZGYCqBGRIB0GNGjWuJ?=
 =?us-ascii?Q?Oj9EDp6ZBCpZkMfchPdzizum16uw54sSyrB7LMgeGqDrje79UXppwEyGSEQl?=
 =?us-ascii?Q?0g2Lzc4ZA2RxBkVmJ8glN5CYxllxANkLiZ0Qakzz0hdtaYMOb267aL2kCAvW?=
 =?us-ascii?Q?huBi2JzOlyQ/qzqa3aQ6dCw5U2vo3FksIrTpo5P2UWw1HbQGeUnMKEz9htj5?=
 =?us-ascii?Q?6Is1o7zqSszHPtHd2nD/68yMALrPYIbz47Ea5qBN1anWVNMw4W90VmKgPqkL?=
 =?us-ascii?Q?W9bc1u33lromQAgh/Wf7dLdiWiZu/iChaq4mboEvCZOEMGG0++ZMyy9kgtLn?=
 =?us-ascii?Q?Evu9jGSHJer2fwJMmLsVvetr/tzQdTNRPsCegiDhYiyCRDzqVY5mNSo5Y5B9?=
 =?us-ascii?Q?2S2iw3Al3ws7os2wLMgxD3iiQ1mu0Q6uzeFaTwf4z4Mi1gILnMmTnDTwboWN?=
 =?us-ascii?Q?ESEJonCOTpiv+IOQTdIH/p6s8oHaIS3ZulbAtTRWtEL/jFaFBtsrrbM9IrX+?=
 =?us-ascii?Q?ZozOc1s3Ky78mtpfs7Z252emzKm+cQZrntYmzbYDIPEspyTorWQOVpiLEeAx?=
 =?us-ascii?Q?Jfpzprs/LLK7GT4I7UmNXrjXo8eXeb9RqGO6KdtH83ipo4/pyeGvjTEs1rGW?=
 =?us-ascii?Q?TShLsaIKicxjMNrZ1QSQfzOZl5URGxRbyCP0Gwa+0hdR63zUyGaKQwhSvHCi?=
 =?us-ascii?Q?yRrkhEU7jCFR00rh0Qslw6RZROaLw10D8VcecS1RLFS50wtOEUjf9dVGJKvq?=
 =?us-ascii?Q?TSAXPV0kDgsw8TixwhIyTV1NwZRfnfeaHtG7xQGeDW3dnCm8l7ct9b7bHNSq?=
 =?us-ascii?Q?x0Lq+MSvHl04TS9DQF40+GQR+6YwzzLVGDVaoP707IpL5ZsZjqO2EDyEKA94?=
 =?us-ascii?Q?ZOmp620uu6//KXwk58BsmkF9J+qPTz6KBBla3/Al6Dx+I6nZV66v8K8ZyrF7?=
 =?us-ascii?Q?A7/EsUo+lJi88neTHfPkCygoorDh/9mNKYs3Gdd6jZeVm/I7/jYQz+hM3wfT?=
 =?us-ascii?Q?dMiqb7voXgOvHEELU//7reSYYmzsvFgbj9g1sbugM9zl6wcq8k2fi6PON8Wg?=
 =?us-ascii?Q?meQeiyWXlKz+Hi1mx2aOGdPiahQosNHGV54KX74WSyY4uNc9au+/rjZPL1D+?=
 =?us-ascii?Q?lz9QhXBkdv11u+KVSFu60JA0JkDEEU6kZkiIkw5Ip6mmHFw6FogpA6sw8RP3?=
 =?us-ascii?Q?puuL36rXLZZg4fA2xqkaxJoVScIMROKymQBcXEwKB5WtwL9blqimHuDE0lkV?=
 =?us-ascii?Q?41cHoCzEjc9jwmU95B7JMXZspluHFWD0Vz+tNBV2e958VWs8xVI7XXtzgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 14:20:10.9683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21f42b0-e178-4f62-09a1-08dddcd00294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301

Ethtool has advanced with additional configurable options, but the
current driver does not support tx-usecs configuration using Ethtool.

Add support to configure and retrieve 'tx-usecs' using ethtool, which
specifies the wait time before servicing an interrupt for Tx coalescing.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
v2 -> v3:
    - Update the commit message.
    - Ensure tx-usecs value must be non zero.
    - Round tx-usecs to nearest multiple of jiffy granularity.
    - Link to v2: https://lore.kernel.org/netdev/20250812045035.3376179-1-Vishal.Badole@amd.com/

v1 -> v2:
    - Replace netdev_err() with extack interface for user error reporting.
    - Link to v1: https://lore.kernel.org/netdev/20250719072608.4048494-1-Vishal.Badole@amd.com/
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 28 ++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 12395428ffe1..0bbb0decdae8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
 	ec->rx_coalesce_usecs = pdata->rx_usecs;
 	ec->rx_max_coalesced_frames = pdata->rx_frames;
 
+	ec->tx_coalesce_usecs = pdata->tx_usecs;
 	ec->tx_max_coalesced_frames = pdata->tx_frames;
 
 	return 0;
@@ -463,7 +464,8 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	unsigned int rx_frames, rx_riwt, rx_usecs;
-	unsigned int tx_frames;
+	unsigned int tx_frames, tx_usecs;
+	unsigned int jiffy_us = jiffies_to_usecs(1);
 
 	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
 	rx_usecs = ec->rx_coalesce_usecs;
@@ -485,20 +487,42 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	tx_usecs = ec->tx_coalesce_usecs;
 	tx_frames = ec->tx_max_coalesced_frames;
 
 	/* Check the bounds of values for Tx */
+	if (!tx_usecs) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx-usecs must not be 0");
+		return -EINVAL;
+	}
+	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
+				       XGMAC_MAX_COAL_TX_TICK);
+		return -EINVAL;
+	}
 	if (tx_frames > pdata->tx_desc_count) {
 		netdev_err(netdev, "tx-frames is limited to %d frames\n",
 			   pdata->tx_desc_count);
 		return -EINVAL;
 	}
 
+	/* Round tx-usecs to nearest multiple of jiffy granularity */
+	if (tx_usecs % jiffy_us) {
+		tx_usecs = rounddown(tx_usecs, jiffy_us);
+		if (!tx_usecs)
+			tx_usecs = jiffy_us;
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx-usecs rounded to %u usec due to jiffy granularity (%u usec)",
+				       tx_usecs, jiffy_us);
+	}
+
 	pdata->rx_riwt = rx_riwt;
 	pdata->rx_usecs = rx_usecs;
 	pdata->rx_frames = rx_frames;
 	hw_if->config_rx_coalesce(pdata);
 
+	pdata->tx_usecs = tx_usecs;
 	pdata->tx_frames = tx_frames;
 	hw_if->config_tx_coalesce(pdata);
 
@@ -830,7 +854,7 @@ static int xgbe_set_channels(struct net_device *netdev,
 }
 
 static const struct ethtool_ops xgbe_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.get_drvinfo = xgbe_get_drvinfo,
 	.get_msglevel = xgbe_get_msglevel,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 905959035a40..8f01f9a2be39 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -272,6 +272,7 @@
 /* Default coalescing parameters */
 #define XGMAC_INIT_DMA_TX_USECS		1000
 #define XGMAC_INIT_DMA_TX_FRAMES	25
+#define XGMAC_MAX_COAL_TX_TICK		100000
 
 #define XGMAC_MAX_DMA_RIWT		0xff
 #define XGMAC_INIT_DMA_RX_USECS		30
-- 
2.34.1


