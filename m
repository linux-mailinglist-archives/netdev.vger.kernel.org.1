Return-Path: <netdev+bounces-145952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9389D15A4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A860B263CD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D221C3F10;
	Mon, 18 Nov 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFql1dK2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75C1C2DA4;
	Mon, 18 Nov 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948313; cv=fail; b=NNtm9n+ni0VQKLjk7zb+vtevSW1QlO3sMHjnMxiS0l8KWX8a6vyxqdCeODUBWW0m69ZRn5nXl/9ylewM1j9AtA1SvoO5ForNcULUZXCKpx0JtuSnIyFj0z54VGjjNv1JmT93OpTc21dILj1vPEaumAI1N4Z0OZSa7BvU0wcAyqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948313; c=relaxed/simple;
	bh=O9dOrsDGGugg4T1RmSmdZOpsWVosQUJ7maTB8/LDIrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9JjlKgZdu8/Q6FU3AeiYySird03R8R9YPbJUJtOkiW3LHeloVpHZHyKI6pZjnbPlPcqg6NjYXMpMadH1/vvfBx22FWqSlBo6SPEZqhCsbtnOn/+KapvOHxVPHSKpn5aGZGN/LV60MxikWVlhz1mGZlm3iXIJllE9ic/iNYBtb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFql1dK2; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGpBcdwo+fyo4P3gLBmw6vp4q3zDTlNz4y8LFLq8ncOAbd+lpD26Gkl05VWc/UNM0lNRf4UTUFbhpaqrtrXKKApKOBkdyPclP6B58imol7kk9bWg0z3yUKtMAx02uWu0XDUAhsMtcpBwCnygle+iXsCadoLjuPKr+bMz7esDS1utJ3j/b1ZQOGB22LuLPLpM5uInYqHrS8paEQyg2gQq7tMwDu8lJ/MuqBHuLnWFzDHTEgbWwvBbCowsV38Saa9zRY1h9mTCHqUj/CqfkNn+Tt5wNBVy8mBsurgHMTxY4BtR8JOZlbTnQ2xPcEXieG1GFP6CZoYDYiowpQavFMei+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiyQNheEWYtnZdU+UzBMgzSMrVHMJSJsRJnXqABw19k=;
 b=WhiVRuJfQ3f0T6p7jSRwoFqvfhCUkuoF+eBB0p9GwUcU7a5MbnD+aeymQiGQgVZRHur4rSrIgX7jpPPO72JXTQd+cQ3nyYdV4uOfHWt1wpA2cZ8jTPa/IQrLXe5In27jhxJskqqS5FNo0GNmLavnkn9KtfeMNQQqYQw8nG68UPD1+9GL7n+F2095mUh8B+fL6o5n9Q5disx0rWWJY9rrOsHklBZi0jFVPTyZhf46bTpGonmsUOZJoJPhUhUzd4Z8WhcNfg8IVJRHTc+3AekJzd2KdI3eFID8/qtYI0DMJaf3tDVypMprs7nONpaAnV8aHKZaDTXR+it8gtGVjQGdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiyQNheEWYtnZdU+UzBMgzSMrVHMJSJsRJnXqABw19k=;
 b=JFql1dK2U3iVo2Uq4NB+R1hGJSAZHAvpOUS/ta0K4E8V2Cv9vKpYOfqCH+WIQGWzyYNgVgFIeT46klrlSQ5xi6bjkjAcqUYitu+Dd4g+cL1+w1ZkY7Ritgvci1rNtZPTHuXlFuQgfA9UVgnPcGuY9qBjcE2RiIqcZANR/dy7sjE=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:45:08 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::a2) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 16/27] sfc: obtain root decoder with enough HPA free space
