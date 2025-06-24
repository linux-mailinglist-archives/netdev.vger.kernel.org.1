Return-Path: <netdev+bounces-200672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D8AE680D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB29C7A756D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1A2C2ACE;
	Tue, 24 Jun 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BPJoiSdx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1D2D5C89;
	Tue, 24 Jun 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774473; cv=fail; b=fmNnnz+aI/5wJE7fMVTr3kkRHpEGpTbVT69aX50OEiV1AueceSBHYKTIyvihiQBrOEjuMGEtJQZ0TGqWM2zOEh00E11EEsT4TmF6Y1SguwC6KY4YGA/F20vxbC2Be4pPNp1mrVy2njClo5vitaEFEuLGSwbE4gaRsq2RYSXb/uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774473; c=relaxed/simple;
	bh=Hlo8U9dPIA7m8BKx525uIsyaPt+PHGAM+FcJHPJ6omQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjHU5WFXE5rovuDSLHwjz27KVNlBGf6v1Z6PRLV3An7qlOsx3liqSBRcOgGb/jZuRW1e0MYJkrp6nG7W7QTNWWTEpFfH6vd1UvuIcrmTjh/pZWabk5A5CF49+YwlqWgSS0Q15xh5YSs9lTxFRw91nY8IMe//l+pvcwQ2npmQTaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BPJoiSdx; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF0kxOtt0ZE2+ZxpODyGgTTBdP0qGL8zJYDeLD6HDctM3WEb87kBbU8KWin90ZkLiEmFmR/Hu5vqhWDuLYl/UsHT0DY2jI+dWgZrhk7/UtjV28KtHYbyZuGkRKtKsH8Ie8HL97GZ/0HGW21da1JmcLte+Q/X6eueq1wdnuZkhJaJ4lxsLFYs/5Lul00Oxy2A+DhVTe/3Inl/BAy3tCMje+adC37bvDNCCvcsILecojN7e9eP879/Q/szCIEbEDgeW9M9e5a9Q2UycQlPvisF6qSgnuNUNsRhXFBcg7t3NVJ5VLyXQWoJ4SPqkue0Gm+gLMmS6t/vh/ZAWW0tKJneBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyKLyv6iAow1ycJMM4LbbEvrC/P2Q4t4aUbysP7dQkE=;
 b=ddWPCCydVrSY8a6RT1/VrjWmvjtj+3tIw5ZVApj/AVnkYIXn8N5lUG/LeV5BLtUcbIGY4mXthVU6CBXbUuDFLY61pqzwnI6K4u/yQtn9e5HDt13iWTaVNHXKvsrwF+Qjh1IzMOJ730bq+mPFfvDA9Ga+ERz/PrqN1Ltr+ksOLPd6BWjS/ML8jvkLn5OJPTp9kLCcHk9o+gtXrIg8t6RrX9O4caUIRA/PWR+CplijRAZ9kNbfSf94BCfs6vp7nIv5EqTPz+bLGkjyVpn3a0QpKeAHcaRNiyGRenWo61MkaSGIzfCxe/EtJFpmLnJP235e8x/dTqbJoVmoSJJTL0Rg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyKLyv6iAow1ycJMM4LbbEvrC/P2Q4t4aUbysP7dQkE=;
 b=BPJoiSdxUU8NPqnVR3P8SMzEdbpp6DGs9BoA6CoW+gpVa2+bA2ZyX4TsUzp5VcCVIKSPyPUCqDgVw5qqEVRYkohKdY5wdEw+O+1qGvjRT0gvoP/ylLy862C5VfbfDcbEgMCD6V+L/LhGWPRzRCGNxFavhTn75H9utqOjpkkOvr4=
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 14:14:29 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::55) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:28 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:27 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Date: Tue, 24 Jun 2025 15:13:43 +0100
Message-ID: <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: c906a649-74cf-4da8-3dcd-08ddb3296ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUFgLZXldQA2K5udUpIF2Ch9SWGLk3uPRQglE9LYtKCg2rWbg6Z18jL/VqTj?=
 =?us-ascii?Q?rfS2ilwVG18sfX1n80WNBh8aQi0ts85zalBB2q0XNiNUZMyo80NijTp5i7gr?=
 =?us-ascii?Q?rWgLogjJ6sScUPpPPZ+tCN2YN8woLjMUnrylhol4cR9Emw22MzEmP9T76q8x?=
 =?us-ascii?Q?9sV7GoIAqxULw8F8JMtKthU//zW2MNjJWzFmObXoK+5akMZaDTt1U/SprEcq?=
 =?us-ascii?Q?FifTtCvyQ+PSMHNAnnM2v/MpsQFs4kqA0TXlnKhmNTMly7cNkBlAyFsBs1e2?=
 =?us-ascii?Q?tF7VedV4N7bfUN3H69VvPlyKEba96aq0SkUBbyJic8SriLO701EUT7duho11?=
 =?us-ascii?Q?VWtwPJi5SpwVVuewWjgycAiCCCwk173Wwt8UWDr9z72q5OEQs74DPzen8XBY?=
 =?us-ascii?Q?THqu76/cfZ1nJfNGsk9I1YXxA23jwns1AmS61RF0u/p3tJtDOdASXCqMyHZg?=
 =?us-ascii?Q?qyhV8eHwQwNZs9EkrNHEV9h8ZRhTueomTFPImLTzZcqex1d/0NN241VsYF98?=
 =?us-ascii?Q?kuwLqbV6XO/OEWdNkztcQzh6DT8NTccyn6f4Z//RjdyssZy6QvEElOEgH2wE?=
 =?us-ascii?Q?sz5cIFkx6MixwBsOp+8cUmpPpzCFSNNK3DVpYNOCaSdMs86UHxliS09oo2OB?=
 =?us-ascii?Q?kYuxCIYrLJdJ/qg80Zyi18wAVb/KTAogM9TY2zIsrAdChxEEuKvz4XMWTHGl?=
 =?us-ascii?Q?+GP9IG2tHQmdIoGIwE8HE/wSlcwZWThALo9Hykv9lYhIKNy6vKJoI6DK6L3+?=
 =?us-ascii?Q?RBSU5Heg9fboZJ+yuomFkp8wEK0MluuiHBG5CT8HbPbbZe99kBaB+sJXxVZ0?=
 =?us-ascii?Q?CuCA7G6rBERx59assdnnPhSZz80rMXLJfaOUow5bdOcV9v/lFwiL/8yRB/+5?=
 =?us-ascii?Q?UPN4IT2aZ61R5yJjm0nvkAJE5Jc5ZiUlv6TBcw07JQnV4zQ+jsodWtELXdM0?=
 =?us-ascii?Q?aFEmylx+uUpe21uJnKSlP8DCiVpzCV1tMoa2QNx1vRcyWndTrgDoB/CPI1qk?=
 =?us-ascii?Q?EblCrpCDStxyPttjo66EYa0DBBjJ8ntdyxnPw0ZOfCVTg82abT/oVFKhTGLp?=
 =?us-ascii?Q?Td9Z7fmaR8TyBTBRJ2WSRdMvN9dqzn13yq+ysuJYARpc9BcrS1siQFywTeHD?=
 =?us-ascii?Q?7328BL1IDs10z0S7Un27F7VA7bXmJ2NIsDZdTeOHOzC9s7RzYf2qHgrWRki9?=
 =?us-ascii?Q?9DYqbZiREgMe7rU1ECpFZTWktJEsSjtjp4b2HETej1FCJR2jHQgjB2dSY7p4?=
 =?us-ascii?Q?7+N8iTG62dUP1GMGrSDfkWQ3QKpdeJ4w5Jxqbtm/pgt6RbBhuUKQy9umGdap?=
 =?us-ascii?Q?ISi+Ygf+N2YTXXyyIWUKncTRNo4UrHM6bxxdp6xiz9IHIZFD39rwiuSjh1vA?=
 =?us-ascii?Q?tqREv3Mn5cEFafTW0bnf04TAGcgFxK1TlmozTGXcSSI1vpQM8L91zmwt4RUZ?=
 =?us-ascii?Q?FYrb2w4P+x0sWO1p2VQtNG74jYI+AXFP6g5wxUYLsUgPDmYPlb7VBjUBeb+/?=
 =?us-ascii?Q?d8NY6yUQx/Pcfuzz0MXyOigrqqGK8CyUmWf7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:29.2298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c906a649-74cf-4da8-3dcd-08ddb3296ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553

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
index f43d2aa2928e..e2c6b5b532db 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1124,6 +1124,48 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
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
index 9acf8c7afb6b..fa10a1643e4c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1563,7 +1563,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7f39790d9d98..cda0b2ff73ce 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -148,14 +148,17 @@ static int cxl_mem_probe(struct device *dev)
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
index fcdf98231ffb..2928e16a62e2 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -234,4 +234,6 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlmds);
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


