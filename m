Return-Path: <netdev+bounces-136673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA19A29C7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6812F1C20A1C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE91EF09F;
	Thu, 17 Oct 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gWzN/tDt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F721EF934;
	Thu, 17 Oct 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184020; cv=fail; b=lgg/SfmhRjtyBnbXPKy1EQGOtZdCZOoZKEfmgxCsJR50O3Tty4LsNcmEOoknNGlJN36Droyo6zW5zzCbPmofCJ7p8wAh//bOCcFbzbrYguYHMC5n0ho++nq6WZB+YsUZjdJGriaWIaX2zUtlrQVWjCtUzMHGCmllzyNemAYuSdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184020; c=relaxed/simple;
	bh=FIK2Iqk/Ulpr935Sk9UH/f/JCSUT5O6j7t/vkwGhE+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV2S75h2sINaUozKqVrRLb7j8e59eGeOyV+x1+oqMGZsSJNGbyZnnU5198sEXMLYkkXo6yabinIkYutv1IWr1tytRf9dlvQyXEsAwWVt2Redo5xcVqVcu/YEIbNf3sXm8GMFLFkkMbLdW70AUpahWZXmjogCzhQ/Z3yNwaaaspA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gWzN/tDt; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIzjeTyOJZ6rM/4eIe/0LinQvp2A6kdtkX0eNCavrqAcMvUQ94T2mu24uOFXfDD1hk69I6u1B+sXUYkpmXTNJGYgO506MTMZbOhJ0DIzIpZ6Pe9ug3/sB3+6Dq7ougbUmCrBFjvF76p60RJuDSTFqfjJrxCVpYrpA+cVMMw2XeveDjmWwjt1kiRy2rCZG7W2z9A0zkIJhpfJmFVZ9gSYrwL2Is2yHhKTMVg5WOcmiEx3zcXuXpoqYDUBBuApYQoEP1VVXWPHWghiqhOu051dy6TiCXN8sdM1DNsyHCkn+lTJOs8cIfyCs7lojQ9BRuDwVPKb2khjwq+PvyMuGwGauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFcAd0gy0NO/qxSnBh+rf/nBw50U2cKicFOWCm+Ta3M=;
 b=bjyJ2CP9TgJW6KoBK2R0rT0XKbBSQp8efPTxfh51bp1YmAqzoPwHwSOKw9vxQxKYiXFp1LgpAGKNhwrWkn3kpuRF5jX6wBK6Km/F65uzZhTuBPUPfTOo6uieRQpcIc9E89diB7kbnV0s5ZcRmNuXvyYu5A0jc6suoTCxhyUOiGSWxjW9bSatri/xO+LbQwBMWweOedqpc4hNLz5VQPaNNEBZezShYoJH4fYAWek44/XtZEETb8esPBfl6uuKoOknEIn7Tf/gFbejv2CnYMhOS5EzNvseHtl+fRetrwmEk4z0tGQVZdU2J4k+tz0IXVpN4Y5YwJofj45KSQaZFH8gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFcAd0gy0NO/qxSnBh+rf/nBw50U2cKicFOWCm+Ta3M=;
 b=gWzN/tDtF0ta4qQB4fYDHreeJ7kS9LatbtieviOZHEwGbN+yfmGBPKNAgr36E4rq/wPUtXIW0qzqf1L2E+M+DGzAiRwRhLOBGxX7S1WGw7c4eelqwAoPftQ/QxZacY/0F4cqYr7NyQdqo5T74iNuXIIVp4uK39MfUDeo8PAGw0c=
Received: from SN7PR18CA0021.namprd18.prod.outlook.com (2603:10b6:806:f3::12)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 16:53:34 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::ed) by SN7PR18CA0021.outlook.office365.com
 (2603:10b6:806:f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:32 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 14/26] sfc: create type2 cxl memdev
