Return-Path: <netdev+bounces-178323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07293A768D7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849247A1795
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA02221542;
	Mon, 31 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZMh46wh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2204.outbound.protection.outlook.com [52.100.158.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C032206B2;
	Mon, 31 Mar 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.158.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432397; cv=fail; b=kghBNs+Gxy8CuLRkDxYajUHdiOxz3AFounUf11nvz4w+c7RQ7EL6mpn1vgwuii4HVRPImI8h0qIcOOkGjaETlaGzC5htb94i0QU5Zhx+4j2pvTuAmA7OVQkxZfxaff13gHBCE+17BkP5JtN229Ns/PgsKrqoL9g3avIg7Rv45Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432397; c=relaxed/simple;
	bh=/egkf8xV7s7QZ9lCEVWLtuCrODoZnMiNJ3Q7mWClNQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4Wht7QR75zK0+713prEpKG29P/OExgZEpD+S9eNrHQwPeU7K1bs70dMoQU73/1kz2PWPGgh2AbAdWKsYciGyPEMhMeQyJWvbQjKLoZ5QWmfx5ENx567jPWR81CjFRQy4SHNJw6pXF5dZ6ub/oWYA/YBoigPXnLQzhH5IT4W5QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZMh46wh; arc=fail smtp.client-ip=52.100.158.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYQF5lgK0gIROm+GPt/1M4aslGY3Mf/H020RcoNpt4W9II2Dk5Fvbl4ZxJqiOM4dPqMuaaIWhy+pTs9HaU0q2JApas2BcPXInnq9OInnTdkz974v3YI6LppDqpc/MISjzoUQuYU2agBDYkRH2INAxEM6CSln+v1d2GebiY3Hf6DBeOVObFVg2deSY4I+WaW9SvYQPe5AkDmeUWEhT4M6riTj+V8jc4EJfRqhSZ5iq9QRB1tKsK8iGNzcXudTQRjqeVffNlXpPV2ZrSArm2VQqf+KGXcfA6sDkUW/+Chp4XpVsPNPcJPeqG3S96EeTVFBcvE46+aPfASq81R098D1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFFo4rSAeX5RF7c5II4zzyw7kYosL6uCm8j5WDzSpOo=;
 b=kXruO0P6YWa4yvKETlocHK1sAtw9wYNzzONBl1GRzjcTfYSeRn2A66BTCfrVwP8XKfpRwnGyB8Pl9wGcOieOcZeNoPB+Hp/utxoS/UaU06LYqPNyz511aLjtzER+x5+gCQW7sYlhsKC7nkgVFBLtTKVw1fa+JJdpgeM/i9mmva0ZJOvmFz846hyp+xNQdSHPbET4/3sRy0Gv7wD3+ojZ2LF+Fc18DjaIQ3ZQ1nNDFphWCDIyDYHGKrygGDGH1I99ghXEnly5egSPW7HkNZ70rU+IBI4L8xCGTCzY9ErJBw6v4lrwuUpYguc+UG4iVzSu8A47SSfIuT4tX8filKM8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFFo4rSAeX5RF7c5II4zzyw7kYosL6uCm8j5WDzSpOo=;
 b=NZMh46whtC1sM9d5rsyDnKQ2r1WN5I6eWqCU2Pt0mvUcQg1MQslu75AewiGuekN9AMqG4chNUrPEsPJTFN+yxOJeT6qgIDicT/QwJTUmZQscEMq9GeV1B9LryZIrGqB2a1WFB05d1dcPh5q/oG+IcwCHmw7YXVSIXFOcrcd0PPY=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:31 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::79) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.46 via Frontend Transport; Mon,
 31 Mar 2025 14:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:31 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:29 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 14/23] sfc: get endpoint decoder
