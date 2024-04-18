Return-Path: <netdev+bounces-89227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E523C8A9B98
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D72CB2390B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C3161306;
	Thu, 18 Apr 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcy2e2e6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E61607B2
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448143; cv=fail; b=fCWVfku7fwJzFQ/TL2DLPfaem1H0KfMUNQh/p649npd21vMnfMEEj3FnxD2Hq3Pj4zVYjhMg4tIWS4BXOJP2T5GEMnWYd3eaFDdlqnulbgD2TUz6Up6cUF0zrLJnP19GgtFxWXo7AUzsxJt8UhDexc6ikWkXTLsY3FdmzsTJMkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448143; c=relaxed/simple;
	bh=cQWRoxyWezpQ4T2yCr/tD6obBqh/zyqjA9bNpz7Bf2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcbM3woYMtvfOgBDYSF2/DlRGtn+tMZpxrOPY5SiULnQxNmcjwYXiw90z3omd99ycVaHcaHzaoFi6DNT3LbP9Sb2Txeq7RXe/s0PHONf6Gyuzu/+r3JGAa+z+by1J3MLQA2nwmcOdWaBMSoPpaxoVopIITd0a7D4n3FZ3c5eK40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcy2e2e6; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2jDN0zSiZayETcY/Ym/kQnlVqLZkwQwyVUlkTVq7bDjAgy/7phcKXKr9JPKKHlLDiaqC2WuLLMncKKXdx/aDcBct1Rm7MyVZ4xJUfjzuXOUV41wbgpkwRzVaNVq2p0VfzFlbz6zqDi7NUNkQEMk4XY/RGvK5SslVLN0GkY55/U/FZ28hWSKRcV1nPHFrXzAORHI7sUODhQSp+yxC3qADa0msVgu/+Z29nFBMM3wJ+AcVg2M/5Bf8FCGhv6ASNN74R01O6GJwoUYujofmPzm7h5pNmuyceY1F7TXipC+Xl9shakVwutO2JIHtKxYY1oe1GoSeS67Ya0svUIMaM/V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK+i0lKYH7FDJeCwMWCUcR7nAppHGq1HB+SHqhxyEVo=;
 b=PAPbRJ6/y1+3j/n0By5VGr/82adb1ropqkAKVWfx5DX5pbIjesLBRVWweV1S66tcDyHRzvtzxEaeIXokMGsjefufTR/NuWMOw2DTqWPIuqDqJcPc3ljjv/8uLukdlw8wQby2IAO5q+akTs8mR26OmbBGUJMf2APfTYKU+LSwH5w0a9EyAAHJ6GeHD/v+62T1AUCPZU/sGhq8pv468aC9qMVs4YMsVCy1khwm0f4hjVZ4S2DeW3LSL0KPCX0R+CpL5xyo918aVOqA1EH3eE7yTK0wXoTfoadqja18RpoAhm32Kw9ncvvEbKyeNqad2GdaA2Z8AwikP0WDEDC4R+PT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK+i0lKYH7FDJeCwMWCUcR7nAppHGq1HB+SHqhxyEVo=;
 b=dcy2e2e6/KWaubCVSt1BUYGO9UjHO+5INO6bxoZsx1cuOW2ZCjaiR7pI4OvkH6ElXj72lPRYzVKccH/NCH0evOqFQw2smpBs/fCo9UVxHF/BUiLp1rOwOAnfZPGb4Lnsbnekt1q0q+TcR+Iqv3bEqgBqPhjM6yLKskRKl1UbOKcbaiSwra8fhb0LNDYuAMLWtSMspoLZDg2a7raoPw6ZGPsLNPGpLkWGGXkMwSzg2/yJSNmnmG4/Psg/WNRzMzYmekEXDvRoNiGPujskHicJXS8IsPBq3nl+4jeu1VyS9AVaAB/L/FRUjfjUaXsyeRo93sKh1SFzImojtCxGUmwYsg==
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 13:48:55 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3e) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 13:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:48:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:33 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:48:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen
	<amcohen@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/3] mlxsw: core: Unregister EMAD trap using FORWARD action
