Return-Path: <netdev+bounces-248379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BFD07845
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DDD5301ABBF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE092E762C;
	Fri,  9 Jan 2026 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="veBG6Aei"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D61C3C08;
	Fri,  9 Jan 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942671; cv=fail; b=mWv1xE0c4pd1QqzdksVgzjwP1HcTLMI2ARnAmgUnQze2In53yPTORCUryl1LQM4/FEwofafyZ1BBntKso/xi0c+wcUXx+AjxI67JsX4U3RJSSkt0W3xGqrSXuvxBA4e3ZuQ2I03N//rMh2WmOML0+2/zFc4icCkw2NYHzhr9oTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942671; c=relaxed/simple;
	bh=ObZwXmvJFRkroBkJGXkdT5aGBtiZj/VJODmPIXBcZO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cv7GTcAEKfcySK71pZuu59swnsIJRmrwG51xDGVlPpgnjYx+hK3JUGJb3Jn/IeZmMEbXWtL35TvfdSyOiqZcpe9NhXC7cX4kB21zaSrvsfRA/PqVUWoTLYOEhjplABfgFgDT0BF6XL/Fnb3rDtU8kXBSlDwM6PF8KCqQ85pWm4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=veBG6Aei; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN5zWIWTCpjGdU4DjunNXar1VR8EjM5Jr8o1IYlMeKlCrZNeWDmAxteq63holmvBCWvtkPU23WDMSIrTb5KoMWFlsOBHqIyXNPHI20Av3/dXJeZlqYFPNrQa8inmE+cSJ5QLQgjSVeVq7zFVQFBc2aTik6g7CXd8wYxtopSdOd4jXvDVkwQofywPS6rLnmVELW+zQlA5yZz0BWIIGMu0jc/oeD6Mtsq6RDFN/OWQHnQvsL5GnddeTSHPl7LyE0W1F1lcPTPQ33NneVZ/DW2Ykya2TdBdwv30VBRardNxSJaxifJslMHm+sn7maQCJoHEDkGXI0joZWUySmNhu/wYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1y+TweL+U/hQ4anp5eAH6/GBJUhqkQ76VBYe7c+P6E=;
 b=pn6YDKDgepjKM7/AmMBlof5CYg5C58FFuqPZsbWY3mV6FHO1JKOaVntgOQw9XqB6kkzNTUStClBL32IJvxkGDPY60367jsptisuAo4JT8eZo2O4/nmGqsAgAJHUiyIR+GkpC5LCwLSGPpqHQa3tc4cYV9nwb0FKqT8AyZefZpwpUEEEdl5lFyCZ1Hzc3ksOOtqpBfjBqTlXiJ/ewlinsRuPq1ckZ8XOtVIYOTQcmQ47/TVwKkGXaGfPDBl77T+RqfBQUuWDSvG1PJJcS44sXzti8sLA0mA6KjrwrIB/+0oCiN0iEND+5jpe/1Hq+4ILZdLbPx8ixSH4J6dMiEco4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1y+TweL+U/hQ4anp5eAH6/GBJUhqkQ76VBYe7c+P6E=;
 b=veBG6AeivtBHEaA81+hJiOzvW1B+08YBYL2Cpa0x3KnBOSREC2mtwRnV+KnmuUeiWKWNLsWqMBir0pXH4pF1y8i6hZP2uwNsKgmsvEoESRYi7i8fa99vz6EqNO33Z7VY/V1BQvs8LZ7AqBESlBBSfPh/BvvYgQvNk+gYgVOHbpU=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 07:11:06 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::1d) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 07:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 07:11:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 9 Jan
 2026 01:11:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Jan
 2026 01:11:00 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 01:10:57 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH 1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
