Return-Path: <netdev+bounces-243797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E05FCA7F1A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC87327E932
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AB32C93E;
	Fri,  5 Dec 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rP+hCn5D"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E531A818;
	Fri,  5 Dec 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935614; cv=fail; b=M9F4qcTT274j+PoGOUj7danv4Bo8kpWiwLrgd9LldrfYFEMq0dNSYhqclKek3mP3J9czzYPxWPHptqcjYKzgtoArYcT2gxjg5RdgiY370GL0rn2vQ3+za8bFc27n0LBQGY6/00BsZpcrhicAoTVGzlEn01IkK9mF4aYFTrcOPuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935614; c=relaxed/simple;
	bh=y1pHASF0DDyczTSM3nfJqHNUVpElnhljDtdMu1qY/4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b95WbLdrC+mHutb6kKlZsKUrB9r7HfiDeVBNAbFcBuFrbltdEybKAESC0/dHBCnj0fr8l3DKMMyA/6WIkJ5myDlHumbz+15ixOP3Iv5YFthHH6ibZC+L7cbuXoOlw6Yh292GNFBYme+IAIiruOwOSiyY6OoIknEqHtsKSHv5sfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rP+hCn5D; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/v+VHbuRwM4TKIhNxnedrDWFZk5Kv8YOrV+Lxt+AKLpY/U8KExyff704foAeze2yyyL2AO9YsalvlQ6OjcTWfTKeOrXXKcyCFLKus2peYjC7OiRGndyZjV/jnLvh24KZtXQhOh0mi3JezFMlFowYticNb88fTlbCan0liB5KTLGrZ7iP55EuXbdtirJO29R5ZAmv89idNdABZ4dZwcJJgkOBZW878mtOmkUWijCxQIQ/66PlnQHoD7kBlxkHQcEZ+cox5Rw6dxlB94YHt5Tc4HPwi2pZ3rUkjD1T+Mm5PyGRKpjUqQKm7PiPEz0Rel8G/lvdkeX6HF9Sp1hWAcVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvScouCXod6KmRxW0MIhF3DHKuYMKmiXMS8DOKG+wlY=;
 b=MmCAXl8VfY3LKFQRr6xQZQn3n3+E96x5RxGIJc7feBlvygHwSYeFPrX58HWWStxN6Sg9pQOF9jcr5W0cON0TwVPw0QyaOKk9rDvd36MEYbncaGiNvQiP5a1DQGmMxZH3tAAeAnaw8HTaW5Bdqv9MKdfh+UglKnw2P0ZiehMsMW8aCEb8fQ4w6SCJvyedyd97ASQspn4dLv2/stzFg1QnlATT3djlQvQHJJF71dY3tuYiKdVal6CgQLEDABHyVeyqsfM2OO9ctLTbKb3XU1j1vqLwPh96GZ+HE5vzyQv0DrD3iB6OfheMUJMpcyZu3h/brucnlVwfqRvVoCiNE5QQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvScouCXod6KmRxW0MIhF3DHKuYMKmiXMS8DOKG+wlY=;
 b=rP+hCn5Du9IwIlrqrEL+rnjoP9GIYID9h64P559MmWcYBVkxbyNji8uQd1f8WlNXespNzQ/vVwXuUnSxwBOjuxEiyh6RuKBiMQ2SLqP7QWCWWe9fENEPfTCQxDlojJIq2L2u2XYHdTZz323lDIyaD5UlkJBwZTiR0q/GgPjYHA8=
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:22 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::c3) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:21 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:20 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v22 16/25] sfc: get root decoder
Date: Fri, 5 Dec 2025 11:52:39 +0000
Message-ID: <20251205115248.772945-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 38faf40f-255f-45f0-5814-08de33f4e423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09i574z3lpVFq23h9zgCH3crzmhBHYYkUbArD86T++FFInrwIaBzHOK/h57v?=
 =?us-ascii?Q?YCH2nB8tb1IbewcYYHYN4rY4em/pyn2T1huYhWWqln9mOK/yKaECKqqD1trO?=
 =?us-ascii?Q?OJfwBfZDqm2D4+gcxGO7LY/I870/xvXjziG2gcz35qahre+l8MGdm6jUYR12?=
 =?us-ascii?Q?r8KKeFrb1pAiFnD9I13BiRY7Zcv35/WlOl3ngLY+RSXEoS1oc+V9PU0wlryp?=
 =?us-ascii?Q?omXPjzMuOqm+MD3KaFuWageffp9OiNYRxgd/H59ay1fxRY4PFiwSLooI9uxp?=
 =?us-ascii?Q?F0bVbL+d4uZWQNM/9GfqH3csGeIP401iGOnHYESDHA49yM9GGYN8pesJLAer?=
 =?us-ascii?Q?uosbu6zaAWYtwdQ8ISxJai8EqwHEvSaIBZYpKVs/b6ctra3XAaL+mRFbCrVo?=
 =?us-ascii?Q?lBDQAIaO0YFKnSZASUt9a5q3BsPWdXne6vMSPomRCQhe9+c7V8E1nkgBtJ5p?=
 =?us-ascii?Q?gAsE6YlIoTkfMFbSg7M7RIc0CJDp5NJl2vnCv0aEKhAjvYKEly+UjIKex3B7?=
 =?us-ascii?Q?63wC4x2SQmcqqJFxF0sKDEMT+KulijBBq6pACsOnYhXBzIM2poII+ggxJ1pa?=
 =?us-ascii?Q?yC7VYCj2F/ruTDcT/m8/+2wgMjSytgKKEUT96XBg1YRolKkoUTh7lb6r1+Lo?=
 =?us-ascii?Q?cRsYbEA90rpMSiOSXHoK6x9hMM3obOBMonPNdpA/gbdVLQd0M0XNPfGPsn15?=
 =?us-ascii?Q?IkC2UyrGEzHfRcV6kB/EMdZkox0o0SdVjME1b1KbXl6Wx5iSJpWovxadWsJe?=
 =?us-ascii?Q?ROHfzIHgxflzmXlnzBxXhPKeWEVZJ1Jk2rlAmP83mHutyKWFPKJkvWWM7XPH?=
 =?us-ascii?Q?l2SrsG7LEqA/W4zHfvkeYKXe2qSOWbuAxyFeOIv9A3Xq7UMTxj2+tL7WvLI4?=
 =?us-ascii?Q?KtZhfcWSUtlONd8wYPe4/gO+8KHE8fusNwtXPoHa8Yd/XpJGxhhUSVlar78s?=
 =?us-ascii?Q?RBsA17Z4b0V/lWQ3CzSMpbEg++CODeE2fxrUUSqtM5huT1dTTAhtWc0LHC43?=
 =?us-ascii?Q?bk9maB2nQCat4BQOc40M3MXnWMbXwtZQ3IQHznS6bZzp2VZWnB8IM1mcp7gn?=
 =?us-ascii?Q?9rfVOffRNz1M0AwTKwJ6J4W0m2I3aVF23GzpVZk+vPDcIjFc8u5J4U9kUZHR?=
 =?us-ascii?Q?g0VFkI7kW1DuyYluW+ZGgtk6+Jwb6BHD8bxHkKW8st+mmFpt8aPMJqOGiD5q?=
 =?us-ascii?Q?aRtaAgGc8r0k30FureOaRq0aJf+WlSAu3vk5dpPg/5qId1g5vBdhuNHOysqN?=
 =?us-ascii?Q?6uF/IGizPtX0r9OP3d9cuay0HLrDCU0lCSyLOlHqWBf2dy04QLw39B9DL0TF?=
 =?us-ascii?Q?qizNgtxK8ujX8kpvtP+p9DqMLNFOdJo4N+ZeL6MYKAgbXKDnYFdzJoXaHHqv?=
 =?us-ascii?Q?p6A6DTj2CPkqBKGcSowLWtFtSQJN3FGrAupaN4BpzvxHAbPP3YcXzICRF6k5?=
 =?us-ascii?Q?qr8997KCGSWN7U83j0geHfnZ/E5Dtr3y4WfDSwGIlahaUV45n4rxzzwnWLv8?=
 =?us-ascii?Q?0sb7ZROODjqanO8d4Rxf3gC7ntLabGTi7a/Cnt5z0hsF3PFVZWkDLPZWkAkj?=
 =?us-ascii?Q?NOhJV7+UnJOklQQfcMg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:22.5112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38faf40f-255f-45f0-5814-08de33f4e423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting HPA (Host Physical Address) to use from a
