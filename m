Return-Path: <netdev+bounces-234624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC996C24C0A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEB044E57D3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD93321AE;
	Fri, 31 Oct 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OJo/DgSf"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA65306B1A
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909447; cv=fail; b=Id5PpiZgQgtzSSgHnekq2rfMe4wkEe47EYPPnuD+pKaSjMAvL/L5Rjr6uPiBuHQGPhEU01OroZocZFc1ROE65KejwvjsvtKbK85j/sZxsNkqcKkKRXyPdkKe5Fftecoj9ugFGB0A5yL1NAgMZFDmZBdgPFZln35AJ0wFDt/q4xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909447; c=relaxed/simple;
	bh=4RgsySyHI5nNM0ogJLBrWOhfeK7BnEEvEG3rXKJORus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6Zd1EyWSUgpgKDYy4bO7HTziAtVeZpzEaS/pFiEpyGy40Fw8KETTxK00+TXILkEH1fBadHVOr6/kjws7x1gtkcMwR4k48t8BcSi6fK7nrnAru8a8r8l412LDUYMrWVTgJxTXqMF5kF57B8G102JiMQUKI7cmUBjRCIr/ucEqVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OJo/DgSf; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9JU2jx0leEjwLqGpVd3Cpq9/Y9WLHnJ6j8YADO3hHQLSGWaEhio1sr9GYQJ10SKGvKYi+kQ/88psIiGlVLRAqO8ESUz0urdn56PfeHh2W0yZd9Z9+bM1GwXI0IMql9LidOKpZZBB8v398LLyqrQXCee2kcaaqh3MEEBfQwr9LyQhZ2yuOCnc9F1ZAPhgxjyWPBOi+1XmkKJkdkIe2mtU7OFR2nvcTbVg5d+q7hxT6hLVt55s7FcYYOWcFbdTbzA8b66YW4/3yWL6+70X3n3wI8/K7qZyqnchpoGLQexoT/2eLNBwqRnkjZuahM0qMlRaJ7f8OKPEkQTL96p9oCb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjE56UQev528o81jMqowTeaKFOR6xJVWrla+SusLWfA=;
 b=zMyh79RviOxt7AIpi2d8TBaeU0FOeo3lPMUtDT/nCu7nNqw2io/fFhJ3rYTqy8xQ9Zx2Mu1y4hJ6agzi4zLTdmxO3lyuYcJ7TT4xp1TloytwhPShe2moRacvQTfaRXEXxUfuzoDAslEGYsf4CHva1I9CE+7ebR0JrBuuc2Fn01xOYoAj/xsZcZ4LDhrahi7fKKCsufqDKAPQdDktGZaSyGENWbh1lBkjoPnEwn2uIt5MNkU5BF3SmEyp3RW2bgOpxo5GeefmGDC/YFO1NfHq5a4tM1XX1NSkBQSKN7T+REun487oOgmjyjBPa//Poml0ZyGJ8X5A0+yQ/gqAFYX7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjE56UQev528o81jMqowTeaKFOR6xJVWrla+SusLWfA=;
 b=OJo/DgSf+sDt0VXtQSQAD2uB+H8SQh7kMCzpgMK8d2h0QOMdPDvJhXvenSKHW4FaxBCqt5SCLjQTZeaZNi/j+dbNDx+CUFV7nRKjCT7P2H6If1G7L5bHkPtvcPtZo83JEjwc4AZZRnnDqO8SwfdRCX75oWS6maOx9UAMN/GIeQo=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:17:23 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::22) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Fri,
 31 Oct 2025 11:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:17:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:17:20 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 4/5] amd-xgbe: add ethtool split header selftest
