Return-Path: <netdev+bounces-104181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959AF90B726
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF2F281CFB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6C166316;
	Mon, 17 Jun 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPS43wrU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57163166306
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643426; cv=fail; b=SwL3fj0faFkXIW8YN01qyCfW3dsWqklDCqTM/zCOcrMFodh4TFeIZaTvMXATDPHmIX7157rhYAM4ug4Dpvwv1rMB9bVUIHHN5DRaxs29ay3btQie9dNqSI25O7X5fhRiTJnOe07XBHlobPriIvEdmxYofaZ0fDUHhGGfy2LCGP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643426; c=relaxed/simple;
	bh=dpLorgXv/Jt+f5TxRJTc6ErxmTh3ShUwp4q8m9NE8YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBWYPd9kXRSePi7HTG9PWX+1+/iCRjNgTzk4Dg16lI8Vkq+9oJnFbHr67k/E6mPgHBTqILjyuRadbju2yA6EGkxSfsaMOVTFARciv8tUSwZahBiWEIyRKi+PcBaoHUMrGtMLL0aGxBqg6T0t5ZDn99r96OIWJhAxAKpF5lN2XwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPS43wrU; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH4h1ihbTRcmPobbGoIhdLWfS0pPTw7RmmI4djenwmVJncPOybUX4VOQlk2uVr79VvJLyd4C3LVU5VobnI1+5lhv+LTPhH4QyKej4kV9gkndTJCMp2YEosOf2F4Wjz4HY47yWJfWEQ9U9HNMKgyDKz5qoqk3LCmXFawenUtKwyr/6FrZQ0AYa2A1hu7+/SYByWwPVqEbTN3Pw+hrDIhhKX8wUCjwDOkfqu5CE3XEcbDtfaXuZ9bH79KVpWwLFm0joUcHaCk7PJWt3v2dDzqnVZEepXuHf/w9uwgbiudXCY9Qle9uqVGP0ld/wtlnC+lOQUxO6sGmuKL32DgNfviSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3dexDeR1R3FAjSxQqJ3Ng8qPTEuD0xqsbpkuzPqxOk=;
 b=NQ+INKSbluWarVaRMC5R+QgcRY8MYGkcjI/qYdcYRbNm0UVz1AG3OYqeKucF1o3gIwNDmudGv2iuTgiNkNCiUdWWhp0mU8PaMUxm6Ww+BNuSwcf+rAY9wZFrU20O+0SMxG0GRZOdpFonH0drC3evlfZi8zW1NWzF1ONdf/Av8q3x2puX76QwrBmzfxLhKHp5Hmg5ZaXIWg6kvEu0F3XdnxVDuJ1Kmv/OinRVuGBLRTnoqKnloe+yh7HWRJeL5+eIB1Ac7ENUHRX1uVq7OKerBPEt47EOxqM2MKn9E/T57g7fi0uz6fPCSKYBUm9bf/tqqbZAEU5ZKVyA2TqYj1DaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3dexDeR1R3FAjSxQqJ3Ng8qPTEuD0xqsbpkuzPqxOk=;
 b=gPS43wrURYPo0ItXlwoWGES+LY7mdK+HC8TzGCaCCuNqsFRZzEA4kOmpzSqGJFq5VXoPVgiVfjLkQTET6HExhQPMjDPf3wkXl7wanmTFFiMJrH7GKiR+O6BnY20/Cwu+6l/4ERbFRK2S4UpJoEmn8Jg2NUTodtU5fcZS+c1xbeQio571urMQYRkYI2d0OfuBXGIQhohWEKTn8tNMprB0jxdV/qeAvocFCRgqD8ebveFGVqJ0JTl8/P3YP58ikXFp3PmqaXgUyDwq0BHCqfCrOf7QeddrFbb00WnS+yTj4p3N1JswdJ3LjXTFaKA6kjc4/hPDmY8d3YHV0EjB+L/DPQ==
