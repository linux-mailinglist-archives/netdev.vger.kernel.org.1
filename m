Return-Path: <netdev+bounces-189819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D93AB3D2F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C50116328A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A8254AF0;
	Mon, 12 May 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m7V33cWV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAE2505A5;
	Mon, 12 May 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066281; cv=fail; b=lFfi4SrDoYbaLiovA2TzHQPAyz2rQOQm/6imi2qNIaCoucbGQWNAVNgtV3Zl7V4yFz85R/9akYqVDtpdTHmU21nNA7QyaHJPx9GymcPtGHKaRLxy6yWWjkOd1OUo9l9Nv13NyRmb87RQ8RcB+5jCM6cZV0eqfyjQ35t9GkocnM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066281; c=relaxed/simple;
	bh=USCreGI7EBvFWU3w92Ucf/RG6T9MnDDn3RhjKF4YIH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRcTZbiqKJ+Dtb9upCnMdxZu1ouG74ARkfEFXOz3JuE7i2ZPRIz1nD8Cxlm+ecjRBjsLn8+WlqIdZ/eLhekdSnAtLgHchXERiGjeCO6KAMbLHGJXpmYhEuX5p88whQ6hSRsdmgSHydYhEe/Vfjy8ebbxUbcf6TZl+CXI2OSp+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m7V33cWV; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7EdkTULsUV6pyFuYhvzoI14h9DHaI7SgwrMN5UzIpiBtgd0y3XWjhz5XLIEN1rGbbxHb3XiYv+1NwnMtTNdKWKn6KXPPUwZ0rrD+gt6TXLrxRk2oz4EZ3ZX8mMVkjG/88lZuno3JsgrRaFHoryI8X4u1szf62JNF7TORBckPel7CPP2hik7BV7D8G1BK59c4DuPT2jNfrGShhzxK0NvSRIHq4hs35NGEkz13gDI3+LNXp6TZOBFAXKkO1EKxzONVNnGsXKUaLnhkn0LSz/DFlb61rQf+36DTdODWq5RbUwrRguF8n2pgiZrQdUeXoFsFcGPT5ERNktD6soH/4q4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVQXGVChlRa50Ef7xttH5kCIrY7pNisR5ukeHRNd13g=;
 b=I+355uNEjdfYiC0QtkdYXgD0bqy/OVK5gHhtGbFULCWeJbgbDYVtd/g/gsVgxR7fcsgsYPccOnWmLDRAtA/2B2PJC2fuxmnB+P9j3R7OEWMCtFdJqokOOe5bwY8pU49VHaVBe+yOvw45zQNFOPs/6W9QpzkxGGmhHks0uk/kQmHhHigz07TLF6mRbvHMBnLs7APW7smsZUGlVAWk1KFQXqwmuS+rKZRzmUtshH5uZLJky8p+Rr6U/3WtLeWhT8CavDqANdu1ClXdroL8vMJPwbRuFYMToElT/gOG0RNMgFXPDBGLLtrmK1TJ5R1pWJDYN0pMGbtCxplio9kScLr39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVQXGVChlRa50Ef7xttH5kCIrY7pNisR5ukeHRNd13g=;
 b=m7V33cWVCY37bOMiZrDFWe9qNygdOd9dOFN2eG1bV9dAPLE9Vavre/efhmXVonDcMOlY1ag7baj5ZvpRd4Izw8EtP2qXFRUmBg57/zEqMWvDFZDwffj/6b0vMNXzLYF08+f+ft8qX5D/RUpHJCFKjtJSy910I4Pj8EKsMBlba/A=
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:18 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::9f) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 16:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:16 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:15 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v15 08/22] sfc: initialize dpa
Date: Mon, 12 May 2025 17:10:41 +0100
Message-ID: <20250512161055.4100442-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e8ebf5-3cd0-46a0-c303-08dd916fa0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w2Wf4+NzDT6CG6ODkVGpcr4WQrGs7bBCQxAVNT1iQdzA7gPdR7fWog7fCwWg?=
 =?us-ascii?Q?vaFnxh13XZftKT/tje5fCGVEbqH1SvxLE9eDmxnhvxMRJeFm8lD5MNz9zgtZ?=
 =?us-ascii?Q?7dUZhPHdv00c8+oUt41Idz0uYhxVQddiAXrj/nfB9tPSyWcPoBHCwg0n95/g?=
 =?us-ascii?Q?2D4LvSpOy5FMTt15mr/YZ1tl2VE48FKBFIqVw+thHH3eBPveMhIvyAMbtZMK?=
 =?us-ascii?Q?D+SWtyqa4gn7DwMTCmfkPA+/ZUmk6uHBXmIClP229I1IyaYDh27wz2m1PhR2?=
 =?us-ascii?Q?J299bGaPLjLr7GC7bWlrn5pQsEVZHfEL94MxloszVdZ39MsS8ZIWfX/VzXyF?=
 =?us-ascii?Q?ar8lH6vipUXiZbV2yendd0VFofIRdcoJ1WptXuI9Zfi2IggHpJc7nB+Ek15u?=
 =?us-ascii?Q?Wei1YQ9PAXxfjaTuXknopkCjTt5MYXVPvoYxUa0ybXAFKS+aqz5FJGa6j+l5?=
 =?us-ascii?Q?we3jCDW6q1YHjkqwHCRQQQGMslLbGgduLumK1L6CEoaSeELvfT1OhC7uHiGO?=
 =?us-ascii?Q?hywFjUp5/L0OFVQeUI3TUXoMIICO2k5q/JE09nUyMIj/W6lBnWYsMfnqdSiZ?=
 =?us-ascii?Q?nDpYysrxEAqkB1BpimhjdQ8EZP8i9qcJxTut8fEc2K9mjxUe0ePkgyKlWEYs?=
 =?us-ascii?Q?kFnJJv0y1MRWc6Ot6MIkp4l1Yd9Cz04qkejpxISOtRsfCbj87RhmJdn2+4oo?=
 =?us-ascii?Q?49Cv+bGcMeezLiqcdxfAix7eBWfy6wG2MGz0rHSTJRJxxYhTemCgbIdgepQ5?=
 =?us-ascii?Q?Mhb8+BCBvOssXunGepM7QmZphsjFK39VKIV6KMoGzYn3bGMG8ojgkc0QcCtW?=
 =?us-ascii?Q?wkxcu5dEst1cwle8nkX6Vy/DIUZGK1GGFjjVWvDW08AX2r+WBTD3JdlSRQO5?=
 =?us-ascii?Q?9uYXhb6CNgq0GYNBhEgTAISxkdQCCsGKpfd18ZwY/WBdX2+t01axcIcLgVNt?=
 =?us-ascii?Q?JQlTmsOoPEvaccrehsigzsY9nq4PHINMNftFUfRJw5GmM9TgckYlnuikeItn?=
 =?us-ascii?Q?/QgvVW21Vo9yKOjgzTdLtS1O2MFdj/J2jhVVA8d6po675G+74i2eiJLaMGo+?=
 =?us-ascii?Q?s6M2LcfDHoUUqQHWX7aU1rSYlbkYfjmF/JDlpiPAfkROqK0/cs0pmn1KUJdp?=
 =?us-ascii?Q?P0QSQ8w002ZOfFP+RHeT89cD4oHUScaHQeYJD6CYzeswfbtAcpGBIp/Tyb2E?=
 =?us-ascii?Q?btvwaOaPIyzlClXIu79gEChWaPe/vkEbVbZRJa1nOBX9DJb9/gmNYILb073y?=
 =?us-ascii?Q?uIuxV3uTQApgcFkumaS/GgZ1K5sJh/ZZIbN4yHWLCryAWGjy8DfZDXusxuzW?=
 =?us-ascii?Q?FxEGzMLVQdte+aZxQBUP6L9YTfsnISyvd5R+swAIPzgwHd4ikdNCyo3nspbT?=
 =?us-ascii?Q?dnV0UjgP0F7v8Nmw4zuuu52/X3C2bzQXCcVWOlClPgJxQnApe+wbRP81ZJlT?=
 =?us-ascii?Q?FM6M7nuEvrdwHv0ZBQxX3CBL8XiZwcM5SLWYYqmOLUsdf4/G+C+wodwuNA2F?=
 =?us-ascii?Q?nTF0+kj1Daax0B+Mi8mofxSwr/zNL0qmj9yu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:18.3853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e8ebf5-3cd0-46a0-c303-08dd916fa0fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 79427a85a1b7..e8bfaf7641e4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,6 +23,9 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct cxl_dpa_info sfc_dpa_info = {
+		.size = EFX_CTPIO_BUFFER_SIZE
+	};
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -70,6 +73,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


