Return-Path: <netdev+bounces-173665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FBA5A589
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0665F1753B4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B291E5710;
	Mon, 10 Mar 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eoblaHG1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2671E51E3;
	Mon, 10 Mar 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640655; cv=fail; b=ZsZsil7bnwaGJJg5NORoSt1JuI+SYwGa9/tDvZ0kv3D65HyP/eCqGcS9VjKV+8+Fq8234LmzpfRCoK27BcNVez8IEZ8qVcbtNC1Lz5OKQ0erL2O91hzwp2nD8VGQCgjQ5LBveA043ldpElZoqIjT38IrenShQg/xjEeb1QAmPmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640655; c=relaxed/simple;
	bh=rvWowOxPD6SYEqHDQs5Hj9Jen1ADCEwqW4JcIF3O1ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVG9V6j3FneyAIF9+T626e/plr/iFwdLIdAxSMcz0oxNlSX7PSMCdL9I0W8Gi3G5IId+c3a/M2358DO4btlkIG4gggj5ZFEFMoVPpBuRBqRoIOb3HWn4OapTRs7B7co3ee7yctUQLKIKijuN/3RK6RWt8cWyMhWeHReq1bCHDu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eoblaHG1; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD7aLr4CoCOXAyLWacuOCJDLeqIYikStUztIcPLOvqfGL2w8Xq3HMpxPo+Ul8ofnuKTFUbisFCsroFRYzXCKU8KI6uL1wOq6Pk3KgMBRnoKpIqSUNmUd0MkOL4eskRbIU+Ys7qzJOUXgoPe9QWJOUMbXGIjmvVJlgu3/PFhmRMp+Br066nZfr7KzmMc0ntzyXYlTBWM+6WL2xbGSkoRAsHpIOSBq0189V9792rdYU2TM57kNszFCB4Y5pz8Ja+qghV5FWqaDT/1xtUHC6OrmTl/dk6sJ9I3aExGd85EVBQHwbTImJs4uaHpZ0Wmd81DkRPkvbyplTCJlo5jyjURGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCjLiCC6i0gfeNN4CmRwfaugYp6kDGRHAf9KTMBsUvs=;
 b=e2pWdUXub6QLaZ2jFSgWRDzfkIdv4DSUeZKXJxrM4748bE0SXHLdqBW6DclVuRTP84wAtMIaAjtQSjo1VspDeeFffQP5BTqhPcF8srY4CpE+XKZ9TQ66gMHL2BVJDg0nMv3uKEUOaqYF6oOmarivzpBPIl2a25YvyjTpdHNnfriDaikOjltKxlD4G6TvrG26oucN5G289/hMYYIfwjS1ihmMPBlbzzonfyZiYh4q3Rkf68djmgMeczfmg/vrp+ijlhCeaRgHiWEcwU/2NQ0AJq7ZBSioM/abN59iQhrtWWlIjPV7Fr3LrCWp0fEbf+lVnBveJFQhd74F91iq7wG2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCjLiCC6i0gfeNN4CmRwfaugYp6kDGRHAf9KTMBsUvs=;
 b=eoblaHG1qS5cIBQb1aKdGJ5M/sqlOtEy3VvL0GHqpFK92htgZVLm7N1rEUX/PFaekXDtwxOCnygkG5jDMM3lCs7GQSdpcl//zFsDf0bL48DFdU/qmIzY12FuEFzJps2S8WpAQlt+knrIS+ZG/0ttUm0pjJr6YdUu0qH5X1+f8Fo=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:08 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d4) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 21:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:07 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:06 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 12/23] fc: obtain root decoder with enough HPA free space
