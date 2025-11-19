Return-Path: <netdev+bounces-240146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0FFC70CA7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B894A2A155
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA249371DF8;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wHjD/hpV"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1A36CE17;
	Wed, 19 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580206; cv=fail; b=sTIfnblNoFPiB9sabtZhKoeH1fZYMLleO2qgjkqjMIXAFtwkdX6V2j9SDIF+yMa/M5F1mIqJxlU3Xk+8fixHZWa1s75Qc3l4kyIN/n8yoLbmxlaeo/FTPSJBNb/QsDzucdHg9p0LAImz0Xb1s00MBIn1QGxj7Kg6alCFcV5uLDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580206; c=relaxed/simple;
	bh=sDB2g2KJG9u/u4Rl2fX1Ry4Q8D/2IzuNg4m0r76Tdds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiA0uiDfTwW3A2NY1cOG7oKbzZW4Yn7ZGKwSTvh4EwZAZJX5Q+BY02M3nrYP7EGt+zqtgKUDpZuU48j5klylLbWQoPHsZma3rZcIgha410hbJhf3WqIgk+qyP/oKaUpuDtZqkuhSeCuLR3+uhm3y2foZUIAc92vADS7Vkzg9T3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wHjD/hpV; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDMFVR+TaFXoPQWBcn8wgjP1jPRGiQXjyipIJ8ZuTeCT9XV9XBnfTgqtOJu9XJh8ZxstNErcbMSHiq1kGWwM/qvTYYqRnzsLg8yY//Q+2gJRONWTCnmilxInszhbY8u3BrigmMoLahEK2H4vn/x4abpU1YTKhTi36OTVCsaOc2LcSmKsYumebdF6oPuuPyqZPVFDpkygHedd8TvM45ypoiKd9PvgJv5D5EIquFCWAdmJPdhQ+tvPRmXWlGkE2CYvjCM2Da0HibL3Y2/WY4ftVP4Q6w5bX369SBxPRv1NmnkrdjTH69w7CWElrCzbbloxRBxpjHVq8e2c/7pIKP3Yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=Xv//jKmFhTpYpPHQ/RwP9qNDGn8D7Lc83GycrSz2TcQQ08r9tHCxj33ySahRJeW+ZimnoEZBzAGyFBaUIm5dZoghFZ5uiM7QD24+YLo0YfipGkXSR/7KGg/ng8MUPEblgi7DclP7Z7yz1Wpzt4iyfZfDA3I8eNojfb6TSfyKsuzW/VYvO4cQddglDMtyCFNlLQ0xmC050kORQz4Kj5JDpOOQlI/fyRA/d09+eXBU6N7dLz2y4u6bfwVGhBKlOjCFZMe2m9g8U6pWvmnW+S2/CqRERA6tRuAKlqBdntr0Cxg0DbfeFhtll9USZbXbKYMhxuW7wtU8gnYpnPi5fPP/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=wHjD/hpVdn32Hsa+enXZMNwOH7hWkWtSngpMTu13Z7kaBRTIuR8mYrJi75sYp74qG89rbFGj4zzCr/O+QFGM35BOa7AWlkhgVfvIOwOTqG68bxqeaq3efIeezy34yYSTjqtveZrkJNGy3Y2oI6uY1FaHQwLRLvhh6q2YqJ+9zgQ=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:08 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2e) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:03 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:03 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:01 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 11/23] sfc: create type2 cxl memdev
