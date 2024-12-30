Return-Path: <netdev+bounces-154588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96A9FEB25
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF93A2A3A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A3D1B393F;
	Mon, 30 Dec 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mABQkKxO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4C19DF41;
	Mon, 30 Dec 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595131; cv=fail; b=GidGZF1vH9+fRPceeKmAP+rVP4HSSnjRVBmqhDyXloMBfk3a7EEsr5ZDLCNTJ/6Q2v7E+6GrZZlyZSDv3C6nznHbn6vmup9mIZ2prb+zqXNcE4ssmvzJDFlB1f0tInoPdFe4iCim798V5TLc0lDlMgPxwACgMsF09vk7XTmujBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595131; c=relaxed/simple;
	bh=zLW338U1XDrW0KrPxVeQuKauxTaiXMKa+6CY63tljsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYqgCHumf/dSvAG2iyRRM0gns+syPvdrk10aCuZWkyVahwT0Xw2GLSsJn4Z7I1TdeQugWt7Z9tidZe2cBfcX0yUe+9Wk9K7KM0vSnJnHBedyiT1J7+MGYuvRU8PY6GB3Ev47CeifSW3n9oKVN3uADsMh+qoEvFKKJ9Gmu07II+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mABQkKxO; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqvOXacknYVbJytQUb0zYLezklygtuB/Vy+FKh/I2azMD/9DOnH5ZF2wEvptYrVZuy8u0Y5uu2pQ0Om1VPgc3sOo1puQ93nn9zyBbx/yq1Wnusah4Pwbm57Bap6hMU8LQSmGbXW1eCMnQMyfwwPm4wR7VBbnq/XKtfKzEVUURPmXkSNcYV7Tsdm2vAlSEB5pEPZ+YQma4JFzdGRZSIbWj+FogFwnPTSa/ieHFZxZwOCJl7BS/giLLvFJRUZHiAPvIoxTCgRhdo408MafGVPXMXu0OBotEDHr1zx0clUINGeNpjnc0XKZnzQLaD+zG09Qvb9ECzjV2OvpdHL2hThbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8fr/G2CTMvty6wUaxJQj6m3owmD34VQT4LtH5fTdsY=;
 b=i3cv+Le8oAneNUw+YGAOiJxEvmLKASTLb2AFiqMHzdqbMyxsBIE+iVSoSR4RT0lKFQ+ExThIIYzmqhCPyKAaaOsRYYOqynPUZqUSnFoXaEBI3ArSSgHzL1wSsXTldByMvrjBLRN2fQyOmogVYmnqxwStaZwCJhiAdSmth/P9OgGsiytRsZi/ufTPnLtL1lbZ7/a1JZ80HjMIt15bg0QweD6nb8iNEr8m/zIp1TIGBCu82J2mBlzoh1v0ByNdY5NRwTagg9eDZEEvXMbk8NZuz4LcwUHRcmQbfBRZo9AZbPjQF3ZFzU38WYJOdfTu83R0uA1MgUVoeztWJl/7DiHwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8fr/G2CTMvty6wUaxJQj6m3owmD34VQT4LtH5fTdsY=;
 b=mABQkKxO/6kRfIENN1Kwsd1TeHMGfS4N7mp0Z7Y9owlYC/GB2HI7RgMVQMbu1enGc5wWrykpFRbZPKo2E8YKNr8p+FSrhbZX7m4HlgcSuZdcyJiJdoG0vtiOgydFS/jlgZiwFzmlUSVouOlLcje2kshi7nWGZ93egw7kd//GqiU=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:21 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::63) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.10 via Frontend Transport; Mon,
 30 Dec 2024 21:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:19 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:18 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 18/27] sfc: get endpoint decoder
