Return-Path: <netdev+bounces-47969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B57EC20C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86621C20443
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29618035;
	Wed, 15 Nov 2023 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzJxtW+F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85F18030
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210E9B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJwNKiJ6tp/kknbanM3d1zOAOe6RT0/f9HWjynuNjJqNo6aSutYqsfzZAUPYYrOQ4HaAC9ura5xZ1XBBoHahOyLBlRXhuu2IsBRj5vPlqiC5LJX3t3UxDjkiKqvkZ4/9F+5hBOPNYBnzHzNuYlbTJ/dGfAwekZL70c1vMFo5TogDxuHsM+XJq6Pvcnxag0+rjFMkBlOIByq9jdULv2/0WFxrmspl5XZjaXEcdyZuV4vKgKdbm3CmfBe2XVjkjE6Xyxxhj/ZT/owK6eiXE7SfIwpfYNXzPP2jjdUqTqfJzpAaMckE2O6/0WittGy8Ohhv3EycXPPiN8lfFaLpncQ6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUCQf06KnSWK0Xwo9xhZrK7UE+GaRpqWBebKCHj6r9Y=;
 b=GyLSmU91HiBpwIKmpn7jcw+n02wuHq5Xl0ld8MhIhRz20NeCUpp1w9Wlh9XAfQQq8Fi9rZu6TdzyHNbZYKAGNflXTd/bwgUZIEPeX5fNIcE4ycNiKLawJ1JcZdNLKhrbByvNMVzTmmYvmtsbPwVfkGh8JIMfDj2a8MA28RincXrrvmbZSmJWfH3xk+oyV36QWKHqnY+BYsIXzZON3LKBjVfEdks/Rd3LtiT0odFXLq118pSsQV4/8lCQQBIemdUNJSfeblgji1D9uEisV7H0NlJBByxors0aHai9a/bHbRvY1VJA+ZNvSiS9aMAFVgjPedWvGLy8SxSoom5+Sev/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUCQf06KnSWK0Xwo9xhZrK7UE+GaRpqWBebKCHj6r9Y=;
 b=tzJxtW+F4aIhM+46nseRksIi/8TOVuNSibUjC0B82dfgEss4uFnqkDB5WPZgbtNllmGb42IciMYMEkfiHgA2cfth2u6T8RMh7iJOBHoXs1kYO5lJLM+c9+lYjWaO4dN/GSrwaN/hvHSteuSNK92NfA+mMkR3TcJCUqqnZXf2EOresbywQ/wmQ/gJXz9pLp7AHcvI/bGpJOEOWYnYhRTGlanOipB4OrgE11+sT9+z8Fiisx7Ut+PES7kaMCjD32pXX9pMv65UGF4D98bBLvh6zeSrk6xiM8mAHVkWzLS67fkvnLgohM6vwwjEqpyDr65Bd07zMWWPXT7IRwKFU44EJA==
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 12:19:32 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::14) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:25 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:22 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/14] mlxsw: Add support for new reset flow
Date: Wed, 15 Nov 2023 13:17:09 +0100
Message-ID: <cover.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: d6665cd8-0407-41ab-4605-08dbe5d51f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mqXzpNCT8NfAXs40Fe8woEIAFhZM8CO8NasdTTqTv+4w6G6n2IkML/tkqw+AjGO16fmkPiwSGCMbJJ+6+zKJDbUgYp393sq4Jt8FVy3WXCpIGfAY2i6+Xzh8rDeY6xGZjYr0Om3hEJBhxZD+JhcG4ncfLQx22uZqVwxJwYB2DF/Vd2jVGqPD/sLB6AFGcl8gp3A/5Bc9TNhHqtV9/EUgS7Aef/781L7DSnO3P/rE9yxRuxToS3vnVx2dAVXAwRsF4wLVh9tuy93WgRtMkSC/PmTvPqrrSPUOiitI7A7ZrxOBRcK1Pv5XElb5euA4Ve7UZiGSW3QN55KIayzI6EjCPv0WweAjkHxiMxiOCGV+GQr1Rpmb/C1wz/wEJcjm/ETyaw6KNSWn30UzsWa9ghIlMAeAX9VWfI/YIe+pM8SwOBK0x9DGzR93TEN2E9LAWN2BT/YaOWhKc3JDnWjtUxqfsMMioXj2EWLZb3h0h/CnsmED6O7RdlV4DziV8DZOnlHoUQZIwc8tsR9EZb0RIZOzzkwCovW4BM/UucPrXZZtXS86oqQu8PswUHeWu13mcvdIXFFiET117qU1iGfHA0cUbdgqeX6nH9e083xeUPSCcDMWiYjgd2mv9AC46zjREfSGWmPLWHZjMG3uvkc9IXVrMzYKORo1DfwbHPuBtsAo4aF6ZUcxfVsdHm488vJJ7TGbOWIkvpVXIEAuX0LH9JtU2e1aQifGrgC5TNdgLc5UdsQrOBOjaS1Pa5R2H+uK431ACz2xF24vmpbVBeHLMzeKrQeGSGqo193Xd/aBpc3lg7U=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(426003)(26005)(16526019)(41300700001)(2616005)(336012)(83380400001)(8936002)(966005)(4326008)(5660300002)(8676002)(47076005)(2906002)(316002)(478600001)(6666004)(110136005)(70586007)(70206006)(54906003)(107886003)(356005)(86362001)(36756003)(82740400003)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:32.1717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6665cd8-0407-41ab-4605-08dbe5d51f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

