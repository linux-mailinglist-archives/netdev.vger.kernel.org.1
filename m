Return-Path: <netdev+bounces-136670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4939A29C5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA01C21724
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2181EF0B0;
	Thu, 17 Oct 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GM/UHyON"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B001EF089;
	Thu, 17 Oct 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184016; cv=fail; b=FwcM3v2QKXUwfgu0P5LUdTtShXSgsh9NfAlTtIZAd81GzZMBnMqDHRcalfTLp/3luLofETWe4j2PmzDriD26vzoyJDEc988mYBPie8hKjHwsZqCmuquvBc8Xql0omy69LkXCI9ZtZB+CaZSNC8z1230Qno0lOJ64axtHC4nUBOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184016; c=relaxed/simple;
	bh=SV4Zjdj0KPA5SjYzgPKGrkx31xOcLf3oz5OgfcRBmak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghCRawYCg4tXE47xlokOObOAfokHsNlDF2GKC7c7+S5JSgYF8oKBiulCYF8xdG65Ta6olSkNTARoe/FapL5tGb5L3YRNSXaHdWPb61bAyvxdJ7vNZCZNSDhtpWnCqt+TpYxDdzhz4oGijopYuHLxF0S5WpYT1RIztTTH+g3HFH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GM/UHyON; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap7H72maYh0um05gdfTr5OVFxwuuU7apZpyKDaKQU7aXmU3lEQ1UQroAbO1zVYG9jbWdlKWk/9yBBObm3ZcPhebOzrRvS5jBSOIohOHKG0VPgNgyv0PvolK0jQmqxXOW0RJRgltgHEWA2+H0OkqeH70L7A5nNXhzXvGBHq+/4l4Vb0ikYc0KbB92+nmp5u2ZnvlixFb0wCHrlcTFzi1jCP60i+G/HPRTifP8pXtp9fB8+3uTWhdII+EirJDyYFn6bGTt+N8mWodzdwhxcvNp/+X4qXlu2jdjUz4oWnQZAAUzYnhWQw+PqQzK3axvvut0MuTjUJ01DN6+BpLLdzAROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njQ7BXy4iW6uNUbFtkWXU0HRWbecwV+JEE7FTixF8X4=;
 b=emW0bLam4QFKhW43ZiQCGEe45EvXZ9kxyYblQhXCx8FXfjLtJ6zG5sbKOsM+B44BTz/Za7m/AUbvbm3cdu1cUmRzXQ5vd8qpNpGVBkhZrLjz5QOHjMe6Y1gwppsuP4+4s4pgOGu1cYumbWNEPvsasatpXpa47EfiOtyc2N2+6yRc5BkwxuKdRvqad53f1qSmTSqapTbqGmv730CVY95M5U95ZQbpwtowiskDgLRv6MZl9geCCQhxnwb++hRiSGRTEufBDjrcI3JA6SdEGeIokNd5JGKhdaVsqcvUcdkzan44vhFU6SJYKU5ZZNoEoHjk9QA2pVispWtdLWPOQtSUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njQ7BXy4iW6uNUbFtkWXU0HRWbecwV+JEE7FTixF8X4=;
 b=GM/UHyONElSJDhYEZiI/KdvMVpLq+J+fR4hhoNy14T6XBbUjmsHJri3VJkyZEfvNDXQEvqazpfFy39SrAwUffrYF8a+Nr6TNuyGfDC43qR4G9ipEmzrrLDvNFgZ1X5kOa2fmfw109iXX2v2eQuMASQdKtn2gaelxneXKGfCst6I=
Received: from SA0PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:d3::17)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:29 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::b8) by SA0PR11CA0012.outlook.office365.com
 (2603:10b6:806:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:26 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 10/26] cxl: harden resource_contains checks to handle zero size resources