Date: Thu, 17 Oct 2024 17:52:13 +0100
Message-ID: <20241017165225.21206-15-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: d65687f9-c84a-4728-99b3-08dceecc3c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEEept8PRm417fA5kObUQICyF6gzhQwRko5BWEaRav8v3n/M14W1mHh7ZpBT?=
 =?us-ascii?Q?saBynw/xsC8JUfzQoAvHU8ZkOCjhL+AdD8TTEaK6QmWVgZgHAtBooHsuzCsF?=
 =?us-ascii?Q?q0Mo7YaWGvfLpeRVGUiVHMcrXFsxKn18f+9zDaxqaQXapcjiltfXwfFxvhhv?=
 =?us-ascii?Q?CkXs3K+xe/X1e2rSvy2aBVXmmnV4uhbmulOKxiuDPlZfoDQ38nIzlbVGJzcT?=
 =?us-ascii?Q?k9gZMKrDD8V1HJOBHp+BMlkpHEVrXsUvwGic48/lry1C0QjCq9VHlczTuqz5?=
 =?us-ascii?Q?H43gyPpHbNakfjZXmVv4bn8isPKtTk1SYJZSAGgFicbnexv39KJgV84vRdsU?=
 =?us-ascii?Q?XHRNHCXKRWNVi1xeg+xRi1hluXIsXoQjA8KBI4ifFTEpNYHTPVfZnDlWOPi+?=
 =?us-ascii?Q?8lTLxMLt5gOzijJHuqwMuFIqhVcEUaf4Eipsa/VKE5j5RB7XZs4KSKQyTT9Q?=
 =?us-ascii?Q?cbsT22dqME0MHUmfrZZxbhHMebMDWfafdITwfkEViTJ3REyOS0iZU7682kv2?=
 =?us-ascii?Q?p5lSjoTGsvwwF+u2KLVdgrE7vZi0R2Ud07yybFBQRF+rwCCWywb1ti++sp09?=
 =?us-ascii?Q?kEtWFIBQE6wYloyXE/TJKD/KFwhqZ1LUXyz/Jxet0/gGDmxl5NMZJsRLxY5x?=
 =?us-ascii?Q?Y4UoCkFZy6+jLOT372f84ZNG9NvBiPQXjXC8hxsGv7wpfpbnYd/4GgqzaTPG?=
 =?us-ascii?Q?8vdG64eGKBOj56Lea22MgjoiUPICuYvHT9E5rJVHg+gIOKDsMbjukiw/bQGw?=
 =?us-ascii?Q?DoHxbGpe3DodsTgE1+c9JSNzvFhhDf6Ixbf1kNOwqnu32HyEs5ZbJ5Byekq3?=
 =?us-ascii?Q?FkHGDT5q8vCE+XqVLrwOtkr3BAKw8BX8pW4lcIrA/kPNNwiWfPgYWrdm54ll?=
 =?us-ascii?Q?k72zsbnZEjD8bdvycSKstU/d1ZLfEmYt3CROVLgkvq7o/G1KuI0y/FzAiG85?=
 =?us-ascii?Q?I/v6oQTK7E/VpiQ1C3wqQs7Yc3VbJDLLWPb3bBTO4sVA1SvMDcIm81DRo3+7?=
 =?us-ascii?Q?kycdbseJT7EGWcxyxEIisT1E3ioV4eW8w2B+dRZq8eQT9HKpA2AwoKkdkqu3?=
 =?us-ascii?Q?F1KHSX+UkNxBAU+tEz4K6pwtb7HWJ4szSSltJh6li7rU7h/oMvWb07pv+i70?=
 =?us-ascii?Q?BSoM4FFlAYngXqfnab04PdTzjPm9rbrrpj19O+EqVCFZPbYgBx4n4WcJOOiJ?=
 =?us-ascii?Q?kX92hzX+CnJgBcoEquBFl7l3Is+5YLQ1K/EEK8FP+XVCodaC710x5IWN18Qa?=
 =?us-ascii?Q?Qs96C5nu8ztf3GgdUrCM772B343FIbsD+bI2vYux7v9lcP/tj/WXcUxTIEg0?=
 =?us-ascii?Q?UW2jiapC2xHzd7s5qgVAXnCQxXxjcHhKLQh8ZdxcZ+M0L9sF1/b2kbW1NLD1?=
 =?us-ascii?Q?JPjrbNcNTYcRJNXMnGHCm5q4pYQ32sI+OyldYhorYb1th2cwwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:33.1247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65687f9-c84a-4728-99b3-08dceecc3c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 419cf9fb6bd0..452421d71fbf 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -94,12 +94,21 @@ int efx_cxl_init(struct efx_nic *efx)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err3;
+	}
+
 	efx->cxl = cxl;
 #endif
 
 	return 0;
 
 #if IS_ENABLED(CONFIG_CXL_BUS)
+err3:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
 	kfree(cxl->cxlds);
 err1:
-- 
2.17.1


