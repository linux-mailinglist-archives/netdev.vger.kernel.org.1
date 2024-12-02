Return-Path: <netdev+bounces-148162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B249E09C9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4E4B611B1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178221DA11A;
	Mon,  2 Dec 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l1GJgE1r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3A1DAC83;
	Mon,  2 Dec 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159572; cv=fail; b=VKgsbbSfo80MBk2w9jd03le0917zKF/SNqxyp0bmSHsSIOMXlmY8kqG2i7WQwz+tRK+XBRLzMRgGN4n0ZBFLZlb62OIu0l9XUK8kWPytg5nhnj8J7LSjjSakLtK2FIg9IlOY1lMMXvt5madFFKyRvtkUj0gNTUymq04VrqfGxJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159572; c=relaxed/simple;
	bh=aMF6BaqmhUUKZFuDf9LNHvgYvCZg5/TRWIh4yO52Qas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4Mzg6z4+KlntSs5tUug47/hq+d+zgHUVb/4ZMNYWVPvCUnJI7iFs51fIkQH3SUzossOBaVYduS5I6c6BaylW+KTZBnTEOuf2RTbToQnxbk2hm1EukZd7B/WqTMWKAluAwRl15Ck0o1dgJscfrzTxECXtQr119F7VaFcy3jBkJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l1GJgE1r; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqMoH64Gb810pNnrjGBZvGrNmv6SFOg7PTePWa6zX2IE1UfClDPLYywMRp+B6SiWzesKbuIHXm8jNL8kOR3ZknRpG6hINrftlFWfatfztORupzFRELPkQ0z5Kkz8rAPQBhnVDCywbFJAhcJ6ky9taI18HC6rFAb8FB3ZIlu3wSc0mgYklGdg5vpgFScembdOZumVHJMwhx+Xmi80r4FXzlGDHJ2NPzrwd3PD8dnTU8MLF52heKLK2UfsSKjmZcsMxafLFCRcI2paYYb4zMUYDFvxnjju2tFBQ2PUKgMzFNibEH4G8r+5PhdFE9mqnR/2sEDYta9Z5BBfz7seDixCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjWFWdqmFQ4Dr93CEPFkFXJEhpCPA5vQFbseKbY82G8=;
 b=T/wWLqDC3Bm9kA2DiVu8aUafpJaOE5f090swXXqOg9IG8Svi14BdOY8Xln/+IgjzCgEwrIWk5QW1CewRPDDkj3Uy7Hb/Q3xqKko2rv0xrsX0QyKdp8r7orxyDilm/Dfd/IOXl0emzcV4YkGO9Slii56ieb3Qw1o9Mnaq9ykF3UjwhLwJKpK6YIQ2heIpXNp37nk9a9Zp8OL1rcbIS2Qi9M+OgSOwmOtPMTHzyCrwli7sawHG4nswIzsmn4aNiht+nvQxfdmD5uuAyICsHwa57FvphXlFDbZsHtIQrsdHGWS2/c447921zMdSbh8EKAw/2lJR5i5J6N8uMVXzkM1MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjWFWdqmFQ4Dr93CEPFkFXJEhpCPA5vQFbseKbY82G8=;
 b=l1GJgE1rkOEEEyiRrB49j2/+figVTH2eVY+GAutM3qKlotgLthS3/6/zWdwNmeCrrh8IzuK81WvmVpl9p80gmaD54TBYsIY+7ET8PkJl/O3mPK5hPPplIdQQ2K3+zO19Mk2G+JdsmaoNLur6vUmtqW1g51iAv3t7LR8eCbANlig=
Received: from CH0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:610:e7::13)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:12:45 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::e6) by CH0PR03CA0218.outlook.office365.com
 (2603:10b6:610:e7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:44 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:43 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 08/28] cxl: add functions for resource request/release by a driver
