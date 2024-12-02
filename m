Return-Path: <netdev+bounces-148172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FF9E0994
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1479C2824EA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABFF1DE3D8;
	Mon,  2 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O6N90wZn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A141DE3DB;
	Mon,  2 Dec 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159589; cv=fail; b=ti8+mUHtj/+6KfVAIL/qflH619H//KPFaBn9VZ/te481J4CxScVluNfVATjlQazViukISLW3Cql2FFa6EGNfvRxku45ei0TJVMa3Y4K5XqiFp09I+XgSgQaBmTHGvdoJlI31XsUAgP4yjB6U9aLRrcyYF04O2hz2YF3lMIn41EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159589; c=relaxed/simple;
	bh=rtC4unKKcr4+IwQUPkTNvDvWq89erz+BY2vmbNCy9Vg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrEDyLSVpVAIAsLlfWWa33ZG7ldr7N5IyqCyQrTsA56TOaKrBSQpbD4o7QkNTTVySN1/Ht2Yf/h1NC0hVhFvI5JYlxqmXIfxAJnn+EnhocYeniE1UE+dhDCRM39cJSLRs2leb6vxiRdzkI7mfJhONtmLyOU1NQOh+3+ITUnVv+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O6N90wZn; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waZnxxEgskZjNNuF6i8AoKexM/F5nfxTk0OtN0otZ7c/yWsCV8ra/bh6C/Swf7Rs4MT6SFmT8rqI6RIygeHsg86sBaiRhkjhbNoa7GPzToFbxltnU5hUb6OuslSkslOIsIZ6i2cxjgAfzoczTSVqhiGmFRhItAb/7kTOIhKYdwB1abPrGy823xuC8dT6Jdtmw1Mo3yz3kOYWLJaUDt3QGGZVwkIPLBCEits/BC+3HkfTyzIvnQmLJZYZTtPDCUNHwme9ho31h9VPl/N7I4qCs8WG2JmGZiY9Nu8dwM3qW3Nlmk404YdcF96xYyPplHQw2SEUPKuBrcb5swJFedRSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5hz7WctsyYqzSNvIrR2kbXpYrg/ZIZzxVXRlKRoqg4=;
 b=hexRCwOtUaDgW0kNkC9O6QHLVFiYqmoGDJzcKtwi1z5Df9UoXiU0y5NARDAmLgjrionl+BqyLwaEfQIVyHwy1KS3Xsq9QWidyogxaJYArIVvDaqKRMguEmb333Bgf6dUE7bjzcGrZLlB65HEPUsOYZoGcvEdpCIGL9ec31RtLixWcyvYf7W0ydI/0KlBFMdEv9NTGIDnkSUqdr9a89C5OtRXK0gn55SNnjnqywW49m9fOe14p5fuBU2BBa0VZBTIBl7+1eXdSktJsEzQAoJlTlc4KLG60Y8wMRzmLLcWjpvj2k/hd9I+itqPwStl2xruj9fKup2g32clLICZOhy+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5hz7WctsyYqzSNvIrR2kbXpYrg/ZIZzxVXRlKRoqg4=;
 b=O6N90wZnSw5OSYMkd6NV/fYCstJ899v9KFPDxJG7mqur5yNV4xqTKa1mlrRbkRRZnHFDEfS7DhHafwpOnoHIzW9/BhzuL3+Wf8nWsSgbMiPQZCuPQewkRaSyf2Wbl/zA8eDXPELE39raMsX9LeHPZLXY4P1T9TMwaWRCW1DK9NA=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:02 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::b9) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:56 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:55 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free space
