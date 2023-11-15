Return-Path: <netdev+bounces-47980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C87EC21D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F7D1F26B19
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83CB1A715;
	Wed, 15 Nov 2023 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKqPxnfp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EC18055
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::614])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B19B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWwGGC/+B3R29f4z2AhaUo0braHYBDhYP4RO1RgTL/0yKl0NflW1I+v7kjKWdsjKtMfzU8E/z7f/Zy74xzNUlynREGpLulCnr54LNf7OZy8w5Kr9weS0lulv79pFgLKqF5SrtR5J6NGuX5/w61En91Zx1KAR1/kNzNxYDXxqyucWnmsr7KoL1vyXB+YlxUF/o+cJ6NCYas0Bs6uCcgg73tp7QMGv5gUAL/TW+bTjT8/ja8E7iGSX8gAA6YWob7uI1J8NBTEdQvopeL7sRvyb25PP2PmsdMKBZYOkTaw4b6q3Mp4zwQdLk5+epXkJM7rxiNyEK3ohXjSaCiwcUmAptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1NTs/mLE9dyWL5hspeVxLAu/nPL7a/tsXcPpwNndz8=;
 b=O9JKzuC7aHcVob8a+ILDSSRIId9S5PkDdHRBOqKyUnaAUxPXw3LDGB/iyh8Cx+rj8Q6p9VPZWxoqD0VDfWUEaahH5Fb6K8i2jcpWWktAHyXz3jrB/oEG1aumIrtwHbMTYviAzhXC9k932QYIUI9ogysMwKK27A9NV6lZfbpEa0XVpULqnto0jsuWmyLdQMr/iu0nscvlcMoYYnprAHTjxCawAxvB3L8XSGAQ3QNel6XUpjvkHVWyRV3lsZg9Ay+glIY03oN0VEr4LZQ0RZL4uOMHLXn1beze2uqywxTrhuQXRP0UVvGycPcHijmV0YdNNK67Mj8SuKA3QDX2Iezmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1NTs/mLE9dyWL5hspeVxLAu/nPL7a/tsXcPpwNndz8=;
 b=qKqPxnfpIGk/9E/h/6KckOaI7D1EMfVwv6Z8qHb0JwVySD4FmFDIgQHyRmV64V0hFYrpu60yVQPwyxVnCj7V33v1zS3a+bUbC7Ok7akoZUBmEJ75KSvH90mjf1UJXgMD4/xOTOM2t9fswIccmhBaYT1qhmdyfW3n6JvzoDNCl4wl4lC41SCg7i0jyd1gzvfrrf8ESGxuCV7Bn+vzsWMqsqZneb6dYlblH32cngz9/fMbqyhfo5nyaA8tqi2HQ9HNfnnnnDOrOifS/R+7rtCE53pXojyNdvfGsUZa3s+BdNzgaG3FyDOYX1sEZKw7/VsOcJZ+IAVWyHjqunpxTob44w==
Received: from MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 12:20:10 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::c4) by MN2PR05CA0057.outlook.office365.com
 (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:55 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:53 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/14] mlxsw: pci: Move software reset code to a separate function
Date: Wed, 15 Nov 2023 13:17:20 +0100
Message-ID: <395237a59d495700926cefa8bb713cdd9364fbc7.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d12ec4e-76f6-4136-2a6e-08dbe5d535d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sB/KvxRxYt+xHQS6l95FUawFUXGWV5oTil7tpX/B29XPuSM0GziWBw3d9+C8joPv44Pimh46IjgN6qOm+hTIS098KxwFJW/pAqIZM9scKuQd+vgDhpdowUHS/XdwLabdX3j3pJ2nWziTcttXLE2S555EocwHGvMbx5KMXTpqWzghGdE1bgX3Hj/IO3LjSsBsmuoWLF4ID6EFEb+DTcPQ+RKaV+LK4A5rGEC5CNuYEmRjfd9ue09HaggK0DpQeI9r0ZK/RVZZ8R6twNuq9M8zgo/ShHDBcbESvsfp3aabQfeRt+mBCjs5HjOqDmbKaxnjh2zwvWrKH0DkCXHrT94c4cJjuhun5p1UDRODc8uDBXLBO3GXKwI3kAn3INKFe10RI1Q4QeYHuDaZWXusK+gWs2HsQAmk/xoPnRru+Dw7YWtByWfaAKaHvVYCma/tkZXPCujGKEpNQvVRrpxPchPOPBDtqK+8zls/6/l/Yzw9b4JjlvPiRwbJXZ2o5nOe9ovDSBQbfi5qku5aJxKtnv9k3hGm1HuoSCGRVVe8K7/g1vPP0mS7MA1EmpojrEBKBxoDvRGiK2K2796XG8QaLnjc14NMZNjdB6lzQxjV3VebDCnturBKKmcV970iA2aMcok1bua/ddgJbOnd6TkZ8UORZRxLT/UeNw03qveQ9mn9flbqfNnJovQgwgWfXRpX0ddmvGjPjlKa7eype+fe0C7o1KMM47gTi7Bq3+h8c5Gamyo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(86362001)(70206006)(70586007)(40460700003)(478600001)(47076005)(6666004)(82740400003)(54906003)(316002)(110136005)(336012)(426003)(83380400001)(16526019)(7636003)(107886003)(26005)(356005)(2616005)(41300700001)(36860700001)(8676002)(8936002)(2906002)(5660300002)(4326008)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:09.5245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d12ec4e-76f6-4136-2a6e-08dbe5d535d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931

From: Amit Cohen <amcohen@nvidia.com>

In general, the existing flow of software reset in the driver is:
1. Wait for system ready status.
2. Send MRSR command, to start the reset.
3. Wait for system ready status.

This flow will be extended once a new reset command is supported. As a
preparation, move step #2 to a separate function.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index fe0b8a38d44e..080881c94c5a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1476,11 +1476,18 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
-static int
-mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
+static int mlxsw_pci_reset_sw(struct mlxsw_pci *mlxsw_pci)
 {
-	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+
+	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
+	return mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+}
+
+static int
+mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
+{
+	struct pci_dev *pdev = mlxsw_pci->pdev;
 	u32 sys_status;
 	int err;
 
@@ -1491,8 +1498,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
-	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
-	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+	err = mlxsw_pci_reset_sw(mlxsw_pci);
 	if (err)
 		return err;
 
-- 
2.41.0


