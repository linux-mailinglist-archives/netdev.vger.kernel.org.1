Return-Path: <netdev+bounces-185153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59DA98BE7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6483BFF5C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE01A316A;
	Wed, 23 Apr 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8/8tKF8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB174040
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416395; cv=fail; b=gmCW0V9557vce/1ayaN0EJ1iCUR89SooaHgoQZLX/0HWzcDeaF/W6Max1vTgXEnIYCzFGOTOKgc3zc8zETPPqjYcJo5KgIuSkLqjapQsVbuCyHggkwMke/fP5uebI1VsftRqWvrmBTk/ENc4jDLdKRB8MKzdNt3j0TSsBo7DEHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416395; c=relaxed/simple;
	bh=qsIGC3QK7YKHnCh/1cz+04iBjzeW3Kn5VShAJ6S3q5s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUAR2PpZZMyMha+02VWmzg80adpNeAuZLhn/z0XVE8O9t0dUlQwwxKRzZ5l4gEM2VBhLTG1fTjrLiaO3XAkjeogjNzh9/x9yAFaI1iylMXnUp9TEA6NmhOs/3LBxQENkaF1qsJbujlDGzkAaAofIEwR4WSYCAUgY9U0Elcs6MB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8/8tKF8; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk3EqUyC3ETKlddoXks6+QcAN67YI6h0JYu7pes7nFvQ2YErtQLE/R8NoVbUrdOnD4IYSXPqzSv47F20b4X54vJml1mDYPjZd81pNoecNZpMGUT92lb5t2x16ZdeXgaIbfyH+Z5/qHnfOYMe77BuEn1Z8Fc/CrDtOYvXPBDPjOyeyILXLoeQFFnMhY+2wMKjNaD5qj5AMG+BbPMlDGfB4Nk74LdJc75bmZELYtUHPEgeE5Ha4nqRY0XXuU2I2iTpkuvC9fnAFNkU1DBvhH8Spej0/DQXF2GkWHhTY+j33uB046zrCza+szaNqyCvxsG43RbYYBUtoPdMN1oBuwYWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgfE98LlHdq1dOBkRnVDSBBshS4QapMaQrCAk0Mxebw=;
 b=ite8CfnxDTHKwpaJdLCpYKzdN3DksHyZLN7VZ2FhaBmns6OZX8pACDRqHvBcDUVmwckPOBk/f2dkf0hqZW4U7ya+YCRzNsgiGwWEIs8IQOU+Ut18usnECUI/fj5PWdJorenKex1CTG5PWyoL+U5wpVpD+tcSqALqsJGcoh0Z7TGC9vuqyg7Zj/fsxnHalbU6hl2KAqGbX3bkv9c1war9ijTmap0b4JyUywMcOAv+8yYCO0BzbQdaCGldp+8UBNQEpbjWL+g6nPF55S3jXWAmZR/OqLeDO1FWJkQYv+6qX0BSgdWhxkE3/JWpGoKA5BzUk+oTK5N4Aoq4xGQSzI2qZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgfE98LlHdq1dOBkRnVDSBBshS4QapMaQrCAk0Mxebw=;
 b=E8/8tKF8172u1CzT/BwRvDdAehc6Ec2GH41PLnZv3QQetszGX0nWmLvbyFEBPdteNObd2q0//dmIjsxOu1tsJxavpviMCrn7njqDQBKlqeSkq+0MCKI9mGjLay4RkBozf+AnWLP2ac2djyRRDkesFiSbWAfE+4fIX8RBRhXm5mlwKmIHKZWum70LgFZkyarqSz2oTvkcPBBevqC6i8GIql9H5o7P3yZhVpsWQiBCKUvjYqKW/ah65ZKerKBuDfbxyuhxG0jOkjY855wL/DoFiPYQxAqTcTLjmIzIYexgn5zbjIDRXJ4AUlD3Qi1QGnM8lW7sEeaPgYG7e3exwWqJxQ==
