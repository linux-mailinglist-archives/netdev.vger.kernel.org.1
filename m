Return-Path: <netdev+bounces-183929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C21A92CAB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC394471AB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689C212D8A;
	Thu, 17 Apr 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UoIyGv3r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898A21B9FE;
	Thu, 17 Apr 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925406; cv=fail; b=ZxZ0cJZYtTW1AY3xG/GYAkQdCMjVKmiwT8ZcSqCoYEwrLwP06fUmabENRsO1VYBK8Y1R7xqWLZYo5oXzoNrjbuGUpM2j+XSX9o1G6jlHn7IKTrtUtBQX4F+Zq8p3d7KXItkzEG56f1201aEM70Ij7i0Rq/bH7ipV1OSjzPCsZpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925406; c=relaxed/simple;
	bh=ILHwymVoBX9B5A5uyhWMFhm35sl0uEDQgNtrFiINjVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUsoQ0ZBlwzm5VZo29fr723/DyL0USFhesq6SpY/4xQmjJmm/dqbIzbfikwNmPWJgk/vffZeCi9a09i49nY1d8LnIm0UYE+nxciThwuFze6xuwqWRjA4D/37YMRJiMdWM07PKEPYpX1BXZFd4j+tk/7OJz17o/bL0JMZtDKdIPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UoIyGv3r; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGSvw5cUIGolj6RTESk51EpiV4W442d66BUm8k24Lt1rBbgabFFnchjUCvT9f1a3vCinEHMjrQouMM+luR84fQf4TzVK9JLGHM5rvcZKLf91v4DRbieaaNxF5zKgLQgxJYuj9Zy0oiYhqU2dnZ89ISyKg2ke5Go1/1g/dWL6CwqauhNA2YOioWDYVZ5SGNTGL55ONHorqabnW9wSlJHcfP05Fdk3DwUrErQkHw2DPNW1JvM7lvo2u5ymDTvOsi+OxxgEApgGH+50Uh1GqIFmhs3rhjVUt8RslTLVwnlAl7FV3RZe6NtefBklqjmv/00s7/4YznP13BQrjIbera6bCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb7qsC3HwWYzhtKb8cc3p5K5nXl3qVBZ0HevteEjVlU=;
 b=pQux4OVPNRSGZoad/79X17SC1IUCbt0xaUUfSgM0zGakyXWM10ns/d0ce+NNBre97uHCUbHE1SlxbsVVsGqcwaLMOxMFsJkcsBxiRALL/Ock2dsV0xLZaMcKl06gtsf0CaD+vfmp3vgBAFhCeLsi/8aB7Jqy1ln5rtT6GrXbh71MJR/tjQUEWHOYSU+FA9Gp/qV0UdxH62LZ9/C7A02+vBpsjIPia/AgqkN+ESffZw00KOzS92nyMXFYcNDOmHb1V9G2sqgeQyqN96TZjtuCkDopozFvzWiNGqhJktojogsfbPKslK8GjPorj6Ub5VozME56Wrf/b+Dh+CtE7LNBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb7qsC3HwWYzhtKb8cc3p5K5nXl3qVBZ0HevteEjVlU=;
 b=UoIyGv3rLQrr7tP3p3JXZoJGCwQKdoTyb+5HF5qi6wiWCaKZl4UvUFdezaZsHzGOx3UC4CeGY+Q3s1SGBuLwAiNZ4Pcar7ShypjAwdv3d4Oj8q0+yBd5qDY7o/vZO61JbS12GBN7kMJjHve8l9uiXqQ9dXUZ5F9G1fkAU1zwxSQ=
Received: from PH0PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:e::13)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:58 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::54) by PH0PR07CA0038.outlook.office365.com
 (2603:10b6:510:e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:56 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:55 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 14/22] sfc: get endpoint decoder
