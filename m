Return-Path: <netdev+bounces-145945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B783A9D1599
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213F3B260C9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7C1C1F24;
	Mon, 18 Nov 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBOt+/GY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E71C1F15;
	Mon, 18 Nov 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948303; cv=fail; b=KnQceXQIk1buxT4kZU/wKj1UqXChGojlRmt+NtCdMTTImcI2dCrA7spdqqf6HrP1uYlcq+8AdipzxDYjenV9hGAdOgG9ZyAZW5mdb3HWDORKDzq35tXsB6vtGBDuPPxVW9xvCnErMNp9g/CVgWFUsDaWc1h5K7SgCHoLP+uG1l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948303; c=relaxed/simple;
	bh=jvgJ+aCq0534tq8AVz1wtzIchIN5h9GODqBS95IYM8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4hYVOsxa0c5bB5sIBsu8Ciw9tIjKZyawySqiiZQTo1VU3zvlMhNAQlk6TolU0IXnOOAGTIkSYVRtxfT8/+OVScBrcUkM6Acg3ve2bgtT1bv+s7BWejFx33CRi+Y47xt4soMIGiEIBTAenDsGHUamDv4sLb64lG4BCkCWbp0DYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBOt+/GY; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFNJR8oqqDCnAWTvvu3GMO9yHKGtViGG85+FIu/lsgO1rLdNWgWRfcRKcZ4ebH4t7P0oVHKi4wMEAhTpQt+VtlGflHtHBWvg8rsQJ+i8GuK3DtK9VZQRAKKMK3WCWZV68jTVFvRFeqD+V1SlnwuCsZajT2kuGYIQs+5rlWhr91FTuqgGpSKCt84Zk8Bi5xz0JnG/LeZOmAO9J2QSLL3RX2OmnIPNTzJ8SAsmPS1iHC4RLJQJYj3rZB2UP+38c19tFkZn2vTwx1h9J7xnfAmazlam5I/2z4YznHt+LOKuiWg1E5iV2X1rZKqSTl1NBSi1rR/tDm7eZXmdvEXtAgVm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8OV1HskqBWE217ug45un182EOJEVOV7jLkmeaP0yG4=;
 b=Q4nRgWsTtj4nbLaslVvB/pfrh1CuvtylbY4QX7H6hcLOIyLTwpGVWGbLOwQMdcUuWYQ6SGBZf/BPIBfBm1XG/dxTCYsXDXQ4CU+UwqGHD5B95MKtBQnl7wake3AjSByZ3pTOlzSriK9iwcc5LP5tK+fK8a5ROzC/3wFw2Pos4XypONUHBZjfSHo1MyCMg5m1hyOuuAFEcMY032fUYHTF4oOyeP5b8vDtldHMPWdxOphTdSLdUbLQeczqeavFYkzhUQbhSr8nG/L30o32S1495oVzACm8S8nMGfzHr7iPuRDO2hvkyq6kiYaam+wb6nuNQ77qjkWJ84MlRjleWlo5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8OV1HskqBWE217ug45un182EOJEVOV7jLkmeaP0yG4=;
 b=KBOt+/GY885P+2fb3TIMiujhIC6vGb+S71vIRiDqmW3JYSrE3Doy0Cvel6+MUQEzedkTYo33k/vRyzULsy4nvH6hW8e6vDS60YFKNI/MyhTnmzbWIJK0e+MsdoycE3ZGctJEtSFZmUdg1uwAarlk431bJVVSVR09xHm3YIhJ1F0=
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 16:44:57 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::ce) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:55 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:54 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 08/27] cxl: add functions for resource request/release by a driver
Date: Mon, 18 Nov 2024 16:44:15 +0000
Message-ID: <20241118164434.7551-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b6547-d9c1-44f4-9756-08dd07f05608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTBlyr73mFKbc1NqogbYkQ8u2WAJbrD1MIgNWYIrHQepRZZPfx/OxnLcGJ4O?=
 =?us-ascii?Q?Y9y0K/5Tv0iH9m52MC5dFI5xrr2TGWyEaguuG/ipoy3HI/BDvNdWGimWrP7n?=
 =?us-ascii?Q?KOlDNUots2+GecxrMehLBDjTHQ8JA4AZPHpJULYC4MVk/SZ1RNgfHC1zGeAf?=
 =?us-ascii?Q?z2P9R8cS7mRyJ2fjTkDYqi8kLZ0WlOnVk4nCTkXX/m1yKI+DUdIOg/bo3DQt?=
 =?us-ascii?Q?DyWEZ/zGMxkTOHbQKqMy1SJnzlPkTwRYfAGtzY6eOjZpMQkR/E3hBmfmDZMn?=
 =?us-ascii?Q?z09JhcwolKVrZn5QOTQxQHzTKGcKh1icGITwoYFsB8EleNNECa+VgJg+RV7M?=
 =?us-ascii?Q?uYDxRHH0Ftx0kH/zQ/n0eRqbEps3+GLNfepeFZJy1GthRLlxzJouus6ZqsJZ?=
 =?us-ascii?Q?bFasG6Ct41X8LMQkrFWOrBJwTfToCqOBkZfYvVj38KoBhgbRNAWNZ8mOTdLt?=
 =?us-ascii?Q?I6zyK2ZSvTEJlgC4Ch7rptJkTKaU+ZkbKDWsjtQc30tHMm/L2AEwvQML15qS?=
 =?us-ascii?Q?PvFAKwMiDqVIBse1snUPuZrwHykeusZlmcXKk62FnrpHUYHXPy8yTi/yf8hQ?=
 =?us-ascii?Q?vX12Ia59TRUuwsG9tJjvcQcduWLPHfV9jGZsslARfI2D76SAbilEKsMY9vGm?=
 =?us-ascii?Q?qu86sBbGb9oVlsfUc43Kfx288JjNJOIgmWgkWb/v/FbOB7+pCoNxxi7eU9Q3?=
 =?us-ascii?Q?7PPJN/zG9xl2VGWI+LxFFwQq5UOHC06JDY76yTF0/6G11ABB33H/nzM01YPb?=
 =?us-ascii?Q?yVhC8VFVqZ4U3re1gOhA84A3u06wZgrt9GOOf3o54w1fPfoHp6KzzXWxyGdQ?=
 =?us-ascii?Q?7j7mr9GvDtojwd4aORm0jnqZX9/wtwfNgrDtTmcKVjSkpNWRT4lIet58k8t0?=
 =?us-ascii?Q?jNT3ZF3yOy182tb1aCMIuF2rAfa4uJQ/9m98Vg2L4xUJuSkEQPNIksZbW/UA?=
 =?us-ascii?Q?CeBYMS1b7SAkek7er/agXoOfPNurRvCEQ+Gq073nJK7Hg9R5E1Y1F+M0+b1U?=
 =?us-ascii?Q?elsBV1qjq/aonToIjF7STa68F4VyjYLiQDymdxcSZtvKWlGGpG/PD/NA37Si?=
 =?us-ascii?Q?z3WxT7lmL7u+ler+bnXnIPmlZriG3j814OTCVo2mbUd/7gFVniGiG1U3Bh4+?=
 =?us-ascii?Q?NOjd10Mn5fuq+/owmHtxbY2ikNKF7GYGSk8VvAdbDWQ4ozN6K3tbSoJdF++2?=
 =?us-ascii?Q?ZlIold8xBF7s6QNnAG9FRl0Ds85YEaHxulEca26B0q+dOEmcQYHUUgXHsnLG?=
 =?us-ascii?Q?x8rejmBl2V+BrT3mQwrISGk2j3Wlh7kRnrTAvuLGavNoEzmbHnQyxVEW6vsD?=
 =?us-ascii?Q?swIQY/VbCNNjtdIBh6BAYnwAN7X5quVBNmhviMODKRrF8RgArASrv+2YSPDS?=
 =?us-ascii?Q?pK31zaRX3jxumVrsgvIqIOY5QDq3oofjk+Pcn6NXwuNmJVD6zQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:57.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b6547-d9c1-44f4-9756-08dd07f05608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and releasing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d083fd13a6dd..7450172c1864 100644
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
index a88d3475e551..e0bafd066b93 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *current_caps,
 			bool is_subset);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 #endif
-- 
2.17.1


