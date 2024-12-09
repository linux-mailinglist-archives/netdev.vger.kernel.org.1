Return-Path: <netdev+bounces-150341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A19E9E8E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB32281362
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3419B586;
	Mon,  9 Dec 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgVjJuk0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BD19F13B;
	Mon,  9 Dec 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770497; cv=fail; b=k0O4UfoZZjWFSlMMT232eASb0GAc5iqAQ6nC2xpRgewE2uAZZTEzE0lt5QGOE4UqCELEAnw1BORcJeEWw3mIYND4tu6sn4wWip+Kuwv3tebnRE3bTce/MmT1VCSK/9zmM1XxLtJEmfHK+LC/MiPvc3K/dwJOXpmUl+Hat4rqTfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770497; c=relaxed/simple;
	bh=gPYFXDcyIVlDciA4wCuftM7UnhiX48Z0kJD75UUmCrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv7nVA+SggmUtw7Ap2qraxHBXitXEs3y/9AjiwnTdQ1pznLsJ1HlDJeKWQZ0GEEmKzHQuH9x/CqtjVaJ3eZ4M0UOQpugTfghpXzXfl/pjx4WLB61DdsQLXeoguw8IPw6KC5CgQog6xnWosQqkIwbE2GPkkTml7KFwvEc13/4oaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgVjJuk0; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZCDOckHC9t1tI/+3wSIXtXRpnna9szE33nLvBaSGpWD1AXSvc9cs+iOtbIizUHDRVcFjXJVPPIGmrltDiG8ahp0t8achKc5cFJPkWZNNDJkXFZa3cP2ci+NZRelnm9LaKin2FsdlcST6W1YeqmZymeoApeuVMg+9PImuFLxhwVrdAUPQkC0xJVMMRAn7EOLuLlmo9SngmZ+YXrF6Vq8n8eaBMMZTCIk9F3IOGnBb2PafPf/1ZWIoDlo2Lq8dC91LHZ9PlPT+QTe3iBTenWuCiFmo4h+fURIXN7jmmKqXR+jWRlAYTNjLpYHmpS+HH5vN/BW66397SB+lkuNZloWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs69Udklrwn5GHhz9se/F4OWpolHa3HiZzZs1yVPqFg=;
 b=LQzte1cozT7t6X0CCNhH8m2w01j5J1qUqyYqAM6Xs9i/mjYD60Y1BdyIJMllfWEzvu0I75d7ec3Lg6CE4vgdmjeTDUJV2lemN0DrjfTTW5O+fM4up0IBvmFgDWrByNyZSOIVu018TqSmD3uUPrJQFEx9+o+qGYj5DC/0BH74BVxNkIrcJ1YHhZPlZSY1iRvjeFtClD1rV6VTLFTax1juS+D/NeNZ52y+yOvSaD7TCo57OHnCNjlcdCM9ZGuCwcOcQsGnY3shVhgO1UuxCzJr+d3d7RLorT98UO3gtUBg/x+vO1baNtYbUsXEsfLZLzjoNLeoyViK3/I09JqDxiviPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs69Udklrwn5GHhz9se/F4OWpolHa3HiZzZs1yVPqFg=;
 b=HgVjJuk02OCdJa2QbHxWbNpDbY/raoHE+xozTFiuLpctzAsCQAfONWQrjdb6haQxtLRemQGN3L6uAhZhmhuJvtt/whYf8ZochYboqdHh9SZy61zuGnpgoG67GbW77KiD83CFxMzW2NH1LqLcpcQnzASTDmS9vDyWzbpcP1vfshc=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 9 Dec
 2024 18:54:52 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::8c) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 18:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:51 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:50 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 09/28] sfc: request cxl ram resource
