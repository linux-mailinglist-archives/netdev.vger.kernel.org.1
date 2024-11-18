Return-Path: <netdev+bounces-145948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2C9D159C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60981F22A0E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511131BF80C;
	Mon, 18 Nov 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v4a+16pY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7A1BD4E1;
	Mon, 18 Nov 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948311; cv=fail; b=BI+RuXKAoW6iZ7eKliGRzdqc2SUM71CqTvUTmwUJnSjEtV2wdwIL9dR287VbAy54E3eKL0rj6L0EXxJLiCdi90Is2wEj3viYvL3fWaIWRTtkSmdGAbpmjvCrOEEhcu0gDgT14T8DoweU2fHpZfZRZSgRDxWJKyBJSwBgfdBnojQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948311; c=relaxed/simple;
	bh=BlbPP/6ruWsGhS7lq7xyuWy+Tlg8H/oDopFgc80f3HY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI71gs2nTrExSCXlwFd+yI/QpXYdEtOqBwy5wrXeS9Cdy2GcUdu7pn+3h6q3YBfX5sC/p1EiDG7ZMVzfvK8G+v7Ee20mdH3E7EHpj5crL+1+U7TI4bzsKvzEDQFTWPeX1pnxKjiKJlPq5f3+p0P1CTXXMgPUfFHCyahlI1jaSgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v4a+16pY; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz91HLjl72NSUaEb29dRI3uY5cGY0rxglMGNUZ5n2lFQH0b0HkQbPjscXYL3TkMXs5kLbyJDt2iWcBKYCaO1899+55GMZs080ESsN8kP6+flEb74gRkrhmxdRlw4ebw7E1acSsZE2X58Pd+SiOMD91Q+3Om7edh7FW7eOXSg5aE/4KyHHzEto2DEOFaSCQiE2M6IfpIcv3fCD/6oWm6GLDIu9xz94f58KIQkuI8w1Bw9i7CkxxZMoCt9xrHGjMZGCPlQXnnrpLB7FbLckDedkFBNKJQf0z/8s1XpvYBNgrLcxEQTsB8N9m2TuUENFxWUw2C8dhYfXF9p0se1ldTKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aak2KCl1dryw5eYBlwRVzFdz5B1kvdjoNW4T7tk3eYQ=;
 b=DhCOFUE1nFTMZaRB752uDYgFIAUGZPH+dktxc9Vn9s1Qj1S6Sqx8iwxRv2sYrR9RcqHQTK9E0/Y1L6MlsJkr9+P70GJzyifMxBO8JxzEwBWZCrBbKDwII5sRcWrtAVUO3XzeRUDl5OPJw7rjEbSSMBr+zUA41rC7F6TwKMHff4Q9BDHp8zwh7BdD27hQcM+vS0xpGs4KtOCgdadJB66dBEwWcH1A1rtPL2e9uQ+SCXK/7+QTtBX15rHSXCCXkOYegcTbN3JjhWv+z/y6DKk9GtXU+kUb61RoVXQ5avwR2E18nC8Atu8mevJGSED/Bw/WCS6xKSGNiIa2CFgnOfBtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aak2KCl1dryw5eYBlwRVzFdz5B1kvdjoNW4T7tk3eYQ=;
 b=v4a+16pYG0H0vBe7E8hKeoRKagnjjAFW0KWog66VHR/eJsmHpcFEdv/56UWVAK5ikgaDjhzMXRCN0zH4b9KHs7Qz66kDwMp3ByjCDwFLSITN6vCvfC+rpRa/CyqAYl4JSZsfOMxA2WdPr7jtPHhGxrLsZ19WY9kCfuHOaRe7W5U=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Mon, 18 Nov 2024 16:45:05 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::69) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:00 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:59 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 12/27] sfc: set cxl media ready
