Return-Path: <netdev+bounces-150340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4D9E9E8D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEA280CB7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E5519F419;
	Mon,  9 Dec 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBPq6yYo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919C19B586;
	Mon,  9 Dec 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770495; cv=fail; b=ORgsf7CJ3/QEAXZrdjLSTDLJApSDom7Zp7/mCPXlYoZFFK9AwVRBn9P4dKSxc9jAcqo1+w/O6htRz0hY4DDglhsv4vB1nqT7g1ABAL+7elfszyJEVzDU7rkH9ZDVZVHDC5ACtGZMQEmVEGK2RljncZvAF9mwGAk06vZjQJAyVCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770495; c=relaxed/simple;
	bh=rsd5P4sh1f477GIl+2hCb7gzJHNSc8IYOME889cScwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEMKADw6dcoIuysCzyL4XdHA3Y3pjPaAMGccNrxn0MIsOMs8jE0wZNHp02iw/0ucG/cCaGqfWWb3c7ygGYZgS7kHxUNhFtQyK7Ac1zfVWxU8rV2pZWiEq3odirDQ+k0TpveJ5WyVZv0VBP2yWx+LTa9ufyHfTZmwSBpVfJ1ZJ8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBPq6yYo; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC207uiBO+oJ8PlX1aoq4PFRypFeANPDRpOD90E7SRfjbryFsU3hS/zHGIvcfF27Xj9YVcChonqPZMVR9Zx9196facfz0iwyQN8RDKzGm5Hn236SrMdzxsjAbJWOZJfNf5c9UFm8Z6spOIOCUe5fMJzd5XLTaGynl+EXwsDImSYlu7xKZk3G3i0B5AmntPP2dfw4ZvOFW9W2u3sTiBRxd3mNdlO/q19qeFYOkkdMQHLQx478j7QZ+EN8YY3XBIhzmAsUg3uGlULQhGa7TWySZ9nPM+dk216+ZIwsRPBCPWDM12XVyhqBZ1QTNNptQzXqxK/UfTG6XryTGSQs0C2dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlXkAPufsfHVx5vfvAFJ9Jl4hcVcs9Y4OKknSjdzGjM=;
 b=TVMS00sa05azeov/c/v/tfEa2muxZXCUPeKjogG8EXx96hA91Zp/dCm90bDyqNcd2waPG+QatXFTc2Ak2fPe/ZjnKrzpPGUwiFiW1hXh7kCACb3QwtvQypFuTsGy/jCLJY48XfrhwC/LuZH7cuM63+qw+PWw36cbq4mGXSzQ5T7sJHBElZ/2DHhoYKJe8moznSNFNFf/UFb7/21jd7xZ/l5hatn0vjccDg+OC2Nn/7TYZg255xMMPzvgXJkeX2EKEnePXfWybMgMsEreWqXnGrB8DCxryx7mflq0W1WcQbzaa0h1rzkZibmgwu1GmtO7jtHwYuPqLu/x0rcXiKPT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlXkAPufsfHVx5vfvAFJ9Jl4hcVcs9Y4OKknSjdzGjM=;
 b=YBPq6yYoZIZq7xciPAUER7PS4GCeWz6S3wSNnOJ6cPXDPbqkfcxo/u/x260Nx1irLsUiPwbmhQ2kiDjlIVAkPjUtbf7lNtwTRaDXxsWht1qHo1snHHCOfM0zP22GylvKti5gIY1xFxsRUUknrnuM3+aBhFHG7W4S8aAGUqLAq2s=
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Mon, 9 Dec
 2024 18:54:50 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::47) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:50 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:48 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 08/28] cxl: add functions for resource request/release by a driver
