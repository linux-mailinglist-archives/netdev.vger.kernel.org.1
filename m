Return-Path: <netdev+bounces-152285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE89F357F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D79E16A339
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE522063FC;
	Mon, 16 Dec 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="swGvyO0l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EA2066CE;
	Mon, 16 Dec 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365470; cv=fail; b=r21fdnxLfAPnST/hu416vi8VJ9s43vD4GUeu0eujT68Xbga/93u1ASKxHeKI8HN8uIL6+B7TpKQp/NTxhUVyyf3vTDjxVo3a77xTX9Mu1J6A8Zw9gRMGzxAeqeP1MqErxKAsuw786+AULxyA9t3YNeOxdYSGIxclwJQGvLMJblA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365470; c=relaxed/simple;
	bh=rsd5P4sh1f477GIl+2hCb7gzJHNSc8IYOME889cScwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca3vV6xqjDYDGc5SVo1YgjJ4mQSuQ1Rgri4FPoIwlFfWeC1mSznL2+jJqteqXtJKHQQFxI/KgoPCO35EoCHrwx0N6fubiRxDswMHH4kcnMeeLSN0SKZn8fhZzWW9E2l1KUxONpqwiwyl889UKR7QcOzqaPfG0hKZ17DyCL3thYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=swGvyO0l; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J33j9K0h2Hv7e3Fd2HE8mKfXjgzNhipuyZ8PcMTCpaiJLINYSWr/hdsVh69zC6Vg5kCJi78LU+TdTwEE8ssoeWW0pFoIjr+TLBltTxC52VLUdMRoaXm3vcHYlcZV9aPhQdlWY8t4j8YzPOlD5j2ovYVYp50PPJjYhKYln8rHDhW2Rkm6twadQ5cD2KIxEccK6keNw0dYcKB2VOZUyG51uo59xgybOL10xm0FqpYQJpHtWKgZudXWQSYXDzT0EtNQ+cNK0m3cmrPFzTaPuhNl+fKjdKLOqQis1PhYYR0LVvdDCKKqI7oX+hSu6B4FTmgm128IOf3jfxLuSS9VW7p2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlXkAPufsfHVx5vfvAFJ9Jl4hcVcs9Y4OKknSjdzGjM=;
 b=TiwNXGq1to71V5/zztDHVijqZL6B69Ms23YoMkDDDljgRtB+mo3ANDlvvqsaoFlBOlvnFNYvueQfZeyAzDEFHjAMwaeJdwgXsyRCXLOlcShnLnQX4coyb9KZ4UeVZjJmlriM+XZTmSTSVP1XyKLaoUvuJTgjY6/FqPtYis4XPp4H/3PxtLdm7bBh8E0yiVvuKyebRLQprKc56pquK+o4vUATa6ul6OIAJ5HgsEtR0yO9nKUCrxLYsZQj1CaqaJRKzvM7zzeoOnUU/mBCH637LDRPHEMjdfWFXrNXj3USjnaCD/fVGRy+z43Z8LU/d58WyoL8q27S83SrR2GRLCmqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlXkAPufsfHVx5vfvAFJ9Jl4hcVcs9Y4OKknSjdzGjM=;
 b=swGvyO0l6RiBXpdEjDyKeIKroMYJduCCSqtCQSqUIxlPMofKY5jDNDqXFdRVAtDMtQ8ehicNTlRul2NMcOdtWzIfda+PbLE73kao3kAaZJnWfdJr9IsIXdB2xSkj4pc2pFvPYy6qnFQsSz+P534EPlCTJluPKa/UfStf/VlMmkY=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:04 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6e) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.10 via Frontend Transport; Mon,
 16 Dec 2024 16:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:03 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:02 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 08/27] cxl: add functions for resource request/release by a driver
