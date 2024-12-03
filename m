Return-Path: <netdev+bounces-148680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324379E2D8F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E693B283F15
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB2207A0F;
	Tue,  3 Dec 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gt7Caahk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D7209692
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259024; cv=fail; b=WzhM533kh1DHxBtGJf0eMQdU1aPYeZpfZaaKRT8w7onmel/qMSYc9ekmLwpUe4OH6ZNWTG6ywwGU/tFDRCmUuH3DMwYkVpKXE6RF4CYghfPrS9eJ/3N9/I41XL25BatE+cxpvLZz5eWcKd3G3KwTxSYQf7bKff3Dr7XxBSxrPDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259024; c=relaxed/simple;
	bh=sA1Q5KsvpvU652oFRacRtTIzkCUQo8deI42RmuiR6GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5IuJCZ9OVUazU8y/V8kEKtLlsyente6F5mMxKda/wjcul6yApiuWsr7FUyBYnnG2/o0A9/gsK+z+OVKEhYIptlZqSGRw1ThaZya6Zn5dWBAXECuPo14kWIi1+MIQvby0zJeKEruJH1mrwKRrptxn086lhI2my4nP+lxx79k3z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gt7Caahk; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDF6E5YCAm00koPEnb1Gzu/oYSV3vN+8B6jE4x2BWqqGqR/SBMGeYgNI6qcyXFgYALQxTwTdulMHDUoXFNSeZRh3lhzGn6kjoY7ZRnC2dM6pN4LNOSNxHgriz495rjE8LUgjIORlq1OZxTPhlOkBQ4urMUIByhaf0zcbrV3g49fIj+i9Dq7TjP/PJO18NA8fudSdS9AP2Bu4HXQqpzdbwN190MqAHEoRmvHLLziBEoAT7QET8xDNx7z0RspqYxKluMBRruK9eyUGo79+/BCkC6eDXHaNwj+/9abu0VgQxGBZwwYRApv30bf3IkjnE89MBEmDyaSVkscs6U78sAX5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqylk6MZn9V//8AH24TTjlGI/kvzV8kgrpCbK1OtZxU=;
 b=tur00Li3NoHxqqwcYIJ17cjJr6CoocawmV9V6ecC/mZwj1Hp5g4saoC/EEbPHTj/EvhzsopUk3cTMwEudtNxw13qhIUbjkBZiqlOL08To10AOWfDHGBWfAseMX7EWQn1sza6Jlzoh+Y1YIcUVHglfsr14/zU8DUa9Mo0uIhDWWze22SGR6j4D1I0phBdTTI10eId2j3c3G6U/MVbRO+f3VvbGg4WYXwvZ5nVhRZVJ1JeYzj6TaAz01L5ABlMH0T5+rRv1z+gp3CDSfD3AiJzZOG8xYjQvX0p+oakbhCQ5N61RJcpXf4z0otBk+ocHJk+sFggazEKKDD9bT0mW0vZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqylk6MZn9V//8AH24TTjlGI/kvzV8kgrpCbK1OtZxU=;
 b=gt7CaahkOLy8knAprCRB9OmXhiI0GYNQdxLy4K1/paLiG870tEG0p5wQ5bn72zNQfwbKQKRbTY03E74j4mkp6y+kXGAuB2eLSH2ud7tS9wIBAJbjAxtrUXUwtCkSOs09PoNQRzM6x9jjsYucFN5aea/33pgItD8Um9DmKz341mzhSurD621kBbMGOn89DejFXTiyitHfy/u9ArTbt/QKk85KS9r68wArl4EEFBQy+dm5CfARDej2KGKQ6G/dSl5ciwDAgCfvirTv4UxoJS208RyL/Rl095OCCA/oFZP5tEmQBJv8mYVYrPSJDOufCGMyPo8iTTi2uXDe5NpEag5a9Q==
Received: from CH0PR03CA0439.namprd03.prod.outlook.com (2603:10b6:610:10e::8)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:50:19 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d2) by CH0PR03CA0439.outlook.office365.com
 (2603:10b6:610:10e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 20:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:49:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/6] net/mlx5: E-Switch, Fix switching to switchdev mode with IB device disabled
