Return-Path: <netdev+bounces-246549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22668CEE062
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 807AC300509A
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81512D6E66;
	Fri,  2 Jan 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlKIcNzU"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054003FF1;
	Fri,  2 Jan 2026 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344116; cv=fail; b=MqC0gfvcokxSva1Tz92Ip9U6WUZdrUcuOYrJe1fLuvg288C++XcARwB5ndXslOSbZrwCDvLcF3UzGGv2dlW35B8GgsiUaFC14KZtFaHlJRRZyv1iwWiRNOVU4RAycO5cM/vrrEnySXMxn9cmKqkKFQr7zBzoFumEs+oUWsxzDzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344116; c=relaxed/simple;
	bh=IQLUJfuGUF4psTpnRJFfyrvZIgeaooMogIF+uiiWexA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlIe3dzdRhrZgCrNRlSX6oyX93ZOQ/be98iuJC1ee2Ra188/qvulEQPBDM2vLFaXUjEWq1ijTO3K7sVlK2QxINFxtQJa7QYtsHr14t3O7JXGV3BabmrkX6FaR8aFdkqNUypl1pDA52MiXeXUTkIOYl5xEFjbblKy41cPDvdAHSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlKIcNzU; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0vZg1KvBNKb9vsrnD+Iy4Md7HxVKxZQ5SGWLmnGnWibbdXBNUq7GoybeTJzUFcFL3SNdIOUF9crVrhhAG4cy3ixrBFEH64SdqShAg9xbjZRoOOEenq64TinvlGwgQeAQWzisL6kU5Bs731FyA+ynaKpYQEJVxkNFCwKQrhZpf/NPvdhgEv3XTuT9VdASP7Iy1ng9tCSugxjsCowsQRmUK5OKMfBtSbkg7eWcH7sjW29pcp/qpHROjOu65hUpJZ6NjsBwRTdG3qotm+bWOTBnXR+Ncc6Loe4iuoCC53co6iQVR9IYcOoQAJ+rDVm1GrKwb5zSwukv2t+yhbXW9tFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rmo1G2uqxHyV3vtME30C+kkfROV30KoVzZ3djrPvh8=;
 b=ZLEj0IMUDriGqEHbeIkU25k7y801ppDK4lsb8r8i67pGX23kZQDucmtyQDgAaTsMEX9NkoCcUklCH/wU1Fa4a5MHo/xvbTCl6o5wRocedxZMgHwCc2OUmARXCpwqxJjYNEta2nVXH5CbCwqo3CMBEwRK3SDLTneIqXIMUFwp3+pWhHGPjzYYmqm9X409X8pCUkGQ+uGjMcEo/V4Xme1xuXfwNa7mTI9F4vd6up6BNzvKhR9baajf+sfrf0Iu2syE1DKzg0v80SXYz/0yu+7Lc+W2ohQiiD6VK9pRd+LG8xtYI4gGPg4YMfFpPwZkzy0GIDDnQt1JR1WdKfl2RRxhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rmo1G2uqxHyV3vtME30C+kkfROV30KoVzZ3djrPvh8=;
 b=XlKIcNzUsjP1ZVkZcf4dcSggNRjYVkBRnsPgCMbbkBrI5PUFYF3G8o8e1RHSQ20Ki4ENaQ1RqkkYSIrPZQ46uvgcJ9pYzl+GWmmgQLEi3amAJvAZkizViT6cHfH+QUpAFM8wtS54qI83TjnFw6SIgyuFw55r5VP/fI3Ap0VWPec=
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 08:55:10 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::c5) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 08:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.0 via Frontend Transport; Fri, 2 Jan 2026 08:55:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 2 Jan
 2026 02:55:07 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 2 Jan 2026 02:55:04 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
