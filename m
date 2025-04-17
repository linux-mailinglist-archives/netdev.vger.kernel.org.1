Return-Path: <netdev+bounces-183933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A781EA92CB2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E31E189FA27
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264D5221F01;
	Thu, 17 Apr 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7nRQ4QM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86055221D87;
	Thu, 17 Apr 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925412; cv=fail; b=gCSPOOilrQKRyiQPYu9JCgL295mdcGD//31YRn1wppB83xCBg1q+Ari6kU8uOSGyLyxR9aF4MW0wIRmla+hSUrTI6lzfpaUwWkMVLRfLjpoo5/75S9o6guYCgqzlhDullA3VUkYyxAkn0XDBWrHuFi7dr9v8HpfMleIAZDSE/co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925412; c=relaxed/simple;
	bh=3ZEtjft/lDIX0aA3kgi14zsHzPvPrLZi3YpmSO9deuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dm5yMtSNLdwD6a4M5HsSAeb6Wi2O1KD1UMBamcnp5zNc4nyArbZBDyJOkIj8Z0XeITauGXS2tzs3UQxPmMywveQNnr/9K320btYUa1OIhPx1smcAbidj/4D2W1hvUCEAjgunzkqG+LgPVZ4pvKBqT8h+BxgBZw1Dds0uTzO81J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7nRQ4QM; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heaIfe7ixr/RIVBNvvsTtX52935ureaXf0aVr4/cQiFA4tZbffYCD/9jL3Sj0BsHoNmzgtwsOtjCj6Tey14e2/03bE4fANoo0ugfTFe+Np1z5EachhNR4jLzv5z3oNObO4DQi1TcolEIcLIu7FbjQ6ZDdCw14fbDm+TWSOA4f/It4bJH1iV1cR98Oj33gR0n2LLawGMlg8V9//IZxi2AwAyMPfWNxBFI8fApcPCTcMH1jdqoabCSkBmLg3MQtONLKuaXGiViTHILxHV95/sWCBPRBURdZTEqwJmV7iyDYTfr649hW+TZeCZKkRhiABJPgZBnLxnDTgtXpG3nM9GzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynfdElytJtuBZ3r1qvFAtdm4S8RXlZs4WJ6ScBSU3Fg=;
 b=YfFJEZ4IIry+NPEfJ31T8nR7PqgF424DTdf36FV5BfnOrS5EPHO/rGYXhxDewCiYaKe4OxhTvgzoPj/3Su5fSUltsPBjh5RhY0kTjNpz0xFJr5ECzxmtstK5AYISlbp4gZfBaroI5G6smx7dVCN6TBJ04qmemgWwApVkXbikdw1rGvMk1KQejTUb90KkE/7FvGplSF1GxFPljOZpnujQe7Fn/DL5FQDkNcMcv/2SVKIKg1HXhYRRYuZMpUoJl45DU6Pr/OdJ7y1icxPbv3yl4oqOZ6bGVkYaLRj12WbUjeFAfLZUZre9rr3uFJWFdV3+SIDDvudB9hCHHQ+ZgPbTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynfdElytJtuBZ3r1qvFAtdm4S8RXlZs4WJ6ScBSU3Fg=;
 b=a7nRQ4QMmSHkKgZ9S5J2/VMfWR8lweUNB+eDByvx1FRYkMzvdHThoC28hzfuYbH/G67/+Rs3M/QsXMe1lbaA2bH6+VdcczOhEW5WUtdm93FP+XqA79XChdJJ6GGHTlut2fp7nUXH1Yqfoe6sPn21PVDtDItrfeGzZymcnMbC9ZU=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.43; Thu, 17 Apr
 2025 21:30:07 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::3d) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Thu,
 17 Apr 2025 21:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:06 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:05 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 20/22] sfc: create cxl region
