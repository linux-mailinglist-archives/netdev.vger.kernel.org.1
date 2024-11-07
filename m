Return-Path: <netdev+bounces-143031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F69C0F34
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E501C209EF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BB192D83;
	Thu,  7 Nov 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULESP38Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF571822E5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008716; cv=fail; b=dysN9x0aQvDHnO0DjFxfIr0/aQCYtaT7a/YAuUXdhlEsHrc4aZhm6TpzAiDSjinjZ6dAF5ZeNLAGBXo7vnoVy+xc6K5TuXKeD0VCaAcb4mOAnZPJA9KXaq7Kp6cqXM1AJ/Z0KHhAt/rmRjLUcE7crqeu53WHnJY1K4/YDyfZ4Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008716; c=relaxed/simple;
	bh=UR1uOvAa2ddLhdJuSRzfiq5EvX2RyV9l3Y1FJRCM7LA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OL9hfzqJMEjKwd9/JyjXiUpf0F6G4AKzX523iOiQ/xOknl921p9ojWhYg/7i1ImfmoKBjSJsx1CFHPDCvVPODEHbKnBtZpWI4JRvoLRlAT97XwXtfkSoSm22BQ+taj7CdMdmj99Ga/5OrJEP1vzTSJo9gsPC/hpug1wxkAqRg50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULESP38Z; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX3eJw+zAsqs70cGhwIWCNCx6KDh/3sZMLZ+a65n+u13iYyq1VNwg3cJwdFIq5rO/X0svwhl3DmOYiK9Wvff7WNp4VcLS/jDFG7PydY8ZcpnKSJIlDtRVuYdK49urNE0w/pOvs2+hXf8sA3s2HOtRTMczq0KGq1FD6BjeKYCN5fAkyeDpWi5J3xDdgnYaPtk4hDz2LlUcGcxJhsVghe9BhIUIhMKeIqV2ngMsjm2M7LhRQLLGGAF631PCW2+143b7Z3jC8v9mncFyHxZZjRrCmY8rtDd5cgqFuuovjyme4SKdPGjzMNnB/0wMiNCh9su4w/xOu3K//DtdLSUvinixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJrjxKk178eymHRfc3xJJ/PCLQPI++tsNky/XkprSyA=;
 b=bwuaIHkKIfZHdAzVx6+4aP/hhNnblyuB1PeEPItCLYcm7EF/u52M4ktdkkFm0zsfIsGZoPy+FCehYHFWz9hTqddr3Ncl/T0/PnuIO62221s/uQFD4DTRLmYtk5wh5GbBE1PtulwAwlywdbo1c7RK4ChReFvPTh0JEaaVlqBcSIQaqRNSwF1XHHH1Knt/8ASudmtO1hrlH/+5de1ejopN8ZasxPxUQvm9xPpjmv7dRZ9dtRaVMhKUHq+nEIdiceWzv816k4wPLAEYcnqgafrpkkKSPIGWuZMo1Isc9RbE3X0FbRB8gVRtnVriZf6Aj6ugSnB/vQFatQKGLgvp+S863A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJrjxKk178eymHRfc3xJJ/PCLQPI++tsNky/XkprSyA=;
 b=ULESP38ZhGBbolZqiMrMmJn+lL6WtoINp2r/FKOlbJ3tgNGJAm3tK/AyJTHFIuYAGdY6e/i6sY1rJOdpXN9bd+/G3gmF7UhpuQi9W5R/nMLxBW1MdAOPvpBs3/VdYCtzJGWFGOgAO543oZiP+N4eGhvEYp+LmomkrkDx7vP3DWL2vGDFztW3zaBiMgKh0AqMPc0drdpfoTcBekIlNuCOsKFWp5ccMfXZ6XJHZ3rrShUpd47eCbt7T1pbvxRStWYHyuTJdLDCpvWGtr+4BhrMowQaZJllERgmlbB5UUrOhbaA6CkDBligYH0yZB8US3UxZAJrhbqk4eeeH1kpMxpZIQ==
Received: from MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 19:45:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::8f) by MW4P220CA0017.outlook.office365.com
 (2603:10b6:303:115::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:44:54 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:44:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:44:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/12] mlx5 esw qos refactor and SHAMPO cleanup
