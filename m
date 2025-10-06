Return-Path: <netdev+bounces-227938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75934BBD995
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACD21883B52
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330282248B8;
	Mon,  6 Oct 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t90hhej+"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538B21FF4C;
	Mon,  6 Oct 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745078; cv=fail; b=RUPpAMR5f+EZzzY3VEKn9UreQq13cCba+WF+gmGSwAIVMVUi4euRqEIhfi76mFhrQ17Aq7lW+/OK3Ni4gBvuQRgSAZzd2D8daCt9Tc21xSi5cy2L+lARVDIS1jmPLyR7zaVeVztxnrMdKOVQsJtsdTI/0TnoRQGar0ndE4lo94g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745078; c=relaxed/simple;
	bh=dYi26bB+0iqgfotfBM5RDbfdi34BwsP5beMIq4cdwkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o90llpqPL7WukKiLlZ1qoYLNz5DZaJcqKXfXxidmVhqTINWcF6tkp45g1fl24bZzvrSNOK+fdIKYuDV/GAl3A0EQuMur04b5PrQEZOpQ03X41FLZLFlobxlUOaM+/J84fSm6lOZCTdSHyqVPS37LJ2XDQvtdWLc57Qj85T3eciQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t90hhej+; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se488G1OP2tE7Zz5M14ZJE4BL2541SdwqYdLW3vlv2Qe+/v9MSysLCUR9A7wSqVM8U6HBeiWvSecJiF188p1rGGh6RJOLRCPPRw10SFoo9bvuuVs8WFmLXwfUCZXCo/Mb8KGGb7pU1QjK11fCq3Y6vjJDTzm6QCU86udv7o4DL+6xjPZ5f9CaBiByB2N82whRfpFjb+quDWCn4zXj1e7AP2JnWYgdjU1zEoP5QLFzymRgBXOAHjTwf36OAnYFbsgFHa6YMb+HAeoN0FlF1Moscg678W+z9qqMTo0dtwz6m/27Jk+7qbKFLoQFItNFo4Nn2Rx97bQfOV6cjagTu2OWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P/GdMfGYhUPYKSgkbz81VGQCE7b10YXn+7VIHC9MK8=;
 b=Od/6D+EdrZsy+0RlmM+ZRvFGA97uBc6DhdiKAMpZVFa+6NaKLHSzK8W6yZTRrFXgRyJqd842sOPn+up2syrc7GpCreqFDs7IgRtv5bE8nMX0Dv1OwCgK8jek/p/q7fc7ZAIcWVx77EA6QCZqYkWJuolZsW/WhdpTDVrWnoKQ+ra4XGuJuSS/ykjSWJ3qQjrlUCrIUgOsvBVLpTsXtWKgKJ4q/xlTD42HLoZ13Yw06JalxXgvUBKP+4ergJC/hxcHK3jmJRbY3YszW2QeJHTDagP8aFpxvHzK6aL+emhUNuMP3eOVjVIQDcS1HUc8MWd4g/oRHs2g7kYla4Hl4KomRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P/GdMfGYhUPYKSgkbz81VGQCE7b10YXn+7VIHC9MK8=;
 b=t90hhej+X/4Sk8Ve4l3doiYIg/qxDaZ5slzXf2ypJJKhJxmPhBbU1T4FqB2tq2s5lzgOqQtAiHOZLyDFKZovdPwpSuM0OknIY907YpRRWSdNJ7NoKZyuK69EENuxRCZuSOnqhDdQ5PNwBrE6ef5kOHX5S2tfvnRaPRXqAIiYSbg=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 10:04:23 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::a2) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:31 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:30 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v19 15/22] cxl: Make region type based on endpoint type
