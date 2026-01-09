Return-Path: <netdev+bounces-248387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0BD07A5B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F4973017652
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110E22CBF1;
	Fri,  9 Jan 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxAl6v0Z"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50954263F52
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944968; cv=fail; b=X9GpwGTouDFCoS4w1W9Pwt7+DMG5SAjvAluHShNpbVSleOMHBhWE1g1H7z9KJj8XZ7wIKSPwmeMPutk/Z0U/4MBxYnB7M7RFS2UIWVCo2/Cbpw37X/+KV/nbhQH1GvWUvuAp2aaVM6+9TPz+8ggc1J4LBwfiGGUW2kwyPi7rJ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944968; c=relaxed/simple;
	bh=JMOtTecySrpW+E3VmlZ088CnxXcv4TrQosmEhEBh/Cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dYJ8J++Xz4lgRQ+mAsctPycv5XlLj7OcFaFD92p+wCxAc979CTFRyl2IpGgvNuah2kpdSV9d3Ut4a4x446Cu5OmfuhQD2XfLyxoRDltIuH3p44qF63HxZjDrNeJzizJp30IOZksDs0sDFhmAh9gqCFF+F/6CIqaq3wvDTnhCEKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxAl6v0Z; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9L7z5atLzYfELum4vtCQ3YBG3HIYw+g4X9dLMwbS8AocL3U/qt8oM+sun1icvLwYS7WbiuynNzFAH3upBuAzCxqVL29qHrtjwrnvIK7+VUpWJoJ3hPHITKjfmzso1EDJQHO3ey7HDN15DqDTWdOgT7cR7iQNqoWJ5nw8TyCpZFj0T1ZjNToqPVFjcioCAsdQlT42xNnPPrdK+wazNFZeU4Bo0gu6hIJFPjINKXS9TmGcqlAX+MN/1QNRCNvtrPZrVpXB8FpuY0+PRZ0tX0TQdSvbCl3wYGzD+ApizVJFzIScypnHQLtgNAFm9qEo071mhk8mgl1vBEkdVYPie1mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRUAvhswlXTjxItOfaddbFWL+g8ZPzce2hyeQYqbcHg=;
 b=WzLOwyjsQK7KBCWXfQwbXLwSscSKyYE83lJONVHkuW022ZVsbJ6FfQzVLnNQTLmpFXq96RiWxQOKEOP/DM+SQbB4dK1JIg++AF5hSgsNEb07/dA3WXQDj9kZ5gNK6nhFPtlIBGsyuS1vqC15l9e5azwg/8keXgVIJjMMxS3acEH/p5C1pXqrdIv2cGQ5Wwl9NaxLV8AM4U9cesnjpluatBMOL1QmhwxIMHppFxAjq6RkQjTFck/qv5NCf97BsXDQPoSJqaDphKyNZFb46sgBkiMGvCfp3ra+8Q2ROkqehy/Bl0ir56eAppongLG1GapTCUa4wzeFHMMCg+q+vsSrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRUAvhswlXTjxItOfaddbFWL+g8ZPzce2hyeQYqbcHg=;
 b=QxAl6v0Zk2IVqyripze72rmq1ZZ26xmF+Fa2A5IOpI2226/2M88lDgK0PWg50u1iR+pVSoYyLx4ynlN2P/X1k22jDOACSY6cMxTuPVOg/W5RnSMfaAsPzW0kz2AQ3347M3Pfxn1rV5kGDbJrTq8k6T9k0O0GuHCETU4o9t/oFzs=
Received: from SA0PR11CA0038.namprd11.prod.outlook.com (2603:10b6:806:d0::13)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 07:48:11 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::2d) by SA0PR11CA0038.outlook.office365.com
 (2603:10b6:806:d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Fri, 9
 Jan 2026 07:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 07:48:11 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 01:48:05 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Vishal Badole <Vishal.Badole@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next] xgbe: Use netlink extack to report errors to ethtool
