Return-Path: <netdev+bounces-237237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F8C4796E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021221889A76
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EE311956;
	Mon, 10 Nov 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10m6w6fK"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1A279355;
	Mon, 10 Nov 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789056; cv=fail; b=RyAc5t2E6L3tmiGdGZnmPQ7uxG16kUgLFbcUhvUdYEzAmBFU5CSWunKPQowHwhCMshv+syCXfMmrO1yqXi7vL+JRfpPA2XW3Zl/pvEcHCtvKnFmdBAMM10EOnNKNk/Mq8fDlrmVXHIOmR58xudmKxyYyNjoaMVFvc28wcgQO43s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789056; c=relaxed/simple;
	bh=1yU6VlC1sfYwUe2EVTlqSjrNohHiD54eO+ScBYfLxdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuwVZKSqaZwMG5ceiBW5VRV3cuWsDbcDOhbHEH9tbtYoJwNb86eynMZPSAA0E9VRw+9kDfG5nxEtFDEolYS9EeUtbrwCNmFPIq9soZlW1AIJfXIKTxVz5bsJIX+KAP+WnI7kxMsfh2Ex7d74FXjSrCIvuNM/399q1PmFwJJnhY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10m6w6fK; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8OoIM2LbuWnbE74Jb5vfcda/dHmiIXoEan0KEHYlZRJLrKLlfHQTzT/t3UI0I4hTaPOPTPElyVHFrLYCiKSCRg9Hk3TgQY1T73rlLJglkRMzK7mvtGYPxrtlPNYt9n1mmx7AwwAdI2AzzJhWc5XlYyT6Gu1qce72JN+kRuyIjV+3h+wJy8+vX1znEPgEz8SuvE4kwvtdkmZpgpRVzzJ4IdAJbLMU+OMBPrU3RC7ebCn9OHKMdCUhDzClgXsTVgbMqL6mTrP5X97ad0tiy0fIM/rsAyDfTT9gZHchtLDF9VIa591lIodNKWXqe/9uLC9p+d4l5zuAmniQ0e9nZsUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+m9M+sjTqQNfuzqsd3hQVsMM6Y25ci87Gs/f/TPLfE=;
 b=Yf4SyGOqVv2wEgfrGJGYdqUI1GZhV3ICZX80cyCrYf8jwuVy48TJtBkanystDSPCwIPfVb9OZPNAQ2i12ERjuaM4IVgibAK1Fyb8KFiI9u4g4YSGuD2mzl5SyeLTr1n1e8bay/AmagMB1GBsEpEjc3368711akf9theJJBGzS1uUDkPgB+iCB2ly0R4frLMy6QaNar8afIFHADp6hKJaIqUgtpvTxPWqj+a186mZVESEoM6ysCZCbLKurrjsIA/FacNqx0hLsY0k5BNb64jXD5SFC/xPBzSPQ3iymMaAkd3FsGJ4cl19atOa3fWXDzEj/ckrDIT0OYa/gqZ3uFJu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+m9M+sjTqQNfuzqsd3hQVsMM6Y25ci87Gs/f/TPLfE=;
 b=10m6w6fKt7KpJ/HZSp1mdgBayE+4WtL6CZqGtAsHGt7rWMWjemESx/aWuHCFq4dZk9OAY+oTGQIz4SHY0giqbxAO1sF9yxJpS8qgMAPUkoX+RwWDCA3AN58uDapJo3sTthHzgzwLGXQqjkSnXFxRhVEM0pgtKQTIx8oBbEIpibo=
Received: from MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::26)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:31 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::d) by MN0P222CA0024.outlook.office365.com
 (2603:10b6:208:531::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:28 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:27 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:26 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v20 14/22] sfc: get endpoint decoder
