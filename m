Return-Path: <netdev+bounces-195510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2079AD0BCE
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9A216FF71
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF31F8691;
	Sat,  7 Jun 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ew7e9ye6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B819539F;
	Sat,  7 Jun 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749283047; cv=fail; b=dzbUTqj9d6qZZYGou0PkA59Rlq6n9k0UdSvYilVr4TRko3/iOQMqErASK4PpWUg0lWbSXyVN59r+mretIAS7Oi1wuwF8+co1uwInEhmKr+C5Am9dSuwhPlRgPpBjvBuqssrcP/MjRSw71JnmrHWRQh5eUY3k4ACS7IpZZsjv5dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749283047; c=relaxed/simple;
	bh=01eyO/i9fpFsbN7YdILIPwGAOVMdL1adSR20PWt5JJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VK87jBDr4dbUrzEf0+blng6EnlBkYDg5SPNBN6tnbJECgKTnfGfMfwAvxWUxnXBcJblyFUnp/IGOm5PMoPzm7Ta/cymzwgrLPV0IhqqfkHQql5g4Oko/Vcbbp4mbzjZXocuuMIzOoVa+MIQvv1jkt/s0ljBliQQ3Wkv0ucdi/e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ew7e9ye6; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5AQ8kH1PgpeftiVGrKkWj5WsdtW29TFQ9qsUD9WmNIxteHULN3ysxCuN8C5kCfYNs/XlnliHNzbHOvMqxKM9iarwgkFrQjm7Gh2MyBX/ILDmcZepD68fDBlFml0xrYzB+yiJY0z9zoGkJIUCaC2/uW8bVR5v3PXV+zH1WZvXi76Un3REyWLrbJUTZksylDRVpLgsfATuj0952rfTp4KqC7DHzoqoFHSi7NK6qnzKxanndJC+kDlwT8NGE6FVxPPKFwrodOpIfRLMN4SehJAfw8MFern6tytoHSO5gTrGjnFnKTm2xCCf7wyNOPZ/tyQfUl6qxlsYQB8sFSyBZAwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKIZ/in0KztmfZJa5AfN47jTpSfVUAkxU5kMp8AI0+M=;
 b=UmYaRBQBZGusTpeZ2XPYhMf7kPQCpufVfY0N54X9Udm0m4Bbx+e4tnn/bqZy/s0zjZJfFWdmsMC0Qe8M18h2cUTZvyXdQ3DJH+XjviT10+aa0Iyia3CdOasEFlco3/BjVxHrQqO/s5sH2SxQg27cLjcjBS6TvUu/0W1KLX1JHNNO01bwKPfFPy0r/MaIu2XGGZVy3z6dHK3u0BVyGlvzjrI68ORMPfFPdQSjYCO0pYa+2QuAe774XnQhBJIGu14uhmDBv2gTRPiI4KReqVHUiDp3Ch3jKGFkYYIHsQftKKxY9ZWx5MyE7gpfjlOKFV88DZjRtPq8WSzYLJ61FGe/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKIZ/in0KztmfZJa5AfN47jTpSfVUAkxU5kMp8AI0+M=;
 b=ew7e9ye67iv8+R2DsLBu6njb4RT2kAErkN5Cy8PuUvaBPVrUUfML8MBpqq3yGrSATSEfp19gEwyObszcR2lx76o60D766wUAYd5dqrxln+6qpt8ra3MmmDXHKM8Y2WGd57OycXvKhpdYtg3hQiAOabLxRm/ARmZuiSCNT9R4VgU=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Sat, 7 Jun
 2025 07:57:22 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::6b) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 7 Jun 2025 07:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Sat, 7 Jun 2025 07:57:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Jun
 2025 02:57:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Jun
 2025 02:57:17 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Jun 2025 02:57:14 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: macb: Add shutdown operation support