Ido Schimmel writes:

This patchset changes mlxsw to issue a PCI reset during probe and
devlink reload so that the PCI firmware could be upgraded without a
reboot.

Unlike the old version of this patchset [1], in this version the driver
no longer tries to issue a PCI reset by triggering a PCI link toggle on
its own, but instead calls the PCI core to issue the reset.

The PCI APIs require the device lock to be held which is why patches
#1-#6 adjust devlink to acquire the device lock during reload.

Patches #7 adds reset method quirk for NVIDIA Spectrum devices.

Patch #8 adds a debug level print in PCI core so that device ready delay
will be printed even if it is shorter than one second.

Patches #9-#11 are straightforward preparations in mlxsw.

Patch #12 finally implements the new reset flow in mlxsw.

Patch #13 adds PCI reset handlers in mlxsw to avoid user space from
resetting the device from underneath an unaware driver. Instead, the
driver is gracefully de-initialized before the PCI reset and then
initialized again after it.

Patch #14 adds a PCI reset selftest to make sure this code path does not
regress.

[1] https://lore.kernel.org/netdev/cover.1679502371.git.petrm@nvidia.com/

Amit Cohen (3):
  mlxsw: Extend MRSR pack() function to support new commands
  mlxsw: pci: Rename mlxsw_pci_sw_reset()
  mlxsw: pci: Move software reset code to a separate function

Ido Schimmel (11):
  devlink: Move private netlink flags to C file
  devlink: Acquire device lock during netns dismantle
  devlink: Enable the use of private flags in post_doit operations
  devlink: Allow taking device lock in pre_doit operations
  devlink: Acquire device lock during reload command
  devlink: Add device lock assert in reload operation
  PCI: Add no PM reset quirk for NVIDIA Spectrum devices
  PCI: Add debug print for device ready delay
  mlxsw: pci: Add support for new reset flow
  mlxsw: pci: Implement PCI reset handlers
  selftests: mlxsw: Add PCI reset test

 Documentation/netlink/specs/devlink.yaml      |  4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 90 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 16 +++-
 drivers/pci/pci.c                             |  3 +
 drivers/pci/quirks.c                          | 13 +++
 net/devlink/core.c                            |  4 +-
 net/devlink/dev.c                             |  8 ++
 net/devlink/devl_internal.h                   | 21 ++++-
 net/devlink/health.c                          |  3 +-
 net/devlink/netlink.c                         | 47 +++++++---
 net/devlink/netlink_gen.c                     |  4 +-
 net/devlink/netlink_gen.h                     |  5 ++
 net/devlink/region.c                          |  3 +-
 .../selftests/drivers/net/mlxsw/pci_reset.sh  | 58 ++++++++++++
 14 files changed, 248 insertions(+), 31 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh

-- 
2.41.0


