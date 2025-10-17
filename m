Return-Path: <netdev+bounces-230343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B9BE6C47
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C54FC30E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C023EA88;
	Fri, 17 Oct 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5svF5+n"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0D30FC35
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683667; cv=fail; b=MSBu3Dpt6BgcrHLlI5awCnYbHMmPSVbCsT9rwYuoCYQrBaDDrClyfv5HXOOa6Jus84TkSNKbmpXEoPROxpQ2rdUgVrV8J0cU7zvfEQERFIb26d3+AyCNBdufyySw3rtcfSDTqXoLeCbUGsqBBjkWI63Fwhz2ouDRNu688/rrH34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683667; c=relaxed/simple;
	bh=LdQeIXMZbSPeRaUowC4iMM5IxLcjYdxCThly0wRB8iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ5ihv0bB6iWhkrRT8ao4g7v1+cGObh9oVZxFEa0yasn5/wUx79gIf6ktj/iH8FcPS+2d0/RqGRKEYZyeUiCmn+bWgl02n1Xyi0sKpNgz8PnoGm5ZOiZgVXSoCePURd4q2JzAGcrngyl8w/YoESHfgshnGi/4Cva4M5r7pYK8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5svF5+n; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG6fCAF6t0trp7YsvuUrRLaYX8h/yQyfD1oT6O4E83MybASWqPkj9CeMLQfmB+L1E+szZXADO6VrF43M7Vt8/9kqcAnqwG/7YiLquGsH7fxPSgQ8fnQE+mxqqdsBO2EqKK7tSqvLSstPDF0LRmg/mn7DT1TSzPSfnGWslY3kGlOqei61TF3Ikvl8U5OlUEg9jziKGlLgoaRjnnE0leCnyTWGMwcqzR7nrzfMeZ3IHwNJ59y91O4bXpee6SpfOP+KGCUTJlSWyJ4AAX2+nqb52tILIyFmoKC8yMpXGkWICFl3KJhZ7uMVe0CUqtnwY0PR9yHrxY/qzbZ3dpRMH/Nn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSOt5do5xvRjxeUSlG8NjgVZxjgEbTtXTRXB4Dhc2mU=;
 b=p+mnsweyIwob4rff2PFMGhbU0h9QriuH3TkLLZz9L2J72qYOQwU2htt6ZfQXYRpp6T2T4jBe9m3Atj/ceOlVMDqJNm0ORT18O5mKRAo84T5Df2qHUOv0tglytQHd2bFr17yg9VUmZASU5MOzdl00YVHItrjJ42BdqK/mMOJrORJDSkIu9qpu5WQHt9Q3SXWeJ2Z4ReA/zvNKjOGSGyvMuNAXNozkGJDCFS2wCby5WNwd65epe8mvx8dvDiBXaZMQd9Jl3XJbsWcOeMi4UDtGCm25SDAPFUoKF7AhA0p6FYznnNZqFWIVuXBZWe3GwPumefvqM2j6onwGFRHgnwPC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSOt5do5xvRjxeUSlG8NjgVZxjgEbTtXTRXB4Dhc2mU=;
 b=U5svF5+nvASmSrbHbzXkN4cy+TH3BxyxGE8fnRLHJOQGTlPGEzp+gFfa4RtYd9RRb6gLCMtaBHFiMR5/kj3mwVGyRAM/EA1VZ8vDtKGKeHZDNKDrAq6IHX+c2jB31KpHXGbDgM2voGOOH8bSZNd/W0Fp3isJbBzZVQuAEyiyQq4=
Received: from BL0PR0102CA0001.prod.exchangelabs.com (2603:10b6:207:18::14) by
 SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 06:47:42 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::a9) by BL0PR0102CA0001.outlook.office365.com
 (2603:10b6:207:18::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 06:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 17 Oct 2025 06:47:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:47:39 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 3/4] amd-xgbe: add ethtool split header selftest
