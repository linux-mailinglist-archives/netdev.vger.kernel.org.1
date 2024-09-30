Return-Path: <netdev+bounces-130565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72098AD93
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AF81C21B0D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25419FA6B;
	Mon, 30 Sep 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoO0np5X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76319F495;
	Mon, 30 Sep 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726168; cv=fail; b=IunO6mtwAovxrej9VvY4ZOBMmp7THrm1+c9EjNvuGqjq/YUDtjTb1EuUD4PI7YtvXdT+CDx4r6YvIhd+YN3GWmfjjsr+D0j4yrKi6sLx34sNGHW2gC+3ec9Kb60uIGxLLRunWOHDv7046YF0VKoBwsidiyDRzHRi6YOFmSGuptg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726168; c=relaxed/simple;
	bh=Enno56Hf5iDPfdkVVozRHpx6xSLIMGpLPrBbc0/60mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpfKbvJJ+SwFdaNpgUQ6xXfkOuHQE71y2aYRiLc8gllsMrZj+QislfUQVJzkhWiPVNRNoQkTNzW80SbemQ1Yp7iLFqRz5LghlmP2Ksf2ROHT+2+n5SWbXlazqMuSVm2ExmPY6jrX3aObK1pjzdW+SYnHLD6fOGvQfQU1MgLeO3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoO0np5X; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be3YX406YxpJN8ZK1l8kScjLZ58rY7GaQnA/q4bFBmTjgOtdFAGxvxnaWg/e+U7LoFrx8TYGn4mxvCSkw4ccGzckez6WefIOTGW+xKzzKD8r4mu8EGw3vKe2VswqEg3JOs36Fe+LyvxnFYRI/xdfZREQuNoxrIIP3lUG/EZDyoNbk6quGr8CERAfkrYC2HTfiWgaWBCQeee0REXop/5aBSdWnqOM6jAJHWihacTZMkIqHqotJdRt1ksjh31vGFE8VwloYZOPNoal0StwCxMriELlcRrpOkmb8b4Brfb85JvopJ7VC5L6XUjZYWeRMnZHgrVWYBGj1qIa7qGTmQYFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCZeE2j5wFx0znovqaaNyA2gj4bVjhrr1wHUlFsln+g=;
 b=RrInMZHUrS802X9YW05pYhT4EjB28RxLM55f7vlbIBBYtESahrNaJ3Xxy8dMRIHgdTsHuMF6wX1nT3jt6M3txFwtK8KZcgqgKWxpd2whEme/K1hkU3z44BxF0bLUkBko/dCc/hbO8CPGFkedf/qU/Z7F3JCXq6mNmxiLGwtw4+kmNkMRdbi7XnzXXRcrNAzboOMLZAWXYZCpeI0Dt0ojlDLaXag7iJI2MTTMOhUpDGYNjBlnn6RvB7YDZQGY5TKM++0Mnex34UCiWr7e/EVm2Ma0fEspRv3e7sS8DHPD8q4DCD88uXcvpsVUVOS86E6rvVTD+fhN2GPvx6X3sAKniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCZeE2j5wFx0znovqaaNyA2gj4bVjhrr1wHUlFsln+g=;
 b=aoO0np5XDbh4beCHN8rIFsDtBIM5NOoKky0abqSFRVp0lgiWJJRmsZI+5+VSoF7loMzYngbADBsTK3AvkmveQ8CzfBF018sx4KQNQ7W6FkprnsSgeTO1C1JtX0d14olshDHUFbjXJQ64wOA9SLS8beeMoB8fs/reyl8YlV40ZAA=
