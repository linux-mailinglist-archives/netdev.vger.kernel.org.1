Return-Path: <netdev+bounces-133807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1E9971A9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65F01C22D20
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DEA1DEFF0;
	Wed,  9 Oct 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZAgV+Ml"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01F1DEFF4;
	Wed,  9 Oct 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491338; cv=fail; b=EOSYuL5zInxBH5yarfEERHoTez0fk0kwSqXfDZJMJE1o/9V8AjLzIGlst/kL8sVd8rDivTJKOhDw7ACIxqtmBclgzI+Q67d0JLZgIbdSYHTGUevLO8pD1T9uLvDSTdZcp2eqtByMKqXHjNW8d+Reg2XEUlO3wKACeTBkZcAmHUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491338; c=relaxed/simple;
	bh=eL4EQ4P3xV/3v99xfz1Hcn8v2sLA7eE2zqlz6/F/Gx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTc8yteR/7QsM8sXB72AZQWxb/cBBvjB0R8R/6BGfGQSO409fwvuRWkLq40AEV/D+gY1NTP9/yCHl9gzBODzu8IzLgxP/+SgdaC5tyMjwF869BnOS+PGToCD24/FHqHiYlcKplABJhjT/2iJLX61zDsWL80eZYbYPb2i+HeTzLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZAgV+Ml; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJh21W4Wp/teQDXa3m/kl5N/dWuwcsZa4eTiYLWBFoCKfVYfZdbQNRd6I8si8Cp9QM7pZA0yEXbi3JBUs6dysS1IFaM/Lk17i0UANmjDFO2jLQxXIU9SmwGMxOuDoMTAgeBOky0xfaJG6SLf40C+XLhdSK2vSAwajkNArPCNTodWxnSOJrDd4onuVzIrL39lbFiscaGoZ/YVkX2UcBDUbB61jHSkWJ4+CaNJX+jr1hF+wNkRwlEYhKKw+XGrxS31cy1rU3BOnFW1XVkTKK4UrxEmykxLTSJCp8atGOupOuhsCRxOHUIoyHDxIhc18YKUBGyJe+HR5RMH0KVUSj1t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFHzaniLyc9sqIhGbXxftavMA5LKfEhbLeJOtBqpVK8=;
 b=JKZpIauXDnrPjnKSBrMhot8oC3TazAOd5VK1njcpEXyOMH732ZhgL73mj6Mh0yh3/h0HAXLsNZwNUdv1L3t2zscz4bNuPddbeVdtlJ2c/fWjO3SxFgAUoJfAAe9O95bspCyYqi1cAklmsbmR2CzD7KX9I2nW4vYJQHpSR4zxkAnmOfZAdjBiqhnfXPXnrNHuSlBLPScFjDLiMOdWoPDIt2ifY9bE+9NSY4b2YyDFI7VS3Q0KtTtNieup6L/gzGZRzybL7xMuh7VLE9ohtcJs2O87Eq5q6HOl6S1CwHtOE7SG88CKfp9opihvP9XAFLrXSj2hSYzJ+IJ3Uuyk0eFhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFHzaniLyc9sqIhGbXxftavMA5LKfEhbLeJOtBqpVK8=;
 b=wZAgV+MlBJUn87GAeJR0RJcnXcxVU+Mig3rvFChKm6JpnuuTveEKxoEZpXMSw/1JHczejTETOyLkdwyPV16prGGyIuAUHXeyN4bO8AN4vCDOM7JFy5cHcdwr4mqG3Szrxoq6r8ezSpfz10rurZ6WrxiuOAhdq+pBT136knaRCQc=
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 16:28:49 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::97) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:28:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:45 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 11:28:41 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v3 3/3] net: emaclite: Adopt clock support
Date: Wed, 9 Oct 2024 21:58:23 +0530
Message-ID: <1728491303-1456171-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9199dc-71f7-42c1-1409-08dce87f73c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sG9JTK5CrDbZKOnjcp7SLhj7JXavHCnVrTnCaZpTt38nXB2eCCR0Hrh1n5Pi?=
 =?us-ascii?Q?2TuBOJBaGL85bSAKxtQfNjh4LkvBRMQLtslR0O0Hd2HmyusqjNxTSTiPNEHI?=
 =?us-ascii?Q?LMLeufRM2wzwypniG/SSzz9JtXJM+qaxusj8l4gps7SLkPASDEaJMv6k3rA8?=
 =?us-ascii?Q?LKCbo5MaZZz1D+PEmetZfXHtFZJLpMgWPfMOQky1163E9PxddDd51aORhnKW?=
 =?us-ascii?Q?7oXu1TOZd3CZaPcjk2q4BtJVbJcu+CV+uW1/li+7r9/svwqTN1rPNOtbQ9J1?=
 =?us-ascii?Q?F9PEfGY+1t/2EhOBiThWSfw9SYr2rsCzO+h2QhSYcBCM6qkgc1jVL5Qaf3VZ?=
 =?us-ascii?Q?+QeyyaU5Kljr25vz0QZhfgpF/5JCMBgCgz2JFE8gFITqZbDFYNHIGN1i/O+Y?=
 =?us-ascii?Q?LeGFYnbr4GBF0YsPPiEQZPb71ezdHoTU4VAVhniAVxOvEDPYioAhdrlZTCF4?=
 =?us-ascii?Q?TaCVB0gRwKdc94J2MvAJCxOOACmh/jQJ/bPzjHV3YHzxT2axIXoV9kBPDZQE?=
 =?us-ascii?Q?EWjAdzYex+Cn9jg6ABlTQXBcWJiNI4dG5bqEKowubva+MEuWc3pCvzWvItmY?=
 =?us-ascii?Q?8dneGWwaEoLrtOaUw5PvJ0YWIwmJUE8rbVd/fbZyhp8uNrvECU7mstLvZY80?=
 =?us-ascii?Q?HfDU/5rG53azrns6lwlkY9yzRAib57z5Jbmq6WMjp0bCIHDxTHiup2kS0wrV?=
 =?us-ascii?Q?WLvmQhXyaqJpUCyMYedCAZC9wVJzOZlX/Fe+FbpJqR73rC6Jp6f4CdUsRIj+?=
 =?us-ascii?Q?FFPFIzAqIJpIUarZKW/iAm5J6njAfRQ7Q8V2F6fiZSTNCpJ5ZJAUTYJStYgy?=
 =?us-ascii?Q?VKiWxw/cYploB7erDlGeb4iWFqkVs++dQGHlSNLd3abFOTSFm6zKmqIdVRdq?=
 =?us-ascii?Q?6KKtKjantwFS6qI5BUsUYPKEe4UgV37ZVlv/ev9bQarmR1y8r0KbqHDM/3e1?=
 =?us-ascii?Q?aE66caJuOMydMU60pr3lGrHyQBv8VMCS/n8JPVqId8ekx9YeEDibZioSJUFi?=
 =?us-ascii?Q?TRLka8M8uOnehntBo1pJFbVMM9UFreZwAoETKMOOTvEeWxafzQ7h+jOrjkjZ?=
 =?us-ascii?Q?ZSPHiAXl3D5tNXbfrDFMxiopFpS4+ZuUGOD/Iu9co0uBuhtcccQYcGyg/Sme?=
 =?us-ascii?Q?cN2NKSlIy8zTsdoOt0aCOQK8j9eRRzfXEYXhvVXHzplvUVF83qo92km+5Vll?=
 =?us-ascii?Q?n4Mnn4nEIO56uXVgxFBGXv8aXTJyBH6Zx+5nr5nDgIbVDYIGIHBTqdbue+jt?=
 =?us-ascii?Q?8joy2bVWhg20fZ2ziKyqMvUZB2oDHU5ZCWFiQEpPDnEug1/m0SjceSnBfzLP?=
 =?us-ascii?Q?sFAkjJr7RulQsdjTd8PizUicLD+9Z2POEY1Akq4LbDIUK0aCUYqkA7ZOHFUm?=
 =?us-ascii?Q?ZyupuCHMlu+IBd1kTyqhZNdYNxpl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:28:47.9147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9199dc-71f7-42c1-1409-08dce87f73c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

From: Abin Joseph <abin.joseph@amd.com>

Adapt to use the clock framework. Add s_axi_aclk clock from the processor
bus clock domain and make clk optional to keep DTB backward compatibility.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v3:
- Remove braces around dev_err_probe().

Changes for v2:
- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 418587942527..ecf47107146d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -7,6 +7,7 @@
  * Copyright (c) 2007 - 2013 Xilinx, Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
@@ -1091,6 +1092,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	struct net_device *ndev = NULL;
 	struct net_local *lp = NULL;
 	struct device *dev = &ofdev->dev;
+	struct clk *clkin;
 
 	int rc = 0;
 
@@ -1127,6 +1129,11 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	lp->tx_ping_pong = get_bool(ofdev, "xlnx,tx-ping-pong");
 	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
 
+	clkin = devm_clk_get_optional_enabled(&ofdev->dev, NULL);
+	if (IS_ERR(clkin))
+		return dev_err_probe(&ofdev->dev, PTR_ERR(clkin),
+				"Failed to get and enable clock from Device Tree\n");
+
 	rc = of_get_ethdev_address(ofdev->dev.of_node, ndev);
 	if (rc) {
 		dev_warn(dev, "No MAC address found, using random\n");
-- 
2.34.1


