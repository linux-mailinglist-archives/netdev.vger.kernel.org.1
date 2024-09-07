Return-Path: <netdev+bounces-126222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D649700D6
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7406E1F22B08
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27279158DA7;
	Sat,  7 Sep 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iSCZTpcN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83C14A614;
	Sat,  7 Sep 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697193; cv=fail; b=RDtSK5bg2smP5QZFC274xHyCGQXiY5kzSTjFudUBVx7qKXEgrscUs8fdmAVOns9p2MAzjgt8TNGbt2wWlFEcqnIfxd57igIACkGRy9RMKxv5XCgATPfZDLrPOnOae7v6ijcMrJ5qGwjcqmu/6vGpAl14Z9F9nVRVoHtRy0r3Glc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697193; c=relaxed/simple;
	bh=OEoxtDUOdCUgkvfkC0F2pDkPqVNtXDSyghHUEs/WVts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BM6j3rnzyrnLAswrs7m6r1kRJ8x7aRaC1Wu/an/VLUsLUcH58PKaXNE4ir7c734oYSqu+34mue6RPuqPaRhgIok1Ht6/Na4YyVJbhMzZNMzRF1q3x9HRfGoBI+jt4ipZyKHm/snmFRa01JrGrc0wOKL91uGdReSFD+f4JkSIzNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iSCZTpcN; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9NTfT//Vxkk5lHUA8UIV+f1OszlG1apMp6HRwm/taIlsaern3II2x91B19tAPQkLW9YLO2Cd48OnKYLJmn1s+FHKOpNg+R9EpMQEjOvhVgIO02jiPKYjBaQlcO0XSdm37f9qzP+G2w4LwPQa1MW9jrX5A5mD/rtH6tjmA41OD0R9sq6j/XyODXwXgAKOaS0A5u5h014T5LHyqiI6nTeWp4ehZ2ZnBzb9QBNKvsQKywI+o8Bh6SobX95KqlP/v21ojcx3uceUEYm2WiehWy2CqrQ18GK1m0aZPTHat6f0jRpPCUc3wjaApZKXT+ncbg4LX7Fh45aiQk6GDUPIM6hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KracG6sScg50+g9r9McAM4i1z1hE4Kt5z0lhBGyXv0=;
 b=U9e7QXM5wfuDRVYrphUTfB8i6sZUeDK5rcLISDP32+tiq3++rJKZG1dlXx3pJrBUn9naRmZ8kRG3cFFB/YOwy205jwbkmkXxVhua9H4hHcxfqDOk9rbgw1mBR71XZfVzhTIx9loyAkg9I8vgCIcJKjhx6r+7IA9RjxetWbFF/e5i0bYQVjPlO3Fbo9kLT1Vm+NizEpfP5Sq9eOcmdJrSq3RG4mNeBGpLzY5yU2CAJB2CG9FR2ZIiL2PPLISFJeHUjM+x3IzFddiFgwgxuoJ5uGG7wF4RfaO02MBUGF/sNwWRYj/yrCKWPj1GcqMzW9zlTUgdgZbapy/pA1L/M6IsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KracG6sScg50+g9r9McAM4i1z1hE4Kt5z0lhBGyXv0=;
 b=iSCZTpcNtGFTNkj9Lkq7EqYQCXKhD1SjaIjdhbtKxK06+PWyxhE83WjetPmuL47MsSiVGO8tihgCKPW1t+UQ30GJQg07M1nWvvZRl6K+MYHwV48pDp2JmC1tITEJ20UItXKFVVWhtZeZ8XuWSrYX4dXaOKF+3B01vjSMZ42138c=
Received: from BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45) by
 SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.17; Sat, 7 Sep 2024 08:19:47 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::87) by BYAPR01CA0032.outlook.office365.com
 (2603:10b6:a02:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:45 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 14/20] cxl: make region type based on endpoint type