Date: Fri, 2 Jan 2026 14:24:53 +0530
Message-ID: <20260102085454.3439195-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260102085454.3439195-1-suraj.gupta2@amd.com>
References: <20260102085454.3439195-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aabd022-0deb-4ea7-ebd2-08de49dca2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dHTyYKb1q/AjPx2JuDg12Ew+ovOC7lH7MeELArV9TAasNG20kKzvCU3gp2e?=
 =?us-ascii?Q?K66WsWpahDqZ+E8LMDd7iMlwsarKjtU2J0XcCjuLb8fIhS7qq2tJK1Lin53X?=
 =?us-ascii?Q?BFUPBDuzzEqcsBPNx8bFW9VchSZHN3mt3I7C97pcClDw+6VhPp/sidOX8wu+?=
 =?us-ascii?Q?0Aaf8nAfvyLOdRnpXET8usWN+XUUxLI6Yl5BO+hSV+j0IxNO70yyz6UNPmxz?=
 =?us-ascii?Q?ok+w8SEDyFKxGJ1qxi7AvC8PE+GJt5MCnPhclsElRQocq1LVwyDvjgS4+rON?=
 =?us-ascii?Q?LJCsryz3xVBGne5TsJii5xCtXk7RcTnjH/V+mXgGFOYE2fDJBfKe24thmfv+?=
 =?us-ascii?Q?u6UxwGCb5u7bcOY8yuT5rqi2Svj7Bw0gETGViNrs4j1iq1yk5V2CdL5MB/sJ?=
 =?us-ascii?Q?l+VRo67UmXdSy5rfMkVWNe69rKPHM3e3uOj933yVxhvsNVPT0HwBj9Sp5eOx?=
 =?us-ascii?Q?Q/TCWARCVPCK3q73Sbw37hga9Z447GtZl4Fb/68eb2X1g5EuQ3NN3Re1LE51?=
 =?us-ascii?Q?mqQffVkXTPIoEDzr+/DIW8X71mlbRBaTQ8SP2zELDTFl15lPrq90eoTB2JmD?=
 =?us-ascii?Q?6S+2vqzATJhwlf5G8QzpJPV6aXkN0GRbWX+O3CLBEe7P+LlxkT8IlvjbMtXo?=
 =?us-ascii?Q?4q46PShgfsA8AUIzI+JP2E5bQoZz+nV6njOhqzqJl39dXZ01XqFsgvlUfzg8?=
 =?us-ascii?Q?RWVT5N/1WMGQOBKdv33ToJqOTxrVGEfwg0DwQUh0JEkpPUDTH9zl90s/Urv6?=
 =?us-ascii?Q?4wff5FkIfAZg/2IzwflI88TU2cYrnFCSY1x0ENDlqYzxhnVdbUeVy+q2T5bX?=
 =?us-ascii?Q?tI/By+OynLivd/fAdlezs3wAFhuZBBwWm6T11aeDeT3cu1Z4KtbzNXwIjFK9?=
 =?us-ascii?Q?lVI/pPjjG0d67DCwKevi7UIb8eXY70rDFQlzT7LaQEse0ZNQ2Y894c4usvmb?=
 =?us-ascii?Q?3Dj0JkNzLnkZdkrs20K8hD8mh2JQQyq7PuQ5igwEwoqWUDVA1AvEQm8nMnbJ?=
 =?us-ascii?Q?6raxG84swqTJLVHbSsOKLmouUKq97wiuVfRTS70Md9gSIRX5Aj+ofUcVcSqC?=
 =?us-ascii?Q?AA0sMHjPMlM9zsQmO4VhQFc1Zl5U7NZQrGwW4UoxhHGofK1R/abBMF6DAj4R?=
 =?us-ascii?Q?dMqZLfj71KywFlilObUw5YmrQ2sFerAx7JXfaRa7fT4AlVBlr75fdQQUlo0+?=
 =?us-ascii?Q?tjayh71SgaJ/vOgCu5o3ZvedepavOx9HCrkzkqOx1HLbVWuHluaxzUGHQWUf?=
 =?us-ascii?Q?jAw4olpawmWo/Ljy+iRHRbAmDytal6KnmBjF0EU/KkcrQ2IQkp1PQz1HQP3x?=
 =?us-ascii?Q?IDHZkEvmHVxmXwJiwZ5bsT381TIe+0uBhY035tKkOmFjznSjHS3E1kbOSDhm?=
 =?us-ascii?Q?IWkGACJMa2ZqSgh6PNCy+JNGME24oQ5BgmnyXuN+fr/rHNXxCkJmZkJZb3YF?=
 =?us-ascii?Q?tU2g4CX8N10477GEAsebbdILfNCkYj6Grh6DJGJP+hNubZI2OGnQXhvDrHHk?=
 =?us-ascii?Q?+BjXqKBohEf67Gxw7YuXkMkW6H5WYLTSYaq9J3iXKBGlrIRQhZ6QzdmxqWwl?=
 =?us-ascii?Q?wrVc6Ch7S2B8CyHhNk4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 08:55:10.5290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aabd022-0deb-4ea7-ebd2-08de49dca2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