Date: Mon, 10 Nov 2025 15:36:49 +0000
Message-ID: <20251110153657.2706192-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: c052191d-26b4-4f05-1e86-08de206f1024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+FNldLJsozjKYTTntO8MB0H156+VBfsjvnhB0AXFq9jRsGCfcVCvcrAv+ZC?=
 =?us-ascii?Q?tVq4XRWMi3mBkGCWohuqKxhcHmbyAQMm8loc4B2rJugIGMVt9WY8BgrBYoVc?=
 =?us-ascii?Q?FwKxW9tbq43meBJE/uyPCBAOTyJ4K9A9t0KwDnkhvurA5nkvVQg8FGn6NN4h?=
 =?us-ascii?Q?6M6UnIFG5XLpDfilsfU2idYC4KpaSQAlHfSdFl/r54u2qfYANtvdHPnrbxp3?=
 =?us-ascii?Q?I8gh7t2eqlkZTNOnKl/sgTrm2Otx4fR0QGtBS9XdKFI/0kvBFubjh/RErAlE?=
 =?us-ascii?Q?P9873lB49MaN9kNl85qtofp+UyYyaS1YmqJXawuAFzTobXH+EBFQ4P1t1nBt?=
 =?us-ascii?Q?xKDOkQ8UTg2j5B+tdCkJboBvYWCn8p1H1zm6GwIYwEVWS2lrXALgz3bqr5Au?=
 =?us-ascii?Q?nC5co8bUslwolGa7/+9v3lg+argXGlspYaEaXfUzjZuD1sXBzzq/LXoUadC9?=
 =?us-ascii?Q?IFsjVE+z0Zw/yxuOWfew2SCUdH5OaEo+Qm+8WrQNhxRjtbZFQsK8KihDa2m2?=
 =?us-ascii?Q?Ba7M9xHjKKiXMpWMZHSL/ykuehf1/k3mDLs6Sys7yAfZHVIIQPi1pykTORPl?=
 =?us-ascii?Q?3jGbq63lqmMAHHckgQHWhVNQsR9Fw8bnlNLDAQqi7tPCEeMjE7nlLF2ZnTIP?=
 =?us-ascii?Q?36Hw9CELx1iLl8IFacOhmMI4fs5KmwjVtdmc8CY5yd2TrkSXQGmpE4hj8o0A?=
 =?us-ascii?Q?B8IrwL7vmIVr8TqA8yOGZpHTsXtJxVEpU2d6o2B7C/Vhln416y9yMw+/rDTb?=
 =?us-ascii?Q?2rim+7dBDRqegMvU+f2zGx3DhFDrjhoI3AQlCH7+RD+4uc10wbTrFyq1ym1b?=
 =?us-ascii?Q?4yvnYAr0jjVY4yv/CUY45OqSSOPOUoEwCMsKTmQJ8lPucR7dfYFoffN5EYT/?=
 =?us-ascii?Q?f+tRyWFEbMg+7sekhGHmuq+lYFIjpCT1leelA660cpgWkuA3HP2sXnUqhJDl?=
 =?us-ascii?Q?tyJ6AjNcjzNgiTvlgqS6kqi/IpLClZquhj7NNODDYfStG9bmQdMjFe/lbo9f?=
 =?us-ascii?Q?yzZ849l66xsKyPl2uSMdA90fThZcbWOrowj+gT1mcbqtd4y5Cqf3JVyRNCEG?=
 =?us-ascii?Q?bk7Yt3HFZcd1RZ09dfcS6jAlRm9VCeya9oaY365Vl3AGYMiEdx8mBDbEoktr?=
 =?us-ascii?Q?kc15f8/CISH0ruvaZwqWiACHLWRQ7kBl8fA7HRQJEe4K4OADwaknNQZcwdHh?=
 =?us-ascii?Q?caAaE8nkU63p0oRr0wwOg3n8sxkAzUYcgB8k0i+5x9QF3LgkAl7X5IGL7PSK?=
 =?us-ascii?Q?g8lsC03MrgwW7Dz75EJPSC3nSKrCAimZUenFQNMHpB+MAcyaMrUoAHKEckOk?=
 =?us-ascii?Q?pyAOVKWSazmjxiHM5X2HKYs/hvqKthhPlOrNiTEITheUUr1Ls6eblLOOk90E?=
 =?us-ascii?Q?cAVh8ECwCbVCxkQH7hjx57Bh8KU8WIsSzJxph+hpVQJk125P2J/tk+BZ9fTV?=
 =?us-ascii?Q?KbEyRMeTcr/Jx00JWzByENCXbyYsuPpGSrt2klzH4oRhkSM4l76QhZCFTLYE?=
 =?us-ascii?Q?0LH90IHp1EnSELYg/VZgVJHEZGeg83ondYnNV/WAljACcSCy9TabvsHI4dEd?=
 =?us-ascii?Q?3bPDbvEMGoViySBsvMs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:31.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c052191d-26b4-4f05-1e86-08de206f1024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d7c34c978434..1a50bb2c0913 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENOSPC;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		cxl_put_root_decoder(cxl->cxlrd);
+		return PTR_ERR(cxl->cxled);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


