Return-Path: <netdev+bounces-84023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B415895569
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDFE1C216B4
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FD82D86;
	Tue,  2 Apr 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Je8i+8AH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71060B96
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064725; cv=fail; b=RvkP1zNddxYWo34HmzOi40CAi4/rrh/bviIOmqkUwLiPfELfoiCxJvHg88wpST/dkj2jBCbySs6ue+Va2OvQJAJG08U3AQh+3UgZMDpNSvzfMQRmX5hsnwoXBy5MBxQSb625xKxBw2MeY3jMQGj0mkGXlGlxCLC+SWmxw2ydeaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064725; c=relaxed/simple;
	bh=aKvJ/87CJUJi0WwADib4HLp0udqn3PgwLwmph1w6wJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fp8Ot6vaIV/gdnmrlRTHn32g1rgMEWLtoTB/Uxu0LF7ndyEoiLtc9yufBrBEIjK/rP8nr0H8A32fQObB51PUgwGr5rJ8JGk0bRdm+r4pC6rgOjH61df3qtJIvwtcTXZJyAJmMgLlvc3+iVwjRDRHGQfo8VAf87+6dXyZT6ULLxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Je8i+8AH; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSDbEjTkVCD5GQJHlEFdz6/P9xPad2Ue4FryuBCkKqsgATd7WBiIQ5cAeyyzlsyqk2/DWQoIOf3T3pn/99JM4w4SpYB1NiavMUKP3tYBo+gcRKVtO/+sEwjsMX2MrwVHS+FZOD+P0opS62QHkJC9Enc+d73X9XQkdjJxlFUjQg/SjehLg/UwQAW/8g5s8ycO0XqWT7qtj5ZuHnFog5BPkrwoRDMdncm4VCWeq6wluWdI18tryNUui4cl1TwDWTOXrR1tLXnKpQWy2IbtH6Vzaf9EmzcWz2Z7s9HVDZX35UP9Je7d1+Fm0LDekjk3MLpHTQR/jGrCc5P6R4Ur4ae7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hwV2SxFVRye7uj44j9qFgKpr89GgbLxB3OSuDi6Nlo=;
 b=cBAPZK55DO2+W+zjtuty1degz34pH3AmVdIwA8EUePrEBgfcM4LWpa+PQkcTFAk7Q4n9Rw5w4IqLVGDHFCiQ5con1/Zv3ggWB9IRa/tkKZi5l5NlCQeZOWxbaIKZttR8wHHGlWXenlq2+robrEjWh9xpgg7+1vISqxcfEnq3O3bgrq55/Z7qnYMv8zoVmR5s+7U+fIoRQjF7iEbenAluP+y4fi1MBfTxCEkrsf8gE3FLUB7L0bcZglc06ok7tkYu3ldZ/7qVa4t/p/g9K+VMTf5MA4bXjDjGB/Cc7NNlk4npjvFXCmG5fRJigytmti9A4ecGE24X8wkoZDCYov8KdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hwV2SxFVRye7uj44j9qFgKpr89GgbLxB3OSuDi6Nlo=;
 b=Je8i+8AH8qwuE0rtcygVIiPb7ETAWdEQc0c19Hb7nkLJT/dxMEF4VNSxnuEjt7ChPcZ/yAjLpa7N5OzDCC1sJVlyV9kXtFEs8ES+BavQtClUOv/RU4rxwui4ikzksuixIeb1wd1q+Ztspyz24autMMOjCB+FIxzp8QYLoJ83XTokpSJwmMx4IFedzLOHekUoIIDw2utZRLrcCCx4NOTtfk2TiA98R9KLKSBru3CyTT1T62egWJnUhY9ZUOn06au6y10wgAz7l59ZOh5904+nPXiz3wb4gf+TXNmNDc8KDDbda4XCcPMDXbXDg4uwHwTeCTrNPR1O3QsBdP0A4KBxVA==
Received: from CY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:930:17::13)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:01 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::6c) by CY5PR17CA0026.outlook.office365.com
 (2603:10b6:930:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/11] mlx5 misc patches