CXL root decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/cxl.h                  | 15 ---------------
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 30 +++++++++++++++++++++++++++---
 drivers/net/ethernet/sfc/efx_cxl.h |  1 +
 include/cxl/cxl.h                  | 15 +++++++++++++++
 5 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 78845e0e3e4f..5441a296c351 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,21 +220,6 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
-/*
- * cxl_decoder flags that define the type of memory / devices this
- * decoder supports as well as configuration lock status See "CXL 2.0
- * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
- * Additionally indicate whether decoder settings were autodetected,
- * user customized.
- */
-#define CXL_DECODER_F_RAM   BIT(0)
-#define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
-#define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
-
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
 	CXL_DECODER_HOSTONLYMEM = 3,
diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e959d9b4f4ce 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index ad1f49e76179..d0e907034960 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	struct range range;
 	u16 dvsec;
@@ -109,6 +110,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
 			return -ENOMEM;
 		}
+		cxl->hdm_was_committed = true;
+	} else {
+		cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					      CXL_DECODER_F_RAM |
+					      CXL_DECODER_F_TYPE2,
+					      &max_size);
+
+		if (IS_ERR(cxl->cxlrd)) {
+			dev_err(&pci_dev->dev, "cxl_get_hpa_freespace failed\n");
+			return PTR_ERR(cxl->cxlrd);
+		}
+
+		if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+			dev_err(&pci_dev->dev, "%s: not enough free HPA space %pap < %u\n",
+				__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+			cxl_put_root_decoder(cxl->cxlrd);
+			return -ENOSPC;
+		}
 	}
 
 	probe_data->cxl = cxl;
@@ -121,9 +140,14 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 	if (!probe_data->cxl)
 		return;
 
-	iounmap(probe_data->cxl->ctpio_cxl);
-	cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0, DETACH_INVALIDATE);
-	unregister_region(probe_data->cxl->efx_region);
+	if (probe_data->cxl->hdm_was_committed) {
+		iounmap(probe_data->cxl->ctpio_cxl);
+		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+				   DETACH_INVALIDATE);
+		unregister_region(probe_data->cxl->efx_region);
+	} else {
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 961639cef692..9a92e386695b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -27,6 +27,7 @@ struct efx_cxl {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_port *endpoint;
 	struct cxl_endpoint_decoder *cxled;
+	bool hdm_was_committed;
 	struct cxl_region *efx_region;
 	void __iomem *ctpio_cxl;
 };
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f138bb4c2560..6fe5c15bd3c5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,21 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+/*
+ * cxl_decoder flags that define the type of memory / devices this
+ * decoder supports as well as configuration lock status See "CXL 2.0
+ * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
+ * Additionally indicate whether decoder settings were autodetected,
+ * user customized.
+ */
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_TYPE3 BIT(3)
+#define CXL_DECODER_F_LOCK  BIT(4)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+
 struct cxl_memdev_ops {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
-- 
2.34.1


