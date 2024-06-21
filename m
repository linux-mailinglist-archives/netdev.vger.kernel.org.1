Return-Path: <netdev+bounces-105564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4CD911CAF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE191F2310D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF9116B3A1;
	Fri, 21 Jun 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AohPA0D5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F63C2F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954493; cv=fail; b=nUEbQiIssjkXtdZLcN+IFVuy1/rQeFW8qltj1Y7BC2hZUhw3ZJJXurrGUCiW7tfkvszk3ge6V/eO2jRuEYKhnGFGudFa+Mi6LbtNJmaNEkxS/+hBl9UtPUN8b+GaDWz6diBvMhKod7xDuSXAiapWq2TaYsDLadH3BlUV9NlsrLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954493; c=relaxed/simple;
	bh=jzEf/Wm3UUgBRvRNzNlQjqK4+9hFXa9o92xSAHkZi8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+ylTLml3cLSsoBenRkyXVG63TICEi5zX0TraAhLqm8qAdmedHfOtE5CSM1upEEUNj2BfGw67xbJ5X/3iCD8oXz3kv4b/F7UTW6yNr2BEdsmGPO7+9DFYojquilDxrLw33Vw66xwuNTUZT+pcWPrcAFKxO4YxgCD11iEjv/utrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AohPA0D5; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibRiuoUb/Gz+OmgZ35OFSJPAvaM2beSSqp62gRmkZaX5gmzVG8NwzycdaoZuH2NcUjPvEdGI2qntakDO/CIht/YY4vL0maaq0BcMsfipZv6+xH1pU2rsAb6JeM0GLvJnS8Xj7kRWJwXPpyig/1aZtFl00zU5owO8lUILqvcRNRKeOp8Cq5y/P2DREZUzK7YlV0Wt8fFxjcAKFoC0DcpUBDNTWNG9f5mJN6vogK0jogVIrapQyPRO+xAgkK192uFHkrBLsnj7YWL/I7ZxYoSbTQZUD8sD76hSTwB/lrSRFa7QkoU5uX9RTNHSsCYASMUdCA6Y79ryha1qSFHDTMwrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n73jwTc9PFQ+u7UnePsr6kXmjTecSk3lMm/bYhsEPis=;
 b=TDOJt1rUYSg8BTaqptwBa2r2WZ9BPjPn1zyfzoXKrMUCz0NhCjE1yrGZ3LgRDk6Kt9mm1eBp8zbJp0jOUYFbWI2Q2xwmiRIia5dBR+88b0PMbznQTZWJjVJ9xLD5KoE/gEdltGd+dMlkR1+AGRVAaFygKNC+dj7WUNqINcgKO/hgonwfoCNG/mfc/sqz2bqtEUFZ8ddrboYeD41oTGs0MjqAD/kf/0F2kc8nBsmT7T4hOxymoY8ASmsbhAS2tkkqP+UAhipQ4GZwLzukXRAyR7a+GrSL3yT9i1efjRqFitmCMvEIiPOfLFbrO4AmC8VYXl89YnvbLX3DdwdbUDak7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n73jwTc9PFQ+u7UnePsr6kXmjTecSk3lMm/bYhsEPis=;
 b=AohPA0D5ElcyWIKKGDG1OONM+Id3I+NjXRvcL/edUaXHwgCDa5jAe+p1Xi9RZyD7x+H/FelcRQJC1ZRg1jqb8n7pLrIjNw/GE00sLLzfnSRJqMIECCsplRNwV29Abqgx+h24e/2anGFU59Hj9JGQFUgngN8tIEjRIbkY06DzsLdU45V6KZ4en6dLFl6cKf4LBfJYwP8Z/QMaSm3/lOTMaajj1h9zGHWOgZ+5W+I+TGNmXn2kBXj2tbyYVx/lX8XNmcf1SBV1xi3Hv5PcyAz6747YW1i1o9hXNJx6NOuouyayGukgS6wgsmLlkfOnUO5cnj+3lM040/Il2s9Cvbo1gA==
