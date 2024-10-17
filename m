Return-Path: <netdev+bounces-136685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7C9A2A72
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91EEB29290
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0361F893E;
	Thu, 17 Oct 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="quftC1b8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969121DF72F;
	Thu, 17 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184036; cv=fail; b=GpY/h2LfSsWv/RMBznJYuCjJXtNKMgF6jLAslmz65UbzngfXqT8xzv4ws+Q0M8Dd22/T1lCcSmt39lPXrfeMoUGTzZ1Yd4QR02mCZ0xGrVE2PfHMlKJkoFcPIV04qJqCnwaGnAdfTO294lpLOEprzalMl8tHPpaPauzrgs8h9fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184036; c=relaxed/simple;
	bh=dHbVp4JIrDOFYID12cNkyk4RmyYQUyN8nsS8VYSRidg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNkVotioeee94guLf8X/XrZOr4g3jKisBjoekDBXQJzv6YSP03/USf+PNVT96o7b5THZbBFBdlFE3uuRMUnVD8huJIpC1ntbnGtEP/YC8s/fIlqkMmkJO33uDg4dx2VwNIILu3lMlmEntJYK7DmKjQ/Xw2OTP6Df4wfFm9OZZmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=quftC1b8; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH3Jx3sXpYedQusz5Uzbx6DRdcd2EXt2WLT7a9+o/rq4YU3FBzXC1cHE6qgikkA5b8X1PyRvre39qNQ/lcaRKFwS3NPT9B/+xcxXOdBXl+Qo0TlxaKtjztQsY2d8njvJ2h4QsqWtNUQklpoDzrYkPG0+3OhWOC3dLMb09ycpCVx91lJMErqUfDn4qFBnB3um10uXF+nnZy2433UWGQyohmqU85nB+EKD+p/rfKrs5W253gyC1WXNxDQfN374tRt28PPnA2VZVu8sOPa/IlwCz1JbmbGdvzpRwe+cwxpH0NyaOQrmh6qVeUkwag0WOqcmJf8rzXnuwyXWZGyd7rAPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEyQrA318a1CUBce8DoYDDpKMIExBf2coSb9UkIo2jA=;
 b=UIeJUzh0098rT7iqfE7YK09bAv4PSF1VFI/Mwp0/ny+mCaOsf5ysqPL2TMcKYCBiADZiU3p6mTMQMq/Q3jZJAex4qPHz8gzvLFmrWpawjM17uw7tA2oOflR/b1PO/BW0ezzrckBotwhRZ82YvKIDK1jtXAHjFPILCdZb4ogOrnOyRw+t1gu9g0vPLDMzpVpob0bC8EgoAw9ZoXZagenLz33FmqEI8WzdmEOPEg3wgwOS6Cp5DjxwW8xe/JHBaOyuvwb0NwbiF9gLGaXTiBm4a8KTLUSh4KFrmJt/GZNzKHUSVPErXxH+V43WUwoOvXKKLMvnExmK3CgfIgaJbNk8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEyQrA318a1CUBce8DoYDDpKMIExBf2coSb9UkIo2jA=;
 b=quftC1b8Yg9eOL7eHhHI5kSc7c1X6qUGO/DEM7Muakrhb8zNoQ9w1mblhVSvxgTCQGifLOtY9xcxphZFCNdeoqKzDxzBPi18JKrfRiYGFCgs5cginTUlWWF7s7Wb0/HiiqsHTJ+V3gOrho7ueU2MtDyUX435SO0/MtHEAL3qc08=
Received: from SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:48 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::a4) by SN7PR04CA0102.outlook.office365.com
 (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:45 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 23/26] sfc: create cxl region
