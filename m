Return-Path: <netdev+bounces-89228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021378A9B99
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7822816E6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B53161330;
	Thu, 18 Apr 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="czekCLPj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1B161912
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448145; cv=fail; b=VEZOAel4DtHYouJltghrreW6daJjJ6X4M38z5WXr4169evrEAbutPdxnXRvXulAbnhDWmafOemLMk7MFL9nTI2Tt5kOef1dCFrcjPYdnz7RfgZY6esCbuzUcl1JUt3nu+ZFUl0HILlSytrSZgMoCfk3WNG3Mdv2QMntjcuABpGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448145; c=relaxed/simple;
	bh=o2nQkW6rgfFEbAZIh3g7C70iDzx9EuwI+xXVTYvFxMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEGfWYTxOSOm+sBqCLUcxMDIvxW1nU6WaflkUJzCMDU29IweUA79k1Oyv9SLoBz+6OBaDXvXkYLx/IVJ+oI9A+HL5bVITUEZaK9ja7LeR6V6gXsGtlckimbqlQ7MXsqBLDYtBgqubl5dvzrQH4qr8jjbM1zhUyL9VR2rpdbUJg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=czekCLPj; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk/6ETyAhDrLmCrbgioBWh46x8B5g0ATNzNdJSWjayFryjCx24eVM8E5HLiRf0ckDZJQ0UyNphZrNymK30ilGW/lpxa++whkpby8RdIfVxz92Xmvw7dW6uGgzD62Wlrr/Fgl7pt7S6osBYv/EwEsROzI7ipRxr727tUkemrK++eKwlEYso6kx6GglanQZsI4fBHPQ/IHuqnykCNX6swOd3WDEEQzTT3J3DjREY9xMHD6NWlmoJPgO2QVC5xY8umvf/ogydp8RfEuWF4DGAFc5q4bhQ3xNN0cjEnhBZjMsaxJGYj8ijEszg68BMW7/68BTIKXH3JpMe+qeci+hN/MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1wnZOq7gALN+c2rrCLvOO30nnxC1MSO7nuJZCRZtY0=;
 b=imy4KQEsP4VAR5fMcOxGrvk7hPTzCIFgPbLeYXa8p7jw+MRWTGMr3oZQjfZ8ZcymIEY6hUTivHHo6wJwVSnHdGdaRg8R9PcA23gatrz1dzETJ82wC4IasKkXXOgBRI/ovsQ95jBRDsgEpvjQyuUijemfta7oCdZGMqylDjj0UFHo3oTG9FiqkpIqkenUcnKJb1m3QePlUnvQ8J4t5g6OEosMwsrO9f3+yVaMwefqdjV5B4Q3jYejNFIX5fenHOnOQZPGnwjwbtgVkzVmwCgvdKs8z3DVhHIcOOtOkMve19Zt/GLhKFVvlB8x+AQdVdOfnOCN5fYP3JtBzTOZFC+puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1wnZOq7gALN+c2rrCLvOO30nnxC1MSO7nuJZCRZtY0=;
 b=czekCLPjQ3aBhE56W2p/yqdQy1N5TPkhsQhGDT4RLzciC6OFKd1MHoPeBe+QIdAMOCHWpdHzistG/7PNaWe2br5f81EXSoeu1R7ooov0hEBEFKlJ/GOe4/otQppKoWULR/HZtDkG8A7a/x7MWSq2i4nylAtaNu0O5PRW+GzcbwKR+u9UP9omDPy53IWkkBc4WSo5AyefYBIphBYJNFm0r3yWh8dnvMnUIRpJIIAT2INnjt8ViscXqfOONnxYz3uDsJWokbLCsg7E2mf6fN2AcVnButi8mQFGrQCpWkMaka0zXil45fn5bOVV7f5L7TfCUKNxqPTxUdF8AD7fGfr6Tg==
Received: from BN8PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:94::33)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:48:59 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::98) by BN8PR03CA0020.outlook.office365.com
 (2603:10b6:408:94::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 13:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:48:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:42 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Tim 'mithro' Ansell <me@mith.ro>, Simon Horman
	<horms@kernel.org>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2 3/3] mlxsw: pci: Fix driver initialization with old firmware
Date: Thu, 18 Apr 2024 15:46:08 +0200
Message-ID: <ee968c49d53bac96a4c66d1b09ebbd097d81aca5.1713446092.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713446092.git.petrm@nvidia.com>
References: <cover.1713446092.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: b26ae776-4b66-46f4-974d-08dc5fae4c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	myrGi9aupow5ahrdVuBnedQw1Y3dJ1g5LEyYHg8rwxYUrI8r4iH3mBR2Yy4vqnvhjfhqhdXDFmOL5uS+p0DTglLyTQPJRj041uH5p59OB0O+5E0usm+Lxoa8uS1NFi0ztvRSqbsvkG09D4aX0BKi+4HTbjCsD1NEcyJgfddBSjU95bBlaPDRexy1VSexDNY2OAiCZj3+0omlQruVEkX9lPh1SAGvxK5jyCLi4VYId8HZXgYK3R1tyEbYhwwVcV2AZJqT388DDNzZPGLXJwpNy7gwLFBflBNhkPzXjVMEjIZFt6hmoHHjsSJkN5q2R6F8FTULWIrr219ajWgqTE4yGH3gR8/qemF8yTh9jcYC6fIqygLoQln445Sdxkx5itqn51Tw+kAoJFOreP71ZZuujMLjCyaYA5WBDyTPCJZeuvdrn1wLNdty04/aYQ3G3W5OPU++BuAEuN/EfVFk+t2iesTJayFA4r+ne9FikxJdyGQGYT6QPWiw09RpIRTzIVkuQbJ0RMpUpZru+AxubxVGHjuAuh1pvANwiRM1yRk9yMK/hpaoWIvgwE3rxaoXwESSxnhGMB2EVdoHFFSE+S0K1yX17I+HRVvt2vyTPYldGfBi3LzefgXjJF0Oyu+ZIH78gv5JcdVSLqB6md1QzC7cZe1fcOnEG5ind/xli9sg5oPtZQaWWKj50+TlfpywhSZD+noGrO00g0cMIGPP/VAxY1Kq1HQETDdD7EFq2N3jNeGK9KNkhXJqui5vHte0NJtk
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:48:59.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26ae776-4b66-46f4-974d-08dc5fae4c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

From: Ido Schimmel <idosch@nvidia.com>

The driver queries the Management Capabilities Mask (MCAM) register
during initialization to understand if a new and deeper reset flow is
supported.

However, not all firmware versions support this register, leading to the
driver failing to load.

Fix by treating an error in the register query as an indication that the
feature is not supported.

Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
Reported-by: Tim 'mithro' Ansell <me@mith.ro>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 4d617057af25..13fd067c39ed 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1545,7 +1545,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mcam_pl[MLXSW_REG_MCAM_LEN];
-	bool pci_reset_supported;
+	bool pci_reset_supported = false;
 	u32 sys_status;
 	int err;
 
@@ -1563,11 +1563,9 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
-	if (err)
-		return err;
-
-	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
-			      &pci_reset_supported);
+	if (!err)
+		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
+				      &pci_reset_supported);
 
 	if (pci_reset_supported) {
 		pci_dbg(pdev, "Starting PCI reset flow\n");
-- 
2.43.0


