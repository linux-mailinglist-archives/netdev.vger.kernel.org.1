Return-Path: <netdev+bounces-237246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D19C47A50
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0957D3A6789
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA631A813;
	Mon, 10 Nov 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fdEh8FxA"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B783168FA;
	Mon, 10 Nov 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789069; cv=fail; b=LpGIjv957MMSe32O0rgy57ODDAXv431H857Q0Vq8SD0kyCPLUyo0XSEQeR+VBJHcnjbH3ylCUIOGURC2KpKF8J2Fd3iawHMKq8rCNuRMVqP+NSiDEvYy0RgTiNOP6quzQn9O3H3lxRzACU9RQcp8cEtyF9x9dZU5ge162rvy6M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789069; c=relaxed/simple;
	bh=QAVaDQzXXMc9OgPZ9Hi1pRJG+oXc/VFysuqSLg2Sizc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PD/V9GtHRNS8v0lmEXhmkqnb+ey0v7t/acD/tq1/dGpGtkkmSdSZuq9V+Jwlk02I2w6NMT5YZ/Ublr7FjK4TeGDwDc7MuJyDxkyDXLIsPsIWF3i3ahxfFeW2iFBysRVEyLhkgdMPZFaSnv9VIPlhY4gxrbh6HtRYDFXzSTr8EHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fdEh8FxA; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0YNJP192uT3iZBASCXXuicJdMqrg/6GiG7c6eqp958Hqo5FnszPY8uAuq8mrg7nGInDYSbnQhy3cK6A+4b7WcFwm8SS+/GMZw+FyGbEDoewIdhgg+ltsXunfejPoy7Q4ZOJ4ckg+rqbLjkWqbH1pyk7PNOwWEJZIRB6tUUWwStLu8GsP5IHAYDXjlCj/29YN60QL3MkovraLL097lAtdymekLGEGRxswJTfywwGQrFo/WLsyozqQT2bX6QljJMk2PB+5Zvaex/UrHx1ocPyR+dD5p4dby7VxpVOd7fGvZwZ5WhvVmrByUAKAXeFpB94j38kYLOvuRZSOOeTC9cU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEmZ9MeOs8qPKTnBwjuwzB/esnoD+A50F+hvnd1w5EI=;
 b=Y1xfgT6ergDJeO0ETRZJgeY1yi/+TIKahlk61f+6oOnlxWEi3GenQhenR93ZcEyOFN7nbzNayYL4MMVRgRIsvFQSThkZNE4M7bpcK7kjhwmOHCpda1FvXd2nXYeUcwqTPWq6Ee1c7DQWd0MGTvNK9NuG7kDdv/CLi/m0lEu4zlq5vDVXnaho0NV5LKV8RZN9wuo5QFCotehVj0yQfBgDRz4TLUEtLbhNsKIdUwDwdcgie7wCInJVZOGv7DW1LN7MSVD8IuYPaUmfXL5wQ4GCygNz9OELh90sbPit4gbRVPTGDw7D8qtRaUkn++6q6YnzXFgoNbfW7OOtRBnSA7zmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEmZ9MeOs8qPKTnBwjuwzB/esnoD+A50F+hvnd1w5EI=;
 b=fdEh8FxAwlIlBpAK6Ksm/7fUDSsOC6afqq8dtrHFnOB/K3FfLBLE028gCds77iSuXP5rEHhdNvTN/NExyrP+7Xr5fdyRa3WxR9UmGq7c1vA+BSkwBqamzz5AFhKHZYmaFkCKgyQKzqpzyCLOgtYKUa8MgtAWzt65rgwo2zyGhDU=
Received: from PH8P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::6)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:44 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::3a) by PH8P220CA0002.outlook.office365.com
 (2603:10b6:510:345::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:36 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:36 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:34 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v20 19/22] cxl: Avoid dax creation for accelerators