Date: Mon, 2 Dec 2024 17:12:10 +0000
Message-ID: <20241202171222.62595-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5998c566-57d9-4dbc-b053-08dd12f493f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOMdEQkfK8Dj0kQcf8Z9TLA1hjlqWYQ/3CdPUZgFAQ88q+DT2b/+24snOY0f?=
 =?us-ascii?Q?06v8e2LWXpdb09Jw+mZdrKQGvjfnnqLE+EBzJxOzHR6+MKDRxXaqbhVwPr4h?=
 =?us-ascii?Q?Hh7Umym/e/ebNIAplNdPFiy8CZ/mAWXtT635NGnNfdrnkWC/e7jFcBy9v2RC?=
 =?us-ascii?Q?c3EmjOuh4Vh8RuoHhM5wH3Br2Bz6koANYylbw13HU03lyBlFDfAKqlYuWV0j?=
 =?us-ascii?Q?PTaqXWI6XcVFzk0m4lfQn3zqo+1wFrQzMU61kZlWwJfoM2C/mlmqdsyR+Igg?=
 =?us-ascii?Q?ZeUCGSiYB5o1nz4BjssQh1uj2BHjaLGz7v/pQu7hfhjHE5nPfXg9LqzMWPmX?=
 =?us-ascii?Q?pMXVqbEQNndwYzbSbz+WU6iurY30eM9e7SiM5s9Z1TVQO2UIPT7rqUOnQsP5?=
 =?us-ascii?Q?kuTK4U9Br8JrTBlxOgzDxAlu/hoSdQOG2EVbiLTQZ0O+yEtCooteRqpLwKVy?=
 =?us-ascii?Q?tSw2XD+uvd+J2wVUTHDlJPkBmf7SBBVVHCn/7b2LahHJKjSPsv4BZz1DOWFd?=
 =?us-ascii?Q?arGDaTs06Ab94IeJg0v6n55/7HB4s1ItLcZIOjwzjdD4Mr6sfNKYiPdTUA9C?=
 =?us-ascii?Q?wiuW1Iy2r8X7C+UldUQDdEzCyGMRJanbwebRqUNgaKTDv02g8FNDLcmN2noZ?=
 =?us-ascii?Q?2iB08G11ktiy+uRcTXGN1CduYkU3hOmQNvcYedNsGELnORboUlU5GTn5kKRl?=
 =?us-ascii?Q?Izm9Xl/3uscWDFIcMJ3ZXCGWnS0sOqmrJsNtvjBRPONB5PxnjZ8aj6HnwqWv?=
 =?us-ascii?Q?t2J7l3QelzW2ArjpP1xGTKK3nI2O6CL6Qxpw4ohy+1YDOvuG0SIvKWAgJ+ah?=
 =?us-ascii?Q?aQIXoKsu7Es5QH+n0BtL69rx5pztl3SU370PcPpCjnQJjUgubNT74Q/fvVuB?=
 =?us-ascii?Q?T1xqNp0VzxGvkCCutWNr/rcxsrPAFSbcVeJD7+NlOB4qZez5EFapliwXRRJs?=
 =?us-ascii?Q?+XnheLF/O7s4VaOS2hrdMZOWkVXBB337pUrNQBGVQwBbvIG78+/yDgofVme9?=
 =?us-ascii?Q?cvfwXy/2VMBuvwn5drA3mf2TS2MAh5MkN7WRUamH0OM/kzcNAj/kBJK02QbR?=
 =?us-ascii?Q?DmGED/wRHeaOiwR4vxmVpA89Tr4DOz6Kh6Ml+BlNfWlfDZ/ow7WmccsczfhI?=
 =?us-ascii?Q?xHkEB7ZxsjTOCWUoZKoT6chMMT0VpKKFAFS/yQvWK0yNj/gJjseRlSdvCvTS?=
 =?us-ascii?Q?wLCokpkcG0GjbrvO0qKZfw8iX2UpZrd6wRfcT6ikm6qwZqddL6V95Ws/DTLG?=
 =?us-ascii?Q?mka0FNvS2bxf0Cgn21sdL4TaeJdrfioCAXmi6UPEMD9ZgJTl8RPkXVHH0zt0?=
 =?us-ascii?Q?YgAFEUQk+kNeVRdzG+1UNfyEoh01O6sUSP0x19gUf54V5STbv/xuu4P0GZbT?=
 =?us-ascii?Q?pLUeSRrgEZmjoytwHUpPsJGNgD0DNoBoCQ4MohvxWnLzcPYddZvMyOWn9Tz+?=
 =?us-ascii?Q?3ttqmV7TG0sKTPC29XB6c+gjIEpH1tI8jQDJp1+CwgfZ/0fWCSTGpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:01.9722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5998c566-57d9-4dbc-b053-08dd12f493f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

From: Alejandro Lucero <alucerop@amd.com>

Asking for availbale HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d03fa9f9c421..79b93d92f9c2 100644
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


