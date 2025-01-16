Return-Path: <netdev+bounces-158959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EACA13F99
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC833A97AA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB722CA0D;
	Thu, 16 Jan 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WpQXK9VE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2122C9FB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045570; cv=fail; b=fIhLjGAfLcZYYoJ9FowFf6B9hFG6odwfa7loRhigdyZtV+d7Bz4m3BqGnsU9SzwXJxn/FUHQku0a3bD36dUYhGeN5CFoovlfBtQjdmvaZ+VMH+HJvpbi/VpIw/IXLEYPtnVPS9g88WRPn9QoS2R0pK0cnB17FhDtZUs10TmFhTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045570; c=relaxed/simple;
	bh=rmnuuN+7O7+kHtJnBgvz9vIKdQw/P8UIOKyTuVSxjGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEFExpiRq2/94rfzer7BnA3lZiAU4qGsLiGtDfhFsTegWHhGn3XAt5Yfp33bc4sHwVeqRXsYBfh+/fRiUNYWctEYy7CxkD803E3mN6tbMfKanjlIhCZVsnN65TVwaUL8uDy1+NKvEfNv/Vpj7jp3c+ONnYKW2LjQYUxs6k+E+n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WpQXK9VE; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsPNoGDFOBVDo80/DAFkqQ4aarCw7282nJ0UUzdTtSG9/NGDMJG9GKkQBEMhd0MpuX/IiUsmt5BHAu5A1doJRoBmyHGqinyAYN5FvFCiYGKUxWUvUH2OE3SkGVz/2FqiXQmASLC5diEHrabKBFGvDzO6s7HRN3kaCdj0+GEeyazdruByd93Udkn39Z4T+fFkLbpE8Xo4Ih4SSx7wVzPOtbvB6hbBPlC9v9i0RIO/ZP9StKj6Mpmxe0N78BWd204krkZrRYkl6T11f1dt3XYhkomRlc82G//9MV/EJuMWEu1VNdfoinwOc2ZJracgLvgnTy6Fdq/6V2qOyEBUk1wd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bqggJNhszsBoFjpfC3eZGxfa/rQOmbHWIF2qrttebU=;
 b=kTbCc/7UGwWykw5pdzpBnYSWo2RCvXZO0I80cXn/kiwihI6ynTs1/tUExEtchiJjGDDzhaubY4ymz3XZc2rsDckvmT8P3ZFiPyu0REJr3ZdbC5jIQvV4MGw04fnNT3QvBCgKYgulnRl/dUQHaa0kUT5dZGLYAu+TKMPxShvjtNbpl+EdsQ6hcpCUsaFagTbsc8pscBYP1CizelHumuWBR/jUp703+iG+Z3sqCkBdhvQKy16cRWNvxcwbALh1pa7M3GuYZnKA2IwGOWZ2IguLYsyasz3YhxCKleWMXKxtBd7P24PS9zKS6IhxW2QdzQn4DSY+5ecYH2Lp1MSyas0ApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bqggJNhszsBoFjpfC3eZGxfa/rQOmbHWIF2qrttebU=;
 b=WpQXK9VE0bk1+e8yr8Ur99BNCxEXA+C7KMya7D5byFj+p+0Rj2LSqFwssiK4+iuA8M6tBgkG15ZgG+yfFs6gQ+j7xB5IErNE+bBtAjQrFCQNLJvyrI1ruz3Zwcw8pHibt62zpYT46ox6yuVMJuu78bJOMiMniIuYaEOnKmCfovm0E891ylcO+/oVU1Oq/tF6kThtG+lftEXV9Jk+Vs52areZAeWwQbFR3Ln966yM3UAtXfNCxAcK3Inq81bJnoBsvU5McjzL4za5FJtB9ucRyNiZCc285YqbIQrjiZHvpnzqtUt2U+oz0OovixgqVoKZPVb37H1rBRFkmnowbRJBrQ==
Received: from BL6PEPF00016416.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:4) by IA1PR12MB9061.namprd12.prod.outlook.com
 (2603:10b6:208:3ab::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 16:39:23 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2a01:111:f403:c803::1) by BL6PEPF00016416.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Thu,
 16 Jan 2025 16:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Thu, 16 Jan 2025 16:39:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:03 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:38:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 1/5] mlxsw: Add mlxsw_txhdr_info structure
