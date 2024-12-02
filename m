Return-Path: <netdev+bounces-148169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F09E0B35
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3130B3BA63
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D471DBB31;
	Mon,  2 Dec 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BGfrQk6n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149771DDC19;
	Mon,  2 Dec 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159578; cv=fail; b=p8eh9tNi7N2NE4QpJmVWOpJWLukdQ1xcZpFesrAh4NDZaoNtYnB52LjpoyaWTuwhR/jnWKHg8ygJ+HnBUBOE+wDwYr+4NUU4nol6aivumFNX26xftz3IZYqM7ZNTCoMmTCueJRnN/Fdl02rQkTqlwqAbNbZIfPWhUpuvSvnEmi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159578; c=relaxed/simple;
	bh=TTPyPh3tQizNsbmLbRfXiXsEn16uAW92xY2nNLLLBVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuSq9F/VqqOTjR3WjW4IjaiYC0ZkgbjlZrlxV7/8j+HFhfzrTjlHkNimyKRMRA9BG1euNCgcKczjnf7+qfMFIdm4q13fiXICFMmCShxjJhTPOTEpN1nZ68G92Dl+ZmT6OQ3iGUZYLTOdwnkxZE7k+zFBzOWjFxUVB8N2M+V3KVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BGfrQk6n; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdtNONd91yC9QPUB9hKAk5baMgmttRkhmC9gvgDOV+vrTM6X+nV5aH+rLhniIP+T03gcKv03AACRosIxwCJWEN/8Macmv9MP0oNSZ1N+PWcXPV/K/k5Is7ZEx6o2H3551XFvtamnsAPfkg/mo3IaZZrnlWf7qjQaIdZT2boI0823WN0Dd9yRXTy90kWG1dX60M+g5ry314mR4tQpsh8tnJLv94dCy9tp/1tudS6M2Xk6GSo2tzPtPXRJHXVLWxpNCt31HjGBDMfpY4d/4xEn4f9mi9Yqi8bUm7m2BW/d7SkyQiiJJrJBuyfPzheRw5gInT9Fb1mlu6BHhO0ohgUQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Azytdy4fCuiKcHvW/a5a+M5CsZKFFfB59fp4IJsczmM=;
 b=FTlppUeaKSfk0nwyl9Il41VKeZnLirCZxJr41m7SfKH132xd9DZrRxCPIoTSkZhHwBfjahPufDs8kaB8YLv0eZglurQMzslC6pdzPv0jWtHRFAwUVcT7TEM87dWaxgHJjaIpd1uivygLMiL4ebm+xN+3fCMOYOp1TdZXH2Da4jgBrhfT0wcQoUNCqJ8Ao9FUm1Z3I9OSEa8qyFvjM0AwTV/AB3mKP/xCKilcgNPzi9ibrX1UGqzyWQExZ8ovLV+i6yGLoCkxng4vV9UbG/yA4klPp6NjmC/8N3jXYTlrYqGxj1+8S3CpzdnmH/uwR41FUgo6AR0k0sJ+PkpFfW8KtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azytdy4fCuiKcHvW/a5a+M5CsZKFFfB59fp4IJsczmM=;
 b=BGfrQk6nL/2meAoYJmxiKtb3n8olilkxoAfJN9gfm5M2u/tImSXcdxLJ8dErHc1A7sT3TQuQba2rA7BbEnS0QmcvA9n29fSBXb/MsEUdWq/Ml76ZJfICjBmrwDuKm0BG5dQnmA25bh+m9WLn8PwiUHCq7iLnkb304B+ifYnbEzU=
Received: from BN9PR03CA0718.namprd03.prod.outlook.com (2603:10b6:408:ef::33)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 17:12:51 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::95) by BN9PR03CA0718.outlook.office365.com
 (2603:10b6:408:ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:50 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:49 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 12/28] sfc: set cxl media ready