Received: from BY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:a03:1a0::35)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 16:57:00 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::8) by BY5PR16CA0022.outlook.office365.com
 (2603:10b6:a03:1a0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 16:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 16:56:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:42 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>, Maksym Yaremchuk
	<maksymy@nvidia.com>
Subject: [PATCH net 1/3] mlxsw: pci: Fix driver initialization with Spectrum-4
Date: Mon, 17 Jun 2024 18:56:00 +0200
Message-ID: <782b8dfa5a4b6adb0ef9b56303037fb0cda19226.1718641468.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718641468.git.petrm@nvidia.com>
References: <cover.1718641468.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: c808120b-5d43-4730-2734-08dc8eee8087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6IkjN0JzNsSZ5WVsb8PR/XZDL2Yiq90573zHxK8+t0Ay6+fP0JxEVdLOJl1?=
 =?us-ascii?Q?k9Yf7lqdxaKD4/AArN87FVJtca69ZVC5CXV96zuW44+CzWGBRGLgIQLq7c1B?=
 =?us-ascii?Q?bkgX5aSMHkQhbY3cHWPX5XzTjshwQQU6AZYhxnWibjbczjIW2+HQ9MbyGNlZ?=
 =?us-ascii?Q?UMKIAPPA5uOXMZL0ncvz8yoloQbvwAEQyhB4fvRJfi8HnVaIyUT9ys1wVnuI?=
 =?us-ascii?Q?3t0lC2uu7rW6MtSZX+TE+7PzxoIN3/4jeFDjEaba+m7f6YKf25oY0+jx+HPZ?=
 =?us-ascii?Q?7nD3OZi181RHC4wS0K7GWgAr4wRO/kmP1h+R7BtYST8A/8suqjnsYce67r91?=
 =?us-ascii?Q?kFgOMP/FEWZHNQZDd5yyj7CoFWpdFktbXMJK6HyRut6ENe2MhDbxiao6Crod?=
 =?us-ascii?Q?+pACJRPNSQxRt9XitubrvNi46M+5RejT0FbglQ/VCqcwC9L46dkGj7amWar2?=
 =?us-ascii?Q?6qVb2F2l577OyY/rcyLPuHYX5uQmyyTSF3ae/pT9Hqx+ORO0jqgeVbnsRjte?=
 =?us-ascii?Q?eUZ61Sr4jcOEgnv8qAbkRWlbdJxnqQdoPYL0NXUsRJk4v6oBpA0n/exjuuMj?=
 =?us-ascii?Q?rD5GhcRyQfMRvdL5qW4TkJ0b591DU1tw8gLcBt6cZaGdO+yBAeDnQPFtjmZ0?=
 =?us-ascii?Q?6r8Kb467KxuHnfME4fid4dl7bUrE+8zEPP85uCFD3JUbSiU24ptVC14AzPBi?=
 =?us-ascii?Q?RxXdFJo0nV/EpadZUsjwngOG5iYnnkvVFYxOycSfSXdz4a7MNpCk5eTWRLhV?=
 =?us-ascii?Q?E8erF3Byg6Atb6GbcC0lHhDEYVwraRWZclw/f9Riucn8aKlL5fKUuw/kwqPR?=
 =?us-ascii?Q?Kkat0FI/QyPar0KV2D01VIWC7GxDZ0LPQYsJUMcOxCwaU8rz9moogeVcWvUB?=
 =?us-ascii?Q?IdVypxfsqZEH+cXp6AYJRFlfgJTW5B3tx384siE7WquWqL5gCLJXDCjB8BOy?=
 =?us-ascii?Q?6mknzUNCMoQTz5yg/Zlv7I2t325Tg0HQ8KI7tK+8JWRDCAG57TuR+ItpUQ/A?=
 =?us-ascii?Q?k5rKDCUpG8UsIyR+nVnG1uKNCejJj2gTEWQDKXAPyriJDInjyywSTIrUcFzG?=
 =?us-ascii?Q?kEEaUr8T9bZTz0eHL3AUFH+rIP2egX2qryJJKpojQYgvYCrzPPXcUeJ8D0FS?=
 =?us-ascii?Q?X9IVFx2i1sjapRx2YDpLguvrHVPaQolAJj06YiJcLKezRvtAaE4p1FUGiOVN?=
 =?us-ascii?Q?YvduUmHDrcYmK50P1MXUFG6FPS7bNSemw6oRDggrB/R7KP4ef9aE3hpYwO8y?=
 =?us-ascii?Q?90WemmdiR3+MT89mp79ejZe79lQQ8OM+YWoeqE0SVWDSv8WJyfVVwZqGTSis?=
 =?us-ascii?Q?euBhs3Awl3P0BeANA0lkCgC580RsBu5inSpuY4Ffg7BYjhv0YzBA4wJR/xg/?=
 =?us-ascii?Q?QJpzBSOzhb//bkHEocvrX+H3P3zNbu6wCsdHQYIz7fNw5qfc+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:56:58.9313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c808120b-5d43-4730-2734-08dc8eee8087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

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
Cc: Simon Horman <horms@kernel.org>
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Maksym Yaremchuk <maksymy@nvidia.com>
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


