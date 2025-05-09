Return-Path: <netdev+bounces-189318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75825AB1976
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C9217E8A3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77C2356C5;
	Fri,  9 May 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EEAliUmn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EB2367B4;
	Fri,  9 May 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806065; cv=fail; b=DJZN8EzQRZ62hyAbsOBWYWVIa5raR7DzkmGaALEd5bDy7AZKSL377013udXE+t5dTmHaVhsxjtM4BhoBzLZD90tNvBRVNADyr9rTrVAZy1s39uC83k6g4toMf9BjHr4sTlV+gn9LxCVPTH2fP6vJxCi8mrexQLVVMM4t9Q4ih5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806065; c=relaxed/simple;
	bh=siMaKEfvVBNqGXRDbVlDXftfrO9yMXo24YuOMwE+B/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmeIFmiwXdvdE56L5UnXgzGvfPRSL4FwM5yVhmL/RFnumalXiblvO8278wjDVwvf235pbWyR2RmTCuOqWAgbQY3SQZyq0DLQZL5mhzu0VDGF3P89MBBouV/g4NSj3+jDA4IxjMvnZPR8Mzh/criusTQTfQb32PJ6L4csPtSYWME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EEAliUmn; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcYWM6n560OijB4Ibm4J7tDOhdd9X4ekrwxTFTYEA8/m3lGeGYrPfM1ID1eBCK4BX0W5QmPmUsGDp3P1fbIg0KJWrWkERNRq5V/9svPag/l95L79NCJMgzGtZNtbe5Wfved1kNeD0/D2V20Cv26aI560MDmOwEegQUe6R1ATMx02hKWc4xcagNDT4vuGnDDiq0Xk8m8GlobRs1nfCyBSW+ywkNEhb7Y1789OVMvb2hxUtqIK7OxVputmapc7Z3HL1XLAbVgMA38tBs7XKhtNqHnXN2AtZxPNhl5XJx3q9g93dfpJ8uWinp0YdO+NwG/aCAbjv/hlODCwc6HQ+xI8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfmZXzlPJM3ugs5Ll1DaUBKGaTXvOvXfpXDnJ7uO0Hc=;
 b=yzucifx3TjKO21zYI981b27BabQZPWRzCQBy1yxJ2+Lux4gRqRD/SNWNaY0KNPUZ0pedSzk+DSK53dbucAfJp2brPOYVxrC+oKXStLJIcjhg4PcE0vodFL3v9xhrZdvqVMUFG2vGLIwNJ5brqQLA5HEB/NelrAzxb4ztN0sPc0eObBGTx7UJHacDKLosizwjdnUXg1thp25CLT25qOqS6r9j6GDVfpAikfNHoDoS6sYS8PuwVzeA64680NryvCyz86hfHD4lZFcl/Y/FLMCqUd3jdg6Ixscyi9sqgrjh85NfsmS0XIeGd+GdJe/NfsgASoF/HVUivxL/CED0XLIJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfmZXzlPJM3ugs5Ll1DaUBKGaTXvOvXfpXDnJ7uO0Hc=;
 b=EEAliUmnEb/GwXkzjBI8gxsoFxIIi5pUue6lSMI+TkfEYYg2THGjUAYk7L61kyaUVQE/ZZmjOAAc7U58BlrNWL5+R9YkNXchxPdGUVCT/+9L+loVYsQvTp5agWDpdvLY2V6kpPL/KmW5fSd50iPyoqTCM65UyQwKF9zvE/alj/w=
Received: from BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 15:54:19 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::74) by BYAPR02CA0013.outlook.office365.com
 (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 15:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:54:19 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:54:15 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 5/5] amd-xgbe: add support for new pci device id 0x1641
