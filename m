Return-Path: <netdev+bounces-136671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E29A29C6
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DE81F21735
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04C1EF0B2;
	Thu, 17 Oct 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xOVIowqZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847E1EABBB;
	Thu, 17 Oct 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184016; cv=fail; b=j+eJwomB2J5bpOxp3KlEIqjrn46XNAIx3ySCF/CA3i1200vTTzZSSrKgVYyr5RM5YVGmsHTX89AshjTeTtFLJCR4BhnWxERZcF7DTmKpCBrxE0JG2xPqTEnwI67uKtwg3d9uinl7zANOf2y9JzPENIEVtO18x7SgZg0mkvFSVBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184016; c=relaxed/simple;
	bh=xtGge27fT0tsPA8RKFjD5rgZ8ZiAEADRKmU1vA7IOJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXtKP0dMYS/VQPMseYB6te7j5vH7i5DgP7BjCSl5Gpkj4DcBs+62nUDg87u5eoT80lAS+4tlLNUPpwsyO98DIHEufb+1HV0s6YL7mByE0FGLTMnl9KNMDp6h2tS8y+Ovl/SCRYqh7g094ZkW0tjf3C4Vp1nvyvsgxmsLrF+/RJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOVIowqZ; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/WnskRdF1NtyOKLslQOmmjXo8Esg0ZR9an+QHpGWVMS9dQIKlUleT93Q1K29NRBf6P9LcthFkYrcYYFvj93i/pSVg2G+9jQyeP4rQHQpQX/8BFypawc5zLbmgR9rglSHhO2fTLUCFWlxwX6BaeksDD9WxF2wc5DQkDVAs45iu8z5HWOYwj0VpzAGAUxGEM0LvOs97XMGbesyIy34JVlTDSPz7YQg2o9y05mOPnBrNCP/UdgLcKSpiaIQRRQD4sGZHCQj1uNST3jYPzxyOWv9egL/DN2vx2UxktUvMrzSmogloWX4LSlL9TY7YsZtw/DRcBqEPidFJ+bDO15XBYosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYUMz6EzjGbSZdsfNBoV9zb1KXfMhXT1uZBMMqgtjTU=;
 b=x7JrdWYun8x4VNm00Xj4EthbDz02xQtlsJ3iUtBRF1Fxoa5zuiqIfRTeygwJsmA+j8e6a0twOHp8k/EXrM3TvsBDbw9vIXaQ6ALFrlYMY+2QKJqwWA1qinzwXcKEJCr2pxyxcHgetCgW/0kgFcpfUIfdcUybMlFLLfrbCWGrdLvxixldGNrpnkw+ge6s3EbeQ+2iuVRFZ8SLr0v6MBuvaKaC3TJwoEnAfOyUjGyDgQc47WCaxW4KJ0ndzbYKtwzYycT53fiTavvAKTAZTawRUF1/L1OTjXKrIfCoNopuXG1WceMQDl4ksRAwSn228i7nX7dlcC45KN0dKAlxUvrqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYUMz6EzjGbSZdsfNBoV9zb1KXfMhXT1uZBMMqgtjTU=;
 b=xOVIowqZcMAje4ksqC5TYuvhxfyzqXC5yoArrsThITS1jg5fU8rMrkNGaljx8/J6NiobVtZ16/Tguapchs4Te+uUB8W6IsNxzzY2YnFXcUqUVwEStwORXW9M3mafW5Cq72woM5gWX4+eItMAxCjMxmmvXdD2cgyjHt3/MwZt64k=
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:27 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::7) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:24 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 09/26] sfc: request cxl ram resource
Date: Thu, 17 Oct 2024 17:52:08 +0100
Message-ID: <20241017165225.21206-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: f968750a-6088-4e29-e84a-08dceecc3844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xiUf8p7c3iXGh6+NeuNrbHd6JaE3oTat8UZhrk6DpK9/2u6Wj88s3vpsZk5b?=
 =?us-ascii?Q?HOczEAdjCYchZOgRUuaKoUS7fvWX0/iBkFxLaiYsPYbnh4hJVHXWejopNO0d?=
 =?us-ascii?Q?LI/6/GCaNWwUwszM4UKke7nshJn/FKvs114LENGFLjVv7ohvJutE7NiYsyY9?=
 =?us-ascii?Q?bxuFqw61T7YhPsbgrdjawoJflX8Mx+kCRsiojgyIWuz4mhYC8diangolngt4?=
 =?us-ascii?Q?4Rvj0zA+Df/X+I4zuHqViScAFEnGoTnY7MXqC9kRZU13CXykBn3ijN7NK8jk?=
 =?us-ascii?Q?CLHe7SRqVEX0r981h3r38XMIJyj8nfGyXXRasbZnQ9hbAouVEf3AieQxkTT5?=
 =?us-ascii?Q?TV2yhsreA4ZpfjRQG3/vlcAcF8n7+gpoBhaiezr3zGSIUO3aPqQxax/JmIo1?=
 =?us-ascii?Q?Jp/ot/G2GaI3C1GO5Ttvydp9tgkF5jTxTE8wjKqTb4YWkrFygyuLOVpYfJSD?=
 =?us-ascii?Q?Lw7awNKVoqZ+LYEtcsl+BUMEYdyHjjl7nqxxmeQzldx+bleRNMGhDHTb2q76?=
 =?us-ascii?Q?HJ04FARmA2v6FTquKW1UDZYJNY7zyx8TK+Io4oulA9r+3eRq4oHNFx2R0YfC?=
 =?us-ascii?Q?OmLYTSEJUJOsjDBu/uKEYUzuKyDYAp0AwZa+W7GYkX468VTd6eXQWLcwyfF8?=
 =?us-ascii?Q?TBikJazE5MUp6Xl4YPX3j/QxQVzthu1W3/0biEtcyADtlewyMsQ6WRbHAA5i?=
 =?us-ascii?Q?//E3HHTBYdfglLliVEa6S7F1WI6aOeBhmzMaWKykm65gTYjQF+JedQzwNZ3j?=
 =?us-ascii?Q?SD0jsEBLUY3alqZRyelUAvUdpGSj7Ff9SfrFklY3+2ItdLt7FkCOI10meAaV?=
 =?us-ascii?Q?DlyoOB4lre/VjgE2H+7xZ4zzZpeRB0GMR3NfEEKbMfB0r5u5iQ/8hlhMnmhX?=
 =?us-ascii?Q?E3Rc86IiL15MS1fSEfbk06caS2/M+4ZONvHMhvQT2aPihCq+bMW7VEjawhQx?=
 =?us-ascii?Q?PGcqrFkLsFI5DLULXUuNQFgozUbCfkw8dSj/eO2tyjuCiMUeA/AH3CPI2k+3?=
 =?us-ascii?Q?ZPUjkq3cbueM9LR4WRYGP1zD+dKtOCgjg9EbfEOkPnJOPk+De93tXx26uTE4?=
 =?us-ascii?Q?NA/T/1si/HXwzwxP6Xd0YWhYccGyiMJoe4XkYij4JIrLf3fsmKcrkjCOt1Sz?=
 =?us-ascii?Q?C25jmO63hEGsJVWNlR78mCIUVTZ2crMFfYegrYYdzIJNgboHwVf5vl4Xw6YW?=
 =?us-ascii?Q?tjy63kxEO+c6Xyp2INybY1w2xl4felIw22xF5viKLYnckwE7pJgM0QhaePIo?=
 =?us-ascii?Q?O2aR3/JvGiEBlek/sqE03eMYnFQKA8h5iDRw51kSxXCnisI9mBPotmPsgbTZ?=
 =?us-ascii?Q?gWuyeVhik6UAAx3Y7RGreyOhFS/nTmQIDmRXaMjiy0txvnOdeJNWsrA5FrnJ?=
 =?us-ascii?Q?vW9KpsiAStlvlLlh6Rni9MspJui3S7NzoB3Dvn2bYFz85m/HWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:26.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f968750a-6088-4e29-e84a-08dceecc3844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 749aa97683fd..d47f8e91eaef 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -83,6 +83,12 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err2;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err2;
+	}
+
 	efx->cxl = cxl;
 #endif
 
@@ -102,6 +108,7 @@ void efx_cxl_exit(struct efx_nic *efx)
 {
 #if IS_ENABLED(CONFIG_CXL_BUS)
 	if (efx->cxl) {
+		cxl_release_resource(efx->cxl->cxlds, CXL_RES_RAM);
 		kfree(efx->cxl->cxlds);
 		kfree(efx->cxl);
 	}
-- 
2.17.1


