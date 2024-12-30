Return-Path: <netdev+bounces-154578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260259FEB1B
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A452161DE4
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568781A3042;
	Mon, 30 Dec 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eriPO2p2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF5199EA1;
	Mon, 30 Dec 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595116; cv=fail; b=QiSCqugmGCXC0Dv9GZL1YRluylfM4LSFCG6Tx1cE8saC5YkV+t17VGPmfZ7/FCIUK+DYohEEZGvtydQzEleM3FHnSdNaP9YWXZk5v0jponEsjxIc+SMZxAjM31BQE5O53KhQ9JxVTwAqey+szUtIKPAzSgn+A5HGTmGdq2I3V6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595116; c=relaxed/simple;
	bh=gv5PR2uOWnMb17+U94ySNJTC9zEASKa0nFPggJJk0pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfrAEBD7abnMWgnesN8c3QT4CEMAZTr379VbI3ruYbcb6MRqnQaUi8yCxfWLGi6/RosZp7rNI63wl3mlu9tw5p505wlSbfQ/4ZI53nNt+q0JRuOtU3oNDzF/oKtgwLrTs6qNEpR0EFbWwKU3I7DkC2X4nJ5j3c9vavcJieO89WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eriPO2p2; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV61X9xoGlj9CoMhWSTnAsE9g57LpXfOsp563LQAxI4dFhycfxrHfP02s8tfrymIyDqymRg9lNksRcHotUjM1C5Gx1hNl08Q7U+fuyXwraj89/QEon5utQH5KAErKsW22uWp+uJs+ZntV5eXlMGqz4bEeFSeabAoynBrCf6yW/FLu32ZvjNIlP6oWZ9E3ay80iiAmqxgJEoUHbO5UQXhFuHvZKBbYXvmD2+AdAWhe8RUjfOWLEpeUUQyCygpx+CW+huJixK8JCCMX4laiop/DI2R3jdlgI/nhqGvwv8bYGR6h1iUsZCnu649VMV3y3YKMXaB1v0qofX8JXAMUfWeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve2YqpLhDZmBfGrAhXLW0GXeyUmYnarAdv+iRyHNVe4=;
 b=XWREMHp0Y8PkFptR1+399UlYpPdGybNUu7C+tuSnb8zi/Lh5LMZX+u2NzJ/Mr+ZP3PeEyHR9DvtDf7Df33VhZYxkEldUY/zmUmaYGnK/ETVH6itOyju+liybg+FFICrco8eIZSjSR4imCb4WS83zIcwdRHZ2JMqq+Nhq9htkcQN+npgCWWJ5QWHPA/5gg0KrdmDwZ5WtjTG8un0pjYxsM1ngBCutoRUlQBf/ExhJt71f6QPG5FGsM0gn+wmQRZDtVGZQzHWTzYUIIa6S42+g7tggDOXPrJ22evUm9Q7/TZSQjAg57+iFwF8wFP34jc5BN7xigaW9Qd+MBHf2jgyi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve2YqpLhDZmBfGrAhXLW0GXeyUmYnarAdv+iRyHNVe4=;
 b=eriPO2p2r2KEKLISNZ6UmhFigCHgrdiC4rHm2s11ngFP7rxIxSmMbzlR5OBMEKnDAcdIAAkv9GqCceQg1oqkUpTToQnXiFK4QO+Gwq8wdgYr/RZS6FANF3Q7SGsVHRbIlhbV/IU99Pbqbf8M+Du+MXQH701ErIbxw7X5SBlrvAk=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:06 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::34) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Mon,
 30 Dec 2024 21:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:05 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:04 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 08/27] cxl: add functions for resource request/release by a driver
