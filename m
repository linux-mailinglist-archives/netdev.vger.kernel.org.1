Return-Path: <netdev+bounces-103246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1E9074B9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D802E1C23AE0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37048145B17;
	Thu, 13 Jun 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zw7z26Wj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01111459F3
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287858; cv=fail; b=HKCAxgxsZCHuXteNsh1raiuFxtBBg7Vm8/dHdQ0tkRpSOZlViVKMoGyF+cUqXgdJV6C/b91r7m9/qBJEjXsdQyeinrY0ojZpCrITw6ioEvT6u4DAPvl1U8Qrpz0Q5XzFKSR7EalaAY2VdqVXIUxbWB9wIXkzzhjRmVmO53J3ah8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287858; c=relaxed/simple;
	bh=j9FGt9lEh+E48gFYSnyaxCF9s9bpG4nU5waH5Jhcbf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCyfDLxbp4nzGGASVUotHBcpP3fNiRNhPQopPcAdqB/ALLNDuIuDsbbF+aPu/XTxnqiT8XwTrvbTQopydYoakSBxsDtwWaIG4YrJaiBDHSYsJp0TKIFrahA8vAakCbyEicAQyhUuTc6L+J5iyDhg+9M09gjFY2K/oL/+SMtcMqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zw7z26Wj; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+JxErQVYjSO/ykeoRyP9Eixh4zM2rQANNcwmxwvY3Dx23OXIIfv20hemBP9QqwxL1KdbgPex/I1C1nIL3gz48g3Mx6gfiPzZ+fhxKn2CjA4FCBZxST7rpYDCpm1HqVfeUpi9FH0bKiMYovWAhNB7K0QymOFn7gll2Oqsjq8jgMn3Lc3dxCVzDpQCxAbwfsAWXBYjtZOp7zWc8OW3y+0NmM93qRwF4ouTJo60uSAZrYientjHM6Wj74b2ZQnAGrOuhcoYSttpCCFbUWnBTPNcDFQUl1/xCk3VSDyXXI/lsI6jXMQCH8EsOH7quusug9gy6hcldlSQ5wIDyx58DocwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWZ0mUiWNWjDoSDf9S3GaGvGBE1jEWleKpT+gPOu/jg=;
 b=O+pWG+n/dOypTT9gQZ1TowaVB7IsA5x7sGnsW1QhBcguoq5tln94hKxsbsjMuwwAxxpwMKVRoGY3O37t1VKJLkXLZ+Jokc8k5gS2tk/xSbpQrhZtrapJG1KU9U6a1d1wa5bS9RZOWYHOsRo8g2Er0J+xhsoOpY3+1gwL9NRhx4Nt14tEGzCihFAs+5FoNjye0i0OERITUjcw+64JFFtmn0xjGKPb5Z6DtuavggRFm1RwG/4/hyTrnyxZfbaWgdnpHelIX2wQ3JYgKm2m43dJCF1a7godmG2OUy1xLqxApcI/Yb1WWR8X3oQXwjlHQyQW8srHyKZleWKwSsMbiERoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWZ0mUiWNWjDoSDf9S3GaGvGBE1jEWleKpT+gPOu/jg=;
 b=Zw7z26WjX8kS7fBzKra9SemZ0ZNAfG77ahQ6iuFxg1iAZBTEMzvg/tI+bRgle2ZL0EciGsUnD/REUiLNtWme2CAJ4O8WeLJKySLQc/7YA/YZ9pUgyVgkNRhqv85SJgLNb0v5gD+FwAHZFn5iTuVUanJ1KyK0Nurumam1Jpu/OM+6c+klFd6Pdf56AxlAZZILXyJ4evEHUXaOgrFXy5nkNUDlISskDaEcy1xxwtyXwp29ToV9+b19sEVE0+nhzRQgleXcUgMaXGLLAxD6xfPjkTq5+yvhpINck4+Q6SQDep0Ck707W8LWT9PsCy8HrQ+5P1IILdwsrapuCu9BCa90BQ==
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 14:10:53 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::14) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 14:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:10:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:29 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] mlxsw: Handle MTU values
Date: Thu, 13 Jun 2024 16:07:53 +0200
Message-ID: <cover.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: e59249e4-af2e-4b7d-01ba-08dc8bb2a2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYEQLlobzQtM1o1NWgNo5yvweQ1t/93KLEdMTJZf/gCOZJww/gORI8VxN920?=
 =?us-ascii?Q?blnQvPyGogM5k4oAiiws1l15KUkjghVEXh0R5/zSoavTYf6ZYXH0CDxGdmyL?=
 =?us-ascii?Q?tnUXy1VF0Qs3mNgEHafWlFpMZk0Js83NIrIWrdktw04oOoSBxuo/U9yR1kC4?=
 =?us-ascii?Q?LiAEvm1rioTymiDXflwjPHpL9eUkLlqSZUfnE80Gt9LWuJRRd6nFJrUhLr2e?=
 =?us-ascii?Q?6gJ9C0bQIt5o/X7hmCAsySVVwYOANlSRnJ/cORY43WftmDZ9G4Yk05sJQbMz?=
 =?us-ascii?Q?R6RPsO1cOUzHCg1bd1QwfW63h1L53vOQq9I8/yNzjzj6t0j1/EFdLBuNRMko?=
 =?us-ascii?Q?PrxMqOUoGwEo8Ydx6RWjYQzp1lldHkX7US6N6M3treB27S2OTCO2K4flAwzc?=
 =?us-ascii?Q?WuXg8XoIk7ClUM7OSl0twNWi8M7UvaWLScfRKeTfxwZsw2pdMHluqOJFnwOG?=
 =?us-ascii?Q?W9gOvavbH+X/Hb5VZa/FHSgMkHwJIB0yMkm9BeGGXFPm+81at6HN95AR2ZV5?=
 =?us-ascii?Q?4frXsGfd10vuS5UO6LeQ+D3gZzA1wviGt9eE5YWLSy0IZErHeO9u95RNYCuj?=
 =?us-ascii?Q?QB52wBoXGo62Fz2RHHcwYBmYPanUCRAaZ6aS/VjbTnv2vuk0n/r9rVPSQYU1?=
 =?us-ascii?Q?KPI2AyJcfoRlRApvm5y7lFb6exRllp02E7hgEML8WJqfNS0QEWtRb+WubZuY?=
 =?us-ascii?Q?IEAZYWlmseCYQK+XI3rJldGZwem4/T34Ko5GDBofnDfXEQJqOR8OrmKDo+lm?=
 =?us-ascii?Q?5Beqp6POsKidaJTE4sDvDiIoQXaO1M8ai50gMAnydQ+WOJzS4papIeikwJOG?=
 =?us-ascii?Q?xKI1Xs7egcvlhMW9ski5kmzFONHLRWUY5Kzh4D1/FP/Z1AeX0SlgvqVXiW0M?=
 =?us-ascii?Q?pmDRcxCPN4Q+MDXmabdM+/tDGRswmsCzLG16krA9VKnQuWA726BQoMyZAD03?=
 =?us-ascii?Q?tS0iK/dzLcWU/EFW1M/Dhv7tWKaJ1zNpOXcSjjpgb7Z6DpwfoIKvWWK8xDu0?=
 =?us-ascii?Q?AUZijLAMAXQv5wdSzAskVxyt5qzP8nqu3w9pmjQMlEjC+XLgdPCZpHAOTjZu?=
 =?us-ascii?Q?u2oONFhh2dzjqwGasAbq1y7Q9vH/N3PwW9VB7A+cqrMnlyu2Op+L5ambPRag?=
 =?us-ascii?Q?oq2Uo8HUY1+zLxVSxV1Vh/ra41k3Qj9sWofEHHfz4V3u+IrrxzfQpnin0BOa?=
 =?us-ascii?Q?rWsCkaoN0upMO4+Ggqpe5RZeqDHwou4DBxlBBZ3k1KWS/7ksalaAE3YyFR7n?=
 =?us-ascii?Q?IF2JacRawp8mXYDgUyMB1Y5nQHlKpi6YMlNeLcz3EW7ProyNJFx1CS9vn/j2?=
 =?us-ascii?Q?JjKHqj6Xg3C/VBmR2DrnKGmFs8oJNvBZadX6oa62ehgINMNFaVzKy3OGfR2j?=
 =?us-ascii?Q?xVay45OBLAwqLdVCgK5nNE/t60sN5eZPVKus7cD6ITkSZpKYSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:10:53.0392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59249e4-af2e-4b7d-01ba-08dc8bb2a2cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

Amit Cohen writes:

The driver uses two values for maximum MTU, but neither is accurate.
In addition, the value which is configured to hardware is not calculated
correctly. Handle these issues and expose accurate values for minimum
and maximum MTU per netdevice.

Add test cases to check that the exposed values are really supported.

Patch set overview:
Patches #1-#3 set the driver to use accurate values for MTU
Patch #4 aligns the driver to always use the same value for maximum MTU
Patch #5 adds a test

Amit Cohen (5):
  mlxsw: port: Edit maximum MTU value
  mlxsw: Adjust MTU value to hardware check
  mlxsw: spectrum: Set more accurate values for netdevice min/max MTU
  mlxsw: Use the same maximum MTU value throughout the driver
  selftests: forwarding: Add test for minimum and maximum MTU

 drivers/net/ethernet/mellanox/mlxsw/port.h    |   3 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  31 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   1 -
 .../mellanox/mlxsw/spectrum_buffers.c         |   8 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/min_max_mtu.sh   | 283 ++++++++++++++++++
 6 files changed, 295 insertions(+), 32 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/min_max_mtu.sh

-- 
2.45.0