Date: Mon, 9 Dec 2024 18:54:09 +0000
Message-ID: <20241209185429.54054-9-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: e3369f58-76a1-4f06-d83c-08dd1882f5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KbZdCvHhWUikX6HATI+o4LrSbePJbRf8/Ze4VBe/26SQ3HveCZ281aMHHvHu?=
 =?us-ascii?Q?NcV6RivNogpdjJVLaxTqKjUrnahQ+66k8ol0o3tNwb0xwk3OBR/a7TG+c4F8?=
 =?us-ascii?Q?COq5cL20ZnsQ45pNsGgPkolpajIvObf/16ZC1b7FhPmpPu8b8kAfqsXR83M9?=
 =?us-ascii?Q?Oto9RvH9P5K6vuZUFdtfWh/zcDVbftfAMZaYIgH8uJccndFxQo4rNOfpw6RP?=
 =?us-ascii?Q?id3pm1TMiGi1vX+B3pol998p4bK6qTJ9m68m6NXaSp2RXQz3Y35UMM3MK9Hf?=
 =?us-ascii?Q?VvZMC8pCeXl/MzG8abofFRsy2TkEviBpVmjVGfh/rugfeLWjXS4AvDYwPI2i?=
 =?us-ascii?Q?wkKfjEzPp7wh3mCDfCzph0xtOFSnND87wfhAv1RQb7Cl3D6qcwTnQx7Ia38j?=
 =?us-ascii?Q?HoGIVMBMiud4aR4tUn5a5RS+ElD485UJt58hb2XtS/9233G8IH0/Qi6LX7kb?=
 =?us-ascii?Q?lxk/mruZ7CwAVOd9XzCncIVkw8YhofD8EXEkpU/IeyfpgXbJs6Ph29ahz+6u?=
 =?us-ascii?Q?5yMyRDJoBduLkVHxGr882mkG1JAQLO2zHes85GuxkoXVR6sYf3zEYjPhRoRu?=
 =?us-ascii?Q?rCYz1Gu2Oh7Pgn+Zx3hx5jHMUgd8SlaKg6DiTNrw4cEoD1JmzAa0F/Fjuw1/?=
 =?us-ascii?Q?qfzxrZ6tz0dhi5WIteAw182UgOTKjL5skbEYsVdE/C0l95NALqPjE52rwFxe?=
 =?us-ascii?Q?kDNlNSKD/u29tQwOi4ea85QppDxvxGKItfOqsN0wvtDo8rkOnKTz6G5rnQyG?=
 =?us-ascii?Q?p/+KWd4zE330gXC2F3YhBfuF5L1L0CfFPpgnciEfQvDJVB/TMi4guKpJ+iOd?=
 =?us-ascii?Q?gXNlzaG3K2mIO12UAR7jQX7dXwcGbN73OrP34T/YQNOd9g8IYDNMhxXWuhcL?=
 =?us-ascii?Q?wawehv66z2IhffrCNgTCfGIOMlqB4uawAZJg0cn/X01hCmobvNA4ZjTYHFB5?=
 =?us-ascii?Q?5IqTSuSwPgFAI0O1Rm2xmGqW9j6uT5CKSZ5p8+6yUEEaC8rzaDYiJv/OwAYq?=
 =?us-ascii?Q?7UcGpk23v1ebnmPRSRelk18BERhW/Qv+oTxNqozBPsdgkK/Bq/GCJlQarXMF?=
 =?us-ascii?Q?dZgssisaN+FA1L5JEiLpGzwFI59gDuiUn3QY3uG/g1HJ4O6KW04ilyEfWrLO?=
 =?us-ascii?Q?iYuyh6J2CsJj/cM/BjTeNHw4kDzNC7SuoK0ymrYee5rpEWBw2r1fXCc4p29p?=
 =?us-ascii?Q?cA4VxuIFcI0IqMC136BG891vxGptX0Tdjn5NZoatIUBcRdkHXnd+TNDyr/xk?=
 =?us-ascii?Q?EWiHWLxfUaK/IL2Om58w39Aa460zlA61CcCs7fsYnFNBArtvOJgfiOb6/Qof?=
 =?us-ascii?Q?ZuShXynPdgqJ58ynzNweHyFeFoqTyTBDn/FmsTVTCBzssuqaTnMaUpy/9vZn?=
 =?us-ascii?Q?5lRd3Fau/r4cKP9SyA13FEDerQ2GqPUSFbpBC2jMDER8E4NwazjsMb/T+8yw?=
 =?us-ascii?Q?dOj3WU44GKptB1ko7Fpe8oOryPt4RjwGhtlhzOXA/M3eLF1lFD6yOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:50.4158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3369f58-76a1-4f06-d83c-08dd1882f5c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

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


