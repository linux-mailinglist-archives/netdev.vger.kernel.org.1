Return-Path: <netdev+bounces-224325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC7B83BEC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737E57BB827
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A63302753;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLzjVR1D"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761F3019C7;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187114; cv=fail; b=IxgFUkIGhtHb27AxcHpcnYNt7Xd6pbiSix+6UGnlH8BGBgXpbaq05m++OiJeOeXaYhuZFzyY4vqVEcptQHGJVQagBmsmEUxufD4qxRSz4tPx9EA5ucseEQ/JgJfABEkNTVQZvzFBFMOvDCViFYTjfmpYuZFXinstNh78S1q39Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187114; c=relaxed/simple;
	bh=mETjR+0Pd+snXlm5Pl+FKVMKooiG3H1yOKIPxw400Qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyuK8b1saaFpkmiGvVjARNMRGU1ypkUASyKyNpPIrdfHq0Bv847c0M8vnK5sqDEgZi+wbsB0WLW2e6DLZE7j3U2qy6ha+pZNMruO3aeEAI/DGsyGd7LIP9ytt+6xJUutElDsfWBR7UTk9UWl4s4yBu2C9z/XB6whSSWOUUGPG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLzjVR1D; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRkSD6dWZDBWe7NV2t7mj8/ciYkqGf6/+AUUwui30COLxyC/Q9ZNlp3ytgWi50mCOaq5aWjHL3BWgeeV7BoX/NivgasRCOhyOgfzNs4l+qV25ioUA3F1Zfp8etSjaKE3UwYTnqa3gceJjPkXwiLXgWhSTZn5kNknhV69C8V3nzwvL90i88SA3gO9TA5PmylqmjA03Jv3WQP0W3dt6BofQDnaTjbLNbae1aOichj803cyAQVNsx572HgEV+6nInYNP473bWphhQbmzOuDWs3J42b30RHX24GnD0RSDygXn8/0fi2rcMBP9zhUB0XB4CnES2bhWGgl77c6wOa1loDp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLJiW4k/FpXv6Ai6oFklr3ELVzyLrff+6j1n+1C0L1k=;
 b=OxD6TW2yCqtXureBKgvz8HYTJuerfWDYOMqcA298bcX0H8eEPqDDh5smg8xTByG+Mozq2QMFiiy8AvoUT7ORTe1TnZCih5rc1bPpI3iW7hYIRC+f1m99QRPakbSqBda5If/WXIkpkNdsNp51I77XrxBPhDhCEwGKnDzQ9NvtTFIrnHa3pJhB24ZC+yuXsEPGE4PWbQYk5dP5Wq6uMdZP6mqbi95gL+21ofg9yPySj9xCll3FD9fX1+7iDz66EMBVRZR4mP12W6QgYbTwo3Aq5EkL7Ijn6bPaiwj3ECZRaLdjCmiYbtYXmP4L+JmpcGC/z1ODBKO0MFsyt0ylQObewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLJiW4k/FpXv6Ai6oFklr3ELVzyLrff+6j1n+1C0L1k=;
 b=xLzjVR1D12kgygcg8QadGj591MKaB/1cY7SAqSSRrkcssOVJe+FreAmR9fb5KTahwqN4WDF+5OML3ODDqcpLPYskEYQrRCp5SpH+zoyRxHfiTglv7854J2pzLJvMgJYrEooM3pSvt2w/viTBy5nKcCDpJOOaDpKBzrSvu+ZhP4A=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:28 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5d) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:12 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:12 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:10 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 07/20] sfc: create type2 cxl memdev
