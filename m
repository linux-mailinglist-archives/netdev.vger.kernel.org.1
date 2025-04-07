Return-Path: <netdev+bounces-179983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83DA7F078
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E77D1896C4D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79722B8DB;
	Mon,  7 Apr 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oY+dduaX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BC22AE7B;
	Mon,  7 Apr 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066315; cv=fail; b=SQ2YvsaBnNOjGxX4aNJAHSkTQga73EW3DKZm06Z5LvAoSlpnK0YnrifzYTReNiYOGDMT5NZ5IkCPOO87wrvmmtUyKAiUV1zcKEjz2p9KPwC056Pqo56bkvk5xrdRcIlVI6dZB41doreamG2qUh2QVdumrUIH1qPBcosr1WPBjkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066315; c=relaxed/simple;
	bh=pZbI/4YJylErd0w6TGelL8k+PtRH3T7lwa0rUHoiYQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf2I6Bi+nb06Sywq0OjncgNCQklvy0u3U641yS8/Y0TznCD5eTb24l+37f6Cf3sswagTHR+5tXh5+crmHYbgaOFL+SC353kBFkAsvSyTdAAWIVX9Zgr5KIEuLKqtR9j8q/Ygmey1w3MWnNRRl4E9x4xuvHWd4WaM7xPg7g76fr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oY+dduaX; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+swI6828aIuYDIE1bEbKsnGl1CXo5bCSD0RLRckdJGTfxVk9EIZt0SL/SuW0rivFX55rm3w8K9OLWPxU4zVUpHFLa0w3kjMyivJ+DXgz2hhRURQXC8F1CSQ+kreOGsPwuUoxDhi2eF0kuo4UjZJL7TC+bV4Gcaa7NiMYwB/f1unz658Vp7gkucTNTTsx/+6xqWZRHPlLu+t+e3qcc3rVPNxXKjv/ZN+5rqeZ9kBRZ7g8SS6OvSQHGoAU0bnScPOoYF1Qzo4dcLU8HE+yVRnybrpfYvPIGRKA9pme1AOkZlV1N2ZqKhLXUTo2wz2iqK+gvaYLqpEmiNgK1+zoRP1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnrzTjB4K6XYZkB2M+DX+g6nOXwovoKNNpIRMr4ms74=;
 b=Q0OlHTYIoMYkD1Pn6ZJqgKPoQsgbhaPzYsL/wr9dvO2s2hRKaBk7VHFqF3A9vmoAMhQO+036RGG8f6g79HqIcT5vJexs0vo4QwaZTAkfL85H2is+eF0ciSm5wc9dnyO4TadNZ0ayTrwaEaJYtvGq7tYcwmHvIPg68mRb0LJaNJDAu6poZU/8Eq9DbG9Fdc7RrfQ0II19cjxpQTzFf/iwAB8454z/6S94PUxX7EgFH/P/FNMG3VQiKZsjSgGJ8352zuPEvcmvg6UccpQApyUZCLyimHbB2Sbp8/BR3fiIyMPisRXCCvzl1uwad/DnXVcXoJ7BEnTCik2PooVQ1DcPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnrzTjB4K6XYZkB2M+DX+g6nOXwovoKNNpIRMr4ms74=;
 b=oY+dduaXFV91CZYWU6fCu4e6qnA8K37YKOnZCUSRhNs3yWwCCRpDVY6obKrpxSp5hPniT0gAe4DG8bOrXC32cfdoVQl2aeg/qaWVnGVIrQ10s3NzfUC2gLPp+HkDChaB9ZpcSBvWhx6vCqFDskg4vCcByDy/EeA1DUqjUPt6/1s=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 22:51:48 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::4f) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 22:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:45 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 4/6] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
