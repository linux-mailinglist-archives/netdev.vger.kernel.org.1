Return-Path: <netdev+bounces-243801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD3CA77A8
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8030308BA08
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD313551;
	Fri,  5 Dec 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WDdJMpsU"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D29330330;
	Fri,  5 Dec 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935624; cv=fail; b=e/J8GRzOVphimu2LCtvfcm0Fw6pHXvxF6Za/hwRHGK6fu/uB9PYgIGEXBPPvdWjWb4el3NZ8KhzqcBdlLgO8UqQvC0FRpI3Nhr4HTneCQZyj28cgWYDO1mfki4biRNkt+f+5wH/ga5Hanv49d2G0PVSCu2JlnUVmfnJ2lxzYfNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935624; c=relaxed/simple;
	bh=BCbBHL/tSCEaxCQ88QhCRljIkg6lUCctTYf1BNAyKqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfkjYIfpo7ZbfrqG6I8NyWYUUyaTOP2oPh2ufXx1XFmv5NCXqL3KVEthguVnupKhaDtLlzdC7qsDQhHYSV3OdRytQQMJTeyLW50wAZ3VQeXA8n/74DQFXyT77q1wLU0HV6uR1ex4bDwZWRdWafy4KPgfRrsIWbhrezBw5Pf9FwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WDdJMpsU; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcEIDZfiIKEP0+6fCBynh+z+z1/8bSuJWfQngJxNMldCiaDJ8B7w+v1AeZk2F9BNmZ3IafGBiL4ead0uWsT/WlrzdoIOOg56jp3t0h/xzQ1M4JZkZ2KlrfwXFpVShIS5tOXTcoK4MEK6OQ9BvN/c9n7ihFcrtmb8IQRvIM8dT93cD8qb6jSx7MWTfQmPSfDkRU54oh9R0Du0TeYS5v8usqPnTHIy+e5Em+tqo99d79kYe3mLIFe0ZByGO4H8ylpei93ftDAADerx8QiYZ7opvHIdCFtYUSOWosduCaecke7Hz5AoBNH7nMUecYzsvohk6IdQP2w4yW1NtkgET1SDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0oUQ2nrNnxkSGyAlBF2lW3Hc9fvr6vrH9MzUO2cVcI=;
 b=MMhSwK1C1tLaNFWdru/cOfljyc0yrGe3Mb5IidD+4wo6ZsDSNxFcOAwFj5QnRqHS1B99q3RbHp0iWlKlvhTWpX8RQNSrXHuXTcTUfWAW05nFpk2NF11NdsAN9JTWmg+gPzRzxtocFtY5ot7vuf2tQwYwluoowtAKkXBEBYMCgrTAiGogKOU4BwsgqPkFiTSqDIf4WrZH2320hjQbsL3xIXfJrB8H+jB4g5sMp0cQCCv0KLq4vwhcvUdpUn/HlayBLoxda2HU8yKfkG9dbJHPKLVctu5aHhb976nIwLgbU4/v7GbXoiktoU9uJ1cwSR1YRrAmxSfiNFQ3gJtAG4NSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0oUQ2nrNnxkSGyAlBF2lW3Hc9fvr6vrH9MzUO2cVcI=;
 b=WDdJMpsUGJZ+sGvoG6vxbwE7HwennYhGUow8/MpaaHN871ZlDhiFFW6AxFJj/AuZGzfN1XnZG5r4AijltjYqybQ1Ox6q7TEHoVZy3KQBSJF3ZQp2ktkpvXgSRMUBW1g1acBugI3pTBG6xkgkrYxIWd+ee/YhtSlSzoYCDQMkDq4=
Received: from SA0PR12CA0006.namprd12.prod.outlook.com (2603:10b6:806:6f::11)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:36 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::d9) by SA0PR12CA0006.outlook.office365.com
 (2603:10b6:806:6f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:34 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:33 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 24/25] sfc: create cxl region