Received: from SA9PR10CA0026.namprd10.prod.outlook.com (2603:10b6:806:a7::31)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 07:21:28 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::52) by SA9PR10CA0026.outlook.office365.com
 (2603:10b6:806:a7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 07:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 07:21:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:20 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:15 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Maksym Yaremchuk <maksymy@nvidia.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net v3 1/2] mlxsw: pci: Fix driver initialization with Spectrum-4
Date: Fri, 21 Jun 2024 09:19:13 +0200
Message-ID: <d4474932101834e663af431624f90875bb4d41d4.1718954012.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718954012.git.petrm@nvidia.com>
References: <cover.1718954012.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: ac940292-efae-4719-92d0-08dc91c2c470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIuCAMqHqMXlRoHEIhzwZt4ZIfcUceaLOfc77HuW1H76XT4mrL23TiCqPO9h?=
 =?us-ascii?Q?N5UhMIN66iKGH4RD4Du5Ol1ui2EyMrsM//sqrZtwwQFEjeU2eUbW5qi4aGsj?=
 =?us-ascii?Q?OXI8x/IvxpZ/YUUZGA/t1ANI0r1JCVJxbhDfRympjLID8tKEDC03sx6HXm4c?=
 =?us-ascii?Q?s6R7JYYDCyFdUhXCergKCubErBfQU5NsQnTMeZo9ddr0j5RBxDvIZPanVtpd?=
 =?us-ascii?Q?+LwVLEO+9OlAnbiLbvJkEIbfMPnfdS6Z5zA+LWEPUkdDsO3IxMj/YVZl761a?=
 =?us-ascii?Q?4ik/8L7+XbDruiw736mx/8BwG9spphz57LXVpUWOs8apSzM3alGh8yI3oIWC?=
 =?us-ascii?Q?aNfWyyGL61jtIKb1odHK1fRPL/8yU28GmYs1LSAEmkWp4ULyFQSLWYGtVJhV?=
 =?us-ascii?Q?whOxKow/0BnG1/4JQrAF6x/StQFt/1WH46q1dr1xvhWF/PyyJm7GqfEfg4Pv?=
 =?us-ascii?Q?M7fDSPUF04FsVjQaz1uAB/F0YJnMUK2KRAXXadC7EHvJ8ilS2kWBMKbHJoeh?=
 =?us-ascii?Q?7hPUpUgi85/T5Nz4vyUfANJjL0tQojJWFepPPdBJFp1qUZQGGsRkjd+hv7C9?=
 =?us-ascii?Q?TOUx0mbKT31fNrUMrpJvQtcDyw8L+iqo7TXVGNNajJQQa0EIBg6mcQURI+cg?=
 =?us-ascii?Q?rOXBgL43WD8ZRnQPIRYalo2PBuzNBi0IWngbs2eckmS1jRzfdpAi9TC47yYN?=
 =?us-ascii?Q?tripvjX+rnX7E/ZJ7bLIqXs0Y+PxldFWLiZDjdBzlJkzgzBKeN2+yGsWvx8B?=
 =?us-ascii?Q?Cf8zNzNG5N/pcqh7ONzu+0e2JsL7ZkcdjUUraqmwzzfrgTRQ3XlJN9eXqZLd?=
 =?us-ascii?Q?YG2Ad2PWt4H+VWDEQGeyEwKCS9/lvucmkNPYg7pt/GWJncoBYiYdJEncFUQq?=
 =?us-ascii?Q?QevPvLvuIFsUMrZmqYz2mLNF68oMz2Pro7DyuPOYtbFqpK4kgAs03uQB6zTr?=
 =?us-ascii?Q?xuYhmVUHjBjhQpPGagx3rQU0SJBeujO/gxUdAjb1C/IXC/fRyIZJE7bmGH9Q?=
 =?us-ascii?Q?sBPT+tFrOQUykdyHvTh0ex9CI7PHXj2XpwLGYizxikaoj3xP6E2n6c9lFg3s?=
 =?us-ascii?Q?Vj+59VWBcTrx1YvFb7zXCvv8STgcrzKeq0EHzdFUFtkLZxnef/YT4u1EiJo/?=
 =?us-ascii?Q?OqW/rKe7WvRlqJ6/qvkSuW+qjRgNGrtq17PWpttM4Lfxyk0V6TzZJtjcNTMM?=
 =?us-ascii?Q?Cgn1PW4CvqPR+H36jDSiAh2NyqQgehGdswLXu3KH3n8rgcdO516WDKXnMwwG?=
 =?us-ascii?Q?IsrD9QF8Do07NOobwyqzGhGJMFRpPRelH+Sh6oSCmavE/H9R1zS+NWUVKBNs?=
 =?us-ascii?Q?UdpiVfnow7XHLIgngt27ZEQT6ptqC137YV8pdxnZkWhQaxpTYNYkHzrqmZwC?=
 =?us-ascii?Q?idoJC3qfTIcb5csyvacyzc+TVuumRMBCKq3Of/NGRw/nAp7HMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:21:28.3600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac940292-efae-4719-92d0-08dc91c2c470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