Add a new managed clock framework helper function that combines getting
optional bulk clocks and enabling them in a single operation.

The devm_clk_bulk_get_optional_enable() function simplifies the common
pattern where drivers need to get optional bulk clocks, prepare and enable
them, and have them automatically disabled/unprepared and freed when the
device is unbound.

This new API follows the established pattern of
devm_clk_bulk_get_all_enabled() and reduces boilerplate code in drivers
that manage multiple optional clocks.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/clk/clk-devres.c | 50 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 23 ++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 5368d92d9b39..994d5bc5168b 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -179,6 +179,56 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional);
 
+static void devm_clk_bulk_release_enable(struct device *dev, void *res)
+{
+	struct clk_bulk_devres *devres = res;
+
+	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
+	clk_bulk_put(devres->num_clks, devres->clks);
+}
+
+static int __devm_clk_bulk_get_enable(struct device *dev, int num_clks,
+				      struct clk_bulk_data *clks, bool optional)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release_enable,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	if (optional)
+		ret = clk_bulk_get_optional(dev, num_clks, clks);
+	else
+		ret = clk_bulk_get(dev, num_clks, clks);
+	if (ret)
+		goto err_clk_get;
+
+	ret = clk_bulk_prepare_enable(num_clks, clks);
+	if (ret)
+		goto err_clk_prepare;
+
+	devres->clks = clks;
+	devres->num_clks = num_clks;
+	devres_add(dev, devres);
+
+	return 0;
+
+err_clk_prepare:
+	clk_bulk_put(num_clks, clks);
+err_clk_get:
+	devres_free(devres);
+	return ret;
+}
+
+int __must_check devm_clk_bulk_get_optional_enable(struct device *dev, int num_clks,
+						   struct clk_bulk_data *clks)
+{
+	return __devm_clk_bulk_get_enable(dev, num_clks, clks, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional_enable);
+
 static void devm_clk_bulk_release_all(struct device *dev, void *res)
 {
 	struct clk_bulk_devres *devres = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b607482ca77e..ac0affa16c8a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -478,6 +478,22 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
  */
 int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 					    struct clk_bulk_data *clks);
+/**
+ * devm_clk_bulk_get_optional_enable - Get and enable optional bulk clocks (managed)
+ * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Behaves the same as devm_clk_bulk_get_optional() but also prepares and enables
+ * the clocks in one operation with management. The clks will automatically be
+ * disabled, unprepared and freed when the device is unbound.
+ *
+ * Returns 0 if all clocks specified in clk_bulk_data table are obtained
+ * and enabled successfully, or for any clk there was no clk provider available.
+ * Otherwise returns valid IS_ERR() condition containing errno.
+ */
+int __must_check devm_clk_bulk_get_optional_enable(struct device *dev, int num_clks,
+						   struct clk_bulk_data *clks);
 /**
  * devm_clk_bulk_get_all - managed get multiple clk consumers
  * @dev: device for clock "consumer"
@@ -1029,6 +1045,13 @@ static inline int __must_check devm_clk_bulk_get_optional(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_optional_enable(struct device *dev,
+								 int num_clks,
+								 struct clk_bulk_data *clks)
+{
+	return 0;
+}
+
 static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
 						     struct clk_bulk_data **clks)
 {
-- 
2.25.1