Date: Mon, 2 Dec 2024 17:12:06 +0000
Message-ID: <20241202171222.62595-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 14430fd2-6840-41d8-e8b5-08dd12f48d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlkcP9t5/9jnuq0Jt9ixPgQdEYNlrBrCbzgaOW3eUiKs8+WUx3US2EJiIM/z?=
 =?us-ascii?Q?OpVK1n0laQMNz8+5n8nKjg4l8xoLPfIQ5sHCirjYfDZ3Fml5vC03kFG22ad2?=
 =?us-ascii?Q?fBqt7fpHhSJTd38qCWbrQR0hOaIIERzZhfZmiuvIwH1NxKLajhfHj2gqNpiR?=
 =?us-ascii?Q?Dvffj3FPKyVCT/NB3viKT/Src2/8L+JDHhWLl5BKz5klS0PI9uK/3A9RNcyz?=
 =?us-ascii?Q?tb717qDErTs2Q9i5vdzeXXTRPVFSiCinv3OiLZ78d/745+3fAu2b26847OwM?=
 =?us-ascii?Q?HmoPp8M7eGAiKE9+DoVJgiTXkucx9U2aLissDCVygBxGC3K03/tXWeX42s1o?=
 =?us-ascii?Q?AWW7vuLRReZqCpGvz3VEwSMF+OsMf1SFfRRqTNcoXVSqa6shWpqVMi9l/jJJ?=
 =?us-ascii?Q?8SuqyOvTGGZsqYM3TCLIg6xtooQOHVmn9WDGSFvF4UIYvFywoKSuR+CFY64m?=
 =?us-ascii?Q?M4nvzf7o0p0pzZDdHejh7gQUz5lQ/lzYL37OBfhBpsgSQgD0TY2OAEneHKSa?=
 =?us-ascii?Q?Nv0zeozWJPfXFMllkc4d+J2Jqf0WMYilcCAEvZSN1nxFjJ/qqBm7ysBxC/tL?=
 =?us-ascii?Q?czURMs0fuBdxy05JrL7trmVnln7lxH94wh4wlQ7+DBv+fOx6kngzjqlIMs3p?=
 =?us-ascii?Q?0Z6627WXHGW3eJbTiWKdq0OpV/9WSjX7RAL3SwExghEa9QCdvOUrs2wOWTSb?=
 =?us-ascii?Q?B6rqcpwBd4PPpACFAoZzmQe2kndii1ZzFgZ6QI1+4G0goW7edmYlyJxmWkix?=
 =?us-ascii?Q?skWhhBxsKT1cEW0l1qRWwP6GuCAK+ZXvir5Ge/Zd0Q6RvSAY4EweWTqUrd/Z?=
 =?us-ascii?Q?NfJ+wv5NmZfuVLZnTZuM+LlrwLZTAyLOcf8MD5549zli/uFstzuaO2ER3+3A?=
 =?us-ascii?Q?XbjiJqBQVwEvdw5AjgfTmydLsoEIj0kN+uocNZ/yULzutBABQ8wqVNN4BPBc?=
 =?us-ascii?Q?mZGjrLuHoha3cFSovvhVqKoGzBLDFswAqHGFWXsLpiAAAZijX1t5Lpo8lRII?=
 =?us-ascii?Q?HkeLVpOX6hYZkPcGrY+ccWyihEPq6dzJx4lGIB4eBjtemdbM3Cm3PIzwGcRN?=
 =?us-ascii?Q?GD4Z4LjMhjHL5yDB0wcTJlSENJiwvdPrYQqiVnkCy0eWYlK8HkAzsVnN20qV?=
 =?us-ascii?Q?+ZhyeistWxOlau+i0dZiUPu+Et+Hs9S6oCbCJwRMQ4QBLDUfzn0A0qYcIHft?=
 =?us-ascii?Q?qtz//8nyLRm/YPMQlygeCTrJ/xnL2k9pBN855mAfjL9fLRevzI1Bg1uVCf3s?=
 =?us-ascii?Q?M3xQUi5SHe5q85hc+zPLLj9sOG1HYyEVEQ3ekE8SAdawPg8IwWSs2O9MPaYx?=
 =?us-ascii?Q?tT/IAdT+EV4wp9MQ/fvMruABn7c9ShrDqmSuSTOV/2CQMrjcXQVvx6rBV/Ka?=
 =?us-ascii?Q?L/WFs19SJtgjwOZS5jTTKBi7fs+PcSEYFRIndg8u03AikMSjXQy9QY6kLoG1?=
 =?us-ascii?Q?vYrHeWnSHI6qr3Cw85B5FYzE0KUgo1OmZ/H1jN6s4rMylg7MfUsmOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:50.9127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14430fd2-6840-41d8-e8b5-08dd12f48d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 76ce4c2e587b..aa65f227c80d 100644
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


