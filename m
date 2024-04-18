Return-Path: <netdev+bounces-89226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F98A9B97
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAB61C209BE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285841635C4;
	Thu, 18 Apr 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cY+vAxsL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338F1635C5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448137; cv=fail; b=SOzATHV8fEiX+t8sIo6WLO9l3l60dsTeBk6msqXd9eAQPuQQJO16dnMPFhWpKSnq69xGVI/MH3e0VUE3BMFOo30Np6CeQAh1MT4OQ/2jh3l72tN8/xxvVVG0UkY0ODOG2KuAkAQvifBOZYqTUJFEmClfB2eT1R7AXdmDs8fAARk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448137; c=relaxed/simple;
	bh=j5FfhHO3tbGxytaBVuuw+bkUblx46dH7n/f98ND4HyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWiz8Rfqr9vl86uz6YIz86HYb67S41a8HMxIech1YSOCHIQ9vsdfaDGWSz26jgFtIJ18rzsYDBQR1qP4dLAvT4KrbLUh3jx1ukKweaDpcgnh7PLdCjtgxLIAF9Rh4cgD5+T6iSejGmrD6i7nJGlyFd9tO6b7583HWvjOL0Q43hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cY+vAxsL; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FftcM9IJF4NFyZdoWsW9PVOhBVThrjHcQwAwRr8rmE5+0C1j7LdFyqFO5hSCAQEcfFsCNZyJChNcDzxmU3xkIhe1JbhIhd8eUOmYGPJtt0z7z22GhUoWak8J5mGK8Oo4+UwPrku7Xx84tWzANEd485MxKCTpdOclRl8xRD2vYYWOea0/ki3ztmOLxGDV9kpGB1qpOolEgmibsDsPD+TIgrTYkFU6984LThafXhwtLwq4i/cmyJ2zahH5NX0pomYY7Zl9Ql7FDlKKCMqn7Z9XzVmReUQJsWMO/8IWbn0CIrToSsoRbfvP/eMXeR5xB6LnzJuhe17hp13FrpSVKnDNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEcq4/JVxUF75LdQMVIth5Nm9Q1MVss1Z0BP8PGUBcI=;
 b=W3F0Mom9ED9dRxj5u41P6aXRClSDISv6/U7kr2UPEl8nstOTyy7n0HBZK9wkcQSnKvwlARPFnsQVydnau04GMvclJ+Y0m0ORDCYvOPgc/1EUrJ9cLo8AhJLPHO/EFw56WfAFQAC0GwbnbGNBxkw4hcpVTmHlaEy2FoCtXhj+dwbHFgnqK2jjYpLWoFP/8M+iIXm0FOyKkhagQ6TMbGGYT3C8bNl0tzlL/sQFWfJngnmjVAF2DzljE7yJBOY0YsIHFK3MXnclVO2p43zyHtJNvNpdoYR/gfbfcpKHgGTuB+vS1vVInGYADkpkF7z1GR4bnKnenKhSOrfVcLEKf0sV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEcq4/JVxUF75LdQMVIth5Nm9Q1MVss1Z0BP8PGUBcI=;
 b=cY+vAxsLGiTF5K/LQMUPfiXunQvmu9krIYt/3gQo49vpB3ZpIW1s4IQJlGff34+j+kLy7yQBAXvCLr/7Hk2Grn6izVn81D+PWejXR5SudKJYk2ztPjqbcd6xkOd2bnAWQEYASs6MFmLTisO+k+5Yum2tEUoT0T08IYdC5jIfnIB8r3zXiOja4iTHq6TTQTet5KNl6ps2XWx2uFwezusxBx5btoaFuZX8H1S3OkGTpbYuX/tB14Yw2ipNZHYrBpvISd3fkKx77mMrugbSPzt4kyalVW8hKozg0gwfTdf65wNK4fK+80+9LRPS20YKsdsmyTTsdvrxl3YpIHBK8Nw8fg==
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 13:48:52 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::64) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Thu, 18 Apr 2024 13:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:48:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:37 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>, Tim 'mithro' Ansell
	<me@mith.ro>