Date: Mon, 30 Dec 2024 21:44:26 +0000
Message-ID: <20241230214445.27602-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4189da93-984e-43c2-1644-08dd291b39aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMavaVpXR4bixwn2kEchfE08Ay9Fgud28EfEToIFSt3WPadfQGrL1iflM7ak?=
 =?us-ascii?Q?+YgOUk7qql3TOwEWpNd3L4V9PQXQjYxOpOjYb01gSr95egow6SgjZueJaftK?=
 =?us-ascii?Q?Xnr7IqnUK6G2JsYEL6A80LO8HbFr1d12pgddgfJQy/SWenaw0oPBzdRtZbyO?=
 =?us-ascii?Q?c6xNZIeiJ0v+fUV8s7CYBaTPkWnSu1Gdpjdk0FYx3CpDby4BA1p1/QbpZZoA?=
 =?us-ascii?Q?O9cA5VVSez8sTSBXt1VqtLNlHL3+r2cOIPzLJcTG6p0eVyAkveZlTc6UoonW?=
 =?us-ascii?Q?iHLiIdQY0Agf2V4kGtiZnCBDG6uwFmhILsfrhG2V0vE1mq2k+FJEIiKPalRA?=
 =?us-ascii?Q?bdydH/gnnIL3Nf+5FkPyYvpnGT4X5NC2E8y0OyJz6H4r6f6rzYfHvI400NLl?=
 =?us-ascii?Q?ur8v/WFvXEaaKr1NnsxtyiIjL53ktuOQ+wU3H9dcM9sQ/VJ7GfJKWJz5ngO7?=
 =?us-ascii?Q?Gmzn2Uj7nflYpVI1749S3WYunEaYrzYV8LjHicspqvic2J+gtsxjMR2PGQ8f?=
 =?us-ascii?Q?H0wN7EToi9sQkn9Y5DNXJot+9fiIreFv49+dpWAQqhsJDiJeUFIInwz9dtqy?=
 =?us-ascii?Q?hYGq8wmjdNS7i3J6HontXZmb5EZGn6jOmU+ar3honwM44BD/ig20l56+UbmU?=
 =?us-ascii?Q?2mosGhXvFVP0ypZpSd3Y44uQS5T2l2Oqwp6fPlZO1V2lb4dBPdgQ5WDmKl6s?=
 =?us-ascii?Q?S0ugPuqEJWB8xu5l9Vwe0asF82uQCf/wJwJLT2nK0b1EoYWL+UQR1dddonXx?=
 =?us-ascii?Q?2nimukeSmLu+mf3A+kixBG4j1jpPUxq3caw8HgYMQyy5ZcqTtamXRpUzbc9S?=
 =?us-ascii?Q?eYBz8P29I1Cg78dtiy11Sg3OXZVWMvs5dfeWtGGyMqWHwmmCweq9GR59/SK6?=
 =?us-ascii?Q?1/ArJ/zcwzrpdF8bsqlwVsud2AeWq8I5+Nh2tXYtwcmqlNgAPKVN8FXTAFzh?=
 =?us-ascii?Q?FeGGh7PhdQfBhy9yQQficiGvefyGFKwSP+XZIcCkNeONF2wDhHYwAq3qYSjx?=
 =?us-ascii?Q?U4nkEW/vuROoKUqNYISZez9L8Txm31bLmNY5pF9+Uvw6qvn1zagJZO9I6RCu?=
 =?us-ascii?Q?Y2NlkuL8fbpyMZDfDGpBfmDl10vIiV63Yf+60MS9oI+baBWxZWag5xJtBoo7?=
 =?us-ascii?Q?WqX98sDNDRtpyskuZQMaOpS9tZfw1G4uQAO8bKZCQQqdm6BVeYd9k4/zhAvT?=
 =?us-ascii?Q?G9bUg+mIAmVphko4bOzG1Fuz7ohYYmofdUgIU3Ee3EesVg+pJCNJhCZQinlc?=
 =?us-ascii?Q?9KSh4+y1y/GwGV3dmGCNA85LfF2jYntY7Tx1rgynDoJ6GspJaylst61zALQX?=
 =?us-ascii?Q?bqY1dhsKOi3ai/VJ/J8UWojbOnDc3CWPLT5kxq/+hr+EnLo9Z4nJ+82/BUF6?=
 =?us-ascii?Q?1sMdqPXh1xRzqgdAgh2yq/N4xTl/JJmbkw3YFVAiZY//v2KU29bIpbiwNKzg?=
 =?us-ascii?Q?yb1f+QaDhGUUXnrzO2MEyImvEkRM4dH9iJRq7wIskfpssc0xT1FEMLsyrvyD?=
 =?us-ascii?Q?z09xZHXrNCq6+sw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:06.3688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4189da93-984e-43c2-1644-08dd291b39aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and releasing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/memdev.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 99f533caae1e..b104af6761cf 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -744,6 +744,45 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
 
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
+{
+	switch (type) {
+	case CXL_RES_RAM:
+		if (!resource_size(&cxlds->ram_res)) {
+			dev_err(cxlds->dev,
+				"resource request for ram with size 0\n");
+			return -EINVAL;
+		}
+
+		return request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+	case CXL_RES_PMEM:
+		if (!resource_size(&cxlds->pmem_res)) {
+			dev_err(cxlds->dev,
+				"resource request for pmem with size 0\n");
+			return -EINVAL;
+		}
+		return request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
+	default:
+		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_resource, "CXL");
+
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
+{
+	switch (type) {
+	case CXL_RES_RAM:
+		return release_resource(&cxlds->ram_res);
+	case CXL_RES_PMEM:
+		return release_resource(&cxlds->pmem_res);
+	default:
+		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c1bb0359476c..87b192095fe3 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -45,4 +45,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *current_caps);
 struct pci_dev;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 #endif
-- 
2.17.1


