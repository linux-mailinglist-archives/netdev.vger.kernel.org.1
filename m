Return-Path: <netdev+bounces-229352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AEBDAEAB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233153AD4C5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6A30B522;
	Tue, 14 Oct 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xzv4nv67"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE52D876F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465549; cv=fail; b=eK/UTOFG0iKgllytqyynb71dZdgKmM584HcjBktb257qg4sXpDW6EL3j/dwznIM1AsoHxprTyURnGD7ImHfn9Qkbeq+lUTnBJortdWkpZPg8GJYfzRvn+R7dPvt1ZvfgITEUOyHwEoDzhSNAHFHYHKDk2hNDOzfYFR/rvuLRE1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465549; c=relaxed/simple;
	bh=xv89tnx6Xj5HDZyk2VUF/9Jg5zJ+54aKef4PodC8d9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcrH/EtgTNus1WIRMduSsOUsWDv0kJ3+pEWpI+e3KYt7R9aVG9fuyyGqzjm6TMwYFwMfYGL9qoyj1Z1pFExaRpFGFlRNIiqKECyEe8xFvGrFKKPmSZ7J5/gTNPiuF3sAGNCb7gHda3b+WoKP6L1MYHNSXTqhXnz/TJhosInomn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xzv4nv67; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ici1+WjjX+DyI1YjjRg8wXE47Rla3PvfiJjo2a8TKuCRD92mWwRMEydymgDz5NgZ2y2YnqpBn/6q1Nb5EyFTJcEbJz8oscycVAhPm5tg/2PgNWfV6loy6lzE7Gh24QHO3t8FH7bwSbdHvJ2LH8WGpNaADcTUMESj7hBDchnf2EpTbFlavPOhTzV1QEbuW3AWwGsGGs64OVQMt8IUTCiDiN+ClPfwpcByOKdR0965hPeSS9ZC5XypM3w7Lv6a9+kXSVm5+GOIxjZR4BrNnUJlR1KPsMntuz/fDmOodEfBUhNo7hPfb4O2P2TWWJCzxl3EaYU8fKyFsEh5l5q1/k+Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk2ghJl7nqUoAf7lL3hmhT/rIpHDFmqaTXxnNcL+D94=;
 b=VwHEXgyUSR5BNPjXkMVSWgj5cHDcvaLDDF0tmG4Tt3o0tkbLI4sVCi2g1znFDQXecEf+vrPSYvd7ryGcPWWOvbq1WCXdV+hCfTDZEXpOmk11+l6bemmdzcaXdgl/D2QA1HNscSWKIwiePxymQE2B1r9x6CIxg42oXWPQ6VkA/ZB0i7c7FNB1GQRoxBSv/hkiptOQvpxwqS4Z3RNuL1kS1DybEInvorSdhcydTUhWmXPXRT32Vc4adROOfafJ7M+hJXjPj75rVYmt1RLqyHiLTDJwHc4uDynPV+DHsvgDb4GWC99GrCktfrh3/Hz4pGtKu/QnQQmhmS6kqaRQ3Kcqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk2ghJl7nqUoAf7lL3hmhT/rIpHDFmqaTXxnNcL+D94=;
 b=xzv4nv67+bTL0ZiUQQLiz6Tw+84YFNSJq7rZV83odd1tbZxm4MD63APkcH3mBhDcbo0alx+3s6NkKe/oBigCCuwfC2/C/b73E7oV8HMDUfg/rYlBYas6MH1BbUPA9/OJDecRXE/Xp9yahZI0Fw4VzvCPB85Ati2UZEnalrgQt8o=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 18:12:25 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::4) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 18:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 18:12:25 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 11:12:15 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 3/4] amd-xgbe: add ethtool split header selftest
