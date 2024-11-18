Return-Path: <netdev+bounces-145950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8C9D159F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7218D1F21E7B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1E1C302E;
	Mon, 18 Nov 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hkFq0ShT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0A1C2432;
	Mon, 18 Nov 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948312; cv=fail; b=DkLA1yCOitx39YP7bxSsfA5WaLgGqombI9tfUDAsFS1WURnpSZdfdO+6PR9MqEN5yvTzQTg3+sXXR6Kbg0ghem0r8M7klEGpOVfh3wbiwdbZeXOuumm3+yR+RbgWcPNlzJUxkm+Ff9UvCdq2gZ+8j99Uox1gZqfRMwiD9QKU0L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948312; c=relaxed/simple;
	bh=1j6TNfg+JhX1kaacDFWTj+ov4D9cTBSIAoU/LnIHk9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am5Abdcl7goG/RepUlXXmE6EzbqxdD5kFz8FEqmGBroWPubjB+S09jGlsw/lKsZcujgMVkvCM5CUfsqTYbyEkShYxHhhjShg89ej4/C3ETKDdYCYEaE7c7toKf4InZ2sifKGGU4cfO5e+DcDnghbNXfXiks3dydy1o2NaPHWGAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hkFq0ShT; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHQglc8WMk+cvf4U4sjy9yA4e+1NIaZkK4TCUuxh5BuKSPkR0Eyoc17M7K1rQ8Y2KDWd7liorww1GyRrCFCHdoQ9NxSrKi/5E1boxtDWp0mgR2UQagvPoIrQui1jX5pAIz3v2TAc5jgT6w9iMGyv5v2zLU47DjE96yFETb4hJiwE00bi8JqMGNf2b1JBz9E4fTUYmzfm0TVaDf6s00hfn9zRLsO4DtRfvlrpHcsMPG3PmqxI4YJb1y2MrJmg8r1O8JJaARpK3Q+dayEjxRR4HKrmL1MySSTfDqj0xp4Kh2UG2MVlO9i/IWqCBlSp3sbLiuplZDKBnmpD2wrhxgrBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvPgqfsB6q6ONvnvsSCAeyATNjbrTCp8brPhoXkv0HE=;
 b=SfgcHyeBOlAUX6JLHscaO6cSF2yIPqegeT7lvxCMMaa2bQ2NCuvpC4rGQV7e5rgKxTG0jt3+XgGhqVbzdgMrCT4v6gp7EiMCcJWFKd51rYUOb/CO6wLaRq62ifkYrRegUNXILpsyko8ayCi0hl/XP8YNAWtxtpXx/IHDihbTI+VWbUDzXflJUFYdLxc/78gr+smqPL3lK/ZBOOpvJSW3kY40TyeI9kBoF+4agOrKnmvj+w/tRqQQC//3xnugnJkBUeDvyWWHO8ywR85UIAZ9yXsQOhSmfoGyXSjNZlJJ7vosvJ9sJ8pt57J/UnGiix56M2D6q38QncTyZ34Wz2S2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvPgqfsB6q6ONvnvsSCAeyATNjbrTCp8brPhoXkv0HE=;
 b=hkFq0ShT7gi83WBWcZkyGLvf7b95Yng/urZOiRzbnKfL5vw0WuwX//7CSlmBJdAynzqdNfzf2XjWUhXysnYtI+z+UXFAPLOuOnKuwQrSsS0IUQOw5KoDfZCgFUA6CG31uXmUPg/FiBP9xwrZ4OFU+tGM04QWi8MkrCUEE//S+Rs=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 16:45:06 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::8a) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:03 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:02 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 14/27] sfc: create type2 cxl memdev