Date: Wed, 19 Nov 2025 19:22:24 +0000
Message-ID: <20251119192236.2527305-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b212ea-e3c2-4935-8b37-08de27a1125e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtyM2UG9ChiKtSGH1hRhmIN+PeVXzMog5TnkO6MaE9z6zPI/Z0Q1Q/w09oqW?=
 =?us-ascii?Q?J/Wg/Doosb8jUcjnJuK/Ar6inmVApw5CT+lGrPhtwUElNakGFYUfa4T8JROc?=
 =?us-ascii?Q?Gki8U2Ujx7pzNwsQkLSiNiGnEN0edt0vDxZMAoGditBdcHW4SrmoPsXfZIfq?=
 =?us-ascii?Q?nlj9zMmNED+v9/B5+v3uJn4eENxFp2IstHqvYUbU6XxwgGfyT+gkrjnHOX7q?=
 =?us-ascii?Q?Zdj6hnUHwNSBnC7612g6r6nanuj6IAw52RDfvtLIKWd3dcDMZNYxyVEvmyUL?=
 =?us-ascii?Q?vVkRfUBE0Okz9FPieZItN3cTsiGvq0cV0UUO4dCf8SwMu2oK1eW8XxU1SGza?=
 =?us-ascii?Q?K2rMY/+DGPhtNOg//V+pS0ycVglFoJSCYvlQKCMgnDxaAceLTdWWxqN+RjNC?=
 =?us-ascii?Q?j7lQrWtZXAwhg1oYuXZ/ePkGBr51RYcMzzZ4TzMAcQfeUDu1g0SEflXwjaLa?=
 =?us-ascii?Q?v5xicrYo+4zbKRDP44MbkUyahLCadksbiDTRSdyjPJ8IMxBqsfl2/3ngelqT?=
 =?us-ascii?Q?eLiOq0fup4UT9bMXqVXeMRfqn2hmxQrpKTUA2w6ctVYVMOCwGhjX0FO8KLvl?=
 =?us-ascii?Q?SCAbzkUR9bsrtOutE/qwlb4dF+3u2jZFUgqKp8pch8aOjVXOszEpeThQwtZU?=
 =?us-ascii?Q?pvgsytRrQYbQKBuMWzKBNKHHhzKiRulmeTY/64BaSNnJb9FCytuD9bmT2lhK?=
 =?us-ascii?Q?Jl+MfB0Y5Hmdpu3M3w6aUWOycjbQDM2zKSJex7RlK1IIlyZV7SPfRRrSup0Y?=
 =?us-ascii?Q?1x91UfvNuJg1zvvfesc21uskJcPEAgLVp78QTRfM1ef6WfLucd82J9cB9SAr?=
 =?us-ascii?Q?/ard92MtKJmCVCL9/N1zZXfOTXFNfREVohgeTsFPG15q5/PHgSvg117dETlK?=
 =?us-ascii?Q?z8ewWIzRAs1ZWQtF8wpVofdty1QsqWYV9ZJUqeIP96X/Lf/xCHSem8pIrHGz?=
 =?us-ascii?Q?KrsyHseSwYPefpqbTJwYf2xmgbyopYrKW3Hoh7oBd4H8Zy1f1tH+tEtuAL7Z?=
 =?us-ascii?Q?QGZBejENi1kK/H9/YsC4BjytnUTzGRKkI9dN5IQyBqgRqLk+34DV5xm7MhsA?=
 =?us-ascii?Q?7k8ALCkU2UL0v63E+m+8hrrxHm/HtPA+dMZ77T2807kWSfjAKH6KYvvknVSl?=
 =?us-ascii?Q?CFoaij71GbzneWxR3f60y39fUVV0SrZNU1IuWToxA6yLJ9T7r0LTrepvxVy8?=
 =?us-ascii?Q?avgbZecziXqWhYLdBv4ad6M38ElcfzSLSVdIOp8e/lFVl9nxGPAOQc5z8HHC?=
 =?us-ascii?Q?WVhLyXL/0s3vIMBo6bUAcNbh6bYEzFhBa4DUHq7MpHs9csAn+Xs2uZRLdeNK?=
 =?us-ascii?Q?Kum2vA1H4sH0DrvYEsPjgqe2THMGCf6oxi2xMK3HvqmNIEDn7GUMDRBSp/Bk?=
 =?us-ascii?Q?XUk4cMkZNjZ+BNf3l8MUdC8wSTLjSyYp36LHajy4MoawpXUEzyvlmHnNLOx/?=
 =?us-ascii?Q?H69jU5EKw9/PVfn66sCbbUUr2mvgVsuHpKZQtJN/GgWOs0WEh0Y5R/JoLaMz?=
 =?us-ascii?Q?IB3XZCJ9Bj2sy7P0A/HuvmKdW9S+A5XpDLgXGHh+ZphRxQirSZ/OQJFy6SR8?=
 =?us-ascii?Q?P1E7iwwgsXFafqT8yz4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:08.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b212ea-e3c2-4935-8b37-08de27a1125e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0b10a2e6aceb..f6eda93e67e2 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


