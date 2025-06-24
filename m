Return-Path: <netdev+bounces-200680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A9AE6846
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF0D18985F0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A772D9EFF;
	Tue, 24 Jun 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ea/6KegW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3172D238A;
	Tue, 24 Jun 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774488; cv=fail; b=MQq7U+VWzzZpp8W6Ndua5XefgvQc8q9rHxnQxm6ueSwhR0ey3d/4h9VqJMmTQw3CmvGio3tdkZHfJPYeV23OMnblnLzmnNwUk6m2AOWj+Q88Y2c8Eh/eTf+MYOUgKntICRjXFtg3AuXKscIrNO0i0jVc0gTUB3VR+WAxHxJmHPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774488; c=relaxed/simple;
	bh=l4c+tF+yHAjHwSf4vdxW3Jv2wFTqRhSenO8KwcSYyjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5bTRGDW7U/MlfsdXlLqh2ggEBKlb2u3c6x5JoUSP/I/KETOPZyGSrn7z7azTO2Z1DwHApzgOLDgKRcq1al6Pyi+vHpzvSZp00N+MMdCfNQ/jsOYEQGLrbkwQEcyoXtZCRKIuSSwzdIu8ZcPEb80mSF69wuiDAAYK/rfqaSxU0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ea/6KegW; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSCtLj4Wh9EWzokDLIj754P/vcnybAZQFvddHgXYfzXhqeKoegeus67QqvK4FrmWeO7sQGs/0ZyygcPYQhONbS5ObwVU3Rm/asXL+ZW9Xn3aDQKZQlHGoPERq2erhQcUgqX2F7o6EutfQxDZjdvLphs9DoqIxDlZvsAoGPD77E92WX73oJNMwhzcwK3UJqk6Hu9bz0OTfMqcBAiHLEXajwOQtHobB3GD6AlNO3c/uCygIXGEMqTWJ7Zyz9KBkGaUVSqAgUteGpjiDVjqNi9cl2yUV8PZC5rQnnC59kd6+niuco/ujxSWr+T8EBmkQadncDDzaf5ELPEjs7uOoo8pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkR3voXjg3XucmYtBZH6Zd2Xx+a2ovdZai6Yl2pvdos=;
 b=TF5EkVp9PCkFwpA3jEZFeFNZvlDyov6rR19vjYd4L6XIi9ON/M5FG6MA492RJmaevmf97HxN/VF7pkMEkD+cOYtoiNd6/nZZtIXnk/lnFkl3UGlsuG4cQ2tW/GfpsZOuU/kh8KS3yL5GEh+HCkWM/0hwtMwwDo+rsoiS8NhdGDzHp3EZJVVD4XST+ZBTjdwVx/gQmylXMtHIHj9B8k84JMPMXjaFrx3fzLHzq+oK3QKiyIzWOIakENRW6gzp+b/DM/5rEBONNeBSL4cbyfBmGsdgwqGoNwT2TSGOuYSoOsV0EnoKmoUThPWaG0qPZQxlPlqA0VBAv2axzUKh3kwWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkR3voXjg3XucmYtBZH6Zd2Xx+a2ovdZai6Yl2pvdos=;
 b=Ea/6KegWxLWgic1rSvD4Y6b5Fh9mgIPFefTJ03Y36bLXFx1KaIm5Nag2TqRici2u38V050WbF3P/rLtVDNcYePmDxiBfLFHnkmb4tP2Cp0FqQpgespYaj0OhXETMNei3Yh74DthlwjHRuhUcNpweeNAT/uDOFkUfW8q8Pt5qrc8=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:14:44 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1e) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:42 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 19/22] cxl: Avoid dax creation for accelerators
