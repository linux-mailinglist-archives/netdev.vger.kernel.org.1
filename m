Return-Path: <netdev+bounces-243791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE87CA7F02
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE96324A3A9
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9832FA3C;
	Fri,  5 Dec 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S0QsV/mr"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951B32F770;
	Fri,  5 Dec 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935605; cv=fail; b=TZjOxbQUUB5hVbg+4sRNtVc0drA6ZIhzxl30uKBIBVoDXvnVLyrycHbpzWmndp3znMbBCSXKa38lQNgpsO1XQRQIAxMzuT4tv6cnBoUbkd2Pm02B/CxRQO0cKM/SrdAG57RaB78DQuJwGh0Bl9KnOSzv/5+pPbNIV/g+96T2RT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935605; c=relaxed/simple;
	bh=t8HLbpLjzDaeh6F31G8vHWGubfiJKIlJkl7Dbd5x9bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFr5bSI0/31geZ4ZHKFqFW648UPc7TdGTa3XW6/8mlvzmaruVoJ7/jf86lJG9Rm2qKHqAlQbmcvIuultzdssngaObxXpKya/qmVjSfYH5w0Q8UnV8s0ztf9H3e2JdEyLe2Dl/KTBZPIBadSj15+dEMHal90i1GyCOSigvxntsJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S0QsV/mr; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqSGax2ekdTF11D9OhOxYSAOseunL0j/anBLuoZn6rLwq8vJhEMTGOz1VPXl6/89udL6okO/OXbd3txjPR3gLlmDG3pBgBV12fgmtzuvslvnBteXBPBZHItx0TWO8/iUDAxc4FEfcG+0FG350TUWVHddhwJdo8hAT14hUAzx79K//gju/ixQpUwknBweq3hKocPY63wv14bTfAtmFPS0jHVlZedPGKmXPQMJGAexM8Lf13k33IiTWh3+SW80oY0mA/qERGt98LKU/R0duLIbdD/n17MtrbzcWaukuKYmsRKuYThDHaQ5GT8/5Lg+9HTo7T7nJgdspIT8NYVFLGSW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MIA8fwutttrouhXqdq+lG8EGWBu030mUTvZV7wCIXw=;
 b=MV+USsw8JLLTP12PugGYUCVX96gHFzumG5XZNxGsXPGEpZL2qPtxqbjtuIC0O2aqkFlJwpCdkhse8xXqtoUwEeIslbT5J99KsVVB6B8XYC6A6ioZaRJaad1PKQtKxqACqvUmjIUyu9jF42AiSO2C9sV6FA9f1kp1rSVLCDQHWhBUhpRT0uqydOfBPfw27uZMhQwefSN/7/EofWfOHk1iyS5iB2rKlth1/Auwk1t58eTWvv3MWCQ+pDQR4FSRketVHx2pXUY1T0baWXdAhhPsYY9NebfCD4S9SuOSZRRpyCCEkFjZ9byeMMb8U5i2e281nwXbz2jpE2cR/FWspqQNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MIA8fwutttrouhXqdq+lG8EGWBu030mUTvZV7wCIXw=;
 b=S0QsV/mrsQhjfv+eQWdc4mFd5LQKxUD3Rak03djU5JYvpmuCHggAIVkdAoUdrdy1vidKB/VnB2t83R96E4wuWUAhmUKOE5VvU/TKGyxX2a2Z0sBqEWxDEMV/LI4vcToPYhV4NjEYdqjLrKzREq0hfa6w/aOKzjwppdqsOZr5R/s=
Received: from SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::20)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:18 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::ad) by SN7P222CA0024.outlook.office365.com
 (2603:10b6:806:124::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:18 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:17 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v22 14/25] sfc: obtain decoder and region if committed by firmware