Date: Mon, 30 Dec 2024 21:44:36 +0000
Message-ID: <20241230214445.27602-19-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f32265-b9ac-426c-92e3-08dd291b423b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?svb52m7O0D7p/cOoWtLPyy7ify4xuEeMrcnAfrmiiHGoNf+I3IgC+Xy2dbG/?=
 =?us-ascii?Q?m642Lmh5z+P9rz97i6Af77FNX10L7l/43t3RhqCkkpPSZqvH5EgoMCeIsdMw?=
 =?us-ascii?Q?kiSPs07b1BSvblVPKx3GcjeswM5KB5SWTQsxADf3dp/MZG+3f1d8Tioz4ecL?=
 =?us-ascii?Q?R5AhHBgBVYCcvfJ1FGj3X0r14SMAMDCBGNKKy0OdpPZtsVCzhceniaxbtHUf?=
 =?us-ascii?Q?sGr9xZoOF+jyBMHBD45402bfw8qqHVx1jAbUYzFFmaPMoPN+rGQmE+GESnV4?=
 =?us-ascii?Q?c6MfaNOjdfuQHyDkju6A4WzhAHz9xyQqbkXn/DA2aQqrNi7LQv8dxl94gF6B?=
 =?us-ascii?Q?lNGH5n9ZZQcrWzu4cd9GhH9bE7cYY2j47ExTUDVI0NlVaLi8RDbGz6nb7r/2?=
 =?us-ascii?Q?dft812KDckpocNgOIqKdhlMAeH7t64CAvE598PSWHJ+8oEqt3o5/aYv/WgPv?=
 =?us-ascii?Q?TDXnTm/3+hOTyKOP597tQMTNRtQNTUjcs7BWVt0FLOKtMsWaJWFEwNLANgck?=
 =?us-ascii?Q?sUD1Ah5pzOTP9/99UhzP32W2ggapz1VcHTQE78XXUdECPbuty/dm04kgWC7S?=
 =?us-ascii?Q?QkiAkym/0yRXABwfxyJLu7j674e99P0iq11cP/Sk6qGPV6oYboL91z4LSm76?=
 =?us-ascii?Q?iqsItBEoct0iSa24OAJL9GgOxqTUezmYMA1Hn6+gH5XA95Ruul2e6ZxDk01D?=
 =?us-ascii?Q?ErLNQoJwEfaFlcnDK+RZ1Cc7U/X/SyePLGyMF8kAqBJSH0zhrqLFIMaGKR3W?=
 =?us-ascii?Q?fJ+fisnGZ/zwOAZp9CumE0ylGadQtVKEOIVtOaXtfryXqVvE09gOGTSFs7qV?=
 =?us-ascii?Q?GZq8guaIRCQ+bQvE/aSzONH8J7NsLYUJlRhsqE4MBggMOQCgsFpIJY2fMhyD?=
 =?us-ascii?Q?ct875Lxz5Hm6cXE1rprg1mW0pdc0E2HOttc/jgpuTJLCIQMWNXNWi/JdVvY5?=
 =?us-ascii?Q?EwkRR+rx8CvolJELWiGeaHJgECskV+6+rfi+IOhf55N8PhHu7frlA+A3EsSi?=
 =?us-ascii?Q?qFZAN5baz7iK4FYFrU85JLiIoo2RoQiPtqpMohhJPZ2L1lVifNvoQDr42Su7?=
 =?us-ascii?Q?KL+9cOv2oJHGGzxe78gKNS3ue2a1HajQx6Z2wBdC3KMS/puK4JNjHd8KvGiH?=
 =?us-ascii?Q?YDlxyPEnBEsfVZI5XAHisB3R7VSmY4u/8acmQOkHajluHXVyroEhTeLwK7x7?=
 =?us-ascii?Q?+3pCulCq5+62c8W+PTScnLbRNlazAZjG0Vzq0tFrPtmH+m/8RolkpBIZ5hKm?=
 =?us-ascii?Q?CZcfxVrjkj/ESPtdPNiztwo6Sdynbaewkj84w6jMxYtVkyP6+8MQxw1MRxHm?=
 =?us-ascii?Q?94UEHFvUarRoZTA9/Nl8sU4FQVr1Ks2//JIuUPIE5Mb5D+iH4ue1sgWp/aTK?=
 =?us-ascii?Q?cWdsxX1JkzbRmqU+fLgIqhCg1bE0UjhhgUszQw98JQCrtvo3G5zdAEfCQP80?=
 =?us-ascii?Q?YLpTGo0rb/egrln4vJFs+crVxPAuOxEZCJINAmh9WPHPXd3aNJy3s77EO+7X?=
 =?us-ascii?Q?ZA6+CyT6CVHngv8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:20.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f32265-b9ac-426c-92e3-08dd291b423b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9413552d559d..f8f48915d21a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -137,6 +145,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
-- 
2.17.1


