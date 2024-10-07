Return-Path: <netdev+bounces-132761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CC19930B0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD99928A158
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583961DB340;
	Mon,  7 Oct 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rRiLqEaO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE71DA113;
	Mon,  7 Oct 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313603; cv=fail; b=pxV+At3G6zc7barZ1hMPwLClpxBNSyqg2YbVYyrPdD0v1ct6m6KNRVLTHAkXEF4wlBvUe+aT1YEr+GsunJNcO5LWvyUUhTQE/8gRmAPoIX+l5gd3M+ktnLKs2CBhZNCu35YoQRxW50yK/bjtrkhYNvkuMZW5T5ZI0kAnR+pT2+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313603; c=relaxed/simple;
	bh=5MB+qC5SwVrYTVPlnd+We1gkdooPv5BGmIioubS/iS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlfRCQU7RQXXz9m/tJr6E+74eg/ni3WakSM4rRzfAVMiL27ayD6xqmbhsyL3VIsiD5z4XXZIi3bJgQp4Ye2zKN4upUEBCAGoM3GccIMvcCcIIkeQ5FPHPbgrtVJCEbAs7v3EeeJJNIgN8SMMkhjefTX6+PSN3n96R/cCyiJgg7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rRiLqEaO; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4yJW+uqL2EjL8A6LeSyQ/okQJTtvmqOjqIFq2CIpBgKeL2YgKXCQ2Z69sj7JMqdRdOyK8aznNVNB5PQsWrXeHCwoUd+3gEpJXmD6+vBZsNbhTMd/GB2RUWMjXgisXjC7/yEe5bK1SOCXqOEVPA2YJ7FfH3W3XPREjUMSxxS0At/OKYXEtsCByfG4z5jG9FlxEbEMVRG/8AuTOVocsoeNM25nVCIl3Nt8yY2WgpZA1B1qTFSmoO7PEOr/p5UaitLw6CdasLhPR/s8umafdKT6k1btGdfR5OAelcdrmLN6deY3KUrBwwLxUikxjvEGvVAZcm36vIVvvleN1aE6RJXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCKzUG30wjF/lWvieBvsSNDEgleYP4VcwrDEA0dQGkU=;
 b=QCdfT5JEgjWimH0NtlJqTEeblZLJu9B4ra0fwRuT09ZKPtCPyswqwE+65WtPV3B3t/s1ckXzr8+8HqUgn7/7u1rfSIenfV7Jv0ltPt41J9cwQ9HLMJTJRSJ0B8Bb+OKBS37yIBdamPu8wRWgaWU9Q6oe3EGL3xBD3tFzjtzvPEZc5owq7bpWu0RghKdkUE4ff1+q8wNxuhmUM/2JYNF6cOGLGt6dK52qxP5pnFKewWlPzF4I5jgTtHKqRUi+pcJn0P3pQ6TAR3coAY7lE52sHte3cw2HKm4P6iMv4iaJalT4NCLHaJoqH+7a/0dizDjWJ39yh7MvlzF5ZFfU+TU5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCKzUG30wjF/lWvieBvsSNDEgleYP4VcwrDEA0dQGkU=;
 b=rRiLqEaOOluYKV9Oxwed3MWiQ6o0I17FTCjQo/JVpJzm2qZydFJ9egtllWlZea7mGjf417pLIhgUgynIxq0bK9nDcjt3YMNYJwv3hCI8wequN6ZStmPFtImSWSYdkhMGtjgK4LQHicUSFNvH+iWfd0enBQTl9sLlBGfs9NIk144=
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Mon, 7 Oct
 2024 15:06:36 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b8) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 15:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 15:06:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 10:06:33 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 10:06:29 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 3/3] net: emaclite: Adopt clock support
