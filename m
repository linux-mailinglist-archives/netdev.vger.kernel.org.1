Return-Path: <netdev+bounces-148175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2999E0B45
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52DEB2BC00
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E61DE880;
	Mon,  2 Dec 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qGrT/ZZo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FF1DE4CC;
	Mon,  2 Dec 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159590; cv=fail; b=NxTE6WSwJEMu+QsLYuEgbYuzqQSYHtRYCGgbLrZwmNdL3kwJNWw7gpC+3adTD3TUKWWYLR1zo6nGXFYofefzZTQoDhup0nuTYQN4xbfs7dgWlh7pfN3Ew/HOhn9Ygdz1bWnS4dD0l09aASNz4y9VHi3Y1v+ojeHHs/RrYsf+4m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159590; c=relaxed/simple;
	bh=kDUQJ2QDdmVMp5BDo6WIyOt8+UOjDSI4utGheSnW/Ok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3n2fLDF6ZfQYOCJOvY+ZO9aTbMTD4X9D1Aq3sxa1NL2gNumrs5nv8hQIIEmtJnU5n7fZHD+x+LDMy8mio7ewrj8khHzDYxB7cMXa4dNk90yNDTZKSHrFB2ClgasaIhOGLTD9c/zy7oiHItLkBbJx0XKKYYJxDWcY6PqTgpVjRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qGrT/ZZo; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtNQND6qAoyJk4SBCOFo+ji0/Pdy2qTBkw9VAkv8OEYk31zpxZwDZF/dc1COYQPEFNdGHDKF77cOBpVkacrm3YDVmg8dDkXQ3/1C81sFYlLcNT6m1a0L0GxsoVFoFGUfATRlOOlK7CwnDJetftiA4gwDIgr16mDz0T+ZXUGmviJmuoc4ujzlsPdUmAew7hE0+h+JbH4ORNLtX2RpKUMxQHrZUgaeLgV7TtgfgwDPR9YRFT+D8xyMo6ooTPDYiUb26zdyOaaUilzzmVd2UvH71/MwQx0Rk6DlW23AVIuu9Mcw5AEeQgF0kfASU8eH+uW8nEHHiWq+vcfLxVxnv1QhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/c50JArpXKh2VIlJgie2HpBst9qvetnAtMJhn0m3g=;
 b=k22u6ilaEjbWC3/DvTPmz7h9TfBrXbcOyUfERpOh2fc4dC8oxnYUlMyeR5OnJXsej5D7Phbcbci+qGM3tNPEmIx39athgcz90nn99NyvBaXEbwuTu29RF2ICUldDPbI5ETKYFbGI1j7okld4hqabcr8H0P2hmdsFYN+3YvLIEg3wHQFCaREZoeOCXJwYIIUoT1WIRkL99PcIDwe/aqdMjg6omRX3WI582OSIeJpe/S6nWqR7GsomYH+O+RIAJ2fL6q23t56QR/nSfVpjY2oD+IFp6tuK1QimtJm8tZd9vZ7cHT/CHGUhnCXrWW1kjxWmxcHx2zI5pI1xc0oQznhpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ/c50JArpXKh2VIlJgie2HpBst9qvetnAtMJhn0m3g=;
 b=qGrT/ZZoTHEAYHFyF29M7ndJ13CN7v5NQ0UBRyjCtlv6G4AQGXwUxf0+dcH9cs1cPD/dwgPOLOHMWNz7hkDLTdZbq0eyRi4V5DX0DBS4zSlfBWDaMb9sOBCxYi0+SzHf8WonzDbFsdlNWBlhDeApO/RD1HCvbOMhQ2Z5EqBd5l0=
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:03 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::37) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:59 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:58 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 18/28] sfc: get endpoint decoder
Date: Mon, 2 Dec 2024 17:12:12 +0000
Message-ID: <20241202171222.62595-19-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 351f7b2f-b404-434b-a4e7-08dd12f494f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TC+77CViknlltsLk6WxpP0RfkrcFKwkmO5BUxIQxR/yWL1Fft+hIAg1vRMSi?=
 =?us-ascii?Q?RrttIwN3pNV4P44/Ct+b0jZbhVoTW7MmxQW8FmDQAbh3MtguXcOdrJv8N0mX?=
 =?us-ascii?Q?B9G0P0mUhU79drumgyM4ZhDTrvXz9BzJoexPzfWmEF475IoORgTKTHPUWDtD?=
 =?us-ascii?Q?+yB8DrIxooKCH4O2lumunEpUXkV7UY6koAn6Pj8SK4hmyPFtYikU8bY/EANc?=
 =?us-ascii?Q?Cax7e1++mqL3sDWVNDbKHrihNTmXtW1d9Q5qfb+HIyd54BB34YNi2ayOwYAz?=
 =?us-ascii?Q?kGF3SmbfnMj3zv5qnhvmXoF7WdnUWwqtCIyFa6R6uxpY7qCY+uiqQYwJWOkY?=
 =?us-ascii?Q?X2v3KL5/7LoUDYuT3vuWZ1xELhHwlcijbt+60w3Sv7ow4KLcVw8QAoF739XT?=
 =?us-ascii?Q?wAr8tcigOtUzQlWAKBqD2B6PK403Pa+DRsI/E+atv2XG4FtPOAxy3v7TzRNx?=
 =?us-ascii?Q?VQ7hsbXRwLQdFGxf6IUjfJXLfhu0iNPL1fL5DCXlzsLbqYiS72Dv5DFzpro4?=
 =?us-ascii?Q?a4vbEPOloOUhx/p3HLJWvavNCeYWbi0DjPOar6w3hm1fmKPTwFuWIf1a8itN?=
 =?us-ascii?Q?3jYWj6zB+Yvc/lHTNrZE3m/pSlmNYpietx4hW7idBd7cIGW7Bbyzl0HDl81T?=
 =?us-ascii?Q?MQT9FrpgKbn8nohNbe2K7kctBuWdbOnvwS3sfQNnRv/b/oVgdprGVgsK4oWc?=
 =?us-ascii?Q?u0LdmO6mQH7TJoizNvnauloBg9Tg4geq3RHbDrAVDg9lqebJgr5/IUQYcIYU?=
 =?us-ascii?Q?FkmVu0BsQREruW83OtMaZSLF8KVXaaKi98iIYHippDRSoyzTA7bYF0ULrScX?=
 =?us-ascii?Q?HwAXK93RpChdWOa+QAQo28czl+mlui+2Qtzz0WhR6j5jgZictgZqutp28jla?=
 =?us-ascii?Q?faOJ3D6Aufp3UwmF7IQU1yo25R9KPPJIO8hwgz9+pKo/seo9MrDN/2OpUgat?=
 =?us-ascii?Q?5SrRRPgVyARIaF4kBnsE+YFJuoTP9y8Jehpwe9Nc5Bp2bVLbGlG9Y2rI9I1L?=
 =?us-ascii?Q?xcfPAzefGDihR/5eSU7R4kfqfHktds3Wv/edAOhGZ4iTnE5l2TLYPQOyTu/q?=
 =?us-ascii?Q?IVTEJX8HpbVpMDGaxo7FYS8liIGeYfbkDRoOaYACGynJYY55PzYIaHe5WcEk?=
 =?us-ascii?Q?XNOQ0Db9aq1c1YpfaHGJ2jouUqDXGKQH2UgnwlTDlgMpRTsQsKVNAV9FIfWN?=
 =?us-ascii?Q?yNNveYGtDtIF2R/GITgiWYI+gcCT3dAEqvRhapKjgQ7JF6NtwVD8mZ77I+8Q?=
 =?us-ascii?Q?rGkqHL0N3BLUnP5YV/fCnqYKeBG5MnVG8FraUD6sgDQOCVIL+6hTPgo3ebgP?=
 =?us-ascii?Q?aGADh1orLeLC/R8qbQPRo+kbLIL30yXK5OQhFUoFnfyANn8lzh16aSnnqcSg?=
 =?us-ascii?Q?b/AY5v/krU+nNj2UKAPiTtb4wMdwHetyptsOUlnlvyTeG2TFYdXlgHuSyfLh?=
 =?us-ascii?Q?IRbAHY2sHVF8YH4DLjyj24Zcn+i5+z9dgxWRGs69EBC94M7+NC1aYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:03.5972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f7b2f-b404-434b-a4e7-08dd12f494f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 79b93d92f9c2..6ca23874d0c7 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR_OR_NULL(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
-- 
2.17.1


