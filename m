Return-Path: <netdev+bounces-173671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D671FA5A58E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952FA1890299
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E911EF38C;
	Mon, 10 Mar 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uNjM3Tyk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320211EB5EE;
	Mon, 10 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640664; cv=fail; b=mS7UES5n4RayHwg518upa4LkeGHOQenDl8PeirB0OjW69mVzYDKI9kHlxjr8TBWUG5kfKic2JDmeEMM6Goo3WFUE6RqkvrqtJ4dfSqiHBDcScL8NrsheXXk+ksGKcFItNo+fkGeA/az7DAPbueSfQgLU4pjsJP/Gkg+5Rnm4zo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640664; c=relaxed/simple;
	bh=mwxeGkNltqmM667UjONMpDP+UXyIY6MF4l4TpGACY9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esSg27puUilbI6b6D3KqWkFn5YYSPGQWejx2KQCTngdsToBGAGi6MVqhtUVnKfuNSyja2cLkC23zueCtk+jAC6FVdnTFy/V4fkmG9WyKdDczvyaq9QwTUTf43uHGd8utLc2OAuQY613uw78rlcvP5qc04JmuWi95PlBdktp81WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uNjM3Tyk; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjC2DQXM/ho5agzyBKuPYPQYfV+dx1lRZj3X6wspJpqcTsI05eqPDCHL2vj9mOno9WyG9MyBMZmrnVkn/8FeyOgtEuWveFXczk4wKybZQIWdAFw41z6xqiEZnIabo5T/Ut++S1cvFb5grP5ozB0eD0nHWm0b0spozfGnF6KqSvzVqnw5Ut3nMI4dF+66t/EB5bUPYN9nrqdyfw6RaMtQP7bBxr8zAB8GFwz7LgHjBEAZh9uLyMZQDzdZkNGQNWyrqRU/utBK824plakk90SJL+LpDnBF8XER5AYH5tnUQJBqC6MRKqrFwRBRWZQoicju0G/aiydm0HvquE1jSw3TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpYpwvOrnasV7GQo7ya6oVa5BaOmZszWnZbHDYdABWA=;
 b=YyuLStP2nGToD9qRBv2VqjzquSNVUxB6+TFfn3uNNXVwCwF0PYO7MaNVzxRKnr6Z/HeUx3lqJqdhDLskV0GGEasAl2AgFPDMZ2DU9lAZ9QqCRJRfoVdju6EcQLMbht0TkQiPLICb8ugDM7iDQEwjC6qAI5TYt6Eb3zSp1pliAYlMurtNr8h9VFsq8AUbTjFG/7IIghuoOlllo1hQMb5HbNl3kuaTPjVXTJ1SN0F//hPb9fvjNBYq6U7vAUONOAXMJzsYvdygulvsnkeN7RY0rQIdCeizU+OEF72g6SLuh/gNe2wYklNQgxXfXtFa8dsDR/SEK0lrXt0DbZx57CKQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpYpwvOrnasV7GQo7ya6oVa5BaOmZszWnZbHDYdABWA=;
 b=uNjM3TykaFOibI10cT2v7UAF2bvp+dsI1QYwK/zDvBYBc4QCDm6I+1cp0wY+cCPiwRuqDONePfGklcmVEYkKTZg5aakZwKy7kce2d8BaUQlcoMM3v7v5MAxJOY7OvLIvTDen/hPYR/cxa+9AZZJUMGcNh7G/Ai3Vtr+Pfmwt98U=
Received: from CH2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:610:51::16)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:20 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::d4) by CH2PR15CA0006.outlook.office365.com
 (2603:10b6:610:51::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 21:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:19 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:18 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 20/23] sfc: create cxl region