Date: Thu, 16 Jan 2025 17:38:14 +0100
Message-ID: <93aed1961f046f79f46869bab37a3faa5027751d.1737044384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
References: <cover.1737044384.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca562c7-bb5e-4909-88c8-08dd364c5531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zCv5Hkgr0DfGF8xYhPPQiAjRsY8jl8t8IxpPguBpurHO6yGkivIUeLlLzSjp?=
 =?us-ascii?Q?tJAes7VFzCjJO121RHnLBuItUjddktC+cp8/eFv8mxf7RrS4zO50X6eJ08k+?=
 =?us-ascii?Q?J9GyXAu57bUFXCxEuC3axC2Vp67L2eP/SmVl01bRCbUFU2ieTxjMtLVXtKj1?=
 =?us-ascii?Q?dT24a3YMIKmFvye+VPE8tfYRVPQG5Ijtsd0MMMCaWkNyx9/786kio7LhJbrm?=
 =?us-ascii?Q?UNIh4/6r7/1uh0y4EzjWy6LpwCQsfCV6pGz/QquJgSB/DGHfjbrIL5DMaHA8?=
 =?us-ascii?Q?tg39NZDYX6jJxrqCPK96NxCFNcDaJKQdzPkaNCT1lb8SPrubbgbWbZuSApIq?=
 =?us-ascii?Q?WKIff605/TolFTibor7qHESKfEnptl7BjC+0UUoUnye+Tiod9xi0mI8HesH6?=
 =?us-ascii?Q?FAvEPWU/m/yn17dcfef+eO/T2BZCZZUYNMnF6xC3qkRnNy/WD551WMCmijA5?=
 =?us-ascii?Q?Ws+2ZLucZmqTvVHbcroHinO7RqczKdPrYC24mxwP26h+1b5McGRdzH1b2QqX?=
 =?us-ascii?Q?BrazF4K1ANc/EpyDErLT/BWiydVZoe9h1V0yVPO/nHRmJkdsvOJjWTSOvnzu?=
 =?us-ascii?Q?/6hop/dtmJKoFHNH+53Tq2ZjL7wKSrad2pT+QLcPDXbGk8AT4h3YHQM8NYvw?=
 =?us-ascii?Q?yyeW8tTSNdjnNr3Y7Lpbb7wf1shGhiIdQ8loMwB+UODZ1XTl8uqJykaQZ252?=
 =?us-ascii?Q?pdZ3lPG5NbhM4mI9yXTeXmn+y/pVBVdag4IF6qfvxnPskXmoV29OEOSxYPLz?=
 =?us-ascii?Q?HgvEppZIEyD92Oy0oZ2cXGpoGl/VYQaHACvxbHzD4/OYsA9GPN/HHTH1K8IA?=
 =?us-ascii?Q?2ATmmGesoR9cnpxDy+GCHGxr5drpADPz7E4jAfcoUQBJhVjfW8en2SAsraCc?=
 =?us-ascii?Q?ENZ3+fUWSb+vdjksd8klIcLIV01RhD97xhUsGuwKW+Tc8rvfGXWHl+wnVAWW?=
 =?us-ascii?Q?Z4xKkQotb8g1puJA8k++Vd9psMbFkD/hS4qPu61vOTOzNsjnxIHxlVIAnX+o?=
 =?us-ascii?Q?6z/d3XHn3kZVE9ztv3pHKgMie/emzKI8xgSTfbehrnz6juWMvCIbZf4jw4+R?=
 =?us-ascii?Q?8n/UJNgu92kH4AA5IbH+P0vEzl6oW7YKEWWeZuqePY4tNAMzzI4KhDHNpC4R?=
 =?us-ascii?Q?G7VI+DqmS63b6pCucU3oHMD1drfLUtWLox/gVpfMdQ8gmO9DGBucNXjdYFV7?=
 =?us-ascii?Q?x9+XX80Eye3rWsiWNV5JLgxdKnRkZFQC80kU1pgpz8qVTqaGwX+BEOQbvko6?=
 =?us-ascii?Q?KbKz9HrgE+hro2gJH736k8jobkWRsrNL8yXhb2R5+tkWsjO6SqtjkdpH66ut?=
 =?us-ascii?Q?x1UTSJGBOu/uxs4nwLV6dRVxN1ZBDuc5yKWJVTpUGFOUdWdjZ7mAUuZjEs6V?=
 =?us-ascii?Q?kDFJDLXXzjIp39dlO8t25Lb/Sj/3BPGP2yGN4Anau1TeO2pcU0xeF2hTZ3cQ?=
 =?us-ascii?Q?lQ/JYSiYZyvplVxITyfmUYBgkcXZQPse3v9jUVeApIwfe5JIFqFPi2+tMD7G?=
 =?us-ascii?Q?voC4EtZFexIB07s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:22.9171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca562c7-bb5e-4909-88c8-08dd364c5531
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

