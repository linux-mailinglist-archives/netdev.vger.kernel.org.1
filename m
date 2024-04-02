Return-Path: <netdev+bounces-84055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6D8955ED
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5821C22327
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98C8595C;
	Tue,  2 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfuV07kY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFCC8564C
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066285; cv=fail; b=VmxrdXX3UlWn8mKALfY4Cw9xjocz9fD8AoTif8x2ztxyQNvJgNRk9ootmF5tpf+TzpPkKNzn3SmxexwLHJ7PO6BGDDAZKX3gETvS2vZMWyKIJtbNWR7GQATnsFnYbOGc55eFAo9d2JQ+8vTXgxWf7/0dlo3pRsAmPqRiWnGoXP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066285; c=relaxed/simple;
	bh=CapeTfEBOdvypIoN7M7fiISzJTS3AoJp7Q0QMfAhy1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNovGhljOSU/nqPdSH5rvEIVoafHJuSSUBwYpB/dekP0F/HTRfX/z2yT2X1bNNuILwauJqzD0iqjlUQKu+0K4fZY6ypm/1d+JKtxj1IYQO6NR8FceCySy61iwTb48fi/gbwMuOhzPsdTiV6H3MyKODEZI5aOYrV5alkZr83U3oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfuV07kY; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARlgSZmtKYKQeOTCyziPFw9e2JH8xrGXgEUAjS41rYqC/1FGh9VzKOXMfBa9SScieJg/QCDO3gN+lH2bZnBe3AGJMDmxt+0ps2HnvVn9M1t97lvfNaaieTudknX3sogvYJD2muCISfZwOU8Lzqz5dr/XzV/IQP5PKCaHgBMuF8baFwZsJ3TFsicaolaw04MpZHkqy3gnM70jtM6zO+98af5vWnnPdVNQizUJ8HgyEHKfvUcqm1unaCutEaJj3smvo1qTtqSY7SYZRTABgVElKAqiipID5vJPMt3MLvCWnUtG0gDa7SOldcTLvIe7WSqhwwkej614LTBCt9Jxjhd8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D838Yk2zIxAGAPhmGteWGD+7VYgkMnzlnVSEvPInpY=;
 b=bhprdWKRU7QThrK24PGwtJpKofbcDM6UBTjQcP6Nh4zL50GXeukuEX5FFTTrZs86CBhrdihfPYb0SWfpgnNkLNp+qw2KGxciNxzgBijX9qL748loTEyzqVYjlo/9JjePXI2gnO51YTXwxzNziwA4wwVzdFzLFE85/sHoRx0bz6gedkNEtvtHDnZegkbnU5BBnc7IVfezin/yBqAPV6aLDEnPuCU19N5Wc2jga4gq2/5PP2pCKOXsYO2+wGsp49X9NB6fyFEuotbeP30CxppXcSX+fNwf/vRbAJC4jbRRJnk5Nxwl8NjvOH6BNJ6hwbme/9LMQTnRflUtMT4LDYWAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D838Yk2zIxAGAPhmGteWGD+7VYgkMnzlnVSEvPInpY=;
 b=kfuV07kYAOM25YWpaNk9NjfkMykbufqYNLopq6No1FwJ5HNk7Nmt67OP0ouvqYS1I/LaU8ojYQx7smgtMEqcFYCBNkc8VPYoc/O0QTu4/K43iAJMUAcT8D1PGRFRbJf1sUNzbmx1HzO7ZCC0DrQkQ7iLyH8V4Qj/OGdEetpu6fD7OpkGtj9A2TMTSXBgSWNcJaynFYCKxpLraLKCeYKwb5gDwPAzkc7PYjYx51J3UJFdSpff8OBCZ/7reki09GqTnxzOcnSq2saR4qot4ALn63P4DmcbLId6zlj1I4mYc0tcEcxDOzO9Ckj7RCSuEwMAHJHI0xfHuU7/8xPcJJUcLg==
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:55 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::d3) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:39 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/15] mlxsw: pci: Make style change in mlxsw_pci_cq_tasklet()
Date: Tue, 2 Apr 2024 15:54:24 +0200
Message-ID: <7170a8f4429ecb5a539b0374c621697778ff8363.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9ef34a-22f2-4e83-abc7-08dc531ce571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B21Wf/kzVaEKt09tN+iVfRTbex3FVS1OufccRFW45wLq3LWAmWnbv+h3dXEXx13mAWjVghJmWuSmGPoA77OrSoE+Zh8VNfFcp3vnivfJbtDSlZtyiZr1dXYiFLhGuUyT/1E/VvKEmSqQHCeI4JVt2eaSMWG9wiZavbMu0l+pJ5Ssg+MXalgt7CoLbYn5e7jH78k1RjaRw35LbIEzGuiTE/bXjhPXREJ5JYbWFLI4Jw9+PQsyO0K0j+HP/wpab2jzyNy8z3jmY5yy7+mJM7DYOMCgS8pqoeuXFhF5LijqmdhK8OUx0Uy3e7qdCKJO94rvivTZfwaf0UDxssDrMPQUYd9NMP9rNMRyjVHCNcGRcGKY2We7Pt/rqVLUKXNU+aQoP7tT6RVAXfF7Mm3aOR0kSVoiH/5Ypn8StpX3IpQ4sHlMCAtd1JG8KvykBYz2zdcPv+m9VzK0Ur3xctNM6+1iMp224GXyR03/7rCWmx83HKFiOFCX3lHpZnrI5PEmZGzNVGdJk2AMVKSkPQEyHD7idZK6+bB2LwMN/GNI7JWp6lINCMC9vJqmZkx5Hh8q/dInf7EbHcG02345ltL1cfFI99zD4k7XJD2xDjenBL92Uzqoep/uO3PfgOWZ6UZ8a3HjjtWE3nCUV6r+WrEaOH+imnSjzfsuVrVxUn0VdHg8B1OvXDTEl6Gj35Dxx79P5IvA95xEmu806zzh74L8uk/UqHtz5OAxu7FEv4/IcT8NAe72d6b8G8bhaiiEbP8uuW3r
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:55.1670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9ef34a-22f2-4e83-abc7-08dc531ce571
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

From: Amit Cohen <amcohen@nvidia.com>

This function will be broken into several functions later. As preparation,
reorder variables to reverse xmas tree.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7f059306af5a..7c4b6e66f1fb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -662,9 +662,9 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 {
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
 	struct mlxsw_pci *mlxsw_pci = q->pci;
+	int credits = q->count >> 1;
+	int items = 0;
 	char *cqe;
-	int items = 0;
-	int credits = q->count >> 1;
 
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
-- 
2.43.0