Date: Thu, 17 Oct 2024 17:52:22 +0100
Message-ID: <20241017165225.21206-24-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: be90adc6-a1a0-4960-0dbe-08dceecc453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EePSfriGGzNFDQ6Xp+0LGHA4bBo3c9EpbwX9xU2ObQn2HaJpnfHoraJhbmaq?=
 =?us-ascii?Q?r6wbcqgWSsERxQNeOIC4W7xKOVC7tfkNnokkIwQoffkzWCfOjPqFiFW6nEsk?=
 =?us-ascii?Q?gkhfhs+zQ6MzJmpqkGVYZ/v4X6qvkj0GSbd/IWU6yfktIOKef9aCrAy4nk8e?=
 =?us-ascii?Q?E2DFxcJgbpog//dG9Tygk7t39fJb+7tG1yuwC05Y3GBOE3Yy7nCgPWJTS4WO?=
 =?us-ascii?Q?N/tra3bGejGxP8bNxMzMxrFdXPPSc+P2KP5UtRa1+vV4l004HPvMjNhnpHsC?=
 =?us-ascii?Q?yc4FRKXY6wce7l39NByY5pTtTFGixqRyEH97Hc7His+aBa35FajACjpzbxvA?=
 =?us-ascii?Q?tv0L83YIeRXotENlUglCmCOCYIA9zmbH+DyA62F/3OaCZkVK4qSmlYHc5l+6?=
 =?us-ascii?Q?yKgGwEAU9dxic749V889y3QyobHU74fiq1/M2ovv/7W/YR0svqhIZuxCx7OT?=
 =?us-ascii?Q?3fcwawx0FTXfO3xg1GhRgn8ytSROe+wRcHUh62us2F0TpawBadHZz8IFENBC?=
 =?us-ascii?Q?Yyt/dV1WIuH6pbUDEF3Gnm8E+Gvm4zWEZ9Tvk13jPf0pY8Dn788Iff35mEP0?=
 =?us-ascii?Q?lD4YH23zb5kSnYTazy9dZVYLrqNUsxGc5r0iceK8vGJIePWVXy2mQOXGdPRQ?=
 =?us-ascii?Q?0+fpI8wFRxVPXXYbLUKo9ckoxkrmOJI3x4E4E9BK9mgneUF1QLQvYUTk4eJH?=
 =?us-ascii?Q?3SKha8BOJrW9aNdbZRjWnOdLtzDo0iQq2vk/stnH5bmJhkGFL7wROo86h05y?=
 =?us-ascii?Q?dZ8tMWDSmO5vh0MxZIWu0fVyjVJIr9ZFrcSBd/YqQ4zk5XLAhio518rwBrrk?=
 =?us-ascii?Q?93jrO18OvepzRgQZn1vLKjBux68AylZ0DKYvz3UNh0NdcdyM1cleyudRZLZB?=
 =?us-ascii?Q?BNJ+8v+mcxlzrdGkP8Thbg3US/3SgZBVaiernm8lbqyoOzjqCQCv4MeA0cgk?=
 =?us-ascii?Q?Y3KyXwXrTfZFljwjkZ1kT6Uvh+WtBB+awcmowjbAy/coVRN/24+mexTeBLol?=
 =?us-ascii?Q?FcYlXpInW2in95acmdyyFCQSsgM4J7QhkKkWWLHKpDz386opv+a+1qGWJk5L?=
 =?us-ascii?Q?pTwOKd1MRimU3HHoqyC2bBXMr3Q3tn/zHNRZODBqWTn+f0zm+maj8bVcTAm8?=
 =?us-ascii?Q?fVO5bAlF9XNa/iPgi+s8Wlv0IKJlRNcteseUCI4l1DXrpZIZEY8pkXnnU7Eq?=
 =?us-ascii?Q?67eo6S/WX7k4pi/t7DnWdtgi2FiliDdvb/1eU8l5hJxEPAFFJ8LfG8WipOPC?=
 =?us-ascii?Q?VkRTi+CsGOKcTLZIqpjoYbspczP0Mswgg59JsuTNa5z7QgVB+3tamyy3v7UH?=
 =?us-ascii?Q?i1s/HjKT9eckEFi/OdqspiLPLisVs7pHiq9VLPv8YT+cw6FpxvjJ3GTDau9U?=
 =?us-ascii?Q?U0Z/wAJunVh3M6izs4Mrc4hCfD8tA/YbGxOLIOGrto8ZQUxbNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:48.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be90adc6-a1a0-4960-0dbe-08dceecc453d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index c0da75b2d8e1..869129635a84 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -127,12 +127,21 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err3;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	if (!cxl->efx_region) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	efx->cxl = cxl;
 #endif
 
 	return 0;
 
 #if IS_ENABLED(CONFIG_CXL_BUS)
+err_region:
+	cxl_dpa_free(cxl->cxled);
 err3:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
@@ -148,6 +157,7 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 #if IS_ENABLED(CONFIG_CXL_BUS)
 	if (efx->cxl) {
+		cxl_accel_region_detach(efx->cxl->cxled);
 		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_RES_RAM);
 		kfree(efx->cxl->cxlds);
-- 
2.17.1


