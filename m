Return-Path: <netdev+bounces-230934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03CBF2147
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A5FB4F7D99
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74A266B67;
	Mon, 20 Oct 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Y6Ghbwt"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8B26657B
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973815; cv=fail; b=uVXdhfOC9oQmehtQZ0EYiT05wHQ5yECFCg7t8DdZ5kvuJ4a0GZ/J9SqH/ZPF15g+Ps+frxN/yW5K/MoP5lDb7svQ0PCiUu3ce+TS/qklKcBldgEZlgxxV5BSWn6VqdHxrXIVWHGa+A1H0mz8PlhvplGsBzukhRSuwyTocbbwV/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973815; c=relaxed/simple;
	bh=lThA+Cia3RD0Xezdh4fria8pae01X34JjQYzA/0PN+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT+pxSDsjcZ40CJUqP8RWo/QuI8k4jNqZws1VKLZvYS+Anv3RQNwKdFl6EH1Et4aBGC+GC5ctLDjgdDX7aUWRY4hHqDF8DytA8mnhKYy8Ydr1jywJ11WV6lkMZQ6Bgh8VWAtqUhUtYGdTGmaV3IZQEjKDvqvyCei4SuKpKJoRXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Y6Ghbwt; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePKP6Y2sVIb86egbgKSOPXQsb8VhgJwDGnWL9LARq8I8yB8uIC5GoABtrG+2uVyF5bza3UQ6h3+e37DDE8wmx0mIspzlGr3Z4YlVjCBQyez40o6rWdgFApnsWQ1UfrNsxsllItAAgVsADdnlU5HIze7iJn5Q3h5iD8SNl2eka5AeFk45J2AMuEugs3tI0MVur0/HnCeA0rzH4UmvZqoO/a/Zd+uqmJGcaRUUy/8WfcP5bHoybJEIIm/F9XTOBEU1waNQmKmkT9MU5YlfGN2uxw0B0ca1pAbCnno7Gv7/280Tt0fFAwTHrnwqlh5v9wlvXc5zV2V93q/SJYGtTiKoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jwppz6pR2kdGflXSlctUZa4SF/uPkO9NFmcUt0EPM4=;
 b=p3txQtHP9b44QsSZYxSB34L9oIdpFkyBu6e5zin4mHW4JICxMgvSuzYH7edwXy2g6FeqcVg0gmLZbbdJldpO7tYfPwUPiwONwjwwX7hxyyv44YNoxKsqahY/HdvAIB45m2dUIb5FqC1MIer1t/78DxNz3b33/KC4RSzUNlNJAnfKQv+URCL2OiPFZfjoq7SzS2pqyz0WQ96AUCD4MxfyaKWFjF53oLosjJKjEnr4/OI5DBNfxBNS6o5W/88QIwKFR4BDKX9mJhYMnAe/uW3De2AyPdUUFvxTMtRhayq8o8pmm/S7cz4dbwQ5k8VfszgH2tuleLOlvXiGWJPoKoPDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jwppz6pR2kdGflXSlctUZa4SF/uPkO9NFmcUt0EPM4=;
 b=4Y6GhbwtF60Y8Xucxt+mS/PT2vkawY8EqsGdiYjswI5+mFFMfXB6F4TDIIBhNcK8ZC3WL0xON1/lzUPXWmiNH8jJKvQU8Ij6gSE8TCvozLgnToQXIb/BiUQ5CHh7itn9/wa850tkSs2ST3Bn9qHRlAfE2QkRCXBHUGAQgMZDsHE=
Received: from PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::21)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:23:28 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::b3) by PH8P223CA0028.outlook.office365.com
 (2603:10b6:510:2db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 15:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 15:23:28 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:23:24 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 4/4] amd-xgbe: add ethtool jumbo frame selftest