Date: Mon, 10 Mar 2025 21:03:29 +0000
Message-ID: <20250310210340.3234884-13-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7371410c-455b-4c4e-09d7-08dd601719a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aog3QZxZVNJ1MI+dqoijq0hNbzOnNrvG/u1ystWiN/UKRQGxAqgKH9HmELpU?=
 =?us-ascii?Q?TPrVbXbynTKNlQWMWS/QZjWj/C3k9Ika52zroTFmxRmk93XjLOTqs6L3jaRz?=
 =?us-ascii?Q?JxtMUP1MusukCjMDob42vVRohNXhR23ZbjsVZU0vJ5w+Bu+VprEiEF8Upz+p?=
 =?us-ascii?Q?Bj4kRPyWn+spB3FJCXp2KlUU27QORdUCK/V5nqMUYPoBAX/vYhtrqUA/rXiq?=
 =?us-ascii?Q?6ITwmWR3fG6nitHrP4SciWlsffYVXeqkXcMrMxn3PWrR3ZKwHo6Rv1dRIFZl?=
 =?us-ascii?Q?45wZS7bzZZSAcpTnBPr5OyoVHZbMpNjTMvpB6o2PvfQIjwhC7izz3MlM82XK?=
 =?us-ascii?Q?hyBt0VAai9GD24jRK/1He0VCHPUlMi4gi48SHnNjdfWUTvVa6DYkNW1M0n1a?=
 =?us-ascii?Q?PHoCQ/qFMiil94J50uWCQD9aq8WK84nR20i1Lv2u/RFVoYWNm5KmaWcvJ7J/?=
 =?us-ascii?Q?s7iHQQQJHe2TuArcupONUJTcKLSot8Qe0HetYK5vpt9hUGcvA+UziB0UPIXY?=
 =?us-ascii?Q?t7ayIreLJfn3aBPvLwjIGibjeU60xHejheaQxZW/nlHa3Gxw0y6c8oSR2qo8?=
 =?us-ascii?Q?2Hg9RgI6twIhtIqH9to0EtObtga+RuuMSWdnFtPGtNjvCUhUwlW9nhsP0t+Z?=
 =?us-ascii?Q?//kA23kDJX7g+IfmOIZBGvSbwIF4VnmxMjP20Fenyj+N/Bo2o9COMfQjZb+/?=
 =?us-ascii?Q?1mTgEN7CfVEL1cKudBZe+CrrMoOu7iHlbQv2WiHKPVVA8po383ow9eYXrvf2?=
 =?us-ascii?Q?S/jhJC2aqlarfa6IOCia4FbcHVM82Kg8gDOuuqrYm2FPkl/+kL2Vv/kieUP3?=
 =?us-ascii?Q?mGDQRSC/eJH/JgQB3tSp5Mkq+9Jh+x09zB8/oV6iyLmq/kI1rCpL2vUvv58P?=
 =?us-ascii?Q?YrfkijUivuUoBrTsBGCHyBNDZFo1EdLEiO4QSYBl9Bbq26e89nSVpDKmo7au?=
 =?us-ascii?Q?plEjsPFptdk0IJayavc7u/0Md0Nall6HYeEjmWiQqhV5s1wiDoB2i2TxxVEZ?=
 =?us-ascii?Q?x5cBKqOiqmBFhWH/rpFqon9yaTskwARRA/njPXvCCXx1DFgCuPaq2gySo8E5?=
 =?us-ascii?Q?OwaAJgeGkFNgScjwMXQg5EDcevn1vV0DdPtRO3jwuQNSqJVs65HodJ/6Q5I2?=
 =?us-ascii?Q?ll/f85zPRdbfKuLjmdZZ5y/cKoS2Z7fd3oeXxeHz2lfrERUNbap7EnLJw+ZJ?=
 =?us-ascii?Q?JptvQ8mrtcgS4eD/x6ywz5tZZv0ftuE1Md0198Ryo+f36VO2kH4KzB+Ld9LN?=
 =?us-ascii?Q?Ba7ixkuPjWUQR81TdaPp/BMPJyxAwgSS/XxfQVdH4tMhPyF6rbYr5QRKUe94?=
 =?us-ascii?Q?DebCkwTHXYqLRY6pkVRk5YBfcQUyZe0wKPjepJdtZJXtgCw3WmwWyw2OZP9v?=
 =?us-ascii?Q?VWDaoCUKanXbCqU1TmcEpgE2DccuoJYC89fJFf677xHVTqZJV3+9mUcQrqNK?=
 =?us-ascii?Q?+pkZuRjxb09Gl6ARUewMYSNMH7WuPOzd9ts8jxn14nIPRvVEmwLNk9l5W2Dc?=
 =?us-ascii?Q?l7hMBOxAJabcEVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:08.5807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7371410c-455b-4c4e-09d7-08dd601719a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Make sfc cxl build dependent on CXL region.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c5fb71e601e7..7a23d6d6d85f 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -68,6 +68,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 5a08a2306784..4395435af576 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -24,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -89,6 +90,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return rc;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		return rc;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		cxl_put_root_decoder(cxl->cxlrd);
+		return rc;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -96,6 +115,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