Date: Tue, 2 Apr 2024 16:30:32 +0300
Message-ID: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: e371342a-0a2c-426b-3cfc-08dc53194699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qpSsGfbqvw6MXv0Kd1TT0GVUiOqclQfk9EnERqe6AWPa81UlLPqftz+Qqe/FcpkZYITjrpHylyXB+Gj2ddjT8/YjrsQhjDHOTL8xA8/+G5VlVb1NeSSZM3Y816pZlxmxQDQwTooGCHZXiOcnzwViy6MVL+xzFFl53zIfL2FRmHD1yUWXG0EzV0500Jpfs/DZ8sJzi+jsZ917ZfvDZgckM44CnFtMjWVPl0/UCMyKuAM/1a2acE2UeS2pZxTbTDicROZdEhQQVSs3Cjawi7HkKf2XNdtwiOAsfsV/3nDqzPLCRLiX+ZTRgH3zSh8k7lJflJGGbK2MXU5OdD/Tdjs0Z6Rbmfb7Dowhi8p3xqmZ1rRbeiH3vf+rJitY6ItBqr9aDcmh/blubsuMwbrhB55TfiiWcF9vdYtCXzti7PFXl/7PinFX0UvVvWyzfHxypt1t1Op6Vfw2RcAL2VprYJI1cmoSLVLniN0ZjJcK8ev+cd5h80eXaz51HzA6cTs3uOWb4zbylaZAFJyyP/2d7W///mmrsImBVCkB/qxqwh2tTptXzwZbLCMNDo/J3KuzqH+yuboIxZjEYXqhlL0CxQK7i14+89DPvVMQfzJX/ShYSn5jZ4zsX4o2Z2fMNy71KiVErJibW4IsMR0xLsC7j1PZiD25qz1F3gN8gEdb29IXnNurxUJNMks8A8qopd4df3MW9VF9LHtbo2C+sPJRr0ltLpsmdVxXou4k4nuF5cAHQeeCZMPUe9U/xRrkc/qAocTU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:00.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e371342a-0a2c-426b-3cfc-08dc53194699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

Hi,

This patchset includes small features and misc code enhancements for the
mlx5 core and EN drivers.

Patches 1-4 by Gal improves the mlx5e ethtool stats implementation, for
example by using standard helpers ethtool_sprintf/puts.

Patch 5 by me adds a reset option for the FW command interface debugfs
stats entries. This allows explicit FW command interface stats reset
between different runs of a test case.

Patches 6 and 7 are simple cleanups.

Patch 8 by Gal adds driver support for 800Gbps link modes.

Patch 9 by Jianbo enhances the L4 steering abilities.

Patches 10-11 by Jianbo save redundant operations.

Series generated against:
commit 5fc68320c1fb ("ipv6: remove RTNL protection from inet6_dump_fib()")

Thanks,
Tariq.

V2:
- Removed patch 5 (representor remote RX drop counter), to be adjusted and submitted later.
- Mention offending commit in patch 6 description, per Simon's feedback.
- Added Simon Horman's Reviewed-by tags.
- Added patches 8 - 11.

Carolina Jubran (1):
  net/mlx5e: XDP, Fix an inconsistent comment

Gal Pressman (6):
  net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
  net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
  net/mlx5e: Use ethtool_sprintf/puts() to fill stats strings
  net/mlx5e: Make stats group fill_stats callbacks consistent with the
    API
  net/mlx5: Convert uintX_t to uX
  net/mlx5e: Add support for 800Gbps link modes

Jianbo Liu (3):
  net/mlx5: Support matching on l4_type for ttc_table
  net/mlx5: Skip pages EQ creation for non-page supplier function
  net/mlx5: Don't call give_pages() if request 0 page

Tariq Toukan (1):
  net/mlx5e: debugfs, Add reset option for command interface stats

 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   2 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  28 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |  14 +-
 .../mellanox/mlx5/core/en_accel/ktls_stats.c  |  26 +-
 .../mlx5/core/en_accel/macsec_stats.c         |  22 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  30 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 491 +++++++++---------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   2 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |   8 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 254 +++++++--
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |   2 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/pagealloc.c   |   3 +
 .../mellanox/mlx5/core/steering/dr_ste_v0.c   |   2 +-
 .../mellanox/mlx5/core/steering/dr_ste_v1.c   |   4 +-
 include/linux/mlx5/device.h                   |   8 +-
 include/linux/mlx5/mlx5_ifc.h                 |  36 +-
 27 files changed, 596 insertions(+), 408 deletions(-)

-- 
2.31.1


