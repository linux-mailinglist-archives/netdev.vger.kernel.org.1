Return-Path: <netdev+bounces-157992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98726A100AF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 06:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A33A7B56
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019C23A0F1;
	Tue, 14 Jan 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciLZXxow"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AA233555
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736834286; cv=fail; b=X0WJf9sNpjJ0gjXAZDtpCFpSHaPD+7ApxdGEzkkLhf0NrMtWYxh2jSTcGLVvdhcF2/DvEup89GLEqEl99B9wckNbxWENgmodBAux9G+l9h8w+2hFqQgl+82YhBgXd86/sz+ZpsNPNucC7UDZdETJWyvyCbSl63ZIFM11+GFvoR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736834286; c=relaxed/simple;
	bh=C7QxjMQIDrRcq5YUBBT6AdtZlYQ3Re2z7Hxel+E4it4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sh7WMhyg1XTzuBXXXdRhj8DRhCCnzFYd8EsTa3QJMKQQTmueN77jup9vGyJfh5ALVm+uszi8ZIdfS4Aq9al/DQy21NMhePQiA6pgvq9brHyznw3LA7cXNKXvVLelV9KGmoIX8/awCUahxha4dI8ESKkhwDNkta68tadub0ThDzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciLZXxow; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd+b34B4J/nYNDoChMQYCOucaY8xpIyKM0zjTclo1tJo9iE7PYzEX3c6Hxs4Z1DLC4SMRjzoj1xXE254p6fgKyeJpV3eoEuDQtAaFTX/r6kfCxUmliXByZSSrJQAPcyD7YGFH41pEyEX7NIXhQLewx1S0JcQ7gIBbSSFZS0IE6t0NUS91yevAPELOkH2edwNLkZTCDqi3rzDG6eobqF/QLT6uVEOaO95d6la5Q3I0NI2/0RZZvBCd+/QgfLAec5kucMAW9wJvQRPHvLFADXpq1GzWyg3rxhOLFc4StPO1YHLLrQE9Yw2rTiaWSdoRZ5U/W48oEig7oOYHfeNg+7UYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXdIG8eLCThiqkSISkP6wRPoPkMdgRYtVFeJ+ujZSGc=;
 b=aDv6YzkIBwPN2RBoj3CqyDyarr8OF1L+kwFJOWOhsFSM2ohxuNAxIlAQfA/gendvI0FCmbpJcfKhRjoQElCw6MgjzCZexXtFCuv4pOQjvNzyylI2/ey6Iaaht//UC8OoXFOUcs65x3H/GBayyIbGe5tUWrnPzWIzCQ2gdI0j+HC2bhmFyAh21cyA0hczs3aIo3UPYox16cnltdZtpfToZZvzXQ41vmej9C+evwogo/AObL0lvqIugoh+SVd9vRD6l0gCIvAR6jJJkUKYqMwI0NxUaTZRZ+0HdH/wqVB83rQO80kBJhssd3ngfBGsSSL5GnR5d/qI1DYCA4K4vt/K6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXdIG8eLCThiqkSISkP6wRPoPkMdgRYtVFeJ+ujZSGc=;
 b=ciLZXxowUZvkttyUwDCcEhuDVSXf6iY60EHyn6/sCyC2krKgA1y7qibEElhFLFBcfaxSHfMBAqxrZikwiGEFuGhNyLx9+RJUMwxUeM6tbqFRInkvwKxdqczAFcxAeedtSsm0rUC2jVdLK7FfDSwX4+1h1gRSXqIDnBlD8UxpL4en2hgn+W59b/fJxGhsG1IwmPV7m5umOof5Kp+G/i+HNWYsNEVDYE6UpCGejU+uXP7hO2hZBE2JIf/BQRTTToM4HlJOmdayGLzm2q9fCm9ufDdSgd4XdFbsoW7xXjGB4U29OVLe+DQnZxcs/1zJMWxuupm6JFes4hyKOaLuAq8Ocg==
