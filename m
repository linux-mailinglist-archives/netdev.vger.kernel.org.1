Return-Path: <netdev+bounces-173662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08CA5A586
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5891A1751C4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B61E2850;
	Mon, 10 Mar 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QjuAnmg2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A21C5F1B;
	Mon, 10 Mar 2025 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640649; cv=fail; b=aPZMwSb5wKLFr2KViN8iY2LrwN+vNuTL2R6nA6hDCuJZsJ890USOd6g8+7cThuirG9CRMPlK76bH9tiEcs1fhnIPsaEVofldMjHzZ+vuoiI6or/rBgP3dgdmCDe6H1lDcs0N/k+DnbzDggzRQu4vwjXRrTiAcZRkBG1kNUtgD0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640649; c=relaxed/simple;
	bh=JVso1V6n7UofyyIxlHRu3NMK5P6DKIAWtMhKHDuvsLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyXKtVXlKbnZLxukoWoVktT1kzrZBZDOm44Js4DTeyLLcSKgZ7mzPLvWsD+ba4SST2qq+LhQzhcPwLu7uwBzPDsk40IqGvS9IjjM2wcPrpVdJs6EQgUN+EQHc60ORTjVoEKyczaCPSYpodEW0tFuoBcORKEXGvw2/lMf07HJTes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QjuAnmg2; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVjr3siwXociHq4h7X/P1D/eBLOofTyTx1PxPB5OmK9BLdxCL0jJXl/hP2K2/YJ0zyb5CTLfuA0KDGhPt36sojZAnW3IU8eS0J6v9txUE3qwbPH4iHv00Oak30IRrATMm60PwaaM5DjDa7ie6KixxfudxP9CC62Kr98Xixi4/03qzO3io+UaxagFPbWQKH5WH37uZ7JoyFuFwSfeuLmOcVyzeAyBDrqqo2YDe8HDp9AUdzuAtQiV8MljHavrck8FyfOuX5bGlSvGopBDTRDWqK22ZNv38pVEY1V/JZbBH2xbQ/RQeEpdEU2o5TYx8LfEfRT3LofZYJjyE5DN6vUiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAkCp9O1oS37axpzpj2aSR7diNheK8mZYdnKNhM+u+c=;
 b=KV3MjB3IRdF2a8HkVgnYvtHkAzdjAUdNwZJRsG6PwVyS3xfq3Spqb7mEuotTd/tJ7l3IA/rV3BFSdz0LXL9R/KChQCgcPG/9jYiq2wfN8R3iPMoRvUbS8jNl+UP8wH8YfhV/b5+qYeEDkubxk02Kni6P7nUOwP29RpjLEHZvqrIsNYSlsTfch/D+e34EECXqVGZuBcHQefXbbX9WAHYTOqFETHYbh5Qd5f2PO0M422/ZcOxKPW3q3lx/JL+6mVlji0lq4f9HYLcEUJTWS6l8F4iNYupiUmN87zbtAv6PFll3357rtVzC88yVXPGhrGI59njrdnLaSJ6biJAC8c1yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAkCp9O1oS37axpzpj2aSR7diNheK8mZYdnKNhM+u+c=;
 b=QjuAnmg2h05Bi51LDLAhiYYm9AXx0ocuhr42Oym7tLk4NAJuQ8K1ex7ojkQm3uJ6kniEj9kDG48m7XpvPtouZkuBdeecHe15Rc4FUztdl+QGgtn5HfKDk5XpniTY4vhLTkC017kwN1jWfd4LHIHCYSgbx7vZNnF0cwYa79BbFQQ=
Received: from BYAPR07CA0046.namprd07.prod.outlook.com (2603:10b6:a03:60::23)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:02 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::6) by BYAPR07CA0046.outlook.office365.com
 (2603:10b6:a03:60::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 21:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:01 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:00 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 08/23] sfc: initialize dpa
