Return-Path: <netdev+bounces-190432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1101AB6CAF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A95119E84B7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B727F737;
	Wed, 14 May 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGQjHT3M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899427A92F;
	Wed, 14 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229310; cv=fail; b=noGwr4zGTxeWKN5McNKHQL0w/AsDwkxlSeHPbYflPdXoh3pEuwfvOUTfE1UTycjTAhnxFR6J071y0RgkCGJ1Y6VwCqXdwiuI4GJUvecbDPX3E+wAfXGxc2n5FUxYhU97p3J+0KNvy8Pjit3SBIIUC1RUxfZRcDrn+7KfOABu3F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229310; c=relaxed/simple;
	bh=7ULgXFNSW5w/K47acGUPlGwNBRTe/oL+NkpAqUJFeBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa0shfVAj6pxKIOykrPiaKwLz3Avzmtqsiz6OzP9hEBFPne/22xrmvf3HCwQmRApV43RXzpu0pK2LL+Jx+R48+/CIWeLRmS3dIu9x1tnxfi8x9uIIIkiMq1C8EmFmks2Jvakw0++Q39ngh6Tcwwcn1BTjrxXhgvN4vsRF3q26Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GGQjHT3M; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJLC1HlyaFnv+rdi2e6AcVgAnSmhVACesAmBos8pa8Iv9wdL+bkCQqGS3UdSOAw21Fv3ntE/II6heY8E0DXkJcNsnuxBDSgNQlKrc25nvTIqeR6FlAXmvyjqsHzLaJyrsSgo4owc6eE7PLOaaAKJaJkk//vsvWYnu2R9C21wiYwjzjdi9hOiK3v31BRNNORXG1arvEnBwUbiVXHqqeCUM0ipeiVcTmypzc3ByTxYnD9jZuosT23LY2Y8wgA7ndHiD/Y/lwvbE4GavyHd1/xq052otKdOXcM/fdf/8mkq+oPwB7muTYbzZHXFHuHkB379mpdHAvivmzJ/26nQGROSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXtZPfCZvjjUJ/23M9s/uMVKwrHBR7Pz2sby06ynru4=;
 b=jgsF2RzdslTADEd2FevnRXE0gy27h97fet+2DepZCGG01i3WiZNMrIqdKo+J/QKxcmE5BnQroAbCqXlEvUQE+c9KK5GhdCsMwi5GUwq9OXVmhzC24KqdVOo1j3HAJuGC6TwbtkYajXuNxKexCv6UASpFppnuJlr7Y1OaROwS3kbCPCg75Bmw1DV8DBjep6ovD5lo80+mrvablrsGtfcOeu2Bx76vpPtFTj/ZYFjtQbpx4x1QK0Eqb63x2yaVlC8Sum10Yyfa00lnBeiQkiXK/aEeDafQW9Du5Kv59acIEeOvJ8lgnpjEteWk9xUMoxxYcKpISbz0UIeBDitK7sXqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXtZPfCZvjjUJ/23M9s/uMVKwrHBR7Pz2sby06ynru4=;
 b=GGQjHT3MVQQJb7kWgBFBuJLBnf5i5iJ/hTe3fhI5Bd2v2L7UJnYknPe4uTN3HstCSMPzxnstQn8x4P/rgl2aYalpBMVXsU+UOtFu+ZKg6yuBfCPVROrlsswkIDlXNQpYmPIDUQmU/vQDZn43xsFKpc3R7UM5CHDhZWA7rf0uJr4=
Received: from CH5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610:1f0::22)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 13:28:27 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7c) by CH5PR05CA0010.outlook.office365.com
 (2603:10b6:610:1f0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.15 via Frontend Transport; Wed,
 14 May 2025 13:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:24 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 20/22] sfc: create cxl region
