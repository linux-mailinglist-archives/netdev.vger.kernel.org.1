Return-Path: <netdev+bounces-169766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A0A45A67
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33BF188FBFD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F8226D07;
	Wed, 26 Feb 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bG1q05N0"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462B1E1E18
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562779; cv=fail; b=PHfAsjoDxaocz80TAZ/SttYvtKpLPt2c3YdW5N5dk4k0IFNNVMcL15VvYQ3a9wmDrxqnYRQ4nEmV2WDkITZF+lY2tjboCiBNkb97qKYvfM3kQ3AQH11IDceYAJhWXebJpBVHlk4+C1WZOZtJSrq3X+MOH9loowhKY/Ipl2voPiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562779; c=relaxed/simple;
	bh=Qa+Lf9Hnga4VmYTTYQ86gyKtW+lYA4zc9blOsEIvD2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB7PjfUZu8uf5TLLs3ircnIeQKD7VcmDGrKY2cCeHdoD9nS8SMQ3NscxXw2aZagXsPNZcHPVjYMs7dwYIm4BZfdRdqcNPCDM1y95UgyMR0Z3sTeLKChn0YDcQBUA+/nlJ60SX8pCGdnBwRaVpd1WOB9FzlYHjERtcZ94binW71k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bG1q05N0; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC7UiG4G1A2WK6P1yT0P7u0ZMxlTS4tpyrqYU0lQQ58/RHmmLBmC7YyPnZ/9ZEx1WHrsMBfM8wkhQAg26zXvAqoyJCDsr1V7A/JF12iOFCouAD8ZBQW3P2M7twEh++41Za1QEfLGV78MOTtRhQcKo6D+sf5HWNtC3/bT+kjAWr8CniENce88sS4S4iL7QDbCm4FLXmkACcE/R1/G8cleLQawtsLd/WA5CITZ2hBYB4SSTHsTsON2yVnDXQpffiloNA3Td5ap7LdLKBpwItZbWDX6GwJv2art78+J1og3K2TQx9MEW2wGaLsy8KkC3pYAZYv9P6qizpiEH/8JgI9wug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dknearg1mJysnVCV/jgPRkX0j2htz0hut7OggUbz4BY=;
 b=TfP7I2IuooE7DwCur7njBnudklhv4/6VPKiu/SHpAAlvsFgNFm0iMYa1JQeeoPjdTFJBAuqkjZJ/oeXRTdTxDT4jJeyHcNZIFZ7VsScffBgSPTLCaKi7OqaV77Jn6aFXZSxXrtPbmfkiQ1xMtc5kjaaFaQEItbIb4c+LuEdXpiB1WfIyBcR8P4or/Se1BWB5/i4KagIzkuccrYGA6dxm4K7IqZeGEQ9V3D0DM4PGnfNvJ0FIlcwrCa2COtiKFnItf9RQ/6pl08RVM5HgSDQaE4J07nfSf02mIOXfDWLa/z2Idd5RwuKs8sq+TTpZwabUDDeg5x3kzZFMDaon6x3wrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dknearg1mJysnVCV/jgPRkX0j2htz0hut7OggUbz4BY=;
 b=bG1q05N00Orm4LTMWKzftJfaP+IJq7vqpPVpYhUKgCkI//shLms02XKRyj2RO4IpzxO0OLYvA/UGkmGVhzob58Gc3s2Phsnwr7PwUErrmUv1n4eRe4Wf6N4n4r77EMOU1eV3qmWUPuwkZbNHomEcEQCUnuAi6K+p7yWsnLApgB3wJbpNUi1BHyxpEiKBt+EdldQjs4iQ8Z9B/jYVVile2GKl2nLrULRP/sXjaPvmOTrX/Gpqoyop22fcyhwBh42/8kms8OKme/HzxZZUWeOISvlj1DoEL8ZyL3uCYj8NmtlWsUAXQCWb/tkNXHKmqg8pe5+THxRCi0Zmq7vWHDqEXg==
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 09:39:31 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6c) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 09:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:39:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:21 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:17 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: Remove newline at the end of a netlink error message
Date: Wed, 26 Feb 2025 11:39:01 +0200
Message-ID: <20250226093904.6632-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
References: <20250226093904.6632-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef345c2-9b02-46bc-8797-08dd56497838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xxSJ4Bgla7VWC9CyKHzqLKMhm1sdziB+98deCmkSy/l44qsvUqyHEENKKfle?=
 =?us-ascii?Q?KsAK8D0GM9xB2wHePlKcxSC9t9nQ3CZLOvf1f+di+lcMxchPyr1l1ye9TbGI?=
 =?us-ascii?Q?/z0D4Ygyv4LuTSdrp8DlHJuTDDJ8CzkxVP7WNJJCnmpL+/5F90YYk83G49Md?=
 =?us-ascii?Q?ZqAPkPVQqxsGSRtGNk/OZ05OAwteg8MHMBOSQYwq+i3TljuzaOJA1VlpnwXr?=
 =?us-ascii?Q?wRi9fEdmoneVczcYkarM/bc7TQVVCa66eYVtPJknXnlTYGV7EXD1Krdu3qaY?=
 =?us-ascii?Q?mQql+AE5KekMvPsLAURf8yEoig5xjmxOQiFGaLTicjFhH2Mx+5xPc8n9YBn6?=
 =?us-ascii?Q?2zkyKAS0E6Y2wpJhhPEHaQ/7GGHvngf3lA5NM2whCJmWyG3k4eON8B4w3BZR?=
 =?us-ascii?Q?xaOI9DOfenLGOZo7zQflL0vIyMQdRMU+WpD49bjMBlbgMCIDqyfVSZbZ+UXJ?=
 =?us-ascii?Q?1G2UuQj5mBsA6kXtM+X7g1+ZG0ezp1fwJmLduGtRM2exi61IuLozXeG8tp2n?=
 =?us-ascii?Q?CYe88mMjyxKWtnEVW/LLCMluks2QaFoQZ8/cH/Xlgss94GuyzpMPHPazOxCQ?=
 =?us-ascii?Q?iwQcicQzZW4NxbvfEQWgTn3CMezn4RjpxoV8MXN65dlubqYiYMKHmtYJuOBI?=
 =?us-ascii?Q?D2o4FiufeVyyQgq0YpIyWjkoDJfN67B0Ik5gwgqqnn7/Myw526i0QnT7ro/4?=
 =?us-ascii?Q?NM1aRZyipwa3uBZs4KZ8RNVqbTGB9/4t5shVVB2W/f77Nn4eDpUgEF59b/eY?=
 =?us-ascii?Q?VuTKAGwlPZcSUNL76s/xfBwZVevofSUlmTz2SrHhRQdLPgRMKP6KRudMvDOS?=
 =?us-ascii?Q?yQ37NP6pv2Xrw6JWstH9qAzIBteYNXEvhAwkBoOXa74ksILrWv74sOjPsabs?=
 =?us-ascii?Q?qFrINvri3si65Z767tDTO8OmsRC3/9aTq/7QWDk4MdQCVDsRbTA1G95dH4fl?=
 =?us-ascii?Q?2erm4oRZ1xC6e7+z/yAAsffAAwVZYOOOHAiQsZLyCknI8g0IILHK3lBHgx67?=
 =?us-ascii?Q?16Mt/eQfc35ypbQwNqEoWSERrbo2crG4KaiZZ1N7IUhQlOyqx0cIIfxsTzAx?=
 =?us-ascii?Q?BW+xUQGxSDnHE1J5NPgWspm7SWfLl3erZQ4OqOUDva9yKHpgcudLdeUgFDZZ?=
 =?us-ascii?Q?tja4nmckcNYExNwhcBeNQvdmIrM7wSsB10u19nPF5i4msgyz2kxEWqD86oxn?=
 =?us-ascii?Q?MepMuQ9CK65gY79v1YM3hcl2T6WSrMH2QyH0DPpoCH9pBsV37//aVCiKJxv5?=
 =?us-ascii?Q?eea8zYS+kVfVXTt8zqoGP7rK/9gRe7SJzwCMWtLBUmh6E2nx32Nq5nZ3HJDT?=
 =?us-ascii?Q?EjS8czqO+94jhPVqlcpzAm5pG9FVTOgsW9QFLIWKY06SUQO0DWAcAjQ3qC0v?=
 =?us-ascii?Q?oW3lJJ/GD4R50nrEnGpwjRN/7qQA2vbbPwuhGEUHr5yYd/3pLhp2YCXZu12N?=
 =?us-ascii?Q?GSFFevMrK9ttClk4p4cxHRuJOamp8YetZx9TBZxq/PZppPdmOHzz/+wQCe2t?=
 =?us-ascii?Q?uOg7Zz38gEC4QbI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:30.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef345c2-9b02-46bc-8797-08dd56497838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

