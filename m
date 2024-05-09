Return-Path: <netdev+bounces-94886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6D8C0EDE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE311F211CD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77181311B9;
	Thu,  9 May 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3aUJsAz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2013172B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254305; cv=fail; b=I8VqotijBBQmFHHA2gpL69sbsHkVLyvsBw7ywKKOU0m0cf03jbxTpAqrdxS4LOwKW02maR3k04Vn5nzM107Jjqb0/Ysd3Yj+G7ijS9nFDPTgO9x/Ei0vfqkUfl6RnWGZuEd0UhicTwPzuREZxSJ5yeSAZJwTzaAgwcg5GZBlLUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254305; c=relaxed/simple;
	bh=pWyA5CbvPcePRn9+zxkQI1drOT28RCuJIhFNVK2C+nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAGQVrjuPLQTQxqIFwx4Kv0wJCc/nPQjItY50AzFz0By6QGczJq2SqiZ0B3LFDGCKQHX1mQqrvXHxPKrmGMl6CKWZOZvIgN/Yts7KSdzKKmfYTkISzjA40vsxymeRz3UKHeCDk2zkkfYkqQsIvCJd39Nx+3g5rXS+Ky0oIdsHW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K3aUJsAz; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFsMO0axPf75wUfIQXxZsruIFbhL7oGV9EVsvBh/Y5Yddx2tTN6sX4gJ7jkCvfWzyzgBZL5XqWm6ckP4+XtcruJmAIp0S2Wy5rmES+P7iNwQJU4o9TwK7HJDWHFBc0HvsJ1YtKdwJ1HZHP9v6Vlgj4p+ETXMufbWxTenMUn7VqoFbtVr1m54NMJFAAsszPUd4Wxcqmsg8CW9608QzJFbDCbxmH6PvwZcyvQqCFMGtt7Uarf4w1JREdhXQPpudgmQ3FTifubJLUljtK1828sS3NRoe20KVRSLNKMtAnYrOyW1RroSB5/nP1ZRyY9x/jX5mRD0k1tOlietwDBIXBGKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXOfpUYR1958LdBCQxjl+tZsSDx6KPiY8X4QwpE5umY=;
 b=Y0pxzYMobFzUJM2Ahwk853HIA91OP1btNokgJwzpm2gs8Be18MRWf/gUGtM8ynmgCNy7Ns9YSxA8qDZOLvzaYhYkt3qQmu4XWbbLuUtFw/1ph3m04qihwbo+eMYsBifeocT0IXiZayX1FuWmgCrgGm+jjOKbynowFMNEYptsYUYeElEohBs6qhpCPOVbDHYatQoXgGjgGJlm1ty+tXQBjPfD24KpouzA11j18oOxeZKuvTQGSIttg5MR9CcVrNihLlQ6wTLms8NmgpNzmpvrf/E3YAWYlyrVdawIafKKAwAn+X0W2ISkmQLO+xpBfkGfOTtCyDUETc4s8iWf2KjPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXOfpUYR1958LdBCQxjl+tZsSDx6KPiY8X4QwpE5umY=;
 b=K3aUJsAzJrXBigEJetUEZzk7SzKMesAgQewbzA4YTADt4GR3gYX+9ZpndzGSOok0KBLPpjyfVVFwSf3xTtV2CrAcOUDt1vmvK7uf6IreLCN+xw2Uh7vbN92rUPK1MbSRBHlLPW4GB74QIPbjuD1n2EcQ4tF0I5C6ws14uDXXlWZSo5sj9PScN8QtJFIEJkXkRud1Yz6gQUlojNMucsv9MWwHkDBfqtWuksbDRLSfvAhe56gOuWtan5+D8aHu414/SqyiVL/wgVQlXKKsWVDnb0BvTHufWgEz8H4Gqf+sIqHON9d39TXrvk/UdiuRhgoNopEam3G+2y4iTYWm+tLaJQ==
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 11:31:40 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::30) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 11:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5: Discard command completions in internal error
Date: Thu, 9 May 2024 14:29:51 +0300
Message-ID: <20240509112951.590184-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
References: <20240509112951.590184-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cea40d-4427-4c44-735b-08dc701b9859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTyr6h63GhqyVQl7w7rekGrz7QCtf8a3yYjLpoGbUsZHtUX9L8De2VmcLRJF?=
 =?us-ascii?Q?ILcnOw/awJ0BOCUy4K5N8+PV1lq4uIQmxz1cvvRS3d17SRcDa/6ze55WFeSt?=
 =?us-ascii?Q?aXilu+vVUxC94AOXeAgf3pTJBTNqDMrj+AcMYcEJcTwXQEQqVmLDDugj9dY0?=
 =?us-ascii?Q?saask5tnSlWgDO3+esmVT+/Z5obLBRv10CbptVqcMm9XU/RsylisV2XzcHaC?=
 =?us-ascii?Q?M6tmtHLWWs0pDIGRql0vgYsdKCGiwQjuIvF4FHFk9jlFuh2NMdiLWezcGYzX?=
 =?us-ascii?Q?VqEstA2Sob2ymfTbBkMPOVrqRynk0LRMtAu1TeYfc/xu3rkO8mt8PwUV6Shr?=
 =?us-ascii?Q?VZkzZ3oSbzfS+qgOnwFZ7RrnGVqqDdO7thOZxgEq6hrbMhXKhG1lkF/BWiPt?=
 =?us-ascii?Q?8J0RnN6yyiioZ3HESxR40Y6p3DCKyiJf7Ya8kP7394JHxbCFE6OXwO7o1Bgc?=
 =?us-ascii?Q?hzQQ2VI5y6xcKG6Ia6WHLPHpDdiJFyDCU7vHnpU1aMcNKS/H2Zqdf9hlQ+US?=
 =?us-ascii?Q?a5kqvHm1m32Yx0nSi/eFp4V7fQ299kf1OW8TI/9px+IV5TQaEKNyMo/lmQGU?=
 =?us-ascii?Q?Cfwapd2NSzMq9RBPxzj13EEGwVLQnr4GKcuywfmRbYDV0rIkU35Qh89w4hQK?=
 =?us-ascii?Q?0XsSaUTAGdKJrLyBVluUPMiNw2uyrYrClgB6nZRvpz2p6IqrTc80LGjmT1Ag?=
 =?us-ascii?Q?HQf2dyrpc7Tz6FWB38eLZ3/c3Zwz8EqucCkeBJZG3/zITUyWKoBDxxOBwHYg?=
 =?us-ascii?Q?1ieypHqhHYlHjKXHX76GDEMug2IgyY8wi2+oEq9XVmIQeXC0MMlTbb4Eh5z3?=
 =?us-ascii?Q?xRYG75bIIB5vBCatO4mdWXRVBFhQTcNNrG7k1QYbYlUFSDW6v0EYqCGYBbji?=
 =?us-ascii?Q?6Ew8QP/cXp/2L7Zr2aFtk0qB+72e0aId1iWZm26iv6ta7DC3PsLU4wvx0zax?=
 =?us-ascii?Q?p8qbtSfZe7eupT80F8gz8z9VNI1j+MDuZ18aWThTd5elWZq8qJqyWONFDh2m?=
 =?us-ascii?Q?eZ9pgsb55WfyDP0Az4sA4IHHAiIMARGTXS6yYZymqho/27KlE4Vv8fwVRECv?=
 =?us-ascii?Q?3rgYncsk9KsH68m0TJlChU+zqIkQVitD21tJm/dAjzCRMsZsjkDugHkN4xQP?=
 =?us-ascii?Q?/8KUm93nSB9U1ZL8lt1JE6AJVjpQVTQwt6quFv3GU64yLFlrstgcl1bxYq5m?=
 =?us-ascii?Q?3JV2nDLU9RjNIOH13S3ovTKQvLwiVYkm8DJkHQCSWGVddEJpbTkbsKPAIqyp?=
 =?us-ascii?Q?+x+yvyOZbpIp+ssPNRCrl/P6XjL66TNOoPVorajwzw5QKNoWtw3O0D281HFy?=
 =?us-ascii?Q?VbpDXpY46hcyh9tp4JDO+jB01h8gwInX3Cvp+7vH77CKkA+EY0++dep/AR4U?=
 =?us-ascii?Q?cgUszvfktgWFLWo1MY03rqUqGFBE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:40.0788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cea40d-4427-4c44-735b-08dc701b9859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

