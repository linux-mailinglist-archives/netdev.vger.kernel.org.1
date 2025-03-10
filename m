Return-Path: <netdev+bounces-173667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA6A5A58A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA97E174866
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DC1E5B8B;
	Mon, 10 Mar 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y6PlxA1U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8B1E0DDC;
	Mon, 10 Mar 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640656; cv=fail; b=q3y3/9cxabdHXMUKjPQIqPcgcwePWhgxu5sTaP4ahH719oll7P+l2cM8peS+T8iVMjdgxOcsvXtFa5fWUafkgiMqeQ1l+wMQz3zNosRskV4V1oBXABjxxokSygHki3P4Jyl4cneVtJu1Yt0vrzhZBhvAuL5/A5kfZW9rDUcT7B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640656; c=relaxed/simple;
	bh=/egkf8xV7s7QZ9lCEVWLtuCrODoZnMiNJ3Q7mWClNQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWJk0V2d0FwY6txpNXblIGShCtiyov9qmsdzKQ0wYgD8YEedub1jEN2Fz+bJc5gkmJKQ1XkCj4U7IE+NOiXLMAXs+pIbSArLFgwHL3icVQjkK5eQ9SmhAzeqLMaQwh7ER2gRGDp7w1Xxzlm4EGw3jJqoZvFVXdGNhNHJYsH/1bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y6PlxA1U; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ2UjeCKdoYVBpmDp4Yy/JywkgyWT/W9LZXZi44fQ+imMwvQHbY5lMFNGtiTAL3IyGErnikebLtP6ECTvw+flI3gjxLdi29g5820agNAw+NHwDAh7Dcl21ojqbyIbSq7zthLtY3ENmuufWFINYtn8ww+RkgL/AxtAUTlTIupC3IolnrIYDx/WmC197DZr4/qSjvx6mvWeQujaSCaldr8w4+FTLTCmBNOKOlqhgAvcu5tuvroKAkgX+HgrjfN0qHotWZPE45yyZTB1cTl0vU1nXGxQQ5dSNqrlqgxnGN6+oTL1Oei/Oy+5z5C/3zmg+ADspIdrXLMl1+Od9YhAWygPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFFo4rSAeX5RF7c5II4zzyw7kYosL6uCm8j5WDzSpOo=;
 b=TFodIAiRczCvZpB3y/pc0EFiWXBhN4OXtY4Ko+L05WRKmTdWaiqpwX09wWZvq8NPCnp9+WwuYByqZc/5afnU0GSbOrAqEFFBzm2cAbL0/GuygWUFp77ysB7Pz1i04kvFwFRuMFk3R8H/W+hGDgfbVfgvzEvcn5gLyZz2hsHo/A8yYlaQqUcU2kP8VzjQEe/NxC7HdnfctDRNrB9RYLEqboy5BDEdOQGOydzjentDA7nsNkQ4H09T3a5RwP71P8NoQyenlnza4h3nilAvTM+j5M2vD05S0eg8sQ5dqgubVk/7FxYJf2XxVU6pOoTzyOZ8H9GrQGgTXUSKTeaxjLZT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFFo4rSAeX5RF7c5II4zzyw7kYosL6uCm8j5WDzSpOo=;
 b=y6PlxA1U1YEMKypQQeXkTUyXs89MVQZ45TSzCGBA8vpM3rhLBLgZKxHXOByxQupoIQ+fbmuRI7ijgAGI1u4GGVgciDOozaGgY/+4t+1jnO0nDBMNBC0vWIM0pOtfmdepg6Rw+pklBtAiBfraqQuKiy+Twpeu13YlOEl8jwmkvaM=
Received: from CH2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:5a::25)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:11 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::7a) by CH2PR08CA0015.outlook.office365.com
 (2603:10b6:610:5a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:10 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:09 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 14/23] sfc: get endpoint decoder