Date: Sat, 7 Sep 2024 09:18:30 +0100
Message-ID: <20240907081836.5801-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fb90a9-882d-47c0-cf00-08dccf15d5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NaiBd3E/IKeRnRrEqbgc3giXPvcx1Jedv4fXoqExty+fAYq5JQNmOvbW6Pm?=
 =?us-ascii?Q?IoWJed+bqknqWlIo24SW3KQSViFBTwOnjWHjXIYtO9csyb9eMTmVD8Fr0QmU?=
 =?us-ascii?Q?oJEhqLwtoqf2JdUTpjo0GKcxwhcROEHJ7Eug2N9wnHv9rmA+7XAdGhbmEzhW?=
 =?us-ascii?Q?SeilMUq1ZJcopSQeQ9+xQHqAenCC5H+h2uF59KXZM0AJQ5Bnyjb0KsfGl0rG?=
 =?us-ascii?Q?3Zz7H7l7rJvomGQPZGh3kD27j4IWzld8rv2OF940OVa9Fg7i3Qz1qCRQeP7o?=
 =?us-ascii?Q?sHVdU76lpmVcCVx0l/aUleNA54ztvTGS3t2AIS8Xwxj5H3g2CPyvYANGeunj?=
 =?us-ascii?Q?TSCKIz+Tf8HRHkBEYO0QIE4QbNcyeg6RSE8D3sXxj8dzLxrY9oX0+ngxS2aR?=
 =?us-ascii?Q?iAK99JPQoIXDe9ddq6OVtQnNKgOPZrE0HJioRJimR/EUol9kktjf0n+OYN95?=
 =?us-ascii?Q?wS1X1YIt4mAqUzFvogZW0eMq6sRB2NKCv7gBRg+k4iCVfRzUhNqJ3pGa0J8v?=
 =?us-ascii?Q?8U4cZ6SNr9jaGQlZaXgWDB36qmJcSvBoVD6+S96Z16sfvaHkL3QUkZSoY7xX?=
 =?us-ascii?Q?i5lI9EXoCOJhYCjEEHjSHR7gmZrqNpPxh+zHFNiZUBwzEPU87l1+Ci0/sv86?=
 =?us-ascii?Q?KCS1HGbi2JBpaGEUFJm4862u09GYh1LcTLyBQfuYmhTb96ZhPlWNwjnAXfpd?=
 =?us-ascii?Q?Zt0CT1tpTrdISlJI4l5rUU/ydVbKTR+EOs4P1LxrNndQ6kmgn+6S0Zo3dfn3?=
 =?us-ascii?Q?GQmd2jsLt4ymZrUs4N3bjfUJgampR+5KtTFzVVldGtiGv03/vlTQcsMOGk9u?=
 =?us-ascii?Q?9oQ1N7bGreeIFMcBq4WDeoeUiF3soo/snBWFKxaverAugts3WbvyOg0V8GCY?=
 =?us-ascii?Q?hrquXzFX7cWjK0rbhB7sdAthJHk0nrJ6UzeHvYYUuY+6FTOBU0VAspOyNIEC?=
 =?us-ascii?Q?GgnIMu0r064c5yCX73wet4zyg2J2v5MCCfFl9VHzKXTpjeEqJRM1j7oLQFIH?=
 =?us-ascii?Q?Oht9ePUqC8BCyrhnvz64szeb4l1OmwgHosLM5d0TVfv5w6ytRvVtiXpuoUa1?=
 =?us-ascii?Q?LXBJ9dHB9zAzIEeQTDOA1iFaBRcEcsaKOlQkQKb3oa5LYHV9BKx34hlQmQ4q?=
 =?us-ascii?Q?paFMHDrq3kUwrzocUBb9JB6kBcq8ryhYOelagDmQzmw2lVVgVY13ttvvLQTo?=
 =?us-ascii?Q?P1h0O4ZGiCzRGLECoT3xjnoJ2Z1+K+vq9ifdaL+PrXc2cONuRT3dMEb4D1Jx?=
 =?us-ascii?Q?aulg4RZAWfUwu281lnZ8eyrprBWbM35WVD+dqXBcHVTpklM5/JIheiIPb5Ui?=
 =?us-ascii?Q?OoA4C0BpuvW/TKMvQZaD17PFSXuOs7KdaRtgu79Bz3qOrFY7EGvIIYhnmNZO?=
 =?us-ascii?Q?Hs8rzfEbneUSNq2Xn7rqvdNHbVLcYT+Tw8LzVJs0YrTnZfi+AIzbi4KIkVDt?=
 =?us-ascii?Q?jTJIAiV1KUQrt1lXLeaXdfjVXQGXWVZX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:46.7264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fb90a9-882d-47c0-cf00-08dccf15d5db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bb227bf894c4..b27303b9764c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2664,7 +2664,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2686,7 +2687,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2701,7 +2702,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2721,7 +2723,8 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3381,7 +3384,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


