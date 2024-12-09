Return-Path: <netdev+bounces-150355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF459E9EA0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6976318825F9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0D1A2554;
	Mon,  9 Dec 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u2PpwHaz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F41A0BCF;
	Mon,  9 Dec 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770521; cv=fail; b=FnbhYe/ZfPDsoDQ/uP+8PUZqXdF0xwCOdyg26clvr42W1XqH+q16walblEqMxzx0Jp9L6TGW4+O4/KF5dQNGgGWRa2bsFmDD301t+VoXQSgQSscWBIkTfLJtbAIu8Kk9uIAW/TXPRR2BzBp6GYk2GmfsKqu4L5+YpGqWJe5Libg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770521; c=relaxed/simple;
	bh=/wRSx97NorCp1Ew7bFW7x/op7Rq2p7cz1/C+h3LXQe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABfNxnkRi1fm3Bq/1mENGjHnF6c8mkJPitj77jLrf9c8/0uhwf38dZi/FbXr/6K1tdzYQXx9gH9pfwgiakhrzgwvyMjz0DJk36hdjoy8kTLs7W+wfHO/z+zEZN99imCsVO4xt/Ho5Wwt60HhxTghnU6m15ESmNqlewobQMBksNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u2PpwHaz; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buxvoMNKoWzCDJ4KJXi7Z0SD9kdMMr7b7v+kewXYOCE+9SBPSaDto41RKIXcqJqshDIw4NfDoQEWC8y/tRQHdxD3BpMAxpmChG5t9V2oXQ8COI7aQAymOyMiWuw2iz4p/TojkqunFZ7uH3ADdor3SK5AfBbJHhVG4EEhIg1rTcLVrpEcwdYY+NI5f6QIFvtaWDL+ro3HFQfCRRudUFlzDq3lr9TuP011g4k2B2kfsgLza4gdlXtHoxOyCniRTmkMIsPU11YpbOj4erRZasAg5+uDclBB/TSVHKo5YLaNSwzTpzXEWgpOB6dO3S48ZDILMcl0OfuYge/a1aLXndqKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff4vAakNNnmtt2W2pH85x7cFJnPFjgxv2VyiRQWtumI=;
 b=TRy47fq6DG/dGJOoIWEIEokjrlJHQaJLOT5MLQ7Z1xIT8g0kqGHtpcEjVhUBWgiByQwCYm1zIbIRCw3fa48Rw0FOiU4MQj9AlN+pF0DFPw3/IcFJv2MbhJqfgInDHa81FN/IfRZz/ywUlTiy2apB0r49MyNuzUVqIQrbL52TilGzk42ZJ2xsEfYqrEVRfM6WZabyRfE4eYAJ8uCTqHCL/f3RFRaExZqaGPlUer7IAS+rvI8hiliEDSksrWs1uzHEh8nbj/t1iV+jCceRCDQuLJweBteuF3MP+aFFNslVCQOZkSXWZg51bJOZbZBs+N6+8fltp856U+5vK2cpoeK+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff4vAakNNnmtt2W2pH85x7cFJnPFjgxv2VyiRQWtumI=;
 b=u2PpwHazOZXpcApspXI0DfZmJGeZa2L8sY+40DUP7imJ+ZFSyk9nrnRi4mJdguOYfWBJ9OEeZj5aooUIDeAt+idh5Bb7GaQJ4X80c8PG05HsIpDwUUiH+iGxPHqEZ/u8i2MVIqPGLQaCOO3qdz6wzOz1dmXcpywmbP/6zH3Bhgk=
Received: from BN9PR03CA0799.namprd03.prod.outlook.com (2603:10b6:408:13f::24)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:15 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::9f) by BN9PR03CA0799.outlook.office365.com
 (2603:10b6:408:13f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:12 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:10 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 23/28] sfc: create cxl region
