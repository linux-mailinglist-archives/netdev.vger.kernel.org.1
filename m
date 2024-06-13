Return-Path: <netdev+bounces-103249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5D9074BC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B7A1C22E14
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256F146010;
	Thu, 13 Jun 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NC8OD2El"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D313145FE0
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287873; cv=fail; b=YbFZOj7QgBKRUfBHScJw20fh8e10BfcrikBwR7w0AQPiHt3zqj1hh1P9EEpkrEaIs8qIYPCtE0DUaBILOtm9wkkiluxRXhrmUWIJxthfIiYo3LI4RY1zuPjgchwarx7mPDVZfnaoEpFSOGL6jvMlZUfmj2/gnmKVdJheSAN9Uv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287873; c=relaxed/simple;
	bh=LiCIDa9N8NDL0LHjcj4p3dKDPG7IAl31nctTn6gval0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6E+kfdss3lDOjND72C/tbCeJibZhMKP0IOmrllHWhkVY5kNnEiLX6D4V+5fgZmd3uwI/6kxh51wPtbrR57K3hDS2W75JF3cXnq2AMwVRALMjpDFEPVomCuRnQAZ8EMSKmfyFJpdzoy9wgDHcKBukHfSFl3OX8i5h0DLgw+seqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NC8OD2El; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adJevBcRWjSSxfEIBuGpX8k6bEnIVfT0fRXzMcocfOaXq+0Gh2mrggHAyxf9sAQWBEH4L6nnX1dDLNWqx+gnrymt0M81FCYW4vR7n7LoT0VsLOCXxOT2D3axmf9NbaaMx86neuI1AhTzICl6+uduSRk2uD2yIyYlxkiF1DkbwHmc3cLpCBlHiWfuTDRN+DVAA7EPPVPZLtPzIZBGTTQeWYQSuczrVYZoOP/5P1o71Z0/zN8h10HDqeZ68lcj4MUqK5K3FFxH5qciU3Ds8saEgAQnssenLJxz0yZ37qPMamrP8bjOAl6M3HW95jiNemWzbYiIPBcGZ52HU1DLBcSJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X//eGTqPR6GX6clhYfoJGDd2v7be7vmMt7zU69UYhG8=;
 b=dc8fLzvlN59BUi7oBJtUT0o7CcNKSGhK7JqzPYsO5z62HnFqtc/leOIhFLwm7qQZk4AsnE2kfVj+PxNFBQlFYzVm9Ewxf6Ur3wH4XwlRLunvWy7J/5VC2h0ckwHirScPKUTt0ZtaMRHaOsIJ2f8/wMw7/Z68p9qp3okcoyeZwrYRr6y4KRdgGQg6eY92U6mOmwLn26W4D0xJaL4QgBouSSwRrj55kzTzSLvsTmTb/Yv/WZLuZmugDOlU4G6yTcc9cwFynNReO7XPAO9K91AzwesyHBWWcDEwIu+zGWVfCer5WOG5FPF8lCxiwJMbqDRA7Kc4sF/YnIfsHWfX4DvOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X//eGTqPR6GX6clhYfoJGDd2v7be7vmMt7zU69UYhG8=;
 b=NC8OD2ElO5p1t4ass64+hTK9lDOA8R9J1yPPig0a67XrbaevCALfkZ01qDnMXBik2Q2hEqNoN79BnPHsuk0ej5r52pFy6D5uI3OIoCUSJfip0t9Ab2liIv0PopNT5nKwlziPO/0rg27rbVJoJlQdLjgWInb06Vf+Zrj26St5p9PFfe6SKFxdulF0ldQtcDoVKq2nKy/e+KC8I14n0lpKXrsKo3T/FsrtA19faRAUYyk/4OGSl40zRU98NjXwykzMWNfA76YcujpdABZip0y1g5eYAcw8kBuI6ER8kBw/sPcQcW64oNwLXCTqGCofqjAfe/Wj/ZaaWn/EsZxpcU0R5w==
Received: from BY3PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:39b::21)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:11:06 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f7) by BY3PR05CA0046.outlook.office365.com
 (2603:10b6:a03:39b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Thu, 13 Jun 2024 14:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:11:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:43 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/5] mlxsw: spectrum: Set more accurate values for netdevice min/max MTU