Date: Tue, 14 Oct 2025 23:40:39 +0530
Message-ID: <20251014181040.2551144-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
References: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: c6942c38-b499-47c6-b528-08de0b4d3a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBxJoi+KW16Jw1EiCN2RGkr5A8TgwV+h7tWl/Qnvgnc1IN6yVFcHHmfqKTKQ?=
 =?us-ascii?Q?JncZGCtVBmrAyxJMvWMN8Kk9Di19AMzRTGrllFIUuyYU6IbxPV14YneQWFRJ?=
 =?us-ascii?Q?uOijC2+ACwLhFf5efed7Xlmvjlbukvzc1pPYrEfbJzfsogyGc23+aircty+h?=
 =?us-ascii?Q?ZDWm8uqX6O+RIcSVXLXkirbuOLtbN7XGhogHiMDIncW4Rw3NbYjyOt3faenH?=
 =?us-ascii?Q?YYRx9qfN1SB9DS1oANq9JQtYjPOu76+iMcldB8kQTskBDryv5ozG90Yui6ih?=
 =?us-ascii?Q?YpGgk0MkrxEM5YpcMFy27P6oKvw3RgOaJzJlzAO+oWd+2NtePaC9g7dpBF7N?=
 =?us-ascii?Q?7WGDLoBZ8GuG2GBd8udhHF9LQjqW+zsVrB/QoHKZOBy4JyZb1XVJUxyANOsS?=
 =?us-ascii?Q?YE7/G9XCNtp+qPewfnFP/d8V9d+0XhxGn5PMYEwmcyrt+mn5l1MbPpzkP3F6?=
 =?us-ascii?Q?NZ5sQOvmXIs4ptt2euSoWQg5HuReryXFGGMvtnQxCjXhqn9vpEtma0K/m3sj?=
 =?us-ascii?Q?bU03ygHniPVM7LAvrRRXf1qn1Qnxbmu/cbjUneXgqC4r7Ea34Q9vYfbWGnQ/?=
 =?us-ascii?Q?vO5M/9uHarga0jtTph7b1oKm4jXh4NtrjMhR9IpmnJ9PD9FflfamqiqtaPUX?=
 =?us-ascii?Q?YP5KBHeGGIrZi/mufIIOKMMqPvmhXoQjJi1W5l2o3kzELj0ul9IC8TLRqh8Y?=
 =?us-ascii?Q?K5ggpQo8tgsRvGlkIFa7nIGtzbke0/dAFtTvnsr8bGm87DSb672vwoDDtDy1?=
 =?us-ascii?Q?VHJkmOuAcPitcLSZM4DpesD7I3R7oYVQWiioO5o6N2IFPY2RZSACUndlCNz5?=
 =?us-ascii?Q?/xIWHOyOHspEBuJHKPstssBMJlAvx5OKD23ZE9b3xE7LAUtmhkQ30Cu3I3bB?=
 =?us-ascii?Q?Fjo6WV9ksov8wQumZ5D3x4XShotfRpDUZFCWNSzy5KNuaJCNc2a5pe4j88ZV?=
 =?us-ascii?Q?ZtZeOozyDtO0B4rukyJt8dfSaevBEqf/idACjxjuHHF+c/FyGx5llHb+A1Uw?=
 =?us-ascii?Q?96yoNeFfT9ina0CQysaJX2A+j21LDVJTDBZFQ8hoFuhYsKpBu0TIP4bqy4Xu?=
 =?us-ascii?Q?dlkyS1hSnnujEu4RsVKndILmoiE456ZIi+qZ22rWGnrxicgjU570OnsnZ3h1?=
 =?us-ascii?Q?sKPLX1w93jWzKKUrcL9WTykebTTIc3o5VzErTy3MBfLAwYu7iUo5GXNNrOYS?=
 =?us-ascii?Q?C4vFcaiTym2bToI2eQfp+Q3NOovjISPjv4HNX1BM1snwERFa7Lsi3HipbYgm?=
 =?us-ascii?Q?eYHRUci6wNM1VPyGdmkImwz2sky20U/KfDuUEaEgWjRJvQiQ5ItVtv5tdkJ0?=
 =?us-ascii?Q?3UQWeAG6jc3pZPiqKelZQAqEX+z6LREV882EboRI+rRvDscq5xZcFBNwRLWh?=
 =?us-ascii?Q?buN7xccsiRQksKD6eP5FRgvmVYHKt5h/o0j13cBMsK+H0dFv+yjXZifsFSeI?=
 =?us-ascii?Q?iiJCw0yFMyXPLpZ6f0/sPZe8N5s/ACFVG0nERTzn55W810HVxxWIBYcFoJWU?=
 =?us-ascii?Q?rrX1e1sQ3MLH2El4mAr8ydfGp0eyMxi8p3hlSCDHwkl4mY7E5DAtIRXJRX9f?=
 =?us-ascii?Q?vHgnIcMM4BBLhO5ehcI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:12:25.0380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6942c38-b499-47c6-b528-08de0b4d3a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645

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
index 927c7aed7e4a..6175ea899f68 100644
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


