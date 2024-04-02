Return-Path: <netdev+bounces-84047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88218955E5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421D61F2382D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAEB85650;
	Tue,  2 Apr 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QElCn6Xo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742384FD6
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066248; cv=fail; b=Td+8EE/LUB//mykMQK/rig0tZ1e8kYcunsC0no/Tjrly0RvBvLq0uKCY32kHC8xdqvHKMIDOgR/L+L3DgkJUPsAXSDi4QMmxdRKR4h61EeTnEfJGnhHLWXd3iRQ2Kz9DIFmXMwd6kKwjdwLP8R5fvqE20eI94J0ps/AIMYLmlZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066248; c=relaxed/simple;
	bh=YhQb6EK7HROvBzAwntbC5rAcitrqp0RUpXtw9OfBXKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oB3IUAihjH2l66p4uLdObjDCAgl5+Y11ChJHlYnp/iTHqizdpLN6J7vXGR9IXubYUofukqFgLH3FV9MMUjEAg4Z48DoSVv78lv3vFchQUjZLqF6zdvh2XR75d3Iz0LLecrNNN4/2WMKrz9zD3WqH0KDjIcM0JGVjxvE9tK2Vg08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QElCn6Xo; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1qFoBexVT0cHt9xuQF/esPug8cJgNGzLFvJxFhZ7K74Yv+eqYbCyI8cQwGlQ0IRHCgwje9dq8Bx7YHkDnQQSAZ9/97SOh5NRQy1g7StROEi3OQbHyBMvSjMlITSGk7Gwht4hofQmAgyclZngoa8lJEUm3Z1mEhlQTBKe40uAzQOVcDnikBaEuIsGHzyUPvmKO1Dnjp/MC46Ex6uEPzDdhDr+1DCwL02E8QLKrUX4jzoQ+TZYRKANvRpPNgzjgc0ujE0RUY0I58bVHNFFud1AhjOxIUuIw1Obl8Y4V+eG+B/AkTLAZiNQAh83cCYadAj9RWRaJkm3ncmtIHxCOJ64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5shGxQ5DSGMbALQ4dKNCZ3FFMmiJ6aZN7ImjB5HStM=;
 b=cI53LeUvH3NziWXWrLRIalaRYmlDp8IDwFxqm0k5TjFRz5DPlet5B8dFvxoZly1CsVBmdPAbJHeu97TNQHmGjIumRDU4JdXm+p61Aj1igwQdCHZAdZ6+TENvPwEjGZZplE2I56YTQplRU3NEVlNmPF/JkqWMDMRo7/3Eohe0pYyTbBfhcmPNPNj+dBaklcf8y9+sgq6643DnWxGl2qU8ykDdWULtUD9AKHOKzWleJsgUNMpZmf9M5PdPmVGrJah+AadI6rz2IMny12nwiRv2NUY/hXAAy4HoACOo3em+OjIBTCBBxsm/Ig0SEHSGhQjPJVbk6ITQ+kqqd48n6H6+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5shGxQ5DSGMbALQ4dKNCZ3FFMmiJ6aZN7ImjB5HStM=;
 b=QElCn6XoJi2kzZtGUoVm+oCbdvlb8S11++sSFlWuycOQK6KskQVlboaIBY+L59N9l8FFevp7tQ6inLz89/hQRVIhwk0p6ckOwgAQ4Rnnxojxx1FdaaO819y5MjKlHJMz88X8BqlMH9q9AFRKhuusf6i0NeU51yFiayJtlqY6bkApUuyJwXuegazbhXNjDwvQJ84Q7cL7f0hv1jMSUEYCfQSv2Qlr+JSq2BI51+hLGEscSklq2NaEmvT4sEH3pR87pEOy3Z/8avqoKU8+x/d0vh0XH/tGyQ3+ZLJatrkh+div6ciS3FhFy6icBxamSpcMG26YdllIcYi++FKllJCIvA==
Received: from BYAPR06CA0006.namprd06.prod.outlook.com (2603:10b6:a03:d4::19)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:23 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::69) by BYAPR06CA0006.outlook.office365.com
 (2603:10b6:a03:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:08 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/15] mlxsw: pci: Arm CQ doorbell regardless of number of completions
Date: Tue, 2 Apr 2024 15:54:17 +0200
Message-ID: <f8efa481bfe7bebb9f93bb803f44ab7da77f53e6.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac679ce-a34b-480f-0cfd-08dc531cd205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5X0bRyBZc8wXIrjw44jjfJzBPIys78hAUzJCpdSpA6hGOFYTK+0G0vjqj/oyD3WB6Ko3tAcLGxXDj0QdVW1SRvht0TbTA+0njk2rz15/+nQyw7F8I1o4MT8rAGlxuruiWWDaq9fbHaJDPTratlhRhN6Hn/gTP70DLff5vE9fWQinduF4Osb3C5gpxSXaIRo8KLD1LcUKQjugKdAYMKak+s3MNmEgcmU9X6Mu9+AutEuK4sbJHzutLD9GHpWCa6Ih6QaxX4wPlTAN1+GdFW6U+K1C1tqRi224MjUDOpkFS5Lh5iWvB5/BnJyKarCGZKhLlsMbft7h2Hz8l3AqW/3pc3yR17yLiVbkXtr5MTQk+Y7HRh83D2Km+ms6GehRN53pnJ/Y2ZQ6ZaHXM2yH6jBhqZe/Kpzs2zRYDWnzd9w6mDG4tfpBJj2xQAg9gW0RLzXj8kA/MvrT9A8W8DrZ5YcI5FRWihA71FKeg0cGbkybHtB+fAcluhWY0DiNgF1kntgD7Si8p0sVgmy4d5Cg7bMjT7XB2bJ7OeaU0A4wca1CJ4Jsm+pMAKympnAmR9Y1NbzUXITaqS6sLsXUD+PlHtITrUdLuG4DsyCD5WgmGlgnvYoFzYPilIgfwdvYkiJihYP08E26BQp55xxK401M7i02CHiNjkvWWlv+zS/aIT4MQcY0s46rneAFMo7SgM+2jn92tzkdWwtZTeiX89/R9iGWjmyVpzpR3pRr8nCiPhA6rRdEy/TbZNklTqm7wp9Le40C
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:22.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac679ce-a34b-480f-0cfd-08dc531cd205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

From: Amit Cohen <amcohen@nvidia.com>

Currently, as part of mlxsw_pci_cq_tasklet(), we check if any item
was handled, and only in such case we arm doorbell. This is unlikely case,
as we schedule tasklet only for CQs that we get an event for them, which
means that they contain completions to handle. Remove this check, which
is supposed to be true always, and even if it is false, it is not a mistake
to ring the doorbell. We can warn on such case, but it is not really worth
to add a check which will be run for each CQ handling when we do not expect
to reach it and it does not point to logic error that should be handled.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2031487a9dae..3a5f902b625d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -706,8 +706,8 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 		if (++items == credits)
 			break;
 	}
-	if (items)
-		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+
+	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 }
 
 static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
-- 
2.43.0


