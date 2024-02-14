Return-Path: <netdev+bounces-71725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3C854D54
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08D31C21B6C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C15EE8C;
	Wed, 14 Feb 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bcqng9gB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDC5DF17
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925802; cv=fail; b=PecgQKp511SR5CY+Xc6392TY7X4/uzMe6AVMBFuhRgaE/F+V56JrRZ8bdEBfai3/6L+8VYlIUYTUyP/cfMf4aVeVleaKJA2oW6TNbs//SIdZLNCDHoiA62LN4FX3t4Dco1irMLlEWqSIP7U2rk4IxJpBt7WMF/5HL7/Y3UCYc28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925802; c=relaxed/simple;
	bh=3y6VjE1oMiZM5DA/VjG1kxpoe11KcIrHke52PNY0698=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBGCOQq08aM8vB3c3euSDhweci2RKIan2vcW4QFqT6yiyXTKb2pcg/WaLdPLeNZ7LCy93rSKLywxCAmdHnpvaMtjHQhvbV1R/e/6ZPiAeWdx2S8AEZ4BnRzFLM55esnj7usspO6ql2ivUDS52q3G3Ca7nf45nfGylhybtcmGfhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bcqng9gB; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2XIR+RlzlPSNjPq6B5IqijXgbd/O8/+z5eKAd8VZGydrsQlaGDMcDwgCsOglxgQWG86tk++FYhRl4AZT7nYTgbrwCUYeOK04DECFPuoiCudPy06g8HZRzMcb+wyEJh8DFa5L811L5JDo469raJPRksx2xaZhVnVVfSariwwVsCzIXSoyDw7H0Lr/OS4Bub62PeOifpiMqwSpmVcRfNGFokCp+THLNdhzQqR1mgsXDqLit01Ck+1Fr6crB07bNeugqkBR97v4Fxpo6a64m4M5J+WwCqesmm2NyQ4Q7REGAB471HfXDZLOC9uhyf3bwLdhNX76Ij6gnA2No97IGj8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fODz+EoTEhCRbK/9bYaDTtTDETBeb630gAm1qmOufWw=;
 b=WoIQ1FYZMv3lKAZh7FgEyCRyFcRBJA1EXV5Jvud7GRsFMCHe9fgLHsQIz0W2foEgyr9RFFX1u/Z07mWitxi0F9V962QED/SvK1HSxcMh1P+mw2RILlZCjIzBjBWmg6bTr5n8ot6hhxe2i9v1T9HlNctLDHJfwh+JsDE0J0O7FRClf2YbtUBN8zpjKmNpKcofPRPgm3UYwvPUJXm9cMl13WM6YF5YE1ZJZxZdpsI8UrZbNEStSmuv2B6eMRKVPFsxOmrqLQo2AVjgkynBB06zen0tYw3cJGE/t7ipjbl5r4K//nJD88qjHDPjiQEs9tHGwJ1qrHYqH9sFp+4FfHNBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fODz+EoTEhCRbK/9bYaDTtTDETBeb630gAm1qmOufWw=;
 b=Bcqng9gB5aamtVZPu/7YEZrGVhnwktCrahbzHMRzn54Vn9LDAB0RzknLUHoTMI/oWtpVMRBhdfyc25hv9nhr2Ofw7HjIMyU4GdWhdd3EErM9j6GCwF5UT4gB+6n88Fr17VM9WsOtprqSxXDKcoRNUG6QcHikO7/yhsXSwsLsW54=
Received: from CH0PR03CA0445.namprd03.prod.outlook.com (2603:10b6:610:10e::31)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 15:49:58 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::5e) by CH0PR03CA0445.outlook.office365.com
 (2603:10b6:610:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:55 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v5 net-next 5/5] amd-xgbe: add support for new pci device id 0x1641
Date: Wed, 14 Feb 2024 21:18:42 +0530
Message-ID: <20240214154842.3577628-6-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db12f47-b2e7-4220-0f06-08dc2d7498a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qaagY3G4ngTHCihkssauRMFFZaldTyIw39DsfJN5lB/YjiwT0AkcB+6TbRvlH8c5OVgomicP2VnXqw3l29wJy7GAcJQ8YhBuuuIxzdxGjPo7lI4hyebldDo4AzYLXfOguj3HaeLYgHf6jquSEIrsF6StXMTD82B3lcrNlS7MrgngVRKEmP0eunRBuoabZFvrnwSGjtk90Qs+9+ttoBMN3rpWgmYSgnV07nNF7+KAdsdvjXv2PbAgbh4l3GAIBZ1I50YZsMwxLW0vt3OQooBRValjk4VCNpuCP6BWaWGWANeXBdXm6sN0ZCTK4hsJk9KFzeVP1haWiJ6CfUKpUtVG8mo7PVY+cKyX3s3dJEJRwYDRIIYqYd60SXLTw4cScdVsvC+kG0KeLCd7teWGHBMB/2kbmDCv3Ebgzpu2uJuUNywCxNmoZOpeaenZigTYng7RXc7Y+RFRATsfp18iyUEKLLmkPOFVdlYbEtDfMWrw9L3IMR2DcZrM47jrO3KJuEOPFb4UbrNrK8XkbY9oEi1yni/7cH7AsRKWTFELv//GIxWLJnsxNmJNV5/X78RdVJjSoceVUqlFb4Et1IUqXOsA9idgtdFukFrKU1Wuzh2g+wI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(26005)(41300700001)(336012)(2616005)(1076003)(426003)(4326008)(2906002)(70586007)(70206006)(8936002)(5660300002)(8676002)(478600001)(54906003)(83380400001)(316002)(7696005)(6666004)(16526019)(82740400003)(86362001)(356005)(6916009)(81166007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:57.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db12f47-b2e7-4220-0f06-08dc2d7498a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

Add support for new pci device id 0x1641 to register
Crater device with PCIe.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 340a7f16c0cc..179dcff907fb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -496,6 +496,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	return ret;
 }
 
+static struct xgbe_version_data xgbe_v3 = {
+	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
+	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
+	.mmc_64bit			= 1,
+	.tx_max_fifo_size		= 65536,
+	.rx_max_fifo_size		= 65536,
+	.tx_tstamp_workaround		= 1,
+	.ecc_support			= 1,
+	.i2c_support			= 1,
+	.irq_reissue_support		= 1,
+	.tx_desc_prefetch		= 5,
+	.rx_desc_prefetch		= 5,
+	.an_cdr_workaround		= 0,
+	.enable_rrc			= 0,
+};
+
 static struct xgbe_version_data xgbe_v2a = {
 	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
 	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
@@ -533,6 +549,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1


