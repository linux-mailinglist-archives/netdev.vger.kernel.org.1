Return-Path: <netdev+bounces-250616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C499D385D2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9E32302FBB4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316439E167;
	Fri, 16 Jan 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sJTI3Rmx"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB33A0E98;
	Fri, 16 Jan 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591669; cv=fail; b=cUr12RX/rBceRH5Krh0091OyXg/ML0uoF7pcWpdpLh1rFwWXpFKsy+nipQt+fzqCBVyDPADdb0fAkyUrG7OqKd9qU5UdHtPahCbqfW79WVeYZ0xOP41wzDJslEitfOJfeVqA+dr5CyhmUfHtJgwkdJiHJS+u0nT/9tbCPSStxBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591669; c=relaxed/simple;
	bh=t8AIVLWdCaY1rbvsZfZvV1eBZl4zASH50xs1/aO9UI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCaJca36k1EGYQvERcPOsrh9k2YexFNNGDQKfsKfJ+VpYvuGiRtD7QY7fnhQmF+GlFW104LdM5cM3WAc84xpOl302RBmjnwVtx6DXVF/A9ZhsSi5uXOMzoaRcnhE7fQ2ceoDpYW4Or+3mkAP6xklyA3JIq5IR4IMVEzG5iB/k0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sJTI3Rmx; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/bPcW3237nLCs48ogKCC9IGjGg/BeMaCsh3b4nuDf4MQ9wlQy2vna7Ty4sQ2WUrqLef5wbKhqudkFVGxAbu2YbXj0K+I+Nhnp2HkswumwOBR5C1QInGRTI6JNxjNN6bkMTNX0qSrKOjShuKfWXb7ArdyezM1Y/Unq0yuJUKygVdnJ99sYRc5LeE+/jJC7wmL5yJtVcJdI5B+CnN5z0fmpGq7xjBTCAOnzp/nUJE7gin6EdlM8eK83HZUUiizSKdKxIYbItfrzzCGmpVgN6wMZNpQ7kBHvFR8YL1wu+tIv51QRmHXnglzoJSNOlLQc0Kx79Yb4OE3Mr6JFHwNHYfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbrVd3eBvdNXPN5GNCFOy5FnXFUpmePFVMTpgaRDJBA=;
 b=CjciF33Anz22flq5ZtKkhmVCZKPZwdB9Ko9pZLCgadfPrPWTf+8ezeCIyj12/F+xOktOXyGbmuzZj9bfmawF8awdx3Dxt25k39No0MiQbI7bDL7U1mzqCe7TE6wsAwbLvwjkxBQw9+MVSY9OChTdb8fxlXe8UpAIkRVMgh8fwl0Pt5p1Yz+DqmJjhz2sVQKkdVbj5b1FSNOEe26M297xPeXkEHnIlWLz5lLboqlLo6M+91kiNm1HA0cNnRZu/Srtc7Zs53VNouwc1/jgNzIP3YQHtlSGJ5eh4MJ3n5puDyG6r/jKaqdQ5lXpLBjnYkBWWPSx7XjuJiUU4ViaW8NzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbrVd3eBvdNXPN5GNCFOy5FnXFUpmePFVMTpgaRDJBA=;
 b=sJTI3Rmx6SKLdxdEjM5E8JEkvLnjXar9tsN0ctoKOMWDxgwN257xo50Xex8uphULRU9+FoHy3EaJIKxXzM1m35KnGfBnBARHAxtV6PqB1pNHvNL9nmq0IIESpTcqA4hYSZrPsBLVTPMlAraOPExdC7EL7/5iuOgm6RJL0Rcu8Gc=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 19:27:42 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::f5) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 19:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 19:27:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 13:27:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 11:27:39 -0800
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 11:27:35 -0800
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH V3 1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
Date: Sat, 17 Jan 2026 00:57:23 +0530
Message-ID: <20260116192725.972966-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260116192725.972966-1-suraj.gupta2@amd.com>
References: <20260116192725.972966-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4742c8-8a83-4f59-0574-08de5535501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hC2MRO0PSTRutTX93OlfUTO50xfGDGVWpQHonZhDS4X8rYUd4z9sx6BmaioH?=
 =?us-ascii?Q?ohsaL2FeCC1zE2TV6P5PwjQ4dPKDsur9VftK5q/GRPZLIsk+zrDM2Z31mWOC?=
 =?us-ascii?Q?JQioEb9tsPFdsORsNB6zIzDZ74MMYbS1oRgVRPkNupUfijuWE6UDATkZp8qs?=
 =?us-ascii?Q?A5jlG2R7/vOwoaM4ea+JcY4V7fqL+jsgl7n1BV1KzllMi3vgYA3TSBqkqxYV?=
 =?us-ascii?Q?usIsGSsfuLnZ1CG1npeuCcXk/YLMBUSwO4sg15TWZr/wR7A7gpKPafRMipw8?=
 =?us-ascii?Q?OwQiCA9bZL2u1eNCp1/g1BAQqq1GXBbpG6/Sd9GYUxIkMlyYgZW8g6Dbou3s?=
 =?us-ascii?Q?LpUta/8PvdxSLh+n2eoVE++KFBY8y5yP3a1ad0tDFTbI45xpMJhCuFTpc+/w?=
 =?us-ascii?Q?XG7lNjcBbhORxKJy7bqtHrl66L2ypfIdTShGkgWroYOH6G3lLzdT9pDxmZ9h?=
 =?us-ascii?Q?6hR5adoSiuf/sEGRZ8ajtRaHeK4xruFsErXN+VKhkmqwvgVDYEr5BFk8Nr7G?=
 =?us-ascii?Q?r2KB5obWSg96NttroPvovN9wbFh3tAnhsl0uNolPmll+uBmUAERTWBsiMAYN?=
 =?us-ascii?Q?dp2ihZRpmO1GyIqO9IoGUFZiFQhRtFFrToFjfdVEokuwSnpECtqTdQswmY5B?=
 =?us-ascii?Q?+dg4ZZUjDS4yWvkCgNU4YhOO2scSsQfdIUmyGM/isMHEFJZoxmyQHNnai/xI?=
 =?us-ascii?Q?OYXPFuyyJfL/xUb1+evclOu+oRlDobB8gRgSDWTtWpY4ya85tAQOx08oOpV1?=
 =?us-ascii?Q?5h3nQsyMHtr2AbxaeMKEQZU1gk5rAbTJyoJEkPmuzGiUjbuSHTDwRf8vE9K4?=
 =?us-ascii?Q?8MfGPH5daeIqF7LgaVGjxoTiXkn40f0wCXDf/zJ1yr4ejXme75SXHYariNHK?=
 =?us-ascii?Q?SnGc/81J8RUNBDgMnLTzNsxy++l/Tv+gZOAl2TzPBBAxLbLRGnfpnQgiaEae?=
 =?us-ascii?Q?RKuazqsXZRGDQf7lGGymOmB3rzpVqIeWCg//WuXMQudrF8VR4OrZm+tgqxmO?=
 =?us-ascii?Q?zXxWAGgr7gGndDtbUtyI4S/kO/GfJdWAvF/z5LH43V9/FPCRY+oKj24dSwJp?=
 =?us-ascii?Q?bh4tSKVRUpoHKLCLAabdsnheAqXQrxgRSE9rpm6p6A5Mq5GdxoVPQdYZqFhX?=
 =?us-ascii?Q?Cl/l0+zXlDSE5lIw65maOwTgdyYlnTdMsJug0mgPuwqx11AjsDSskexWGn8P?=
 =?us-ascii?Q?ZR55MSdlJsHUeewSOatt+iA6dVV8KD5nl29DmFyNjJNozcS/6t5EzGI6Xplg?=
 =?us-ascii?Q?2DEauA7qZW4Gd4kIVULnOX3C9aHpIBhSwWQnYu68+wYJJLK1iZmSE3KwezYf?=
 =?us-ascii?Q?Luzb3+e+tfgYCHbniRmU7X7LYN2sZwjgzRjTcUreT0FY2sIp0mT6WLVir9d/?=
 =?us-ascii?Q?B4mAEqM5Su7toLabJeqCRnFTryrfQXkoPSX2Vd1S7sEjyCmFIXl+MWANl+KZ?=
 =?us-ascii?Q?tak4nQk8eHQLfZf2P5V1BUzfT0AHIsJiTxDVCGpGg7wM+qVJuxWU+NUTkszY?=
 =?us-ascii?Q?4J7wXnnufIer3PsolHILoZy6dYt6aQHESGl+/crAXBnMeKQ1vKalfQjNzxEH?=
 =?us-ascii?Q?myy0K/o9J0IUm2DXuSpgLfuYMdqSD10E61D5JIBGiLVZ7tAcmN23u51UUIIe?=
 =?us-ascii?Q?xZUPxSWGiw7/fzf1bRiPgV9PsIqYz4a0qILpS4Zpzbp0e7RfViXz3Fh2lsKm?=
 =?us-ascii?Q?Fne1Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 19:27:39.8394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4742c8-8a83-4f59-0574-08de5535501c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

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
+ * Return: 0 if all clocks specified in clk_bulk_data table are obtained
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