Netlink error messages should not have a newline at the end of the
string.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c            | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 31142f6cc372..1e5522a19483 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -242,7 +242,7 @@ static int mlx5_dpll_clock_quality_level_get(const struct dpll_device *dpll,
 		return 0;
 	}
 errout:
-	NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from firmware\n");
+	NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from firmware");
 	return -EINVAL;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index e4e487c8431b..5c762a71818d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -140,7 +140,7 @@ static int mlx5e_tc_tun_parse_vxlan_gbp_option(struct mlx5e_priv *priv,
 	gbp_mask = (u32 *)&enc_opts.mask->data[0];
 
 	if (*gbp_mask & ~VXLAN_GBP_MASK) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Wrong VxLAN GBP mask(0x%08X)\n", *gbp_mask);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Wrong VxLAN GBP mask(0x%08X)", *gbp_mask);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index f9113cb13a0c..a4b2e57b3f80 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2040,7 +2040,7 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (size_read < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(
 				extack,
-				"Query module eeprom by page failed, read %u bytes, err %d\n",
+				"Query module eeprom by page failed, read %u bytes, err %d",
 				i, size_read);
 			return i;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 5f647358a05c..76e35c827da0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1863,7 +1863,7 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 			 "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)\n",
 			 addr, vport_num);
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)\n",
+				       "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)",
 				       addr, vport_num);
 		return -EINVAL;
 	}
@@ -1876,7 +1876,7 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 				 "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
 				 addr, vid, vport_num);
 			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)\n",
+					       "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)",
 					       addr, vid, vport_num);
 			return -EINVAL;
 		}
@@ -1884,7 +1884,7 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 
 	err = mlx5_esw_bridge_port_mdb_attach(dev, port, addr, vid);
 	if (err) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to add MDB (MAC=%pM,vid=%u,vport=%u)\n",
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to add MDB (MAC=%pM,vid=%u,vport=%u)",
 				       addr, vid, vport_num);
 		return err;
 	}
-- 
2.40.1


