Return-Path: <netdev+bounces-116893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7194C019
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29451F295B4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F321946C4;
	Thu,  8 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZtYl638M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EC192B88
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128187; cv=fail; b=Ol+4kOwQZU3XJKHtC85s+JdcnPC+1YnbIhQI54GjzuFn3YmeYSplSZNUEKogNvdk/PfhWPEVaERbmPLiEHibqyR3l9btl2pZ2K8jxJ01KdRhjo7vnseCU4xOYrysAtkvvrS7jpaFVuFEvUsG9Jp2D0rJBATikOuwiuGQcw6zMng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128187; c=relaxed/simple;
	bh=O/m8DLggWxmAI03LBnxQHMVn6+YWlsrL6XHGGKV5XZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPkMa8qp5LmAbO00ZhseYtbBnuH4aUFEexqfPeV43Crzyj5qMhQocb95G8S9vYZnMQoKITOEqujpgchv2s5VMJvOjkb+p+572GhGcdYNprmhzXE3tCTZqBLxs1AER3563Dzp3t4dxenk52dVdAYazA7NHe5jpLQBNEI6YCbePN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZtYl638M; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFIGGBdU8U9D3iCtnz6zPqUTgEDF7c0GFxWQoqUTcY20LKIgQ3nRK0bd9uWkdb83m8AXjzqLXDscg2C7/FFisjrkwZnrB1Nq05+MfKPqUVtYbHd0gjzTB8Khzf5lEFbeUp1KhGhSPLIru4H4P3AHVinbhDhv8IWUjpjNYGNXmWpdJ/IuEFjPOsbIBTl8fpXefdqva4tCIhpVYmrV9fuJ4BU6j4o6IWG6wDQ22kM+9C/JfgUAxKtkK7LXZYHcXJXVB1Aa0umYcNH6iwC/0Lx4tLlmBUElFNNKDAQIX5oR3UQP2351IlIko7k75bSf47aivxY3NEp2NhJBPPMIdUlDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLwqTrHQp2mS/sPXh4ERiT8QDwikrBsGaKWXWUVchbU=;
 b=kfrOECeA3NpYi2NKsEaTZQQE4Oo7E/pL58gO2NAjo8p0M0hwlLWQ/kVFbIoA6ArlqXtR/mJLoBhantKTxBqx8MGLyiSrnj0+KPI006uO8VWsT1CxFJSpXVNOO/NGm0jDWJuWT5rEMi0/nj3agHiVLRjipCXsOBkMoiNa4KyXUuMISNM2NQK/0CWhHYzyLwEyWyd16eto/IqYTFGuX9baGAJVyhtpVxxs3Ple69F4eObqRX+7fcTDdGbwTieLwLZTEO+bYfl/OefzBQHZNnYR4A4jr9Dpe0qEcCQ0ipUnTVL4zXN7UUmzk8PhCQFs1Zu4AQyUOs9k6PfbtkgIlgj1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLwqTrHQp2mS/sPXh4ERiT8QDwikrBsGaKWXWUVchbU=;
 b=ZtYl638M8D053h86O0koKrY0394r+saUtwoNn9ljNZxyMF418LprHAYe/L43EntctHltvLTPikn5sxFJV1bP1Ux6LPqBiY48+h34WUfbFhU+v9la4psHAa/mU9IcxvC2K/K3sS3mVMOjj6bUEAgrmYHDI3XP5vvwJY/MBv3ZWccOyivfhSrxB5S51Jw8A1JQHSn2KeUq/pP5yeUi1JKgvtdFbxuiQjctpc54FY+6UJXHI2AGOjAA+w07VP+Yr3yjHb4hXieD789fKGrNUaAEmQrVuamzNx4sw/G4G4L7fjEtkdV7VyF/PNAQRg1p17PWmU6UZKut0iY4iH6zoNfNSQ==