Date: Mon, 9 Dec 2024 18:54:10 +0000
Message-ID: <20241209185429.54054-10-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: b4844bd4-c651-4853-1e79-08dd1882f6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zzmq5JedknOuFJQIuSwq/2YOPqJtbRJwDSk1wmfRR/S5uNS1GGkTb+Iqt4V+?=
 =?us-ascii?Q?xcQJsvuGRQ+wvkn6+1jbP6FHbv9hxe/gioFCFFe9BuaUm53O2ZeELlx956wl?=
 =?us-ascii?Q?quuDnKjugIpvBzMV/tMUhVR1ScCULa/DL8HEOQnDMocTKQ235BVWk4MRh+qY?=
 =?us-ascii?Q?gz9jJ9s8VGO7e3VERWNJnhzmPVpRHSZeuim5/6w6cfFR779T1OEEvxlXpdt3?=
 =?us-ascii?Q?TTzUkDdOxutc4+CblFk9ltdz8JLkTwct10OU7M/tI1Y9er/w3mXY6Cc19yBG?=
 =?us-ascii?Q?Ygx0bRGZKoPENLK8qkFadni/D0Uy5LWELmDYga065qjR/yaMTxMkwWz6CpN/?=
 =?us-ascii?Q?Wiv8eP22c9X1lrhYIjfxh2+TaotOt37bQd2L6i0G+kak9PTIWFbDIqNepa8u?=
 =?us-ascii?Q?uxtYFf5kX8Zqay2ksO1zOCHLW9osNLya1mNUa59PoCspBp3LqkUsHum4L0YA?=
 =?us-ascii?Q?sXK6e7dudUYHK9DxwYBW8Fvz00uYmFC44QsdIo8yWXX7glnCexvIAFe2rdQt?=
 =?us-ascii?Q?pwWFSS8I0kokByaODBq1Q+JMuNNTwCNqkz5FtAyfB1vWUfVi8xq21KflOIQl?=
 =?us-ascii?Q?g1iPHHB8oJ2eBTrYrI5xKBVCeOdVeSgNLVsVfZYdqgkxugF+V+ZjHwECSto5?=
 =?us-ascii?Q?ZpCNrMtCmkK7JF4clNmRKPlRoP0CUX7qSiVkfSCPd+L9HbvqR2IzY4p6P1kq?=
 =?us-ascii?Q?XPVZM8ZbA2hbpEP1uOsMQqwg6TxBroIyHxVx2Qq+exbebHTFa6ZrlfzjuXF7?=
 =?us-ascii?Q?rOBJ9PZgLOkWSJSu4CBrB2EWv8ty0+oXUiQ5gfUvAgOdi+JTfe6D8smcIXFP?=
 =?us-ascii?Q?C5L7C33rVWCB8xB0UsCjpHc0w581+r7fI1mqXPq58WS/m8YUWYHiJNn5xgaI?=
 =?us-ascii?Q?gGjnNA8FmS12kKtVS1RX8YpcK388Ieg8PJ2pge1+yqRVRfFpDzUwLYAM6oE/?=
 =?us-ascii?Q?FSBp23IEGOlV6I9Tzujpjab/6ZczT79RHIFDQzuDmiosr/qfelwedBTxWAAI?=
 =?us-ascii?Q?PanJsGlCg1Bh6qFwBUTgBOQDMX2wz0JaJi5PirzCChr3LngxCGRBuem18TC1?=
 =?us-ascii?Q?xTZCftM0AEClU1kRouU3EZnedifHWGjv6dHQbGqHh+RSBZyJ08aqkZ85PRCr?=
 =?us-ascii?Q?on1zv5qbRKofmD0to8oLrFhCAQua9rYhtpBkOeo995Oezr5CJvPQBujSlAeS?=
 =?us-ascii?Q?koq8e4vuIDDhFj3yJ2nMhg+jV3NdC9EmYcfnHnlBVLIH8EEo880du86OGgvk?=
 =?us-ascii?Q?rTAePpsbDuf6nOaSgtYAxSHA+r7CqBFLASAqmkB0yVgJAXNoNAD+u0ft4/Zl?=
 =?us-ascii?Q?kLTM7kA5OAc5fWHTx8afAZfUvnVcr3x+ZcTMMtl0XtgEM41WyPgTce1jf+sH?=
 =?us-ascii?Q?dS4r2okz4CCfqEokeYEgoXf9injDXU/VpJC9S0bykbF3FCGRMx2xJN6nwupj?=
 =?us-ascii?Q?1MJXLW//jcyXJcLoxFg3BiYMChG0RCT3hTkM9U4D7A3BX56//0SzWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:51.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4844bd4-c651-4853-1e79-08dd1882f6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3f15486f99e4..6d7a7b38e382 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err2;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -98,6 +104,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