Date: Thu, 17 Oct 2024 17:52:09 +0100
Message-ID: <20241017165225.21206-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d0ea5b-0400-49f8-ede0-08dceecc39b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pxeeXN8Ye8039tHX5N3yZtLJbtLSA4VPQh/F3vZl90TDCKvh5ChU96+AcE+d?=
 =?us-ascii?Q?jhVrIwydg7B4ufqHKiskRk1QaV7zufTpAf1wseMKar5htQFIljHaH/+EKLPh?=
 =?us-ascii?Q?TGZui0UO0afYNM3nUfhyweWwj54eswAhKI+XRew2yITojb7TuBxcixIN6iyn?=
 =?us-ascii?Q?BJPI2T8/NnlFav3gwa22LeFw6G7qWuUrFAADuU7bf6xZnQUHhlt7GB27sJcp?=
 =?us-ascii?Q?4CtlPVgSo9TtL3PuKe1cjPKv5MAUN/K/nQUJyKQWNKIWeS+qfazZbAb0ZYlH?=
 =?us-ascii?Q?jejweg3j9JBoE8SlZUJFLh9ggPdrYeN7B51UHy3Q5arsdNkQMWZM4BF7FhZt?=
 =?us-ascii?Q?5LJw/1i9GN7qPQxGWL3gCQ6m4qQwoKyDm3F0KFL9g0aEPHDzBU99OZBem49o?=
 =?us-ascii?Q?H2FCEEfd00Sa89s9q1GoDFHwG6qVjbmjtD2PL8gFkdvhvZIUit3/B26TJG5G?=
 =?us-ascii?Q?7bMuzEjz5eJoZc9rOwe+fdF2V6ORQzpksqKxd19cc56jyvehcJ4B2rI5UDot?=
 =?us-ascii?Q?uTi7qTJoYhRx8HJcB4Q10qRV+xECfNZMB2ZviHqH9UXjAV088ZIsJdIVfl5D?=
 =?us-ascii?Q?bod6AIJ1dFsC9/OV8HLUMkTwQSYDkQSqKbAFSZtCnmS/HXhReTDXEiHGKEIG?=
 =?us-ascii?Q?2ROs1Y0thWiZ+bXazZskDVQun8QABJTXoD11RAYcCATZnyLUR3DDLOWY4TuB?=
 =?us-ascii?Q?ZrY/hVFqkxw6o8HTgMponvW+k2cuXS6kNdC/3+/xJUsccZcdG0txRZylwlOZ?=
 =?us-ascii?Q?jog8dFxmts10yQBfJG+Es/LirW1fyJnNgAAbrFPb7LJ2vnCBbIA4liCnnxF2?=
 =?us-ascii?Q?4XV2+n8KbwglLcb3tLFXgm+vwVU5Z/POS3UW0MJ+pCUgBY4KeptDzbLPT1zK?=
 =?us-ascii?Q?8eGle17YnEwcd5bcEOltyHc09vuXNJ/8zVEdmUf33WoRiu0DE4dzkHpBca/n?=
 =?us-ascii?Q?uIi6cUctjHDBShjBP91FmaTAsK+rDpciT1HZspwwvvgNq/w3rmPO5oSq/bav?=
 =?us-ascii?Q?n3inOYug8QBPEUcuGnJPtz9gd+XE/CKBfGYK6Wi2fMUTJskbAAQsGtdcUnFE?=
 =?us-ascii?Q?/dyoPcLgMNPwvD4Z5lJCP5a3t4C3K/p1VBlBXcnmD1poKGLSOneWT3py10hL?=
 =?us-ascii?Q?U8/xcLU/dgrV5Sixs3SHzNSHU21SdO4uIw9XS+7BuVnDDbaw5ri4vGd4JSXZ?=
 =?us-ascii?Q?vetx7VZauojB8AcubioPe3/pWpTD7d6uXQwiT/LsAxyf9rray0rqgXnKt351?=
 =?us-ascii?Q?n98l2jCI0hoQAwDWkXsiEvnGqO8UmqY/PgHrA/4DC3QQwZWqhABozWbTbMD8?=
 =?us-ascii?Q?ZCSP7l/nM4tKwUrJtq0aw1be4cnbcBRlKn5+gSDd89ben9Lc9lJdHiYSs26t?=
 =?us-ascii?Q?Y5Q+jxmRNgabkbQe2Iq3sJHWudGWxTtRCDG+NWUWK2GQUN1EFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:28.8015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d0ea5b-0400-49f8-ede0-08dceecc39b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

From: Alejandro Lucero <alucerop@amd.com>

For a resource defined with size zero, resource_contains returns
always true.

Add resource size check before using it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..c729541bb7e1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (resource_contains(&cxlds->pmem_res, res))
+	if (resource_size(&cxlds->pmem_res) &&
+	    resource_contains(&cxlds->pmem_res, res)) {
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	} else if (resource_size(&cxlds->ram_res) &&
+		   resource_contains(&cxlds->ram_res, res)) {
 		cxled->mode = CXL_DECODER_RAM;
+	}
 	else {
 		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
 			 port->id, cxled->cxld.id, cxled->dpa_res);
-- 
2.17.1