Date: Thu, 18 Apr 2024 15:46:06 +0200
Message-ID: <753a89e14008fde08cb4a2c1e5f537b81d8eb2d6.1713446092.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: ab809236-a77d-4c7e-954a-08dc5fae49b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68JgVCA2kUqq2i/dCY0TmA+kio98z0DeJ55nO79HywR+vVk/v4zjelrUWgVmuo4Gsi6X+KCIhYWvpdTh5FMQiCRk8ej2fOcZFYCPIlyWf55e6UIWJ6PzO5tcrJVGKFEwi3abu2uB852jYsZ0Q+MDIN0BVK/6113l+uycNq3ZhHRMKZnRUjVyUGQCiG76tTPPO7Ocw65RXIctyG9Xseokye0M9DJo1OP0/yxUEYtoIrn9ZbJEaz/lSmFOQ/D4uWPku8tWo3VcfibnBaz86wmMOeLBcoS1R10B26vJS72YuxlQDJ0Za+EC15un5SeJe9LErs200SSxbHFTTXLkVWUVUSCTS8lo1qAzITcrswXablt+XjFn6Ss/shrBygpNmgjRDKpfRErCU7BxIiPkT2UXr+e4IqgeSG5yjwyLXCYOq3dJAZZnYCvZ4Q3u5O5cL4kYJkkPn3vvfPc9icoYUkNrpTOxEYjOzOKVit6aXAfBmbPPKFItcreuV3pev+gvl2CPte76TuYwj3fOF4l7V0J1qVR15GAUsXyqWexOfZU9Vkx+Gt9BXyiEEPTp9qkykHfG3kWfW8ZmibKcyytCKZx8zWBWLukaz2T8C80VjXTSgPj0hfjh3tLDBlChGYFqkEDzNIXWSCBVyRmpCodE2DwM2sQe1l5UaNhVNeU8GBUmbx9IMBSyxq8IuiYSnGM8ZR81OLwWCJgtIEah5+gLDOZYs+IFoptNlyCrgf6Q5l/tO+6IO0tUL8KuiOQGgNzqHKvk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:48:54.4208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab809236-a77d-4c7e-954a-08dc5fae49b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205

From: Ido Schimmel <idosch@nvidia.com>

The device's manual (PRM - Programmer's Reference Manual) classifies the
trap that is used to deliver EMAD responses as an "event trap". Among
other things, it means that the only actions that can be associated with
the trap are TRAP and FORWARD (NOP).

Currently, during driver de-initialization the driver unregisters the
trap by setting its action to DISCARD, which violates the above
guideline. Future firmware versions will prevent such misuses by
returning an error. This does not prevent the driver from working, but
an error will be printed to the kernel log during module removal /
devlink reload:

mlxsw_spectrum 0000:03:00.0: Reg cmd access status failed (status=7(bad parameter))
mlxsw_spectrum 0000:03:00.0: Reg cmd access failed (reg_id=7003(hpkt),type=write)

Suppress the error message by aligning the driver to the manual and use
a FORWARD (NOP) action when unregistering the trap.

Fixes: 4ec14b7634b2 ("mlxsw: Add interface to access registers and process events")
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index e4d7739bd7c8..4a79c0d7e7ad 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -849,7 +849,7 @@ static void mlxsw_emad_rx_listener_func(struct sk_buff *skb, u16 local_port,
 
 static const struct mlxsw_listener mlxsw_emad_rx_listener =
 	MLXSW_RXL(mlxsw_emad_rx_listener_func, ETHEMAD, TRAP_TO_CPU, false,
-		  EMAD, DISCARD);
+		  EMAD, FORWARD);
 
 static int mlxsw_emad_tlv_enable(struct mlxsw_core *mlxsw_core)
 {
-- 
2.43.0


