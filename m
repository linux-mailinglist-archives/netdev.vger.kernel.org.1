Return-Path: <netdev+bounces-183920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D87A92CA5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B847B536C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D029E213E67;
	Thu, 17 Apr 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O9QJYD4d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155B20DD4D;
	Thu, 17 Apr 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925390; cv=fail; b=mzGq1AL3JGvnbn26lnoKNncoBuZdvoqjSaL6UFIYo04FRv0dYFcN5B3VOMvbdf19BV0tyIT7J2F7zjIf4YKVQyeNga5QHYDDAdRgXri2qwGnrwQs9Kr4fl0KGrxBHlxcyvhaTjSHJ827m7iF57XMfUwDgQzx5uPqEXkGasHV8MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925390; c=relaxed/simple;
	bh=qiwkvmBN6arIezXVro1M7Mp0v5FlGgHASe2BvKey/w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU8NTPKe0HcdpTLiFv9B5E4tEcYfglOWIqRbj3JJbRGRRm7riPVCsPTe36Q03Xp1AttatutOkoP9CqYt8fAhIGtXrrBIaQ7ltYbMJg9x9IjuDH/n1dw+UIRl4F2dvR6ZE7CZqSliGEoSCTBvI7LzdhVWZCFR8pUrNIPxNbKnq54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O9QJYD4d; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOvNJ1lhJdsT9QLzl+6iBRmFe3JYPd1OXbBmmbNALfmS1nHH/X4oS1ktL84hxcXm9RssC5pdYZErV0a39TloXiHzbh12SCMmKWvBGB56YMyVy4hHW5rdebfU7qFPrVBx05y2rZtV53XZuVfyRT5TgXv+z8rWjf06AVMvezA+AI1Iqo/sO1jtAl35/Jo1gJ9OO9bibyGjQduPs4Vz6LC/9MaJSu5jjqO9rBJSBeuUI8u2gnKVQQR4Nzki5vduA43mDQ/T8lWHX5DWy16XzWomljMtLxWLmAyAnT0JxRRmKpZc8a1+ipMVaf3J3WKSg6rfEbIJCcFiG7b88pZJaB21+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qDNHbaLGSQwOTscvD8FAfETT5VReZ0xKHKfqF/azII=;
 b=qXDYZM/3yy2GpQFYs9kmSZ9tp2k3v2e/LIIrn/bd1ojQEsA1jjEYrpx1y1IQlXh4bJmooSq+xRloOAQ5mpzagUSyvjk6nuqTw1vUJGi1duvtuulQNu42zizQC5bG9XJC/w8Y4oQHTH5yJa8LW+6bspW3MDXzxuIc1vytmmtR7jQuIo/rxaVcoobx69nNJ7sdSuC6uUHTFAqKmrQce+RRAYIZwgG9iqpF7o1ruLCtBWW2IkTQVpTkHM/DX6tzDUxFRyhCdto5AHKL5ATLuiNNCuKiM0f1vDRRvzWiYsbsZCcrbvtDH2YEgmXGEeNzmCrDnGLrUO3/4ttcW/+Tps3R8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qDNHbaLGSQwOTscvD8FAfETT5VReZ0xKHKfqF/azII=;
 b=O9QJYD4dDGKS/03ZaC8Guuc+REzze1vVTTHQy38ujZVCrJpj49YVaiGryXngEVDakDymFn1NhVAn+M+MK6Kl9Ol3s2XksWs746FLIyHWEbViCni984MofVVLXBuwrYu58A1wGMB0SH/S/cwRbI21EOaAZD8QPa14ClgmNyIsf78=
Received: from BL6PEPF0001641D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:12) by CY8PR12MB7099.namprd12.prod.outlook.com
 (2603:10b6:930:61::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 17 Apr
 2025 21:29:45 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF0001641D.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Thu,
 17 Apr 2025 21:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:43 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:42 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 06/22] sfc: make regs setup with checking and set media ready