Date: Thu, 17 Apr 2025 22:29:17 +0100
Message-ID: <20250417212926.1343268-15-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 087bee67-6a16-4e48-1bb3-08dd7df70062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8OjCLbD8GXQY5equJOgY4yZYyPRAYDD8K42ZBR+1i4xJp5iSByENkjRwqz9?=
 =?us-ascii?Q?NyrOFa/MX53ht4TzUJqe7e0GTrQDftZb0LfsikY4TUV0l312CHnFyj3dQ2Wt?=
 =?us-ascii?Q?EO5yA5utFsTfqq9TAeL/WQhHbw39ldzF8tbo8hcRdOYHp7ebJX1TLTr0afJJ?=
 =?us-ascii?Q?CBwWa0iBJ/6MDyd5UnLpNB+r/GeJLfojVcZ5NyJhxARA7cfiyor1A3wmcDbI?=
 =?us-ascii?Q?rXSbUmRqDJVUl1gpemba6ASMFyRVpemhvGDOIzGdzytRFZpB1EYe2mJEYnIW?=
 =?us-ascii?Q?aNMUDh5pfwQQ0hfYaO2+yfF5Px/TmpHFWK5pZw5QwJGrV0cl7ufvGTJ2cnUb?=
 =?us-ascii?Q?XbT/8QsId4Az0QKyhGdulVQxd0hCgaIxEz8mOmBGIWmv6bkZ8sQpYE1B9wHZ?=
 =?us-ascii?Q?gzXsfviuXDa9R4EvkmT0ktj1BwekBNlJpJE6i0fZ9wPaFBMlcu6WVtcIoXu/?=
 =?us-ascii?Q?EkSIyxX14AzD6floBdLamWfix/SJpd77TTDQTem3/r/YNVKy7JyGaSpm3Xq0?=
 =?us-ascii?Q?ZQ/UcdKc+IQ6nG0lFldWkYlfHSfe3kB7/IIxsb/dejeEV4uN/IGXr1vAa2WA?=
 =?us-ascii?Q?dM8W5as9Y+PhQf2/+OcXWqa2c+cz51tadjO7smsZnehcpk7kcj/TiRlWtsy0?=
 =?us-ascii?Q?ciKlZc4saMoO/YXM4B98E8FZxt5YGRlaX3pp3GMWUPeNXqicW0k6cRdYmOh+?=
 =?us-ascii?Q?3COObVhamVypYR5j3I+05hNz9bSOywxTRm9R3XDfy0TK8Qb6BoY5q/qXX6Oc?=
 =?us-ascii?Q?4lkZGLeGf29/5+WmONeGbbxIR3L3BteryVTIPa4ByH0T8FMXZ/j+umk015hY?=
 =?us-ascii?Q?TMMotJpOWK+t8wRS1gJqSKw4c+t23q4eFDjsdxS5A9bxholRTvx5HoBrjLX9?=
 =?us-ascii?Q?ksHNIT/EdoMAPjpPKtnwHsBbo7IgacTtWvhWPeFgr3LQ/T6oy42GehaAEOAG?=
 =?us-ascii?Q?PVIXk7yiJYlzhQwPY4bz016fcBFa+eZmnabbFKTXhjtX1XwTUUCGqEZ/QHKM?=
 =?us-ascii?Q?9E/0iSvfLyaQerIOrj/ief9uz5PEOqe5p3OMgkqhN1BXLEcvqaTjFruRqvIY?=
 =?us-ascii?Q?/roBr5Kp8p5BNS50xwOufxrIBoMjChHJLogLLLWfGVp5O2ZxRcJiSt5ER3Az?=
 =?us-ascii?Q?f48RcjHcbtz3flvKTcM1JQxrWXxU919gPXmtCyTe5Fjxike7BEArUiKmtegA?=
 =?us-ascii?Q?9OLmAlyswHOOvXWKRY2QlG1uL+zau8TOqYADreG+MvmyfqcEaela8G1uTTHS?=
 =?us-ascii?Q?DnC+x23/99mJeRNmuIu7Wv3SMzoczqtFyxnLIDn9qQjM3wCBHRCtaBaVh8tK?=
 =?us-ascii?Q?fAPDt+AW0a/xsq8Nmst0l8eH/Rs8buT4xWsZ3Zy8IUVegwKRSZc/eYWa1lIy?=
 =?us-ascii?Q?jvn7V3Xm3DJgy7MOkK87jzcduibzoVqm0FQhE3ZFwkyCKLjmIxXki4pGrxNV?=
 =?us-ascii?Q?nm8tcP7mCcN+hh27vcdouNHtAB1lCwyWQp6SCdd62Z65byt2GOxmEmVwZj0B?=
 =?us-ascii?Q?gqtvNYq+T7ZQGAF1wyCwI6FYzIun3UaEumgO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:57.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087bee67-6a16-4e48-1bb3-08dd7df70062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f08a9f43bd38..21c94391f687 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -99,18 +99,33 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		cxl_put_root_decoder(cxl->cxlrd);
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto sfc_put_decoder;
 	}
 
 	probe_data->cxl = cxl;
 
 	return 0;
+
+sfc_put_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


