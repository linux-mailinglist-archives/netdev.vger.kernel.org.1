Return-Path: <netdev+bounces-150357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24379E9E9A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D09281C1C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868F1A2C06;
	Mon,  9 Dec 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t1xukA8z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22B19CD1B;
	Mon,  9 Dec 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770521; cv=fail; b=lRbC0NF8lTDnknc0DRLCDPimzSKAEU/c8WGYTnvgvVHpy8ySav1Lvd1KG8g8PF9aDkyiJSv0gYRT6azKcPRDjsLkkLYyrpD5HkhbJCltrejxgxb/A1NDKUzYsehqNoC5BFtuCj2hghUlOLvlAu38gKODeugYRTpbFyynM0CAAcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770521; c=relaxed/simple;
	bh=LTWGAtkie+ntpHx3B91LUTt9cPkmNFnafLzqencQ09s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnp3C2glPM/ilzk6D30YoLn2agSuDv7vSMzJN6+8L9Sy5xUrHAnNzARkTN4EMBYh8glcyoZsoImfn6k82ImqqcnkoKF+VtW9UHowXf4ZXiz5kto49cyDsahWCI+49SIfQfSnyEA2TguiGse1sgAv/kIJCAdiZ1ZLvs6AZG43L9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t1xukA8z; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGRGXe2+wciJESI7IYfUtDrDFAJBO44OD3adwODduqf423z0CDAqbDYVtOlh6a+fLzZsQnS1uyN8PxOtn8WLCy81ZHFLvGjeZs8FInH1eEQnTuH8QJNbcNcrlK/5Z8JNyaNqyb278r0iyrbJvjwI7eqqOW2pnR8l54mltHats5h6tU4daTpoek2jg0QFcxsXqBsyUl8UedELqMXPoiBv+swXfVkNticIQlBXp3bV6damHjgDQpOojkc0OPt8uCyIbJP/jsqAC1gJskGPbRS11o0tbmol8Y8By7OuGKKOIGk3iZZLGMCvUdhzRgpfUVzyNJFlWm0Mia+5C3u2QdQraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3uzLOFzndABcXfe0aSXlrBk7l6993v5m1Bbc4huAT4=;
 b=Nn2xFG5wCJebOSKEK6uUrfmEUv0yfgM9rMB9cMhSF8juazdBFc7v6jlZjGA3xZGSjBd17IoFTbgCJUjpQOAfPnF1DWB62LeJzSzbEbglYTgtAFTyZhRQLopmqRYEgDYEdnluanybojg/Guy7bYCiPvoZDupV1eSJYSUnWFfArc7IS31JGfKN+z9VoCzo9E0RjNlkxCHhSQ0Q5LFbhCDn9oTBrmAPq+PuIZBvhqctJHdhXgTvhwfDvfzUMMR7VH00KXPxDtzQ6EeH/fnKRXHl8dkAdI/vnqvqrlpCsi83n08n0Yg8xasQge2U8LQnvHb9tupygeGK+E+UQF9pLKqOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3uzLOFzndABcXfe0aSXlrBk7l6993v5m1Bbc4huAT4=;
 b=t1xukA8z0CMvKH0T91CU0/TjNugC+rp3iGR8cGtuj4v+mQy6pNMS4JUuQh6vbp4OeyCu3J8sMKlOtBXeaAFE8/+JY5kHgIvvlZ2wRoH6Cutiwioq94yU6yMwP1Tba5MbE78zeAKAZc0roj9/CezYy5hpnfAhHu5yMtdKnIUhSkY=
Received: from MN2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:208:23c::22)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 18:55:15 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::8f) by MN2PR18CA0017.outlook.office365.com
 (2603:10b6:208:23c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:14 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:13 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 25/28] sfc: specify no dax when cxl region is created