Date: Fri, 9 Jan 2026 13:17:46 +0530
Message-ID: <20260109074746.3350059-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6507b0-ca78-4728-3399-08de4f53702a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpZfiKadHQ4OaAZ9oh69HeEoSqXByK+qyd5BAY0C3D9plD+sMCckq/A+ODKH?=
 =?us-ascii?Q?hHTp3I5knw4HZWQwKT20tUF//2whQEOILRJL8HXGdNazom/EcATESeJjhk+S?=
 =?us-ascii?Q?dblZMpNnnV9Kd+XPWCT0jqjLeT7JcEXPQmmw1PIPQkIz6JiuvEvZGLdAv2vw?=
 =?us-ascii?Q?Z1PTgF2wXp0nrdEn8g9mLEuf+lb6AIs9A+Oi9rcWzFxqIBLPV5KMXJXKXp+X?=
 =?us-ascii?Q?RG/g8H3n86ftzAuDTBQqOsCvf6+WxTVRTgvZIiQVStw/l5go+ZG5xMq5WIow?=
 =?us-ascii?Q?MNK4Y53iH6XfViXtGwP9pE2/uMiLLHNsJniIocHMSB5NCBJrPUGOZWjnQ8NT?=
 =?us-ascii?Q?xxQy0RQ19NKGz3rN3hpmA8eF+CkP3Ni0GvD9BIQ5e0b7xuHu0XhdV3CFK5TU?=
 =?us-ascii?Q?SrWY6DZ7YSFbybufO5mvF/ZeuiGl+Vgt2Uxh5X72cnsJsDk2/2LNu1EVA2Kq?=
 =?us-ascii?Q?Ta8rGbpy31+yQXD/Z9S9kH2ADyUGQg6Y7qLmVyBsZ3r/kVhd81k7DApjCUC9?=
 =?us-ascii?Q?pKY/9JzntAZVdQtW1arb/YZy/zvE2EsLPv8Asi/P9QNaBL2s6i+zCLvLaKfW?=
 =?us-ascii?Q?AG2NBlP09Fmu//1T0ncKYpRlfbVk2de1wEZW6YWT5e9XxEE4Iy6tfLwOUv+C?=
 =?us-ascii?Q?HYzxXSvibij+14UfR5o4gsw/cv89J9IMHmjmycJ/gMm5BMlX4rRKngwQ4lcF?=
 =?us-ascii?Q?mOL8YqEKkolCBqsPhm5AU1L01wn2eEbVHuuoDhnnjMMozghKj116GVQU8eP1?=
 =?us-ascii?Q?H0jhZ1bhiTdiToN9h/1NciN5+pERZ4uq1J25xiyQd8b3fA9hXEw/eziLjqZP?=
 =?us-ascii?Q?5FqWJbdwp5H6XO8OkRONR57juCvT6moZUkUiBAPNYiJJ6LW3z3ZKROXNVMHx?=
 =?us-ascii?Q?qcVWcwjJiQJ5SNQRJEMPwOdGI0aZfzLafYSjSS5EJWG7UZZAPCDAyopgW4BD?=
 =?us-ascii?Q?3OvSdkKYW11mHSrdPumGE6K8JAFWHrMCRnTbauqmYF1gA3j9Dwy/yJkynOD0?=
 =?us-ascii?Q?A9ScbZcfHxHn1H4Dz9R+aJIRkEnZvE4EkZCTFvegCNFHHsuZ2TjGBswTnb9u?=
 =?us-ascii?Q?tZKuRmv0S756o5ez8qNUHcgJw2JSYH5bi9RXe8ivVh2Bjv5iRWSwZS8zzHH6?=
 =?us-ascii?Q?Z2l7bSge0tlnNsFDZe1yIMb3FeAgSI/W8s8HCTCgWQnorEj+yGj4VUA/Jo4/?=
 =?us-ascii?Q?H2c36A+q6UNh0+tHuBMzOFmXlenE9216YEUo+vnRy0gb/p2whP7nkoPvaeVn?=
 =?us-ascii?Q?2DUC8Qs+pptEUEEO1ClRVk1QJZxsJPpHcYgKSSeHGlVOaI7VDXItCDpqxtep?=
 =?us-ascii?Q?b4pQLwHZWxZkZWp9LbwYr/FWwWoAK34ELgV0tl95sn8N1ey4mElLsJaux0dw?=
 =?us-ascii?Q?btMde9MKoJo363l25YITjs4ngJQ4HLQOH0+f+nKjAdMCyPKu4Q5jMGa7vLG0?=
 =?us-ascii?Q?mo4qNVtIng4UTjw8WqqPd7qMrPAv79+r48A/Zgw0YYVlQnMxqzBE5Nr2XFgg?=
 =?us-ascii?Q?oRu5boPlkz8ESxco8l0fBZAzt+i2RLURZVFYYOSB5w1t+dxc/WnZmrTAI522?=
 =?us-ascii?Q?q+tmp+NtqxLg+dM6G7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:48:11.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6507b0-ca78-4728-3399-08de4f53702a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