Date: Mon, 16 Dec 2024 16:10:23 +0000
Message-ID: <20241216161042.42108-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 087ef66b-f3e6-47f1-dde0-08dd1dec3e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iF7DaHYpRSz2xmibqvASc78L4rfxOfX2woeEXQY6Dj3VGGkFUlmL989X2W9O?=
 =?us-ascii?Q?qmjOEbWig3dkR9A5ArqwxX/socHljX25Y7V1t8VyYuj0Z/4AevRbUVMTRi4I?=
 =?us-ascii?Q?yO/TROXLuutHllqb+qr7GO2QqVLmcODAZK2i3jhJjvXZJoYNWTy7g4umBBFa?=
 =?us-ascii?Q?7O+ujkDxpPZP8xKKSpWDS2hEBTLHc+5N1FMwCSFRZiYxr8w5EK5zt7dmSxm5?=
 =?us-ascii?Q?SDligpEhq516zuW+QUFKyKIOGn13l7ijB1+F92/yV3IOeUHVmtbfnzFNPlBx?=
 =?us-ascii?Q?2yv6u93HM7Xy6o2M0qe6np7UviyVJpM1FO68qVowGOYh0D/+gpu4C7WggfOb?=
 =?us-ascii?Q?Mv9k8imrcZl+X0L1mLnMYv2d7aNHNlbhE9iN+XDy8zTBJek/1GilqRFdObPi?=
 =?us-ascii?Q?w+qi5QSJoD66mclVVDKgIIY/q+FvCWjO1/zLlP/k2MDqlHQ97ivGiWQYHVkS?=
 =?us-ascii?Q?YcoDSjqGztO2EguMrdJWsoQXEX23kKhnYPsC1veVm9bHqSqrtztYn4rsp9+F?=
 =?us-ascii?Q?REE2SfVT891QssiyXahZnwmdZ1Klw+6LRGp/17rTjkCEdcEJzQoQGt3gH5O7?=
 =?us-ascii?Q?gNboOcZyJ5qnsaiHb3A3X/s6rEGhvTqx6pZFgpSphVGxlaH72fkMjh40PMzx?=
 =?us-ascii?Q?iBuBcD9vhqKB3SCCd26oNPXmXAhoRoFzTMqk8mZynyRpaqDfXyUjFSSO1si2?=
 =?us-ascii?Q?nhKmDBPXQGypfv3ceYsG37jtQgajr3PdTpmKer1crvAKEF8XaDv9LfxTS7S4?=
 =?us-ascii?Q?jlpgOBBLUJ6L4X1jan1SyB17TCQtRPYWL25gJ09s1u8VJ3IGrWpgjevkasQi?=
 =?us-ascii?Q?NlvEzxYCpRmgemeFptEQiIBxxpOviCtFs3sCQKk3V3DH3S9tmH+MmkF4pQzE?=
 =?us-ascii?Q?VWnsk2Qki0d9gwFgIPqDHLaip7JcFcT4xZNuFRS68Ylkiw0FCieQ6q3+G0hy?=
 =?us-ascii?Q?z6Wl1ZXU4/cKGcx6e+Vb4V6dky60kna0unPlScibkW/H/ko1uflHZENYkiGC?=
 =?us-ascii?Q?byRDuvPPDpWBY4FZnYbGA+QE8Yj/W/Qm6qkeWqpCoeU729sgkKy8hL5nY+vH?=
 =?us-ascii?Q?EmLFfSlfjtNrgVRXAZEWqfUHkyQqkI5peNTGUP9x+9JPXnqqrPdw1vyUD2EJ?=
 =?us-ascii?Q?8krI5wx/q8BCOPqwEj25vVt9H0caOQgYEIjfKXHNAjJIQM5Ac6RmMn3gtCWd?=
 =?us-ascii?Q?AAdxYA0O4Fj76ToZp2zUqXI5COnRMbUaPyJszX+0nRiZpGwWI5v5CTkPiZyf?=
 =?us-ascii?Q?XbDqhR+Nw+f4bLgXLf5Lu+xqRZtFK1B7zSpQDwCcWiH9kqXcAz6WwVkCFe+M?=
 =?us-ascii?Q?Qzo/MDxebPITsWy7fXccwrCvCHN6eBSGhAjeBg7uRSMFYRqPYG/SSGxCpLtM?=
 =?us-ascii?Q?hEjLJoaXripeD6EhTEoPwFim49X12QYkv51psVZvg/iZbSJnscM5qRolWzHs?=
 =?us-ascii?Q?Lx5FoGKVJoTl8fJLKn0YoLUcdJcpfKIfQz/wyLn6p4FHk7+HppwHJ0gHkBMp?=
 =?us-ascii?Q?8QO1LwDuG5VWWcJ8MwYodzBcfleN62BbSKEU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:04.6215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087ef66b-f3e6-47f1-dde0-08dd1dec3e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and releasing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/memdev.c | 45 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 99f533caae1e..c414b0fbbead 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -744,6 +744,51 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
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
+EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
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