Date: Mon, 6 Oct 2025 11:01:23 +0100
Message-ID: <20251006100130.2623388-16-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8097b15a-5176-43ad-9347-08de04bfb9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddQC7RTvWt7x7Ai52NCnyBRQPnUWq44siHVsrHp+s/Gwjr4yzcISAsb65JJP?=
 =?us-ascii?Q?XaigHUvRXM8QSYyCAYtcG4aA7PU3lbH4c/yjGlASXfExo+hjWlVnsbr4q5Tt?=
 =?us-ascii?Q?hlCbQHW9nIK40/GDi8zw8lRWXNNixajZUj2owUMIexK+VB9bLRy3+T5b7fqB?=
 =?us-ascii?Q?mz/JqAQJPWA6WofjJUJHgRZX9bHu6rda+fSWoj2l1pmPDolcoUZTkKaSIT2K?=
 =?us-ascii?Q?K8I0eYjtja1OdRAdWlMPERHkc/qdVl56KJ1JdlzJuGW2dpmm8+UcQI9/7JyN?=
 =?us-ascii?Q?hN6u+e3Y20Xo55VBO1jXCQD5MYiyao/y0Cn1OzAnq9zK0KbXvaKUVWQXRm64?=
 =?us-ascii?Q?8eDA2QEl/piJMf3qjBDoYGVoW4fA92C6glZvKStDYCSpYyNHh3c2W96pUbFp?=
 =?us-ascii?Q?PwNLoMBD42yC1dUCZ4+/y+G9QwICoDUzVt9SbuqqTa4t1690y/EAfOccITWP?=
 =?us-ascii?Q?E2+ucONy0JnTcU9vzVjpvZ+t8CrLpl1Bnuwx5836AyB8oKKs0Q/hd88axDxN?=
 =?us-ascii?Q?DJmkoL3wnUGTAv6jChW/EDsD9Hhs0RpfBCtkDype50zmsG/V3q/gy8ga1h9q?=
 =?us-ascii?Q?MwaOQGGHbACPqx1gB/daR4ZVvgfWKmI3vwqz/gplEAX+V5gW8Ey9hPjRGBfm?=
 =?us-ascii?Q?vhgkSuZZCuAc7JJewLOxyxiBjsWF7adYukaePW2ysEjEcte2dR25xG7GpKpH?=
 =?us-ascii?Q?3SNUGxijnhOkYHRx1+3t4m4wiVCFzaCXSUlVMq5gqxH9rjuvkiwqg7e3+ue+?=
 =?us-ascii?Q?0GyBchR0cYw/l8zEstDSC7byDW1seBiI8tWGqjf3G0Hi1I+O6wVxVFKvPTTZ?=
 =?us-ascii?Q?o7Zr36CZElEkP8f4GstLBceAe8QBIA+I6b3jwyPdmxG1LeHix9IWLeUz1m0+?=
 =?us-ascii?Q?H3HKtpkuFoOOZRZ4YR81dEniFWIpM9DicXpg6bMnMmqSEadj1IB3pvar+ArB?=
 =?us-ascii?Q?HrNrJyrAY07uBw6fOiXIyGqpG8teKPGorfhSdZcmRiD30zjtcZ4CIsQAdEMQ?=
 =?us-ascii?Q?0FAPnm5HCtNTOsMjxf+UqzYXF3+ugDLrS1n55BUFOdYor5JqSiNF+6H9awo3?=
 =?us-ascii?Q?y8YNbHxJq/mHZXi52hrNG/UmTgQM96CIm83wnocSo8qdaFI5Z5z2yj4uxRDv?=
 =?us-ascii?Q?CdAYenheP9uhqk26k0OIjU6qUZ9kYPS7/tktKNaBU5obqrXeTPNX00C9wEZd?=
 =?us-ascii?Q?vDCfoPEcaPM6VFqsQ5zuodX9mMMN6/ViTSYiXvNojP+bkVdGNd8cnVBecyQ5?=
 =?us-ascii?Q?bUGpldgpgKmb8oul8VlfmdXXrqivRvn3kTg6HNOs/JMPs+PExwnPXWYECRqU?=
 =?us-ascii?Q?mcPRRxG3+2FmFZrVU6Fy/5VaXnC8RBQtI/qZA3BWF3iLGW0ei/cOHqHu1Qlf?=
 =?us-ascii?Q?uv2tChMI30VQpTmAivBgjyEYBvGCVLHg2BW9uXwaReLRG6vyi+zjROROx6I6?=
 =?us-ascii?Q?7dSlRlMTk64Z/PgoIxL9oHVlh590nKNKzS5UBOJPxLdYXJcGtAY5guqxob3P?=
 =?us-ascii?Q?3dfO4bQSlROx0ssLdbkE5kXKmJt13O7QEMtkJiIgEkzm++TZ7kt1qx6JpmIM?=
 =?us-ascii?Q?1ZOwYvN67tHxy5roTDs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:23.3582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8097b15a-5176-43ad-9347-08de04bfb9c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c5b66204ecde..732bc5c6c2bd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2749,7 +2749,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2771,7 +2772,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2785,7 +2786,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3577,7 +3578,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