Date: Mon, 10 Mar 2025 21:03:31 +0000
Message-ID: <20250310210340.3234884-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dbbb34-ea76-4770-5dd0-08dd60171b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jFkbPSC5VWaHOsXVeWkzIS5Gv6+10tIK9yhcZJDMZdF3OiMnBh6TeADHqGa8?=
 =?us-ascii?Q?wSJMZZNnoriKJvcZVspgZ13jPK8qQ6pXNCCWXC+M88jdUeBtX2gZkY+bKwK4?=
 =?us-ascii?Q?srqpUizqcTnmv/mUYb71aoZVrszwa33o7WkwUyntiA6nWaBZ71m8LeMo671M?=
 =?us-ascii?Q?jf7C6FXUwJk6BICG42yY7AS/oD+FTva/fwjC3DxszGdDwLnhQyeA+ZZjV9Wh?=
 =?us-ascii?Q?XiXZkqBOvMkhEx0n2huxeWdXMIViZmV8w5kowGKIXRXIWI2oKLkPNS7HsgbC?=
 =?us-ascii?Q?uDQzWvDqhY2la8vCPqazPITD14y8ns+PvNHU5ftWSDF1iStpl73SupJdTvMZ?=
 =?us-ascii?Q?Evt2Qt5VRUzhsU5pBRddcV3g/coL7nsEGF3D2ix9/Y1NCl3Dj0EdWvxLwzYh?=
 =?us-ascii?Q?vQRQUWa/aYBzzBrAW+OUc2k/fEjC0ApWYzxZm22y05tPMB/5vcqs45CWsbqJ?=
 =?us-ascii?Q?SUhFLz9zP9sqO3Aqp6MokHeJNkca6et6N8EOsEsrJ/BLaeRWt+Egat/d3O9N?=
 =?us-ascii?Q?4TjgWg+YxXcaDFst+Ks5Z2whMjLGkMqADWRh2W3yqU/royywzLOKv1rBFj06?=
 =?us-ascii?Q?ZB4+sR8s/+QvVE3ahosdSioRuLea7N4FTk+SKUcMXej6Vhib7mAlnh9i/LXb?=
 =?us-ascii?Q?h06u9iTt+LvK+0pOfyGPhf4xn0xyq0qb8vCbxabX/zR/1OyJt0omH3z2mIuU?=
 =?us-ascii?Q?PauOU8LgA/k59G2llLSOGUn5+zw1rZrbXpKTFroCToOfzO5U0MgP+y7wsyLd?=
 =?us-ascii?Q?cKl3PObqSAxo3aTu88HEXPp7REDVvvvrRE52g0BFo5ma707i7ylZp7fnc3Gh?=
 =?us-ascii?Q?Peo/ghx99ZoH0Lx4G1MVTMCb5aKsdvnU87G63eFsR98TAcXM8NhpOnyxBwXU?=
 =?us-ascii?Q?+B9cxIGCSFxeOClo0PT48XESzF04GQ9B8TONCOZim5cOfsnQwGP9+BWjLIrf?=
 =?us-ascii?Q?oVKliu/2UlqE9ZSDsD0Cf0mXCzKqpqfjUzT9/xy2ZjzhcTEqIY1jWvQ7uu3q?=
 =?us-ascii?Q?NMZ9r9aKenUteCMmhavpsHaZsbvHsIiocJUQDqtZtcKZ4Z0ylS3fVFwtnr9/?=
 =?us-ascii?Q?CjOGBNrwqYv9SXiMSea4d2gC7v6aT5HBoDrRdOwcZS+Bx9kj5+hwp5tHMR9b?=
 =?us-ascii?Q?QA0cOx0oQMF5UddlKh1gHeYrbQc7bRCs1Fq2fk3dv4GR4r940ljAwHpVJsmi?=
 =?us-ascii?Q?uwUXmPchSkcxoQgMsUN2p+zeXuf546iPnnHCN98hi9k3CzZrhu8X07gL9j8W?=
 =?us-ascii?Q?sQlPkyy5k/0GCqvVL1CI+/vYht/ky3/t5HcSsH9201gub31HEaE9eBjebVV9?=
 =?us-ascii?Q?HMRch4n8cIkNMLmSi7+moIZcsfe7pXxZAU9Qy5NRnV0FAHQOL8ADV90gU4Zp?=
 =?us-ascii?Q?KDdg+NXcxZcAE08/c1yZ3PjDBODvus88k1JG+J2hab8A28QO0qOVYd+6w8jk?=
 =?us-ascii?Q?x/8onPReF0UBBm+ub3+y+aqsaozckug+ye4UeY0d49aWzBAebsxlhaUUJqqi?=
 =?us-ascii?Q?eoaEMSqBoD+sQJM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:11.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dbbb34-ea76-4770-5dd0-08dd60171b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4395435af576..20eb1dfa8c65 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -104,19 +104,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		rc = -ENOSPC;
-		cxl_put_root_decoder(cxl->cxlrd);
-		return rc;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE);
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


