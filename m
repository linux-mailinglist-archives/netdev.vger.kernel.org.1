Return-Path: <netdev+bounces-163061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45226A294D4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADE23ABCDC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C591DE8AF;
	Wed,  5 Feb 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOuy1MVx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81221DD88B;
	Wed,  5 Feb 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768840; cv=fail; b=e6kstt6nvGbp69bg1FKmZ2mOegP0x7kaGafv5kdekCYEFduWAgRq1tnzkSqQjtGBbePiIO9YwGS+B2JhxT9pQYm4tLla0GEFyAGOHxVgzMRyq5Il9clvxvgxfpgpT+PNTeIDTJuGJ/71g2yL3buKHobveE8gqY2HB/were5db6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768840; c=relaxed/simple;
	bh=6O47hGk+L3WhfV+0ZVJMLuoxuZKVp5Uy98Dua1EZbuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLPaCRCKPdSMHo7ZcXMkifx+edtzmTjJfN/nnszv6ElfwLGPOvkAbmWq9kgWQkrOiBzQ286XjSstCx0ZSmIJv/m5fMLgaeKUASihjWGOsBDLq8pbBsuJs67jqcpvbNiJa0IAkRFPS5d08xbPc1GTqt7AKzPQIqgJeqT3wDT/OC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yOuy1MVx; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+WTitlK/3q/2ZorOtk2O5Thnly4RWz9yIyI6G/viATG6sTcicIRzJDC8rJiGsBIfTBDy6W5vp68eiZ0qw1D+XBB6NJPDudTTOob1refUXm3ybEEtBDzblUYQD0OmjXT8KeACbnvfYVmIUEJGdLAy1QfMuChLdHAHB3CgUCXSmUp5Xg3meiiPGR32aXVnriqLm/gYAc+VqCXK6SnLGHjK44uu5X83Y5fIhxA7sokmEgixu7t1vg29QSYATmmGtS5cMSxQpwL/+E8fPmBHn4SDiSnOJhCDNH2AOtXRxj+qbZ7UmKfPPwrQgHH1v1J6S5IDInPWvmoy+Rx0ULwIOEzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LBDu1pSsoSZ2oYqeMV8qbMC3uBpN0E8A9CyL2V8ChA=;
 b=CNB8radkM2MPzxuDUObqSX09n2ELBSuiGRIwmEj54JtG2eD8KeTROvxZqC01R2/SJsLvCs/N4KaRFV80FoUcf9lq3JaqcB/SrPTOqxf16fn+lexWakt+DT+RH2vcwpfr08GRm8puOSujnb/PXxdrnwDJp6SVURg6nI9rkBotz0pIgyY8Q7uSFMa6M21e5uBkbmja57lgRJxwBwSwhMxXshismSgjZOhIt0Vp7/jPyuvEFGlKz9yDdEUYdL9RJdgYG/sG0hwshX/eACT+FBSGbU6eDVUXDXeG1QAjDwDVuUFWadntzxLx56EdCIKlcXKPRFj8CTveIb2ctttbpluCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LBDu1pSsoSZ2oYqeMV8qbMC3uBpN0E8A9CyL2V8ChA=;
 b=yOuy1MVxS51rhLGUxRZh2QAkFKrjGlLRiaPL6kEPNfPpUzcCThzocCm7BNZ4mJGxy6UesIIWuT7qnmXaQeHt5lyhbGjavbi8i4KhDLTH2gQD+pU7eLIxAlzbUxxQIdOttlusj2P1cnmlzOAebNTmjFcaceYEfkF7jVUHTfJfsRs=
Received: from SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:20:33 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::32) by SJ0PR13CA0042.outlook.office365.com
 (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.8 via Frontend Transport; Wed, 5
 Feb 2025 15:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:30 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:28 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 23/26] sfc: create cxl region