Received: from SJ0PR05CA0207.namprd05.prod.outlook.com (2603:10b6:a03:330::32)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:53:05 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::33) by SJ0PR05CA0207.outlook.office365.com
 (2603:10b6:a03:330::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Wed,
 23 Apr 2025 13:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:52:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:52:46 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:52:42 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>
Subject: [RFC net-next 0/5] devlink: Add unique identifier to devlink port function
Date: Wed, 23 Apr 2025 16:50:37 +0300
Message-ID: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 473aa110-0aab-45e8-61e9-08dd826e2ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rE840Y9iCGwGUWXiWxhq9WeLWqxt2vWpAqczl2Du3dL0ScEIKt29NnHO4tsm?=
 =?us-ascii?Q?80i8J9RqNvkW7VGSG5Yz3toLbku8JtkRYQ7Ls8/QBRWgedbDszzhkhq0kLah?=
 =?us-ascii?Q?rjWheHHxOw5bLpB53K7DU6yt2C8/4F6/0kjCA0CWYLiZj0W9DTN1Y60kKA/z?=
 =?us-ascii?Q?MwcbuTo7JYxA7SDW47wTem4cP9aF0aL7FKt8fe3qOTKjT95vSUVNbFvFXEuR?=
 =?us-ascii?Q?fUkkXuFInDd9t2GVVz7VEorDjkCGMd2NYXveRKT1WmL35MplI0WnvY20uiMp?=
 =?us-ascii?Q?ddfHFSaVtk4JyhCaalWYybZzs5/bxngGpkhhGmTvT/q+zmuwQIYODgNkl/0X?=
 =?us-ascii?Q?1lluW8vAIuq1lA4HNhWqQNECRaxcuWJ9R7sBREgTZgDiR//WOrYzDvlPIpCO?=
 =?us-ascii?Q?rlH5F+3D/Sfu5lb5Cz6O4PvkFxPPoKgG9fSVFmvNlpp4Upg78W+FU8HJ2iPu?=
 =?us-ascii?Q?8wvDUwpV9tWDXrJMgH4WJ7zNBr4OPepsEfMjzjnFqIvopcVtfDkTjcyzb3Ic?=
 =?us-ascii?Q?afZXBn9xB2M8JUnBKpy8DMSr/L9NLSTlUPi3ntI9PXkyIXRwjoX1QgCSvQ3v?=
 =?us-ascii?Q?jMC8XpoEhOR6PJJ+Qf0GwPUMt73ButZLNS+m1yiYZQ+seIRqPSIluOKw4Kr1?=
 =?us-ascii?Q?FdX8B8A/rMyKW41vfcVR3im+1JNTGWraLQlVQS1YsDcKqaa3MJ0FKlHKuA2A?=
 =?us-ascii?Q?qpamYR8xXtNmOzkXrC/LElbI947fB5TUtaPeV0hyxsMTCNRv8tnWVIYAw3Z1?=
 =?us-ascii?Q?zwyifn8Fz79SKPxRJTFlVXvzRX5+uzZyPT4ZOQR7dXBEe3KTg1UaGFT4tp7I?=
 =?us-ascii?Q?1F+sYXd2Dh/unSsMA+08cIFC6hTpxxSeLLfhkMZnLnvjGf9MpTo5gu84IHiS?=
 =?us-ascii?Q?D0m76QMcVKKEE9eYtHQQYYtz3CZ67J5DBc55zkN/zDlDoJW3cBsW4csrLXw/?=
 =?us-ascii?Q?olGpQXruRsUZNwHLwB+9L1klElKV9iKklpycnaRPSvJjZs34m+qObhac1gM0?=
 =?us-ascii?Q?nYKdc4f3GQlAun1wJU8ajVQ+ZWaI1wJJkAk7fCnVKwUyINPNdjMJJqrZM9FF?=
 =?us-ascii?Q?Ulj0NQoOxFexYrrGwjoX7eT2E4ME3P/KnUmgFbqY4HfSMDKtl+HD1NKzDGL7?=
 =?us-ascii?Q?5s/oYWHWXqSFms1ABiqTM4oT07r7YQ7J3jMUvc2AzCx97JzuOpayJxfRb8UW?=
 =?us-ascii?Q?+FKtxtYrJyBCnzlsuxSBfMlokJZEbU0VOvMmC2v/3xSCxBgzxkYfCZKUnFmK?=
 =?us-ascii?Q?q1IZDg1OkBGY/tjtcEhlbC1t71GwRgTUE8BLGFxFm3Rn5jthZT/WXkPVplCM?=
 =?us-ascii?Q?yw6VeaWnTIEXLHtBBre9NntZKpLuO+lLnkZQuxZ1BDmxvHWpXrAWykQiAA2j?=
 =?us-ascii?Q?9kmLBtUYWJxCGnD+cpaG2sZ2RBReOaUobCf28vdsUnDyaV8Wx9uKbwpWPXP/?=
 =?us-ascii?Q?xtdbWrijLOplDtIqZl8gSixuHeohlbM/uBfqU16pEoXD/+BkQe/QXUVrGaEz?=
 =?us-ascii?Q?AjtoGJTws3ZgotBI/Rmg/DvnEPpyuU0UgY2y/WJ/NgGTtJARwe3THazJwg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:04.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473aa110-0aab-45e8-61e9-08dd826e2ba7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

A function unique identifier (UID) is a vendor defined string of
arbitrary length that universally identifies a function. The function
UID can be reported by device drivers via devlink dev info command.

This patch set adds UID attribute to devlink port function that reports
the UID of the function that pertains to the devlink port. Code is also
added to mlx5 as the first user to implement this attribute.

The main purpose of adding this attribute is to allow users to
unambiguously map between a function and the devlink port that manages
it, which might be on another host.

For example, one can retrieve the UID of a function using the "devlink
dev info" command and then search for the same UID in the output of
"devlink port show" command.

The "devlink dev info" support for UID of a function is added by a
separate patchset [1]. This patchset is submitted as an RFC to
illustrate the other side of the solution.

Other existing identifiers such as serial_number or board.serial_number
are not good enough as they don't guarantee uniqueness per function. For
example, in a multi-host NIC all PFs report the same value.

Example output:

$ devlink port show pci/0000:03:00.0/327680 -jp
{
    "port": {
        "pci/0000:03:00.0/327680": {
            "type": "eth",
            "netdev": "pf0hpf",
            "flavour": "pcipf",
            "controller": 1,
            "pfnum": 0,
            "external": true,
            "splittable": false,
            "function": {
                "hw_addr": "5c:25:73:37:70:5a",
                "roce": "enable",
                "max_io_eqs": 120,
                "uid":
"C6A76AD20605BE026D23C14E70B90704F4A5F5B3F304D83B37000732BF861D48MLNXS0D0F0"
            }
        }
    }
}

[1] https://lore.kernel.org/netdev/20250416214133.10582-1-jiri@resnulli.us/

Avihai Horon (5):
  devlink: Add unique identifier to devlink port function
  net/mlx5: Move mlx5_cmd_query_vuid() from IB to core
  net/mlx5: Add vhca_id argument to mlx5_core_query_vuid()
  net/mlx5: Add define for max VUID string size
  net/mlx5: Expose unique identifier in devlink port function

 Documentation/netlink/specs/devlink.yaml      |  3 ++
 .../networking/devlink/devlink-port.rst       | 12 +++++++
 drivers/infiniband/hw/mlx5/cmd.c              | 21 ------------
 drivers/infiniband/hw/mlx5/cmd.h              |  2 --
 drivers/infiniband/hw/mlx5/main.c             |  5 +--
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 22 ++++++++++++
 include/linux/mlx5/driver.h                   |  3 ++
 include/net/devlink.h                         |  8 +++++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 32 +++++++++++++++++
 13 files changed, 122 insertions(+), 25 deletions(-)

-- 
2.27.0


