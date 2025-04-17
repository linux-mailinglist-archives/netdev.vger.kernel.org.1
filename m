Return-Path: <netdev+bounces-183915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C9A92C9F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707737B536B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B720E71D;
	Thu, 17 Apr 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJBtWLew"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA820E6EC;
	Thu, 17 Apr 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925385; cv=fail; b=QPFBix5f1BE15wI7EvDUMAN86Mz9pAxxYkoRLyo7LD5+jdm15GB+VndW7V89eqRTie922K8ajkANzlKlw7MBVzJj9zI0+TOwIRqD7X6uZF1ghbiXptlBBCwVD1oeFhhSKhQFImFjFKp5b0dLz+4dONHUCaENHA947qeKEIR6mQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925385; c=relaxed/simple;
	bh=b28QutyNJCGeGB6WP/uYKgdk60wuk9hUbCZNqH7Ob24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfQ2GZyYYk6ko9zAQ4TL0BnGPaADWHKtMNFzNlNKfO8KAx2RUnxmNBLmvoXzfZ+tp4fSzU5GU8TdUDuqCUeWdkcXtCx2Xkay67B/cspWnuPB2P9YANVJTrpTqrrfspnRdf29F0M2qMsO/MN0UBGZyeSGM1R+cHghKtT0dxYtXZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJBtWLew; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrrMYIK+5xPvESfdjjAm1S4BRdhRofTMkHOAWdqMGoHsiwTxKQriyWF2CRuoyUBriqna0rMkq0puWvMZbcBv+Xoelj/fslMw7HocMtJ+5LCCgaqUyVD8w+bjB+aeAVIETfYEoV2tzkfkkFDXhl0kG4LfgGii6f/2Mn4zpWN8J90+wCFUang4vPBEXltH+U72nPemdN3uvW7u7fWPl14W1ngqHisL0+K0M7Uhj783ZLs8B0StagwoTpeOWjZVZ3YQr+62dOdRA9NGdeV7w0pf91W2wsfahSgHI2FmdQR3rppI+s6ELCdGoeXhAvRf3T1MWcU7TyOI+S6COey3Qjjkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVXVYascczj9swJwlSUj95MCFfytjinhuOn3+oel8wI=;
 b=iyoNPa+j3wbQpjbAO93gzzWx9djIABZ83jpnLOhcAVzx5apEwhoLJ5pPw271MAUfYAQnUtDymJt613GMelfQZ4K4pAQKs+kR8z+zwRe05Nao0cR0VNxEBoLKSlmg3HygFtgU9YtQ7ktoW5tQdfuSE6tKemURRSpqTrfOA36eIUI3lZa4cdvrIr3dv9HV0c6CKizEKhJe8utsf1GXrtADm+eLZQbFmrTpNnqXlhlIpLLyOfH8U+jx2bqWB72En8dxsi3z6wp3BrvgDGPnag8Xi5llWu+5BsxJbxzILwt8ZZHt9i4Jgly/f305Wtr/qYSUYpMdRFjdDpVRbQ3xQaK7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVXVYascczj9swJwlSUj95MCFfytjinhuOn3+oel8wI=;
 b=CJBtWLewwJZObJ5Nuun9YysjCnavWf0E08ZQU4HZklAC7I8EQNQwAoUha+OX3b2M0kKRCC5TnHj8TpI3+5qWBXCW0TsZDIXRo/rPf2ylrXZq9eEGFVc93Yo2IT3nqPXedYmAUik7xFoWeV35hJizsGUWkv5Geviu42UnuiiRUcI=
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:37 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::5) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 21:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:35 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 01/22] cxl: add type2 device basic support
Date: Thu, 17 Apr 2025 22:29:04 +0100
Message-ID: <20250417212926.1343268-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 647bcef0-7328-45d4-6346-08dd7df6f426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWLEc+/EjJTV+MU6f/zvV4N6V/5svEPirf0XTEv5QusZZQYXjxO8jYalTu/M?=
 =?us-ascii?Q?wvojgCtoBW2cnAq5QPDlczh3EbuDLlbE4jNB/5D3Z3/nB0nyfBgPj/VAeiO3?=
 =?us-ascii?Q?VNUcikJeEX2iz0QU6TNPLvy6i5xXrWEo9pgCEgb7AOnAvrYfu7+FCanwkjdC?=
 =?us-ascii?Q?R2Y8qN+XA1i4P4dCoG03418PRcj9UPBGV+C5fRo2FUqFNh9PUETMS/T6quwe?=
 =?us-ascii?Q?4ZPJqdVBCMXtzm/hfZlB/g7LKCS2TXgR2q3E/GaO3M7G4Dg2S8vp3lgXA5oh?=
 =?us-ascii?Q?OtWHhaKYeS2qSVjYzHyJ3Kh4Tt8fwOd6TKuIEkY5Un/kmroGpYAgqxQ7uWgX?=
 =?us-ascii?Q?GtVz6Hy6+ZDdm5X/NsAUgMFx4pAKMU6wwTmjEhrV0eNDNSMVReHfrWHlqWC+?=
 =?us-ascii?Q?hEt5QHK7seceD75grhpdhFleUZs7azG2X2aj26+hXhQMYbhpfF1+ZkjPJF9e?=
 =?us-ascii?Q?b/9Uo2b53k/iyM6kttsS+9J7NGfr2cX3gBap9utogQUgvMVORJVDakKD65yr?=
 =?us-ascii?Q?wzOdQccC96D+cAkeZSVBWZuyuaw+vm4G8KqlHFl49lolObDsYnJEAPJP8PKB?=
 =?us-ascii?Q?9T2YCozQmixmxNEmsvTJxEg6GQk8ByD4bZk+bfGGKNVDhi6r2f5zq+n2evCM?=
 =?us-ascii?Q?TpMwFKpuqQ8D0vzrY20ey4mBuLV0MfJgUD26yVXGZWxBqMSW2JoMkqpocbts?=
 =?us-ascii?Q?HbmTSwCOdTDIUefWA4Gp72rI5oGBqSxI6PZsABBQaQSqMzZSoNYtwz9vTEZJ?=
 =?us-ascii?Q?Ppxvmjk7Rx9tkGKtIwUQznMxuo2bq4Q8RAMx6x7m7a+a7uPdhwLMINy8cQN7?=
 =?us-ascii?Q?C+2k6LMo+mSUxmMkDsMyCRQSi8YI1T9gmXZesJUdpyySMBq2fKbGoLYo8m7E?=
 =?us-ascii?Q?R8IaLKyLu6maKrELOmrwgzVKphjFpfLgnlXnbXzN1gOz7wrP6WygbHvw/8vm?=
 =?us-ascii?Q?JMFlxXbuB9ybbmXQB1FTsjow3AjtDjIB9YKnWYkTsw6vODVvz/i+aKWybrQp?=
 =?us-ascii?Q?AXp0YOkQi3UKndyka89TunnyVDkAdr5VvVqZjNmD/z6nwdwFCyo8pdXpr5xz?=
 =?us-ascii?Q?YxplIPREmOl1LCwYgHsMiZYEN9xoIUKiywtwboyy/xDmOUQi8CDPegqUThAJ?=
 =?us-ascii?Q?dfMMMYOlFLPcCWgpO5pcL4mDWmW+YsSZiOlz0shVTqB4LLfv/uXXWjbkv1J6?=
 =?us-ascii?Q?xZ88SLYXr9qPmxwJlx71iqrqohFQhokUVRRTQI/tM+xf4pSpiPJc7czZUO4f?=
 =?us-ascii?Q?1QXx5360MFl70v1curg9nBBVa/Kmr58fPID/MOaCYCBzFHm4YGhIcvSqtfcV?=
 =?us-ascii?Q?EyVJS4kw6k75rKxUaAVHTeX9gqZoyqgWZ1QXQ0pZh41OXrYEyorjZ+qnUXfw?=
 =?us-ascii?Q?KD8JHtei60QR575119q4NQHy4+XXlSZ9KgXCNQ/YbjXBDwXrn81c9CPsDi84?=
 =?us-ascii?Q?D99a5vCmgzoa/Nuz4pTQ3oVOTHqmdYmKBVzl2fLpghkmZmqIEUA8YZviR1sW?=
 =?us-ascii?Q?ednrAome1qqRX9ydP7+R/l/hMjssE1eYt76S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:36.7619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647bcef0-7328-45d4-6346-08dd7df6f426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