Received: from MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) by
 CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 19:56:05 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::6c) by MN2PR01CA0064.outlook.office365.com
 (2603:10b6:208:23f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 19:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:56:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:56:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:56:02 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 14:55:58 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<abin.joseph@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<elfring@users.sourceforge.net>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>
Subject: [PATCH net-next 3/3] net: emaclite: Adopt clock support
Date: Tue, 1 Oct 2024 01:25:38 +0530
Message-ID: <1727726138-2203615-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d10f1e-cc93-4f43-e60f-08dce189eac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9y6P7ZH164ktDgeAKd79yr7n8KZNrSnlaLCl5HhhFL+ckQVPnCBULPuUPBW?=
 =?us-ascii?Q?OckRqieO/tOL8mRLhv6yfIcC+ECV15A7g2w+fGkUJ5KNBlQjuecJVHqbo6gr?=
 =?us-ascii?Q?fuqASCDDd/hu79iMngfbUgYtfRFSGvVabHx93K9N3QepgUOrRUr7ZlB4m0lx?=
 =?us-ascii?Q?pfz2xLdakBljOXY/rT2BkJ5tMvXjaBsmWVJAU01JJVTh8poZJ5QFtgtnBCOr?=
 =?us-ascii?Q?6LB+rl5uHvk/AenG7Vl8hzcGjy8vxJM9f2O0xfVvCf24s9rJ5Z+w1sfLrpKu?=
 =?us-ascii?Q?A9bWnRcPj079GtwybW0g3dwtXrSReojRlNnIyjai4/0v/yksiuDvNc6dcxQa?=
 =?us-ascii?Q?rKmJCxhjs5Jif8XkiK5agsVKdHPKEuNOKjx7v+WAx0vWpuYZEpD6VGaVDmFz?=
 =?us-ascii?Q?Ck96eB39Z/XMjQ8TofG4cLYL6v9x32EjVTSS9tsnOuIb8vG1QsOxiCYsdY1I?=
 =?us-ascii?Q?eLwj7p02uMR31fHN1lhMFDHwfzSXVh9hjjrKLmJbs7wmJn6hUBMzshJ32+cZ?=
 =?us-ascii?Q?nfLrpnojM7cU/Zt5PpwQBe5IamirJyNohh//I0WxNEGwFOsAXVbege7ARQZx?=
 =?us-ascii?Q?/91bCeClV7YeruXQW9Eln+K64jVzftNeXs9806hmdSpRek5d5K4/7aJAl71f?=
 =?us-ascii?Q?FcyAbEZH18CHaH6GPPFlPOaUEOK/lHNYss96oceC6Rj5otenhsIHo+zAWUh7?=
 =?us-ascii?Q?OBnba0naVHBSipkT0zBUTINQcEdpHPk1+i7xbnPC5AqBLw9AMo/Wi5vsQfqc?=
 =?us-ascii?Q?jsuDE3oW0gPxdJ7Dv1YkkCafMPetz1t37XcGdqK09hdmeWSlkJBzaJ+ODfix?=
 =?us-ascii?Q?flmb0ya/3ausB8R38nz/+vJAdfTD8JOTYf8owIEYTmLAvo0vja7Lp7S1uER8?=
 =?us-ascii?Q?njA/Ez+6tkJ7vX4QgaqinnROlnDZMtQlOAcylvpCHD4Kj/QkWHmeN16tGDFk?=
 =?us-ascii?Q?3axYDlLiG1sr0wdbIpMezDEs9A3Wf4yoLa65BqF9+HHDUs7zFQzHPI3vdo+K?=
 =?us-ascii?Q?yzU1tF+vnHUrKD0uwtMCB8OANA+GKE+vfu6FoAdTzom1gHKrN72Rl6maLxJx?=
 =?us-ascii?Q?aKA7A8jL3rXOaC/D3no9EepM7TjR6UYgMSa6Qx5WxpOwtChF/T2mdsJQ8Rq5?=
 =?us-ascii?Q?2THK6sH84eqCvEXeynFMkrRR65t3+SSIeaFM+eYmp1YWarMk9yhEjR46x0yW?=
 =?us-ascii?Q?tHz0Pfp95niDExPYEsf7UupWAOVCtk1t8qwRO0p4LlV6y3iOB5+Q3h0zA2sh?=
 =?us-ascii?Q?dlM5HMXQj5wRRChqPqwPbO3dVpBV9xjv8CCUw1J33pfgAMZ61HCBv6JlzbDr?=
 =?us-ascii?Q?6XmuzHHFulEToxHXm/Px6N1RXRQHKyTZETB5ecO2Az6LAISOYn5gSTK/DZNT?=
 =?us-ascii?Q?cgp5qK9MVjFzEenO0wIsnJ//ty7B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:56:04.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d10f1e-cc93-4f43-e60f-08dce189eac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

From: Abin Joseph <abin.joseph@amd.com>

Adapt to use the clock framework. Add s_axi_aclk clock from the processor
bus clock domain and make clk optional to keep DTB backward compatibility.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 13ac619df273..4f469eaffa07 100644
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