Date: Fri, 5 Dec 2025 11:52:47 +0000
Message-ID: <20251205115248.772945-25-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e4273e-0f08-4717-d230-08de33f4eb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BK4Qppd+2C5Yil9quN9LvJ+zMpA8JVq7rjAnd0Ed9TDQ8zhHk4AqL9/yyrVv?=
 =?us-ascii?Q?PJ6TtW5ksqRaT8Cg8a4kFnM7Zqqupb+Wn/3UYPKenzqZfDJRV1MsF44gmFXv?=
 =?us-ascii?Q?wZVp7eam097NJ6+ahto5yM4emAFjc4lELY4IiE5//WATSBt62PIp4vvCI3AO?=
 =?us-ascii?Q?OgwScKNfE27MOaB+xm0pVllTUfBDjCSi8pdggSM1lnBCQTx5o5nREC3JYBeQ?=
 =?us-ascii?Q?sRgqeqym7NeCMcMfUgDypJdUvVk8my6bnCC9IhtrmsyzC0IqIgDbMVYkDNej?=
 =?us-ascii?Q?LcwT2p5hzd9a2LTf8BpuS0vD1NTNsFZL/h4e1VMEdc9BbbRPP4fH3Vk+yACB?=
 =?us-ascii?Q?xdLeenq1XNkwg9my3nf80YPbUjTPPYqlyoRWayTa9gldkx3Kx0xQKC3wT7md?=
 =?us-ascii?Q?9L6n6/RGIXre4Lta0SXPytASm49JFz0kHeNpYN4/hjOIpKek71BRRYbDBdt6?=
 =?us-ascii?Q?VXfMIgxiqX9CjazfEl5Kb/3xvisvKJQxtGzIHitvxoJPDIBgnR365bOiB+kl?=
 =?us-ascii?Q?HHERx+MNa5Ks15LeMEZldqOizfivhJwPUxQ9OyeCgPqszHu8F8t+lJWaCdPZ?=
 =?us-ascii?Q?wjXyyAiYqqKS+SCqNwsi5+arKC0Qgk1nZRpCJRJPaZaegLuQ2sfYnRK9cGWG?=
 =?us-ascii?Q?hA9jvwySZwid4Pbs23G8LcamzX5K/FV1KLCMhBj5BSmMs5U1+i/YXjOuScrR?=
 =?us-ascii?Q?z0rfCN9j8AS5t2/pSxReXaO9DTphkhLqRpYyMPT/LOLVVfu14Zj1YLI1X2jK?=
 =?us-ascii?Q?t+o4l27UsjJO3Ou1yqziuAXKRdPcMWiHirlxNpQTyXnTDHubFvgUJurj6AHv?=
 =?us-ascii?Q?frGXESoV82gebJEOVn8yFIlzkv2YJZHKLDnxo35kNWZnudRt9xcKmDIn3oP4?=
 =?us-ascii?Q?TU+h1O2KCW4Ceg61y6o5Re1njhDnKN54T0o9RgY7lIxGdcpieWeoSC3zDg9p?=
 =?us-ascii?Q?SRaRw00M6BTv5kQnS+ay3bRTBc1pw2EHNiOEV/ZHl6NlD+tgzKkE5nARhQSz?=
 =?us-ascii?Q?ipWka+39AKoLvGl2j5sJRL9U4Ip9o3mrQVUBEiIenQ1AmC+fD80qAs6/bmzc?=
 =?us-ascii?Q?jGtr8nnQ+xVlwOc+j8snm7i80nn7/tqYriiT1ZLO6PZ2tjJptDIKTOM+gwe8?=
 =?us-ascii?Q?oBhRDRO7nHZ0W2Po1eRTFEyFbCPIt+wvJJ89HKnS3BVKxh49iTBTct+SAkCj?=
 =?us-ascii?Q?bbEoWa8BOZJiGYd8ml7Bz7pbLCYSSA5JTWDuMitowN9Vm5yl4H0cfcfWaVD4?=
 =?us-ascii?Q?SuGHXQEDK+Ck8M2tSy4AshqLQ2IX2ySd0ulbckka6zRXOeK3SNAVd4m8h7es?=
 =?us-ascii?Q?OwrPn7WC7nNOgTcqkFxmDRgHyD4cXmLkF3YPwBvw878SWkkIOUMIO7mnTNiv?=
 =?us-ascii?Q?bACsvt39to6lw5u8NCZSsB5atvZvGjCX/SIgnm0D66ZTsU5oCLKUozo9Fwzk?=
 =?us-ascii?Q?G8gtwb22b586HiPNuXQ9BhWKgmJeWekB4/tbEhfm0nhVutgiWwg4DAIhSXEO?=
 =?us-ascii?Q?sEygaDofA1u0m9xKqU2wfehH3cLe94oMDKvBG9lkSYEurBcN7lKFwCpZEBXx?=
 =?us-ascii?Q?V3bUHBeOy25bci+VXfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:35.0373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e4273e-0f08-4717-d230-08de33f4eb9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 56e7104483a5..18b487d0cac3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -136,6 +136,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			cxl_put_root_decoder(cxl->cxlrd);
 			return PTR_ERR(cxl->cxled);
 		}
+
+		cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+		if (IS_ERR(cxl->efx_region)) {
+			pci_err(pci_dev, "CXL accel create region failed");
+			cxl_put_root_decoder(cxl->cxlrd);
+			cxl_dpa_free(cxl->cxled);
+			return PTR_ERR(cxl->efx_region);
+		}
 	}
 
 	probe_data->cxl = cxl;
@@ -152,11 +160,14 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 		iounmap(probe_data->cxl->ctpio_cxl);
 		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
 				   DETACH_INVALIDATE);
-		unregister_region(probe_data->cxl->efx_region);
 	} else {
+		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+				   DETACH_INVALIDATE);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
+
+	unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


