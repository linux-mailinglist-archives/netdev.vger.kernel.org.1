Return-Path: <netdev+bounces-194798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A9ACCA20
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423393A2787
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038022FE17;
	Tue,  3 Jun 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jp+YEgEm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C370838;
	Tue,  3 Jun 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964454; cv=fail; b=c0266uu2phoAH/7H8A3zApwZ73S5JGF3dl/Ln2kEcz6t06naC1ZKKZfXn15mnwvL0+zGALbNJSYAOxN+VQOX5tQr2jk9MbXFW0ELIFeFpxRYkQiTCvX5SNRNOov1J8g4cKuANIRihVXXZeRr/ctpRELoj3j7XCcWN4vN8ObOXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964454; c=relaxed/simple;
	bh=DQsLwjhjyVnNcEhhIC9CZt8RhSPiqOqKivaLqLMh2KE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u28Ah+M4fwaeelDR3q/f0Cb1dEeqZKFIE7i0amzuU8IYFGnHvYsFu9j6KRJQurmpn9u9HkslS9WO+TylcO1DBIpR6aZ8des2/gCD0s8kpYiOVXv+gftSsS7rkrDwgvG8eL6HSgAqPxc2Kn40hsmznbZikjCsF1OdIXm1JMij2G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jp+YEgEm; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0BES23Ge40A6gdbBXxNQJuYolmANL+6DoIxlpxJjMgd3NIcIKfpb5AgJRmImUxbHQ5sdjLeCxB52zJJ7yD170OiO6/WSlZDwllAu481DqPGWTyDv2VoKzzxuIaGzstLVMi46WK9lt7D49PkJcbIwPwFEmcxIhGrT58yE0zuiqoStzdzQUVwuddhx8LCOCg8oKAbse60td1JfMgYWKgC5HSscdcwtxaIwzO/pm/en2ysfArGEiKn9xqEcNG7xXZmre2Z6eHtqu0hLNzznOfPTd5xXz4UB6lKid5aej7FuRjOF81ptqCamndW1Yma2FtYdC7jPd9+EnVDKPoBH1zWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgDGYzQtRO2ytvgfkrBGdqDnT1v6cE/YiTvVrlhuauk=;
 b=I0DTwNeCwOCTaUXR6+3iQ4DyYVu+7r8SrAyIdeaAxMRyHdanI+XxD7WlS6KGtVw9VEZyC4kLmTL4CKRkCtomjFk54Zl4xq380+ScY6jbAXqto/B+vefPo7E5q+Sn7w8EFa482Mh+Sn095tjlDCCIQ2ZY5QcGlNV2tNxfK3QTai0KBXJ3jDoGgF5nl37q5BBgV41Tmm3flcKYkMEJIJS1WDccuuRe15vn2MQljAUtPyFvJZ8mncHZXBDwhTe7mbVEOnno+83OY+BnOAJEWl7gkzwwG1AGNSiAc8KBKIJZSGh2CutSn0U7zWCzBn1mPSzI0JctJyeD1e7wJUD5E7zrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgDGYzQtRO2ytvgfkrBGdqDnT1v6cE/YiTvVrlhuauk=;
 b=jp+YEgEmV+ky6PVDiMjqzpy/4PWU08N3oXLv/8+8HGCr7Bmj7Xes0jmPlTNtd/tUvVPgze7nenNcDFyCjkColcD9s2peKST5rVCfS/pMf+vW1ZyZLLhMiSgL4t9wO4u6k/ViERzHNLK05x0EVp6lAh1zcrqlar/bRCdxPgHWrFk=
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:27:29 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::57) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 3 Jun 2025 15:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 15:27:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 10:27:27 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Jun 2025 10:27:25 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: macb: Add shutdown operation support
Date: Tue, 3 Jun 2025 20:57:24 +0530
Message-ID: <20250603152724.3004759-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f59cd4a-20e5-46a5-f32a-08dda2b32731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMNCPnd+qM9/pnQUCL99SabFluUtKcOqmz+IBeAkcYfV7sjuY67DZKLIasK5?=
 =?us-ascii?Q?4eBTj+l5poyi8x+A8Tju3Z5FGzJ/qi5HOtWbN7urQ+O4/SkvYcxzg4SuFkbr?=
 =?us-ascii?Q?X8cTGv3qxI9g1JAPt14eRF1XDYSQ/eI+fZ2RW9nkqMrBl9BX4T06yRWhdYTS?=
 =?us-ascii?Q?vt55T7sf/VpuZZqtXqCDVpurZuBHPK9ZI6MWXpvH9/HJyRGTwld6J8l55Smc?=
 =?us-ascii?Q?Zy0423hYvx0si7HuMLwfqi9JDA/bSFzgodPC7h18ljB3ZPOugv+J+aeb+++2?=
 =?us-ascii?Q?XZAlyTiM9/K4+BkG91LIOqkVkk5tHSR5tjJH5ZAO5MxcMzTy849vu9p5v48Z?=
 =?us-ascii?Q?icIwoF4tkH57z7JE09IcmVFsumRwZUE/08jQ2xPTgMl9VP7EjlWj2fVAe/mY?=
 =?us-ascii?Q?ibSrrk8yriUaqu9NgbNDxLGds8HP8QemYDQQYwYFZ6G6w5UGa2v0uAyVeoqU?=
 =?us-ascii?Q?DDEhJFYwHM+vJgCtkE1XQMPgBphnLL0wer/auywOH/UyI8R5NgrbpW8mwKDW?=
 =?us-ascii?Q?1A+kU+dX10UGGxcMyTKSVPsmYBaWiVtBKZ3WY5KCQuGuZUodDs/9tL2GwJv4?=
 =?us-ascii?Q?1xbnc0ozNrbfmmPtZfB9Ndz5zv20MDDNr61eq5u2UY2fH+3LabKsxxFHsvcn?=
 =?us-ascii?Q?BvycgfqLHaj9/KHCszFcqU8t2ngIyR4JHm9cZs1SR3QL+F2NM3s5dV5fnFTo?=
 =?us-ascii?Q?6OJx7Q8lI2El9fesMwEG0E1akJl7ZVIoAf6+MAvBpl3gh7fl1ikyO4uhuhP4?=
 =?us-ascii?Q?fW88ADEukE3GgG8Bz/xG26Ham3lS7as3sn1dZMO7KYhJav4FxwwtDiXnv37m?=
 =?us-ascii?Q?78LVkZ7j/DuGZt4Epi/Vw12/skNFltiCegvB7WVNPCxzqg7AwKL+HAQcWB6o?=
 =?us-ascii?Q?y9sZQ8nzc1ifIVuVW6k532uZGvMCPj5LMiM/HpG+qNU0MYllcN6p+Zj04E2f?=
 =?us-ascii?Q?W8FmUqdYOfCgW0CM77U6Ri+vnkPaoB5KH0n0HSdpDKbav+r2FPP7X5bnTSiP?=
 =?us-ascii?Q?5ubh3mnYs0jzEteX9ge/4gtLEv/X5xf7Gi35CkmMYDGbMe1Skg5JyQJ3+Q0h?=
 =?us-ascii?Q?eKswCM4Z0vwBwvnbUC1783NXsFYa10aT6VJeMaV5b+/uv1ra1jnqP1P8IIx3?=
 =?us-ascii?Q?ZYY9PZR0idNL6d9zDWwVMnNt1ag1Iwl/mVt4HlRu0bsWicf2oObGI36whWvV?=
 =?us-ascii?Q?S3l/xu+PKibpQRzcWv+y6OqGU0Mk0VhZfOIYPClefyziBrOZ6ZdmihRG30KJ?=
 =?us-ascii?Q?XpFZky6LScXkcsfHXOq3SxsNWxBGjmuRNY3yrQhJLS1TlrDOnta1aVqNw0Iz?=
 =?us-ascii?Q?kEnP+BSRz774csjQa/NCVzZTAb8NDMrxzUXyv4J3tky8p4wLHvZRVCxGiw6w?=
 =?us-ascii?Q?gsQDVQQTjUl/m2Jv/L9BDzZNwc5g/v2BbU3SnMcW/fOjNV0uWN26RxFAeZcz?=
 =?us-ascii?Q?M8CR2ftkWAEQ6g/2ncPW3LHwJ43XYT/Qy2eIC7481LbR55k9rrawu6X7FEIh?=
 =?us-ascii?Q?yOpHXfIEbVqsucHKNrdPfwjRdxrV8fioSk51?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:27:29.6365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59cd4a-20e5-46a5-f32a-08dda2b32731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

Implement the shutdown hook to ensure clean and complete deactivation of
MACB controller. Kexec utility calls the shutdown hooks and facilitates
loading and booting of new kernel directly from the currently running
kernel, thereby ensuring a seamless and efficient transition.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Reference:
drivers/net/ethernet/xilinx/xilinx_axienet_main.c
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c

---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1e8bd2ec155..7ccfdb1155f3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5650,6 +5650,14 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void macb_shutdown(struct platform_device *pdev)
+{
+	struct net_device *netdev = dev_get_drvdata(&pdev->dev);
+
+	netif_device_detach(netdev);
+	dev_close(netdev);
+}
+
 static const struct dev_pm_ops macb_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
 	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
@@ -5663,6 +5671,7 @@ static struct platform_driver macb_driver = {
 		.of_match_table	= of_match_ptr(macb_dt_ids),
 		.pm	= &macb_pm_ops,
 	},
+	.shutdown	= macb_shutdown,
 };
 
 module_platform_driver(macb_driver);
-- 
2.34.1