Subject: [PATCH net v2 2/3] mlxsw: core_env: Fix driver initialization with old firmware
Date: Thu, 18 Apr 2024 15:46:07 +0200
Message-ID: <0afa8b2e8bac178f5f88211344429176dcc72281.1713446092.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: fe50a6e0-e11d-4063-6e46-08dc5fae47f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pLwOIyBAch86oyI+oADUKuDOkXfRiGQ3bSQWd8gscvpw5BjzSBSfNBUx+4qES7/kmqYfyMedJRpTGwsn6uRrhWc4mifpSNSgs31byPkxTNLpKAAdZuMTY+X0Xmy26jrnKXrX21l+4NRfc8Q7TBH2TEKRaIC8887mR9RlB5py5bF38O1shfR60eTM9S0jXPQ+IXH7ioKEGqGhgZBO//CoYy9jboID9BRlLlDEdql9Y3OSzEtOyx7dYNjfOiGV767HSftV0xnGCeKfddzqf+CKnXqOGo78WsCvBTAPe6UJ5QI/aj5OFSW8J7tDXGyW83+gUiXRrlBjZuYvr1swSM2/FSAH6RNoatEqJEq2Fvbo+TpUmpAIyrxMjeJ4XRWEwTCMg0I9mAhMlR4qHeRCiii+DQU5g+L4VmcgA+Y9xf3bX9AcVZ2zMW3ev89b1sOPQJj+gPpfvEktXR618+Tm3QElgPuoQ0ruX5QMmmgqXvm5zWQHxdWmSXkgtNleGfFRbGXTd1GEMqj2evHgkri3tok+RSlTlpJU/O5UIEHXJ/BE8FTbK2gnN+R30pB+bqeyNQaMBkbknUz+lWnLNCzv/q6YhwRqM7eJKjGBjOZ2ASs2SL1rvNoaKdoce11iFZL9uTjspZt8k+G7B09jyWb0LD8yKOq6+pdFmjGtBrzQWTlmHKHPMbDfqYhriQeG9JSAIeDvkcUeEsh/4ZhxhgMMW94U6WI8vjY2+J1+ahr063/W+aJnRCzrjAYJPgsYGq4AQTW2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:48:51.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe50a6e0-e11d-4063-6e46-08dc5fae47f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

From: Ido Schimmel <idosch@nvidia.com>

The driver queries the Management Capabilities Mask (MCAM) register
during initialization to understand if it can read up to 128 bytes from
transceiver modules.

However, not all firmware versions support this register, leading to the
driver failing to load.

Fix by treating an error in the register query as an indication that the
feature is not supported.

Fixes: 1f4aea1f72da ("mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks")
Cc: Simon Horman <horms@kernel.org>
Reported-by: Tim 'mithro' Ansell <me@mith.ro>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Make mlxsw_env_max_module_eeprom_len_query() void

 .../net/ethernet/mellanox/mlxsw/core_env.c    | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 53b150b7ae4e..6c06b0592760 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -1357,24 +1357,20 @@ static struct mlxsw_linecards_event_ops mlxsw_env_event_ops = {
 	.got_inactive = mlxsw_env_got_inactive,
 };
 
-static int mlxsw_env_max_module_eeprom_len_query(struct mlxsw_env *mlxsw_env)
+static void mlxsw_env_max_module_eeprom_len_query(struct mlxsw_env *mlxsw_env)
 {
 	char mcam_pl[MLXSW_REG_MCAM_LEN];
-	bool mcia_128b_supported;
+	bool mcia_128b_supported = false;
 	int err;
 
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_env->core, MLXSW_REG(mcam), mcam_pl);
-	if (err)
-		return err;
-
-	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_MCIA_128B,
-			      &mcia_128b_supported);
+	if (!err)
+		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_MCIA_128B,
+				      &mcia_128b_supported);
 
 	mlxsw_env->max_eeprom_len = mcia_128b_supported ? 128 : 48;
-
-	return 0;
 }
 
 int mlxsw_env_init(struct mlxsw_core *mlxsw_core,
@@ -1445,15 +1441,11 @@ int mlxsw_env_init(struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_type_set;
 
-	err = mlxsw_env_max_module_eeprom_len_query(env);
-	if (err)
-		goto err_eeprom_len_query;
-
+	mlxsw_env_max_module_eeprom_len_query(env);
 	env->line_cards[0]->active = true;
 
 	return 0;
 
-err_eeprom_len_query:
 err_type_set:
 	mlxsw_env_module_event_disable(env, 0);
 err_mlxsw_env_module_event_enable:
-- 
2.43.0


