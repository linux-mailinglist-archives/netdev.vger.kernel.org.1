Return-Path: <netdev+bounces-154593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172429FEB2A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6900B3A2B23
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CC219CD19;
	Mon, 30 Dec 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KqpqpUwD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483021B4246;
	Mon, 30 Dec 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595138; cv=fail; b=FSZH3WH38qA/IX57IuJYRp6K6iUmXfrLKpEnt4Ibmz/cG5j4KirjvRs3hiQ1wklUsREijREKnfFZdyxgtky4YBA86RgPBgwc2f3XUAj0MbjCZEfF4wagHAq0azhhE8zMuxLsTvbqVdwu10vQrvW3zlQWCqm8Z2Hg0V8ypa4xmPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595138; c=relaxed/simple;
	bh=wDaaJ41aHQ99IDp39Bj8qQ5Kw4mM2f4x59+JMwluQmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cm78kCreTGBZlY44pZHsVRvekD7XyTH3pExvR0TYTr1yxP1ybQRKXHcSb0QtIP2fNtvnpCKjDfVo/uBmTcSmf7FlJN4bA4m6NWOce8kKpC3M/2FKWanQR+KXl1Tc0YGpnezra8y5NF/w8nGh8ahJsQ4HMN357rSPQX7N3gfbUcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KqpqpUwD; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey+6sbMnZTYrrFuRaF8bhe+l5o0aq392n+I5TsQaRH85FP7DnNRU7zo1LGHP+djsfSWgjuIIWpRPb42bQPoTEfqEm30NPu+t32bNXMqP4mbm7OPGKkW3nemN2POBIn8MnYDgBzc6ENFDZDJqX+upw9frvc9c8Lw9j5a1Gjus90RtARQ3dnJ1v0NCsWOQNrFJAIsl4K0DAkTNQnLtKsantX897snUp8fPT1dZ49Bcug2UHEG4deX2B1I6fc1WOMMsVw50CYNYdgVlwNiLSIIWCzR9cBWhPsTlsXsMjdkmDCrJvXSfGGmuyspRFKLLUj9DDNoBWtFZ7dNnHrDnPQq2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+M4e6MxkAg+gslYT6JEnpkmqyRxqrfOwr+c8kciwOE=;
 b=R7P4JtFkFpHtPwMDuxc30qPTZ8/sT3efsKDqKQMnqAIdoGjGjo8h8Dmq8Z+g9tT+X3Z5xL8OcOPAc0rwvbUCmvwNHbBKfv+iyfq0oL1/Egh1QFjPc1PX7NjT8/9syF2sp8lsMuvpz70Zp9s/qSX/wppgD6Yto6XxBwpTfD+RmVBCfR/FkADNSqLAa70TDJvWaM45uuvXI4jOAPCocG0vfKTJ1pcnFCUWiR+f+D3YkICh8sYOFA11cABlKuq3v5OIbbZaMtngDYQraEjma/TRPDS12uZ1ZE0QNJPLlBozy4UKtN/aLbV3OxSYQxkmMzleRt3Lm4MsOrrx7FUzsQF+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+M4e6MxkAg+gslYT6JEnpkmqyRxqrfOwr+c8kciwOE=;
 b=KqpqpUwDZ3lMZmrS8rVer78XIk+7mxDvkj1qM7byqOZkRJPJ29cV5u5LU6Cdce6PD/pwK/aVZBJoGD7TsR2Mc91OYWVr10TigGcf+EoTfdZgFdYxyPJF0qH9tVZNrg1RDIpCo0CJqdrY1pHOSH4P7nfb1mMRQk7nC225RVEH7i8=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Mon, 30 Dec
 2024 21:45:28 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::77) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Mon,
 30 Dec 2024 21:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:27 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:26 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 24/27] sfc: create cxl region