Date: Thu, 17 Apr 2025 22:29:09 +0100
Message-ID: <20250417212926.1343268-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e99cc5-98c0-4a69-2045-08dd7df6f8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhDt3i2zIfpBVr+yP8T741E7ZoYxUf5D+yHzP6RPmp0JnFP3UKweiCJYo9Br?=
 =?us-ascii?Q?ojzD6u+m6m/xcD6d3+k5O0VWUlLHDquv44xS/h/ieCmKMl0husQ+FI6U1r9A?=
 =?us-ascii?Q?8qacmRmpNtsBWyPtnmUNdo2a/v5jma5wsQlkA39waY14hMJwjepSA8VykJnL?=
 =?us-ascii?Q?L7BFAEKShqHyGwrjIeS7K7x/Yl2K1EWuproyEQKEBO66EwsQb5lZAcHg6Ha/?=
 =?us-ascii?Q?QKcYFFnZhHgVoJxqlam8sYzfqm/lF7INI5U+bosN7GZuwwExc1n1og8rOvX8?=
 =?us-ascii?Q?kNGvWCgK7cO7RUpcFrle5B0YnoffRbStL0krLzhpy72Nr2VrkJqiX3MuO5Es?=
 =?us-ascii?Q?9BazjaBa1bl2/GtE6K/U9Febd91aEu9oOA/YYpI0eGOtxNxxggaxbxUKYXHY?=
 =?us-ascii?Q?N6xdcv7OpJi9WzC8fO/9/cys0hgVX3RP4PdB/5QedZnxbwbZxdx6guSgQL7H?=
 =?us-ascii?Q?HkQBNWhMSXUfzalJxnJaWE8GU/e/WtiHRVc1Dru9kc9e/Gnc11Y1M4Z4MR6o?=
 =?us-ascii?Q?z5CPOMnKyKyh+bxyCHwlavqeY//8WVysWVKYt3q8h5DhM93Yx/FmB3zL8VpR?=
 =?us-ascii?Q?HdbBJ4FeJPcwM8tq+orn4Vz9/nX7k2CzPEall1EDjWfzWfVR8R4mT/G+E6F8?=
 =?us-ascii?Q?xYBxQBhg34pcNjm/mj48Ac3GSnH59vwg9Ra6txjCAuShdM3B/FUV7jt8Gwm4?=
 =?us-ascii?Q?vO/4LPrIBK/IdNuXjBg9/PYGnlPM8yS/7r2VA98upF08xodMuO64yqgStKdq?=
 =?us-ascii?Q?0WGxGPEyVrK7AoAXvuGTCQjJSvaI3O4hd4ET0CQITcpItdeSYvD5xEhVPqP5?=
 =?us-ascii?Q?Ij89Z6hLiBgMJCXlRm+Ux1DW6gqqpakBYW44VcaibKeJptPhtUpua46nCw3d?=
 =?us-ascii?Q?jOGVkG0GQhMJAcdDhWwwu1f7VlSIHwN/gcEG8Uou6uMm6YnZkYNOlCXBrOVr?=
 =?us-ascii?Q?WZNEHwqqy995owIQEIlKEAbc/aOoHTfP6LAC4Rn3jA9aQCbsqOZIF30UjX4K?=
 =?us-ascii?Q?rx91u8onKa4iO29M9SBXa5Wg1NcRsoItnbB1CDes9JeWylCMlst4gQPnBCAZ?=
 =?us-ascii?Q?Je6wtDDezrJUWDI+JnO9VDz4mdpFMsDjiABGHR+pWElMl4Ax3jtimFSIUePz?=
 =?us-ascii?Q?+RHRvY/6v5r0P2aAc78zSq4Q+kBog6wogtFjtXzuvhSjHyPkRulH+dMVnmON?=
 =?us-ascii?Q?Cq0nKvKSf2dBGHiL5TlEd/GmkMElcpzetKpM54BYwzWgkG8H/XOr6HJ1J0R5?=
 =?us-ascii?Q?Cx/TthNCesGLflFp9zRmhkqY7EsDy70LzyINr0xilPp0SlN9zRlBsSZdtg6f?=
 =?us-ascii?Q?szM1ReWbJa6BSKDLsveAzeesEz77TFeVLF2oytAHMv98HoOpp/lkoyLPSYXp?=
 =?us-ascii?Q?2uISXnNYy1KEtgaoydV7XnyVR2KD2Z1e3+ntctdrqEtEHfW/FVMM2VXAeGd8?=
 =?us-ascii?Q?+qYoRfoO90WTJYStiqg3I9DYv8p7Ez5hHQ/TDUzA4Y+TRtfIGNj1Ea4UX9hS?=
 =?us-ascii?Q?xi6biQW/a9bM16yx66o6PtZXpm2YFaz4xiB6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:44.6512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e99cc5-98c0-4a69-2045-08dd7df6f8da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Set media ready explicitly as there is no means for doing so without
a mailbox and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 753d5b7d49b6..79427a85a1b7 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,10 +19,13 @@
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
+	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +46,30 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		return rc;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pci_dev, expected, found))
+		return -ENXIO;
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


