Return-Path: <netdev+bounces-227927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E43BBD97E
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B91164EC107
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1164221FC7;
	Mon,  6 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LN6rKzFk"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E89221DB3;
	Mon,  6 Oct 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745045; cv=fail; b=C+8hpcJHdJNkyinnrIBThe7N+y9LIzLvR5F80+oozxUp4XLFPHYSgMKVpyMuPurJuWgJQw+HDiwu1XFufDUfdwARRzD9JAWIrK14t5JRqkTiCzcnjONsHgN+wye8hROr4nqL72efnuLBMp1YDjVB7nX9hwXqejjBz+SYGwjB8RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745045; c=relaxed/simple;
	bh=sDB2g2KJG9u/u4Rl2fX1Ry4Q8D/2IzuNg4m0r76Tdds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KApvpGkyXks/akqjYidnkT+9YlAwIfpnWK+vuI6NJQ7WnnhGGcchMvEctzarFzx0Bpv/uQu0+71VnLNOLoopCDV4ZsRVvCEEw6D5djOSkm9q0rz8wtBuLc6sFdDg8e+kHk7HXcf67d50trgVw8IFh7EwFLlfHYFJYcKEIou0jMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LN6rKzFk; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCh4pHTWDcC7sx7Yi4syd3+0hV34sx8K2j5/wCUReSTK3tiZVjchDnbSpH7QGMSocnsq6ApUgB3OxHs2I51iAgmaSt84XSanojEC/fKrEwWL0KlV7WfIKPCdblnk4OX1FwlCs7Sgiced8cawcgL4gdlJBIXobqpBkfX5/QM96/bRBjETO72XHwKmfxUJOqyagqul5aGO0T3Y9PUI2jhtv2/2JMR56n9+UC0GuFnGMqiKcskWKet7J584NnBxeVcEL2asb8CPSBAshQ2l8uHheVlTTPGERoMaVAHVdc26UkUJoOjPy2toI0wOvO5hkCSlfDUhISdjgBK1B/+QDhAUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=offWEWCCDaYHnQXRHgaTXtUnTreicxYFtzeFFHEgs+YjozNYTmfp/TnF6JEhi0dfO9fX4haogd6mIOHtRK72DKynsWJBxfep0cCP7jKM19TcEjdrRov1UVm65vHQLOuwPEtsn1KoHZJrQ3Y8mlfzRG3Xt60XXst3gh+oIedYJCcOv0q+1u5wGJCLjgQQfLO9/qlwMm3wQUgFz0sZ2ZhYthgLaEGk8vLKOgdY4wywJlkUrTPOTcTl8oxXmCYtWdAJcVODta03nfQ34hS0Y9SkOw2OTwtuAXCf7yhmeOreS/56XKPcJKggNgA84aMdUDefEvUnCFTAk8cEmoAjsDrlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=LN6rKzFkq3JHh4BHTGttjp9z7ldOZNKVDpBBvhsMy7/Jb5hO+nNiotaYVD/XsWboRzJXRfKWL7tYRRRoU7jejE33gXS5G4xmMto70fun5glGd0QTWYRiVjzsDvO/5duitGDp3t+M+gcivEoNpUTqm2R7U8YBm/zDN4NigBVvD9s=
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:54 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::1f) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:23 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:23 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:21 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v19 10/22] sfc: create type2 cxl memdev
Date: Mon, 6 Oct 2025 11:01:18 +0100
Message-ID: <20251006100130.2623388-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: feb77d20-2bd7-4cb8-8b3d-08de04bfa83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5T+7K6+p05whzsHJxYv2T/laF3TwPDp2wSDnJFcr1ZvHgAM+L4FMGweilnRk?=
 =?us-ascii?Q?ra5Jc/j4Exa4DdE+XXmfAH9KBoU9Ie4i6tIuVuWGnOZfLIh6gculYP75EV4V?=
 =?us-ascii?Q?KJpTue+QqstKe6Ki7puN0bKba9Hxwjvu6WSt4PAo3oH7AOiQXpYuSFsv4GsP?=
 =?us-ascii?Q?JaWab8B8B5MaL9Tmvza0g83sbQic63Gzs6CRdVlWQGsxhILul43VL8suvBEF?=
 =?us-ascii?Q?NPzwlK+4vCTMw7MnS2I0dDJ8HOY1Oio3NvS6QEHq5cTWqVmBkzotK7ZNix+7?=
 =?us-ascii?Q?Tzxnt4POHrji2fH33pN3WqfDbGV+kh3i0jVUrrx96i+E3OlDyq/aZGUCxsrR?=
 =?us-ascii?Q?Pohs25Ar/zPR8Y7LsOfzVmWKMxIQH6H+WkV9xj0nOM0Au/hRbUCEGI085rf1?=
 =?us-ascii?Q?fGgEWIuzJEMEYUfCLwtnqihtUbbx2y+Irltnz/R4RLospBozbhrjxfL5oRTA?=
 =?us-ascii?Q?BgxC7FJL80N74utevinftVaDLLGOSWkwOeTaqy/DslE6CvGwTwOuBk47JMQO?=
 =?us-ascii?Q?IWCSjmDlihUD0W/Ip5auJKZRwFh3VFTSS5Jdt5a7riYgwDesDJzHkh5t3Sbs?=
 =?us-ascii?Q?vE309yOG1RpEh5eUpC7VJz/mQdeeUhCXuUtEMGxqGdifqpypOrjGpFUKgA8Q?=
 =?us-ascii?Q?bNPUvilq6htNmDpMKB6GvrGrpJk0c4qo7YwajPkM+bERjiNzuYPIXSO9lYIW?=
 =?us-ascii?Q?b+Ssgcw02oJkRgXgaVOM8G1Me2X8jpHPZjdG1S8UvP0nGqUnOMxEvFgjO7GX?=
 =?us-ascii?Q?ETB4PrHCVCg9a1vT95emCoJxPNeaqDoOX3+LiynIEGvgIROAPclvwczHGA+h?=
 =?us-ascii?Q?HPLlfTzEDMi+RhWDLk6UTdhAOUrqNM9s15xyVvyOZR9+BxUNPraCx8CusQVO?=
 =?us-ascii?Q?2FSzz5cT7Taz/q01Ry7sxFZw3t+soeHOZiDXbf0v/ehKT4Kswkdtyyy+v+b3?=
 =?us-ascii?Q?9IoxUV2EtPUx9VNzJH4Mx+VIV5scwY1giW0OSfxptYL4MNXJSYccde4Pjvz8?=
 =?us-ascii?Q?Nk7hYkyKXCd7/bcpf/Ar+Y/UCnzIW+LK8KpP4CTUlHkj2iKAfcDeFu+rlyzc?=
 =?us-ascii?Q?xJ3VixvSnMwJN8ODn2K/tb3Sszdr+9bb/s/Qk28lBrsgGJAAPpHFYtIoXHhM?=
 =?us-ascii?Q?bH1NuSvU46uO754xe/7MVbC+q90xIVJQTWU45B234wWDkjkSw6L+R/Hp9s8q?=
 =?us-ascii?Q?oDuDXxpIosfXnVQaNcUtq1R8lGDRtXuezaEUyvZAjH70AxRcxnMhKckROASX?=
 =?us-ascii?Q?LwvUAjdtY+A4KWCjHB75Z5qciwgNhz3lMahYEi/AgOplfzc1iMvvCzK8+R6o?=
 =?us-ascii?Q?wIZ+vMAhrLYJ062TONdDhvxVzccaoNCsgFVB8fwiFT49hz3aNxnfQDFpcqgL?=
 =?us-ascii?Q?1UIAd/GSQ7kR/39LPm4CERcUsyK9OAUbKYEl/W4Rw8sRY4Mw8zZOGPKZVXau?=
 =?us-ascii?Q?RG7ZYVXasjC41f2HnOWACURVhiQgdUUV1neiCpQpJj3oNlPHVB9NoFnrJOdo?=
 =?us-ascii?Q?CGmuEZqvpESwTa1UpSN8ZfYvqv+CUPNAg9dnnmonRVTMgRPIcrX7CkyUv5vn?=
 =?us-ascii?Q?v5/ABlTYi3bb1GU1yCk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:54.0330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb77d20-2bd7-4cb8-8b3d-08de04bfa83a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0b10a2e6aceb..f6eda93e67e2 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
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