Date: Mon, 18 Nov 2024 16:44:21 +0000
Message-ID: <20241118164434.7551-15-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc3c4fb-9470-4e18-1615-08dd07f05b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QakN061NIQ2cd0pX4NjI7ppBQUA2/20811mmeCMZdN6/HG+xK+u36usIJa+T?=
 =?us-ascii?Q?7pFxHqabRN82NfOpy9CyBnXHIgXhoYirrcFHO6YQPUWINyB415ZRkTZ0YPG7?=
 =?us-ascii?Q?mBjnHYoZdoQbrZwi0EMQtjhmEZbb1NoB4l7FvRDUWpCTMCQua3v42SYOIUEZ?=
 =?us-ascii?Q?3lGWXAvQvGp/dbSUruzHvsA5/Fk8eDoqEenbbRVEoIBTvyV75zBrQXcEyUxw?=
 =?us-ascii?Q?Z7E0+tDd30ApwgEk1WByYm24CED0KvXRpzXYrS/+RbOWIZW9UEMqCoB2imks?=
 =?us-ascii?Q?IO40d05KONuxxogjRSYhp5upnjW5kj+DCF6pSoz9eQxja4cCzQz6CxIepsQN?=
 =?us-ascii?Q?zfoNF3mXzp8gKizLHfhR0YZJxhaFYTngmLUxve2Q7PUGU+x2uOvfFj1mbOHz?=
 =?us-ascii?Q?797YicpE2ZdRtv+Vo0BOeclvFtUfHvnEOhEmKKu3pq/ArNNrB0MFLInNzYLn?=
 =?us-ascii?Q?h+UQNZbX2pwxl74s4As/O0uv9m+8EAzjF5DNKF3l0ORH6fKKUywbfQyeE7tb?=
 =?us-ascii?Q?iFSz+9w9yonYa2GdG9TLihHckUyAFM7FvMFiauCfYXlwzqJrhZyabMbGzJ+n?=
 =?us-ascii?Q?mATEUisLdxpozV8lafdUDYgkjMpNJED6MdsR+pvprQaAIFNDzEIlZ3zgMCa8?=
 =?us-ascii?Q?En7LyYLVVl909gkOHQujGQXASOlpHB/MmQ2EPtqK2QceOT4cwo/lmD+a6oql?=
 =?us-ascii?Q?XIWhbrj7zEi4TU4gid7RBaA3eOVp7o83AZLDgT0GBHExrD1eh9IJyGpZ/loW?=
 =?us-ascii?Q?iQPFTlz25ALW9lCpe8gzEzKFOHR349qL69mx9TDgvN8+KBeIx8n9B9Vk8jMH?=
 =?us-ascii?Q?qLvXfqftaDFLgaugoKoEGVVK+KdCUO2UfI9Gboe/rWbpPzTKXxwsewGxRgwO?=
 =?us-ascii?Q?0kAHn95tTKEHJmSZU08vnCB8OZbpZtzAHZGIdSqhsrDV3nG4VNmdnhdQt3zP?=
 =?us-ascii?Q?TuMhdsBkbDBGoiLvwbrF9mEF1uFtiZuZazBd2QqAm9xMHdhxm8K1PaQ8PhRf?=
 =?us-ascii?Q?cZoFllRSE6PA6ummmF7BnfRH02LBhL3JGxTVw/Lm/zyu1+SjoMJsAHSmfDsX?=
 =?us-ascii?Q?zH6+yZZ6TBIt7bOGyqKcvGBNfGxwW4bUzvKHNFpuwi9xxeIWZHBbikNCDHI/?=
 =?us-ascii?Q?Q1nZQLqtDdt4DezIrEpIlyMVNDGpQ7OSGZTJV0is5vhObfM359f4b7JxTavz?=
 =?us-ascii?Q?CunAseAUt72OcOTj4WJebDGg/FOVnMx+/uIfmimnzFGRv5ZIPGjgawz8R5W3?=
 =?us-ascii?Q?Nj6O1P/7pkoP0fhtLH1EJHwkD1PCdQHzRn9FciOnfxTuPGYkQI0Wm3g/zFQb?=
 =?us-ascii?Q?mtPoo8HL5BbWApbzgFyLF1fi7ln/MyMxnryVTnNpAFHPXXyXM/POF1qhe4hz?=
 =?us-ascii?Q?Qc64sNU1yirHOc085r1vvuGo2rDUzu/wezhOWDhgZmVzW8KCGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:05.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc3c4fb-9470-4e18-1615-08dd07f05b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9f862fc5ebfa..7e900fbbc28e 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -95,10 +95,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err3:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
 	kfree(cxl->cxlds);
 err1:
-- 
2.17.1


