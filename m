Return-Path: <netdev+bounces-126213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7769700CD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4F51F22A22
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87F1514DC;
	Sat,  7 Sep 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bu3s+Xcl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210A14AD2B;
	Sat,  7 Sep 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697176; cv=fail; b=tYZbzPT9zvwTzrD7TitAftYjo6CkFggtfGlGnIzM4IvJovAiT8DTvefvp7VZDuqq63cQJie7IPb0oINxC6g98VNgvmSvX8X0XcnP0v1VHdRt5NNLJpHSNChFKJdIAesIk7WrJgJTX51PJ1/y47jbkP0ObfWt7Gqi8kfbTzpUYcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697176; c=relaxed/simple;
	bh=XENGUSXp5MqD0EnxHjZ3bndZ9FmCP/roR7S0RvjPvng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+MMHtbcsi+Be071IqZvVTpb4Rbl80jJ1RkkM8uMX4v88e+voS9iJDcnc7QARWpAfsoY34YPDhlNCfp/evlc9ir2Yg/k/EelvG798+yuAkHG9/cYwF3/1fud1t+cqKUyV3FszGEMoQNlMr2udSDFlAzRny2VBF6Vl0kQ/NpU1dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bu3s+Xcl; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNYyQUs4sGV4WIQH854impW1/A1rD6SqD3dIObakB4Mz4qk2/HzOznH071a/xl7ypL0JGL4gTLPh4gmXWmNOt+4M9pxqkmrleUF6MLWHXGHV064mG175XKUJLK9dij1ipAJNNnisYjOXf96e8MFR4WPJ4FTQSAlCxqOCvcnnePLumhIns1WqqvcLP2uJS1TGu7AQqEBeSq7Cxr8H2SZ9xAHELiZCO5JhBAcJPKpUB6tJZjt3s6gVnlcfxD5RKyQ7w2qZpCqrPaS08ENaRY1ZFxTwMCN1qwWKjUmLpJT28IpX9RqGlshylNGwwpqs9aX+jwI6ILS7RSDxIET/dlgfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a32juu3lT9HE3boW3OCJsU2VMql+SLFh9g5aOWoU7Rs=;
 b=NEdAJMC+wu3aryxXEuz1jg5w8SkqryeQvEs6mMCGqC+mRl5dbpxnrR0T7hmvDVD+vRUMq+sqo2eh6zV08jPIB5OK/akoC18RUfBER1t9+9OtcCuwkd6VMxp+83BM5iY5WXVXgnAtkflGNHieXv18DCdwGS2cxGFMrpQWYVMGb6ejO+BEb/Z4CwWU+iHP7Wy6C8PujSvycR0SuEv5InuVAFBDGhsQNKKIecCqLJ9SewVgwiJasbChKefUJS14WYD75CyuQt7L71uR2jWfFvBnnpN6TqXnHl2zBaXTZaOtqyRwojFKb5rzvuEJvalJUZBNqK4JSlZml2KwOxqhQnozPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a32juu3lT9HE3boW3OCJsU2VMql+SLFh9g5aOWoU7Rs=;
 b=bu3s+XclkRN1RO1hvrAZRJSuTK+DNAX8pV8enGWL5rGqxU7metkBlCvPyKwCvKCde6pET0vz+Ldkimeufxn/swZBLAXOmY1CnPwnK0J/O4Rrgt+poaxV+wCMmXk2CcYpZgFp023a4lGPH6JafMC2EaDAeuMde0ocILrx+c55caI=
Received: from YQBP288CA0040.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:9d::24)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:31 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:c01:9d:cafe::38) by YQBP288CA0040.outlook.office365.com
 (2603:10b6:c01:9d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:29 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 06/20] cxl: add functions for resource request/release by a driver