Date: Mon, 10 Mar 2025 21:03:37 +0000
Message-ID: <20250310210340.3234884-21-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b8a913-be5d-496b-f8eb-08dd601720b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x8FZwxqWJuo8+BWS+tiAgegX6cvipDb6mXEARv5gpBs6QqeWV2RaLcqyFHpC?=
 =?us-ascii?Q?U5s1AAKZsrVy2F+aXy1hL172KM9Ogc/Pv/rKpPs8TNgKU4085QS4Z6oumS0r?=
 =?us-ascii?Q?Fif5eH9YCkLlO0C85Dp7PudkoAVlKaOaDPZa5AVrEPK0fS2HsYZlf63y5VjB?=
 =?us-ascii?Q?HO8JWIdwK5ckAEzszUqvfFQ0GNVfHw2y25C77Z1HuGEZtHI0qAnP+22pzn+R?=
 =?us-ascii?Q?bYT4xUVFhpced1sKAubXqNHk6jS83nVUbHItZNvunH2Cx4ZmK6hGYECv9ip9?=
 =?us-ascii?Q?Py3VDvO4Enk8vK6eawLAXgNComuoARb9ieudDpOUrRcYfc24IxnOV2dJCpak?=
 =?us-ascii?Q?d98fq5BF48eXM/DbdeLUcx9DX6k/uWZX1WLTCjUY2A+imqQ4CesYFOj+6TKI?=
 =?us-ascii?Q?yqseS0eYbzETvbnOVIOcDxnU8S/2zk4W6X4U7Lh1nnfbNU9YDyDTqwsp9H1V?=
 =?us-ascii?Q?f9o+XCQWyVNhl8ySGsaXq1g3AzLhwndYCs34MkgwoZ1Ay/62BWq2h6JzWZL2?=
 =?us-ascii?Q?KKD+Uq9lTZGjBX5Vkw+iBsz5397jKquqzB5Q+7gEWy9Xfodm6CPqKFCufxCx?=
 =?us-ascii?Q?jqEMeLJHljLvz+L6FlxERCJU6A7buHrNBBlYZOyYphSGpkCjq6/EI0eTPs0e?=
 =?us-ascii?Q?hqVqdPVWlBbMd87JwCQ+Qe3ObRiiwzLHAJrP392IO4lsMNBSe5mhdhRrxy1n?=
 =?us-ascii?Q?DWMVsguepL5MYThbMhj2x8i9I4qCABmAYZcGlYhUd5O2ahVivRTy5q+5a+Sd?=
 =?us-ascii?Q?2smBJ0CVMBE+fAFsjS4k/pOziRRK6s6pjZZg6TcnZjN0mtz1eWsYncWIMRMb?=
 =?us-ascii?Q?Obf/28Z4vAPm8r+nKlL0uQKEhFeMekiUsdPqaENFxRopBCgoADqhnlwnjZLQ?=
 =?us-ascii?Q?iNrx7Gbq5zGdEYhJLaoqR3mZzFWZIPMjuC5D+JUWW9esJVmoMg4qiL+yG18J?=
 =?us-ascii?Q?oAoWebyVu6/YBsre5t+SD1O6Xb6B/MKumbAJ/p20eTyaqDXOnAF59TKyCIDm?=
 =?us-ascii?Q?MsI6B9ajT4SFKufGUytPBGjOAM1yBl/3hpMbL7fISoK1qwgfs2hS/Di3MoBG?=
 =?us-ascii?Q?NhmlytsGxqcpKJqS4tKNDQ2ayV/EMKuwvRZCGzeJORVKQahnq9tcNeAhIi9t?=
 =?us-ascii?Q?wdxnls7CAXXs1fudAIE7hhDqtE0hYf6bNowrooSoh48hlUrcJNJLjax+ugwD?=
 =?us-ascii?Q?HRAiHFcnGFPicghxKPr1/K0WXy2lJoeREhEKOS+ItuV3aoRewn+FDzw85Pr0?=
 =?us-ascii?Q?iVabKmSd7WR9lnzzT8JUBV44z4o0enrorUioTNTFj+tYP4TRnWG2qgaQetex?=
 =?us-ascii?Q?4Uo0rgo0702n/a+8/69a8j7LcmFOFPg3tR4JiiHEuLhVbuE3k03EpDtGoqqi?=
 =?us-ascii?Q?45Os/Vk2hQTKRW/w3KNZn7cPZWnI4fc0qUuE5yvIGvkd1JAEg2h9PwPXmTeY?=
 =?us-ascii?Q?miWJXwwkECru7EROcwn34tinT5RZHNDoADksvm5gQ2p7obDyeKottUPunKtQ?=
 =?us-ascii?Q?ZGefd/6kpvG0y7g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:20.4680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b8a913-be5d-496b-f8eb-08dd601720b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

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
index 20eb1dfa8c65..424efc61cc84 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -114,10 +114,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto sfc_put_decoder;
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
 sfc_put_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 	return rc;
@@ -126,6 +135,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