Date: Fri, 9 May 2025 21:23:25 +0530
Message-ID: <20250509155325.720499-6-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a87614-8e8c-4947-04c5-08dd8f11c260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/x99QuPOuip8IUvoIUabz1e4SQmHNkhgoliGqBuR4C1MbCu8SLt1NjhOWkt?=
 =?us-ascii?Q?i08bBEHNd7KfbSvhrKmrF04v68ojVmAHmk6puusD7XMl3pkNpvK7/vwvgGhb?=
 =?us-ascii?Q?+bKdqDx8PbuSM1KZMOWSRCn/Dmw5D+uFF1Zu/InXsoSVPHYbRoGs6xaCSS6h?=
 =?us-ascii?Q?M6qibnAfC6eDskFNRrDMRYpljfaylFkZp19lCWoBgvgXkLxMoVEgMfvUkEv6?=
 =?us-ascii?Q?CNsuzkewV3UR9V8qMDCZs2VaYxqW+oey9X/BwNx3bPe6c9uu58KMdB9IVKIM?=
 =?us-ascii?Q?+OWQrWvqr9xzBpy/w8g5lNIwELIe1/eAQrpyJFr9kY1q1EiFEhb4OR7WsZ4e?=
 =?us-ascii?Q?iw2wl7W/Ko13okAGhJICITX8ZKce6SM1t8ojZ95jNhuFCD7Ga3YBInwtvqYK?=
 =?us-ascii?Q?U4d31SeB0EKuu6cYC9XOXKhYJCTb2twW7EbmR9skLEM1orCIolr+SKm5vlv0?=
 =?us-ascii?Q?JXskx3ExuzpS8N+sa6BFHIL9MBbGKy3CAjfRmecLBlydtyGoFGsT5TUr//pw?=
 =?us-ascii?Q?fbC01nKHvyKmpTajmg3e/13k20CbzXHiULjYZGu8p7ICFB9os/KjX0+kiOIi?=
 =?us-ascii?Q?ytcUM/NMjBRCVpULc0G6i0pBPqtQ88HhcoCBWWjd0ZQ7wqEYAYrmmRarjDbj?=
 =?us-ascii?Q?vAWCH/NK6mdJqi9e4c+eGtXyvjvOLKXfxwvkmV7S6CEYTippgEFhGbrbrfUG?=
 =?us-ascii?Q?dQJcbSr8uvshhLXc7P1KfPK8ILU6Liz0LUAaegcdLVZv2sCLYMFVS79sYvDB?=
 =?us-ascii?Q?HSjMjh/q+4DLhY/AHEeTZFFGCRtUxEVtfRwcdrqIzZo3SwuELgUAkYoUKKjh?=
 =?us-ascii?Q?TKdu7GD1N5aLfQco0wJDLMjWxcEkuQwhO7Uf5FnUDdUBCwkmXcr2fA7rkBSc?=
 =?us-ascii?Q?0vFnwzd+QzghJ9cMFnL4yBV4AzNCm5Qb6h8eiJ23GFALJhUY0fK2aC7rwuWK?=
 =?us-ascii?Q?LQMV6jdMOmX5YCl0RL1achtQWzWoCaOHOBDOgbTvoqtxVGNyIaGLhwFjm8Sc?=
 =?us-ascii?Q?fGAo65Tt3dqi2LhSs+zFK96v8Qh8vp6v8oINDA5q6Z+6Iy9hPlvUauNbGxev?=
 =?us-ascii?Q?Of1+0thF3d6smWmebZraZQCTUHII5c4XbKWfPSL9rbrsY59Dt8VnbF6cBbqn?=
 =?us-ascii?Q?Wc7vbVW/rociUYLVD9mdPAif/W/EdWOArYEiJeDhdJJwlzNXw0I8Zf86K7LX?=
 =?us-ascii?Q?1YjwvimmPcyE/vMzDqF3Tj+fZs0IAl9n048vu1D0RoVpBo4c4LXyLU2T8SSD?=
 =?us-ascii?Q?z+gTAhwYzxZnaVDzkD9SLJ5mUJz89d0RUVMVV3DO2ZSAPW236RanlurmTXG6?=
 =?us-ascii?Q?AaQCdyKDbH8jFkilpZJfBfMCMxyA7NXGUj7a7D0FvjRqufH4a3dAN7neC1Uk?=
 =?us-ascii?Q?QnUGPzsUO0dZvuhHcRPwa6fMypWfGgVKdsXwLtwx/thRf8njLJyfePgnJkHU?=
 =?us-ascii?Q?oFSmaoN4cNJ+aQfSqbihMP4I3m5St7dL8yEJ4+hXpGlMOmaFIzdY65r5N9E7?=
 =?us-ascii?Q?+Z6ceZG/ENy3knTmBCgUi0jazF0Ewp4rabZE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:54:19.3457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a87614-8e8c-4947-04c5-08dd8f11c260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184

Add support for new pci device id 0x1641 to register
Renoir device with PCIe.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- use the correct device name Renoir instead of Crater

 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 718534d30651..097ec5e4f261 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -391,6 +391,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	return ret;
 }
 
+static struct xgbe_version_data xgbe_v3 = {
+	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
+	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
+	.mmc_64bit			= 1,
+	.tx_max_fifo_size		= 65536,
+	.rx_max_fifo_size		= 65536,
+	.tx_tstamp_workaround		= 1,
+	.ecc_support			= 1,
+	.i2c_support			= 1,
+	.irq_reissue_support		= 1,
+	.tx_desc_prefetch		= 5,
+	.rx_desc_prefetch		= 5,
+	.an_cdr_workaround		= 0,
+	.enable_rrc			= 0,
+};
+
 static struct xgbe_version_data xgbe_v2a = {
 	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
 	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
@@ -428,6 +444,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1