Date: Fri, 17 Oct 2025 12:17:03 +0530
Message-ID: <20251017064704.3911798-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
References: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 14179c01-14fd-4d3d-365f-08de0d4911dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D+Db7RMVBGBUVNEIpcZoKrnLVyDQuwR5qnMqeL7A1hfDceuGwv8fLb+F1/B?=
 =?us-ascii?Q?5tghDYdCCyBMinePoWO6W1FYBBvHdCmPue8SKGNnC2MAUytl1Rv9D2TkDh/k?=
 =?us-ascii?Q?SbNv5ZyJV8MJXm9TM0vbnIehLfkRZHbq2/GifSgYM60ZeyqLbXjUJVSFAA2E?=
 =?us-ascii?Q?/reVtcP6n5QKdM9XDniVuLjp8z01EBVFqClaLE9xLGgWWTcH833bSE/4YReN?=
 =?us-ascii?Q?U7fwlimd/1BBBV3yCouVLzd9R55rA6UGreuHWOY1bnlMFQ/iKEQg+4+iCLuX?=
 =?us-ascii?Q?1v/FyvOJN9kB/AeTnTMgPIPEPdvi0FWJptPphzODdRAj4Iup8FokN4Gdkyib?=
 =?us-ascii?Q?5uXmo3cArmRG7T61Sb5izVFrIn69i9KePTReZ9KUDYiDK5WDb4UdaCFl3nIT?=
 =?us-ascii?Q?0cXaiB4iWik+3ZoPZoGb3gKAb0W+e4rJBbj4Oautn8inskFMnyWX2KMIHBpa?=
 =?us-ascii?Q?kHe8flTx+XeEh+EYNXgGM0/XI7BF+BfNAjwaARQrKb9f+Usnigr2OHO942wO?=
 =?us-ascii?Q?/fNdSP5PfjEFBxa9vjsYMiMzQ6dXX7qWMPTNlvJ1pKenji+oiaT2KYVBz5IW?=
 =?us-ascii?Q?flJGygde5owtEzroa9dftMCJ97Ps/9bupk/xr0YoFDgKLJk22Y3DlC06Qnp6?=
 =?us-ascii?Q?nuAs6p7ieefd5ve1z8snJQN8OVdLBZ9D3ALD2UZ0Ja0tkvDVkT+jvFm8+2VE?=
 =?us-ascii?Q?yIODlPfZYB4FKFGeXw4STKw13iJC1yaQh6KZWMYVoQG9sgkvBf6b/FXbJSug?=
 =?us-ascii?Q?ng6hW6PQ1OxLj/nIvk5Q6bx9762lwL8VuVTKabZoVE5xjpnsaAFWmoFv1y1T?=
 =?us-ascii?Q?g9f6QFacZMIiw9M3ZLek84igoezPXHvKEeZsSvO7RXv3oW2jY0p7FLnsjT8R?=
 =?us-ascii?Q?/N5I/RScB9poQEtkBc4MPUyVZABGScSvWC0kXO88uAvWVdr3xVwOMawd49PL?=
 =?us-ascii?Q?p5E/YVEpNJo+laXjo/LFRzfj24t3mCIpEMmfKhK55+IW2EFDFBnG1KcwbEJo?=
 =?us-ascii?Q?a7zvXrv8hXhQ+4+LI+V0QMcK5wZeSZ5JSjs6u4yWbny1Jp0ZM2hX5u9aNbDp?=
 =?us-ascii?Q?9n65xbMzNyJrI3ncH3mCZfUuQ7jXrzDeBBvjr9eBNV9XjICRIhK6fzgG1HVL?=
 =?us-ascii?Q?pycLu3VAhNWxnsdXwEMZmng7alobH2lcipxPA8wGu/VwiDYVasx7lO57QseY?=
 =?us-ascii?Q?j8SkUkcnTMxROjN4o9hCmdDAKup0qE9rp91j9iu1zW0HiqYr7cNR2g7WerDF?=
 =?us-ascii?Q?ddKHdcu7PLpnhU/9sV1+SqbCg4myDIjeUxE1XSaYyqT6HDsgeV2qzW1ps1ZF?=
 =?us-ascii?Q?wBaGiJfpMmoM3LcC7X8GZXiYZeVFveH63e4Jaw8IokA9Yfj+K0L9ZPaHI8em?=
 =?us-ascii?Q?hvkJgd2ddcgEaEOG4BT7lFvCijQk3RyjBjx8UhaZZ/rgHOlTt60m4tnFljmW?=
 =?us-ascii?Q?Yqnoc2dZ4TiuJIR328VGx/l6933ESMcH0rt2EDdfYAT3qb40kRuQTkbnsm4h?=
 =?us-ascii?Q?xJteMAWTrMP57UZp+9Ua5/vNzXzu8JBIBNuyjtXiJ4UDNF7bmYWEzGV6Loee?=
 =?us-ascii?Q?LQO6HD9GfM4xaKmH9uk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:47:41.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14179c01-14fd-4d3d-365f-08de0d4911dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 47 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index e5391a2eca51..71d67bdeae92 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -211,6 +211,7 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
 	}
 
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
+	pdata->sph = true;
 }
 
 static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
@@ -223,6 +224,7 @@ static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
 
 		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
 	}
+	pdata->sph = false;
 }
 
 static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 0c7770aab979..ae7c8d6aca61 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -329,6 +329,48 @@ static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
 	return ret;
 }
 
+static int xgbe_test_sph(struct xgbe_prv_data *pdata)
+{
+	unsigned long cnt_end, cnt_start;
+	struct xgbe_pkt_attrs attr = {};
+	int ret;
+
+	cnt_start = pdata->ext_stats.rx_split_header_packets;
+
+	if (!pdata->sph) {
+		netdev_err(pdata->netdev, "Split Header not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* UDP test */
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = false;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	/* TCP test */
+	cnt_start = cnt_end;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = true;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback               ",
@@ -338,7 +380,12 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "PHY Loopback               ",
 		.lb = XGBE_LOOPBACK_NONE,
 		.fn = xgbe_test_phy_loopback,
+	}, {
+		.name = "Split Header               ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_sph,
 	},
+
 };
 
 void xgbe_selftest_run(struct net_device *dev,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index f4da4d834e0d..a51498af4aac 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1246,6 +1246,7 @@ struct xgbe_prv_data {
 	int rx_adapt_retries;
 	bool rx_adapt_done;
 	bool mode_set;
+	bool sph;
 };
 
 /* Function prototypes*/
-- 
2.34.1