Date: Mon, 31 Mar 2025 15:45:46 +0100
Message-ID: <20250331144555.1947819-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: a6272d7a-aa98-47d6-edf4-08dd7062d3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|34020700016|36860700013|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eoXZyNLfNLXrWPthMMIGGIg1ZPm3CFG7GS4V2e7vFsmRpUBQqo8NA7Mruh1f?=
 =?us-ascii?Q?g1Tmm+bibeSESJ0bql6ive+gjuA7Dhs9VgQfGZC+63oPD9BaCXG+nbmyXaIk?=
 =?us-ascii?Q?BiOL9MgnUOZz2CwEkh6/rPBNmW4RvmMyBvqwyD3Zxp4zgVCM5mXmGzyttyie?=
 =?us-ascii?Q?KES63LKQFDzV9Vk03M5RrxzzzuENbiDnQjrguSc/5ewjVCOTQ5XBmJsNVsQj?=
 =?us-ascii?Q?yyoiSuHI3FhstLqeLnrvFTRK9LXPNM3WdvLhQNC+CCftndjZCjS1afSlWrR6?=
 =?us-ascii?Q?cnjSOxgFeE1D0W74I/4/J1sKkvZKOv8YUxxyTqBIIy9xpUkUT52kDUKsBgPX?=
 =?us-ascii?Q?ZNdaJ0DAYxz82aB0+J16JVxFV62x4XY+sYYjtaDPSqqkfJPA1k/JrVTEsHgw?=
 =?us-ascii?Q?r7/CRxly2CWjTJ4D/qI4Eoixp3PFF2ii3c897xpySSEer7huO1m2c1AfNSiL?=
 =?us-ascii?Q?BM4hGrClOehdkSFjGTPkoZOApGlDcGvnCvv9wkbx/pAnUvv4ZrEFrqZKcCx9?=
 =?us-ascii?Q?MbR6pQ53rqKExpvq55b721zrncsDrWT1pQV4+7YVF8duinOIe+EcEBUGQU0l?=
 =?us-ascii?Q?19LN7ihqXyfo5r9/iTKYMNVAmAuKXhwr4xNFWp71jCAhccQSd0LJxwFJBJO+?=
 =?us-ascii?Q?ZxbsZZoHn6esBElFJb5SdXGczBHoOItkqLnU+axBNfiDnL5xdBeED72ULu+t?=
 =?us-ascii?Q?Ke6OtU8oAvrvQBTPQkkangPkU6YWNQjB6WHsNKoSUuDCOmKHFU6oO8cE3Fly?=
 =?us-ascii?Q?A+EVxgTrWW3jh4ZTaWNjdGzFy8eWpDPO6wTTrpja6ikmLk4/IKH2nLZI5dhg?=
 =?us-ascii?Q?52408/0tjPW+W1zhix3iGkPCAcBFZd6GQacUL7ph2i0wOpuJmKpPPdDQ+eZd?=
 =?us-ascii?Q?JOhzgmPa2q/Y5+UCCSX1j7IwoY5Knb/Kg2w8OsvbpUJVAHKDs0szNEMIZcRK?=
 =?us-ascii?Q?sfDYmSw+eQwUNZvdIb93Q0+4gNg0zbMoSt32Elg3wtS6wOrBENEMScJ63oiR?=
 =?us-ascii?Q?l/Kml/wHlHvQqyPl9+EWFBwYFxpOiyZyHTVLBc1qKxF4lDlxuoUmrs19muLE?=
 =?us-ascii?Q?4x8prSEnG9MRi73049vxfL2bRYPc8wkJAye+0GX6ombug9BzgdMCDNN8YtQz?=
 =?us-ascii?Q?BsDM1LJW9lT6XQNhgJd3JWHHWwLBMbXNaxIAZwaDnAE/5/ychetVlK5sLJTL?=
 =?us-ascii?Q?xOvTqF9/ifk9EPY6orayrQXwcrDUxQKQbuJVcEEQStfLsPDofsFkq+uZ9aI4?=
 =?us-ascii?Q?Nfo2UWWjuNa3uQ6qXb7NyFd8nkaDxjBsSZuGdKzYHXbUoVVmX2f0rUzU4RMV?=
 =?us-ascii?Q?NSPUUW1ATVHNU8aEd4qOsQ9Yg9A/ld4paJpq35WZlcdsJO7BcVldVXcPk7q0?=
 =?us-ascii?Q?wszup79CBEC/mJG/1KLuljciEmebEWLtbxC+8sKuiBpWWWUyRKU74jJejq76?=
 =?us-ascii?Q?7mFYpmHgXQ4MnGEK7hBd+DwWEMpo3vgiMuJS+sFHnwD/RpomSbSxtmEwZXsC?=
 =?us-ascii?Q?fGo7ZiqCGl1s/bY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(34020700016)(36860700013)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:31.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6272d7a-aa98-47d6-edf4-08dd7062d3a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4395435af576..20eb1dfa8c65 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -104,19 +104,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		rc = -ENOSPC;
-		cxl_put_root_decoder(cxl->cxlrd);
-		return rc;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto sfc_put_decoder;
 	}
 
 	probe_data->cxl = cxl;
 
 	return 0;
+
+sfc_put_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+	return rc;
 }
 
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