Date: Mon, 10 Mar 2025 21:03:25 +0000
Message-ID: <20250310210340.3234884-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: be398c6c-5d61-4ee4-78cf-08dd60171594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHaEZDUBdx7jEx9NE9WbEG9OcyAQfmzWLj8an5fbWjtF2R3zNTw+Lpaln+nc?=
 =?us-ascii?Q?Cq8xYsxNGYmflg+eYO9IBH+UfOHTTjY/3IksVn8Ssh6es9i01dr0TPY7Jkty?=
 =?us-ascii?Q?5+rEgg2/74p1gvCiXXR+VNz/RE63WDhiK+WREPs7/+9iTvU/H+8HOHyxbyM0?=
 =?us-ascii?Q?9wdLCpr870YpsrrzsTzvTzqy9H1swObY144MKIswYXXO5ToYGPAOEABqwbr5?=
 =?us-ascii?Q?JKXx7TzZ5l8+nFiUNyBGvuv88goXL1Jim8VY60jAeIwMMcZw/DhaxHQuuXV2?=
 =?us-ascii?Q?fccTNYEzR2Pae5aRyM6iINmMI2Gl4Xolr4NmlCOlT9OtJnggQ3dQj0Z0ztmN?=
 =?us-ascii?Q?urORKgKlR2MLP0XTPB5W8ADT3jHWHISbklJFj5BxpCgQCOLVAgCMVITPdlHf?=
 =?us-ascii?Q?A+4SB6Dfjx5skw4CsuVq0FAA8B2iLWLdRpLbgo6ATzkN5Ieper2VGB3Idaxf?=
 =?us-ascii?Q?a1RN0Y6GKX2ZkVqjq1cMygiQS0oST+/i4r4BtID4ArKOiPXjz0GHa40hquWK?=
 =?us-ascii?Q?uskxiW0COeBwpUe0gBOBea753+ITXt4fogWyontlRBIECvbXa7lEI13l/tun?=
 =?us-ascii?Q?K7qkBDTeUEDfvc4tOo+5z7UxQ1Ur/FesHkBkL8ml519rZS1LBeSweaSX6PNV?=
 =?us-ascii?Q?O3PqaXy1Xxknq+g8fUk2WtzkBdamTgIgBszmtmRf60SVGeZB/TStbGV/mQro?=
 =?us-ascii?Q?BRCqupl1aS04OU+/8Pt0B4ryZh69ScuT0h3suYXPz+2FjPJHaIWDbgE7hzcd?=
 =?us-ascii?Q?zACGxyTz++Fga8zZUGF/9/K9O5Jv8Xco9ZlyA9lRb5NcvPS6dpnXHbY17MQg?=
 =?us-ascii?Q?TieOSCLm5WPc04pELoV74VzlJ9/rNcp/qrgs/JM5QUpAmCaTLd3C5t5+3DVD?=
 =?us-ascii?Q?X7n6I8oU3ZDXecCE2GUJuHEX4ugZWbHWfi/zh6POtyft3zdxlljeZoXO//DS?=
 =?us-ascii?Q?9iSPikpPRqocg1VBA6+3/PX6hTkm9NVxz2Xvw5Cde98yGsRo0AF5K81csP+W?=
 =?us-ascii?Q?Ph8Vr0HSHit7HpwWR1u9ecISwAgn7fQSutCqL3EDeKNqcgRjJ1/nnAYAOMtE?=
 =?us-ascii?Q?4/u2FkaIyp3bUG9SfiCkmk6zPcsISm0mWkyHysgGCplnK9pO5G0fxHVB2c2J?=
 =?us-ascii?Q?Auzqew2JzHtJJeZZp5FZ/l4fl/luCp4tZFPAmPzJxHCd/BDT71Bmf5LwPMR6?=
 =?us-ascii?Q?k86jyAX65tMZXvtK/QF8KXKhoTctV+VxiUXw5qfiPY61o+BfODJf+IuVWtYA?=
 =?us-ascii?Q?t2HVAQwQWNwfVRR+WOsK15GScRKymfTWvla+hl3pkil2yyDC23zsmGsEJvKY?=
 =?us-ascii?Q?p9zJkkTn5VJveFfi1yj7tWNXKaelHhub++9X4TvcZUATJTaJlfgdh8VKZPFI?=
 =?us-ascii?Q?YLFk5nrs/9y13VlkQzIuCyDkFxVkQbqNOkowgWmk/Qrp+9oJSSjyr6CIuyjX?=
 =?us-ascii?Q?DSXDN/ffiVnVTYDdlm+QwoPvosZRmgs824dSC1y5NBvKPLw34wImXOjSWf8E?=
 =?us-ascii?Q?m1O3fP/IZOPpnIM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:01.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be398c6c-5d61-4ee4-78cf-08dd60171594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3b705f34fe1b..2c942802b63c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
+	struct cxl_dpa_info sfc_dpa_info = { 0 };
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
@@ -75,6 +76,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
+	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
+	if (rc)
+		return rc;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