Date: Mon, 9 Dec 2024 18:54:26 +0000
Message-ID: <20241209185429.54054-26-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: f351b56a-71d7-4eaf-57f6-08dd188304d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9K0JEU2iplhaa4eBI/0vvM+/kZpcQfdrfgw+4AsmLL+3/EDUoIpdpPwFlSj?=
 =?us-ascii?Q?mR2jgs5xTQ4sB0f27jHwMon/DrPTiqOsDaBVJoy6dFpaiQXbeKLZdFLNtkuc?=
 =?us-ascii?Q?Y76yvs9bxrMNtu/kSmaY0yad9xDjQFOmYR3oQD2vKqHGviWa73IZLgYuV8F8?=
 =?us-ascii?Q?rAtF1YZB9j/9EmPb2Uz1iFPhX3647jyY1JT4pzKlfcUvb72l/07BbVqkkSdc?=
 =?us-ascii?Q?TDS/jdEB0+O5kxZD9HZ3DN8PRWNp6L92yVKRdE7HkEI5lNk9dWsJ2t3umM5i?=
 =?us-ascii?Q?jFAGF3BwYmKiHw+KKAE9B0iiidiaVZa5pFOmYpaKg0AZ6hD+NTY/j2YNMRXc?=
 =?us-ascii?Q?8LvrMfGpN9gl12z/+YEjtAl6XZq6W0/ynKirEQCt/8VpAGG6YjKPzRounEoR?=
 =?us-ascii?Q?JrSFP/ak7iL4qcUH/rtQtX0+bjVvYH1pGPmawMT6BMMO6PlCtYS2wFPHwIHY?=
 =?us-ascii?Q?2k/F/AbVyWEEskfxfbKAwz7jEmGp67Ci5wwxNP2xP4kdpSz/Ae79oMNWq+9Z?=
 =?us-ascii?Q?+kqvr6E1vTRzxPQP/9dE/SHyj1JIobPCG2mmc82x9pHnglV5sPT9BlQzspF3?=
 =?us-ascii?Q?V2kWw+noRT6FxnQUVtyF6Pd8Mvczz2MK3DlLskXDyPzeBqG2TrZJWIf1RLMK?=
 =?us-ascii?Q?GbaiAVzPdm0b3AMruFJrsI9R0zW8EOwYB1msEQN+pCpYiFzskwrT198/HnyL?=
 =?us-ascii?Q?rlLz9U3dcUk9fCch/obsYNeUweG9EAbghBU+nKM1yPTTf+3JcibqFfhIIn4e?=
 =?us-ascii?Q?ZVkNBiTF6wBH6RDyE2LqB7vMbB3D75CeoxoNgme/dlP92KIS+WZ5NNFnoZ3y?=
 =?us-ascii?Q?kyvILjFrTcXPMIrcR9MEl/u3CnhEeoajm/f4Utd/Fio1BdaYGjfHApYZrQLg?=
 =?us-ascii?Q?+v7ouhFRWmFazTfST3CTH/6uTc9TTuZzHJqyZ1NXeYTe4oUUsRbtC6PZoZub?=
 =?us-ascii?Q?rTB7BL9vKid/0KzfqDEoewbl+m2oJr9nZaUm7NI1eeOQZZhJ0SC/b6owdUtY?=
 =?us-ascii?Q?SrF8jK/7xEgaeToM18/5gh532/B46TD8qqa7gDicBb0eqD/wEBBucnpOnvZT?=
 =?us-ascii?Q?yr+RZMct+xvafI/yRDmg6qPxU0cC30S1+Ua5qj2seDB5JCJLM9uwGiHtq5Bk?=
 =?us-ascii?Q?PkcE+HRgtssbD8GI/AkSsxgMAa35PDSS/TPXdseWPawH8o895ZWZH3I+HNv5?=
 =?us-ascii?Q?W+8YvMAPBQyf66QbTLMAIEhLjdd4Mzd1hV480ixPnJ8G6PJh+qDSzMX+Ej5v?=
 =?us-ascii?Q?FG4iBDeY+oBJ5TFOYlxZ8JjM1Oohnr3V1Qro2+4WOTwmSoIqZGyXgH55Ob40?=
 =?us-ascii?Q?trq9I/1NPrEXpOoKAliNwpq8cB4t2HnOj74wo8S74+les1g2mXlbjMoVJWRI?=
 =?us-ascii?Q?mAV7zYmogfA1iNgGFaN63sKrPg6GkifWEVfT2j9CpDfMj3b/K5qFXM3iMGfQ?=
 =?us-ascii?Q?GzxAh0EZh9jrIv1R2fDPBRzzXpRpXi/TzQ7IheEfUDyxDCfhAGZDJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:15.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f351b56a-71d7-4eaf-57f6-08dd188304d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

From: Alejandro Lucero <alucerop@amd.com>

The CXL memory should not be used by the host in any case except for
what the driver allows. Tell the cxl core to not create a DAX device
using the avoid dax at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9b34795f7853..e7c121368b0a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,7 +128,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
-	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
 	if (!cxl->efx_region) {
 		pci_err(pci_dev, "CXL accel create region failed");
 		rc = PTR_ERR(cxl->efx_region);
-- 
2.17.1


