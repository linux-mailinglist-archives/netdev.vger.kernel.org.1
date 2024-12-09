Return-Path: <netdev+bounces-150348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E49E9E92
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC9281EAD
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAF1A0732;
	Mon,  9 Dec 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yHcXsvk9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430F1A0730;
	Mon,  9 Dec 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770507; cv=fail; b=SSnNHXZY+EPettt6qyAjSGK6MNB9bBfEK4R/exrXr1gFd1NTHg1tNiK/hHllI+yL9qx7Bedse5gzy0n7o9L4ACsRlKpg4pqSzjkWg1B6f3e28TRhG4QU8MHamxFKhZfmPB6neuVG8MnX7vliEll4ky5tI9pGhl/9rgZVXvyb4cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770507; c=relaxed/simple;
	bh=43zkb4bAd4kGliLsoQkuoh9b7gxzH9DE3Sg26TRCm0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfrcZjChsXfcCIaySPQ6HbsYWWxSq6vsouP3JD2r/gCvkDQIAqiHX2TiFLT2NahzQK4BYAGWoXFvBi+7DhJI7OxRH7FFwBg0r6rn1zCB6tiY0zvgY5BaVmDdB5EuHo/yiMvXV9uQGHi8dWP2w2yPw0nE/LoAUzRO/ppf2HqxS7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yHcXsvk9; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFe4rv2YD/Jmz6a+Hoa62bYNl7wIoaM3xSGmAKMWKYjRioWgEfGbWJwGlkjnGq+Yn+wxbQ/Fd/a+LqoXZ618oG+JzwQVvwdHsydp6d+0ob8AL+BFxlvRlp2TeAEvl7I2+oNrS2gsjjZTqcaKVyoJp+DZLd5zZ61HE9CaptxhUh3JiZZhdgUtl00fQQmjpEXfUc+S8uCxHSefD7GDW9G714XAakrB3S42lwX7UpF7N18pPUkLpGobMCPBr6bssSYS2ugbqeaRWzDGePgQHnsyLjHDg4oWf+mH3tfjWIyiKANj45uOWBMycRq4tGLUy/NaHXh5GQ9bLWQMolf98sIIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t5IfKGaWFAoQTFbQjsKZRrHL9cdRjF0pzBpqGrZ1XU=;
 b=gkrzkGTOZRW1tYa6v+HnugLMKKurKP/GRJyhZ3JPN5YOrsfVwwQS45vOX2tBsYC5gdsqePNLUphvlr0LwaAk5x5CdYIkGbi3f7yiqXJAfjlRYQS3Z2Mi9Q9m43ob48qqvehCNhLxSmnkOuH0HQcF6aP0rYrVtsnsDxlmrDjrACjKECGSreWKQrScxXRNvQIQi2xpWZW8qT+xqjlMwCAn/ac6QmAtlYgVoa9QN46kFSAW1qhAGKp3Dw0rapcE/DvhQvT6yRN5cQVlB2n/8ZbOiubHZCKg/0rCBBF5h9War/9GZg6iAqhGc2Jv9A8vSHVWv/5xfHlw149IxxSz9aA7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t5IfKGaWFAoQTFbQjsKZRrHL9cdRjF0pzBpqGrZ1XU=;
 b=yHcXsvk9ccI12VH1smKsJ1FXvEKeGJBcaH5hdpXKyJ6OCu5MDe5qBYXcB0Lejcj6G22IrjdFlwgBpOTELGvL183svvC01BgksrGxBifi+4U/pqCKsz9QRs0Ygfaq8vtrnfyMqKndC3ZmE3j94OK/IU/B73EDQHgcX05pVNAjwGU=
Received: from BL0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:207:3c::15)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:03 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::36) by BL0PR02CA0002.outlook.office365.com
 (2603:10b6:207:3c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:01 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:00 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 16/28] sfc: obtain root decoder with enough HPA free space
