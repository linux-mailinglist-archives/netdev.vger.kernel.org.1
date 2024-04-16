Return-Path: <netdev+bounces-88274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 171278A684B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712BAB21B04
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CC127B53;
	Tue, 16 Apr 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKallWHA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCE127E04
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263224; cv=fail; b=RCtaEpX6NlLcZuCjoiGUmnqab3bmMJxeXMyF1z2P9gOcr3wFEopv1xDdLT5sRHd6JftHFo1Lh9NyHSre5rgwQMqnjc5PguSBX/zfjOUQuGyIvv2dLG2LvbW+uTRXKzickH9zyRjvjHPl7L/Fvpe8CTD7kOMbK1sHgCCFY4L8zGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263224; c=relaxed/simple;
	bh=qr784Wkf5iWEv6eRY27aqjBQ9/HXyZPGBLOCGf2Ho2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8PRIzMRv9YF63zypsKIcqsEsGVIp1zgJwIduTdBnwqaP/sLDoW60eK6RzIeihkRNSnNQrCX6apcQ9rTgqx8fVjKGbbeQH0ow+1kn84PjttUWgjOzNpvrjKvZVH7Nb+NyLAdFSKigDidl/nfN79wyMw1olJm8peN4rOADwJHL6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uKallWHA; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGkWQoo0s2Lq3VGY/2KZoX77SbuxmOZ1G/06L2yugsly5D3GIwgE9gp7RVcO2kFoprPf7nUfqp9PDlcEwoizXxIiEUYRmIaLR3RooiXNMB5cHeiFrrZQn0WPybGU02ebczaVgayqOoaR8VdBtxtP3/+hQPwIb7QbTon/y3IFrYIoIUeglRu5OByICaZPOSy8fekELP+alhzbLsMNQwt3YUSVnq0zUw88uuxLamNfrIs1G13RgjWEfSVR1lr3Ah+Uc08uc4oXTQMH632O5jtShaADJA8hRvErh8xzCj/J9vmdnoow6/NbysmInzFqUQn1qVZ2ieHVv+P36D6YDdIdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p37b0wRkjfgZYYEJR+DT94OPv1tVc84VbVhVtc3ctPI=;
 b=BObHqdwgYqdmUohuoQmr3TxnaIjObqdSUMHQJe8k+POjdhAJBQjWPpZy2xfYF6/krJiNMHfwq1uZor+2fpXeK+jgHiUt8NWkkMYpi77yHLf/2pN8Ys8AnLCpSpjXKv1XHGkIPyUrf8c3S/c9alGJkr6hpA/oIwwef6kBYU8p40fQeKC5hyShlLQrEqGQxyCQc5U/2jBvfJqxtwA8qWKLuvaauXOQOZT6oXA6a+HlcBnNbQyC8o1aU/nBRGlIXSC1+VC9eJHK6CscbQRSdZEpyXYscCfdhYCSejdlWLDVg9Ekqyl9hqaYAu8sUXrLEta78T36Bx1mxxgtsZT2O1PLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p37b0wRkjfgZYYEJR+DT94OPv1tVc84VbVhVtc3ctPI=;
 b=uKallWHAhMBe9fPc9nC1un0BHkEEPcRvmi7+AEPf8zn/OSBww+5f+b2Z1wrDZ6uFsoMZ3Hqcgf5Bp115SRQl3IeOz7EKp05pVqgXTA8GgRy6lTgiADt+xpVmhb33Jk+vLcbNHGlREI5YXVcsSJOvxWub10v+bzPorOENEhlIga2WbNzMBMdsEPO4tgoHattdjqgZqctBHQTeVpYDpJ7+yoa+ICtmRRZHHREUcyXldLKP04kfhzYKiEv8/zqlZeD8eG1dTkiAL6Lf5dlz1aZZAnHlTbW15/xLmimus8V1c7bYfFgYAhbonxkvaFMPj6n1P+hPfEn28pVE+teBBW3Dqg==
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 10:27:00 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d5) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 10:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:27:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:26:46 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:26:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Tim 'mithro' Ansell <me@mith.ro>
Subject: [PATCH net 2/3] mlxsw: core_env: Fix driver initialization with old firmware
Date: Tue, 16 Apr 2024 12:24:15 +0200
Message-ID: <314f08cecbcae00340390e077cf20e02d0b48446.1713262810.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc66831-3f00-4fec-efd2-08dc5dffc029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQq3a988NJZVWUt98TtBLcjFRzZrDzpwsJ2iE3LUBpxaomRTD5aPbubkwvlD?=
 =?us-ascii?Q?hZQfZFupVXbi6ybDgq20vPhrXeUcJhljdA1IZMdNnTQtJyTxvDyj6dZAZnSi?=
 =?us-ascii?Q?PM52d1WF/SVa6a6DFID94aDh9Z+Q9DQyLvuPXPHvcwMO37AVn/t9ACj/Lx0f?=
 =?us-ascii?Q?yaaL44b+4iCjNVMSrEHaotlbP6v9bq7sNcg8r01nXN07hEdDk75GQs3hVE/D?=
 =?us-ascii?Q?rzxYRd9kq5H6mPcV1tswmtuyZLChvg8Q4aHimCxNNpfcZvNbOsGrCk0xRsfM?=
 =?us-ascii?Q?ICu80lpYjqRIfIhEW2lpq/aT9BsKZU3Gw7XvWsAJBa9k4fhiONED0PPH7ZOF?=
 =?us-ascii?Q?4c0VC/WwQVbg4cLOzwQ+3l6RbLh3xonFKegPStLyUT4pCa2G9ED4YwHLpOIU?=
 =?us-ascii?Q?hez4kVKFdtSLzjQr6duSKwb5BuNPZnvPOBLgdnammnwLJkzXpWL8ChZIIAbz?=
 =?us-ascii?Q?IKPpb+5Q9AIn507Q1sFsifwDxsahSlaDxswlv1xcE98/t8gXW11A1942FOXq?=
 =?us-ascii?Q?dNBVQRo/0/hkz2KzykeZWkX1/O57kVVf31J+oGlsBuGFUlSmIoeO+dGNyJpd?=
 =?us-ascii?Q?XDTz2ijJfxTnl4W2Ub0TVSPP01S77dmKpJt5bJwfU6eEif/tQU04y3zrVcPD?=
 =?us-ascii?Q?RfaAS6VmHt81LsaHe9HA5HZU/6UMsWqr6s0z5x7HhBR0lWnjDQayS9/p5cm0?=
 =?us-ascii?Q?3GGKKQ2Va2CMj5meEaQE0NcSU8Zo0AViUBxMsLBkZWwdp0FCArD3ddoLewfn?=
 =?us-ascii?Q?ZSo1Kzg4ARu+1hrTf0SqyyH828FurL2nJmRzfupDjyhXn28ixSqQlgYSE8hh?=
 =?us-ascii?Q?D/k4YRhtKq/NrBngd3Ze88BTNhHpdw1WBq/eN1zqhlmQTPLF/Y9FuZp8ti2V?=
 =?us-ascii?Q?vfhuFK7/izxYkpCe7rm/1WJ5PV8kHhGqLQoEN7eCGcTLqWTbl2oL4Mdu+byw?=
 =?us-ascii?Q?iMYn4KF/+zLBi0ewpbeprfRWdaJSNHc9gUrout/bKKRNpcdYxax+5vVB6Gya?=
 =?us-ascii?Q?Seqvz5phYT11eUTPPjd0AaquXBpAZKCAtTeX245UGkbCXcFnRujn+aKmKbmT?=
 =?us-ascii?Q?XvcxEF6FrtLXaU6biZK2WUA36plBGoS9HH7Mi0bgfxbBr8SFttFnDsIRTuqq?=
 =?us-ascii?Q?+B+itMB7swY2IryH16fX1NtsVzZsXfCY/SeprtKavWpeQexNpfDYhDAN7sgm?=
 =?us-ascii?Q?hq5+Tf89PiZQIzk5vKT2ybyEj9KkmPBVydWgNsRc5ds2avkKV7f1QsF7nTNh?=
 =?us-ascii?Q?mlMzboqyBnPpMPmz9gmesCnbBmrccbdSpfOenQdRSnIo0KkPicTP1IeRAQrS?=
 =?us-ascii?Q?oGqG1A22edIlTFp+JWKSW4xZgTKEC9p/WhG+mLqNfrvZErdVA3DJAdhk+n5B?=
 =?us-ascii?Q?xzmiSWnxn0p8bIygb3GABfLXrCEH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:27:00.0066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc66831-3f00-4fec-efd2-08dc5dffc029
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

From: Ido Schimmel <idosch@nvidia.com>

The driver queries the Management Capabilities Mask (MCAM) register
during initialization to understand if it can read up to 128 bytes from
transceiver modules.

However, not all firmware versions support this register, leading to the
driver failing to load.

Fix by treating an error in the register query as an indication that the
feature is not supported.

Fixes: 1f4aea1f72da ("mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks")
Reported-by: Tim 'mithro' Ansell <me@mith.ro>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 53b150b7ae4e..5d02b6aef4d2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -1360,17 +1360,15 @@ static struct mlxsw_linecards_event_ops mlxsw_env_event_ops = {
 static int mlxsw_env_max_module_eeprom_len_query(struct mlxsw_env *mlxsw_env)
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
 
-- 
2.43.0


