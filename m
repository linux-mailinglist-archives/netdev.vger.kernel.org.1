Return-Path: <netdev+bounces-86129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C106889DA1E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43791C223A2
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2D12F36B;
	Tue,  9 Apr 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0ICUOxY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128108287F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669124; cv=fail; b=OnifaRFeodWEGzzh7XIiwTBzU4TkIskQX0sT6NeAf9rdXjbD/c023Snjv/McejA5jQPFCbVARNMFrEolmnO8uLM/7oQ3pGZhlR74r2nue8kyEeVd2HPwADGm/5/5IQzkua9NdtNnqzVOkoQOBtS53xyo6KcMfyQQqQrVOBOiAbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669124; c=relaxed/simple;
	bh=7du57CG1z/dyI0Gh3XflJ3rtLuaUfkrP+FgNJjv2lVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6CI0Y04AnEK41FCdzlaLMFYFjN7zEI1pP00sBRNDa5ad3M3o+dSblrb6PEz/YFbF3/L+xkGNVO8dacrzuQAWbTBWyMp/UcTad7OmlVBW7egkKyfqKqEP1E6h/81C+Pa87rKUEi9JolYsliyAgsCQr3+mTSH9rfSQGKv0G1QVnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0ICUOxY; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auHWQMtWWTY/85ufF+8VnPoaemZ2VS5DheoaLhcd+P9hNQnViiXfGwd9mdPu2FNG4NAcJz0d/g0SntQHY7pZd2hWgAXUmD9QHF2tL4DiBbBEkm0gCougrc/x3s8AIFw+io6VzIzDx8xsswtOnvPGiOM2y1HgSYyaEQFO3w+k8geNVoGv6IDTeYU845/4ljLpG/EMUOslGEIOrBtiafXIVKmkl7XxYXBcej1gQqo7h2/pNBXxJ8zbPZgdzdXEJa3V9yBaCohr0WUIGDIpCwS/Wo5ZrcDqZ5VVNHGLMRiRStbskIaTPcgJOPf/uKB9Rj4SkmrVZpXK2J87PvxC9sIRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6lPIMIOD+Ghcm+R1RCEmAeJUXXOtz9eEHYqFDm/WUY=;
 b=ZD6RdM0oZjXiNZ0wLLljb1OSWKNw1UezPRHiox8nBokTNcF8DkgKiOcBsKm8dePOyqn1lLT/Xu9MpCZoVRMXb67cDpgbRq/ifDsDdj35y1McnMuj0++lw8VdgWgC6p+DWiN8YulqZoDSb9mqAN+OFfDLMiBY2quWEsScT4UvwGyy+5WQnZ54IRmSIuWMo50FmSeyFFqJc3fUHMFW+UE29wFHXHTFyVwbkzoeqq/+yXv8H9RrOraJ0G7ByzDXsXKhZ6vB3tv/NEForlpIA+NVskkPWPi444Mk7QJDUwgxB9VusB5fna9QLUvBD2r0GrTxte6xDSJitYtl3MP+192wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6lPIMIOD+Ghcm+R1RCEmAeJUXXOtz9eEHYqFDm/WUY=;
 b=M0ICUOxYl/7m0Ju0HSkINVoSFjcoHqlT9h3yYoOpkEoAHSLI6y7X93CPICztksZBoLecWkcVBUqfT/ApxNi4lEjHKy6fZabAyfCkX1qBdPKxJyPleqCS2RO1Wz8ShEUyiKlRIz+RGruw270bJOyKXRTXNMWqUsKxcoAzn8Op1oD04wECKRpEkNco59Ln3U6DPMG4cGIbKalwotwGcTtSnyO/iOgUITofDxwce5zW8M3Z02Yydp7eNyEmiz4cd/nTDEtABUwPGJQO+/0ovWFunXYSt8dWeNzzLPOG+tGzgKkhcZgw+Jg5RfBmznl2KmFDSJzduPf1mYv+D1QKnk+JZA==
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:25:18 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::fc) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Tue, 9 Apr 2024 13:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 13:25:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 06:25:00 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 06:24:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next] mlxsw: spectrum_ethtool: Add support for 100Gb/s per lane link modes
Date: Tue, 9 Apr 2024 15:22:14 +0200
Message-ID: <1d77830f6abcc4f0d57a7f845e5a6d97a75a434b.1712667750.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 685f7231-9bd0-4748-cce8-08dc58987edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X2Wgn4CeIS8jDJ6YC9uBwJItc7JtT1O/EDAKG54as3szuvzp968c5oGhttET4wUpajXvC8ryr1pike30b0+3oWZOCWy1yerrvLj7mjRs/YzMZ/zZDwUxFbIJXmNAvBPiPQpXDTeQdARWxGepA1VhlWPyDuQ70hYnbQsY3CTjdvTA/QQfsa1dCwFsuO7sB4FCASldMH6vKqTk9++INuHWjjYPDuGm749rQkqFhx80qDomWCz2aMlBxlXGmmZzxfwvzWDFL+v93/qaX+6fzS55/xzPyAMfXlDPwSZCxdElIrezYZ+FXSDMSIn9/V3FW4WnM2S4YbLSfHb5NEKQKwVB4pwwrPcxNAX5keg+YYMqJGYIYAZpTojkQtkJK7vhXkwVlVM3QVoM+ZlB1JZcpXtaVN1dRbxa2d0qmozKdINF2kYU55V94WRQ9a2P/SbaEENk7z+hsBrAiqD8ilqlJHxPBEENSQaHjZIZEwzuvJI3RQhyAODsapFjiUszf9MlkW2XyO03DlqVI0lBkCffzqBW+TwcP+HXzEOJJjSMHu/6kSy/VYzK6t3Os0sKD5YIi1tBfwJ/NQiotN96MDl9b5R32x3zs5yJ6gZjf0uZu/6dnVeA1dOUn+vid2SOUUZElsaE+5BnsE17XWIuHvIDeOQGD/dXMPbs5GXkm4ao1NIPHTDUFu/a+QLTfHpIKiH2v0bP4Q4fpfERrpgKSJHqNxChNJBnuwOQApNg7HmWJa9oWTkuv5iDGkFXkN/bYvggnNKw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:25:16.5074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f7231-9bd0-4748-cce8-08dc58987edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