From: Alejandro Lucero <alucerop@amd.com>

Differentiate CXL memory expanders (type 3) from CXL device accelerators
(type 2) with a new function for initializing cxl_dev_state and a macro
for helping accel drivers to embed cxl_dev_state inside a private
struct.

Move structs to include/cxl as the size of the accel driver private
struct embedding cxl_dev_state needs to know the size of this struct.

Use same new initialization with the type3 pci driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      |  11 +-
 drivers/cxl/core/memdev.c    |  32 ++++++
 drivers/cxl/core/pci.c       |   1 +
 drivers/cxl/core/regs.c      |   1 +
 drivers/cxl/cxl.h            |  97 +---------------
 drivers/cxl/cxlmem.h         |  88 +--------------
 drivers/cxl/cxlpci.h         |  21 ----
 drivers/cxl/pci.c            |  17 +--
 include/cxl/cxl.h            | 210 +++++++++++++++++++++++++++++++++++
 include/cxl/pci.h            |  23 ++++
 tools/testing/cxl/test/mem.c |   3 +-
 11 files changed, 289 insertions(+), 215 deletions(-)
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..ab994d459f46 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1484,23 +1484,20 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
 	int rc;
 
-	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
+	mds = cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
+				   struct cxl_memdev_state, cxlds, true);
 	if (!mds) {
 		dev_err(dev, "No memory available\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
 	mutex_init(&mds->event.log_lock);
-	mds->cxlds.dev = dev;
-	mds->cxlds.reg_map.host = dev;
-	mds->cxlds.cxl_mbox.host = dev;
-	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
 	if (rc == -EOPNOTSUPP)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a16a5886d40a..6cc732aeb9de 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -633,6 +633,38 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+			enum cxl_devtype type, u64 serial, u16 dvsec,
+			bool has_mbox)
+{
+	*cxlds = (struct cxl_dev_state) {
+		.dev = dev,
+		.type = type,
+		.serial = serial,
+		.cxl_dvsec = dvsec,
+		.reg_map.host = dev,
+		.reg_map.resource = CXL_RESOURCE_NONE,
+	};
+
+	if (has_mbox)
+		cxlds->cxl_mbox.host = dev;
+}
+
+struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
+					    enum cxl_devtype type, u64 serial,
+					    u16 dvsec, size_t size,
+					    bool has_mbox)
+{
+	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
+
+	if (!cxlds)
+		return NULL;
+
+	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
+	return_ptr(cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(_cxl_dev_state_create, "CXL");
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..2e9af4898914 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 117c2e94c761..58a942a4946c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..fd7e2f3811a2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <cxl/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -200,97 +201,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/*
- * Using struct_group() allows for per register-block-type helper routines,
- * without requiring block-type agnostic code to include the prefix.
- */
-struct cxl_regs {
-	/*
-	 * Common set of CXL Component register block base pointers
-	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
-	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
-	 */
-	struct_group_tagged(cxl_component_regs, component,
-		void __iomem *hdm_decoder;
-		void __iomem *ras;
-	);
-	/*
-	 * Common set of CXL Device register block base pointers
-	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
-	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
-	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
-	 */
-	struct_group_tagged(cxl_device_regs, device_regs,
-		void __iomem *status, *mbox, *memdev;
-	);
-
-	struct_group_tagged(cxl_pmu_regs, pmu_regs,
-		void __iomem *pmu;
-	);
-
-	/*
-	 * RCH downstream port specific RAS register
-	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rch_regs, rch_regs,
-		void __iomem *dport_aer;
-	);
-
-	/*
-	 * RCD upstream port specific PCIe cap register
-	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rcd_regs, rcd_regs,
-		void __iomem *rcd_pcie_cap;
-	);
-};
-
-struct cxl_reg_map {
-	bool valid;
-	int id;
-	unsigned long offset;
-	unsigned long size;
-};
-
-struct cxl_component_reg_map {
-	struct cxl_reg_map hdm_decoder;
-	struct cxl_reg_map ras;
-};
-
-struct cxl_device_reg_map {
-	struct cxl_reg_map status;
-	struct cxl_reg_map mbox;
-	struct cxl_reg_map memdev;
-};
-
-struct cxl_pmu_reg_map {
-	struct cxl_reg_map pmu;
-};
-
-/**
- * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @host: device for devm operations and logging
- * @base: virtual base of the register-block-BAR + @block_offset
- * @resource: physical resource base of the register block
- * @max_size: maximum mapping size to perform register search
- * @reg_type: see enum cxl_regloc_type
- * @component_map: cxl_reg_map for component registers
- * @device_map: cxl_reg_maps for device registers
- * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
- */
-struct cxl_register_map {
-	struct device *host;
-	void __iomem *base;
-	resource_size_t resource;
-	resource_size_t max_size;
-	u8 reg_type;
-	union {
-		struct cxl_component_reg_map component_map;
-		struct cxl_device_reg_map device_map;
-		struct cxl_pmu_reg_map pmu_map;
-	};
-};
-
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
@@ -482,11 +392,6 @@ struct cxl_region_params {
 	resource_size_t cache_size;
 };
 
-enum cxl_partition_mode {
-	CXL_PARTMODE_RAM,
-	CXL_PARTMODE_PMEM,
-};
-
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..e7cd31b9f107 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -7,6 +7,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/node.h>
+#include <cxl/cxl.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
 #include "cxl.h"
@@ -357,87 +358,6 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
-/*
- * enum cxl_devtype - delineate type-2 from a generic type-3 device
- * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
- *			 HDM-DB, no requirement that this device implements a
- *			 mailbox, or other memory-device-standard manageability
- *			 flows.
- * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
- */
-enum cxl_devtype {
-	CXL_DEVTYPE_DEVMEM,
-	CXL_DEVTYPE_CLASSMEM,
-};
-
-/**
- * struct cxl_dpa_perf - DPA performance property entry
- * @dpa_range: range for DPA address
- * @coord: QoS performance data (i.e. latency, bandwidth)
- * @cdat_coord: raw QoS performance data from CDAT
- * @qos_class: QoS Class cookies
- */
-struct cxl_dpa_perf {
-	struct range dpa_range;
-	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
-	int qos_class;
-};
-
-/**
- * struct cxl_dpa_partition - DPA partition descriptor
- * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
- * @perf: performance attributes of the partition from CDAT
- * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
- */
-struct cxl_dpa_partition {
-	struct resource res;
-	struct cxl_dpa_perf perf;
-	enum cxl_partition_mode mode;
-};
-
-/**
- * struct cxl_dev_state - The driver device state
- *
- * cxl_dev_state represents the CXL driver/device state.  It provides an
- * interface to mailbox commands as well as some cached data about the device.
- * Currently only memory devices are represented.
- *
- * @dev: The device associated with this CXL state
- * @cxlmd: The device representing the CXL.mem capabilities of @dev
- * @reg_map: component and ras register mapping parameters
- * @regs: Parsed register blocks
- * @cxl_dvsec: Offset to the PCIe device DVSEC
- * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
- * @media_ready: Indicate whether the device media is usable
- * @dpa_res: Overall DPA resource tree for the device
- * @part: DPA partition array
- * @nr_partitions: Number of DPA partitions
- * @serial: PCIe Device Serial Number
- * @type: Generic Memory Class device or Vendor Specific Memory device
- * @cxl_mbox: CXL mailbox context
- * @cxlfs: CXL features context
- */
-struct cxl_dev_state {
-	struct device *dev;
-	struct cxl_memdev *cxlmd;
-	struct cxl_register_map reg_map;
-	struct cxl_regs regs;
-	int cxl_dvsec;
-	bool rcd;
-	bool media_ready;
-	struct resource dpa_res;
-	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-	unsigned int nr_partitions;
-	u64 serial;
-	enum cxl_devtype type;
-	struct cxl_mailbox cxl_mbox;
-#ifdef CONFIG_CXL_FEATURES
-	struct cxl_features_state *cxlfs;
-#endif
-};
-
 static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 {
 	/*
@@ -833,7 +753,11 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec);
+void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+			enum cxl_devtype type, u64 serial, u16 dvsec,
+			bool has_mbox);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..570e53e26f11 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,29 +7,8 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
 #define CXL_DVSEC_RANGE_MAX		2
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7b14a154463c..0da1d0e9c9ec 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,8 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -911,6 +913,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int rc, pmu_count;
 	unsigned int i;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -924,19 +927,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(pdev);
 
-	mds = cxl_memdev_state_create(&pdev->dev);
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		dev_warn(&pdev->dev,
+			 "Device DVSEC not present, skip CXL.mem init\n");
+
+	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
-	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
-	if (!cxlds->cxl_dvsec)
-		dev_warn(&pdev->dev,
-			 "Device DVSEC not present, skip CXL.mem init\n");
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..a8ffcc5c2b32
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 Intel Corporation. */
+/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_CXL_H__
+#define __CXL_CXL_H__
+
+#include <linux/cdev.h>
+#include <linux/node.h>
+#include <linux/ioport.h>
+#include <cxl/mailbox.h>
+
+/**
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
+struct device;
+
+/*
+ * Using struct_group() allows for per register-block-type helper routines,
+ * without requiring block-type agnostic code to include the prefix.
+ */
+struct cxl_regs {
+	/*
+	 * Common set of CXL Component register block base pointers
+	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 */
+	struct_group_tagged(cxl_component_regs, component,
+		void __iomem *hdm_decoder;
+		void __iomem *ras;
+	);
+	/*
+	 * Common set of CXL Device register block base pointers
+	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
+	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+	 */
+	struct_group_tagged(cxl_device_regs, device_regs,
+		void __iomem *status, *mbox, *memdev;
+	);
+
+	struct_group_tagged(cxl_pmu_regs, pmu_regs,
+		void __iomem *pmu;
+	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
+
+	/*
+	 * RCD upstream port specific PCIe cap register
+	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rcd_regs, rcd_regs,
+		void __iomem *rcd_pcie_cap;
+	);
+};
+
+struct cxl_reg_map {
+	bool valid;
+	int id;
+	unsigned long offset;
+	unsigned long size;
+};
+
+struct cxl_component_reg_map {
+	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
+};
+
+struct cxl_device_reg_map {
+	struct cxl_reg_map status;
+	struct cxl_reg_map mbox;
+	struct cxl_reg_map memdev;
+};
+
+struct cxl_pmu_reg_map {
+	struct cxl_reg_map pmu;
+};
+
+/**
+ * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @host: device for devm operations and logging
+ * @base: virtual base of the register-block-BAR + @block_offset
+ * @resource: physical resource base of the register block
+ * @max_size: maximum mapping size to perform register search
+ * @reg_type: see enum cxl_regloc_type
+ * @component_map: cxl_reg_map for component registers
+ * @device_map: cxl_reg_maps for device registers
+ * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ */
+struct cxl_register_map {
+	struct device *host;
+	void __iomem *base;
+	resource_size_t resource;
+	resource_size_t max_size;
+	u8 reg_type;
+	union {
+		struct cxl_component_reg_map component_map;
+		struct cxl_device_reg_map device_map;
+		struct cxl_pmu_reg_map pmu_map;
+	};
+};
+
+/**
+ * struct cxl_dpa_perf - DPA performance property entry
+ * @dpa_range: range for DPA address
+ * @coord: QoS performance data (i.e. latency, bandwidth)
+ * @cdat_coord: raw QoS performance data from CDAT
+ * @qos_class: QoS Class cookies
+ */
+struct cxl_dpa_perf {
+	struct range dpa_range;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
+	int qos_class;
+};
+
+enum cxl_partition_mode {
+	CXL_PARTMODE_RAM,
+	CXL_PARTMODE_PMEM,
+};
+
+/**
+ * struct cxl_dpa_partition - DPA partition descriptor
+ * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
+ * @perf: performance attributes of the partition from CDAT
+ * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
+ */
+struct cxl_dpa_partition {
+	struct resource res;
+	struct cxl_dpa_perf perf;
+	enum cxl_partition_mode mode;
+};
+
+#define CXL_NR_PARTITIONS_MAX 2
+
+/**
+ * struct cxl_dev_state - The driver device state
+ *
+ * cxl_dev_state represents the CXL driver/device state.  It provides an
+ * interface to mailbox commands as well as some cached data about the device.
+ * Currently only memory devices are represented.
+ *
+ * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @reg_map: component and ras register mapping parameters
+ * @regs: Parsed register blocks
+ * @cxl_dvsec: Offset to the PCIe device DVSEC
+ * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
+ * @dpa_res: Overall DPA resource tree for the device
+ * @part: DPA partition array
+ * @nr_partitions: Number of DPA partitions
+ * @serial: PCIe Device Serial Number
+ * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @cxl_mbox: CXL mailbox context
+ * @cxlfs: CXL features context
+ */
+struct cxl_dev_state {
+	/* public for Type2 drivers */
+	struct device *dev;
+	struct cxl_memdev *cxlmd;
+
+	/* private for Type2 drivers */
+	struct cxl_register_map reg_map;
+	struct cxl_regs regs;
+	int cxl_dvsec;
+	bool rcd;
+	bool media_ready;
+	struct resource dpa_res;
+	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
+	unsigned int nr_partitions;
+	u64 serial;
+	enum cxl_devtype type;
+	struct cxl_mailbox cxl_mbox;
+#ifdef CONFIG_CXL_FEATURES
+	struct cxl_features_state *cxlfs;
+#endif
+};
+
+struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
+					    enum cxl_devtype type, u64 serial,
+					    u16 dvsec, size_t size,
+					    bool has_mbox);
+
+#define cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
+	({										\
+		static_assert(__same_type(struct cxl_dev_state,				\
+			      ((drv_struct *)NULL)->member));				\
+		static_assert(offsetof(drv_struct, member) == 0);			\
+		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
+						      sizeof(drv_struct), mbox);	\
+	})
+#endif /* __CXL_CXL_H__ */
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..5729a93b252a
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#endif
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index f2957a3e36fe..5fa19ee3308b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1717,7 +1717,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev);
+	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
@@ -1733,7 +1733,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id + 1;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 
-- 
2.34.1