Date: Mon, 10 Nov 2025 15:36:54 +0000
Message-ID: <20251110153657.2706192-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 00403ce6-77ba-4c09-12f9-08de206f17b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jzn0OBpUfqFbpfnE4uEpssOEAJkP4qsFcQTloFWu1dTQIHK55Qufu4ocWEk?=
 =?us-ascii?Q?Viw2h+2JCtvSSx6zAE7GsZSvXZ+3SC0qnOnnaqQ/QSvbs1Jh53wekFv6lEgd?=
 =?us-ascii?Q?5RH/446pFcNP2yK552U59XNBQ5STgFkEG6RJsSVEd0YbIWcLryNtSyFr49iU?=
 =?us-ascii?Q?meoAQn16dVzB7RUxE37E47H5yS+M2IovsJgmY/+2eYGzBbnFi7ZT0UzgxOji?=
 =?us-ascii?Q?7PGjwnkTTa9FHDoeVl9hzrYQma7GD7cWhxjh8GXQu/Ezz/PgMuuGr84HoOXN?=
 =?us-ascii?Q?Wy2DNQGiS7sAIP3B1A+j+HO80PKWkypyMknGnkqvCvJFfSjlmPsIJfMnjitj?=
 =?us-ascii?Q?yKeKvIDxJJV05iNtDxNnSiHIF+h0aOBJ+vgmUPMr/d14rkyJf/Is0hPSqU+w?=
 =?us-ascii?Q?qSzyNjYI8GhOHbLfNuJxrgPgdU7BXNK+/TcC/7ezgrZw9cyVZctvX6yGbyO6?=
 =?us-ascii?Q?CHm9pSIDBGPIb4NfzLpxeiJVs3+QBhhUMlcpNZQYdl8VF0/X0o5WgVoHZi0b?=
 =?us-ascii?Q?137N4fexDhf2VRO4lJvj+R+lLo8FGjUX4dzu1CF0mY8cvSYNRTkPbv+0Jk95?=
 =?us-ascii?Q?Ac36Rs8XdmJAXqWKCM830JfJAwLUyV4GJiAryvnc5Inm5UBUrhfGcHNQYxvm?=
 =?us-ascii?Q?a3HRnoEKYIYcIMW89gEVItJrR3IxnyAHIgEpEFOlD7CXriowoMxmqUsv8wI1?=
 =?us-ascii?Q?5zrr5NZTlFyv24SN4KWKv9jaks7TrY+43myo6IfhYhsFWSiLo5JJ4bOfSIF8?=
 =?us-ascii?Q?KU1FmU7t4O3jAMCee+CIAwrrXTclyAjcZrdm3CaCRiIoxPO9dzeLDCFmj160?=
 =?us-ascii?Q?xn9E9RJLqZYznihrQWMrtc/yPBAT+XChi3Zy/76XGgwFQm+e+w13miLEZMH3?=
 =?us-ascii?Q?jGJ99nYoqlwgNsboC4gybLJiHlSlEbl5ZjmoO0tw2XR1dobdozShnx0NJ3Ja?=
 =?us-ascii?Q?hN+rZYNbJj0+Ewi+Sg6jyhQnq/SPnnzT0m0DIZL+KZacS/z2K5yrnYXCauHg?=
 =?us-ascii?Q?PNnHOdex6tVEi8LIm1I8fgANPWnQfbEqHWzHrizlUOvZl/docSMbYe4bptlx?=
 =?us-ascii?Q?q15AWxo2Nvb61zc2jlGsIIHMNhFW3Fj2z1nKl+tlK3V3zGSUir6BYF9/qFRA?=
 =?us-ascii?Q?k7zU/ip+pmaL7BhPZv+vMvSwLKfk5ho+XGwDep0GbD3DBdSwFIFNJSEY53Rb?=
 =?us-ascii?Q?nX4dytWeFVCnvtrULxefB7wqsl85/WWUm08n7iEOkXL9BtQdnRHrFJFNLgHv?=
 =?us-ascii?Q?TCAfUfgM9oIwXuaaPBTeb9Ssf7O9Oy6o1s8Hq9vnMCEh4w6tq8yBquz8PPMe?=
 =?us-ascii?Q?MsJddMbXuuXER1OXR7T5KJOu5NoUK5wwmhBJJoqX4ctGA0sotiQp6hzlwrnT?=
 =?us-ascii?Q?DajY7YEG3FqFVzYjSsciWIhsPabxmWLisLEsJPq1hNoGeNj6QpkDo5U1PJzK?=
 =?us-ascii?Q?N3mpS9HFOQos5pjM+YcU3YtfnodwbYViGv8qsoFk4eUDvisytannuZ7SsQTe?=
 =?us-ascii?Q?Cm1HbI5CrUTdkUmKFncmcwy3W4L7jhjm73DWRqTZA7maZiboy+LO1I8bbzAp?=
 =?us-ascii?Q?EpPxgt79reFcslANOxA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:44.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00403ce6-77ba-4c09-12f9-08de206f17b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 63c9c5f92252..5ee40cb9d050 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4135,6 +4135,13 @@ static int cxl_region_probe(struct device *dev)
 			return rc;
 	}
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
-- 
2.34.1