From: Ido Schimmel <idosch@nvidia.com>

The Spectrum-4 ASIC supports 100Gb/s per lane link modes, but the only
one currently supported by the driver is 800Gb/s over eight lanes.

Add support for 100Gb/s over one lane, 200Gb/s over two lanes and
400Gb/s over four lanes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  3 +
 .../mellanox/mlxsw/spectrum_ethtool.c         | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 8892654c685f..8adf86a6f5cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -4786,8 +4786,11 @@ MLXSW_ITEM32(reg, ptys, an_status, 0x04, 28, 4);
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_50GAUI_1_LAUI_1_50GBASE_CR_KR	BIT(8)
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_CAUI_4_100GBASE_CR4_KR4		BIT(9)
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_100GAUI_2_100GBASE_CR2_KR2		BIT(10)
+#define MLXSW_REG_PTYS_EXT_ETH_SPEED_100GAUI_1_100GBASE_CR_KR		BIT(11)
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_200GAUI_4_200GBASE_CR4_KR4		BIT(12)
+#define MLXSW_REG_PTYS_EXT_ETH_SPEED_200GAUI_2_200GBASE_CR2_KR2		BIT(13)
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_400GAUI_8				BIT(15)
+#define MLXSW_REG_PTYS_EXT_ETH_SPEED_400GAUI_4_400GBASE_CR4_KR4		BIT(16)
 #define MLXSW_REG_PTYS_EXT_ETH_SPEED_800GAUI_8				BIT(19)
 
 /* reg_ptys_ext_eth_proto_cap
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 0f29e9c19411..a755b0a901d3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -1648,6 +1648,18 @@ mlxsw_sp2_mask_ethtool_100gaui_2_100gbase_cr2_kr2[] = {
 #define MLXSW_SP2_MASK_ETHTOOL_100GAUI_2_100GBASE_CR2_KR2_LEN \
 	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_100gaui_2_100gbase_cr2_kr2)
 
+static const enum ethtool_link_mode_bit_indices
+mlxsw_sp2_mask_ethtool_100gaui_1_100gbase_cr_kr[] = {
+	ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseDR_Full_BIT,
+};
+
+#define MLXSW_SP2_MASK_ETHTOOL_100GAUI_1_100GBASE_CR_KR_LEN \
+	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_100gaui_1_100gbase_cr_kr)
+
 static const enum ethtool_link_mode_bit_indices
 mlxsw_sp2_mask_ethtool_200gaui_4_200gbase_cr4_kr4[] = {
 	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
@@ -1660,6 +1672,18 @@ mlxsw_sp2_mask_ethtool_200gaui_4_200gbase_cr4_kr4[] = {
 #define MLXSW_SP2_MASK_ETHTOOL_200GAUI_4_200GBASE_CR4_KR4_LEN \
 	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_200gaui_4_200gbase_cr4_kr4)
 
+static const enum ethtool_link_mode_bit_indices
+mlxsw_sp2_mask_ethtool_200gaui_2_200gbase_cr2_kr2[] = {
+	ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseDR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+};
+
+#define MLXSW_SP2_MASK_ETHTOOL_200GAUI_2_200GBASE_CR2_KR2_LEN \
+	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_200gaui_2_200gbase_cr2_kr2)
+
 static const enum ethtool_link_mode_bit_indices
 mlxsw_sp2_mask_ethtool_400gaui_8[] = {
 	ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
@@ -1672,6 +1696,18 @@ mlxsw_sp2_mask_ethtool_400gaui_8[] = {
 #define MLXSW_SP2_MASK_ETHTOOL_400GAUI_8_LEN \
 	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_400gaui_8)
 
+static const enum ethtool_link_mode_bit_indices
+mlxsw_sp2_mask_ethtool_400gaui_4_400gbase_cr4_kr4[] = {
+	ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT,
+};
+
+#define MLXSW_SP2_MASK_ETHTOOL_400GAUI_4_400GBASE_CR4_KR4_LEN \
+	ARRAY_SIZE(mlxsw_sp2_mask_ethtool_400gaui_4_400gbase_cr4_kr4)
+
 static const enum ethtool_link_mode_bit_indices
 mlxsw_sp2_mask_ethtool_800gaui_8[] = {
 	ETHTOOL_LINK_MODE_800000baseCR8_Full_BIT,
@@ -1816,6 +1852,14 @@ static const struct mlxsw_sp2_port_link_mode mlxsw_sp2_port_link_mode[] = {
 		.speed		= SPEED_100000,
 		.width		= 2,
 	},
+	{
+		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_100GAUI_1_100GBASE_CR_KR,
+		.mask_ethtool	= mlxsw_sp2_mask_ethtool_100gaui_1_100gbase_cr_kr,
+		.m_ethtool_len	= MLXSW_SP2_MASK_ETHTOOL_100GAUI_1_100GBASE_CR_KR_LEN,
+		.mask_sup_width	= MLXSW_SP_PORT_MASK_WIDTH_1X,
+		.speed		= SPEED_100000,
+		.width		= 1,
+	},
 	{
 		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_200GAUI_4_200GBASE_CR4_KR4,
 		.mask_ethtool	= mlxsw_sp2_mask_ethtool_200gaui_4_200gbase_cr4_kr4,
@@ -1825,6 +1869,14 @@ static const struct mlxsw_sp2_port_link_mode mlxsw_sp2_port_link_mode[] = {
 		.speed		= SPEED_200000,
 		.width		= 4,
 	},
+	{
+		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_200GAUI_2_200GBASE_CR2_KR2,
+		.mask_ethtool	= mlxsw_sp2_mask_ethtool_200gaui_2_200gbase_cr2_kr2,
+		.m_ethtool_len	= MLXSW_SP2_MASK_ETHTOOL_200GAUI_2_200GBASE_CR2_KR2_LEN,
+		.mask_sup_width	= MLXSW_SP_PORT_MASK_WIDTH_2X,
+		.speed		= SPEED_200000,
+		.width		= 2,
+	},
 	{
 		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_400GAUI_8,
 		.mask_ethtool	= mlxsw_sp2_mask_ethtool_400gaui_8,
@@ -1833,6 +1885,14 @@ static const struct mlxsw_sp2_port_link_mode mlxsw_sp2_port_link_mode[] = {
 		.speed		= SPEED_400000,
 		.width		= 8,
 	},
+	{
+		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_400GAUI_4_400GBASE_CR4_KR4,
+		.mask_ethtool	= mlxsw_sp2_mask_ethtool_400gaui_4_400gbase_cr4_kr4,
+		.m_ethtool_len	= MLXSW_SP2_MASK_ETHTOOL_400GAUI_4_400GBASE_CR4_KR4_LEN,
+		.mask_sup_width	= MLXSW_SP_PORT_MASK_WIDTH_4X,
+		.speed		= SPEED_400000,
+		.width		= 4,
+	},
 	{
 		.mask		= MLXSW_REG_PTYS_EXT_ETH_SPEED_800GAUI_8,
 		.mask_ethtool	= mlxsw_sp2_mask_ethtool_800gaui_8,
-- 
2.43.0


