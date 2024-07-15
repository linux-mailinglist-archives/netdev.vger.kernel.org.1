Return-Path: <netdev+bounces-111577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E154931951
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2C1C21C7F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC24D8B1;
	Mon, 15 Jul 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzVqBfxL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001082486;
	Mon, 15 Jul 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064555; cv=fail; b=HDb4SN2FkQLx6/e2cobBkrRhIStdg93IUNAWMVLV/8nfbqcCbA1IBgGQmbYvBnzsUjYfgDmij0EFvVvEw7yoVdNPLN5ofWnXTwch85lpbiQ9pwBaFAw7GEBlGYaA8SHcXkdGpDb66FL6xeJApb3bQdYLA8hHdFhzyT/cnr8BIOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064555; c=relaxed/simple;
	bh=l/+FmP7W4y9wt+tPE2M28dGJ00elP29yEJE2jwO9fiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTH1XuTUzLoUH+hJYgUfn0hkq8+X6LhiB5hYXv0IZx3otwhDLElOtFR3CBLv9qm7RGpEzyte5Nz1GyNBHVAavfs0CX8xwW0Lb0hxOaGqu8tw/XTthjF6DB1oj3h0wvQHQddZke6MN/oIwPVR7x6u2QZyMMy9pV+B6C5ckR4BAGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzVqBfxL; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGXO476LWRzpLfWpfyQvm28yANeWbEdtwXHp6g+SQ9wxfcT85zH3HUdUKHjaDtz7Nwv98KJ4FblKnz3vcfGTCmmt42Ynmtz41UjoweJq2PB2Xka+ObHyHLQHtVIuDltOn0hWHJsdRJ464vDIQz03qz4QA104V0/cuGX7HWuLYHgEvWwntM0kd8VqBYu1nZJEqWcfDf+b+0+Lg504NvHlpydBllDngOgi2ZIgltI77d7Pec0OuUyOcI4trwoX3ZLt3XsDPGKNZq+q3BDydbx6+Nyyt+51sYBZM1Nm0eI3Gjj7amEGkM75dpfuz8Oi3FjVo0w+5QIMaQ3dPImAeFt02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdujPSOjy/j4GFMNo1rdfTLRyXkFQ36MUwtV/GPAJUU=;
 b=P4p6SEUQmuDoh0RkGUrnyoTQ7S+ydfOuUOkmznBL/bLW5yaHMdzeSiEgHTwnjwERsUIH5tzbkR5VohhaCjWdLteqFmAASQxnQVaPZxoBL0E7uVtUUtf6kZJ21OpFN3YkiNdK2aSzRtWU1/eiOFKKRmvpzh8nPu02tBpmmUx5yNSnMspp6QEztjitADTGbAYbO7wdbrc5Glx6cSVUj+u9nqcZWHGEzGA+EDngkInIMb5a72JLG3Bi0ZsojFQcsj8pk0mhmqUzdqYYNXlso8HL2zqPQWJC4dKUEyb1pLJCNL6I3MqyBT+bfcf4faxjRRcWUVImEz+3SLkTz1gBjZIV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdujPSOjy/j4GFMNo1rdfTLRyXkFQ36MUwtV/GPAJUU=;
 b=nzVqBfxLYQUFF7kMIKM1HMjmxEmAbijydqeeVS6dxPhaHayWRKZRmk0EdlAvczE1rioKoXPiE/pVTPHEIU2eRrVbYHfBV6v33ENUOYZHlCAmLomF9C6s6qcBbfK5TJlia+dUpjSBg2z6jtAoTEY4yL8/4/3qjQNHghQmaG33bsc=
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 17:29:06 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a02:ee:cafe::f3) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:29:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:03 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:29:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 14/15] cxl: add function for obtaining params from a region
Date: Mon, 15 Jul 2024 18:28:34 +0100
Message-ID: <20240715172835.24757-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: de1c62ff-e12e-4af6-6625-08dca4f3a08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c85xg5TBlfyDHjEsvF0J8UTozPGpoYQyk+Crwva4Fq5UMXJGh3zgaYyhSqy7?=
 =?us-ascii?Q?/ax+uYN+iqXKJcaGafA7ynAygVpGzmDtw8tk4pLXw+tOSUMxdMp9lH/XGBuo?=
 =?us-ascii?Q?Ni9Qvs/BQUNneiwWRfA6PrLqYJx5x4SsLantV7D2D9+cdvPWisTkcuBkD1/4?=
 =?us-ascii?Q?BiRP5R8y8YLZtmnxOJUlZgB3obV61k1SacTBpW2WnE1+AfwYneXZLwkn/xLv?=
 =?us-ascii?Q?FksG0aAWMk1EbkDscSTawd47iB/L0RPb+MrQlIzh6vELDIbi/OHLoRtC6riP?=
 =?us-ascii?Q?uXePleRn5cflXSDVwqstKm5kIRs1G31KnAEw8dR720XVd41g0fV5Xws9Lx34?=
 =?us-ascii?Q?TGHQ0mpFLCVK1tNYH75zDm3TudgKspraHaVHXzQeu71rW9seQADEmuDqQzOI?=
 =?us-ascii?Q?rMw6NdQteDQueYMK5+fqukY3YxD2DzG2flY38FGfqti3vsffVOVw5SHqkPTQ?=
 =?us-ascii?Q?HwO93HWX6xxEnyhrFIOIpfraGNmExwQ3g2HUt64GtrNj5wEdQL6NX8MltMEw?=
 =?us-ascii?Q?U/hhzrU3xHQj4zVfB3EBWd1YGqAWr2xqIGp5G4IO2muR4uFjh7nv+9HYTOXp?=
 =?us-ascii?Q?1Q+63Cpj31n9iWveAlpC0gkqkkUjqmAKOJEA/UiI7rjM5YtKF8m+mhAA+Z6d?=
 =?us-ascii?Q?IdMX/xCPIKFvrECPl4PAA1YBvMAl70NaKjvk8BTwTOVlX47ySlwiTRHMUrvH?=
 =?us-ascii?Q?4shjAYpe8FmsL6jMkQtjjYp1uqIz2lJxLPH7sUhzEsHy0s296SeKns+UpCD+?=
 =?us-ascii?Q?ttIHjrLRw9Z9kkw7KWsZgtQR6aOHhc7dQxytrBAxH+GAV2L6LeSdYg5zjxbi?=
 =?us-ascii?Q?sEgwl891tY8V26Mw8YCA45ZRmzsrZQ2NUh4uHkb6x6rnqcdUAUnuYTr1Rhig?=
 =?us-ascii?Q?xAiPQXM6PvkDRsquyyplNSRWpKIJMj1srmSusTJzr1rXugQrm9Nryq/qNfO1?=
 =?us-ascii?Q?5cE9crcHXMJAxDatyq5R0fNoI9xeP/yN8kN99huD6XAiUm+Y52Y5DaUcv6Rg?=
 =?us-ascii?Q?VtNY1NV2Ooeu6xPXS+cCcRnQYODvrUQ3cdudM6Ig3W/eJrVqs702lmGz+oUY?=
 =?us-ascii?Q?88t3mEqW5FBGVyGfAtnxT7JdWH8A6G0SHUBD0tNHEaAmAhiiTooKpuQ6KjCH?=
 =?us-ascii?Q?GZ0sBqIfrcxevr14/Duv63cf0ZMPDp3P5zhi3QKaliX3Y9oSA5F70p0NFee5?=
 =?us-ascii?Q?ct5R8sJH2WhmeN9lhw9zfGJDAG+KdCQCopZvxl2XOc3yZ91kx2BOEkhU9ihe?=
 =?us-ascii?Q?/3r6QXwzwy8+e3dTKkndvMekFUpi3R/Rjlej2xvka/eKPe5NSynk5VQHrQaF?=
 =?us-ascii?Q?RvCgx/uPRYBses4D4AHq/EKCONKhv7r8rkrNzEIXUQkt6gGaV/iGzF3ZblJ4?=
 =?us-ascii?Q?n5oWztllzNHGf7Cyfr1OgmLeS8/esyFUUkzMvx+btR0mPOzGZxUZx7joXz1A?=
 =?us-ascii?Q?Ovpezc/Xo9o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:29:05.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1c62ff-e12e-4af6-6625-08dca4f3a08d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for given a opaque cxl region struct returns the params
to be used for mapping such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c     | 16 ++++++++++++++++
 drivers/cxl/cxl.h             |  3 +++
 include/linux/cxl_accel_mem.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c8fc14ac437e..9ff10923e9fc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3345,6 +3345,22 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
+int cxl_accel_get_region_params(struct cxl_region *region,
+				resource_size_t *start, resource_size_t *end)
+{
+	if (!region)
+		return -ENODEV;
+
+	if (!region->params.res) {
+		return -ENODEV;
+	}
+	*start = region->params.res->start;
+	*end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_get_region_params, CXL);
+
 static int match_root_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1bf3b74ff959..b4c4c4455ef1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -906,6 +906,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
 int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
+
+int cxl_accel_get_region_params(struct cxl_region *region,
+				resource_size_t *start, resource_size_t *end);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index a5f9ffc24509..5d715eea6e91 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -53,4 +53,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     int ways);
 
 int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_accel_get_region_params(struct cxl_region *region,
+				resource_size_t *start, resource_size_t *end);
 #endif
-- 
2.17.1