Date: Tue, 24 Jun 2025 15:13:52 +0100
Message-ID: <20250624141355.269056-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eedaa5-2b91-4ee5-aa3e-08ddb32977b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZK/q5gw7R7nZC9nHYFAUD+FjXadsV2wGYYeQv1hZdpLrtyr6evLy961/26Y?=
 =?us-ascii?Q?Jh51dcRN2rnufbqCYYuSBvONxxV7n/LyUJh3lYcQNsLzlytWOLUvcZh2qP7x?=
 =?us-ascii?Q?kkToIKlqrpltqxJBKRGJH28CQ9TM2HYZSW/OFSIIor2NJRcJV3oBxhcfc7hm?=
 =?us-ascii?Q?4nxYd5jfNVVNLlB6lmEnWAptTXCM6EfNuNrqLGK6K8BBDPrEhS1Zk2fqkmRw?=
 =?us-ascii?Q?DINVWtCcJ3B5rziuhcVZj58gphReqypd7AzdYDLjAhXefFJTXEfeJRY/cVzd?=
 =?us-ascii?Q?hqGyTvfufosxf1BpC+gK/WmC3guuyomDL+2m29fbD8/LdQ/qfGlQLIQVpHRE?=
 =?us-ascii?Q?q4g4hWcJzarSdy0CY1BxOH+vkgrJ1Hdi6+jCkctp0oE1sl1TwK2FGe0iaJCb?=
 =?us-ascii?Q?bi5NxWY0N2xEl/YzCaZ5Z312lZdvZhdrwjMdpfR7kFuVxasfpzjXAvPTrpR2?=
 =?us-ascii?Q?BxEDllScw4GhSnF9p+RcfG6O42vFmz53D/JdgAFm4+vf5MqtjuxXuESh0I6D?=
 =?us-ascii?Q?rC1D5NxJ6cW7TuaTp6Aule8hankY4RBGVbEgcRsZOpxs3V1YqZeYl32B3e83?=
 =?us-ascii?Q?DcWX1xFS52n47/UVgku2tdmr4uzMzhrJQoMO29lotT8i0QJ8feE9huqPc5F6?=
 =?us-ascii?Q?592AtNKLat2hqLYlEwaYQvT18nedmvwvbyy4E/wz1elLUR+WmZtVRbGiJnBR?=
 =?us-ascii?Q?EDaNYhAO5F7sxBhi2ytdcVQStJez6sTUg7qcG1c0D+6EnwuFk+LvlKSOrzHv?=
 =?us-ascii?Q?qHtTQHYzx3FQFMNjEGubFzlJ+75danQ0bY/K+FwNWTDx4T50ElK9X5eiTLQO?=
 =?us-ascii?Q?UJkzrhIXHfPmH8QUGMlHj6wTr1pKEtuE4dy+426qsQlsMdZt1iNtNds6P1LV?=
 =?us-ascii?Q?6GQo1VMi6l/1uMJrpi0W744Omqh24xrTZlzGTSmBDQRQaIjT7RBI8VePE0p6?=
 =?us-ascii?Q?1EX0/aKc0xRm3tQWFj+Ua38pIOaS+FhiSqxBNnMsrzJHBwCnoCsiNztVF+We?=
 =?us-ascii?Q?FLLhFF/vzFBaCCZukBFJajTgzJh71K7DDvybak3aSAc2JgEU+COwNncABOpT?=
 =?us-ascii?Q?5Phpm3Vsoc2rP9Dyq+zRpKuxsLR13n5nG1cZ5bXWrS6eCg/vyk5Z9nBDzkX2?=
 =?us-ascii?Q?iYGK6tVGnmgSRACutkCOugo3vi1Tx++uZZahT2Ug9tdpL+/lJwOB4+0Nzm08?=
 =?us-ascii?Q?8xuEtXVsnAGVkDBsr9Koh5+YZTpc0Bh3Fcwi1QL+2XpfhIxlacFBGr3eWr6O?=
 =?us-ascii?Q?9GOmqO4FqBOEAN3MUIF+M+mQ8oGZ6ovUorCxy51HDh6M7N8Du/Q5wx3VajWE?=
 =?us-ascii?Q?7JJtHPvDwUQf7NKbszCOt4Zrb7TEKZ4GfegPINc0HvPJ6yVVXWF82Z5tCaDm?=
 =?us-ascii?Q?QDfxcmJcPbsbWElTIYwVU1rcz0Wvt/a24mI/RWGH0XRhEBT++9wM8Ug00nez?=
 =?us-ascii?Q?ZYmomBB+WguUcqiSB/KTCPqv6gnSDAaXHcgKRXQMHxG7x/VZL/5GBS6yBv5L?=
 =?us-ascii?Q?EaUuA1MubKFRBbTmO2DI/cEmjcF9aJtrhNEb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:43.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eedaa5-2b91-4ee5-aa3e-08ddb32977b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4ca5ade54ad9..e933e4ebed1c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3857,6 +3857,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
-- 
2.34.1