Date: Fri, 9 Jan 2026 12:40:50 +0530
Message-ID: <20260109071051.4101460-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260109071051.4101460-1-suraj.gupta2@amd.com>
References: <20260109071051.4101460-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 177561c9-da3b-456a-96af-08de4f4e414f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eb1TJPb9q6eadC2ezIisJoniZuJ9rHUCFI28/g2qn6VAkRiRNPOIfcxQs6GF?=
 =?us-ascii?Q?WasxMlUiVwjM2i1JX1QlJJ89PPMd8oMA68mlUSAWxMu/10+7kZpKtVarZJN9?=
 =?us-ascii?Q?QRTc6lYsqn0+5Gks3bgjYQQxhii93/TYPyUPcbKaGeEwW8gWXFsPfjqnTIrG?=
 =?us-ascii?Q?TQZ8K+FOYSdPiaNY9wHnjFuD4AHHJUPX+4YNowoc7tx5kE55Bwd6tLyDlzgl?=
 =?us-ascii?Q?0crnsFBICZy9I0GChV7KTNooJJsCXTbrK72E+QPcgEULq0fAsQefvWOnsDf7?=
 =?us-ascii?Q?hlz5wfpgA1OtcIrJgXyiqXiaN3TdF9OpWsNkjA4gTGZT5xVTmHSj8pPorLOT?=
 =?us-ascii?Q?NUufDhiru01f98lbowEicNGe4+VHkiJIgYzElucbYON7b1Jpi3+DZNWTvDUa?=
 =?us-ascii?Q?UEUj/qSI11nwECBQw4rsbGtRvfpQ4IDcRrsR8vk+jgDS8+nP9CQOmShjNWMl?=
 =?us-ascii?Q?vJpupClI3GP/AL8ZF+j5xORkeAsHXH1yjz/fF/oRMFpJtx+SWg7eKFAAiEEF?=
 =?us-ascii?Q?VkMAY6vh9ZS4aPt7KLCe7O+djeosbyc2jZWyGfiFDYAxsz+Vzp1YypQAphWn?=
 =?us-ascii?Q?KudVI5xHAF8KXWw5zmL4NRsH+SvKydDcmj0N3rnoNYt8nfVxVgahIsCjLBwC?=
 =?us-ascii?Q?BCaj5rWbGIpmLdhU5i9lkjL5cF/xHt/vUTKhYasQcrtajPs7DyvGAwybE40l?=
 =?us-ascii?Q?VABO/VAGIC8PkZ/fGptqcpGe8Rp+YQoovIfGFNDq2mfRSd7KARoq5KksYK2l?=
 =?us-ascii?Q?bC+T0OwycvuB5Vu35TVqYne4SvpFOdbHpdDYQX3lNmEoE19NrPjuCM4K7T2D?=
 =?us-ascii?Q?cunnA8R/TkLjU01DtylyG7+NmIi5IdqeLCe9/oPLUpwQ+NZ44zHdJfdWNldA?=
 =?us-ascii?Q?Ak+Na2Gs9+X7m46vBTeiHOmt9SncdXgfM0+RtYKtekDXNkqVbBH2ea6y5e7I?=
 =?us-ascii?Q?DZdiLScl6qYlZSGcbZHxd/7Ro49IYHGWvBLdxbjj/RH5972AgcuWzn0Sh/ZZ?=
 =?us-ascii?Q?u45hDsRF1y4T5lPwLmKRpzHnso9RDJemj2/5YVKdi3966bLRrUKWISr66Cn5?=
 =?us-ascii?Q?INy6zcJihgqR+WUfIl1iM43UEVf0Ub2wLg0Xs6Lw3B1a7NEgoDxzQnSERtbh?=
 =?us-ascii?Q?FqF0v7mVFWHAZ+ZQ2N0mp9mQzIB9rKCD6Rsqh8gpShBBzP4l3O32xEJMF0H2?=
 =?us-ascii?Q?hpdiZe8wAjgaqSUgNXfsG2o8ec4gKfhRMNPFGUaE8cOCkdWeBfid3xoXc5vD?=
 =?us-ascii?Q?cI2uRBtGcb6GKvedRqz/bD53TPz8dpWZC/xNdUEgwirmEUcskEbbtAziYbLI?=
 =?us-ascii?Q?sJtm1nbh3dOQ9o6Cz0U8Mj8+JPzierA88rKfOAiyd3GDoFgFsMN6KBxVwnke?=
 =?us-ascii?Q?+Mp2FDKDUSsg+y9OHiotga5cEzmbKRwxe1pkPfsodoYWl6DpRJa9udWMoXbk?=
 =?us-ascii?Q?Lth1RRkHSFuiwUGo8vnRtSKlTRL1FR500K+5l2/3SFDUJRH/WXomxOrvFdp3?=
 =?us-ascii?Q?BUsbP6yXWiDnp75RzjbEo7GQGKeaClzapDFfcWvCV02xartsnqrNGSIPTrIV?=
 =?us-ascii?Q?RuQkRT+fv4OOqPRs3tM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:11:05.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177561c9-da3b-456a-96af-08de4f4e414f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

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
Reviewed-by: Brian Masney <bmasney@redhat.com>
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