Date: Mon, 18 Nov 2024 16:44:19 +0000
Message-ID: <20241118164434.7551-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1852ed-a497-4812-5130-08dd07f05aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYfRW7YC1O9k5BnZnmTCqnjOCmiL/jze8SkzOT+UAHZ51Pg37NMAMmMFsuQR?=
 =?us-ascii?Q?5tEY9OK8JTE4+amwftMwOfA8iAf7jUzvwuuNDDXrYzRFJ3NiuK+urUklXg19?=
 =?us-ascii?Q?WpS4CMapc9zjIFimpJc155sg1DOBBpHzkO9LfqiecZJD5A1poUHF+IJ/GrOR?=
 =?us-ascii?Q?c0Ia8YLvO455bM1Y1CrtT6jIU1LT2DADs0WkmesP4k5IPeFgbMsDltMrybrS?=
 =?us-ascii?Q?db/bI2VjX8ldoNepYILB9ImiSwvq1/ezEywbvO1DBm0WRYp15cxnOLzYn3Jb?=
 =?us-ascii?Q?sYXTvHixfAlBVI8OqhzX+zfq5TSw8uqPugQ+Kwzh7v8RSFRDSIbPF373Zu/S?=
 =?us-ascii?Q?qDJDLoabfeFsCFPbGtCG7MQITJNZ3/op8ymbYCQ/rxYdYBKl2/1VEGGvJIdh?=
 =?us-ascii?Q?oLCW94BhiUZZYFp+BrqzN0d3EraVGBWbCyFtBlDKtRNxp5DiuG4NFl0WOJiX?=
 =?us-ascii?Q?0sXmntLdYgx03Luyo8xmGsiU/qbHV837HQrtfQuWAwsLwLaudWDMPRFU/53z?=
 =?us-ascii?Q?olPz8zitSL7stHJuE2Z2He6jZtXkblungtNadn325/qioxHDC3sxrCo463II?=
 =?us-ascii?Q?2XVEZXJdMfkDpMAaWj/22xRs/+0a8mcpCP0JGcDhK84SquPo38vuUKMGW3qx?=
 =?us-ascii?Q?TiRDRJjMB6LHJrrzf7QDhyry7vWQVpzQQ+pBTrbtfgozzMVk39eQ9kpV9wFi?=
 =?us-ascii?Q?QhDsmtAC7H56+eM2Ua3nF30yTT6lhaYP5Rq52TOqnwIJKIm7u1bKUXStfkRf?=
 =?us-ascii?Q?Ujp6xIv7y+hEsI2VdlojpkF8SkmOiohN+UAgZFZTHKy9BJhekpdlXrwUOqYd?=
 =?us-ascii?Q?kHGSdEcBrx7eWNIa0we9cEBUkzp+xrLBpnyWehdkRVaYPUrRghgOYmx+HVuF?=
 =?us-ascii?Q?AW59+7KOfi3v/vlvpafQEDAqlq3tzutWoP9qdFNOglStooz2I35w6veDgrJT?=
 =?us-ascii?Q?R3iTYM0G1MxvEuQTu0HJAB2XiOildmfCYufX/yBov2fs1KqqMvqDG1TwOPTe?=
 =?us-ascii?Q?OiKCjW8Zy8Ze+ygkDEsTf8Ib3ZK90xJhVqQBrRXjgC0XGPWfA/7Pwz/YXsXd?=
 =?us-ascii?Q?aE2sQDt73RBKFW9t97MC1w1VA4lY8SiaM0vz1u6FejfsrkUV63YWSvLGmOwc?=
 =?us-ascii?Q?08KuO8ak5k98K81zRISkvnEPvjviGb0DI3X2BaWVLHgPpVWfMCkbzjb+kyqw?=
 =?us-ascii?Q?4W07/yr5p+GT9h7Cr2DlaMDXbnqxHllDQTRPVzQkxZ0rb2GPkLxCM4PJjoxU?=
 =?us-ascii?Q?yQTGK7R0xTpq9sLHX17ooq31sUfeDjhgoAVcOnodllPPB+c+64ytvyETjTvq?=
 =?us-ascii?Q?AOXPeIS4y0Kq73+cjCcoss0Nz7Rkp6Rl9T2GOzdHD3uafL/yEB415Bxo7ymE?=
 =?us-ascii?Q?5SSFN1+bde4IbK2mTArO9C6otqyLhbFa4mnSXrrq3CGrtroDow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:05.0485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1852ed-a497-4812-5130-08dd07f05aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 06a1cc752d55..9f862fc5ebfa 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -90,6 +90,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlds);
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