Date: Wed, 5 Feb 2025 15:19:47 +0000
Message-ID: <20250205151950.25268-24-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dd0ddb-2659-40eb-faf1-08dd45f8a217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NV00PxO6DhVKMU1T0+6EjesZewV2IkBRC+ukH6eIGBIOD8kpMlhf7pgOJYGs?=
 =?us-ascii?Q?mg2K8pZaX9wmJ/Xt/rDM7644pNLR8e/3//PQKPlkbZMabw0g7yqNjm81ADjE?=
 =?us-ascii?Q?8NG6k66DiXTwOn+CEUvf8xOBNmAzHhqldgxikiPaslv8R6pY0IQrTq7UFtLN?=
 =?us-ascii?Q?f4/fg4Aj93r0EMkekFijp0/axizGTibS5n0lvruZPG7+hvPwwujFeUAFkAh+?=
 =?us-ascii?Q?6sz7pqd7lxUSXY9xqGNyafQ1Pw4156C/OorC7JvGtk6m3DdfOk13AEnJGP29?=
 =?us-ascii?Q?mBJVffnIGgBH1nMaynqP0ys5ZL4LoiF05XTyPdnow5nQMseylBJSKpb8xnDD?=
 =?us-ascii?Q?sKm+b2Lt7Lu33r0MB5vPdVuqA8etV4KKAqoLCQRxjLCS2Q792I5sX4zch2hf?=
 =?us-ascii?Q?sOAN4Qhq5O8WRum31u7IVa83AqmylJ20hauv2TnGSFroCI+oHUSMEpTgguUm?=
 =?us-ascii?Q?62DtKs8vsfeS8Op8Nli4lBT5i7J98HIoTmb5eUfymt5wyHR2NrQG435fR3jq?=
 =?us-ascii?Q?7JnOO2tyPMYu8Laul6JZ9WLYPAycI6S8LtCrREiivS/jiBE+DTNTqRGmZYtb?=
 =?us-ascii?Q?FY6TOcaZ6Jg30YhbcsQF3s7RDxS3bjCGftbxkr4uM2N4oAlHF2sFJg67bijP?=
 =?us-ascii?Q?pvPQ8jw1Fn6DjZkw8fuTGUY5RwRtkldFaOJmjT8df2EoT+42lKRD07fVI/zR?=
 =?us-ascii?Q?KmPug52XshqUILGOvQpYmbehyCzRR+XtzOLm2aBuypmuPzHhg0tNlGfkv4Wf?=
 =?us-ascii?Q?yX5uuCTkM7v48NKQmoQsFLlmne9rSvyOD+ade1JerZssd2+T9UbhtKErG/MN?=
 =?us-ascii?Q?AIDCNvTQ8Azp8BKZEMYKjY++kffqfkTI1818jkncslBuFoloH18qCFipzdcl?=
 =?us-ascii?Q?wHvGOqsVdnwNWsT1WpLn3+hPIsdU9ni2/umdVGA1CxoDOBv3TrzvaRdfQCc0?=
 =?us-ascii?Q?1SggqshwoMV6FWiXqyRVtAdG9y13aMbmlRpETHSb9xMftgWPM2TpOVOChNnI?=
 =?us-ascii?Q?m+gcR/4aWEnoT+Aws7uwHjivUI4GcZw1VihgwSkRLLgyMzSYAObZqV0TSDl/?=
 =?us-ascii?Q?YK4eHdsgxsIyKU+EA8Ye+fWklIP0lgRzDTLUeMfs1zls3ZXrg4EBzVJjANHE?=
 =?us-ascii?Q?BFJP4t++HQID4PEZwtRWdY+WJ1hSYsioitBcBNECPbcGfAk4hlaSgYt6LNWz?=
 =?us-ascii?Q?G38M8Kz8XAdXwDanIFdi1tP0RpZDC76akJGy592QBv+BljWHA6E4qMjX0eEo?=
 =?us-ascii?Q?TQn894vA/5b2Wz7Gl2GpoKk0SIMLdvuqii4XGpNfU65KNw4A5jA0+NEa/uII?=
 =?us-ascii?Q?lLWbIQtbTyL+FsN3OzXSOpI6zVvc0YJcGIL186uQcXeI+NOPwwa5hcA8ccnU?=
 =?us-ascii?Q?O3LLFT6IIMgVdSUDoUx9xaIc7NR8fn+rUonQUDp8RFbcHif4Ths59lzla6Ph?=
 =?us-ascii?Q?0vK4lmAj0IsT/88vh/Ohmj0rq64KEYwbaD1kHWxD8pR8ST3BxdI92v8CPss+?=
 =?us-ascii?Q?n5QTQ7izPJB6duA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:32.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dd0ddb-2659-40eb-faf1-08dd45f8a217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range specifying no DAX device should be created.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 984dc2ee522d..eac849b4e0aa 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -129,10 +129,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_regs;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(probe_data->cxl->cxled);
 err_regs:
 	kfree(probe_data->cxl);
 	return rc;
@@ -142,6 +151,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 		kfree(probe_data->cxl);
-- 
2.17.1