From: Amit Cohen <amcohen@nvidia.com>

mlxsw_tx_info structure is used to store information that is needed to
process Tx completions when Tx time stamps are requested. A next patch
will move Tx header handling from spectrum.c to pci.c. For that, some
additional fields which are related to Tx should be passed to pci driver.

As preparation, create an extended structure, called mlxsw_txhdr_info,
and store mlxsw_tx_info inside. The new fields should not be added to
mlxsw_tx_info structure as it is stored in the SKB control block which is
of limited size.

The next patch will extend the new structure with some fields which are
needed in order to construct Tx header.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c     | 14 +++++++-------
 drivers/net/ethernet/mellanox/mlxsw/core.h     |  8 ++++++--
 drivers/net/ethernet/mellanox/mlxsw/i2c.c      |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c      |  6 +++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 ++++++------
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 4a79c0d7e7ad..a3c032da4b4b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -677,7 +677,7 @@ struct mlxsw_reg_trans {
 	struct list_head bulk_list;
 	struct mlxsw_core *core;
 	struct sk_buff *tx_skb;
-	struct mlxsw_tx_info tx_info;
+	struct mlxsw_txhdr_info txhdr_info;
 	struct delayed_work timeout_dw;
 	unsigned int retries;
 	u64 tid;
@@ -742,7 +742,7 @@ static int mlxsw_emad_transmit(struct mlxsw_core *mlxsw_core,
 			    skb->len - mlxsw_core->driver->txhdr_len);
 
 	atomic_set(&trans->active, 1);
-	err = mlxsw_core_skb_transmit(mlxsw_core, skb, &trans->tx_info);
+	err = mlxsw_core_skb_transmit(mlxsw_core, skb, &trans->txhdr_info);
 	if (err) {
 		dev_kfree_skb(skb);
 		return err;
@@ -984,8 +984,8 @@ static int mlxsw_emad_reg_access(struct mlxsw_core *mlxsw_core,
 	list_add_tail(&trans->bulk_list, bulk_list);
 	trans->core = mlxsw_core;
 	trans->tx_skb = skb;
-	trans->tx_info.local_port = MLXSW_PORT_CPU_PORT;
-	trans->tx_info.is_emad = true;
+	trans->txhdr_info.tx_info.local_port = MLXSW_PORT_CPU_PORT;
+	trans->txhdr_info.tx_info.is_emad = true;
 	INIT_DELAYED_WORK(&trans->timeout_dw, mlxsw_emad_trans_timeout_work);
 	trans->tid = tid;
 	init_completion(&trans->completion);
@@ -995,7 +995,7 @@ static int mlxsw_emad_reg_access(struct mlxsw_core *mlxsw_core,
 	trans->type = type;
 
 	mlxsw_emad_construct(mlxsw_core, skb, reg, payload, type, trans->tid);
-	mlxsw_core->driver->txhdr_construct(skb, &trans->tx_info);
+	mlxsw_core->driver->txhdr_construct(skb, &trans->txhdr_info.tx_info);
 
 	spin_lock_bh(&mlxsw_core->emad.trans_list_lock);
 	list_add_tail_rcu(&trans->list, &mlxsw_core->emad.trans_list);
@@ -2330,10 +2330,10 @@ bool mlxsw_core_skb_transmit_busy(struct mlxsw_core *mlxsw_core,
 EXPORT_SYMBOL(mlxsw_core_skb_transmit_busy);
 
 int mlxsw_core_skb_transmit(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
-			    const struct mlxsw_tx_info *tx_info)
+			    const struct mlxsw_txhdr_info *txhdr_info)
 {
 	return mlxsw_core->bus->skb_transmit(mlxsw_core->bus_priv, skb,
-					     tx_info);
+					     txhdr_info);
 }
 EXPORT_SYMBOL(mlxsw_core_skb_transmit);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 24c3ff6fcf71..cd33ceb2154b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -72,6 +72,10 @@ struct mlxsw_tx_info {
 	bool is_emad;
 };
 
+struct mlxsw_txhdr_info {
+	struct mlxsw_tx_info tx_info;
+};
+
 struct mlxsw_rx_md_info {
 	struct napi_struct *napi;
 	u32 cookie_index;
@@ -95,7 +99,7 @@ struct mlxsw_rx_md_info {
 bool mlxsw_core_skb_transmit_busy(struct mlxsw_core *mlxsw_core,
 				  const struct mlxsw_tx_info *tx_info);
 int mlxsw_core_skb_transmit(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
-			    const struct mlxsw_tx_info *tx_info);
+			    const struct mlxsw_txhdr_info *txhdr_info);
 void mlxsw_core_ptp_transmitted(struct mlxsw_core *mlxsw_core,
 				struct sk_buff *skb, u16 local_port);
 
@@ -487,7 +491,7 @@ struct mlxsw_bus {
 	bool (*skb_transmit_busy)(void *bus_priv,
 				  const struct mlxsw_tx_info *tx_info);
 	int (*skb_transmit)(void *bus_priv, struct sk_buff *skb,
-			    const struct mlxsw_tx_info *tx_info);
+			    const struct mlxsw_txhdr_info *txhdr_info);
 	int (*cmd_exec)(void *bus_priv, u16 opcode, u8 opcode_mod,
 			u32 in_mod, bool out_mbox_direct,
 			char *in_mbox, size_t in_mbox_size,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 1e150ce1c73a..f9f565c1036d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -516,7 +516,7 @@ static bool mlxsw_i2c_skb_transmit_busy(void *bus_priv,
 }
 
 static int mlxsw_i2c_skb_transmit(void *bus_priv, struct sk_buff *skb,
-				  const struct mlxsw_tx_info *tx_info)
+				  const struct mlxsw_txhdr_info *txhdr_info)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0863dca2fc0b..e8e0a06cd4e0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2122,7 +2122,7 @@ static bool mlxsw_pci_skb_transmit_busy(void *bus_priv,
 }
 
 static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
-				  const struct mlxsw_tx_info *tx_info)
+				  const struct mlxsw_txhdr_info *txhdr_info)
 {
 	struct mlxsw_pci *mlxsw_pci = bus_priv;
 	struct mlxsw_pci_queue *q;
@@ -2137,7 +2137,7 @@ static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
 			return err;
 	}
 
-	q = mlxsw_pci_sdq_pick(mlxsw_pci, tx_info);
+	q = mlxsw_pci_sdq_pick(mlxsw_pci, &txhdr_info->tx_info);
 	spin_lock_bh(&q->lock);
 	elem_info = mlxsw_pci_queue_elem_info_producer_get(q);
 	if (!elem_info) {
@@ -2145,7 +2145,7 @@ static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
 		err = -EAGAIN;
 		goto unlock;
 	}
-	mlxsw_skb_cb(skb)->tx_info = *tx_info;
+	mlxsw_skb_cb(skb)->tx_info = txhdr_info->tx_info;
 	elem_info->sdq.skb = skb;
 
 	wqe = elem_info->elem;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index aa71993daf28..3bd6230307aa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -721,16 +721,16 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	struct mlxsw_sp_port_pcpu_stats *pcpu_stats;
-	const struct mlxsw_tx_info tx_info = {
-		.local_port = mlxsw_sp_port->local_port,
-		.is_emad = false,
+	const struct mlxsw_txhdr_info txhdr_info = {
+		.tx_info.local_port = mlxsw_sp_port->local_port,
+		.tx_info.is_emad = false,
 	};
 	u64 len;
 	int err;
 
 	memset(skb->cb, 0, sizeof(struct mlxsw_skb_cb));
 
-	if (mlxsw_core_skb_transmit_busy(mlxsw_sp->core, &tx_info))
+	if (mlxsw_core_skb_transmit_busy(mlxsw_sp->core, &txhdr_info.tx_info))
 		return NETDEV_TX_BUSY;
 
 	if (eth_skb_pad(skb)) {
@@ -739,7 +739,7 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 	}
 
 	err = mlxsw_sp_txhdr_handle(mlxsw_sp->core, mlxsw_sp_port, skb,
-				    &tx_info);
+				    &txhdr_info.tx_info);
 	if (err)
 		return NETDEV_TX_OK;
 
@@ -751,7 +751,7 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 	/* Due to a race we might fail here because of a full queue. In that
 	 * unlikely case we simply drop the packet.
 	 */
-	err = mlxsw_core_skb_transmit(mlxsw_sp->core, skb, &tx_info);
+	err = mlxsw_core_skb_transmit(mlxsw_sp->core, skb, &txhdr_info);
 
 	if (!err) {
 		pcpu_stats = this_cpu_ptr(mlxsw_sp_port->pcpu_stats);
-- 
2.47.0