Date: Mon, 2 Dec 2024 17:12:02 +0000
Message-ID: <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c60555-bda6-453b-b08f-08dd12f489d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUHnAXpPTk71ZEJzy2z3bXQ20FyFZtxd4aVHGtGs0Th0wbNRJO7ZZcVR3vL0?=
 =?us-ascii?Q?ripvBh8MIpiy6obwbTMURCNkgN0Q/cazTyy4o2BDjvilvCCBd3c1m03D/XXv?=
 =?us-ascii?Q?95TeR9i8rMI0067AigkVBrCe6WGRi/6BPgCXofD0UunBrRODoLR3cQRhU3hI?=
 =?us-ascii?Q?AE6PFI6D6PBwd63QAlXU4QXn0GNq1KJvxc0T2b6ce4ecPKVdbaWGid+7dBQU?=
 =?us-ascii?Q?FfYSY4jE23W6zEJ9gOL6AaHEBKgmscdOlGCSHhIUm/r0VNnw9GinhtbQhxhz?=
 =?us-ascii?Q?qoWAgIs7HrZ9/XO2YsdG1wGoUpBraR8CWGlCSclM1uxN6Z2uhLuoZv2uvU/S?=
 =?us-ascii?Q?qsZz9Heh/96d3Ed6Vr3hIY0X+Fv2PpJgdIyWxia0piPwVrnkQcrtF/PQCsis?=
 =?us-ascii?Q?4U0Kwle0g/vIQKpkOgJV4Ipq5Pe8a98fleIp80qRfvTyF2sIZrvi7MVtk+2s?=
 =?us-ascii?Q?1xP4ooRmXNw/Teb2/GsLA8H+nXKeQe5Unk3qXLnjW3761BdmSclR+TDNJnpX?=
 =?us-ascii?Q?OgCw7xFXecvPt22fNMSHtt2AFyhQ/D7OMZOCbL+bXUP0e2HB4uHYeTQqrPY0?=
 =?us-ascii?Q?AOQ57qImKSMkMhIbmMuyu9WyqdwY1Q9SkyNhV/srcOg5nL62xoK8LuUmvnZL?=
 =?us-ascii?Q?QD9MXYQL+nKvYoTtZR9UpOuJ5q3yFhQl9T3NXB+juY+ZMLXSCT4HvBV9F9R4?=
 =?us-ascii?Q?5PRl5P4sN0cyWZkXO9U0uAiVuywh/JBckxGHTADR7xnBu/PV7qD1KhjDsrIR?=
 =?us-ascii?Q?tuPBmK1/Xb4QepEBu/tr2MO/S1qZgQN9zoNJmVsRb1SZp6jdX4YWzH/ZYdhi?=
 =?us-ascii?Q?eaD6mnndo+uROvNsivZdi4ldjzfaNziw2A+NyWHgS5f3+/bz67XrDqU7fizd?=
 =?us-ascii?Q?Q7b8Ut5xwkfA/EcHclhebqrvqxyQC4gAeO24op2bW3Tz1Nf3fHzA/WBMFvvY?=
 =?us-ascii?Q?rxEHLvcJi8c6dPZeQis9Aq2CXwsPkHWw3sMdgty2tquYgr/I0nk8D4Cj1+Bv?=
 =?us-ascii?Q?pcoqApovqkrKY5qCpja4bQufE3duxw5V/KzmLxGurNm6+pBz5q8sFIssx60k?=
 =?us-ascii?Q?urbLD0lpRKkvsZh8UGLeMxxLwOMqG/hy0sj7g/i6PszL3XZ4Qo3sEGOJUe2f?=
 =?us-ascii?Q?lI5DZeLK7q4ej+KTDsPwrslm4zwIZ5hmmoUWreGWYqw0WlYGL1OSpUM8tq0Z?=
 =?us-ascii?Q?8OTphMblNlB/wTalMYzi7sYm733O4vlhhM9rA43n0sjeUjjxXZLs9DuFZeYm?=
 =?us-ascii?Q?wDqSU+x3X9itjDoerB+5zx53JpRzbADV3St10PrX/Qg5AVVu6m7oGe7Dz8vS?=
 =?us-ascii?Q?JuvD5/vw0S2Qtnj5BjneynJHZKhvynm4ZRXoCNeanp7oMstW3Xh3TU4VD78B?=
 =?us-ascii?Q?orvCx6SH7ohT+w0agDeDoG3UH8mrzDsdgETikiqpHmELbT5SrBt3gRaovM+h?=
 =?us-ascii?Q?2jWd1ChZdxA+QWiJB4DnDpgC/RDDddqTLBty7rTKSjsGTaoIoGTpyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:44.9565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c60555-bda6-453b-b08f-08dd12f489d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and releasing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 8257993562b6..1d43fa60525b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
 
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
+{
+	int rc;
+
+	switch (type) {
+	case CXL_RES_RAM:
+		if (!resource_size(&cxlds->ram_res)) {
+			dev_err(cxlds->dev,
+				"resource request for ram with size 0\n");
+			return -EINVAL;
+		}
+
+		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+		break;
+	case CXL_RES_PMEM:
+		if (!resource_size(&cxlds->pmem_res)) {
+			dev_err(cxlds->dev,
+				"resource request for pmem with size 0\n");
+			return -EINVAL;
+		}
+		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
+		break;
+	default:
+		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
+		return -EINVAL;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
+
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
+{
+	int rc;
+
+	switch (type) {
+	case CXL_RES_RAM:
+		rc = release_resource(&cxlds->ram_res);
+		break;
+	case CXL_RES_PMEM:
+		rc = release_resource(&cxlds->pmem_res);
+		break;
+	default:
+		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
+		return -EINVAL;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 18fb01adcf19..44664c9928a4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 #endif
-- 
2.17.1