Date: Thu, 13 Jun 2024 16:07:56 +0200
Message-ID: <be8232e38c196ecb607f82c5e000ea427ce22abb.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
References: <cover.1718275854.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 982f2a46-c612-4696-5b3a-08dc8bb2aa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gavgs3Vl0SyZ0hNDwm+4X9UKgsXlE1a+Gd3WuUZrEFE4/xbsvdUPl8kt5dnk?=
 =?us-ascii?Q?a8+D0uKM118nPbxgm5CNpCqI6g2h54vlbK48N7rw5Nvgw40yW9cio6+zGgWk?=
 =?us-ascii?Q?p91PVOXeynkXb7GoMiBnqdq6YWpeOwRCw8dEI1z8P0gCDQbFGCZ394sX42vi?=
 =?us-ascii?Q?QCN0zAJmz+TvUDfN4NwV7rp+xlfsBHGyVcN2LuOiTvzdTyDLHkOz09U1sjdG?=
 =?us-ascii?Q?1KYyb61PNPVFiKeEJdNs+o9usuMt5+IUrKrqWLlZ0A9vRdyvNB6yWgyU7IgU?=
 =?us-ascii?Q?exEpYXqYycq8+/amv/cBY0oo2UJ8KzUxwZ6TgnwsQVIfoSRwDa6Q+1hJl2ie?=
 =?us-ascii?Q?QFzSAYpoN2CWpfPdWb5tL6k7i4ulLAI5M368MWPvV0hLanaflzcCYbYwbfDL?=
 =?us-ascii?Q?jiVCCcqpkHCWcY/ALGrh81Z1c1PcKByJ1CPxEsiTAjpaq7dWzd/ksYKLjIR+?=
 =?us-ascii?Q?OGGxv3Uf8eu6KcJOmTiycuTi1K8M45zVSnKHXfCsPv0fC6MUQJ0CT9Zuq+yo?=
 =?us-ascii?Q?+2iIxwgieuhTl0k0GkRR5W7bxORpncFdCtn4KWV+aVxPCFo6y00C69zMS5kz?=
 =?us-ascii?Q?3Vf8j6bCaH8wJobaXEgWUZpOqCVCPXspxjDG7UqbcmWrMMP2zz5Kgul4wlQx?=
 =?us-ascii?Q?rZmfZOqUdKJj07odDOANtT+dv2FJ/XF1Og6iQm1FcjiifbPykz0mA4D1dRp3?=
 =?us-ascii?Q?5sx9W6A3uoDywr3PIfP9ClcXhqmr2v1MnSilRlwALj/V3Ds675r6XV/zr913?=
 =?us-ascii?Q?be2mEmsO0dAVLA7kSjw12dKr4HS1QXtrHaTbf90TtKQpsGRU7VBJ6Zs1dbl6?=
 =?us-ascii?Q?uejYddmQfFJCgS8MESaYa3F5De3bwE/VLE+KudiXqU3EZQ4oUgjDouhQHPAo?=
 =?us-ascii?Q?TMqa+GrU7o9bWlc7zARv4JML/qroVHEe92uxqfUZyFX7kiy6dv/MCrzOtUsQ?=
 =?us-ascii?Q?dZMaZ0YAPzNpLg2kJxG6fNmOybeV9xbkdiIz9qcJfmPAglT92GSbfBzZ0ljo?=
 =?us-ascii?Q?nUS2pYpHGhiwDVQhkgnHvcltxMDrX8FE4fOk+WEcxvC4y5OzUJDhqGrGtegk?=
 =?us-ascii?Q?hUscAmxsPmQZcpJVnHlHDyt9fBOoS+XK9ZrJ1nIT2v8vbLyTwIYyqnKSO6O2?=
 =?us-ascii?Q?njELCsip5CBNUvbb5Dq6tCrjje4jjbFQQOUaxsat7gPSbk6z0jvsf+2KnNiG?=
 =?us-ascii?Q?uB+1UM+I0nrQ8By/CSe1M9C9990JRpnVGEFQc5AuiT3qRMT7qZGyjW3smrso?=
 =?us-ascii?Q?nb68ZXtMGWWCHU66yTKBFax5FJMPPTUmqf2F/MeUAxKALkFzkvKZtg1vlPMT?=
 =?us-ascii?Q?kVFbPq9nE5LPi/dzakgh/sCQV/1u+r3YIKQ9KLc+fnYhcAgvcwfQMay621G+?=
 =?us-ascii?Q?ukkpnnNZ7bABme5JMrQZcNXcuXy3XI4dMJmR7CsDqMEHOLyCvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:11:05.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982f2a46-c612-4696-5b3a-08dc8bb2aa67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

From: Amit Cohen <amcohen@nvidia.com>

Currently, the driver uses ETH_MAX_MTU as maximum MTU of netdevices,
instead, use the accurate value which is supported by the driver.
Subtract Ethernet headers which are taken into account by hardware for
MTU checking, as described in the previous patch.

Set minimum MTU to ETH_MIN_MTU, as zero MTU is not really supported.

With this change:
a. The stack will do the MTU checking, so we can remove it from the driver.
b. User space will be able to query the actual MTU limits.
   Before this patch:
   $ ip -j -d link show dev swp1 | jq | grep mtu
    "mtu": 1500,
    "min_mtu": 0,
    "max_mtu": 65535,

   With this patch:
   $ ip -j -d link show dev swp1 | jq | grep mtu
    "mtu": 1500,
    "min_mtu": 68,
    "max_mtu": 10218,

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 879daa18ccca..c5856f4d6b8b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -426,8 +426,6 @@ static int mlxsw_sp_port_mtu_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 mtu)
 	char pmtu_pl[MLXSW_REG_PMTU_LEN];
 
 	mtu += MLXSW_PORT_ETH_FRAME_HDR;
-	if (mtu > mlxsw_sp_port->max_mtu)
-		return -EINVAL;
 
 	mlxsw_reg_pmtu_pack(pmtu_pl, mlxsw_sp_port->local_port, mtu);
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(pmtu), pmtu_pl);
@@ -1697,8 +1695,8 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
 
-	dev->min_mtu = 0;
-	dev->max_mtu = ETH_MAX_MTU;
+	dev->min_mtu = ETH_MIN_MTU;
+	dev->max_mtu = MLXSW_PORT_MAX_MTU - MLXSW_PORT_ETH_FRAME_HDR;
 
 	/* Each packet needs to have a Tx header (metadata) on top all other
 	 * headers.
-- 
2.45.0