From: Akiva Goldberger <agoldberger@nvidia.com>

Fix use after free when FW completion arrives while device is in
internal error state. Avoid calling completion handler in this case,
since the device will flush the command interface and trigger all
completions manually.

Kernel log:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
...
RIP: 0010:refcount_warn_saturate+0xd8/0xe0
...
Call Trace:
<IRQ>
? __warn+0x79/0x120
? refcount_warn_saturate+0xd8/0xe0
? report_bug+0x17c/0x190
? handle_bug+0x3c/0x60
? exc_invalid_op+0x14/0x70
? asm_exc_invalid_op+0x16/0x20
? refcount_warn_saturate+0xd8/0xe0
cmd_ent_put+0x13b/0x160 [mlx5_core]
mlx5_cmd_comp_handler+0x5f9/0x670 [mlx5_core]
cmd_comp_notifier+0x1f/0x30 [mlx5_core]
notifier_call_chain+0x35/0xb0
atomic_notifier_call_chain+0x16/0x20
mlx5_eq_async_int+0xf6/0x290 [mlx5_core]
notifier_call_chain+0x35/0xb0
atomic_notifier_call_chain+0x16/0x20
irq_int_handler+0x19/0x30 [mlx5_core]
__handle_irq_event_percpu+0x4b/0x160
handle_irq_event+0x2e/0x80
handle_edge_irq+0x98/0x230
__common_interrupt+0x3b/0xa0
common_interrupt+0x7b/0xa0
</IRQ>
<TASK>
asm_common_interrupt+0x22/0x40

Fixes: 51d138c2610a ("net/mlx5: Fix health error state handling")
Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 511e7fee39ac..20768ef2e9d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1634,6 +1634,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
-- 
2.31.1