Date: Sat, 7 Sep 2024 09:18:22 +0100
Message-ID: <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c48d57-91c3-457f-7680-08dccf15cc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1ERPx4Lya3thLFbCpAM/wcCCZczk5YtKR/dh9OVFyX1TyPfhb9aZ3813HF6?=
 =?us-ascii?Q?y2CkHSHMHSoYleLbel4Rp2hn6IdiIL3Cx5ZoT6gR5kTckVpgNE3bvUVxyHAZ?=
 =?us-ascii?Q?NkhxzdIqGYDX4uRNlLBqKY5I7AxEwSa7sZQ3GxKCrd7gvH7afcasBInLnRH3?=
 =?us-ascii?Q?eCwcII4Gf2ab14u8I1BYYDlry3a3eyZkCCYR/jUJJRKf+ZnJ1S7oJLtspAAv?=
 =?us-ascii?Q?2GpltvGpksBaOOXf4luoVumkKuTbctXElpYsbWveyXwmFW+Nwyk149GZgqxB?=
 =?us-ascii?Q?aWcIl+hsvdrUil3aOJbsGyPO++VnqaLMMv8z5LTQPzbeMHDPgXvHhi6ctrMe?=
 =?us-ascii?Q?H3MhELNuxiAr3F5lqp2tW1Z5+XifPtggwpzZ7ZneIHWOVWfZsrn2bvNDWBqo?=
 =?us-ascii?Q?KybazylQJyQHACs4Sj7FhUKaI1VJGPMdVNRivyiVfvqpSKbsxOUlEd446XuO?=
 =?us-ascii?Q?p+w2QrgNdYJmqJzPboe1tCTcIi8IaKCr+V/+9qRMUzI8Pn3n2fjWPzavbmn/?=
 =?us-ascii?Q?xNkkut3+RsREsZb7i7QdPz4CvOW93yrSf6RvWyPiEJ2X1HfKeXtDsoS6zAJz?=
 =?us-ascii?Q?obpEjc5f/Ib3FwrU9y1ki1KeBkUOaiiOmT7B+kt6kJp/WGDjPGNqadAecG52?=
 =?us-ascii?Q?VjCbiyi7kJQfDqCHdgEVPdGqLyvsoE0NLUlkzgOQSrvWSY3PaJIRCx7LLfsD?=
 =?us-ascii?Q?o/mJS/H7D0dbKbVYt23v9NMWuHqKYBmw6bHY64GB8WCf+OgZyq7CftILxWZX?=
 =?us-ascii?Q?zTs/53wGqNW0Ece5RphIp3xxWCuAulPdllbpnsZBAkrkTULrFDhk8HXLaKcP?=
 =?us-ascii?Q?jnclJvW7rnCp/VvIzR6CRzlevYXXpFvuz6N59d1IpoN9WM5ArsS114vKkXbi?=
 =?us-ascii?Q?jK4RhzXowx6rg50BZxvIHRFt7sy0Vu4uV9YDuG+XUOR1FuKlpjXXvq4gZuNe?=
 =?us-ascii?Q?5i5F73Vz0Ai88HiDzjfaYu6UDsNZiXLy6FWhbe7IQtIIAYWOWztFyhaGc9xy?=
 =?us-ascii?Q?1L7yPfOXbxe0tgst9bLdvDB9SB+hqR2jg9lzVOXgMnSK6edols8DsatF8BAc?=
 =?us-ascii?Q?SNDyb7DhbJ5jP0MhIelZtGibiJlj8Fw0Rnl5z3sMH7Y5M7BPRdu4qqvXP+Pb?=
 =?us-ascii?Q?mXVTb1NNnjyUKTWLK1J3uFCo8l640ASuQL/cz5jWGuLKdASXFYTXD4exyIII?=
 =?us-ascii?Q?oAAIFIEjzfHwa2NJ8bTqRmmKZ2YcKxkmyb2OXAEpbxKfKzQthrvkhiaNycIB?=
 =?us-ascii?Q?2LdeXrtgUBOGjUHqeHkcH+srxLXUhq3BS+E15vIteGNkY5tPdzhng0K21zaN?=
 =?us-ascii?Q?grQ6QNDk+YHZNrJouT4Fw8QK35tuKXtw5pirRrmDbM3WwrGaLuzGEmKZdv7y?=
 =?us-ascii?Q?zlwPY2RY2kkUjoxuxIFtWKd7fK1+b0rT1fYdt1zFwyUPgfKfgtZDvZoHbOwY?=
 =?us-ascii?Q?wBYXxa0ZnkIoRPC2KuGlu+m8zY0jw0h9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:30.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c48d57-91c3-457f-7680-08dccf15cc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

From: Alejandro Lucero <alucerop@amd.com>

Create accessors for an accel driver requesting and
releaseing a resource.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c          | 40 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++
 include/linux/cxl/cxl.h            |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 10c0a6990f9a..a7d8daf4a59b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -744,6 +744,46 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
 
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
+{
+	int rc;
+
+	switch (type) {
+	case CXL_ACCEL_RES_RAM:
+		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+		break;
+	case CXL_ACCEL_RES_PMEM:
+		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
+		break;
+	default:
+		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
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
+	case CXL_ACCEL_RES_RAM:
+		rc = release_resource(&cxlds->ram_res);
+		break;
+	case CXL_ACCEL_RES_PMEM:
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
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index fee143e94c1f..80259c8317fd 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -72,6 +72,12 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err;
+	}
+
 	return 0;
 err:
 	kfree(cxl->cxlds);
@@ -84,6 +90,7 @@ int efx_cxl_init(struct efx_nic *efx)
 void efx_cxl_exit(struct efx_nic *efx)
 {
 	if (efx->cxl) {
+		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
 		kfree(efx->cxl->cxlds);
 		kfree(efx->cxl);
 	}
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index f2dcba6cdc22..22912b2d9bb2 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -52,4 +52,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
 			u32 *current_caps);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 #endif
-- 
2.17.1


