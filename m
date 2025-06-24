Return-Path: <netdev+bounces-200671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB09AE682C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060FF162F1D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD22D5C97;
	Tue, 24 Jun 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qKUvaHgC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E722C2ACE;
	Tue, 24 Jun 2025 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774471; cv=fail; b=jDTzZ9wn+ir1Ramqlykt+mKa1v7tbfYSYsvaV1qz8GFfkU2GSo9OKlaKdS7Sc92+g48cG+U2FqliRXRBfJ3j1pV7/MgmKRxLFlGGmTRpgPisd+bRrL1a54BZQafIZgO7SE5flwWM8d1i4ep0Y26BfI9EjOzKas5ckidfvk+XPmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774471; c=relaxed/simple;
	bh=jh6/uSQVKDNAMuna8z6wHC+wVtW444ZnAypMVQWavdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2iTeGRBd5KnugvrQUySwhRuq2Q0xyA5+4Bmh4C5dN6V46aNV1YbGV/PcUNY8Cifyp+YtuHjP42cshpy8v3+JCtLRqNKALBOxmPBsVZ55yKbzNV3AwWCD67p61CjMnGMvt0f3HMjBpXutDrJX1mIH90RDOqNaRugVqJRfbBPl9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qKUvaHgC; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYxUnscIaPJd1rmk5XbZydvZ/mKX6tsmLu7g+TwaPhTDicJn6CKfP3/ljPkyY7nEtgjlpLwswtynG8mzXLOSb1cqXzLyKXEIGpnRkli9Kcl/Phqwf7HyCLEQAydtrXbfxFtiQ77r8rU9ig2xUXnihcqvF868OEgMDKgmX0D2YH7/z5RIm9BzQEto3AMzzqPWrhfceMNRsqcz8AhBQeexmoUrW2XaUQHYA/iHWmlAwnSO9JfoIwFUft0613Ta98bR08zaeBeP4jJfbGqGwGhZUnUcjcLzhXZD1zXjJTKdkTN+ySmWQZkJHXbzl4oFNKyd9gXXgXx2Tc5eHiwiDGSKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrJUfX0umdF8DisuYn7k3bG36EHpScxIMG6bRHp28vo=;
 b=lChGzMbaUs33dFK5TEkFN3UKkVGJMthuLauRFtjaTNjv7dwcFX/ULn+it8TNJ7QCFcWuGzn8HG7h+OTVMvHe0tTbVSrIXv2vy4YI6gFVuFaDixQjvSoLeAaz+/a0ILZ/PmuyChSCv5lvcuB6v20HgDo5sNFNSbdFdwnIc+L3ex8/XdbJUucvHoW56lIVpydHvRDf/4D158uOHbeZMkjVpULSEyChpyDovVvz3pY7hbOimYDcyECYxNbfK4LSwx5BDg9LnIXfVxTRuRScW3xF5s9x1k4Hp6TCNoxPhIv+7F1yCOw0qEUaeZFbzS37XQ6L1SMVYogFc0ADdg8BZFfjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrJUfX0umdF8DisuYn7k3bG36EHpScxIMG6bRHp28vo=;
 b=qKUvaHgC5bR7o8VXdh+/K000IZcg8UhZFxinBWMQaixnUZo4tz0WyzOtIcLWGiPTXP0TXn/4dYZj71oCVMl5abLxlftqYr9v5Lko2zM6yBaJ4rLeihr84rby73b7ZvpcZ+eRwW0lqxbN5zquZK+VTEvRxm5kyrDPInymwVMIi5M=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 14:14:26 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::a1) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:24 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v17 08/22] cxl: Prepare memdev creation for type2
