Return-Path: <netdev+bounces-126220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E69700D4
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367CD1F22B6F
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238B158861;
	Sat,  7 Sep 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u5BCLBgR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1D14A614;
	Sat,  7 Sep 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697188; cv=fail; b=n8WGC7F6DhNbVhqvooaJxfcsbtgLcLyxqi8Gj/qw094SUFZop0JLe7wetAt8LkKtd7aZcoXLoA+2rsshB10eUdM6+8+UhEyQC9/4UpazBeHnjPjkWEVGJC98dH9Dmxm3VBfMBaF+zeE9EyQfm2iuJutQzTtYVm9gHghOb9bn2lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697188; c=relaxed/simple;
	bh=zpOhnuV6wciXcR0wGiNV9mTU7N4hXUkLkP9Fsv6jD5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlXcO+Qpm9e17Dnibig7ZOsimFEelR4XpkhUrAheDMv3JcY8e7DJkJZkh0kFy7QJgo6G/IvuWuyUGOr0IWCDnknv4lnqX6LeRZnqFeNWnLxlqBhOZGy+yTUoer/DurZIEUpRTQOcFuW4oPuWVzUzOTKPEXMOcFfRcm415en1I4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u5BCLBgR; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ2tQhrGzR78BaXKFv8zZh0glOTKq1D4/EdiFw7bwvylRfyK7IvQ8SOB6XvPgQQo7oqIF+NwZpoPKw6WyARSkCAZz0DfMH2CNN0iVUaZulFrDe4Kq4z5US02VaXY9whxfJErRWL/UWGg9nWAv16Yhb9bh3VzQN0fKJ3/K3etmYCU/RBAFSIPTBBVlmJpCDSc4aU5yJi67cjCwzYirZTtJ736h/YouY7ugTKESO6LQfwvsbEAU5z8tufszoo0q30Gog4LH4PJT2pqLJAkVRoL1qRgWP4DNL6z9dXVPbulQJF6P03y5vMLkFFhV+8Rhf2QnF/PlQzneVpexC45eJlB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBMb4Hln9DJcXSpvaKraVH2Nm4a1Lr5PFzU8XJIPHCI=;
 b=w1RmDuhc+RoaIt7q4ChByiVhjgv6AXLeuwyFGSa8Xqm3vDznVVW2VEbZuYGA2MKPXDNIQ7/Gz7WR7akcPulQGzUdo5gGa5EjIdXvbhqzuTDGVLeR2QJawUsMMFmAldTxKrECfnqEv5dGWG00YQ4Zi0qjA4ax0E7WQpPZz6X+gl86KlNWWz9T3Gb+LmpvilIqy3DbwU6PjTtsij1Oqq0KQp2MzXvbxiqSw6mvLHS62XwGawMBWs13pi8pxIcLy183IRjeOMcfSGn0/wR/t4wjvPdlVcCMEJXYBP2jWqfQ5p/UrFtWoiMAlUrwODSugsDy4za6Kwoaa6cwKaY6YhJ6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBMb4Hln9DJcXSpvaKraVH2Nm4a1Lr5PFzU8XJIPHCI=;
 b=u5BCLBgRxDcr1YDIa9xSbJflLdl73S9myHYn72s6/j9LU0b4Fu65geFwuGitzwAjPEH33JaVrwq4nLU5Pw6d4uyrYY6IAB09Zhd6kaBnDpByrfFu+YAud4WrabIm/JlbkLwyZ0xACdBH/CCsA+ZInpXXuOiHtzYJ0Izgagxf8aQ=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 08:19:42 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::bb) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:41 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:40 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 12/20] efx: use acquire_endpoint when looking for free HPA