Date: Mon, 30 Dec 2024 21:44:42 +0000
Message-ID: <20241230214445.27602-25-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ba102c-9424-4695-f166-08dd291b46c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Ls7sYKdonUPoszOqi6jjQuBqOZq5r/9XmRX1Wwinwu3H98In+cZdgN3uJpa?=
 =?us-ascii?Q?oXHmPT2aKzFndxaYjX1ECSBmKF4TdPmVtxzJhAIfIQpCEi8hS6lQlJjby+pm?=
 =?us-ascii?Q?CtfZM1Mr+v+U0bsVhyq1FHnxZ9lUgK2aP580MOaBmeB9hEQJvFjrYkIbUCaR?=
 =?us-ascii?Q?OBS5JstiXxmhshyUBsITT2edsXzs/mvorbWBHZJCcU6q9uFRaRw8dXLfu/1w?=
 =?us-ascii?Q?nRdlDUUea7w7oJbQaMDV2KjRQXqhiKBz6IEEJI6+hvZFzx2erdSk0OQ/Uq6f?=
 =?us-ascii?Q?dc1+q3UrNvcWWu8NzQT/F45CZE79xw/6LujU+QGG6W3XqjIRwrdDUyX7iCNJ?=
 =?us-ascii?Q?Hm0Buftx46nI/y4ovpKkfocnMPGi3wZ4nwfBRr2Gi5LqFqJ1ln/YwmniPil+?=
 =?us-ascii?Q?qXiPqOck6xR/YkJnU0Y/Ny8O4Pwetkdi+TtADqNMAf/1rjeQYiOJkQzhlMae?=
 =?us-ascii?Q?KaQEXOBnZPSxNhdAm9umujbcVZ+pwQdSizixMHEYag5akN1uKxOPp+5lDzSs?=
 =?us-ascii?Q?L+0YhjyGaxY6cFKxv7J2U7AifK3THNJy8YnFMrTRVSMoYz3kJM4IOmGv0dTl?=
 =?us-ascii?Q?MLGwBWdnjJ8tbjIPGMmBCZCdnczakNLqvms597eZulbF5i9ty0DRXkbg2X7m?=
 =?us-ascii?Q?tx6Hf+KTRpPPqz+TqrGFYRip3EfpeOtJm42ynSQNSJHEHoFGA2s4yVCWyGqv?=
 =?us-ascii?Q?G0VuRH5XAyOog1p1k4kX0C0gY18tcxkkqfGL5ioenq+2vqECkil61T6m/2wp?=
 =?us-ascii?Q?QfNSvf7EGsGTtpgtw1OhfszyTz+z++CdckLMt4xjidrtYLVXUsQooAk8TjcT?=
 =?us-ascii?Q?rMJilS/0H5WjKMXDrBtKbc8WKbi4/nXI+pqnJoWbE/vnanPu/FW0p3LZRwjF?=
 =?us-ascii?Q?sPJIzuC2KF2jhA3EzvjnibLay34vj8l49WwBY2NZBVeOcV9+4O2PxBpYx52R?=
 =?us-ascii?Q?r9qsN5gLa5IR18/syTcnHi0Tv51oz6lVE+aLPpaJzEeEtWW1KLga3Eue2QuX?=
 =?us-ascii?Q?9xXLyFoQ/9qNbHQ1OffKj5jKAqzOKRzEhwxqbBOB99Nzu3Wp3Sl/fPtZsBU9?=
 =?us-ascii?Q?OpvpZl9UJXCj8oyMCcSDdxzgwURi12gMFkAMXAdDYcx0mv79qThhsAqU+PgW?=
 =?us-ascii?Q?7jgBfbwHjonBOTIrUdwHTJBZ/mkE6LonB8YpRlxynoYC9o3/kfhTjexy8BWy?=
 =?us-ascii?Q?0BZ3xYbJ4VMbjhVRoGItP9e69gmWKthdCOZym0XV6uHZzJo2f1nN1OD1S2G7?=
 =?us-ascii?Q?Wrl81Wfj56Y/2cKz/k/pac/ryXWTXEQ8QSHApf1mzliuBul0E3qv4+k9Vgdq?=
 =?us-ascii?Q?srQXy5ck+4yh8cqbh6T24+hLajinVaNfOp8eToCUn17YKVVv3DCmsZnx03zC?=
 =?us-ascii?Q?Z0aLP6HTQnskHwLcRDcRX/FyD9YrMsAn/EZOM7cG3rz6cqJL+4RH1mn/blxu?=
 =?us-ascii?Q?AJUYfqvdtNYBGTxS/D4+wD1XrpVhfOYbrDPBTMtdy8FAHPwYDYNmU8knlb61?=
 =?us-ascii?Q?QUA5hRxA6Sq9NdI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:28.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ba102c-9424-4695-f166-08dd291b46c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

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
index f8f48915d21a..30d51dc94b43 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -129,10 +129,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
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
 err_memdev:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err_resource_set:
@@ -145,6 +154,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
-- 
2.17.1