From: Ido Schimmel <idosch@nvidia.com>

Cited commit added support for a new reset flow ("all reset") which is
deeper than the existing reset flow ("software reset") and allows the
device's PCI firmware to be upgraded.

In the new flow the driver first tells the firmware that "all reset" is
required by issuing a new reset command (i.e., MRSR.command=6) and then
triggers the reset by having the PCI core issue a secondary bus reset
(SBR).

However, due to a race condition in the device's firmware the device is
not always able to recover from this reset, resulting in initialization
failures [1].

New firmware versions include a fix for the bug and advertise it using a
new capability bit in the Management Capabilities Mask (MCAM) register.

Avoid initialization failures by reading the new capability bit and
triggering the new reset flow only if the bit is set. If the bit is not
set, trigger a normal PCI hot reset by skipping the call to the
Management Reset and Shutdown Register (MRSR).

Normal PCI hot reset is weaker than "all reset", but it results in a
fully operational driver and allows users to flash a new firmware, if
they want to.

[1]
mlxsw_spectrum4 0000:01:00.0: not ready 1023ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 2047ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 4095ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 8191ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 16383ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 32767ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 65535ms after bus reset; giving up
mlxsw_spectrum4 0000:01:00.0: PCI function reset failed with -25
mlxsw_spectrum4 0000:01:00.0: cannot register bus device
mlxsw_spectrum4: probe of 0000:01:00.0 failed with error -25

Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Maksym Yaremchuk <maksymy@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 18 +++++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index bf66d996e32e..c0ced4d315f3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1594,18 +1594,25 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
-static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci)
+static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
+					  bool pci_reset_sbr_supported)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
 	int err;
 
+	if (!pci_reset_sbr_supported) {
+		pci_dbg(pdev, "Performing PCI hot reset instead of \"all reset\"\n");
+		goto sbr;
+	}
+
 	mlxsw_reg_mrsr_pack(mrsr_pl,
 			    MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE);
 	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
 	if (err)
 		return err;
 
+sbr:
 	device_lock_assert(&pdev->dev);
 
 	pci_cfg_access_lock(pdev);
@@ -1633,6 +1640,7 @@ static int
 mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
+	bool pci_reset_sbr_supported = false;
 	char mcam_pl[MLXSW_REG_MCAM_LEN];
 	bool pci_reset_supported = false;
 	u32 sys_status;
@@ -1652,13 +1660,17 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
-	if (!err)
+	if (!err) {
 		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
 				      &pci_reset_supported);
+		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET_SBR,
+				      &pci_reset_sbr_supported);
+	}
 
 	if (pci_reset_supported) {
 		pci_dbg(pdev, "Starting PCI reset flow\n");
-		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci);
+		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci,
+						     pci_reset_sbr_supported);
 	} else {
 		pci_dbg(pdev, "Starting software reset flow\n");
 		err = mlxsw_pci_reset_sw(mlxsw_pci);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 8adf86a6f5cc..3bb89045eaf5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10671,6 +10671,8 @@ enum mlxsw_reg_mcam_mng_feature_cap_mask_bits {
 	MLXSW_REG_MCAM_MCIA_128B = 34,
 	/* If set, MRSR.command=6 is supported. */
 	MLXSW_REG_MCAM_PCI_RESET = 48,
+	/* If set, MRSR.command=6 is supported with Secondary Bus Reset. */
+	MLXSW_REG_MCAM_PCI_RESET_SBR = 67,
 };
 
 #define MLXSW_REG_BYTES_PER_DWORD 0x4
-- 
2.45.0