Date: Sat, 7 Sep 2024 09:18:28 +0100
Message-ID: <20240907081836.5801-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: fb706f70-3c4c-4c12-07cf-08dccf15d358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEi5EjzDPjnZqKKrq+jTbOTS+AzaBa59TMve02Qy4PMRUn/HefHSCBroxsN6?=
 =?us-ascii?Q?Dnh0KYxHtmfwGVFgwpQGzawXqs1TBs2xX75EHaJpGESWfydFmpmBUaA/ij/4?=
 =?us-ascii?Q?l3oqSBhyjtEMAHELIYIrHtyMTT/nmPNsuk5KtipjglXesONTvsoSpUydFTeL?=
 =?us-ascii?Q?9iSmWkMjjxQjY5I7VMvcQFcJd1hDnTvwJ70rvLKr0iYdROl2Sy9Ey0gicQFh?=
 =?us-ascii?Q?DDlv9h6z8tDHd8wTd09ZAfcPJP+gLSKSqez5ScjxrG0nzIEL0afQN8E86Go1?=
 =?us-ascii?Q?nzygNUJcLc9ncHK/cib0/HhrfHC68t9kwjR9Tn1HUEmmOYlU/OVIt+zwNM01?=
 =?us-ascii?Q?8zbRrz1mPheK94J3yximncdzjDSwbz5etXZ2Yhlcq9gvc5Vw1dMRC0u/M8Lk?=
 =?us-ascii?Q?/J2h7MZFXuRc8Xtd4maJYhvl7TUTbjkTNcFyET+Ua+RopJvK4k2WTOcXvZAK?=
 =?us-ascii?Q?XvmycIESAEqiSB4siPyqAi2jZr1qvKDZrGc1RMzcROHRtuQVgY7ewwtjHJas?=
 =?us-ascii?Q?DYDsT9Pml/RkkYk6OHl6dYuW4BP57XQ+Li4uOcXipzR0zYq2ZaiPFb7xwGvv?=
 =?us-ascii?Q?UqScl4tpwd2P99lSV5xOwA0fCFTAzyHYD7OqY59MV75TsOv9qKA6vzi5tLwh?=
 =?us-ascii?Q?dT2g17PfAV45wOJNQnP3Lbj9XGec4vdFH2G7ZEZDYQj21XlzTiHixUbCANbJ?=
 =?us-ascii?Q?gBMB8VVlpt6DjyH8SPxMp35svo8WQ7G73B9ynmkODUTJ9si98gcb6+d5PkQV?=
 =?us-ascii?Q?9R5mZrG4KBG9h7fLxliBsv2XMO+GA8wQz/GymnnUXwDlq2AdCAFcdIQNgbst?=
 =?us-ascii?Q?1vmtDIUKuLSNIT7mBJ8FCC49aUZFXQCkIFkD5SQDUmuG7nixFCx3/b9uaDu1?=
 =?us-ascii?Q?0myYjpgKO0vV00l9DmvSoql97N63gCuwdWy/+7OhstzDUqTcCHlXDCyYD2NZ?=
 =?us-ascii?Q?b4Hb3HGyNqI16IwITOO2yJ37hcKP9gZJHDEE5iElLcIUK301m/e6lBQ903W9?=
 =?us-ascii?Q?KgVxuP74CY+XWLyjZ2GjjWEDBm21+wu6bI8oMkt9oir41VrXP6bRsx7qMN5H?=
 =?us-ascii?Q?Q0EoEzKjnt/5a9nhpknDJw4YgrwHnqqYVFdfHVfw51ifi9jw4lEyoSmVJNWz?=
 =?us-ascii?Q?eAH3faqIyJ+Vk1lBbzqe6idv+tDN3W+gCifjlT7VCT5s0Q/m/WsmkQSr0Hni?=
 =?us-ascii?Q?9oGJfejEP9pLG1Aku64jgGOXaXBB7zDqPECTL6ncEspOYFmm8kVQKTn+0w2/?=
 =?us-ascii?Q?OZhTtV/7dh7mBk91gIyoyA3eRqvHaLPPXL3snllWF1YEYxq0JHEubVTI23Rd?=
 =?us-ascii?Q?IrQkiPVtFWwQ2N7xPBL6HQ8arAuT7iL6JUoQ2jH+7KgOk4JlDOjJDJqe+pNN?=
 =?us-ascii?Q?fsTEGxhDf8OyG9IgBFcfDqXnIyxmFw0HNRn58Qc4+x80Fq+foMxsfZ8vBU/D?=
 =?us-ascii?Q?4Op7dqbMFISxh+1XgyqmBbxXrL+u+kar?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:42.5698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb706f70-3c4c-4c12-07cf-08dccf15d358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

From: Alejandro Lucero <alucerop@amd.com>

Asking for availbale HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization and use acquire_endpoint for
avoiding potential races with cxl port creation.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx.c     |  8 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 3a7406aa950c..08a2f527df16 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1117,10 +1117,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	 * used for PIO buffers. If there is no CXL support, or initialization
 	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
 	 * defined at specific PCI BAR regions will be used.
+	 *
+	 * The only error to handle is -EPROBE_DEFER happening if the root port
+	 * is not there yet.
 	 */
 	rc = efx_cxl_init(efx);
-	if (rc)
+	if (rc) {
+		if (rc == -EPROBE_DEFER)
+			goto fail2;
 		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+	}
 
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 899bc823a212..826759caa552 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,6 +23,7 @@ int efx_cxl_init(struct efx_nic *efx)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
+	resource_size_t max;
 	u16 dvsec;
 	int rc;
 
@@ -90,7 +91,38 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err;
 	}
 
+	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
+	if (IS_ERR(cxl->endpoint)) {
+		rc = PTR_ERR(cxl->endpoint);
+		if (rc != -EPROBE_DEFER) {
+			pci_err(pci_dev, "CXL accel acquire endpoint failed");
+			goto err;
+		}
+	}
+
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_release;
+	}
+
+	if (max < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
+			__func__, max, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err;
+	}
+
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+
 	return 0;
+
+err_release:
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 err:
 	kfree(cxl->cxlds);
 	kfree(cxl);
-- 
2.17.1