Date: Thu, 18 Sep 2025 10:17:33 +0100
Message-ID: <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c1b69e-9433-4375-b78d-08ddf69453f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IQyKykX0sSdwVIM+5OIGXFI9pZJwKafKEVuMFFR2Bh1s1ea0f0SHquvP37L?=
 =?us-ascii?Q?uxiRgwZ3DOXCu/uhcx1FeqqDSF1zQKKZwMaDLsm3ZOCw7z8bEoo+gBJrucyk?=
 =?us-ascii?Q?jx2qfeg9Hb0svEVGeuGIsWZUAmZdL3Oj41cIgYOS20UGTQvoVLPPRx0bHLzq?=
 =?us-ascii?Q?C7GFZfJ4zJGlqvm0S+XnO2a0XlhWGluX2XHWy1Jw3Eg/246yZ6T/es0A+mhB?=
 =?us-ascii?Q?p3RMyIr0yIW1WtL1VwXbs7vza2a5BcB9Inwzr3Z+l21imHxTZRMKwCSuwUo3?=
 =?us-ascii?Q?hk1Hg9fQWI8zmMgVq9agQc2RXRAteq/15VdAsPGuWV7nrrvloKMFZ558UnsU?=
 =?us-ascii?Q?jQiYPqHAu+lslgWsYviy2sLgNJ2v+YswtCzZpvGr4leoGN5UB6XDk/f8a1Ya?=
 =?us-ascii?Q?+HfBxbD/By2OxuJlAG6bjyhL8ynObQriqxQtCJqcuISVhTpOxk3OK4mf8eIn?=
 =?us-ascii?Q?7XfUZp+Psnu2HsdVzi8Y3VOFfk5xCKxxFgd0lYMcNvUoDRb2QpcGlDFa6jeE?=
 =?us-ascii?Q?N6rKXw9I1rlbbfzvnJyffDiXNDnorxmhO5QOoG5bEt3PAu3YfqS3tZdTaCZG?=
 =?us-ascii?Q?5VKz5LQma60eZLxpNMr9oeIVhDVtl6l4+fqrYZhrsKU7aV38ZZdK7axQZh9e?=
 =?us-ascii?Q?5IaXEVxVyAimO4ewMfUE6cI7Xa8y4ViAvh+d1+abng2gR5roFq2+JI/Vf0sP?=
 =?us-ascii?Q?Lk4L/ND6gFp8JdyWkxDaLfc1Tdu9Ic6qWRr638Ov2ciIjriIePOcpCQXS5N9?=
 =?us-ascii?Q?uKMTO/raoV3GvoYuHQtV9oLGMjTSk6fXMQUxgoZFDCn7rZujZZitgobezDZe?=
 =?us-ascii?Q?9vUZ7bc1nz5/YdrV2CfQzXyfPRqNq2yb7XJvX37evOUgqdigAe3MIUIoWl7A?=
 =?us-ascii?Q?P0e9i7zg1+9BtfxWD4XI9ZnsVDYMqM23hbQy8vtrGxiDE9QSxEi3NOZUlgq6?=
 =?us-ascii?Q?G+HX8KiyT4nVC6wD6hQh4jzPoo6aFI4R6gJtmM19WvOPntBtc0cCPYEW4zJB?=
 =?us-ascii?Q?Oz4S3GNkfnvL2eMAiV+5cASJQJly3uWP0rNLmjaR6VSw2vQsOkZRQMOFMEhi?=
 =?us-ascii?Q?j6rEEGi0AL53swngjHPnLueoVYIy5DXDV+ldIUHe6oDIf9JvQF0VlpsdGv2/?=
 =?us-ascii?Q?tl+YzYR36Zy7lW362460iTudX+0vYRYhXCyT1I/vgpIz0vNZMoRdGgyjj+Xz?=
 =?us-ascii?Q?Vodou1wPO1m0I4wQetYojuFzWaIb/QG0+HshlTzQllaWqTcyIm6O6aSIy45l?=
 =?us-ascii?Q?cJYmO6JFloSSruPkTtkD3z2BwKo21LmmkMdCvsHFiMpRKpitnBnCmmfVPFc+?=
 =?us-ascii?Q?2/jbS9mCVUz8GrwldW3eMprE8ibpUCxmrP8wjhp+C7JgyrhFOFku7GyXuj2+?=
 =?us-ascii?Q?VAYTjberA0WmfsEWn8Uy87J5JZnglIIWDEj8TVQP+fxh/wc/SwmBgIn90gAD?=
 =?us-ascii?Q?RidffO0dvabXMqXy/+Xs6MP6QEZGKH/R5cx2xyQtPnXZxFlBWpJ3cpZbIobP?=
 =?us-ascii?Q?+WSDpsCkvqXKly90SC3tc+nKwoObnfE2gv0a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:27.9742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c1b69e-9433-4375-b78d-08ddf69453f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 651d26aa68dc..177c60b269d6 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -82,6 +82,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return dev_err_probe(&pci_dev->dev, -ENODEV,
 				     "dpa capacity setup failed\n");
 
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


