Return-Path: <netdev+bounces-224321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009BB83BD5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8823854067B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A0301034;
	Thu, 18 Sep 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKO9g3MQ"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EE2F9DB8;
	Thu, 18 Sep 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187111; cv=fail; b=tN8uw/KPrkTRnZlJvvZQIpk0z0rxCnGJcb8SKTpvU5xajibOuXgU+yKvC7Gg+FknmREMGeWda7fBpSKsWXrXxCPhHT0EnIsDpvIu5EyzzybMvApyj1+XXqA0i284wfVNW7VVzCPgz6YlGjh0nSWg4Pvo2WwYuWQ9bQiMObaE1wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187111; c=relaxed/simple;
	bh=mlmqdUGUpgwmECU3wCIPAiijr92PfhRbgTr67y/kh/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ix2nv/oBNIxh1CBYOXxms2QEkBbHdhVDqAlD+pCDkm3ius8dhLpGuBKP5pVVZBl2j8OOKWJSZ7itAq8rNpmeA6zZ5n8xpiAWCEFJgA3eviRlgllM+ROAvC/GD1J5BQd36F6kJ64mBSp7XBO/IGQyAuPP43OqFhGZyV+SI6wO1HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YKO9g3MQ; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoOIdAtzzbU68XOgWIvnZSCSRVMW6StIvowtID+1g8ed8hFDHRxy7UtwZDjTCvAvBdD7rIKnwmwo8Zki1rIPPyJEZkdLYzFGnelBQbKMmbBeHh841HFYfWfpqUxmAEYYEQ7f2dl2Hvi5epaMhCqt+ic92kSz3BKc4VRqf/8tInFiLtve9OMjLWOEUfwwVe96n5UN+EvwXcQMhYBwBzjmFmvTzKdpeApn41hA6A71ZdBNJ+eRoLv2fd3sTzRf7Gq0DNVH6d7lD6xD2SUfraj+Rn1ObRo/inrxdRA5vc+k5l2wx2Gb5ROBae7rzMu16h4+wfbG7/ZasCORJfsV8dvxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk/mPmNe0dfDfl0+A79Xi48abRoY9N7/EsDM26wg8e8=;
 b=PfHwoly9rWkP0FKnlF9+Eqz5jB90LxzrYLGuSzgjEFzmK9nbfNP3Heriwh2cWqMie2/Uw0QLPDYsp1Ry/bUHYABSa42UEB5O9B6+mMuaWPGI5uYY779pi075mFep7MGRwo11DpcpKcJTlLrzZNztvnrCPMaP+rqthAZIvpgWVXWt0y3id1JpUbv47g4BhqEW8PrpYFBg9fOB99OLbf/EnaKUGrCBNBd7W3AQQFRevlk6wmZQNcObj0hQMVWcoXgRtLRHAfe84AZKipNKWI5+bHs1XrVGCodV8qG3zf2GbDMjs1Up8CQEdqISk5YM0xVVsRWf/wzaOcNQmskseNh32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk/mPmNe0dfDfl0+A79Xi48abRoY9N7/EsDM26wg8e8=;
 b=YKO9g3MQ81p8K9KnrUzxefUgZ7/tIm/E0SmDKhSWqncBPoVAcLSyGi3pNvnmeMX1f8YeP0Or4sOpfKyZ0X2c4swABuyHq/iDMmJnVBxxUfCcpFyailwxARM4VE31C5BuVzgmEGa0iJSb5C/4l2T8v+r4eNzPE8o/ADoT7Jt05mg=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:25 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::e9) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:13 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:12 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 08/20] cx/memdev: Indicate probe deferral