Date: Fri, 31 Oct 2025 16:45:57 +0530
Message-ID: <20251031111555.774425-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031111555.774425-1-Raju.Rangoju@amd.com>
References: <20251031111555.774425-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b386eac-3504-4013-6b25-08de186f1087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZG/f2TQXppNsNN1Zn8ckEwXKY5zNq7QTGKvb6cQxus48mQfFsEfeufmzcqnr?=
 =?us-ascii?Q?kGghdi5BcZLS15Ll37KzpK5r0HehB0T6/ym16daS/sprpbz56rFDkAlJWoWu?=
 =?us-ascii?Q?EXAacdhojZEPTsqcNDxn4ZyfpQrlpCWlWDLU1u+h+ijHjikF8oj/PgUBNOiH?=
 =?us-ascii?Q?wX9ZhoqVdegLwiEC96afbP4S1NXeVcalTFFlNA+l8FOtAewm6vLd39wPKDVe?=
 =?us-ascii?Q?N48KgMgdEb1Lm5KE9gpOnak2j2YU0viZig9GpB4gBPsOXgl5Rg/mxt2zTGcP?=
 =?us-ascii?Q?ZvJ291EqF+bNWuOMr3jk827LgfhuNwUinhdSq4s0rdoc/zieCfwCUHSDeB0O?=
 =?us-ascii?Q?oBhHmHeWA8il9A8crEemi+R/ewS1bNGw2QFhYIQOjOeNMokj//GU5DdWKCXs?=
 =?us-ascii?Q?vgK4D5HCOeGoWnbbZginpHKjpyBCaQMSI4xLJ23+zL/fTnJJZJ9EwRxiywjo?=
 =?us-ascii?Q?qg4X+/+sVuvp/Uu8ljxDowVHSRCLw9ycj+UCm7G1aig49vKcyo0JNWInv6Mx?=
 =?us-ascii?Q?EAF6elO40GWj2kaqpciwK2ZVfPkg4Ser7noui4bAixOjzXfWawVAAoj2mv6q?=
 =?us-ascii?Q?j/FECtmOYc5JE286R7jeCjftUYHHy1dixuPwb4pWuUICTj33ndHWbXcXaGjk?=
 =?us-ascii?Q?0eDLSJ0tHkMPu4zpaR8lC1NuVqBXqZQ9ChjTZWkbTlexwY5xgztcjD8Gmpzr?=
 =?us-ascii?Q?kd7gwwEFDURPVzff7fIaPwS+YJ5RtU4lwKkgBjQolHuEZOjF/8PImzSA/AGj?=
 =?us-ascii?Q?qHuRKFqoiQZNy3DiM10UwC5xcSevuuZy4W3LxoixCN/Am3WgpZtTW2mAF9T5?=
 =?us-ascii?Q?DMEazaqnEGSMWznBa4b0x9ABiin9req0gf03jFx98JgbX3IhZh/Q2Pz3Xngv?=
 =?us-ascii?Q?FnoYeHjYema6+KwjV6MCjBdOhlTS8HDwjC1MlsEPg0SrQu/8fLa9afcDHQEw?=
 =?us-ascii?Q?Ah5Iedn7cxG46x6Lxb/zaTJWpEdQ4wqKnSxa++WPJhKmuBiLvVUMFzsFPUR8?=
 =?us-ascii?Q?yZ9egG9LAYw1Gpa2CTd42tE+VYWq3lOVjNLw3COOVKsmLUx9txy+HUjRNl/n?=
 =?us-ascii?Q?CQtLLon2yhAT6F7YvilkYrjUayIZTckfCGyeQ73pKwqlJQmQaQUnr1d7xfrQ?=
 =?us-ascii?Q?A6XbYlHaLYwXIRkkhXbZ/oVGVoDxeTc6djdsoyz4h9rYNNYSUqdf0StIlCml?=
 =?us-ascii?Q?YbXRys37WEufxPiJR4z77A001rysRaA2uhjCDeyn9s1NZrU8WUz+kKWGuls1?=
 =?us-ascii?Q?/qYK1bjiSCJXVHyUNlN5bLszr6vGEVrs2TxTNOXAfnktFyPDI5oSd+4H1LPx?=
 =?us-ascii?Q?1q+Zy5IqM2JpUrMGL5/4na7R5VUNvLyS30W1bIVog/Qgd8gNtzMbo8wIbydS?=
 =?us-ascii?Q?m/WyvPiO7t4MY9z1T4UtPdsYUCUrfCGbAV+1G/rExQPUROlN4hxrpkt8QNhc?=
 =?us-ascii?Q?PvnHDACFXqRyHibd0jBlFTUVWW1HvtIVT/YOdMIe3pTy42twTLXL85GVX+7b?=
 =?us-ascii?Q?/jG5ylJ310SgWmZZ41HzVfcqsGvHodsUDtgIVXdLIHhBDJ1XTYFHC8dEdTxn?=
 =?us-ascii?Q?YnAk/Q+9EwbtQwn+xLI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:17:23.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b386eac-3504-4013-6b25-08de186f1087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
index 23b9d568a861..15c51e96bcdf 100644
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