Date: Mon, 7 Apr 2025 15:51:11 -0700
Message-ID: <20250407225113.51850-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407225113.51850-1-shannon.nelson@amd.com>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 688a63da-8b37-4d0c-652c-08dd7626c77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCNhu9RrzQ0j5keMRp7qMMJeHWAIe/EiyqRwiTyUCbL4DKQiSlJn6/IJWyYa?=
 =?us-ascii?Q?YTvBC3zy7H1bKtyhQ1w7xkapXdHvZ0X2Rxd3nrNcZ7VYLdDexJ03zOczysb/?=
 =?us-ascii?Q?0Y4pMP9AwsqyBfCwVIcM6Y41sGRTvHHTY2AMeJ45NlwRjKfYD7oDlFXIUppA?=
 =?us-ascii?Q?6ozz/J8cfInQ6nQ+DXxtiUkMsNywt91hCvwIq1F8CY0ibX3mLDY+IFprnGvz?=
 =?us-ascii?Q?scEOMUFDx92OuW/cNPghGcHoT4MsALTVBFduvWlaId1NscYebjYjjK6fN79O?=
 =?us-ascii?Q?EECtLtO8oHby22awTKDb1QNh9ZLpGgh9j01QoPTSKcJtIqYI8jyHVGTfH3mp?=
 =?us-ascii?Q?UM1WFl80ukl76sqLzD52WyflCRUa+Eq3gEcBJ5gQgFFR8pVhl5ERCsy23VCJ?=
 =?us-ascii?Q?Iwgvt1IpQBbIUoQ4UiXDdzoLJ7PBB3RmoDPyY79MtyLgP/ReFh+PWuAOMc09?=
 =?us-ascii?Q?78rsUWNWPqlUMV8S4oqr9tVkFxRSI25ziQVZkRS2vmO9cN2sMqBMhjOg8dF2?=
 =?us-ascii?Q?6YceYIL2nufx0GLK/JcEf6ne4/dBy5lMISOlVXLHfv24TVtS5Cn17JRrM7K9?=
 =?us-ascii?Q?w4U7Nnn030iGcj4dGGwUFfcZ5OmF370/i6z7EtP9p5hvP7UirDfkfaDDAgwL?=
 =?us-ascii?Q?f0yH/wY0l/JWP1kLZzHWIlKPX8P1B+mYhj/1dKnEeq3AfMJuOa4VNVz7tTbD?=
 =?us-ascii?Q?4h5HBmRY2ImRidhQWnr66w4Q1w/UDgssZ2UoQ+xgT5ZEISgZ70UhuLJdcuQ7?=
 =?us-ascii?Q?mXZ43X/msjyLkBRKNO57RN1f36U/WsoPr2fYBBa30u9I23c5LPQSKogqEHD+?=
 =?us-ascii?Q?wDr9jEmpV/5XVN9kEbVOZ+fa6AZ9qDl2bRQmnPB8hrKvdPV/W6QvaflK1RpX?=
 =?us-ascii?Q?TE1ovchMgyn1hFtv51ZgAvHp3tS7veMuR5uyFGMgrWZgrqgHXHSCsvxQc4pW?=
 =?us-ascii?Q?3EYftr7613jadEOe+4hHwM1jdnziQsdA5kgNI3NgZKhLZogIUR8wbPyDfj/9?=
 =?us-ascii?Q?TIFOCVDYTLXpUNtLu+umNz/ICXtZxP8ypMkkM6+DB95xq8S5VT/vHZ+TNMZr?=
 =?us-ascii?Q?+zDHzYwpL+q/39AhEHnoPBWqlXLrWlm6FOhGHpjgBzVL6+0waa2CEcXvepyP?=
 =?us-ascii?Q?oHz+vMO0wMNNjFxUDVw8amV6O6eiId0S/YBhSMmjqyHSwBXbELR5sX1S7yos?=
 =?us-ascii?Q?cdyPEn2tmuJraIIaymOE/RkCxhm3jgSICLHVbPnbnvzXDlPByFXReF2gweta?=
 =?us-ascii?Q?pZiCgHb3pULqehRRjYR2LZPqlFdrHy9VSjVqkoK95RvLmQOXRNLySn68Vgvx?=
 =?us-ascii?Q?5MaWL7tMzZuEVcNGbShAuQ0cDvfesWMuVNKQNOkdb5e56npTU/Yj7DbiLs9p?=
 =?us-ascii?Q?romnVJf6gHc+BOuYO5U8iAtBLpP91wfdFJ3GbBDLhdm1FqcjtC78naj9rwKC?=
 =?us-ascii?Q?jDfw7Is6qeyRGS/CXrc42mP8j2PNt2vbEXEugvCd1jWtnxbCNnl0btuZ4UkG?=
 =?us-ascii?Q?elb5ZMX06O3onBk/izolZS+iVqltopOMvIM4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:48.3662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688a63da-8b37-4d0c-652c-08dd7626c77c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

From: Brett Creeley <brett.creeley@amd.com>

When the pds_core driver was first created there were some race
conditions around using the adminq, especially for client drivers.
To reduce the possibility of a race condition there's a check
against pf->state in pds_client_adminq_cmd(). This is problematic
for a couple of reasons:

1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
   cleared until after everything in probe is complete, which
   includes creating the auxiliary devices. For pds_fwctl this
   means it can't make any adminq commands until after pds_core's
   probe is complete even though the adminq is fully up by the
   time pds_fwctl's auxiliary device is created.

2. The race conditions around using the adminq have been fixed
   and this path is already protected against client drivers
   calling pds_client_adminq_cmd() if the adminq isn't ready,
   i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().

Fix this by removing the pf->state check in pds_client_adminq_cmd()
because invalid accesses to pds_core's adminq is already handled by
pdsc_adminq_post()->pdsc_adminq_inc_if_up().

Fixes: 10659034c622 ("pds_core: add the aux client API")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index eeb72b1809ea..c9aac27883a3 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -107,9 +107,6 @@ int pds_client_adminq_cmd(struct pds_auxiliary_dev *padev,
 	dev_dbg(pf->dev, "%s: %s opcode %d\n",
 		__func__, dev_name(&padev->aux_dev.dev), req->opcode);
 
-	if (pf->state)
-		return -ENXIO;
-
 	/* Wrap the client's request */
 	cmd.client_request.opcode = PDS_AQ_CMD_CLIENT_CMD;
 	cmd.client_request.client_id = cpu_to_le16(padev->client_id);
-- 
2.17.1