Date: Mon, 20 Oct 2025 20:52:28 +0530
Message-ID: <20251020152228.1670070-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9058bbbc-7b9c-437a-07a9-08de0fec9ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ct4WQeDAPPIK/lMe7G9C5Dy9eH5nC6Y8TMrwDSXlHHxcf6je9Z8/To5jExrb?=
 =?us-ascii?Q?sXPvbAQ4eSkO7emF3zG4/3sSzh1UHPa+3B8ayBX3uyF9Xr3xr1g4pi38ov42?=
 =?us-ascii?Q?ViRhclEsBoIAIIK83DRPVDCFEAx9JydNTsATAw7Ud+FRQKEBn3XL7fVeQQXv?=
 =?us-ascii?Q?K66NDAa+mXgduyyQ9FIGAT6JoOwtgqxKdQuW6sjymgK2A9Mpu/PJT0BiMxve?=
 =?us-ascii?Q?n8oc2VUgOPAddFodKR4ZRgbnB+hIvwVZd1k1NRn9uAjsz3qeegPaox4xadk+?=
 =?us-ascii?Q?b2jUVQqLvdW8T0WgGleJqA0cGUedjxI2nxeNi7P3rxYtcRQBymzeoe/jYGb3?=
 =?us-ascii?Q?lJaOTiV5ussIAk2BESbZZXFqtHV425mqeRRzePkiE2T0MLPREwnKZllJG7uy?=
 =?us-ascii?Q?hqOfSrUeYSMCZ9siQAgE5O6i2vGfIs2elo/8J8oY6jTzsBqtTg5YAoAJ9kZX?=
 =?us-ascii?Q?yWUovgOdZL03kFxnx0E/xfXl/dtB8axnRUWbKhO102bH0mZoylwP2BNhCC9R?=
 =?us-ascii?Q?NdwAtTlncNrZWhKR0RJUBuG2/wxQFHGJg2VLeO1a8Nco2C6T7KUT1CUbHwoI?=
 =?us-ascii?Q?vbhSCt5XeITdB1ETfKnN9EoIyfPVbO+UrZYj4RnnSFBP7eEUt7eRvashE9Sd?=
 =?us-ascii?Q?kU0myMfRudkpTbcs7UvkBl4OkJi2G60KCxzYfYLGbIviZEl7rWFKQ6S0GnRg?=
 =?us-ascii?Q?jwToWHwBj86t7oD6cINCJFX9YI4wdAiVG76P7hU8mjBo1pT/JER00me43Se/?=
 =?us-ascii?Q?ryrlXTgAtwj80wS1oZ5Zp+lAS1wDm+DEVWY3SBkykG2hgJk24cHkH90xwqSa?=
 =?us-ascii?Q?aYh3H176D/U8c9GgDc6lR65yFJej4YqibjYM5TPDOmDRJpXnllELvtmrtoTG?=
 =?us-ascii?Q?CpWDAL03Kj3QnjT2rRDvgVr7LPUFMGI4qwUVDWAXEoKUp/TH+MslfSAJddCU?=
 =?us-ascii?Q?DxOfTlVFLczGK9x6vzl5i0pzV4c1G/rukkGKWWAqKu/822VdQZLW6AlkoEVH?=
 =?us-ascii?Q?M2v3j89cswcxhq7a3LqMBYMZiJr4L3AizNMW9Q0F/WTc3VW0sVNPMwGNhdur?=
 =?us-ascii?Q?SXRmq+zrcLzijYe6E8i2pi4eDdWC3n9543/N5YV9vXWmIItA2pCL7GFzRvaS?=
 =?us-ascii?Q?0YdikU+F5mIBUI62sAJcO6LiL/TuZyJTTSZfrA1wcSfTfc2jE8DC0ZhjSZ/a?=
 =?us-ascii?Q?mIrmwJ29sFa/uL8RyE46T7zkRu9lZ0C++sQEFlpChGnsDIHqwTDLZWVuTt9g?=
 =?us-ascii?Q?tXM6DBDG0HVWJENNARQBRTtb1VINGraMBvGw1vmMStdvTAus0mcVHowZGiG2?=
 =?us-ascii?Q?0NnyJswu13Gbt+pJQoXZVm9BJM4epfijOiiEbq1sPpsRU4zMHMgv3dIcdtwH?=
 =?us-ascii?Q?y+2aYbt4FT5NKdbQX6rZGKKcSHbUtfrFbQ33gPWH8ZzWt24lbdBgBvke0G0o?=
 =?us-ascii?Q?Hq4gdLw7CxGtemG8IMFpa6N5DqLAjqa8IQGU72fdXP0ubw4KNOXIsZEbAsHD?=
 =?us-ascii?Q?CMbuX6MBUTUmWPo/2mFnWKrfIw63kqO/u8HTwsoD2e4vBkEpCb5j8l4mUjsQ?=
 =?us-ascii?Q?hr9FE942hvtqMvr38nM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:23:28.4485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9058bbbc-7b9c-437a-07a9-08de0fec9ee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 25 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index a99ee37bc4ce..b7cec176d308 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -207,10 +207,18 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct iphdr *ih;
 	struct tcphdr *th;
 	struct udphdr *uh;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
-		goto out;
+		return -1;
+
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			return -1;
+	}
 
 	if (skb_linearize(skb))
 		goto out;
@@ -379,6 +387,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
+static int xgbe_test_jumbo(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_pkt_attrs attr = {};
+	int size = pdata->rx_buf_size;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.max_size = size - ETH_FCS_LEN;
+
+	return __xgbe_test_loopback(pdata, &attr);
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -392,6 +411,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Split Header   ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_sph,
+	}, {
+		.name = "Jumbo Frame    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_jumbo,
 	},
 };
 
-- 
2.34.1