Date: Thu, 17 Apr 2025 22:29:23 +0100
Message-ID: <20250417212926.1343268-21-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b456286-ecbf-4fb4-d5ba-08dd7df70637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yxeiq7jubs6rMiuk3JILUq0QkshijD3aTx69YYaVvhe9RJggxHKKu0q0Al1u?=
 =?us-ascii?Q?+Voy/kKsWmpl0rIj2qAE3nEAiJgw/pQ4TjQfCLAdej8iosiPwinWSQF1dUNh?=
 =?us-ascii?Q?jR8yiRnJ1DT5vIIkJBoTi5Yvbb7EQslfht+n8dkbH+B4U/h3uPQNpPmv/tzT?=
 =?us-ascii?Q?pAcK+hZT9KWEltlRs8ddlKBw1yfIcNGzVVIeeI1uTNFVnM8ws9dn1offXTWj?=
 =?us-ascii?Q?Z0uvgiJyU8Wk4IFMCusVfWfLUTU9e8cp3XyfbOI3BU3Jqof9xzELtAyxuu/8?=
 =?us-ascii?Q?sxv4pM+bhCv2p6L+jwbsewhZyFp7EyHAX/drlQL81IPT0/b3u9qnGR6CU2sb?=
 =?us-ascii?Q?BuSQYrrhEsWUaV2Ft+VQImR9kHRUxrt4MWMvESP1VSvk33FJoBnPcicWsdR1?=
 =?us-ascii?Q?aRLOUoTsNB0OzK+PaU1U2pJDPrGxArhdtlZ32Li1g2QbFP0UC+3CHMTJnjqZ?=
 =?us-ascii?Q?tQyzVnL/OD1hfcXvdbRYKuruFswMn36dPq61XmdogfjwVbofF1GMwzQ4TcgV?=
 =?us-ascii?Q?AKok7v+l6/6A/93BVfXCdbjucu4c2XLzddM+oSUKpZtlXInidc0D66MJHNPU?=
 =?us-ascii?Q?u1k1gBOx7bsZ/jU4+9mWffuQjO0KVgJYBPUnaqdBveaRmg5i3YtbQ1lWdOMA?=
 =?us-ascii?Q?OW5kM7m9kGbcQwQSRmcI6HuOPRnD3YKw/El7zLKGn50F7cKAN1uUoVT/1ShZ?=
 =?us-ascii?Q?B39jv3VGKFbNq/tAlJoq0pvnNHAIHCZpQhmECuNfqI1NS4LscPg7vOs5AMZA?=
 =?us-ascii?Q?o7tdNYYt+XiWtzF5RCfjJ9yJgVFcT15Q+48lSi9YtaDLYxmkjhR1Q9Zg0S7c?=
 =?us-ascii?Q?16tupjYaU//VkpZ0sEALRK7l3bZdtsf88f/maJQgbGX1nVEk3fXgzdXXIWdN?=
 =?us-ascii?Q?1U70vw0+lyJwLFrVtQ/doWCm29ZomUDnkabTWdoROtuhst/We6NVW85DNZKn?=
 =?us-ascii?Q?lGppD8X1mWlBVolEpEhf7xV+pqqpO70V8s2aXOcpKLi0gbtV8gHCzqg5vIWW?=
 =?us-ascii?Q?WsRIg/6stDQkYGrME9MrMPsnihrujY/LKTfUfWnigwHCc05pUZ3zPNtkOgGS?=
 =?us-ascii?Q?mTba3pJHvkhUQcwJYhtKX1o6Fxm+XJSGG6sRJN1W0Tb68od2IVM82VuRRqeD?=
 =?us-ascii?Q?1RbPcxnWPKrdV9huyEuiXrHKQNpSnUeN3SGZcCK4CSyrfAnJG+UOTXPY3AyZ?=
 =?us-ascii?Q?wXnTbKwszvXbflunZ/HT8ygW25vZSDzPbGjfQ0LHqmP2/qIVF28uybmDm4yp?=
 =?us-ascii?Q?qGz5OLBf/zgt2mWKnwXfj33thFwagezIfoW39w2RamftEmspJTQgFmhanEWW?=
 =?us-ascii?Q?3sarHh8almglBR3cphePqF7l41glJx2nIrDbiQEpO9Z2dIV0k3g1qkwjpffj?=
 =?us-ascii?Q?E8qwgqIZ5KHxc62660bFWoBb9SZv7N/JikfAn6YZMQnBkG5V2MGEyMBH5Jzz?=
 =?us-ascii?Q?4vhiNtbX6Iy8vpJbbLq1s2G0ZluHawcrBTQbiLh+Rvh81CmO4uUIJ2Vs0s5L?=
 =?us-ascii?Q?k26C4DdcUV9qLSSLR2B+Ra3SFHCE+TVrKzgK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:07.0754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b456286-ecbf-4fb4-d5ba-08dd7df70637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range specifying no DAX device should be created.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 21c94391f687..4323f1243f7c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -111,10 +111,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto sfc_put_decoder;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 sfc_put_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 	return rc;
@@ -123,6 +132,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


