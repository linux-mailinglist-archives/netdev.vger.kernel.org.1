Return-Path: <netdev+bounces-249545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDFED1ACDC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52EC2305E34E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C1234AB06;
	Tue, 13 Jan 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1kw5Lmva"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5733B962;
	Tue, 13 Jan 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327818; cv=fail; b=S+qNy1/q6L2UbxBHfa73snXMH5uk2kY7tQEFjDNujqu+DFFgNsMioPPmQvQ8vMUS1OzLAA03U/Hr5+CZ/iydtw6PwuXyNMBozx+yKOd9YFM9oazswJFNsAXUf2KzEYKfLOrUEqFJKSPMEMBbbE1U3QOlkLq+QDjLgw2lHQIuPkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327818; c=relaxed/simple;
	bh=ObZwXmvJFRkroBkJGXkdT5aGBtiZj/VJODmPIXBcZO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEYtoaG+OCJzKtrRF/s5HT1mHPCO+3KJx8NtFN1y4mAq++n+yMcAAiHOcOLcwQ69TkvyPg6fMfxPnbDzHzzKpzXnK8wNlLxbd8vU1wbrGysu1H36cHiS5RjsUJ2gsGjze4MRArlz3QH5KSxJSLhHu0Hnxx9e5lyR44Nbe0NShfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1kw5Lmva; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo6sMMQytbZ912sJuDsOsTKHiysu3ReR9w2HeFkNSRjhhCqFNBu/Xv+6KNaKWEiHyZaCd7b92HNtZ57yUTNb9eeJbYfiLU8eE6dPCBvUHbTUX6Byy7/5hh8BKQcG7B5kdakdY7AT9McVBTdlIIfOyFiUikAWoJpP6y4iWBJ7NbFw1eUAGBOkEwjEEVXbhxCkMltePQts8D4BSG6DtLHMedxFV3M6oBJe6YYhuVc9E1UpFnfh8TAXWWpdln+cHWvBl8HVQCBeDMoEwObhzvcdT6lOyH1caUlP6qdFh0asbE5vKkHkIpmyjKptzWGoHr+sXWFuRNRL9VjQsTZFAvb2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1y+TweL+U/hQ4anp5eAH6/GBJUhqkQ76VBYe7c+P6E=;
 b=O/LG5OFsyKclJ7R3+vVQ7sP/CqDS/vFjrbamxj4r5UuxZcPqWBFEjZ4bLikNWSFsmeEv2WbyHEX0DTptkBjAMnKY9IvlSkpuQU73j+XUr09YmQkFVVX0fFjE89lfQqQ7zymG/LHt9UT2+z28S1TDMv0xp/l1kN7xlSRFGinq1i9BnGSMOTBjH9SGWFYZ6jAnwFSlE2vZDnu+9XvVa/v5t6Ze/pa2qg88aJ9qrGZydF2yPJu4gG4jfsKX45Z/JprhLQNG39QxZ3bCdW646yVVHorn6SMTrlXsiMiNU5rGxeatK7AtYigdXoBQqAShxJb6HID42yHNFJMF5PepolY2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1y+TweL+U/hQ4anp5eAH6/GBJUhqkQ76VBYe7c+P6E=;
 b=1kw5LmvaKvJdZDD44EMJ3dEiZpoE+48MNYLU8Md/x9Y/XDG/wkBqtw9yvjnOntYQbEDTWkg4wrFpWIgQ8nXrpUqV76ig+qUxQOR24e7hwXKccmVeApQOK1hksgvY3Yrpwl5rwqhv7TvfyYSKHSLFOzjIggdU8OSubXyY2mhO+ng=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:10:13 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ce) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Tue,
 13 Jan 2026 18:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 18:10:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 12:10:12 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 12:10:08 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH V2 1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