Date: Tue, 3 Dec 2024 22:49:17 +0200
Message-ID: <20241203204920.232744-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6728214b-1a96-4977-cbb1-08dd13dc18c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcokZq5/FaqsHNNmKxa+1UhFBLV2TdO8DyIkCZbOphzqmKUjjxZDpFKXwGhL?=
 =?us-ascii?Q?CU+u9zoiiczZn0L/3QFtNE+MHGgwftelZJ/+G1HOlv+z5wPfdajOHoSl6JQA?=
 =?us-ascii?Q?rvPDQ69eCwqFHmyGyurJv9XoISC/pJf/JAR4hV2H5s8hbFzVO3cLB3QmAhPW?=
 =?us-ascii?Q?/uCadBezjzA0Ket3zx3IxyjyGr9/LE2QbwTcI4BHJpf+5761RLHvUc7QRp3G?=
 =?us-ascii?Q?vQWpPDIxGbrjt0YyCN+6j7JUuob581bu3C1NfscW6E/3I8z/ULwDqeAXmpqR?=
 =?us-ascii?Q?smCBHZG2Osz5DTZKEqv3hkgN0Cc/7ybpYU0yaG5gVLIOl0MSEmQVNxnirkIf?=
 =?us-ascii?Q?kNbAZHaUo2UufY1Ohi3XBHKc/bqSYwARstPI5sRDuypHjnq3WpgPGHu6eoEx?=
 =?us-ascii?Q?3IZ/Ot2wcurhAcPQ6eNMNzT2hsYrNalEUqqWsoWqN2V8wDYKVpgZ8i6fP8dQ?=
 =?us-ascii?Q?LpMaybEa9pgbZ2eFFO04wlD++t6vcgqVMeBg8Bshi6WhDi4K/liuvxKCGrax?=
 =?us-ascii?Q?+nMBhYnUcA3gRt9YDlKkyEHZ5IE3Az0w9LhZzoSiDv7yucZaB0OfktwFI2E1?=
 =?us-ascii?Q?LMK3lIpdsRxI92oJLIMmOGzgElkcs4wlU4kEw4qGeV3uw3mz+wkUDPXTTlIT?=
 =?us-ascii?Q?XSrZ+4LIb61qdk0YtU7ut2gSJjiox67EFRyouhz1QT+VesFJl7I6PrLoYOIH?=
 =?us-ascii?Q?HYFeyCTcccjmQZDwoILzhwQ4ukLSU5UtgOZJTqwCkaMta5zZNc86OqKBcl54?=
 =?us-ascii?Q?E7vPfkmut1taTjWxAbJrAJmIol0r0zHT0m1bD86BZVtnZHs1Xq4sz6DZ4ctJ?=
 =?us-ascii?Q?pq6LM2Usarq4zVKO5+SoMibXW2Bi9TSsE7E8aeXdw89X0A/yQCzKbUhhDncb?=
 =?us-ascii?Q?ikg6+DFRaA6furt1bGxh5BnSRly8ZnyUx6Fn4floT5faLom6nunaJfRWiNFI?=
 =?us-ascii?Q?gXRMYp+5bje4f5xlzIsBpFtqJ929F2NOyH3/WiktereXHjTSmqeJZP2nSB2U?=
 =?us-ascii?Q?7dk/L2Hdh3FCvWB7YKqu00eAjiRHDgwERrzlzY2R1acSXbqQp+0BX02dfus2?=
 =?us-ascii?Q?7Wbcl3gyTDSLq8ehquU+7lxvVL5xflte6LYeOVh/gk0ebfRlnveNMHLnz+qB?=
 =?us-ascii?Q?wJejdf48a/SBaRhdutb7iJt+nn73YdZQHBGaNpdwAww/VGz8kiKiREjxJgyT?=
 =?us-ascii?Q?mZZzhcY0YK8pZ9Hz5u4GnSeh86VsZgUGyTapw/d40Hb9LXA2HR4bY78OCsvJ?=
 =?us-ascii?Q?F1rCHv1Uqzmz0r10bbxBYEYbJEbKeEVo8AZrN6mbqAwgD1NPJqzxrWFPCfwJ?=
 =?us-ascii?Q?sgus6jWd8Ze4+rHKig99t5RVWJ6ZYuXBC86bW4ehxvgmcspzfEKgmXp+Q8h8?=
 =?us-ascii?Q?kBJz8AKSu3MtZlywaI0DIqvJMDuA14Z3OFqaLwBpgfFa+jreCuh+WpOwtYJ9?=
 =?us-ascii?Q?iypjnOBgWZh9G+25I677a/CgYm8m5vly?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:18.3055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6728214b-1a96-4977-cbb1-08dd13dc18c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

From: Patrisious Haddad <phaddad@nvidia.com>

In case that IB device is already disabled when moving to switchdev mode,
which can happen when working with LAG, need to do rescan_drivers()
before leaving in order to add ethernet representor auxiliary device.

Fixes: ab85ebf43723 ("net/mlx5: E-switch, refactor eswitch mode change")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d6ff2dc4c19e..5213d5b2cad5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2338,6 +2338,7 @@ static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 
 	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV) {
 		esw->mode = mode;
+		mlx5_rescan_drivers_locked(esw->dev);
 		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
 		return;
 	}
-- 
2.44.0