Date: Sat, 7 Jun 2025 13:27:13 +0530
Message-ID: <20250607075713.1829282-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: e606e40d-124f-4ba4-408f-08dda598eed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UceTL5e1hu/mzL8l1ef1sItKMluul5HCv6wPRzDFdg7SD217Kqx/6bQ4YA+m?=
 =?us-ascii?Q?1MqsvbCh+Y0IAcuUvgykkPXMqyswbnQ1jSXlSbemzWOkCQIvu72/3ejalwcX?=
 =?us-ascii?Q?uRTzDirHbJFqL4VsWWCoKF3SRRCvBiK1g/pjHtRKZ61YtCJssRGXlS5uNYZc?=
 =?us-ascii?Q?9NOGZCui0ZfmX9L6Y4kdW3rk/Gp0VzQ/TjlaxzWoWNnYEkKbB5VYmaocfx0+?=
 =?us-ascii?Q?OtarIWzF1C4X5IMS0MttXAiqc9Rsl04Nu3zqV68xMr/Oy8GERqkH+3dJLPzr?=
 =?us-ascii?Q?EDKWHMim+vwNKXaorKwuKsciBOTLp9/aqkEDZJBfvIqoiXGFBtN7cpPqxGcg?=
 =?us-ascii?Q?ORhyaJYECX8p40yhfY57EC+u5i9mBuqLNd3AtX2O4qhSNrlOBHK6e0HCrFb+?=
 =?us-ascii?Q?H7BxQCbNGwwr9x2Sfr2tiwmxUT13b6s12jT8XX42sT17ljstrdSKWr9sRZr0?=
 =?us-ascii?Q?qInGMAp081ChOHc62WGaL+56qEfSUKWbHOzexJAXD3l4mve6VqPJgrBPHB++?=
 =?us-ascii?Q?23tOu+krVOPemYROyjmwCJZ3NrZDv6Rw8spzDReZMp3Oh1yat8XHFVUd9iVa?=
 =?us-ascii?Q?4uTrcCRSnCGA9Qw8zSTsEWhJ1Kg3HFfkSQWz9LQvXI3znlurNOXszf4OsQ7o?=
 =?us-ascii?Q?9jkexSEW95S+zQLVj+lLmfhMaVk4nVQVROh3nfYc14sf6/hPhv6fuCoSgL+w?=
 =?us-ascii?Q?/AthOc7Amch02vWyuduUt5t7psWLX7K3GVjcFFd1Nk+MlCcSX+IdRq5WlBvH?=
 =?us-ascii?Q?UEMntoQOLX//XOoiykATqgPn1YSvwLwjNV0JDuvJFTWR2zx9se9u8UYNOcrq?=
 =?us-ascii?Q?NYLrth6MfMyzhKNKvL3jDBCKwiA2NusD1lqAITxqPAMPccnNev1K8IJHYIO2?=
 =?us-ascii?Q?uyqY1X58yNJfxou7+amvbukDX+J6X8sx090u51WF7B0nuaOpOGuGvUm/n4ls?=
 =?us-ascii?Q?B3szVqIkfD2xat7L3mcVty5HEcroxRlvwMKLjWe9Izhnw6zJEPBqWMkODN4Y?=
 =?us-ascii?Q?eQZFeN7uV5J0mhTrVvLVYOrMt8He5+BdCjkzL7zabT+6oBLcLayk5zPlGxDw?=
 =?us-ascii?Q?olCUnfoRreE2Dmqhss4gW43pmiCDRv6UQ24pplgOWCWUbyAfAvYNs2wyiLP7?=
 =?us-ascii?Q?kn112ImEA3grW5VcyMTPMmDoq5EmruxgrrsFpAognxc70KiA6v/mIp5SvzbV?=
 =?us-ascii?Q?0wTwIUw2LuD92FgEDr1I1e+s5QUza30amztbl+icXtsuyfPVm3pejI+Eq1UV?=
 =?us-ascii?Q?SUGZnHQ08jEDbs09/2kFT4l9bcnszvYMHU/TkguGNmsK/OPtTNv8ELKn/6WA?=
 =?us-ascii?Q?d7eFpkR5A3y1rsvUwyGfKFTBR+XI4iQ5h9g3KBe0R1iOdDhZpxxAm8+c1G5F?=
 =?us-ascii?Q?Nq5Be1Co+VQak2RhB2MRBowPkmvSmSH95S6eFWppUivL2qd3jN/2VOC6I4rp?=
 =?us-ascii?Q?n0AwG3egcMbOpbObR4LfoS/1qzA0nuLzpvqXR8lfK5R8hsa0lAf80zEBPSSo?=
 =?us-ascii?Q?cePJZweffrA4QoVBnHQdFoefZNxKbIWBtkDo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 07:57:21.6289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e606e40d-124f-4ba4-408f-08dda598eed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

Implement the shutdown hook to ensure clean and complete deactivation of
MACB controller. The shutdown sequence is protected with 'rtnl_lock()'
to serialize access and prevent race conditions while detaching and
closing the network device. This ensure a safe transition when the Kexec
utility calls the shutdown hook, facilitating seamless loading and
booting of a new kernel from the currently running one.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v2:
Update the commit description
Update the code to call the close only when admin is up

---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1e8bd2ec155..5bb08f518d54 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5650,6 +5650,19 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void macb_shutdown(struct platform_device *pdev)
+{
+	struct net_device *netdev = platform_get_drvdata(pdev);
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev))
+		dev_close(netdev);
+
+	rtnl_unlock();
+}
+
 static const struct dev_pm_ops macb_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
 	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
@@ -5663,6 +5676,7 @@ static struct platform_driver macb_driver = {
 		.of_match_table	= of_match_ptr(macb_dt_ids),
 		.pm	= &macb_pm_ops,
 	},
+	.shutdown	= macb_shutdown,
 };
 
 module_platform_driver(macb_driver);
-- 
2.34.1


