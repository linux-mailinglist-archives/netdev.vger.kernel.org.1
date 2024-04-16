Return-Path: <netdev+bounces-88276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B98A684C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F227C1C20B17
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D22127B68;
	Tue, 16 Apr 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aAwDERB5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231A127B6A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263230; cv=fail; b=TrkXYaqwihT7XSZTfJh6U05cJbmaeyZX4taLPziloliVHn7fSgbIq7An192x2xljfy52kw/KwUjCfNG6PZrliF/lKzo/Ht+sODTMockkiEyP7eVI2MBdINjP5rA4n4LNxjqDA91E7SiNK3WwB8CB1Je9p318JS2SGaLcxjvSJsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263230; c=relaxed/simple;
	bh=syGf1Z5JNoHIxUOWts30Z04rtEvjjlxiJwY6i1CMp4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFodeYQLssS/hZInF+mL9KXYW55VJ8wfj+oFAOduM6Mi/ECKJkT1GiQvtlBTqnR2gilaPCoHbBrJvFUGWWMBqDMDg/pjlqJ37ka9CY4vnL3Wh4QDa6haV5WD6GubRnpXQgUERSZ0TSxG27NPIZijae2h98wIto7sH3iU5mVdVx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aAwDERB5; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc/GcTskee4HUGXqrintRBmriqaOScISzDoNHh7KTH582ra6ivqi17174SrOh6pIeA06d4G+R6160XHtnWJ2aWCNFZp18TjBh5C9rNVJRYMNLRIJI9K8lbIs87sHaEtWm+IZlWlh2vLpGz624ejl6Z1DuqmM63TixP88GUdkxoz+QJSkWbkk6xR5s1xrQujnoTHaOEjkQS6NX612ma5gg2U5Hmmes6ErjFCCYDa0ZmTitJeDApWqZzRjDgwN6h1fnVxR2P4xpos8RQuj8dTAkM3AAwZkDIEH8hASyjbzBl8pIuULFdVG33lkU1IrLPn6s0WR/H6m+GUKiwhP9laQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79ENVm+SLCP0C1x9t4JjrGmDtuSSvQkhjJejLz5gIqQ=;
 b=G4xBhemA9ESvdV1HFZb7d0FnYqKLFecgd6FuY12AM7WUlp6zvOtMl44QavI29V8KHc81hVKNoldoPyEC5+b83EOTa/5DbSCtx3oAudrAAlhtSc3ClwqOoS6+CEvSi7Z+rQUBMQJRzznnlH9ICie2nRWFjpfdizXS9BYI7nzS2NOdrmG5NJ/ujL627u7kvLXmK8OYPTU2ziQKXEgcVjhAx8PqAR0NxrW207eMRDNfgU2lyp/pk0IVbIRk773SXwaGR++QPRHWYbAW/NID2t3ujsEiXBVfGKyI3nWcc9pQNfwDpYaSCnocONBSgcWKAYTW6NUEsHZumbGR2Z20br+Rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79ENVm+SLCP0C1x9t4JjrGmDtuSSvQkhjJejLz5gIqQ=;
 b=aAwDERB5/tyz2SDgqM/CWKHoeV2m7Y1Mi25kQppewAAkXUmF9MrxcXNC7XQ185VLJz0XxjUo2p8kEhnV6pd7pslXjXz/w42aWBr6VRCyjulKV//Zbrj2X50a3GWj47jLtajzflefBfImhnOwVP15oTAOpwea2NtpIgFAOcR8rtLQPSKxebTbMAiKWGWqOgoLysPGT0AwmOQxSvj1gN5Xv72r5gnLjlEHp0a2ck6QIl8YcsTbgy23Dlo1JRKCWuuz3/emT/oV3FOkoFvXSCFlj/HZWVBEbtZ0+CRGgOQH9OqG5sUepCj2NcPe4WbYMVKCBtMS7rThgI/U3Ed/RmoXcQ==
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:27:05 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::e0) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 10:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:27:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:26:51 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:26:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Tim 'mithro' Ansell <me@mith.ro>
Subject: [PATCH net 3/3] mlxsw: pci: Fix driver initialization with old firmware
Date: Tue, 16 Apr 2024 12:24:16 +0200
Message-ID: <449181a5ed544dd4790ae4d650586436848007cd.1713262810.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713262810.git.petrm@nvidia.com>
References: <cover.1713262810.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: a41ff0b6-3471-4d1a-9e86-08dc5dffc306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tEQVpm3i8Tr5lLIHBJxgOj4c+6khKS3Hj8/wfOi9Yj0PdgLVzfaJvvzYJ91tCRyCkeP4ml8sqV2TiHKVD0jx13pG60PFlZQatNJ+dsGZgMhQ4vBGlZtbJicYHLG1Ox+n8Jpq1ZsK4TQ5qI1KFCJpe2QPfNvm8tjIEcTsYg7a4yEv9CE9TuTt7GrTUZlce/KpcCdP/PnucFTsPd2NyRusfoy2TYg0uVEQY7ptvY9k0CB9AWAN3DmdIdMN6Bf5fDgY5WB5Yr858v+g602C9NQAIxFjxmergZgeiESKpS0mXXfNeuPCbB6NFUA2nxBdXQKOBTs4L8TaqCsmRupAfep/sW0vxTb+uxBR+7z6Enr8WWdhOr0XSV0X1izky0+fhtzXug81H2hLPOzKe6zo1Zu0053S/xMv5CqHWnBb+mgrUm2ADzdYugjSSS+LSTvvhkZLuOEVn3h+fD52aBzs8tdZzKWvZSjn8PqyaNZHhSLXOye0n8jShp/nklU/i1c6saa/QcPvujrlwVOkc3I1EgkLmWAngkW/exyLYc0BZ70CJMqQie6fIBNs+Xos7eOMaCeDRLqlDLTMVUQYEYK99fBd4e9uGqwdt3sKXwPhT3Y/OrT9x6YhVtEvAUQ3tSBX1IGFY9zEpnLq0Hqi9zr9JwbO4KcksWxEtFaaukNGkwpvUcp1VD0XoHVOgtSyNE90WWG2HVNZH9l4QDmpMLtSJaWUPkKFwvtaGk33bJDHR8BWOjSUYnMBcEX4MgkzFYXczNHz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:27:04.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ff0b6-3471-4d1a-9e86-08dc5dffc306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363

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


