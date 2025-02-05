Return-Path: <netdev+bounces-163056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B532CA29484
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280E3168DBD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CC1898F8;
	Wed,  5 Feb 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aqwGMGjQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B461DACA1;
	Wed,  5 Feb 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768834; cv=fail; b=kn4DMdy6SNh4b5Ssd3A9xoBmOHhzBTPgpXcQFrTrbWFvNAn8Ad1Ir72A1GNyanl76mzSrWkT+bExIDXrh6WRkjXuUKp9i+Hi8mdzzS0eFTCLSS/saMextmyS8NjBAd08zK83laMEzS0yZyhqWnnE92mC9ceiKbm7N/XDXA30FjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768834; c=relaxed/simple;
	bh=liDaTpDChPOXHDrXYOSr0eTARKegjc7QC6uV2QCKDSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjA1G1XHKi8PpReevlfAk6JRNC0T627XNsxNR5E5KNT5R5U2JRh5OR8X3KpJzDitbNL+hJ3TBWXEeN0oSXYc1dbPdYcL8KURTlAaxYAGOzb4kX34jeecw9KlPlc4IJSwJG7IYMmGlM5k1zGXPxftSGzOwpgyVS89+Fl3319yURk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aqwGMGjQ; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THoNhsxGCG+lx19yoGiX+p4syhzcsvdg4UG7lVGm7NWRfhdvrzdYcP8jdUkWe+Wl4oCJHWwC/4qqPAx3MP8vUqyIsWcEp9Bz3yWWFOpvA2BVh+UkGs9To9SSDCCdhQeRZa3WPZrt1zb6ktiJJmQt5vpXBByyGbgd/zcht7j6pyW8ZK9G3+npHt1RSEXpcQHDiCzapvvJxyOHUNwqEmog84ZCQpadgnxKVLj+jDGy8ai1MmDM2GpQaEB6GquZdQLTNjLLAw/tl0bv3R0YLcQ4Mw0XKARQkjXLRkBD9dLdQMdMUtyaIeMi1UbS+iQsfTdhPUM+zHb4/WwOS7pC9UceJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91JENTy1Qn60f8X7zNIK1L/uu9Mt3l5B0a8pqxcMpzw=;
 b=w/cqrNJ/JaDgk+5ff65E6sUs98x3WayDEI6m3c7CX0u5Uee6H7//xPgkO19IwWuU8kdeIScvQUDcKatHZV1/mGJfdtWki8Xq6M0gaagIZ7SOYwduDHGnGbprxKHJEgOR2NMvAIv1efDdSmWHx8ay2LrjyfMUdua8FemSKJVspZ35XvQFpDMaoYnlIxUUUurafJ9QwGpTRzmOD92hER0hynFCMvLaZzhjqyAMMsXEtSl4icR5j/LQXqsrCwKqco5wTh4SPrLbFhYdIyTUYRwoEYUbjTz8/lRQrt0Wo11DyZbQwCXxCmvv6S8Qfqq35Wvd9kSe6MSkBxbjhXeO+Em/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91JENTy1Qn60f8X7zNIK1L/uu9Mt3l5B0a8pqxcMpzw=;
 b=aqwGMGjQk70tOVNaW6rdpPmqJsddq1nH9KWqAGJRVMe+9LXidFkuPjhJFl9y8VBSt+jxy3HtudF05Pja8y/UOUyg/I9LoYGtxUC2xdnerJwrILbTaupJWcW/tM7L4kn0Zmdv2NPsT8Hw0PDRgnzbKEZsnp+C1K+UBOXFIYtK11o=
Received: from SN7PR04CA0201.namprd04.prod.outlook.com (2603:10b6:806:126::26)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:20:24 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::ac) by SN7PR04CA0201.outlook.office365.com
 (2603:10b6:806:126::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:21 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:20 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 17/26] sfc: get endpoint decoder