From: Vishal Badole <Vishal.Badole@amd.com>

Upgrade XGBE driver to report errors via netlink extack instead
of netdev_error so ethtool userspace can be aware of failures.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 46 +++++++++++---------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 0d19b09497a0..0d1e979c864e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -362,13 +362,16 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 
 	/* Check the bounds of values for Rx */
 	if (rx_riwt > XGMAC_MAX_DMA_RIWT) {
-		netdev_err(netdev, "rx-usec is limited to %d usecs\n",
-			   hw_if->riwt_to_usec(pdata, XGMAC_MAX_DMA_RIWT));
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx-usec is limited to %d usecs\n",
+				       hw_if->riwt_to_usec(pdata,
+							   XGMAC_MAX_DMA_RIWT));
 		return -EINVAL;
 	}
 	if (rx_frames > pdata->rx_desc_count) {
-		netdev_err(netdev, "rx-frames is limited to %d frames\n",
-			   pdata->rx_desc_count);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx-frames is limited to %d frames\n",
+				       pdata->rx_desc_count);
 		return -EINVAL;
 	}
 
@@ -387,8 +390,9 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 	if (tx_frames > pdata->tx_desc_count) {
-		netdev_err(netdev, "tx-frames is limited to %d frames\n",
-			   pdata->tx_desc_count);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx-frames is limited to %d frames\n",
+				       pdata->tx_desc_count);
 		return -EINVAL;
 	}
 
@@ -474,7 +478,7 @@ static int xgbe_set_rxfh(struct net_device *netdev,
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
-		netdev_err(netdev, "unsupported hash function\n");
+		NL_SET_ERR_MSG_FMT_MOD(extack, "unsupported hash function\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -561,37 +565,39 @@ static int xgbe_set_ringparam(struct net_device *netdev,
 	unsigned int rx, tx;
 
 	if (ringparam->rx_mini_pending || ringparam->rx_jumbo_pending) {
-		netdev_err(netdev, "unsupported ring parameter\n");
+		NL_SET_ERR_MSG_FMT_MOD(extack, "unsupported ring parameter\n");
 		return -EINVAL;
 	}
 
 	if ((ringparam->rx_pending < XGBE_RX_DESC_CNT_MIN) ||
 	    (ringparam->rx_pending > XGBE_RX_DESC_CNT_MAX)) {
-		netdev_err(netdev,
-			   "rx ring parameter must be between %u and %u\n",
-			   XGBE_RX_DESC_CNT_MIN, XGBE_RX_DESC_CNT_MAX);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "rx ring parameter must be between %u and %u\n",
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
+				       "tx ring parameter must be between %u and %u\n",
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
+				       "rx ring parameter rounded to power of two: %u\n",
+				       rx);
 
 	tx = __rounddown_pow_of_two(ringparam->tx_pending);
 	if (tx != ringparam->tx_pending)
-		netdev_notice(netdev,
-			      "tx ring parameter rounded to power of two: %u\n",
-			      tx);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx ring parameter rounded to power of two: %u\n",
+				       tx);
 
 	if ((rx == pdata->rx_desc_count) &&
 	    (tx == pdata->tx_desc_count))
-- 
2.34.1


