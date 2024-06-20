Return-Path: <netdev+bounces-105470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88591152E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E6F1F219A1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243B7E107;
	Thu, 20 Jun 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aAqqv2Rr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E476F311
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920402; cv=fail; b=I0GOiyHNpdZTVDIqCoF6v8u1uBmoM0lFiTat2xl0hnt+C8N840MQ6Y63IJItNQiDMU5r6kHRJGAFeEV0xN5hfYsMK/2XkTuMwrSJTl/05uuUikukQxEwZx/XfE59JypP+crKbXwvSHU2v4Pv6lW9SFRVeDySdas9t7RcGVnfyUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920402; c=relaxed/simple;
	bh=2J4YPNAfjIT1Rvnf/1fDsO43YACWKeSBeHkuu9M97ZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZrobmOYnaAr75pCXLZ8cZRZHyzWomMadd/mku/pCIo3/EGyDwVx4M75ZgGxUyp8JrkYGrg3Xig9wismeag/ZKgmiAPPgbgoUnPpEaI4leiZTtS6jXPFG289J8PAtxnVAu78Z8avt5SLzKMJ7WgMF+Mb0csQehjoDtGmqmR1+x8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aAqqv2Rr; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckH2ccf84JBOTotlqtRMX8jqqCb70rFka4EFiPttSYjFKkJJ8JL2GI2/xDtwCZ7dFgD6DDnOIBUBleZcKnDciEChHi4bcBjySqmAgdw+xMRpWfj3UvOr7nk7xjwF1JGlzLazuybrcoHr382jtKPGkXSCLSWVYtI/WoS9RFY9TWTgSY6scjJg2Rh1nP3dI1vkpBLSMb8aWVvkIPEdNrw2dxXzC52hGB1w4BJRj8AWDb43CL2ACIGN4QN8zs11gL3CKWwFJ1u31r/H3IbksYjbVbF8zhV2W94rXbrFtjNV7+rU9BaS7WFRGQC3AQY/yXH/BEX1RItAb0+aeIv/8ukvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62UJhr/9NBpqRwUTVnyVWZkT3QYdQ4uPJkrXyTvKC+k=;
 b=DBE4k131Dr4nAW05fh2BPl5Aiy7pRYqZeLc/oRl7YA4Fb3iqKQ2vS8nQxFZou5de+tds9pEtvmULQPnBi9A6RujCWP88CsCahMadJQjCGCW64nBjoUIyaCCmIyWlWuwVEwf2VptUhHw/lprUvAqMX6Qkp8wqWA2flPV+WgJKi9c4tHX4vrW/4URTHuAhw+nbUPg0EECIrvycos7ZxjDR+dTRzuhGxqyZi59D922cPCuFtRvlp44JsKBbOiYlzEJhsfiJZ0sd/mJVGarjsuulO3IutXJvp/nENfkGBsCk1ekhGZRuNtchJP19YQtQAet74UfEWTAYK4UwixRs/BfK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62UJhr/9NBpqRwUTVnyVWZkT3QYdQ4uPJkrXyTvKC+k=;
 b=aAqqv2RrkgmhgGFfJmUhkuqQMK2yw+q5/k8ptyNItgDJtSD4GPbEierrehnh1MoPihjaDumGiyu9ab0qEa0M8t5TO2OlIBzIyRaNNRd+RPqGNs+S0b9/4uFBLZPDwK4RJuVYfte5+gEE3Z/JAwHPjaQBsb1Zep9j1T2TMJTISYU=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 21:53:16 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::27) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Thu, 20 Jun 2024 21:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 21:53:16 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 16:53:14 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net] net: remove drivers@pensando.io from MAINTAINERS