Date: Tue, 13 Jan 2026 23:40:01 +0530
Message-ID: <20260113181002.200544-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260113181002.200544-1-suraj.gupta2@amd.com>
References: <20260113181002.200544-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3ac914-0d61-4ba3-e9b2-08de52cefeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9IqPX0EMadoqSd0lEyyGZkp30k2jYap285oZG4Q7bGgwY8vVSMhQqZpN8Dx?=
 =?us-ascii?Q?AOJK2oCRqjaRnZadMqYMb4p0ynhHdp5t2J2QkXNmcIPI/bRTofKvrb3hpcZV?=
 =?us-ascii?Q?Ngx0Jl8UPVFxSX4c06v4ZMwVwOUihMV+R86Dsc6EeLL2KpfrSUHFvAEJNCXx?=
 =?us-ascii?Q?8EzLxsGYIuY2objQqxNUG2B4SBGSSEAzfH9ng4oMdw93Jv2FP/BqNDud8vTq?=
 =?us-ascii?Q?MOAnTHpJljoxxt3XtesBezX746daLzzNe9GUgyLRrV3X9skW/tGrRNU4Nsf0?=
 =?us-ascii?Q?n2kwtgLFImFIX/6k60ZfyZSerxuZZg/nfFycd7So9a/rirmqFf+L50PKtI+K?=
 =?us-ascii?Q?/9KF2l+yi/caC/QKNWpVfw+SZ3gBopVNff+MqwcKO46oTe6siPSDArl6j7M2?=
 =?us-ascii?Q?PJRQgz7DFCTrr8Q0sMONrxRXKxaAdZJfx0pRIG0z9GCWmomaQv8YZCAqqTEg?=
 =?us-ascii?Q?5OJ31QKc1fMl/lBZWSXMVCh97If/yk1PVGCPvsuzrTpWiug+quvv9Fv0HUMS?=
 =?us-ascii?Q?b0dp8a7Y3zOf39j965/8Lhu5skoQ4iWWZ+lTeQZPHiOqtok4s7QvzDIg6Idw?=
 =?us-ascii?Q?UzSHRz/ltGgEb9DIVysko3bg9X17F64b52aW31k9cESK+u5BY+oe7lyY20hh?=
 =?us-ascii?Q?SVRlptaFvML5IUq0isfn36V+U7ZHf+MnBFnLx7UroOKp7hyKIxd1L5cNLK2P?=
 =?us-ascii?Q?R1rpkyz0we3+3X6VaZSbNGur6awav+ICFhG+/CxLAHJYYHoWjwuXbYZ/z7Pk?=
 =?us-ascii?Q?ftSXBWx5B8BOXc99EAG97B7UrofogwYYLsXdCLqz/8GxldQJgnnGG32TZwCX?=
 =?us-ascii?Q?ZDftv1k34iunD2Xqcs/87+rgmSVC4GVGpU2K1HACoIodqRHwkrEerYVy9l3O?=
 =?us-ascii?Q?RrRC8/89/631itTifROYoTiuLapWe6RN1s83Ghe+xJqSo9+hOKRGKqrNRH7+?=
 =?us-ascii?Q?fpBXKND4fCDLpjB0cUWrI2168YoacX6Bfx2nS9CfndyfiaXWyMKCNoLE1qS2?=
 =?us-ascii?Q?r0ArzewzDt2TIp0PLvrayD/Lo2y/ue+y2Ai3y92imzwZKJpEVZzGErFMQviZ?=
 =?us-ascii?Q?NVlHzHASVvSVIIP6/WrbXyVPqMUYPo5s8/5CofZcn7cv1w2g9CTE357S/tUM?=
 =?us-ascii?Q?RLQatY0/Yd+N4p7bUMZRWnO8vCFudyFgZkH7ZMeUW7qvhmVsa/y2SBETzxq9?=
 =?us-ascii?Q?ZBZ+vCwA/sQJCqudfpwJqeiqPaPD+VuY522OJb0XddUaLOvscvKOVwuCj68u?=
 =?us-ascii?Q?hknNjkzVorCLS9h5OoZ0PhIXaJ2YSchouAd49kG763y3JN5hdqArkVaLPChQ?=
 =?us-ascii?Q?sgDseTUTFvPx/KiFph8voqcPLaXMk7/fzKfQcYfdppQidTzIskEIMx5K5cE2?=
 =?us-ascii?Q?BlIhwhmbrOdlAwq1Spj5i4ISDXr69wV7OVYsLzLB22ZH5MrIyIiiEpvvwJRF?=
 =?us-ascii?Q?1gx0c2CEAxbd6iGVcUsEDWBY/+v+nIJSWIZ/GbloDpD2+3omSRnfHTKKCrg5?=
 =?us-ascii?Q?9jjVG/C2uAaeyPZ0RP4AhlO6i4+MO4BMOQII1R7NV0YLJp30p4sygzJ4UxKU?=
 =?us-ascii?Q?VHGTzEjgm4dIQ1N5/cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:10:12.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3ac914-0d61-4ba3-e9b2-08de52cefeec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

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


