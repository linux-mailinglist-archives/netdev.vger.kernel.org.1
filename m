Return-Path: <netdev+bounces-154576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D948C9FEB19
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5F41882DAD
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321319CD0B;
	Mon, 30 Dec 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tL2Vn/Zl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820019D092;
	Mon, 30 Dec 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595115; cv=fail; b=Md9vRdRkav2wISb6xnflzjK00t/0QM3Qld78BB0P79uZrcoaxxhCReUi+tQ9Ii/GgwgB4dm8fMmjZ0egrSnczzq+zmBQebPd0qZOsjs0U+DnWXObNaPJKMcGNl+MNqDn2TTEpU9VEVyx0LWjDALWtjrBzAfvN6Zi3JiyQGmGFmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595115; c=relaxed/simple;
	bh=A/RR3t07Pmv7BN9JfJS2CBmv3zegqq144sTvGlCsXKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTucBwZeMDPy+zyVSV114/4gBzWKNcq7X6u8JAF9o2n14QeAh904doAfM0OIefdjSQ7+/cGu2V6R4/Jg4v4uaFvfP3gMghp0Y5T+6ppuzcb2mhaWlsV9Pf/gPDOFjSucP53oITsz63cuffgSRkG2gwD4jsv8Gjo7heZ6yWLjaQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tL2Vn/Zl; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPetv4a+Jsh/V6tBnJKKeqtOHayGPvpHAR4QuWqnkzgQyvr42AL3rSHyfQQc/L4CKebjbpiXwk8UZOAYVMuPGYT4hnspQa5vdvBtp2eWnHjiPFDX7egjx6lnfozFAPTNz9cMAmqL83bk/3Cx8fieFvc2RoKYBE6v4keGeLnGgpIsnDutr1U0QOLf9OC31WfnGW20xsXOqw9lYvAc73JoQQ6Ff1uNp4DrSrqgDPx0u8be3EoRweEmtzNLEFUpow9jKIUcf2My8E0aZozvJ4J8CLeHraD56oD+YzqWsXMKCZkDo+OUlrhELxdmb5Y4V0bwdpZKdkVh5pkZZetI8twzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUf74OjDJgoB+EctjmQxbsSB5Rrg94AX4/Is4roB0zo=;
 b=bJhpmFdYA7lul28kU+yaovlp8psFRupZPdwi0SprVd364txuU1lcO7VDSe9JM/G4y6XUnJMBbPKtI6UbTNf/QFsEcuYJd7KYwBewlym5QgyBP1HGZ4X4Ke3pxYfiHGmQFENzZ08Ot7jIcg9VfsMNX6nfLCENDPlH/MLfQ5S6y8GyOJuvU213ityRBt3Cbl9QW+uw31jo2dBi8vqYg1mN+7XS5rOF2paC158Slq9HjVFyE9kS1x85f71LS55raTSphYHhSmlgif8nStiS+VWO0ldZWGpWVYqd+cLjJJfOaOzB/48e+8qkHGxDcqQHmslmP8zC0EnFVy1E1tO7aqyRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUf74OjDJgoB+EctjmQxbsSB5Rrg94AX4/Is4roB0zo=;
 b=tL2Vn/Zlk8VQGH8w54g2G2YBi+GfeHm3mWVGgoVeuGxGOToVPUsojZcSwUyOQWVPzjKmENRRjKwSc1pcIK/ZSUmgphG08xpsvNBrK7kmlMyn+jeLmL0I/g6Rf54mZTInMYK7ewVcbVbzF4jPrMkR41eBZvzlk+lNxTHEDtSqcJA=
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:05 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::72) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 21:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:04 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:03 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 07/27] sfc: use cxl api for regs setup and checking
Date: Mon, 30 Dec 2024 21:44:25 +0000
Message-ID: <20241230214445.27602-8-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 92973ce6-813b-4417-4572-08dd291b38b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FHdD2Jtp3PXisbZGIe3aJ6VbiT39vtOYsUlSfSucOzsbvNS1qzd89Q7gkEE?=
 =?us-ascii?Q?8Vk9uzyrdFkF1JuJQIxKSAfUPV6q7/KFIagV9Tnn2qbAzYmGYL2iprAMhkk7?=
 =?us-ascii?Q?OhTA3rXJR5Z1ncnlGADmrKi71ej1nagT2UQhYopqTUKuj9cEkHyXebhUEGEx?=
 =?us-ascii?Q?4wnM8Ge7uAIOJSrm10AqLPB4XrM3im/Z8xuyd14PFuL3kbVQf4riIhxzXWP0?=
 =?us-ascii?Q?89QqxU3gTvwFpI4JHi7rExh1voug7MKZzWr4I/bukY+VQqgyFrtQ4IlJWYCE?=
 =?us-ascii?Q?vY6IX55do1WtnVZNvr62UijvElXh7W17Zy/FqFmihLSc+ukXEOH3NltCpt3F?=
 =?us-ascii?Q?NYqsVy2sUmc2CA+6y0zRTdaF3lNc3Zn8uGPee5pllduIzQ5l7M5jUtw6mElz?=
 =?us-ascii?Q?zBzlM4lXSyXCutSlxECE7/p4snq4S21MhEiG9LMazlrKsepxg+P92uWlwG1O?=
 =?us-ascii?Q?HZCO5LQYPLHr4RBMMj/PButvGH+eDOeRPWAr5qk7h87+oKKQdha9nNHnG5dq?=
 =?us-ascii?Q?aSieo/jHvc33JePMsIEFFDmqw3FVRNjft5jkWUYVokHdnNqDeMrHewadpEZT?=
 =?us-ascii?Q?vH9UrDr9Amng9EnPrN6HUIN1NmvW4SoEN+l98a6xGtfDWNumQcxRWHEufQ2V?=
 =?us-ascii?Q?r0/isb5sXdpwCYrQBVP8eMvsTXGNww4M7INlWwK22MaS6EneIgIRfxHN7+n7?=
 =?us-ascii?Q?3yr0kr8HjcLDpS7r6egO1r05bkmmR6XZFNENBxvCv+gkn2esvAgJgMmFobIq?=
 =?us-ascii?Q?Lf3VkGLNC7DTqtpTp19jAGgrfQvrFIrz5Jq4LpHW9vr4yC9/L0fPboEgZve0?=
 =?us-ascii?Q?gphLvcEE6abmiSZXrLfz/yFzN5HPgAmWpmtjrnXHr7XA+aHCxlwX/6yCYQXG?=
 =?us-ascii?Q?7xz9RFITryXNkFFAoaF/bE5vb02722CdN3p1pjDjCZXLSh3V5guDc/WeJAds?=
 =?us-ascii?Q?kAq8t27TQF2s1ni34MSTJ+NPc8U3+dDK+y4MeXDdls1DtXYM6WOD9RyRJco1?=
 =?us-ascii?Q?lnDRk1oP9mY1JvSpANAPp2gCwuOsd9POUzDzky2YTodN5ZF0UQbzy174MJur?=
 =?us-ascii?Q?nU1bsBtlCmjXhkgtx3k63eaTaKh7MoLK9CeW4GhMVhIIHg3n8Ud1fIcK1JIy?=
 =?us-ascii?Q?k7Qr4R798pwrGQaPaCpQzu4pPV6omsOjFdHDtiac87nRTGMfKYh6nICeZ7sG?=
 =?us-ascii?Q?acVJ68wXXTdi2slFIKsrz/i58abIedt4Cts8Q1i+86Zq2hucx4fFk4Pu/POR?=
 =?us-ascii?Q?lYxBiRamUMShmbEWE3D+DdNKkXP3R0bHzjQ83M//6CyZdswk4IqDyrf+A6y0?=
 =?us-ascii?Q?qSb+zM47/Ckx6aankLfrbJXiU9nREtoijncsnrtdBV6KJKieGB4U6uYOFH65?=
 =?us-ascii?Q?TYRnNgAlEWDcTsRSSvd2ZoVUWsr1kboTYNiqMz9SxcB+AUuaga1CQO0H81Ic?=
 =?us-ascii?Q?qqmbgPAKbRYAiYFAQWqAIk8LMxqpTiNlPAwfp/uV4r9v+H1Hyy0Cc7bSLc8d?=
 =?us-ascii?Q?Z4qdu0Xslf+Vlnc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:04.7906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92973ce6-813b-4417-4572-08dd291b38b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 12c9d50cbb26..29368d010adc 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	struct resource res;
 	u16 dvsec;
@@ -64,6 +66,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_resource_set;
 	}
 
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err_resource_set;
+	}
+
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%pb) not as expected(%pb)",
+			found, expected);
+		rc = -EIO;
+		goto err_resource_set;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


