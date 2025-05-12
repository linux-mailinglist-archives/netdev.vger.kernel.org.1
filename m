Return-Path: <netdev+bounces-189820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17228AB3D2D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72ED5188513E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D767F2550C4;
	Mon, 12 May 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ErVQiXV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384722505CD;
	Mon, 12 May 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066285; cv=fail; b=BKG9ynkXafQ3IMYfgS8/3bH9B1fVjTEP7hFvEDlQZJCGi2AkAMK9wO5kwwA5N7UssT7Y2I4NQG3MCLupK/Zl00z9xOIxqQ6kAyf8KGAHcfzfXO8crM0WuMkOa3Zyg5eRCWX6P2qEjKaB6eWQckDkHq7IYgcpqmockre4Mo3tgww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066285; c=relaxed/simple;
	bh=dDZWoEKfo8atxw31+Z/CqXZDjSXbTnzQF3yZBRPa4uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWHedPGN5ZgibC9Pd5JEe85+ojDYWXbvJ6OqcloNM+djkRaQosu4pmvhXtLr2U2jQ9vXoQ8423VTjFDmpnkOZvU3q/wulu9aU72dxpU2MCg2KHN53tY8bweFvSkNF4WTtmZjhcA+bWbxS7H5lMRt2xa8UQWRtrd+XjX3DUaO7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ErVQiXV; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvxiL59JrykXABWKJp31S4cmK2ZIOLdHOhVA7KgKHG3Sgy936C1PCsxAkv6dw0gObJptTHaw+gb78f07W3jJZgOcw+KMDLGuYUAL3SX+942YSVPvJt6gJ30ryTXMKWEx+VMZjuJkIlyRV0lbf5suN4HUXHhpvt7fpKNFZNAPZAkNiRbAoPZMIC648RE21gEdmM+nG4Msm/4shehCfc+ZBlxeB+PhuAZPG7OZRTj5zCTBq50gimCdqUBwq1uwyLCZaZlO0XN6sB22kNXF2mmRtxCOPXYpyhctiziY4Gh5M2P62AhzKtPdyloC8MeRIH+WT/NCYmC1BlyMneXBBOloAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tRD1acARPPvv/XFRre46ALnvzaR7/EDOJznD0ZSn10=;
 b=obE8qRL2to6WoRnr8CT/F1CGIcUIy8BdzN6cMe6HVMN8YCnFn2sLqxWM6yvsj3jvf4rdvGZNziV72ngceXs0CABVzW73XM5LPOEXowQOnJ6YJTejHq6X2zeEvBoW+fiTC5Zg2wB+OeDCtXbwu2Dj1WaInNocKTQnGbIC7a7IxtAker+A7+jeMCF4M8Yp4woRGZTGGvS8+yQ+WzI2+HzVbet4SEo47o2voAStXEPabgD1q8oEE2Yak2wca6NN2MgZvDPQeVy/bwEdWx5Orn7HSuuCUKgB+rh2DBi4m3W4M0QbqCiCNei/JVrJuX7dSJaHHjkIKvP8UTtuY+PceT9iuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tRD1acARPPvv/XFRre46ALnvzaR7/EDOJznD0ZSn10=;
 b=5ErVQiXVJKN2Pze1kPKK3LGZj0o6O44kQFLCyhzEmIOHm1J+9nH2ZA2pFer/C0XIqNvOz7E3ne6V1jEXUG5J+nUUZfF26gzVTDFWZU/mIVGp/gKBelxAWwZOzNh/Kb8wAHG8ztRDK/8+YIbM7PNFXnJiroYnzIIm9ni0HMiqG0E=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:21 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::a8) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 16:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:20 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:18 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 10/22] sfc: create type2 cxl memdev