Date: Wed, 14 May 2025 14:27:41 +0100
Message-ID: <20250514132743.523469-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be92d6-7c08-4e77-a03d-08dd92eb358e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X98Gvjh9AhgBGz6k/VXqm8nVXiPrrKV+aPMEhOybb//GYpxM3qJgAgjYPg0L?=
 =?us-ascii?Q?S1y7eF6C7UEU6Oji0I4FvhGkVOXJNYTKNKTAfRXxfvNSpGuxkixtegNE+Lfv?=
 =?us-ascii?Q?dzN3kOAcxn65d5TvNGnW3Jqab5yjNOwVhH8Q7SO1D1RaOz1CVm+uyZTy6a++?=
 =?us-ascii?Q?IKgYPFIJirFYr9SdrEfzuDTLNfl9aF6QtHaDmiVJSX3nV1JNF9M6TZKMnYcm?=
 =?us-ascii?Q?NICNFcN/pi3lYn9JI4aupOpF0h322rDcmAr9eWrZw8cE/G4jVqSoXxvusXDg?=
 =?us-ascii?Q?XEf8HH3Ow+JXZLpbKMmg+88f4riuSWEriH50XA5i8/UDR8hQm+QinNPvyv+2?=
 =?us-ascii?Q?o8UhwrS9IWnmRImKLTyLCx5bgBtN4CZw0ukryVb3CvNSuufKkvbCUt34WcKR?=
 =?us-ascii?Q?FiN+wmqw9aaxt5Pbwz9fbWcWmMWvzbYphTpOf2QCnR/JadZVlRgVCgX+IEkj?=
 =?us-ascii?Q?1h/Fo+yFHvGTUYODEIoGDK2aHY/99nORHgMmNhyFEBR8KNKMf3nYv4LKgd3s?=
 =?us-ascii?Q?6mH0W66pv2GNTPliu7rz+cOVJ1YrnqSrl7m0SBSh4yYEU072vCALMH9/97gJ?=
 =?us-ascii?Q?nT/lNFmr9wAZVmq2P8YFT8a0rqQm4YkdjEkbGv/K8RFjD+xwVFka9aurED1W?=
 =?us-ascii?Q?p2O7Mg3jiYwUA79opQFn7RmRDacllBLW3ErwcsRjeb8GV528PGLvsAiTot6L?=
 =?us-ascii?Q?O/vDrbHSjTgnAH3ki8FaQEDdWUENt4/Nf2RILBIbpAFhLooP9ubmZURD63O+?=
 =?us-ascii?Q?jYUd3UozqwiD2gOnX2K7Q0diK8z0VGI7MfohAS4YpnnDVy/ZXKXilqmYl7XJ?=
 =?us-ascii?Q?nUerbHxE35otOgR0AHtc7ZUUv2uW16c1dLgTCR2fUMgLlridKbapKvFuyaNV?=
 =?us-ascii?Q?HZTtRxAbpCASRmvimsTNeApZIqOB1u+KPmd4O+LOV1vuTGpyYlJ3oy2n9ZJ/?=
 =?us-ascii?Q?q3FFtHncDKUwtgrUuZxub6Y/YRvDeDr/weQsUxrrMgvH77L8wdGUwWnyDD+N?=
 =?us-ascii?Q?u8xjlk2gYr5Et1nLT3lp0kNjnU0Oz+BWxcWpBr2CCu//wnKkEmeVAV9g0AuD?=
 =?us-ascii?Q?PC14inthH4HyDUMK0qa+wdjT2lFWW08ymPbrCVQUXNgOL4kQ54EPZc/IWaJ/?=
 =?us-ascii?Q?/XFJILjnzXbNBvgJ6ZasH7z+ue1TEe4nw9PnbD1t35Xz93J2Xdklbjek1P8I?=
 =?us-ascii?Q?agTVX3nfmTNrZgeyMuo/Xgh27v5aTidaU191Kg4wTIgztD/sDr0aZ5tOjT6V?=
 =?us-ascii?Q?0Jlp+yfug6ZnYFVHDrEzn4Ii6vGup6BLhzLNRQH7KqeYYyHQC4uKiRbE/2OT?=
 =?us-ascii?Q?ohgcbvtZI3wCkT1d5mOauQhd4fTsWh4Rz/hims75rxz4ubj9DQ6HEAnyuyCX?=
 =?us-ascii?Q?PkDRTHUirsGIxL1yl5WhVCeLYONcBRMc+ZKQh/56P9DDAwcl4aJDdnzwTzEJ?=
 =?us-ascii?Q?/yxIxCnWywi6k4aUXuh3nXroDNuPZBzPT2titsvi8NGpo2OYt1pGoFSvJLDn?=
 =?us-ascii?Q?BkDJcwjk/911eKerpbw+0w3Ckw0l+Wj0Zsxe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:26.9458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be92d6-7c08-4e77-a03d-08dd92eb358e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

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
index 20db9aa382ec..960293a04ed3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -110,10 +110,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
@@ -122,6 +131,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