Date: Fri, 5 Dec 2025 11:52:37 +0000
Message-ID: <20251205115248.772945-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d6146a-2806-4569-9738-08de33f4e1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IyTp2QhqGREAHojbeBSwDzu2s5ci0f0lqnQYlv93nBE996RaHmJc0egQLfND?=
 =?us-ascii?Q?PxvvntlJN2/CUvA21Tv4WjOQxyDn/rV7WYbxwihvvwfXvt9uFpQxy+Pm8DC6?=
 =?us-ascii?Q?qq7/Yu7P16O7M2YqOGfQc/iPokVgjaxiVTaL6S8NoI4frAI9EvmC2aCjQPb7?=
 =?us-ascii?Q?BRJSNvHRjtODGwb6hwZCkLbFpj4izm0DnbqFD308pFXGVZoJFsbZfzEHggkF?=
 =?us-ascii?Q?0il4Gji73vsxMzO5FZUpvV1eVjNZcN4lKlujmhe5iQvNcIY4V2ytL/ziFj7b?=
 =?us-ascii?Q?sCd+uRuSIMkWXoRz7xTvPGmFnm0l7afgmNxDAP8+Wp2XTuusT4PaS/LSE1od?=
 =?us-ascii?Q?XOIAUgk1TOzqGqDgahxUMcXvCc+0c+NS/tw6IRansp1MpMEaF8S7CeacVXwK?=
 =?us-ascii?Q?vx80d1TF29fCwxGY93uHF4jEOGoWIeNcRqbXLsQO4n1YbYvQqqQQpwVn3Diu?=
 =?us-ascii?Q?iEOB3QU+aHVKPWZrr590Tfr0gTwXinaJhTBy2zgXyvRRj+eODZwjFuaDmk6z?=
 =?us-ascii?Q?DS4+Rx8+l8PBHEsq9+4g6xvxjb9k/SJ3vWswq5s929PJDdDsjTTjATbzDyxX?=
 =?us-ascii?Q?M8lcPSuRrUuOX5amdPVd7LKt+OXvr2O1tKN66qruQ0pjAH6THQ3Wsuq2Paj7?=
 =?us-ascii?Q?BLNEMJIlq/kI/FO+1kpjVuvmjO2+7Hqo7gr6WNsiVXMnGAC7/uxJPy1aY5mK?=
 =?us-ascii?Q?k37Tv2S+S8cRC71yuqgWRMz6TbGGs8YiEi3algNO1pM3GIOXv/0hAuIVm5z4?=
 =?us-ascii?Q?VuIDoL5WMAEXkSm3AakoZ4BKm8y09mxWdaXWMOux2/sLmg3JaKYDYuK9ov4d?=
 =?us-ascii?Q?N2/Zgb2IVAj4KZIJzke1DMVAWbWl/oYVY63ZL8hwWvLIFLc9oqsUyCYPPtCX?=
 =?us-ascii?Q?Hrt2vz8Km6kiXNsEOxmAC16KYocUw6KP6dZH/cyjhY6x5Mx3RHNM3W5We6c8?=
 =?us-ascii?Q?EnKm+G1OdqaVFdGmILQIuomE/pYOhBNVFGoF0tH2SQo2h87AEb7u0YMLPW+5?=
 =?us-ascii?Q?xbQnqoocJ4pUg+dINJT6tYcx/ulpLrROWAscwf3v3szxLYWPF1tAqDl0dHfh?=
 =?us-ascii?Q?4jzReecQuVDNJxF0X2JtRjbgHJXA44wMK3jfBHL2BXwNmr42jzolsnyQmVt3?=
 =?us-ascii?Q?P5p7hdoYWsfBeBDU4AfazCkH6Aj/Ev1Q5kuKx9pyOt3KABrTM5m/JnNKsn6Z?=
 =?us-ascii?Q?HmaaiVJLL55QeVIEDtWJ8Hg4nUIleMOlOl2OR9wA8A/a48vS7kDlLTyPq3qr?=
 =?us-ascii?Q?ztmrvyPpfTX865dsPnc6YN1fU7ARRlvR69pRI5tE/FTJLLxN7UYVizCeLbuU?=
 =?us-ascii?Q?NbcqtevZ55uwR5OXAVi9HOGl8rS5gUXu+f4sdNEVjZKzWfO5Z8k9GsMQbcBA?=
 =?us-ascii?Q?GFebmdhkUYVqGLsCDBa/DvSDfX2eSxzLMv0pjb3c7OwSbdiX/xHt9PVPyTIw?=
 =?us-ascii?Q?G8ejshLUZLWDjeKzjQUe3A93sByOV8UF+F16kvsYBDbX121jBCJtgGo3FFsc?=
 =?us-ascii?Q?ORt3sB50Tgn5W1SrkpcLpQNIU7IgTVHw5EcM9XQY8xzwBRNWAeXOtYDGWWbb?=
 =?us-ascii?Q?CQaFLxMOwoim3OQdYCk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:18.6837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d6146a-2806-4569-9738-08de33f4e1da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

From: Alejandro Lucero <alucerop@amd.com>

Check if device HDM is already committed during firmware/BIOS
initialization.

A CXL region should exist if so after memdev allocation/initialization.
Get HPA from region and map it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f6eda93e67e2..ad1f49e76179 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -90,6 +91,26 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
+	if (cxl->cxled) {
+		if (!cxl->efx_region) {
+			pci_err(pci_dev, "CXL found committed decoder without a region");
+			return -ENODEV;
+		}
+		rc = cxl_get_region_range(cxl->efx_region, &range);
+		if (rc) {
+			pci_err(pci_dev,
+				"CXL getting regions params from a committed decoder failed");
+			return rc;
+		}
+
+		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+		if (!cxl->ctpio_cxl) {
+			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+			return -ENOMEM;
+		}
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -97,6 +118,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+	cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0, DETACH_INVALIDATE);
+	unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