Received: from BL0PR01CA0011.prod.exchangelabs.com (2603:10b6:208:71::24) by
 BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 05:58:01 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:71:cafe::f2) by BL0PR01CA0011.outlook.office365.com
 (2603:10b6:208:71::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 05:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Tue, 14 Jan 2025 05:58:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 21:57:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 Jan 2025 21:57:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 21:57:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-01-14
Date: Tue, 14 Jan 2025 07:57:00 +0200
Message-ID: <20250114055700.1928736-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 99090431-5663-4166-2c77-08dd346066e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDDeD2Gr98Bm8ieLdPYsm15x3xPDmDApLu2fsYgzhg/uWCAd7darwvPH5Jgc?=
 =?us-ascii?Q?aMytYOinxnb/OxdFpYvBRgzppWzpo0xHIf+hJtiE+fAWkuhO8CvLuLFo70zb?=
 =?us-ascii?Q?31UkHfTDPhMg41xadp0Eqg8ENCm7qYEjYIfo5YPDLl+Tnq/cpO9ziQ8BS21x?=
 =?us-ascii?Q?k9y4PswrUFoSzAF2Ac7UVoCKSNnUAqRP4EhTKP/ucPtdbnMiWKc2f0qE+bg7?=
 =?us-ascii?Q?ERvDR26ZGdbGTnXIvqzJsDoOKliiKNEMkS5CA3rTvSYoEaUXRUT1OqnbBJUx?=
 =?us-ascii?Q?xcoi+RW413ZiwgAZXNLdaPy4CefGiC5zaa+x7Tq19vHcqHjN8V4f47MNzWNZ?=
 =?us-ascii?Q?6n+0q0nrb3MdQ5U6GmMo+R/rp3YaAdUDw6nqa03OQkNeFI7IbY4tGeJUrKD6?=
 =?us-ascii?Q?3IK4jwJg+wMLmYKeq5sSuHmVMf0kvy1bRH4eaO/yJr08+TlmRw7x4uOw7KEB?=
 =?us-ascii?Q?5WTbt1QFroKwKaU6FlfICeNdSWcwaoCpoBxJqLNVoizYPR+VNxvDAB27ULgC?=
 =?us-ascii?Q?lRpuxo5i0YGLbarac76Vfgzbj1iPBg4DDXg1spMlfg2KofpLWr/urQcvLXlU?=
 =?us-ascii?Q?ywgfqc7cKaPUNVYFAyJlmrdpi/ZselLG67UsXUE+ZywqcZqns/87SJ8Dx72G?=
 =?us-ascii?Q?iNjLQkWozgqt0fHdMQQm2y1JihzQZAyl51fGwcagmWQNIj2q/GyEf/7OT9bX?=
 =?us-ascii?Q?F6/CCyr8aRSIjgVNAbKnfnsczTuka2sFcQ7CkW9nYrYK69HlhnmlAuQKT5ls?=
 =?us-ascii?Q?EwP9ZwDu5pdQ6mtEd9r5rQO3VY85lE6qiwRQ4FuTkZnwd0FPjZmTOM1EaPR2?=
 =?us-ascii?Q?eO/GQxN2hvs0iB24KgsNXi7sDoqAWe5VoW4DOlg8uap5lHQ2FgHDMGuanO11?=
 =?us-ascii?Q?N+7vi+4zJVt7phNh6I4sQAsW/K49WXVTWKSd7UKSDi1IYVZGW3M/GVt83qo4?=
 =?us-ascii?Q?vVW7HMvqm1W4VcFiI0BzXFl+spVcgdK7nu2+MW+ILLuUsjxhQgcJYiRl2dw2?=
 =?us-ascii?Q?MSYrC4mshnB05iE8nyLVnnNK7uhwpYILqlWgNohVoXJxRK99G7ik662iG+2n?=
 =?us-ascii?Q?v8pVTX49BB9dqx6Ms0LzZaas29ta7hIuffSmPgs7GqM16nhDyaWNwzDxdEVY?=
 =?us-ascii?Q?RwRnHC3x7kVcxTG2jfd9oPlCFxc7atm8ZDRfOotbSasebjui26Fa//DVkZl2?=
 =?us-ascii?Q?9GgfSVPcIhfnidQ/0ogpwbyA/dfHmp4Wd7SXg/hC8ReNLnGg0Q6V5UeudQTU?=
 =?us-ascii?Q?uZAnmQkaXIbxbPybHxcEHRgBnF/OvAurIAbcN7yJh1TmtlgefIyl/vXUuupK?=
 =?us-ascii?Q?7xu7oKg6ZN75C6Xw5F4ZABPXoPMM6QXftEfV6d2/TVLuiVqYocLZmnEZEI3Y?=
 =?us-ascii?Q?xWrSM7E01PupHUSAXHwv9yPlHE3N+5XFtNpOxRvLLsj5jyi1vLtjq6bpbihF?=
 =?us-ascii?Q?Rz0tJy/B+LNYoDi87su1BqnHkgWWRjYiyPIdTZVxWeZVJ9h3kwXNTo01jlNC?=
 =?us-ascii?Q?4sJzeknJxj8cBCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 05:58:00.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99090431-5663-4166-2c77-08dd346066e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380

Hi,

The following pull-request contains mlx5 IFC updates for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit aeb3ec99026979287266e4b5a1194789c1488c1a:

  net/mlx5: Add device cap abs_native_port_num (2024-12-16 02:29:16 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 6ca00ec47b70acb7a06cf5c79f6bec6074cef008:

  net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers (2025-01-12 03:58:00 -0500)

----------------------------------------------------------------
Akiva Goldberger (1):
      net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers

Jianbo Liu (2):
      net/mlx5: Update mlx5_ifc to support FEC for 200G per lane link modes
      net/mlx5: Add support for MRTCQ register

Saeed Mahameed (1):
      net/mlx5: SHAMPO: Introduce new SHAMPO specific HCA caps

 drivers/net/ethernet/mellanox/mlx5/core/fw.c   |  6 +++
 drivers/net/ethernet/mellanox/mlx5/core/main.c |  5 ++
 include/linux/mlx5/device.h                    |  4 ++
 include/linux/mlx5/driver.h                    |  3 ++
 include/linux/mlx5/mlx5_ifc.h                  | 73 ++++++++++++++++++++++++--
 5 files changed, 86 insertions(+), 5 deletions(-)

