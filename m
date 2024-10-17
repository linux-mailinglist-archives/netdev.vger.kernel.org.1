Return-Path: <netdev+bounces-136669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0839A29C4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60B21C230F5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198D1E8838;
	Thu, 17 Oct 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpNHy4Ik"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547271EABD4;
	Thu, 17 Oct 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184015; cv=fail; b=XOr8zHTJeuRcWCvrLmR4Cwk37C9kwzRRg73ytdZoaCLuuxVJvkl6JeXWtyEz/w1yJ12exC7FgNfuIwnp0ucrsaQ9ATUxSk3ZMHmA/xlt8hdvsZPKaSPZaJh77sI7dIL/5lMqUiZ31BWnum0eUy5egYTuVDhkLsDN3t5vevquiMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184015; c=relaxed/simple;
	bh=mTinsQRly/KjhHddG0CxgSuyJWoTr50MQpw2pJFF2Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhvY5psIg88xXCS7GDUgTE2vaJCS+hya2g2DeCv9cXd4n7eg7gqBW7CH5sSOhMucKKmOyRV3LYnCgfxgGm/OLPyiQLp9oJS+t38CqTdiP+O/TE4zWJQeUi8/fTikj5AeE7CjNGUwGAuKouBz4XEGcx5irPLzAAd/6FJQc9eTrNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpNHy4Ik; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnYMnHTU+DhOO3g0H5ABtPgwBsyNeTb4KS8HIzGDPfQ+7J+WaWHqFNwDKGJs7jfK/anGXzUtHn3047RnVHo9EAmrVCv3vshvUBzgrM2AAQ32pN0mLtbK8lKmcLrjcE4UPwVxMLEwytj4iXLlm19z696j8ELScZXn1/bD4e7iz0LTU4gVn+R7FfEnvA1DkXmqYjQM7LAbD2vp5ybsv2Ut7X3fPWjzDBBV6HrDDzBUwnXqHAKTXYr+2trKau81vgixRGGeQuQrax4mKzvRTKS/dl5B9oQd/8HZZwdz1D4V6z8OQ0eeylT23IoKmEmd12r2pF7dl0793bvC1fQBUfxcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqb+Ftuywvd2uVIlKEOQUkRNgrlCowKkNXO2KgCWLlo=;
 b=UsFczDyHMVcdK8KSnfD3hihDXl5Mr6msirnfVA3hB0el4q91S87LgDTZ0m5vftBkcvUVJcdtThKb9cyoB4XW55p42cJ+cmqmXwHYfBK9SnbG4+YUhpMBGnM9WwKW8ije6z0KdZdWtFMsbNxcrKliWetMQOsn9SgmrRCsjAmyX2/bdXvu2qfP+tfEEBItOsk1N5dJ+GyZbvMzYyUm4+mbhIEnGiaSZZMoQOgachBE7lNCKElVvOLYveDVtsRNJ8SIXRkb+7qktxEJYbOtsmT7u6Mtkc73jLBME6FxNNJrhBOOcKnLKlzmM/yJxiei9jtyiz1qv0R8bwc80331pYlcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqb+Ftuywvd2uVIlKEOQUkRNgrlCowKkNXO2KgCWLlo=;
 b=mpNHy4IkeZIcPAGY9h3lrS2kH7datqTFaTXCPvUiEP7o1ulHdteBVZREKXbuQfMz9squveSLqU2lcD1jSAm5g7y1ODaDGg0MYH7Li/1DEUowetossQg7eM2dahZsHIyzQ5DeE7gCxFcjTH8YOsseBwiJdX/7+ZaiccP99iN1XtQ=
Received: from SA0PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:d3::16)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 16:53:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::8b) by SA0PR11CA0011.outlook.office365.com
 (2603:10b6:806:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:23 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 08/26] cxl: add functions for resource request/release by a driver