Date: Tue, 24 Jun 2025 15:13:41 +0100
Message-ID: <20250624141355.269056-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 922dccb9-4016-458c-4826-08ddb3296cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5jTL2lpKyuAKPTdtrSGn3/9g9xdYd1bELKeWK6a0n3dYLZSuusflfZ50xAi?=
 =?us-ascii?Q?MeQ9hwQt8+pFefOM5tvz3Sg/BHyzk5hwEvuBtI414oqz/jC6tV9+Ea2zEw2y?=
 =?us-ascii?Q?5B6ID369SCjDoKX0KvGqG4rhRVvz6kFI9yGWb5LkVU3Fw+bw3AnFyZs64tdH?=
 =?us-ascii?Q?fhZiEHIP2W2hYKpQWhWUNhYq5yzo4SNteU4zhtfvalNVl5wjKr76e0SdgjNu?=
 =?us-ascii?Q?WpshvqZts6yhbiwMAiQTwnucKanGE5kfTHrRiqJD4YcRxCDoF9w+6TzTVPWS?=
 =?us-ascii?Q?cxCrhGQpXxpQipSQDWkmbHYiPnX/yPvkR5/lgPEBKEgBhCW3ehIooF5qCVYY?=
 =?us-ascii?Q?SvxKeok1/loYcLFw/bggvOt9q2ic1gg+o/UT8AfvVrQ12PJdP8yjYg3KsnNA?=
 =?us-ascii?Q?GNAPRXraMl4NSYdeetxhGxjOmlF4h7Vyg1jvjIoBIPM3ZXnggEg9ChpIna7v?=
 =?us-ascii?Q?g7kPUI1SYZD5B901LNCaKVdR0T4RZsBpagmpV1Dm5p63z2w0TPVfl5rXlG9i?=
 =?us-ascii?Q?bPc7fcG+d6Nq7CvKXXrzbUheFaNfi9RfPnuMaIibzz6xA3MZMG/TVCDdSs6/?=
 =?us-ascii?Q?qDPOHBPh4lhRxsLammsgfZIym8NG6CykL4RaT4jlhbg1b/Z19jrWt5y+2yPZ?=
 =?us-ascii?Q?1DVQOGguhRzZ1JGCC6zB9pAkfBGTaNyNqKvb3D5rFA5aqbqlGQIrjnXhpalv?=
 =?us-ascii?Q?+2SjET9LUu5M8lOAy826fJuokPRkvriCNwFBufxK9sUP23wEMNY2Mg1H1JRP?=
 =?us-ascii?Q?9n6a3Kpnitdu2wes6Lx8fsoLqaskTP/DxaURvAXVcagqKw3Na5PXsNvCSU/S?=
 =?us-ascii?Q?rHN3yhvBSSubZ5H7zpfPFz8FM16u2/aIoSmBJUK/Vh9nQdi56SdrM3EpGH9/?=
 =?us-ascii?Q?yS3INZllHSSG0mpMvHF4QYdqbFiYkWo1uUFPBr7HvZ/ci9+L8HvB8XD9TqCu?=
 =?us-ascii?Q?xkXCfIb0ipDJkTUCEaB+Kt1QgZkMZNMGCWmfk5TXAriGVJVTce5ruuFJeIay?=
 =?us-ascii?Q?6+FJ59dX3dKOKVlS7f6XEu3pIHXXDRb5OR7LPGjvwNbK+TE8QrJdyTLr2adx?=
 =?us-ascii?Q?kxuMf4PlOYV6eSlSa2deYDDwtV/vgUZlSUaLZ/BqMqtcDTUe30hRKArgWKvx?=
 =?us-ascii?Q?aWexh3YPBq0t7+3jqbFyondeSF3aJpW083QwIyUkrqIN+1alRkAI53yqRIvn?=
 =?us-ascii?Q?CxLJ2K7BNBSilkqIm+r5lY7MdyR5fOthTAERPVXNzDWtfbzoYQAZ4MMZ8hYv?=
 =?us-ascii?Q?4c0p9CiQbf5k2l41tC679WDu+z/IIE637oeu8xFhKbA/ldhKKg5PPKTAYMV5?=
 =?us-ascii?Q?/AF88dnBYTLPkWnhR7NNC28gi7c2HntSb1kn25HfBfP1ZjR1tDNylIB/aFV2?=
 =?us-ascii?Q?nLZtPZw7QSKdjI9IzSjgjESPtl00zCzQWZMhVt+7P3siWSxe9cjbIfaZfrkw?=
 =?us-ascii?Q?NfS/LwNKsUEgAz5A6n+ClYY+F1KhQdy1YV2L+fIklcknrkZIfkLFfQwshezH?=
 =?us-ascii?Q?QHXziJjj2UEiV6ZLR+gdFqhUmVWeM+PZbaaj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:25.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922dccb9-4016-458c-4826-08ddb3296cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/cxlmem.h      |  2 --
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c73582d24dd7..f43d2aa2928e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9cc4337cacfb..7be51f70902a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..7f39790d9d98 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/*
+	 * Avoid poison debugfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/*
+	 * Avoid poison sysfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4975ead488b4..fcdf98231ffb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -232,4 +232,6 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