Date: Mon, 7 Oct 2024 20:36:03 +0530
Message-ID: <1728313563-722267-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a61d57a-be6c-4d60-1f05-08dce6e1a2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTTxjG2DN3HEMTACXs6G1p9wY3Vl2CzabZmTUIQOxntV4cFaMzi0xckB5W/9?=
 =?us-ascii?Q?GNgGzthsMqHImHatQQZ2S6wN67AT6AagNSPZpN5wb9MI9vEzle+uRgag7CMG?=
 =?us-ascii?Q?3J3N/Z4HwdZkFSkFJNlh3FzdpZIXwnd9V7Qb8RY/J7ag8wtY6IiLhpMiyGeE?=
 =?us-ascii?Q?TzM1TXeRyUt/oxOa4E4MtJAyeSJLm8AAGPSUEULbvg38FCfG9N4ZEqqXl4GY?=
 =?us-ascii?Q?l9OxQDlog3+NCACfL0ZCsxqQbHr1MEjXdzHlAZeqFW15zE7ls62qJq4PHfrp?=
 =?us-ascii?Q?OM2imzsq5rqB8yZv1qGrF7jC3CWWAI6IhIJztsZCJd96pFETirvH2KKVwDd4?=
 =?us-ascii?Q?AnoKg9/t0XwxH/KvUUfKigY99objqVhqIxAGOd7ejSqgp1x99gv/5Xn31/qD?=
 =?us-ascii?Q?bT4jhVcGnapG3tlDQryhIACXdu+vO4czGwVYQQ5tQuFSabl+wrGwGu8pas0S?=
 =?us-ascii?Q?0VD/qUpf3cH2DonHNabBsQWPocqDyTkpz/7fRudHfmsFMFopoLjMCJIuEaPj?=
 =?us-ascii?Q?32QtaEOtj5d/4YhUOl0D2NqcwQaFPIT5vUNZXPX35TYo2DYrw2N7xWzI3vOY?=
 =?us-ascii?Q?dmX0HtRNfvrOManz90Djl+pZ6DhQ4MQecnbZvJcnHwJIe1rloPXiZ8shg1iN?=
 =?us-ascii?Q?PaV9gqxIbQVr2xqBMqmC4p8TOiUXe68V/fZIuDnW1v5ZkDXOi0rF0JIb6w6T?=
 =?us-ascii?Q?HzVOW1dGW0ocmf3OKKSBmFvt5+r+VV6wrUddw76+ZvfAc+aW5L/FMJTMx+7r?=
 =?us-ascii?Q?8gFbYvfBZBUlmGH1uvRe4Uq7OTQLXge1S1WK0NtiRkyQUlJORuQtbNoMwzp4?=
 =?us-ascii?Q?tl2BvuQKheNUwu/BglcXssPVu9U7m/JGhdyqK4FJZN79QQ2+O/i3VOF3p3S8?=
 =?us-ascii?Q?30mDdzh/mlK4Y135P6UgCbGwm6OAuZgN/GweOvB01t7T52ve/qj2ujFjifHJ?=
 =?us-ascii?Q?sBBeiQf04yKz8DZXlQa+rbukn1LMbAnjoWTKRZBs+xzICzbSrRgt4CBEymXL?=
 =?us-ascii?Q?bEc8ahnlC9QUWdIPKkPO3/s05BGYoxlX3dttuQFJM1CjX6yy7qXvu32BZSPx?=
 =?us-ascii?Q?OS+ZX9Rcs/pwhws9buT2IJl8q+xD2Tbq5QzQ9oInUW+NKGItj4ubuLsuIsPl?=
 =?us-ascii?Q?ME6iT/I5GaH6Kula33SDgG25CeMRMq5QzTSO/l0ete0f1ZO7bt4SPdWqW2QO?=
 =?us-ascii?Q?VRf+1Ro1i2LE2yXo6AlBLZBLN+U8Q9TuaNRAZLBDBLT+pduLOsCmgRcu0yH5?=
 =?us-ascii?Q?V9UGdj9YS/UuF+lncnT7k+rFK9MOiO0cOoNvQssGMSNJOMev0L0q4DJCi2Gb?=
 =?us-ascii?Q?sX6FWBMz8li6p/yan2+l68cMhMt6boxQeiPspDenhKOgNDDopGfJOj2Cc3/W?=
 =?us-ascii?Q?bC1We/a7x9itzlseXID91+j8jKhz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:06:35.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a61d57a-be6c-4d60-1f05-08dce6e1a2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

From: Abin Joseph <abin.joseph@amd.com>

Adapt to use the clock framework. Add s_axi_aclk clock from the processor
bus clock domain and make clk optional to keep DTB backward compatibility.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
changes for v2:
- None.
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 418587942527..fe901af5ddfa 100644
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
 
@@ -1127,6 +1129,12 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	lp->tx_ping_pong = get_bool(ofdev, "xlnx,tx-ping-pong");
 	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
 
+	clkin = devm_clk_get_optional_enabled(&ofdev->dev, NULL);
+	if (IS_ERR(clkin)) {
+		return dev_err_probe(&ofdev->dev, PTR_ERR(clkin),
+				"Failed to get and enable clock from Device Tree\n");
+	}
+
 	rc = of_get_ethdev_address(ofdev->dev.of_node, ndev);
 	if (rc) {
 		dev_warn(dev, "No MAC address found, using random\n");
-- 
2.34.1