Received: from CH2PR18CA0052.namprd18.prod.outlook.com (2603:10b6:610:55::32)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 14:43:01 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::25) by CH2PR18CA0052.outlook.office365.com
 (2603:10b6:610:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 14:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:43:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Breno Leitao <leitao@debian.org>, Moshe Shemesh
	<moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5e: Take state lock during tx timeout reporter
Date: Thu, 8 Aug 2024 17:41:04 +0300
Message-ID: <20240808144107.2095424-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dda196-1483-4304-bc8e-08dcb7b8675f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yB3xuxKYfJ/3ufJgXYtTjxvlda/uaVNnep9JRzgSvGq/A0Yt63d3yP2C/He?=
 =?us-ascii?Q?fsT/g1Mv1PIadj6iH2+xeeMIJmrT16RtSL0XOIyFNIjpIAfknzcDlPlC3VJ/?=
 =?us-ascii?Q?LnKLlNSQ9jiIBuznw31g4B1uNH7btY1ab67OSL/+7UDwDrg0v7VJ/jsW38dO?=
 =?us-ascii?Q?8XtblIrliV8f+ZZUskh9TCuMcKyHydIJOvKlVSGmYUCvGeZUWXtojJ06XlBW?=
 =?us-ascii?Q?5J8IjMhPTS6Wv4d/+U8Nud5QS96eYi1e69cHrsRujyGxe2R4b+f1R20BPTaD?=
 =?us-ascii?Q?Q55XRYSmbrroTIEFANutjkcgY9+XR6DtMuTXTX4VFgJJPN8jhI7CHDpqG8wQ?=
 =?us-ascii?Q?Wkfc0WNC8HW1OVXm9EkIjOcdTmCqx9e7iJpdRs/9EJSZczsHTG2+5H6BwLKA?=
 =?us-ascii?Q?GceMf6D7c2yuM8JQDNCBZPqmt6Bh1hqbXWeXG4oz9iXqa4OcEC8NgMfBDbVI?=
 =?us-ascii?Q?VdpO/b7CXOXckHbv0aqfGv0cRM1qATbb/BgBhr/3LyI/D39zqD58fTKXn+ZQ?=
 =?us-ascii?Q?Ka0Dvz+sue+KQt3iOeOtgfeLpYajFEHX6SWt3XUrEEZny3oCo7eiLOyLXr+H?=
 =?us-ascii?Q?WiMkts6Oa42LqVt5kAcRhyUQiog/JeY/HCCO1nPTkPoKS+b5GqKU2M/3teO4?=
 =?us-ascii?Q?jNWusVKVbmWsIlWznA08JXtaFQ2gfIE9FmPWln+ei02M+1yiQElAbWWSwiF+?=
 =?us-ascii?Q?thLlLohpLkacP9kaSYLHzITCbHK1wJccj3tbbxJZxR/LEepPIRKIGt0Q5rtG?=
 =?us-ascii?Q?aJSP/AfjCx/sVA47uI1Lb8N9v/JtfQujYgC0xQ5J+wJtTYDbiayJUnOaGvyQ?=
 =?us-ascii?Q?TPg3JYZT69MoD6BLNUD5DgfPlCXm7dVNSqnxvBNeoTxEAjzDyD3f7LUEuNDi?=
 =?us-ascii?Q?NV2NhBxgByLd62P678DcmT/xd/gL+knJTV69rwKosdgtjKUS8jDPaocD/CKr?=
 =?us-ascii?Q?TWgg2wUUVvcy9ISMuNcYfbxC4PJO0OS7S6r99GrAPWvqNWNS00xxHg3hOlrj?=
 =?us-ascii?Q?lfiErLEvUzSjqePIGAeUdCZoAAHr5As4ngVdD50SwgIL3Oi73AoIlms/cKWN?=
 =?us-ascii?Q?6WobmLp+etv/Y3xwLTWNcVrETMd6A0qaijrvJGwVV/SB3T7is2rCBLv1Ebe7?=
 =?us-ascii?Q?hqgiO/l2wpnsZVRTmUWVzqta9xWKERcreZzHSWOpdzJcHSP8Od264Nt3Xb4P?=
 =?us-ascii?Q?C5R+aSo5JGUtJW5TOVujw/mLsJw6mnHPXPGBQMK95ZVdXl2SWeZuLv4ZLYuK?=
 =?us-ascii?Q?UxSWmbzLqT8FOytz7V5JaMZvUUyq3DshMimAYL6RUcVNIjh3Cv+zLhG7QFWO?=
 =?us-ascii?Q?V2bDx74vcluEBCehA+MXd95ZDh9AXt3w2TO5VPxVR7xUB0SHara6oSkkj+JH?=
 =?us-ascii?Q?cSjV2Hyg0sr0SPcJcqoz2J4+ea5Rvs6jPp8Cjl790RtcQeo7tdCdosPfG2hL?=
 =?us-ascii?Q?o/G/4f/N9nUTudihEB6OB7MHV42PBDyX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:43:01.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dda196-1483-4304-bc8e-08dcb7b8675f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5e_safe_reopen_channels() requires the state lock taken. The
referenced changed in the Fixes tag removed the lock to fix another
issue. This patch adds it back but at a later point (when calling
mlx5e_safe_reopen_channels()) to avoid the deadlock referenced in the
Fixes tag.

Fixes: eab0da38912e ("net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Link: https://lore.kernel.org/all/ZplpKq8FKi3vwfxv@gmail.com/T/
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 22918b2ef7f1..09433b91be17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -146,7 +146,9 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 		return err;
 	}
 
+	mutex_lock(&priv->state_lock);
 	err = mlx5e_safe_reopen_channels(priv);
+	mutex_unlock(&priv->state_lock);
 	if (!err) {
 		to_ctx->status = 1; /* all channels recovered */
 		return err;
-- 
2.44.0