Date: Thu, 17 Oct 2024 17:52:07 +0100
Message-ID: <20241017165225.21206-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f609db-1b3c-4097-9590-08dceecc3716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRXhiEQdzmYrEJl4Tvazdwfud5HqD63ULUnxFbxp453/8NV16TkbkVJiNcsN?=
 =?us-ascii?Q?Aqy2vhXDdOODWm5CSE/KBy3VKCVU47EAuwvYoLVyKq6lnhHC1aScIKMZj8yA?=
 =?us-ascii?Q?Zklqc6MFOxXMtkijxBsWUY9RCLhk0pUaVdtP2fRuFnN41KkSJhJqK6e4jlVU?=
 =?us-ascii?Q?/ecxKxSZY6AIhhiCeSAEqcLRWfTSv9pqGFI/KWIF+6cHfin+Q7G/iFFqF1sC?=
 =?us-ascii?Q?FtCEyTSSlsE0JAF9rHL1+7fM/hLOQhdd0pBJzK3b5eZ4FkOU42SFP4wjkJD3?=
 =?us-ascii?Q?et6uIf8ZRTqPBHPKkDXXJ3ryAlqtZJ1G7PAuTA5vZQ6v3fLj0dJYF1tIcHHJ?=
 =?us-ascii?Q?w0Y0P3EHqYhDsczQlST+dUKgrAyFfrfTjOXKoz4PxJ+JSy1Y0xteilB9HUxP?=
 =?us-ascii?Q?HTDeeHFIFlOYY2aJacJfWEyHGeKLtTvL+ETTR6QFhrVf1cPDeqZ2WvGNc3zy?=
 =?us-ascii?Q?khwKT43lCfCqp7isquXQJUskS8ISv3iVZ3dvIFee7mdUGrUPcOth0xdqj/vK?=
 =?us-ascii?Q?IyRn9ALLUjN2zE1ydDkPB6eruIPKyM2xh1x+kwQdzMof+7Nr3KYACLoJnjbK?=
 =?us-ascii?Q?hcjPGVYwEmYh7GB2VcPZjoWNmjla3vpvpfLMBMMYRw/reYcOVRLGg7LSsfIy?=
 =?us-ascii?Q?WY3M+mb1mPxytQH7SMs8Az6D9j6Pu/3A5jaSi7TAUTp1tsFoJeIqOoFXJvvt?=
 =?us-ascii?Q?C/zTK78upOaTnuHS14Wqj6MOc5jbMWQv0Dzmjcjz9jiNCbsMUFjkrI8wxNBE?=
 =?us-ascii?Q?AOa6xcxIZkGksfkM3n926BnTkIMH/XlpU+cfESovAJ7Oy1wDFAZZAApFFYQF?=
 =?us-ascii?Q?+CiO392xZjEoHX9l1YwlDin9kEGowAx3NFFPdSGzW/QN6z4nT2iE6peMkR2W?=
 =?us-ascii?Q?qD6atoLrDU50zpiBLn4hgrGgLFqIwK6wVJuohBNSlR4YNBOJ+qaXCTXqY4Hf?=
 =?us-ascii?Q?xk2rMtVbV6tBeBAGMDXk3qx2NT52wxBUGlAjgzq811IIR8yG9V/XfnbeQcTd?=
 =?us-ascii?Q?949Uo9Y9wO8BCJdqXMl+JqdrwFoRlFImk8CGjLWOOYJwymu2Na+TfdL6Dtw6?=
 =?us-ascii?Q?MK9Fi8owNqB/AezMO1kXSakSBV79D9kV447kzo7So1ndcgUhAcGtG0i1FB9q?=
 =?us-ascii?Q?tkLNEWOk5O6b2C5w2gN5IS00Nv0fVPB9nVCJ2dFHJSkWybZIYC8u/9bvCvY+?=
 =?us-ascii?Q?yuxuoU4QKolA/Jp7tMBiR/0rr62TM5uWlv2+/UPLGqI+17GmCcBve5/G1VZN?=
 =?us-ascii?Q?lN6mALQCQmlsKGiJGKeL3uBVDd70FpXle/Lb8Wkm9YTGhUwIDVz67SqC5MuJ?=
 =?us-ascii?Q?kTyCxMxp2iZaS+jhQCpkmjEI9z7OX5Wfk8sQkvsBfULBDcuSGugkxXYlOLmD?=
 =?us-ascii?Q?LhQlfiD6Vt330yFwKOPZvtgbFUTQMGukFGmkYmP6XhJo6izeOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:24.3796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f609db-1b3c-4097-9590-08dceecc3716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and releasing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 include/linux/cxl/cxl.h   |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 94b8a7b53c92..4b2641f20128 100644
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
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 2f48ee591259..6c6d27721067 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 #endif
-- 
2.17.1