Date: Thu, 7 Nov 2024 21:43:45 +0200
Message-ID: <20241107194357.683732-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a47979-a13f-4cca-be42-08dcff64b0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdkgKMsvpNpw9ROnUWFTBHTzrjI57BUJd6kudzAwtTdaDnp4B5c5U/bHVDI8?=
 =?us-ascii?Q?vsEqnQPhhWjykzMvUmLKX/b2Dplvk64ji29SxdcPX4UunhUPQSc8KdrorMfS?=
 =?us-ascii?Q?x1dgXMbnIJtqx2qMthj27vqp8x5j4KoLN1Ed2E0kPrwc8Ze8dOP/5zME4bFT?=
 =?us-ascii?Q?NnS8sm1WotOUgNz3u3gVGkHSK2KUdqLUy8nFKghsgVxl7yko7IS28QOutwMX?=
 =?us-ascii?Q?xZLdn+yxPxeyyE/cIRXrWLMpnAJTQ9bO0BaK/c6Bl8AkKv1MbdKM+/yBCnh0?=
 =?us-ascii?Q?OxTR3H71MnfSt2DH2KjVB6qfdGjRVhQF/nFK3YwBovtXzLn5kXWyyvu5OqTY?=
 =?us-ascii?Q?Xcqh/AufjMV2+b1Nf3Kzq9xRfCuqPX+SbsJ6ii6EECC5t02aZYLnu7o+n8e9?=
 =?us-ascii?Q?qekJmt+WC/PVVbew5ITikOezK7+bh7MdQcSttco008onSozzT5DewcMogWC0?=
 =?us-ascii?Q?rU/1U3NLIc4petVu2pB2rPyxhq2s6NO/dxtvmRuAfmQkDU49HCSGoHamwV+8?=
 =?us-ascii?Q?QclJIukwW5Mefsdg47rlCFp/a/Rw8WZ7yzfEumnHXBrOyEsL4Ho7vwb4UYQe?=
 =?us-ascii?Q?u+sudkRW0Zq9OzF+2SjPQ7MYFPMxxMpEAwntvtcVOm+sVC7ckN6XFCS9oXQz?=
 =?us-ascii?Q?2H96NZPBB6I+wE5nNWsr1xjPRaLoSF3Tht8Kb6YK5oOuriXsKHpyPiRYNAIm?=
 =?us-ascii?Q?c+VMylWRnzIRASrDLWKV/RtE7k207qwmWRBdXG2ODtLO1/jL8PLDX2HcQ78Y?=
 =?us-ascii?Q?gFMAi81ndEwq/3wjE6AFd7Bc5D/HLX+t8wVneSZ3TF1CTKyMQYZQOuXRsZ1Y?=
 =?us-ascii?Q?/2ncsiuj0Fo6C1vYGAGXbMCpNzoIpg91LLQ5QBUT25je+4O2cOu9o6Ksfzb+?=
 =?us-ascii?Q?S7rUn0xe4wKXiSSXw1eLZ09QuTmZW7i5JwSCwMQ2Dcqp0AMdeZBFKm1N8q4m?=
 =?us-ascii?Q?gebPY2etyngNSfdc2MnRe7NYzF1Jk0Er19edA/mU6LgStjcA/ZELF78lkZnv?=
 =?us-ascii?Q?I+4xplWbd+iqMZDje8sMj++6pkk+ueqYBoa33/QiFxcb8zXu3wu1Bfw1Pl0b?=
 =?us-ascii?Q?1+2WtcUEqTsi226pPER/HwmysT3kiwbDaxpQzNLDuuNqPPQjTO7lOcsx8FDl?=
 =?us-ascii?Q?LQw2VX9AT0QhO7MszonDxqQAbkWFkO+M/6UejeLGuoWMLqlexdbaxzumOWpW?=
 =?us-ascii?Q?43cEhUD9SeCKF32FpuJAazPzfRBfXnJ7Ryp/ezKgkYrTwQ2kk0P484q7tZzl?=
 =?us-ascii?Q?Orw5XOVoWMCSRYqbsaMC5yPCI/6OAgy6XCBIpgy/2DySd8PYe97/ZZFXupCG?=
 =?us-ascii?Q?oTVrBjlwHOx4JKfw4O7+JwhYMZK/UhR031v33qhOHIZMmByE9Dr6oTPtK5RP?=
 =?us-ascii?Q?Qf8vHOqXZSvkeSC44dzOrQHKF/2yrlLyLIhfxU1Vy/qtyGj48Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:10.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a47979-a13f-4cca-be42-08dcff64b0e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

Hi,

This patchset for the mlx5 core and Eth drivers consists of 3 parts.

First patch by Patrisious improves the E-switch mode change operation.

The following 6 patches by Carolina introduce further refactoring for
the QoS handling, to set the foundation for future extensions.

In the following 5 patches by Dragos, we enhance the SHAMPO datapath
flow by simplifying some logic, and cleaning up the implementation.

Series generated against:
commit 702c290a1cb1 ("sctp: Avoid enqueuing addr events redundantly")

Thanks,
Tariq


Carolina Jubran (6):
  net/mlx5: Simplify QoS normalization by removing error handling
  net/mlx5: Generalize max_rate and min_rate setting for nodes
  net/mlx5: Refactor scheduling element configuration bitmasks
  net/mlx5: Generalize scheduling element operations
  net/mlx5: Integrate esw_qos_vport_enable logic into rate operations
  net/mlx5: Make vport QoS enablement more flexible for future
    extensions

Dragos Tatulea (5):
  net/mlx5e: SHAMPO, Simplify UMR allocation for headers
  net/mlx5e: SHAMPO, Fix page_index calculation inconsistency
  net/mlx5e: SHAMPO, Change frag page setup order during allocation
  net/mlx5e: SHAMPO, Drop info array
  net/mlx5e: SHAMPO, Rework header allocation loop

Patrisious Haddad (1):
  net/mlx5: E-switch, refactor eswitch mode change

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  15 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 123 ++--
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 558 +++++++-----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   7 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   5 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  26 +-
 9 files changed, 303 insertions(+), 439 deletions(-)

-- 
2.44.0


