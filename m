Return-Path: <netdev+bounces-234312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE49C1F367
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6609C3A4C51
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166C2D879A;
	Thu, 30 Oct 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BtXhwnmM"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE733F389
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815661; cv=fail; b=NBrWrY0S/AUcIFB9zCQy+JdgdB0ZlxN5xKXrvVMSPtNJSR9UjcZdj8AwuGFNlSMB+2alvZnE3mObGcO1K6D2oL3y/n2zTB4ZJ4iUIu8F/NIXajTxz7KHMcUlJ2uIAjfOWCOjA0YBuO98R0q8ni9vVF8D4nVBQRv2ojYsKmlLqVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815661; c=relaxed/simple;
	bh=rfPsjduGqIs04lYEFV7LzLRaIDPdbLPXc5Wh1DmQLdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEspgWH7vOcj7jP419EkjAtdXNSJSAUnDGrH8vTXG4qDZz3wLWB7oqkjLzqNunGsPga7y5FBU6jl/NhGZIdJqwlR4UZbcW4kTMt0FNfRxDY5mZEtUbYDBpgrJ94KJfAy73N8HkXDkYF0/PfWfcptGh3VbPlwjCcOoZTLnXG/zbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BtXhwnmM; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr0Io9KXU2ETwXWRkwDCMz1PkUEvIgPV22tkBc2FXRHNWzVgwlkPN5qIWHgg1Oy9qww4bC2sC9ql/xLStH1Ko01A3OsKkJfTjrtnb/wR/V58m1eapOAXzPNokZmkM8I6Q05EXtoOyDXMDkgt5AUqqkGPyNbM+YqCWIrfUlFin034rzf4DysdNr/1U4LkZ4WdPXD8Tm0oJldRtFW+Ktn8O9J3J6YfECGC79b8B+Ikz/GSkBYXd4lLAbr3HqfgT/UzGL7MEveUT44lOavHaxuGynURhys/DTFYLK/YRN742qwRTRj5qgsshqajMhgHV/FnQ74j8sQbT6iu26VZY8Doug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN8neVBTL+M+8BmKGzbVhLLaovo1u6AOMrswpKzQ6qg=;
 b=Csyp8mo2ISUEEo4vE5KqXzzPyTMwoKlbG4GZQ4xTFyFfZMQYtMLP8TEG0DN7YaIilZZPb0GVWjNP6hZk0Ho3UxnXo3dI2qv1qwSho6G5YrCB5JEVs3EtrDVtNObc8SOBnXSwQZNBlI8o1I49g5d6C9U382ITh1Jel76ZcStu/qAMqjfIIm8xHW0ckmFVl1Wdhq126dSgLVl7jKP9y8sVpMsNn1jNJIClGAtIUzq+9lYNdtS8JoA4FnjYp0fZVKZzo3l/oaIgxavDlULXyWL0WV/2X8bbepTyxmqUTGbaxNIgEPqbDj/Vq/eeRmupkEoneCOpPG4SIpUwOwf8J6Zgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN8neVBTL+M+8BmKGzbVhLLaovo1u6AOMrswpKzQ6qg=;
 b=BtXhwnmM9eq1UBZo1TpawSacrLBbD51kl969Lb7nwil1Mfg4QmYmU82HEzWnEIVC5RRopk7L9GM/7DMFfa0yJ2kck6ZPRYy7w2vVpcD8NnnrvrT9lWeVsJBJApRpv+217hBchwC0k3phYWyfY1EKfxvZKc04Hg/jmhHoy5EYcLc=
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:14:15 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::8d) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 09:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:14:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:14:12 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 4/5] amd-xgbe: add ethtool split header selftest
Date: Thu, 30 Oct 2025 14:43:36 +0530
Message-ID: <20251030091336.3496880-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bded7c6-3d68-4bfe-b7cf-08de1794b289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvp7r4iNCBWv9XqUg1wDh+TpF/arP56o+Uq+1p1rm3/XwGsJzcfTrblytug9?=
 =?us-ascii?Q?vjdXILNVQIcYiMFRuSoo3GpRFl2iIetRVP6rBGUC66evqbGQyleko+94Agn4?=
 =?us-ascii?Q?mSRfJO+6/2M3xj37p7UJVmEpVy618HaJjnxCjwXiawtHJA+dfu0WKgOzlRX6?=
 =?us-ascii?Q?g4eeKlh+Jh0nP0okrP4mx/FkaJ8V2Qv1NfVMRS1chc/CLu3ceaLi/+ja0Vj8?=
 =?us-ascii?Q?5VH+uuzED3eav8oedAihh34HdDYXn/mF6HuHZ/YW5NEHfh6illMbOdMNWVJ4?=
 =?us-ascii?Q?aRGoQ7HSpDhYtaiV+blmGq6wNYj3k7TBnblXS4mJRJpftnvcRX1/X7Tcf2tv?=
 =?us-ascii?Q?MldKqLJ1bZxjz9nZ5A905te+HJH2KXTaUUZdRvvB8xeBAQzd3l+mZIognGCh?=
 =?us-ascii?Q?ls04UPLLzsBFkZhGQ5LIgcQBCuxDhdiS7eJ+BzgE+g8ecKU3ZpmzuYKEh3xt?=
 =?us-ascii?Q?1+SF4l+QFpZk3a4dxhH3MNK5sjyBU7qjROqOwvwAG/zrjFHlVic3zYY/lhNy?=
 =?us-ascii?Q?HVJ3e72XTQf/e+xhWIgYsZjY4HCFgHTFUKiCbZmRc0Na1GJn+VLoDAhFurBT?=
 =?us-ascii?Q?SUGp0C7RT9JLoOYFX+9XHvIF4LRjWQ1gTvTLop3v1LKkfAZjnjP/OM61vBI0?=
 =?us-ascii?Q?n5AJyNOSag00iWXDNT+9gbwn6gZzOXT07hBBsm06MaZQGii0DCYsTnSdQYrU?=
 =?us-ascii?Q?iBIResfxYm2z5pPqtGNYwEKNdhGnMZD5I1Smp4XJHDho0huCSmR46fKZQPZD?=
 =?us-ascii?Q?MMQQs9AH4v0p3v0yPuEFYtn5sjgdgvvJxaFGup7vCroAp3X5ktvR5W0bvamW?=
 =?us-ascii?Q?wwqIgURYQXBi+3A3ChUOIcd+DjhkGC8yyvMbbvf1BVlon/D7GkVoo4qH5qh8?=
 =?us-ascii?Q?HbZqmhxcQ0OufO7ea4W/4Ly+6v15XXeriSw3vZx5Lfhh9sdGv31pMOxcPYbv?=
 =?us-ascii?Q?zMn0D1BfrCA1b9LvWxcJtNa6Ovse5UByNiz6ZnvuIzXfC5BJ5J+6lOsH7007?=
 =?us-ascii?Q?vSVvHhqTo0TAnRs6gzkYjMGn8u23sKwn2swqhd6W2BdT7PMTFszl8GZyutAW?=
 =?us-ascii?Q?kMEPl0Z+rEwxC+nvH0NPFvlkyNs0ke/eucKX8H7y22mw26dxuBWCteqnbsFh?=
 =?us-ascii?Q?LR4ebvvOzA5Dj1yVvkpUyszr2Fqtgk34V3U8RgklV7/EQmulU5ZMx02TB2Jb?=
 =?us-ascii?Q?ppLvHVVM7VhSWi6clG1youfMsbWzJcqUYYuwjrOIeemHzbBQokKPM+4p3nG/?=
 =?us-ascii?Q?GpPV4imowDZkc7yWeGbxllOQO+Zx3HmuN36kAamBLsPqJfW6FjdcUb9xFjz6?=
 =?us-ascii?Q?jPHZ5XQJPK8mCA0uIGtw6U3wku0JlXy1CQOkR/qtOIJtidLrscIGLKUqpAbK?=
 =?us-ascii?Q?VflGXQvjFWfdBmcue+4eSr7dPAw0tFFuvd8Kzomaair/OVgNydoyXKi0q81R?=
 =?us-ascii?Q?kUgxCzdUq8UQFv5dLRbrQ2QtM664QxeBgKuad9ZcNQVucToiqmmx6Da3VmO2?=
 =?us-ascii?Q?gB10/EMuyLw1QZ8KSe75ia/ON9ubQkFiFQR91wP1qGE9S1POMgDe7dck1Tpm?=
 =?us-ascii?Q?NslNElpfWsEcc+UTSco=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:14:15.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bded7c6-3d68-4bfe-b7cf-08de1794b289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 46 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 +
 3 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index ffc7d83522c7..b646ae575e6a 100644
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
index dd397790ec0a..1a86375201cd 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -173,6 +173,48 @@ static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
 	return ret;
 }
 
+static int xgbe_test_sph(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	unsigned long cnt_end, cnt_start;
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
 		.name = "MAC Loopback   ",
@@ -182,6 +224,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "PHY Loopback   ",
 		.lb = XGBE_LOOPBACK_NONE,
 		.fn = xgbe_test_phy_loopback,
+	}, {
+		.name = "Split Header   ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_sph,
 	},
 };
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index dc03082c59aa..03ef0f548483 100644
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