Date: Thu, 18 Sep 2025 10:17:34 +0100
Message-ID: <20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: adb40909-a08e-428c-7245-08ddf69451f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVjydbl43/Yqq1JZpMH0cRfV2JYcS4cwSd1K4xp9Vr0wgcDAowGtEyT7mj67?=
 =?us-ascii?Q?HcEApfwU87wTpEqHRCj9cj7+cuHG06FsTwmVnrpuBOd9DrlLWALCCp/zGo3T?=
 =?us-ascii?Q?Y/aEjPHHbE5+3VLQ1od/SiFEjR/JGXtd2yWc+bF/OQiT+Hq2XjKg3Gj+uRiB?=
 =?us-ascii?Q?LMiamlbCa2N2nsOv31itAvFeHNVD0D63zsuufQ6KILjVlZqu+Kk2uXeUOZFJ?=
 =?us-ascii?Q?CIjY6inCw/Jlyt9WbGUDsM1ukU0B71DY4EXkj3QQQ6uzoIR2xghqwaX+O358?=
 =?us-ascii?Q?bt2fI2Iz/VsTdnWjvgQlRJmIBfAIHk2kiV8/yRiduQoq9WudXOdzRfimlexl?=
 =?us-ascii?Q?7/BPvT9O3dNMM0IVEgYYBdHScY388QJKEXWo6g5U+yl3w4OR+tXzshBjrRyt?=
 =?us-ascii?Q?Q+L1LT9mE2BdATgQVRfQwCseiO9YBmzYpejLIJTR7ZZicSvRW2YdS5CFiBmy?=
 =?us-ascii?Q?dunLH1HUsANZW5guuZsf9PpWhskruTdJj8aaxN2lAeY2hA7NzyL9pefXZWM+?=
 =?us-ascii?Q?r1U60o01BGXscNa2awvoz/PRhhdqHwF+ickATE3/JbhdD+rFOpwMsY95QqpG?=
 =?us-ascii?Q?cSn9IlaIzosf2iXmpGWSVI7NXK0ivn+L6nmQQ5aPnibeWeLen/06RrR/w6VX?=
 =?us-ascii?Q?3p064GD+wVbzIw6eYoj/suqq/JgNsLG/m8kf6pPJWJUJ9bYP3Shc8ZzOjALf?=
 =?us-ascii?Q?6dTWOJHZt3Wkn9UBM4P3agvv/TdsltzMpl68UEQQ7+/uYQAXv0ab9SBqaYuF?=
 =?us-ascii?Q?anOWj1823cPl2o4k7BN0fzzZ6Yo4/opzzhFBP8TypKqq8dB9Wkf1uKzNZ0bP?=
 =?us-ascii?Q?yJd7zKgsZEloHcopXEvvcWSDSHTMRD6PbkOqVG2Xeo0kqBN0Gyi8Bpbx/ZhM?=
 =?us-ascii?Q?OSENKoukqxUD0YLM3mJYMdo+appkns+FEU8nwQZ+6osj7GY1Gu289MwvLYsL?=
 =?us-ascii?Q?c2ts8hLObkZmuIHBwo+gtWpiq78YWfNgaWAgraq60gydhaMtD+cDXTYTORCH?=
 =?us-ascii?Q?+4GDjuJPVFooFXaA6J7leluMeqc3vPbOWkKAxtxi8L/7Bo4fso5tNrXN3jnu?=
 =?us-ascii?Q?f84niqTD5RjTQRV+PNwMrjOppxtEC3bmZwU5glgu2+/gqOZ3BHTn+aW5RSO5?=
 =?us-ascii?Q?z0ch4SaAyjy5YEw1X+n4sl5ds29tFnOFZSoPv01SVvzkohXFmTFqdhyYJVPh?=
 =?us-ascii?Q?VULMZzKZv3LXCSa8aO2+THZpl5Nh5ICyyd8sNUp/cch9W5Olz736NfElJ/KD?=
 =?us-ascii?Q?exEo+ztLaMpd5e3AQOaCTSfTLg2lii7puPQJhbFZESw44zcG85vj8aLsVMJ7?=
 =?us-ascii?Q?30r2SqkyK6Wn8+PaA9kX6VM6pu6gGA98dWf96B1aDZzWy/IqFRmEjtGNtyaM?=
 =?us-ascii?Q?tC6rN5vVAeLuQtY3nyduMu8MHrXbhdZgwc2Uvu3Ddfy6DyidgHumkuWrTvK9?=
 =?us-ascii?Q?XsHYpXfAt8sZz1TQ+Lar5WCT3cZrYKNk1GcqglBoZYQIvERaV9nDFtxfuPS6?=
 =?us-ascii?Q?lEhdsekjNgO9FpyGEhwYduv5bPb/uRuayZBI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:24.6733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb40909-a08e-428c-7245-08ddf69451f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

From: Alejandro Lucero <alucerop@amd.com>

The first step for a CXL accelerator driver that wants to establish new
CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
topology up to the root.

If the port driver has not attached yet the expectation is that the
driver waits until that link is established. The common cxl_pci driver
has reason to keep the 'struct cxl_memdev' device attached to the bus
until the root driver attaches. An accelerator may want to instead defer
probing until CXL resources can be acquired.

Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
accelerator driver probing should be deferred vs failed. Provide that
indication via a new cxl_acquire_endpoint() API that can retrieve the
probe status of the memdev.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 +-
 drivers/cxl/mem.c         |  7 +++++--
 include/cxl/cxl.h         |  2 ++
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3228287bf3f0..10d21996598a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1164,6 +1164,48 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
 
+/*
+ * Try to get a locked reference on a memdev's CXL port topology
+ * connection. Be careful to observe when cxl_mem_probe() has deposited
+ * a probe deferral awaiting the arrival of the CXL root driver.
+ */
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	int rc = -ENXIO;
+
+	device_lock(&cxlmd->dev);
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		goto err;
+
+	if (IS_ERR(endpoint)) {
+		rc = PTR_ERR(endpoint);
+		goto err;
+	}
+
+	device_lock(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		goto err_endpoint;
+
+	return endpoint;
+
+err_endpoint:
+	device_unlock(&endpoint->dev);
+err:
+	device_unlock(&cxlmd->dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
+
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	device_unlock(&endpoint->dev);
+	device_unlock(&cxlmd->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
+
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 240c3c5bcdc8..4c3fecd4c8ea 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1557,7 +1557,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9ffee09fcb50..f103e2003add 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -122,14 +122,17 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	rc = devm_cxl_enumerate_ports(cxlmd);
-	if (rc)
+	if (rc) {
+		cxlmd->endpoint = ERR_PTR(rc);
 		return rc;
+	}
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
 		cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
-		return -ENXIO;
+		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
+		return -EPROBE_DEFER;
 	}
 
 	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 401a59185608..64946e698f5f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -251,4 +251,6 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_ops *ops);
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