Date: Mon, 18 Nov 2024 16:44:23 +0000
Message-ID: <20241118164434.7551-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a506fc-bb3e-409f-c4ab-08dd07f05c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fQTtb7gv7oOE3uz80S6jZI7aU0q/KPW7R6HcqmYkyuc3YAeKYYis3Ky9tT/4?=
 =?us-ascii?Q?EiHetgIEX2dAMQLCymZGFyotsmVA0aSfhChZV95u7TMEKFUj7P+a5VsWx5yJ?=
 =?us-ascii?Q?e3fOu1NsdSiuz/7N+wzWY5Jggk0DfYRMxogbzMzYlyIM8+6PwrukIIyWv60Y?=
 =?us-ascii?Q?au41LKlGQey8xoTDMz2bvukaY6hmZ6j3eT/SaYETpUw5K6nkp21GIhXwEi8v?=
 =?us-ascii?Q?/BF+B0aBAxH6Uxo3aonoO8d+gQdIWrN699xXu2dBfAkY/46LQMFrROzLpFi2?=
 =?us-ascii?Q?l04QF71sSZHYdsNbxDtHKp+u7sFFQBaoGQMHc23Vn3rvIv4pMpo/owfoVSW3?=
 =?us-ascii?Q?8m57WbOFZ8Fz/+MSk6eA8+/Jb6gCT9M00omyQlTkWNswKZrd48TQuuiQ7VwB?=
 =?us-ascii?Q?WpN6Hbg58E7XSbxtv/snKu3LxDztSfyTtHVCQI0VTvPzYWFClWPqqUCiv03g?=
 =?us-ascii?Q?vrY/po4PEI6g+wVs6IHiIUIVmU3V5CPoTAV0HWzmPKVwBNwQ2cICUNCmQ7z5?=
 =?us-ascii?Q?iaoCUj0gW6T1G7ZxxluPsjvMWHqH1RlT2loDwL5O9sh00s7xfKMWdxupX1xB?=
 =?us-ascii?Q?viXuU7uX/mZVNkLidQejUJ9A/urCAhiFMyTCrRmaVvZb00CiKVl2Cxz0exxp?=
 =?us-ascii?Q?+wQ0QtNG+8C7/k59FarC+fpqwNvL8iDfx+7r+AuOIzqgSV4R4b4c01SbTG75?=
 =?us-ascii?Q?ry90IXbFJRgSX+2hH9RDDKEllWxZm2cfCo3fud8uwq5e3DwGXdGxIJqJzHVN?=
 =?us-ascii?Q?f+lViW56E0svQYElgzaQqJwi46meLbe8gilbYT8Plyr7ZevrprDJbOuX8NaL?=
 =?us-ascii?Q?y6adbL/NBGOOsgYJ1UBXU9FL3EfVcfn50P1du4E8ONCgNYli7lUTkTlHF6wp?=
 =?us-ascii?Q?MsnnMdjdK81+XKUKhyZYce7CmPhnW4Nod7AYjcwElCs1kPZtCSBpMTU4RWli?=
 =?us-ascii?Q?w0+J+wWVSaOP4X6mxbADiZKYd/4+yMP5aT8A5n8mh0Hn2iudDIbuLNL6bPEb?=
 =?us-ascii?Q?Mmf4dNUd8SMisJV96jHwBNRbb5HBmLgILz8agrRHlSqd0tFaLn6dvlPBcBC8?=
 =?us-ascii?Q?ogu1j7b0S7eJPsQZo51twLHz+sj2XA5+9CV4Gd4QXO5ccBCkL7MKu3uB9yYt?=
 =?us-ascii?Q?ZgyUZ13jMV2Qj3Rdr4HV5WAG7AI7NWq/pgbYiKvQTTDeYJyYypa5VoUEzeBN?=
 =?us-ascii?Q?86FSJxmkblh3fT/JxwpWYrZt3oBQTfE2fV12obY2Yc29g5aL3EbWSI5FyU/E?=
 =?us-ascii?Q?N6SkMtnuWcDTpE9caG/f/bQr+SDeliBigVPjbgUz32mLfTMIrDkjoNfBfkg8?=
 =?us-ascii?Q?psim9p9RoG1UKqJoXdHYhJ5XDVx9OcDyuLtohZUTxK6oC/y89tUrndyFL8it?=
 =?us-ascii?Q?zl4Kci3ApbjV1Tx2K6kQqF96BWcINEUHMO+uw1I8BJXw1TrjQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:07.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a506fc-bb3e-409f-c4ab-08dd07f05c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

From: Alejandro Lucero <alucerop@amd.com>

Asking for availbale HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 7e900fbbc28e..048500492371 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
+	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
+	if (max < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
+			__func__, max, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


