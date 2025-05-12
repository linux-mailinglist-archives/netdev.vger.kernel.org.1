Return-Path: <netdev+bounces-189817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BAAB3D29
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41460188468F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02102505A9;
	Mon, 12 May 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z8aSNIhV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EA253F36;
	Mon, 12 May 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066278; cv=fail; b=pBXDOeQ/n/DOFS/cmGKbGGZ6FgmLGRGX+2Da0Qog+Vp9NO4gaMwO2GIclAgMreocbSQhW74AjBrBhnLG0k4xAxI6vI6KmEr8MPquoG/sS8f4ynaSm1JlPJNvWqJGqwL9cmqbG6z+n6mc6mpc+Pd9vLakQi2e5Bfqs+R0y1OA7tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066278; c=relaxed/simple;
	bh=qiwkvmBN6arIezXVro1M7Mp0v5FlGgHASe2BvKey/w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/ms2gKY2rQAWKewWpehuW8TYs6GFpMJ6AQ1gxrVqCxkCH+11mxb1S782108NhURnNEXC+Og/CG67jjKMcvEOMZOUhX7boKLQw8Wagnp/kFZpIe9XVLZCwc8nHpSvPfStPbOCYJuRJGGm5mx6cvmWjhvEV1DLtO8wWo/hZBQ2yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z8aSNIhV; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSa/DVwI5jehRHcOsmlkXI9vqQhjLObdB2Q5a+Zom4DVNGPSHVobFZK3n9LSLuC3Lq3nyqdlkHmCQQKnInHzU1vksdG9qFNuHLrblvBIjHHGSv1/kGx7JokRFyMvxlkG2X9qAS8LTU90KCZCNpNPZasZsPzmS0kE81UP8LX+dTFqZJi3xARrz1c1vIUcL397fRZPZwkUgX2UAvMtO7Jsk7MNzNd8dtUxonsQT9UsVP19NSuIELEpgc8HqepVb2LAMdR9Uk1AQvUZDbdWcxTBcf3CA97D971ABaqVT2eulLjSRPxFAcFOwyqRf7DvZ20E5pcMl6rR09vP1lYUY/albA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qDNHbaLGSQwOTscvD8FAfETT5VReZ0xKHKfqF/azII=;
 b=AY8ehjxV/cR5kR8VS23P0HP2ErfVGpdAUMhDmV3pGilqiqMUYAlLKWt21Bly/b32MrbgthtnDn578tzaKtPJoKwWuxjz5xcFsI3LoO1rCHbFh85YB3RZHsyow1U5Ozk4aDTDE4dDOSVyxYCLyKu/hwNQlT05cWE7mpSpP3ax3YPzKDiBqWwyzOdl9he8BpgZ+9a/NO+awgI8J9DgzjPCxOrfIeQth7pQ/rKW3ngJoylG3/auoSKq9irrqmUne43xGb7ne4s6Moi/DyFuTaUZdo4dT11OywrS7CfxJ05tk4769DBrqbLTRrWLw6mWzqzp+IPGO/KvGMrtUIH10XqOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qDNHbaLGSQwOTscvD8FAfETT5VReZ0xKHKfqF/azII=;
 b=z8aSNIhV9WwleHjwd8QXPk4XmwOGAt52mMeBUoyxk4wZBkAHaSI6ZoMpfjDD2vLVAxcGsciLHDuLTDP2ilbNHMwlY/Two0XdB4XmIik8blT+mtmLbsJtxyIdU7mtXb3LzzhOmWlHvga9hL14UfQF7xnZF6m6v/9gn3/xeDeAueY=
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 16:11:14 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::6c) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 16:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:13 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:12 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 06/22] sfc: make regs setup with checking and set media ready
Date: Mon, 12 May 2025 17:10:39 +0100
Message-ID: <20250512161055.4100442-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 6504f14f-389d-4aed-572d-08dd916f9e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqVWaVikj6J+5njW1yVjmByOhgeIpu4mn8MNTl2n+eW0pdjikWotfFMhTBwn?=
 =?us-ascii?Q?V30SaV3+7t6QBl1q7nyJOcPiHhFqi9CNIPjU25L7MhdhfTrMW9Hh1nhc7EhF?=
 =?us-ascii?Q?jVy3htdQK1x26ni9CYzwTFV7cPkcQzn6NJar03PyU0Vb4jg5grS/KFcKFb1o?=
 =?us-ascii?Q?mhwhg2mZIR7pUPQkhMSDgN9pbEHqGSsICrt/n/wlSOoddkdDRiNfB7gsFk9/?=
 =?us-ascii?Q?pTKDt8wHz2xRzKr+mvNGj4mPEykckpcfleZSnbeZW6hGWLE6pNWrumtiyFri?=
 =?us-ascii?Q?MxKg9hTYSZK620Gm3O9Iy64kagrx2kqPElV+x2ionwvG5f1miKNPxbjHLn4J?=
 =?us-ascii?Q?euNUc+FIJMhzJ5NHdC8yJXPzXjUXgrotxnAnIn6Tlk7Bh7fJ14WKHR0slsWW?=
 =?us-ascii?Q?Q+V2PYZVwV5KAVs2VwruXzZ6NCF5T/WP79SgSgIWbqm70s3uiDyaOpQ/RuwL?=
 =?us-ascii?Q?nzjoJuMfD9PSpWsxs0ztA4t/U0dUSKZXY+QD9suaLnMoEprxVeuz2i1KUoDa?=
 =?us-ascii?Q?wRDBDnj4Z3Dz2IK4gYmIr8MeP9/AGb60nXnIAGUWRiNuQFp1JPwU58vD3Q+K?=
 =?us-ascii?Q?mBfm8uIdSYvxzmQ9CWb5LbAourhCfdVQ5IGc3Ci0ptXqaHooXCM1ecgDXEj2?=
 =?us-ascii?Q?EEwQSLgwra1B7bQVov3n48uyy40bKxYoUX/Mi7Jkd5fWPtdmhDo3WmzX06JS?=
 =?us-ascii?Q?A7XF9uuvEAfUm+wME38LZGTFbrcyDh9aN3ojE5C4ajOzqEHEh/9qe50wHY6q?=
 =?us-ascii?Q?9z91YVxDRrBL0kNsQhwdpsOjZ+0wUep3hR33h15kpZZz9QqWLJh1N+cZLM6o?=
 =?us-ascii?Q?c7LF314LQoOzSlXq+T6jmMYJQ34+LoIA3Oq572T1aG+go5alqhO0/DPTrC1b?=
 =?us-ascii?Q?OpybGHo1Tcgokcn5Q2oODkUhRNNavpId1+aWNbSy3dtJVf2NTQSuxnkRQf2h?=
 =?us-ascii?Q?Np5cqDPsZPhqGA9WurJqENJ2Ng2YNIT1nxkA5KWZur2NuXXJiKXLkgmve1/8?=
 =?us-ascii?Q?eResqkdMc8I7uB6Uu+0/Oz0Vqt72r8c9XJjFk+Ncnj5itpUhxDN6ghAyWJEz?=
 =?us-ascii?Q?5yg4PrZ5l97RiCKdcm8xhZ/t4Mo15ZiGVQGGrefY2L2bhhcNzA0TBjEsUMqu?=
 =?us-ascii?Q?kG6xj/UNuud48Vv1qpC5h3qpErlS4PmtS6LS3a1ucMdtidOckyOnIyi3bEXb?=
 =?us-ascii?Q?GSJwqSYoyIczOmfsE5X4QZkp1m2ols1eUIsBiufLCfWIeMmP66dwgPZ4Bxl9?=
 =?us-ascii?Q?ozvgrwj3lTjslUUUldCBkeah3LZMoSUO2yHrDIEzka1Vz21yAXOZ2c3j4I0a?=
 =?us-ascii?Q?St2p11eCgjtMdhxUc8UO9P5J9bt4Qi7i+auRMwrTMQ2Cp4OBn7p7C8pkzZ1g?=
 =?us-ascii?Q?a3zddEavelY0gcdKIST+xWt4UmJv1S8cmtAB2r89HamasjwqUTund78vlhXg?=
 =?us-ascii?Q?X3G73S4JQEzoKyq2M7ShSc22SvCaV8LwZv5PeEmmvKNkpWtGIpm0hDY/BhHd?=
 =?us-ascii?Q?Om7ZWk/dp7Q9lDev+debxaYh17bQDHwOSzxS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:14.2579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504f14f-389d-4aed-572d-08dd916f9e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

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