Date: Mon, 9 Dec 2024 18:54:24 +0000
Message-ID: <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bb2eea-f2b6-4a59-0525-08dd188302fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Kh8IpTgJpAfOIc7hO5zzo5PNkzsDWf4w4l8/EmnxLj8/Bbn6ar0nTi0MOSc?=
 =?us-ascii?Q?EZ6aDBhc57uIvV9keWLXFdbeKh4/2I8ciN0oaGtnmZAOQXNLpchd8yDWXpk1?=
 =?us-ascii?Q?tjPlWpBT42lPW5yRvyYvqTwaTnOUqDjXZ7XxNqmMVDSxu701BKlYLswflt4w?=
 =?us-ascii?Q?WelxnHOdLQlFLmNHlG3JjnwE387lptPc+ga+6qP5LNKfPAaZTgbYCVTTZ2Lh?=
 =?us-ascii?Q?G6m6eZ4gTF+rJEKqtNpREkdCtalq6sly5j2FgDkZQdjmqtJz7laV85FMNnP7?=
 =?us-ascii?Q?UaWs9Ut7ZomnNBsxghZZXoGBC9GlVKwKhX67INS2P19e15hXqPnghNvMIOUZ?=
 =?us-ascii?Q?BHOP0VVr/5e2RZUdDwufOfsHzcsFfqBvJVMuhWFg9xy87Mh/s2ToO06yjOTN?=
 =?us-ascii?Q?WmrC1G8w8KP1hzgngWv9j8kAAQw8uAMB3ymzCd0ytaH18nQBE22Sdp4WeujS?=
 =?us-ascii?Q?03RmoLwm5y/G4LiVQaRU01Qt9/LeAz+sFvT8fU0rFMGhOLK1tIcEq69/59/J?=
 =?us-ascii?Q?XXHuJ6TcYC6WyaW/Tk+8BPak+b2SYe6fk6tgAWXIrLUngPTsMFLGLFv84G8E?=
 =?us-ascii?Q?ELbKgWIi9LaLd01FsglES/s8t/1mVo716xejk7ISPtzNKapJylRyovU7wpss?=
 =?us-ascii?Q?OQBKvXFUL0UkHGy7ldA3mJzOws/BcmIkbwTnQT071xu9Yz3iAwsk4hLZBCOS?=
 =?us-ascii?Q?zaFkLxmYDQvENI5s8gNh5vXtJzGTZLoJmpxzQS+S2OJvaBgtdIAZctpRgTNq?=
 =?us-ascii?Q?KvrXWSIG8Iv9eMLf2Bxhlacpmr5PmYBGwUhbE77O79sYcihSE5ePv/dQkO/0?=
 =?us-ascii?Q?R14sc4eBbaSd4J0ac6LeyO1ny3XiDb4m6/jdu6y/pG8v2s/GK+z6sAibvuBw?=
 =?us-ascii?Q?FJwXI7+9gDTvnabrZPxUuQGqLJm9l1Rc+6Vk3fm7z2inqy2e8tfIbvNO5LmJ?=
 =?us-ascii?Q?bslH5bKX9P16e4Rkb0VwI1nSqTNSPEKqE037jCOvbswlaYWV3/ufZuatvJr8?=
 =?us-ascii?Q?zCMxUbntxEzLaJI+GXK0sv4z98/goOx4FookaspvykErEK4GX1UaLm+IZSCa?=
 =?us-ascii?Q?pnBMhvkDpM4BNpjbTF2CH7GXnVi/MhKfj56fM03eHbChqOB1A56skAs5wzhd?=
 =?us-ascii?Q?MGlcszJUHMH2ZyUBJny4JVqMF/oPjqsACeDgdMxPt0gfvYcUwPCc/DGIoHhl?=
 =?us-ascii?Q?KZt8BItDOheq6umJdvdkZ2PzQ+qXcfrq077uLZExwM6h8uNMXqeuj5oS+MrE?=
 =?us-ascii?Q?wWcYIgip1PLSjuyKZsr2ISt6wg79hzwqWIYuE0z6tiN6j2yftAZo79VHog9R?=
 =?us-ascii?Q?yX3pUk+Dtcz7o2taF41zMUGo7kIk3UPFFffJRvtYvboXUrUrSBljl8J3DNGC?=
 =?us-ascii?Q?4UWexzVxD/8MBFmIJQKnORllsz+6a+oDi3JF9zKbEWT0kV3ZFOHxHRAhMtck?=
 =?us-ascii?Q?FsKypX6g75fTGw5/1en7W8i8LOYqcHss0pEclMqsbAFfbTdwPJ3cHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:12.5681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb2eea-f2b6-4a59-0525-08dd188302fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 09827bb9e861..9b34795f7853 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	if (!cxl->efx_region) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 err3:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
@@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
-- 
2.17.1