Date: Thu, 20 Jun 2024 14:52:57 -0700
Message-ID: <20240620215257.34275-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7ea979-0e8e-4210-ae61-08dc9173641f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MUAtxRe2GqhExCy8L7yXjta7DEepdcwdvemIqUJ7e3a7yNtLAr10aTbzhqTA?=
 =?us-ascii?Q?vFq13rwpG4TECDcYPr70dBZ/PudMoqE7UqJtgIACkQaIUt/71y520Crr8g+7?=
 =?us-ascii?Q?6G8M490CMmYixXY1JBouqf1/Kz1Qf1Ps3UHoOSrRfstWSKvq3jpibrZpRkTy?=
 =?us-ascii?Q?4nN0IwVBBVBai+wP9lbmOLDYEYeP7CXdmnHHL8QZZgpToTCFG2ax8fVmqPcf?=
 =?us-ascii?Q?a+VUQeGqv+UfrnUyuO3K0VjGx2gywN9DYixF3cEQ2Rkb+AOi794PE92TiraR?=
 =?us-ascii?Q?epZ8G6UbYTP0aBMbBLbSm2Pc9lWVHietpjxofwWQNzKqzbxnA9xtmAUN2yCJ?=
 =?us-ascii?Q?t9VQp3gy8ki99IU1ZxUd7avFbO/YoUQqDkGs+iF49iFCwtwkJkBxArwARime?=
 =?us-ascii?Q?Thbh4KEOupXaxpq2FtzPASQvOkiZAZm+u8/QkI1Xmd0NsqQ6393UUcehwRvS?=
 =?us-ascii?Q?bJ+ox5/f/cm0H5V34mYZjq8KvMqskBVgefSN9GIziC8DD1Int+h8p+hUkIBI?=
 =?us-ascii?Q?4DRaI8eLkXUsBa2aB9AV7pPfVpGFKY5VGekLcfW3ueKU351cu88j59PxW/Y1?=
 =?us-ascii?Q?WlOxzyABbHEmZN0VO7gaCgiwhO0WKc1b0EyM5XgRFYBvBwoKDAKyc6I7sosk?=
 =?us-ascii?Q?MhpTmIYSWTqLRCrBzYy4+sLT9LoiCroJ9Nna39llci2nijpvWVeZ6PWCl1uZ?=
 =?us-ascii?Q?QMjB8XXJyJRcMbLjWo5femWdCtoNKVA4/CsqWzbeLwp+Jf5/+Tpmay6xXQlI?=
 =?us-ascii?Q?K3X2bG0jRozrjee0aNxBj+h2RVVo0JVW5jJAjnyUgm+lDVWi9a7cQhnJSW6G?=
 =?us-ascii?Q?Zkb75cjCws+l9CmImvyNsYTSbB6TuPqdKhWUq397T7UFuPaG+SsX963ut5ti?=
 =?us-ascii?Q?fiL6PgzXDwCgTz1o4E7v+NusgSFCLNhPKO2yKvv8dAM+vO8zuAm1xN+jP8BA?=
 =?us-ascii?Q?AJ49+QpGcM0QcfxQwqxtETpK0OGC5clbpkX/oUKgjGJsMxshtu68eaZxWCmB?=
 =?us-ascii?Q?7GvO8/19okBgj+jSQpJIsosTnNU3VTTbjVlzoFbi0sxwfVO+o04O3iu5N7xc?=
 =?us-ascii?Q?tG9HEC4+iwa1mL7bW3y8ftdyzSdcmMp8Tn82hX3xcHU2cSsAYedB8jMO1K70?=
 =?us-ascii?Q?FATCLYEQn6avDJroc7pV1uejdEnRPhnDt868Pw7l8RwMrEpZxcmRCcjgLpdd?=
 =?us-ascii?Q?SUshDJz8kHxtqTBqD59X/X0iFP8S8fk0c6KGxpzbzvwojxAvT7ZW08/vjiLF?=
 =?us-ascii?Q?QIM9Y+nerVmc4+SvsOOcKVPMgXN+mjtW91D9jNwey2Ht+s4fH1kWKhUpjEjt?=
 =?us-ascii?Q?WSlcl1avz465TMbep+u+/m9i6VBJTrPrC9ZYAv7BUTrTPCbBZh7wDuxwHwAc?=
 =?us-ascii?Q?TK3jWUn7tFX4Ofr2B7pvIrIFjRjgyWNRnVgKq+B7JhFOsS0KHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 21:53:16.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7ea979-0e8e-4210-ae61-08dc9173641f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

Our corporate overlords have been changing the domains around
again and this mailing list has gone away.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10ecbf192ebb..1139b1240225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17532,7 +17532,6 @@ F:	include/linux/peci.h
 PENSANDO ETHERNET DRIVERS
 M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
-M:	drivers@pensando.io
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
-- 
2.17.1