Date: Wed, 5 Feb 2025 15:19:41 +0000
Message-ID: <20250205151950.25268-18-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: d96eb610-ea4f-4e2a-5267-08dd45f89cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m9n9r46IbzBg2ojwEzlGxWoGUW1V9fT202Cr6AI+jqgXpPl2azpIpqqpE6mp?=
 =?us-ascii?Q?wG0laSqENvoBB4bBSOteuhSV7donWMbDjIGqHr+G2WaeWI3QvIV0rT/iY1ci?=
 =?us-ascii?Q?OGwML0ctQcBoDYkgEGv7JwDrpD9pv+Koq3uTXAY1KxAHfmJ3tMOWyVSqpZKl?=
 =?us-ascii?Q?9053ENKqLBv2El+ONmo74rvcJVSbfSbD7m2leeena8k7hBZALdEZxUqmaRkz?=
 =?us-ascii?Q?V82UDQhq155Yqyw4a/ueBs5PFQ9Nbc5G58x8IWV54bCUVXFRIIk+Q5S+snIm?=
 =?us-ascii?Q?fIo/3RwYAUMKrhkzbfd84mF0rFHNoTE2N1ygjiVCLNMTGVhKnINaRANPl/dq?=
 =?us-ascii?Q?5bBGW1rZC/4BObACOFzar4CNX8GwUfYr5jxQnDNBbsHjN5pvao4/g5I8BTs+?=
 =?us-ascii?Q?6Q/hLpoom5IBUXcGTlVFiWNty/pkp3EkT5Pn3c9TU/FBw54SYRoPHqTI4lJk?=
 =?us-ascii?Q?Prxkc1523xMg1/e5sMGDf/vI7qzm4aTLFqJ/bFpx+ESsaCtDIvPX0/FlYxLN?=
 =?us-ascii?Q?fyQdwKS3j/4vbwPbVowVipaKY8Ql8nwyLs2M9Z7UYLJQv6UeNjwfW9WXH39Z?=
 =?us-ascii?Q?RXYgBAcOtZTGtu14qbXq5RP+x+9c4CJdmtxQMMICIeiL7NsSTJJxCZvjHZyt?=
 =?us-ascii?Q?GHWZz+x6aPth/pAXILS2MU78oV9XQudR3vvjfdBs9+xwN0vES0KmCzWf3Ogt?=
 =?us-ascii?Q?fa7SgnwK5H0JwVyXBUeAkqv8JN7v/6Flm2Ks8Zi0FFjmp8aK+X7iCnB2Fszt?=
 =?us-ascii?Q?y+i5S6mW5bUK3osz4/L6l79gPqYY3LmMghFadpII6WJIY76D6D2Tt9qcILYE?=
 =?us-ascii?Q?GK5RJCgyBET97KvxNNUw+ecFTrZx1V3tzordUgOLxscyJlkowFLWO5ovfGQD?=
 =?us-ascii?Q?Wn95/+zPjdfSyLWFteU6MfYb8L+mpG+z/jaXEls/Jl5aqnS/InWR8IcNQMXF?=
 =?us-ascii?Q?vxu4A9TI4z9dmgIGWN9gZEg3QWyibN7OWN7I5dGjg3ZzZGL7iAD27Ju9Nbw9?=
 =?us-ascii?Q?1YkYIiXCWPBoE4irwM8eI2bmbnty49fRmlnR7vaNKoL7NdAPNZCYlzYleEa+?=
 =?us-ascii?Q?FrKzRLtzdF4XbBtClNYl0h200aY5jMg5QVBSyk5yOcLvfMm8b3t79K2Uq8oz?=
 =?us-ascii?Q?4zAKTsih9jYbuiB603jTBnbvDxl1idjy51miBs9byvyI4wAyIS5iX7cGDPbd?=
 =?us-ascii?Q?MAZ1roX2fn66uBwuiihZv4dAJ9f7MkPTQY/HOf2pmAy0wLcoHRnbr0UVCal0?=
 =?us-ascii?Q?SQwgihWM93XfsAwHObAcILt2Icve6XrOXVe93WYo/JQrglxM8MApkpxmOblj?=
 =?us-ascii?Q?7fmyHoL+yBQJV76lXPZAJGY/0OicyvYKbJjgmWnU0WxPeiA4PXOu32AbIh8K?=
 =?us-ascii?Q?Ln4H7Z4+5Pf5kDX7gmu4hZmTWWKwhfqbc1whmhh4rT7wqLYx0NqAey12ObYq?=
 =?us-ascii?Q?N8s7irFLgG9utP3JORWeDMNZa19Xg2JJXtIiiTpHu23NLm7F/52+gnOGoBNw?=
 =?us-ascii?Q?XHKiLGCwVIBGiK4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:23.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96eb610-ea4f-4e2a-5267-08dd45f89cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index a9ff84143e5d..984dc2ee522d 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_regs;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		cxl_put_root_decoder(cxl->cxlrd);
+		goto err_regs;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -134,6 +142,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