Date: Mon, 9 Dec 2024 18:54:17 +0000
Message-ID: <20241209185429.54054-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dce90e1-1a5d-4ddf-4612-08dd1882fd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NLRoeyBzUpGQUmwxvQg5fS3uodscMZuAQI8xhmzVDmoYNM4J9IWz30XWoZP?=
 =?us-ascii?Q?kB+pZlwzWceAROgSJNvAurDY2EY/8aknxrJfsF8EThmUL6q2Fit2MLxyWvq7?=
 =?us-ascii?Q?KR/55Qd8vkUP1Lj5F9+YaxqaJemGZt3MQgoztICaPjqFPOPHP9PLw9RUSvqA?=
 =?us-ascii?Q?7hG7eReExPH/4t642uW7FlWwyNZF7y6pofjZcQV6Gu4jwLVaPLFsYbecB1/W?=
 =?us-ascii?Q?V+gC2IThXHo1JCFXt+FgM7WgxsJk0ImhubnX15rVL4W0Ga3r9Qgwq6C0rrXG?=
 =?us-ascii?Q?8cAwf1e7RyhCh5yrSMCBFmdsrBP6Vo+N0seKCHDy4hwBOGF6Bi5WAsN85XrQ?=
 =?us-ascii?Q?S7LaXvYnfx30Dg0WNst0q583Ci4J13BZrCaML+L5NwowjkrWcW7Z53h3K5iZ?=
 =?us-ascii?Q?YjYuWFxm2V56yHsry3baQ1E8cupNof6HHkyte+2NlnFQgoHXRWn0LpdJGQ5A?=
 =?us-ascii?Q?AKvI5Ui42lwViw3mnT4MxXcvL8/UReYnh3tRoDd9XFmA4BY+ywNPJ9y6TM/+?=
 =?us-ascii?Q?i//qyFmNXzaDN9vs2gz++a77tQ7dONmEtLMCzZhM1HHmLghO6CEwG9JnVSy2?=
 =?us-ascii?Q?TjBR+cDFE6rWIqmbnUC7KE3/R7db6NQj70oCzKK4FQ/BHQRrgh6JmqBCAfk1?=
 =?us-ascii?Q?9LnxM3mOEr4BLMe/BrKSN+8b/YQypJFfellh2vSuUo5w6hsdRBNeG1fw/cF3?=
 =?us-ascii?Q?lV5v9TuPscxAo/IGk3Efxbw70EE16Nh/zlAUjB5EnQFLBxb1C3DCFFk+miLg?=
 =?us-ascii?Q?WY52L3P+Sfqz9yc8l0wangDE5z/Plp3lW8P1SrMgiweBemC0ukZpttZ35bQM?=
 =?us-ascii?Q?xvxx267BGcGpCDorQrZBySiP7abDbzEM3jX8FV+bOeT1Dm95Q9yUDhZpy2Si?=
 =?us-ascii?Q?v1SHoMEcLyspzLZ/Tnbg7PP73olx4YfAWN0DENpZE4USHwqqe109BobAbCvn?=
 =?us-ascii?Q?ddKU+u7M/Nni3z8MWWaADw/3fyJyOZ5gfD95wGqq6oZnDhXdHIGIdfoDIck4?=
 =?us-ascii?Q?LLUA9uKIQovSBMLezxxQC9SeHneZCPms8Jxu5BSGeDatAdBEZgVIQBgT0Feq?=
 =?us-ascii?Q?+UOgi3JMa1e4wX+hCVVux7wT8+ue+ybQEFFkF2XI+bsR2zOTJAlAYAYfFO1I?=
 =?us-ascii?Q?HELwa8xiUEkDuChwN4qMeYKX9YQMGeywIxoK8hnyfgy6CKhHk7pouvw1JmoK?=
 =?us-ascii?Q?vRDuYm+l/W+dIGHq/AmnUrUtAuAumZR3SLAr3/PMlNdwOoarX2k5httXBy7Y?=
 =?us-ascii?Q?7oEXv+zjnTYO8fnruOQxqOGxLq4iGEQVOmV7my+JnRaVwF7KxhCANLC9oIX3?=
 =?us-ascii?Q?Hb2/bnkYPNHn2E9pJ/REWOsWk+gpZZ8RIwxHOE8ttSxLfK9sOpRiN7aS1u/O?=
 =?us-ascii?Q?u918I97rKGknwnD/U/fNEKHWs0C6gUmB7eAzDT0qlyYijoRAlOsBpT6CjuE5?=
 =?us-ascii?Q?RzITXcE4+8bnmKa1OTxfFL9fhuE4fIzCvsgOFZalp8aVBXmnAag12Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:03.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dce90e1-1a5d-4ddf-4612-08dd1882fd76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 8db5cf5d9ab0..f2dc025c9fbb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
+	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
+	if (max < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: no enough free HPA space %pap < %u\n",
+			__func__, &max, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