Date: Mon, 12 May 2025 17:10:43 +0100
Message-ID: <20250512161055.4100442-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: a948f757-228d-4e10-3876-08dd916fa261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNlFgAm65y8MlvfGXYOh0LXS6D3AZ8Mf2RJnFW3gRyKEI2kR9J+ZnC0hGkS9?=
 =?us-ascii?Q?p6VnY5mK/1O7QzhfHvUr7WtyaTDWa2+iuXarA/nmjKMEK5BlM6vdBTGIHqxx?=
 =?us-ascii?Q?5DTz6wUSSt/FCbBHStO7tNQKrndKaLaBfOUGFR1c3Wgh8FvC6pS/4VsnpDpu?=
 =?us-ascii?Q?W9xOMKbchbOiAI1bxoWNQ9CkIMPrs4ybW2RLBfdB5jnP7XhqYBBuegWdGDTI?=
 =?us-ascii?Q?JjMkHxrkmyERKd5h2ts70X+/i/KM28GfNXHr3dyX/i1CPVIxsoHtPFLEUi4Q?=
 =?us-ascii?Q?uQrpzIz4JvEB01OZQ0qGyqyMOm8YvY/UOtvohITHJdMSHsFVZA3M/wpYv3Tk?=
 =?us-ascii?Q?01p0S2wmmWX5JrezbeidJsurbZdn4zfBvR5vISbt65130dGibm1wrvrcfErn?=
 =?us-ascii?Q?oYa34/dpvgnW/TEC9v1GNLUw3qNkmoCO8+5qFJCiC6UuvsyK0TYT5bevXn1u?=
 =?us-ascii?Q?h/mt2s0SztzhDSFEGp3U5+0fP3a6bdYuU/P+llsMNUhm5/yUb/6H9E7Niv/U?=
 =?us-ascii?Q?UiN/mevjBGU2ngcQn0xYmozDzqShEx17wLPMTqkJDcwnbu+oggNERU6JlqEC?=
 =?us-ascii?Q?lJ6e6v25FB4nVZmNZZc/2aN11xm0QPcYPDJDMayMR0XnJeDAEB8yUo8eRm2C?=
 =?us-ascii?Q?d2i3Qo3o2Dpoc2DXmtSIfVFucto1wNT0iP6H7tFFtdptJEk9B667AavFvsgf?=
 =?us-ascii?Q?wbQCv2BMaGwpDxQt5ppp26179ANsZ4ph7KqSk5O8/PsXAO/dhsWyK04S4eSt?=
 =?us-ascii?Q?9SHKDfulkdhzfne9jGpO3gtBq3+pvOJlPWZMHZBVXy1JTFYwH8zvEV3JjfmA?=
 =?us-ascii?Q?wPYCQDMhoDfZfHy/GUSZRF3WGGjPKuA6U6QqKtc7rHTnjvk5+sxY0gP69rqz?=
 =?us-ascii?Q?FKWuT5pQQKwWbmoUEAKvpN/wkkBVswUoUBmr3aqgFjAVMIfOqAsNrV/ImjbB?=
 =?us-ascii?Q?4275ABRb/PyLOOV2exIAgz2ccSj7dwOaW01lW+my410gffADaWK5EAf2iGjJ?=
 =?us-ascii?Q?TAW9zAKXF/+EBS3sE6hJ+PT8WNUU53Fmd+9W+6F8FQA7aZmcsRhhOF9PbKC3?=
 =?us-ascii?Q?Rw5Tc4RtLtY1PrUfKdOziyCHLiYebK6xWSCcKKCHwWWFzg/PgzCbmqx+3SNJ?=
 =?us-ascii?Q?2fhVzbwqmIcycxUf4W98bmjiCrlb7Fq0L4Eao2EpJAK0rQUfLuQOf2ZZBi8e?=
 =?us-ascii?Q?4iAvIiYecRT/AJWFMkdlVEuTEenj+Kd5l4nGxcsZ+PdKVEcsKhpdcGyvaU4V?=
 =?us-ascii?Q?Au4w38CtV3pxBl12gc8q5AxLKjju59xoye8ffFOyID8nFZPpYfhd78NveqR1?=
 =?us-ascii?Q?kF08WZztPCbGjqiiSUwxiL4zzFcdgs3nyF81vKIIo/yHs3Fsbt8AG7NqG6Hy?=
 =?us-ascii?Q?w3LYCGuJim8VeuHv9O3EYhjdPmXLgnZ6WC8g/ozM2v05YQMglUBtZUjrlN2i?=
 =?us-ascii?Q?1NOaIw+NFoSvtzgPAFGJLQ1LW6UDwCM0UPGpu1lsK8NsDQ3KVHorcCqNyTEj?=
 =?us-ascii?Q?eEJKrOkRLW74Pq/yDi2dBvhabd+7Gxd/mgD8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:20.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a948f757-228d-4e10-3876-08dd916fa261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index e8bfaf7641e4..04a65dd130a4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -78,6 +78,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (rc)
 		return rc;
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


